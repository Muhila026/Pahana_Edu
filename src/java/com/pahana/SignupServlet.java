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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
@WebServlet(urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {
    
    // Database connection settings - UPDATE THESE VALUES ACCORDING TO YOUR MYSQL SETUP
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password"; // Change this to your actual MySQL root password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        
        // Generate a unique account number for the customer
        String accountNumber = "ACC" + System.currentTimeMillis();

        // Debug logging
        System.out.println("Received parameters:");
        System.out.println("name: " + name);
        System.out.println("email: " + email);
        System.out.println("password: " + (password != null ? "***" : "null"));
        System.out.println("address: " + address);
        System.out.println("telephone: " + telephone);
        System.out.println("account_number: " + accountNumber);


        // Basic input validation
        if(name == null || email == null || password == null || address == null || telephone == null ||
           name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || 
           address.trim().isEmpty() || telephone.trim().isEmpty()){
            System.out.println("Validation failed - some fields are null or empty");
            response.sendRedirect("register.jsp?error=All fields are required!");
            return;
        }
        
        // Basic email validation
        if(!email.contains("@") || !email.contains(".")){
            response.sendRedirect("register.jsp?error=Please enter a valid email address!");
            return;
        }
        
        // Password length validation
        if(password.length() < 3){
            response.sendRedirect("register.jsp?error=Password must be at least 3 characters long!");
            return;
        }

        try{
            // Test database connection first
            System.out.println("Attempting to connect to database...");
            System.out.println("URL: " + DB_URL);
            System.out.println("User: " + DB_USER);
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection successful!");

            // First, let's check what columns actually exist in the customers table
            System.out.println("Checking table structure...");
            java.sql.DatabaseMetaData metaData = conn.getMetaData();
            java.sql.ResultSet columns = metaData.getColumns(null, null, "customers", null);
            
            System.out.println("Available columns in customers table:");
            java.util.List<String> availableColumns = new java.util.ArrayList<>();
            while (columns.next()) {
                String columnName = columns.getString("COLUMN_NAME");
                String columnType = columns.getString("TYPE_NAME");
                availableColumns.add(columnName);
                System.out.println("  - " + columnName + " (" + columnType + ")");
            }
            columns.close();
            
            // Also try a direct query to see the exact column names
            System.out.println("Double-checking with direct query...");
            try {
                java.sql.Statement checkStmt = conn.createStatement();
                java.sql.ResultSet rs = checkStmt.executeQuery("SELECT * FROM customers LIMIT 0");
                java.sql.ResultSetMetaData rsMetaData = rs.getMetaData();
                System.out.println("Columns from ResultSetMetaData:");
                for (int i = 1; i <= rsMetaData.getColumnCount(); i++) {
                    String colName = rsMetaData.getColumnName(i);
                    String colType = rsMetaData.getColumnTypeName(i);
                    System.out.println("  - " + colName + " (" + colType + ")");
                }
                rs.close();
                checkStmt.close();
            } catch (Exception e) {
                System.err.println("Error checking ResultSetMetaData: " + e.getMessage());
            }
            
            // Debug: Print all available columns for comparison
            System.out.println("All available columns (case-sensitive):");
            for (String col : availableColumns) {
                System.out.println("  '" + col + "' (length: " + col.length() + ")");
            }

            // Use a simple, direct INSERT statement based on your exact table structure
            // From your database schema, these are the exact columns that exist
            String sql = "INSERT INTO customers (account_number, name, email, password_, address, telephone, role_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accountNumber);
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.setString(4, password);
            stmt.setString(5, address);
            stmt.setString(6, telephone);
            stmt.setString(7, "4");
            
            System.out.println("Using direct INSERT SQL: " + sql);
            System.out.println("Parameters: account_number=" + accountNumber + ", name=" + name + ", email=" + email + ", password=***, address=" + address + ", telephone=" + telephone + ", role_id=4");
            
            System.out.println("Attempting INSERT with SQL: " + sql);

            try {
                System.out.println("Executing SQL: " + sql);
                int rowsInserted = stmt.executeUpdate();
                System.out.println("Rows inserted: " + rowsInserted);
                
                stmt.close();
                conn.close();

                if(rowsInserted > 0){
                    response.sendRedirect("login.jsp?message=Registration successful! You can now login with your email and password.");
                }else{
                    response.sendRedirect("register.jsp?error=Registration failed!");
                }
            } catch (java.sql.SQLException sqlEx) {
                System.err.println("SQL Error: " + sqlEx.getMessage());
                System.err.println("SQL State: " + sqlEx.getSQLState());
                System.err.println("Error Code: " + sqlEx.getErrorCode());
                
                // Provide a clear error message
                response.sendRedirect("register.jsp?error=Database error: " + sqlEx.getMessage());
            }
        }catch(ClassNotFoundException e){
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
            response.sendRedirect("register.jsp?error=Database driver error. Please contact administrator.");
        }catch(Exception e){
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error: " + e.getMessage());
        }
    }
    
    // Method to test database connection - you can call this from browser
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h2>Database Connection Test</h2>");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            out.println("<p>MySQL JDBC Driver loaded successfully</p>");
            
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            out.println("<p style='color: green;'>Database connection successful!</p>");
            out.println("<p>Connected to: " + DB_URL + "</p>");
            out.println("<p>User: " + DB_USER + "</p>");
            
            // Test a simple query
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM customers");
            if (rs.next()) {
                out.println("<p>Customers table exists and has " + rs.getInt("count") + " records</p>");
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (ClassNotFoundException e) {
            out.println("<p style='color: red;'>MySQL JDBC Driver not found: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p style='color: red;'>Database connection failed: " + e.getMessage() + "</p>");
            out.println("<p><strong>Common solutions:</strong></p>");
            out.println("<ul>");
            out.println("<li>Check if MySQL is running on localhost:3306</li>");
            out.println("<li>Verify the database 'bookshop' exists</li>");
            out.println("<li>Check if user 'root' has access to the database</li>");
            out.println("<li>Verify the password in SignupServlet.java matches your MySQL root password</li>");
            out.println("</ul>");
        }
        
        out.println("</body></html>");
    }
}
