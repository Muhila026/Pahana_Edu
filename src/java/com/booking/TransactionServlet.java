package com.booking;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.sql.*;
import java.math.BigDecimal;
import java.io.BufferedReader;
import java.util.regex.Pattern;
import java.util.regex.Matcher;


/**
 * Servlet for handling Transaction operations
 */
public class TransactionServlet extends HttpServlet {

    // Singleton Database Connection Manager
    private static class DatabaseConnectionManager {
        private static DatabaseConnectionManager instance;
        private static final String URL = "jdbc:mysql://localhost:3306/pahana_bookshop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        private static final String USERNAME = "root";
        private static final String PASSWORD = "password";
        
        private DatabaseConnectionManager() {}
        
        public static synchronized DatabaseConnectionManager getInstance() {
            if (instance == null) {
                instance = new DatabaseConnectionManager();
            }
            return instance;
        }
        
        public Connection getConnection() throws SQLException {
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        }
    }
    
    // Observer Pattern for Event Logging
    public interface EventObserver {
        void onEvent(String event, String details);
    }
    
    public static class EventLogger implements EventObserver {
        @Override
        public void onEvent(String event, String details) {
            System.out.println("EVENT: " + event + " - " + details + " at " + new java.util.Date());
        }
    }
    
    public static class EventManager {
        private static List<EventObserver> observers = new ArrayList<>();
        
        public static void addObserver(EventObserver observer) {
            observers.add(observer);
        }
        
        public static void notifyObservers(String event, String details) {
            for (EventObserver observer : observers) {
                observer.onEvent(event, details);
            }
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DatabaseConnectionManager.getInstance().getConnection();
    }

    // Factory Pattern for Object Creation
    public static class ObjectFactory {
        public static Transaction createTransaction(int transactionId, Customer customer, BigDecimal totalAmount) {
            return new Transaction(transactionId, customer, totalAmount);
        }
        
        public static TransactionItem createTransactionItem(int transactionItemId, int quantity, BigDecimal price, Book book) {
            TransactionItem item = new TransactionItem();
            item.setTransactionItemId(transactionItemId);
            item.setQuantity(quantity);
            item.setPrice(price);
            item.setBook(book);
            return item;
        }
        
        public static Book createBook(int bookId, String title, String description, BigDecimal pricePerUnit, int stockQuantity) {
            Book book = new Book();
            book.setBookId(bookId);
            book.setTitle(title);
            book.setDescription(description);
            book.setPricePerUnit(pricePerUnit);
            book.setStockQuantity(stockQuantity);
            return book;
        }
    }
    
    // Transaction Model Class
    public static class Transaction {
        private int transactionId;
        private Customer customer;
        private BigDecimal totalAmount;
        private User createdBy;
        private Timestamp createdAt;
        private List<TransactionItem> items;
        
        public Transaction() {}
        
        public Transaction(int transactionId, Customer customer, BigDecimal totalAmount) {
            this.transactionId = transactionId;
            this.customer = customer;
            this.totalAmount = totalAmount;
        }
        
        // Builder Pattern for Transaction
        public static class TransactionBuilder {
            private int transactionId;
            private Customer customer;
            private BigDecimal totalAmount;
            private User createdBy;
            private Timestamp createdAt;
            private List<TransactionItem> items = new ArrayList<>();
            
            public TransactionBuilder transactionId(int transactionId) {
                this.transactionId = transactionId;
                return this;
            }
            
            public TransactionBuilder customer(Customer customer) {
                this.customer = customer;
                return this;
            }
            
            public TransactionBuilder totalAmount(BigDecimal totalAmount) {
                this.totalAmount = totalAmount;
                return this;
            }
            
            public TransactionBuilder createdBy(User createdBy) {
                this.createdBy = createdBy;
                return this;
            }
            
            public TransactionBuilder createdAt(Timestamp createdAt) {
                this.createdAt = createdAt;
                return this;
            }
            
            public TransactionBuilder items(List<TransactionItem> items) {
                this.items = items;
                return this;
            }
            
            public Transaction build() {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(transactionId);
                transaction.setCustomer(customer);
                transaction.setTotalAmount(totalAmount);
                transaction.setCreatedBy(createdBy);
                transaction.setCreatedAt(createdAt);
                transaction.setItems(items);
                return transaction;
            }
        }
        
        public static TransactionBuilder builder() {
            return new TransactionBuilder();
        }
        
        // Getters and Setters
        public int getTransactionId() {
            return transactionId;
        }
        
        public void setTransactionId(int transactionId) {
            this.transactionId = transactionId;
        }
        
        public Customer getCustomer() {
            return customer;
        }
        
        public void setCustomer(Customer customer) {
            this.customer = customer;
        }
        
        public BigDecimal getTotalAmount() {
            return totalAmount;
        }
        
        public void setTotalAmount(BigDecimal totalAmount) {
            this.totalAmount = totalAmount;
        }
        
        public User getCreatedBy() {
            return createdBy;
        }
        
        public void setCreatedBy(User createdBy) {
            this.createdBy = createdBy;
        }
        
        public Timestamp getCreatedAt() {
            return createdAt;
        }
        
        public void setCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
        }
        
        public List<TransactionItem> getItems() {
            return items;
        }
        
        public void setItems(List<TransactionItem> items) {
            this.items = items;
        }
        
        @Override
        public String toString() {
            return "Transaction{" + "transactionId=" + transactionId + ", customer=" + customer + ", totalAmount=" + totalAmount + '}';
        }
    }

    // TransactionItem Model Class
    public static class TransactionItem {
        private int transactionItemId;
        private Transaction transaction;
        private Book book;
        private int quantity;
        private BigDecimal price;
        
        public TransactionItem() {}
        
        public TransactionItem(int transactionItemId, Transaction transaction, Book book, int quantity, BigDecimal price) {
            this.transactionItemId = transactionItemId;
            this.transaction = transaction;
            this.book = book;
            this.quantity = quantity;
            this.price = price;
        }
        
        // Getters and Setters
        public int getTransactionItemId() {
            return transactionItemId;
        }
        
        public void setTransactionItemId(int transactionItemId) {
            this.transactionItemId = transactionItemId;
        }
        
        public Transaction getTransaction() {
            return transaction;
        }
        
        public void setTransaction(Transaction transaction) {
            this.transaction = transaction;
        }
        
        public Book getBook() {
            return book;
        }
        
        public void setBook(Book book) {
            this.book = book;
        }
        
        public int getQuantity() {
            return quantity;
        }
        
        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
        
        public BigDecimal getPrice() {
            return price;
        }
        
        public void setPrice(BigDecimal price) {
            this.price = price;
        }

    @Override
        public String toString() {
            return "TransactionItem{" + "transactionItemId=" + transactionItemId + ", book=" + book + ", quantity=" + quantity + ", price=" + price + '}';
        }
    }

    // Book Model Class (needed for TransactionItem)
    // Decorator Pattern for Book functionality
    public static abstract class BookDecorator {
        protected Book book;
        
        public BookDecorator(Book book) {
            this.book = book;
        }
        
        public abstract String getDisplayInfo();
    }
    
    public static class BookPriceDecorator extends BookDecorator {
        public BookPriceDecorator(Book book) {
            super(book);
        }
        
        @Override
        public String getDisplayInfo() {
            return book.getTitle() + " - $" + String.format("%.2f", book.getPricePerUnit());
        }
    }
    
    public static class BookStockDecorator extends BookDecorator {
        public BookStockDecorator(Book book) {
            super(book);
        }
        
        @Override
        public String getDisplayInfo() {
            String stockStatus = book.getStockQuantity() > 10 ? "In Stock" : 
                               book.getStockQuantity() > 0 ? "Low Stock" : "Out of Stock";
            return book.getTitle() + " - " + stockStatus + " (" + book.getStockQuantity() + ")";
        }
    }
    
    public static class Book {
        private int bookId;
        private String title;
        private String description;
        private BigDecimal pricePerUnit;
        private int stockQuantity;
        private BookCategory category;
        private User createdBy;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        public Book() {}
        
        public Book(int bookId, String title, String description, BigDecimal pricePerUnit, int stockQuantity, BookCategory category) {
            this.bookId = bookId;
            this.title = title;
            this.description = description;
            this.pricePerUnit = pricePerUnit;
            this.stockQuantity = stockQuantity;
            this.category = category;
        }
        
        // Getters and Setters
        public int getBookId() {
            return bookId;
        }
        
        public void setBookId(int bookId) {
            this.bookId = bookId;
        }
        
        public String getTitle() {
            return title;
        }
        
        public void setTitle(String title) {
            this.title = title;
        }
        
        public String getDescription() {
            return description;
        }
        
        public void setDescription(String description) {
            this.description = description;
        }
        
        public BigDecimal getPricePerUnit() {
            return pricePerUnit;
        }
        
        public void setPricePerUnit(BigDecimal pricePerUnit) {
            this.pricePerUnit = pricePerUnit;
        }
        
        public int getStockQuantity() {
            return stockQuantity;
        }
        
        public void setStockQuantity(int stockQuantity) {
            this.stockQuantity = stockQuantity;
        }
        
        public BookCategory getCategory() {
            return category;
        }
        
        public void setCategory(BookCategory category) {
            this.category = category;
        }
        
        public User getCreatedBy() {
            return createdBy;
        }
        
        public void setCreatedBy(User createdBy) {
            this.createdBy = createdBy;
        }
        
        public Timestamp getCreatedAt() {
            return createdAt;
        }
        
        public void setCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
        }
        
        public Timestamp getUpdatedAt() {
            return updatedAt;
        }
        
        public void setUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
        }
    }

    // BookCategory Model Class (needed for Book)
    // Visitor Pattern for different operations on objects
    public interface Visitor {
        void visit(Book book);
        void visit(Transaction transaction);
        void visit(TransactionItem item);
    }
    
    public static class DataExportVisitor implements Visitor {
        private StringBuilder exportData = new StringBuilder();
        
        @Override
        public void visit(Book book) {
            exportData.append("Book: ").append(book.getTitle())
                     .append(", Price: $").append(String.format("%.2f", book.getPricePerUnit()))
                     .append(", Stock: ").append(book.getStockQuantity()).append("\n");
        }
        
        @Override
        public void visit(Transaction transaction) {
            exportData.append("Transaction: ").append(transaction.getTransactionId())
                     .append(", Customer: ").append(transaction.getCustomer().getName())
                     .append(", Total: $").append(String.format("%.2f", transaction.getTotalAmount())).append("\n");
        }
        
        @Override
        public void visit(TransactionItem item) {
            exportData.append("Item: ").append(item.getBook().getTitle())
                     .append(", Qty: ").append(item.getQuantity())
                     .append(", Price: $").append(String.format("%.2f", item.getPrice())).append("\n");
        }
        
        public String getExportData() {
            return exportData.toString();
        }
    }
    
    public static class BookCategory {
        private int categoryId;
        private String categoryName;
        
        public BookCategory() {}
        
        public BookCategory(int categoryId, String categoryName) {
            this.categoryId = categoryId;
            this.categoryName = categoryName;
        }
        
        // Getters and Setters
        public int getCategoryId() {
            return categoryId;
        }
        
        public void setCategoryId(int categoryId) {
            this.categoryId = categoryId;
        }
        
        public String getCategoryName() {
            return categoryName;
        }
        
        public void setCategoryName(String categoryName) {
            this.categoryName = categoryName;
        }
    }

    // Customer Model Class (needed for Transaction)
    public static class Customer {
        private int customerId;
        private String accountNumber;
        private String name;
        private String address;
        private String phone;
        private String username;
        private String email;
        private String password;
        private UserRole role;
        private User createdBy;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        public Customer() {}
        
        public Customer(int customerId, String accountNumber, String name, String address, String phone) {
            this.customerId = customerId;
            this.accountNumber = accountNumber;
            this.name = name;
            this.address = address;
            this.phone = phone;
        }
        
        // Getters and Setters
        public int getCustomerId() {
            return customerId;
        }
        
        public void setCustomerId(int customerId) {
            this.customerId = customerId;
        }
        
        public String getAccountNumber() {
            return accountNumber;
        }
        
        public void setAccountNumber(String accountNumber) {
            this.accountNumber = accountNumber;
        }
        
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public String getAddress() {
            return address;
        }
        
        public void setAddress(String address) {
            this.address = address;
        }
        
        public String getPhone() {
            return phone;
        }
        
        public void setPhone(String phone) {
            this.phone = phone;
        }
        
        public String getUsername() {
            return username;
        }
        
        public void setUsername(String username) {
            this.username = username;
        }
        
        public void setEmail(String email) {
            this.email = email;
        }
        
        public String getEmail() {
            return email;
        }
        
        public void setPassword(String password) {
            this.password = password;
        }
        
        public String getPassword() {
            return password;
        }
        
        public UserRole getRole() {
            return role;
        }
        
        public void setRole(UserRole role) {
            this.role = role;
        }
        
        public User getCreatedBy() {
            return createdBy;
        }
        
        public void setCreatedBy(User createdBy) {
            this.createdBy = createdBy;
        }
        
        public Timestamp getCreatedAt() {
            return createdAt;
        }
        
        public void setCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
        }
        
        public Timestamp getUpdatedAt() {
            return updatedAt;
        }
        
        public void setUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
        }
    }

    // User Model Class (needed for Transaction and Customer)
    public static class User {
        private int userId;
        private String username;
        private String password;
        private String email;
        private UserRole role;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        public User() {}
        
        public User(int userId, String username, String password, String email, UserRole role) {
            this.userId = userId;
            this.username = username;
            this.password = password;
            this.email = email;
            this.role = role;
        }
        
        // Getters and Setters
        public int getUserId() {
            return userId;
        }
        
        public void setUserId(int userId) {
            this.userId = userId;
        }
        
        public String getUsername() {
            return username;
        }
        
        public void setUsername(String username) {
            this.username = username;
        }
        
        public String getPassword() {
            return password;
        }
        
        public void setPassword(String password) {
            this.password = password;
        }
        
        public String getEmail() {
            return email;
        }
        
        public void setEmail(String email) {
            this.email = email;
        }
        
        public UserRole getRole() {
            return role;
        }
        
        public void setRole(UserRole role) {
            this.role = role;
        }
        
        public Timestamp getCreatedAt() {
            return createdAt;
        }
        
        public void setCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
        }
        
        public Timestamp getUpdatedAt() {
            return updatedAt;
        }
        
        public void setUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
        }
    }

    // UserRole Model Class (needed for User and Customer)
    public static class UserRole {
        private int roleId;
        private String roleName;
        
        public UserRole() {}
        
        public UserRole(int roleId, String roleName) {
            this.roleId = roleId;
            this.roleName = roleName;
        }
        
        // Getters and Setters
        public int getRoleId() {
            return roleId;
        }
        
        public void setRoleId(int roleId) {
            this.roleId = roleId;
        }
        
        public String getRoleName() {
            return roleName;
        }
        
        public void setRoleName(String roleName) {
            this.roleName = roleName;
        }
    }

    // Transaction DAO Methods
    public boolean createTransaction(Transaction transaction) {
        String sql = "INSERT INTO sales (customer_id, total_amount, created_by) VALUES (?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, transaction.getCustomer().getCustomerId());
            pstmt.setBigDecimal(2, transaction.getTotalAmount());
            pstmt.setInt(3, transaction.getCreatedBy().getUserId());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                // Get the generated transaction ID
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        transaction.setTransactionId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating transaction: " + e.getMessage());
            return false;
        }
    }
    
    public boolean createTransactionItem(TransactionItem item) {
        String sql = "INSERT INTO sales_items (transaction_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, item.getTransaction().getTransactionId());
            pstmt.setInt(2, item.getBook().getBookId());
            pstmt.setInt(3, item.getQuantity());
            pstmt.setBigDecimal(4, item.getPrice());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating transaction item: " + e.getMessage());
            return false;
        }
    }
    
    public List<Transaction> getAllTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, c.name as customer_name, u.username as created_by_name FROM sales t " +
                    "LEFT JOIN customers c ON t.customer_id = c.customer_id " +
                    "LEFT JOIN users u ON t.created_by = u.user_id " +
                    "ORDER BY t.transaction_id DESC";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getInt("transaction_id"));
                transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
                transaction.setCreatedAt(rs.getTimestamp("created_at"));
                
                // Set customer
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("customer_name"));
                transaction.setCustomer(customer);
                
                // Set created by user
                User createdBy = new User();
                createdBy.setUserId(rs.getInt("created_by"));
                createdBy.setUsername(rs.getString("created_by_name"));
                transaction.setCreatedBy(createdBy);
                
                // Get transaction items
                List<TransactionItem> items = getTransactionItems(transaction.getTransactionId());
                transaction.setItems(items);
                
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all transactions: " + e.getMessage());
        }
        return transactions;
    }
    
    public List<Transaction> getTransactionsByCustomer(int customerId) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, c.name as customer_name, u.username as created_by_name FROM sales t " +
                    "LEFT JOIN customers c ON t.customer_id = c.customer_id " +
                    "LEFT JOIN users u ON t.created_by = u.user_id " +
                    "WHERE t.customer_id = ? " +
                    "ORDER BY t.transaction_id DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(rs.getInt("transaction_id"));
                    transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
                    transaction.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Set customer
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setName(rs.getString("customer_name"));
                    transaction.setCustomer(customer);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    transaction.setCreatedBy(createdBy);
                    
                    // Get transaction items
                    List<TransactionItem> items = getTransactionItems(transaction.getTransactionId());
                    transaction.setItems(items);
                    
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transactions by customer: " + e.getMessage());
        }
        return transactions;
    }
    
    // Adapter Pattern for Data Format Conversion
    public interface DataFormatter {
        String formatData(Object data);
    }
    
    public static class JSONFormatter implements DataFormatter {
        @Override
        public String formatData(Object data) {
            // Simple JSON-like formatting for debugging
            if (data instanceof Transaction) {
                Transaction t = (Transaction) data;
                return String.format("{\"id\":%d,\"customer\":\"%s\",\"amount\":%.2f}", 
                    t.getTransactionId(), 
                    t.getCustomer().getName(), 
                    t.getTotalAmount());
            }
            return data.toString();
        }
    }
    
    public static class XMLFormatter implements DataFormatter {
        @Override
        public String formatData(Object data) {
            // Simple XML-like formatting for debugging
            if (data instanceof Transaction) {
                Transaction t = (Transaction) data;
                return String.format("<transaction><id>%d</id><customer>%s</customer><amount>%.2f</amount></transaction>", 
                    t.getTransactionId(), 
                    t.getCustomer().getName(), 
                    t.getTotalAmount());
            }
            return "<data>" + data.toString() + "</data>";
        }
    }
    
    public static class DataFormatAdapter {
        private DataFormatter formatter;
        
        public DataFormatAdapter(DataFormatter formatter) {
            this.formatter = formatter;
        }
        
        public String format(Object data) {
            return formatter.formatData(data);
        }
    }
    
    /**
     * Debug method to check database structure
     */
    private void debugDatabaseStructure() {
        System.out.println("=== Database Structure Debug ===");
        
        try (Connection conn = getConnection()) {
            // Check transactions table
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM sales LIMIT 1")) {
                java.sql.ResultSetMetaData metaData = rs.getMetaData();
                System.out.println("Transactions table columns:");
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    System.out.println("  " + i + ". " + metaData.getColumnName(i) + " (" + metaData.getColumnTypeName(i) + ")");
                }
            }
            
            // Check transaction_items table
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM transaction_items LIMIT 1")) {
                java.sql.ResultSetMetaData metaData = rs.getMetaData();
                System.out.println("Transaction_items table columns:");
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    System.out.println("  " + i + ". " + metaData.getColumnName(i) + " (" + metaData.getColumnTypeName(i) + ")");
                }
            }
            
            // Check sample data
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM sales")) {
                if (rs.next()) {
                    System.out.println("Total transactions in database: " + rs.getInt("count"));
                }
            }
            
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM transaction_items")) {
                if (rs.next()) {
                    System.out.println("Total transaction items in database: " + rs.getInt("count"));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking database structure: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Iterator Pattern for Transaction Items
    public static class TransactionItemIterator implements Iterator<TransactionItem> {
        private List<TransactionItem> items;
        private int position = 0;
        
        public TransactionItemIterator(List<TransactionItem> items) {
            this.items = items;
        }
        
        @Override
        public boolean hasNext() {
            return position < items.size();
        }
        
        @Override
        public TransactionItem next() {
            if (hasNext()) {
                return items.get(position++);
            }
            throw new java.util.NoSuchElementException();
        }
        
        public void reset() {
            position = 0;
        }
    }
    
    public List<TransactionItem> getTransactionItems(int transactionId) {
        List<TransactionItem> items = new ArrayList<>();
        
        // First, let's check if the transaction_items table has any data for this transaction
        String checkSql = "SELECT COUNT(*) as count FROM sales_items WHERE transaction_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            
            checkStmt.setInt(1, transactionId);
            try (ResultSet checkRs = checkStmt.executeQuery()) {
                if (checkRs.next()) {
                    int count = checkRs.getInt("count");
                    System.out.println("=== getTransactionItems Debug ===");
                    System.out.println("Looking for items with transaction_id: " + transactionId);
                    System.out.println("Raw count from transaction_items table: " + count);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking transaction items count: " + e.getMessage());
        }
        
        // Now try to get the full item details with book category information
        String sql = "SELECT ti.*, b.title as book_title, b.description, bc.category_id, bc.category_name " +
                    "FROM sales_items ti " +
                    "LEFT JOIN books b ON ti.book_id = b.book_id " +
                    "LEFT JOIN categories bc ON b.category_id = bc.category_id " +
                    "WHERE ti.transaction_id = ?";
        
        System.out.println("SQL Query: " + sql);
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, transactionId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                int itemCount = 0;
                while (rs.next()) {
                    itemCount++;
                    
                    // Debug: Check raw price value from database
                    java.math.BigDecimal rawPrice = rs.getBigDecimal("price");
                    System.out.println("  Raw price from database: " + rawPrice + " (type: " + (rawPrice != null ? rawPrice.getClass().getSimpleName() : "NULL") + ")");
                    
                    TransactionItem item = new TransactionItem();
                    item.setTransactionItemId(rs.getInt("transaction_item_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rawPrice);
                    
                    // Debug: Check price after setting
                    System.out.println("  Price after setting: " + item.getPrice() + " (null? " + (item.getPrice() == null) + ")");
                    
                    // Set book
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("book_title"));
                    
                    // Set book category from database
                    BookCategory category = new BookCategory();
                    int categoryId = rs.getInt("category_id");
                    String categoryName = rs.getString("category_name");
                    
                    if (categoryId > 0 && categoryName != null && !categoryName.trim().isEmpty()) {
                        category.setCategoryId(categoryId);
                        category.setCategoryName(categoryName);
                    } else {
                        category.setCategoryId(0);
                        category.setCategoryName("N/A");
                    }
                    book.setCategory(category);
                    
                    item.setBook(book);
                    
                    System.out.println("  Found item " + itemCount + ": Book=" + book.getTitle() + 
                                     ", Qty=" + item.getQuantity() + ", Price=" + item.getPrice() + 
                                     ", Category=" + book.getCategory().getCategoryName() + 
                                     ", Price null check: " + (item.getPrice() == null));
                    
                    items.add(item);
                }
                System.out.println("Total items found: " + itemCount);
                
                // If no items found, let's debug the raw data
                if (itemCount == 0) {
                    System.out.println("No items found. Let's check raw transaction_items data:");
                    String rawSql = "SELECT * FROM sales_items WHERE transaction_id = ?";
                    try (PreparedStatement rawStmt = conn.prepareStatement(rawSql)) {
                        rawStmt.setInt(1, transactionId);
                        try (ResultSet rawRs = rawStmt.executeQuery()) {
                            while (rawRs.next()) {
                                System.out.println("  Raw item: ID=" + rawRs.getInt("transaction_item_id") + 
                                                 ", TransactionID=" + rawRs.getInt("transaction_id") + 
                                                 ", BookID=" + rawRs.getInt("book_id") + 
                                                 ", Qty=" + rawRs.getInt("quantity") + 
                                                 ", Price=" + rawRs.getBigDecimal("price"));
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transaction items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    public Transaction getTransactionById(int transactionId) {
        String sql = "SELECT t.*, c.name as customer_name, u.username as created_by_name FROM sales t " +
                    "LEFT JOIN customers c ON t.customer_id = c.customer_id " +
                    "LEFT JOIN users u ON t.created_by = u.user_id " +
                    "WHERE t.transaction_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, transactionId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(rs.getInt("transaction_id"));
                    transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
                    transaction.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Set customer
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setName(rs.getString("customer_name"));
                    transaction.setCustomer(customer);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    transaction.setCreatedBy(createdBy);
                    
                    // Get transaction items
                    List<TransactionItem> items = getTransactionItems(transactionId);
                    transaction.setItems(items);
                    
                    return transaction;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transaction by ID: " + e.getMessage());
        }
        return null;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        // Get current user's role
        String currentUserRole = (String) session.getAttribute("role");
        
        // If no action specified, default to list
        if (action == null || action.isEmpty()) {
            action = "list";
        }
        
        // Check role-based access
        if (!hasAccess(currentUserRole, action)) {
            response.sendRedirect("transaction.jsp?error=Access denied.");
            return;
        }

        switch (action) {
            case "view":
                handleViewTransaction(request, response, session);
                break;
            case "list":
                handleListTransactions(request, response, session);
                break;
            case "create":
                handleCreateTransaction(request, response, session);
                break;
            default:
                response.sendRedirect("transaction.jsp?error=Invalid action.");
        }
    }

    // Strategy Pattern for Access Control
    public interface AccessStrategy {
        boolean hasAccess(String action);
    }
    
    public static class AdminAccessStrategy implements AccessStrategy {
        @Override
        public boolean hasAccess(String action) {
            return true; // Admin has access to everything
        }
    }
    
    public static class ManagerStaffAccessStrategy implements AccessStrategy {
        @Override
        public boolean hasAccess(String action) {
            return "view".equals(action) || "list".equals(action) || "create".equals(action);
        }
    }
    
    public static class CustomerAccessStrategy implements AccessStrategy {
        @Override
        public boolean hasAccess(String action) {
            return "view".equals(action) || "list".equals(action);
        }
    }
    
    public static class AccessStrategyFactory {
        public static AccessStrategy getStrategy(String userRole) {
            if ("ADMIN".equals(userRole)) {
                return new AdminAccessStrategy();
            } else if ("MANAGER".equals(userRole) || "STAFF".equals(userRole)) {
                return new ManagerStaffAccessStrategy();
            } else if ("CUSTOMER".equals(userRole)) {
                return new CustomerAccessStrategy();
            }
            return new CustomerAccessStrategy(); // Default to most restrictive
        }
    }
    
    private boolean hasAccess(String currentUserRole, String action) {
        AccessStrategy strategy = AccessStrategyFactory.getStrategy(currentUserRole);
        return strategy.hasAccess(action);
    }

    private void handleCreateTransaction(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        response.setContentType("application/json");
        
        try {
            // Read JSON data from request body
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            String jsonData = sb.toString();
            
            // Debug: Log the received JSON
            System.out.println("Received JSON: " + jsonData);
            
            // Parse JSON data using simple regex patterns
            int customerId = extractIntValue(jsonData, "customerId");
            BigDecimal totalAmount = new BigDecimal(extractStringValue(jsonData, "totalAmount"));
            String itemsJson = extractArrayValue(jsonData, "items");
            
            // Get customer from database
            Customer customer = getCustomerById(customerId);
            if (customer == null) {
                sendErrorResponse(response, "Customer not found with ID: " + customerId);
                return;
            }
            
            // Get current user from database
            String username = (String) session.getAttribute("username");
            if (username == null) {
                sendErrorResponse(response, "User session not found. Please login again.");
                return;
            }
            User currentUser = getUserByUsername(username);
            if (currentUser == null) {
                sendErrorResponse(response, "User not found: " + username);
                return;
            }
            
            // Create transaction
            Transaction transaction = new Transaction();
            transaction.setCustomer(customer);
            transaction.setTotalAmount(totalAmount);
            transaction.setCreatedBy(currentUser);
            
            // Parse items array
            List<TransactionItem> items = parseItemsArray(itemsJson);
            
            // Validate items
            for (TransactionItem item : items) {
                // Load the actual book data from database
                Book book = getBookById(item.getBook().getBookId());
                if (book == null) {
                    sendErrorResponse(response, "Book not found with ID: " + item.getBook().getBookId());
                    return;
                }
                
                // Check stock availability
                if (book.getStockQuantity() < item.getQuantity()) {
                    sendErrorResponse(response, "Insufficient stock for book: " + book.getTitle() + ". Available: " + book.getStockQuantity() + ", Requested: " + item.getQuantity());
                    return;
                }
                
                item.setBook(book);
            }
            
            transaction.setItems(items);
            
            // Save transaction
            boolean success = createTransaction(transaction);
            
            if (success) {
                // Save transaction items
                for (TransactionItem item : items) {
                    item.setTransaction(transaction);
                    boolean itemSuccess = createTransactionItem(item);
                    if (!itemSuccess) {
                        sendErrorResponse(response, "Failed to create transaction item for book: " + item.getBook().getTitle());
                        return;
                    }
                }
                
                // Update book stock
                for (TransactionItem item : items) {
                    Book book = item.getBook();
                    int newStock = book.getStockQuantity() - item.getQuantity();
                    
                    // Update stock in database
                    String updateSql = "UPDATE books SET stock_quantity = ? WHERE book_id = ?";
                    try (Connection conn = getConnection();
                         PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                        
                        pstmt.setInt(1, newStock);
                        pstmt.setInt(2, book.getBookId());
                        
                        int rowsAffected = pstmt.executeUpdate();
                        if (rowsAffected > 0) {
                            System.out.println("Book stock updated: " + book.getTitle() + " -> " + newStock);
                        } else {
                            System.err.println("Failed to update stock for book: " + book.getTitle());
                        }
                    } catch (SQLException e) {
                        System.err.println("Error updating book stock: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
                
                // Prepare response data
                StringBuilder responseData = new StringBuilder();
                responseData.append("{\"success\":true,");
                responseData.append("\"transactionId\":").append(transaction.getTransactionId()).append(",");
                responseData.append("\"transaction\":{");
                responseData.append("\"transactionId\":").append(transaction.getTransactionId()).append(",");
                responseData.append("\"customerName\":\"").append(customer.getName()).append("\",");
                responseData.append("\"items\":[");
                
                for (int i = 0; i < items.size(); i++) {
                    TransactionItem item = items.get(i);
                    responseData.append("{");
                    responseData.append("\"title\":\"").append(item.getBook().getTitle()).append("\",");
                    responseData.append("\"quantity\":").append(item.getQuantity()).append(",");
                    responseData.append("\"price\":").append(item.getPrice());
                    responseData.append("}");
                    if (i < items.size() - 1) {
                        responseData.append(",");
                    }
                }
                
                responseData.append("]}");
                responseData.append("}");
                
                String finalResponse = responseData.toString();
                System.out.println("Sending response: " + finalResponse);
                
                // Log successful transaction
                // eventManager.logEvent("Transaction created successfully: " + transaction.getTransactionId(), "INFO"); // eventManager is removed
                
                response.getWriter().write(finalResponse);
            } else {
                sendErrorResponse(response, "Failed to create transaction");
            }
            
        } catch (Exception e) {
            // eventManager.logEvent("Transaction creation error: " + e.getMessage(), "ERROR"); // eventManager is removed
            System.err.println("Transaction creation error: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Error creating transaction: " + e.getMessage());
        }
    }

    /**
     * Get customer by ID from database
     */
    private Customer getCustomerById(int customerId) {
        String sql = "SELECT * FROM customers WHERE customer_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                    customer.setUsername(rs.getString("username"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error loading customer: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get user by username from database
     */
    private User getUserByUsername(String username) {
        String sql = "SELECT u.*, ur.role_name FROM users u " +
                    "LEFT JOIN roles ur ON u.role_id = ur.role_id " +
                    "WHERE u.username = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    
                    UserRole role = new UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    role.setRoleName(rs.getString("role_name"));
                    user.setRole(role);
                    
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error loading user: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get book by ID from database
     */
    private Book getBookById(int bookId) {
        String sql = "SELECT b.*, bc.category_name FROM books b " +
                    "LEFT JOIN categories bc ON b.category_id = bc.category_id " +
                    "WHERE b.book_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                    book.setStockQuantity(rs.getInt("stock_quantity"));
                    
                    // Set category
                    BookCategory category = new BookCategory();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    book.setCategory(category);
                    
                    return book;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error loading book: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    private List<TransactionItem> parseItemsArray(String itemsJson) throws Exception {
        List<TransactionItem> items = new ArrayList<>();
        
        // Simple regex to extract items from JSON array
        Pattern itemPattern = Pattern.compile("\\{[^}]*\\}");
        Matcher matcher = itemPattern.matcher(itemsJson);
        
        while (matcher.find()) {
            String itemJson = matcher.group();
            int bookId = extractIntValue(itemJson, "bookId");
            int quantity = extractIntValue(itemJson, "quantity");
            BigDecimal price = new BigDecimal(extractStringValue(itemJson, "price"));
            
            Book book = new Book();
            book.setBookId(bookId);
            
            TransactionItem item = new TransactionItem();
            item.setBook(book);
            item.setQuantity(quantity);
            item.setPrice(price);
            items.add(item);
        }
        
        return items;
    }

    private int extractIntValue(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\":\\s*(\\d+)");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return Integer.parseInt(matcher.group(1));
        }
        throw new RuntimeException("Could not find " + key + " in JSON");
    }

    private String extractStringValue(String json, String key) {
        // First try to find string value
        Pattern pattern = Pattern.compile("\"" + key + "\":\\s*\"([^\"]*)\"");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        
        // If not found as string, try to find as number
        Pattern numberPattern = Pattern.compile("\"" + key + "\":\\s*([0-9]+\\.?[0-9]*)");
        Matcher numberMatcher = numberPattern.matcher(json);
        if (numberMatcher.find()) {
            return numberMatcher.group(1);
        }
        
        throw new RuntimeException("Could not find " + key + " in JSON: " + json.substring(0, Math.min(200, json.length())));
    }

    private String extractArrayValue(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\":\\s*\\[(.*?)\\]", Pattern.DOTALL);
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        throw new RuntimeException("Could not find " + key + " array in JSON");
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        String errorData = "{\"success\":false,\"message\":\"" + message + "\"}";
        response.getWriter().write(errorData);
    }

    private void handleViewTransaction(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            // Debug all request parameters
            System.out.println("=== handleViewTransaction Debug ===");
            System.out.println("All request parameters:");
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                System.out.println("  " + paramName + " = " + paramValue);
            }
            
            int transactionId = Integer.parseInt(request.getParameter("transaction_id"));
            System.out.println("Transaction ID requested: " + transactionId);
            
            // Debug database structure first
            debugDatabaseStructure();
            
            Transaction transaction = getTransactionById(transactionId);
            System.out.println("Transaction loaded: " + (transaction != null ? "YES" : "NO"));
            
            if (transaction != null) {
                System.out.println("Transaction ID: " + transaction.getTransactionId());
                System.out.println("Customer: " + transaction.getCustomer().getName());
                System.out.println("Total Amount: " + transaction.getTotalAmount());
                System.out.println("Items count: " + (transaction.getItems() != null ? transaction.getItems().size() : "NULL"));
                
                if (transaction.getItems() != null) {
                    for (int i = 0; i < transaction.getItems().size(); i++) {
                        TransactionItem item = transaction.getItems().get(i);
                        System.out.println("  Item " + (i+1) + ": Book=" + item.getBook().getTitle() + 
                                         ", Qty=" + item.getQuantity() + ", Price=" + item.getPrice());
                    }
                }
                
                // Check if customer is viewing their own transaction
                String currentUserRole = (String) session.getAttribute("role");
                if ("CUSTOMER".equals(currentUserRole)) {
                    int customerId = (Integer) session.getAttribute("userId");
                    if (transaction.getCustomer().getCustomerId() != customerId) {
                        response.sendRedirect("transaction.jsp?error=Access denied. You can only view your own transactions.");
                        return;
                    }
                }
                
                request.setAttribute("transaction", transaction);
                request.getRequestDispatcher("transaction_view.jsp").forward(request, response);
            } else {
                System.out.println("Transaction not found in database");
                response.sendRedirect("transaction.jsp?error=Transaction not found.");
            }

        } catch (Exception e) {
            System.err.println("Transaction view error: " + e.getMessage());
            e.printStackTrace();
            // eventManager.logEvent("Transaction view error: " + e.getMessage(), "ERROR"); // eventManager is removed
            response.sendRedirect("transaction.jsp?error=Error viewing transaction: " + e.getMessage());
        }
    }

    private void handleListTransactions(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String currentUserRole = (String) session.getAttribute("role");
            List<Transaction> transactions;
            
            if ("CUSTOMER".equals(currentUserRole)) {
                // Customer can only see their own transactions
                Integer customerId = (Integer) session.getAttribute("userId");
                System.out.println("CUSTOMER user - userId from session: " + customerId);
                
                if (customerId != null) {
                    transactions = getTransactionsByCustomer(customerId);
                    System.out.println("Found " + transactions.size() + " transactions for customer ID: " + customerId);
                } else {
                    // Fallback to customerId attribute if userId is not set
                    customerId = (Integer) session.getAttribute("customerId");
                    System.out.println("Fallback - customerId from session: " + customerId);
                    
                    if (customerId != null) {
                        transactions = getTransactionsByCustomer(customerId);
                        System.out.println("Found " + transactions.size() + " transactions for customer ID: " + customerId);
                    } else {
                        // No customer ID found, return empty list
                        System.out.println("No customer ID found in session, returning empty list");
                        transactions = new ArrayList<>();
                    }
                }
            } else {
                // Admin, Manager, Staff can see all transactions
                System.out.println("Non-CUSTOMER user - role: " + currentUserRole + ", showing all transactions");
                transactions = getAllTransactions();
                System.out.println("Found " + transactions.size() + " total transactions");
            }
            
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("transaction.jsp").forward(request, response);

        } catch (Exception e) {
            // eventManager.logEvent("Transaction list error: " + e.getMessage(), "ERROR"); // eventManager is removed
            response.sendRedirect("transaction.jsp?error=Error loading transactions: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Transaction Management Servlet";
    }
} 