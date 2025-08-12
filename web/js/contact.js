// Contact.js - Modern Navbar and Contact Form Functionality
// Pahana BookShop

document.addEventListener('DOMContentLoaded', function() {
    
    // ===== NAVBAR FUNCTIONALITY =====
    
    // Navbar background change on scroll (for public, customer, and staff)
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.public-navbar, .customer-navbar, .staff-navbar');
        if (navbar) {
            if (window.scrollY > 50) {
                navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                navbar.style.backdropFilter = 'blur(10px)';
                navbar.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)';
            } else {
                navbar.style.background = 'white';
                navbar.style.backdropFilter = 'none';
                navbar.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)';
            }
        }
    });

    // Mobile navbar toggle functionality
    const navbarToggler = document.querySelector('.navbar-toggler');
    const navbarCollapse = document.querySelector('.navbar-collapse');
    
    if (navbarToggler && navbarCollapse) {
        navbarToggler.addEventListener('click', function() {
            navbarCollapse.classList.toggle('show');
        });
    }

    // Navbar link active state management
    const navLinks = document.querySelectorAll('.nav-link, .customer-nav-menu a');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            if (window.innerWidth <= 991) {
                const bootstrapCollapse = bootstrap.Collapse.getInstance(navbarCollapse);
                if (bootstrapCollapse) {
                    bootstrapCollapse.hide();
                }
                navbarCollapse.addEventListener('hidden.bs.collapse', function() {
                    navbarCollapse.classList.remove('show');
                });
            }
            
            navLinks.forEach(l => l.classList.remove('active'));
            if (!this.classList.contains('welcome-user') && !this.classList.contains('login-btn') && !this.classList.contains('customer-logout-btn')) {
                this.classList.add('active');
            }
        });
    });

    // ===== CONTACT FORM FUNCTIONALITY =====
    
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form data
            const formData = new FormData(this);
            const name = formData.get('name');
            const email = formData.get('email');
            const subject = formData.get('subject');
            const message = formData.get('message');
            
            // Enhanced validation
            if (!name || !email || !subject || !message) {
                showNotification('Please fill in all required fields.', 'error');
                return;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showNotification('Please enter a valid email address.', 'error');
                return;
            }
            
            // Name validation (minimum 2 characters)
            if (name.trim().length < 2) {
                showNotification('Name must be at least 2 characters long.', 'error');
                return;
            }
            
            // Subject validation (minimum 5 characters)
            if (subject.trim().length < 5) {
                showNotification('Subject must be at least 5 characters long.', 'error');
                return;
            }
            
            // Message validation (minimum 10 characters)
            if (message.trim().length < 10) {
                showNotification('Message must be at least 10 characters long.', 'error');
                return;
            }
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            submitBtn.textContent = 'Sending...';
            submitBtn.disabled = true;
            
            // Simulate form submission (replace with actual AJAX call)
            setTimeout(() => {
                showNotification('Thank you for your message! We will get back to you soon.', 'success');
                this.reset();
                
                // Reset button
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            }, 1500);
        });
    }

    // ===== FORM FIELD ENHANCEMENTS =====
    
    // Form field focus effects
    document.querySelectorAll('.form-group input, .form-group textarea, .form-group select').forEach(field => {
        field.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.style.boxShadow = '0 4px 12px rgba(99, 102, 241, 0.15)';
        });
        
        field.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
            this.parentElement.style.boxShadow = 'none';
        });
        
        // Real-time validation
        field.addEventListener('input', function() {
            validateField(this);
        });
    });

    // ===== NOTIFICATION SYSTEM =====
    
    function showNotification(message, type = 'info') {
        // Remove existing notifications
        const existingNotifications = document.querySelectorAll('.notification');
        existingNotifications.forEach(notification => notification.remove());
        
        // Create notification element
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle'}"></i>
                <span>${message}</span>
                <button class="notification-close">&times;</button>
            </div>
        `;
        
        // Add styles
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: ${type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#6366f1'};
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 10000;
            max-width: 400px;
            animation: slideInRight 0.3s ease-out;
        `;
        
        // Add to page
        document.body.appendChild(notification);
        
        // Close button functionality
        const closeBtn = notification.querySelector('.notification-close');
        closeBtn.addEventListener('click', () => {
            notification.remove();
        });
        
        // Auto-remove after 5 seconds
        setTimeout(() => {
            if (notification.parentNode) {
                notification.style.animation = 'slideOutRight 0.3s ease-in';
                setTimeout(() => notification.remove(), 300);
            }
        }, 5000);
    }

    // ===== FIELD VALIDATION =====
    
    function validateField(field) {
        const value = field.value.trim();
        const fieldName = field.name;
        let isValid = true;
        let errorMessage = '';
        
        switch (fieldName) {
            case 'name':
                if (value.length < 2) {
                    isValid = false;
                    errorMessage = 'Name must be at least 2 characters long.';
                }
                break;
            case 'email':
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    isValid = false;
                    errorMessage = 'Please enter a valid email address.';
                }
                break;
            case 'subject':
                if (value.length < 5) {
                    isValid = false;
                    errorMessage = 'Subject must be at least 5 characters long.';
                }
                break;
            case 'message':
                if (value.length < 10) {
                    isValid = false;
                    errorMessage = 'Message must be at least 10 characters long.';
                }
                break;
        }
        
        // Update field validation state
        updateFieldValidation(field, isValid, errorMessage);
    }
    
    function updateFieldValidation(field, isValid, errorMessage) {
        const formGroup = field.parentElement;
        const existingError = formGroup.querySelector('.field-error');
        
        if (!isValid) {
            if (!existingError) {
                const errorElement = document.createElement('div');
                errorElement.className = 'field-error';
                errorElement.style.cssText = `
                    color: #ef4444;
                    font-size: 0.875rem;
                    margin-top: 0.25rem;
                    animation: fadeIn 0.3s ease-out;
                `;
                errorElement.textContent = errorMessage;
                formGroup.appendChild(errorElement);
            } else {
                existingError.textContent = errorMessage;
            }
            field.style.borderColor = '#ef4444';
        } else {
            if (existingError) {
                existingError.remove();
            }
            field.style.borderColor = '#10b981';
        }
    }

    // ===== ANIMATIONS =====
    
    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .notification-content {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .notification-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.25rem;
            cursor: pointer;
            margin-left: auto;
            padding: 0;
            line-height: 1;
        }
        
        .notification-close:hover {
            opacity: 0.8;
        }
    `;
    document.head.appendChild(style);

    // ===== MOBILE SIDEBAR TOGGLE =====
    
    // Mobile sidebar toggle (for admin layouts only)
    function toggleSidebar() {
        const sidebar = document.querySelector('.admin-sidebar');
        if (sidebar) {
            sidebar.classList.toggle('open');
        }
    }
    
    // Make function globally available
    window.toggleSidebar = toggleSidebar;

    // ===== STAFF TAB FUNCTIONALITY =====
    
    // Staff tab activation
    document.querySelectorAll('.staff-tab').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.staff-tab').forEach(t => t.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // ===== SCROLL TO TOP FUNCTIONALITY =====
    
    // Add scroll to top button
    const scrollToTopBtn = document.createElement('button');
    scrollToTopBtn.innerHTML = '<i class="fas fa-arrow-up"></i>';
    scrollToTopBtn.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        background: linear-gradient(90deg, #6366f1, #8b5cf6);
        color: white;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        transition: all 0.3s ease;
        z-index: 1000;
        opacity: 0;
        visibility: hidden;
    `;
    
    document.body.appendChild(scrollToTopBtn);
    
    // Show/hide scroll to top button
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            scrollToTopBtn.style.opacity = '1';
            scrollToTopBtn.style.visibility = 'visible';
        } else {
            scrollToTopBtn.style.opacity = '0';
            scrollToTopBtn.style.visibility = 'hidden';
        }
    });
    
    // Scroll to top functionality
    scrollToTopBtn.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
    
    // Hover effects for scroll to top button
    scrollToTopBtn.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-3px)';
        this.style.boxShadow = '0 6px 20px rgba(99, 102, 241, 0.4)';
    });
    
    scrollToTopBtn.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
        this.style.boxShadow = '0 4px 12px rgba(99, 102, 241, 0.3)';
    });

    console.log('Contact.js loaded successfully! 🚀');
});
