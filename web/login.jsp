<%-- 
    Document   : login
    Created on : Aug 4, 2025, 4:00:06 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            .login-container {
                max-width: 400px;
                margin: 100px auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"], input[type="password"], select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .btn {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
            }
            .btn:hover {
                background-color: #45a049;
            }
            .error {
                color: red;
                margin-bottom: 15px;
                padding: 10px;
                background-color: #ffe6e6;
                border-radius: 4px;
            }
            .success {
                color: green;
                margin-bottom: 15px;
                padding: 10px;
                background-color: #e6ffe6;
                border-radius: 4px;
            }
            .user-type-info {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
                font-size: 14px;
                color: #666;
            }
            
            .password-container {
                position: relative;
            }
            
            .password-toggle {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
                color: #666;
                font-size: 16px;
                padding: 0;
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .password-toggle:hover {
                color: #4CAF50;
            }
            
            .password-container input[type="password"],
            .password-container input[type="text"] {
                padding-right: 35px;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <% if (request.getParameter("message") != null) { %>
                <div class="success">
                    <%= request.getParameter("message") %>
                </div>
            <% } %>
            
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="username">Username/Email:</label>
                    <input type="text" id="username" name="username" required placeholder="Enter your username or email">
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <div class="password-container">
                        <input type="password" id="password" name="password" required>
                        <button type="button" class="password-toggle" onclick="togglePasswordVisibility('password')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="btn">Login</button>
            </form>
            
            <p style="text-align: center; margin-top: 20px; color: #666;">
                Enter your username/email and password to login
            </p>
            
            <p style="text-align: center; margin-top: 15px;">
                Don't have an account? <a href="register.jsp" style="color: #4CAF50; text-decoration: none; font-weight: bold;">Register here</a>
            </p>
        </div>

        <script>
            function togglePasswordVisibility(inputId) {
                const input = document.getElementById(inputId);
                const icon = input.parentElement.querySelector('.password-toggle i');
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }
        </script>
    </body>
</html>

