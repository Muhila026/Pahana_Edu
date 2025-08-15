package com.booking;



import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.math.BigDecimal;
import java.util.Collections;
import com.booking.TransactionServlet;
import com.booking.TransactionServlet.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet for providing chart data
 */
public class ChartServlet extends HttpServlet {




    @Override
    public void init() throws ServletException {
        super.init();


    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Please login first.\"}");
            return;
        }

        if ("transactionSales".equals(action)) {
            handleTransactionSalesChart(request, response);
        } else if ("lastTransactions".equals(action)) {
            handleLastTransactionsChart(request, response);
        } else if ("weeklySales".equals(action)) {
            handleWeeklySalesChart(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid action.\"}");
        }
    }

    private void handleTransactionSalesChart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get transaction data for the last 30 days
            List<Map<String, Object>> transactionData = new ArrayList<>(); // Placeholder - implement actual data retrieval
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"success\":true,\"labels\":[");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd");
            
            // Build labels array
            for (int i = 0; i < transactionData.size(); i++) {
                Map<String, Object> transaction = transactionData.get(i);
                Timestamp createdAt = (Timestamp) transaction.get("created_at");
                String dateLabel = dateFormat.format(createdAt);
                
                jsonBuilder.append("\"").append(dateLabel).append("\"");
                if (i < transactionData.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("],\"data\":[");
            
            // Build data array
            for (int i = 0; i < transactionData.size(); i++) {
                Map<String, Object> transaction = transactionData.get(i);
                Double totalAmount = (Double) transaction.get("total_amount");
                
                jsonBuilder.append(totalAmount);
                if (i < transactionData.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]}");
            
            response.getWriter().write(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("Chart data error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading chart data: " + e.getMessage() + "\"}");
        }
    }

    private void handleWeeklySalesChart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            String role = session != null ? (String) session.getAttribute("role") : null;
            if (role == null || !"ADMIN".equals(role)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"error\":\"Forbidden\"}");
                return;
            }

            TransactionServlet txServlet = new TransactionServlet();
            List<Transaction> all = txServlet.getAllTransactions(); // DESC by ID, includes createdAt and totalAmount

            // Build last 7 days date keys in chronological order
            LinkedHashMap<String, BigDecimal> dayToTotal = new LinkedHashMap<>();
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            // Normalize to day start for consistent labeling
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);

            SimpleDateFormat labelFmt = new SimpleDateFormat("MMM dd");
            List<Date> days = new ArrayList<>();
            for (int i = 6; i >= 0; i--) {
                Calendar c = (Calendar) cal.clone();
                c.add(Calendar.DAY_OF_YEAR, -i);
                Date d = c.getTime();
                days.add(d);
                dayToTotal.put(labelFmt.format(d), BigDecimal.ZERO);
            }

            // Sum totals per day for transactions within last 7 days
            Calendar startCal = (Calendar) cal.clone();
            startCal.add(Calendar.DAY_OF_YEAR, -6);
            Date startDate = startCal.getTime();
            Date endDate = cal.getTime(); // inclusive of today

            for (Transaction t : all) {
                Timestamp ts = t.getCreatedAt();
                if (ts == null) continue;
                Date td = new Date(ts.getTime());
                if (td.before(startDate) || td.after(new Date(endDate.getTime() + 86399999L))) continue; // within 7-day window
                String key = labelFmt.format(td);
                if (dayToTotal.containsKey(key)) {
                    BigDecimal current = dayToTotal.get(key);
                    BigDecimal add = t.getTotalAmount() != null ? t.getTotalAmount() : BigDecimal.ZERO;
                    dayToTotal.put(key, current.add(add));
                }
            }

            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"labels\":[");
            int idx = 0; int size = dayToTotal.size();
            for (String label : dayToTotal.keySet()) {
                json.append("\"").append(label).append("\"");
                if (++idx < size) json.append(",");
            }
            json.append("],\"data\":[");
            idx = 0;
            for (BigDecimal total : dayToTotal.values()) {
                json.append(total != null ? total.doubleValue() : 0.0);
                if (++idx < size) json.append(",");
            }
            json.append("]}");

            response.getWriter().write(json.toString());
        } catch (Exception e) {
            System.err.println("Chart weekly sales error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading weekly sales: " + e.getMessage() + "\"}");
        }
    }

    private void handleLastTransactionsChart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            String role = session != null ? (String) session.getAttribute("role") : null;
            if (role == null || !"ADMIN".equals(role)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"error\":\"Forbidden\"}");
                return;
            }

            int limit = 10;
            try {
                String limitParam = request.getParameter("limit");
                if (limitParam != null && !limitParam.isEmpty()) {
                    limit = Math.max(1, Math.min(50, Integer.parseInt(limitParam)));
                }
            } catch (NumberFormatException ignored) {}

            TransactionServlet txServlet = new TransactionServlet();
            List<Transaction> all = txServlet.getAllTransactions(); // Ordered DESC by ID

            List<Transaction> subset = new ArrayList<>();
            int count = Math.min(limit, all != null ? all.size() : 0);
            for (int i = 0; i < count; i++) {
                subset.add(all.get(i));
            }
            // Reverse to chronological order for chart (oldest -> newest)
            Collections.reverse(subset);

            SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd HH:mm");
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"labels\":[");
            for (int i = 0; i < subset.size(); i++) {
                Timestamp ts = subset.get(i).getCreatedAt();
                String label = ts != null ? dateFormat.format(ts) : ("#" + subset.get(i).getTransactionId());
                json.append("\"").append(label).append("\"");
                if (i < subset.size() - 1) json.append(",");
            }
            json.append("],\"data\":[");
            for (int i = 0; i < subset.size(); i++) {
                java.math.BigDecimal amt = subset.get(i).getTotalAmount();
                double value = amt != null ? amt.doubleValue() : 0.0;
                json.append(value);
                if (i < subset.size() - 1) json.append(",");
            }
            json.append("]}");

            response.getWriter().write(json.toString());
        } catch (Exception e) {
            System.err.println("Chart last transactions error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error loading last transactions: " + e.getMessage() + "\"}");
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
        return "Chart Data Servlet";
    }
} 