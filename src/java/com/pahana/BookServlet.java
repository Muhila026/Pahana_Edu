package com.pahana;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/BookServlet"})
public class BookServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            listBooks(request, response);
        } else if ("search".equals(action)) {
            searchBooks(request, response);
        } else if ("view".equals(action)) {
            viewBook(request, response);
        } else {
            // Default: list all books
            listBooks(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addBook(request, response);
                break;
            case "update":
                updateBook(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void listBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT b.*, c.category_name FROM books b " +
                        "LEFT JOIN categories c ON b.category_id = c.category_id " +
                        "ORDER BY b.title";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<Book> books = new ArrayList<>();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getBigDecimal("price"));
                book.setStockQuantity(rs.getInt("stock_quantity"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setCategoryName(rs.getString("category_name"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                books.add(book);
            }
            
            request.setAttribute("books", books);
            
            // Get categories for dropdown
            sql = "SELECT * FROM categories ORDER BY category_name";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            List<CategoryServlet.Category> categories = new ArrayList<>();
            while (rs.next()) {
                CategoryServlet.Category category = new CategoryServlet.Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
            
            request.setAttribute("categories", categories);
            
            rs.close();
            stmt.close();
            conn.close();
            
            // Check if redirect is requested
            String redirect = request.getParameter("redirect");
            if ("pos".equals(redirect)) {
                // Redirect back to POS with book data
                request.getRequestDispatcher("pos.jsp").forward(request, response);
                return;
            }
            
            // Forward to appropriate page based on user role
            HttpSession session = request.getSession();
            String userType = (String) session.getAttribute("userType");
            String role = (String) session.getAttribute("role");
            
            if (isAdminOrManager(role)) {
                request.getRequestDispatcher("book-management.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("books.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("books.jsp").forward(request, response);
        }
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("searchTerm");
        String categoryFilter = request.getParameter("categoryFilter");
        
        if (searchTerm == null) {
            searchTerm = "";
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT b.*, c.category_name FROM books b ");
            sqlBuilder.append("LEFT JOIN categories c ON b.category_id = c.category_id ");
            sqlBuilder.append("WHERE (b.title LIKE ? OR b.author LIKE ?) ");
            
            List<Object> params = new ArrayList<>();
            params.add("%" + searchTerm + "%");
            params.add("%" + searchTerm + "%");
            
            if (categoryFilter != null && !categoryFilter.isEmpty() && !"all".equals(categoryFilter)) {
                sqlBuilder.append("AND b.category_id = ? ");
                params.add(Integer.parseInt(categoryFilter));
            }
            
            sqlBuilder.append("ORDER BY b.title");
            
            PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            
            List<Book> books = new ArrayList<>();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getBigDecimal("price"));
                book.setStockQuantity(rs.getInt("stock_quantity"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setCategoryName(rs.getString("category_name"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                books.add(book);
            }
            
            request.setAttribute("books", books);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("categoryFilter", categoryFilter);
            
            // Get categories for dropdown
            String categorySql = "SELECT * FROM categories ORDER BY category_name";
            PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
            ResultSet categoryRs = categoryStmt.executeQuery();
            
            List<CategoryServlet.Category> categories = new ArrayList<>();
            while (categoryRs.next()) {
                CategoryServlet.Category category = new CategoryServlet.Category();
                category.setCategoryId(categoryRs.getInt("category_id"));
                category.setCategoryName(categoryRs.getString("category_name"));
                category.setDescription(categoryRs.getString("description"));
                categories.add(category);
            }
            
            request.setAttribute("categories", categories);
            
            rs.close();
            stmt.close();
            categoryRs.close();
            categoryStmt.close();
            conn.close();
            
            request.getRequestDispatcher("books.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("books.jsp").forward(request, response);
        }
    }
    
    private void viewBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookId = request.getParameter("bookId");
        
        if (bookId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book ID is required");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT b.*, c.category_name FROM books b " +
                        "LEFT JOIN categories c ON b.category_id = c.category_id " +
                        "WHERE b.book_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(bookId));
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getBigDecimal("price"));
                book.setStockQuantity(rs.getInt("stock_quantity"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setCategoryName(rs.getString("category_name"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                
                request.setAttribute("book", book);
            } else {
                request.setAttribute("error", "Book not found");
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
            request.getRequestDispatcher("book-detail.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("books.jsp").forward(request, response);
        }
    }
    
    private void addBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!isAdminOrManager(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String price = request.getParameter("price");
        String stockQuantity = request.getParameter("stockQuantity");
        String categoryId = request.getParameter("categoryId");
        
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Book title is required");
            request.getRequestDispatcher("book-management.jsp").forward(request, response);
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "INSERT INTO books (title, author, price, stock_quantity, category_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title.trim());
            stmt.setString(2, author != null ? author.trim() : "");
            stmt.setBigDecimal(3, new java.math.BigDecimal(price != null ? price : "0"));
            stmt.setInt(4, Integer.parseInt(stockQuantity != null ? stockQuantity : "0"));
            stmt.setInt(5, Integer.parseInt(categoryId != null ? categoryId : "1"));
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (result > 0) {
                request.setAttribute("success", "Book added successfully");
            } else {
                request.setAttribute("error", "Failed to add book");
            }
            
            response.sendRedirect("BookServlet?action=list");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("book-management.jsp").forward(request, response);
        }
    }
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!isAdminOrManager(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String bookId = request.getParameter("bookId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String price = request.getParameter("price");
        String stockQuantity = request.getParameter("stockQuantity");
        String categoryId = request.getParameter("categoryId");
        
        if (bookId == null || title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Book ID and title are required");
            request.getRequestDispatcher("book-management.jsp").forward(request, response);
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "UPDATE books SET title = ?, author = ?, price = ?, stock_quantity = ?, category_id = ? WHERE book_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title.trim());
            stmt.setString(2, author != null ? author.trim() : "");
            stmt.setBigDecimal(3, new java.math.BigDecimal(price != null ? price : "0"));
            stmt.setInt(4, Integer.parseInt(stockQuantity != null ? stockQuantity : "0"));
            stmt.setInt(5, Integer.parseInt(categoryId != null ? categoryId : "1"));
            stmt.setInt(6, Integer.parseInt(bookId));
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (result > 0) {
                request.setAttribute("success", "Book updated successfully");
            } else {
                request.setAttribute("error", "Book not found or no changes made");
            }
            
            response.sendRedirect("BookServlet?action=list");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("book-management.jsp").forward(request, response);
        }
    }
    
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!isAdminOrManager(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String bookId = request.getParameter("bookId");
        
        if (bookId == null) {
            request.setAttribute("error", "Book ID is required");
            request.getRequestDispatcher("book-management.jsp").forward(request, response);
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "DELETE FROM books WHERE book_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(bookId));
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (result > 0) {
                request.setAttribute("success", "Book deleted successfully");
            } else {
                request.setAttribute("error", "Book not found");
            }
            
            response.sendRedirect("BookServlet?action=list");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("book-management.jsp").forward(request, response);
        }
    }
    
    private boolean isAdminOrManager(String role) {
        return "Admin".equals(role) || "Manager".equals(role);
    }
    
    // Inner class for Book
    public static class Book {
        private int bookId;
        private String title;
        private String author;
        private java.math.BigDecimal price;
        private int stockQuantity;
        private int categoryId;
        private String categoryName;
        private java.sql.Timestamp createdAt;
        
        // Getters and Setters
        public int getBookId() { return bookId; }
        public void setBookId(int bookId) { this.bookId = bookId; }
        
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        
        public String getAuthor() { return author; }
        public void setAuthor(String author) { this.author = author; }
        
        public java.math.BigDecimal getPrice() { return price; }
        public void setPrice(java.math.BigDecimal price) { this.price = price; }
        
        public int getStockQuantity() { return stockQuantity; }
        public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }
        
        public int getCategoryId() { return categoryId; }
        public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
        
        public String getCategoryName() { return categoryName; }
        public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
        
        public java.sql.Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(java.sql.Timestamp createdAt) { this.createdAt = createdAt; }
    }
} 