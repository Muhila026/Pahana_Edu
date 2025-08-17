<%-- 
    Document   : contact
    Created on : Aug 4, 2025, 6:17:17 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/sidebar.css">
    <style>
        /* ===== CSS VARIABLES ===== */
        :root {
            /* Brand Colors */
            --primary-color: #b1081b;
            --primary-hover: #8a0615;
            --secondary-color: #57b8bf;

            /* Status Colors */
            --success-color: #4CAF50;
            --warning-color: #F4A261;
            --danger-color: #E76F51;
            --info-color: #60A5FA;

            /* Backgrounds */
            --background-color: #ffffff;
            --card-background: #eefdff;

            /* Text Colors */
            --text-primary: #1e293b;
            --text-secondary: #d0898d;

            /* Borders & Accents */
            --border-color: #d0898d;
            --Navbar-bg: #ffffff;
            --Navbar-hover: #ecdbeb;
            --Navbar-active-bg: #57b8bf;
            --Navbar-active-text: #ffffff;
            --accent-color: #57b8bf;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background: var(--background-color);
            min-height: 100vh;
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
        
        .logo-text { color: var(--primary-color); transition: var(--transition); }
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
                border-bottom: 1px solid var(--border-color);
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
                border-bottom: 1px solid var(--border-color);
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
                border-color: var(--primary-color);
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

        .customer-logo-text { color: var(--primary-color); transition: var(--transition); }
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
                border-bottom: 1px solid var(--border-color);
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
                border-bottom: 1px solid var(--border-color);
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
                border-color: var(--primary-color);
            }
        }

        .customer-main-content {
            margin-top: 100px;
            padding: 0 2rem;
        }

        /* ===== MANAGER/ADMIN NAVIGATION (Sidebar Only) ===== */
        /* Sidebar styles are now in css/sidebar.css */

        /* ===== STAFF NAVIGATION (Horizontal Tabs) ===== */
        .staff-layout {
            min-height: 100vh;
        }

        .staff-navbar {
            background: white;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .staff-tabs {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            gap: 0.5rem;
            padding: 0 2rem;
            overflow-x: auto;
            justify-content: flex-end;
        }

        .staff-tab {
            background: rgba(99, 102, 241, 0.1);
            color: #6366f1;
            text-decoration: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            white-space: nowrap;
            border: 1px solid rgba(99, 102, 241, 0.2);
        }

        .staff-tab:hover,
        .staff-tab.active {
            background: #6366f1;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .staff-main-content {
            margin-top: 80px;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(0deg, rgba(15,23,42,0.55), rgba(15,23,42,0.55)), url('IMG/store.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 8rem 2rem 4rem;
            text-align: center;
            color: white;
        }
        
        .page-header h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .page-header p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        /* Contact Section */
        .contact {
            padding: 5rem 2rem;
            background: var(--Navbar-bg);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px var(--border-color);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .contact-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
        }
        
        .contact-info h3 { margin-bottom: 1rem; color: var(--primary-color); font-size: 1.8rem; }
        
        .contact-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: var(--Navbar-bg);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 5px 15px var(--border-color);
        }
        
        .contact-item:hover {
            transform: translateX(5px);
            background: var(--card-background);
            box-shadow: 0 10px 25px var(--border-color);
        }
        
        .contact-item i { margin-right: 1rem; color: var(--primary-color); font-size: 1.5rem; width: 30px; text-align: center; }
        
        .contact-item span { color: var(--text-secondary); }
        
        .contact-item strong { color: var(--primary-color); display: block; margin-bottom: 0.2rem; }
        
        /* Contact Form */
        .contact-form {
            background: var(--Navbar-bg);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px var(--border-color);
        }
        
        .contact-form h3 { margin-bottom: 1.5rem; color: var(--primary-color); font-size: 1.8rem; }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
            font-weight: 500;
        }
        
        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 2px var(--Navbar-hover);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .submit-btn {
            background: var(--primary-color);
            color: var(--Navbar-active-text);
            padding: 1rem 2rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            width: 100%;
        }
        
        .submit-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px var(--border-color);
        }
        
        /* FAQ Section */
        .faq {
            padding: 5rem 2rem;
            background: var(--Navbar-bg);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px var(--border-color);
        }
        
        .faq h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--primary-color);
        }
        
        .faq-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
        }
        
        .faq-item {
            background: var(--Navbar-bg);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .faq-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px var(--border-color);
        }
        
        .faq-item h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }
        
        .faq-item p {
            color: var(--text-secondary);
            line-height: 1.6;
        }
        
        /* Map Section */
        .map-section {
            padding: 3rem 2rem;
            background: var(--Navbar-bg);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px var(--border-color);
        }
        
        .map-container {
            background: var(--Navbar-bg);
            height: 400px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.5rem;
            border: 2px dashed var(--border-color);
        }
        
        /* Business Hours */
        .business-hours {
            padding: 3rem 2rem;
            background: var(--Navbar-bg);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px var(--border-color);
        }
        
        .hours-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        
        .hours-item {
            background: var(--Navbar-bg);
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .hours-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px var(--border-color);
        }
        
        .hours-item h4 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .hours-item p {
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: var(--Navbar-active-text);
            text-align: center;
            padding: 2rem;
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
            
            /* Sidebar responsive styles are now in css/sidebar.css */
            
            .customer-main-content {
                margin-top: 120px;
                padding: 0 1rem;
            }
            
            .staff-tabs {
                padding: 0 1rem;
            }
            
            .page-header h1 {
                font-size: 2.5rem;
            }
            
            .contact-content {
                grid-template-columns: 1fr;
            }
            
            .faq-grid {
                grid-template-columns: 1fr;
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
                    <li><a href="contact.jsp" class="active">Contact</a></li>
                    <li><a href="login.jsp" class="login-btn">Login</a></li>
                </ul>
            </div>
        </nav>

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
                        <li><a href="BookCategoryServlet?action=list&redirect=categories.jsp">Categories</a></li>
                        <li><a href="dashboard.jsp">My Profile</a></li>
                        <li><a href="orders.jsp">My Orders</a></li>
                        <li><a href="wishlist.jsp">Wishlist</a></li>
                        <li><a href="contact.jsp" class="active">Contact</a></li>
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
            <!-- <main class="customer-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Contact Us</h1>
                        <p>Get in touch with us for any questions, support, or feedback.</p>
                    </div>
                </div>
            </main> -->
       

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
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
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
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
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
                }
                %>
            </aside>

    <% } else if ("staff".equals(navType)) { %>
        <!-- STAFF NAVIGATION (Horizontal Tabs) -->
        <div class="staff-layout">
            <nav class="staff-navbar">
                <div class="staff-tabs">
                    <a href="welcome.jsp" class="staff-tab"><i class="fas fa-home"></i> Dashboard</a>
                    <a href="books.jsp" class="staff-tab"><i class="fas fa-book"></i> Books</a>
                    <a href="categories.jsp" class="staff-tab"><i class="fas fa-tags"></i> Categories</a>
                    <a href="orders.jsp" class="staff-tab"><i class="fas fa-shopping-cart"></i> Orders</a>
                    <a href="customers.jsp" class="staff-tab"><i class="fas fa-users"></i> Customers</a>
                    <a href="LogoutServlet" class="staff-tab"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </nav>
    <% } %>

    <!-- Page Header -->
    <section class="page-header">
        <h1>Contact Us</h1>
        <p>We'd love to hear from you. Get in touch with us for any questions or support.</p>
    </section>

    <!-- Contact Section -->
    <section class="contact">
        <div class="container">
            <div class="contact-content">
                <div class="contact-info">
                    <h3>Get in Touch</h3>
                    <div class="contact-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <strong>Address</strong>
                            <span>123 Galle Road, Colombo 04, Sri Lanka</span>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-phone"></i>
                        <div>
                            <strong>Phone</strong>
                            <span>+94 11 234 5678</span>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-envelope"></i>
                        <div>
                            <strong>Email</strong>
                            <span>support@pahana-edu.lk</span>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-clock"></i>
                        <div>
                            <strong>Business Hours</strong>
                            <span>Mon–Sat: 9:00 AM – 7:00 PM, Sun: 10:00 AM – 5:00 PM</span>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-globe"></i>
                        <div>
                            <strong>Website</strong>
                            <span>www.pahana-edu.lk</span>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-comments"></i>
                        <div>
                            <strong>Live Chat</strong>
                            <span>Available 24/7 for instant support</span>
                        </div>
                    </div>
                </div>
                <div class="contact-form">
                    <h3>Send us a Message</h3>
                    <form id="contactForm">
                        <div class="form-group">
                            <label for="name">Full Name *</label>
                            <input type="text" id="name" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email Address *</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone">
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject *</label>
                            <select id="subject" name="subject" required>
                                <option value="">Select a subject</option>
                                <option value="general">General Inquiry</option>
                                <option value="order">Order Status</option>
                                <option value="return">Returns & Refunds</option>
                                <option value="technical">Technical Support</option>
                                <option value="feedback">Feedback</option>
                                <option value="partnership">Partnership</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="message">Message *</label>
                            <textarea id="message" name="message" placeholder="Please describe your inquiry in detail..." required></textarea>
                        </div>
                        <button type="submit" class="submit-btn">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq">
        <div class="container">
            <h2>Frequently Asked Questions</h2>
            <div class="faq-grid">
                <div class="faq-item">
                    <h3>How do I place an order?</h3>
                    <p>You can place an order by browsing our book collection, adding items to your cart, and proceeding to checkout. We accept all major credit cards and PayPal.</p>
                </div>
                <div class="faq-item">
                    <h3>What is your return policy?</h3>
                    <p>We offer a 30-day return policy for all books in their original condition. Simply contact our customer service team to initiate a return.</p>
                </div>
                <div class="faq-item">
                    <h3>Do you ship internationally?</h3>
                    <p>Yes, we ship to most countries worldwide. Shipping costs and delivery times vary by location. You can check shipping options during checkout.</p>
                </div>
                <div class="faq-item">
                    <h3>How can I track my order?</h3>
                    <p>Once your order ships, you'll receive a tracking number via email. You can also track your order by logging into your account.</p>
                </div>
                <div class="faq-item">
                    <h3>Do you offer bulk discounts?</h3>
                    <p>Yes, we offer special pricing for bulk orders and educational institutions. Please contact our sales team for more information.</p>
                </div>
                <div class="faq-item">
                    <h3>Can I cancel my order?</h3>
                    <p>Orders can be cancelled within 24 hours of placement, provided they haven't been shipped yet. Contact our customer service team immediately.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Business Hours -->
    <section class="business-hours">
        <div class="container">
                         <h2 style="text-align: center; font-size: 2.5rem; margin-bottom: 3rem; color: var(--primary-color);">Business Hours</h2>
            <div class="hours-grid">
                <div class="hours-item">
                    <h4>Monday - Friday</h4>
                    <p>9:00 AM - 6:00 PM</p>
                </div>
                <div class="hours-item">
                    <h4>Saturday</h4>
                    <p>10:00 AM - 4:00 PM</p>
                </div>
                <div class="hours-item">
                    <h4>Sunday</h4>
                    <p>Closed</p>
                </div>
                <div class="hours-item">
                    <h4>Holidays</h4>
                    <p>Limited Hours</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Map Section -->
    <section class="map-section">
        <div class="container">
                         <h2 style="text-align: center; font-size: 2.5rem; margin-bottom: 3rem; color: var(--primary-color);">Find Us</h2>
            <div class="map-container">
                <div style="text-align: center;">
                    <i class="fas fa-map-marked-alt" style="font-size: 3rem; margin-bottom: 1rem; display: block;"></i>
                    <p>Interactive Map Coming Soon</p>
                    <p style="font-size: 1rem; margin-top: 1rem;">123 Galle Road, Colombo 04, Sri Lanka</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 BookShop. All rights reserved. | Your trusted source for quality books and knowledge.</p>
    </footer>

    <script src="js/sidebar.js"></script>
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

        // Contact form submission
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form data
            const formData = new FormData(this);
            const name = formData.get('name');
            const email = formData.get('email');
            const subject = formData.get('subject');
            const message = formData.get('message');
            
            // Simple validation
            if (!name || !email || !subject || !message) {
                alert('Please fill in all required fields.');
                return;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('Please enter a valid email address.');
                return;
            }
            
            // Simulate form submission
            alert('Thank you for your message! We will get back to you soon.\n\nName: ' + name + '\nEmail: ' + email + '\nSubject: ' + subject);
            
            // Reset form
            this.reset();
        });

        // Form field focus effects
        document.querySelectorAll('.form-group input, .form-group textarea, .form-group select').forEach(field => {
            field.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            field.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    </script>
    
    <!-- Contact.js - Modern Navbar and Contact Form Functionality -->
    <script src="js/contact.js"></script>
</body>
</html> 