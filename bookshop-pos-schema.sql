-- =============================================
-- BookShop Database Schema with POS System
-- =============================================

-- Drop existing tables if they exist (be careful with this in production!)
-- DROP TABLE IF EXISTS sale_items;
-- DROP TABLE IF EXISTS sales;
-- DROP TABLE IF EXISTS books;
-- DROP TABLE IF EXISTS categories;
-- DROP TABLE IF EXISTS customers;
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS roles;

-- =============================================
-- 1. Roles Table
-- =============================================
CREATE TABLE IF NOT EXISTS roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- =============================================
-- 2. Users Table (Admin/Manager/Staff)
-- =============================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_ VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
        ON DELETE SET NULL
);

-- =============================================
-- 3. Customers Table (Customer Login)
-- =============================================
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_ VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    telephone VARCHAR(20),
    role_id INT DEFAULT 4,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
        ON DELETE SET NULL
); 

-- =============================================
-- 4. Categories Table (Books Categories)
-- =============================================
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 5. Books Table 
-- =============================================
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for each book
    title VARCHAR(150) NOT NULL,                   -- Book title
    author VARCHAR(100),                           -- Author name
    price DECIMAL(10,2) NOT NULL,                  -- Price of the book
    stock_quantity INT DEFAULT 0,                  -- Available stock
    category_id INT,                               -- Linked to categories table
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,-- Auto date/time of book entry
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE SET NULL                         -- If category deleted, set NULL
);

-- =============================================
-- 6. Sales Table (POS Transactions)
-- =============================================
CREATE TABLE IF NOT EXISTS sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NULL,                          -- Optional customer ID for walk-in customers
    total_amount DECIMAL(10,2) NOT NULL,           -- Total sale amount
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date and time of sale
    created_by VARCHAR(50) NOT NULL,               -- Username of staff who processed the sale
    payment_method VARCHAR(50) DEFAULT 'Cash',     -- Payment method used
    status VARCHAR(20) DEFAULT 'Completed',        -- Sale status
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE SET NULL
);

-- =============================================
-- 7. Sale Items Table (Individual Items in Sales)
-- =============================================
CREATE TABLE IF NOT EXISTS sale_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,                          -- Reference to sales table
    book_id INT NOT NULL,                          -- Reference to books table
    quantity INT NOT NULL,                         -- Quantity sold
    unit_price DECIMAL(10,2) NOT NULL,            -- Price per unit at time of sale
    total_price DECIMAL(10,2) NOT NULL,           -- Total price for this item
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
        ON DELETE CASCADE,                         -- Delete items when sale is deleted
    FOREIGN KEY (book_id) REFERENCES books(book_id)
        ON DELETE RESTRICT                         -- Prevent deletion of books that have sales
);

-- =============================================
-- Insert Sample Data
-- =============================================

-- Roles
INSERT IGNORE INTO roles (role_name) VALUES 
('Admin'),
('Manager'),
('Staff'),
('Customer');

-- Users (Admin/Staff Login) - Fixed column names
INSERT IGNORE INTO users (username, password_, email, phone, role_id) VALUES
('adminUser', '123', 'admin@pahanaedu.lk', '0712345678', 1),
('managerUser', '123', 'manager@pahanaedu.lk', '0712345679', 2),
('staffUser', '123', 'staff@pahanaedu.lk', '0712345680', 3);

-- Customers (Customer Login) - Fixed column names
INSERT IGNORE INTO customers (account_number, name, email, password_, address, telephone, role_id) VALUES
('ACC001', 'Kasun Perera', 'kasun@example.com', '123', '123 Colombo Road, Colombo', '0771234567', 4),
('ACC002', 'Nimali Jayasekara', 'nimali@example.com', '123', '45 Kandy Road, Kandy', '0777654321', 4);

-- Insert Sample Book Categories
INSERT IGNORE INTO categories (category_name, description) VALUES
('Fiction', 'Novels and stories that are imaginative or made up'),
('Non-Fiction', 'Informative and factual books'),
('Children', 'Books suitable for kids'),
('Science', 'Books about science and technology'),
('History', 'Books about historical events and people');

-- Insert Sample Books Without ISBN
INSERT IGNORE INTO books (title, author, price, stock_quantity, category_id) VALUES
('Harry Potter and the Philosopher\'s Stone', 'J.K. Rowling', 1200.00, 50, 1), -- Fiction
('A Brief History of Time', 'Stephen Hawking', 1500.00, 30, 4),               -- Science
('Fairy Tales for Kids', 'Various', 800.00, 40, 3),                           -- Children
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 1800.00, 25, 2), -- Non-Fiction
('The Second World War', 'Antony Beevor', 2000.00, 20, 5);                     -- History

-- =============================================
-- Create Indexes for Better Performance
-- =============================================

-- Index for faster book searches
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_books_author ON books(author);
CREATE INDEX idx_books_category ON books(category_id);
CREATE INDEX idx_books_stock ON books(stock_quantity);

-- Index for faster sales queries
CREATE INDEX idx_sales_date ON sales(sale_date);
CREATE INDEX idx_sales_customer ON sales(customer_id);
CREATE INDEX idx_sales_created_by ON sales(created_by);

-- Index for faster sale items queries
CREATE INDEX idx_sale_items_sale ON sale_items(sale_id);
CREATE INDEX idx_sale_items_book ON sale_items(book_id);

-- =============================================
-- Verify the structure
-- =============================================
SELECT 'Roles Table' as Table_Name, COUNT(*) as Record_Count FROM roles
UNION ALL
SELECT 'Users Table', COUNT(*) FROM users
UNION ALL
SELECT 'Customers Table', COUNT(*) FROM customers
UNION ALL
SELECT 'Categories Table', COUNT(*) FROM categories
UNION ALL
SELECT 'Books Table', COUNT(*) FROM books
UNION ALL
SELECT 'Sales Table', COUNT(*) FROM sales
UNION ALL
SELECT 'Sale Items Table', COUNT(*) FROM sale_items;

-- =============================================
-- Sample POS Queries for Testing
-- =============================================

-- View all books with stock
-- SELECT b.title, b.author, b.price, b.stock_quantity, c.category_name 
-- FROM books b LEFT JOIN categories c ON b.category_id = c.category_id 
-- WHERE b.stock_quantity > 0;

-- View recent sales
-- SELECT s.sale_id, s.total_amount, s.sale_date, s.created_by, 
--        COUNT(si.item_id) as items_sold
-- FROM sales s LEFT JOIN sale_items si ON s.sale_id = si.sale_id 
-- GROUP BY s.sale_id ORDER BY s.sale_date DESC LIMIT 10;

-- View sales by staff member
-- SELECT created_by, COUNT(*) as sales_count, SUM(total_amount) as total_sales
-- FROM sales GROUP BY created_by ORDER BY total_sales DESC;
