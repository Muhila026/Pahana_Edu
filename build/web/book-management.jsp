<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management - BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        .admin-sidebar {
            width: 320px;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 1rem 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 999;
            scrollbar-width: thin;
            scrollbar-color: #3498db #2c3e50;
        }

        .admin-sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .admin-sidebar::-webkit-scrollbar-track {
            background: #2c3e50;
        }

        .admin-sidebar::-webkit-scrollbar-thumb {
            background: #3498db;
            border-radius: 3px;
        }

        .admin-sidebar::-webkit-scrollbar-thumb:hover {
            background: #2980b9;
        }

        .admin-sidebar-header {
            padding: 0 1.5rem 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .admin-sidebar-header h2 {
            color: #3498db;
            margin-bottom: 0.5rem;
        }

        .admin-sidebar-menu {
            list-style: none;
            padding: 0 1.5rem;
        }

        .admin-sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .admin-sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: white;
            text-decoration: none;
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            transition: all 0.3s;
            font-weight: 500;
            font-size: 0.95rem;
            border-left: 3px solid transparent;
        }

        .admin-sidebar-menu a:hover {
            background: rgba(255,255,255,0.1);
            color: #3498db;
            transform: translateX(5px);
            border-left-color: #3498db;
        }

        .admin-sidebar-menu a.active {
            background: rgba(52, 152, 219, 0.2);
            color: #3498db;
            border-left-color: #3498db;
        }

        .admin-sidebar-menu i {
            width: 20px;
            text-align: center;
            font-size: 1rem;
        }

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

        /* Add Book Form */
        .add-book-form {
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
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #ac87cd;
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

        .form-row-3 {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .form-row-3 .form-group {
            flex: 1;
            min-width: 150px;
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

        /* Books Table */
        .books-table {
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
            min-width: 800px;
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

        .book-title {
            font-weight: 600;
            color: #724784;
        }

        .book-author {
            color: #666;
            font-style: italic;
        }

        .book-price {
            font-weight: bold;
            color: #ff7f42;
        }

        .book-stock {
            background: #ffe2b8;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
            color: #724784;
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
            max-width: 600px;
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
            .admin-sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            
            .admin-sidebar.open {
                transform: translateX(0);
            }
            
            .admin-main-content {
                margin-left: 0;
            }
            
            .form-row,
            .form-row-3 {
                flex-direction: column;
            }
            
            .form-row .form-group,
            .form-row-3 .form-group {
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
                min-width: 600px;
            }
            
            th, td {
                padding: 0.5rem;
                min-width: 80px;
            }
            
            .main-content {
                padding: 1rem;
            }
            
            .page-header,
            .add-book-form,
            .books-table {
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
                <li><a href="BookServlet?action=list" class="active"><i class="fas fa-book"></i> Inventory Management</a></li>
                <li><a href="CategoryServlet?action=list"><i class="fas fa-tags"></i> Categories</a></li>
                
                <!-- Sales & Orders -->
                <li class="menu-divider"><span>Sales & Orders</span></li>
                <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Order Management</a></li>
                <li><a href="transactions.jsp"><i class="fas fa-receipt"></i> Transaction History</a></li>
                
                <!-- Management -->
                <li class="menu-divider"><span>Management</span></li>
                <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Customer Management</a></li>
                
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
                <!-- Page Header -->
                <div class="page-header">
                    <h1><i class="fas fa-book"></i> Book Management</h1>
                    <p>Manage book inventory. Add, edit, or delete books as needed.</p>
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

                <!-- Add Book Form -->
                <div class="add-book-form">
                    <h3><i class="fas fa-plus"></i> Add New Book</h3>
                    <form action="BookServlet" method="POST">
                        <input type="hidden" name="action" value="add" />
                        <div class="form-row">
                            <div class="form-group">
                                <label for="title">Book Title *</label>
                                <input type="text" id="title" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="author">Author</label>
                                <input type="text" id="author" name="author" placeholder="Author name">
                            </div>
                        </div>
                        <div class="form-row-3">
                            <div class="form-group">
                                <label for="price">Price *</label>
                                <input type="number" id="price" name="price" step="0.01" min="0" value="0.00" required>
                            </div>
                            <div class="form-group">
                                <label for="stockQuantity">Stock Quantity *</label>
                                <input type="number" id="stockQuantity" name="stockQuantity" min="0" value="0" required>
                            </div>
                            <div class="form-group">
                                <label for="categoryId">Category *</label>
                                <select id="categoryId" name="categoryId" required>
                                    <option value="">Select Category</option>
                                    <%
                                    java.util.List<com.pahana.CategoryServlet.Category> categories = 
                                        (java.util.List<com.pahana.CategoryServlet.Category>) request.getAttribute("categories");
                                    if (categories != null) {
                                        for (com.pahana.CategoryServlet.Category category : categories) {
                                    %>
                                        <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                                    <%
                                        }
                                    }
                                    %>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Book
                        </button>
                    </form>
                </div>

                <!-- Books Table -->
                <div class="books-table">
                    <div class="table-header">
                        <h2><i class="fas fa-list"></i> All Books</h2>
                    </div>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Created Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                // Get books from request attribute
                                java.util.List<com.pahana.BookServlet.Book> books = 
                                    (java.util.List<com.pahana.BookServlet.Book>) request.getAttribute("books");
                                
                                if (books != null && !books.isEmpty()) {
                                    for (com.pahana.BookServlet.Book book : books) {
                                %>
                                    <tr>
                                        <td><%= book.getBookId() %></td>
                                        <td>
                                            <div class="book-title"><%= book.getTitle() %></div>
                                        </td>
                                        <td>
                                            <div class="book-author"><%= book.getAuthor() != null ? book.getAuthor() : "Unknown" %></div>
                                        </td>
                                        <td><%= book.getCategoryName() != null ? book.getCategoryName() : "Uncategorized" %></td>
                                        <td>
                                            <div class="book-price">$<%= book.getPrice() != null ? book.getPrice().toString() : "0.00" %></div>
                                        </td>
                                        <td>
                                            <span class="book-stock"><%= book.getStockQuantity() %></span>
                                        </td>
                                        <td><%= book.getCreatedAt() != null ? book.getCreatedAt().toString() : "N/A" %></td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-warning btn-sm edit-book-btn" 
                                                        data-id="<%= book.getBookId() %>"
                                                        data-title="<%= book.getTitle().replace("\"", "&quot;") %>"
                                                        data-author="<%= book.getAuthor() != null ? book.getAuthor().replace("\"", "&quot;") : "" %>"
                                                        data-price="<%= book.getPrice() != null ? book.getPrice().toString() : "0" %>"
                                                        data-stock="<%= book.getStockQuantity() %>"
                                                        data-category="<%= book.getCategoryId() %>"
                                                        title="Edit Book">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-danger btn-sm delete-book-btn" 
                                                        data-id="<%= book.getBookId() %>"
                                                        data-title="<%= book.getTitle().replace("\"", "&quot;") %>"
                                                        title="Delete Book">
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
                                            <i class="fas fa-inbox" style="font-size: 2rem; color: #ccc; margin-bottom: 1rem;"></i>
                                            <p>No books found</p>
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

    <!-- Edit Book Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3><i class="fas fa-edit"></i> Edit Book</h3>
            <form action="BookServlet" method="POST">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" id="editBookId" name="bookId" />
                <div class="form-row">
                    <div class="form-group">
                        <label for="editTitle">Book Title *</label>
                        <input type="text" id="editTitle" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="editAuthor">Author</label>
                        <input type="text" id="editAuthor" name="author" placeholder="Author name">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label for="editPrice">Price *</label>
                        <input type="number" id="editPrice" name="price" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="editStockQuantity">Stock Quantity *</label>
                        <input type="number" id="editStockQuantity" name="stockQuantity" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="editCategoryId">Category *</label>
                        <select id="editCategoryId" name="categoryId" required>
                            <option value="">Select Category</option>
                            <%
                            if (categories != null) {
                                for (com.pahana.CategoryServlet.Category category : categories) {
                            %>
                                <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>
                </div>
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Book
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
            <p>Are you sure you want to delete the book "<span id="deleteBookTitle"></span>"?</p>
            <p style="color: #ff4757; font-size: 0.9rem;">
                <i class="fas fa-info-circle"></i> This action cannot be undone.
            </p>
            <form action="BookServlet" method="POST">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" id="deleteBookId" name="bookId" />
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Book
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
        <p>&copy; 2024 BookShop. All rights reserved. | Book Management System</p>
    </footer>

    <script>
        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.admin-sidebar');
            if (sidebar) {
                sidebar.classList.toggle('open');
            }
        }

        // Edit book function
        function editBook(bookId, title, author, price, stockQuantity, categoryId) {
            document.getElementById('editBookId').value = bookId;
            document.getElementById('editTitle').value = title;
            document.getElementById('editAuthor').value = author;
            document.getElementById('editPrice').value = price;
            document.getElementById('editStockQuantity').value = stockQuantity;
            document.getElementById('editCategoryId').value = categoryId;
            document.getElementById('editModal').style.display = 'block';
        }

        // Delete book function
        function deleteBook(bookId, bookTitle) {
            document.getElementById('deleteBookId').value = bookId;
            document.getElementById('deleteBookTitle').textContent = bookTitle;
            document.getElementById('deleteModal').style.display = 'block';
        }

        // Event listeners for edit and delete buttons
        document.addEventListener('DOMContentLoaded', function() {
            // Edit book buttons
            document.querySelectorAll('.edit-book-btn').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    const bookId = this.getAttribute('data-id');
                    const title = this.getAttribute('data-title');
                    const author = this.getAttribute('data-author');
                    const price = this.getAttribute('data-price');
                    const stock = this.getAttribute('data-stock');
                    const category = this.getAttribute('data-category');
                    editBook(bookId, title, author, price, stock, category);
                });
            });

            // Delete book buttons
            document.querySelectorAll('.delete-book-btn').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    const bookId = this.getAttribute('data-id');
                    const title = this.getAttribute('data-title');
                    deleteBook(bookId, title);
                });
            });
        });

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