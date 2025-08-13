package com.pahana;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/DiscountServlet")
public class DiscountServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DiscountServlet.class.getName());
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            listDiscounts(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            saveDiscountUsage(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void listDiscounts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Discount> discounts = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT discount_id, discount_type, discount_value, created_at FROM discounts ORDER BY discount_type";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                while (rs.next()) {
                    Discount discount = new Discount();
                    discount.setDiscountId(rs.getInt("discount_id"));
                    discount.setDiscountType(rs.getString("discount_type"));
                    discount.setDiscountValue(rs.getBigDecimal("discount_value"));
                    discount.setCreatedAt(rs.getTimestamp("created_at"));
                    discounts.add(discount);
                }
            }
            
            request.setAttribute("discounts", discounts);
            request.getRequestDispatcher("/discounts.jsp").forward(request, response);
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing discounts", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
    
    private void saveDiscountUsage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Parse JSON request body
            // This is a simplified version - in production you'd use a JSON parser
            String customerPhone = request.getParameter("customerPhone");
            String discountType = request.getParameter("discountType");
            String discountAmount = request.getParameter("discountAmount");
            String billTotal = request.getParameter("billTotal");
            
            if (customerPhone == null || discountType == null || discountAmount == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }
            
            try (Connection conn = DatabaseConnection.getConnection()) {
                String sql = "INSERT INTO discount_usage (customer_phone, discount_type, discount_amount, bill_total, used_at) VALUES (?, ?, ?, ?, NOW())";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, customerPhone);
                    stmt.setString(2, discountType);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(discountAmount));
                    stmt.setBigDecimal(4, new java.math.BigDecimal(billTotal));
                    
                    int rowsAffected = stmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": true, \"message\": \"Discount usage saved\"}");
                    } else {
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to save discount usage");
                    }
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error saving discount usage", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Error parsing discount amount", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid discount amount");
        }
    }
    
    // Discount model class
    public static class Discount {
        private int discountId;
        private String discountType;
        private java.math.BigDecimal discountValue;
        private Timestamp createdAt;
        
        // Getters and Setters
        public int getDiscountId() { return discountId; }
        public void setDiscountId(int discountId) { this.discountId = discountId; }
        
        public String getDiscountType() { return discountType; }
        public void setDiscountType(String discountType) { this.discountType = discountType; }
        
        public java.math.BigDecimal getDiscountValue() { return discountValue; }
        public void setDiscountValue(java.math.BigDecimal discountValue) { this.discountValue = discountValue; }
        
        public Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    }
}
