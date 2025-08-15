<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.BookServlet.Book"%>
<%@page import="com.booking.CustomerServlet.Customer"%>
<%@page import="com.booking.TransactionServlet.Transaction,com.booking.TransactionServlet.TransactionItem"%>
<%@page import="com.booking.BookServlet"%>
<%@page import="com.booking.CustomerServlet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Point of Sale</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            :root {
                /* Brand Colors - Modern Bookstore Theme */
                --primary-color: #916fc6;
                --primary-hover: #5b21b6;
                --secondary-color: #ec4899;
                --tertiary-color: #8b5cf6;

                /* Status Colors */
                --success-color: #10B981;
                --warning-color: #F59E0B;
                --danger-color: #EF4444;
                --info-color: #3B82F6;

                /* Backgrounds */
                --background-color: #F9F5FF;
                --card-background: #FFFFFF;
                --gradient-bg: linear-gradient(135deg, #F9F5FF 0%, #F3E8FF 100%);

                /* Text Colors */
                --text-primary: #1E1B4B;
                --text-secondary: #4C1D95;
                --text-light: #cdc5d6;

                /* Borders & Accents */
                --border-color: #EDE9FE;
                --sidebar-bg: #401782;
                --sidebar-hover: #4a238a;
                --accent-color: #928c9e;
                --gold-accent: #FBBF24;
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
                margin: 0;
                padding: 0;
                color: var(--text-primary);
            }

            .main-container {
                display: flex;
                min-height: 100vh;
            }



            /* Bill Modal Styles */
            .bill-container {
                max-width: 100%;
                margin: 0 auto;
                padding: 0;
            }

            .bill-header {
                text-align: center;
                border-bottom: 2px solid #dee2e6;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }

            .bill-header h4 {
                color: #1e3c72;
                margin-bottom: 10px;
                font-weight: bold;
            }

            .bill-header p {
                margin-bottom: 5px;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .bill-items {
                margin-bottom: 15px;
            }

            .bill-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 0;
                border-bottom: 1px solid #f1f3f4;
                font-size: 0.95rem;
            }

            .bill-item:last-child {
                border-bottom: none;
            }

            .bill-total {
                border-top: 2px solid #dee2e6;
                padding-top: 15px;
                font-weight: bold;
                font-size: 1.1rem;
                color: #1e3c72;
            }

            /* Modal specific styles */
            #billModal .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            #billModal .modal-header {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                border-bottom: none;
                border-radius: 12px 12px 0 0;
            }

            #billModal .modal-title {
                color: white;
                font-weight: 600;
            }

            #billModal .btn-close-white {
                filter: invert(1);
            }

            /* Enhanced Cart Item Styles */
            .cart-item {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .cart-item-info {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 8px;
            }

            .cart-item-title {
                flex: 1;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 4px;
            }

            .cart-item-details {
                flex: 1;
                font-size: 0.85rem;
            }

            .cart-item-price {
                text-align: right;
                color: #28a745;
                font-weight: 600;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                background: #f8f9fa;
                padding: 6px 12px;
                border-radius: 6px;
            }

            .quantity-btn {
                background: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .quantity-btn:hover {
                background: #0056b3;
            }

            .quantity-btn:active {
                transform: scale(0.95);
            }

            /* Order Summary Styles */
            #orderSummary .d-flex {
                border-bottom: 1px solid #f1f3f4;
                padding: 8px 0;
            }

            #orderSummary .d-flex:last-child {
                border-bottom: none;
            }

            #orderSummary .text-start {
                flex: 1;
            }

            #orderSummary .text-end {
                min-width: 80px;
                text-align: right;
            }

            #orderSummary strong {
                color: #2c3e50;
            }

            #orderSummary small {
                font-size: 0.8rem;
                color: #6c757d;
            }



            /* Main Content Styles */
            .main-content {
                flex: 1;
                padding: 0;
                background-color: var(--background-color);
            }

            /* Point of Sale Main Section Styles */
            .pos-main-section {
                padding: 2rem;
                background-color: var(--background-color);
            }

            .pos-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 1.5rem;
                padding-bottom: 0.75rem;
                border-bottom: 1px solid var(--border-color);
            }

            .pos-title-section {
                display: flex;
                flex-direction: column;
                gap: 0.1rem;
            }

            .pos-section-title {
                color: #6f42c1;
                font-size: 1.8rem;
                font-weight: 700;
                margin: 0;
                line-height: 1.2;
            }

            .welcome-text {
                color: #6c757d;
                font-size: 0.9rem;
                font-weight: 500;
                margin: 0;
                line-height: 1.2;
            }

            .pos-navbar {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .pos-nav-link {
                display: flex;
                align-items: center;
                padding: 0.6rem 1rem;
                color: var(--text-primary);
                text-decoration: none;
                border-radius: 6px;
                border: 1px solid var(--border-color);
                background: var(--card-background);
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 0.9rem;
            }

            .pos-nav-link:hover {
                background: var(--background-color);
                color: var(--text-primary);
                text-decoration: none;
                border-color: var(--accent-color);
            }

            .pos-nav-link.logout-link {
                color: var(--danger-color);
                background: color-mix(in srgb, var(--danger-color) 12%, white);
                border-color: color-mix(in srgb, var(--danger-color) 22%, white);
            }

            .pos-nav-link.logout-link:hover {
                background: var(--danger-color);
                color: white;
                border-color: var(--danger-color);
            }

            /* POS Container Styles */
            .pos-container {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 2rem;
                height: calc(100vh - 200px);
            }

            .product-search-section, .cart-section {
                background: var(--card-background);
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
            }

            .section-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid var(--border-color);
            }



            /* Product Search Styles */
            .search-header {
                margin-bottom: 1.5rem;
            }

            .search-description {
                color: var(--text-secondary);
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
            }

            .search-status {
                color: var(--text-secondary);
                font-size: 0.85rem;
                font-style: italic;
            }

            .search-controls {
                margin-bottom: 1.5rem;
            }

            .search-input-group {
                display: flex;
                gap: 1rem;
                align-items: center;
            }

            .search-input {
                flex: 1;
                border: 2px solid var(--border-color);
                border-radius: 8px;
                padding: 0.75rem;
                font-size: 1rem;
            }

            .search-input:focus {
                border-color: var(--tertiary-color);
                outline: none;
                box-shadow: 0 0 0 3px color-mix(in srgb, var(--tertiary-color) 15%, transparent);
            }

            .search-buttons {
                display: flex;
                gap: 0.5rem;
            }

            .btn-search {
                background: var(--primary-color);
                border: none;
                color: white;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-search:hover {
                background: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px color-mix(in srgb, var(--primary-color) 30%, transparent);
            }

            .btn-refresh {
                background: var(--success-color);
                border: none;
                color: white;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-refresh:hover {
                background: color-mix(in srgb, var(--success-color) 85%, black);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px color-mix(in srgb, var(--success-color) 30%, transparent);
            }

            /* Product List Styles */
            .product-list {
                flex: 1;
                overflow-y: auto;
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .product-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem;
                background: var(--background-color);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .product-item:hover {
                background: var(--card-background);
                border-color: var(--tertiary-color);
                transform: translateX(5px);
            }

            .product-info {
                flex: 1;
            }

            .product-details {
                display: flex;
                gap: 1rem;
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
                color: var(--text-primary);
            }

            .product-title {
                font-weight: 600;
                color: var(--text-primary);
            }

            .product-category {
                color: var(--text-secondary);
            }

            .product-price {
                color: var(--success-color);
                font-weight: 600;
            }

            .product-stock {
                font-size: 0.85rem;
                color: #6c757d;
            }

            .btn-add {
                background: var(--success-color);
                border: none;
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-add:hover {
                background: color-mix(in srgb, var(--success-color) 85%, black);
                transform: scale(1.05);
            }

            .no-products {
                text-align: center;
                color: #6c757d;
                padding: 2rem;
            }

            /* Cart Styles */
            .cart-description {
                color: var(--text-secondary);
                margin-bottom: 1rem;
                font-size: 0.9rem;
            }

            .cart-content {
                flex: 1;
                overflow-y: auto;
                margin-bottom: 1rem;
                background: var(--card-background);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                min-height: 200px;
            }

            .empty-cart {
                text-align: center;
                color: var(--text-secondary);
                padding: 2rem;
            }

            .cart-summary {
                border-top: 2px solid var(--border-color);
                padding-top: 1rem;
                margin-bottom: 1rem;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.5rem 0;
                font-size: 1rem;
            }

            .summary-row.total {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--tertiary-color);
                border-top: 1px solid var(--border-color);
                padding-top: 0.75rem;
            }

            .cart-actions {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .btn-checkout {
                width: 100%;
                background: linear-gradient(135deg, var(--tertiary-color) 0%, var(--primary-hover) 100%);
                color: white;
                border: none;
                padding: 1rem;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-checkout:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px color-mix(in srgb, var(--primary-color) 30%, transparent);
            }

            .btn-checkout:disabled {
                background: var(--text-secondary);
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .btn-debug {
                background: var(--text-secondary);
                border: none;
                color: white;
                padding: 0.75rem;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-debug:hover {
                background: color-mix(in srgb, var(--text-secondary) 85%, black);
                transform: translateY(-2px);
            }

            /* Cart Item Styles */
            .cart-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem;
                border-bottom: 1px solid var(--border-color);
                background: var(--background-color);
                margin: 0.5rem;
                border-radius: 6px;
            }

            .cart-item:last-child {
                border-bottom: none;
            }

            .cart-item-info {
                flex: 1;
            }

            .cart-item-title {
                font-weight: 600;
                color: var(--text-primary);
                font-size: 0.9rem;
                margin-bottom: 0.25rem;
            }

            .cart-item-details {
                font-size: 0.8rem;
                color: var(--text-secondary);
            }

            .cart-item-price {
                color: var(--success-color);
                font-weight: 600;
                font-size: 0.9rem;
                text-align: right;
                min-width: 60px;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                background: var(--card-background);
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                border: 1px solid var(--border-color);
            }

            .quantity-btn {
                background: var(--tertiary-color);
                color: white;
                border: none;
                border-radius: 4px;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 0.8rem;
                font-weight: bold;
            }

            .quantity-btn:hover {
                background: var(--primary-hover);
            }

            /* Modal Styles */
            .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .modal-header {
                background: linear-gradient(135deg, var(--tertiary-color) 0%, var(--primary-hover) 100%);
                color: white;
                border-radius: 12px 12px 0 0;
                border: none;
            }

            .modal-body {
                padding: 2rem;
            }

            /* Checkout Modal Enhancements */
            #checkoutModal .summary-card {
                background: var(--background-color);
                border: 1px solid var(--border-color);
                border-radius: 12px;
                padding: 1rem;
            }
            #checkoutModal .selected-chip{
                display:inline-flex;
                align-items:center;
                gap:.5rem;
                background: color-mix(in srgb, var(--tertiary-color) 12%, white);
                color: var(--primary-hover);
                border: 1px solid color-mix(in srgb, var(--tertiary-color) 20%, white);
                padding:.4rem .7rem;
                border-radius:999px;
                font-weight:600;
                margin-bottom:.75rem;
            }
            #checkoutModal .summary-row {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                border-bottom: 1px dashed var(--border-color);
            }
            #checkoutModal .summary-row:last-child { border-bottom: none; }
            #checkoutModal .summary-total { font-weight: 700; color: var(--tertiary-color); font-size: 1.1rem; }
            #checkoutModal .btn-confirm {
                background: linear-gradient(135deg, var(--success-color) 0%, color-mix(in srgb, var(--success-color) 85%, black) 100%);
                color: #fff;
                border: none;
                padding: 0.8rem 1.2rem;
                border-radius: 10px;
                font-weight: 600;
            }
            #checkoutModal .btn-confirm:disabled { background: var(--text-secondary); }

            /* Receipt improvements */
            #billModal .brand-title { font-weight: 800; letter-spacing: .3px; }
            #billModal .bill-meta { color: #6b7280; font-size: .9rem; }
            #billModal .bill-items .bill-item span:last-child { font-weight: 600; }
            #billModal .bill-head{display:flex;justify-content:space-between;font-weight:700;border-bottom:1px dashed #e5e7eb;padding:.4rem 0;margin-bottom:.25rem;color:#374151}

            /* Add to Cart Modal Enhancements */
            #quantityModal .product-meta .badge {
                font-weight: 500;
                padding: 0.45rem 0.6rem;
                border-radius: 999px;
            }
            #quantityModal .price-display {
                display: inline-flex;
                align-items: baseline;
                gap: 6px;
                background: color-mix(in srgb, var(--tertiary-color) 8%, white);
                border: 1px solid color-mix(in srgb, var(--tertiary-color) 18%, white);
                padding: 0.6rem 0.9rem;
                border-radius: 10px;
                color: var(--primary-hover);
                font-weight: 700;
                font-size: 1.1rem;
            }
            #quantityModal .quantity-stepper {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                background: var(--card-background);
                border: 1.5px solid var(--border-color);
                padding: 0.5rem 0.75rem;
                border-radius: 10px;
            }
            #quantityModal .qty-btn {
                width: 36px;
                height: 36px;
                border: none;
                border-radius: 8px;
                background: var(--tertiary-color);
                color: #fff;
                font-weight: 700;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            #quantityModal .qty-btn:hover { background: var(--primary-hover); }
            #quantityModal .total-row { font-size: 1rem; }
            #quantityModal .btn-atc {
                background: linear-gradient(135deg, var(--tertiary-color) 0%, var(--primary-hover) 100%);
                color: #fff;
                border: none;
                padding: 0.6rem 1.2rem;
                border-radius: 10px;
                font-weight: 600;
                box-shadow: 0 4px 12px color-mix(in srgb, var(--tertiary-color) 25%, transparent);
            }
            #quantityModal .btn-atc:hover { transform: translateY(-1px); box-shadow: 0 8px 18px color-mix(in srgb, var(--tertiary-color) 35%, transparent); }

            .quantity-input {
                width: 100%;
                padding: 0.75rem;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 1.1rem;
                text-align: center;
            }

            .quantity-input:focus {
                border-color: #667eea;
                outline: none;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            /* Customer Selection Styles */
            .customer-search {
                margin-bottom: 1rem;
            }

            .customer-list {
                max-height: 300px;
                overflow-y: auto;
            }

            .customer-item {
                padding: 0.75rem;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                margin-bottom: 0.5rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .customer-item:hover {
                background: #f8f9fa;
                border-color: #667eea;
            }

            .customer-item.selected {
                background: #667eea;
                color: white;
                border-color: #667eea;
            }

            /* Bill Styles */
            .bill-container {
                background: white;
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                max-width: 400px;
                margin: 0 auto;
            }

            .bill-header {
                text-align: center;
                border-bottom: 2px solid #e9ecef;
                padding-bottom: 1rem;
                margin-bottom: 1rem;
            }

            .bill-items {
                margin-bottom: 1rem;
            }

            .bill-item {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                border-bottom: 1px solid #f8f9fa;
            }

            .bill-total {
                border-top: 2px solid #e9ecef;
                padding-top: 1rem;
                font-weight: 700;
                font-size: 1.2rem;
            }

            /* Responsive Design */
            @media (max-width: 1200px) {
                .pos-container {
                    grid-template-columns: 1.5fr 1fr;
                }
            }

            @media (max-width: 768px) {

                .pos-main-section {
                    padding: 1rem;
                }

                .pos-header {
                    flex-direction: column;
                    gap: 1rem;
                    text-align: center;
                }

                .pos-section-title {
                    font-size: 1.5rem;
                    margin-bottom: 0;
                }

                .pos-navbar {
                    flex-wrap: wrap;
                    justify-content: center;
                    gap: 0.5rem;
                }

                .pos-nav-link {
                    font-size: 0.8rem;
                    padding: 0.4rem 0.8rem;
                }

                .pos-container {
                    grid-template-columns: 1fr;
                    grid-template-rows: auto 1fr;
                }

                .search-input-group {
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .search-buttons {
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            // Check role-based access
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "STAFF".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
            
            // Load all books
            try {
                BookServlet bookServlet = new BookServlet();
                List<Book> allBooks = bookServlet.getAllBooks();
                request.setAttribute("allBooks", allBooks);
                System.out.println("Loaded " + (allBooks != null ? allBooks.size() : 0) + " books for POS");
            } catch (Exception e) {
                System.err.println("Error loading books for POS: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("allBooks", new ArrayList<>());
            }
            
            // Load customers for checkout
            try {
                CustomerServlet customerServlet = new CustomerServlet();
                List<Customer> customers = customerServlet.getAllCustomers();
                request.setAttribute("customers", customers);
                System.out.println("Loaded " + (customers != null ? customers.size() : 0) + " customers for POS");
            } catch (Exception e) {
                System.err.println("Error loading customers for POS: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("customers", new ArrayList<>());
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "pos");
        %>

        <div class="main-container">


            <!-- Main Content -->
            <div class="main-content">

                <!-- Point of Sale Section -->
                <div class="pos-main-section">
                    <div class="pos-header">
                        <div class="pos-title-section">
                            <h2 class="pos-section-title">
                                <i class="bi bi-cash-register me-2"></i>Point of Sale
                            </h2>
                            <div class="welcome-text">Welcome, <%= username %> (<%= role %>)</div>
                    </div>
                        <div class="pos-navbar">
                            <a href="dashboard.jsp" class="pos-nav-link">
                                <i class="bi bi-house me-2"></i>Dashboard
                            </a>
                            <a href="TransactionServlet?action=list" class="pos-nav-link">
                                <i class="bi bi-cart me-2"></i>Transaction
                            </a>
                            <a href="profile.jsp" class="pos-nav-link">
                                <i class="bi bi-person me-2"></i>Profile
                            </a>
                            <a href="LogoutServlet" class="pos-nav-link logout-link">
                                <i class="bi bi-box-arrow-right me-2"></i>Logout
                            </a>
                    </div>
                </div>

                <!-- POS Container -->
                <div class="pos-container">
                        <!-- Product Search Section -->
                        <div class="product-search-section">
                            <div class="search-header">
                        <h3 class="section-title">
                                    <i class="bi bi-search me-2"></i>Product Search
                        </h3>
                                <p class="search-description">Search for books by title or category.</p>
                                <div class="search-status" id="searchStatus">Showing books</div>
                            </div>
                        
                        <div class="search-controls">
                            <div class="search-input-group">
                                <input type="text" class="form-control search-input" id="bookSearch" placeholder="Search for books..." onkeyup="searchBooks()">
                                <div class="search-buttons">
                                    <button class="btn btn-search" onclick="searchBooks()">
                                        <i class="bi bi-search me-2"></i>Search
                                    </button>
                                    <button class="btn btn-refresh" onclick="refreshBooks()">
                                        <i class="bi bi-arrow-clockwise me-2"></i>Refresh Books
                                    </button>
                            </div>
                        </div>
                    </div>

                        <div class="product-list" id="productList">
                                    <% 
                                    List<Book> booksList = (List<Book>) request.getAttribute("allBooks");
                                    if (booksList != null && !booksList.isEmpty()) {
                                        for (Book book : booksList) {
                                    if (book.getBookId() > 0 && book.getTitle() != null && book.getPricePerUnit() != null && 
                                        book.getPricePerUnit().compareTo(java.math.BigDecimal.ZERO) > 0 && book.getStockQuantity() >= 0) {
                                    %>
                                    <div class="product-item" data-id="<%= book.getBookId() %>" onclick="openQuantityFromItem(this)">
                                        <div class="product-info">
                                            <div class="product-details">
                                                <span class="product-title"><%= book.getTitle() %></span>
                                                <span class="product-category"><%= (book.getCategory() != null && book.getCategory().getCategoryName() != null) ? book.getCategory().getCategoryName() : "N/A" %></span>
                                        <span class="product-price">Rs. <%= book.getPricePerUnit() %></span>
                                    </div>
                                    <div class="product-stock">
                                        Stock: <%= book.getStockQuantity() %>
                                    </div>
                                </div>
                                <button class="btn btn-add">
                                    <i class="bi bi-plus me-1"></i>Add
                                                </button>
                            </div>
                            <%
                                    }
                                        }
                                    } else {
                                    %>
                            <div class="no-products">
                                            <i class="bi bi-book" style="font-size: 2rem;"></i>
                                            <p>No books found</p>
                            </div>
                                    <%
                                    }
                                    %>
                        </div>
                    </div>

                    <!-- Shopping Cart Section -->
                    <div class="cart-section">
                        <h3 class="section-title">
                            <i class="bi bi-cart me-2"></i>Shopping Cart
                        </h3>
                        <p class="cart-description">Review items and complete purchase.</p>
                        
                        <div class="cart-content" id="cartItems">
                            <div class="empty-cart">
                                <i class="bi bi-cart" style="font-size: 2rem;"></i>
                                <p>Cart is empty</p>
                            </div>
                        </div>
                        
                        <div class="cart-summary">
                            <div class="summary-row">
                                <span>Subtotal:</span>
                                <span>Rs. <span id="cartSubtotal">0.00</span></span>
                            </div>
                            <div class="summary-row total">
                                <span>Total:</span>
                                <span>Rs. <span id="cartTotal">0.00</span></span>
                            </div>
                        </div>
                        
                        <div class="cart-actions">
                            <button class="btn btn-checkout" id="checkoutBtn" disabled onclick="showCheckoutModal()">
                                <i class="bi bi-credit-card me-2"></i>Process Payment & Complete Sale
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quantity Modal -->
        <div class="modal fade" id="quantityModal" tabindex="-1" aria-labelledby="quantityModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="quantityModalLabel">
                            <i class="bi bi-plus-circle me-2"></i>Add to Cart
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-2">
                            <h6 id="bookTitle" class="mb-2"></h6>
                            <div class="product-meta mb-3">
                                <span class="badge bg-light text-dark me-2" id="bookCategoryBadge"></span>
                                <span class="badge bg-success-subtle text-success">In stock: <span id="bookStock"></span></span>
                            </div>
                            <div class="price-display mb-3">
                                <span class="currency">Rs.</span><span id="bookPrice"></span>
                            </div>
                            <div class="quantity-stepper mb-3">
                                <button type="button" class="qty-btn" onclick="stepQuantity(-1)">-</button>
                                <input type="number" class="quantity-input" id="quantityInput" min="1" value="1" oninput="handleQuantityInput()">
                                <button type="button" class="qty-btn" onclick="stepQuantity(1)">+</button>
                            </div>
                            <div class="total-row d-flex justify-content-between align-items-center mb-3">
                                <span>Line total</span>
                                <strong>Rs. <span id="modalLineTotal">0.00</span></strong>
                            </div>
                            <div class="d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="button" class="btn btn-atc" onclick="confirmAddToCart()"><i class="bi bi-cart-plus me-2"></i>Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Checkout Modal -->
        <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="checkoutModalLabel">
                            <i class="bi bi-credit-card me-2"></i>Checkout
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="mb-3">Select Customer</h6>
                                <div class="customer-search">
                                    <input type="text" class="form-control" id="customerSearch" placeholder="Search customers...">
                                </div>
                                <div id="selectedCustomerChip" class="selected-chip d-none">
                                    <i class="bi bi-person-check"></i>
                                    <span id="selectedCustomerName">Customer selected</span>
                                </div>
                                <div class="customer-list" id="customerList">
                                    <% 
                                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                                    if (customers != null && !customers.isEmpty()) {
                                        for (Customer customer : customers) { 
                                    %>
                                        <div class="customer-item" data-id="<%= customer.getCustomerId() %>" onclick="selectCustomerFromItem(this)">
                                            <strong><%= customer.getName() %></strong><br>
                                            <small class="text-muted">Account: <%= customer.getAccountNumber() %></small>
                                        </div>
                                    <% 
                                        }
                                    } else {
                                    %>
                                        <div class="text-muted text-center py-3">
                                            <i class="bi bi-info-circle me-2"></i>No customers found
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-3">Order Summary</h6>
                                <div class="summary-card">
                                    <div id="orderSummary"><!-- populated dynamically --></div>
                                    <div class="summary-row">
                                        <span>Subtotal</span>
                                        <strong>Rs. <span id="modalSubtotal">0.00</span></strong>
                                    </div>
                                    <div class="summary-row summary-total">
                                        <span>Total</span>
                                        <strong>Rs. <span id="modalTotal">0.00</span></strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4 d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-confirm" id="confirmCheckoutBtn" disabled onclick="processTransaction()">
                                <i class="bi bi-check-circle me-2"></i>Confirm Transaction
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bill Modal -->
        <div class="modal fade" id="billModal" tabindex="-1" aria-labelledby="billModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="billModalLabel">
                            <i class="bi bi-receipt me-2"></i>Transaction Receipt
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="bill-container" id="billContent">
                            <!-- Bill content will be populated here -->
                        </div>
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-primary me-2" onclick="printBill()">
                                <i class="bi bi-printer me-2"></i>Print Bill
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Global variables
            let cart = [];
            let selectedCustomer = null;
            let currentBook = null;
            let transactionId = null;
            let allBooks = [];



            // Helper: robustly parse currency text like "Rs. 3,000.00" or "Rs 3000" or "3.000,50"
            function parsePriceText(text) {
                if (!text) return 0;
                const raw = String(text);
                // Grab the last numeric-looking token (handles cases with currency prefixes)
                const tokens = raw.match(/[0-9]+(?:[.,][0-9]+)*/g);
                if (!tokens || tokens.length === 0) return 0;
                let token = tokens[tokens.length - 1];
                // If both comma and dot exist, treat commas as thousands separators
                const hasComma = token.includes(',');
                const hasDot = token.includes('.');
                if (hasComma && hasDot) {
                    token = token.replace(/,/g, '');
                } else if (hasComma && !hasDot) {
                    // Only comma present: treat as decimal separator
                    token = token.replace(/,/g, '.');
                }
                const value = parseFloat(token);
                return isNaN(value) ? 0 : value;
            }

            // Search books functionality
            function searchBooks() {
                const searchTerm = document.getElementById('bookSearch').value.toLowerCase().trim();
                const productItems = document.querySelectorAll('#productList .product-item');
                let visibleCount = 0;
                
                productItems.forEach(item => {
                    const title = item.querySelector('.product-title')?.textContent?.toLowerCase() || '';
                    const category = item.querySelector('.product-category')?.textContent?.toLowerCase() || '';
                    
                    if (searchTerm === '' || title.includes(searchTerm) || category.includes(searchTerm)) {
                        item.style.display = '';
                        visibleCount++;
                    } else {
                        item.style.display = 'none';
                    }
                });
                
                // Update search status
                if (searchTerm === '') {
                    document.getElementById('searchStatus').textContent = 'Showing books';
                } else {
                    document.getElementById('searchStatus').textContent = `Found ${visibleCount} book(s) matching "${searchTerm}"`;
                }
            }

            // Refresh books functionality
            function refreshBooks() {
                document.getElementById('bookSearch').value = '';
                document.getElementById('searchStatus').textContent = 'Showing books';
                
                        // Show all books
                const productItems = document.querySelectorAll('#productList .product-item');
                productItems.forEach(item => {
                    item.style.display = '';
                });
            }



            // Show quantity modal
            function showQuantityModal(id, title, price, stock, category) {
                console.log('showQuantityModal called with:', { id, title, price, stock, category });
                
                // Comprehensive validation
                if (!id || id <= 0) {
                    console.error('Invalid book ID:', id);
                    alert('Error: Invalid book ID. Please try again.');
                    return;
                }
                
                if (!title || title.trim() === '') {
                    console.error('Invalid book title:', title);
                    alert('Error: Invalid book title. Please try again.');
                    return;
                }
                
                if (price === null || price === undefined || price <= 0) {
                    console.error('Invalid book price:', price);
                    alert('Error: Invalid book price. Please try again.');
                    return;
                }
                
                if (stock === null || stock === undefined || stock <= 0) {
                    console.error('Invalid book stock:', stock);
                    alert('Error: This book is out of stock or has invalid stock data.');
                    return;
                }
                
                // All validation passed
                currentBook = { id, title, price: Number(price), stock: Number(stock), category };
                document.getElementById('bookTitle').textContent = title;
                document.getElementById('bookCategoryBadge').textContent = category || 'N/A';
                document.getElementById('bookPrice').textContent = Number(price).toFixed(2);
                document.getElementById('bookStock').textContent = stock;
                document.getElementById('quantityInput').value = 1;
                document.getElementById('quantityInput').max = stock;
                document.getElementById('modalLineTotal').textContent = Number(price).toFixed(2);
                
                const modal = new bootstrap.Modal(document.getElementById('quantityModal'));
                modal.show();
            }

            // Safer DOM-driven open for product card
            function openQuantityFromItem(node) {
                const container = node.closest('.product-item');
                const idText = container?.dataset?.id || container?.getAttribute('data-id') || '0';
                const id = parseInt(idText, 10) || 0;
                const title = container.querySelector('.product-title')?.textContent?.trim() || '';
                const rawPriceText = container.querySelector('.product-price')?.textContent || '';
                const stockText = container.querySelector('.product-stock')?.textContent?.replace(/[^0-9]/g, '') || '0';
                const category = container.querySelector('.product-category')?.textContent?.trim() || '';
                const price = parsePriceText(rawPriceText);
                const stock = parseInt(stockText || '0', 10);
                showQuantityModal(id, title, price, stock, category);
            }

            // Confirm add to cart
            function confirmAddToCart() {
                // Validate currentBook
                if (!currentBook || !currentBook.stock) {
                    console.error('Invalid currentBook:', currentBook);
                    alert('Error: Invalid book data. Please try again.');
                    return;
                }
                
                const quantity = parseInt(document.getElementById('quantityInput').value);
                const stock = currentBook.stock;
                
                if (quantity < 1) {
                    alert('Quantity must be at least 1');
                    return;
                }
                
                if (quantity > stock) {
                    alert('Quantity cannot exceed available stock');
                    return;
                }
                
                const existingItem = cart.find(item => item.id === currentBook.id);
                
                if (existingItem) {
                    const newTotal = existingItem.quantity + quantity;
                    if (newTotal > stock) {
                        alert('Total quantity cannot exceed available stock');
                        return;
                    }
                    existingItem.quantity += quantity;
                } else {
                    cart.push({
                        id: currentBook.id,
                        title: currentBook.title,
                        price: currentBook.price,
                        quantity: quantity,
                        stock: currentBook.stock
                    });
                }
                
                updateCartDisplay();
                
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('quantityModal'));
                modal.hide();
                
                // Show success message
                showToast('Item added to cart successfully!', 'success');
            }

            // Stepper handlers for Add to Cart modal
            function stepQuantity(delta) {
                const input = document.getElementById('quantityInput');
                let value = parseInt(input.value || '1', 10) + delta;
                const max = parseInt(input.max || String(currentBook?.stock || 1), 10);
                if (value < 1) value = 1;
                if (value > max) value = max;
                input.value = value;
                updateLineTotal();
            }

            function handleQuantityInput() {
                const input = document.getElementById('quantityInput');
                let value = parseInt(input.value || '1', 10);
                if (isNaN(value) || value < 1) value = 1;
                const max = parseInt(input.max || String(currentBook?.stock || 1), 10);
                if (value > max) value = max;
                input.value = value;
                updateLineTotal();
            }

            function updateLineTotal() {
                const qty = parseInt(document.getElementById('quantityInput').value || '1', 10);
                const price = Number(currentBook?.price || 0);
                const line = qty * price;
                document.getElementById('modalLineTotal').textContent = line.toFixed(2);
            }

            // Update cart display
            function updateCartDisplay() {
                const cartItems = document.getElementById('cartItems');
                const cartSubtotal = document.getElementById('cartSubtotal');
                const cartTotal = document.getElementById('cartTotal');
                const checkoutBtn = document.getElementById('checkoutBtn');
                
                if (cart.length === 0) {
                    cartItems.innerHTML = `
                        <div class="empty-cart">
                            <i class="bi bi-cart" style="font-size: 2rem;"></i>
                            <p>Cart is empty</p>
                        </div>
                    `;
                    checkoutBtn.disabled = true;
                } else {
                    cartItems.innerHTML = '';
                    let total = 0;
                    
                    cart.forEach(item => {
                        const itemTotal = item.price * item.quantity;
                        total += itemTotal;
                        
                        const cartItem = document.createElement('div');
                        cartItem.className = 'cart-item';
                        cartItem.innerHTML = '<div class="cart-item-info">' +
                            '<div class="cart-item-title"><strong>' + item.title + '</strong></div>' +
                            '<div class="cart-item-details">' +
                            '<small class="text-muted">ID: ' + item.id + '</small><br>' +
                            '<small class="text-muted">Price: ' + item.price.toFixed(2) + ' x ' + item.quantity + '</small>' +
                            '</div>' +
                            '<div class="cart-item-price"><strong>' + itemTotal.toFixed(2) + '</strong></div>' +
                            '</div>' +
                            '<div class="cart-item-quantity">' +
                            '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', -1)">-</button>' +
                            '<span>' + item.quantity + '</span>' +
                            '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', 1)">+</button>' +
                            '</div>';
                        
                        cartItems.appendChild(cartItem);
                    });
                    
                    cartSubtotal.textContent = total.toFixed(2);
                    cartTotal.textContent = total.toFixed(2);
                    checkoutBtn.disabled = false;
                }
            }

            // Update quantity
            function updateQuantity(productId, change) {
                const item = cart.find(item => item.id === productId);
                
                if (item) {
                    const newQuantity = item.quantity + change;
                    
                    if (newQuantity <= 0) {
                        cart = cart.filter(item => item.id !== productId);
                    } else if (newQuantity > item.stock) {
                        alert('Quantity cannot exceed available stock');
                        return;
                    } else {
                        item.quantity = newQuantity;
                    }
                    
                    updateCartDisplay();
                }
            }

            // Reset checkout modal state
            function resetCheckoutModal() {
                selectedCustomer = null;
                document.getElementById('confirmCheckoutBtn').disabled = true;
                document.getElementById('modalTotal').textContent = '0.00';
                document.getElementById('orderSummary').innerHTML = '';
                document.querySelectorAll('.customer-item').forEach(item => {
                    item.classList.remove('selected');
                });
            }

            // Show checkout modal
            function showCheckoutModal() {
                if (cart.length === 0) {
                    alert('Cart is empty!');
                    return;
                }
                
                // Reset checkout modal state
                resetCheckoutModal();
                
                // Update order summary
                updateOrderSummary();
                
                const modal = new bootstrap.Modal(document.getElementById('checkoutModal'));
                modal.show();
            }

            // Select customer
            function selectCustomer(customerId, customerName, node) {
                selectedCustomer = { id: customerId, name: customerName };
                
                // Update UI
                document.querySelectorAll('.customer-item').forEach(item => {
                    item.classList.remove('selected');
                });
                const sourceItem = node || (typeof event !== 'undefined' && event.target ? event.target.closest('.customer-item') : null);
                if (sourceItem) {
                    sourceItem.classList.add('selected');
                }
                
                document.getElementById('confirmCheckoutBtn').disabled = false;
                // show chip
                const chip = document.getElementById('selectedCustomerChip');
                const chipName = document.getElementById('selectedCustomerName');
                if (chip && chipName) { chip.classList.remove('d-none'); chipName.textContent = customerName; }
            }

            // Safer DOM-driven select for customer
            function selectCustomerFromItem(node) {
                const name = node.querySelector('strong')?.textContent?.trim() || '';
                const idText = node?.dataset?.id || node?.getAttribute('data-id') || '0';
                const id = parseInt(idText, 10) || 0;
                selectCustomer(id, name, node);
            }

            // Update order summary
            function updateOrderSummary() {
                const orderSummary = document.getElementById('orderSummary');
                const modalTotal = document.getElementById('modalTotal');
                let subtotal = 0;
                
                let summaryHTML = '';
                cart.forEach(item => {
                    const itemTotal = item.price * item.quantity;
                    subtotal += itemTotal;
                    
                    summaryHTML += '<div class="d-flex justify-content-between mb-2">' +
                        '<div class="text-start">' +
                        '<div><strong>' + item.title + '</strong></div>' +
                        '<small class="text-muted">ID: ' + item.id + ' | Price: ' + item.price.toFixed(2) + ' x ' + item.quantity + '</small>' +
                        '</div>' +
                        '<div class="text-end">' +
                        '<strong>' + itemTotal.toFixed(2) + '</strong>' +
                        '</div>' +
                        '</div>';
                });
                
                orderSummary.innerHTML = summaryHTML;
                document.getElementById('modalSubtotal').textContent = subtotal.toFixed(2);
                modalTotal.textContent = subtotal.toFixed(2);
            }

            // After a successful sale, decrement the visible stock counts in the product list
            function updateProductStocksAfterSale(soldItems) {
                if (!Array.isArray(soldItems)) return;
                soldItems.forEach(function(item) {
                    const bookId = item.bookId ?? item.id;
                    const qty = parseInt(item.quantity, 10) || 0;
                    if (!bookId || qty <= 0) return;
                    const stockEl = document.querySelector('.product-item[data-id="' + bookId + '"] .product-stock');
                    if (!stockEl) return;
                    const current = parseInt((stockEl.textContent || '').replace(/[^0-9]/g, ''), 10) || 0;
                    const next = Math.max(0, current - qty);
                    stockEl.textContent = 'Stock: ' + next;
                });
            }

            // Process transaction 
            function processTransaction() {
                if (!selectedCustomer) {
                    alert('Please select a customer');
                    return;
                }
                
                if (cart.length === 0) {
                    alert('Cart is empty');
                    return;
                }
                
                // Calculate total amount from cart
                let totalAmount = 0;
                cart.forEach(item => {
                    totalAmount += item.price * item.quantity;
                });
                
                // Prepare transaction data
                const transactionData = {
                    customerId: selectedCustomer.id,
                    items: cart.map(item => ({
                        bookId: item.id,
                        quantity: item.quantity,
                        price: item.price
                    })),
                    totalAmount: totalAmount
                };
                
                // Debug: Log the transaction data
                console.log('Transaction data:', transactionData);
                console.log('JSON string:', JSON.stringify(transactionData));
                
                // Send transaction to server
                fetch('TransactionServlet?action=create', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(transactionData)
                })
                .then(response => response.json())
                .then(data => {
                    console.log('Server response:', data);
                    if (data.success) {
                        transactionId = data.transactionId;
                        showBill(data.transaction);
                        // Decrement visible stock counts in the product list
                        updateProductStocksAfterSale(transactionData.items);
                        
                        // Clear cart
                        cart = [];
                        updateCartDisplay();
                        
                        // Reset modal total and clear order summary
                        document.getElementById('modalTotal').textContent = '0.00';
                        document.getElementById('orderSummary').innerHTML = '';
                        
                        // Close checkout modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('checkoutModal'));
                        modal.hide();
                        
                        // Reset checkout modal state
                        resetCheckoutModal();
                        
                        showToast('Transaction completed successfully!', 'success');
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    console.error('Error details:', error.message);
                    alert('An error occurred while processing the transaction');
                });
            }

            // Show bill
            function showBill(transaction) {
                console.log('showBill called with transaction:', transaction);
                const billContent = document.getElementById('billContent');
                const billModal = document.getElementById('billModal');
                
                console.log('billContent element:', billContent);
                console.log('billModal element:', billModal);
                
                const currentDate = new Date().toLocaleDateString();
                const currentTime = new Date().toLocaleTimeString();
                
                let itemsHTML = '';
                let total = 0;
                
                // Check if transaction and items exist
                if (!transaction) {
                    console.error('Transaction is null or undefined');
                    return;
                }
                
                if (!transaction.items || !Array.isArray(transaction.items)) {
                    console.error('Transaction items is null, undefined, or not an array:', transaction.items);
                    return;
                }
                
                console.log('Transaction items:', transaction.items);
                
                transaction.items.forEach(item => {
                    console.log('Processing item:', item);
                    if (!item || !item.title || !item.quantity || !item.price) {
                        console.error('Invalid item data:', item);
                        return;
                    }
                    const itemTotal = item.price * item.quantity;
                    total += itemTotal;
                    
                    itemsHTML += '<div class="bill-item">' +
                                            '<span>' + item.title + ' x' + item.quantity + '</span>' +
                    '<span>' + itemTotal.toFixed(2) + '</span>' +
                        '</div>';
                });
                
                const billHTML = '<div class="bill-header">' +
                    '<h4 class="brand-title">BookShop</h4>' +
                    '<div class="bill-meta">Transaction Receipt</div>' +
                    '<div class="bill-meta">Date: ' + currentDate + ' &nbsp; | &nbsp; Time: ' + currentTime + '</div>' +
                    '<div class="bill-meta">Transaction ID: ' + (transaction.transactionId || 'N/A') + '</div>' +
                    '<div class="bill-meta">Customer: ' + (transaction.customerName || 'N/A') + '</div>' +
                    '</div>' +
                    '<div class="bill-items">' +
                    (itemsHTML || '<div class="text-center text-muted">No items to display</div>') +
                    '</div>' +
                    '<div class="bill-total d-flex justify-content-between">' +
                    '<span>Total:</span>' +
                    '<span>Rs. ' + total.toFixed(2) + '</span>' +
                    '</div>' +
                    '<div class="text-center mt-3">' +
                    '<p class="text-muted">Thank you for your purchase!</p>' +
                    '</div>';
                
                console.log('Generated bill HTML:', billHTML);
                billContent.innerHTML = billHTML;
                
                const modal = new bootstrap.Modal(document.getElementById('billModal'));
                console.log('Showing bill modal');
                modal.show();
                console.log('Bill modal should be visible now');
            }

            // Print bill
            function printBill() {
                const billContent = document.getElementById('billContent').innerHTML;
                const printWindow = window.open('', '_blank');
                printWindow.document.write(
                    '<html>' +
                    '<head>' +
                    '<title>Transaction Receipt</title>' +
                    '<style>' +
                    'body { font-family: Arial, sans-serif; margin: 20px; }' +
                    '.bill-container { max-width: 400px; margin: 0 auto; }' +
                    '.bill-header { text-align: center; border-bottom: 2px solid #ccc; padding-bottom: 10px; margin-bottom: 10px; }' +
                    '.bill-item { display: flex; justify-content: space-between; padding: 5px 0; border-bottom: 1px solid #eee; }' +
                    '.bill-total { border-top: 2px solid #ccc; padding-top: 10px; font-weight: bold; font-size: 1.2em; }' +
                    '@media print { body { margin: 0; } }' +
                    '</style>' +
                    '</head>' +
                    '<body>' +
                    '<div class="bill-container">' +
                    billContent +
                    '</div>' +
                    '</body>' +
                    '</html>'
                );
                printWindow.document.close();
                printWindow.print();
            }

            // Show toast notification
            function showToast(message, type = 'info') {
                // Create toast element
                const toast = document.createElement('div');
                toast.className = 'alert alert-' + type + ' alert-dismissible fade show position-fixed';
                toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                toast.innerHTML = message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                
                document.body.appendChild(toast);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.parentNode.removeChild(toast);
                    }
                }, 3000);
            }

            // Customer search functionality
            document.getElementById('customerSearch').addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const customerItems = document.querySelectorAll('.customer-item');
                
                customerItems.forEach(item => {
                    const customerName = item.querySelector('strong').textContent.toLowerCase();
                    const accountNumber = item.querySelector('small').textContent.toLowerCase();
                    
                    if (customerName.includes(searchTerm) || accountNumber.includes(searchTerm)) {
                        item.style.display = '';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });

            // Logout functionality
            function logout() {
                // Clear cart and session data
                cart = [];
                selectedCustomer = null;
                currentBook = null;
                transactionId = null;
                
                // Method 1: Try to call logout servlet via fetch
                fetch('LogoutServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    }
                })
                .then(response => {
                    // Redirect to login page after successful logout
                    window.location.href = 'login.jsp';
                })
                .catch(error => {
                    console.error('Logout error:', error);
                    // Method 2: Fallback - redirect directly to logout servlet
                    window.location.href = 'LogoutServlet';
                });
            }

            // Initialize POS
            document.addEventListener('DOMContentLoaded', function() {
                console.log('POS initialized with enhanced functionality');
                
                // Debug: Check loaded data
                const bookRows = document.querySelectorAll('#bookTableBody tr');
                console.log('Total book rows found:', bookRows.length);
                
                // Store all books for search functionality
                allBooks = Array.from(bookRows).map(row => ({
                    title: row.querySelector('td:nth-child(2)')?.textContent || '',
                    price: row.querySelector('td:nth-child(3)')?.textContent || '',
                    stock: row.querySelector('td:nth-child(4)')?.textContent || '',
                    category: row.querySelector('td:nth-child(5)')?.textContent || ''
                }));
                
                console.log('Books loaded for search:', allBooks.length);
            });
        </script>
    </body>
</html> 