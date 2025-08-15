package com.booking;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.DatabaseMetaData;

/**
 * Servlet for handling BookCategory operations
 */
public class BookCategoryServlet extends HttpServlet {

    private Connection getConnection() throws SQLException {
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("BookCategoryServlet: MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("BookCategoryServlet: MySQL JDBC Driver not found: " + e.getMessage());
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        
        String url = "jdbc:mysql://localhost:3306/pahana_bookshop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String username = "root";
        String password = "password";
        
        System.out.println("BookCategoryServlet: Attempting to connect to: " + url);
        Connection conn = DriverManager.getConnection(url, username, password);
        System.out.println("BookCategoryServlet: Database connection successful");
        return conn;
    }

    // BookCategory Model Class
    public static class BookCategory {
        private int categoryId;
        private String categoryName;
        
        public BookCategory() {}
        
        public BookCategory(int categoryId, String categoryName) {
            this.categoryId = categoryId;
            this.categoryName = categoryName;
        }
        
        // Getters and Setters
        public int getCategoryId() {
            return categoryId;
        }
        
        public void setCategoryId(int categoryId) {
            this.categoryId = categoryId;
        }
        
        public String getCategoryName() {
            return categoryName;
        }
        
        public void setCategoryName(String categoryName) {
            this.categoryName = categoryName;
        }
    }

    // BookCategory DAO Methods
    public boolean createBookCategory(BookCategory bookCategory) {
        String sql = "INSERT INTO categories (category_name) VALUES (?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookCategory.getCategoryName());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating book category: " + e.getMessage());
            return false;
        }
    }
    
    public List<BookCategory> getAllBookCategories() {
        List<BookCategory> bookCategories = new ArrayList<>();
        
        try (Connection conn = getConnection()) {
            // First check if table exists
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet tables = metaData.getTables(null, null, "categories", null);
            
            if (!tables.next()) {
                System.err.println("BookCategoryServlet: categories table does not exist!");
                return bookCategories;
            }
            
            System.out.println("BookCategoryServlet: categories table exists");
            
            // Check table structure
            ResultSet columns = metaData.getColumns(null, null, "categories", null);
            System.out.println("BookCategoryServlet: Table columns:");
            while (columns.next()) {
                String columnName = columns.getString("COLUMN_NAME");
                String columnType = columns.getString("TYPE_NAME");
                System.out.println("  - " + columnName + " (" + columnType + ")");
            }
            
            String sql = "SELECT * FROM categories ORDER BY category_id";
            System.out.println("BookCategoryServlet: Executing SQL: " + sql);
            
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                
                System.out.println("BookCategoryServlet: Database connection successful");
                
                while (rs.next()) {
                    BookCategory bookCategory = new BookCategory();
                    bookCategory.setCategoryId(rs.getInt("category_id"));
                    bookCategory.setCategoryName(rs.getString("category_name"));
                    bookCategories.add(bookCategory);
                    System.out.println("BookCategoryServlet: Found category - ID: " + bookCategory.getCategoryId() + ", Name: " + bookCategory.getCategoryName());
                }
                
                System.out.println("BookCategoryServlet: Total categories found: " + bookCategories.size());
            }
        } catch (SQLException e) {
            System.err.println("Error getting all book categories: " + e.getMessage());
            e.printStackTrace();
        }
        return bookCategories;
    }
    
    public BookCategory getBookCategoryById(int categoryId) {
        String sql = "SELECT * FROM categories WHERE category_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BookCategory bookCategory = new BookCategory();
                    bookCategory.setCategoryId(rs.getInt("category_id"));
                    bookCategory.setCategoryName(rs.getString("category_name"));
                    return bookCategory;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting book category by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateBookCategory(BookCategory bookCategory) {
        String sql = "UPDATE categories SET category_name = ? WHERE category_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookCategory.getCategoryName());
            pstmt.setInt(2, bookCategory.getCategoryId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating book category: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBookCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting book category: " + e.getMessage());
            return false;
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
        // Removed bookCategoryDAO initialization
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String redirectParam = request.getParameter("redirect");

        // Handle malformed URLs like action=listredirect=book_category.jsp
        // by extracting the redirect portion from the action parameter
        if (action != null && action.contains("redirect=")) {
            String[] parts = action.split("redirect=", 2);
            action = parts[0] != null ? parts[0].replaceAll("[?&]+$", "").trim() : "list";
            if (redirectParam == null && parts.length > 1) {
                redirectParam = parts[1] != null ? parts[1].trim() : null;
            }
        }

        // Normalize default action
        
        if (action == null) {
            action = "list";
        }

        // Preserve redirect for downstream handlers
        if (redirectParam != null && !redirectParam.isEmpty()) {
            request.setAttribute("redirect", redirectParam);
        }

        // Allow public access to list action (viewing categories)
        if ("list".equals(action)) {
            try {
                listBookCategories(request, response);
                return;
            } catch (Exception e) {
                System.err.println("Error in BookCategoryServlet (public): " + e.getMessage());
                response.sendRedirect("categories.jsp?error=An error occurred: " + e.getMessage());
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
                    listBookCategories(request, response);
                    break;
                case "add":
                    addBookCategory(request, response);
                    break;
                case "edit":
                    editBookCategory(request, response);
                    break;
                case "update":
                    updateBookCategory(request, response);
                    break;
                case "delete":
                    deleteBookCategory(request, response);
                    break;
                default:
                    listBookCategories(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in BookCategoryServlet: " + e.getMessage());
            response.sendRedirect("book_category.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listBookCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BookCategory> bookCategories = getAllBookCategories();
        request.setAttribute("categories", bookCategories);

        // Debug logging
        System.out.println("BookCategoryServlet: Retrieved " + (bookCategories != null ? bookCategories.size() : 0) + " categories");
        System.out.println("BookCategoryServlet: Setting 'categories' attribute");

        // Determine redirect target if provided
        String redirect = (String) request.getAttribute("redirect");
        if (redirect == null || redirect.trim().isEmpty()) {
            redirect = request.getParameter("redirect");
        }

        // Debug logging
        System.out.println("BookCategoryServlet: Redirect attribute: " + request.getAttribute("redirect"));
        System.out.println("BookCategoryServlet: Redirect parameter: " + request.getParameter("redirect"));
        System.out.println("BookCategoryServlet: Final redirect value: " + redirect);

        // Default views
        String defaultPublicView = "categories.jsp";
        String defaultAdminView = "book_category.jsp"; // admin listing page

        String targetView = defaultPublicView;

        if (redirect != null && !redirect.trim().isEmpty()) {
            // Sanitize to prevent open redirect to external resources; only allow JSPs in web root
            if (redirect.endsWith(".jsp") && !redirect.contains("://") && !redirect.contains("..")) {
                targetView = redirect;
                System.out.println("BookCategoryServlet: Using redirect target: " + targetView);
            }
        } else {
            // If user is authenticated (admin/manager/staff), prefer admin view
            HttpSession session = request.getSession(false);
            if (session != null) {
                String role = (String) session.getAttribute("role");
                if ("ADMIN".equals(role) || "MANAGER".equals(role) || "STAFF".equals(role)) {
                    targetView = defaultAdminView;
                    System.out.println("BookCategoryServlet: Using admin view: " + targetView);
                }
            }
        }

        System.out.println("BookCategoryServlet: Final target view: " + targetView);
        request.getRequestDispatcher(targetView).forward(request, response);
    }

    private void addBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            response.sendRedirect("book_category.jsp?error=Category name is required.");
            return;
        }

        BookCategory bookCategory = new BookCategory();
        bookCategory.setCategoryName(categoryName.trim());

        boolean success = createBookCategory(bookCategory); // Use the new method
        
        if (success) {
            response.sendRedirect("BookCategoryServlet?action=list&message=Category added successfully.");
        } else {
            response.sendRedirect("book_category.jsp?error=Failed to add category.");
        }
    }

    private void editBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            BookCategory bookCategory = getBookCategoryById(categoryId); // Use the new method
            
            if (bookCategory != null) {
                request.setAttribute("bookCategory", bookCategory);
                request.getRequestDispatcher("book_category_edit.jsp").forward(request, response);
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Category not found.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
        }
    }

    private void updateBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        
        if (categoryIdStr == null || categoryName == null || 
            categoryIdStr.trim().isEmpty() || categoryName.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID and name are required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            BookCategory bookCategory = new BookCategory();
            bookCategory.setCategoryId(categoryId);
            bookCategory.setCategoryName(categoryName.trim());

            boolean success = updateBookCategory(bookCategory); // Use the new method
            
            if (success) {
                response.sendRedirect("BookCategoryServlet?action=list&message=Category updated successfully.");
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Failed to update category.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
        }
    }

    private void deleteBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            boolean success = deleteBookCategory(categoryId); // Use the new method
            
            if (success) {
                response.sendRedirect("BookCategoryServlet?action=list&message=Category deleted successfully.");
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Failed to delete category.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
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
        return "Book Category Management Servlet";
    }
} 