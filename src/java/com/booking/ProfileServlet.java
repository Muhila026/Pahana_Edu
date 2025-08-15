package com.booking;

import com.booking.UserServlet.User;
import com.booking.CustomerServlet.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling Profile operations
 */
public class ProfileServlet extends HttpServlet {

    // Singleton Pattern - Profile Manager
    private static class ProfileManager {
        private static ProfileManager instance;
        private static final int MAX_PASSWORD_LENGTH = 50;
        private static final int MIN_PASSWORD_LENGTH = 6;
        
        private ProfileManager() {}
        
        public static synchronized ProfileManager getInstance() {
            if (instance == null) {
                instance = new ProfileManager();
            }
            return instance;
        }
        
        public boolean isPasswordValid(String password) {
            return password != null && 
                   password.length() >= MIN_PASSWORD_LENGTH && 
                   password.length() <= MAX_PASSWORD_LENGTH;
        }
        
        public String getPasswordValidationMessage() {
            return "Password must be between " + MIN_PASSWORD_LENGTH + " and " + MAX_PASSWORD_LENGTH + " characters";
        }
    }
    
    // Strategy Pattern - Profile Update Strategies
    public interface ProfileUpdateStrategy {
        boolean canUpdate(String userRole);
        String getUpdateMessage();
    }
    
    public static class AdminProfileStrategy implements ProfileUpdateStrategy {
        @Override
        public boolean canUpdate(String userRole) {
            return "ADMIN".equals(userRole);
        }
        
        @Override
        public String getUpdateMessage() {
            return "Admin profile updated successfully";
        }
    }
    
    public static class ManagerProfileStrategy implements ProfileUpdateStrategy {
        @Override
        public boolean canUpdate(String userRole) {
            return "MANAGER".equals(userRole);
        }
        
        @Override
        public String getUpdateMessage() {
            return "Manager profile updated successfully";
        }
    }
    
    public static class StaffProfileStrategy implements ProfileUpdateStrategy {
        @Override
        public boolean canUpdate(String userRole) {
            return "STAFF".equals(userRole);
        }
        
        @Override
        public String getUpdateMessage() {
            return "Staff profile updated successfully";
        }
    }
    
    public static class CustomerProfileStrategy implements ProfileUpdateStrategy {
        @Override
        public boolean canUpdate(String userRole) {
            return "CUSTOMER".equals(userRole);
        }
        
        @Override
        public String getUpdateMessage() {
            return "Customer profile updated successfully";
        }
    }
    
    // Factory Pattern - Profile Strategy Factory
    public static class ProfileStrategyFactory {
        public static ProfileUpdateStrategy getStrategy(String userRole) {
            switch (userRole) {
                case "ADMIN":
                    return new AdminProfileStrategy();
                case "MANAGER":
                    return new ManagerProfileStrategy();
                case "STAFF":
                    return new StaffProfileStrategy();
                case "CUSTOMER":
                    return new CustomerProfileStrategy();
                default:
                    return new CustomerProfileStrategy(); // Default strategy
            }
        }
    }
    
    // Command Pattern - Profile Operations
    public interface ProfileCommand {
        void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    }
    
    public static class UpdateProfileCommand implements ProfileCommand {
        @Override
        public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Implementation will be added here
            System.out.println("Executing UpdateProfileCommand");
        }
    }
    
    public static class ChangePasswordCommand implements ProfileCommand {
        @Override
        public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Implementation will be added here
            System.out.println("Executing ChangePasswordCommand");
        }
    }
    
    // Command Invoker
    public static class ProfileCommandInvoker {
        private ProfileCommand command;
        
        public void setCommand(ProfileCommand command) {
            this.command = command;
        }
        
        public void executeCommand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            if (command != null) {
                command.execute(request, response);
            }
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || role == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "view";
        }

        try {
            switch (action) {
                case "update":
                    updateProfile(request, response);
                    break;
                case "changePassword":
                    updateProfile(request, response);
                    break;
                case "updateProfile":
                    updateProfileInfo(request, response);
                    break;
                default:
                    response.sendRedirect("profile.jsp");
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in ProfileServlet: " + e.getMessage());
            response.sendRedirect("profile.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?error=Current password is required.");
            return;
        }
        
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("profile.jsp?error=New passwords do not match.");
                return;
            }
        }

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if ("ADMIN".equals(role) || "MANAGER".equals(role) || "STAFF".equals(role)) {
            updateUserProfile(request, response, currentPassword, newPassword);
        } else if ("CUSTOMER".equals(role)) {
            updateCustomerProfile(request, response, currentPassword, newPassword);
        } else {
            response.sendRedirect("profile.jsp?error=Invalid user type.");
        }
    }

    private void updateProfileInfo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        String email = request.getParameter("email");
        
        if (username == null || role == null) {
            response.sendRedirect("profile.jsp?error=User session not found.");
            return;
        }
        
        if ("ADMIN".equals(role) || "MANAGER".equals(role) || "STAFF".equals(role)) {
            updateUserProfileInfo(request, response, username, email);
        } else if ("CUSTOMER".equals(role)) {
            updateCustomerProfileInfo(request, response, username, email);
        } else {
            response.sendRedirect("profile.jsp?error=Invalid user type.");
        }
    }

    private void updateUserProfile(HttpServletRequest request, HttpServletResponse response, 
                                 String currentPassword, String newPassword) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        String email = request.getParameter("email");
        
        // Verify current password
                    User user = new UserServlet().getUserByUsername(currentUser.getUsername());
        if (user == null || !user.getPassword().equals(currentPassword)) {
            response.sendRedirect("profile.jsp?error=Current password is incorrect.");
            return;
        }
        
        // Update user
        user.setEmail(email != null ? email.trim() : user.getEmail());
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            user.setPassword(newPassword.trim());
        }
        
                    boolean success = new UserServlet().updateUser(user);
        
        if (success) {
            // Update session
            session.setAttribute("user", user);
            // Invalidate session to force logout after password change
            session.invalidate();
            response.sendRedirect("login.jsp?message=Password updated successfully. Please login again with your new password.");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update profile.");
        }
    }

    private void updateUserProfileInfo(HttpServletRequest request, HttpServletResponse response, 
                                     String username, String email) throws ServletException, IOException {
        
        try {
            User user = new UserServlet().getUserByUsername(username);
            if (user == null) {
                response.sendRedirect("profile.jsp?error=User not found.");
                return;
            }
            
            // Update email if provided
            if (email != null && !email.trim().isEmpty()) {
                user.setEmail(email.trim());
            }
            
            boolean success = new UserServlet().updateUser(user);
            
            if (success) {
                // Update session
                request.getSession().setAttribute("user", user);
                // Invalidate session to force logout after profile update
                request.getSession().invalidate();
                response.sendRedirect("login.jsp?message=Profile information updated successfully. Please login again.");
            } else {
                response.sendRedirect("profile.jsp?error=Failed to update profile information.");
            }
            
        } catch (Exception e) {
            System.err.println("Error updating user profile info: " + e.getMessage());
            response.sendRedirect("profile.jsp?error=Error updating profile: " + e.getMessage());
        }
    }

    private void updateCustomerProfileInfo(HttpServletRequest request, HttpServletResponse response, 
                                         String username, String email) throws ServletException, IOException {
        
        try {
            Customer customer = new CustomerServlet().getCustomerByUsername(username);
            if (customer == null) {
                response.sendRedirect("profile.jsp?error=Customer not found.");
                return;
            }
            
            // Update email if provided
            if (email != null && !email.trim().isEmpty()) {
                customer.setEmail(email.trim());
            }
            
            boolean success = new CustomerServlet().updateCustomer(customer);
            
            if (success) {
                // Update session
                request.getSession().setAttribute("user", customer);
                // Invalidate session to force logout after profile update
                request.getSession().invalidate();
                response.sendRedirect("login.jsp?message=Profile information updated successfully. Please login again.");
            } else {
                response.sendRedirect("profile.jsp?error=Failed to update profile information.");
            }
            
        } catch (Exception e) {
            System.err.println("Error updating customer profile info: " + e.getMessage());
            response.sendRedirect("profile.jsp?error=Error updating profile: " + e.getMessage());
        }
    }

    private void updateCustomerProfile(HttpServletRequest request, HttpServletResponse response, 
                                     String currentPassword, String newPassword) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer currentCustomer = (Customer) session.getAttribute("user");
        String name = request.getParameter("name");
        
        // Verify current password
                    Customer customer = new CustomerServlet().getCustomerByUsername(currentCustomer.getUsername());
        if (customer == null || !customer.getPassword().equals(currentPassword)) {
            response.sendRedirect("profile.jsp?error=Current password is incorrect.");
            return;
        }
        
        // Update customer
        customer.setName(name != null ? name.trim() : customer.getName());
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            customer.setPassword(newPassword.trim());
        }
        
                    boolean success = new CustomerServlet().updateCustomer(customer);
        
        if (success) {
            // Update session
            session.setAttribute("user", customer);
            // Invalidate session to force logout after password change
            session.invalidate();
            response.sendRedirect("login.jsp?message=Password updated successfully. Please login again with your new password.");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update profile.");
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
        return "Profile Management Servlet";
    }
} 