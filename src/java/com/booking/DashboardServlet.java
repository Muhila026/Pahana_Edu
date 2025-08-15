package com.booking;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet for handling Dashboard operations
 */
public class DashboardServlet extends HttpServlet {

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/pahana_bookshop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String username = "root";
        String password = "password";
        return DriverManager.getConnection(url, username, password);
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || role == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        try {
            // Load dashboard statistics directly from database
            DashboardStats stats = getDashboardStats();
            request.setAttribute("dashboardStats", stats);
            
            // Forward to dashboard page
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error loading dashboard: " + e.getMessage());
            response.sendRedirect("dashboard.jsp?error=Error loading dashboard data.");
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
        return "Dashboard Servlet";
    }
    
    /**
     * Load real dashboard statistics from database
     */
    private DashboardStats getDashboardStats() throws SQLException {
        DashboardStats stats = new DashboardStats();
        
        try (Connection conn = getConnection()) {
            // Get total books
            String bookSql = "SELECT COUNT(*) as total FROM books";
            try (PreparedStatement pstmt = conn.prepareStatement(bookSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats.setTotalBooks(rs.getInt("total"));
                }
            }
            
            // Get total transactions
            String transactionSql = "SELECT COUNT(*) as total FROM sales";
            try (PreparedStatement pstmt = conn.prepareStatement(transactionSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats.setTotalTransactions(rs.getInt("total"));
                }
            }
            
            // Get total customers
            String customerSql = "SELECT COUNT(*) as total FROM customers";
            try (PreparedStatement pstmt = conn.prepareStatement(customerSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats.setTotalCustomers(rs.getInt("total"));
                }
            }
            
            // Get total users
            String userSql = "SELECT COUNT(*) as total FROM users";
            try (PreparedStatement pstmt = conn.prepareStatement(userSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats.setTotalUsers(rs.getInt("total"));
                }
            }
            
            // Get total revenue
            String revenueSql = "SELECT COALESCE(SUM(total_amount), 0) as total FROM sales";
            try (PreparedStatement pstmt = conn.prepareStatement(revenueSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats.setTotalRevenue(rs.getDouble("total"));
                }
            }
            
            System.out.println("Dashboard stats loaded from database:");
            System.out.println("  Total Books: " + stats.getTotalBooks());
            System.out.println("  Total Transactions: " + stats.getTotalTransactions());
            System.out.println("  Total Customers: " + stats.getTotalCustomers());
            System.out.println("  Total Users: " + stats.getTotalUsers());
            System.out.println("  Total Revenue: " + stats.getTotalRevenue());
            
        } catch (SQLException e) {
            System.err.println("Error loading dashboard stats: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        
        return stats;
    }
    
    /**
     * Inner class for dashboard statistics
     */
    public static class DashboardStats {
        private int totalBooks;
        private int totalCustomers;
        private int totalTransactions;
        private int totalUsers;
        private double totalRevenue;
        
        // Getters and Setters
        public int getTotalBooks() { return totalBooks; }
        public void setTotalBooks(int totalBooks) { this.totalBooks = totalBooks; }
        
        public int getTotalCustomers() { return totalCustomers; }
        public void setTotalCustomers(int totalCustomers) { this.totalCustomers = totalCustomers; }
        
        public int getTotalTransactions() { return totalTransactions; }
        public void setTotalTransactions(int totalTransactions) { this.totalTransactions = totalTransactions; }
        
        public int getTotalUsers() { return totalUsers; }
        public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }
        
        public double getTotalRevenue() { return totalRevenue; }
        public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
    }
} 