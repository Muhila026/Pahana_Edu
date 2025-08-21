<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.TransactionServlet.Transaction,com.booking.TransactionServlet.TransactionItem,com.booking.TransactionServlet.Customer,com.booking.TransactionServlet.Book"%>

<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction View - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
        :root {
            /* Brand Colors */
            --primary-color: #2C3E91;       /* Deep royal blue - main brand color */
            --primary-hover: #1F2D6D;       /* Darker navy blue for hover */
            --secondary-color: #4A90E2;     /* Bright sky blue for highlights */

            /* Status Colors (blue-friendly) */
            --success-color: #3BB273;       /* Teal green - balanced with blue */
            --warning-color: #F4B400;       /* Golden yellow for alerts */
            --danger-color: #E63946;        /* Strong coral red */
            --info-color: #5DADEC;          /* Soft info blue */

            /* Backgrounds */
            --background-color: #F4F8FC;    /* Very light blue-gray background */
            --card-background: #FFFFFF;     /* Clean white cards */

            /* Text Colors */
            --text-primary: #1E293B;        /* Dark navy-gray for readability */
            --text-secondary: #475569;      /* Muted cool gray for secondary text */

            /* Borders & Accents */
            --border-color: #D0D9E6;        /* Soft bluish-gray border */
            --sidebar-bg: #2C3E91;          /* Deep blue sidebar */
            --sidebar-hover: #1F2D6D;       /* Darker hover state */
            --sidebar-active-bg: #4A90E2;   /* Bright blue for active item */
            --sidebar-active-text: #ffffff; /* White text on active item */
            --accent-color: #3FA9F5;        /* Fresh accent blue */
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
                color: var(--sidebar-active-text);
                overflow-y: auto;
                z-index: 1000;
            transition: all 0.3s ease;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
                text-align: center;
            }

        .sidebar-title {
            font-size: 1.4rem;
                font-weight: 700;
            color: var(--sidebar-active-text);
            margin-bottom: 0.5rem;
        }

        .sidebar-subtitle {
            font-size: 0.9rem;
            color: var(--sidebar-active-text);
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
            color: var(--sidebar-active-text);
                text-decoration: none;
                transition: all 0.3s ease;
            border-radius: 0;
            font-weight: 500;
            }

            .nav-link.active { background: var(--sidebar-active-bg); color: var(--sidebar-active-text); }

            .nav-link i {
                width: 20px;
            margin-right: 12px;
            font-size: 1.1rem;
            }

            .sidebar-footer { padding: 1.5rem; border-top: 1px solid var(--border-color); margin-top: auto; }

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
            background: var(--primary-color);
            color: var(--sidebar-active-text);
            padding: 2.5rem;
            border-radius: 20px;
                margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before { content: none; }

        @keyframes float { 0% { } }

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

        .card-title i {
            color: var(--primary-color);
            }

            /* Transaction Details */
            .transaction-details {
            background: var(--card-background);
            border-radius: 12px;
                padding: 2rem;
                margin-bottom: 2rem;
            }

            .transaction-info {
                display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .info-item {
                background: white;
            padding: 1.5rem;
            border-radius: 12px;
            border-left: 4px solid var(--primary-color);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .info-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .info-label {
                font-weight: 600;
            color: var(--text-secondary);
                margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            }

            .info-value {
            color: var(--text-primary);
            font-size: 1.2rem;
            font-weight: 600;
        }

        /* Table Styling */
        .table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
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
            background-color: #f8fafc;
        }

        .table tfoot { background: var(--success-color); color: var(--sidebar-active-text); }

        .table tfoot td {
            padding: 1.5rem 1rem;
            font-weight: 600;
            border: none;
            }

            /* Button Styles */
            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
            font-weight: 500;
                transition: all 0.3s ease;
                border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn:hover {
            transform: translateY(-2px);
            text-decoration: none;
            }

            .btn-secondary {
            background: var(--secondary-color);
                color: white;
            }

            .btn-secondary:hover {
            background: #475569;
            color: white;
            }

            /* Alert Styles */
            .alert {
            border-radius: 12px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
                border: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            }

            .alert-success { background: var(--success-color); color: var(--sidebar-active-text); }

            .alert-danger { background: var(--danger-color); color: var(--sidebar-active-text); }

        .alert-info { background: var(--info-color); color: var(--sidebar-active-text); }

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
            
            .transaction-info {
                grid-template-columns: 1fr;
                }

                .card-title {
                    flex-direction: column;
                align-items: flex-start;
                    gap: 1rem;
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
            
            // Get transaction from request attribute
            Transaction transaction = (Transaction) request.getAttribute("transaction");
            
            if (transaction == null) {
                response.sendRedirect("TransactionServlet?action=list&error=Transaction not found.");
                return;
            }
        %>

            <!-- Sidebar -->
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
                        <i class="fas fa-tachometer-alt"></i>
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
                
                <% if ("ADMIN".equals(userRole)) { %>
                <div class="nav-item">
                    <a href="UserRoleServlet?action=list" class="nav-link">
                        <i class="fas fa-user-shield"></i>
                        UserRole
                    </a>
                </div>
                <% } %>
                
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
                        <i class="fas fa-tachometer-alt"></i>
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
                <i class="fas fa-receipt me-3"></i>
                <% if ("CUSTOMER".equals(userRole)) { %>
                    My Transaction Details
                <% } else { %>
                    Transaction Details
                <% } %>
            </h1>
            <p class="page-subtitle">
                <% if ("CUSTOMER".equals(userRole)) { %>
                    View details of your purchase transaction
                <% } else { %>
                    View complete information about this transaction
                <% } %>
            </p>
                </div>

                <!-- Messages -->
                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
            <i class="fas fa-check-circle"></i><%= request.getParameter("message") %>
                </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
            <i class="fas fa-exclamation-triangle"></i><%= request.getParameter("error") %>
                </div>
                <% } %>

                <!-- Transaction Details -->
                <div class="content-card">
                    <h3 class="card-title">
                <i class="fas fa-info-circle"></i>Transaction Information
                    </h3>
                    
                    <div class="transaction-details">
                        <div class="transaction-info">
                            <div class="info-item">
                                <div class="info-label">Transaction ID</div>
                        <div class="info-value">#<%= transaction.getTransactionId() %></div>
                            </div>
                            
                            <div class="info-item">
                        <div class="info-label">Customer Name</div>
                                <div class="info-value">
                            <%= transaction.getCustomer() != null ? transaction.getCustomer().getName() : "N/A" %>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Total Amount</div>
                        <div class="info-value">Rs.<%= String.format("%.2f", transaction.getTotalAmount()) %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Created By</div>
                        <div class="info-value">
                            <%= transaction.getCreatedBy() != null ? transaction.getCreatedBy().getUsername() : "N/A" %>
                        </div>
                            </div>
                            
                            <div class="info-item">
                        <div class="info-label">Transaction Date</div>
                        <div class="info-value">
                            <%= transaction.getCreatedAt() != null ? transaction.getCreatedAt() : "N/A" %>
                        </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Items Count</div>
                        <div class="info-value">
                            <%= transaction.getItems() != null ? transaction.getItems().size() : 0 %> items
                        </div>
                    </div>
                </div>
                
                <div class="text-center">
                    <a href="TransactionServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>Back to Transactions
                    </a>
                        </div>
                    </div>
                </div>

                <!-- Transaction Items -->
                <div class="content-card">
                    <h3 class="card-title">
                <i class="fas fa-list-ul"></i>Transaction Items
                    </h3>
                    
                    <% if (transaction.getItems() != null && !transaction.getItems().isEmpty()) { %>
                    <div class="table-responsive">
                <table class="table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Book Title</th>
                            <th>Category</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Line Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    int itemNumber = 1;
                                    for (TransactionItem item : transaction.getItems()) { 
                                %>
                                <tr>
                                    <td><%= itemNumber++ %></td>
                            <td>
                                <strong><%= item.getBook() != null ? item.getBook().getTitle() : "N/A" %></strong>
                            </td>
                            <td>
                                <%= item.getBook() != null && item.getBook().getCategory() != null ? 
                                    item.getBook().getCategory().getCategoryName() : "N/A" %>
                            </td>
                            <td>
                                <span class="badge bg-primary"><%= item.getQuantity() %></span>
                            </td>
                            <td>Rs.<%= String.format("%.2f", item.getPrice()) %></td>
                            <td>
                                <strong>Rs.<%= String.format("%.2f", item.getPrice().multiply(new java.math.BigDecimal(item.getQuantity()))) %></strong>
                            </td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                        <tr>
                            <td colspan="5" class="text-end"><strong>Transaction Total:</strong></td>
                            <td><strong>Rs.<%= String.format("%.2f", transaction.getTotalAmount()) %></strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <% } else { %>
                    <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>No items found for this transaction.
                    </div>
                    <% } %>
            </div>
        </div>

        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
        // Mobile sidebar functionality
            function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('open');
        }

        // Close sidebar on window resize
        window.addEventListener('resize', function() {
            if (window.innerWidth > 1024) {
                document.getElementById('sidebar').classList.remove('open');
            }
        });
        </script>
    </body>
</html> 