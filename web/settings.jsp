<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings - Pahana BookShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/sidebar.css">
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

        .settings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .settings-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .settings-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f5f9;
        }

        .settings-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .settings-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #1e293b;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            background: #f8fafc;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #6366f1;
            background: white;
        }

        .form-group .help-text {
            font-size: 0.85rem;
            color: #64748b;
            margin-top: 0.25rem;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #6366f1;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .toggle-label {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .toggle-label span {
            font-weight: 600;
            color: #1e293b;
        }

        .toggle-description {
            color: #64748b;
            font-size: 0.9rem;
            margin-left: 4rem;
        }

        .settings-actions {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
        }

        .settings-actions h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        @media (max-width: 768px) {
            .admin-main-content { margin-left: 0; }
            .main-content { padding: 1rem; }
            .settings-grid { grid-template-columns: 1fr; }
            .action-buttons { flex-direction: column; }
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

    <% if ("admin".equals(navType)) { %>
        <div class="admin-layout">
            <aside class="admin-sidebar">
                <div class="admin-sidebar-header">
                    <h2>Admin Panel</h2>
                    <p>Welcome, <%= username %></p>
                </div>
                
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Admin)</a></li>
                    <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="reports.jsp"><i class="fas fa-chart-bar"></i> Analytics & Reports</a></li>
                    <li><a href="settings.jsp" class="active"><i class="fas fa-cogs"></i> System Settings</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Admin)</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </aside>

            <main class="admin-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>System Settings</h1>
                        <p>Configure system preferences, security settings, and application behavior</p>
                    </div>
                    
                    <div class="settings-grid">
                        <!-- General Settings -->
                        <div class="settings-card">
                            <div class="settings-header">
                                <h3><i class="fas fa-cog"></i> General Settings</h3>
                                <p>Basic system configuration and preferences</p>
                            </div>
                            
                            <form id="generalSettingsForm">
                                <div class="form-group">
                                    <label for="storeName">Store Name</label>
                                    <input type="text" id="storeName" name="storeName" value="Pahana BookShop" required>
                                    <div class="help-text">The name displayed throughout the application</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="storeEmail">Store Email</label>
                                    <input type="email" id="storeEmail" name="storeEmail" value="info@pahanabookshop.com" required>
                                    <div class="help-text">Primary contact email for the store</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="storePhone">Store Phone</label>
                                    <input type="text" id="storePhone" name="storePhone" value="+1 (555) 123-4567">
                                    <div class="help-text">Contact phone number</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="timezone">Timezone</label>
                                    <select id="timezone" name="timezone">
                                        <option value="UTC-8">Pacific Time (UTC-8)</option>
                                        <option value="UTC-7">Mountain Time (UTC-7)</option>
                                        <option value="UTC-6">Central Time (UTC-6)</option>
                                        <option value="UTC-5" selected>Eastern Time (UTC-5)</option>
                                        <option value="UTC+0">UTC</option>
                                        <option value="UTC+1">Central European Time (UTC+1)</option>
                                        <option value="UTC+5:30">India Standard Time (UTC+5:30)</option>
                                    </select>
                                    <div class="help-text">System timezone for date and time display</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="currency">Currency</label>
                                    <select id="currency" name="currency">
                                        <option value="USD" selected>US Dollar ($)</option>
                                        <option value="EUR">Euro (€)</option>
                                        <option value="GBP">British Pound (£)</option>
                                        <option value="CAD">Canadian Dollar (C$)</option>
                                        <option value="AUD">Australian Dollar (A$)</option>
                                        <option value="INR">Indian Rupee (₹)</option>
                                    </select>
                                    <div class="help-text">Default currency for pricing</div>
                                </div>
                            </form>
                        </div>

                        <!-- Security Settings -->
                        <div class="settings-card">
                            <div class="settings-header">
                                <h3><i class="fas fa-shield-alt"></i> Security Settings</h3>
                                <p>Authentication and security configurations</p>
                            </div>
                            
                            <form id="securitySettingsForm">
                                <div class="form-group">
                                    <label for="sessionTimeout">Session Timeout (minutes)</label>
                                    <input type="number" id="sessionTimeout" name="sessionTimeout" value="30" min="5" max="480">
                                    <div class="help-text">How long before users are automatically logged out</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="maxLoginAttempts">Maximum Login Attempts</label>
                                    <input type="number" id="maxLoginAttempts" name="maxLoginAttempts" value="5" min="3" max="10">
                                    <div class="help-text">Number of failed attempts before account lockout</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="lockoutDuration">Lockout Duration (minutes)</label>
                                    <input type="number" id="lockoutDuration" name="lockoutDuration" value="15" min="5" max="1440">
                                    <div class="help-text">How long accounts remain locked after failed attempts</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="passwordMinLength">Minimum Password Length</label>
                                    <input type="number" id="passwordMinLength" name="passwordMinLength" value="8" min="6" max="20">
                                    <div class="help-text">Minimum characters required for passwords</div>
                                </div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="requireSpecialChars" name="requireSpecialChars" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>Require Special Characters in Passwords</span>
                                </div>
                                <div class="toggle-description">Passwords must contain at least one special character</div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="twoFactorAuth" name="twoFactorAuth">
                                        <span class="slider"></span>
                                    </div>
                                    <span>Enable Two-Factor Authentication</span>
                                </div>
                                <div class="toggle-description">Require 2FA for admin accounts</div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="auditLogging" name="auditLogging" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>Enable Audit Logging</span>
                                </div>
                                <div class="toggle-description">Log all system activities for security monitoring</div>
                            </form>
                        </div>

                        <!-- Email Settings -->
                        <div class="settings-card">
                            <div class="settings-header">
                                <h3><i class="fas fa-envelope"></i> Email Settings</h3>
                                <p>Configure email notifications and SMTP settings</p>
                            </div>
                            
                            <form id="emailSettingsForm">
                                <div class="form-group">
                                    <label for="smtpHost">SMTP Host</label>
                                    <input type="text" id="smtpHost" name="smtpHost" value="smtp.gmail.com">
                                    <div class="help-text">SMTP server hostname</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="smtpPort">SMTP Port</label>
                                    <input type="number" id="smtpPort" name="smtpPort" value="587" min="1" max="65535">
                                    <div class="help-text">SMTP server port</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="smtpUsername">SMTP Username</label>
                                    <input type="email" id="smtpUsername" name="smtpUsername" value="noreply@pahanabookshop.com">
                                    <div class="help-text">Email account username</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="smtpPassword">SMTP Password</label>
                                    <input type="password" id="smtpPassword" name="smtpPassword" value="••••••••">
                                    <div class="help-text">Email account password</div>
                                </div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="orderConfirmations" name="orderConfirmations" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>Send Order Confirmations</span>
                                </div>
                                <div class="toggle-description">Automatically email customers when orders are placed</div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="shippingUpdates" name="shippingUpdates" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>Send Shipping Updates</span>
                                </div>
                                <div class="toggle-description">Notify customers of shipping status changes</div>
                            </form>
                        </div>

                        <!-- Notification Settings -->
                        <div class="settings-card">
                            <div class="settings-header">
                                <h3><i class="fas fa-bell"></i> Notification Settings</h3>
                                <p>Configure system notifications and alerts</p>
                            </div>
                            
                            <form id="notificationSettingsForm">
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="lowStockAlerts" name="lowStockAlerts" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>Low Stock Alerts</span>
                                </div>
                                <div class="toggle-description">Notify when book inventory is running low</div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="orderNotifications" name="orderNotifications" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>New Order Notifications</span>
                                </div>
                                <div class="toggle-description">Alert staff when new orders are received</div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="systemAlerts" name="systemAlerts" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>System Alerts</span>
                                </div>
                                <div class="toggle-description">Show important system messages and warnings</div>
                                
                                <div class="toggle-label">
                                    <div class="toggle-switch">
                                        <input type="checkbox" id="emailNotifications" name="emailNotifications" checked>
                                        <span class="slider"></span>
                                    </div>
                                    <span>Email Notifications</span>
                                </div>
                                <div class="toggle-description">Send notifications via email</div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Settings Actions -->
                    <div class="settings-actions">
                        <h3><i class="fas fa-save"></i> Save & Apply Settings</h3>
                        <div class="action-buttons">
                            <button class="btn btn-primary" onclick="saveAllSettings()">
                                <i class="fas fa-save"></i> Save All Settings
                            </button>
                            <button class="btn btn-secondary" onclick="resetToDefaults()">
                                <i class="fas fa-undo"></i> Reset to Defaults
                            </button>
                            <button class="btn btn-warning" onclick="testEmailSettings()">
                                <i class="fas fa-envelope"></i> Test Email Settings
                            </button>
                            <button class="btn btn-danger" onclick="clearAllData()">
                                <i class="fas fa-trash"></i> Clear All Data
                            </button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    <% } else { %>
        <div style="text-align: center; padding: 4rem 2rem;">
            <h1 style="color: #ef4444; margin-bottom: 1rem;">Access Denied</h1>
            <p style="color: #64748b; margin-bottom: 2rem;">Only administrators can access System Settings.</p>
            <a href="welcome.jsp" style="background: #6366f1; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block;">Return to Home</a>
        </div>
    <% } %>

    <script src="js/sidebar.js"></script>
    <script>
        function saveAllSettings() {
            alert('Saving all settings...');
            // This would typically save to database
        }

        function resetToDefaults() {
            if (confirm('Reset all settings to defaults?')) {
                document.querySelectorAll('form').forEach(form => form.reset());
                alert('Settings reset to defaults!');
            }
        }

        function testEmailSettings() {
            alert('Testing email configuration...');
            // This would test SMTP connection
        }

        function clearAllData() {
            if (confirm('⚠️ WARNING: This will delete ALL data. Are you sure?')) {
                if (confirm('Final warning: Type "DELETE ALL" to confirm:')) {
                    const confirmation = prompt('Type "DELETE ALL" to confirm:');
                    if (confirmation === 'DELETE ALL') {
                        alert('All data cleared. System will restart.');
                    } else {
                        alert('Data clearing cancelled.');
                    }
                }
            }
        }
    </script>
</body>
</html>
