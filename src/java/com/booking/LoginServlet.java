/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.UserServlet.User;
import com.booking.UserServlet.UserRole;
import com.booking.CustomerServlet;



import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pruso
 */
public class LoginServlet extends HttpServlet {





    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("Initializing database and patterns...");
        try {
            DatabaseUtil.initializeDatabase();
            
            // Initialize patterns
    
            
            
            // Initialize observers
            
            
            System.out.println("Database and patterns initialization completed successfully!");
            System.out.println("System initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing system: " + e.getMessage());
            System.err.println("System initialization failed: " + e.getMessage());
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else {
            handleLogin(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleId = request.getParameter("role_id");

            // Create user object
            UserRole role = new UserRole();
            role.setRoleId(Integer.parseInt(roleId));
            
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            // Register user using UserServlet
            UserServlet userServlet = new UserServlet();
            boolean success = userServlet.registerUser(user);

            if (success) {
                System.out.println("User registered successfully: " + username);
                response.sendRedirect("login.jsp?message=Registration successful! Please login.");
            } else {
                System.out.println("User registration failed: " + username);
                response.sendRedirect("login.jsp?error=Registration failed. Username or email might already exist.");
            }

        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            response.sendRedirect("login.jsp?error=Registration error: " + e.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // First try to authenticate as a regular user (ADMIN, MANAGER, STAFF)
            UserServlet userServlet = new UserServlet();
            User user = null;
            if (userServlet.authenticateUser(username, password)) {
                // Authentication successful, get the full user object
                user = userServlet.getUserByUsername(username);
            }

            if (user != null) {
                // Check if user has valid role (ADMIN=1, MANAGER=2, STAFF=3)
                String roleName = user.getRole().getRoleName();
                if ("ADMIN".equals(roleName) || "MANAGER".equals(roleName) || "STAFF".equals(roleName)) {
                    // Store user in session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("role", roleName);
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userType", "user");
                    
                    System.out.println("User logged in successfully: " + username + " (Role: " + roleName + ")");
                    
                    // Redirect based on role
                    if ("ADMIN".equals(roleName)) {
                        response.sendRedirect("dashboard.jsp");
                    } else if ("STAFF".equals(roleName)) {
                        response.sendRedirect("pos.jsp");
                    } else {
                        response.sendRedirect("DashboardServlet");
                    }
                    return;
                } else {
                    // User exists but has invalid role for users table
                    System.out.println("Login failed - invalid role for user: " + username + " (Role: " + roleName + ")");
                    response.sendRedirect("login.jsp?error=Invalid user role. Please contact administrator.");
                    return;
                }
            }
            
            // If not a regular user, try to authenticate as a customer (CUSTOMER role only)
            CustomerServlet customerServlet = new CustomerServlet();
            boolean customerAuthSuccess = customerServlet.authenticateCustomer(username, password);
            
            if (customerAuthSuccess) {
                // Get the full customer object to check role and set session
                com.booking.CustomerServlet.Customer customer = customerServlet.getCustomerByUsername(username);
                
                if (customer != null) {
                    // Check if customer has CUSTOMER role (role_id = 4)
                    String roleName = customer.getRole() != null ? customer.getRole().getRoleName() : "CUSTOMER";
                    
                    if ("CUSTOMER".equals(roleName)) {
                        // Store customer in session
                        HttpSession session = request.getSession();
                        session.setAttribute("user", customer);
                        session.setAttribute("username", customer.getUsername());
                        session.setAttribute("role", roleName);
                        session.setAttribute("userId", customer.getCustomerId());
                        session.setAttribute("userType", "customer");
                        session.setAttribute("customerId", customer.getCustomerId());
                        session.setAttribute("customerName", customer.getName());
                        
                        System.out.println("Customer logged in successfully: " + username + " (Role: " + roleName + ")");
                        response.sendRedirect("transaction.jsp");
                        return;
                    } else {
                        // Customer exists but has invalid role for customers table
                        System.out.println("Login failed - invalid role for customer: " + username + " (Role: " + roleName + ")");
                        response.sendRedirect("login.jsp?error=Invalid customer role. Please contact administrator.");
                        return;
                    }
                } else {
                    // Customer authentication succeeded but couldn't retrieve customer data
                    System.out.println("Login failed - customer data retrieval failed: " + username);
                    response.sendRedirect("login.jsp?error=Customer data retrieval failed. Please contact administrator.");
                    return;
                }
            }
            
            // If neither user nor customer authentication succeeded
            System.out.println("Login failed for username: " + username);
            response.sendRedirect("login.jsp?error=Invalid username or password.");

        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            response.sendRedirect("login.jsp?error=Login error: " + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
