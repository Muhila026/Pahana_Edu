<%-- 
    Document   : patient
    Created on : Aug 4, 2025, 4:18:28 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Registration Success</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f, #1a2a6c);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #28a745, #20c997, #28a745);
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 40px;
        }
        
        .header h1 {
            color: #28a745;
            font-size: 28px;
            margin-bottom: 15px;
        }
        
        .header p {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        }
        
        .message {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .btn {
            display: inline-block;
            background: linear-gradient(135deg, #0066cc, #0099cc);
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            margin: 0 10px;
        }
        
        .btn:hover {
            background: linear-gradient(135deg, #0052a3, #0077b3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 102, 204, 0.3);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #495057);
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268, #343a40);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <div class="header">
            <h1>Registration Successful!</h1>
            <p>Your patient account has been created successfully.</p>
        </div>
        
        <% 
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
        %>
            <div class="message">
                <%= message %>
            </div>
        <% } %>
        
        <div class="actions">
            <a href="login.jsp" class="btn">Login Now</a>
            <a href="register.jsp" class="btn btn-secondary">Register Another Patient</a>
        </div>
    </div>
</body>
</html> 
