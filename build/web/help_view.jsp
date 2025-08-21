<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.HelpServlet.HelpSection"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Help Section - BookShop</title>
    
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
            background: linear-gradient(135deg, var(--info-color), #2563eb);
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
            color: var(--info-color);
        }

        /* Help Content Styles */
        .help-content {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            border-left: 4px solid var(--info-color);
        }

        .help-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .help-body {
            font-size: 1.1rem;
            line-height: 1.7;
            color: var(--text-secondary);
        }

        .help-body h1, .help-body h2, .help-body h3, .help-body h4, .help-body h5, .help-body h6 {
            color: var(--text-primary);
            margin-top: 1.5rem;
            margin-bottom: 1rem;
        }

        .help-body p {
            margin-bottom: 1rem;
        }

        .help-body ul, .help-body ol {
            margin-bottom: 1rem;
            padding-left: 2rem;
        }

        .help-body li {
            margin-bottom: 0.5rem;
        }

        .help-body strong {
            color: var(--text-primary);
            font-weight: 600;
        }

        .help-body em {
            color: var(--text-secondary);
            font-style: italic;
        }

        .help-body code {
            background: var(--background-color);
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            color: var(--danger-color);
        }

        .help-body blockquote {
            border-left: 4px solid var(--info-color);
            padding-left: 1rem;
            margin: 1rem 0;
            font-style: italic;
            color: var(--text-secondary);
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
            background: var(--info-color);
            color: white;
        }

        .btn-primary:hover {
            background: #2563eb;
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

        .btn-warning {
            background: var(--warning-color);
            color: white;
        }

        .btn-warning:hover {
            background: #d97706;
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
            
            .help-content {
                padding: 1.5rem;
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
        
        // Get help section from request attributes
        HelpSection helpSection = (HelpSection) request.getAttribute("helpSection");
        
        if (helpSection == null) {
            response.sendRedirect("HelpServlet?action=list&error=Help section not found.");
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
                <a href="help.jsp" class="nav-link active">
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
                <i class="fas fa-eye me-3"></i>View Help Section
            </h1>
            <p class="page-subtitle">Read and understand help content</p>
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

        <!-- Help Section Content -->
        <div class="content-card">
            <h3 class="card-title">
                <i class="fas fa-info-circle"></i>Help Section Details
                <div>
                    <a href="HelpServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>Back to Help
                    </a>
                </div>
            </h3>
            
            <div class="help-content">
                <h2 class="help-title">
                    <i class="fas fa-question-circle me-2"></i><%= helpSection.getTitle() != null ? helpSection.getTitle() : "Untitled" %>
                </h2>
                
                <div class="help-body">
                    <% if (helpSection.getContent() != null && !helpSection.getContent().trim().isEmpty()) { %>
                        <%= helpSection.getContent() %>
                    <% } else { %>
                        <p class="text-muted">No content available for this help section.</p>
                    <% } %>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="btn-group">
                <a href="HelpServlet?action=list" class="btn btn-secondary">
                    <i class="fas fa-list"></i>All Help Sections
                </a>
                
                <% if ("ADMIN".equals(role) ) { %>
                    <a href="HelpServlet?action=edit&help_id=<%= helpSection.getHelpId() %>" class="btn btn-warning">
                        <i class="fas fa-edit"></i>Edit Help Section
                    </a>
                    
                    <button class="btn btn-danger" data-help-id="<%= helpSection.getHelpId() %>" onclick="deleteHelpSection(this.dataset.helpId)">
                        <i class="fas fa-trash"></i>Delete Help Section
                    </button>
                <% } %>
            </div>
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

        // Delete help section confirmation
        function deleteHelpSection(helpId) {
            if (confirm('Are you sure you want to delete this help section?\n\nThis action cannot be undone.')) {
                window.location.href = 'HelpServlet?action=delete&help_id=' + helpId;
            }
        }
    </script>
</body>
</html> 