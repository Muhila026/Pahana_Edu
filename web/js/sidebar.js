// ===== UNIFIED SIDEBAR FUNCTIONALITY FOR ALL PAGES =====

// Sidebar Management Class
class SidebarManager {
    constructor() {
        this.sidebar = document.querySelector('.admin-sidebar');
        this.overlay = null;
        this.toggleBtn = null;
        this.init();
    }

    init() {
        this.createOverlay();
        this.createToggleButton();
        this.bindEvents();
        this.setActiveMenuItem();
        // Removed automatic loading state
    }

    // Create overlay for mobile sidebar
    createOverlay() {
        this.overlay = document.createElement('div');
        this.overlay.className = 'sidebar-overlay';
        this.overlay.addEventListener('click', () => this.closeSidebar());
        document.body.appendChild(this.overlay);
    }

    // Create toggle button for mobile
    createToggleButton() {
        this.toggleBtn = document.createElement('button');
        this.toggleBtn.className = 'sidebar-toggle';
        this.toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
        this.toggleBtn.addEventListener('click', () => this.toggleSidebar());
        document.body.appendChild(this.toggleBtn);
    }

    // Bind all event listeners
    bindEvents() {
        // Close sidebar on escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                this.closeSidebar();
            }
        });

        // Handle window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 768) {
                this.closeSidebar();
            }
        });

        // Add hover effects to menu items
        const menuItems = document.querySelectorAll('.admin-sidebar-menu a');
        menuItems.forEach(item => {
            item.addEventListener('mouseenter', this.handleMenuItemHover.bind(this));
            item.addEventListener('mouseleave', this.handleMenuItemLeave.bind(this));
        });
    }

    // Toggle sidebar open/close
    toggleSidebar() {
        if (this.sidebar.classList.contains('open')) {
            this.closeSidebar();
        } else {
            this.openSidebar();
        }
    }

    // Open sidebar
    openSidebar() {
        this.sidebar.classList.add('open');
        this.overlay.classList.add('active');
        this.sidebar.classList.add('sidebar-fade-in');
        document.body.style.overflow = 'hidden';
        
        // Update toggle button
        this.toggleBtn.innerHTML = '<i class="fas fa-times"></i>';
        this.toggleBtn.style.background = '#ef4444';
    }

    // Close sidebar
    closeSidebar() {
        this.sidebar.classList.remove('open');
        this.overlay.classList.remove('active');
        this.sidebar.classList.remove('sidebar-fade-in');
        document.body.style.overflow = '';
        
        // Update toggle button
        this.toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
        this.toggleBtn.style.background = '#6366f1';
    }

    // Handle menu item hover
    handleMenuItemHover(e) {
        const item = e.currentTarget;
        const icon = item.querySelector('i');
        
        if (icon) {
            icon.style.transform = 'scale(1.2) rotate(5deg)';
        }
    }

    // Handle menu item leave
    handleMenuItemLeave(e) {
        const item = e.currentTarget;
        const icon = item.querySelector('i');
        
        if (icon) {
            icon.style.transform = 'scale(1) rotate(0deg)';
        }
    }

    // Set active menu item based on current page
    setActiveMenuItem() {
        const currentPath = window.location.pathname;
        const currentPage = currentPath.split('/').pop(); // Get just the filename
        const menuItems = document.querySelectorAll('.admin-sidebar-menu a');
        
        // First, remove all active classes
        menuItems.forEach(item => {
            item.classList.remove('active');
        });
        
        // Special handling for POS page
        if (currentPage === 'pos.jsp') {
            // Find and mark the POS menu item as active
            menuItems.forEach(item => {
                if (item.textContent.trim().includes('Point of Sale')) {
                    item.classList.add('active');
                    return;
                }
            });
            return;
        }
        
        // For other pages, find the exact match and mark it as active
        menuItems.forEach(item => {
            const href = item.getAttribute('href');
            if (href) {
                const hrefPage = href.split('/').pop().split('?')[0]; // Get filename without query params
                
                // Exact match for the current page
                if (hrefPage === currentPage) {
                    item.classList.add('active');
                    return; // Found the match, no need to continue
                }
            }
        });
    }

    // Manually set a specific menu item as active
    setSpecificMenuItemActive(menuText) {
        const menuItems = document.querySelectorAll('.admin-sidebar-menu a');
        
        // First, remove all active classes
        menuItems.forEach(item => {
            item.classList.remove('active');
        });
        
        // Then, find the menu item with the specified text and mark it as active
        menuItems.forEach(item => {
            if (item.textContent.trim().includes(menuText)) {
                item.classList.add('active');
                return;
            }
        });
    }

    // Add loading state to sidebar
    addLoadingState() {
        // Simulate loading for demonstration
        this.sidebar.classList.add('loading');
        
        setTimeout(() => {
            this.sidebar.classList.remove('loading');
        }, 1000);
    }

    // Refresh sidebar content
    refreshSidebar(showLoading = false) {
        if (showLoading) {
            this.sidebar.classList.add('loading');
            
            // Simulate refresh delay
            setTimeout(() => {
                this.sidebar.classList.remove('loading');
                this.setActiveMenuItem();
            }, 800);
        } else {
            // Just refresh without loading state
            this.setActiveMenuItem();
        }
    }

    // Clear loading state
    clearLoadingState() {
        this.sidebar.classList.remove('loading');
    }

    // Add new menu item dynamically
    addMenuItem(text, href, icon, position = 'end') {
        const menu = document.querySelector('.admin-sidebar-menu');
        const newItem = document.createElement('li');
        
        newItem.innerHTML = `
            <a href="${href}">
                <i class="fas fa-${icon}"></i>
                ${text}
            </a>
        `;
        
        if (position === 'start') {
            menu.insertBefore(newItem, menu.firstChild);
        } else {
            menu.appendChild(newItem);
        }
        
        // Bind events to new item
        const link = newItem.querySelector('a');
        link.addEventListener('mouseenter', this.handleMenuItemHover.bind(this));
        link.addEventListener('mouseleave', this.handleMenuItemLeave.bind(this));
    }

    // Remove menu item by text
    removeMenuItem(text) {
        const menuItems = document.querySelectorAll('.admin-sidebar-menu a');
        menuItems.forEach(item => {
            if (item.textContent.trim() === text) {
                item.parentElement.remove();
            }
        });
    }

    // Update sidebar header
    updateHeader(title, subtitle) {
        const header = document.querySelector('.admin-sidebar-header');
        if (header) {
            const titleEl = header.querySelector('h2');
            const subtitleEl = header.querySelector('p');
            
            if (titleEl) titleEl.textContent = title;
            if (subtitleEl) subtitleEl.textContent = subtitle;
        }
    }

    // Change sidebar theme
    changeTheme(theme) {
        const themes = {
            'default': {
                background: 'linear-gradient(135deg, #6366f1 0%, #4f46e5 100%)',
                accent: '#fbbf24',
                scrollbar: '#a855f7'
            },
            'dark': {
                background: 'linear-gradient(135deg, #1f2937 0%, #111827 100%)',
                accent: '#10b981',
                scrollbar: '#6b7280'
            },
            'ocean': {
                background: 'linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%)',
                accent: '#f59e0b',
                scrollbar: '#06b6d4'
            }
        };
        
        if (themes[theme]) {
            const themeData = themes[theme];
            this.sidebar.style.background = themeData.background;
            
            // Update CSS custom properties
            document.documentElement.style.setProperty('--sidebar-accent', themeData.accent);
            document.documentElement.style.setProperty('--sidebar-scrollbar', themeData.scrollbar);
        }
    }
}

// Initialize sidebar when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Check if sidebar exists on the page
    if (document.querySelector('.admin-sidebar')) {
        window.sidebarManager = new SidebarManager();
        
        // Add some example functionality
        console.log('Sidebar Manager initialized');
        
        // Example: Change theme after 3 seconds
        setTimeout(() => {
            // window.sidebarManager.changeTheme('ocean');
        }, 3000);
    }
});

// Utility functions for sidebar management
window.SidebarUtils = {
    // Toggle sidebar from external code
    toggle: function() {
        if (window.sidebarManager) {
            window.sidebarManager.toggleSidebar();
        }
    },
    
    // Add menu item from external code
    addMenuItem: function(text, href, icon, position) {
        if (window.sidebarManager) {
            window.sidebarManager.addMenuItem(text, href, icon, position);
        }
    },
    
    // Remove menu item from external code
    removeMenuItem: function(text) {
        if (window.sidebarManager) {
            window.sidebarManager.removeMenuItem(text);
        }
    },
    
    // Update header from external code
    updateHeader: function(title, subtitle) {
        if (window.sidebarManager) {
            window.sidebarManager.updateHeader(title, subtitle);
        }
    },
    
    // Change theme from external code
    changeTheme: function(theme) {
        if (window.sidebarManager) {
            window.sidebarManager.changeTheme(theme);
        }
    },
    
    // Set specific menu item as active from external code
    setActiveMenuItem: function(menuText) {
        if (window.sidebarManager) {
            window.sidebarManager.setSpecificMenuItemActive(menuText);
        }
    },
    
    // Clear loading state from external code
    clearLoading: function() {
        if (window.sidebarManager) {
            window.sidebarManager.clearLoadingState();
        }
    }
};

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = SidebarManager;
}
