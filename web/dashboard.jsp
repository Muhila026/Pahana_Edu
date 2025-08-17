<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.booking.*"%>
<%@page import="com.booking.BookServlet.Book"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= session.getAttribute("role") != null ? session.getAttribute("role") + " Dashboard" : "Dashboard" %> - BookShop</title>
    
        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
        <style>
       :root {
                /* Brand Colors */
                --primary-color: #b1081b;       /* Strong maroon/red - brand & emphasis */
                --primary-hover: #8a0615;       /* Darker maroon for hover */
                --secondary-color: #57b8bf;     /* Fresh teal accent */

                /* Status Colors */
                --success-color: #4CAF50;       /* Soft green for success */
                --warning-color: #F4A261;       /* Gentle orange for warnings */
                --danger-color: #E76F51;        /* Coral red for errors */
                --info-color: #60A5FA;          /* Light modern blue */

                /* Backgrounds */
                --background-color: #ffffff;    /* Soft lavender background */
                --card-background: #eefdff;     /* Light blue-gray card background */

                /* Text Colors */
                --text-primary: #1e293b;        /* Dark navy for readability */
                --text-secondary: #d0898d;      /* Muted pinkish tone for subtext */

                /* Borders & Accents */
                --border-color: #d0898d;        /* Soft pink border */
                --sidebar-bg: #ffffff;          /* Clean white sidebar */
                --sidebar-hover: #ecdbeb;       /* Light lavender hover */
                --sidebar-active-bg: #57b8bf;   /* Teal active background */
                --sidebar-active-text: #ffffff; /* White text on active sidebar item */
                --accent-color: #57b8bf;        /* Teal highlights */
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

        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: white;
            padding: 2.5rem;
            border-radius: 20px;
                margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .dashboard-header::before {
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

        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .dashboard-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        /* Management Cards */
        .management-grid {
                display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

        .management-card {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .management-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        .management-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
                color: white;
            }

        .card-icon.book {
            background: linear-gradient(135deg, var(--success-color), #059669);
        }

        .card-icon.category {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
        }

        .card-icon.user {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
        }

        .card-icon.reports {
            background: linear-gradient(135deg, var(--info-color), #2563eb);
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
        }

        .card-description {
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .card-action {
            display: inline-flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .card-action:hover {
            background: var(--primary-hover);
            color: white;
            transform: translateX(5px);
        }

        .card-action i {
            margin-left: 8px;
            transition: transform 0.3s ease;
        }

        .card-action:hover i {
            transform: translateX(3px);
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

            .management-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .dashboard-header {
                padding: 2rem 1.5rem;
            }
            
            .dashboard-title {
                font-size: 2rem;
            }
            
            .management-grid {
                grid-template-columns: 1fr;
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
        
        /* Chart sizing */
        .chart-wrapper {
            height: 260px;
        }

        /* Stats grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
        }
        .stat-box {
            background: var(--card-background);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1rem 1.25rem;
        }
        .stat-label { color: var(--text-secondary); font-weight: 600; font-size: .95rem; }
        .stat-value { font-size: 1.8rem; font-weight: 700; color: var(--text-primary); }
        .stat-sub { color: var(--text-secondary); font-size: .85rem; }
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
            <% 
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equals(role) || "MANAGER".equals(role)) { 
            %>
                <!-- ADMIN and MANAGER see all menu items -->
                <div class="nav-item">
                    <a href="dashboard.jsp" class="nav-link active">
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
                    <a href="help.jsp" class="nav-link">
                        <i class="fas fa-question-circle"></i>
                        Help
                    </a>
                </div>
            <% } else if ("STAFF".equals(role)) { %>
                <!-- STAFF see limited menu items -->
                <div class="nav-item">
                    <a href="dashboard.jsp" class="nav-link active">
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
                    <a href="help.jsp" class="nav-link">
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
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1 class="dashboard-title">
                <%= session.getAttribute("role") != null ? session.getAttribute("role") + " Dashboard" : "Dashboard" %>
            </h1>
            <p class="dashboard-subtitle">
                Welcome back, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %>! 
                <% if ("ADMIN".equals(session.getAttribute("role")) || "MANAGER".equals(session.getAttribute("role"))) { %>
                Manage your bookstore and help customers find their perfect books.
                <% } else if ("STAFF".equals(session.getAttribute("role"))) { %>
                Help customers and manage daily operations efficiently.
                <% } else if ("CUSTOMER".equals(session.getAttribute("role"))) { %>
                Browse books and manage your account.
                <% } else { %>
                Welcome to our bookstore!
                <% } %>
            </p>
        </div>
        <% if ("ADMIN".equals(session.getAttribute("role")) || "MANAGER".equals(session.getAttribute("role"))) { %>
            <div class="management-card" style="margin-bottom: 2rem;">
                <h3 class="card-title">Stock Overview</h3>
                <p class="card-description">Key inventory indicators at a glance.</p>
                <div class="stats-grid">
                    <%
                        List<Book> dashBooks;
                        try {
                            dashBooks = new com.booking.BookServlet().getAllBooks();
                        } catch (Exception ex) {
                            dashBooks = new ArrayList<>();
                        }
                        long totalStock = 0L;
                        long lowStock = 0L;
                        long outStock = 0L;
                        java.util.Set<String> categorySet = new java.util.HashSet<>();
                        if (dashBooks != null) {
                            for (Book b : dashBooks) {
                                int q = b != null ? b.getStockQuantity() : 0;
                                totalStock += q;
                                if (q == 0) {
                                    outStock++;
                                } else if (q <= 10) {
                                    lowStock++;
                                }
                                try {
                                    String cn = (b != null && b.getCategory() != null) ? b.getCategory().getCategoryName() : null;
                                    if (cn != null) categorySet.add(cn);
                                } catch (Exception ignore) {}
                            }
                        }
                        int categoryCount = categorySet.size();
                    %>
                    <div class="stat-box">
                        <div class="stat-label">Total Units</div>
                        <div class="stat-value" style="color: var(--tertiary-color);"><%= totalStock %></div>
                        <div class="stat-sub">All books in stock</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-label">Low Stock</div>
                        <div class="stat-value" style="color: var(--warning-color);"><%= lowStock %></div>
                        <div class="stat-sub">≤ 10 units remaining</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-label">Out of Stock</div>
                        <div class="stat-value" style="color: var(--danger-color);"><%= outStock %></div>
                        <div class="stat-sub">Need reorder</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-label">Categories</div>
                        <div class="stat-value" style="color: var(--info-color);"><%= categoryCount %></div>
                        <div class="stat-sub">Active categories</div>
                    </div>
                </div>
            </div>
            <% } %>
        <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
        <div class="management-card" style="margin-bottom: 2rem;">
            <h3 class="card-title">Last 7 Days Sales</h3>
            <p class="card-description">Daily total amounts for the past week.</p>
            <div class="chart-wrapper">
                <canvas id="lastTransactionsChart"></canvas>
            </div>
        </div>
        <% } %>

       

        <!-- Management Cards Grid -->
        <div class="management-grid">
            <!-- Book Management Card -->
            <div class="management-card">
                <div class="card-icon book">
                    <i class="fas fa-book"></i>
                        </div>
                <h3 class="card-title">Book Management</h3>
                <p class="card-description">Add, edit, and manage books in your inventory. Keep track of stock levels and book details.</p>
                <a href="BookServlet?action=list" class="card-action">
                    Manage Books
                    <i class="fas fa-arrow-right"></i>
                </a>
                        </div>

            <!-- Category Management Card -->
            <div class="management-card">
                <div class="card-icon category">
                    <i class="fas fa-tags"></i>
                    </div>
                <h3 class="card-title">Category Management</h3>
                <p class="card-description">Organize books with categories and tags. Create a structured catalog for easy navigation.</p>
                <a href="BookCategoryServlet?action=list" class="card-action">
                    Manage Categories
                    <i class="fas fa-arrow-right"></i>
                </a>
                </div>

            <!-- User Management Card -->
            <div class="management-card">
                <div class="card-icon user">
                    <i class="fas fa-users"></i>
                        </div>
                <h3 class="card-title">User Management</h3>
                <p class="card-description">Manage customer accounts and staff members. Control access and permissions.</p>
                <a href="UserServlet?action=list" class="card-action">
                    Manage Users
                    <i class="fas fa-arrow-right"></i>
                </a>
                    </div>

            <!-- Reports & Analytics Card -->
            <div class="management-card">
                <div class="card-icon reports">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h3 class="card-title">Reports & Analytics</h3>
                <p class="card-description">View sales reports and customer analytics. Track performance and make data-driven decisions.</p>
                <a href="ChartServlet" class="card-action">
                    View Reports
                    <i class="fas fa-arrow-right"></i>
                </a>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

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

        // Add smooth animations
            document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.management-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100 + (index * 100));
            });
            });

        // Admin chart: last transactions
        document.addEventListener('DOMContentLoaded', function() {
            const canvas = document.getElementById('lastTransactionsChart');
            if (!canvas || typeof Chart === 'undefined') return;

            function hexToRgba(hex, alpha) {
                const clean = hex.replace('#', '').trim();
                const bigint = parseInt(clean.length === 3 ? clean.split('').map(c=>c+c).join('') : clean, 16);
                const r = (bigint >> 16) & 255;
                const g = (bigint >> 8) & 255;
                const b = bigint & 255;
                return `rgba(${r}, ${g}, ${b}, ${alpha})`;
            }

            const root = getComputedStyle(document.documentElement);
            let lineColor = (root.getPropertyValue('--primary-color') || '#b1081b').trim();
            const gridColor = (root.getPropertyValue('--border-color') || '#EDE9FE').trim();
            const tickColor = (root.getPropertyValue('--text-primary') || '#1E1B4B').trim();
            if (!lineColor || lineColor.charAt(0) !== '#') {
                lineColor = '#b1081b';
            }
            const fillColor = hexToRgba(lineColor, 0.12);

            fetch('ChartServlet?action=weeklySales', { cache: 'no-store' })
                .then(res => res.json())
                .then(json => {
                    if (!json || json.success !== true) return;
                    const ctx = canvas.getContext('2d');
                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: json.labels || [],
                            datasets: [{
                                label: 'Amount (Rs)',
                                data: json.data || [],
                                borderColor: lineColor,
                                backgroundColor: fillColor,
                                tension: 0.3,
                                fill: true,
                                pointRadius: 2,
                                pointBackgroundColor: lineColor,
                                pointBorderColor: lineColor,
                                borderWidth: 2
                            }]
                        },
                        options: {
                            maintainAspectRatio: false,
                            plugins: { legend: { display: false } },
                            scales: {
                                x: { ticks: { color: tickColor }, grid: { color: gridColor } },
                                y: { ticks: { color: tickColor }, grid: { color: gridColor } }
                            }
                        }
                    });
                })
                .catch(err => console.error('Chart load error', err));
        });
        </script>
    </body>
</html> 