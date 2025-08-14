<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Discount Management</title>
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .main-content {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            margin-bottom: 2rem;
            text-align: center;
            border: 1px solid rgba(99, 102, 241, 0.1);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
        }

        .page-header h1 {
            color: #6366f1;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .page-header p {
            color: #64748b;
            font-weight: 500;
        }
        
        .action-buttons {
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 15px;
            text-decoration: none;
            display: inline-block;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
        }
        
        .btn-info {
            background: linear-gradient(135deg, #06b6d4, #0891b2);
            color: white;
        }
        
        .btn-dark {
            background: linear-gradient(135deg, #374151, #1f2937);
            color: white;
        }
        
        .btn-sm {
            padding: 8px 16px;
            font-size: 12px;
        }
        
        .discounts-table {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
            overflow: hidden;
            border: 1px solid rgba(99, 102, 241, 0.1);
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th,
        .table td {
            padding: 16px 20px;
            text-align: left;
            border-bottom: 1px solid rgba(99, 102, 241, 0.1);
        }
        
        .table th {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            font-weight: 600;
            color: #6366f1;
            font-size: 14px;
        }
        
        .table tr:hover {
            background-color: rgba(99, 102, 241, 0.05);
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            backdrop-filter: blur(5px);
        }
        
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 2rem;
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(99, 102, 241, 0.1);
            animation: modalSlideIn 0.3s ease;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid rgba(99, 102, 241, 0.1);
        }
        
        .modal-header h2 {
            color: #6366f1;
            font-weight: 700;
            margin: 0;
        }
        
        .close {
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            color: #6366f1;
            transition: all 0.3s ease;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.1);
        }
        
        .close:hover {
            color: white;
            background: #6366f1;
            transform: rotate(90deg);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #6366f1;
            font-size: 14px;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #f8fafc;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #6366f1;
            background: white;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }
        
        .form-actions {
            text-align: right;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(99, 102, 241, 0.1);
        }
        
        .no-discounts {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar-header">
            <h2>Admin Panel</h2>
            <p>Welcome, Admin</p>
        </div>
        <ul class="admin-sidebar-menu">
            <li><a href="welcome.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="pos.jsp"><i class="fas fa-cash-register"></i> Point of Sale</a></li>
            <li><a href="CategoryServlet?action=list"><i class="fas fa-cog"></i> Manage Categories</a></li>
            <li><a href="BookServlet?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
            <li><a href="user-management.jsp"><i class="fas fa-users"></i> Manage Users</a></li>
            <li><a href="CustomerServlet?action=list"><i class="fas fa-user-friends"></i> Manage Customer</a></li>
            <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> All Orders</a></li>
            <li><a href="discount.jsp" class="active"><i class="fas fa-percentage"></i> Discounts</a></li>
            <li><a href="settings.jsp"><i class="fas fa-cogs"></i> System Settings</a></li>
            <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
            <li><a href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main-content">
        <div class="main-content">
            <div class="page-header">
                <h1>Discount Management</h1>
                <p>Manage discounts and promotional offers for your bookstore.</p>
            </div>

        <div class="action-buttons">
            <button class="btn btn-primary" onclick="openAddModal()">
                <i class="fas fa-plus"></i> Add New Discount
            </button>
                               <button class="btn btn-secondary" onclick="loadDiscounts()">
                       <i class="fas fa-sync-alt"></i> Refresh Discounts
                   </button>
                   <button class="btn btn-warning" onclick="testDatabaseConnection()">
                       <i class="fas fa-database"></i> Test Database
                   </button>
                   <button class="btn btn-info" onclick="testServletAccess()">
                       <i class="fas fa-server"></i> Test Servlet Access
                   </button>
                   <button class="btn btn-dark" onclick="testRawResponse()">
                       <i class="fas fa-code"></i> Test Raw Response
                   </button>
                   <button class="btn btn-success" onclick="testServletDirectly()">
                       <i class="fas fa-check"></i> Test Servlet Directly
                   </button>
                   <button class="btn btn-primary" onclick="testDatabaseConnectionSimple()">
                       <i class="fas fa-database"></i> Simple DB Test
                   </button>
                   <button class="btn btn-warning" onclick="testEditFunction()">
                       <i class="fas fa-edit"></i> Test Edit
                   </button>
                   <button class="btn btn-danger" onclick="testDeleteFunction()">
                       <i class="fas fa-trash"></i> Test Delete
                   </button>
                   <button class="btn btn-info" onclick="checkSessionInfo()">
                       <i class="fas fa-info-circle"></i> Check Session
                   </button>
        </div>

        <div class="discounts-table">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Discount Type</th>
                        <th>Value</th>
                        <th>Created At</th>
                        <th>Updated At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="discountsTableBody">
                    <tr>
                        <td colspan="6" class="no-discounts">Loading discounts...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Add/Edit Discount Modal -->
    <div id="discountModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Add New Discount</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="discountForm">
                <input type="hidden" id="discountId" name="discountId">
                
                <div class="form-group">
                    <label for="discountType">Discount Type:</label>
                    <select id="discountType" name="discountType" required>
                        <option value="">Select Discount Type</option>
                        <option value="Percentage">Percentage</option>
                        <option value="Fixed Amount">Fixed Amount</option>
                        <option value="Seasonal">Seasonal</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="discountValue">Discount Value:</label>
                    <input type="number" id="discountValue" name="discountValue" 
                           step="0.01" min="0" required placeholder="Enter discount value">
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-success">Save Discount</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Global variables
        let currentDiscountId = null;
        let isEditMode = false;

        // Open modal for adding new discount
        function openAddModal() {
            isEditMode = false;
            currentDiscountId = null;
            document.getElementById('modalTitle').textContent = 'Add New Discount';
            document.getElementById('discountForm').reset();
            document.getElementById('discountModal').style.display = 'block';
        }

        // Open modal for editing existing discount
        function editDiscount(discountId) {
            console.log('Attempting to edit discount with ID:', discountId);
            
            isEditMode = true;
            currentDiscountId = discountId;
            document.getElementById('modalTitle').textContent = 'Edit Discount';
            
            // Get discount data and populate form from backend
            getDiscountById(discountId)
                .then(discount => {
                    console.log('Retrieved discount data:', discount);
                    document.getElementById('discountId').value = discount.discountId;
                    document.getElementById('discountType').value = discount.discountType;
                    document.getElementById('discountValue').value = discount.discountValue;
                    document.getElementById('discountModal').style.display = 'block';
                })
                .catch(error => {
                    console.error('Error fetching discount:', error);
                    alert('Error loading discount data: ' + error.message);
                });
        }

        // Delete discount
        function deleteDiscount(discountId) {
            console.log('Attempting to delete discount with ID:', discountId);
            
            if (confirm('Are you sure you want to delete this discount?')) {
                const formData = new FormData();
                formData.append('action', 'delete');
                formData.append('discountId', discountId);
                
                console.log('Sending delete request with data:', {
                    action: 'delete',
                    discountId: discountId
                });
                
                fetch('DiscountServlet', {
                    method: 'POST',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: formData
                })
                .then(response => {
                    console.log('Delete response status:', response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('Delete response data:', data);
                    if (data.success) {
                        alert('Discount deleted successfully!');
                        loadDiscounts(); // Refresh the table
                    } else {
                        alert('Error: ' + data.error);
                    }
                })
                .catch(error => {
                    console.error('Error deleting discount:', error);
                    alert('Error deleting discount: ' + error.message);
                });
            }
        }

        // Close modal
        function closeModal() {
            document.getElementById('discountModal').style.display = 'none';
        }

        // Handle form submission
        document.getElementById('discountForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const discountData = {
                discountId: formData.get('discountId'),
                discountType: formData.get('discountType'),
                discountValue: formData.get('discountValue')
            };
            
            if (isEditMode) {
                updateDiscount(discountData);
            } else {
                addDiscount(discountData);
            }
        });
        
        // Function to add new discount
        function addDiscount(discountData) {
            const formData = new FormData();
            formData.append('action', 'add');
            formData.append('discountType', discountData.discountType);
            formData.append('discountValue', discountData.discountValue);
            
            fetch('DiscountServlet', {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Discount added successfully!');
                    closeModal();
                    loadDiscounts();
                } else {
                    alert('Error: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error adding discount');
            });
        }
        
        // Function to update existing discount
        function updateDiscount(discountData) {
            console.log('Attempting to update discount with data:', discountData);
            
            const formData = new FormData();
            formData.append('action', 'update');
            formData.append('discountId', discountData.discountId);
            formData.append('discountType', discountData.discountType);
            formData.append('discountValue', discountData.discountValue);
            
            console.log('Sending update request with data:', {
                action: 'update',
                discountId: discountData.discountId,
                discountType: discountData.discountType,
                discountValue: discountData.discountValue
            });
            
            fetch('DiscountServlet', {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: formData
            })
            .then(response => {
                console.log('Update response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('Update response data:', data);
                if (data.success) {
                    alert('Discount updated successfully!');
                    closeModal();
                    loadDiscounts();
                } else {
                    alert('Error: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error updating discount:', error);
                alert('Error updating discount: ' + error.message);
            });
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('discountModal');
            if (event.target === modal) {
                closeModal();
            }
        }

        // Function to get discount by ID from backend
        function getDiscountById(id) {
            console.log('Fetching discount by ID:', id);
            
            return fetch(`DiscountServlet?action=get&id=${id}`, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    console.log('Get discount response status:', response.status);
                    return response.text();
                })
                .then(text => {
                    console.log('Get discount response data:', text);
                    try {
                        const data = JSON.parse(text);
                        if (data.success && data.discount) {
                            return data.discount;
                        } else {
                            throw new Error(data.error || 'Discount not found');
                        }
                    } catch (parseError) {
                        console.error('Failed to parse discount JSON:', parseError);
                        console.error('Raw response was:', text);
                        throw new Error('Invalid response format from server');
                    }
                })
                .catch(error => {
                    console.error('Error in getDiscountById:', error);
                    throw error;
                });
        }

        // Load discounts on page load
        window.onload = function() {
            loadDiscounts();
        }

        // Function to load all discounts from backend
               function loadDiscounts() {
           console.log('Loading discounts from database...');
           
           // Show loading state
           document.getElementById('discountsTableBody').innerHTML = 
               '<tr><td colspan="6" class="no-discounts">Loading discounts from database...</td></tr>';
           
           fetch('DiscountServlet?action=list', {
               method: 'GET',
               headers: {
                   'X-Requested-With': 'XMLHttpRequest',
                   'Accept': 'application/json'
               }
           })
               .then(response => {
                   console.log('Response status:', response.status);
                   console.log('Response headers:', response.headers);
                   if (!response.ok) {
                       throw new Error(`HTTP error! status: ${response.status}`);
                   }
                   return response.text(); // Get raw text first
               })
               .then(text => {
                   console.log('Raw response text:', text);
                   
                   // Try to parse as JSON
                   try {
                       const discounts = JSON.parse(text);
                       console.log('Parsed discounts:', discounts);
                       if (Array.isArray(discounts)) {
                           displayDiscounts(discounts);
                       } else {
                           console.error('Unexpected response format:', discounts);
                           document.getElementById('discountsTableBody').innerHTML = 
                               '<tr><td colspan="6" class="no-discounts">Invalid response format from server</td></tr>';
                       }
                   } catch (parseError) {
                       console.error('Failed to parse JSON:', parseError);
                       console.error('Raw response was:', text);
                       console.error('Response length:', text.length);
                       console.error('First 200 characters:', text.substring(0, 200));
                       console.error('Last 200 characters:', text.substring(Math.max(0, text.length - 200)));
                       document.getElementById('discountsTableBody').innerHTML = 
                           '<tr><td colspan="6" class="no-discounts">Server returned invalid JSON. Check console for details.</td></tr>';
                   }
               })
               .catch(error => {
                   console.error('Error loading discounts:', error);
                   document.getElementById('discountsTableBody').innerHTML = 
                       '<tr><td colspan="6" class="no-discounts">Error loading discounts: ' + error.message + '</td></tr>';
               });
       }
        
        // Function to display discounts in table
        function displayDiscounts(discounts) {
            const tbody = document.getElementById('discountsTableBody');
            
            console.log('Displaying discounts:', discounts);
            console.log('First discount object:', discounts[0]);
            
            if (discounts.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" class="no-discounts">No discounts found</td></tr>';
                return;
            }
            
            tbody.innerHTML = '';
            
            discounts.forEach((discount, index) => {
                console.log(`Processing discount ${index}:`, discount);
                
                const row = document.createElement('tr');
                
                // Ensure discount ID is valid
                const discountId = discount.discountId || discount.id;
                console.log(`Discount ${index} ID:`, discountId);
                
                if (!discountId) {
                    console.error('Discount missing ID:', discount);
                    return; // Skip this discount
                }
                
                // Format the value display
                let valueDisplay = '';
                if (discount.discountType === 'Percentage') {
                    valueDisplay = discount.discountValue + '%';
                } else if (discount.discountType === 'Fixed Amount') {
                    valueDisplay = '$' + discount.discountValue;
                } else {
                    valueDisplay = discount.discountValue;
                }
                
                // Format timestamps
                const createdAt = formatDateTime(discount.createdAt);
                const updatedAt = formatDateTime(discount.updatedAt);
                
                row.innerHTML = `
                    <td>${discountId}</td>
                    <td>${discount.discountType || 'N/A'}</td>
                    <td>${valueDisplay}</td>
                    <td>${createdAt}</td>
                    <td>${updatedAt}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editDiscount(${discountId})">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-danger btn-sm" onclick="deleteDiscount(${discountId})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                `;
                
                tbody.appendChild(row);
            });
        }
        
        // Function to format date time
        function formatDateTime(dateTimeString) {
            if (!dateTimeString) return 'N/A';
            const date = new Date(dateTimeString);
            return date.toLocaleString();
        }
        
               // Function to test database connection
       function testDatabaseConnection() {
           console.log('Testing database connection...');
           alert('Check browser console for database connection details');
           
           // Test basic connection
           fetch('DiscountServlet?action=list')
               .then(response => {
                   console.log('Database connection test - Response:', response);
                   console.log('Status:', response.status);
                   console.log('Headers:', response.headers);
                   return response.text();
               })
               .then(text => {
                   console.log('Raw response text:', text);
                   try {
                       const json = JSON.parse(text);
                       console.log('Parsed JSON:', json);
                       if (Array.isArray(json)) {
                           console.log('✅ Database connection successful! Found', json.length, 'discounts');
                           alert('Database connection successful! Found ' + json.length + ' discounts');
                       } else {
                           console.log('❌ Unexpected response format:', json);
                           alert('Database connected but unexpected response format');
                       }
                   } catch (e) {
                       console.log('❌ Response is not valid JSON:', text);
                       alert('Database connected but response is not valid JSON');
                   }
               })
               .catch(error => {
                   console.error('❌ Database connection failed:', error);
                   alert('Database connection failed: ' + error.message);
               });
       }
       
       // Function to test basic servlet accessibility
       function testServletAccess() {
           console.log('Testing basic servlet access...');
           
           fetch('DiscountServlet')
               .then(response => {
                   console.log('Basic servlet test - Status:', response.status);
                   console.log('Basic servlet test - Headers:', response.headers);
                   return response.text();
               })
               .then(text => {
                   console.log('Basic servlet test - Raw response:', text.substring(0, 200) + '...');
                   if (text.length > 0) {
                       console.log('✅ Servlet is accessible');
                       alert('Servlet is accessible! Check console for response details.');
                   } else {
                       console.log('❌ Servlet returned empty response');
                       alert('Servlet returned empty response');
                   }
               })
               .catch(error => {
                   console.error('❌ Servlet access failed:', error);
                   alert('Servlet access failed: ' + error.message);
               });
       }
       
       // Function to test raw response from DiscountServlet
       function testRawResponse() {
           console.log('Testing raw response from DiscountServlet...');
           
           fetch('DiscountServlet?action=list')
               .then(response => {
                   console.log('Raw response test - Status:', response.status);
                   console.log('Raw response test - Headers:', response.headers);
                   return response.text();
               })
               .then(text => {
                   console.log('=== RAW RESPONSE START ===');
                   console.log('Response length:', text.length);
                   console.log('Full response:', text);
                   console.log('=== RAW RESPONSE END ===');
                   
                   // Try to parse as JSON
                   try {
                       const json = JSON.parse(text);
                       console.log('✅ Response is valid JSON:', json);
                       alert('Response is valid JSON! Check console for details.');
                   } catch (e) {
                       console.log('❌ Response is NOT valid JSON');
                       console.log('Parse error:', e.message);
                       alert('Response is NOT valid JSON. Check console for full response.');
                   }
               })
               .catch(error => {
                   console.error('❌ Raw response test failed:', error);
                   alert('Raw response test failed: ' + error.message);
               });
       }
       
       // Function to test servlet directly
       function testServletDirectly() {
           console.log('Testing DiscountServlet directly...');
           
           fetch('DiscountServlet?action=test', {
               method: 'GET',
               headers: {
                   'X-Requested-With': 'XMLHttpRequest',
                   'Accept': 'application/json'
               }
           })
               .then(response => {
                   console.log('Direct servlet test - Status:', response.status);
                   return response.text();
               })
               .then(text => {
                   console.log('Direct servlet test - Response:', text);
                   try {
                       const json = JSON.parse(text);
                       if (json.success) {
                           console.log('✅ Servlet is working correctly!');
                           alert('Servlet is working correctly! Message: ' + json.message);
                       } else {
                           console.log('❌ Servlet returned error:', json);
                           alert('Servlet returned error: ' + json.error);
                       }
                   } catch (e) {
                       console.log('❌ Servlet response is not valid JSON:', text);
                       alert('Servlet response is not valid JSON: ' + text);
                   }
               })
               .catch(error => {
                   console.error('❌ Direct servlet test failed:', error);
                   alert('Direct servlet test failed: ' + error.message);
               });
       }
       
       // Function to test database connection with simple approach
       function testDatabaseConnectionSimple() {
           console.log('Testing database connection with simple approach...');
           
           // Test 1: Check if servlet responds at all
           fetch('DiscountServlet?action=test', {
               method: 'GET',
               headers: {
                   'X-Requested-With': 'XMLHttpRequest',
                   'Accept': 'application/json'
               }
           })
               .then(response => {
                   console.log('✅ Servlet responds - Status:', response.status);
                   return response.text();
               })
               .then(text => {
                   console.log('✅ Servlet response:', text);
                   
                   // Test 2: Try to list discounts
                   return fetch('DiscountServlet?action=list', {
                       method: 'GET',
                       headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           'Accept': 'application/json'
                       }
                   });
               })
               .then(response => {
                   console.log('✅ List action responds - Status:', response.status);
                   return response.text();
               })
               .then(text => {
                   console.log('✅ List action response:', text);
                   
                   if (text.includes('error') || text.includes('Error')) {
                       console.log('❌ Database error detected in response');
                       alert('Database error detected. Check console for details.');
                   } else if (text.includes('discounts') || text.includes('[]')) {
                       console.log('✅ Database connection successful!');
                       alert('Database connection successful! Check console for details.');
                   } else {
                       console.log('❓ Unexpected response format:', text);
                       alert('Unexpected response format. Check console for details.');
                   }
               })
               .catch(error => {
                   console.error('❌ Database test failed:', error);
                   alert('Database test failed: ' + error.message);
               });
       }

        // Function to test edit functionality
        function testEditFunction() {
            console.log('Testing edit functionality...');
            
            // First, load discounts to see what IDs are available
            fetch('DiscountServlet?action=list', {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                }
            })
            .then(response => response.text())
            .then(text => {
                try {
                    const discounts = JSON.parse(text);
                    if (discounts.length > 0) {
                        const firstDiscountId = discounts[0].discountId || discounts[0].id;
                        console.log('Testing edit with discount ID:', firstDiscountId);
                        editDiscount(firstDiscountId);
                    } else {
                        alert('No discounts available for testing');
                    }
                } catch (e) {
                    console.error('Failed to parse discounts:', e);
                    alert('Failed to load discounts for testing');
                }
            })
            .catch(error => {
                console.error('Error loading discounts for testing:', error);
                alert('Error loading discounts for testing');
            });
        }

        // Function to test delete functionality
        function testDeleteFunction() {
            console.log('Testing delete functionality...');
            
            // First, load discounts to see what IDs are available
            fetch('DiscountServlet?action=list', {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                }
            })
            .then(response => response.text())
            .then(text => {
                try {
                    const discounts = JSON.parse(text);
                    if (discounts.length > 0) {
                        const firstDiscountId = discounts[0].discountId || discounts[0].id;
                        console.log('Testing delete with discount ID:', firstDiscountId);
                        deleteDiscount(firstDiscountId);
                    } else {
                        alert('No discounts available for testing');
                    }
                } catch (e) {
                    console.error('Failed to parse discounts:', e);
                    alert('Failed to load discounts for testing');
                }
            })
            .catch(error => {
                console.error('Error loading discounts for testing:', error);
                alert('Error loading discounts for testing');
            });
        }

       // Function to check session information
       function checkSessionInfo() {
           console.log('Checking session information...');
           alert('Check browser console for session details');
           
           fetch('DiscountServlet?action=checkSession', {
               method: 'GET',
               headers: {
                   'X-Requested-With': 'XMLHttpRequest',
                   'Accept': 'application/json'
               }
           })
               .then(response => {
                   console.log('Session check - Status:', response.status);
                   console.log('Session check - Headers:', response.headers);
                   return response.text();
               })
               .then(text => {
                   console.log('Session check - Raw response:', text);
                   try {
                       const json = JSON.parse(text);
                       console.log('Session check - Parsed JSON:', json);
                       if (json.success) {
                           console.log('✅ Session is valid. User:', json.user);
                           alert('Session is valid! User: ' + json.user);
                       } else {
                           console.log('❌ Session is invalid. Error:', json.error);
                           alert('Session is invalid. Error: ' + json.error);
                       }
                   } catch (e) {
                       console.log('❌ Session check response is not valid JSON:', text);
                       alert('Session check response is not valid JSON: ' + text);
                   }
               })
               .catch(error => {
                   console.error('❌ Session check failed:', error);
                   alert('Session check failed: ' + error.message);
               });
       }
    </script>
    
    <script src="js/sidebar.js"></script>
</body>
</html>
