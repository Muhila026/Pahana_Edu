package com.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = trimOrEmpty(request.getParameter("name"));
        String email = trimOrEmpty(request.getParameter("email"));
        String phone = trimOrEmpty(request.getParameter("phone"));
        String subject = trimOrEmpty(request.getParameter("subject"));
        String message = trimOrEmpty(request.getParameter("message"));

        if (name.isEmpty() || email.isEmpty() || subject.isEmpty() || message.isEmpty()) {
            response.sendRedirect("contact.jsp?status=error&reason=validation");
            return;
        }

        EmailService emailService = new EmailService();

        boolean notifyAdminOk = emailService.sendContactNotificationToAdmin(name, email, phone, subject, message);
        boolean autoReplyOk = emailService.sendContactAutoReply(email, name);

        if (notifyAdminOk && autoReplyOk) {
            response.sendRedirect("contact.jsp?status=success");
        } else if (notifyAdminOk) {
            response.sendRedirect("contact.jsp?status=partial&detail=autoreply_failed");
        } else if (autoReplyOk) {
            response.sendRedirect("contact.jsp?status=partial&detail=notify_failed");
        } else {
            response.sendRedirect("contact.jsp?status=error&reason=send_failed");
        }
    }

    private String trimOrEmpty(String value) {
        return value == null ? "" : value.trim();
    }
}



