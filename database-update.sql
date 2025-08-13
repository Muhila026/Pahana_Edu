-- =============================================
-- Database Update Script for BookShop POS
-- Add Bill/Invoice Functionality
-- =============================================

-- Run this script to add bill functionality to your existing BookShop database
-- Make sure to backup your database before running this script

-- Note: The customer_id column already exists in your sales table, so we'll skip that part

-- =============================================
-- 1. Bills/Invoices Table
-- =============================================
CREATE TABLE IF NOT EXISTS bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_number VARCHAR(50) NOT NULL UNIQUE,       -- Unique bill number (e.g., BILL-2024-001)
    sale_id INT NOT NULL,                          -- Reference to sales table
    customer_id INT NULL,                          -- Reference to customers table (optional for walk-in customers)
    customer_name VARCHAR(100),                    -- Customer name (for walk-in customers)
    customer_email VARCHAR(100),                   -- Customer email
    customer_phone VARCHAR(20),                    -- Customer phone
    customer_address TEXT,                         -- Customer address
    subtotal DECIMAL(10,2) NOT NULL,              -- Subtotal before tax
    tax_amount DECIMAL(10,2) NOT NULL,            -- Tax amount
    total_amount DECIMAL(10,2) NOT NULL,          -- Total amount after tax
    payment_method VARCHAR(50) NOT NULL,           -- Payment method used
    bill_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date and time of bill generation
    created_by VARCHAR(50) NOT NULL,               -- Username of staff who created the bill
    notes TEXT,                                    -- Additional notes
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
        ON DELETE CASCADE,                         -- Delete bill when sale is deleted
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE SET NULL,                        -- Set customer_id to NULL if customer is deleted
    FOREIGN KEY (created_by) REFERENCES users(username)
        ON DELETE RESTRICT
);

-- =============================================
-- 2. Bill Items Table (Individual Items in Bills)
-- =============================================
CREATE TABLE IF NOT EXISTS bill_items (
    bill_item_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,                          -- Reference to bills table
    book_id INT NOT NULL,                          -- Reference to books table
    book_title VARCHAR(150) NOT NULL,              -- Book title at time of billing
    book_author VARCHAR(100),                      -- Author at time of billing
    quantity INT NOT NULL,                         -- Quantity in bill
    unit_price DECIMAL(10,2) NOT NULL,            -- Unit price at time of billing
    total_price DECIMAL(10,2) NOT NULL,           -- Total price for this item
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
        ON DELETE CASCADE,                         -- Delete items when bill is deleted
    FOREIGN KEY (book_id) REFERENCES books(book_id)
        ON DELETE RESTRICT
);

-- =============================================
-- 3. Bill Number Sequence Table
-- =============================================
CREATE TABLE IF NOT EXISTS bill_sequence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    sequence INT NOT NULL DEFAULT 1,
    UNIQUE KEY unique_year_sequence (year, sequence)
);

-- =============================================
-- 4. Insert Sample Bill Sequence
-- =============================================
INSERT IGNORE INTO bill_sequence (year, sequence) VALUES 
(2024, 1),
(2024, 2),
(2024, 3);

-- =============================================
-- 5. Verify Tables Created Successfully
-- =============================================
SELECT 'bills' as table_name, COUNT(*) as record_count FROM bills
UNION ALL
SELECT 'bill_items' as table_name, COUNT(*) as record_count FROM bill_items
UNION ALL
SELECT 'bill_sequence' as table_name, COUNT(*) as record_count FROM bill_sequence;

-- =============================================
-- 6. Show Table Structure (Optional)
-- =============================================
-- DESCRIBE bills;
-- DESCRIBE bill_items;
-- DESCRIBE bill_sequence;

-- =============================================
-- 11. Discount Table
-- =============================================
CREATE TABLE IF NOT EXISTS discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_type VARCHAR(100) NOT NULL,           -- Type of discount (Percentage, Fixed Amount, Seasonal)
    discount_value DECIMAL(10,2) NOT NULL,         -- Amount or percentage value
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample discounts
INSERT IGNORE INTO discounts (discount_type, discount_value) VALUES
('Percentage', 10.00),    -- 10% discount
('Fixed Amount', 500.00), -- 500 LKR off
('Seasonal Offer', 15.00); -- 15% discount

-- =============================================
-- 12. Discount Usage Table
-- =============================================
CREATE TABLE IF NOT EXISTS discount_usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_phone VARCHAR(20) NOT NULL,           -- Customer phone number
    discount_type VARCHAR(100) NOT NULL,           -- Type of discount used
    discount_amount DECIMAL(10,2) NOT NULL,        -- Amount of discount applied
    bill_total DECIMAL(10,2) NOT NULL,             -- Total bill amount
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- When discount was used
    INDEX idx_customer_phone (customer_phone),      -- Index for customer lookup
    INDEX idx_used_at (used_at)                    -- Index for date queries
);
