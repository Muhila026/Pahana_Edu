<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* ===== CSS VARIABLES ===== */
        :root {
            --primary-color: #6366f1; /* Modern indigo */
            --secondary-color: #8b5cf6; /* Modern violet */
            --accent-color: #a855f7; /* Modern purple */
            --text-color: #1e293b; /* Dark blue-gray */
            --light-color: #f8fafc; /* Light gray */
            --hover-color: #4f46e5;
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
            color: #333;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            min-height: 100vh;
        }

        /* ===== PUBLIC NAVIGATION (Top Navbar Only) ===== */
        .public-navbar {
            background: white;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
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
            color: #6366f1;
            text-decoration: none;
            letter-spacing: -0.5px;
            padding: 18px 20px 18px 0;
            display: flex;
            align-items: center;
            border-right: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .logo-text {
            background: linear-gradient(90deg, #6366f1, #8b5cf6, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            background-size: 200% auto;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
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
            color: #1e293b;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            border-bottom: 2px solid transparent;
        }
        
        .nav-menu a:hover,
        .nav-menu a.active {
            color: #6366f1;
            border-bottom-color: #6366f1;
        }
        
        .nav-menu a.active {
            font-weight: 600;
        }
        
        .login-btn {
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            color: white !important;
            font-weight: 600 !important;
            border-radius: 6px;
            margin: 7px 0;
            padding: 8px 16px !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
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
            background: white;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
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
            color: #6366f1;
            text-decoration: none;
            letter-spacing: -0.5px;
            padding: 18px 20px 18px 0;
            display: flex;
            align-items: center;
            border-right: 1px solid rgba(0, 0, 0, 0.1);
        }

        .customer-logo-text {
            background: linear-gradient(90deg, #6366f1, #8b5cf6, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            background-size: 200% auto;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

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
            color: #1e293b;
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
            color: #6366f1;
            border-bottom-color: #6366f1;
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
            background: linear-gradient(90deg, #ef4444, #dc2626);
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
                margin-left: 0;
                justify-content: center;
            }
            
            .customer-logout-btn {
                margin: 10px 20px;
                border-radius: 6px;
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
            color: #6366f1;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #666;
        }

        /* Page Header for Public */
        .public-page-header {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            text-align: center;
            padding: 120px 2rem 80px;
            margin-bottom: 4rem;
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

        /* Search Form */
        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin: -2rem auto 3rem;
            max-width: 800px;
            position: relative;
            z-index: 10;
        }

        .search-form {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #6366f1;
        }

        .form-group input,
        .form-group select {
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #8b5cf6;
        }

        .search-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        /* Books Section */
        .books {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem 4rem;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .book-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .book-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
        }

        .book-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .book-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
            color: #8b5cf6;
        }

        .book-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
            line-height: 1.3;
        }

        .book-author {
            color: #666;
            margin-bottom: 1rem;
            font-style: italic;
        }

        .book-category {
            background: rgba(99, 102, 241, 0.1);
            color: #6366f1;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .book-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .book-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #6366f1;
        }

        .book-stock {
            background: rgba(99, 102, 241, 0.1);
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
            color: #6366f1;
        }

        .view-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            text-decoration: none;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            display: inline-block;
            transition: all 0.3s ease;
            font-weight: 500;
            width: 100%;
            text-align: center;
        }

        .view-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.4);
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
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
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
            
            .search-form {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .books-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .book-card {
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
                    <li><a href="books.jsp">Books</a></li>
                    <li><a href="categories.jsp">Categories</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                    <li><a href="login.jsp" class="login-btn">Login</a></li>
                </ul>
            </div>
        </nav>

        <!-- Page Header -->
        <section class="public-page-header">
            <h1>Our Book Collection</h1>
            <p>Discover thousands of books from classic literature to modern bestsellers. Find your next favorite read in our carefully curated collection.</p>
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
                        <li><a href="books.jsp" class="active">Books</a></li>
                        <li><a href="categories.jsp">Categories</a></li>
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
                        <h1>Our Book Collection</h1>
                        <p>Discover amazing books and find your next favorite read.</p>
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
                        <h1>Book Management</h1>
                        <p>Manage your book inventory and help customers find their perfect reads.</p>
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
                    <a href="books.jsp" class="staff-tab active"><i class="fas fa-book"></i> Books</a>
                    <a href="categories.jsp" class="staff-tab"><i class="fas fa-tags"></i> Categories</a>
                    <a href="orders.jsp" class="staff-tab"><i class="fas fa-shopping-cart"></i> Orders</a>
                    <a href="customers.jsp" class="staff-tab"><i class="fas fa-users"></i> Customers</a>
                    <a href="LogoutServlet" class="staff-tab"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="staff-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Book Collection</h1>
                        <p>Help customers explore and find the perfect books.</p>
                    </div>
                </div>
            </main>
        </div>
    <% } %>

    <!-- Search Section -->
    <div class="search-section">
        <form action="BookServlet" method="GET" class="search-form">
            <input type="hidden" name="action" value="search">
            <div class="form-group">
                <label for="searchTerm">Search Books</label>
                <input type="text" id="searchTerm" name="searchTerm" 
                       placeholder="Search by title or author..." 
                       value="${searchTerm != null ? searchTerm : ''}">
            </div>
            <div class="form-group">
                <label for="categoryFilter">Category</label>
                <select id="categoryFilter" name="categoryFilter">
                    <option value="all">All Categories</option>
                    <%
                    java.util.List<com.pahana.CategoryServlet.Category> categories = 
                        (java.util.List<com.pahana.CategoryServlet.Category>) request.getAttribute("categories");
                    if (categories != null) {
                        for (com.pahana.CategoryServlet.Category category : categories) {
                            String selected = (request.getAttribute("categoryFilter") != null && 
                                             request.getAttribute("categoryFilter").equals(String.valueOf(category.getCategoryId()))) ? "selected" : "";
                    %>
                        <option value="<%= category.getCategoryId() %>" <%= selected %>><%= category.getCategoryName() %></option>
                    <%
                        }
                    }
                    %>
                </select>
            </div>
            <button type="submit" class="search-btn">
                <i class="fas fa-search"></i> Search
            </button>
        </form>
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

    <!-- Books Section -->
    <section class="books">
        <div class="books-grid">
            <%
            // Get books from request attribute
            java.util.List<com.pahana.BookServlet.Book> books = 
                (java.util.List<com.pahana.BookServlet.Book>) request.getAttribute("books");
            
            if (books != null && !books.isEmpty()) {
                for (com.pahana.BookServlet.Book book : books) {
            %>
                <div class="book-card">
                    <span class="book-icon">📖</span>
                    <h3 class="book-title"><%= book.getTitle() %></h3>
                    <p class="book-author">by <%= book.getAuthor() != null ? book.getAuthor() : "Unknown Author" %></p>
                    <span class="book-category"><%= book.getCategoryName() != null ? book.getCategoryName() : "Uncategorized" %></span>
                    <div class="book-details">
                        <span class="book-price">$<%= book.getPrice() != null ? book.getPrice().toString() : "0.00" %></span>
                        <span class="book-stock">
                            <i class="fas fa-boxes"></i> <%= book.getStockQuantity() %> in stock
                        </span>
                    </div>
                    <a href="BookServlet?action=view&bookId=<%= book.getBookId() %>" class="view-btn">
                        <i class="fas fa-eye"></i> View Details
                    </a>
                </div>
            <%
                }
            } else {
            %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 3rem;">
                    <h3 style="color: #6366f1; margin-bottom: 1rem;">No Books Found</h3>
                    <p style="color: #666;">No books match your search criteria. Try adjusting your search terms.</p>
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

        // Load books from servlet if not already loaded
        window.addEventListener('load', function() {
            // Check if books are already loaded (from servlet)
            const books = document.querySelectorAll('.book-card');
            if (books.length === 0 || (books.length === 1 && books[0].textContent.includes('No books'))) {
                // Redirect to servlet to load books
                window.location.href = 'BookServlet?action=list';
            }
        });
    </script>
</body>
</html> 