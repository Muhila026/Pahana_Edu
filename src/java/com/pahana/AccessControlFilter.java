package com.pahana;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/category-management.jsp"})
public class AccessControlFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("loggedIn") == null || 
            !(Boolean) session.getAttribute("loggedIn")) {
            httpResponse.sendRedirect("login.jsp");
            return;
        }
        
        // Check if user has admin or manager role
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        
        boolean isAuthorized = "admin".equals(userType) || "Admin".equals(role) || "Manager".equals(role);
        
        if (!isAuthorized) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Admin or Manager privileges required.");
            return;
        }
        
        // User is authorized, continue with the request
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
} 