package com.pahana;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet(urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        if (!isAdmin(session)) {
            response.sendRedirect("welcome.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "view":
                viewUser(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        if (!isAdmin(session)) {
            response.sendRedirect("welcome.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
            default:
                listUsers(request, response);
        }
    }

    private boolean isAdmin(HttpSession session) {
        if (session == null || session.getAttribute("loggedIn") == null) {
            return false;
        }
        
        Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
        if (!loggedIn) {
            return false;
        }

        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        
        return "admin".equals(userType) || "Admin".equals(role);
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<User> users = new ArrayList<>();
        String searchTerm = request.getParameter("searchTerm");
        String roleFilter = request.getParameter("roleFilter");

        try (Connection conn = getConnection()) {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT u.user_id, u.username, u.email, u.phone, u.created_at, r.role_name ");
            sql.append("FROM users u ");
            sql.append("LEFT JOIN roles r ON u.role_id = r.role_id ");
            sql.append("WHERE 1=1 ");
            
            List<Object> params = new ArrayList<>();
            
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                sql.append("AND (u.username LIKE ? OR u.email LIKE ?) ");
                params.add("%" + searchTerm + "%");
                params.add("%" + searchTerm + "%");
            }
            
            if (roleFilter != null && !roleFilter.equals("all")) {
                sql.append("AND r.role_name = ? ");
                params.add(roleFilter);
            }
            
            sql.append("ORDER BY u.created_at DESC");

            try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    stmt.setObject(i + 1, params.get(i));
                }
                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        User user = new User();
                        user.setUserId(rs.getInt("user_id"));
                        user.setUsername(rs.getString("username"));
                        user.setEmail(rs.getString("email"));
                        user.setPhone(rs.getString("phone"));
                        user.setRoleName(rs.getString("role_name"));
                        user.setCreatedAt(rs.getTimestamp("created_at"));
                        users.add(user);
                    }
                }
            }

            // Get roles for filter dropdown
            List<Role> roles = getRoles(conn);
            
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("roleFilter", roleFilter);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading users: " + e.getMessage());
        }

        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        try (Connection conn = getConnection()) {
            String sql = "SELECT u.user_id, u.username, u.email, u.phone, u.created_at, r.role_name " +
                        "FROM users u " +
                        "LEFT JOIN roles r ON u.role_id = r.role_id " +
                        "WHERE u.user_id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        User user = new User();
                        user.setUserId(rs.getInt("user_id"));
                        user.setUsername(rs.getString("username"));
                        user.setEmail(rs.getString("email"));
                        user.setPhone(rs.getString("phone"));
                        user.setRoleName(rs.getString("role_name"));
                        user.setCreatedAt(rs.getTimestamp("created_at"));
                        
                        request.setAttribute("user", user);
                    }
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading user: " + e.getMessage());
        }

        request.getRequestDispatcher("user-view.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        try (Connection conn = getConnection()) {
            // Get user details
            String userSql = "SELECT u.user_id, u.username, u.email, u.phone, u.role_id, r.role_name " +
                           "FROM users u " +
                           "LEFT JOIN roles r ON u.role_id = r.role_id " +
                           "WHERE u.user_id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(userSql)) {
                stmt.setInt(1, userId);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        User user = new User();
                        user.setUserId(rs.getInt("user_id"));
                        user.setUsername(rs.getString("username"));
                        user.setEmail(rs.getString("email"));
                        user.setPhone(rs.getString("phone"));
                        user.setRoleId(rs.getInt("role_id"));
                        user.setRoleName(rs.getString("role_name"));
                        
                        request.setAttribute("user", user);
                    }
                }
            }
            
            // Get roles for dropdown
            List<Role> roles = getRoles(conn);
            request.setAttribute("roles", roles);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading user: " + e.getMessage());
        }

        request.getRequestDispatcher("user-edit.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("roleId"));

        try (Connection conn = getConnection()) {
            // Check if username or email already exists
            String checkSql = "SELECT COUNT(*) FROM users WHERE username = ? OR email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("error", "Username or email already exists");
                        request.getRequestDispatcher("user-management.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // For now, store password as plain text to match LoginServlet
            // In production, you should use proper password hashing
            String sql = "INSERT INTO users (username, email, password_hash, role_id, phone, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setString(3, password); // Store as plain text to match LoginServlet
                stmt.setInt(4, roleId);
                stmt.setString(5, phone != null ? phone : ""); // Use provided phone or empty string
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("success", "User added successfully");
                } else {
                    request.setAttribute("error", "Failed to add user");
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error adding user: " + e.getMessage());
        }

        response.sendRedirect("UserServlet?action=list");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String password = request.getParameter("password");

        try (Connection conn = getConnection()) {
            // Check if username or email already exists (excluding current user)
            String checkSql = "SELECT COUNT(*) FROM users WHERE (username = ? OR email = ?) AND user_id != ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);
                checkStmt.setInt(3, userId);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("error", "Username or email already exists");
                        request.getRequestDispatcher("user-edit.jsp").forward(request, response);
                        return;
                    }
                }
            }

            StringBuilder sql = new StringBuilder();
            sql.append("UPDATE users SET username = ?, email = ?, phone = ?, role_id = ? ");
            
            List<Object> params = new ArrayList<>();
            params.add(username);
            params.add(email);
            params.add(phone != null ? phone : "");
            params.add(roleId);
            
            // Update password only if provided
            if (password != null && !password.trim().isEmpty()) {
                sql.append(", password_hash = ? ");
                params.add(password); // Store as plain text to match LoginServlet
            }
            
            sql.append("WHERE user_id = ?");
            params.add(userId);

            try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    stmt.setObject(i + 1, params.get(i));
                }
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("success", "User updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update user");
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error updating user: " + e.getMessage());
        }

        response.sendRedirect("UserServlet?action=list");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        // Prevent admin from deleting themselves
        HttpSession session = request.getSession();
        Integer currentUserId = (Integer) session.getAttribute("userId");
        if (currentUserId != null && currentUserId == userId) {
            request.setAttribute("error", "You cannot delete your own account");
            response.sendRedirect("UserServlet?action=list");
            return;
        }

        try (Connection conn = getConnection()) {
            String sql = "DELETE FROM users WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("success", "User deleted successfully");
                } else {
                    request.setAttribute("error", "Failed to delete user");
                }
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error deleting user: " + e.getMessage());
        }

        response.sendRedirect("UserServlet?action=list");
    }

    private List<Role> getRoles(Connection conn) throws SQLException {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT role_id, role_name FROM roles ORDER BY role_name";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Role role = new Role();
                role.setRoleId(rs.getInt("role_id"));
                role.setRoleName(rs.getString("role_name"));
                roles.add(role);
            }
        }
        
        return roles;
    }

    // Note: Password hashing is not implemented in this version
    // In production, you should use BCrypt or similar for password hashing

    private Connection getConnection() throws SQLException {
        // Use the same connection method as other servlets
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found", e);
        }
    }

    // Inner classes for data transfer
    public static class User {
        private int userId;
        private String username;
        private String email;
        private String phone;
        private int roleId;
        private String roleName;
        private Timestamp createdAt;

        // Getters and Setters
        public int getUserId() { return userId; }
        public void setUserId(int userId) { this.userId = userId; }
        
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        
        public int getRoleId() { return roleId; }
        public void setRoleId(int roleId) { this.roleId = roleId; }
        
        public String getRoleName() { return roleName; }
        public void setRoleName(String roleName) { this.roleName = roleName; }
        
        public Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    }

    public static class Role {
        private int roleId;
        private String roleName;

        // Getters and Setters
        public int getRoleId() { return roleId; }
        public void setRoleId(int roleId) { this.roleId = roleId; }
        
        public String getRoleName() { return roleName; }
        public void setRoleName(String roleName) { this.roleName = roleName; }
    }
} 