<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>POS Test - BookShop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .status {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>POS System Test Page</h1>
        
        <div class="status success">
            <strong>✅ JSP is working!</strong> This page loaded successfully.
        </div>
        
        <div class="status info">
            <strong>ℹ️ Current Time:</strong> <%= new java.util.Date() %>
        </div>
        
        <div class="status info">
            <strong>ℹ️ Server Info:</strong> <%= application.getServerInfo() %>
        </div>
        
        <div class="status info">
            <strong>ℹ️ Servlet Version:</strong> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %>
        </div>
        
        <h3>Test Functions:</h3>
        <button onclick="testJavaScript()">Test JavaScript</button>
        <button onclick="testFetch()">Test Fetch API</button>
        <button onclick="window.location.href='pos.jsp'">Go to Full POS</button>
        <button onclick="window.location.href='welcome.jsp'">Go to Welcome</button>
        
        <div id="testResults" style="margin-top: 20px;"></div>
    </div>

    <script>
        function testJavaScript() {
            const results = document.getElementById('testResults');
            results.innerHTML = '<div class="status success">✅ JavaScript is working!</div>';
        }
        
        function testFetch() {
            const results = document.getElementById('testResults');
            results.innerHTML = '<div class="status info">🔄 Testing fetch...</div>';
            
            fetch('POSServlet?action=searchBooks&searchTerm=test')
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error('Servlet not responding');
                    }
                })
                .then(data => {
                    results.innerHTML = '<div class="status success">✅ Fetch API working! Servlet responded with ' + data.length + ' books</div>';
                })
                .catch(error => {
                    results.innerHTML = '<div class="status error">❌ Fetch API error: ' + error.message + '</div>';
                });
        }
    </script>
</body>
</html> 