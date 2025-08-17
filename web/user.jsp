<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.UserServlet.User"%>
<%@page import="com.booking.UserServlet.UserRole"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
        :root {
            /* Brand Colors */
            --primary-color: #2C3E91;
            --primary-hover: #1F2D6D;
            --secondary-color: #4A90E2;
            
            /* Status Colors (blue-friendly) */
            --success-color: #3BB273;
            --warning-color: #F4B400;
            --danger-color: #E63946;
            --info-color: #5DADEC;
            
            /* Backgrounds */
            --background-color: #F4F8FC;
            --card-background: #FFFFFF;
            
            /* Text Colors */
            --text-primary: #1E293B;
            --text-secondary: #475569;
            
            /* Borders & Accents */
            --border-color: #D0D9E6;
            --sidebar-bg: #2C3E91;
            --sidebar-hover: #1F2D6D;
            --sidebar-active-bg: #4A90E2;
            --sidebar-active-text: #ffffff;
            --accent-color: #3FA9F5;
        }

        * {
                margin: 0;
                padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--background-color);
            color: var(--text-primary);
            }

            /* Sidebar Styles */
            .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
                width: 280px;
            background: var(--sidebar-bg);
                color: var(--sidebar-active-text);
                overflow-y: auto;
                z-index: 1000;
            transition: all 0.3s ease;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
                text-align: center;
            }

                .sidebar-title {
            font-size: 1.4rem;
                font-weight: 700;
            color: var(--sidebar-active-text);
            margin-bottom: 0.5rem;
        }

        .sidebar-subtitle {
            font-size: 0.9rem;
            color: var(--sidebar-active-text);
            font-weight: 400;
        }

        .sidebar-nav {
            padding: 1.5rem 0;
            }

            .nav-item {
            margin-bottom: 0.5rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--sidebar-active-text);
                text-decoration: none;
                transition: all 0.3s ease;
            border-radius: 0;
                font-weight: 500;
            }

            

            .nav-link.active { background: var(--sidebar-active-bg); color: var(--sidebar-active-text); }

            .nav-link i {
            width: 20px;
            margin-right: 12px;
                font-size: 1.1rem;
            }

            .sidebar-footer { padding: 1.5rem; border-top: 1px solid var(--border-color); margin-top: auto; }

            .logout-btn {
                width: 100%;
            background: var(--danger-color);
            border: none;
                color: white;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            font-weight: 500;
            }

            .logout-btn:hover {
            background: var(--danger-color);
                color: var(--sidebar-active-text);
                text-decoration: none;
            transform: translateY(-2px);
            }

        /* Main Content */
            .main-content {
                margin-left: 280px;
                padding: 2rem;
            min-height: 100vh;
        }

        .page-header {
            background: var(--primary-color);
            color: var(--sidebar-active-text);
            padding: 2.5rem;
            border-radius: 20px;
                margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before { content: none; }

        @keyframes float { 0% { } }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
            }

            /* Content Cards */
            .content-card {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
            border: 1px solid var(--border-color);
            }

            .card-title {
                font-size: 1.5rem;
                font-weight: 600;
            color: var(--text-primary);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
            gap: 0.75rem;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.open {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .page-header {
                padding: 2rem 1.5rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
        }

        /* Mobile Menu Toggle */
        .mobile-menu-toggle {
            display: none;
            position: fixed;
            top: 1rem;
            left: 1rem;
            z-index: 1001;
            background: var(--primary-color);
            border: none;
                color: white;
            padding: 0.75rem;
            border-radius: 8px;
            font-size: 1.2rem;
        }

        @media (max-width: 1024px) {
            .mobile-menu-toggle {
                display: block;
            }
        }

        /* Overlay for mobile */
        .sidebar-overlay {
            display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .sidebar-overlay.open {
            display: block;
        }

        /* Table Styling */
        .table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .table thead th {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 1rem;
                font-weight: 600;
            }

        .table tbody td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background: #f8fafc;
        }

        /* Button Styling */
        .btn-primary {
            background: var(--primary-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .btn-success {
            background: var(--success-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

        .btn-success:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .btn-warning {
            background: var(--warning-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-warning:hover {
            background: #d97706;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Role Badge Styling */
        .role-admin {
            background: var(--danger-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .role-manager {
            background: var(--warning-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .role-staff {
            background: var(--info-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .role-customer {
            background: var(--secondary-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            }
        </style>
    </head>
    <body>
    <!-- Mobile Menu Toggle -->
    <button class="mobile-menu-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Sidebar Overlay -->
    <div class="sidebar-overlay" id="sidebarOverlay" onclick="closeSidebar()"></div>

    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-title">
                <% 
                String userRole = (String) session.getAttribute("role");
                if (userRole != null) {
                    if (userRole.equals("ADMIN")) {
                        out.print("ADMIN Panel");
                    } else if (userRole.equals("MANAGER")) {
                        out.print("MANAGER Panel");
                    } else if (userRole.equals("STAFF")) {
                        out.print("STAFF Panel");
                    } else if (userRole.equals("CUSTOMER")) {
                        out.print("CUSTOMER Panel");
                    } else {
                        out.print("UserRole Panel");
                    }
                } else {
                    out.print("UserRole Panel");
                }
                %>
            </div>
            <div class="sidebar-subtitle">Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></div>
        </div>
        
        <nav class="sidebar-nav">
            <div class="nav-item">
                <a href="dashboard.jsp" class="nav-link">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
            </div>
            
            <div class="nav-item">
                <a href="pos.jsp" class="nav-link">
                    <i class="fas fa-cash-register"></i>
                    POS
                </a>
            </div>
            
            <div class="nav-item">
                <a href="TransactionServlet?action=list" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    Transaction
                </a>
            </div>
            
            <div class="nav-item">
                <a href="CustomerServlet?action=list" class="nav-link">
                    <i class="fas fa-user-friends"></i>
                    Customer
                </a>
            </div>
            
            <div class="nav-item">
                <a href="BookCategoryServlet?action=list" class="nav-link">
                    <i class="fas fa-tags"></i>
                    Book Categories
                </a>
            </div>
            
            <div class="nav-item">
                <a href="BookServlet?action=list" class="nav-link">
                    <i class="fas fa-book"></i>
                    Book
                </a>
            </div>
            
            <div class="nav-item">
                <a href="StockServlet?action=list" class="nav-link">
                    <i class="fas fa-boxes"></i>
                    Stock
                </a>
                    </div>
            
            <div class="nav-item">
                <a href="UserServlet?action=list" class="nav-link active">
                    <i class="fas fa-users"></i>
                    User
                </a>
                        </div>
            
            <div class="nav-item">
                <a href="UserRoleServlet?action=list" class="nav-link">
                    <i class="fas fa-user-shield"></i>
                    UserRole
                </a>
                    </div>
            
            <div class="nav-item">
                <a href="profile.jsp" class="nav-link">
                    <i class="fas fa-user"></i>
                    Profile
                </a>
            </div>
            
            <div class="nav-item">
                <a href="help.jsp" class="nav-link">
                    <i class="fas fa-question-circle"></i>
                    Help
                </a>
            </div>
        </nav>

        <div class="sidebar-footer">
            <a href="LogoutServlet" class="logout-btn">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-users me-3"></i>User Management
            </h1>
            <p class="page-subtitle">Manage system users, staff members, and their access permissions</p>
                </div>

                <!-- Messages -->
        <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i><%= request.getParameter("message") %>
                </div>
                <% } %>
                
        <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
            <i class="fas fa-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                </div>
                <% } %>

        <!-- User Management Content -->
                <div class="content-card">
                    <h3 class="card-title">
                <span><i class="fas fa-list"></i>System Users</span>
                <div class="d-flex gap-2">
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="fas fa-plus-circle me-2"></i>Add New User
                    </button>
                    <a href="UserServlet?action=list" class="btn btn-primary">
                        <i class="fas fa-arrow-clockwise me-2"></i>Refresh
                    </a>
                </div>
                    </h3>
                    
            <!-- Users Table -->
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        List<User> users = (List<User>) request.getAttribute("users");
                        if (users != null && !users.isEmpty()) {
                            for (User user : users) {
                        %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><strong><%= user.getUsername() %></strong></td>
                            <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                            <td>
                                <% if (user.getRole() != null) { %>
                                    <span class="role-<%= user.getRole().getRoleName().toLowerCase() %>">
                                        <%= user.getRole().getRoleName() %>
                                    </span>
                                <% } else { %>
                                    <span class="text-muted">N/A</span>
                                <% } %>
                            </td>
                            <td>
                                <span class="badge bg-success">Active</span>
                            </td>
                            <td>
                                <a href="UserServlet?action=view&user_id=<%= user.getUserId() %>" class="btn btn-sm btn-warning">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="UserServlet?action=delete&user_id=<%= user.getUserId() %>" class="btn btn-sm btn-danger">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center text-muted">
                                <i class="fas fa-inbox me-2"></i>No users found
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>



        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUserModalLabel">
                            <i class="fas fa-plus-circle me-2"></i>Add New User
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="UserServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username *</label>
                                        <input type="text" class="form-control" id="username" name="username" 
                                               required placeholder="Enter username">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password *</label>
                                        <input type="password" class="form-control" id="password" name="password" 
                                               required placeholder="Enter password">
                            </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               placeholder="Enter email address">
                        </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="roleId" class="form-label">Role *</label>
                                <select class="form-select" id="roleId" name="role_id" required>
                                        <option value="">Select Role</option>
                                        <%
                                            List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                            String currentUserRole = (String) session.getAttribute("role");
                                            if (userRoles != null) {
                                                for (UserRole role : userRoles) {
                                                    String availableRoleName = role.getRoleName();
                                                    boolean showOption = false;
                                                    if ("ADMIN".equals(currentUserRole)) {
                                                        // Admin can create Admin, Manager, Staff (exclude Customer)
                                                        showOption = !"CUSTOMER".equals(availableRoleName);
                                                    } else if ("MANAGER".equals(currentUserRole)) {
                                                        // Manager can create only Staff
                                                        showOption = "STAFF".equals(availableRoleName);
                                                    } else {
                                                        // Others cannot assign system roles
                                                        showOption = false;
                                                    }
                                                    if (showOption) {
                                        %>
                                        <option value="<%= role.getRoleId() %>"><%= availableRoleName %></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>
                                <small class="text-muted">Note: CUSTOMER accounts are created through customer registration.</small>
                                <!-- Debug info -->
                                <div class="mt-2">
                                    <small class="text-info">
                                        Debug: <% 
                                        if (userRoles != null) {
                                            out.print("User roles loaded: " + userRoles.size());
                                        } else {
                                            out.print("No user roles loaded");
                                        }
                                        %>
                                    </small>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Add User
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
        // Mobile sidebar functionality
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            sidebar.classList.toggle('open');
            overlay.classList.toggle('open');
            }

        function closeSidebar() {
                const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            sidebar.classList.remove('open');
            overlay.classList.remove('open');
        }

        // Close sidebar when clicking on a link (mobile)
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth <= 1024) {
                    closeSidebar();
                }
            });
        });

        // Close sidebar on window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 1024) {
                closeSidebar();
                }
            });

            // User management functions
            function editUser(userId) {
            // Redirect to edit page
            window.location.href = 'user_edit.jsp?id=' + userId;
        }

        function deleteUser(userId, username) {
            if (confirm('Are you sure you want to delete user "' + username + '"?')) {
                window.location.href = 'UserServlet?action=delete&id=' + userId;
            }
        }
        </script>
    </body>
</html> 