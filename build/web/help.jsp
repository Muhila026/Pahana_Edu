<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support - Pahana BookShop</title>
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
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
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

        .help-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .help-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .help-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f5f9;
        }

        .help-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .help-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .help-content {
            color: #1e293b;
            line-height: 1.7;
        }

        .help-content h4 {
            color: #6366f1;
            margin: 1.5rem 0 0.5rem 0;
            font-size: 1.1rem;
        }

        .help-content ul {
            margin: 1rem 0;
            padding-left: 1.5rem;
        }

        .help-content li {
            margin-bottom: 0.5rem;
        }

        .help-content p {
            margin-bottom: 1rem;
        }

        .contact-info {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            margin-top: 1.5rem;
        }

        .contact-info h4 {
            color: #6366f1;
            margin-bottom: 1rem;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            color: #64748b;
        }

        .contact-item i {
            color: #6366f1;
            width: 20px;
        }

        .public-help {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
        }

        .public-help h2 {
            color: #6366f1;
            margin-bottom: 1rem;
            text-align: center;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .benefit-item {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            text-align: center;
        }

        .benefit-item i {
            font-size: 2rem;
            color: #6366f1;
            margin-bottom: 1rem;
        }

        .benefit-item h4 {
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .benefit-item p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .login-section {
            text-align: center;
            margin-top: 2rem;
            padding: 2rem;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border-radius: 20px;
            color: white;
        }

        .login-section h3 {
            margin-bottom: 1rem;
        }

        .login-section p {
            margin-bottom: 1.5rem;
            opacity: 0.9;
        }

        .login-btn {
            background: white;
            color: #6366f1;
            padding: 0.8rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.3);
        }

        @media (max-width: 768px) {
            .admin-main-content { margin-left: 0; }
            .main-content { padding: 1rem; }
            .help-grid { grid-template-columns: 1fr; }
            .benefits-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <%
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
    
    String navType = "public";
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
        <!-- PUBLIC HELP PAGE -->
        <nav class="public-navbar">
            <div class="nav-container">
                <a href="welcome.jsp" class="logo">
                    <span class="logo-text">Pahana BookShop</span>
                </a>
                <ul class="nav-menu">
                    <li><a href="welcome.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="books.jsp">Books</a></li>
                    <li><a href="categories.jsp">Categories</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                    <li><a href="help.jsp" class="active">Help (Public - How to Login and Benefits)</a></li>
                    <li><a href="login.jsp" class="login-btn">Login</a></li>
                </ul>
            </div>
        </nav>

        <main class="main-content">
            <div class="page-header">
                <h1>Help & Support</h1>
                <p>Learn how to use our platform and discover the benefits of joining Pahana BookShop</p>
            </div>
            
            <div class="public-help">
                <h2>How to Login and Get Started</h2>
                <p>Getting started with Pahana BookShop is easy! Follow these simple steps to create your account and start exploring our vast collection of books.</p>
                
                <div class="benefits-grid">
                    <div class="benefit-item">
                        <i class="fas fa-user-plus"></i>
                        <h4>Easy Registration</h4>
                        <p>Create your account in minutes with just your email and basic information</p>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-book"></i>
                        <h4>Access to Books</h4>
                        <p>Browse thousands of books across all genres and categories</p>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-shopping-cart"></i>
                        <h4>Order Management</h4>
                        <p>Track your orders and manage your purchase history</p>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-heart"></i>
                        <h4>Wishlist Feature</h4>
                        <p>Save books you want to read later in your personal wishlist</p>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-tags"></i>
                        <h4>Special Offers</h4>
                        <p>Get access to exclusive discounts and promotional offers</p>
                    </div>
                    <div class="benefit-item">
                        <i class="fas fa-headset"></i>
                        <h4>Customer Support</h4>
                        <p>24/7 customer support to help with any questions</p>
                    </div>
                </div>
                
                <div class="login-section">
                    <h3>Ready to Get Started?</h3>
                    <p>Join thousands of readers who have already discovered the joy of reading with Pahana BookShop</p>
                    <a href="login.jsp" class="login-btn">Login / Register Now</a>
                </div>
            </div>
        </main>
    <% } else if (isLoggedIn) { %>
        <% if ("admin".equals(navType)) { %>
            <div class="admin-layout">
                <aside class="admin-sidebar">
                    <div class="admin-sidebar-header">
                        <h2>Admin Panel</h2>
                        <p>Welcome, <%= username %></p>
                    </div>
                    
                    <ul class="admin-sidebar-menu">
                        <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Admin)</a></li>
                        <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                        <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                        <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                        <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                        <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                        <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                        <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                        <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                        <li><a href="help.jsp" class="active"><i class="fas fa-question-circle"></i> Help (Admin)</a></li>
                        <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </aside>

                <main class="admin-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>Help (Admin)</h1>
                            <p>Administrative help and system management guidance</p>
                        </div>
                        
                        <div class="help-grid">
                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-cogs"></i> System Management</h3>
                                    <p>Essential administrative functions</p>
                                </div>
                                <div class="help-content">
                                    <h4>User Management</h4>
                                    <ul>
                                        <li>Create and manage user accounts</li>
                                        <li>Assign roles and permissions</li>
                                        <li>Monitor user activity</li>
                                        <li>Reset passwords when needed</li>
                                    </ul>
                                    
                                    <h4>System Settings</h4>
                                    <ul>
                                        <li>Configure store information</li>
                                        <li>Set security parameters</li>
                                        <li>Manage email settings</li>
                                        <li>Configure notifications</li>
                                    </ul>
                                    
                                    <div class="contact-info">
                                        <h4>Need Help?</h4>
                                        <div class="contact-item">
                                            <i class="fas fa-envelope"></i>
                                            <span>admin-support@pahanabookshop.com</span>
                                        </div>
                                        <div class="contact-item">
                                            <i class="fas fa-phone"></i>
                                            <span>+1 (555) 123-4567</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-chart-bar"></i> Reports & Analytics</h3>
                                    <p>Business intelligence tools</p>
                                </div>
                                <div class="help-content">
                                    <h4>Sales Reports</h4>
                                    <ul>
                                        <li>View daily, weekly, and monthly sales</li>
                                        <li>Analyze customer behavior</li>
                                        <li>Track inventory performance</li>
                                        <li>Generate custom reports</li>
                                    </ul>
                                    
                                    <h4>System Monitoring</h4>
                                    <ul>
                                        <li>Monitor system performance</li>
                                        <li>Track user activity logs</li>
                                        <li>View error reports</li>
                                        <li>System health status</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } else if ("manager".equals(navType)) { %>
            <div class="admin-layout">
                <aside class="admin-sidebar">
                    <div class="admin-sidebar-header">
                        <h2>Manager Panel</h2>
                        <p>Welcome, <%= username %></p>
                    </div>
                    
                    <ul class="admin-sidebar-menu">
                        <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Manager)</a></li>
                        <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                        <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                        <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                        <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                        <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                        <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                        <li><a href="help.jsp" class="active"><i class="fas fa-question-circle"></i> Help (Manager)</a></li>
                        <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </aside>

                <main class="admin-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>Help (Manager)</h1>
                            <p>Management guidance and operational support</p>
                        </div>
                        
                        <div class="help-grid">
                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-book"></i> Inventory Management</h3>
                                    <p>Book and category management</p>
                                </div>
                                <div class="help-content">
                                    <h4>Book Management</h4>
                                    <ul>
                                        <li>Add new books to inventory</li>
                                        <li>Update book information and prices</li>
                                        <li>Manage stock quantities</li>
                                        <li>Organize books by categories</li>
                                    </ul>
                                    
                                    <h4>Category Management</h4>
                                    <ul>
                                        <li>Create and edit book categories</li>
                                        <li>Organize books by genre</li>
                                        <li>Set category descriptions</li>
                                        <li>Manage category hierarchy</li>
                                    </ul>
                                    
                                    <div class="contact-info">
                                        <h4>Need Help?</h4>
                                        <div class="contact-item">
                                            <i class="fas fa-envelope"></i>
                                            <span>manager-support@pahanabookshop.com</span>
                                        </div>
                                        <div class="contact-item">
                                            <i class="fas fa-phone"></i>
                                            <span>+1 (555) 123-4567</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-shopping-cart"></i> Order Management</h3>
                                    <p>Customer order processing</p>
                                </div>
                                <div class="help-content">
                                    <h4>Order Processing</h4>
                                    <ul>
                                        <li>View and process customer orders</li>
                                        <li>Update order status</li>
                                        <li>Handle returns and refunds</li>
                                        <li>Generate shipping labels</li>
                                    </ul>
                                    
                                    <h4>Customer Support</h4>
                                    <ul>
                                        <li>Manage customer accounts</li>
                                        <li>Handle customer inquiries</li>
                                        <li>Process customer requests</li>
                                        <li>Maintain customer relationships</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } else if ("staff".equals(navType)) { %>
            <div class="admin-layout">
                <aside class="admin-sidebar">
                    <div class="admin-sidebar-header">
                        <h2>Staff Panel</h2>
                        <p>Welcome, <%= username %></p>
                    </div>
                    
                    <ul class="admin-sidebar-menu">
                        <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                        <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                        <li><a href="help.jsp" class="active"><i class="fas fa-question-circle"></i> Help (Staff)</a></li>
                        <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </aside>

                <main class="admin-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>Help (Staff)</h1>
                            <p>Daily operations and customer service guidance</p>
                        </div>
                        
                        <div class="help-grid">
                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-cash-register"></i> Point of Sale</h3>
                                    <p>POS system operation</p>
                                </div>
                                <div class="help-content">
                                    <h4>Processing Sales</h4>
                                    <ul>
                                        <li>Scan books or search by title</li>
                                        <li>Add items to cart</li>
                                        <li>Apply discounts if applicable</li>
                                        <li>Process payment methods</li>
                                        <li>Generate receipts</li>
                                    </ul>
                                    
                                    <h4>Customer Service</h4>
                                    <ul>
                                        <li>Help customers find books</li>
                                        <li>Check inventory availability</li>
                                        <li>Process returns and exchanges</li>
                                        <li>Answer customer questions</li>
                                    </ul>
                                    
                                    <div class="contact-info">
                                        <h4>Need Help?</h4>
                                        <div class="contact-item">
                                            <i class="fas fa-envelope"></i>
                                            <span>staff-support@pahanabookshop.com</span>
                                        </div>
                                        <div class="contact-item">
                                            <i class="fas fa-phone"></i>
                                            <span>+1 (555) 123-4567</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-shopping-cart"></i> Order Management</h3>
                                    <p>Order processing and tracking</p>
                                </div>
                                <div class="help-content">
                                    <h4>Order Processing</h4>
                                    <ul>
                                        <li>View pending orders</li>
                                        <li>Update order status</li>
                                        <li>Prepare orders for shipping</li>
                                        <li>Handle customer inquiries</li>
                                    </ul>
                                    
                                    <h4>Inventory Checks</h4>
                                    <ul>
                                        <li>Check book availability</li>
                                        <li>Report low stock items</li>
                                        <li>Update inventory counts</li>
                                        <li>Locate books in store</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } else { %>
            <!-- Customer Help -->
            <div class="customer-layout">
                <nav class="customer-navbar">
                    <div class="customer-nav-container">
                        <a href="welcome.jsp" class="customer-logo">
                            <span class="customer-logo-text">Pahana BookShop</span>
                        </a>
                        <ul class="customer-nav-menu">
                            <li><a href="welcome.jsp">Home (Welcome Page)</a></li>
                            <li><a href="about.jsp">About</a></li>
                            <li><a href="books.jsp">Books</a></li>
                            <li><a href="categories.jsp">Categories</a></li>
                            <li><a href="orders.jsp">My Orders</a></li>
                            <li><a href="wishlist.jsp">Wishlist</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                            <li><a href="profile.jsp">My Profile</a></li>
                            <li><a href="help.jsp" class="active">Help (Customer)</a></li>
                        </ul>
                        <div class="customer-user-info">
                            <span class="welcome-text">Welcome, <%= username %></span>
                            <a href="LogoutServlet" class="customer-logout-btn">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>
                </nav>

                <main class="customer-main-content">
                    <div class="main-content">
                        <div class="page-header">
                            <h1>Help (Customer)</h1>
                            <p>Customer support and guidance</p>
                        </div>
                        
                        <div class="help-grid">
                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-shopping-cart"></i> Ordering & Shopping</h3>
                                    <p>How to place and track orders</p>
                                </div>
                                <div class="help-content">
                                    <h4>Placing Orders</h4>
                                    <ul>
                                        <li>Browse books by category or search</li>
                                        <li>Add books to your cart</li>
                                        <li>Review your order before checkout</li>
                                        <li>Choose shipping and payment options</li>
                                        <li>Receive order confirmation</li>
                                    </ul>
                                    
                                    <h4>Order Tracking</h4>
                                    <ul>
                                        <li>View order history in My Orders</li>
                                        <li>Track shipping status</li>
                                        <li>Download invoices</li>
                                        <li>Request returns if needed</li>
                                    </ul>
                                    
                                    <div class="contact-info">
                                        <h4>Need Help?</h4>
                                        <div class="contact-item">
                                            <i class="fas fa-envelope"></i>
                                            <span>customer-support@pahanabookshop.com</span>
                                        </div>
                                        <div class="contact-item">
                                            <i class="fas fa-phone"></i>
                                            <span>+1 (555) 123-4567</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="help-card">
                                <div class="help-header">
                                    <h3><i class="fas fa-user"></i> Account Management</h3>
                                    <p>Managing your profile and preferences</p>
                                </div>
                                <div class="help-content">
                                    <h4>Profile Management</h4>
                                    <ul>
                                        <li>Update personal information</li>
                                        <li>Change password</li>
                                        <li>Manage shipping addresses</li>
                                        <li>Set notification preferences</li>
                                    </ul>
                                    
                                    <h4>Wishlist Features</h4>
                                    <ul>
                                        <li>Save books for later</li>
                                        <li>Organize your reading list</li>
                                        <li>Share wishlist with friends</li>
                                        <li>Get notified of price changes</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <% } %>
    <% } %>

    <script src="js/sidebar.js"></script>
</body>
</html>
