# BookShop Category Management System

A comprehensive category management system for the BookShop application with role-based access control.

## Features

### 🔐 Role-Based Access Control
- **Public/Customer**: View and search categories only
- **Staff**: View categories (read-only access)
- **Admin/Manager**: Full CRUD operations (Create, Read, Update, Delete)

### 📚 Category Management
- **View Categories**: Browse all book categories with descriptions
- **Search Categories**: Search by category name or description
- **Add Categories**: Create new book categories (Admin/Manager only)
- **Edit Categories**: Modify existing categories (Admin/Manager only)
- **Delete Categories**: Remove categories (Admin/Manager only)

### 🎨 User Interface
- **Responsive Design**: Works on desktop and mobile devices
- **Modern UI**: Clean, professional interface with animations
- **Consistent Navigation**: Same navbar across all pages
- **Modal Dialogs**: Confirmation dialogs for delete operations

## Database Schema

### Tables
1. **roles** - User roles (Admin, Manager, Staff, Customer)
2. **users** - Admin/Staff user accounts
3. **customers** - Customer accounts
4. **categories** - Book categories
5. **books** - Book inventory

### Sample Data
The system includes sample data for testing:
- Admin user: `adminUser` / `123`
- Manager user: `managerUser` / `123`
- Staff user: `staffUser` / `123`
- Customer: `kasun@example.com` / `123`

## Setup Instructions

### 1. Database Setup
1. Create a MySQL database named `mydatabase`
2. Run the `database_setup.sql` script to create tables and sample data:
   ```sql
   mysql -u root -p mydatabase < database_setup.sql
   ```

### 2. Configuration
Update database connection details in servlets:
- `CategoryServlet.java`
- `LoginServlet.java`
- `AccessControlFilter.java`

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "password";
```

### 3. Deploy Application
1. Build the project
2. Deploy to Tomcat server
3. Access the application at `http://localhost:8080/BookShop`

## Usage Guide

### For Public Users
1. Visit `categories.jsp` to view all categories
2. Use the search function to find specific categories
3. Click "Explore" to view books in that category

### For Staff
1. Login with staff credentials
2. Access categories page (read-only)
3. Can view and search categories

### For Admin/Manager
1. Login with admin/manager credentials
2. Click "Manage Categories" in the navigation
3. Use the category management interface:
   - **Add Category**: Fill the form and click "Add Category"
   - **Edit Category**: Click "Edit" button, modify in modal, click "Update"
   - **Delete Category**: Click "Delete" button, confirm in modal

## File Structure

```
BookShop/
├── src/java/com/pahana/
│   ├── CategoryServlet.java          # Main category CRUD operations
│   ├── LoginServlet.java             # User authentication
│   ├── LogoutServlet.java            # User logout
│   ├── SignupServlet.java            # User registration
│   └── AccessControlFilter.java      # Role-based access control
├── web/
│   ├── categories.jsp                # Public category viewing
│   ├── category-management.jsp       # Admin category management
│   ├── welcome.jsp                   # Home page
│   └── other JSP files...
├── database_setup.sql                # Database schema and sample data
└── README.md                         # This file
```

## Security Features

### Access Control
- **Filter-based protection**: `AccessControlFilter` protects admin pages
- **Session validation**: All operations check user authentication
- **Role verification**: CRUD operations restricted to Admin/Manager roles

### Data Validation
- **Input sanitization**: All user inputs are validated
- **SQL injection prevention**: Prepared statements used throughout
- **Duplicate prevention**: Unique constraints on category names

### Error Handling
- **Graceful error messages**: User-friendly error display
- **Database constraint checks**: Prevents deletion of categories in use
- **Session timeout handling**: Automatic logout on session expiry

## API Endpoints

### CategoryServlet
- `GET /CategoryServlet?action=list` - List all categories
- `GET /CategoryServlet?action=search&searchTerm=...` - Search categories
- `POST /CategoryServlet?action=add` - Add new category
- `POST /CategoryServlet?action=update` - Update existing category
- `POST /CategoryServlet?action=delete` - Delete category

## Troubleshooting

### Common Issues
1. **Database Connection Error**: Check database credentials and connection
2. **Access Denied**: Ensure user has proper role permissions
3. **Categories Not Loading**: Verify database setup and sample data
4. **Session Issues**: Clear browser cache and cookies

### Debug Mode
Enable debug logging by checking console output for detailed error messages.

## Future Enhancements

- [ ] Category image upload
- [ ] Category hierarchy (parent-child relationships)
- [ ] Bulk category operations
- [ ] Category analytics and reporting
- [ ] API endpoints for mobile app integration

## Support

For technical support or questions, please refer to the application logs or contact the development team. 