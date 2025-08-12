/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pahana;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try {
            System.out.println("Login attempt for username: " + username);
            
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL driver loaded successfully");
            
            // Connect to database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection successful");
            
            boolean loginSuccessful = false;
            String sql = "";
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            // First, try to find user in users table (Admin/Staff/Manager)
            sql = "SELECT u.*, r.role_name FROM users u " +
                  "JOIN roles r ON u.role_id = r.role_id " +
                  "WHERE u.username = ? AND u.password_ = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Admin/Staff login successful
                loginSuccessful = true;
                System.out.println("Admin/Staff user found - Login successful");
                System.out.println("User ID: " + rs.getInt("user_id"));
                System.out.println("Role: " + rs.getString("role_name"));
                
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("loggedIn", true);
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("userType", "admin");
                session.setAttribute("role", rs.getString("role_name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("phone", rs.getString("phone"));
                
                System.out.println("Session created with attributes:");
                System.out.println("- username: " + session.getAttribute("username"));
                System.out.println("- loggedIn: " + session.getAttribute("loggedIn"));
                System.out.println("- userId: " + session.getAttribute("userId"));
                System.out.println("- userType: " + session.getAttribute("userType"));
                System.out.println("- role: " + session.getAttribute("role"));
                
                // Redirect to welcome page after successful login
                System.out.println("Redirecting to welcome.jsp");
                response.sendRedirect("welcome.jsp");
            } else {
                // If not found in users table, check in customers table
                rs.close();
                stmt.close();
                
                sql = "SELECT c.*, r.role_name FROM customers c " +
                      "JOIN roles r ON c.role_id = r.role_id " +
                      "WHERE c.email = ? AND c.password_ = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                
                rs = stmt.executeQuery();
                
                if (rs.next()) {
                    // Customer login successful
                    loginSuccessful = true;
                    System.out.println("Customer found - Login successful");
                    System.out.println("Customer ID: " + rs.getInt("customer_id"));
                    System.out.println("Customer Name: " + rs.getString("name"));
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("loggedIn", true);
                    session.setAttribute("customerId", rs.getInt("customer_id"));
                    session.setAttribute("userType", "customer");
                    session.setAttribute("role", rs.getString("role_name"));
                    session.setAttribute("customerName", rs.getString("name"));
                    session.setAttribute("accountNumber", rs.getString("account_number"));
                    session.setAttribute("email", rs.getString("email"));
                    session.setAttribute("phone", rs.getString("telephone"));
                    session.setAttribute("address", rs.getString("address"));
                    
                    System.out.println("Session created with attributes:");
                    System.out.println("- username: " + session.getAttribute("username"));
                    System.out.println("- loggedIn: " + session.getAttribute("loggedIn"));
                    System.out.println("- customerId: " + session.getAttribute("customerId"));
                    System.out.println("- userType: " + session.getAttribute("userType"));
                    System.out.println("- role: " + session.getAttribute("role"));
                    System.out.println("- customerName: " + session.getAttribute("customerName"));
                    
                    // Redirect to dashboard after successful login
                    System.out.println("Redirecting to dashboard.jsp");
                    response.sendRedirect("welcome.jsp");
                }
            }
            
            if (!loginSuccessful) {
                // Login failed - no matching user found
                System.out.println("No user found with username: " + username + " and password: " + password);
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}