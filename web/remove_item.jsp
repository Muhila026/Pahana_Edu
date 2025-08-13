<%@ page contentType="application/json" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

String billItemId = request.getParameter("bill_item_id");

if (billItemId == null || billItemId.trim().isEmpty()) {
    out.print("{\"success\": false, \"message\": \"Bill item ID is required\"}");
    return;
}

Connection conn = null;
PreparedStatement pstmt = null;

try {
    // Database connection (adjust these values as needed)
    String url = "jdbc:mysql://localhost:3306/bookshop_pos";
    String username = "root";
    String password = "";
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);
    
    // Get bill item details before deletion
    String getItemSql = "SELECT bi.*, b.bill_id, b.total_amount FROM bill_items bi " +
                        "JOIN bills b ON bi.bill_id = b.bill_id " +
                        "WHERE bi.bill_item_id = ?";
    pstmt = conn.prepareStatement(getItemSql);
    pstmt.setInt(1, Integer.parseInt(billItemId));
    ResultSet rs = pstmt.executeQuery();
    
    if (rs.next()) {
        int billId = rs.getInt("bill_id");
        double itemTotal = rs.getDouble("total_price");
        double currentBillTotal = rs.getDouble("total_amount");
        
        // Start transaction
        conn.setAutoCommit(false);
        
        // Delete the bill item
        String deleteItemSql = "DELETE FROM bill_items WHERE bill_item_id = ?";
        pstmt = conn.prepareStatement(deleteItemSql);
        pstmt.setInt(1, Integer.parseInt(billItemId));
        int deletedRows = pstmt.executeUpdate();
        
        if (deletedRows > 0) {
            // Update bill total
            double newTotal = currentBillTotal - itemTotal;
            double newSubtotal = newTotal / 1.08; // Assuming 8% tax
            double newTax = newTotal - newSubtotal;
            
            String updateBillSql = "UPDATE bills SET total_amount = ?, subtotal = ?, tax_amount = ? WHERE bill_id = ?";
            pstmt = conn.prepareStatement(updateBillSql);
            pstmt.setDouble(1, newTotal);
            pstmt.setDouble(2, newSubtotal);
            pstmt.setDouble(3, newTax);
            pstmt.setInt(4, billId);
            pstmt.executeUpdate();
            
            // Commit transaction
            conn.commit();
            
            out.print("{\"success\": true, \"message\": \"Item removed successfully\", \"newTotal\": " + newTotal + "}");
        } else {
            out.print("{\"success\": false, \"message\": \"Failed to delete item\"}");
        }
    } else {
        out.print("{\"success\": false, \"message\": \"Bill item not found\"}");
    }
    
} catch (Exception e) {
    try {
        if (conn != null) {
            conn.rollback();
        }
    } catch (SQLException se) {
        se.printStackTrace();
    }
    
    out.print("{\"success\": false, \"message\": \"Error: " + e.getMessage().replace("\"", "\\\"") + "\"}");
    e.printStackTrace();
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) {
            conn.setAutoCommit(true);
            conn.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
