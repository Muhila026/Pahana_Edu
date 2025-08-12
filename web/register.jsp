<%-- 
    Document   : register
    Created on : Aug 4, 2025, 4:08:51?PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Pahana BookShop</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #6366f1;
            --primary-hover: #4f46e5;
            --secondary-color: #64748b;
            --success-color: #10b981;
            --error-color: #ef4444;
            --background-color: #f8fafc;
            --card-background: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-container {
            background: var(--card-background);
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            width: 100%;
            max-width: 550px;
            position: relative;
        }

        .register-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .register-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .register-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .register-header p {
            font-size: 1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .register-body {
            padding: 40px 30px;
        }

        .form-floating {
            margin-bottom: 20px;
            position: relative;
        }

        .form-floating .form-control {
            border: 2px solid var(--border-color);
            border-radius: 12px;
            padding: 16px 20px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8fafc;
        }

        .form-floating .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background: white;
        }

        .form-floating label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .password-field {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 5px;
            transition: color 0.3s ease;
            z-index: 10;
        }

        .password-toggle:hover {
            color: var(--primary-color);
        }

        .btn-register {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            border: none;
            border-radius: 12px;
            padding: 16px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-register:hover::before {
            left: 100%;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.3);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 16px 20px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            color: var(--error-color);
            border-left: 4px solid var(--error-color);
        }

        .required {
            color: var(--error-color);
            font-weight: 600;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 576px) {
            .register-container {
                margin: 10px;
                border-radius: 15px;
            }
            
            .register-header {
                padding: 30px 20px;
            }
            
            .register-header h1 {
                font-size: 2rem;
            }
            
            .register-body {
                padding: 30px 20px;
            }
        }

        /* Loading Animation */
        .btn-loading {
            position: relative;
            color: transparent;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Input Focus Effects */
        .form-floating .form-control:focus + label {
            color: var(--primary-color);
        }

        /* Floating Label Animation */
        .form-floating .form-control:not(:placeholder-shown) + label,
        .form-floating .form-control:focus + label {
            transform: scale(0.85) translateY(-1rem) translateX(0.15rem);
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <div class="register-container">
        <!-- Header Section -->
        <div class="register-header">
            <h1><i class="fas fa-user-plus me-2"></i>Create Account</h1>
            <p>Join Pahana BookShop and start your reading journey</p>
        </div>

        <!-- Body Section -->
        <div class="register-body">
            <!-- Error Messages -->
            <%
            String error = request.getParameter("error");
            if (error != null && !error.isEmpty()) {
            %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= error %>
                </div>
            <%
            }
            %>

            <!-- Registration Form -->
            <form id="registrationForm" action="SignupServlet" method="POST">
                <div class="form-floating">
                    <input type="text" class="form-control" id="name" name="name" 
                           placeholder="Full Name" required>
                    <label for="name">
                        <i class="fas fa-user me-2"></i>Full Name <span class="required">*</span>
                    </label>
                </div>

                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Email Address" required>
                    <label for="email">
                        <i class="fas fa-envelope me-2"></i>Email Address <span class="required">*</span>
                    </label>
                </div>

                <div class="form-floating">
                    <input type="tel" class="form-control" id="telephone" name="telephone" 
                           placeholder="Phone Number" required>
                    <label for="telephone">
                        <i class="fas fa-phone me-2"></i>Phone Number <span class="required">*</span>
                    </label>
                </div>

                <div class="form-floating">
                    <input type="text" class="form-control" id="address" name="address" 
                           placeholder="Address" required>
                    <label for="address">
                        <i class="fas fa-map-marker-alt me-2"></i>Address <span class="required">*</span>
                    </label>
                </div>

                <div class="form-floating password-field">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Password" required>
                    <label for="password">
                        <i class="fas fa-lock me-2"></i>Password <span class="required">*</span>
                    </label>
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>

                <button type="submit" class="btn btn-register" id="registerBtn">
                    <i class="fas fa-user-plus me-2"></i>Create Account
                </button>
            </form>

            <!-- Login Link -->
            <div class="login-link">
                <p>Already have an account? 
                    <a href="login.jsp">Sign in here</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Password Toggle Functionality
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleBtn = document.querySelector('.password-toggle i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleBtn.classList.remove('fa-eye');
                toggleBtn.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleBtn.classList.remove('fa-eye-slash');
                toggleBtn.classList.add('fa-eye');
            }
        }

                 // Form Submission with Loading State
         document.getElementById('registrationForm').addEventListener('submit', function(e) {
             // Client-side validation
             var name = document.getElementById('name').value.trim();
             var email = document.getElementById('email').value.trim();
             var telephone = document.getElementById('telephone').value.trim();
             var address = document.getElementById('address').value.trim();
             var password = document.getElementById('password').value.trim();
             
             if (!name || !email || !telephone || !address || !password) {
                 e.preventDefault();
                 showAlert('Please fill in all required fields!', 'danger');
                 return false;
             }
             
             // Basic email validation
             if (email.indexOf('@') === -1 || email.indexOf('.') === -1) {
                 e.preventDefault();
                 showAlert('Please enter a valid email address!', 'danger');
                 return false;
             }
             
             // Password length validation
             if (password.length < 3) {
                 e.preventDefault();
                 showAlert('Password must be at least 3 characters long!', 'danger');
                 return false;
             }

             // If validation passes, show loading state
             var registerBtn = document.getElementById('registerBtn');
             var originalText = registerBtn.innerHTML;
             
             registerBtn.classList.add('btn-loading');
             registerBtn.disabled = true;
             
             // Form will submit normally
             console.log('Form validation passed, submitting...');
         });

                 // Show Alert Function
         function showAlert(message, type) {
             // Remove existing alerts
             const existingAlert = document.querySelector('.alert');
             if (existingAlert) {
                 existingAlert.remove();
             }

             // Create new alert
             const alertDiv = document.createElement('div');
             alertDiv.className = 'alert alert-' + type;
             
             // Set icon based on type
             var iconClass = 'exclamation-circle';
             if (type === 'success') {
                 iconClass = 'check-circle';
             }
             
             alertDiv.innerHTML = '<i class="fas fa-' + iconClass + ' me-2"></i>' + message;

             // Insert alert before the form
             const form = document.getElementById('registrationForm');
             form.parentNode.insertBefore(alertDiv, form);

             // Auto-hide alert after 5 seconds
             setTimeout(function() {
                 alertDiv.style.opacity = '0';
                 setTimeout(function() {
                     alertDiv.remove();
                 }, 300);
             }, 5000);
         }

                 // Input Focus Effects
         var inputs = document.querySelectorAll('.form-control');
         for (var i = 0; i < inputs.length; i++) {
             var input = inputs[i];
             input.addEventListener('focus', function() {
                 this.parentElement.classList.add('focused');
             });
             
             input.addEventListener('blur', function() {
                 if (!this.value) {
                     this.parentElement.classList.remove('focused');
                 }
             });
         }

         // Add smooth animations
         document.addEventListener('DOMContentLoaded', function() {
             var registerContainer = document.querySelector('.register-container');
             registerContainer.style.opacity = '0';
             registerContainer.style.transform = 'translateY(20px)';
             
             setTimeout(function() {
                 registerContainer.style.transition = 'all 0.6s ease';
                 registerContainer.style.opacity = '1';
                 registerContainer.style.transform = 'translateY(0)';
             }, 100);
         });
    </script>
</body>
</html>