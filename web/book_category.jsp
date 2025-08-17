<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.BookCategoryServlet.BookCategory"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Category Management - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
        :root {
            /* Brand Colors */
            --primary-color: #b1081b;
            --primary-hover: #8a0615;
            --secondary-color: #57b8bf;
            
            /* Status Colors */
            --success-color: #4CAF50;
            --warning-color: #F4A261;
            --danger-color: #E76F51;
            --info-color: #60A5FA;
            
            /* Backgrounds */
            --background-color: #ffffff;
            --card-background: #eefdff;
            
            /* Text Colors */
            --text-primary: #1e293b;
            --text-secondary: #d0898d;
            
            /* Borders & Accents */
            --border-color: #d0898d;
            --sidebar-bg: #ffffff;
            --sidebar-hover: #ecdbeb;
            --accent-color: #57b8bf;
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
                <a href="CustomerServlet?action=list" class="nav-link">
                    <i class="fas fa-user-friends"></i>
                    Customer
                </a>
            </div>
            
            <div class="nav-item">
                <a href="BookCategoryServlet?action=list" class="nav-link active">
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
                <i class="fas fa-tags me-3"></i>Book Category Management
            </h1>
            <p class="page-subtitle">Organize and manage book categories for better catalog organization</p>
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

                <!-- Book Category Management Content -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-tags me-2"></i>Book Category Management</span>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                            <i class="bi bi-plus-circle me-2"></i>Add Category
                        </button>
                    </h3>
                    
                    <!-- Book Categories Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Category Name</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<BookCategory> bookCategories = (List<BookCategory>) request.getAttribute("categories");
                                if (bookCategories != null && !bookCategories.isEmpty()) {
                                    for (BookCategory category : bookCategories) {
                                %>
                                <tr>
                                    <td><%= category.getCategoryId() %></td>
                                    <td><%= category.getCategoryName() %></td>
                                    <td>
                                        <button class="btn btn-edit btn-sm"
                                                data-category-id="<%= category.getCategoryId() %>"
                                                data-category-name='<%= category.getCategoryName().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("'","&#39;").replace("\"","&quot;") %>'
                                                onclick="handleEditClick(this)">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-delete btn-sm"
                                                data-category-id="<%= category.getCategoryId() %>"
                                                data-category-name='<%= category.getCategoryName().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("'","&#39;").replace("\"","&quot;") %>'
                                                onclick="handleDeleteClick(this)">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="3" class="text-center text-muted">
                                        <i class="bi bi-inbox me-2"></i>No book categories found
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Add Category Modal -->
                <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addCategoryModalLabel">
                                    <i class="bi bi-plus-circle me-2"></i>Add New Category
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="BookCategoryServlet" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="categoryName" class="form-label">Category Name</label>
                                        <input type="text" class="form-control" id="categoryName" name="categoryName" 
                                               required placeholder="Enter category name">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-plus-circle me-2"></i>Add Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Edit Category Modal -->
                <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editCategoryModalLabel">
                                    <i class="fas fa-pencil me-2"></i>Edit Category
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="BookCategoryServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="categoryId" id="editCategoryId">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="editCategoryName" class="form-label">Category Name</label>
                                        <input type="text" class="form-control" id="editCategoryName" name="categoryName" 
                                               required placeholder="Enter category name">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-check-circle me-2"></i>Update Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteCategoryModal" tabindex="-1" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteCategoryModalLabel">
                                    <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete the category "<span id="deleteCategoryName"></span>"?</p>
                                <p class="text-danger"><small>This action cannot be undone.</small></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                                    <i class="fas fa-trash me-2"></i>Delete Category
                                </a>
                            </div>
                        </div>
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
                sidebar.classList.toggle('open');
                document.getElementById('sidebarOverlay').classList.toggle('open');
            }

            // Close sidebar when clicking outside on mobile
            function closeSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.remove('open');
                document.getElementById('sidebarOverlay').classList.remove('open');
            }

            // Edit category function
            function editCategory(categoryId, categoryName) {
                document.getElementById('editCategoryId').value = categoryId;
                document.getElementById('editCategoryName').value = categoryName;
                new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
            }

            // Handlers that read data attributes to avoid inline script expressions
            function handleEditClick(buttonEl) {
                const categoryId = buttonEl.getAttribute('data-category-id');
                const categoryName = buttonEl.getAttribute('data-category-name');
                editCategory(categoryId, categoryName);
            }

            // Delete category function
            function deleteCategory(categoryId, categoryName) {
                document.getElementById('deleteCategoryName').textContent = categoryName;
                document.getElementById('confirmDeleteBtn').href = 'BookCategoryServlet?action=delete&id=' + categoryId;
                new bootstrap.Modal(document.getElementById('deleteCategoryModal')).show();
            }

            function handleDeleteClick(buttonEl) {
                const categoryId = buttonEl.getAttribute('data-category-id');
                const categoryName = buttonEl.getAttribute('data-category-name');
                deleteCategory(categoryId, categoryName);
            }
        </script>
    </body>
</html> 