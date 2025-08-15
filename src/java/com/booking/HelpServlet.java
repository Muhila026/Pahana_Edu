package com.booking;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;


/**
 * Servlet for handling Help operations
 */
public class HelpServlet extends HttpServlet {

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
    
    // Factory Pattern - Help Section Creation
    public static class HelpSectionFactory {
        public static HelpSection createHelpSection(int helpId, String title, String content, Integer roleId) {
            HelpSection section = new HelpSection();
            section.setHelpId(helpId);
            section.setTitle(title);
            section.setContent(content);
            section.setRoleId(roleId);
            return section; 
        }
        
        public static HelpSection createHelpSectionFromRequest(String title, String content, Integer roleId) {
            return createHelpSection(0, title, content, roleId);
        }
    }
    
    // Builder Pattern - Help Section Builder
    public static class HelpSectionBuilder {
        private int helpId;
        private String title;
        private String content;
        private Integer roleId;
        
        public HelpSectionBuilder roleId(int roleId) {
            this.roleId = roleId;
            return this;
        }
        
        public HelpSectionBuilder helpId(int helpId) {
            this.helpId = helpId;
            return this;
        }
        
        public HelpSectionBuilder title(String title) {
            this.title = title;
            return this;
        }
        
        public HelpSectionBuilder content(String content) {
            this.content = content;
            return this;
        }
        
        public HelpSection build() {
            return HelpSectionFactory.createHelpSection(helpId, title, content, roleId);
        }
    }
    
    // Chain of Responsibility Pattern - Help Content Validation
    public abstract static class HelpContentValidator {
        protected HelpContentValidator nextValidator;
        
        public HelpContentValidator setNext(HelpContentValidator validator) {
            this.nextValidator = validator;
            return validator;
        }
        
        public abstract boolean validate(HelpSection helpSection);
        public abstract String getErrorMessage();
        
        protected boolean validateNext(HelpSection helpSection) {
            if (nextValidator != null) {
                return nextValidator.validate(helpSection);
            }
            return true;
        }
    }
    
    public static class TitleValidator extends HelpContentValidator {
        @Override
        public boolean validate(HelpSection helpSection) {
            if (helpSection.getTitle() == null || helpSection.getTitle().trim().isEmpty()) {
                return false;
            }
            return validateNext(helpSection);
        }
        
        @Override
        public String getErrorMessage() {
            return "Help section title is required";
        }
    }
    
    public static class ContentValidator extends HelpContentValidator {
        @Override
        public boolean validate(HelpSection helpSection) {
            if (helpSection.getContent() == null || helpSection.getContent().trim().isEmpty()) {
                return false;
            }
            return validateNext(helpSection);
        }
        
        @Override
        public String getErrorMessage() {
            return "Help section content is required";
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DatabaseConnectionManager.getInstance().getConnection();
    }

    // HelpSection Model Class
    public static class HelpSection {
        private int helpId;
        private String title;
        private String content;
        private Integer roleId;
        
        public HelpSection() {}
        
        public HelpSection(int helpId, String title, String content, Integer roleId) {
            this.helpId = helpId;
            this.title = title;
            this.content = content; 
            this.roleId = roleId;
        }
        
        // Getters and Setters
        public int getHelpId() {
            return helpId;
        }
        
        public void setHelpId(int helpId) {
            this.helpId = helpId;
        }
        
        public String getTitle() {
            return title;
        }
        
        public void setTitle(String title) {
            this.title = title;
        }
        
        public String getContent() {
            return content;
        }
        
        public void setContent(String content) {
            this.content = content;
        }
        
        public Integer getRoleId() {
            return roleId;
        }
        
        public void setRoleId(Integer roleId) {
            this.roleId = roleId;
        }
        
        @Override
        public String toString() {
            return "HelpSection{" + "helpId=" + helpId + ", title=" + title + '}';
        }
    }

    // Simple DTO for role options in forms
    public static class RoleOption {
        private final int roleId;
        private final String roleName;

        public RoleOption(int roleId, String roleName) {
            this.roleId = roleId;
            this.roleName = roleName;
        }

        public int getRoleId() {
            return roleId;
        }

        public String getRoleName() {
            return roleName;
        }
    }

    // HelpSection DAO Methods
    public boolean createHelpSection(HelpSection helpSection) {
        String sql = "INSERT INTO help_sections (title, content, role_id) VALUES (?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            if (helpSection.getRoleId() == null) {
                pstmt.setNull(3, Types.INTEGER);
            } else {
                pstmt.setInt(3, helpSection.getRoleId());
            }
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating help section: " + e.getMessage());
            return false;
        }
    }
    
    public List<HelpSection> getAllHelpSections() {
        List<HelpSection> helpSections = new ArrayList<>();
        String sql = "SELECT * FROM help_sections ORDER BY help_id";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                HelpSection helpSection = new HelpSection();
                helpSection.setHelpId(rs.getInt("help_id"));
                helpSection.setTitle(rs.getString("title"));
                helpSection.setContent(rs.getString("content"));
                int roleIdVal = rs.getInt("role_id");
                helpSection.setRoleId(rs.wasNull() ? null : roleIdVal);
                helpSections.add(helpSection);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all help sections: " + e.getMessage());
        }
        return helpSections;
    }

    public List<HelpSection> getHelpSectionsForRole(String roleName) {
        List<HelpSection> helpSections = new ArrayList<>();
        if (roleName == null) {
            return getAllHelpSections();
        }

        Integer roleId = getRoleIdByName(roleName);
        String sql = (roleId == null)
                ? "SELECT * FROM help_sections WHERE role_id IS NULL ORDER BY help_id"
                : "SELECT * FROM help_sections WHERE role_id IS NULL OR role_id = ? ORDER BY help_id";

        try (Connection conn = getConnection()) {
            if (roleId == null) {
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(sql)) {
                    while (rs.next()) {
                        HelpSection helpSection = new HelpSection();
                        helpSection.setHelpId(rs.getInt("help_id"));
                        helpSection.setTitle(rs.getString("title"));
                        helpSection.setContent(rs.getString("content"));
                        int roleIdVal = rs.getInt("role_id");
                        helpSection.setRoleId(rs.wasNull() ? null : roleIdVal);
                        helpSections.add(helpSection);
                    }
                }
            } else {
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, roleId);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        while (rs.next()) {
                            HelpSection helpSection = new HelpSection();
                            helpSection.setHelpId(rs.getInt("help_id"));
                            helpSection.setTitle(rs.getString("title"));
                            helpSection.setContent(rs.getString("content"));
                            int roleIdVal = rs.getInt("role_id");
                            helpSection.setRoleId(rs.wasNull() ? null : roleIdVal);
                            helpSections.add(helpSection);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting help sections for role: " + e.getMessage());
        }
        return helpSections;
    }

    private Integer getRoleIdByName(String roleName) {
        String sql = "SELECT role_id FROM roles WHERE role_name = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, roleName);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error resolving role id for '" + roleName + "': " + e.getMessage());
        }
        return null;
    }

    private List<RoleOption> getAllRoles() {
        List<RoleOption> roles = new ArrayList<>();
        String sql = "SELECT role_id, role_name FROM roles ORDER BY role_id";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                roles.add(new RoleOption(rs.getInt("role_id"), rs.getString("role_name")));
            }
        } catch (SQLException e) {
            System.err.println("Error loading roles: " + e.getMessage());
        }
        return roles;
    }
    
    public HelpSection getHelpSectionById(int helpId) {
        String sql = "SELECT * FROM help_sections WHERE help_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    HelpSection helpSection = new HelpSection();
                    helpSection.setHelpId(rs.getInt("help_id"));
                    helpSection.setTitle(rs.getString("title"));
                    helpSection.setContent(rs.getString("content"));
                    int roleIdVal = rs.getInt("role_id");
                    helpSection.setRoleId(rs.wasNull() ? null : roleIdVal);
                    return helpSection;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting help section by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateHelpSection(HelpSection helpSection) {
        String sql = "UPDATE help_sections SET title = ?, content = ?, role_id = ? WHERE help_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            if (helpSection.getRoleId() == null) {
                pstmt.setNull(3, Types.INTEGER);
            } else {
                pstmt.setInt(3, helpSection.getRoleId());
            }
            pstmt.setInt(4, helpSection.getHelpId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating help section: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteHelpSection(int helpId) {
        String sql = "DELETE FROM help_sections WHERE help_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting help section: " + e.getMessage());
            return false;
        }
    }

    private boolean hasAccess(String currentUserRole, String action) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin has access to everything
        }
        // Manager, Staff, Customer: view and list only
        return "view".equals(action) || "list".equals(action);
    }

    private void handleCreateHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String currentRole = session != null ? (String) session.getAttribute("role") : null;
        if (!"ADMIN".equals(currentRole)) {
            response.sendRedirect("help.jsp?error=Access denied. Only administrators can create help sections.");
            return;
        }
        // Check if this is a GET request (show form) or POST request (process form)
        if ("GET".equals(request.getMethod())) {
            // GET request - display the create form
            request.setAttribute("roles", getAllRoles());
            request.getRequestDispatcher("help_create.jsp").forward(request, response);
        } else {
            // POST request - process the form submission
            try {
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String roleIdStr = request.getParameter("role_id");
                String roleName = request.getParameter("role_name");
                if (title == null || content == null || title.trim().isEmpty() || content.trim().isEmpty()) {
                    response.sendRedirect("help_create.jsp?error=Title and content are required.");
                    return;
                }

                HelpSection helpSection = new HelpSection();
                helpSection.setTitle(title.trim());
                helpSection.setContent(content.trim());
                if (roleName != null && !roleName.trim().isEmpty()) {
                    Integer rid = getRoleIdByName(roleName.trim());
                    helpSection.setRoleId(rid);
                } else if (roleIdStr != null && !roleIdStr.trim().isEmpty()) {
                    try {
                        helpSection.setRoleId(Integer.valueOf(roleIdStr.trim()));
                    } catch (NumberFormatException ignore) {
                        helpSection.setRoleId(null);
                    }
                }

                boolean success = createHelpSection(helpSection);

                if (success) {
                    response.sendRedirect("help.jsp?message=Help section created successfully.");
                } else {
                    response.sendRedirect("help_create.jsp?error=Failed to create help section.");
                }

            } catch (Exception e) {
                response.sendRedirect("help_create.jsp?error=Error creating help section: " + e.getMessage());
            }
        }
    }

    private void handleEditHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String currentRole = session != null ? (String) session.getAttribute("role") : null;
        if (!"ADMIN".equals(currentRole)) {
            response.sendRedirect("help.jsp?error=Access denied. Only administrators can edit help sections.");
            return;
        }
        try {
            String helpIdStr = request.getParameter("help_id");
            if (helpIdStr == null || helpIdStr.trim().isEmpty()) {
                response.sendRedirect("help.jsp?error=Help section ID is required.");
                return;
            }

            int helpId = Integer.parseInt(helpIdStr);
            HelpSection helpSection = getHelpSectionById(helpId);
            
            if (helpSection != null) {
                request.setAttribute("helpSection", helpSection);
                request.setAttribute("roles", getAllRoles());
                request.getRequestDispatcher("help_edit.jsp").forward(request, response);
            } else {
                response.sendRedirect("help.jsp?error=Help section not found.");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("help.jsp?error=Invalid help section ID.");
        } catch (Exception e) {
            response.sendRedirect("help.jsp?error=Error loading help section: " + e.getMessage());
        }
    }

    private void handleUpdateHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String currentRole = session != null ? (String) session.getAttribute("role") : null;
        if (!"ADMIN".equals(currentRole)) {
            response.sendRedirect("help.jsp?error=Access denied. Only administrators can update help sections.");
            return;
        }
        try {
            String helpIdStr = request.getParameter("help_id");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String roleIdStr = request.getParameter("role_id");
            String roleName = request.getParameter("role_name");

            if (helpIdStr == null || title == null || content == null || 
                helpIdStr.trim().isEmpty() || title.trim().isEmpty() || content.trim().isEmpty()) {
                response.sendRedirect("help.jsp?error=Help section ID, title and content are required.");
                return;
            }

            int helpId = Integer.parseInt(helpIdStr);
            HelpSection helpSection = new HelpSection();
            helpSection.setHelpId(helpId);
            helpSection.setTitle(title.trim());
            helpSection.setContent(content.trim());
            if (roleName != null && !roleName.trim().isEmpty()) {
                helpSection.setRoleId(getRoleIdByName(roleName.trim()));
            } else if (roleIdStr != null && !roleIdStr.trim().isEmpty()) {
                try {
                    helpSection.setRoleId(Integer.valueOf(roleIdStr.trim()));
                } catch (NumberFormatException ignore) {
                    helpSection.setRoleId(null);
                }
            }
            boolean success = updateHelpSection(helpSection);

            if (success) {
                response.sendRedirect("help.jsp?message=Help section updated successfully.");
            } else {
                response.sendRedirect("help.jsp?error=Failed to update help section.");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("help.jsp?error=Invalid help section ID.");
        } catch (Exception e) {
            response.sendRedirect("help.jsp?error=Error updating help section: " + e.getMessage());
        }
    }



    private void handleDeleteHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String currentRole = session != null ? (String) session.getAttribute("role") : null;
        if (!"ADMIN".equals(currentRole)) {
            response.sendRedirect("help.jsp?error=Access denied. Only administrators can delete help sections.");
            return;
        }
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));

            boolean success = deleteHelpSection(helpId);

            if (success) {
                // eventManager.logEvent("Help section deleted successfully: ID " + helpId, "INFO"); // Removed
                response.sendRedirect("help.jsp?message=Help section deleted successfully.");
            } else {
                // eventManager.logEvent("Help section deletion failed: ID " + helpId, "ERROR"); // Removed
                response.sendRedirect("help.jsp?error=Failed to delete help section.");
            }

        } catch (Exception e) {
            // eventManager.logEvent("Help section deletion error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error deleting help section: " + e.getMessage());
        }
    }

    private void handleViewHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));
            HelpSection helpSection = getHelpSectionById(helpId);
            
            if (helpSection != null) {
                // Non-admins can only view global or their own role
                String currentRole = session != null ? (String) session.getAttribute("role") : null;
                if (!"ADMIN".equals(currentRole)) {
                    Integer sectionRoleId = helpSection.getRoleId();
                    if (sectionRoleId != null) {
                        Integer viewerRoleId = currentRole != null ? getRoleIdByName(currentRole) : null;
                        if (viewerRoleId == null || !sectionRoleId.equals(viewerRoleId)) {
                            response.sendRedirect("help.jsp?error=Access denied. You don't have permission to view this help section.");
                            return;
                        }
                    }
                }
                request.setAttribute("helpSection", helpSection);
                request.getRequestDispatcher("help_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("help.jsp?error=Help section not found.");
            }

        } catch (Exception e) {
            // eventManager.logEvent("Help section view error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error viewing help section: " + e.getMessage());
        }
    }

    private void handleListHelpSections(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String currentRole = session != null ? (String) session.getAttribute("role") : null;
            List<HelpSection> helpSections;
            if ("ADMIN".equals(currentRole) || "MANAGER".equals(currentRole)) {
                helpSections = getAllHelpSections();
            } else if (currentRole != null) {
                helpSections = getHelpSectionsForRole(currentRole);
            } else {
                helpSections = getAllHelpSections();
            }
            request.setAttribute("helpSections", helpSections);
            request.getRequestDispatcher("help.jsp").forward(request, response);

        } catch (Exception e) {
            // eventManager.logEvent("Help section list error: " + e.getMessage(), "ERROR"); // Removed
            response.sendRedirect("help.jsp?error=Error loading help sections: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET requests directly
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        // Get session
        HttpSession session = request.getSession(false);
        
        try {
            switch (action) {
                case "create":
                    handleCreateHelpSection(request, response, session);
                    break;
                case "edit":
                    handleEditHelpSection(request, response, session);
                    break;
                case "update":
                    handleUpdateHelpSection(request, response, session);
                    break;
                case "delete":
                    handleDeleteHelpSection(request, response, session);
                    break;
                case "view":
                    handleViewHelpSection(request, response, session);
                    break;
                case "list":
                default:
                    handleListHelpSections(request, response, session);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in HelpServlet: " + e.getMessage());
            response.sendRedirect("help.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests directly
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Help Content Management Servlet";
    }
} 