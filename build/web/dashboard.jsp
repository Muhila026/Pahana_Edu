<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - Test Version</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 30px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
        }
        
        .nav-links {
            display: flex;
            gap: 20px;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #333;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.3s;
        }
        
        .nav-links a:hover {
            background: #667eea;
            color: white;
        }
        
        .logout-btn {
            background: #dc3545;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background: #c82333;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .welcome-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .welcome-section h1 {
            color: #667eea;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .welcome-section p {
            color: #666;
            font-size: 18px;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card h3 {
            color: #667eea;
            margin-bottom: 15px;
            font-size: 20px;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #333;
        }
        
        .info-value {
            color: #666;
        }
        
        .quick-actions {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .quick-actions h3 {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 20px;
        }
        
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .action-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 15px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
            display: block;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: #666;
            font-size: 16px;
        }
        
        .test-notice {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <%
    // Test version - no session validation
    String username = "Test User";
    String patientName = "John Doe";
    Integer patientId = 1;
    
    // Sample data for testing
    String age = "25";
    String phone = "1234567890";
    String email = "john@example.com";
    String bloodGroup = "A+";
    String address = "123 Main St, City";
    %>
    
    <nav class="navbar">
        <div class="logo">Patient Portal</div>
        <div class="nav-links">
            <a href="dashboard-test.jsp">Dashboard</a>
            <a href="profile.jsp">Profile</a>
            <a href="appointments.jsp">Appointments</a>
            <a href="medical-records.jsp">Medical Records</a>
        </div>
        <a href="login.jsp" class="logout-btn">Login</a>
    </nav>
    
    <div class="container">
        <div class="test-notice">
            <strong>Test Version:</strong> This is a test dashboard without authentication. 
            <a href="login.jsp" style="color: #667eea; text-decoration: none; font-weight: bold;">Click here to login</a> for the full version.
        </div>
        
        <div class="welcome-section">
            <h1>Welcome back, <%= patientName %>!</h1>
            <p>Here's your patient dashboard overview</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">3</div>
                <div class="stat-label">Upcoming Appointments</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">12</div>
                <div class="stat-label">Past Visits</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">5</div>
                <div class="stat-label">Prescriptions</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">2</div>
                <div class="stat-label">Pending Tests</div>
            </div>
        </div>
        
        <div class="dashboard-grid">
            <div class="card">
                <h3>Personal Information</h3>
                <div class="info-item">
                    <span class="info-label">Name:</span>
                    <span class="info-value"><%= patientName %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Age:</span>
                    <span class="info-value"><%= age %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Blood Group:</span>
                    <span class="info-value"><%= bloodGroup %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Phone:</span>
                    <span class="info-value"><%= phone %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Email:</span>
                    <span class="info-value"><%= email %></span>
                </div>
            </div>
            
            <div class="card">
                <h3>Recent Activity</h3>
                <div class="info-item">
                    <span class="info-label">Last Visit:</span>
                    <span class="info-value">Dec 15, 2024</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Next Appointment:</span>
                    <span class="info-value">Jan 20, 2025</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Doctor:</span>
                    <span class="info-value">Dr. Smith</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Department:</span>
                    <span class="info-value">Cardiology</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Status:</span>
                    <span class="info-value" style="color: #28a745; font-weight: bold;">Active</span>
                </div>
            </div>
        </div>
        
        <div class="quick-actions">
            <h3>Quick Actions</h3>
            <div class="action-buttons">
                <a href="book-appointment.jsp" class="action-btn">Book Appointment</a>
                <a href="view-prescriptions.jsp" class="action-btn">View Prescriptions</a>
                <a href="medical-history.jsp" class="action-btn">Medical History</a>
                <a href="update-profile.jsp" class="action-btn">Update Profile</a>
                <a href="contact-doctor.jsp" class="action-btn">Contact Doctor</a>
                <a href="download-reports.jsp" class="action-btn">Download Reports</a>
            </div>
        </div>
    </div>
</body>
</html> 