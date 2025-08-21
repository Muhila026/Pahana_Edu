<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
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

        /* ===== CSS VARIABLES ===== */
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
            --Navbar-bg: var(--card-background);
            --Navbar-hover: rgba(76, 117, 186, 0.12);
            --Navbar-active-bg: var(--secondary-color);
            --Navbar-active-text: #ffffff;
            --accent-color: #3FA9F5;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* ===== PUBLIC NAVIGATION (Top Navbar Only) ===== */
        .public-navbar {
            background: var(--Navbar-bg);
            box-shadow: 0 4px 6px -1px var(--border-color), 0 2px 4px -1px var(--border-color);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            letter-spacing: -0.5px;
            padding: 18px 20px 18px 0;
            display: flex;
            align-items: center;
            border-right: 1px solid var(--border-color);
        }
        
        .logo-text { color: white; transition: var(--transition); }
        .logo:hover .logo-text { color: var(--secondary-color); }
        
        .nav-menu {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
            margin-left: auto;
        }
        
        .nav-menu li {
            position: relative;
        }
        
        .nav-menu a {
            display: block;
            padding: 18px 16px;
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: var(--transition);
            position: relative;
            border-bottom: 2px solid transparent;
        }
        
        .nav-menu a:hover,
        .nav-menu a.active {
            color: var(--Navbar-active-bg);
            border-bottom-color: var(--Navbar-active-bg);
        }
        
        .nav-menu a.active {
            font-weight: 600;
        }
        
        .welcome-user {
            color: var(--secondary-color) !important;
            font-weight: 600 !important;
            padding: 18px 16px !important;
        }
        
        .login-btn {
            background: var(--primary-color);
            color: var(--Navbar-active-text) !important;
            font-weight: 600 !important;
            border-radius: 6px;
            margin: 7px 0;
            padding: 8px 16px !important;
            transition: var(--transition);
            border: none;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px var(--border-color);
        }
        
        @media (max-width: 991px) {
            .nav-container {
                flex-direction: column;
                align-items: stretch;
            }
            
            .logo {
                border-right: none;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                margin-right: 0;
                justify-content: space-between;
            }
            
            .nav-menu {
                display: none;
                flex-direction: column;
                margin: 0;
            }
            
            .nav-menu.show {
                display: flex;
            }
            
            .nav-menu a {
                padding: 14px 20px;
                border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            }
            
            .welcome-user {
                padding: 14px 20px !important;
            }
            
            .login-btn {
                margin: 10px 20px;
                border-radius: 6px;
            }
            
            .navbar-toggler {
                position: absolute;
                right: 20px;
                top: 20px;
                border-color: #6366f1;
            }
        }

        /* ===== CUSTOMER NAVIGATION (Top Navbar Only) ===== */
        .customer-layout {
            min-height: 100vh;
        }

        .customer-navbar {
            background: var(--Navbar-bg);
            box-shadow: 0 4px 6px -1px var(--border-color), 0 2px 4px -1px var(--border-color);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .customer-nav-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .customer-logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            letter-spacing: -0.5px;
            padding: 18px 20px 18px 0;
            display: flex;
            align-items: center;
            border-right: 1px solid var(--border-color);
        }

        .customer-logo-text { color: white; transition: var(--transition); }
        .customer-logo:hover .customer-logo-text { color: var(--secondary-color); }

        .customer-nav-menu {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
            margin-left: auto;
            flex-wrap: wrap;
        }

        .customer-nav-menu li {
            position: relative;
        }

        .customer-nav-menu a {
            display: block;
            padding: 18px 16px;
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: var(--transition);
            position: relative;
            border-bottom: 2px solid transparent;
            white-space: nowrap;
        }

        .customer-nav-menu a:hover,
        .customer-nav-menu a.active {
            color: var(--Navbar-active-bg);
            border-bottom-color: var(--Navbar-active-bg);
        }

        .customer-nav-menu a.active {
            font-weight: 600;
        }

        .customer-user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--text-primary);
        }

        .customer-user-info .welcome-text { font-weight: 600; color: var(--secondary-color); background: var(--card-background); padding: 0.5rem 1rem; border-radius: 8px; border: 1px solid var(--secondary-color); }

        .customer-logout-btn {
            background: var(--primary-color);
            color: var(--Navbar-active-text) !important;
            font-weight: 600 !important;
            border-radius: 6px;
            margin: 7px 0;
            padding: 8px 16px !important;
            transition: var(--transition);
            border: none;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .customer-logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px var(--border-color);
        }

        @media (max-width: 991px) {
            .customer-nav-container {
                flex-direction: column;
                align-items: stretch;
            }
            
            .customer-logo {
                border-right: none;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                margin-right: 0;
                justify-content: space-between;
            }
            
            .customer-nav-menu {
                display: none;
                flex-direction: column;
                margin: 0;
            }
            
            .customer-nav-menu.show {
                display: flex;
            }
            
            .customer-nav-menu a {
                padding: 14px 20px;
                border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            }
            
            .customer-user-info {
                padding: 14px 20px;
                flex-direction: column;
                align-items: stretch;
            }
            
            .customer-logout-btn {
                margin: 10px 20px;
                border-radius: 6px;
                justify-content: center;
            }
            
            .navbar-toggler {
                position: absolute;
                right: 20px;
                top: 20px;
                border-color: #6366f1;
            }
        }

        .customer-main-content {
            margin-top: 100px;
            padding: 0 2rem;
        }

        /* ===== MANAGER/ADMIN NAVIGATION (Sidebar Only) ===== */
        .admin-layout {
            display: flex;
            min-height: 100vh;
        }

        .admin-sidebar {
            width: 320px;
            background: var(--sidebar-bg);
            color: var(--sidebar-active-text);
            padding: 1rem 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 999;
            scrollbar-width: thin;
            scrollbar-color: var(--secondary-color) var(--sidebar-hover);
        }

        .admin-sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .admin-sidebar::-webkit-scrollbar-track { background: var(--sidebar-hover); }

        .admin-sidebar::-webkit-scrollbar-thumb { background: var(--secondary-color); border-radius: 3px; }

        .admin-sidebar::-webkit-scrollbar-thumb:hover { background: var(--primary-hover); }

        .admin-sidebar-header {
            padding: 0 1.5rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .admin-sidebar-header h2 { color: var(--secondary-color); margin-bottom: 0.5rem; }

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
            color: var(--sidebar-active-text);
            text-decoration: none;
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            transition: all 0.3s;
            font-weight: 500;
            font-size: 0.95rem;
            border-left: 3px solid transparent;
        }

        .admin-sidebar-menu a:hover {
            background: var(--sidebar-hover);
            color: var(--accent-color);
            transform: translateX(5px);
            border-left-color: var(--accent-color);
        }

        .admin-sidebar-menu a.active {
            background: var(--sidebar-active-bg);
            color: var(--sidebar-active-text);
            border-left-color: var(--accent-color);
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

        /* ===== STAFF NAVIGATION (Horizontal Tabs) ===== */
        .staff-layout {
            min-height: 100vh;
        }

        .staff-navbar {
            background: linear-gradient(135deg, #724784, #ac87cd, #724784);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .staff-tabs {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            gap: 0.5rem;
            padding: 0 2rem;
            overflow-x: auto;
        }

        .staff-tab {
            background: rgba(255,255,255,0.1);
            color: white;
            text-decoration: none;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s;
            white-space: nowrap;
        }

        .staff-tab:hover,
        .staff-tab.active {
            background: #ff7f42;
            color: white;
        }

        .staff-main-content {
            margin-top: 80px;
        }

        /* ===== COMMON STYLES ===== */
        .main-content {
            padding: 2rem;
            max-width: 1200px;
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

        /* Page Header for Public */
        .public-page-header {
            background: linear-gradient(0deg, rgba(15,23,42,0.55), rgba(15,23,42,0.55)), url('IMG/books.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: white;
            text-align: center;
            padding: 100px 2rem 70px;
            margin-bottom: 3rem;
        }

        .public-page-header h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .public-page-header p {
            font-size: 1.2rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Category Pills */
        .category-pills { max-width: 1000px; margin: -2rem auto 2rem; padding: 0 2rem; display: flex; flex-wrap: wrap; gap: 0.5rem; justify-content: center; }
        .category-pill { background: var(--Navbar-hover); border: 1px solid var(--border-color); color: var(--primary-color); padding: 0.35rem 0.9rem; border-radius: 999px; text-decoration: none; font-weight: 500; transition: var(--transition); }
        .category-pill:hover { background: var(--primary-color); color: var(--Navbar-active-text); transform: translateY(-1px); box-shadow: 0 6px 18px var(--border-color); }

        /* Categories Section */
        .categories {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem 4rem;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .category-card {
            background: var(--Navbar-bg);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px var(--border-color);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .category-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .category-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px var(--border-color);
        }

        .category-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
        }

        .category-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .category-description {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .category-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .book-count {
            background: var(--Navbar-hover);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            color: var(--primary-color);
        }

        .category-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .tag {
            background: var(--Navbar-hover);
            color: var(--primary-color);
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .explore-btn {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: var(--Navbar-active-text);
            text-decoration: none;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            display: inline-block;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .explore-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px var(--border-color);
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: var(--Navbar-active-text);
            text-align: center;
            padding: 2rem;
            margin-top: 4rem;
        }

        .footer p {
            margin: 0;
            opacity: 0.9;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .customer-navbar {
                padding: 1rem 0;
            }
            
            .customer-nav-container {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }
            
            .customer-nav-menu {
                flex-wrap: wrap;
                justify-content: center;
                gap: 0.3rem;
            }
            
            .customer-nav-menu a {
                padding: 0.5rem 0.8rem;
                font-size: 0.85rem;
            }
            
            .customer-user-info {
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }
            
            .customer-main-content {
                margin-top: 120px;
                padding: 0 1rem;
            }
            
            .admin-sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            
            .admin-sidebar.open {
                transform: translateX(0);
            }
            
            .customer-main-content,
            .admin-main-content {
                margin-left: 0;
            }
            
            .staff-tabs {
                padding: 0 1rem;
            }
            
            .public-page-header h1 {
                font-size: 2.5rem;
            }
            
            .categories-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .category-card {
                padding: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }
            
            .nav-menu {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .public-page-header {
                padding: 100px 1rem 60px;
            }
            
            .public-page-header h1 {
                font-size: 2rem;
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
    
    // Determine navigation type
    String navType = "public"; // default
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

    <% if ("public".equals(navType)) { %>
        <!-- PUBLIC NAVIGATION (Top Navbar Only) -->
        <nav class="public-navbar">
            <div class="nav-container">
                <a href="#home" class="logo">
                    <span class="logo-text">Pahana BookShop</span>
                </a>
                <ul class="nav-menu">
                    <li><a href="welcome.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="BookServlet?action=list&redirect=books.jsp">Books</a></li>
                    <li><a href="BookCategoryServlet?action=list&redirect=categories.jsp">Categories</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                    <li><a href="login.jsp" class="login-btn">Login</a></li>
                </ul>
            </div>
        </nav>

        <!-- Page Header -->
        <section class="public-page-header">
            <h1>Browse Categories</h1>
            <p>School to University, Professional studies and Sinhala/English literature — curated for Sri Lankan learners.</p>
        </section>


    <% } else if ("customer".equals(navType)) { %>
        <!-- CUSTOMER NAVIGATION (Top Navbar Only) -->
       
            <!-- Navbar -->
            <nav class="customer-navbar">
                <div class="customer-nav-container">
                    <a href="welcome.jsp" class="customer-logo">
                        <span class="customer-logo-text">Pahana BookShop</span>
                    </a>
                    <ul class="customer-nav-menu">
                        <li><a href="welcome.jsp">Home</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="BookServlet?action=list&redirect=books.jsp">Books</a></li>
                        <li><a href="BookCategoryServlet?action=list&redirect=categories.jsp" class="active">Categories</a></li>
                        <li><a href="dashboard.jsp">My Profile</a></li>
                        <li><a href="orders.jsp">My Orders</a></li>
                        <li><a href="wishlist.jsp">Wishlist</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                        <%
                        // Get customer full name from session
                        String customerName = (String) session.getAttribute("customerName");
                        String displayName = (customerName != null && !customerName.trim().isEmpty()) ? customerName : username;
                        %>
                        <li><span class="welcome-text">Welcome, <%= displayName %></span></li>
                        <li><a href="LogoutServlet" class="customer-logout-btn">Logout</a></li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="customer-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Book Categories</h1>
                        <p>Explore our diverse collection of books organized by categories.</p>
                    </div>
                </div>
            </main>
      

    <% } else if ("manager".equals(navType) || "admin".equals(navType)) { %>
        <!-- MANAGER/ADMIN NAVIGATION (Sidebar Only) -->
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
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="BookCategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="users.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                    <li><a href="inventory.jsp"><i class="fas fa-boxes"></i> Inventory Management</a></li>
                    <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                    <li><a href="backup.jsp"><i class="fas fa-database"></i> Backup & Restore</a></li>
                    <li><a href="logs.jsp"><i class="fas fa-file-alt"></i> System Logs</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("manager".equals(navType)) {
                %>
                <!-- MANAGER SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="BookCategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Process Orders</a></li>
                    <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Sales Reports</a></li>
                    <li><a href="staff.jsp"><i class="fas fa-user-tie"></i> Staff Management</a></li>
                    <li><a href="customers.jsp"><i class="fas fa-users"></i> Customer Support</a></li>
                    <li><a href="inventory.jsp"><i class="fas fa-boxes"></i> Stock Management</a></li>
                    <li><a href="promotions.jsp"><i class="fas fa-tags"></i> Promotions</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("staff".equals(navType)) {
                %>
                <!-- STAFF SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="books.jsp"><i class="fas fa-book"></i> Browse Books</a></li>
                    <li><a href="categories.jsp"><i class="fas fa-tags"></i> Categories</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Process Orders</a></li>
                    <li><a href="customers.jsp"><i class="fas fa-users"></i> Customer Support</a></li>
                    <li><a href="inventory.jsp"><i class="fas fa-boxes"></i> Check Stock</a></li>
                    <li><a href="returns.jsp"><i class="fas fa-undo"></i> Returns & Refunds</a></li>
                    <li><a href="schedule.jsp"><i class="fas fa-calendar"></i> My Schedule</a></li>
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
                        <h1>Category Management</h1>
                        <p>Manage book categories and organize your inventory.</p>
                    </div>
                </div>
            </main>
        </div>

    <% } else if ("staff".equals(navType)) { %>
        <!-- STAFF NAVIGATION (Horizontal Tabs) -->
        <div class="staff-layout">
            <nav class="staff-navbar">
                <div class="staff-tabs">
                    <a href="welcome.jsp" class="staff-tab"><i class="fas fa-home"></i> Dashboard</a>
                    <a href="books.jsp" class="staff-tab"><i class="fas fa-book"></i> Books</a>
                    <a href="categories.jsp" class="staff-tab active"><i class="fas fa-tags"></i> Categories</a>
                    <a href="orders.jsp" class="staff-tab"><i class="fas fa-shopping-cart"></i> Orders</a>
                    <a href="customers.jsp" class="staff-tab"><i class="fas fa-users"></i> Customers</a>
                    <a href="LogoutServlet" class="staff-tab"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="staff-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Book Categories</h1>
                        <p>Help customers explore books by categories.</p>
                    </div>
                </div>
            </main>
        </div>
    <% } %>

    <!-- Categories Section -->
    <section class="categories">
        <div class="categories-grid">
            <%
            // Get categories from request attribute
            java.util.List<com.booking.BookCategoryServlet.BookCategory> categories = 
                (java.util.List<com.booking.BookCategoryServlet.BookCategory>) request.getAttribute("categories");
            
            if (categories != null && !categories.isEmpty()) {
                for (com.booking.BookCategoryServlet.BookCategory category : categories) {
            %>
                <div class="category-card">
                    <span class="category-icon">📚</span>
                    <h3 class="category-title"><%= category.getCategoryName() %></h3>
                    <p class="category-description">Explore amazing books in this category.</p>
                    <div class="category-stats">
                        <span class="book-count">
                            <i class="fas fa-book"></i> 25+ Books
                        </span>
                    </div>
                    <div class="category-tags">
                        <span class="tag">Popular</span>
                        <span class="tag">Bestsellers</span>
                    </div>
                    <a href="books.jsp?category=<%= category.getCategoryId() %>" class="explore-btn">
                        <i class="fas fa-arrow-right"></i> Explore Books
                    </a>
                </div>
            <%
                }
            } else {
            %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 3rem;">
                    <h3 style="color: #6366f1; margin-bottom: 1rem;">No Categories Found</h3>
                    <p style="color: #666;">Categories will be loaded from the database.</p>
                </div>
            <%
            }
            %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 BookShop. All rights reserved. | Your trusted source for quality books and knowledge.</p>
    </footer>

    <script>
        // Navbar background change on scroll (for public, customer, and staff)
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.public-navbar, .customer-navbar, .staff-navbar');
            if (navbar) {
                if (window.scrollY > 50) {
                    navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                    navbar.style.backdropFilter = 'blur(10px)';
                    navbar.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)';
                } else {
                    navbar.style.background = 'white';
                    navbar.style.backdropFilter = 'none';
                    navbar.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)';
                }
            }
        });

        // Mobile sidebar toggle (for admin layouts only)
        function toggleSidebar() {
            const sidebar = document.querySelector('.admin-sidebar');
            if (sidebar) {
                sidebar.classList.toggle('open');
            }
        }

        // Customer nav menu active state
        document.querySelectorAll('.customer-nav-menu a').forEach(link => {
            if (link.href === window.location.href) {
                link.classList.add('active');
            }
        });

        // Staff tab activation
        document.querySelectorAll('.staff-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.staff-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Load categories from servlet if not already loaded
        window.addEventListener('load', function() {
            // Check if categories are already loaded (from servlet)
            const categories = document.querySelectorAll('.category-card');
            if (categories.length === 0 || (categories.length === 1 && categories[0].textContent.includes('No categories'))) {
                // Redirect to servlet to load categories and return to this page
                window.location.href = 'BookCategoryServlet?action=list&redirect=categories.jsp';
            }
        });
    </script>
</body>
</html> 