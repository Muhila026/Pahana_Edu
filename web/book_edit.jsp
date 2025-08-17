<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.BookServlet.Book"%>
<%@page import="com.booking.BookCategoryServlet.BookCategory"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Edit - BookShop</title>
    
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

        .form-select {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.875rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            color: var(--text-primary);
        }

        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            outline: none;
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
        
        // Get book and categories from request attributes
        Book book = (Book) request.getAttribute("book");
        List<BookCategory> categories = (List<BookCategory>) request.getAttribute("categories");
        
        if (book == null) {
            response.sendRedirect("BookServlet?action=list&error=Book not found or not loaded.");
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
                <a href="BookServlet?action=list" class="nav-link active">
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
                <i class="fas fa-edit me-3"></i>Edit Book
            </h1>
            <p class="page-subtitle">Update book information and details</p>
        </div>

        <!-- Edit Book Form -->
        <div class="content-card">
            <h3 class="card-title">
                <i class="fas fa-book-open"></i>Edit Book Details
                <div>
                    <a href="BookServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>Back to List
                    </a>
                </div>
            </h3>
            
            <form method="POST" action="BookServlet?action=update">
                <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                
                <div class="form-section">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Book ID</label>
                            <input type="text" class="form-control" value="<%= book.getBookId() %>" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Title *</label>
                            <input type="text" class="form-control" name="title" value="<%= book.getTitle() != null ? book.getTitle() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Price *</label>
                            <input type="number" class="form-control" name="price" step="0.01" min="0" 
                                   value="<%= book.getPricePerUnit() != null ? book.getPricePerUnit() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Stock Quantity *</label>
                            <input type="number" class="form-control" name="stock" min="0" 
                                   value="<%= book.getStockQuantity() %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Category *</label>
                            <select class="form-select" name="categoryId" required>
                                <option value="">Select Category</option>
                                <% 
                                if (categories != null) {
                                    for (BookCategory category : categories) {
                                        String selected = (book.getCategory() != null && book.getCategory().getCategoryId() == category.getCategoryId()) ? "selected" : "";
                                %>
                                <option value="<%= category.getCategoryId() %>" <%= selected %>><%= category.getCategoryName() %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Created Date</label>
                            <input type="text" class="form-control" value="<%= book.getCreatedAt() != null ? book.getCreatedAt().toString() : "N/A" %>" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Last Updated</label>
                            <input type="text" class="form-control" value="<%= book.getUpdatedAt() != null ? book.getUpdatedAt().toString() : "N/A" %>" readonly>
                        </div>
                    </div>
                    
                    <div class="form-group full-width-field">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="4" placeholder="Enter book description"><%= book.getDescription() != null ? book.getDescription() : "" %></textarea>
                    </div>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>Update Book
                    </button>
                    <a href="BookServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-list"></i>View All Books
                    </a>
                    <a href="BookServlet?action=list" class="btn btn-danger">
                        <i class="fas fa-times"></i>Cancel
                    </a>
                </div>
            </form>
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

        // Form validation
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const title = document.querySelector('input[name="title"]').value.trim();
                    const price = document.querySelector('input[name="price"]').value.trim();
                    const stock = document.querySelector('input[name="stock"]').value.trim();
                    const categoryId = document.querySelector('select[name="categoryId"]').value;
                    
                    if (!title) {
                        e.preventDefault();
                        alert('Book title is required');
                        return false;
                    }
                    
                    if (!price || parseFloat(price) <= 0) {
                        e.preventDefault();
                        alert('Valid price is required');
                        return false;
                    }
                    
                    if (!stock || parseInt(stock) < 0) {
                        e.preventDefault();
                        alert('Valid stock quantity is required');
                        return false;
                    }
                    
                    if (!categoryId) {
                        e.preventDefault();
                        alert('Category selection is required');
                        return false;
                    }
                });
            }
        });
    </script>
</body>
</html> 