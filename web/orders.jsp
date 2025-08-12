<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management - Pahana BookShop</title>
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

        /* Sidebar styles are now in css/sidebar.css */

        /* Main Content Styles */
        .main-content {
            padding: 2rem;
            max-width: 1400px;
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

        /* Order Management Grid */
        .order-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .order-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            transition: all 0.3s ease;
            text-align: center;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
        }

        .order-card-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
        }

        .order-card-icon.orders {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
        }

        .order-card-icon.new-order {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .order-card-icon.pending {
            background: linear-gradient(135deg, #f59e0b, #d97706);
        }

        .order-card-icon.completed {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .order-card-icon.returns {
            background: linear-gradient(135deg, #ef4444, #dc2626);
        }

        .order-card-icon.reports {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
        }

        .order-card h3 {
            color: #1e293b;
            margin-bottom: 1rem;
            font-size: 1.3rem;
            font-weight: 600;
        }

        .order-card p {
            color: #64748b;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .order-card-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
        }

        .order-card-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        .order-card-btn.secondary {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .order-card-btn.warning {
            background: linear-gradient(135deg, #f59e0b, #d97706);
        }

        .order-card-btn.danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
        }

        /* Quick Stats Section */
        .quick-stats {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
        }

        .stats-header {
            margin-bottom: 1.5rem;
        }

        .stats-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #6366f1;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #64748b;
            font-weight: 500;
        }

        /* Recent Orders Section */
        .recent-orders {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .recent-header {
            margin-bottom: 1.5rem;
        }

        .recent-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .order-table th,
        .order-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #f1f5f9;
        }

        .order-table th {
            background: #f8fafc;
            font-weight: 600;
            color: #1e293b;
        }

        .order-table tr:hover {
            background: #f8fafc;
        }

        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fef3c7;
            color: #d97706;
        }

        .status-processing {
            background: #dbeafe;
            color: #2563eb;
        }

        .status-completed {
            background: #d1fae5;
            color: #059669;
        }

        .status-cancelled {
            background: #fee2e2;
            color: #dc2626;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .admin-main-content {
                margin-left: 0;
            }
            
            .main-content {
                padding: 1rem;
            }
            
            .order-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .order-table {
                font-size: 0.9rem;
            }
            
            .order-table th,
            .order-table td {
                padding: 0.75rem 0.5rem;
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
        <!-- MANAGER/ADMIN/STAFF NAVIGATION (Sidebar Only) -->
        <div class="admin-layout">
            <!-- Sidebar -->
            <aside class="admin-sidebar">
                <div class="admin-sidebar-header">
                    <h2><%= "admin".equals(navType) ? "Admin" : ("manager".equals(navType) ? "Manager" : "Staff") %> Panel</h2>
                    <p>Welcome, <%= username %></p>
                </div>
                
                <%
                // Different sidebar menus for each role
                if ("admin".equals(navType)) {
                %>
                <!-- ADMIN SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard </a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp" class="active"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
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
                    <li><a href="orders.jsp" class="active"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
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
                        <h1>Order Management</h1>
                        <p>Manage orders, track sales, and handle customer requests</p>
                    </div>
                    
                    <!-- Quick Stats Section -->
                    <div class="quick-stats">
                        <div class="stats-header">
                            <h3><i class="fas fa-chart-line"></i> Order Overview</h3>
                            <p>Quick statistics for today's operations</p>
                        </div>
                        <div class="stats-grid">
                            <div class="stat-item">
                                <div class="stat-number">24</div>
                                <div class="stat-label">Today's Orders</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">8</div>
                                <div class="stat-label">Pending</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">16</div>
                                <div class="stat-label">Completed</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">$1,247</div>
                                <div class="stat-label">Today's Revenue</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Management Grid -->
                    <div class="order-grid">
                        <!-- View All Orders -->
                        <div class="order-card">
                            <div class="order-card-icon orders">
                                <i class="fas fa-list"></i>
                            </div>
                            <h3>View All Orders</h3>
                            <p>Browse and manage all customer orders in the system</p>
                            <button class="order-card-btn" onclick="viewAllOrders()">
                                <i class="fas fa-eye"></i> View Orders
                            </button>
                        </div>
                        
                        <!-- Create New Order -->
                        <div class="order-card">
                            <div class="order-card-icon new-order">
                                <i class="fas fa-plus"></i>
                            </div>
                            <h3>Create New Order</h3>
                            <p>Manually create orders for walk-in customers or phone orders</p>
                            <a href="pos.jsp" class="order-card-btn secondary">
                                <i class="fas fa-cash-register"></i> Go to POS
                            </a>
                        </div>
                        
                        <!-- Pending Orders -->
                        <div class="order-card">
                            <div class="order-card-icon pending">
                                <i class="fas fa-clock"></i>
                            </div>
                            <h3>Pending Orders</h3>
                            <p>Review and process orders that are waiting for fulfillment</p>
                            <button class="order-card-btn warning" onclick="viewPendingOrders()">
                                <i class="fas fa-clock"></i> View Pending
                            </button>
                        </div>
                        
                        <!-- Completed Orders -->
                        <div class="order-card">
                            <div class="order-card-icon completed">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <h3>Completed Orders</h3>
                            <p>View order history and completed transactions</p>
                            <button class="order-card-btn secondary" onclick="viewCompletedOrders()">
                                <i class="fas fa-check"></i> View Completed
                            </button>
                        </div>
                        
                        <!-- Returns & Refunds -->
                        <div class="order-card">
                            <div class="order-card-icon returns">
                                <i class="fas fa-undo"></i>
                            </div>
                            <h3>Returns & Refunds</h3>
                            <p>Process customer returns and handle refund requests</p>
                            <button class="order-card-btn danger" onclick="viewReturns()">
                                <i class="fas fa-undo"></i> Manage Returns
                            </button>
                        </div>
                        
                        <!-- Order Reports -->
                        <div class="order-card">
                            <div class="order-card-icon reports">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <h3>Order Reports</h3>
                            <p>Generate detailed reports on sales, orders, and performance</p>
                            <button class="order-card-btn" onclick="generateReports()">
                                <i class="fas fa-chart-bar"></i> Generate Reports
                            </button>
                        </div>
                    </div>
                    
                    <!-- Recent Orders Section -->
                    <div class="recent-orders">
                        <div class="recent-header">
                            <h3><i class="fas fa-history"></i> Recent Orders</h3>
                            <p>Latest customer orders and their current status</p>
                        </div>
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Items</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#ORD-001</td>
                                    <td>John Smith</td>
                                    <td>3 books</td>
                                    <td>$45.99</td>
                                    <td><span class="order-status status-completed">Completed</span></td>
                                    <td>Today, 2:30 PM</td>
                                    <td>
                                        <button class="order-card-btn" style="padding: 0.5rem 1rem; font-size: 0.8rem;" onclick="viewOrderDetails('ORD-001')">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#ORD-002</td>
                                    <td>Sarah Johnson</td>
                                    <td>2 books</td>
                                    <td>$28.50</td>
                                    <td><span class="order-status status-processing">Processing</span></td>
                                    <td>Today, 1:15 PM</td>
                                    <td>
                                        <button class="order-card-btn" style="padding: 0.5rem 1rem; font-size: 0.8rem;" onclick="viewOrderDetails('ORD-002')">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#ORD-003</td>
                                    <td>Mike Wilson</td>
                                    <td>1 book</td>
                                    <td>$19.99</td>
                                    <td><span class="order-status status-pending">Pending</span></td>
                                    <td>Today, 12:45 PM</td>
                                    <td>
                                        <button class="order-card-btn" style="padding: 0.5rem 1rem; font-size: 0.8rem;" onclick="viewOrderDetails('ORD-003')">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#ORD-004</td>
                                    <td>Emily Davis</td>
                                    <td>4 books</td>
                                    <td>$67.25</td>
                                    <td><span class="order-status status-completed">Completed</span></td>
                                    <td>Today, 11:20 AM</td>
                                    <td>
                                        <button class="order-card-btn" style="padding: 0.5rem 1rem; font-size: 0.8rem;" onclick="viewOrderDetails('ORD-004')">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    <% } else if ("customer".equals(navType)) { %>
        <!-- CUSTOMER ORDER VIEW -->
        <div class="main-content" style="margin-left: 0; padding-top: 2rem;">
            <div class="page-header">
                <h1>My Orders</h1>
                <p>Track your book orders and view order history</p>
            </div>
            
            <!-- Customer Order Grid -->
            <div class="order-grid">
                <div class="order-card">
                    <div class="order-card-icon orders">
                        <i class="fas fa-list"></i>
                    </div>
                    <h3>My Order History</h3>
                    <p>View all your previous orders and their current status</p>
                    <button class="order-card-btn" onclick="viewMyOrders()">
                        <i class="fas fa-eye"></i> View My Orders
                    </button>
                </div>
                
                <div class="order-card">
                    <div class="order-card-icon new-order">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3>Place New Order</h3>
                    <p>Browse books and place a new order</p>
                    <a href="books.jsp" class="order-card-btn secondary">
                        <i class="fas fa-book"></i> Browse Books
                    </a>
                </div>
                
                <div class="order-card">
                    <div class="order-card-icon returns">
                        <i class="fas fa-undo"></i>
                    </div>
                    <h3>Request Return</h3>
                    <p>Request a return or refund for your orders</p>
                    <button class="order-card-btn danger" onclick="requestReturn()">
                        <i class="fas fa-undo"></i> Request Return
                    </button>
                </div>
            </div>
            
            <!-- Customer Recent Orders -->
            <div class="recent-orders">
                <div class="recent-header">
                    <h3><i class="fas fa-history"></i> My Recent Orders</h3>
                    <p>Your latest book orders</p>
                </div>
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Items</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#ORD-001</td>
                            <td>The Great Gatsby, 1984</td>
                            <td>$24.98</td>
                            <td><span class="order-status status-completed">Delivered</span></td>
                            <td>Yesterday</td>
                            <td>
                                <button class="order-card-btn" style="padding: 0.5rem 1rem; font-size: 0.8rem;" onclick="viewOrderDetails('ORD-001')">
                                    <i class="fas fa-eye"></i> View
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-002</td>
                            <td>To Kill a Mockingbird</td>
                            <td>$14.99</td>
                            <td><span class="order-status status-processing">Processing</span></td>
                            <td>Today</td>
                            <td>
                                <button class="order-card-btn" style="padding: 0.5rem 1rem; font-size: 0.8rem;" onclick="viewOrderDetails('ORD-002')">
                                    <i class="fas fa-eye"></i> View
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    <% } else { %>
        <!-- Access Denied for non-logged in users -->
        <div style="text-align: center; padding: 4rem 2rem;">
            <h1 style="color: #ef4444; margin-bottom: 1rem;">Access Denied</h1>
            <p style="color: #64748b; margin-bottom: 2rem;">Please log in to view order information.</p>
            <a href="login.jsp" style="background: #6366f1; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block; margin-right: 1rem;">Login</a>
            <a href="register.jsp" style="background: #10b981; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block;">Register</a>
        </div>
    <% } %>

    <script src="js/sidebar.js"></script>
    <script>
        // Order management functions
        function viewAllOrders() {
            alert('View All Orders functionality will be implemented here.');
            // This would typically redirect to a detailed orders list page
        }

        function viewPendingOrders() {
            alert('View Pending Orders functionality will be implemented here.');
            // This would filter and show only pending orders
        }

        function viewCompletedOrders() {
            alert('View Completed Orders functionality will be implemented here.');
            // This would filter and show only completed orders
        }

        function viewReturns() {
            alert('Returns & Refunds functionality will be implemented here.');
            // This would redirect to returns management page
        }

        function generateReports() {
            alert('Order Reports functionality will be implemented here.');
            // This would redirect to reports generation page
        }

        function viewOrderDetails(orderId) {
            alert('Viewing order details for: ' + orderId);
            // This would show detailed order information
        }

        function viewMyOrders() {
            alert('View My Orders functionality will be implemented here.');
            // This would show customer's order history
        }

        function requestReturn() {
            alert('Request Return functionality will be implemented here.');
            // This would open return request form
        }

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Order Management page loaded');
        });
    </script>
</body>
</html>
