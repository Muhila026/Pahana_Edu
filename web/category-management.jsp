<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management - BookShop</title>
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
        /* Sidebar styles are now in css/sidebar.css */

        /* ===== COMMON STYLES ===== */
        .main-content {
            padding: 2rem;
            max-width: 1200px;
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

        /* Add Category Form */
        .add-category-form {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
            min-width: 200px;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #ff7f42;
            color: white;
        }

        .btn-primary:hover {
            background: #ffaf24;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #ff4757;
            color: white;
        }

        .btn-danger:hover {
            background: #ff3742;
        }

        .btn-warning {
            background: #ac87cd;
            color: white;
        }

        .btn-warning:hover {
            background: #724784;
        }

        /* Categories Table */
        .categories-table {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            overflow-x: auto;
        }

        .table-header {
            background: #724784;
            color: white;
            padding: 1rem 2rem;
        }

        .table-header h2 {
            margin: 0;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 600px;
            border-collapse: collapse;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        th {
            background: #ffe2b8;
            font-weight: 600;
            color: #333;
        }

        tr:hover {
            background: #ffe2b8;
        }

        .action-buttons {
            display: flex;
            gap: 0.3rem;
            flex-wrap: nowrap;
            align-items: center;
        }

        .btn-sm {
            padding: 0.5rem;
            font-size: 0.9rem;
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        /* Messages */
        .message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
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
            position: absolute;
            right: 1rem;
            top: 1rem;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }

        .close:hover {
            color: #333;
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
            
            .form-row {
                flex-direction: column;
            }
            
            .form-row .form-group {
                min-width: auto;
            }
            
            .action-buttons {
                flex-direction: row;
                gap: 0.2rem;
            }
            
            .table-container {
                font-size: 0.9rem;
            }
            
            table {
                min-width: 500px;
            }
            
            th, td {
                padding: 0.5rem;
                min-width: 80px;
            }
            
            .main-content {
                padding: 1rem;
            }
            
            .page-header,
            .add-category-form,
            .categories-table {
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
            }
            %>
        </aside>

        <!-- Main Content -->
        <main class="admin-main-content">
            <div class="main-content">
                <!-- Page Header -->
                <div class="page-header">
                    <h1><i class="fas fa-tags"></i> Category Management</h1>
                    <p>Manage book categories. Add, edit, or delete categories as needed.</p>
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

                <!-- Add Category Form -->
                <div class="add-category-form">
                    <h3><i class="fas fa-plus"></i> Add New Category</h3>
                    <form action="CategoryServlet" method="POST">
                        <input type="hidden" name="action" value="add">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="categoryName">Category Name *</label>
                                <input type="text" id="categoryName" name="categoryName" required>
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <input type="text" id="description" name="description" placeholder="Brief description of the category">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Category
                        </button>
                    </form>
                </div>

                <!-- Categories Table -->
                <div class="categories-table">
                    <div class="table-header">
                        <h2><i class="fas fa-list"></i> All Categories</h2>
                    </div>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Category Name</th>
                                    <th>Description</th>
                                    <th>Created Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                // Get categories from request attribute
                                java.util.List<com.pahana.CategoryServlet.Category> categories = 
                                    (java.util.List<com.pahana.CategoryServlet.Category>) request.getAttribute("categories");
                                
                                if (categories != null && !categories.isEmpty()) {
                                    for (com.pahana.CategoryServlet.Category category : categories) {
                                %>
                                    <tr>
                                        <td><%= category.getCategoryId() %></td>
                                        <td><strong><%= category.getCategoryName() %></strong></td>
                                        <td><%= category.getDescription() != null ? category.getDescription() : "No description" %></td>
                                        <td><%= category.getCreatedAt() != null ? category.getCreatedAt().toString() : "N/A" %></td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-warning btn-sm edit-category-btn" 
                                                        data-id="<%= category.getCategoryId() %>"
                                                        data-name="<%= category.getCategoryName().replace("\"", "&quot;") %>"
                                                        data-description="<%= category.getDescription() != null ? category.getDescription().replace("\"", "&quot;") : "" %>"
                                                        title="Edit Category">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-danger btn-sm delete-category-btn" 
                                                        data-id="<%= category.getCategoryId() %>"
                                                        data-name="<%= category.getCategoryName().replace("\"", "&quot;") %>"
                                                        title="Delete Category">
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
                                        <td colspan="5" style="text-align: center; padding: 2rem;">
                                            <i class="fas fa-inbox" style="font-size: 2rem; color: #ccc; margin-bottom: 1rem;"></i>
                                            <p>No categories found</p>
                                        </td>
                                    </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Edit Category Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3><i class="fas fa-edit"></i> Edit Category</h3>
            <form action="CategoryServlet" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editCategoryId" name="categoryId">
                <div class="form-group">
                    <label for="editCategoryName">Category Name *</label>
                    <input type="text" id="editCategoryName" name="categoryName" required>
                </div>
                <div class="form-group">
                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" name="description" rows="3" placeholder="Brief description of the category"></textarea>
                </div>
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Category
                    </button>
                    <button type="button" class="btn btn-danger" onclick="closeModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeDeleteModal()">&times;</span>
            <h3><i class="fas fa-exclamation-triangle"></i> Confirm Delete</h3>
            <p>Are you sure you want to delete the category "<span id="deleteCategoryName"></span>"?</p>
            <p style="color: #ff4757; font-size: 0.9rem;">
                <i class="fas fa-info-circle"></i> This action cannot be undone.
            </p>
            <form action="CategoryServlet" method="POST">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="deleteCategoryId" name="categoryId">
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Category
                    </button>
                    <button type="button" class="btn btn-primary" onclick="closeDeleteModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 BookShop. All rights reserved. | Category Management System</p>
    </footer>

    <script src="js/sidebar.js"></script>
    <script>
        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.admin-sidebar');
            if (sidebar) {
                sidebar.classList.toggle('open');
            }
        }

        // Edit category function
        function editCategory(categoryId, categoryName, description) {
            document.getElementById('editCategoryId').value = categoryId;
            document.getElementById('editCategoryName').value = categoryName;
            document.getElementById('editDescription').value = description;
            document.getElementById('editModal').style.display = 'block';
        }

        // Delete category function
        function deleteCategory(categoryId, categoryName) {
            document.getElementById('deleteCategoryId').value = categoryId;
            document.getElementById('deleteCategoryName').textContent = categoryName;
            document.getElementById('deleteModal').style.display = 'block';
        }

        // Close modal functions
        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const editModal = document.getElementById('editModal');
            const deleteModal = document.getElementById('deleteModal');
            if (event.target === editModal) {
                editModal.style.display = 'none';
            }
            if (event.target === deleteModal) {
                deleteModal.style.display = 'none';
            }
        }

        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            const messages = document.querySelectorAll('.message');
            messages.forEach(function(message) {
                message.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html> 