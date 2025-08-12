<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>POS - Point of Sale</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
        }
        
        .header {
            background: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            font-size: 24px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logout-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        
        .container {
            display: flex;
            height: calc(100vh - 70px);
        }
        
        .left-panel {
            flex: 2;
            padding: 20px;
            background: white;
            border-right: 1px solid #ddd;
        }
        
        .right-panel {
            flex: 1;
            padding: 20px;
            background: white;
        }
        
        .search-section {
            margin-bottom: 20px;
        }
        
        .search-box {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
        }
        
        .search-box:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            max-height: 500px;
            overflow-y: auto;
        }
        
        .book-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .book-card:hover {
            border-color: #3498db;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .book-card.selected {
            border-color: #3498db;
            background: #ecf0f1;
        }
        
        .book-title {
            font-weight: bold;
            margin-bottom: 5px;
            color: #2c3e50;
        }
        
        .book-author {
            color: #7f8c8d;
            margin-bottom: 5px;
        }
        
        .book-price {
            font-size: 18px;
            font-weight: bold;
            color: #27ae60;
        }
        
        .book-stock {
            color: #e67e22;
            font-size: 14px;
        }
        
        .cart-section h3 {
            margin-bottom: 15px;
            color: #2c3e50;
        }
        
        .cart-items {
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 20px;
        }
        
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .cart-item-info {
            flex: 1;
        }
        
        .cart-item-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .cart-item-price {
            color: #7f8c8d;
        }
        
        .cart-item-quantity {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-btn {
            background: #3498db;
            color: white;
            border: none;
            width: 25px;
            height: 25px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 14px;
        }
        
        .quantity-btn:hover {
            background: #2980b9;
        }
        
        .quantity-input {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
        }
        
        .remove-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        
        .cart-total {
            border-top: 2px solid #3498db;
            padding-top: 15px;
            margin-bottom: 20px;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .total-amount {
            font-size: 24px;
            font-weight: bold;
            color: #27ae60;
        }
        
        .checkout-btn {
            width: 100%;
            background: #27ae60;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .checkout-btn:hover {
            background: #229954;
        }
        
        .checkout-btn:disabled {
            background: #bdc3c7;
            cursor: not-allowed;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: none;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: none;
        }
        
        /* Receipt Modal Styles */
        .receipt-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .receipt-content {
            background-color: white;
            margin: 5% auto;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 500px;
            position: relative;
            text-align: center;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .receipt-header {
            border-bottom: 2px solid #3498db;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        
        .receipt-header h2 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .receipt-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 14px;
            color: #7f8c8d;
        }
        
        .receipt-items {
            text-align: left;
            margin-bottom: 20px;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
        }
        
        .receipt-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .receipt-item:last-child {
            border-bottom: none;
        }
        
        .receipt-item-details {
            flex: 1;
            text-align: left;
        }
        
        .receipt-item-title {
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .receipt-item-author {
            font-size: 12px;
            color: #7f8c8d;
            font-style: italic;
        }
        
        .receipt-item-price {
            color: #27ae60;
            font-weight: bold;
        }
        
        .receipt-total {
            border-top: 2px solid #3498db;
            padding-top: 15px;
            font-size: 18px;
            font-weight: bold;
            color: #27ae60;
        }
        
        .receipt-actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .receipt-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .receipt-btn:hover {
            background: #2980b9;
        }
        
        .receipt-btn.print {
            background: #27ae60;
        }
        
        .receipt-btn.print:hover {
            background: #229954;
        }
        
        .receipt-btn.close {
            background: #e74c3c;
        }
        
        .receipt-btn.close:hover {
            background: #c0392b;
        }
        
        @media print {
            .receipt-actions {
                display: none;
            }
            .receipt-content {
                margin: 0;
                box-shadow: none;
                border-radius: 0;
            }
        }
    </style>
</head>
<body>
    <%
        // Check if user is logged in and has appropriate role
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        
        // Only allow admin, manager, and staff
        if (!"admin".equals(userType) && !"Manager".equals(role) && !"Staff".equals(role)) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
    %>
    
    <div class="header">
        <h1><i class="fas fa-cash-register"></i> POS - Point of Sale</h1>
        <div class="user-info">
            <span>Welcome, <%= username %> (<%= role != null ? role : userType %>)</span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="left-panel">
            <div class="search-section">
                <input type="text" id="searchBox" class="search-box" placeholder="Search books by title, author, or category...">
            </div>
            
            <div class="books-grid" id="booksGrid">
                <!-- Books will be loaded here -->
            </div>
        </div>
        
        <div class="right-panel">
            <h3><i class="fas fa-shopping-cart"></i> Shopping Cart</h3>
            
            <div class="success-message" id="successMessage"></div>
            <div class="error-message" id="errorMessage"></div>
            
            <div class="cart-items" id="cartItems">
                <!-- Cart items will be displayed here -->
                <p style="text-align: center; color: #7f8c8d; margin-top: 50px;">No items in cart</p>
            </div>
            
            <div class="cart-total">
                <div class="total-row">
                    <span>Subtotal:</span>
                    <span id="subtotal">Rs. 0.00</span>
                </div>
                <div class="total-row">
                    <span>Total:</span>
                    <span class="total-amount" id="totalAmount">Rs. 0.00</span>
                </div>
            </div>
            
            <button class="checkout-btn" id="checkoutBtn" onclick="processSale()" disabled>
                <i class="fas fa-credit-card"></i> Process Sale
            </button>
        </div>
    </div>

    <!-- Receipt Modal -->
    <div id="receiptModal" class="receipt-modal">
        <div class="receipt-content">
            <div class="receipt-header">
                <h2><i class="fas fa-book"></i> BookShop</h2>
                <p>Sales Receipt</p>
                <div class="receipt-info">
                    <span id="receiptDate"></span>
                    <span>Sale ID: <span id="receiptSaleId"></span></span>
                </div>
                <div class="receipt-info">
                    <span>Cashier: <%= username %></span>
                    <span id="receiptTime"></span>
                </div>
            </div>
            
            <div class="receipt-items" id="receiptItems">
                <!-- Receipt items will be populated here -->
            </div>
            
            <div class="receipt-total">
                <div>Total Amount: <span id="receiptTotal"></span></div>
            </div>
            
            <div class="receipt-actions">
                <button class="receipt-btn print" onclick="printReceipt()">
                    <i class="fas fa-print"></i> Print Receipt
                </button>
                <button class="receipt-btn close" onclick="closeReceipt()">
                    <i class="fas fa-times"></i> Close
                </button>
            </div>
        </div>
    </div>

    <script>
        let cart = [];
        let books = [];
        
        // Load books on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadBooks();
            
            // Search functionality
            document.getElementById('searchBox').addEventListener('input', function() {
                const searchTerm = this.value.trim();
                if (searchTerm.length > 0) {
                    searchBooks(searchTerm);
                } else {
                    loadBooks();
                }
            });
        });
        
        function loadBooks() {
            fetch('POSServlet?action=getBooks')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        books = data.books;
                        displayBooks(books);
                    } else {
                        showError('Failed to load books: ' + data.error);
                    }
                })
                .catch(error => {
                    showError('Error loading books: ' + error.message);
                });
        }
        
        function searchBooks(searchTerm) {
            fetch(`POSServlet?action=searchBooks&search=${encodeURIComponent(searchTerm)}`)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        books = data.books;
                        displayBooks(books);
                    } else {
                        showError('Search failed: ' + data.error);
                    }
                })
                .catch(error => {
                    showError('Search error: ' + error.message);
                });
        }
        
        function displayBooks(booksToShow) {
            const grid = document.getElementById('booksGrid');
            grid.innerHTML = '';
            
            if (booksToShow.length === 0) {
                grid.innerHTML = '<p style="text-align: center; color: #7f8c8d; grid-column: 1/-1; margin-top: 50px;">No books found</p>';
                return;
            }
            
            booksToShow.forEach(book => {
                const bookCard = document.createElement('div');
                bookCard.className = 'book-card';
                bookCard.onclick = () => addToCart(book);
                
                bookCard.innerHTML = `
                    <div class="book-title">${book.title}</div>
                    <div class="book-author">${book.author}</div>
                    <div class="book-price">Rs. ${book.price.toFixed(2)}</div>
                    <div class="book-stock">Stock: ${book.stock}</div>
                `;
                
                grid.appendChild(bookCard);
            });
        }
        
        function addToCart(book) {
            const existingItem = cart.find(item => item.id === book.id);
            
            if (existingItem) {
                if (existingItem.quantity < book.stock) {
                    existingItem.quantity++;
                    existingItem.totalPrice = existingItem.quantity * existingItem.price;
                } else {
                    showError('Cannot add more items. Stock limit reached.');
                    return;
                }
            } else {
                cart.push({
                    id: book.id,
                    title: book.title,
                    author: book.author,
                    price: book.price,
                    quantity: 1,
                    totalPrice: book.price,
                    stock: book.stock
                });
            }
            
            updateCartDisplay();
            updateCheckoutButton();
        }
        
        function updateCartDisplay() {
            const cartContainer = document.getElementById('cartItems');
            
            if (cart.length === 0) {
                cartContainer.innerHTML = '<p style="text-align: center; color: #7f8c8d; margin-top: 50px;">No items in cart</p>';
                return;
            }
            
            cartContainer.innerHTML = '';
            cart.forEach((item, index) => {
                const cartItem = document.createElement('div');
                cartItem.className = 'cart-item';
                
                cartItem.innerHTML = `
                    <div class="cart-item-info">
                        <div class="cart-item-title">${item.title}</div>
                        <div class="cart-item-price">Rs. ${item.price.toFixed(2)} each</div>
                    </div>
                    <div class="cart-item-quantity">
                        <button class="quantity-btn" onclick="updateQuantity(${index}, -1)">-</button>
                        <input type="number" class="quantity-input" value="${item.quantity}" 
                               min="1" max="${item.stock}" onchange="updateQuantityInput(${index}, this.value)">
                        <button class="quantity-btn" onclick="updateQuantity(${index}, 1)">+</button>
                    </div>
                    <div style="text-align: right; min-width: 80px;">
                        <div style="font-weight: bold; margin-bottom: 5px;">Rs. ${item.totalPrice.toFixed(2)}</div>
                        <button class="remove-btn" onclick="removeFromCart(${index})">Remove</button>
                    </div>
                `;
                
                cartContainer.appendChild(cartItem);
            });
        }
        
        function updateQuantity(index, change) {
            const item = cart[index];
            const newQuantity = item.quantity + change;
            
            if (newQuantity >= 1 && newQuantity <= item.stock) {
                item.quantity = newQuantity;
                item.totalPrice = item.quantity * item.price;
                updateCartDisplay();
                updateTotals();
                updateCheckoutButton();
            }
        }
        
        function updateQuantityInput(index, value) {
            const item = cart[index];
            const newQuantity = parseInt(value);
            
            if (newQuantity >= 1 && newQuantity <= item.stock) {
                item.quantity = newQuantity;
                item.totalPrice = item.quantity * item.price;
                updateTotals();
                updateCheckoutButton();
            } else {
                // Reset to valid value
                updateCartDisplay();
            }
        }
        
        function removeFromCart(index) {
            cart.splice(index, 1);
            updateCartDisplay();
            updateTotals();
            updateCheckoutButton();
        }
        
        function updateTotals() {
            const subtotal = cart.reduce((sum, item) => sum + item.totalPrice, 0);
            document.getElementById('subtotal').textContent = `Rs. ${subtotal.toFixed(2)}`;
            document.getElementById('totalAmount').textContent = `Rs. ${subtotal.toFixed(2)}`;
        }
        
        function updateCheckoutButton() {
            const checkoutBtn = document.getElementById('checkoutBtn');
            checkoutBtn.disabled = cart.length === 0;
        }
        
        function processSale() {
            if (cart.length === 0) {
                showError('Cart is empty');
                return;
            }
            
            const saleData = {
                items: cart,
                totalAmount: parseFloat(document.getElementById('totalAmount').textContent.replace('Rs. ', ''))
            };
            
            fetch('POSServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `action=processSale&saleData=${JSON.stringify(saleData)}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccess('Sale processed successfully! Sale ID: ' + data.saleId);
                    showReceipt(data.saleId);
                    cart = [];
                    updateCartDisplay();
                    updateTotals();
                    updateCheckoutButton();
                    loadBooks(); // Refresh book list to update stock
                } else {
                    showError('Sale failed: ' + data.error);
                }
            })
            .catch(error => {
                showError('Error processing sale: ' + error.message);
            });
        }
        
        function showSuccess(message) {
            const successDiv = document.getElementById('successMessage');
            successDiv.textContent = message;
            successDiv.style.display = 'block';
            document.getElementById('errorMessage').style.display = 'none';
            
            setTimeout(() => {
                successDiv.style.display = 'none';
            }, 5000);
        }
        
        function showError(message) {
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.textContent = message;
            errorDiv.style.display = 'block';
            document.getElementById('successMessage').style.display = 'none';
            
            setTimeout(() => {
                errorDiv.style.display = 'none';
            }, 5000);
        }
        
        // Receipt functions
        function showReceipt(saleId) {
            // Set receipt details
            const now = new Date();
            document.getElementById('receiptDate').textContent = now.toLocaleDateString();
            document.getElementById('receiptTime').textContent = now.toLocaleTimeString();
            document.getElementById('receiptSaleId').textContent = saleId;
            document.getElementById('receiptTotal').textContent = `Rs. ${parseFloat(document.getElementById('totalAmount').textContent.replace('Rs. ', '')).toFixed(2)}`;
            
            // Populate receipt items with book details
            const receiptItems = document.getElementById('receiptItems');
            receiptItems.innerHTML = '';
            
            cart.forEach(item => {
                const receiptItem = document.createElement('div');
                receiptItem.className = 'receipt-item';
                
                receiptItem.innerHTML = `
                    <div class="receipt-item-details">
                        <div class="receipt-item-title">${item.title}</div>
                        <div class="receipt-item-author">by ${item.author || 'Unknown Author'}</div>
                        <div style="font-size: 12px; color: #7f8c8d;">
                            Qty: ${item.quantity} × Rs. ${item.price.toFixed(2)}
                        </div>
                    </div>
                    <div class="receipt-item-price">
                        Rs. ${item.totalPrice.toFixed(2)}
                    </div>
                `;
                
                receiptItems.appendChild(receiptItem);
            });
            
            // Show the receipt modal
            document.getElementById('receiptModal').style.display = 'block';
        }
        
        function closeReceipt() {
            document.getElementById('receiptModal').style.display = 'none';
        }
        
        function printReceipt() {
            window.print();
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('receiptModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>
