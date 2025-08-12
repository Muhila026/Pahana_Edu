<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #724784 0%, #ac87cd 100%);
            min-height: 100vh;
        }

        /* ===== MANAGER/ADMIN NAVIGATION (Sidebar Only) ===== */
        .admin-layout {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar styles are now in css/sidebar.css */

        /* Sidebar scrollbar styles are now in css/sidebar.css */

        /* Sidebar header and menu styles are now in css/sidebar.css */

        .menu-divider {
            margin: 1.5rem 0 0.5rem 0;
            padding: 0 1.2rem;
        }

        .menu-divider span {
            color: #bdc3c7;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            opacity: 0.8;
        }

        .admin-main-content {
            flex: 1;
            margin-left: 320px;
        }

        /* ===== COMMON STYLES ===== */
        .main-content {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            text-align: center;
        }

        .page-header h1 {
            color: #724784;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #666;
        }

        /* Search and Filter Section */
        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: end;
        }

        .search-form .form-group {
            flex: 1;
            min-width: 200px;
        }

        .search-form .search-btn,
        .search-form .add-customer-btn {
            flex-shrink: 0;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #724784;
        }

        .form-group input,
        .form-group select {
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #ac87cd;
        }

        .search-btn {
            background: linear-gradient(135deg, #ff7f42, #ffaf24);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 127, 66, 0.3);
        }

        .add-customer-btn {
            background: linear-gradient(135deg, #51cf66, #40c057);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .add-customer-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(81, 207, 102, 0.3);
        }

        /* Customers Table */
        .customers-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        .customers-table {
            width: 100%;
            min-width: 800px;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .customers-table th,
        .customers-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .customers-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #724784;
        }

        .customers-table tr:hover {
            background: #f8f9fa;
        }

        .customer-status {
            background: #ffe2b8;
            color: #724784;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .customer-status.active {
            background: #51cf66;
            color: white;
        }

        .customer-status.inactive {
            background: #ff6b6b;
            color: white;
        }

        .customer-status.pending {
            background: #ffaf24;
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 0.3rem;
            flex-wrap: nowrap;
            align-items: center;
        }

        .btn {
            padding: 0.5rem;
            border: none;
            border-radius: 5px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 35px;
            height: 35px;
            font-size: 0.9rem;
        }

        .btn-view {
            background: #ac87cd;
            color: white;
        }

        .btn-edit {
            background: #ffaf24;
            color: white;
        }

        .btn-delete {
            background: #ff6b6b;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }

        /* Messages */
        .message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .message.error {
            background: #ff6b6b;
            color: white;
        }

        .message.success {
            background: #51cf66;
            color: white;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 2rem;
            border-radius: 15px;
            width: 90%;
            max-width: 500px;
            position: relative;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: #000;
        }

        .modal-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .modal-form .form-group {
            flex: 1;
        }

        .modal-form .form-group {
            display: flex;
            flex-direction: column;
        }

        .modal-form label {
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #724784;
        }

        .modal-form input,
        .modal-form select,
        .modal-form textarea {
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .modal-form input:focus,
        .modal-form select:focus,
        .modal-form textarea:focus {
            outline: none;
            border-color: #ac87cd;
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 1rem;
            flex-wrap: wrap;
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
        }

        .btn-save {
            background: #51cf66;
            color: white;
        }

        /* Footer */
        .footer {
            background: #724784;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 4rem;
        }

        .footer p {
            margin: 0;
            opacity: 0.8;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            /* Sidebar responsive styles are now in css/sidebar.css */
            
            .search-form {
                flex-direction: column;
                gap: 1rem;
            }
            
            .search-form .form-group {
                min-width: auto;
            }
            
            .customers-table {
                font-size: 0.9rem;
                min-width: 600px;
            }
            
            .customers-table th,
            .customers-table td {
                padding: 0.5rem;
                min-width: 80px;
            }
            
            .action-buttons {
                flex-direction: row;
                gap: 0.2rem;
            }
            
            .btn {
                padding: 0.4rem 0.8rem;
                font-size: 0.8rem;
            }
            
            .main-content {
                padding: 1rem;
            }
            
            .page-header,
            .search-section,
            .customers-section {
                padding: 1rem;
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
    
    // Check if user has permission to access this page
    boolean hasPermission = "admin".equals(navType) || "manager".equals(navType);
    if (!hasPermission) {
        response.sendRedirect("welcome.jsp");
        return;
    }
    %>

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
                <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Customer Support</a></li>
                <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                <li><a href="inventory.jsp"><i class="fas fa-boxes"></i> Inventory Management</a></li>
                <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                <li><a href="backup.jsp"><i class="fas fa-database"></i> Backup & Restore</a></li>
                <li><a href="logs.jsp"><i class="fas fa-file-alt"></i> System Logs</a></li>
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
            <%
            } else if ("manager".equals(navType)) {
            %>
            <!-- MANAGER SIDEBAR MENU -->
            <ul class="admin-sidebar-menu">
                <!-- Main Navigation -->
                <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                
                <!-- Inventory Management -->
                <li class="menu-divider"><span>Inventory</span></li>
                <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Inventory Management</a></li>
                <li><a href="CategoryServlet?action=list"><i class="fas fa-tags"></i> Categories</a></li>
                
                <!-- Sales & Orders -->
                <li class="menu-divider"><span>Sales & Orders</span></li>
                <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Order Management</a></li>
                <li><a href="transactions.jsp"><i class="fas fa-receipt"></i> Transaction History</a></li>
                
                <!-- Management -->
                <li class="menu-divider"><span>Management</span></li>
                <li><a href="CustomerServlet?action=list" class="active"><i class="fas fa-user-friends"></i> Customer Management</a></li>
                
                <!-- User -->
                <li class="menu-divider"><span>User</span></li>
                <li><a href="user-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
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
                    <h1>Customer Management</h1>
                    <p>Manage customer accounts, view customer details, and provide customer support</p>
                </div>

                <!-- Messages -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="message error">
                        <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <% if (request.getAttribute("success") != null) { %>
                    <div class="message success">
                        <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
                    </div>
                <% } %>

                <!-- Search Section -->
                <div class="search-section">
                    <form action="CustomerServlet" method="GET" class="search-form">
                        <input type="hidden" name="action" value="list">
                        <div class="form-group">
                            <label for="searchTerm">Search Customers</label>
                            <input type="text" id="searchTerm" name="searchTerm" 
                                   placeholder="Search by name or email..." 
                                   value="${searchTerm != null ? searchTerm : ''}">
                        </div>
                        <!-- Status filter removed since we don't have a status field in the database -->
                        <!-- <div class="form-group">
                            <label for="statusFilter">Status Filter</label>
                            <select id="statusFilter" name="statusFilter">
                                <option value="all">All Status</option>
                                <option value="active" ${statusFilter == 'active' ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${statusFilter == 'inactive' ? 'selected' : ''}>Inactive</option>
                                <option value="pending" ${statusFilter == 'pending' ? 'selected' : ''}>Pending</option>
                            </select>
                        </div> -->
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i> Search
                        </button>
                        <button type="button" class="add-customer-btn" onclick="openAddCustomerModal()">
                            <i class="fas fa-plus"></i> Add Customer
                        </button>
                    </form>
                </div>

                <!-- Customers Section -->
                <div class="customers-section">
                    <table class="customers-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Total Orders</th>
                                <th>Created Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            java.util.List<com.pahana.CustomerServlet.Customer> customers = 
                                (java.util.List<com.pahana.CustomerServlet.Customer>) request.getAttribute("customers");
                            
                            if (customers != null && !customers.isEmpty()) {
                                for (com.pahana.CustomerServlet.Customer customer : customers) {
                                    String statusClass = "";
                                    if (customer.getStatus() != null) {
                                        switch (customer.getStatus().toLowerCase()) {
                                            case "active":
                                                statusClass = "active";
                                                break;
                                            case "inactive":
                                                statusClass = "inactive";
                                                break;
                                            case "pending":
                                                statusClass = "pending";
                                                break;
                                        }
                                    }
                            %>
                                <tr>
                                    <td><%= customer.getCustomerId() %></td>
                                    <td><strong><%= customer.getName() %></strong></td>
                                    <td><%= customer.getEmail() %></td>
                                    <td><%= customer.getPhone() != null ? customer.getPhone() : "N/A" %></td>
                                    <td>
                                        <span class="customer-status <%= statusClass %>">
                                            <%= customer.getStatus() != null ? customer.getStatus() : "Unknown" %>
                                        </span>
                                    </td>
                                    <td><%= customer.getTotalOrders() %></td>
                                    <td><%= customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : "N/A" %></td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="CustomerServlet?action=view&customerId=<%= customer.getCustomerId() %>" class="btn btn-view" title="View Customer">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="CustomerServlet?action=edit&customerId=<%= customer.getCustomerId() %>" class="btn btn-edit" title="Edit Customer">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button onclick="confirmDelete('<%= customer.getCustomerId() %>', '<%= customer.getName() %>')" class="btn btn-delete" title="Delete Customer">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            <%
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="8" style="text-align: center; padding: 2rem;">
                                        <h3 style="color: #724784; margin-bottom: 1rem;">No Customers Found</h3>
                                        <p style="color: #666;">No customers match your search criteria.</p>
                                    </td>
                                </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Add Customer Modal -->
    <div id="addCustomerModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeAddCustomerModal()">&times;</span>
            <h2 style="color: #724784; margin-bottom: 1rem;">Add New Customer</h2>
            <form action="CustomerServlet" method="POST" class="modal-form">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone">
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <!-- Status field removed since we don't have this field in the database -->
                <!-- <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" required>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                        <option value="pending">Pending</option>
                    </select>
                </div> -->
                <div class="modal-buttons">
                    <button type="button" class="btn btn-cancel" onclick="closeAddCustomerModal()">Cancel</button>
                    <button type="submit" class="btn btn-save">Add Customer</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 BookShop. All rights reserved. | Customer Management System</p>
    </footer>

    <script src="js/sidebar.js"></script>
    <script>
        // Modal functions
        function openAddCustomerModal() {
            document.getElementById('addCustomerModal').style.display = 'block';
        }

        function closeAddCustomerModal() {
            document.getElementById('addCustomerModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('addCustomerModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        }

        // Confirm delete function
        function confirmDelete(customerId, customerName) {
            if (confirm('Are you sure you want to delete customer "' + customerName + '"? This action cannot be undone.')) {
                window.location.href = 'CustomerServlet?action=delete&customerId=' + customerId;
            }
        }

        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.admin-sidebar');
            if (sidebar) {
                sidebar.classList.toggle('open');
            }
        }
    </script>
</body>
</html> 