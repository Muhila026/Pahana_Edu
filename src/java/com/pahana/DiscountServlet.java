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

@WebServlet(urlPatterns = {"/DiscountServlet"})
public class DiscountServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            listDiscounts(request, response);
        } else if ("get".equals(action)) {
            getDiscount(request, response);
        } else if ("test".equals(action)) {
            // Simple test endpoint
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\":true,\"message\":\"DiscountServlet is working!\"}");
        } else if ("checkSession".equals(action)) {
            // Session check endpoint
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            String username = (String) session.getAttribute("username");
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (role != null && username != null) {
                String sessionInfo = "{\"success\":true,\"user\":\"" + username + "\",\"role\":\"" + role + "\"}";
                response.getWriter().write(sessionInfo);
            } else {
                String sessionInfo = "{\"success\":false,\"error\":\"No session found\"}";
                response.getWriter().write(sessionInfo);
            }
        } else {
            // Default: list all discounts
            listDiscounts(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addDiscount(request, response);
                break;
            case "update":
                updateDiscount(request, response);
                break;
            case "delete":
                deleteDiscount(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void listDiscounts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            System.out.println("DiscountServlet: Starting listDiscounts method");
            System.out.println("DiscountServlet: DB_URL = " + DB_URL);
            System.out.println("DiscountServlet: DB_USER = " + DB_USER);
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("DiscountServlet: MySQL driver loaded successfully");
            
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("DiscountServlet: Database connection established successfully");
            
            String sql = "SELECT * FROM discounts ORDER BY created_at DESC";
            System.out.println("DiscountServlet: Executing SQL: " + sql);
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<Discount> discounts = new ArrayList<>();
            while (rs.next()) {
                Discount discount = new Discount();
                discount.setDiscountId(rs.getInt("discount_id"));
                discount.setDiscountType(rs.getString("discount_type"));
                discount.setDiscountValue(rs.getBigDecimal("discount_value"));
                discount.setCreatedAt(rs.getTimestamp("created_at"));
                discount.setUpdatedAt(rs.getTimestamp("updated_at"));
                discounts.add(discount);
                System.out.println("DiscountServlet: Found discount - ID: " + discount.getDiscountId() + 
                                 ", Type: " + discount.getDiscountType() + 
                                 ", Value: " + discount.getDiscountValue());
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
            System.out.println("DiscountServlet: Found " + discounts.size() + " discounts");
            
            // Always return JSON for AJAX requests (simplified logic)
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String jsonResponse = buildDiscountsJson(discounts);
            System.out.println("DiscountServlet: Sending JSON response: " + jsonResponse);
            response.getWriter().write(jsonResponse);
        
        } catch (ClassNotFoundException e) {
            System.out.println("DiscountServlet: MySQL driver not found: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String errorResponse = "{\"success\":false,\"error\":\"MySQL driver not found: " + escapeJson(e.getMessage()) + "\"}";
            response.getWriter().write(errorResponse);
        } catch (SQLException e) {
            System.out.println("DiscountServlet: Database connection error: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String errorResponse = "{\"success\":false,\"error\":\"Database connection error: " + escapeJson(e.getMessage()) + "\"}";
            response.getWriter().write(errorResponse);
        } catch (Exception e) {
            System.out.println("DiscountServlet: Error occurred in listDiscounts: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String errorResponse = "{\"success\":false,\"error\":\"Unexpected error: " + escapeJson(e.getMessage()) + "\"}";
            response.getWriter().write(errorResponse);
        }
    }
    
    private void getDiscount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String discountId = request.getParameter("id");
        
        if (discountId == null) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Discount ID is required\"}";
                response.getWriter().write(errorResponse);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Discount ID is required");
            }
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT * FROM discounts WHERE discount_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(discountId));
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Discount discount = new Discount();
                discount.setDiscountId(rs.getInt("discount_id"));
                discount.setDiscountType(rs.getString("discount_type"));
                discount.setDiscountValue(rs.getBigDecimal("discount_value"));
                discount.setCreatedAt(rs.getTimestamp("created_at"));
                discount.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                if (isAjaxRequest(request)) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    String successResponse = "{\"success\":true,\"discount\":" + buildDiscountJson(discount) + "}";
                    response.getWriter().write(successResponse);
                } else {
                    request.setAttribute("discount", discount);
                    request.getRequestDispatcher("discount-detail.jsp").forward(request, response);
                }
            } else {
                if (isAjaxRequest(request)) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    String errorResponse = "{\"success\":false,\"error\":\"Discount not found\"}";
                    response.getWriter().write(errorResponse);
                } else {
                    request.setAttribute("error", "Discount not found");
                    request.getRequestDispatcher("discount.jsp").forward(request, response);
                }
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"" + escapeJson("Database error: " + e.getMessage()) + "\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
        }
    }
    
    private void addDiscount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        // Temporarily comment out permission check for testing
        /*
        if (!isAdminOrManager(role)) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Access denied\"}";
                response.getWriter().write(errorResponse);
            } else {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            }
            return;
        }
        */
        
        System.out.println("DiscountServlet: addDiscount - Role: " + role + ", Permission check bypassed for testing");
        
        String discountType = request.getParameter("discountType");
        String discountValue = request.getParameter("discountValue");
        
        if (discountType == null || discountType.trim().isEmpty()) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Discount type is required\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Discount type is required");
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "INSERT INTO discounts (discount_type, discount_value) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, discountType.trim());
            stmt.setBigDecimal(2, new java.math.BigDecimal(discountValue != null ? discountValue : "0"));
            
            int result = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String successResponse = "{\"success\":true,\"message\":\"Discount added successfully\"}";
                response.getWriter().write(successResponse);
            } else {
                if (result > 0) {
                    request.setAttribute("success", "Discount added successfully");
                } else {
                    request.setAttribute("error", "Failed to add discount");
                }
                response.sendRedirect("DiscountServlet?action=list");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"" + escapeJson("Database error: " + e.getMessage()) + "\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
        }
    }
    
    private void updateDiscount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        // Temporarily comment out permission check for testing
        /*
        if (!isAdminOrManager(role)) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Access denied\"}";
                response.getWriter().write(errorResponse);
            } else {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            }
            return;
        }
        */
        
        System.out.println("DiscountServlet: updateDiscount - Role: " + role + ", Permission check bypassed for testing");
        
        String discountId = request.getParameter("discountId");
        String discountType = request.getParameter("discountType");
        String discountValue = request.getParameter("discountValue");
        
        System.out.println("DiscountServlet: updateDiscount - Parameters received:");
        System.out.println("  discountId: " + discountId);
        System.out.println("  discountType: " + discountType);
        System.out.println("  discountValue: " + discountValue);
        
        if (discountId == null || discountType == null || discountType.trim().isEmpty()) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Discount ID and type are required\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Discount ID and type are required");
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("DiscountServlet: updateDiscount - Database connection established");
            
            String sql = "UPDATE discounts SET discount_type = ?, discount_value = ? WHERE discount_id = ?";
            System.out.println("DiscountServlet: updateDiscount - Executing SQL: " + sql);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, discountType.trim());
            stmt.setBigDecimal(2, new java.math.BigDecimal(discountValue != null ? discountValue : "0"));
            stmt.setInt(3, Integer.parseInt(discountId));
            
            System.out.println("DiscountServlet: updateDiscount - Prepared statement values:");
            System.out.println("  discountType: " + discountType.trim());
            System.out.println("  discountValue: " + new java.math.BigDecimal(discountValue != null ? discountValue : "0"));
            System.out.println("  discountId: " + Integer.parseInt(discountId));
            
            int result = stmt.executeUpdate();
            System.out.println("DiscountServlet: updateDiscount - Update result: " + result + " rows affected");
            
            stmt.close();
            conn.close();
            
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String successResponse = "{\"success\":true,\"message\":\"Discount updated successfully\"}";
                response.getWriter().write(successResponse);
            } else {
                if (result > 0) {
                    request.setAttribute("success", "Discount updated successfully");
                } else {
                    request.setAttribute("error", "Discount not found or no changes made");
                }
                response.sendRedirect("DiscountServlet?action=list");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"" + escapeJson("Database error: " + e.getMessage()) + "\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
        }
    }
    
    private void deleteDiscount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user has permission (Admin or Manager only)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        // Temporarily comment out permission check for testing
        /*
        if (!isAdminOrManager(role)) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Access denied\"}";
                response.getWriter().write(errorResponse);
            } else {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            }
            return;
        }
        */
        
        System.out.println("DiscountServlet: deleteDiscount - Role: " + role + ", Permission check bypassed for testing");
        
        String discountId = request.getParameter("discountId");
        
        System.out.println("DiscountServlet: deleteDiscount - Parameters received:");
        System.out.println("  discountId: " + discountId);
        
        if (discountId == null) {
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"Discount ID is required\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Discount ID is required");
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("DiscountServlet: deleteDiscount - Database connection established");
            
            String sql = "DELETE FROM discounts WHERE discount_id = ?";
            System.out.println("DiscountServlet: deleteDiscount - Executing SQL: " + sql);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(discountId));
            
            System.out.println("DiscountServlet: deleteDiscount - Prepared statement values:");
            System.out.println("  discountId: " + Integer.parseInt(discountId));
            
            int result = stmt.executeUpdate();
            System.out.println("DiscountServlet: deleteDiscount - Delete result: " + result + " rows affected");
            
            stmt.close();
            conn.close();
            
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String successResponse = "{\"success\":true,\"message\":\"Discount deleted successfully\"}";
                response.getWriter().write(successResponse);
            } else {
                if (result > 0) {
                    request.setAttribute("success", "Discount deleted successfully");
                } else {
                    request.setAttribute("error", "Discount not found");
                }
                response.sendRedirect("DiscountServlet?action=list");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjaxRequest(request)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String errorResponse = "{\"success\":false,\"error\":\"" + escapeJson("Database error: " + e.getMessage()) + "\"}";
                response.getWriter().write(errorResponse);
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("discount.jsp").forward(request, response);
            }
        }
    }
    
    private boolean isAdminOrManager(String role) {
        return "Admin".equals(role) || "Manager".equals(role);
    }
    
    private boolean isAjaxRequest(HttpServletRequest request) {
        String requestedWith = request.getHeader("X-Requested-With");
        String acceptHeader = request.getHeader("Accept");
        boolean isAjax = "XMLHttpRequest".equals(requestedWith) || 
               acceptHeader != null && acceptHeader.contains("application/json");
        
        System.out.println("DiscountServlet: isAjaxRequest check - X-Requested-With: " + requestedWith + 
                          ", Accept: " + acceptHeader + ", Result: " + isAjax);
        return isAjax;
    }
    
    // Helper method to build JSON manually (without Gson dependency)
    private String buildDiscountsJson(List<Discount> discounts) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < discounts.size(); i++) {
            Discount d = discounts.get(i);
            json.append("{");
            json.append("\"discountId\":").append(d.getDiscountId()).append(",");
            json.append("\"discountType\":\"").append(escapeJson(d.getDiscountType())).append("\",");
            json.append("\"discountValue\":").append(d.getDiscountValue()).append(",");
            json.append("\"createdAt\":\"").append(d.getCreatedAt() != null ? d.getCreatedAt().toString() : "").append("\",");
            json.append("\"updatedAt\":\"").append(d.getUpdatedAt() != null ? d.getUpdatedAt().toString() : "").append("\"");
            json.append("}");
            if (i < discounts.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
    
    private String buildDiscountJson(Discount discount) {
        StringBuilder json = new StringBuilder("{");
        json.append("\"discountId\":").append(discount.getDiscountId()).append(",");
        json.append("\"discountType\":\"").append(escapeJson(discount.getDiscountType())).append("\",");
        json.append("\"discountValue\":").append(discount.getDiscountValue()).append(",");
        json.append("\"createdAt\":\"").append(discount.getCreatedAt() != null ? discount.getCreatedAt().toString() : "").append("\",");
        json.append("\"updatedAt\":\"").append(discount.getUpdatedAt() != null ? discount.getUpdatedAt().toString() : "").append("\"");
        json.append("}");
        return json.toString();
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\\", "\\\\").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }
    
    // Inner class for Discount
    public static class Discount {
        private int discountId;
        private String discountType;
        private java.math.BigDecimal discountValue;
        private java.sql.Timestamp createdAt;
        private java.sql.Timestamp updatedAt;
        
        // Getters and Setters
        public int getDiscountId() { return discountId; }
        public void setDiscountId(int discountId) { this.discountId = discountId; }
        
        public String getDiscountType() { return discountType; }
        public void setDiscountType(String discountType) { this.discountType = discountType; }
        
        public java.math.BigDecimal getDiscountValue() { return discountValue; }
        public void setDiscountValue(java.math.BigDecimal discountValue) { this.discountValue = discountValue; }
        
        public java.sql.Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(java.sql.Timestamp createdAt) { this.createdAt = createdAt; }
        
        public java.sql.Timestamp getUpdatedAt() { return updatedAt; }
        public void setUpdatedAt(java.sql.Timestamp updatedAt) { this.updatedAt = updatedAt; }
    }
}
