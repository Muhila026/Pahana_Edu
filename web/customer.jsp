<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.CustomerServlet.Customer"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - BookShop</title>
    
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

        .btn-success {
            background: var(--success-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

        .btn-success:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .btn-warning {
            background: var(--warning-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

        .btn-warning:hover {
            background: #d97706;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Custom Action Button Styles */
        .btn-edit {
            background: var(--accent-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-edit:hover {
            background: #ea580c;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.3);
            color: white;
        }

        .btn-delete {
            background: var(--danger-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            color: white;
        }

        /* View Button Style - Blue like edit but blue color */
        .btn-view {
            background: var(--primary-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-view:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
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
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equals(role) || "MANAGER".equals(role)) { 
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
                    <a href="TransactionServlet?action=list" class="nav-link">
                        <i class="fas fa-shopping-cart"></i>
                        Transaction
                    </a>
                </div>
                
                <div class="nav-item">
                    <a href="CustomerServlet?action=list" class="nav-link active">
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
            <% } else if ("STAFF".equals(role)) { %>
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
                    <a href="TransactionServlet?action=list" class="nav-link">
                        <i class="fas fa-shopping-cart"></i>
                        Transaction
                    </a>
                </div>
                
                <div class="nav-item">
                    <a href="CustomerServlet?action=list" class="nav-link active">
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
            <% } else if ("CUSTOMER".equals(role)) { %>
                <!-- CUSTOMER see minimal menu items -->
                <div class="nav-item">
                    <a href="TransactionServlet?action=list" class="nav-link">
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
                <i class="fas fa-user-friends me-3"></i>Customer Management
            </h1>
            <p class="page-subtitle">Manage all customer accounts and information in your bookstore</p>
                        </div>
                        
                <!-- Messages -->
                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle me-2"></i><%= request.getParameter("message") %>
                                    </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                        </div>
                <% } %>

                <!-- Customer List -->
                <div class="content-card">
                    <div class="d-flex justify-content-between align-items-center">
                    <h3 class="card-title">
                            <i class="fas fa-users me-2"></i>Customer List
                    </h3>
                        <div class="d-flex gap-2">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                                <i class="fas fa-plus-circle me-2"></i>Add New Customer
                                        </button>
                            <a href="CustomerServlet?action=list" class="btn btn-outline-primary">
                                <i class="fas fa-sync-alt me-2"></i>Refresh
                            </a>
                            </div>
                        </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Account Number</th>
                                    <th>Name</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Created By</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                                    if (customers != null && !customers.isEmpty()) {
                                        for (Customer customer : customers) {
                                %>
                                <tr>
                                    <td><%= customer.getCustomerId() %></td>
                                    <td><%= customer.getAccountNumber() %></td>
                                    <td><%= customer.getName() %></td>
                                    <td><%= customer.getUsername() != null ? customer.getUsername() : "N/A" %></td>
                                    <td><%= customer.getEmail() != null ? customer.getEmail() : "N/A" %></td>
                                    <td><%= customer.getPhone() %></td>
                                    <td><%= customer.getAddress() %></td>
                                    <td><%= customer.getCreatedBy() != null ? customer.getCreatedBy().getUsername() : "N/A" %></td>
                                    <td>
                                        <a href="CustomerServlet?action=view&customer_id=<%= customer.getCustomerId() %>" 
                                           class="btn btn-view btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="customer_edit.jsp?customer_id=<%= customer.getCustomerId() %>" class="btn btn-edit btn-sm">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button class="btn btn-delete btn-sm" data-customer-id="<%= customer.getCustomerId() %>" onclick="deleteCustomer(this.dataset.customerId)" 
                                                title="Delete customer">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="9" class="text-center">No customers found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Toggle sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.getElementById('sidebarOverlay');
                sidebar.classList.toggle('open');
                overlay.classList.toggle('open');
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.mobile-menu-toggle');
                const overlay = document.getElementById('sidebarOverlay');
                
                if (window.innerWidth <= 1024) { // Adjust breakpoint for mobile menu
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target) && !overlay.contains(event.target)) {
                        sidebar.classList.remove('open');
                        overlay.classList.remove('open');
                    }
                }
            });

            // Customer management functions
            function editCustomer(customerId) {
                // Navigate to edit page
                window.location.href = 'customer_edit.jsp?customer_id=' + customerId;
            }

            function deleteCustomer(customerId) {
                // Create custom popup
                const popup = document.createElement('div');
                popup.className = 'custom-popup-overlay';
                popup.innerHTML = 
                    '<div class="custom-popup">' +
                        '<div class="custom-popup-header">' +
                            '<h5>Confirm Delete</h5>' +
                            '<button type="button" class="btn-close" onclick="closePopup()">&times;</button>' +
                        '</div>' +
                        '<div class="custom-popup-body">' +
                            '<p>Are you sure you want to delete this customer?</p>' +
                        '</div>' +
                        '<div class="custom-popup-footer">' +
                            '<button type="button" class="btn btn-secondary" onclick="closePopup()">Cancel</button>' +
                            '<button type="button" class="btn btn-danger" onclick="confirmDelete(' + customerId + ')">Delete</button>' +
                        '</div>' +
                    '</div>';
                document.body.appendChild(popup);
            }

            function closePopup() {
                const popup = document.querySelector('.custom-popup-overlay');
                if (popup) {
                    popup.remove();
                }
            }

            function confirmDelete(customerId) {
                // Create AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=delete&customer_id=' + customerId, true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        closePopup();
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    // Show success message
                                    showAlert(response.message, 'success');
                                    // Reload the page after a short delay
                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 1500);
                                } else {
                                    // Show error message
                                    showAlert(response.message, 'error');
                                }
                            } catch (e) {
                                // Fallback for non-JSON responses
                                showAlert('Customer deleted successfully!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        } else {
                            // Show error message
                            showAlert('Failed to delete customer. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send();
            }

            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' alert-dismissible fade show';
                alertDiv.style.position = 'fixed';
                alertDiv.style.top = '20px';
                alertDiv.style.right = '20px';
                alertDiv.style.zIndex = '9999';
                alertDiv.style.minWidth = '300px';
                alertDiv.innerHTML = 
                    message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(alertDiv);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 3000);
            }

            // Toggle password visibility
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                const icon = document.getElementById(inputId + 'Icon');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }
            
            // Email verification functions
            function sendVerificationCode() {
                const email = document.getElementById('email').value.trim();
                
                if (!email) {
                    showAlert('Please enter an email address first.', 'error');
                    return;
                }
                
                // Validate email format
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    showAlert('Please enter a valid email address.', 'error');
                    return;
                }
                
                // Disable the send button and show loading state
                const sendBtn = document.getElementById('sendVerificationBtn');
                const originalText = sendBtn.innerHTML;
                sendBtn.disabled = true;
                sendBtn.innerHTML = '<i class="bi bi-hourglass-split"></i>';
                
                // Send AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=sendVerificationCode', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        // Re-enable the send button
                        sendBtn.disabled = false;
                        sendBtn.innerHTML = originalText;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    showAlert(response.message, 'success');
                                    // Show verification row
                                    document.getElementById('verificationRow').style.display = 'block';
                                    // Focus on verification pin input
                                    document.getElementById('verificationPin').focus();
                                } else {
                                    showAlert(response.message, 'error');
                                }
                            } catch (e) {
                                showAlert('Verification code sent successfully!', 'success');
                                document.getElementById('verificationRow').style.display = 'block';
                                document.getElementById('verificationPin').focus();
                            }
                        } else {
                            showAlert('Failed to send verification code. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send('email=' + encodeURIComponent(email));
            }
            
            function verifyEmail() {
                const email = document.getElementById('email').value.trim();
                const verificationPin = document.getElementById('verificationPin').value.trim();
                
                if (!verificationPin) {
                    showAlert('Please enter the verification code.', 'error');
                    return;
                }
                
                // Disable the verify button and show loading state
                const verifyBtn = document.getElementById('verifyEmailBtn');
                const originalText = verifyBtn.innerHTML;
                verifyBtn.disabled = true;
                verifyBtn.innerHTML = '<i class="bi bi-hourglass-split"></i>';
                
                // Send AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=verifyEmail', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        // Re-enable the verify button
                        verifyBtn.disabled = false;
                        verifyBtn.innerHTML = originalText;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    showAlert(response.message, 'success');
                                    // Enable the Add Customer button
                                    const addCustomerBtn = document.getElementById('addCustomerBtn');
                                    addCustomerBtn.disabled = false;
                                    console.log('Add Customer button enabled: ' + !addCustomerBtn.disabled);
                                    // Show verification status
                                    showVerificationStatus('Email verified successfully!', 'success');
                                    // Make email read-only and disable verification controls
                                    document.getElementById('email').readOnly = true;
                                    document.getElementById('sendVerificationBtn').disabled = true;
                                    document.getElementById('verificationPin').disabled = true;
                                    document.getElementById('verifyEmailBtn').disabled = true;
                                } else {
                                    showAlert(response.message, 'error');
                                    showVerificationStatus('Verification failed. Please try again.', 'error');
                                }
                            } catch (e) {
                                console.log('JSON parse error, using fallback logic');
                                showAlert('Email verified successfully!', 'success');
                                const addCustomerBtn = document.getElementById('addCustomerBtn');
                                addCustomerBtn.disabled = false;
                                console.log('Add Customer button enabled (fallback): ' + !addCustomerBtn.disabled);
                                showVerificationStatus('Email verified successfully!', 'success');
                                // Make email read-only and disable verification controls
                                document.getElementById('email').readOnly = true;
                                document.getElementById('sendVerificationBtn').disabled = true;
                                document.getElementById('verificationPin').disabled = true;
                                document.getElementById('verifyEmailBtn').disabled = true;
                            }
                        } else {
                            showAlert('Failed to verify email. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send('email=' + encodeURIComponent(email) + '&verificationCode=' + encodeURIComponent(verificationPin));
            }
            
            function showVerificationStatus(message, type) {
                const statusDiv = document.getElementById('verificationStatus');
                const messageSpan = document.getElementById('verificationMessage');
                
                statusDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger');
                messageSpan.textContent = message;
                statusDiv.style.display = 'block';
                
                // Auto hide after 5 seconds
                setTimeout(() => {
                    statusDiv.style.display = 'none';
                }, 5000);
            }
            
            function submitForm(event) {
                console.log('Form submission started');
                console.log('Form data:');
                console.log('  Name:', document.getElementById('name').value);
                console.log('  Phone:', document.getElementById('phone').value);
                console.log('  Address:', document.getElementById('address').value);
                console.log('  Username:', document.getElementById('username').value);
                console.log('  Email:', document.getElementById('email').value);
                console.log('  Password:', document.getElementById('password').value);
                console.log('  Verification Pin:', document.getElementById('verificationPin').value);
                
                // Check if verification is complete
                if (document.getElementById('addCustomerBtn').disabled) {
                    console.log('ERROR: Add Customer button is still disabled');
                    event.preventDefault();
                    return false;
                }
                
                console.log('Form submission proceeding...');
                return true;
            }
            
            // Reset form when email changes (guard if element exists)
            (function() {
                var emailInput = document.getElementById('email');
                if (!emailInput) return;
                emailInput.addEventListener('input', function() {
                    // Reset verification state
                    var verificationRow = document.getElementById('verificationRow');
                    var verificationStatus = document.getElementById('verificationStatus');
                    var verificationPin = document.getElementById('verificationPin');
                    if (verificationRow) verificationRow.style.display = 'none';
                    if (verificationStatus) verificationStatus.style.display = 'none';
                    if (verificationPin) verificationPin.value = '';
                    
                    // Re-enable email field and verification controls
                    emailInput.readOnly = false;
                    var sendBtn = document.getElementById('sendVerificationBtn');
                    var verifyBtn = document.getElementById('verifyEmailBtn');
                    if (sendBtn) sendBtn.disabled = false;
                    if (verificationPin) verificationPin.disabled = false;
                    if (verifyBtn) verifyBtn.disabled = false;
                });
            })();
        </script>

        <!-- Add Customer Modal -->
        <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCustomerModalLabel">
                            <i class="fas fa-user-plus me-2"></i>Add New Customer
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="CustomerServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Customer Name *</label>
                                        <input type="text" class="form-control" id="name" name="name" required placeholder="Enter customer name">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone Number *</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" required placeholder="Enter phone number">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address *</label>
                                        <textarea class="form-control" id="address" name="address" rows="3" required placeholder="Enter customer address"></textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username *</label>
                                        <input type="text" class="form-control" id="username" name="username" required placeholder="Enter username">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email *</label>
                                        <div class="input-group">
                                            <input type="email" class="form-control" id="email" name="email" required placeholder="Enter email address">
                                            <button class="btn btn-outline-primary" type="button" id="sendVerificationBtn" onclick="sendVerificationCode()">
                                                <i class="fas fa-envelope"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password *</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter password">
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password')">
                                                <i class="fas fa-eye" id="passwordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Email Verification Row -->
                            <div class="row verification-row" id="verificationRow" style="display: none;">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="verificationPin" class="form-label">Verification Pin</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="verificationPin" name="verificationPin" placeholder="Enter 6-digit code" maxlength="6">
                                            <button class="btn btn-outline-success" type="button" id="verifyEmailBtn" onclick="verifyEmail()">
                                                <i class="fas fa-check-circle"></i>
                                            </button>
                                        </div>
                                        <small class="form-text text-muted">Enter the 6-digit verification code sent to your email</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="alert alert-info verification-status" id="verificationStatus" style="display: none;">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <span id="verificationMessage"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" id="addCustomerBtn">
                                <i class="fas fa-plus-circle me-2"></i>Add Customer
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html> 