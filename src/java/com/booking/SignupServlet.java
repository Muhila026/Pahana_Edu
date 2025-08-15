package com.booking;

// Customer and UserRole are inner classes, so we'll define them locally
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

/**
 * Servlet for handling Customer Registration operations
 */
public class SignupServlet extends HttpServlet {

    // Singleton Pattern - Database Connection Manager
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
    
    // Customer Model Class
    public static class Customer {
        private int customerId;
        private String accountNumber;
        private String name;
        private String email;
        private String phone;
        private String address;
        private String username;
        private String password;
        private UserRole role;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        
        // Getters and Setters
        public int getCustomerId() { return customerId; }
        public void setCustomerId(int customerId) { this.customerId = customerId; }
        
        public String getAccountNumber() { return accountNumber; }
        public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
        
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
        
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        
        public UserRole getRole() { return role; }
        public void setRole(UserRole role) { this.role = role; }
        
        public Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
        
        public Timestamp getUpdatedAt() { return updatedAt; }
        public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    }
    
    // UserRole Model Class
    public static class UserRole {
        private int roleId;
        private String roleName;
        
        public UserRole() {}
        
        public UserRole(int roleId, String roleName) {
            this.roleId = roleId;
            this.roleName = roleName;
        }
        
        // Getters and Setters
        public int getRoleId() { return roleId; }
        public void setRoleId(int roleId) { this.roleId = roleId; }
        
        public String getRoleName() { return roleName; }
        public void setRoleName(String roleName) { this.roleName = roleName; }
    }
    
    // Factory Pattern - Customer Creation
    public static class CustomerFactory {
        public static Customer createCustomer(String name, String email, String telephone, String address, String username, String password) {
            Customer customer = new Customer();
            customer.setName(name);
            customer.setEmail(email);
            customer.setPhone(telephone);
            customer.setAddress(address);
            customer.setPassword(password);
            customer.setUsername(username); // Use provided username
            // Note: account_number will be generated in saveCustomer method
            
            // Create UserRole with proper constructor
            UserRole customerRole = new UserRole();
            customerRole.setRoleId(4);
            customerRole.setRoleName("CUSTOMER");
            customer.setRole(customerRole);
            
            System.out.println("Created customer: " + customer.getName() + " with role: " + customer.getRole().getRoleName());
            return customer;
        }
    }
    
    // Strategy Pattern - Registration Validation
    public interface RegistrationValidationStrategy {
        boolean validate(String value);
        String getErrorMessage();
    }
    
    public static class NameValidationStrategy implements RegistrationValidationStrategy {
        @Override
        public boolean validate(String value) {
            return value != null && !value.trim().isEmpty() && value.trim().length() >= 2;
        }
        
        @Override
        public String getErrorMessage() {
            return "Name must be at least 2 characters long";
        }
    }
    
    public static class EmailValidationStrategy implements RegistrationValidationStrategy {
        @Override
        public boolean validate(String value) {
            return value != null && value.matches("^[A-Za-z0-9+_.-]+@(.+)$");
        }
        
        @Override
        public String getErrorMessage() {
            return "Please enter a valid email address";
        }
    }
    
    public static class PhoneValidationStrategy implements RegistrationValidationStrategy {
        @Override
        public boolean validate(String value) {
            return value != null && value.matches("^[0-9+\\-()\\s]+$");
        }
        
        @Override
        public String getErrorMessage() {
            return "Please enter a valid phone number";
        }
    }
    
    public static class PasswordValidationStrategy implements RegistrationValidationStrategy {
        @Override
        public boolean validate(String value) {
            return value != null && value.length() >= 6;
        }
        
        @Override
        public String getErrorMessage() {
            return "Password must be at least 6 characters long";
        }
    }
    
    // Chain of Responsibility Pattern - Validation Chain
    public static class ValidationChain {
        private List<RegistrationValidationStrategy> validators = new ArrayList<>();
        
        public ValidationChain addValidator(RegistrationValidationStrategy validator) {
            validators.add(validator);
            return this;
        }
        
        public ValidationResult validate(String name, String email, String phone, String address, String password) {
            ValidationResult result = new ValidationResult();
            
            // Validate each field
            if (!validators.get(0).validate(name)) {
                result.addError(validators.get(0).getErrorMessage());
            }
            if (!validators.get(1).validate(email)) {
                result.addError(validators.get(1).getErrorMessage());
            }
            if (!validators.get(2).validate(phone)) {
                result.addError(validators.get(2).getErrorMessage());
            }
            if (!validators.get(3).validate(password)) {
                result.addError(validators.get(3).getErrorMessage());
            }
            
            return result;
        }
    }
    
    public static class ValidationResult {
        private List<String> errors = new ArrayList<>();
        
        public void addError(String error) {
            errors.add(error);
        }
        
        public boolean isValid() {
            return errors.isEmpty();
        }
        
        public List<String> getErrors() {
            return errors;
        }
        
        public String getFirstError() {
            return errors.isEmpty() ? "" : errors.get(0);
        }
    }
    
    // Observer Pattern - Registration Events
    public interface RegistrationObserver {
        void onRegistrationSuccess(String email, String name);
        void onRegistrationFailure(String email, String reason);
    }
    
    public static class RegistrationLogger implements RegistrationObserver {
        @Override
        public void onRegistrationSuccess(String email, String name) {
            System.out.println("REGISTRATION_SUCCESS: " + email + " (" + name + ") at " + new java.util.Date());
        }
        
        @Override
        public void onRegistrationFailure(String email, String reason) {
            System.out.println("REGISTRATION_FAILURE: " + email + " - " + reason + " at " + new java.util.Date());
        }
    }
    
    public static class RegistrationEventManager {
        private static List<RegistrationObserver> observers = new ArrayList<>();
        
        public static void addObserver(RegistrationObserver observer) {
            observers.add(observer);
        }
        
        public static void notifySuccess(String email, String name) {
            for (RegistrationObserver observer : observers) {
                observer.onRegistrationSuccess(email, name);
            }
        }
        
        public static void notifyFailure(String email, String reason) {
            for (RegistrationObserver observer : observers) {
                observer.onRegistrationFailure(email, reason);
            }
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DatabaseConnectionManager.getInstance().getConnection();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set content type
        response.setContentType("text/html;charset=UTF-8");
        
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Initialize validation chain
        ValidationChain validationChain = new ValidationChain()
            .addValidator(new NameValidationStrategy())
            .addValidator(new EmailValidationStrategy())
            .addValidator(new PhoneValidationStrategy())
            .addValidator(new PasswordValidationStrategy());
        
        // Validate input
        ValidationResult validationResult = validationChain.validate(name, email, telephone, address, password);
        
        if (!validationResult.isValid()) {
            // Redirect back with validation error
            response.sendRedirect("register.jsp?error=" + validationResult.getFirstError());
            return;
        }
        
        try {
            System.out.println("=== Registration Process Started ===");
            System.out.println("Name: " + name);
            System.out.println("Email: " + email);
            System.out.println("Phone: " + telephone);
            System.out.println("Address: " + address);
            
            // Check if email already exists
            System.out.println("Checking if email exists...");
            if (isEmailExists(email)) {
                System.out.println("Email already exists: " + email);
                response.sendRedirect("register.jsp?error=Email address already registered. Please use a different email or login.");
                return;
            }
            System.out.println("Email is unique, proceeding...");
            
            // Create customer using factory
            System.out.println("Creating customer object...");
            Customer customer = CustomerFactory.createCustomer(name, email, telephone, address, username, password);
            System.out.println("Customer object created successfully");
            System.out.println("Note: created_by will be set to 1 (hardcoded)");
            
            // Save customer to database
            System.out.println("Attempting to save customer to database...");
            boolean success = saveCustomer(customer);
            System.out.println("Database save result: " + success);
            
            if (success) {
                // Notify observers of success
                RegistrationEventManager.notifySuccess(email, name);
                
                // Redirect to login with success message
                System.out.println("Registration successful, redirecting to login...");
                response.sendRedirect("login.jsp?success=Registration successful! Please login with your email and password.");
            } else {
                // Notify observers of failure
                RegistrationEventManager.notifyFailure(email, "Database save failed");
                
                System.out.println("Database save failed");
                response.sendRedirect("register.jsp?error=Registration failed. Please try again.");
            }
            
        } catch (Exception e) {
            System.err.println("=== EXCEPTION IN REGISTRATION ===");
            System.err.println("Error in SignupServlet: " + e.getMessage());
            System.err.println("Exception type: " + e.getClass().getName());
            e.printStackTrace();
            
            // Notify observers of failure
            RegistrationEventManager.notifyFailure(email, "Exception: " + e.getMessage());
            
            response.sendRedirect("register.jsp?error=An error occurred during registration. Please try again.");
        }
    }
    
    private boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM customers WHERE email = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    private boolean saveCustomer(Customer customer) throws SQLException {
        // Generate unique account number
        String accountNumber = generateAccountNumber();
        System.out.println("Generated account number: " + accountNumber);
        
        String sql = "INSERT INTO customers (account_number, name, email, phone, address, username, password, role_id, created_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, accountNumber);
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getEmail());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getAddress());
            pstmt.setString(6, customer.getUsername());
            pstmt.setString(7, customer.getPassword());
            pstmt.setInt(8, customer.getRole().getRoleId());
            pstmt.setInt(9, 1); // Always set created_by to 1
            
            int result = pstmt.executeUpdate();
            System.out.println("Customer insert result: " + result + " rows affected");
            System.out.println("Created by user ID: 1 (hardcoded)");
            return result > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error in saveCustomer: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            throw e;
        }
    }
    
    // Generate unique account number with C prefix
    private String generateAccountNumber() throws SQLException {
        String sql = "SELECT MAX(CAST(SUBSTRING(account_number, 2) AS UNSIGNED)) as max_num FROM customers WHERE account_number LIKE 'C%'";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = pstmt.executeQuery()) {
                int nextNumber = 1; // Default to 1 if no customers exist
                
                if (rs.next()) {
                    int maxNum = rs.getInt("max_num");
                    if (maxNum > 0) {
                        nextNumber = maxNum + 1;
                    }
                }
                
                // Format: C000001, C000002, C000003, etc.
                String accountNumber = "C" + String.format("%06d", nextNumber);
                System.out.println("Generated sequential account number: " + accountNumber);
                return accountNumber;
            }
        } catch (SQLException e) {
            System.err.println("Error generating account number: " + e.getMessage());
            e.printStackTrace();
            // Fallback: return a default account number
            return "C000001";
        }
    }
    

    
    @Override
    public void init() throws ServletException {
        super.init();
        // Register observers
        RegistrationEventManager.addObserver(new RegistrationLogger());
    }
}
