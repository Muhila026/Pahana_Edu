<%-- 
    Document   : about
    Created on : Aug 4, 2025, 6:17:17 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
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
        
        .logo-text { color: var(--primary-color); transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        .logo:hover .logo-text { color: var(--secondary-color); }
        
        .logo:hover .logo-text {
            background-position: 100% 0;
        }
        
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
        .nav-menu a.active { color: var(--Navbar-active-bg); border-bottom-color: var(--Navbar-active-bg); }
        
        .nav-menu a.active {
            font-weight: 600;
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
            box-shadow: 0 4px 12px rgba(13, 30, 76, 0.3);
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
            
            .login-btn {
                margin: 10px 20px;
                border-radius: 6px;
            }
        }

        /* ===== CUSTOMER NAVIGATION (Top Navbar Only) ===== */
        .customer-layout {
            min-height: 100vh;
        }

        .customer-navbar {
            background: var(--Navbar-bg);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
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
            border-right: 1px solid rgba(0, 0, 0, 0.1);
        }

        .customer-logo-text { color: var(--primary-color); }

        .customer-logo:hover .customer-logo-text {
            background-position: 100% 0;
        }

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
            color: var(--text-color);
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
            color: var(--primary-color);
            border-bottom-color: var(--primary-color);
        }

        .customer-nav-menu a.active {
            font-weight: 600;
        }

        .customer-user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: #1e293b;
        }

        .customer-user-info .welcome-text {
            font-weight: 600;
            color: #8b5cf6;
            background: rgba(139, 92, 246, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            border: 1px solid rgba(139, 92, 246, 0.2);
        }

        .customer-logout-btn {
            background: var(--primary-color);
            color: white !important;
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
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .customer-main-content {
            margin-top: 100px;
            padding: 0 2rem;
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

        /* ===== MANAGER/ADMIN NAVIGATION (Sidebar Only) ===== */
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
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            gap: 0.5rem;
            padding: 0 2rem;
            overflow-x: auto;
            justify-content: flex-end;
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
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-hover) 100%);
            padding: 8rem 2rem 4rem;
            text-align: center;
            color: var(--Navbar-active-text);
        }
        
        .page-header h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .page-header p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        /* About Section */
        .about {
            padding: 5rem 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .about-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            align-items: center;
        }
        
        .about-text h2 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
        }
        
        .about-text p {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            color: var(--text-secondary);
        }
        
        .about-image {
            background: url('IMG/books.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 400px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--Navbar-active-text);
            font-size: 4rem;
        }

        /* Highlights */
        .highlights { padding: 5rem 2rem; background: linear-gradient(135deg, var(--background-color) 0%, var(--card-background) 100%); }
        .highlight-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .highlight-card { background: var(--card-background); padding: 2rem; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); border: 1px solid var(--border-color); transition: transform 0.2s ease; }
        .highlight-card:hover { transform: translateY(-6px); }
        .highlight-card h3 { color: var(--primary-color); margin-bottom: 0.5rem; }
        .highlight-card p { color: var(--text-secondary); }

        /* Stats */
        .stats { padding: 4rem 2rem; background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-hover) 100%); color: var(--Navbar-active-text); }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }
        .stat-card { background: rgba(255,255,255,0.08); padding: 1.5rem; border-radius: 14px; border: 1px solid rgba(255,255,255,0.15); }
        .stat-card h3 { margin: 0; font-size: 2rem; }
        .stat-card p { margin: 0.5rem 0 0; opacity: 0.95; }

        /* Store Info */
        .store-info {
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .store-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
        .store-card { background: var(--Navbar-bg); border: 1px solid var(--border-color); border-radius: 12px; padding: 1.5rem; }
        .store-card h3 { color: var(--primary-color); margin-bottom: 0.5rem; }
        .store-card p { color: var(--text-secondary); margin: 0.25rem 0; }

        @media (max-width: 768px) {
            .store-grid { grid-template-columns: 1fr; }
        }
        
        /* Mission & Vision */
        .mission-vision {
            padding: 5rem 2rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .mission-vision-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .mission-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .mission-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
        }
        
        .mission-card h3 {
            font-size: 1.8rem;
            margin-bottom: 1rem;
            color: #6366f1;
        }
        
        .mission-card p {
            color: #666;
            font-size: 1.1rem;
        }
        
        /* Team Section */
        .team {
            padding: 5rem 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            margin: 2rem auto;
            max-width: 1200px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }
        
        .team-member {
            background: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
        }
        
        .team-member img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto 1rem;
            box-shadow: 0 6px 18px rgba(0,0,0,0.12);
            border: 3px solid #fff;
        }
        
        .team-member h3 {
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }
        
        .team-member p {
            color: #666;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            color: white;
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
            
            .page-header h1 {
                font-size: 2.5rem;
            }
            
            .about-content {
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
                    <li><a href="about.jsp" class="active">About</a></li>
                    <li><a href="BookServlet?action=list&redirect=books.jsp">Books</a></li>
                    <li><a href="BookCategoryServlet?action=list&redirect=categories.jsp">Categories</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
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
                        <li><a href="about.jsp" class="active">About</a></li>
                        <li><a href="BookServlet?action=list&redirect=books.jsp">Books</a></li>
                        <li><a href="BookCategoryServlet?action=list&redirect=categories.jsp">Categories</a></li>
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
                    <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> POS</a></li>
                    <li><a href="transaction.jsp"><i class="fas fa-exchange-alt"></i> Transaction</a></li>
                    <li><a href="customer.jsp"><i class="fas fa-users"></i> Customer</a></li>
                    <li><a href="BookCategoryServlet?action=list&redirect=book_category.jsp"><i class="fas fa-tags"></i> Book Categories</a></li>
                    <li><a href="book.jsp"><i class="fas fa-book"></i> Book</a></li>
                    <li><a href="stock.jsp"><i class="fas fa-boxes"></i> Stock</a></li>
                    <li><a href="user.jsp"><i class="fas fa-user"></i> User</a></li>
                    <li><a href="user_role.jsp"><i class="fas fa-user-tag"></i> UserRole</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("manager".equals(navType)) {
                %>
                <!-- MANAGER SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> POS</a></li>
                    <li><a href="transaction.jsp"><i class="fas fa-exchange-alt"></i> Transaction</a></li>
                    <li><a href="customer.jsp"><i class="fas fa-users"></i> Customer</a></li>
                    <li><a href="BookCategoryServlet?action=list&redirect=book_category.jsp"><i class="fas fa-tags"></i> Book Categories</a></li>
                    <li><a href="book.jsp"><i class="fas fa-book"></i> Book</a></li>
                    <li><a href="stock.jsp"><i class="fas fa-boxes"></i> Stock</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
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
                <a href="dashboard.jsp" class="staff-tab"><i class="fas fa-home"></i> Dashboard</a>
                <a href="pos.jsp" class="staff-tab"><i class="fas fa-cash-register"></i> POS</a>
                <a href="transaction.jsp" class="staff-tab"><i class="fas fa-exchange-alt"></i> Transaction</a>
                <a href="customer.jsp" class="staff-tab"><i class="fas fa-users"></i> Customer</a>
                <a href="profile.jsp" class="staff-tab"><i class="fas fa-user-circle"></i> Profile</a>
                <a href="help.jsp" class="staff-tab"><i class="fas fa-question-circle"></i> Help</a>
                <a href="LogoutServlet" class="staff-tab"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
            </nav>
    <% } %>

    <!-- Page Header -->
    <section class="page-header">
        <h1>About Pahana BookShop</h1>
        <p>Colombo’s community-first bookstore and e-commerce platform connecting readers with great books, fair prices, and friendly service.</p>
    </section>

    <!-- About Section -->
    <section class="about">
        <div class="container">
            <div class="about-content">
                <div class="about-text">
                    <h2>Our Story</h2>
                    <p>Pahana BookShop began as a small, family-run store in Colombo and has grown into a modern hybrid bookstore—combining a warm in-store experience with an easy-to-use online platform.</p>
                    <p>We specialize in school and university texts, competitive exam prep, Sinhala and English literature, and a curated range of business, technology, and personal development titles. Our goal is to make learning accessible and enjoyable for everyone—from young students to lifelong learners.</p>
                    <p>With real‑time stock, secure checkout, and fast pickup or delivery, we serve thousands of customers each month while keeping our community feel—personal recommendations, seasonal reading lists, and special events.</p>
                </div>
                <div class="about-image" aria-label="Inside Pahana BookShop"></div>
            </div>
        </div>
    </section>

    <!-- Highlights -->
    <section class="highlights">
        <div class="highlight-grid">
            <div class="highlight-card">
                <h3>School & Exam Books</h3>
                <p>From Grade 1 to A/L, past papers, model papers, and study guides.</p>
            </div>
            <div class="highlight-card">
                <h3>University & Professional</h3>
                <p>Engineering, IT, Accounting, Medicine, Law, and more.</p>
            </div>
            <div class="highlight-card">
                <h3>Literature & Kids</h3>
                <p>Sinhala/English novels, story books, activity books, and comics.</p>
            </div>
            <div class="highlight-card">
                <h3>Stationery & Gifts</h3>
                <p>Notebooks, art supplies, planners, and gift packs for every occasion.</p>
            </div>
        </div>
    </section>

    <!-- Mission & Vision -->
    <section class="mission-vision">
        <div class="container">
            <div class="mission-vision-grid">
                <div class="mission-card">
                    <h3>Our Mission</h3>
                    <p>Make quality learning resources affordable and accessible, while offering genuine guidance that helps every reader choose the right book for their journey.</p>
                </div>
                <div class="mission-card">
                    <h3>Our Vision</h3>
                    <p>Be Sri Lanka’s most trusted education-focused bookstore—online and offline—known for service, selection, and community impact.</p>
                </div>
                <div class="mission-card">
                    <h3>Our Values</h3>
                    <p>Integrity, student success, inclusivity, and continuous improvement. We partner with parents, teachers, and institutions to support learning outcomes.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats -->
    <section class="stats">
        <div class="stats-grid">
            <div class="stat-card"><h3>25,000+</h3><p>Titles in stock</p></div>
            <div class="stat-card"><h3>10,000+</h3><p>Students served yearly</p></div>
            <div class="stat-card"><h3>48h</h3><p>Average delivery in Colombo</p></div>
            <div class="stat-card"><h3>4.8/5</h3><p>Customer rating</p></div>
        </div>
    </section>

    <!-- Store Info / Visit Us -->
    <section class="store-info">
        <div class="store-grid">
            <div class="store-card">
                <h3>Visit Our Store</h3>
                <p>123 Galle Road, Colombo 04</p>
                <p>Mon–Sat: 9:00 AM – 7:00 PM | Sun: 10:00 AM – 5:00 PM</p>
                <p>Hotline: +94 11 234 5678</p>
            </div>
            <div class="store-card">
                <h3>Bulk & Institutional Orders</h3>
                <p>Email: sales@pahana-edu.lk</p>
                <p>We support schools, tuition classes, and companies with quotations and delivery.</p>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="team">
        <div class="container">
                         <h2 style="text-align: center; font-size: 2.5rem; margin-bottom: 3rem; color: #6366f1;">Our Team</h2>
            <div class="team-grid">
                <div class="team-member">
                    <img src="IMG/admin.jpg" alt="Founder & CEO">
                    <h3>Nimal Perera</h3>
                    <p>Founder & Admin</p>
                </div>
                <div class="team-member">
                    <img src="IMG/manager.jpg" alt="Head of Operations">
                    <h3>Tharanga Fernando</h3>
                    <p>Manager</p>
                </div>
                <div class="team-member">
                    <img src="IMG/staff.jpg" alt="Lead Developer">
                    <h3>Chaminda Silva</h3>
                    <p>Employee</p>
                </div>
                <div class="team-member">
                    <img src="IMG/staff2.jpg" alt="Creative Director">
                    <h3>Kavindi Jayasinghe</h3>
                    <p>Employee</p>
                </div>
            </div>
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
    </script>
</body>
</html> 