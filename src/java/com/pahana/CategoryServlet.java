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

@WebServlet(urlPatterns = {"/CategoryServlet"})
public class CategoryServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            listCategories(request, response);
        } else if ("search".equals(action)) {
            searchCategories(request, response);
        } else {
            // Default: list all categories
            listCategories(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void listCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT * FROM categories ORDER BY category_name";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<Category> categories = new ArrayList<>();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                categories.add(category);
            }
            
            request.setAttribute("categories", categories);
            
            rs.close();
            stmt.close();
            conn.close();
            
            // Forward to appropriate page based on user role
            HttpSession session = request.getSession();
            String userType = (String) session.getAttribute("userType");
            String role = (String) session.getAttribute("role");
            
            if (isAdminOrManager(role)) {
                request.getRequestDispatcher("category-management.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("categories.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("categories.jsp").forward(request, response);
        }
    }
    
    private void searchCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm == null) {
            searchTerm = "";
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT * FROM categories WHERE category_name LIKE ? OR description LIKE ? ORDER BY category_name";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            
            List<Category> categories = new ArrayList<>();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                categories.add(category);
            }
            
            request.setAttribute("categories", categories);
            request.setAttribute("searchTerm", searchTerm);
            
            rs.close();
            stmt.close();
            conn.close();
            
            request.getRequestDispatcher("categories.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("categories.jsp").forward(request, response);
        }
    }
    
    private void addCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!isAdminOrManager(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("error", "Category name is required");
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, categoryName.trim());
            stmt.setString(2, description != null ? description.trim() : "");
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (result > 0) {
                request.setAttribute("success", "Category added successfully");
            } else {
                request.setAttribute("error", "Failed to add category");
            }
            
            response.sendRedirect("CategoryServlet?action=list");
            
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { // Duplicate entry
                request.setAttribute("error", "Category name already exists");
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
        }
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!isAdminOrManager(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String categoryId = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        
        if (categoryId == null || categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("error", "Category ID and name are required");
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "UPDATE categories SET category_name = ?, description = ? WHERE category_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, categoryName.trim());
            stmt.setString(2, description != null ? description.trim() : "");
            stmt.setInt(3, Integer.parseInt(categoryId));
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (result > 0) {
                request.setAttribute("success", "Category updated successfully");
            } else {
                request.setAttribute("error", "Category not found or no changes made");
            }
            
            response.sendRedirect("CategoryServlet?action=list");
            
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { // Duplicate entry
                request.setAttribute("error", "Category name already exists");
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
        }
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!isAdminOrManager(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String categoryId = request.getParameter("categoryId");
        
        if (categoryId == null) {
            request.setAttribute("error", "Category ID is required");
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Check if category is being used by any books
            String checkSql = "SELECT COUNT(*) FROM books WHERE category_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, Integer.parseInt(categoryId));
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                request.setAttribute("error", "Cannot delete category: It is being used by books");
                request.getRequestDispatcher("category-management.jsp").forward(request, response);
                return;
            }
            
            String sql = "DELETE FROM categories WHERE category_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(categoryId));
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (result > 0) {
                request.setAttribute("success", "Category deleted successfully");
            } else {
                request.setAttribute("error", "Category not found");
            }
            
            response.sendRedirect("CategoryServlet?action=list");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("category-management.jsp").forward(request, response);
        }
    }
    
    private boolean isAdminOrManager(String role) {
        return "Admin".equals(role) || "Manager".equals(role);
    }
    
    // Inner class for Category
    public static class Category {
        private int categoryId;
        private String categoryName;
        private String description;
        private java.sql.Timestamp createdAt;
        
        // Getters and Setters
        public int getCategoryId() { return categoryId; }
        public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
        
        public String getCategoryName() { return categoryName; }
        public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        
        public java.sql.Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(java.sql.Timestamp createdAt) { this.createdAt = createdAt; }
    }
} 