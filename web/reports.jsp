<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics & Reports - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/sidebar.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .date-selector {
            background: white;
            padding: 1.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .date-selector h3 {
            color: #6366f1;
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .date-controls {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .date-input {
            padding: 0.5rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .date-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .date-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        .date-btn.secondary {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .kpi-card {
            background: white;
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            text-align: center;
            transition: all 0.3s ease;
        }

        .kpi-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(99, 102, 241, 0.15);
        }

        .kpi-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: white;
        }

        .kpi-icon.revenue { background: linear-gradient(135deg, #10b981, #059669); }
        .kpi-icon.orders { background: linear-gradient(135deg, #6366f1, #8b5cf6); }
        .kpi-icon.customers { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .kpi-icon.books { background: linear-gradient(135deg, #ef4444, #dc2626); }

        .kpi-number {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .kpi-label {
            color: #64748b;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .kpi-change {
            font-size: 0.9rem;
            font-weight: 600;
        }

        .kpi-change.positive { color: #10b981; }
        .kpi-change.negative { color: #ef4444; }

        .charts-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .chart-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .chart-header {
            margin-bottom: 1.5rem;
        }

        .chart-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .chart-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .chart-container {
            position: relative;
            height: 300px;
        }

        .top-products {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
        }

        .top-products h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-table th,
        .product-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #f1f5f9;
        }

        .product-table th {
            background: #f8fafc;
            font-weight: 600;
            color: #1e293b;
        }

        .product-table tr:hover {
            background: #f8fafc;
        }

        .product-rank {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: white;
            font-size: 0.9rem;
        }

        .rank-1 { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .rank-2 { background: linear-gradient(135deg, #9ca3af, #6b7280); }
        .rank-3 { background: linear-gradient(135deg, #f97316, #ea580c); }

        .report-actions {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
        }

        .report-actions h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .action-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        .action-btn.secondary { background: linear-gradient(135deg, #10b981, #059669); }
        .action-btn.warning { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .action-btn.danger { background: linear-gradient(135deg, #ef4444, #dc2626); }

        @media (max-width: 1200px) {
            .charts-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 768px) {
            .admin-main-content { margin-left: 0; }
            .main-content { padding: 1rem; }
            .date-controls { flex-direction: column; align-items: stretch; }
            .kpi-grid { grid-template-columns: repeat(2, 1fr); }
            .action-buttons { flex-direction: column; }
            .chart-container { height: 250px; }
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

    <% if ("admin".equals(navType) || "manager".equals(navType)) { %>
        <div class="admin-layout">
            <aside class="admin-sidebar">
                <div class="admin-sidebar-header">
                    <h2><%= "admin".equals(navType) ? "Admin" : "Manager" %> Panel</h2>
                    <p>Welcome, <%= username %></p>
                </div>
                
                <% if ("admin".equals(navType)) { %>
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Admin)</a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="reports.jsp" class="active"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                    <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Admin)</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <% } else if ("manager".equals(navType)) { %>
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Manager)</a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="reports.jsp" class="active"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Manager)</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <% } %>
            </aside>

            <main class="admin-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Analytics & Reports</h1>
                        <p>Comprehensive business insights and performance analytics</p>
                    </div>
                    
                    <div class="date-selector">
                        <h3><i class="fas fa-calendar"></i> Select Date Range</h3>
                        <div class="date-controls">
                            <input type="date" class="date-input" id="startDate" value="2024-01-01">
                            <span style="color: #64748b;">to</span>
                            <input type="date" class="date-input" id="endDate" value="2024-12-31">
                            <button class="date-btn" onclick="updateReports()">
                                <i class="fas fa-sync"></i> Update Reports
                            </button>
                            <button class="date-btn secondary" onclick="setLast30Days()">Last 30 Days</button>
                            <button class="date-btn secondary" onclick="setLast90Days()">Last 90 Days</button>
                            <button class="date-btn secondary" onclick="setThisYear()">This Year</button>
                        </div>
                    </div>
                    
                    <div class="kpi-grid">
                        <div class="kpi-card">
                            <div class="kpi-icon revenue">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="kpi-number" id="totalRevenue">$24,567</div>
                            <div class="kpi-label">Total Revenue</div>
                            <div class="kpi-change positive">+12.5% vs last period</div>
                        </div>
                        
                        <div class="kpi-card">
                            <div class="kpi-icon orders">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="kpi-number" id="totalOrders">1,247</div>
                            <div class="kpi-label">Total Orders</div>
                            <div class="kpi-change positive">+8.3% vs last period</div>
                        </div>
                        
                        <div class="kpi-card">
                            <div class="kpi-icon customers">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="kpi-number" id="totalCustomers">892</div>
                            <div class="kpi-label">Total Customers</div>
                            <div class="kpi-change positive">+15.2% vs last period</div>
                        </div>
                        
                        <div class="kpi-card">
                            <div class="kpi-icon books">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="kpi-number" id="totalBooks">3,456</div>
                            <div class="kpi-label">Books Sold</div>
                            <div class="kpi-change positive">+6.7% vs last period</div>
                        </div>
                    </div>
                    
                    <div class="charts-grid">
                        <div class="chart-card">
                            <div class="chart-header">
                                <h3><i class="fas fa-chart-line"></i> Sales Trend</h3>
                                <p>Revenue and order trends over time</p>
                            </div>
                            <div class="chart-container">
                                <canvas id="salesChart"></canvas>
                            </div>
                        </div>
                        
                        <div class="chart-card">
                            <div class="chart-header">
                                <h3><i class="fas fa-chart-pie"></i> Category Distribution</h3>
                                <p>Sales by book category</p>
                            </div>
                            <div class="chart-container">
                                <canvas id="categoryChart"></canvas>
                            </div>
                        </div>
                    </div>
                    
                    <div class="top-products">
                        <h3><i class="fas fa-trophy"></i> Top Performing Books</h3>
                        <table class="product-table">
                            <thead>
                                <tr>
                                    <th>Rank</th>
                                    <th>Book Title</th>
                                    <th>Category</th>
                                    <th>Units Sold</th>
                                    <th>Revenue</th>
                                    <th>Growth</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><div class="product-rank rank-1">1</div></td>
                                    <td>The Great Gatsby</td>
                                    <td>Fiction</td>
                                    <td>156</td>
                                    <td>$2,028</td>
                                    <td><span class="kpi-change positive">+23%</span></td>
                                </tr>
                                <tr>
                                    <td><div class="product-rank rank-2">2</div></td>
                                    <td>To Kill a Mockingbird</td>
                                    <td>Fiction</td>
                                    <td>134</td>
                                    <td>$2,008</td>
                                    <td><span class="kpi-change positive">+18%</span></td>
                                </tr>
                                <tr>
                                    <td><div class="product-rank rank-3">3</div></td>
                                    <td>1984</td>
                                    <td>Fiction</td>
                                    <td>128</td>
                                    <td>$1,536</td>
                                    <td><span class="kpi-change positive">+15%</span></td>
                                </tr>
                                <tr>
                                    <td><div class="product-rank">4</div></td>
                                    <td>Pride and Prejudice</td>
                                    <td>Classic</td>
                                    <td>112</td>
                                    <td>$1,456</td>
                                    <td><span class="kpi-change positive">+12%</span></td>
                                </tr>
                                <tr>
                                    <td><div class="product-rank">5</div></td>
                                    <td>The Hobbit</td>
                                    <td>Fantasy</td>
                                    <td>98</td>
                                    <td>$1,274</td>
                                    <td><span class="kpi-change positive">+9%</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="report-actions">
                        <h3><i class="fas fa-download"></i> Export & Generate Reports</h3>
                        <div class="action-buttons">
                            <button class="action-btn" onclick="exportSalesReport()">
                                <i class="fas fa-file-excel"></i> Export Sales Report
                            </button>
                            <button class="action-btn secondary" onclick="exportInventoryReport()">
                                <i class="fas fa-file-pdf"></i> Export Inventory Report
                            </button>
                            <button class="action-btn warning" onclick="generateCustomerReport()">
                                <i class="fas fa-users"></i> Customer Analysis
                            </button>
                            <button class="action-btn danger" onclick="generateFinancialReport()">
                                <i class="fas fa-chart-line"></i> Financial Summary
                            </button>
                            <button class="action-btn" onclick="scheduleReport()">
                                <i class="fas fa-clock"></i> Schedule Reports
                            </button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    <% } else { %>
        <div style="text-align: center; padding: 4rem 2rem;">
            <h1 style="color: #ef4444; margin-bottom: 1rem;">Access Denied</h1>
            <p style="color: #64748b; margin-bottom: 2rem;">You don't have permission to access Analytics & Reports.</p>
            <a href="welcome.jsp" style="background: #6366f1; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block;">Return to Home</a>
        </div>
    <% } %>

    <script src="js/sidebar.js"></script>
    <script>
        let salesChart, categoryChart;

        document.addEventListener('DOMContentLoaded', function() {
            initializeCharts();
            setDefaultDateRange();
        });

        function initializeCharts() {
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            salesChart = new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Revenue ($)',
                        data: [18500, 19200, 20100, 19800, 21500, 22800, 22100, 23400, 24100, 23800, 25200, 24567],
                        borderColor: '#6366f1',
                        backgroundColor: 'rgba(99, 102, 241, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: 'Orders',
                        data: [156, 162, 168, 165, 178, 185, 179, 192, 198, 195, 208, 201],
                        borderColor: '#10b981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4,
                        fill: false,
                        yAxisID: 'y1'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    scales: {
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            title: {
                                display: true,
                                text: 'Revenue ($)'
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            title: {
                                display: true,
                                text: 'Orders'
                            },
                            grid: {
                                drawOnChartArea: false,
                            },
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                        }
                    }
                }
            });

            const categoryCtx = document.getElementById('categoryChart').getContext('2d');
            categoryChart = new Chart(categoryCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Fiction', 'Non-Fiction', 'Science', 'History', 'Biography', 'Other'],
                    datasets: [{
                        data: [35, 25, 15, 12, 8, 5],
                        backgroundColor: [
                            '#6366f1',
                            '#10b981',
                            '#f59e0b',
                            '#ef4444',
                            '#8b5cf6',
                            '#6b7280'
                        ],
                        borderWidth: 2,
                        borderColor: '#ffffff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                        }
                    }
                }
            });
        }

        function setDefaultDateRange() {
            const today = new Date();
            const startDate = new Date(today.getFullYear(), 0, 1);
            
            document.getElementById('startDate').value = startDate.toISOString().split('T')[0];
            document.getElementById('endDate').value = today.toISOString().split('T')[0];
        }

        function setLast30Days() {
            const today = new Date();
            const thirtyDaysAgo = new Date(today.getTime() - (30 * 24 * 60 * 60 * 1000));
            
            document.getElementById('startDate').value = thirtyDaysAgo.toISOString().split('T')[0];
            document.getElementById('endDate').value = today.toISOString().split('T')[0];
            updateReports();
        }

        function setLast90Days() {
            const today = new Date();
            const ninetyDaysAgo = new Date(today.getTime() - (90 * 24 * 60 * 60 * 1000));
            
            document.getElementById('startDate').value = ninetyDaysAgo.toISOString().split('T')[0];
            document.getElementById('endDate').value = today.toISOString().split('T')[0];
            updateReports();
        }

        function setThisYear() {
            const today = new Date();
            const startDate = new Date(today.getFullYear(), 0, 1);
            
            document.getElementById('startDate').value = startDate.toISOString().split('T')[0];
            document.getElementById('endDate').value = today.toISOString().split('T')[0];
            updateReports();
        }

        function updateReports() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            document.querySelectorAll('.kpi-number').forEach(el => {
                el.textContent = 'Loading...';
            });
            
            setTimeout(() => {
                updateKPIValues(startDate, endDate);
                updateCharts(startDate, endDate);
                showNotification('Reports updated successfully!', 'success');
            }, 1000);
        }

        function updateKPIValues(startDate, endDate) {
            const start = new Date(startDate);
            const end = new Date(endDate);
            const daysDiff = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
            
            const baseRevenue = 24567;
            const revenuePerDay = baseRevenue / 365;
            const newRevenue = Math.round(revenuePerDay * daysDiff);
            
            document.getElementById('totalRevenue').textContent = '$' + newRevenue.toLocaleString();
            document.getElementById('totalOrders').textContent = Math.round(newRevenue / 20).toLocaleString();
            document.getElementById('totalCustomers').textContent = Math.round(newRevenue / 30).toLocaleString();
            document.getElementById('totalBooks').textContent = Math.round(newRevenue / 7).toLocaleString();
        }

        function updateCharts(startDate, endDate) {
            console.log('Charts updated for date range:', startDate, 'to', endDate);
        }

        function exportSalesReport() {
            showNotification('Sales report export started...', 'info');
        }

        function exportInventoryReport() {
            showNotification('Inventory report export started...', 'info');
        }

        function generateCustomerReport() {
            showNotification('Customer analysis report generated...', 'info');
        }

        function generateFinancialReport() {
            showNotification('Financial summary report generated...', 'info');
        }

        function scheduleReport() {
            showNotification('Report scheduling feature coming soon...', 'info');
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 1rem 1.5rem;
                border-radius: 8px;
                color: white;
                font-weight: 600;
                z-index: 1000;
                animation: slideIn 0.3s ease;
            `;
            
            switch(type) {
                case 'success': notification.style.background = '#10b981'; break;
                case 'info': notification.style.background = '#6366f1'; break;
                case 'warning': notification.style.background = '#f59e0b'; break;
                case 'error': notification.style.background = '#ef4444'; break;
                default: notification.style.background = '#6366f1';
            }
            
            notification.textContent = message;
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
        }

        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes slideOut {
                from { transform: translateX(0); opacity: 1; }
                to { transform: translateX(100%); opacity: 0; }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
