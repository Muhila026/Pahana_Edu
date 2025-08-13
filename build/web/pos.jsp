<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Point of Sale - Pahana BookShop</title>
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
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        html {
            height: 100%;
            overflow: hidden;
            scroll-behavior: smooth;
        }

        /* Sidebar styles are now in css/sidebar.css */

        /* Standalone POS Layout */
        .pos-standalone-layout {
            height: 100vh;
            width: 100vw;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        /* POS Header */
        .pos-header {
            background: white;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            flex-shrink: 0;
        }

        .pos-header-left h1 {
            color: #6366f1;
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .pos-header-left p {
            color: #64748b;
            margin: 0.25rem 0 0 0;
            font-size: 0.9rem;
        }

        .pos-header-right {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: #f8fafc;
            color: #475569;
            text-decoration: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
        }

        .nav-link:hover {
            background: #6366f1;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .nav-link.logout {
            background: #fef2f2;
            color: #dc2626;
            border-color: #fecaca;
        }

        .nav-link.logout:hover {
            background: #dc2626;
            color: white;
            border-color: #dc2626;
        }

        /* POS Main Content */
        .pos-main-content {
            flex: 1;
            overflow: hidden;
        }

        /* Scroll to Top Button */
        .scroll-to-top-btn {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: #6366f1;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
            z-index: 10;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .scroll-to-top-btn:hover {
            background: #4f46e5;
            transform: scale(1.1);
            box-shadow: 0 4px 16px rgba(99, 102, 241, 0.4);
        }

        /* Scroll Indicators */
        .scroll-indicator {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .scroll-indicator.visible {
            opacity: 1;
        }

        /* Main Content Styles */
        .main-content {
            padding: 1rem;
            width: 100%;
            margin: 0;
            max-width: none;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: #cbd5e1 #f1f5f9;
        }

        .main-content::-webkit-scrollbar {
            width: 8px;
        }

        .main-content::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 4px;
        }

        .main-content::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        .main-content::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }



        /* POS Grid Layout */
        .pos-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
            height: calc(100vh - 120px);
            overflow: hidden;
        }

        /* Product Search Section */
        .product-search {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            height: 100%;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .search-header {
            margin-bottom: 1rem;
            flex-shrink: 0;
        }

        .search-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            flex-shrink: 0;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #6366f1;
        }

        .search-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        /* Product List */
        .product-list {
            flex: 1;
            overflow-y: auto;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            min-height: 300px;
            scrollbar-width: thin;
            scrollbar-color: #cbd5e1 #f1f5f9;
        }

        .product-list::-webkit-scrollbar {
            width: 8px;
        }

        .product-list::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 4px;
        }

        .product-list::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        .product-list::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
            transition: background-color 0.3s ease;
        }

        .product-item:hover {
            background-color: #f8fafc;
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .product-details {
            font-size: 0.9rem;
            color: #64748b;
        }

        .product-stock {
            font-size: 0.8rem;
            color: #475569;
            margin-top: 0.25rem;
        }

        .add-to-cart-btn {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        /* Cart Section */
        .cart-section {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            height: 100%;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .cart-header {
            margin-bottom: 1rem;
            flex-shrink: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cart-scroll-indicator {
            font-size: 0.8rem;
            color: #64748b;
            background: #f1f5f9;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            border: 1px solid #e2e8f0;
        }

        .cart-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .cart-items {
            margin-bottom: 1.5rem;
            flex: 1;
            overflow-y: auto;
            min-height: 200px;
            max-height: 350px;
            scrollbar-width: thin;
            scrollbar-color: #cbd5e1 #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 0.5rem;
            background: #f8fafc;
        }

        .cart-items::-webkit-scrollbar {
            width: 8px;
        }

        .cart-items::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 4px;
        }

        .cart-items::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        .cart-items::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        /* Cart scroll hint */
        .cart-scroll-hint {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: rgba(99, 102, 241, 0.1);
            color: #6366f1;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.75rem;
            pointer-events: none;
            opacity: 0.7;
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
            background: white;
            margin-bottom: 0.5rem;
            border-radius: 6px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: all 0.2s ease;
        }

        .cart-item:hover {
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
            transform: translateY(-1px);
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item-info {
            flex: 1;
        }

        .cart-item-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .cart-item-price {
            color: #6366f1;
            font-weight: 600;
        }

        .cart-item-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quantity-btn {
            background: #f1f5f9;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .quantity-btn:hover {
            background: #e2e8f0;
        }

        .quantity-display {
            padding: 0.5rem;
            min-width: 40px;
            text-align: center;
            font-weight: 600;
        }

        .remove-item-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .remove-item-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Cart Summary */
        .cart-summary {
            border-top: 2px solid #f1f5f9;
            padding-top: 1rem;
            flex-shrink: 0;
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 1rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .summary-row.total {
            font-size: 1.2rem;
            font-weight: 700;
            color: #6366f1;
            border-top: 1px solid #f1f5f9;
            padding-top: 1rem;
            margin-top: 1rem;
        }

        /* Discount Button Styling */
        .discount-btn {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block !important;
            visibility: visible !important;
            opacity: 1 !important;
            min-width: 120px;
            height: auto;
            line-height: 1.2;
        }

        .discount-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        .discount-btn:disabled {
            background: #9ca3af;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        /* Quick Discount Buttons */
        .quick-discount-btn {
            background: linear-gradient(135deg, #8b5cf6, #a855f7);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid #e2e8f0;
        }

        .quick-discount-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.3);
            background: linear-gradient(135deg, #7c3aed, #9333ea);
        }

        .checkout-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }

        /* Bill Section Styles */
        .bill-section {
            margin-top: 1.5rem;
            padding: 1.5rem;
            border-top: 1px solid #e2e8f0;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .bill-section::-webkit-scrollbar {
            width: 6px;
        }

        .bill-section::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 3px;
        }

        .bill-section::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 3px;
        }

        .bill-section::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        .bill-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-group {
            flex: 1;
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #475569;
            font-weight: 500;
        }

        .bill-input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            font-family: inherit;
        }

        .bill-input:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .bill-input[type="email"] {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .bill-input[type="email"]:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .bill-input[type="textarea"] {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .bill-input[type="textarea"]:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        textarea.bill-input {
            resize: vertical;
            min-height: 60px;
        }

        /* Bill Section Specific Styles */
        .bill-section h4 {
            color: #6366f1;
            margin: 0 0 1.5rem 0;
            font-size: 1.2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .bill-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .form-row {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #475569;
            font-weight: 500;
        }

        .bill-input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            font-family: inherit;
            background: white;
        }

        .bill-input:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        select.bill-input {
            cursor: pointer;
        }

        /* Responsive adjustments for bill form */
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .bill-input {
                font-size: 16px; /* Prevents zoom on mobile */
            }
        }







        /* Full Screen Layout */
        .admin-main-content {
            width: 100%;
            height: 100vh;
            overflow: hidden;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .pos-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            /* Mobile responsive styles */
            
            .main-content {
                padding: 0.75rem;
            }
            
            .pos-grid {
                height: calc(100vh - 150px);
                gap: 1rem;
            }
            
            .page-header {
                padding: 1rem;
                margin-bottom: 1rem;
            }
            
            .product-search,
            .cart-section {
                padding: 1rem;
            }
            
            .search-form {
                flex-direction: column;
            }
            
            .cart-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            /* Mobile header adjustments */
            .pos-header {
                padding: 0.75rem 1rem;
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }
            
            .pos-header-right {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .nav-link {
                font-size: 0.85rem;
                padding: 0.4rem 0.8rem;
            }
            
            /* Mobile bill section adjustments */
            .bill-section {
                padding: 1rem;
                margin-top: 1rem;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0.75rem;
            }
            
            .form-group {
                margin-bottom: 0.75rem;
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

    <% if ("admin".equals(navType) || "manager".equals(navType) || "staff".equals(navType)) { %>
        <!-- STANDALONE POS PAGE (No Sidebar) -->
        <div class="pos-standalone-layout">
            <!-- Header with User Info and Navigation -->
            <header class="pos-header">
                <div class="pos-header-left">
                    <h1><i class="fas fa-cash-register"></i> Point of Sale</h1>
                    <p>Welcome, <%= username %> (<%= "admin".equals(navType) ? "Admin" : ("manager".equals(navType) ? "Manager" : "Staff") %>)</p>
                </div>
                <div class="pos-header-right">
                    <a href="welcome.jsp" class="nav-link" title="Back to Dashboard">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <a href="orders.jsp" class="nav-link" title="View Orders">
                        <i class="fas fa-shopping-cart"></i> Orders
                    </a>
                    <a href="profile.jsp" class="nav-link" title="My Profile">
                        <i class="fas fa-user"></i> Profile
                    </a>
                    <a href="LogoutServlet" class="nav-link logout" title="Logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </header>

            <!-- Main Content -->
            <main class="pos-main-content">
                <div class="main-content">
                    <!-- POS Grid Layout -->
                    <div class="pos-grid">
                        <!-- Product Search Section -->
                        <div class="product-search">
                            <div class="search-header">
                                <h3><i class="fas fa-search"></i> Product Search</h3>
                                <p>Search for books by title, author, or ISBN</p>
                                <div id="searchResultsCount" style="margin-top: 0.5rem; font-size: 0.9rem; color: #6366f1; font-weight: 500;"></div>
                            </div>
                            
                            <form class="search-form" onsubmit="event.preventDefault(); searchProducts();">
                                <input type="text" class="search-input" placeholder="Search for books..." id="productSearch" oninput="debounceSearch()">
                                <button type="submit" class="search-btn">
                                    <i class="fas fa-search"></i> Search
                                </button>
                                <button type="button" class="search-btn" style="background: linear-gradient(135deg, #10b981, #059669);" onclick="refreshProductsFromDatabase()">
                                    <i class="fas fa-sync-alt"></i> Refresh
                                </button>
                            </form>
                            
                            <div class="product-list" id="productList">
                                <!-- Products will be loaded dynamically from database -->
                                <%
                                // Get books from request attribute (if available from BookServlet)
                                java.util.List<com.pahana.BookServlet.Book> books = 
                                    (java.util.List<com.pahana.BookServlet.Book>) request.getAttribute("books");
                                
                                if (books != null && !books.isEmpty()) {
                                    for (com.pahana.BookServlet.Book book : books) {
                                        // Only show books with stock > 0
                                        if (book.getStockQuantity() > 0) {
                                %>
                                    <div class="product-item" data-title="<%= book.getTitle().toLowerCase() %>" data-author="<%= book.getAuthor() != null ? book.getAuthor().toLowerCase() : "" %>" data-category="<%= book.getCategoryName() != null ? book.getCategoryName().toLowerCase() : "" %>">
                                        <div class="product-info">
                                            <div class="product-name"><%= book.getTitle() %></div>
                                            <div class="product-details">
                                                <%= book.getAuthor() != null ? book.getAuthor() : "Unknown Author" %> • 
                                                <%= book.getCategoryName() != null ? book.getCategoryName() : "Uncategorized" %> • 
                                                Rs. <%= book.getPrice() != null ? book.getPrice().toString() : "0.00" %>
                                            </div>
                                            <div class="product-stock">Stock: <%= book.getStockQuantity() %></div>
                                        </div>
                                        <button class="add-to-cart-btn" data-title="<%= book.getTitle() %>" data-price="<%= book.getPrice() != null ? book.getPrice() : 0 %>" data-bookid="<%= book.getBookId() %>">
                                            <i class="fas fa-plus"></i> Add
                                        </button>
                                    </div>
                                <%
                                        }
                                    }
                                } else {
                                    // If no books from servlet, show loading message and load from database
                                %>
                                    <div id="loadingMessage" style="text-align: center; padding: 2rem; color: #64748b;">
                                        <i class="fas fa-spinner fa-spin" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                                        <p>Loading books from database...</p>
                                    </div>
                                    <div id="noBooksMessage" style="text-align: center; padding: 2rem; color: #64748b; display: none;">
                                        <i class="fas fa-book-open" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                                        <p>No books found in database</p>
                                        <p style="font-size: 0.9rem; margin-top: 0.5rem;">Please add some books first or check your database connection.</p>
                                        <button class="search-btn" onclick="refreshProductsFromDatabase()" style="margin-top: 1rem;">
                                            <i class="fas fa-sync-alt"></i> Try Again
                                        </button>
                                    </div>
                                <%
                                }
                                %>
                            </div>
                        </div>
                        
                        <!-- Cart Section -->
                        <div class="cart-section">
                            <div class="cart-header">
                                <h3><i class="fas fa-shopping-cart"></i> Shopping Cart</h3>
                                <p>Review items and complete purchase</p>
                            </div>
                            
                            <div class="cart-items" id="cartItems">
                                <!-- Cart items will be displayed here -->
                            </div>
                            
                            <div class="cart-summary">
                                <div class="summary-row">
                                    <span>Subtotal:</span>
                                    <span id="subtotal">Rs. 0.00</span>
                                </div>
                                <div class="summary-row">
                                    <span>Tax (8%):</span>
                                    <span id="tax">Rs. 0.00</span>
                                </div>
                                <div class="summary-row">
                                    <span>Discount:</span>
                                    <button type="button" class="discount-btn" onclick="showDiscountModal()" style="display: inline-block !important; visibility: visible !important; opacity: 1 !important;">
                                        <i class="fas fa-percentage"></i> Apply Discount
                                    </button>
                                </div>
                                <div class="summary-row total">
                                    <span>Total:</span>
                                    <span id="total">Rs. 0.00</span>
                                </div>
                                
                                <!-- Bill Section -->
                                <div class="bill-section">
                                    
                                    <div class="bill-form">
                                        
                                        
                                        <div class="form-row">
                                            
                                            <div class="form-group">
                                                <label for="paymentMethod">Payment Method:</label>
                                                <select id="paymentMethod" class="bill-input">
                                                    <option value="Cash">Cash</option>
                                                    <option value="Credit Card">Credit Card</option>
                                                    <option value="Debit Card">Debit Card</option>
                                                    <option value="Bank Transfer">Bank Transfer</option>
                                                    <option value="Digital Wallet">Digital Wallet</option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        
                                    </div>
                                </div>
                                
                                <button class="checkout-btn" onclick="processCheckout()">
                                    <i class="fas fa-credit-card"></i> Process Payment & Generate Bill
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Discount Modal -->
        <div id="discountModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">
            <div style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%;">
            <div style="background: white; padding: 2rem; border-radius: 12px; max-width: 400px; width: 90%;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h3 style="color: #6366f1; margin: 0;">Customer Discount</h3>
                    <button onclick="closeDiscountModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #64748b;">&times;</button>
                </div>
                
                <div style="margin-bottom: 1.5rem;">
                    <label style="display: block; margin-bottom: 0.5rem; color: #475569; font-weight: 500;">Customer Phone Number:</label>
                    <input type="text" id="customerPhoneForDiscount" placeholder="Enter customer phone number" style="width: 100%; padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 1rem;">
                </div>
                
                <div style="margin-bottom: 1.5rem;">
                    <label style="display: block; margin-bottom: 0.5rem; color: #475569; font-weight: 500;">Discount Amount:</label>
                    <div style="display: flex; gap: 0.5rem; align-items: center;">
                        <input type="number" id="discountAmount" placeholder="0" min="0" step="0.01" style="flex: 1; padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 1rem;">
                        <select id="discountType" style="padding: 0.75rem; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 1rem; background: white; cursor: pointer;">
                            <option value="amount">Rs.</option>
                            <option value="percentage">%</option>
                        </select>
                    </div>
                </div>
                
                <div style="margin-bottom: 1.5rem;">
                    <label style="display: block; margin-bottom: 0.5rem; color: #475569; font-weight: 500;">Quick Discount Options:</label>
                    <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                        <button type="button" class="quick-discount-btn" onclick="applyQuickDiscount('percentage', 10)">
                            10% Off
                        </button>
                        <button type="button" class="quick-discount-btn" onclick="applyQuickDiscount('amount', 500)">
                            Rs. 500 Off
                        </button>
                        <button type="button" class="quick-discount-btn" onclick="applyQuickDiscount('percentage', 15)">
                            15% Off
                        </button>
                    </div>
                </div>
                
                <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                    <button type="button" onclick="closeDiscountModal()" style="background: #64748b; color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 8px; cursor: pointer;">Cancel</button>
                    <button type="button" onclick="applyDiscount()" style="background: linear-gradient(135deg, #10b981, #059669); color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 8px; cursor: pointer;">Apply Discount</button>
                </div>
            </div>
            </div>
        </div>
    <% } else { %>
        <!-- Access Denied for non-staff users -->
        <div style="text-align: center; padding: 4rem 2rem;">
            <h1 style="color: #ef4444; margin-bottom: 1rem;">Access Denied</h1>
            <p style="color: #64748b; margin-bottom: 2rem;">You don't have permission to access the Point of Sale system.</p>
            <a href="welcome.jsp" style="background: #6366f1; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block;">Return to Home</a>
        </div>
    <% } %>


    <script>
        // Simple cart functionality
        let cart = [];

        // Set up event listeners for add to cart buttons
        function setupAddToCartListeners() {
            document.querySelectorAll('.add-to-cart-btn').forEach(button => {
                // Remove existing listeners to avoid duplicates
                button.removeEventListener('click', handleAddToCart);
                button.addEventListener('click', handleAddToCart);
            });
        }

        // Refresh all event listeners and update display
        function refreshProductDisplay() {
            setupAddToCartListeners();
            updateTotals();
            
            // Update the book count
            const productItems = document.querySelectorAll('.product-item');
            if (productItems.length > 0) {
                document.getElementById('searchResultsCount').textContent = 'Showing ' + productItems.length + ' books';
            }
        }

        function handleAddToCart() {
            const title = this.getAttribute('data-title');
            const price = parseFloat(this.getAttribute('data-price'));
            const bookId = parseInt(this.getAttribute('data-bookid'));
            addToCart(title, price, bookId);
        }

        // Set up initial event listeners
        document.addEventListener('DOMContentLoaded', setupAddToCartListeners);

        function addToCart(name, price, bookId) {
            const existingItem = cart.find(item => item.name === name);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({ name, price, quantity: 1, bookId: bookId });
            }
            
            // Update stock display
            updateStockDisplay(name, -1);
            
            updateCartDisplay();
            updateTotals();
        }

        function updateStockDisplay(bookName, change) {
            const productItems = document.querySelectorAll('.product-item');
            productItems.forEach(item => {
                const itemName = item.querySelector('.product-name').textContent;
                if (itemName === bookName) {
                    const stockElement = item.querySelector('.product-stock');
                    if (stockElement) {
                        const currentStock = parseInt(stockElement.textContent.match(/\d+/)[0]);
                        const newStock = Math.max(0, currentStock + change);
                        stockElement.textContent = 'Stock: ' + newStock;
                        
                        // Disable add button if stock is 0
                        const addButton = item.querySelector('.add-to-cart-btn');
                        if (newStock === 0) {
                            addButton.disabled = true;
                            addButton.style.background = '#9ca3af';
                            addButton.style.cursor = 'not-allowed';
                        }
                    }
                }
            });
        }

        function updateQuantity(index, change) {
            const item = cart[index];
            const oldQuantity = item.quantity;
            item.quantity += change;
            
            if (item.quantity <= 0) {
                cart.splice(index, 1);
                // Restore all stock when item is completely removed
                updateStockDisplay(item.name, oldQuantity);
            } else {
                // Update stock based on quantity change
                updateStockDisplay(item.name, -change);
            }
            
            updateCartDisplay();
            updateTotals();
        }

        function removeItem(index) {
            const removedItem = cart[index];
            cart.splice(index, 1);
            
            // Restore stock when item is removed
            updateStockDisplay(removedItem.name, removedItem.quantity);
            
            updateCartDisplay();
            updateTotals();
        }

        function updateCartDisplay() {
            const cartItems = document.getElementById('cartItems');
            cartItems.innerHTML = '';
            
            cart.forEach((item, index) => {
                const cartItem = document.createElement('div');
                cartItem.className = 'cart-item';
                cartItem.innerHTML = '<div class="cart-item-info">' +
                    '<div class="cart-item-name">' + item.name + '</div>' +
                    '<div class="cart-item-price">Rs. ' + item.price.toFixed(2) + '</div>' +
                    '</div>' +
                    '<div class="cart-item-controls">' +
                        '<button class="quantity-btn" onclick="updateQuantity(' + index + ', -1)">-</button>' +
                        '<span class="quantity-display">' + item.quantity + '</span>' +
                        '<button class="quantity-btn" onclick="updateQuantity(' + index + ', 1)">+</button>' +
                        '<button class="remove-item-btn" onclick="removeItem(' + index + ')">' +
                            '<i class="fas fa-trash"></i>' +
                        '</button>' +
                    '</div>';
                cartItems.appendChild(cartItem);
            });
            
            // Update cart scroll indicator
            updateCartScrollIndicator();
        }

        function updateTotals() {
            const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            const tax = subtotal * 0.08;
            
            // Calculate discount from modal or stored value
            const discountAmount = parseFloat(document.getElementById('discountAmount').value) || 0;
            const discountType = document.getElementById('discountType').value;
            let discount = 0;
            
            if (discountAmount > 0) {
                if (discountType === 'percentage') {
                    discount = (subtotal * discountAmount) / 100;
                } else {
                    discount = discountAmount;
                }
                
                // Ensure discount doesn't exceed subtotal
                discount = Math.min(discount, subtotal);
            }
            
            const total = subtotal + tax - discount;
            
            document.getElementById('subtotal').textContent = 'Rs. ' + subtotal.toFixed(2);
            document.getElementById('tax').textContent = 'Rs. ' + tax.toFixed(2);
            document.getElementById('total').textContent = 'Rs. ' + total.toFixed(2);
        }

        function updateCartScrollIndicator() {
            const cartItems = document.getElementById('cartItems');
            const cartHeader = document.querySelector('.cart-header h3');
            
            // Remove existing indicator
            const existingIndicator = document.querySelector('.cart-scroll-indicator');
            if (existingIndicator) {
                existingIndicator.remove();
            }
            
            // Add scroll indicator if cart has many items
            if (cart.length > 5) {
                const indicator = document.createElement('div');
                indicator.className = 'cart-scroll-indicator';
                indicator.innerHTML = `<i class="fas fa-arrow-down"></i> Scroll to see more items (${cart.length} total)`;
                cartHeader.parentNode.appendChild(indicator);
            }
        }

        // Discount Modal Functions
        function showDiscountModal() {
            if (cart.length === 0) {
                alert('Please add items to cart before applying discount.');
                return;
            }
            document.getElementById('discountModal').style.display = 'flex';
            document.getElementById('customerPhoneForDiscount').focus();
        }

        function closeDiscountModal() {
            document.getElementById('discountModal').style.display = 'none';
            // Clear the modal inputs
            document.getElementById('customerPhoneForDiscount').value = '';
            document.getElementById('discountAmount').value = '';
            document.getElementById('discountType').value = 'amount';
        }

        function applyDiscount() {
            const customerPhone = document.getElementById('customerPhoneForDiscount').value.trim();
            const discountAmount = parseFloat(document.getElementById('discountAmount').value);
            const discountType = document.getElementById('discountType').value;
            
            if (!customerPhone) {
                alert('Please enter customer phone number.');
                document.getElementById('customerPhoneForDiscount').focus();
                return;
            }
            
            if (!discountAmount || discountAmount <= 0) {
                alert('Please enter a valid discount amount.');
                document.getElementById('discountAmount').focus();
                return;
            }
            
            // Here you would typically verify the customer phone number
            // For now, we'll just apply the discount
            // In a real system, you'd check against your customer database
            
            // Store discount info for checkout
            window.currentDiscount = {
                customerPhone: customerPhone,
                amount: discountAmount,
                type: discountType
            };
            
            // Save discount usage to database
            saveDiscountUsage(window.currentDiscount);
            
            // Update totals with discount
            updateTotals();
            
            // Close modal
            closeDiscountModal();
            
            // Show success message
            alert('Discount applied successfully!\nCustomer: ' + customerPhone + '\nDiscount: ' + discountAmount + (discountType === 'percentage' ? '%' : ' Rs.'));
        }

        function applyQuickDiscount(type, value) {
            // Set the discount type and amount
            document.getElementById('discountType').value = type;
            document.getElementById('discountAmount').value = value;
            
            // Focus on customer phone for quick entry
            document.getElementById('customerPhoneForDiscount').focus();
            
            // Show a small confirmation
            const typeText = type === 'percentage' ? '%' : 'Rs.';
            const message = `Quick discount set: ${value}${typeText}`;
            
            // Create a temporary notification
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #10b981, #059669);
                color: white;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
                z-index: 1001;
                font-weight: 500;
            `;
            notification.textContent = message;
            document.body.appendChild(notification);
            
            // Remove notification after 2 seconds
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.parentNode.removeChild(notification);
                }
            }, 2000);
        }

        function searchProducts() {
            const searchTerm = document.getElementById('productSearch').value.toLowerCase().trim();
            const productItems = document.querySelectorAll('.product-item');
            let visibleCount = 0;
            
            if (searchTerm === '') {
                // If search is empty, show all products
                productItems.forEach(item => {
                    item.style.display = 'flex';
                    visibleCount++;
                });
                document.getElementById('searchResultsCount').textContent = 'Showing ' + visibleCount + ' books';
            } else {
                // Search through products
                productItems.forEach(item => {
                    const productName = item.querySelector('.product-name').textContent.toLowerCase();
                    const productAuthor = item.dataset.author || '';
                    const productTitle = item.dataset.title || '';
                    const productCategory = item.dataset.category || '';

                    if (productName.includes(searchTerm) || 
                        productAuthor.includes(searchTerm) || 
                        productTitle.includes(searchTerm) || 
                        productCategory.includes(searchTerm)) {
                        item.style.display = 'flex';
                        visibleCount++;
                    } else {
                        item.style.display = 'none';
                    }
                });
                
                const bookText = visibleCount === 1 ? 'book' : 'books';
                document.getElementById('searchResultsCount').textContent = 'Found ' + visibleCount + ' ' + bookText + ' matching "' + searchTerm + '"';
            }
            
            // Show message if no products match search
            const noResultsMessage = document.getElementById('noResultsMessage');
            if (visibleCount === 0 && searchTerm !== '') {
                if (!noResultsMessage) {
                    const message = document.createElement('div');
                    message.id = 'noResultsMessage';
                    message.style.cssText = 'text-align: center; padding: 2rem; color: #64748b;';
                    message.innerHTML = '<i class="fas fa-search" style="font-size: 2rem; margin-bottom: 1rem;"></i>' +
                        '<p>No books found matching "' + searchTerm + '"</p>' +
                        '<button class="search-btn" onclick="clearSearch()" style="margin-top: 1rem;">' +
                            '<i class="fas fa-times"></i> Clear Search' +
                        '</button>';
                    document.getElementById('productList').appendChild(message);
                }
            } else if (noResultsMessage) {
                noResultsMessage.remove();
            }
        }

        function clearSearch() {
            document.getElementById('productSearch').value = '';
            searchProducts();
            document.getElementById('searchResultsCount').textContent = 'Showing all books';
        }

        function refreshProductsFromDatabase() {
            // Show loading message
            document.getElementById('productList').innerHTML = '<div id="loadingMessage" style="text-align: center; padding: 2rem; color: #64748b;">' +
                '<i class="fas fa-spinner fa-spin" style="font-size: 2rem; margin-bottom: 1rem;"></i>' +
                '<p>Loading books from database...</p>' +
                '</div>';
            
            // Clear any existing search
            document.getElementById('productSearch').value = '';
            
            // Redirect to BookServlet to get real book data
            window.location.href = 'BookServlet?action=list&redirect=pos';
        }

        // Handle database errors or connection issues
        function showDatabaseError() {
            const productList = document.getElementById('productList');
            productList.innerHTML = '<div style="text-align: center; padding: 2rem; color: #ef4444;">' +
                '<i class="fas fa-exclamation-triangle" style="font-size: 2rem; margin-bottom: 1rem;"></i>' +
                '<p>Unable to connect to database</p>' +
                '<p style="font-size: 0.9rem; margin-top: 0.5rem; color: #64748b;">Please check your database connection and try again.</p>' +
                '<button class="search-btn" onclick="refreshProductsFromDatabase()" style="margin-top: 1rem; background: linear-gradient(135deg, #ef4444, #dc2626);">' +
                    '<i class="fas fa-sync-alt"></i> Retry Connection' +
                '</button>' +
                '</div>';
            document.getElementById('searchResultsCount').textContent = 'Database connection error';
        }

        // Auto-load products from database when page loads if no books are present
        function autoLoadProducts() {
            const productItems = document.querySelectorAll('.product-item');
            const loadingMessage = document.getElementById('loadingMessage');
            const noBooksMessage = document.getElementById('noBooksMessage');
            
            if (productItems.length === 0) {
                if (loadingMessage) {
                    // Show loading message and then load from database
                    setTimeout(() => {
                        refreshProductsFromDatabase();
                    }, 1000); // Wait 1 second then load
                } else if (noBooksMessage) {
                    // Show no books message
                    noBooksMessage.style.display = 'block';
                    document.getElementById('searchResultsCount').textContent = 'No books available';
                }
            } else {
                // Update the count display
                document.getElementById('searchResultsCount').textContent = 'Showing ' + productItems.length + ' books';
            }
        }

        // Debounce function for real-time search
        let searchTimeout;
        function debounceSearch() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                searchProducts();
            }, 300); // Wait 300ms after user stops typing
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            setupAddToCartListeners();
            updateTotals();
            autoLoadProducts();
            
            // Set up search input event listeners
            const searchInput = document.getElementById('productSearch');
            if (searchInput) {
                searchInput.addEventListener('input', debounceSearch);
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        searchProducts();
                    }
                });
            }
            
                    // Initialize discount system
        window.currentDiscount = null;
        
        // Ensure discount button is visible
        setTimeout(() => {
            const discountBtn = document.querySelector('.discount-btn');
            if (discountBtn) {
                discountBtn.style.display = 'inline-block';
                discountBtn.style.visibility = 'visible';
                discountBtn.style.opacity = '1';
                console.log('Discount button made visible');
            } else {
                console.log('Discount button not found');
            }
        }, 100);
        
        // Load available discounts from database
        loadAvailableDiscounts();
            
            // Initialize scroll improvements
            initializeScrollImprovements();
        });

        // Scroll improvements and enhancements
        function initializeScrollImprovements() {
            // Add scroll indicators to scrollable containers
            addScrollIndicators();
            
            // Smooth scroll to top when needed
            addScrollToTop();
            
            // Keyboard navigation for scrollable areas
            addKeyboardScrollNavigation();
        }

        function addScrollIndicators() {
            const scrollableElements = document.querySelectorAll('.product-list, .cart-items');
            
            scrollableElements.forEach(element => {
                if (element.scrollHeight > element.clientHeight) {
                    // Add subtle scroll indicator
                    element.style.position = 'relative';
                    
                    // Add scroll shadow effect
                    element.addEventListener('scroll', function() {
                        if (this.scrollTop > 0) {
                            this.style.boxShadow = 'inset 0 2px 4px rgba(0,0,0,0.1)';
                        } else {
                            this.style.boxShadow = 'none';
                        }
                    });
                }
            });
        }

        function addScrollToTop() {
            // Add scroll to top functionality for long lists
            const longLists = document.querySelectorAll('.product-list, .cart-items');
            
            longLists.forEach(list => {
                if (list.scrollHeight > list.clientHeight * 2) {
                    // Add scroll to top button when scrolled down
                    list.addEventListener('scroll', function() {
                        if (this.scrollTop > 100) {
                            if (!this.querySelector('.scroll-to-top-btn')) {
                                const scrollBtn = document.createElement('button');
                                scrollBtn.className = 'scroll-to-top-btn';
                                scrollBtn.innerHTML = '<i class="fas fa-arrow-up"></i>';
                                scrollBtn.style.cssText = `
                                    position: absolute;
                                    bottom: 10px;
                                    right: 10px;
                                    background: #6366f1;
                                    color: white;
                                    border: none;
                                    border-radius: 50%;
                                    width: 40px;
                                    height: 40px;
                                    cursor: pointer;
                                    box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
                                    z-index: 10;
                                    transition: all 0.3s ease;
                                `;
                                
                                scrollBtn.addEventListener('click', () => {
                                    this.scrollTo({ top: 0, behavior: 'smooth' });
                                });
                                
                                scrollBtn.addEventListener('mouseenter', function() {
                                    this.style.transform = 'scale(1.1)';
                                    this.style.boxShadow = '0 4px 16px rgba(99, 102, 241, 0.4)';
                                });
                                
                                scrollBtn.addEventListener('mouseleave', function() {
                                    this.style.transform = 'scale(1)';
                                    this.style.boxShadow = '0 2px 8px rgba(99, 102, 241, 0.3)';
                                });
                                
                                this.appendChild(scrollBtn);
                            }
                        } else {
                            const scrollBtn = this.querySelector('.scroll-to-top-btn');
                            if (scrollBtn) {
                                scrollBtn.remove();
                            }
                        }
                    });
                }
            });
        }

        function addKeyboardScrollNavigation() {
            // Add keyboard navigation for scrollable areas
            const scrollableElements = document.querySelectorAll('.product-list, .cart-items');
            
            scrollableElements.forEach(element => {
                element.addEventListener('keydown', function(e) {
                    const scrollAmount = 100;
                    
                    switch(e.key) {
                        case 'ArrowUp':
                            e.preventDefault();
                            this.scrollBy({ top: -scrollAmount, behavior: 'smooth' });
                            break;
                        case 'ArrowDown':
                            e.preventDefault();
                            this.scrollBy({ top: scrollAmount, behavior: 'smooth' });
                            break;
                        case 'Home':
                            e.preventDefault();
                            this.scrollTo({ top: 0, behavior: 'smooth' });
                            break;
                        case 'End':
                            e.preventDefault();
                            this.scrollTo({ top: this.scrollHeight, behavior: 'smooth' });
                            break;
                    }
                });
                
                // Make elements focusable for keyboard navigation
                element.setAttribute('tabindex', '0');
            });
        }
        


        // Customer discount verification and management
        function verifyCustomerPhone(phoneNumber) {
            // This function would typically check against your customer database
            // For now, we'll just return true to allow any phone number
            // In a real system, you'd implement proper customer verification
            
            // Example implementation:
            // return fetch('CustomerServlet?action=verify&phone=' + phoneNumber)
            //     .then(response => response.json())
            //     .then(data => data.exists);
            
            return true; // Placeholder - always allow for now
        }

        function saveDiscountUsage(discountData) {
            // This function would save discount usage to the database
            // For now, we'll just log it to console
            // In a real system, you'd implement database storage
            
            console.log('Discount Usage:', {
                customerPhone: discountData.customerPhone,
                discountAmount: discountData.amount,
                discountType: discountData.type,
                timestamp: new Date().toISOString(),
                billTotal: document.getElementById('total').textContent
            });
            
            // Example database save implementation:
            // fetch('DiscountServlet', {
            //     method: 'POST',
            //     headers: { 'Content-Type': 'application/json' },
            //     body: JSON.stringify(discountData)
            // });
        }

        function loadAvailableDiscounts() {
            // Load available discounts from database
            fetch('DiscountServlet?action=list')
                .then(response => response.text())
                .then(html => {
                    // Parse the HTML response to extract discount data
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(html, 'text/html');
                    
                    // Extract discount data from the response
                    const discountRows = doc.querySelectorAll('tr[data-discount-id]');
                    const availableDiscounts = [];
                    
                    discountRows.forEach(row => {
                        const discountId = row.getAttribute('data-discount-id');
                        const discountType = row.querySelector('.discount-type')?.textContent?.trim();
                        const discountValue = row.querySelector('.discount-value')?.textContent?.trim();
                        
                        if (discountId && discountType && discountValue) {
                            availableDiscounts.push({ 
                                id: discountId, 
                                type: discountType, 
                                value: discountValue 
                            });
                        }
                    });
                    
                    // Update quick discount buttons if discounts are available
                    if (availableDiscounts.length > 0) {
                        updateQuickDiscountButtons(availableDiscounts);
                    }
                })
                .catch(error => {
                    console.error('Error loading discounts:', error);
                    // Use default discounts if loading fails
                    const defaultDiscounts = [
                        { type: 'Percentage', value: '10.00' },
                        { type: 'Fixed Amount', value: '500.00' },
                        { type: 'Percentage', value: '15.00' }
                    ];
                    updateQuickDiscountButtons(defaultDiscounts);
                });
        }

        function updateQuickDiscountButtons(discounts) {
            const quickDiscountContainer = document.querySelector('.quick-discount-btn').parentNode;
            if (quickDiscountContainer) {
                // Clear existing buttons
                quickDiscountContainer.innerHTML = '';
                
                // Add new buttons based on available discounts
                discounts.forEach(discount => {
                    const button = document.createElement('button');
                    button.type = 'button';
                    button.className = 'quick-discount-btn';
                    
                    const isPercentage = discount.type.toLowerCase().includes('percentage') || 
                                       discount.type.toLowerCase().includes('seasonal');
                    const type = isPercentage ? 'percentage' : 'amount';
                    const value = parseFloat(discount.value);
                    
                    button.onclick = () => applyQuickDiscount(type, value);
                    button.textContent = discount.type === 'Fixed Amount' ? 
                        `Rs. ${value} Off` : `${value}% Off`;
                    
                    quickDiscountContainer.appendChild(button);
                });
            }
        }

        // Customer search functionality removed - discount is now applied via modal

        function processCheckout() {
            if (cart.length === 0) {
                alert('Please add items to cart before checkout.');
                return;
            }
            
            // Validate bill form
            const customerName = document.getElementById('customerName').value.trim();
            const customerPhone = document.getElementById('customerPhone').value.trim();
            const customerEmail = document.getElementById('customerEmail').value.trim();
            const paymentMethod = document.getElementById('paymentMethod').value;
            
            if (!customerName) {
                alert('Please enter customer name.');
                document.getElementById('customerName').focus();
                return;
            }
            
            if (!customerPhone) {
                alert('Please enter customer phone number.');
                document.getElementById('customerPhone').focus();
                return;
            }
            
            // Customer ID not available in simplified system
            const customerId = null;
            
            // Collect bill data
            const billData = {
                customerId: customerId || null,
                customerName: customerName,
                customerPhone: customerPhone,
                customerEmail: customerEmail,
                customerAddress: document.getElementById('customerAddress').value.trim(),
                paymentMethod: paymentMethod,
                notes: document.getElementById('billNotes').value.trim(),
                cart: cart,
                subtotal: parseFloat(document.getElementById('subtotal').textContent.replace('Rs. ', '')),
                tax: parseFloat(document.getElementById('tax').textContent.replace('Rs. ', '')),
                discount: window.currentDiscount ? window.currentDiscount.amount : 0,
                discountType: window.currentDiscount ? window.currentDiscount.type : 'amount',
                discountCustomerPhone: window.currentDiscount ? window.currentDiscount.customerPhone : null,
                total: parseFloat(document.getElementById('total').textContent.replace('Rs. ', ''))
            };
            
            // Show processing message
            const checkoutBtn = document.querySelector('.checkout-btn');
            const originalText = checkoutBtn.innerHTML;
            checkoutBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            checkoutBtn.disabled = true;
            
            // Send bill data to servlet
            fetch('BillServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(billData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Show success message with bill number
                    alert('Payment processed successfully!\nBill Number: ' + data.billNumber + '\nTotal: Rs. ' + data.total.toFixed(2));
                    
                                        // Clear cart and form
                    cart = [];
                    updateCartDisplay();
                    updateTotals();
                    clearBillForm();
                    
                    // Reset discount
                    window.currentDiscount = null;
                    
                    // Optionally open bill in new window
                    if (data.billUrl) {
                        window.open(data.billUrl, '_blank');
                    }
                } else {
                    alert('Error processing payment: ' + (data.message || 'Unknown error'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error processing payment. Please try again.');
            })
            .finally(() => {
                // Restore button
                checkoutBtn.innerHTML = originalText;
                checkoutBtn.disabled = false;
            });
        }
        
        function clearBillForm() {
            document.getElementById('customerName').value = '';
            document.getElementById('customerPhone').value = '';
            document.getElementById('customerEmail').value = '';
            document.getElementById('customerAddress').value = '';
            document.getElementById('paymentMethod').value = 'Cash';
            document.getElementById('billNotes').value = '';
            
            // Clear discount
            window.currentDiscount = null;
        }
    </script>
</body>
</html>
