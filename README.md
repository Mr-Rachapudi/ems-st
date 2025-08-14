# Employee Management System (EMS) - Smalltalk

A comprehensive Employee Management System built with ObjectStudio/VisualWorks Smalltalk featuring CRUD operations, data validation, Windows GUI, and persistent SQLite storage.

## 🚀 Features

- **Complete CRUD Operations**: Create, Read, Update, and Delete employee records
- **Data Validation**: Comprehensive validation system with custom validators
- **GUI Interface**: Native Windows GUI with forms, lists, and search functionality
- **Database Persistence**: SQLite database integration for data storage
- **Search Functionality**: Search employees by name and filter by department
- **Deployment Ready**: Windows executable deployment configuration
- **Error Handling**: Robust exception handling with custom error types

## 📋 System Requirements

### Required Software
- **ObjectStudio/VisualWorks Smalltalk** (Version 8.2 or later recommended)
- **Windows Operating System** (Windows 7 or later)
- **SQLite Database Engine** (included with ObjectStudio packages)

### Hardware Requirements
- **RAM**: Minimum 4GB, 8GB recommended
- **Storage**: At least 500MB free space for development environment
- **Display**: 1024x768 minimum resolution

## 🔧 Dependencies and Required Packages

The following ObjectStudio packages are required:

```
- ObjectStudio-Core
- ObjectStudio-GUI  
- ObjectStudio-Database
- SQLite-Driver
```

These packages should be available in your ObjectStudio installation or can be loaded from the ObjectStudio package repository.

## 📦 Installation Instructions

### 1. Environment Setup

1. **Install ObjectStudio/VisualWorks Smalltalk**
   - Download and install ObjectStudio from Cincom Systems
   - Ensure you have the GUI and Database packages installed
   - Verify SQLite driver is available

2. **Clone the Repository**
   ```bash
   git clone https://github.com/Mr-Rachapudi/ems-st.git
   cd ems-st
   ```

### 2. Loading the Project

1. **Open ObjectStudio IDE**
   - Launch ObjectStudio development environment
   - Open the System Browser

2. **Load XML Files**
   Load the following XML files in order:
   ```
   1. Employee.xml                    (Model layer)
   2. EmployeeDatabase.xml           (Database layer)
   3. CreateEmployeeValidator.xml    (Validation)
   4. ReadEmployeeValidator.xml      (Validation)
   5. UpdateEmployeeValidator.xml    (Validation)
   6. DeleteEmployeeValidator.xml    (Validation)
   7. EmployeeService.xml            (Service layer)
   8. EmployeeListView.xml           (GUI Components)
   9. EmployeeFormView.xml           (GUI Components)
   10. EmployeeSearchView.xml        (GUI Components)
   11. EmployeeManagementWindow.xml  (Main GUI)
   12. EmployeeManagementController.xml (Controller)
   13. EmployeeManagementApp.xml     (Application)
   14. EmployeeManagementDeployment.xml (Deployment)
   ```

3. **Compile All Classes**
   - In the System Browser, select "Compile All" to compile all loaded classes
   - Resolve any compilation errors if they occur

### 3. Database Setup

The application automatically creates the SQLite database (`employees.db`) on first run with the following schema:

```sql
CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    department TEXT NOT NULL,
    salary REAL NOT NULL,
    hire_date TEXT NOT NULL
);
```

No manual database setup is required.

## 📁 Project Structure

```
ems-st/
├── Employee.xml                      # Employee model class
├── EmployeeDatabase.xml              # Database access layer
├── EmployeeService.xml               # Business logic service
├── CreateEmployeeValidator.xml       # Create operation validation
├── ReadEmployeeValidator.xml         # Read operation validation  
├── UpdateEmployeeValidator.xml       # Update operation validation
├── DeleteEmployeeValidator.xml       # Delete operation validation
├── EmployeeManagementWindow.xml      # Main application window
├── EmployeeListView.xml              # Employee list display
├── EmployeeFormView.xml              # Employee form for CRUD
├── EmployeeSearchView.xml            # Search functionality
├── EmployeeManagementController.xml  # Application controller
├── EmployeeManagementApp.xml         # Main application class
├── EmployeeManagementDeployment.xml  # Deployment configuration
└── README.md                         # This file
```

### Architecture Overview

- **Model Layer**: `Employee.xml` - Core employee data model
- **Database Layer**: `EmployeeDatabase.xml` - SQLite database operations
- **Service Layer**: `EmployeeService.xml` - Business logic and validation coordination
- **Validation Layer**: `*Validator.xml` files - Input validation and business rules
- **View Layer**: `*View.xml` files - GUI components and user interface
- **Controller Layer**: `EmployeeManagementController.xml` - Application flow control
- **Application Layer**: `EmployeeManagementApp.xml` - Application entry point

## 🚀 Usage Instructions

### Running the Application

1. **Start the Application**
   ```smalltalk
   EmployeeManagementApp main
   ```
   Or alternatively:
   ```smalltalk
   EmployeeManagementApp start
   ```

2. **Using the GUI**
   - The main window will open with employee list view
   - Use "Add Employee" button to create new employees
   - Double-click on employee records to edit
   - Use search functionality to find specific employees
   - Select employees and use "Delete" to remove records

### Basic Operations

**Create Employee:**
```smalltalk
employee := Employee new
    name: 'John Doe';
    email: 'john.doe@company.com';
    department: 'Engineering';
    salary: 75000;
    hireDate: Date today;
    yourself.
EmployeeService instance createEmployee: employee.
```

**Read Employee:**
```smalltalk
employee := EmployeeService instance readEmployee: 1.
```

**Update Employee:**
```smalltalk
employee salary: 80000.
EmployeeService instance updateEmployee: employee.
```

**Delete Employee:**
```smalltalk
EmployeeService instance deleteEmployeeById: 1.
```

## 🔨 Development Workflow

### Making Changes

1. **Modify Classes**: Edit the XML files or use the System Browser
2. **Recompile**: Compile modified classes
3. **Test**: Run the application to test changes
4. **Debug**: Use ObjectStudio debugger for troubleshooting

### Adding New Features

1. Follow the existing architecture patterns
2. Add appropriate validation in validator classes
3. Update service layer for new business logic
4. Modify GUI components as needed
5. Update deployment configuration if required

### Testing

- Manual testing through the GUI application
- Unit testing can be added using ObjectStudio's testing framework
- Database operations can be tested independently

## 🚀 Deployment

### Creating Windows Executable

1. **Open Deployment Manager** in ObjectStudio IDE

2. **Create Deployment Configuration:**
   - Application Name: `EmployeeManagementSystem`
   - Main Class: `EmployeeManagementApp`
   - Startup Method: `main`
   - Target: Windows Executable

3. **Configure Settings:**
   - Executable Name: `EmployeeManagement.exe`
   - Include Runtime: Yes
   - Compress Executable: Yes
   - Target Platform: Windows

4. **Build Process:**
   - Add all required classes from the project
   - Include necessary ObjectStudio packages
   - Build the executable

The resulting `EmployeeManagement.exe` will be a standalone Windows application including the ObjectStudio runtime and all dependencies.

### Deployment Script

Use the deployment script generator:
```smalltalk
EmployeeManagementDeployment createDeploymentScript
```

This generates a complete deployment script for automated builds.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes following the existing code patterns
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Style Guidelines

- Follow ObjectStudio/Smalltalk naming conventions
- Use descriptive method and variable names
- Add appropriate validation for all user inputs
- Maintain separation of concerns between layers
- Document complex business logic

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Troubleshooting

### Common Issues

**Database Connection Errors:**
- Ensure SQLite driver is properly installed
- Check file permissions for database creation
- Verify ObjectStudio-Database package is loaded

**GUI Display Issues:**
- Confirm ObjectStudio-GUI package is available
- Check Windows compatibility settings
- Verify display resolution meets minimum requirements

**Compilation Errors:**
- Load XML files in the correct order
- Ensure all required packages are installed
- Check for missing dependencies

### Getting Help

- Check ObjectStudio documentation for platform-specific issues
- Review the deployment configuration for build problems
- Use ObjectStudio debugger for runtime issues

## 📞 Support

For questions and support:
- Create an issue in this repository
- Contact the development team
- Refer to ObjectStudio documentation

---

**Version**: 1.0.0  
**Last Updated**: August 2025  
**Compatibility**: ObjectStudio/VisualWorks 8.2+, Windows 7+
