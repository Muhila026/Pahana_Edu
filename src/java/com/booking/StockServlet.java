package com.booking;

import com.booking.BookServlet.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;

/**
 * Servlet for handling Stock operations
 */
public class StockServlet extends HttpServlet {

    // Singleton Pattern - Stock Manager
    private static class StockManager {
        private static StockManager instance;
        private static final int LOW_STOCK_THRESHOLD = 10;
        private static final int CRITICAL_STOCK_THRESHOLD = 5;
        
        private StockManager() {}
        
        public static synchronized StockManager getInstance() {
            if (instance == null) {
                instance = new StockManager();
            }
            return instance;
        }
        
        public String getStockStatus(int quantity) {
            if (quantity <= CRITICAL_STOCK_THRESHOLD) {
                return "CRITICAL";
            } else if (quantity <= LOW_STOCK_THRESHOLD) {
                return "LOW";
            } else {
                return "SUFFICIENT";
            }
        }
        
        public boolean needsRestocking(int quantity) {
            return quantity <= LOW_STOCK_THRESHOLD;
        }
    }
    
    // Strategy Pattern - Stock Update Strategies
    public interface StockUpdateStrategy {
        boolean validateUpdate(int currentStock, int newStock);
        String getValidationMessage();
    }
    
    public static class PositiveStockStrategy implements StockUpdateStrategy {
        @Override
        public boolean validateUpdate(int currentStock, int newStock) {
            return newStock >= 0;
        }
        
        @Override
        public String getValidationMessage() {
            return "Stock quantity cannot be negative";
        }
    }
    
    public static class ReasonableStockStrategy implements StockUpdateStrategy {
        @Override
        public boolean validateUpdate(int currentStock, int newStock) {
            return newStock >= 0 && newStock <= 10000; // Reasonable upper limit
        }
        
        @Override
        public String getValidationMessage() {
            return "Stock quantity must be between 0 and 10,000";
        }
    }
    
    // Factory Pattern - Stock Operation Factory
    public static class StockOperationFactory {
        public static StockUpdateStrategy getStrategy(String operationType) {
            if ("strict".equals(operationType)) {
                return new ReasonableStockStrategy();
            } else {
                return new PositiveStockStrategy();
            }
        }
    }
    
    // Observer Pattern - Stock Change Notifications
    public interface StockChangeObserver {
        void onStockUpdate(int bookId, int oldStock, int newStock);
        void onLowStock(int bookId, int currentStock);
    }
    
    public static class StockChangeLogger implements StockChangeObserver {
        @Override
        public void onStockUpdate(int bookId, int oldStock, int newStock) {
            System.out.println("STOCK_UPDATE: Book ID " + bookId + " changed from " + oldStock + " to " + newStock);
        }
        
        @Override
        public void onLowStock(int bookId, int currentStock) {
            System.out.println("LOW_STOCK_ALERT: Book ID " + bookId + " has only " + currentStock + " items left");
        }
    }
    
    public static class StockChangeManager {
        private static List<StockChangeObserver> observers = new ArrayList<>();
        
        public static void addObserver(StockChangeObserver observer) {
            observers.add(observer);
        }
        
        public static void notifyStockUpdate(int bookId, int oldStock, int newStock) {
            for (StockChangeObserver observer : observers) {
                observer.onStockUpdate(bookId, oldStock, newStock);
            }
        }
        
        public static void notifyLowStock(int bookId, int currentStock) {
            for (StockChangeObserver observer : observers) {
                observer.onLowStock(bookId, currentStock);
            }
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
        // Register observers
        StockChangeManager.addObserver(new StockChangeLogger());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || role == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }
        
        // Check role-based access - only ADMIN and MANAGER can access stock
        boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role);
        if (!canAccess) {
            response.sendRedirect("dashboard.jsp?error=Access denied.");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listStock(request, response);
                    break;
                case "update":
                    updateStock(request, response);
                    break;
                case "add":
                    addStock(request, response);
                    break;
                default:
                    listStock(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in StockServlet: " + e.getMessage());
            response.sendRedirect("stock.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Book> books = new BookServlet().getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("stock.jsp").forward(request, response);
    }

    private void updateStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        String stockQuantityStr = request.getParameter("stockQuantity");
        
        // Validation
        if (bookIdStr == null || stockQuantityStr == null || 
            bookIdStr.trim().isEmpty() || stockQuantityStr.trim().isEmpty()) {
            response.sendRedirect("StockServlet?action=list&error=Book ID and stock quantity are required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            
            if (stockQuantity < 0) {
                response.sendRedirect("StockServlet?action=list&error=Stock quantity cannot be negative.");
                return;
            }

            boolean success = new BookServlet().updateStockQuantity(bookId, stockQuantity);
            
            if (success) {
                response.sendRedirect("StockServlet?action=list&message=Stock updated successfully.");
            } else {
                response.sendRedirect("StockServlet?action=list&error=Failed to update stock.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("StockServlet?action=list&error=Invalid book ID or stock quantity.");
        }
    }
    
    private void addStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        String stockQuantityStr = request.getParameter("stockQuantity");
        
        // Validation
        if (bookIdStr == null || stockQuantityStr == null || 
            bookIdStr.trim().isEmpty() || stockQuantityStr.trim().isEmpty()) {
            response.sendRedirect("StockServlet?action=list&error=Book ID and stock quantity are required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            int addQuantity = Integer.parseInt(stockQuantityStr);
            
            if (addQuantity <= 0) {
                response.sendRedirect("StockServlet?action=list&error=Add quantity must be greater than 0.");
                return;
            }

            // Get current stock quantity
            Book book = new BookServlet().getBookById(bookId);
            if (book == null) {
                response.sendRedirect("StockServlet?action=list&error=Book not found.");
                return;
            }
            
            int currentStock = book.getStockQuantity();
            int newStock = currentStock + addQuantity;
            
            boolean success = new BookServlet().updateStockQuantity(bookId, newStock);
            
            if (success) {
                response.sendRedirect("StockServlet?action=list&message=Stock added successfully. New total: " + newStock);
            } else {
                response.sendRedirect("StockServlet?action=list&error=Failed to add stock.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("StockServlet?action=list&error=Invalid book ID or stock quantity.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Stock Management Servlet";
    }
} 