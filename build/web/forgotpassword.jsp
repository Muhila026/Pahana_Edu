<%-- 
    Document   : forgotpassword
    Created on : Aug 15, 2025, 2:52:41 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password - BookShop</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

            * { margin: 0; padding: 0; box-sizing: border-box; }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .container-card {
                background: var(--card-background);
                border-radius: 20px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                overflow: hidden;
                width: 100%;
                max-width: 520px;
                position: relative;
            }

            .card-header {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
                color: white;
                padding: 40px 30px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .card-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: float 6s ease-in-out infinite;
            }

            @keyframes float { 0%, 100% { transform: translateY(0) rotate(0); } 50% { transform: translateY(-20px) rotate(180deg); } }

            .card-header h1 { font-size: 2rem; font-weight: 700; margin-bottom: 10px; position: relative; z-index: 1; }
            .card-header p { font-size: 1rem; opacity: 0.95; position: relative; z-index: 1; }

            .card-body { padding: 40px 30px; }

            .form-floating { margin-bottom: 20px; position: relative; }
            .form-floating .form-control {
                border: 2px solid var(--border-color);
                border-radius: 12px;
                padding: 16px 20px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: #f8fafc;
            }
            .form-floating .form-control:focus { border-color: var(--primary-color); box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1); background: white; }
            .form-floating label { color: var(--text-secondary); font-weight: 500; }

            .password-field { position: relative; }
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
            .password-toggle:hover { color: var(--primary-color); }

            .btn-primary-gradient {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
                border: none; border-radius: 12px; padding: 14px 16px; font-size: 16px; font-weight: 600; color: white; width: 100%; transition: all 0.3s ease; position: relative; overflow: hidden;
            }
            .btn-primary-gradient::before { content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent); transition: left 0.5s; }
            .btn-primary-gradient:hover::before { left: 100%; }
            .btn-primary-gradient:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(99, 102, 241, 0.3); }

            .btn-outline { border-radius: 12px; padding: 12px 14px; font-weight: 600; }

            .alert { border-radius: 12px; border: none; padding: 16px 20px; margin-bottom: 20px; font-weight: 500; }
            .alert-danger { background: linear-gradient(135deg, #fef2f2, #fee2e2); color: var(--danger-color); border-left: 4px solid var(--danger-color); }
            .alert-success { background: linear-gradient(135deg, #f0fdf4, #dcfce7); color: var(--success-color); border-left: 4px solid var(--success-color); }

            .muted { color: var(--text-secondary); font-size: 14px; }
            .link { color: var(--primary-color); text-decoration: none; font-weight: 600; }
            .link:hover { color: var(--primary-hover); text-decoration: underline; }

            .step { display: none; }
            .step.active { display: block; }

            .timer { font-variant-numeric: tabular-nums; }

            @media (max-width: 576px) {
                .container-card { margin: 10px; border-radius: 15px; }
                .card-header { padding: 30px 20px; }
                .card-header h1 { font-size: 1.75rem; }
                .card-body { padding: 30px 20px; }
            }

            .btn-loading { position: relative; color: transparent !important; }
            .btn-loading::after {
                content: '';
                position: absolute;
                width: 20px; height: 20px; top: 50%; left: 50%; margin-left: -10px; margin-top: -10px;
                border: 2px solid transparent; border-top: 2px solid white; border-radius: 50%;
                animation: spin 1s linear infinite;
            }
            @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        </style>
    </head>
    <body>
        <div class="container-card">
            <div class="card-header">
                <h1>Forgot Password</h1>
                <p>We will send a verification code to your email</p>
            </div>

            <div class="card-body">
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <%= request.getAttribute("success") %>
                </div>
                <% } %>

                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <%= request.getParameter("message") %>
                </div>
                <% } %>

                <div id="stepRequest" class="step active">
                    <form id="requestForm" action="ForgotPasswordServlet" method="post">
                        <input type="hidden" name="action" value="requestCode">
                        <div class="form-floating">
                            <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                            <label for="email"><i class="fas fa-envelope me-2"></i>Email address</label>
                        </div>

                        <button type="submit" id="sendCodeBtn" class="btn btn-primary-gradient">
                            <i class="fas fa-paper-plane me-2"></i>Send Verification Code
                        </button>

                        <div class="mt-3 text-center">
                            <a href="login.jsp" class="link"><i class="fas fa-arrow-left me-1"></i>Back to Sign In</a>
                        </div>
                    </form>
                </div>

                <div id="stepVerify" class="step">
                    <form id="resetForm" action="ForgotPasswordServlet" method="post">
                        <input type="hidden" name="action" value="resetPassword">
                        <div class="form-floating mb-2">
                            <input type="email" class="form-control" id="emailReadonly" name="email" placeholder="name@example.com" readonly>
                            <label for="emailReadonly"><i class="fas fa-envelope me-2"></i>Email address</label>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="muted">Enter the 6-digit code sent to your email</span>
                            <button type="button" id="resendBtn" class="btn btn-sm btn-outline-secondary btn-outline" disabled>
                                Resend code <span id="resendTimer" class="timer">60</span>s
                            </button>
                        </div>

                        <div class="form-floating">
                            <input type="text" class="form-control" id="code" name="code" placeholder="123456" maxlength="6" pattern="[0-9]{6}" required>
                            <label for="code"><i class="fas fa-key me-2"></i>Verification code</label>
                        </div>

                        <div class="form-floating password-field">
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="New Password" minlength="6" required>
                            <label for="newPassword"><i class="fas fa-lock me-2"></i>New password</label>
                            <button type="button" class="password-toggle" data-target="newPassword"><i class="fas fa-eye"></i></button>
                        </div>

                        <div class="form-floating password-field">
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" minlength="6" required>
                            <label for="confirmPassword"><i class="fas fa-lock me-2"></i>Confirm new password</label>
                            <button type="button" class="password-toggle" data-target="confirmPassword"><i class="fas fa-eye"></i></button>
                        </div>

                        <button type="submit" id="resetBtn" class="btn btn-primary-gradient">
                            <i class="fas fa-rotate me-2"></i>Reset Password
                        </button>

                        <div class="mt-3 text-center">
                            <a href="#" id="changeEmail" class="link"><i class="fas fa-arrow-left me-1"></i>Change email</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            const stepRequest = document.getElementById('stepRequest');
            const stepVerify = document.getElementById('stepVerify');
            const requestForm = document.getElementById('requestForm');
            const resetForm = document.getElementById('resetForm');
            const emailInput = document.getElementById('email');
            const emailReadonly = document.getElementById('emailReadonly');
            const sendCodeBtn = document.getElementById('sendCodeBtn');
            const resetBtn = document.getElementById('resetBtn');
            const resendBtn = document.getElementById('resendBtn');
            const resendTimer = document.getElementById('resendTimer');
            const changeEmail = document.getElementById('changeEmail');

            function togglePassword(button) {
                const targetId = button.getAttribute('data-target');
                const input = document.getElementById(targetId);
                const icon = button.querySelector('i');
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

            document.querySelectorAll('.password-toggle').forEach(btn => {
                btn.addEventListener('click', function () { togglePassword(this); });
            });

            let countdownInterval;
            function startResendCountdown(seconds) {
                let remaining = seconds;
                resendBtn.disabled = true;
                resendTimer.textContent = remaining;
                clearInterval(countdownInterval);
                countdownInterval = setInterval(() => {
                    remaining -= 1;
                    resendTimer.textContent = remaining;
                    if (remaining <= 0) {
                        clearInterval(countdownInterval);
                        resendBtn.disabled = false;
                        resendTimer.textContent = '0';
                    }
                }, 1000);
            }

            requestForm.addEventListener('submit', function (e) {
                e.preventDefault();
                const email = emailInput.value.trim();
                if (!email) return;

                sendCodeBtn.classList.add('btn-loading');
                sendCodeBtn.disabled = true;

                // First, check if email exists in system (customers or users) via CustomerServlet
                const checkXhr = new XMLHttpRequest();
                checkXhr.open('POST', 'CustomerServlet?action=check-email-exists', true);
                checkXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                checkXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                checkXhr.onreadystatechange = function () {
                    if (checkXhr.readyState === 4) {
                        try {
                            const resp = JSON.parse(checkXhr.responseText || '{}');
                            if (checkXhr.status === 200 && resp.status === 'success' && resp.exists) {
                                // Send verification code
                                const sendXhr = new XMLHttpRequest();
                                sendXhr.open('POST', 'CustomerServlet?action=send-verification', true);
                                sendXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                sendXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                                sendXhr.onreadystatechange = function () {
                                    if (sendXhr.readyState === 4) {
                                        sendCodeBtn.classList.remove('btn-loading');
                                        sendCodeBtn.disabled = false;
                                        if (sendXhr.status === 200) {
                                            try {
                                                const s = JSON.parse(sendXhr.responseText || '{}');
                                                if (s.status === 'success') {
                                                    // Move to verify step
                                                    emailReadonly.value = email;
                                                    stepRequest.classList.remove('active');
                                                    stepVerify.classList.add('active');
                                                    startResendCountdown(60);
                                                } else {
                                                    showInlineAlert(stepRequest, s.message || 'Failed to send verification code', 'danger');
                                                }
                                            } catch (_) {
                                                // Fallback assume success
                                                emailReadonly.value = email;
                                                stepRequest.classList.remove('active');
                                                stepVerify.classList.add('active');
                                                startResendCountdown(60);
                                            }
                                        } else {
                                            showInlineAlert(stepRequest, 'Failed to send verification code. Please try again.', 'danger');
                                        }
                                    }
                                };
                                sendXhr.send('email=' + encodeURIComponent(email) + '&context=forgot-password');
                            } else {
                                sendCodeBtn.classList.remove('btn-loading');
                                sendCodeBtn.disabled = false;
                                showInlineAlert(stepRequest, 'This email is not registered.', 'danger');
                            }
                        } catch (err) {
                            sendCodeBtn.classList.remove('btn-loading');
                            sendCodeBtn.disabled = false;
                            showInlineAlert(stepRequest, 'System error. Please try again.', 'danger');
                        }
                    }
                };
                checkXhr.onerror = function () {
                    sendCodeBtn.classList.remove('btn-loading');
                    sendCodeBtn.disabled = false;
                    showInlineAlert(stepRequest, 'Network error. Please try again.', 'danger');
                };
                checkXhr.send('email=' + encodeURIComponent(email));
            });

            resendBtn.addEventListener('click', function () {
                const email = emailReadonly.value.trim();
                if (!email) return;
                resendBtn.classList.add('btn-loading');
                resendBtn.disabled = true;
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=send-verification', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        resendBtn.classList.remove('btn-loading');
                        if (xhr.status === 200) {
                            startResendCountdown(60);
                        } else {
                            showInlineAlert(stepVerify, 'Failed to resend code. Try again.', 'danger');
                            resendBtn.disabled = false;
                        }
                    }
                };
                xhr.onerror = function () {
                    resendBtn.classList.remove('btn-loading');
                    showInlineAlert(stepVerify, 'Network error. Try again.', 'danger');
                    resendBtn.disabled = false;
                };
                xhr.send('email=' + encodeURIComponent(email) + '&context=forgot-password');
            });

            changeEmail.addEventListener('click', function (e) {
                e.preventDefault();
                stepVerify.classList.remove('active');
                stepRequest.classList.add('active');
            });

            resetForm.addEventListener('submit', function (e) {
                e.preventDefault();
                const email = emailReadonly.value.trim();
                const code = document.getElementById('code').value.trim();
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                if (!email || !code) {
                    showInlineAlert(resetForm, 'Please enter the verification code.', 'danger');
                    return;
                }
                if (!newPassword || !confirmPassword) {
                    showInlineAlert(resetForm, 'Please fill in both password fields.', 'danger');
                    return;
                }
                if (newPassword !== confirmPassword) {
                    showInlineAlert(resetForm, 'Passwords do not match.', 'danger');
                    return;
                }
                resetBtn.classList.add('btn-loading');
                resetBtn.disabled = true;

                // Step 1: verify code
                const verifyXhr = new XMLHttpRequest();
                verifyXhr.open('POST', 'CustomerServlet?action=verify-email', true);
                verifyXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                verifyXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                verifyXhr.onreadystatechange = function () {
                    if (verifyXhr.readyState === 4) {
                        if (verifyXhr.status === 200) {
                            let ok = false;
                            try {
                                const resp = JSON.parse(verifyXhr.responseText || '{}');
                                ok = resp.status === 'success' || resp.success === true;
                            } catch (_) {}
                            if (ok) {
                                // Step 2: reset password
                                const resetXhr = new XMLHttpRequest();
                                resetXhr.open('POST', 'CustomerServlet?action=reset-password', true);
                                resetXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                resetXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                                resetXhr.onreadystatechange = function () {
                                    if (resetXhr.readyState === 4) {
                                        resetBtn.classList.remove('btn-loading');
                                        resetBtn.disabled = false;
                                        if (resetXhr.status === 200) {
                                            try {
                                                const r = JSON.parse(resetXhr.responseText || '{}');
                                                if (r.status === 'success') {
                                                    showInlineAlert(resetForm, 'Password reset successfully! Redirecting to login...', 'success');
                                                    setTimeout(() => { window.location.href = 'login.jsp'; }, 1500);
                                                } else {
                                                    showInlineAlert(resetForm, r.message || 'Failed to reset password.', 'danger');
                                                }
                                            } catch (_) {
                                                showInlineAlert(resetForm, 'Password reset successfully! Redirecting to login...', 'success');
                                                setTimeout(() => { window.location.href = 'login.jsp'; }, 1500);
                                            }
                                        } else {
                                            showInlineAlert(resetForm, 'Failed to reset password. Please try again.', 'danger');
                                        }
                                    }
                                };
                                resetXhr.send('email=' + encodeURIComponent(email) + '&newPassword=' + encodeURIComponent(newPassword));
                            } else {
                                resetBtn.classList.remove('btn-loading');
                                resetBtn.disabled = false;
                                showInlineAlert(resetForm, 'Invalid verification code.', 'danger');
                            }
                        } else {
                            resetBtn.classList.remove('btn-loading');
                            resetBtn.disabled = false;
                            showInlineAlert(resetForm, 'Failed to verify code. Please try again.', 'danger');
                        }
                    }
                };
                verifyXhr.onerror = function () {
                    resetBtn.classList.remove('btn-loading');
                    resetBtn.disabled = false;
                    showInlineAlert(resetForm, 'Network error during verification. Please try again.', 'danger');
                };
                verifyXhr.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code));
            });

            setTimeout(() => {
                document.querySelectorAll('.alert').forEach(el => {
                    el.style.opacity = '0';
                    setTimeout(() => el.remove(), 300);
                });
            }, 5000);

            document.addEventListener('DOMContentLoaded', function () {
                const card = document.querySelector('.container-card');
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100);
            });

            function showInlineAlert(container, message, type) {
                const div = document.createElement('div');
                div.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger');
                div.innerHTML = (type === 'success' ? '<i class="fas fa-check-circle me-2"></i>' : '<i class="fas fa-exclamation-circle me-2"></i>') + message;
                container.prepend(div);
                setTimeout(() => { div.remove(); }, 4000);
            }
        </script>
    </body>
</html>
