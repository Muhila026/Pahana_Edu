<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.HelpServlet.HelpSection"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support - BookShop</title>
    
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
            color: var(--sidebar-active-text);
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

        /* Help Section Styling */
            .help-section {
                margin-bottom: 2rem;
            }

        .help-section h3 {
            color: var(--primary-color);
                margin-bottom: 1rem;
            font-weight: 600;
            }

            .help-section p {
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .help-section ul {
            color: var(--text-secondary);
                line-height: 1.6;
            margin-bottom: 1rem;
            padding-left: 1.5rem;
        }

        .help-section li {
            margin-bottom: 0.5rem;
        }

        .contact-info {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            padding: 2rem;
            border-radius: 16px;
            text-align: center;
        }

        .contact-info h3 {
            color: white;
            margin-bottom: 1rem;
        }

        .contact-info p {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 0.5rem;
        }

        .contact-info .contact-item {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .contact-info i {
            font-size: 1.2rem;
        }

        /* Ensure content visibility */
        .help-section h4 {
            color: var(--text-primary);
            margin-bottom: 0.75rem;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .help-section ol {
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 1rem;
            padding-left: 1.5rem;
        }

        .help-section ol li {
            margin-bottom: 0.5rem;
        }

        /* Additional styling for better visibility */
        .content-card .help-section:last-child {
            margin-bottom: 0;
        }

        .contact-info {
            margin-top: 2rem;
        }

        .contact-info .contact-item span {
            font-weight: 500;
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
        <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
        // Get help sections from request attributes (loaded by HelpServlet)
        List<HelpSection> helpSections = (List<HelpSection>) request.getAttribute("helpSections");

        // For MANAGER, strictly show only MANAGER-based help (exclude global/null role)
        if ("MANAGER".equals(role)) {
            try {
                com.booking.HelpServlet hs = new com.booking.HelpServlet();
                List<HelpSection> managerSections = hs.getHelpSectionsForRole("MANAGER");
                List<HelpSection> managerOnly = new ArrayList<>();
                for (HelpSection s : managerSections) {
                    if (s.getRoleId() != null) {
                        managerOnly.add(s);
                    }
                }
                helpSections = managerOnly;
            } catch (Exception ignore) {
                // keep existing helpSections if any
            }
        }

        // If no help sections loaded, redirect to HelpServlet to load them (for non-MANAGER roles)
        if (helpSections == null && !"MANAGER".equals(role)) {
            response.sendRedirect("HelpServlet?action=list");
            return;
        }
    %>
    
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
                    <a href="help.jsp" class="nav-link active">
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
                    <a href="CustomerServlet?action=list" class="nav-link">
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
                    <a href="help.jsp" class="nav-link active">
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
                    <a href="help.jsp" class="nav-link active">
                        <i class="fas fa-question-circle"></i>
                        Help
                    </a>
                </div>
            <% } else { %>
                <!-- Default fallback for unknown roles -->
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
                <i class="fas fa-question-circle me-3"></i>Help & Support
            </h1>
            <p class="page-subtitle">Get help with using the BookShop management system</p>
        </div>

        <!-- Dynamic Help Content from Database -->
        <% if (helpSections != null && !helpSections.isEmpty()) { %>
            <% for (HelpSection helpSection : helpSections) { %>
                <div class="content-card">
                    <h3 class="card-title">
                        <i class="fas fa-info-circle"></i><%= helpSection.getTitle() %>
                        <% if ("ADMIN".equals(role)) { %>
                            <div class="btn-group">
                                <a href="HelpServlet?action=view&help_id=<%= helpSection.getHelpId() %>" class="btn btn-sm btn-info">
                                    <i class="fas fa-eye"></i>View
                                </a>
                                <a href="HelpServlet?action=edit&help_id=<%= helpSection.getHelpId() %>" class="btn btn-edit btn-sm">
                                    <i class="fas fa-edit"></i>Edit
                                </a>
                                <button class="btn btn-delete btn-sm" data-help-id="<%= helpSection.getHelpId() %>" data-help-title="<%= helpSection.getTitle().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("'", "&#39;") %>">
                                    <i class="fas fa-trash"></i>Delete
                                </button>
                            </div>
                        <% } %>
                    </h3>
                    <div class="help-section">
                        <%= helpSection.getContent() %>
                                        </div>
                                    </div>
            <% } %>
        <% } else { %>
            <!-- Fallback content if no help sections found -->
            <div class="content-card">
                <h3 class="card-title">
                    <i class="fas fa-info-circle"></i>Getting Started
                </h3>
                <div class="help-section">
                    <h4>Welcome to BookShop Management System</h4>
                    <p>This system helps you manage your bookstore operations efficiently. Here's how to get started:</p>
                    <ul>
                        <li><strong>Dashboard:</strong> View overview of your bookstore operations</li>
                        <li><strong>POS:</strong> Process sales and transactions</li>
                        <li><strong>Books:</strong> Manage your book inventory</li>
                        <li><strong>Customers:</strong> Handle customer accounts</li>
                        <li><strong>Users:</strong> Manage staff access</li>
                    </ul>
                                </div>
                            </div>
                            <% } %>

        <!-- Add New Help Section Button (Admin/Manager only) -->
                        <% if ("ADMIN".equals(role)) { %>
            <div class="content-card">
                <h3 class="card-title">
                    <i class="fas fa-plus-circle"></i>Manage Help Content
                </h3>
                <div class="help-section">
                    <p>Add new help sections or manage existing ones:</p>
                    <a href="HelpServlet?action=create" class="btn btn-primary">
                        <i class="fas fa-plus"></i>Add New Help Section
                    </a>
                </div>
            </div>
        <% } %>

        <!-- Contact Information -->
        <div class="contact-info">
            <h3><i class="fas fa-headset me-2"></i>Need More Help?</h3>
            <p>If you need additional assistance, please contact our support team:</p>
            <div class="contact-item">
                <i class="fas fa-envelope"></i>
                <span>muhilavijayakumar@gmail.com</span>
            </div>
            <div class="contact-item">
                <i class="fas fa-phone"></i>
                <span>+94 76 594 7337</span>
            </div>
            <div class="contact-item">
                <i class="fas fa-clock"></i>
                <span>Monday - Sunday, 9:00 AM - 6:00 PM</span>
            </div>
        </div>

        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
        // Mobile sidebar functionality
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            sidebar.classList.toggle('open');
            overlay.classList.toggle('open');
            }

        function closeSidebar() {
                const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            sidebar.classList.remove('open');
            overlay.classList.remove('open');
        }

        // Close sidebar when clicking on a link (mobile)
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth <= 1024) {
                    closeSidebar();
                }
            });
        });

        // Close sidebar on window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 1024) {
                closeSidebar();
            }
        });

        // Delete Help Section (delegated handler)
        document.addEventListener('click', function(e) {
            var btn = e.target.closest('.btn-delete');
            if (!btn) return;
            var helpId = btn.getAttribute('data-help-id');
            var title = btn.getAttribute('data-help-title') || 'this help section';
            if (confirm('Are you sure you want to delete the help section "' + title + '"?')) {
                window.location.href = 'HelpServlet?action=delete&help_id=' + encodeURIComponent(helpId);
            }
        });
        </script>
    </body>
</html> 