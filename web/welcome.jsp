<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookShop - Your Gateway to Knowledge</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/sidebar.css">
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
        
        .welcome-user {
            color: #8b5cf6 !important;
            font-weight: 600 !important;
            padding: 18px 16px !important;
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
                margin-left: 0;
                justify-content: center;
            }
            
            .customer-logout-btn {
                margin: 10px 20px;
                border-radius: 6px;
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
            gap: 0.8rem;
            padding: 0 20px;
            overflow-x: auto;
            justify-content: flex-end;
        }

        .staff-tab {
            background: rgba(99, 102, 241, 0.05);
            color: #1e293b;
            text-decoration: none;
            padding: 18px 16px;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            white-space: nowrap;
            position: relative;
            border: 1px solid rgba(99, 102, 241, 0.1);
            font-size: 0.95rem;
            border-bottom: 2px solid transparent;
        }

        .staff-tab:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #6366f1;
            border-bottom-color: #6366f1;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.1);
        }

        .staff-tab.active {
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            color: white;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            border-color: #6366f1;
            border-bottom-color: #6366f1;
        }
        
        @media (max-width: 991px) {
            .staff-tabs {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .staff-tab {
                padding: 14px 20px;
                border-radius: 6px;
            }
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
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
            text-align: center;
            border: 1px solid rgba(99, 102, 241, 0.1);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
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

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            padding: 0 2rem;
            margin-top: 70px;
        }
        
        .hero-content h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            animation: fadeInUp 1s ease;
        }
        
        .hero-content p {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            animation: fadeInUp 1s ease 0.2s both;
        }
        
        .cta-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 1s ease 0.4s both;
        }
        
        .cta-btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }
        
        .cta-primary {
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: white;
        }
        
        .cta-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .cta-primary:hover::before {
            left: 100%;
        }
        
        .cta-primary:hover {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(251, 191, 36, 0.3);
        }
        
        .cta-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .cta-secondary:hover {
            background: white;
            color: #6366f1;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 255, 255, 0.3);
        }
        
        /* Features Section */
        .features {
            padding: 5rem 2rem;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .section-title {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #6366f1;
            font-weight: 700;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .feature-card {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(99, 102, 241, 0.1);
            position: relative;
            overflow: hidden;
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        
        .feature-card:hover::before {
            transform: scaleX(1);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
            border-color: rgba(99, 102, 241, 0.3);
        }
        
        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #6366f1;
            font-weight: 600;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: #fbbf24;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            color: #f59e0b;
        }
        
        .feature-card p {
            color: #64748b;
            line-height: 1.7;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 4rem;
        }
        
        .footer p {
            margin: 0;
            opacity: 0.9;
            font-weight: 500;
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
            
            .hero-content h1 {
                font-size: 2.5rem;
            }
            
            .hero-content p {
                font-size: 1.1rem;
            }
            
            .cta-buttons {
                flex-direction: column;
                gap: 1rem;
            }
            
            .cta-btn {
                width: 80%;
                margin: 0 auto;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .features-grid {
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
            
            .hero-content h1 {
                font-size: 2rem;
            }
            
            .hero-content p {
                font-size: 1rem;
            }
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
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

        <!-- Hero Section -->
        <section id="home" class="hero">
            <div class="hero-content">
                <h1>Welcome to Pahana BookShop</h1>
                <p>Discover thousands of books from classic literature to modern bestsellers. Your journey into the world of knowledge starts here.</p>
                <div class="cta-buttons">
                    <a href="register.jsp" class="cta-btn cta-primary">Get Started</a>
                    <a href="books.jsp" class="cta-btn cta-secondary">Browse Books</a>
                </div>
            </div>
        </section>

    <% } else if ("customer".equals(navType)) { %>
        <!-- CUSTOMER NAVIGATION (Top Navbar Only) - Using Public Style -->
        <div class="customer-layout">
            <!-- Navbar -->
            <nav class="public-navbar">
                <div class="nav-container">
                    <a href="welcome.jsp" class="logo">
                        <span class="logo-text">Pahana BookShop</span>
                    </a>
                    <ul class="nav-menu">
                        <li><a href="welcome.jsp" class="active">Home</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="BookServlet?action=list&redirect=books.jsp">Books</a></li>
                        <li><a href="BookCategoryServlet?action=list&redirect=categories.jsp">Categories</a></li>
                        <li><a href="orders.jsp">My Orders</a></li>
                        <li><a href="wishlist.jsp">Wishlist</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                        <li><a href="profile.jsp">My Profile</a></li>
                        <%
                        // Get customer full name from session
                        String customerName = (String) session.getAttribute("customerName");
                        String displayName = (customerName != null && !customerName.trim().isEmpty()) ? customerName : username;
                        %>
                        <li><span style="color: #ffaf24; font-weight: 500;">Welcome, <%= displayName %></span></li>
                        <li><a href="LogoutServlet" class="login-btn">Logout</a></li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="customer-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Welcome back, <%= displayName %>!</h1>
                        <p>You're logged in as a Customer. Discover amazing books and enjoy your reading journey with us.</p>
                    </div>
                    
                    <!-- Customer Dashboard Content -->
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">📖</div>
                            <h3>Browse Books</h3>
                            <p>Explore our vast collection of books across all genres and categories.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">🛒</div>
                            <h3>My Orders</h3>
                            <p>Track your orders and view your purchase history.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">❤️</div>
                            <h3>Wishlist</h3>
                            <p>Save books you want to read later in your personal wishlist.</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>

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
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("manager".equals(navType)) {
                %>
                <!-- MANAGER SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("staff".equals(navType)) {
                %>
                <!-- STAFF SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
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
                        <h1><%= "admin".equals(navType) ? "Admin" : "Manager" %> Dashboard</h1>
                        <p>Welcome back, <%= username %>! Manage your bookstore and help customers find their perfect books.</p>
                    </div>
                    
                    <!-- Admin/Manager Dashboard Content -->
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">📚</div>
                            <h3>Book Management</h3>
                            <p>Add, edit, and manage books in your inventory.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">🏷️</div>
                            <h3>Category Management</h3>
                            <p>Organize books with categories and tags.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">👥</div>
                            <h3>User Management</h3>
                            <p>Manage customer accounts and staff members.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">📊</div>
                            <h3>Reports & Analytics</h3>
                            <p>View sales reports and customer analytics.</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>

    <% } else if ("staff".equals(navType)) { %>
        <!-- STAFF NAVIGATION (Horizontal Tabs) -->
        <div class="staff-layout">
            <nav class="staff-navbar">
                <div class="staff-tabs">
                    <a href="welcome.jsp" class="staff-tab active"><i class="fas fa-home"></i> Dashboard</a>
                    <a href="pos.jsp" class="staff-tab"><i class="fas fa-cash-register"></i> POS</a>
                    <a href="books.jsp" class="staff-tab"><i class="fas fa-book"></i> Books</a>
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
                        <h1>Staff Dashboard</h1>
                        <p>Welcome back, <%= username %>! Help customers and manage daily operations.</p>
                    </div>
                    
                    <!-- Staff Dashboard Content -->
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">📖</div>
                            <h3>Book Assistance</h3>
                            <p>Help customers find the perfect books and manage inventory.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">🛒</div>
                            <h3>Order Processing</h3>
                            <p>Process customer orders and handle order inquiries.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">👥</div>
                            <h3>Customer Support</h3>
                            <p>Provide excellent customer service and support.</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    <% } %>

    <!-- Features Section (for public users) -->
    <% if ("public".equals(navType)) { %>
        <section class="features">
            <div class="container">
                <h2 class="section-title">Why Choose BookShop?</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">📚</div>
                        <h3>Vast Collection</h3>
                        <p>Access thousands of books across all genres, from classic literature to modern bestsellers.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🚚</div>
                        <h3>Fast Delivery</h3>
                        <p>Quick and reliable delivery to your doorstep with secure packaging.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">💰</div>
                        <h3>Best Prices</h3>
                        <p>Competitive prices and regular discounts to make reading affordable for everyone.</p>
                    </div>
                </div>
            </div>
        </section>
    <% } %>

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
                    navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                    navbar.style.boxShadow = '0 8px 25px -1px rgba(0, 0, 0, 0.1), 0 4px 6px -1px rgba(0, 0, 0, 0.06)';
                } else {
                    navbar.style.background = 'white';
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
