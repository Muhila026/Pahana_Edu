-- Setup script for discounts table
-- Run this in your MySQL database to ensure the discounts table exists

USE mydatabase;

-- Create discounts table if it doesn't exist
CREATE TABLE IF NOT EXISTS discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_type VARCHAR(100) NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample discounts if table is empty
INSERT IGNORE INTO discounts (discount_type, discount_value) VALUES
('Percentage', 10.00),    -- 10% discount
('Fixed Amount', 500.00), -- 500 LKR off
('Seasonal Offer', 15.00); -- 15% discount

-- Verify table structure
DESCRIBE discounts;

-- Show sample data
SELECT * FROM discounts;
