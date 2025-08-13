<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Viewer - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --text-color: #1e293b;
            --light-color: #f8fafc;
            --border-color: #e2e8f0;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background: #f8fafc;
            padding: 2rem;
        }

        .bill-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .bill-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .bill-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .bill-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .bill-content {
            padding: 2rem;
        }

        .bill-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid var(--border-color);
        }

        .bill-details h3, .customer-details h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding: 0.5rem 0;
        }

        .info-row:not(:last-child) {
            border-bottom: 1px solid #f1f5f9;
        }

        .info-label {
            font-weight: 600;
            color: #64748b;
        }

        .info-value {
            color: var(--text-color);
        }

        .bill-items {
            margin-bottom: 2rem;
        }

        .bill-items h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .item-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1rem;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .item-table th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .item-table td {
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .item-table tr:hover {
            background: #f8fafc;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.2s ease;
        }

        .item-table tr:last-child td {
            border-bottom: none;
        }

        .book-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .book-title {
            font-weight: 600;
            color: var(--text-color);
            font-size: 1rem;
        }

        .book-author {
            font-size: 0.85rem;
            color: #64748b;
            font-style: italic;
        }

        .price-cell, .quantity-cell, .total-cell {
            text-align: center;
            font-weight: 500;
        }

        .price-cell {
            color: #059669;
        }

        .total-cell {
            color: var(--primary-color);
            font-weight: 600;
        }

        .quantity-cell {
            color: #475569;
        }

        .quantity-display {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #f1f5f9;
            border-radius: 6px;
            padding: 0.5rem 0.75rem;
            min-width: 50px;
        }

        .quantity-number {
            font-weight: 600;
            color: #475569;
        }

        .action-cell {
            text-align: center;
        }

        .remove-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .remove-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            background: linear-gradient(135deg, #dc2626, #b91c1c);
        }

        .remove-btn:active {
            transform: translateY(0);
        }

        .table-summary {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-top: 2px solid var(--primary-color);
        }

        .table-summary td {
            padding: 1.5rem 1rem;
            font-size: 1.1rem;
        }

        /* Responsive table adjustments */
        @media (max-width: 768px) {
            .item-table {
                font-size: 0.85rem;
            }
            
            .item-table th,
            .item-table td {
                padding: 0.75rem 0.5rem;
            }
            
            .book-title {
                font-size: 0.9rem;
            }
            
            .book-author {
                font-size: 0.8rem;
            }
            
            .quantity-display {
                padding: 0.4rem 0.6rem;
                min-width: 40px;
            }
            
            .remove-btn {
                width: 32px;
                height: 32px;
            }
            
            .table-summary td {
                padding: 1rem 0.5rem;
                font-size: 1rem;
            }
        }

        @media (max-width: 600px) {
            .item-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .item-table th,
            .item-table td {
                min-width: 120px;
            }
            
            .book-info {
                min-width: 150px;
            }
        }

        .bill-summary {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding: 0.5rem 0;
        }

        .summary-row.total {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-color);
            border-top: 2px solid var(--border-color);
            padding-top: 1rem;
            margin-top: 1rem;
        }

        .bill-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            padding-top: 2rem;
            border-top: 2px solid var(--border-color);
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #4f46e5;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #64748b;
            color: white;
        }

        .btn-secondary:hover {
            background: #475569;
            transform: translateY(-2px);
        }

        .print-only {
            display: none;
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }
            
            .bill-container {
                box-shadow: none;
                border-radius: 0;
            }
            
            .bill-actions {
                display: none;
            }
            
            .print-only {
                display: block;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .bill-info {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .bill-actions {
                flex-direction: column;
            }
            
            .item-table {
                font-size: 0.9rem;
            }
            
            .item-table th,
            .item-table td {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <%
    // Get bill ID from request parameter
    String billId = request.getParameter("id");
    String billNumber = request.getParameter("number");
    
    if (billId == null && billNumber == null) {
        out.println("<div style='text-align: center; padding: 4rem;'>");
        out.println("<h1>Bill Not Found</h1>");
        out.println("<p>No bill ID or number provided.</p>");
        out.println("<a href='pos.jsp' style='color: #6366f1;'>Return to POS</a>");
        out.println("</div>");
        return;
    }
    
    // Database connection and bill retrieval
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // Database connection (adjust these values as needed)
        String url = "jdbc:mysql://localhost:3306/bookshop_pos";
        String username = "root";
        String password = "";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        
        // Get bill information
        String billSql = "";
        if (billId != null) {
            billSql = "SELECT * FROM bills WHERE bill_id = ?";
            pstmt = conn.prepareStatement(billSql);
            pstmt.setInt(1, Integer.parseInt(billId));
        } else {
            billSql = "SELECT * FROM bills WHERE bill_number = ?";
            pstmt = conn.prepareStatement(billSql);
            pstmt.setString(1, billNumber);
        }
        
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            // Bill found, display it
            String customerName = rs.getString("customer_name");
            String customerEmail = rs.getString("customer_email");
            String customerPhone = rs.getString("customer_phone");
            String customerAddress = rs.getString("customer_address");
            double subtotal = rs.getDouble("subtotal");
            double taxAmount = rs.getDouble("tax_amount");
            double totalAmount = rs.getDouble("total_amount");
            String paymentMethod = rs.getString("payment_method");
            String notes = rs.getString("notes");
            Date billDate = rs.getDate("bill_date");
            String createdBy = rs.getString("created_by");
            
            // Get bill items
            String itemsSql = "SELECT * FROM bill_items WHERE bill_id = ?";
            pstmt = conn.prepareStatement(itemsSql);
            pstmt.setInt(1, rs.getInt("bill_id"));
            ResultSet itemsRs = pstmt.executeQuery();
    %>
    
    <div class="bill-container">
        <div class="bill-header">
            <h1><i class="fas fa-receipt"></i> INVOICE</h1>
            <p><%= rs.getString("bill_number") %></p>
        </div>
        
        <div class="bill-content">
            <div class="bill-info">
                <div class="bill-details">
                    <h3><i class="fas fa-info-circle"></i> Bill Details</h3>
                    <div class="info-row">
                        <span class="info-label">Bill Number:</span>
                        <span class="info-value"><%= rs.getString("bill_number") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Date:</span>
                        <span class="info-value"><%= billDate != null ? billDate.toString() : "N/A" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Payment Method:</span>
                        <span class="info-value"><%= paymentMethod %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Processed By:</span>
                        <span class="info-value"><%= createdBy %></span>
                    </div>
                </div>
                
                <div class="customer-details">
                    <h3><i class="fas fa-user"></i> Customer Information</h3>
                    <div class="info-row">
                        <span class="info-label">Name:</span>
                        <span class="info-value"><%= customerName != null ? customerName : "Walk-in Customer" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Phone:</span>
                        <span class="info-value"><%= customerPhone != null ? customerPhone : "N/A" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-value"><%= customerEmail != null ? customerEmail : "N/A" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Address:</span>
                        <span class="info-value"><%= customerAddress != null ? customerAddress : "N/A" %></span>
                    </div>
                </div>
            </div>
            
            <div class="bill-items">
                <h3><i class="fas fa-list"></i> Items Purchased</h3>
                <table class="item-table">
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        double calculatedSubtotal = 0;
                        while (itemsRs.next()) {
                            String bookTitle = itemsRs.getString("book_title");
                            String bookAuthor = itemsRs.getString("book_author");
                            int quantity = itemsRs.getInt("quantity");
                            double unitPrice = itemsRs.getDouble("unit_price");
                            double totalPrice = itemsRs.getDouble("total_price");
                            calculatedSubtotal += totalPrice;
                        %>
                        <tr>
                            <td>
                                <div class="book-info">
                                    <div class="book-title"><%= bookTitle != null ? bookTitle : "Unknown Book" %></div>
                                    <div class="book-author"><%= bookAuthor != null ? bookAuthor : "Unknown Author" %></div>
                                </div>
                            </td>
                            <td class="price-cell">$<%= String.format("%.2f", unitPrice) %></td>
                            <td class="quantity-cell">
                                <div class="quantity-display">
                                    <span class="quantity-number"><%= quantity %></span>
                                </div>
                            </td>
                            <td class="total-cell">$<%= String.format("%.2f", totalPrice) %></td>
                            <td class="action-cell">
                                <button class="remove-btn" onclick="removeItem(<%= itemsRs.getInt("bill_item_id") %>, '<%= bookTitle != null ? bookTitle.replace("'", "\\'") : "Unknown Book" %>')" title="Remove Item">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                    <tfoot>
                        <tr class="table-summary">
                            <td colspan="3" style="text-align: right; font-weight: 600; color: #475569;">
                                <strong>Total Items:</strong> <%= itemsRs.getRow() %>
                            </td>
                            <td colspan="2" style="text-align: center; font-weight: 600; color: var(--primary-color);">
                                <strong>Subtotal: $<%= String.format("%.2f", calculatedSubtotal) %></strong>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            
            <div class="bill-summary">
                <h3><i class="fas fa-calculator"></i> Summary</h3>
                <div class="summary-row">
                    <span>Subtotal:</span>
                    <span>$<%= String.format("%.2f", subtotal) %></span>
                </div>
                <div class="summary-row">
                    <span>Tax (8%):</span>
                    <span>$<%= String.format("%.2f", taxAmount) %></span>
                </div>
                <div class="summary-row total">
                    <span>Total Amount:</span>
                    <span>$<%= String.format("%.2f", totalAmount) %></span>
                </div>
            </div>
            
            <% if (notes != null && !notes.trim().isEmpty()) { %>
            <div style="margin-bottom: 2rem; padding: 1rem; background: #fef3c7; border-radius: 8px; border-left: 4px solid #f59e0b;">
                <h4 style="color: #92400e; margin-bottom: 0.5rem;"><i class="fas fa-sticky-note"></i> Notes:</h4>
                <p style="color: #92400e;"><%= notes %></p>
            </div>
            <% } %>
            
            <div class="bill-actions">
                <button class="btn btn-primary" onclick="window.print()">
                    <i class="fas fa-print"></i> Print Bill
                </button>
                <a href="pos.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to POS
                </button>
            </div>
        </div>
    </div>
    
    <%
        } else {
            // Bill not found
            out.println("<div style='text-align: center; padding: 4rem;'>");
            out.println("<h1>Bill Not Found</h1>");
            out.println("<p>The requested bill could not be found in the database.</p>");
            out.println("<a href='pos.jsp' style='color: #6366f1;'>Return to POS</a>");
            out.println("</div>");
        }
        
    } catch (Exception e) {
        out.println("<div style='text-align: center; padding: 4rem;'>");
        out.println("<h1>Error</h1>");
        out.println("<p>An error occurred while retrieving the bill: " + e.getMessage() + "</p>");
        out.println("<a href='pos.jsp' style='color: #6366f1;'>Return to POS</a>");
        out.println("</div>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
    
    <script>
        // Auto-print functionality (optional)
        function autoPrint() {
            if (window.location.search.includes('autoprint=true')) {
                window.print();
            }
        }
        
        // Auto-print when page loads if requested
        window.addEventListener('load', autoPrint);

        // Function to remove an item from the bill
        function removeItem(billItemId, bookTitle) {
            if (confirm('Are you sure you want to remove "' + bookTitle + '" from the bill?')) {
                fetch('remove_item.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'bill_item_id=' + billItemId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Item removed successfully!');
                        // Reload the page to update the table
                        window.location.reload();
                    } else {
                        alert('Error removing item: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('Error removing item: ' + error);
                });
            }
        }
    </script>
</body>
</html>
