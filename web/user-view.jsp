<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View User - BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #724784 0%, #ac87cd 100%);
            min-height: 100vh;
        }

        /* ===== ADMIN NAVIGATION (Sidebar Only) ===== */
        .admin-layout {
            display: flex;
            min-height: 100vh;
        }

        .admin-sidebar {
            width: 320px;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 1rem 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 999;
            scrollbar-width: thin;
            scrollbar-color: #3498db #2c3e50;
        }

        .admin-sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .admin-sidebar::-webkit-scrollbar-track {
            background: #2c3e50;
        }

        .admin-sidebar::-webkit-scrollbar-thumb {
            background: #3498db;
            border-radius: 3px;
        }

        .admin-sidebar::-webkit-scrollbar-thumb:hover {
            background: #2980b9;
        }

        .admin-sidebar-header {
            padding: 0 1.5rem 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .admin-sidebar-header h2 {
            color: #3498db;
            margin-bottom: 0.5rem;
        }

        .admin-sidebar-menu {
            list-style: none;
            padding: 0 1.5rem;
        }

        .admin-sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .admin-sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: white;
            text-decoration: none;
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            transition: all 0.3s;
            font-weight: 500;
            font-size: 0.95rem;
            border-left: 3px solid transparent;
        }

        .admin-sidebar-menu a:hover {
            background: rgba(255,255,255,0.1);
            color: #3498db;
            transform: translateX(5px);
            border-left-color: #3498db;
        }

        .admin-sidebar-menu a.active {
            background: rgba(52, 152, 219, 0.2);
            color: #3498db;
            border-left-color: #3498db;
        }

        .admin-sidebar-menu i {
            width: 20px;
            text-align: center;
            font-size: 1rem;
        }

        .admin-main-content {
            flex: 1;
            margin-left: 320px;
        }

        /* ===== COMMON STYLES ===== */
        .main-content {
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            text-align: center;
        }

        .page-header h1 {
            color: #724784;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #666;
        }

        /* User Details Styles */
        .user-details-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .user-info {
            display: grid;
            gap: 1.5rem;
        }

        .info-group {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-weight: 600;
            color: #724784;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            padding: 0.8rem;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #ac87cd;
            font-size: 1rem;
        }

        .user-role {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            text-align: center;
        }

        .user-role.admin {
            background: #ff6b6b;
            color: white;
        }

        .user-role.manager {
            background: #ffaf24;
            color: white;
        }

        .user-role.staff {
            background: #51cf66;
            color: white;
        }

        .user-role.default {
            background: #ffe2b8;
            color: #724784;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e9ecef;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .btn-back {
            background: #6c757d;
            color: white;
        }

        .btn-edit {
            background: linear-gradient(135deg, #ffaf24, #ff7f42);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b, #ff4757);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        /* Messages */
        .message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .message.error {
            background: #ff6b6b;
            color: white;
        }

        .message.success {
            background: #51cf66;
            color: white;
        }

        /* Footer */
        .footer {
            background: #724784;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 4rem;
        }

        .footer p {
            margin: 0;
            opacity: 0.8;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .admin-sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            
            .admin-sidebar.open {
                transform: translateX(0);
            }
            
            .admin-main-content {
                margin-left: 0;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <%
    // Determine user type and role for navigation
    String userType = null;
    String role = null;
    String username = null;
    boolean isLoggedIn = false;
    
    if (session != null && session.getAttribute("loggedIn") != null) {
        isLoggedIn = (Boolean) session.getAttribute("loggedIn");
        if (isLoggedIn) {
            userType = (String) session.getAttribute("userType");
            role = (String) session.getAttribute("role");
            username = (String) session.getAttribute("username");
        }
    }
    
    // Check if user is admin
    boolean isAdmin = "admin".equals(userType) || "Admin".equals(role);
    if (!isAdmin) {
        response.sendRedirect("welcome.jsp");
        return;
    }
    
    // Determine navigation type for sidebar
    String navType = "admin";
    if ("Manager".equals(role)) {
        navType = "manager";
    } else if ("Staff".equals(role)) {
        navType = "staff";
    }
    %>

    <!-- ADMIN NAVIGATION (Sidebar Only) -->
    <div class="admin-layout">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="admin-sidebar-header">
                <h2><%= "admin".equals(navType) ? "Admin" : "Manager" %> Panel</h2>
                <p>Welcome, <%= username %></p>
            </div>
            <%
            // Different sidebar menus for each role
            if ("admin".equals(navType)) {
            %>
            <!-- ADMIN SIDEBAR MENU -->
            <ul class="admin-sidebar-menu">
                <!-- Main Navigation -->
                <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                
                <!-- Inventory Management -->
                <li class="menu-divider"><span>Inventory</span></li>
                <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Inventory Management</a></li>
                <li><a href="CategoryServlet?action=list"><i class="fas fa-tags"></i> Categories</a></li>
                
                <!-- Sales & Orders -->
                <li class="menu-divider"><span>Sales & Orders</span></li>
                <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Order Management</a></li>
                <li><a href="transactions.jsp"><i class="fas fa-receipt"></i> Transaction History</a></li>
                
                <!-- Management -->
                <li class="menu-divider"><span>Management</span></li>
                <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Customer Management</a></li>
                <li><a href="UserServlet?action=list" class="active"><i class="fas fa-users"></i> User Management</a></li>
                
                <!-- User -->
                <li class="menu-divider"><span>User</span></li>
                <li><a href="user-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
            <%
            } else if ("manager".equals(navType)) {
            %>
            <!-- MANAGER SIDEBAR MENU -->
            <ul class="admin-sidebar-menu">
                <!-- Main Navigation -->
                <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                
                <!-- Inventory Management -->
                <li class="menu-divider"><span>Inventory</span></li>
                <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Inventory Management</a></li>
                <li><a href="CategoryServlet?action=list"><i class="fas fa-tags"></i> Categories</a></li>
                
                <!-- Sales & Orders -->
                <li class="menu-divider"><span>Sales & Orders</span></li>
                <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Order Management</a></li>
                <li><a href="transactions.jsp"><i class="fas fa-receipt"></i> Transaction History</a></li>
                
                <!-- Management -->
                <li class="menu-divider"><span>Management</span></li>
                <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Customer Management</a></li>
                <li><a href="UserServlet?action=list" class="active"><i class="fas fa-users"></i> User Management</a></li>
                
                <!-- User -->
                <li class="menu-divider"><span>User</span></li>
                <li><a href="user-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
            <%
            }
            %>
        </aside>

        <!-- Main Content -->
        <main class="admin-main-content">
            <div class="main-content">
                <div class="page-header">
                    <h1>User Details</h1>
                    <p>View user information and account details</p>
                </div>

                <!-- Messages -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="message error">
                        <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <% if (request.getAttribute("success") != null) { %>
                    <div class="message success">
                        <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
                    </div>
                <% } %>

                <!-- User Details -->
                <div class="user-details-section">
                    <%
                    com.pahana.UserServlet.User user = (com.pahana.UserServlet.User) request.getAttribute("user");
                    if (user != null) {
                        String roleClass = "default";
                        if (user.getRoleName() != null) {
                            switch (user.getRoleName().toLowerCase()) {
                                case "admin":
                                    roleClass = "admin";
                                    break;
                                case "manager":
                                    roleClass = "manager";
                                    break;
                                case "staff":
                                    roleClass = "staff";
                                    break;
                            }
                        }
                    %>
                    <div class="user-info">
                        <div class="info-group">
                            <div class="info-label">User ID</div>
                            <div class="info-value">#<%= user.getUserId() %></div>
                        </div>
                        
                        <div class="info-group">
                            <div class="info-label">Username</div>
                            <div class="info-value"><%= user.getUsername() %></div>
                        </div>
                        
                        <div class="info-group">
                            <div class="info-label">Email Address</div>
                            <div class="info-value"><%= user.getEmail() %></div>
                        </div>
                        
                        <div class="info-group">
                            <div class="info-label">Role</div>
                            <div class="info-value">
                                <span class="user-role <%= roleClass %>">
                                    <%= user.getRoleName() != null ? user.getRoleName() : "No Role Assigned" %>
                                </span>
                            </div>
                        </div>
                        
                        <div class="info-group">
                            <div class="info-label">Account Created</div>
                            <div class="info-value">
                                <%= user.getCreatedAt() != null ? user.getCreatedAt().toString() : "Unknown" %>
                            </div>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="UserServlet?action=list" class="btn btn-back">
                            <i class="fas fa-arrow-left"></i> Back to List
                        </a>
                        <a href="UserServlet?action=edit&userId=<%= user.getUserId() %>" class="btn btn-edit">
                            <i class="fas fa-edit"></i> Edit User
                        </a>
                        <button onclick="confirmDelete(<%= user.getUserId() %>, '<%= user.getUsername() %>')" class="btn btn-delete">
                            <i class="fas fa-trash"></i> Delete User
                        </button>
                    </div>
                    <%
                    } else {
                    %>
                    <div style="text-align: center; padding: 2rem;">
                        <h3 style="color: #724784; margin-bottom: 1rem;">User Not Found</h3>
                        <p style="color: #666;">The requested user could not be found.</p>
                        <a href="UserServlet?action=list" class="btn btn-back" style="margin-top: 1rem;">
                            <i class="fas fa-arrow-left"></i> Back to User List
                        </a>
                    </div>
                    <%
                    }
                    %>
                </div>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 BookShop. All rights reserved. | Admin User Management System</p>
    </footer>

    <script>
        // Confirm delete function
        function confirmDelete(userId, username) {
            if (confirm('Are you sure you want to delete user "' + username + '"? This action cannot be undone.')) {
                window.location.href = 'UserServlet?action=delete&userId=' + userId;
            }
        }

        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.admin-sidebar');
            if (sidebar) {
                sidebar.classList.toggle('open');
            }
        }
    </script>
</body>
</html> 