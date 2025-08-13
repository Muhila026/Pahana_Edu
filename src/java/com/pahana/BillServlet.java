package com.pahana;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import org.json.JSONObject;
import org.json.JSONArray;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // Read JSON data from request
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            JSONObject billData = new JSONObject(sb.toString());
            
            // Extract bill information
            String customerName = billData.getString("customerName");
            String customerPhone = billData.getString("customerPhone");
            String customerEmail = billData.getString("customerEmail");
            String customerAddress = billData.getString("customerAddress");
            String paymentMethod = billData.getString("paymentMethod");
            String notes = billData.getString("notes");
            double subtotal = billData.getDouble("subtotal");
            double tax = billData.getDouble("tax");
            double total = billData.getDouble("total");
            
            // Get customer ID if available
            Integer customerId = null;
            if (billData.has("customerId") && !billData.isNull("customerId")) {
                customerId = billData.getInt("customerId");
            }
            
            // Get cart items
            JSONArray cartArray = billData.getJSONArray("cart");
            List<CartItem> cartItems = new ArrayList<>();
            
            for (int i = 0; i < cartArray.length(); i++) {
                JSONObject item = cartArray.getJSONObject(i);
                CartItem cartItem = new CartItem();
                cartItem.name = item.getString("name");
                cartItem.price = item.getDouble("price");
                cartItem.quantity = item.getInt("quantity");
                cartItem.bookId = item.getInt("bookId");
                cartItems.add(cartItem);
            }
            
            // Get current user from session
            HttpSession session = request.getSession();
            String createdBy = "staff"; // default
            if (session != null && session.getAttribute("username") != null) {
                createdBy = (String) session.getAttribute("username");
            }
            
            // Process the bill
            String billNumber = processBill(customerId, customerName, customerPhone, customerEmail, customerAddress,
                                         paymentMethod, notes, subtotal, tax, total, cartItems, createdBy);
            
            if (billNumber != null) {
                jsonResponse.put("success", true);
                jsonResponse.put("billNumber", billNumber);
                jsonResponse.put("total", total);
                jsonResponse.put("message", "Bill generated successfully");
                jsonResponse.put("billUrl", "bill-viewer.jsp?number=" + billNumber);
                
                // Update book stock quantities
                updateBookStock(cartItems);
                
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to generate bill");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error processing bill: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    private String processBill(Integer customerId, String customerName, String customerPhone, String customerEmail, 
                             String customerAddress, String paymentMethod, String notes, 
                             double subtotal, double tax, double total, List<CartItem> cartItems, 
                             String createdBy) {
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Get database connection
            conn = getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // 1. Insert into sales table
            String salesSql = "INSERT INTO sales (customer_id, total_amount, created_by, payment_method, status) VALUES (?, ?, ?, ?, 'Completed')";
            pstmt = conn.prepareStatement(salesSql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setObject(1, customerId); // customerId can be null for walk-in customers
            pstmt.setDouble(2, total);
            pstmt.setString(3, createdBy);
            pstmt.setString(4, paymentMethod);
            pstmt.executeUpdate();
            
            // Get the generated sale_id
            rs = pstmt.getGeneratedKeys();
            int saleId = 0;
            if (rs.next()) {
                saleId = rs.getInt(1);
            }
            
            if (saleId == 0) {
                throw new Exception("Failed to get sale ID");
            }
            
            // 2. Insert sale items
            String saleItemsSql = "INSERT INTO sale_items (sale_id, book_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(saleItemsSql);
            
            for (CartItem item : cartItems) {
                pstmt.setInt(1, saleId);
                pstmt.setInt(2, item.bookId);
                pstmt.setInt(3, item.quantity);
                pstmt.setDouble(4, item.price);
                pstmt.setDouble(5, item.price * item.quantity);
                pstmt.executeUpdate();
            }
            
            // 3. Generate bill number
            String billNumber = generateBillNumber(conn);
            
            // 4. Insert into bills table
            String billsSql = "INSERT INTO bills (bill_number, sale_id, customer_id, customer_name, customer_email, customer_phone, customer_address, subtotal, tax_amount, total_amount, payment_method, created_by, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(billsSql);
            pstmt.setString(1, billNumber);
            pstmt.setInt(2, saleId);
            pstmt.setInt(3, customerId); // Use customerId if available
            pstmt.setString(4, customerName);
            pstmt.setString(5, customerEmail);
            pstmt.setString(6, customerPhone);
            pstmt.setString(7, customerAddress);
            pstmt.setDouble(8, subtotal);
            pstmt.setDouble(9, tax);
            pstmt.setDouble(10, total);
            pstmt.setString(11, paymentMethod);
            pstmt.setString(12, createdBy);
            pstmt.setString(13, notes);
            pstmt.executeUpdate();
            
            // 5. Insert bill items
            String billItemsSql = "INSERT INTO bill_items (bill_id, book_id, book_title, book_author, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(billItemsSql);
            
            // Get bill_id
            String getBillIdSql = "SELECT bill_id FROM bills WHERE bill_number = ?";
            pstmt = conn.prepareStatement(getBillIdSql);
            pstmt.setString(1, billNumber);
            rs = pstmt.executeQuery();
            
            int billId = 0;
            if (rs.next()) {
                billId = rs.getInt(1);
            }
            
            // Get book details for bill items
            String bookDetailsSql = "SELECT title, author FROM books WHERE book_id = ?";
            PreparedStatement bookStmt = conn.prepareStatement(bookDetailsSql);
            
            pstmt = conn.prepareStatement(billItemsSql);
            for (CartItem item : cartItems) {
                // Get book details
                bookStmt.setInt(1, item.bookId);
                ResultSet bookRs = bookStmt.executeQuery();
                String bookTitle = "";
                String bookAuthor = "";
                if (bookRs.next()) {
                    bookTitle = bookRs.getString("title");
                    bookAuthor = bookRs.getString("author");
                }
                
                pstmt.setInt(1, billId);
                pstmt.setInt(2, item.bookId);
                pstmt.setString(3, bookTitle);
                pstmt.setString(4, bookAuthor);
                pstmt.setInt(5, item.quantity);
                pstmt.setDouble(6, item.price);
                pstmt.setDouble(7, item.price * item.quantity);
                pstmt.executeUpdate();
            }
            
            // Commit transaction
            conn.commit();
            
            return billNumber;
            
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private String generateBillNumber(Connection conn) throws SQLException {
        // Get current year
        Calendar cal = Calendar.getInstance();
        int currentYear = cal.get(Calendar.YEAR);
        
        // Get next sequence for this year
        String sequenceSql = "INSERT INTO bill_sequence (year, sequence) VALUES (?, 1) ON DUPLICATE KEY UPDATE sequence = sequence + 1";
        PreparedStatement pstmt = conn.prepareStatement(sequenceSql);
        pstmt.setInt(1, currentYear);
        pstmt.executeUpdate();
        
        // Get the sequence number
        String getSequenceSql = "SELECT sequence FROM bill_sequence WHERE year = ?";
        pstmt = conn.prepareStatement(getSequenceSql);
        pstmt.setInt(1, currentYear);
        ResultSet rs = pstmt.executeQuery();
        
        int sequence = 1;
        if (rs.next()) {
            sequence = rs.getInt(1);
        }
        
        // Format: BILL-YYYY-XXX (e.g., BILL-2024-001)
        return String.format("BILL-%d-%03d", currentYear, sequence);
    }
    
    private void updateBookStock(List<CartItem> cartItems) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            String updateStockSql = "UPDATE books SET stock_quantity = stock_quantity - ? WHERE book_id = ?";
            pstmt = conn.prepareStatement(updateStockSql);
            
            for (CartItem item : cartItems) {
                pstmt.setInt(1, item.quantity);
                pstmt.setInt(2, item.bookId);
                pstmt.executeUpdate();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private Connection getConnection() throws SQLException {
        // You may need to adjust these connection details based on your setup
        String url = "jdbc:mysql://localhost:3306/bookshop_pos";
        String username = "root";
        String password = "";
        
        return DriverManager.getConnection(url, username, password);
    }
    
    // Inner class to represent cart items
    private static class CartItem {
        String name;
        double price;
        int quantity;
        int bookId;
    }
}
