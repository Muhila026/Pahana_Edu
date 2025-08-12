/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pahana;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(urlPatterns = {"/POSServlet"})
public class POSServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookshop?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password"; // Change this to your actual MySQL password

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and has appropriate role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }
        
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        
        // Only allow admin, manager, and staff
        if (!"admin".equals(userType) && !"Manager".equals(role) && !"Staff".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("getBooks".equals(action)) {
            getBooks(request, response);
        } else if ("searchBooks".equals(action)) {
            searchBooks(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and has appropriate role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }
        
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        
        // Only allow admin, manager, and staff
        if (!"admin".equals(userType) && !"Manager".equals(role) && !"Staff".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("processSale".equals(action)) {
            processSale(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void getBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT b.*, c.category_name FROM books b LEFT JOIN categories c ON b.category_id = c.category_id WHERE b.stock_quantity > 0";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"success\":true,\"books\":[");
            
            boolean first = true;
            while (rs.next()) {
                if (!first) jsonResponse.append(",");
                jsonResponse.append("{");
                jsonResponse.append("\"id\":").append(rs.getInt("book_id")).append(",");
                jsonResponse.append("\"title\":\"").append(rs.getString("title").replace("\"", "\\\"")).append("\",");
                jsonResponse.append("\"author\":\"").append(rs.getString("author") != null ? rs.getString("author").replace("\"", "\\\"") : "").append("\",");
                jsonResponse.append("\"price\":").append(rs.getBigDecimal("price")).append(",");
                jsonResponse.append("\"stock\":").append(rs.getInt("stock_quantity")).append(",");
                jsonResponse.append("\"category\":\"").append(rs.getString("category_name") != null ? rs.getString("category_name").replace("\"", "\\\"") : "").append("\"");
                jsonResponse.append("}");
                first = false;
            }
            
            jsonResponse.append("]}");
            out.print(jsonResponse.toString());
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            String errorResponse = "{\"success\":false,\"error\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}";
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print(errorResponse);
        }
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String searchTerm = request.getParameter("search");
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            getBooks(request, response);
            return;
        }
        
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT b.*, c.category_name FROM books b LEFT JOIN categories c ON b.category_id = c.category_id " +
                        "WHERE b.stock_quantity > 0 AND (b.title LIKE ? OR b.author LIKE ? OR c.category_name LIKE ?)";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            String searchPattern = "%" + searchTerm.trim() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery(sql);
            
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"success\":true,\"books\":[");
            
            boolean first = true;
            while (rs.next()) {
                if (!first) jsonResponse.append(",");
                jsonResponse.append("{");
                jsonResponse.append("\"id\":").append(rs.getInt("book_id")).append(",");
                jsonResponse.append("\"title\":\"").append(rs.getString("title").replace("\"", "\\\"")).append("\",");
                jsonResponse.append("\"author\":\"").append(rs.getString("author") != null ? rs.getString("author").replace("\"", "\\\"") : "").append("\",");
                jsonResponse.append("\"price\":").append(rs.getBigDecimal("price")).append(",");
                jsonResponse.append("\"stock\":").append(rs.getInt("stock_quantity")).append(",");
                jsonResponse.append("\"category\":\"").append(rs.getString("category_name") != null ? rs.getString("category_name").replace("\"", "\\\"") : "").append("\"");
                jsonResponse.append("}");
                first = false;
            }
            
            jsonResponse.append("]}");
            out.print(jsonResponse.toString());
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            String errorResponse = "{\"success\":false,\"error\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}";
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print(errorResponse);
        }
    }
    
    private void processSale(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            // Get sale data from request
            String saleData = request.getParameter("saleData");
            if (saleData == null || saleData.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Sale data is required");
                return;
            }
            
            // Parse JSON-like sale data (simplified parsing)
            // In a real application, you'd use a proper JSON library
            String[] items = saleData.split("\\|");
            double totalAmount = 0.0;
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false); // Start transaction
            
            try {
                // Create sale record
                String saleSql = "INSERT INTO sales (total_amount, sale_date, created_by) VALUES (?, NOW(), ?)";
                PreparedStatement saleStmt = conn.prepareStatement(saleSql, Statement.RETURN_GENERATED_KEYS);
                saleStmt.setDouble(1, totalAmount);
                saleStmt.setString(2, (String) request.getSession().getAttribute("username"));
                
                int saleRows = saleStmt.executeUpdate();
                if (saleRows == 0) {
                    throw new Exception("Failed to create sale record");
                }
                
                // Get the generated sale ID
                ResultSet generatedKeys = saleStmt.getGeneratedKeys();
                int saleId = 0;
                if (generatedKeys.next()) {
                    saleId = generatedKeys.getInt(1);
                }
                generatedKeys.close();
                
                // Process each item
                for (String item : items) {
                    if (item.trim().isEmpty()) continue;
                    
                    String[] itemParts = item.split(",");
                    if (itemParts.length >= 4) {
                        int bookId = Integer.parseInt(itemParts[0]);
                        int quantity = Integer.parseInt(itemParts[1]);
                        double unitPrice = Double.parseDouble(itemParts[2]);
                        double itemTotal = Double.parseDouble(itemParts[3]);
                        
                        totalAmount += itemTotal;
                        
                        // Insert sale item
                        String itemSql = "INSERT INTO sale_items (sale_id, book_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";
                        PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                        itemStmt.setInt(1, saleId);
                        itemStmt.setInt(2, bookId);
                        itemStmt.setInt(3, quantity);
                        itemStmt.setDouble(4, unitPrice);
                        itemStmt.setDouble(5, itemTotal);
                        itemStmt.executeUpdate();
                        itemStmt.close();
                        
                        // Update book stock
                        String updateStockSql = "UPDATE books SET stock_quantity = stock_quantity - ? WHERE book_id = ?";
                        PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSql);
                        updateStockStmt.setInt(1, quantity);
                        updateStockStmt.setInt(2, bookId);
                        updateStockStmt.executeUpdate();
                        updateStockStmt.close();
                    }
                }
                
                // Update total amount in sale record
                String updateSaleSql = "UPDATE sales SET total_amount = ? WHERE sale_id = ?";
                PreparedStatement updateSaleStmt = conn.prepareStatement(updateSaleSql);
                updateSaleStmt.setDouble(1, totalAmount);
                updateSaleStmt.setInt(2, saleId);
                updateSaleStmt.executeUpdate();
                updateSaleStmt.close();
                
                conn.commit(); // Commit transaction
                
                String successResponse = "{\"success\":true,\"saleId\":" + saleId + ",\"message\":\"Sale processed successfully\"}";
                out.print(successResponse);
                
            } catch (Exception e) {
                conn.rollback(); // Rollback transaction on error
                throw e;
            } finally {
                conn.setAutoCommit(true);
                conn.close();
            }
            
        } catch (Exception e) {
            String errorResponse = "{\"success\":false,\"error\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}";
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print(errorResponse);
        }
    }
}
