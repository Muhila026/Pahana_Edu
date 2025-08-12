<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple POS Test - BookShop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
        .test-section {
            margin: 20px 0;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .test-section h3 {
            color: #666;
            margin-top: 0;
        }
        .status {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            font-weight: bold;
        }
        .status.success { background: #d4edda; color: #155724; }
        .status.error { background: #f8d7da; color: #721c24; }
        .status.info { background: #d1ecf1; color: #0c5460; }
        button {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
        }
        button:hover { background: #0056b3; }
        input {
            padding: 8px;
            margin: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 200px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔧 Simple POS Test Page</h1>
            <p>Testing basic functionality to identify 500 error source</p>
        </div>

        <!-- Basic JSP Test -->
        <div class="test-section">
            <h3>1. Basic JSP Functionality Test</h3>
            <p><strong>Current Time:</strong> <%= new java.util.Date() %></p>
            <p><strong>Server Info:</strong> <%= application.getServerInfo() %></p>
            <p><strong>JSP Version:</strong> <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %></p>
            <div class="status success">✅ Basic JSP is working</div>
        </div>

        <!-- Session Test -->
        <div class="test-section">
            <h3>2. Session Management Test</h3>
            <%
            try {
                String sessionStatus = "Session ID: " + session.getId();
                session.setAttribute("testAttribute", "Test Value");
                String retrievedValue = (String) session.getAttribute("testAttribute");
                out.println("<p><strong>Session Test:</strong> " + sessionStatus + "</p>");
                out.println("<p><strong>Attribute Test:</strong> " + retrievedValue + "</p>");
                out.println("<div class='status success'>✅ Session management working</div>");
            } catch (Exception e) {
                out.println("<div class='status error'>❌ Session error: " + e.getMessage() + "</div>");
            }
            %>
        </div>

        <!-- Database Connection Test -->
        <div class="test-section">
            <h3>3. Database Connection Test</h3>
            <%
            try {
                // Test basic database connectivity
                Class.forName("com.mysql.cj.jdbc.Driver");
                out.println("<div class='status success'>✅ MySQL Driver loaded successfully</div>");
            } catch (ClassNotFoundException e) {
                out.println("<div class='status error'>❌ MySQL Driver not found: " + e.getMessage() + "</div>");
            } catch (Exception e) {
                out.println("<div class='status error'>❌ Database test error: " + e.getMessage() + "</div>");
            }
            %>
        </div>

        <!-- Servlet Context Test -->
        <div class="test-section">
            <h3>4. Servlet Context Test</h3>
            <%
            try {
                String contextPath = application.getContextPath();
                String realPath = application.getRealPath("/");
                out.println("<p><strong>Context Path:</strong> " + contextPath + "</p>");
                out.println("<p><strong>Real Path:</strong> " + realPath + "</p>");
                out.println("<div class='status success'>✅ Servlet context working</div>");
            } catch (Exception e) {
                out.println("<div class='status error'>❌ Servlet context error: " + e.getMessage() + "</div>");
            }
            %>
        </div>

        <!-- Form Test -->
        <div class="test-section">
            <h3>5. Form Processing Test</h3>
            <form method="POST" action="pos-simple.jsp">
                <input type="text" name="testInput" placeholder="Enter test text" value="<%= request.getParameter('testInput') != null ? request.getParameter('testInput') : '' %>">
                <button type="submit">Test Form</button>
            </form>
            <%
            if (request.getParameter("testInput") != null) {
                out.println("<div class='status info'>✅ Form submitted with: " + request.getParameter("testInput") + "</div>");
            }
            %>
        </div>

        <!-- Error Test -->
        <div class="test-section">
            <h3>6. Error Handling Test</h3>
            <button onclick="testJavaScript()">Test JavaScript</button>
            <button onclick="testError()">Test Error Handling</button>
            <div id="jsResult" class="status info" style="display: none;"></div>
        </div>

        <!-- Navigation Test -->
        <div class="test-section">
            <h3>7. Navigation Test</h3>
            <button onclick="window.location.href='welcome.jsp'">Go to Welcome Page</button>
            <button onclick="window.location.href='books.jsp'">Go to Books Page</button>
            <button onclick="window.location.href='categories.jsp'">Go to Categories Page</button>
        </div>

        <!-- Summary -->
        <div class="test-section">
            <h3>📊 Test Summary</h3>
            <p>If you can see this page, basic JSP functionality is working.</p>
            <p>If you're still getting 500 errors, check the server logs for specific error messages.</p>
            <div class="status info">ℹ️ Check Tomcat logs for detailed error information</div>
        </div>
    </div>

    <script>
        function testJavaScript() {
            document.getElementById('jsResult').style.display = 'block';
            document.getElementById('jsResult').textContent = '✅ JavaScript is working';
            document.getElementById('jsResult').className = 'status success';
        }

        function testError() {
            try {
                // Simulate an error
                throw new Error('Test error for error handling');
            } catch (error) {
                document.getElementById('jsResult').style.display = 'block';
                document.getElementById('jsResult').textContent = '✅ Error handling working: ' + error.message;
                document.getElementById('jsResult').className = 'status success';
            }
        }
    </script>
</body>
</html>
