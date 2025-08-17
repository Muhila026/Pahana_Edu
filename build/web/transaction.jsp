<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.TransactionServlet.Transaction"%>
<%@page import="com.booking.TransactionServlet.TransactionItem"%>
<%@page import="com.booking.TransactionServlet.Customer"%>
<%@page import="com.booking.TransactionServlet.Book"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Management - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
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
                --sidebar-bg: #ffffff;          /* Clean white sidebar */
                --sidebar-hover: #ecdbeb;       /* Light lavender hover */
                --sidebar-active-bg: #57b8bf;   /* Teal active background */
                --sidebar-active-text: #ffffff; /* White text on active sidebar item */
                --accent-color: #57b8bf;        /* Teal highlights */
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
                color: var(--primary-color);
                overflow-y: auto;
                z-index: 1000;
            transition: all 0.3s ease;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--sidebar-hover);
                text-align: center;
            }

                .sidebar-title {
            font-size: 1.4rem;
                font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .sidebar-subtitle {
            font-size: 0.9rem;
            color: var(--primary-color);
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
            color: var(--primary-color);
                text-decoration: none;
                transition: all 0.3s ease;
            border-radius: 0;
                font-weight: 500;
            }



            .nav-link.active {
            background: var(--accent-color);
                color: white;
            }

            .nav-link:hover {
                background: var(--sidebar-hover);
                color: var(--text-primary);
            }

            .nav-link i {
            width: 20px;
            margin-right: 12px;
                font-size: 1.1rem;
            }

            .sidebar-footer {
            padding: 1.5rem;
            border-top: 1px solid var(--sidebar-hover);
                margin-top: auto;
            }

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
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: white;
            padding: 2.5rem;
            border-radius: 20px;
                margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

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

        .btn-secondary {
            background: var(--secondary-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #475569;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(100, 116, 139, 0.3);
        }

        .btn-info {
            background: var(--info-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-info:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
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
            if ("ADMIN".equals(userRole) || "MANAGER".equals(userRole)) { 
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
                    <a href="TransactionServlet?action=list" class="nav-link active">
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
                    <a href="UserRoleServlet?action=list" class="nav-link">
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
            <% } else if ("STAFF".equals(userRole)) { %>
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
                    <a href="TransactionServlet?action=list" class="nav-link active">
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
            <% } else if ("CUSTOMER".equals(userRole)) { %>
                <!-- CUSTOMER see minimal menu items -->
                <div class="nav-item">
                    <a href="TransactionServlet?action=list" class="nav-link active">
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
            <% } else { %>
                <!-- Default fallback for unknown roles -->
                <div class="nav-item">
                    <a href="profile.jsp" class="nav-link active">
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
                <i class="fas fa-shopping-cart me-3"></i>
                <% if ("CUSTOMER".equals(userRole)) { %>
                    My Transactions
                            <% } else { %>
                            Transaction Management
                            <% } %>
                        </h1>
            <p class="page-subtitle">
                <% if ("CUSTOMER".equals(userRole)) { %>
                    View your purchase history and transaction details
                <% } else { %>
                    View and manage all sales transactions and purchase history
                <% } %>
            </p>
                </div>

                <!-- Messages -->
                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i><%= request.getParameter("message") %>
                </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
            <i class="fas fa-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                </div>
                <% } %>
                
                <!-- Info message for direct JSP access -->
                <% 
                // Check if transactions data is loaded (will be declared later in the table section)
                if (request.getAttribute("transactions") == null) { 
                %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Note:</strong> This page should be accessed through the Transaction menu. 
                        <a href="TransactionServlet?action=list" class="alert-link">Click here to load transactions</a> or use the Refresh button.
                </div>
                <% } %>

                <!-- Transaction List -->
                <div class="content-card">
                    <h3 class="card-title">
                <span>
                    <% if ("CUSTOMER".equals(userRole)) { %>
                        <i class="fas fa-receipt me-2"></i>My Transaction History
                            <% } else { %>
                        <i class="fas fa-receipt me-2"></i>Transaction List
                            <% } %>
                        </span>
                        <div>
                            <a href="javascript:void(0)" onclick="refreshTransactions()" class="btn btn-secondary me-2">
                        <i class="fas fa-arrow-clockwise me-2"></i>Refresh
                            </a>
                        </div>
                    </h3>
                    

                    
                    <div class="table-responsive">
                <table class="table">
                            <thead>
                                <tr>
                                    <th>Transaction ID</th>
                                    <% if (!"CUSTOMER".equals(userRole)) { %>
                                    <th>Customer</th>
                                    <% } %>
                                    <th>Total Amount</th>
                                    <% if (!"CUSTOMER".equals(userRole)) { %>
                                    <th>Created By</th>
                                    <% } %>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                                    

                                    
                                    if (transactions != null && !transactions.isEmpty()) {
                                        for (Transaction transaction : transactions) {
                                %>
                                <tr>
                                    <td><%= transaction.getTransactionId() %></td>
                                    <% if (!"CUSTOMER".equals(userRole)) { %>
                                    <td>
                                            <% if (transaction.getCustomer() != null) { %>
                                        <%= transaction.getCustomer().getName() %>
                                            <% } else { %>
                                                <span class="text-muted">N/A</span>
                                            <% } %>
                                        </td>
                                    <% } %>
                                    <td><strong>Rs.<%= String.format("%.2f", transaction.getTotalAmount()) %></strong></td>
                                    <% if (!"CUSTOMER".equals(userRole)) { %>
                                        <td>
                                            <% if (transaction.getCreatedBy() != null) { %>
                                                <%= transaction.getCreatedBy().getUsername() %>
                                            <% } else { %>
                                                <span class="text-muted">N/A</span>
                                            <% } %>
                                    </td>
                                    <% } %>
                                    <td>
                                        <% if (transaction.getCreatedAt() != null) { %>
                                            <%= transaction.getCreatedAt() %>
                                        <% } else { %>
                                            <span class="text-muted">N/A</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="TransactionServlet?action=view&transaction_id=<%= transaction.getTransactionId() %>" 
                                   class="btn btn-info btn-sm">
                                    <i class="fas fa-eye me-1"></i>View
                                        </a>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                <tr>
                            <td colspan="<%= "CUSTOMER".equals(userRole) ? "4" : "6" %>" class="text-center text-muted">
                                <i class="fas fa-inbox me-2"></i>
                                <% if ("CUSTOMER".equals(userRole)) { %>
                                    No transactions found.
                                    <br><small>You haven't made any purchases yet. Visit our store to make your first purchase!</small>
                                        <% } else { %>
                                    No transactions found.
                                        <br><small>Create your first transaction using the POS system.</small>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                </div>
            </div>
        </div>

        <div id="transactionsMeta" data-has-transactions='<%= (request.getAttribute("transactions") != null) %>' style="display:none"></div>

        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
        // Mobile sidebar functionality
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            sidebar.classList.toggle('open');
            overlay.classList.toggle('open');
            }

        function closeSidebar() {
                const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            sidebar.classList.remove('open');
            overlay.classList.remove('open');
        }

        // Refresh transactions function
        function refreshTransactions() {
            // Show loading state
            const refreshBtn = document.querySelector('.btn-secondary');
            const originalText = refreshBtn.innerHTML;
            refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Refreshing...';
            refreshBtn.disabled = true;
            
            // Redirect to TransactionServlet to load fresh data
            window.location.href = 'TransactionServlet?action=list';
        }

        // Auto-redirect if no transactions data is present
        window.addEventListener('load', function() {
            var metaEl = document.getElementById('transactionsMeta');
            var hasTransactionsData = metaEl && metaEl.dataset && metaEl.dataset.hasTransactions === 'true';
            if (!hasTransactionsData) {
                window.location.href = 'TransactionServlet?action=list';
            }
        });

        // Close sidebar when clicking on a link (mobile)
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth <= 1024) {
                    closeSidebar();
                }
            });
        });

        // Close sidebar on window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 1024) {
                closeSidebar();
                }
            });
        </script>
    </body>
</html> 