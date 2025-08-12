package com.pahana;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/customer-management.jsp", "/customer-edit.jsp", "/customer-view.jsp"})
public class CustomerAccessControlFilter implements Filter {

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

        // Check if user is logged in and is admin or manager
        if (!isAdminOrManager(session)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/welcome.jsp");
            return;
        }

        // Continue with the request if user is admin or manager
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }

    private boolean isAdminOrManager(HttpSession session) {
        if (session == null || session.getAttribute("loggedIn") == null) {
            return false;
        }
        
        Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
        if (!loggedIn) {
            return false;
        }

        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        
        return "admin".equals(userType) || "Admin".equals(role) || "Manager".equals(role);
    }
} 