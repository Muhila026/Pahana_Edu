package com.pahana;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/CustomerServlet"})
public class CustomerServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin or manager
        HttpSession session = request.getSession();
        if (!isAdminOrManager(session)) {
            response.sendRedirect("welcome.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listCustomers(request, response);
                break;
            case "search":
                searchCustomers(request, response);
                break;
            case "view":
                viewCustomer(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            default:
                listCustomers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin or manager
        HttpSession session = request.getSession();
        if (!isAdminOrManager(session)) {
            response.sendRedirect("welcome.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            default:
                listCustomers(request, response);
        }
    }

    private boolean isAdminOrManager(HttpSession session) {
        if (session == null || session.getAttribute("loggedIn") == null) {
            return false;
        }
        
        Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
        if (!loggedIn) {
            return false;
        }

        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        
        return "admin".equals(userType) || "Admin".equals(role) || "Manager".equals(role);
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Customer> customers = new ArrayList<>();
        String searchTerm = request.getParameter("searchTerm");
        String statusFilter = request.getParameter("statusFilter");

        try (Connection conn = getConnection()) {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT c.customer_id, c.name, c.email, c.telephone as phone, ");
            sql.append("c.address, c.created_at, 'active' as status, 0 as total_orders ");
            sql.append("FROM customers c ");
            sql.append("WHERE 1=1 ");
            
            List<Object> params = new ArrayList<>();
            
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                sql.append("AND (c.name LIKE ? OR c.email LIKE ?) ");
                params.add("%" + searchTerm + "%");
                params.add("%" + searchTerm + "%");
            }
            
            // Note: Status filter is disabled since we don't have a status field
            // if (statusFilter != null && !statusFilter.equals("all")) {
            //     sql.append("AND c.status = ? ");
            //     params.add(statusFilter);
            // }
            
            sql.append("ORDER BY c.created_at DESC");

            try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    stmt.setObject(i + 1, params.get(i));
                }
                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Customer customer = new Customer();
                        customer.setCustomerId(rs.getInt("customer_id"));
                        customer.setName(rs.getString("name"));
                        customer.setEmail(rs.getString("email"));
                        customer.setPhone(rs.getString("phone"));
                        customer.setAddress(rs.getString("address"));
                        customer.setStatus(rs.getString("status"));
                        customer.setCreatedAt(rs.getTimestamp("created_at"));
                        customer.setTotalOrders(rs.getInt("total_orders"));
                        customers.add(customer);
                    }
                }
            }
            
            request.setAttribute("customers", customers);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("statusFilter", statusFilter);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading customers: " + e.getMessage());
        }

        request.getRequestDispatcher("customer-management.jsp").forward(request, response);
    }

    private void searchCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("searchTerm");
        List<Customer> customers = new ArrayList<>();

        try (Connection conn = getConnection()) {
            String sql = "SELECT customer_id, name, email, telephone as phone, address FROM customers " +
                        "WHERE name LIKE ? OR email LIKE ? OR telephone LIKE ? " +
                        "ORDER BY name LIMIT 10";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                String searchPattern = "%" + searchTerm + "%";
                stmt.setString(1, searchPattern);
                stmt.setString(2, searchPattern);
                stmt.setString(3, searchPattern);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Customer customer = new Customer();
                        customer.setCustomerId(rs.getInt("customer_id"));
                        customer.setName(rs.getString("name"));
                        customer.setEmail(rs.getString("email"));
                        customer.setPhone(rs.getString("phone"));
                        customer.setAddress(rs.getString("address"));
                        customers.add(customer);
                    }
                }
            }
            
        } catch (SQLException e) {
            // Log error but don't throw exception to avoid breaking POS functionality
            System.err.println("Error searching customers: " + e.getMessage());
        }

        // Return results as HTML table that can be parsed by JavaScript
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.println("<table style='display: none;'>"); // Hidden table for data extraction
        
        for (Customer customer : customers) {
            out.println("<tr data-customer-id='" + customer.getCustomerId() + "'>");
            out.println("<td class='customer-name'>" + customer.getName() + "</td>");
            out.println("<td class='customer-email'>" + (customer.getEmail() != null ? customer.getEmail() : "") + "</td>");
            out.println("<td class='customer-phone'>" + (customer.getPhone() != null ? customer.getPhone() : "") + "</td>");
            out.println("<td class='customer-address'>" + (customer.getAddress() != null ? customer.getAddress() : "") + "</td>");
            out.println("</tr>");
        }
        
        out.println("</table>");
    }

    private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        
        try (Connection conn = getConnection()) {
            // Get customer details
            String customerSql = "SELECT * FROM customers WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(customerSql)) {
                stmt.setInt(1, customerId);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        Customer customer = new Customer();
                        customer.setCustomerId(rs.getInt("customer_id"));
                        customer.setName(rs.getString("name"));
                        customer.setEmail(rs.getString("email"));
                        customer.setPhone(rs.getString("telephone"));
                        customer.setAddress(rs.getString("address"));
                        customer.setStatus("active"); // Default status since we don't have this field
                        customer.setCreatedAt(rs.getTimestamp("created_at"));
                        
                        request.setAttribute("customer", customer);
                    }
                }
            }
            
            // Note: Orders functionality is disabled since orders table doesn't exist
            // request.setAttribute("orders", new ArrayList<>());
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading customer: " + e.getMessage());
        }

        request.getRequestDispatcher("customer-view.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM customers WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, customerId);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        Customer customer = new Customer();
                        customer.setCustomerId(rs.getInt("customer_id"));
                        customer.setName(rs.getString("name"));
                        customer.setEmail(rs.getString("email"));
                        customer.setPhone(rs.getString("telephone"));
                        customer.setAddress(rs.getString("address"));
                        customer.setStatus("active"); // Default status
                        
                        request.setAttribute("customer", customer);
                    }
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading customer: " + e.getMessage());
        }

        request.getRequestDispatcher("customer-edit.jsp").forward(request, response);
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String name = firstName + " " + lastName; // Combine first and last name
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String status = request.getParameter("status");

        try (Connection conn = getConnection()) {
            // Check if email already exists
            String checkSql = "SELECT COUNT(*) FROM customers WHERE email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, email);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("error", "Email already exists");
                        request.getRequestDispatcher("customer-management.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Generate a unique account number
            String accountNumber = "ACC" + System.currentTimeMillis();
            
            String sql = "INSERT INTO customers (account_number, name, email, password_hash, address, telephone, role_id, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, accountNumber);
                stmt.setString(2, name);
                stmt.setString(3, email);
                stmt.setString(4, password != null ? password : "defaultpassword"); // Use provided password or default
                stmt.setString(5, address);
                stmt.setString(6, phone);
                stmt.setInt(7, 4); // Default role_id for customers
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("success", "Customer added successfully");
                } else {
                    request.setAttribute("error", "Failed to add customer");
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error adding customer: " + e.getMessage());
        }

        response.sendRedirect("CustomerServlet?action=list");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String name = firstName + " " + lastName; // Combine first and last name
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String status = request.getParameter("status");

        try (Connection conn = getConnection()) {
            // Check if email already exists (excluding current customer)
            String checkSql = "SELECT COUNT(*) FROM customers WHERE email = ? AND customer_id != ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, email);
                checkStmt.setInt(2, customerId);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("error", "Email already exists");
                        request.getRequestDispatcher("customer-edit.jsp").forward(request, response);
                        return;
                    }
                }
            }

            String sql = "UPDATE customers SET name = ?, email = ?, telephone = ?, address = ? WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, address);
                stmt.setInt(5, customerId);
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("success", "Customer updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update customer");
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error updating customer: " + e.getMessage());
        }

        response.sendRedirect("CustomerServlet?action=list");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        try (Connection conn = getConnection()) {
            // Note: Orders check is disabled since orders table doesn't exist
            // You can add this check back when you create the orders table

            String sql = "DELETE FROM customers WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, customerId);
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("success", "Customer deleted successfully");
                } else {
                    request.setAttribute("error", "Failed to delete customer");
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error deleting customer: " + e.getMessage());
        }

        response.sendRedirect("CustomerServlet?action=list");
    }

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found", e);
        }
    }

    // Inner classes for data transfer
    public static class Customer {
        private int customerId;
        private String name;
        private String email;
        private String phone;
        private String address;
        private String status;
        private Timestamp createdAt;
        private int totalOrders;

        // Getters and Setters
        public int getCustomerId() { return customerId; }
        public void setCustomerId(int customerId) { this.customerId = customerId; }
        
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getFullName() { return name; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        
        public Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
        
        public int getTotalOrders() { return totalOrders; }
        public void setTotalOrders(int totalOrders) { this.totalOrders = totalOrders; }
    }

    // Note: Order class removed since orders table doesn't exist
    // You can add this back when you create the orders table
} 