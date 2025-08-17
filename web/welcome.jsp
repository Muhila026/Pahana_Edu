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
                /* Brand Colors */
                --primary-color: #b1081b;       /* Strong maroon/red - brand & emphasis */
                --primary-hover: #8a0615;       /* Darker maroon for hover */
                --secondary-color: #57b8bf;     /* Fresh teal accent */

                /* Status Colors */
                --success-color: #4CAF50;       /* Soft green for success */
                --warning-color: #F4A261;       /* Gentle orange for warnings */
                --danger-color: #E76F51;        /* Coral red for errors */
                --info-color: #60A5FA;          /* Light modern blue */

                /* Backgrounds */
                --background-color: #ffffff;    /* Soft lavender background */
                --card-background: #eefdff;     /* Light blue-gray card background */

                /* Text Colors */
                --text-primary: #1e293b;        /* Dark navy for readability */
                --text-secondary: #d0898d;      /* Muted pinkish tone for subtext */

                /* Borders & Accents */
                --border-color: #d0898d;        /* Soft pink border */
                --Navbar-bg: #ffffff;          /* Clean white sidebar */
                --Navbar-hover: #ecdbeb;       /* Light lavender hover */
                --Navbar-active-bg: #57b8bf;   /* Teal active background */
                --Navbar-active-text: #ffffff; /* White text on active Navbar item */
                --accent-color: #57b8bf;        /* Teal highlights */
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
        
        .logo-text {
            color: var(--primary-color);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .logo:hover .logo-text {
            color: var(--secondary-color);
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
        .nav-menu a.active {
            color: var(--Navbar-active-bg);
            border-bottom-color: var(--Navbar-active-bg);
        }
        
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
        .login-btn:hover,
        .login-btn:focus,
        .login-btn:active,
        .login-btn:visited {
            color: var(--Navbar-active-text) !important;
            text-decoration: none;
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
            
            
        }

        /* ===== CUSTOMER NAVIGATION (Top Navbar Only) ===== */
        .customer-layout {
            min-height: 100vh;
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
            background: var(--Navbar-hover);
            color: var(--primary-color);
            border-bottom-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.1);
        }

        .staff-tab.active {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: white;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            border-color: var(--primary-color);
            border-bottom-color: var(--primary-color);
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
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            text-align: center;
            border: 1px solid var(--border-color);
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
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
        }

        .page-header h1 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .page-header p {
            color: var(--text-secondary);
            font-weight: 500;
        }

        /* Hero Section */
        .hero {
            background: url('IMG/store.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: var(--Navbar-active-text);
            padding: 0 2rem;
            margin-top: 0;
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
            background: var(--warning-color);
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
            background: var(--warning-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(251, 191, 36, 0.3);
        }
        
        .cta-secondary {
            background: transparent;
            color: var(--Navbar-active-text);
            border: 2px solid var(--Navbar-active-text);
        }
        
        .cta-secondary:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 255, 255, 0.3);
        }
        
        /* Features Section */
        .features {
            padding: 5rem 2rem;
            background: linear-gradient(135deg, var(--background-color) 0%, var(--card-background) 100%);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .section-title {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--primary-color);
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
            box-shadow: 0 10px 30px var(--border-color);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
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
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        
        .feature-card:hover::before {
            transform: scaleX(1);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px var(--border-color);
            border-color: var(--border-color);
        }
        
        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: var(--warning-color);
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            color: var(--warning-color);
        }
        
        .feature-card p {
            color: #64748b;
            line-height: 1.7;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-hover) 100%);
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
            .customer-main-content {
                margin-top: 120px;
                padding: 0 1rem;
            }
            
            /* Sidebar responsive styles are now in css/sidebar.css */
            
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
            .hero { min-height: 45vh; }
            
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

        @keyframes logoGradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
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

    <!-- Hero + Features Sections (for public users) -->
    <% if ("public".equals(navType)) { %>
        <section class="hero">
            <div class="hero-content">
                <h1>Discover Your Next Favorite Book</h1>
                <p>Thousands of titles across genres. Read more, learn more, enjoy more.</p>
                <div class="cta-buttons">
                    <a href="BookServlet?action=list&redirect=books.jsp" class="cta-btn cta-primary">Browse Books</a>
                    <a href="about.jsp" class="cta-btn cta-secondary">Learn More</a>
                </div>
            </div>
        </section>
        <section class="features">
            <div class="container">
                <h2 class="section-title">Why Choose Pahana Edu Online?</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">📝</div>
                        <h3>Easy Account Registration</h3>
                        <p>New customers can register online with a unique account number, name, address, telephone, and units consumed.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">📊</div>
                        <h3>Smart Billing Management</h3>
                        <p>Manage billing details efficiently with clearly calculated charges based on your units consumed.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">💳</div>
                        <h3>Secure Payments & History</h3>
                        <p>View bills, check usage history, and make secure payments anytime from your online account.</p>
                    </div>
                </div>
            </div>
        </section>
    <% } %>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 Pahana Edu, Colombo. All rights reserved. | Leading bookshop with a modern online billing system.</p>
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
