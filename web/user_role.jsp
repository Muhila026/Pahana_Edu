<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.UserServlet.UserRole"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Role Management - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
        :root {
            /* Brand Colors */
            --primary-color: #2C3E91;       /* Deep royal blue - main brand color */
            --primary-hover: #1F2D6D;       /* Darker navy blue for hover */
            --secondary-color: #4A90E2;     /* Bright sky blue for highlights */

            /* Status Colors (blue-friendly) */
            --success-color: #3BB273;       /* Teal green - balanced with blue */
            --warning-color: #F4B400;       /* Golden yellow for alerts */
            --danger-color: #E63946;        /* Strong coral red */
            --info-color: #5DADEC;          /* Soft info blue */

            /* Backgrounds */
            --background-color: #F4F8FC;    /* Very light blue-gray background */
            --card-background: #FFFFFF;     /* Clean white cards */

            /* Text Colors */
            --text-primary: #1E293B;        /* Dark navy-gray for readability */
            --text-secondary: #475569;      /* Muted cool gray for secondary text */

            /* Borders & Accents */
            --border-color: #D0D9E6;        /* Soft bluish-gray border */
            --sidebar-bg: #2C3E91;          /* Deep blue sidebar */
            --sidebar-hover: #1F2D6D;       /* Darker hover state */
            --sidebar-active-bg: #4A90E2;   /* Bright blue for active item */
            --sidebar-active-text: #ffffff; /* White text on active item */
            --accent-color: #3FA9F5;        /* Fresh accent blue */
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
            background: #dc2626;
                color: white;
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

        /* Custom Action Button Styles */
        .btn-edit {
            background: var(--accent-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-edit:hover {
            background: #ea580c;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.3);
            color: white;
        }

        .btn-delete {
            background: var(--danger-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            color: white;
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
            <% 
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equals(role) || "MANAGER".equals(role)) { 
            %>
                <!-- ADMIN and MANAGER see all menu items -->
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
                    <a href="UserServlet?action=list" class="nav-link">
                        <i class="fas fa-users"></i>
                        User
                    </a>
                </div>
                
                <div class="nav-item">
                    <a href="UserRoleServlet?action=list" class="nav-link active">
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
            <% } else if ("STAFF".equals(role)) { %>
                <!-- STAFF see limited menu items -->
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
            <% } else if ("CUSTOMER".equals(role)) { %>
                <!-- CUSTOMER see basic menu items -->
                <div class="nav-item">
                    <a href="TransactionServlet?action=list" class="nav-link">
                        <i class="fas fa-shopping-cart"></i>
                        Transaction
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
            <% } %>
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
                <i class="fas fa-user-shield me-3"></i>User Role Management
                <% if ("MANAGER".equals(role)) { %>
                <span class="badge bg-warning ms-2">Manager Access</span>
                <% } else if ("ADMIN".equals(role)) { %>
                <span class="badge bg-danger ms-2">Admin Access</span>
                <% } %>
            </h1>
            <p class="page-subtitle">
                <% if ("ADMIN".equals(role) || "MANAGER".equals(role)) { %>
                Manage user roles and permissions for system access control
                <% } else { %>
                View user roles and permissions (read-only access)
                <% } %>
            </p>
        </div>

                <!-- Add User Role Form - Only for ADMIN and MANAGER -->
                <% if ("ADMIN".equals(role) || "MANAGER".equals(role)) { %>
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-shield-plus me-2"></i>Add New User Role</span>
                    </h3>
                    
                    <form action="UserRoleServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="role_name" class="form-label">Role Name</label>
                                    <input type="text" class="form-control" id="role_name" name="role_name" 
                                           placeholder="Enter role name (e.g., EDITOR)" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Add Role
                            </button>
                        </div>
                    </form>
                </div>
                <% } %>

                <!-- User Role List -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-shield-check me-2"></i>User Role List</span>
                        <a href="UserRoleServlet?action=list" class="btn btn-primary">
                            <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                        </a>
                    </h3>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Role Name</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                                    <%
                        // Load user roles directly if not already loaded
                        List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                        if (userRoles == null) {
                            try {
                                // Load user roles directly using UserRoleServlet
                                com.booking.UserRoleServlet userRoleServlet = new com.booking.UserRoleServlet();
                                userRoles = userRoleServlet.getAllUserRoles();
                                System.out.println("Loaded " + (userRoles != null ? userRoles.size() : 0) + " user roles");
                            } catch (Exception e) {
                                System.err.println("Error loading user roles: " + e.getMessage());
                                e.printStackTrace();
                                userRoles = new ArrayList<>();
                            }
                        }
                        
                        if (userRoles != null && !userRoles.isEmpty()) {
                            for (UserRole roleItem : userRoles) {
                    %>
                                <tr>
                                    <td><%= roleItem.getRoleId() %></td>
                                    <td><span class="badge bg-primary"><%= roleItem.getRoleName() %></span></td>
                                    <td>
                                        <% if ("ADMIN".equals(role) || "MANAGER".equals(role)) { %>
                                        <button class="btn btn-edit btn-sm" data-role-id="<%= roleItem.getRoleId() %>" data-role-name="<%= roleItem.getRoleName() %>">
                                            <i class="fas fa-pencil"></i>
                                        </button>
                                        <% if (roleItem.getRoleId() > 4) { %>
                                        <button class="btn btn-delete btn-sm" data-role-id="<%= roleItem.getRoleId() %>">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <% } else { %>
                                        <span class="text-muted small">Core Role</span>
                                        <% } %>
                                        <% } else { %>
                                        <span class="text-muted small">View Only</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3" class="text-center">No user roles found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Toggle sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('open'); // Changed from 'show' to 'open'
                document.getElementById('sidebarOverlay').classList.toggle('open'); // Toggle overlay
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.mobile-menu-toggle');
                const sidebarOverlay = document.getElementById('sidebarOverlay');
                
                if (window.innerWidth <= 1024) { // Changed from 768 to 1024 for mobile menu toggle
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target) && (!sidebarOverlay || !sidebarOverlay.contains(event.target))) {
                        sidebar.classList.remove('open');
                        sidebarOverlay.classList.remove('open');
                    }
                }
            });

            // User role management functions
            function editRole(roleId, roleName) {
                const newRoleName = prompt('Enter new role name:', roleName);
                if (newRoleName && newRoleName.trim() !== '') {
                    // Create a form and submit it
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'UserRoleServlet';
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'update';
                    form.appendChild(actionInput);
                    
                    const roleIdInput = document.createElement('input');
                    roleIdInput.type = 'hidden';
                    roleIdInput.name = 'role_id';
                    roleIdInput.value = roleId;
                    form.appendChild(roleIdInput);
                    
                    const roleNameInput = document.createElement('input');
                    roleNameInput.type = 'hidden';
                    roleNameInput.name = 'role_name';
                    roleNameInput.value = newRoleName.trim();
                    form.appendChild(roleNameInput);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function deleteRole(roleId) {
                if (confirm('Are you sure you want to delete this role?')) {
                    window.location.href = 'UserRoleServlet?action=delete&role_id=' + roleId;
                }
            }

            // Bind click handlers to avoid inline JS with JSP expressions
            document.addEventListener('DOMContentLoaded', function() {
                var editButtons = document.querySelectorAll('.btn-edit[data-role-id]');
                editButtons.forEach(function(button) {
                    button.addEventListener('click', function() {
                        var roleId = this.getAttribute('data-role-id');
                        var roleName = this.getAttribute('data-role-name') || '';
                        editRole(roleId, roleName);
                    });
                });
                var deleteButtons = document.querySelectorAll('.btn-delete[data-role-id]');
                deleteButtons.forEach(function(button) {
                    button.addEventListener('click', function() {
                        var roleId = this.getAttribute('data-role-id');
                        deleteRole(roleId);
                    });
                });
            });
        </script>
    </body>
</html> 