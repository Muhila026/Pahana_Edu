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
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }

        .required {
            color: var(--danger-color);
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
        
        /* New Form Styling for Add Customer Design */
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .input-group .btn {
            border-left: none;
        }
        
        .input-group .form-control {
            border-right: none;
        }
        
        .input-group .form-control:focus {
            border-right: 1px solid var(--primary-color);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }
        
        .alert {
            margin-bottom: 1rem;
        }
        
        /* Username field specific styling */
        #username {
            text-transform: lowercase;
        }
        
        /* Form layout improvements */
        .row {
            margin-left: -0.5rem;
            margin-right: -0.5rem;
        }
        
        .col-md-6 {
            padding-left: 0.5rem;
            padding-right: 0.5rem;
        }
        
        /* Button spacing */
        .gap-2 > * {
            margin-left: 0.5rem;
        }
        
        .gap-2 > *:first-child {
            margin-left: 0;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <!-- Header Section -->
        <div class="register-header">
            <h1><i class="fas fa-user-plus me-2"></i>Add New Customer</h1>
            <p>Create a new customer account with full access to our services</p>
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
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label for="name" class="form-label">
                                <i class="fas fa-user me-2"></i>Customer Name <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   placeholder="Enter customer name" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label for="telephone" class="form-label">
                                <i class="fas fa-phone me-2"></i>Phone Number <span class="required">*</span>
                            </label>
                            <input type="tel" class="form-control" id="telephone" name="telephone" 
                                   placeholder="Enter phone number" required>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label for="address" class="form-label">
                        <i class="fas fa-map-marker-alt me-2"></i>Address <span class="required">*</span>
                    </label>
                    <textarea class="form-control" id="address" name="address" 
                              placeholder="Enter customer address" rows="3" required></textarea>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label for="username" class="form-label">
                                <i class="fas fa-user me-2"></i>Username <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   placeholder="Enter username" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-2"></i>Email <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Enter email address" required>
                                <button type="button" class="btn btn-outline-primary" onclick="validateEmail()">
                                    <i class="fas fa-envelope"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock me-2"></i>Password <span class="required">*</span>
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Enter password" required>
                        <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                    <button type="button" class="btn btn-secondary" onclick="clearForm()">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-primary" id="registerBtn">
                        <i class="fas fa-plus me-2"></i>Add Customer
                    </button>
                </div>
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
        
        // Email Validation Function
        function validateEmail() {
            const emailInput = document.getElementById('email');
            const email = emailInput.value.trim();
            
            if (email && email.match(/^[A-Za-z0-9+_.-]+@(.+)$/)) {
                showAlert('Email format is valid!', 'success');
            } else {
                showAlert('Please enter a valid email address!', 'warning');
            }
        }
        
        // Clear Form Function
        function clearForm() {
            document.getElementById('registrationForm').reset();
            showAlert('Form cleared successfully!', 'info');
        }
        
        // Email Validation Function
        function validateEmail() {
            const emailInput = document.getElementById('email');
            const email = emailInput.value.trim();
            
            if (email && email.match(/^[A-Za-z0-9+_.-]+@(.+)$/)) {
                showAlert('Email format is valid!', 'success');
            } else {
                showAlert('Please enter a valid email address!', 'warning');
            }
        }
        
        // Clear Form Function
        function clearForm() {
            document.getElementById('registrationForm').reset();
            showAlert('Form cleared successfully!', 'info');
        }
        
        // Show Alert Function
        function showAlert(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
            alertDiv.innerHTML = `
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            
            const form = document.getElementById('registrationForm');
            form.parentNode.insertBefore(alertDiv, form);
            
            // Auto-dismiss after 5 seconds
            setTimeout(() => {
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }

                 // Form Submission with Loading State
         document.getElementById('registrationForm').addEventListener('submit', function(e) {
             // Client-side validation
             var name = document.getElementById('name').value.trim();
             var username = document.getElementById('username').value.trim();
             var email = document.getElementById('email').value.trim();
             var telephone = document.getElementById('telephone').value.trim();
             var address = document.getElementById('address').value.trim();
             var password = document.getElementById('password').value.trim();
             
             if (!name || !username || !email || !telephone || !address || !password) {
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