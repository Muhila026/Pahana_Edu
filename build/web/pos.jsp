<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Point of Sale - Pahana BookShop</title>
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
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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

        /* Sidebar styles are now in css/sidebar.css */

        /* Main Content Styles */
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

        /* POS Grid Layout */
        .pos-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        /* Product Search Section */
        .product-search {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .search-header {
            margin-bottom: 1.5rem;
        }

        .search-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #6366f1;
        }

        .search-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
        }

        /* Product List */
        .product-list {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
            transition: background-color 0.3s ease;
        }

        .product-item:hover {
            background-color: #f8fafc;
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .product-details {
            font-size: 0.9rem;
            color: #64748b;
        }

        .product-stock {
            font-size: 0.8rem;
            color: #475569;
            margin-top: 0.25rem;
        }

        .add-to-cart-btn {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        /* Cart Section */
        .cart-section {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .cart-header {
            margin-bottom: 1.5rem;
        }

        .cart-header h3 {
            color: #6366f1;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .cart-items {
            margin-bottom: 1.5rem;
            max-height: 300px;
            overflow-y: auto;
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item-info {
            flex: 1;
        }

        .cart-item-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .cart-item-price {
            color: #6366f1;
            font-weight: 600;
        }

        .cart-item-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quantity-btn {
            background: #f1f5f9;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .quantity-btn:hover {
            background: #e2e8f0;
        }

        .quantity-display {
            padding: 0.5rem;
            min-width: 40px;
            text-align: center;
            font-weight: 600;
        }

        .remove-item-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .remove-item-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Cart Summary */
        .cart-summary {
            border-top: 2px solid #f1f5f9;
            padding-top: 1.5rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .summary-row.total {
            font-size: 1.2rem;
            font-weight: 700;
            color: #6366f1;
            border-top: 1px solid #f1f5f9;
            padding-top: 1rem;
            margin-top: 1rem;
        }

        .checkout-btn {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .pos-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            /* Sidebar responsive styles are now in css/sidebar.css */
            
            .main-content {
                padding: 1rem;
            }
            
            .search-form {
                flex-direction: column;
            }
            
            .cart-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <%
    // Determine user type and role for navigation
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
    
    // Determine navigation type
    String navType = "public"; // default
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

    <% if ("admin".equals(navType) || "manager".equals(navType) || "staff".equals(navType)) { %>
        <!-- MANAGER/ADMIN/STAFF NAVIGATION (Sidebar Only) -->
        <div class="admin-layout">
            <!-- Sidebar -->
            <aside class="admin-sidebar">
                <div class="admin-sidebar-header">
                    <h2><%= "admin".equals(navType) ? "Admin" : ("manager".equals(navType) ? "Manager" : "Staff") %> Panel</h2>
                    <p>Welcome, <%= username %></p>
                </div>
                
                <%
                // Different sidebar menus for each role
                if ("admin".equals(navType)) {
                %>
                <!-- ADMIN SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Admin)</a></li>
                    <li><a href="pos.jsp" class="active"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Admin)</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("manager".equals(navType)) {
                %>
                <!-- MANAGER SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard (Manager)</a></li>
                    <li><a href="pos.jsp" class="active"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
                    <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                    <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Manager)</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                } else if ("staff".equals(navType)) {
                %>
                <!-- STAFF SIDEBAR MENU -->
                <ul class="admin-sidebar-menu">
                    <li><a href="pos.jsp" class="active"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
                    <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                    <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help (Staff)</a></li>
                    <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
                <%
                }
                %>
            </aside>

            <!-- Main Content -->
            <main class="admin-main-content">
                <div class="main-content">
                    <div class="page-header">
                        <h1>Point of Sale (POS)</h1>
                        <p>Process sales, manage inventory, and serve customers efficiently</p>
                    </div>
                    
                    <!-- POS Grid Layout -->
                    <div class="pos-grid">
                        <!-- Product Search Section -->
                        <div class="product-search">
                            <div class="search-header">
                                <h3><i class="fas fa-search"></i> Product Search</h3>
                                <p>Search for books by title, author, or ISBN</p>
                            </div>
                            
                            <form class="search-form">
                                <input type="text" class="search-input" placeholder="Search for books..." id="productSearch">
                                <button type="button" class="search-btn" onclick="searchProducts()">
                                    <i class="fas fa-search"></i> Search
                                </button>
                                <button type="button" class="search-btn" style="background: linear-gradient(135deg, #10b981, #059669);" onclick="loadProductsFromDatabase()">
                                    <i class="fas fa-database"></i> Load Products
                                </button>
                            </form>
                            
                            <div class="product-list" id="productList">
                                <!-- Products will be loaded dynamically from database -->
                                <%
                                // Get books from request attribute (if available from BookServlet)
                                java.util.List<com.pahana.BookServlet.Book> books = 
                                    (java.util.List<com.pahana.BookServlet.Book>) request.getAttribute("books");
                                
                                if (books != null && !books.isEmpty()) {
                                    for (com.pahana.BookServlet.Book book : books) {
                                        // Only show books with stock > 0
                                        if (book.getStockQuantity() > 0) {
                                %>
                                    <div class="product-item" data-title="<%= book.getTitle().toLowerCase() %>" data-author="<%= book.getAuthor() != null ? book.getAuthor().toLowerCase() : "" %>">
                                        <div class="product-info">
                                            <div class="product-name"><%= book.getTitle() %></div>
                                            <div class="product-details">
                                                <%= book.getAuthor() != null ? book.getAuthor() : "Unknown Author" %> • 
                                                <%= book.getCategoryName() != null ? book.getCategoryName() : "Uncategorized" %> • 
                                                $<%= book.getPrice() != null ? book.getPrice().toString() : "0.00" %>
                                            </div>
                                            <div class="product-stock">Stock: <%= book.getStockQuantity() %></div>
                                        </div>
                                        <button class="add-to-cart-btn" data-title="<%= book.getTitle() %>" data-price="<%= book.getPrice() != null ? book.getPrice() : 0 %>" data-bookid="<%= book.getBookId() %>">
                                            <i class="fas fa-plus"></i> Add
                                        </button>
                                    </div>
                                <%
                                        }
                                    }
                                } else {
                                    // If no books from servlet, show sample products
                                %>
                                    <div class="product-item" data-title="the great gatsby" data-author="f. scott fitzgerald">
                                        <div class="product-info">
                                            <div class="product-name">The Great Gatsby</div>
                                            <div class="product-details">F. Scott Fitzgerald • Fiction • $12.99</div>
                                            <div class="product-stock">Stock: 15</div>
                                        </div>
                                        <button class="add-to-cart-btn" data-title="The Great Gatsby" data-price="12.99" data-bookid="1">
                                            <i class="fas fa-plus"></i> Add
                                        </button>
                                    </div>
                                    
                                    <div class="product-item" data-title="to kill a mockingbird" data-author="harper lee">
                                        <div class="product-info">
                                            <div class="product-name">To Kill a Mockingbird</div>
                                            <div class="product-details">Harper Lee • Fiction • $14.99</div>
                                            <div class="product-stock">Stock: 8</div>
                                        </div>
                                        <button class="add-to-cart-btn" data-title="To Kill a Mockingbird" data-price="14.99" data-bookid="2">
                                            <i class="fas fa-plus"></i> Add
                                        </button>
                                    </div>
                                    
                                    <div class="product-item" data-title="1984" data-author="george orwell">
                                        <div class="product-info">
                                            <div class="product-name">1984</div>
                                            <div class="product-details">George Orwell • Fiction • $11.99</div>
                                            <div class="product-stock">Stock: 12</div>
                                        </div>
                                        <button class="add-to-cart-btn" data-title="1984" data-price="11.99" data-bookid="3">
                                            <i class="fas fa-plus"></i> Add
                                        </button>
                                    </div>
                                <%
                                }
                                %>
                            </div>
                        </div>
                        
                        <!-- Cart Section -->
                        <div class="cart-section">
                            <div class="cart-header">
                                <h3><i class="fas fa-shopping-cart"></i> Shopping Cart</h3>
                                <p>Review items and complete purchase</p>
                            </div>
                            
                            <div class="cart-items" id="cartItems">
                                <!-- Cart items will be displayed here -->
                            </div>
                            
                            <div class="cart-summary">
                                <div class="summary-row">
                                    <span>Subtotal:</span>
                                    <span id="subtotal">$0.00</span>
                                </div>
                                <div class="summary-row">
                                    <span>Tax (8%):</span>
                                    <span id="tax">$0.00</span>
                                </div>
                                <div class="summary-row total">
                                    <span>Total:</span>
                                    <span id="total">$0.00</span>
                                </div>
                                
                                <button class="checkout-btn" onclick="processCheckout()">
                                    <i class="fas fa-credit-card"></i> Process Payment
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    <% } else { %>
        <!-- Access Denied for non-staff users -->
        <div style="text-align: center; padding: 4rem 2rem;">
            <h1 style="color: #ef4444; margin-bottom: 1rem;">Access Denied</h1>
            <p style="color: #64748b; margin-bottom: 2rem;">You don't have permission to access the Point of Sale system.</p>
            <a href="welcome.jsp" style="background: #6366f1; color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-block;">Return to Home</a>
        </div>
    <% } %>

    <script src="js/sidebar.js"></script>
    <script>
        // Simple cart functionality
        let cart = [];

        // Set up event listeners for add to cart buttons
        function setupAddToCartListeners() {
            document.querySelectorAll('.add-to-cart-btn').forEach(button => {
                // Remove existing listeners to avoid duplicates
                button.removeEventListener('click', handleAddToCart);
                button.addEventListener('click', handleAddToCart);
            });
        }

        function handleAddToCart() {
            const title = this.getAttribute('data-title');
            const price = parseFloat(this.getAttribute('data-price'));
            const bookId = parseInt(this.getAttribute('data-bookid'));
            addToCart(title, price, bookId);
        }

        // Set up initial event listeners
        document.addEventListener('DOMContentLoaded', setupAddToCartListeners);

        function addToCart(name, price, bookId) {
            const existingItem = cart.find(item => item.name === name);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({ name, price, quantity: 1, bookId: bookId });
            }
            
            // Update stock display
            updateStockDisplay(name, -1);
            
            updateCartDisplay();
            updateTotals();
        }

        function updateStockDisplay(bookName, change) {
            const productItems = document.querySelectorAll('.product-item');
            productItems.forEach(item => {
                const itemName = item.querySelector('.product-name').textContent;
                if (itemName === bookName) {
                    const stockElement = item.querySelector('.product-stock');
                    if (stockElement) {
                        const currentStock = parseInt(stockElement.textContent.match(/\d+/)[0]);
                        const newStock = Math.max(0, currentStock + change);
                        stockElement.textContent = `Stock: ${newStock}`;
                        
                        // Disable add button if stock is 0
                        const addButton = item.querySelector('.add-to-cart-btn');
                        if (newStock === 0) {
                            addButton.disabled = true;
                            addButton.style.background = '#9ca3af';
                            addButton.style.cursor = 'not-allowed';
                        }
                    }
                }
            });
        }

        function updateQuantity(index, change) {
            const item = cart[index];
            const oldQuantity = item.quantity;
            item.quantity += change;
            
            if (item.quantity <= 0) {
                cart.splice(index, 1);
                // Restore all stock when item is completely removed
                updateStockDisplay(item.name, oldQuantity);
            } else {
                // Update stock based on quantity change
                updateStockDisplay(item.name, -change);
            }
            
            updateCartDisplay();
            updateTotals();
        }

        function removeItem(index) {
            const removedItem = cart[index];
            cart.splice(index, 1);
            
            // Restore stock when item is removed
            updateStockDisplay(removedItem.name, removedItem.quantity);
            
            updateCartDisplay();
            updateTotals();
        }

        function updateCartDisplay() {
            const cartItems = document.getElementById('cartItems');
            cartItems.innerHTML = '';
            
            cart.forEach((item, index) => {
                const cartItem = document.createElement('div');
                cartItem.className = 'cart-item';
                cartItem.innerHTML = `
                    <div class="cart-item-info">
                        <div class="cart-item-name">${item.name}</div>
                        <div class="cart-item-price">$${item.price.toFixed(2)}</div>
                    </div>
                    <div class="cart-item-controls">
                        <button class="quantity-btn" onclick="updateQuantity(${index}, -1)">-</button>
                        <span class="quantity-display">${item.quantity}</span>
                        <button class="quantity-btn" onclick="updateQuantity(${index}, 1)">+</button>
                        <button class="remove-item-btn" onclick="removeItem(${index})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                `;
                cartItems.appendChild(cartItem);
            });
        }

        function updateTotals() {
            const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            const tax = subtotal * 0.08;
            const total = subtotal + tax;
            
            document.getElementById('subtotal').textContent = `$${subtotal.toFixed(2)}`;
            document.getElementById('tax').textContent = `$${tax.toFixed(2)}`;
            document.getElementById('total').textContent = `$${total.toFixed(2)}`;
        }

        function searchProducts() {
            const searchTerm = document.getElementById('productSearch').value.toLowerCase();
            const productItems = document.querySelectorAll('.product-item');
            
            productItems.forEach(item => {
                const productName = item.querySelector('.product-name').textContent.toLowerCase();
                const productAuthor = item.dataset.author;
                const productTitle = item.dataset.title;

                if (productName.includes(searchTerm) || productAuthor.includes(searchTerm) || productTitle.includes(searchTerm)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        }

        function loadProductsFromDatabase() {
            // Redirect to BookServlet to get real book data
            window.location.href = 'BookServlet?action=list&redirect=pos';
        }

        function processCheckout() {
            if (cart.length === 0) {
                alert('Please add items to cart before checkout.');
                return;
            }
            
            alert('Payment processed successfully! Total: $' + document.getElementById('total').textContent);
            cart = [];
            updateCartDisplay();
            updateTotals();
        }

        // Initialize
        updateTotals();
    </script>
</body>
</html>
