package com.booking;

import com.booking.BookCategoryServlet.BookCategory;
import com.booking.UserServlet.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * Servlet for handling Book operations
 */
public class BookServlet extends HttpServlet {

    // Singleton Pattern - Database Connection Manager
    private static class DatabaseConnectionManager {
        private static DatabaseConnectionManager instance;
        private static final String URL = "jdbc:mysql://localhost:3306/pahana_bookshop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        private static final String USERNAME = "root";
        private static final String PASSWORD = "password";
        
        private DatabaseConnectionManager() {}
        
        public static synchronized DatabaseConnectionManager getInstance() {
            if (instance == null) {
                instance = new DatabaseConnectionManager();
            }
            return instance;
        }
        
        public Connection getConnection() throws SQLException {
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        }
    }
    
    // Factory Pattern - Book Creation
    public static class BookFactory {
        public static Book createBook(int bookId, String title, String description, 
                                    BigDecimal pricePerUnit, int stockQuantity, 
                                    BookCategory category) {
            Book book = new Book();
            book.setBookId(bookId);
            book.setTitle(title);
            book.setDescription(description);
            book.setPricePerUnit(pricePerUnit);
            book.setStockQuantity(stockQuantity);
            book.setCategory(category);
            return book;
        }
        
        public static Book createBookWithTimestamp(int bookId, String title, String description,
                                                 BigDecimal pricePerUnit, int stockQuantity,
                                                 BookCategory category, Timestamp updatedAt) {
            Book book = createBook(bookId, title, description, pricePerUnit, stockQuantity, category);
            book.setUpdatedAt(updatedAt);
            return book;
        }
    }
    
    // Strategy Pattern - Book Validation
    public interface BookValidationStrategy {
        boolean validate(Book book);
        String getErrorMessage();
    }
    
    public static class TitleValidationStrategy implements BookValidationStrategy {
        @Override
        public boolean validate(Book book) {
            return book.getTitle() != null && !book.getTitle().trim().isEmpty();
        }
        
        @Override
        public String getErrorMessage() {
            return "Book title is required";
        }
    }
    
    public static class PriceValidationStrategy implements BookValidationStrategy {
        @Override
        public boolean validate(Book book) {
            return book.getPricePerUnit() != null && book.getPricePerUnit().compareTo(BigDecimal.ZERO) > 0;
        }
        
        @Override
        public String getErrorMessage() {
            return "Book price must be greater than zero";
        }
    }
    
    public static class StockValidationStrategy implements BookValidationStrategy {
        @Override
        public boolean validate(Book book) {
            return book.getStockQuantity() >= 0;
        }
        
        @Override
        public String getErrorMessage() {
            return "Stock quantity cannot be negative";
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DatabaseConnectionManager.getInstance().getConnection();
    }

    // Book Model Class
    public static class Book {
        private int bookId;
        private String title;
        private String description;
        private BigDecimal pricePerUnit;
        private int stockQuantity;
        private BookCategory category;
        private User createdBy;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        public Book() {}
        
        public Book(int bookId, String title, String description, BigDecimal pricePerUnit, int stockQuantity, BookCategory category, Timestamp updatedAt) {
            this.bookId = bookId;
            this.title = title;
            this.description = description;
            this.pricePerUnit = pricePerUnit;
            this.stockQuantity = stockQuantity;
            this.category = category;
            this.updatedAt = updatedAt;
        }
        
        // Builder Pattern for Book
        public static class BookBuilder {
            private int bookId;
            private String title;
            private String description;
            private BigDecimal pricePerUnit;
            private int stockQuantity;
            private BookCategory category;
            private User createdBy;
            private Timestamp createdAt;
            private Timestamp updatedAt;
            
            public BookBuilder bookId(int bookId) {
                this.bookId = bookId;
                return this;
            }
            
            public BookBuilder title(String title) {
                this.title = title;
                return this;
            }
            
            public BookBuilder description(String description) {
                this.description = description;
                return this;
            }
            
            public BookBuilder pricePerUnit(BigDecimal pricePerUnit) {
                this.pricePerUnit = pricePerUnit;
                return this;
            }
            
            public BookBuilder stockQuantity(int stockQuantity) {
                this.stockQuantity = stockQuantity;
                return this;
            }
            
            public BookBuilder category(BookCategory category) {
                this.category = category;
                return this;
            }
            
            public BookBuilder createdBy(User createdBy) {
                this.createdBy = createdBy;
                return this;
            }
            
            public BookBuilder createdAt(Timestamp createdAt) {
                this.createdAt = createdAt;
                return this;
            }
            
            public BookBuilder updatedAt(Timestamp updatedAt) {
                this.updatedAt = updatedAt;
                return this;
            }
            
            public Book build() {
                Book book = new Book();
                book.setBookId(bookId);
                book.setTitle(title);
                book.setDescription(description);
                book.setPricePerUnit(pricePerUnit);
                book.setStockQuantity(stockQuantity);
                book.setCategory(category);
                book.setCreatedBy(createdBy);
                book.setCreatedAt(createdAt);
                book.setUpdatedAt(updatedAt);
                return book;
            }
        }
        
        public static BookBuilder builder() {
            return new BookBuilder();
        }
        
        // Getters and Setters
        public int getBookId() {
            return bookId;
        }
        
        public void setBookId(int bookId) {
            this.bookId = bookId;
        }
        
        public String getTitle() {
            return title;
        }
        
        public void setTitle(String title) {
            this.title = title;
        }
        
        public String getDescription() {
            return description;
        }
        
        public void setDescription(String description) {
            this.description = description;
        }
        
        public BigDecimal getPricePerUnit() {
            return pricePerUnit;
        }
        
        public void setPricePerUnit(BigDecimal pricePerUnit) {
            this.pricePerUnit = pricePerUnit;
        }
        
        // Convenience method for JSP compatibility
        public BigDecimal getPrice() {
            return pricePerUnit;
        }
        
        public int getStockQuantity() {
            return stockQuantity;
        }
        
        public void setStockQuantity(int stockQuantity) {
            this.stockQuantity = stockQuantity;
        }
        
        public BookCategory getCategory() {
            return category;
        }
        
        public void setCategory(BookCategory category) {
            this.category = category;
        }
        
        // Convenience method for JSP compatibility
        public String getCategoryName() {
            return category != null ? category.getCategoryName() : null;
        }
        
        // Convenience method for JSP compatibility (database doesn't have author column)
        public String getAuthor() {
            return "Unknown Author"; // Since database doesn't store author information
        }
        
        public User getCreatedBy() {
            return createdBy;
        }
        
        public void setCreatedBy(User createdBy) {
            this.createdBy = createdBy;
        }
        
        public Timestamp getCreatedAt() {
            return createdAt;
        }
        
        public void setCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
        }
        
        public Timestamp getUpdatedAt() {
            return updatedAt;
        }
        
        public void setUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
        }
        
        @Override
        public String toString() {
            return "Book{" + "bookId=" + bookId + ", title=" + title + ", pricePerUnit=" + pricePerUnit + ", stockQuantity=" + stockQuantity + ", category=" + category + '}';
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }

    // Book DAO Methods
    public boolean createBook(Book book) {
        String sql = "INSERT INTO books (title, description, price_per_unit, stock_quantity, category_id, created_by, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getDescription());
            pstmt.setBigDecimal(3, book.getPricePerUnit());
            pstmt.setInt(4, book.getStockQuantity());
            pstmt.setInt(5, book.getCategory().getCategoryId());
            pstmt.setInt(6, book.getCreatedBy().getUserId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating book: " + e.getMessage());
            return false;
        }
    }
    
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name, u.username as created_by_name FROM books b " +
                    "LEFT JOIN categories c ON b.category_id = c.category_id " +
                    "LEFT JOIN users u ON b.created_by = u.user_id " +
                    "ORDER BY b.book_id";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setDescription(rs.getString("description"));
                book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                book.setStockQuantity(rs.getInt("stock_quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                // Note: updated_at column doesn't exist in database yet
                book.setUpdatedAt(null);
                
                // Set category
                BookCategory category = new BookCategory();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                book.setCategory(category);
                
                // Set created by user
                User createdBy = new User();
                createdBy.setUserId(rs.getInt("created_by"));
                createdBy.setUsername(rs.getString("created_by_name"));
                book.setCreatedBy(createdBy);
                
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all books: " + e.getMessage());
        }
        return books;
    }
    
    public Book getBookById(int bookId) {
        String sql = "SELECT b.*, c.category_name, u.username as created_by_name FROM books b " +
                    "LEFT JOIN categories c ON b.category_id = c.category_id " +
                    "LEFT JOIN users u ON b.created_by = u.user_id " +
                    "WHERE b.book_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setDescription(rs.getString("description"));
                    book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                                    book.setStockQuantity(rs.getInt("stock_quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                // Note: updated_at column doesn't exist in database yet
                book.setUpdatedAt(null);
                
                // Set category
                    BookCategory category = new BookCategory();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    book.setCategory(category);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    book.setCreatedBy(createdBy);
                    
                    return book;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting book by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title = ?, description = ?, price_per_unit = ?, stock_quantity = ?, category_id = ? WHERE book_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getDescription());
            pstmt.setBigDecimal(3, book.getPricePerUnit());
            pstmt.setInt(4, book.getStockQuantity());
            pstmt.setInt(5, book.getCategory().getCategoryId());
            pstmt.setInt(6, book.getBookId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE book_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateStockQuantity(int bookId, int newQuantity) {
        String sql = "UPDATE books SET stock_quantity = ? WHERE book_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, bookId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating stock quantity: " + e.getMessage());
            return false;
        }
    }
    
    public List<Book> getBooksByCategory(int categoryId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name, u.username as created_by_name FROM books b " +
                    "LEFT JOIN categories c ON b.category_id = c.category_id " +
                    "LEFT JOIN users u ON b.created_by = u.user_id " +
                    "WHERE b.category_id = ? " +
                    "ORDER BY b.book_id";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setDescription(rs.getString("description"));
                    book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                    book.setStockQuantity(rs.getInt("stock_quantity"));
                    book.setCreatedAt(rs.getTimestamp("created_at"));
                    // Note: updated_at column doesn't exist in database yet
                    book.setUpdatedAt(null);
                    
                    // Set category
                    BookCategory category = new BookCategory();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    book.setCategory(category);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    book.setCreatedBy(createdBy);
                    
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting books by category: " + e.getMessage());
        }
        return books;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        // Allow public access to list action (viewing books)
        if ("list".equals(action) || "search".equals(action) || "getBooksByCategory".equals(action)) {
            try {
                switch (action) {
                    case "list":
                        listBooks(request, response);
                        break;
                    case "search":
                        searchBooks(request, response);
                        break;
                    case "getBooksByCategory":
                        getBooksByCategory(request, response);
                        break;
                    default:
                        listBooks(request, response);
                        break;
                }
                return;
            } catch (Exception e) {
                System.err.println("Error in BookServlet (public): " + e.getMessage());
                response.sendRedirect("books.jsp?error=An error occurred: " + e.getMessage());
                return;
            }
        }
        
        // For other actions, require authentication
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || role == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }
        
        // Check role-based access for admin operations
        boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "STAFF".equals(role);
        if (!canAccess) {
            response.sendRedirect("dashboard.jsp?error=Access denied.");
            return;
        }

        try {
            switch (action) {
                case "list":
                    listBooks(request, response);
                    break;
                case "add":
                    addBook(request, response);
                    break;
                case "edit":
                    editBook(request, response);
                    break;
                case "update":
                    updateBook(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "getBooksByCategory":
                    getBooksByCategory(request, response);
                    break;
                default:
                    listBooks(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in BookServlet: " + e.getMessage());
            response.sendRedirect("book.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Book> books = getAllBooks();
        List<BookCategory> categories = new BookCategoryServlet().getAllBookCategories();
        
        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        
        // Check if this is a redirect request from books.jsp
        String redirect = request.getParameter("redirect");
        if ("books.jsp".equals(redirect)) {
            request.getRequestDispatcher("books.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("book.jsp").forward(request, response);
        }
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("searchTerm");
        String categoryFilter = request.getParameter("categoryFilter");
        
        List<Book> books = getAllBooks(); // For now, get all books
        List<BookCategory> categories = new BookCategoryServlet().getAllBookCategories();
        
        // TODO: Implement actual search logic
        // For now, just return all books
        
        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("categoryFilter", categoryFilter);
        
        request.getRequestDispatcher("books.jsp").forward(request, response);
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");
        
        // Validation
        if (title == null || title.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Book title is required.");
            return;
        }
        
        if (priceStr == null || priceStr.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Price is required.");
            return;
        }
        
        if (stockStr == null || stockStr.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Stock quantity is required.");
            return;
        }
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Category is required.");
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Get current user
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            
            // Create book object
            Book book = new Book();
            book.setTitle(title.trim());
            book.setDescription(description != null ? description.trim() : "");
            book.setPricePerUnit(price);
            book.setStockQuantity(stock);
            
            // Set category
            BookCategory category = new BookCategory();
            category.setCategoryId(categoryId);
            book.setCategory(category);
            
            // Set created by
            book.setCreatedBy(currentUser);

            boolean success = createBook(book);
            
            if (success) {
                response.sendRedirect("BookServlet?action=list&message=Book added successfully.");
            } else {
                response.sendRedirect("book.jsp?error=Failed to add book.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("book.jsp?error=Invalid price or stock quantity.");
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("id");
        
        if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
            response.sendRedirect("BookServlet?action=list&error=Book ID is required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            Book book = getBookById(bookId);
            
            if (book != null) {
                // Get all categories for the dropdown
                List<BookCategory> categories = new BookCategoryServlet().getAllBookCategories();
                request.setAttribute("book", book);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("book_edit.jsp").forward(request, response);
            } else {
                response.sendRedirect("BookServlet?action=list&error=Book not found.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookServlet?action=list&error=Invalid book ID.");
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");
        
        // Validation
        if (bookIdStr == null || title == null || priceStr == null || 
            stockStr == null || categoryIdStr == null ||
            bookIdStr.trim().isEmpty() || title.trim().isEmpty() || 
            priceStr.trim().isEmpty() || stockStr.trim().isEmpty() || 
            categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookServlet?action=list&error=All fields are required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Create book object
            Book book = new Book();
            book.setBookId(bookId);
            book.setTitle(title.trim());
            book.setDescription(description != null ? description.trim() : "");
            book.setPricePerUnit(price);
            book.setStockQuantity(stock);
            
            // Set category
            BookCategory category = new BookCategory();
            category.setCategoryId(categoryId);
            book.setCategory(category);

            boolean success = updateBook(book);
            
            if (success) {
                response.sendRedirect("BookServlet?action=list&message=Book updated successfully.");
            } else {
                response.sendRedirect("BookServlet?action=list&error=Failed to update book.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookServlet?action=list&error=Invalid price, stock quantity, or book ID.");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("id");
        
        if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
            response.sendRedirect("BookServlet?action=list&error=Book ID is required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            
            boolean success = deleteBook(bookId);
            
            if (success) {
                response.sendRedirect("BookServlet?action=list&message=Book deleted successfully.");
            } else {
                response.sendRedirect("BookServlet?action=list&error=Failed to delete book.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookServlet?action=list&error=Invalid book ID.");
        }
    }

    private void getBooksByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Skip session check for AJAX calls to allow testing
        System.out.println("getBooksByCategory called");
        
        String categoryIdStr = request.getParameter("categoryId");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is required");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            List<Book> books;
            
            System.out.println("Getting books for category ID: " + categoryId);
            
            if (categoryId == 0) {
                // Get all books
                books = getAllBooks();
                System.out.println("Retrieved " + (books != null ? books.size() : 0) + " books from getAllBooks()");
            } else {
                // Get books by category
                books = getBooksByCategory(categoryId);
                System.out.println("Retrieved " + (books != null ? books.size() : 0) + " books from getBooksByCategory(" + categoryId + ")");
            }
            
            if (books == null) {
                books = new ArrayList<>();
                System.out.println("Books list was null, created empty list");
            }
            
            // Convert books to JSON format
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            PrintWriter out = response.getWriter();
            out.print("[");
            
            for (int i = 0; i < books.size(); i++) {
                Book book = books.get(i);
                System.out.println("Processing book: " + book.getTitle() + " (ID: " + book.getBookId() + ")");
                
                out.print("{");
                out.print("\"id\":" + book.getBookId() + ",");
                out.print("\"title\":\"" + (book.getTitle() != null ? book.getTitle().replace("\"", "\\\"") : "") + "\",");
                out.print("\"price\":" + book.getPricePerUnit() + ",");
                out.print("\"stock\":" + book.getStockQuantity() + ",");
                out.print("\"category\":\"" + (book.getCategory() != null && book.getCategory().getCategoryName() != null ? book.getCategory().getCategoryName().replace("\"", "\\\"") : "") + "\"");
                out.print("}");
                
                if (i < books.size() - 1) {
                    out.print(",");
                }
            }
            
            out.print("]");
            out.flush();
            
            System.out.println("JSON response sent successfully");
            
        } catch (NumberFormatException e) {
            System.err.println("NumberFormatException: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
        } catch (Exception e) {
            System.err.println("Exception in getBooksByCategory: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
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
        return "Book Management Servlet";
    }
} 