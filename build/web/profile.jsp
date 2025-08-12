<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/sidebar.css">
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --accent-color: #a855f7;
            --text-color: #1e293b;
            --light-color: #f8fafc;
            --hover-color: #4f46e5;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            min-height: 100vh;
        }

        .main-content {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
            text-align: center;
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .page-header h1 {
            color: #6366f1;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .page-header p {
            color: #64748b;
            font-weight: 500;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .profile-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .profile-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f5f9;
        }

        .profile-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .profile-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .profile-avatar {
            text-align: center;
            margin-bottom: 2rem;
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 3rem;
            color: white;
            font-weight: 700;
        }

        .profile-info {
            text-align: center;
        }

        .profile-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .profile-role {
            color: #6366f1;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: #6366f1;
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #1e293b;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"],
        .form-group input[type="tel"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            background: #f8fafc;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #6366f1;
            background: white;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-right: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        .profile-actions {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e2e8f0;
        }

        @media (max-width: 768px) {
            .admin-main-content { margin-left: 0; }
            .main-content { padding: 1rem; }
            .profile-grid { grid-template-columns: 1fr; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <%
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
    
    String navType = "public";
    if (isLoggedIn) {
        if ("admin".equals(userType) || "Admin".equals(role)) {
            navType = "admin";
        } else if ("Manager".equals(role)) {
            navType = "manager";
        } else if ("Staff".equals(role)) {
            navType = "staff";
        } else {
            navType = "customer";
        }
    }
    %>

    <% if (isLoggedIn) { %>
        <% if ("admin".equals(navType)) { %>
            <div class="admin-layout">
                <aside class="admin-sidebar">
                    <div class="admin-sidebar-header">
                        <h2>Admin Panel</h2>
                        <p>Welcome, <%= username %></p>
                    </div>
                    
                    <ul class="admin-sidebar-menu">
                        <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Admin)</a></li>
                        <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                        <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                        <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                        <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                        <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                        <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                        <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                        <li><a href="profile.jsp" class="active"><i class="fas fa-user"></i> My Profile</a></li>
                        <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Admin)</a></li>
                        <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </aside>

                <main class="admin-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>My Profile</h1>
                            <p>View and manage your profile information</p>
                        </div>
                        
                        <div class="profile-grid">
                            <!-- Profile Summary -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-user"></i> Profile Summary</h3>
                                    <p>Your account overview</p>
                                </div>
                                
                                <div class="profile-avatar">
                                    <div class="avatar">
                                        <%= username != null ? username.charAt(0).toUpperCase() : "U" %>
                                    </div>
                                    <div class="profile-info">
                                        <div class="profile-name"><%= username != null ? username : "User" %></div>
                                        <div class="profile-role"><%= role != null ? role : "User" %></div>
                                    </div>
                                </div>
                                
                                <div class="profile-stats">
                                    <div class="stat-item">
                                        <div class="stat-number">Admin</div>
                                        <div class="stat-label">Role</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-number">Active</div>
                                        <div class="stat-label">Status</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Details -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-edit"></i> Profile Details</h3>
                                    <p>Update your personal information</p>
                                </div>
                                
                                <form id="profileForm">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="firstName">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="Admin" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="User" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" id="email" name="email" value="admin@pahanabookshop.com" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="phone">Phone Number</label>
                                        <input type="tel" id="phone" name="phone" value="+1 (555) 123-4567">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="department">Department</label>
                                        <select id="department" name="department">
                                            <option value="administration" selected>Administration</option>
                                            <option value="management">Management</option>
                                            <option value="operations">Operations</option>
                                        </select>
                                    </div>
                                    
                                    <div class="profile-actions">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                        <button type="button" class="btn btn-secondary" onclick="resetForm()">
                                            <i class="fas fa-undo"></i> Reset
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } else if ("manager".equals(navType)) { %>
            <div class="admin-layout">
                <aside class="admin-sidebar">
                    <div class="admin-sidebar-header">
                        <h2>Manager Panel</h2>
                        <p>Welcome, <%= username %></p>
                    </div>
                    
                    <ul class="admin-sidebar-menu">
                        <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Manager)</a></li>
                        <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                        <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                        <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                        <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                        <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                        <li><a href="profile.jsp" class="active"><i class="fas fa-user"></i> My Profile</a></li>
                        <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Manager)</a></li>
                        <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </aside>

                <main class="admin-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>My Profile</h1>
                            <p>View and manage your profile information</p>
                        </div>
                        
                        <div class="profile-grid">
                            <!-- Profile Summary -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-user"></i> Profile Summary</h3>
                                    <p>Your account overview</p>
                                </div>
                                
                                <div class="profile-avatar">
                                    <div class="avatar">
                                        <%= username != null ? username.charAt(0).toUpperCase() : "U" %>
                                    </div>
                                    <div class="profile-info">
                                        <div class="profile-name"><%= username != null ? username : "User" %></div>
                                        <div class="profile-role"><%= role != null ? role : "User" %></div>
                                    </div>
                                </div>
                                
                                <div class="profile-stats">
                                    <div class="stat-item">
                                        <div class="stat-number">Manager</div>
                                        <div class="stat-label">Role</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-number">Active</div>
                                        <div class="stat-label">Status</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Details -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-edit"></i> Profile Details</h3>
                                    <p>Update your personal information</p>
                                </div>
                                
                                <form id="profileForm">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="firstName">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="Manager" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="User" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" id="email" name="email" value="manager@pahanabookshop.com" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="phone">Phone Number</label>
                                        <input type="tel" id="phone" name="phone" value="+1 (555) 123-4567">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="department">Department</label>
                                        <select id="department" name="department">
                                            <option value="management" selected>Management</option>
                                            <option value="operations">Operations</option>
                                            <option value="sales">Sales</option>
                                        </select>
                                    </div>
                                    
                                    <div class="profile-actions">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                        <button type="button" class="btn btn-secondary" onclick="resetForm()">
                                            <i class="fas fa-undo"></i> Reset
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } else if ("staff".equals(navType)) { %>
            <div class="admin-layout">
                <aside class="admin-sidebar">
                    <div class="admin-sidebar-header">
                        <h2>Staff Panel</h2>
                        <p>Welcome, <%= username %></p>
                    </div>
                    
                    <ul class="admin-sidebar-menu">
                        <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                        <li><a href="profile.jsp" class="active"><i class="fas fa-user"></i> My Profile</a></li>
                        <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Staff)</a></li>
                        <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </aside>

                <main class="admin-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>My Profile</h1>
                            <p>View and manage your profile information</p>
                        </div>
                        
                        <div class="profile-grid">
                            <!-- Profile Summary -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-user"></i> Profile Summary</h3>
                                    <p>Your account overview</p>
                                </div>
                                
                                <div class="profile-avatar">
                                    <div class="avatar">
                                        <%= username != null ? username.charAt(0).toUpperCase() : "U" %>
                                    </div>
                                    <div class="profile-info">
                                        <div class="profile-name"><%= username != null ? username : "User" %></div>
                                        <div class="profile-role"><%= role != null ? role : "User" %></div>
                                    </div>
                                </div>
                                
                                <div class="profile-stats">
                                    <div class="stat-item">
                                        <div class="stat-number">Staff</div>
                                        <div class="stat-label">Role</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-number">Active</div>
                                        <div class="stat-label">Status</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Details -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-edit"></i> Profile Details</h3>
                                    <p>Update your personal information</p>
                                </div>
                                
                                <form id="profileForm">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="firstName">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="Staff" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="User" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" id="email" name="email" value="staff@pahanabookshop.com" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="phone">Phone Number</label>
                                        <input type="tel" id="phone" name="phone" value="+1 (555) 123-4567">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="department">Department</label>
                                        <select id="department" name="department">
                                            <option value="operations" selected>Operations</option>
                                            <option value="sales">Sales</option>
                                            <option value="customer-service">Customer Service</option>
                                        </select>
                                    </div>
                                    
                                    <div class="profile-actions">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                        <button type="button" class="btn btn-secondary" onclick="resetForm()">
                                            <i class="fas fa-undo"></i> Reset
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } else { %>
            <!-- Customer Profile -->
            <div class="customer-layout">
                <nav class="customer-navbar">
                    <div class="customer-nav-container">
                        <a href="welcome.jsp" class="customer-logo">
                            <span class="customer-logo-text">Pahana BookShop</span>
                        </a>
                        <ul class="customer-nav-menu">
                            <li><a href="welcome.jsp">Home (Welcome Page)</a></li>
                            <li><a href="about.jsp">About</a></li>
                            <li><a href="books.jsp">Books</a></li>
                            <li><a href="categories.jsp">Categories</a></li>
                            <li><a href="orders.jsp">My Orders</a></li>
                            <li><a href="wishlist.jsp">Wishlist</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                            <li><a href="profile.jsp" class="active">My Profile</a></li>
                            <li><a href="help.jsp">Help (Customer)</a></li>
                        </ul>
                        <div class="customer-user-info">
                            <span class="welcome-text">Welcome, <%= username %></span>
                            <a href="LogoutServlet" class="customer-logout-btn">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>
                </nav>

                <main class="customer-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>My Profile</h1>
                            <p>View and manage your profile information</p>
                        </div>
                        
                        <div class="profile-grid">
                            <!-- Profile Summary -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-user"></i> Profile Summary</h3>
                                    <p>Your account overview</p>
                                </div>
                                
                                <div class="profile-avatar">
                                    <div class="avatar">
                                        <%= username != null ? username.charAt(0).toUpperCase() : "U" %>
                                    </div>
                                    <div class="profile-info">
                                        <div class="profile-name"><%= username != null ? username : "User" %></div>
                                        <div class="profile-role">Customer</div>
                                    </div>
                                </div>
                                
                                <div class="profile-stats">
                                    <div class="stat-item">
                                        <div class="stat-number">Customer</div>
                                        <div class="stat-label">Role</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-number">Active</div>
                                        <div class="stat-label">Status</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Details -->
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h3><i class="fas fa-edit"></i> Profile Details</h3>
                                    <p>Update your personal information</p>
                                </div>
                                
                                <form id="profileForm">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="firstName">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="Customer" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="User" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" id="email" name="email" value="customer@pahanabookshop.com" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="phone">Phone Number</label>
                                        <input type="tel" id="phone" name="phone" value="+1 (555) 123-4567">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="address">Shipping Address</label>
                                        <textarea id="address" name="address" rows="3" placeholder="Enter your shipping address"></textarea>
                                    </div>
                                    
                                    <div class="profile-actions">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                        <button type="button" class="btn btn-secondary" onclick="resetForm()">
                                            <i class="fas fa-undo"></i> Reset
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } %>
    <% } else { %>
        <div style="text-align: center; padding: 4rem 2rem;">
            <h1 style="color: #ef4444; margin-bottom: 1rem;">Access Denied</h1>
            <p style="color: #64748b; margin-bottom: 2rem;">Please login to view your profile.</p>
            <a href="login.jsp" style="background: #6366f1; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block;">Login</a>
        </div>
    <% } %>

    <script src="js/sidebar.js"></script>
    <script>
        function resetForm() {
            document.getElementById('profileForm').reset();
            alert('Form reset to original values');
        }

        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Profile updated successfully!');
        });
    </script>
</body>
</html>
