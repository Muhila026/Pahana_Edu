<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.CustomerServlet.Customer"%>
<%@page import="com.booking.CustomerServlet"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Edit - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
        :root {
            /* Brand Colors */
            --primary-color: #2C3E91;
            --primary-hover: #1F2D6D;
            --secondary-color: #4A90E2;

            /* Status Colors (blue-friendly) */
            --success-color: #3BB273;
            --warning-color: #F4B400;
            --danger-color: #E63946;
            --info-color: #5DADEC;

            /* Backgrounds */
            --background-color: #F4F8FC;
            --card-background: #FFFFFF;

            /* Text Colors */
            --text-primary: #1E293B;
            --text-secondary: #475569;

            /* Borders & Accents */
            --border-color: #D0D9E6;
            --sidebar-bg: #2C3E91;
            --sidebar-hover: #1F2D6D;
            --sidebar-active-bg: #4A90E2;
            --sidebar-active-text: #ffffff;
            --accent-color: #3FA9F5;
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
            color: var(--accent-color);
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
                justify-content: space-between;
            gap: 1rem;
        }

        .card-title i {
            color: var(--primary-color);
        }

        /* Form Styles */
        .form-section {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

            .form-group {
            margin-bottom: 0;
            }

            .form-label {
                font-weight: 600;
            color: var(--text-secondary);
                margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            }

            .form-control {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.875rem;
                font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            color: var(--text-primary);
            }

            .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
                outline: none;
            }

        .form-control[readonly] {
            background-color: #f1f5f9;
            color: var(--text-secondary);
            cursor: not-allowed;
        }

            .form-control.is-invalid {
            border-color: var(--danger-color);
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
            }

            .invalid-feedback {
                display: block;
                width: 100%;
            margin-top: 0.5rem;
            font-size: 0.875rem;
            color: var(--danger-color);
        }

        .full-width-field {
            grid-column: 1 / -1;
        }

        /* Button Styles */
        .btn {
            padding: 0.875rem 1.75rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .btn:hover {
            transform: translateY(-2px);
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-hover);
            color: white;
        }

        .btn-secondary {
            background: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background: #475569;
            color: white;
        }

        .btn-danger {
            background: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            color: white;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
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

        .alert-success {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            }

            .alert-danger {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        .alert-info {
            background: linear-gradient(135deg, var(--info-color), #2563eb);
            color: white;
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
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .card-title {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .btn-group {
                flex-direction: column;
                width: 100%;
            }
            
            .btn {
                width: 100%;
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
            
            CustomerServlet customerServlet = new CustomerServlet();
            Customer customer = null;
            String errorMessage = "";
            String successMessage = "";
            
            // Handle form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    int customerId = Integer.parseInt(request.getParameter("customerId"));
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String customerUsername = request.getParameter("username");
                    String email = request.getParameter("email");
                    
                    // Validation
                    if (name == null || name.trim().isEmpty()) {
                        errorMessage = "Customer name is required";
                    } else if (phone == null || phone.trim().isEmpty()) {
                        errorMessage = "Phone number is required";
                    } else {
                        // Get existing customer
                        customer = customerServlet.getCustomerById(customerId);
                        if (customer != null) {
                            // Update customer details
                            customer.setName(name.trim());
                            customer.setPhone(phone.trim());
                            customer.setAddress(address != null ? address.trim() : "");
                            customer.setUsername(customerUsername != null ? customerUsername.trim() : "");
                            customer.setEmail(email != null ? email.trim() : "");
                            
                            if (customerServlet.updateCustomer(customer)) {
                                // Redirect back to list to auto-refresh the page with success message
                                response.sendRedirect("CustomerServlet?action=list&message=Customer updated successfully.");
                                return;
                            } else {
                                errorMessage = "Failed to update customer";
                            }
                        } else {
                            errorMessage = "Customer not found";
                        }
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid customer ID";
                } catch (Exception e) {
                    errorMessage = "Error updating customer: " + e.getMessage();
                }
            }
            
            // Load customer data for editing
            if (customer == null) {
                try {
                    String customerIdParam = request.getParameter("customer_id");
                    if (customerIdParam == null) {
                        customerIdParam = request.getParameter("id");
                    }
                    
                    if (customerIdParam != null) {
                        int customerId = Integer.parseInt(customerIdParam);
                        customer = customerServlet.getCustomerById(customerId);
                        
                        if (customer == null) {
                            errorMessage = "Customer not found with ID: " + customerId;
                        }
                    } else {
                        errorMessage = "No customer ID provided";
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid customer ID provided";
                } catch (Exception e) {
                    errorMessage = "Error retrieving customer: " + e.getMessage();
                }
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
            <% } else if ("CUSTOMER".equals(userRole)) { %>
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
                <i class="fas fa-edit me-3"></i>Edit Customer
            </h1>
            <p class="page-subtitle">Update customer information and details</p>
        </div>

        <!-- Messages -->
                    <% if (!errorMessage.isEmpty()) { %>
                        <div class="alert alert-danger">
            <i class="fas fa-exclamation-triangle"></i><%= errorMessage %>
                        </div>
                    <% } %>

                    <% if (!successMessage.isEmpty()) { %>
                        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i><%= successMessage %>
                        </div>
                    <% } %>

        <!-- Edit Customer Form -->
                    <% if (customer != null) { %>
        <div class="content-card">
            <h3 class="card-title">
                <i class="fas fa-user-edit"></i>Edit Customer Details
                <div>
                    <a href="CustomerServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>Back to List
                    </a>
                </div>
            </h3>
            
                        <form method="POST" action="customer_edit.jsp">
                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                            
                <div class="form-section">
                    <div class="form-grid">
                                    <div class="form-group">
                                        <label class="form-label">Customer ID</label>
                                        <input type="text" class="form-control" value="<%= customer.getCustomerId() %>" readonly>
                                    </div>
                        
                                    <div class="form-group">
                                        <label class="form-label">Account Number</label>
                                        <input type="text" class="form-control" value="<%= customer.getAccountNumber() != null ? customer.getAccountNumber() : "" %>" readonly>
                            </div>

                                    <div class="form-group">
                                        <label class="form-label">Customer Name *</label>
                                        <input type="text" class="form-control" name="name" value="<%= customer.getName() != null ? customer.getName() : "" %>" required>
                                    </div>
                        
                                    <div class="form-group">
                                        <label class="form-label">Phone Number *</label>
                                        <input type="text" class="form-control" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" required>
                            </div>

                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" name="username" value="<%= customer.getUsername() != null ? customer.getUsername() : "" %>">
                                    </div>
                        
                                    <div class="form-group">
                            <label class="form-label">Email Address</label>
                                        <input type="email" class="form-control" name="email" value="<%= customer.getEmail() != null ? customer.getEmail() : "" %>">
                            </div>

                                    <div class="form-group">
                                        <label class="form-label">Role</label>
                                        <input type="text" class="form-control" value="<%= customer.getRole() != null ? customer.getRole().getRoleName() : "N/A" %>" readonly>
                                    </div>
                        
                                    <div class="form-group">
                                        <label class="form-label">Created By</label>
                                        <input type="text" class="form-control" value="<%= customer.getCreatedBy() != null ? customer.getCreatedBy().getUsername() : "N/A" %>" readonly>
                            </div>

                                    <div class="form-group">
                            <label class="form-label">Created Date</label>
                                        <input type="text" class="form-control" value="<%= customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : "N/A" %>" readonly>
                                    </div>
                        
                                    <div class="form-group">
                            <label class="form-label">Last Updated</label>
                                        <input type="text" class="form-control" value="<%= customer.getUpdatedAt() != null ? customer.getUpdatedAt().toString() : "N/A" %>" readonly>
                                    </div>
                                </div>
                    
                    <div class="form-group full-width-field">
                        <label class="form-label">Address</label>
                        <textarea class="form-control" name="address" rows="4" placeholder="Enter customer address"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                    </div>
                            </div>

                <div class="btn-group">
                                        <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>Update Customer
                                        </button>
                    <a href="customer_view.jsp?customer_id=<%= customer.getCustomerId() %>" class="btn btn-secondary">
                        <i class="fas fa-eye"></i>View Customer
                    </a>
                    <a href="CustomerServlet?action=list" class="btn btn-danger">
                        <i class="fas fa-times"></i>Cancel
                    </a>
                                    </div>
            </form>
                            </div>
                    <% } %>
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

            // Form validation
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        const name = document.querySelector('input[name="name"]').value.trim();
                        const phone = document.querySelector('input[name="phone"]').value.trim();
                        
                        if (!name) {
                            e.preventDefault();
                            alert('Customer name is required');
                            return false;
                        }
                        
                        if (!phone) {
                            e.preventDefault();
                            alert('Phone number is required');
                            return false;
                        }
                    });
                }
            });
        </script>
    </body>
</html> 