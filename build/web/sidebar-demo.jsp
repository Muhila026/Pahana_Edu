<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar Demo - Unified Design</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/sidebar.css">
    <style>
        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            min-height: 100vh;
        }
        
        .demo-content {
            padding: 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            margin: 2rem;
        }
        
        .theme-selector {
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }
        
        .theme-selector h3 {
            margin-top: 0;
            color: #1e293b;
        }
        
        .theme-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .theme-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .theme-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .theme-default {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
        }
        
        .theme-dark {
            background: linear-gradient(135deg, #1f2937, #111827);
            color: white;
        }
        
        .theme-ocean {
            background: linear-gradient(135deg, #0ea5e9, #0284c7);
            color: white;
        }
        
        .theme-forest {
            background: linear-gradient(135deg, #059669, #047857);
            color: white;
        }
        
        .demo-info {
            background: #f0f9ff;
            border: 1px solid #0ea5e9;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .demo-info h3 {
            color: #0c4a6e;
            margin-top: 0;
        }
        
        .demo-info ul {
            color: #0c4a6e;
            line-height: 1.8;
        }
    </style>
</head>
<body>
    <div class="admin-layout">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="admin-sidebar-header">
                <h2>Unified Sidebar</h2>
                <p>Consistent design across all pages</p>
            </div>
            
            <ul class="admin-sidebar-menu">
                <li><a href="#" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-book"></i> Books</a></li>
                <li><a href="#"><i class="fas fa-users"></i> Users</a></li>
                <li><a href="#"><i class="fas fa-shopping-cart"></i> Orders</a></li>
                <li><a href="#"><i class="fas fa-chart-bar"></i> Reports</a></li>
                <li><a href="#"><i class="fas fa-cog"></i> Settings</a></li>
                <li><a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="admin-main-content">
            <div class="demo-content">
                <h1>Unified Sidebar Design Demo</h1>
                
                <div class="demo-info">
                    <h3>✨ What's New</h3>
                    <ul>
                        <li><strong>Consistent Styling:</strong> All sidebars now use the same CSS file</li>
                        <li><strong>Unified Colors:</strong> Same color scheme across all pages</li>
                        <li><strong>Theme Support:</strong> Multiple theme options available</li>
                        <li><strong>Responsive Design:</strong> Mobile-friendly sidebar behavior</li>
                        <li><strong>Enhanced Animations:</strong> Smooth hover effects and transitions</li>
                    </ul>
                </div>
                
                <div class="theme-selector">
                    <h3>🎨 Try Different Themes</h3>
                    <div class="theme-buttons">
                        <button class="theme-btn theme-default" onclick="changeTheme('default')">Default</button>
                        <button class="theme-btn theme-dark" onclick="changeTheme('dark')">Dark</button>
                        <button class="theme-btn theme-ocean" onclick="changeTheme('ocean')">Ocean</button>
                        <button class="theme-btn theme-forest" onclick="changeTheme('forest')">Forest</button>
                    </div>
                </div>
                
                <div class="demo-info">
                    <h3>🔧 Implementation Details</h3>
                    <ul>
                        <li><strong>CSS File:</strong> <code>web/css/sidebar.css</code></li>
                        <li><strong>JavaScript:</strong> <code>web/js/sidebar.js</code></li>
                        <li><strong>Updated Pages:</strong> books.jsp, pos.jsp, user-view.jsp, welcome.jsp</li>
                        <li><strong>Features:</strong> CSS variables, theme switching, responsive design</li>
                    </ul>
                </div>
                
                <div class="demo-info">
                    <h3>📱 Mobile Features</h3>
                    <ul>
                        <li><strong>Hamburger Menu:</strong> Toggle button for mobile devices</li>
                        <li><strong>Overlay:</strong> Background overlay when sidebar is open</li>
                        <li><strong>Smooth Transitions:</strong> Animated open/close effects</li>
                        <li><strong>Touch Friendly:</strong> Optimized for touch devices</li>
                    </ul>
                </div>
            </div>
        </main>
    </div>

    <script src="js/sidebar.js"></script>
    <script>
        // Theme switching functionality
        function changeTheme(theme) {
            const sidebar = document.querySelector('.admin-sidebar');
            
            // Remove all theme classes
            sidebar.classList.remove('theme-default', 'theme-dark', 'theme-ocean', 'theme-forest');
            
            // Add new theme class
            if (theme !== 'default') {
                sidebar.classList.add('theme-' + theme);
            }
            
            // Show feedback
            const themeNames = {
                'default': 'Default Theme',
                'dark': 'Dark Theme',
                'ocean': 'Ocean Theme',
                'forest': 'Forest Theme'
            };
            
            alert('Switched to ' + themeNames[theme] + '!');
        }
        
        // Initialize sidebar manager
        document.addEventListener('DOMContentLoaded', function() {
            if (window.sidebarManager) {
                console.log('Sidebar Manager initialized successfully!');
            }
        });
    </script>
</body>
</html>
