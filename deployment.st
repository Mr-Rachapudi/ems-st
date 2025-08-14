Object subclass: #EmployeeManagementDeployment
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-Deployment'!

!EmployeeManagementDeployment class methodsFor: 'deployment configuration'!

applicationName
    ^'EmployeeManagementSystem'
!

applicationVersion
    ^'1.0.0'
!

mainClass
    ^EmployeeManagementApp
!

startupMethod
    ^#main
!

requiredClasses
    ^#(
        Employee
        EmployeeDatabase
        CreateEmployeeValidator
        ReadEmployeeValidator
        UpdateEmployeeValidator
        DeleteEmployeeValidator
        EmployeeService
        EmployeeManagementWindow
        EmployeeListView
        EmployeeFormView
        EmployeeSearchView
        EmployeeManagementController
        EmployeeManagementApp
    )
!

requiredPackages
    ^#(
        'ObjectStudio-Core'
        'ObjectStudio-GUI'
        'ObjectStudio-Database'
        'SQLite-Driver'
    )
!

deploymentSettings
    ^Dictionary new
        at: 'executable-name' put: 'EmployeeManagement.exe';
        at: 'icon-file' put: 'employee-icon.ico';
        at: 'version-info' put: self versionInfo;
        at: 'target-platform' put: 'Windows';
        at: 'minimum-windows-version' put: 'Windows 7';
        at: 'preferred-windows-version' put: 'Windows 11';
        at: 'include-runtime' put: true;
        at: 'compress-executable' put: true;
        at: 'create-installer' put: true;
        yourself
!

versionInfo
    ^Dictionary new
        at: 'FileVersion' put: '1.0.0.0';
        at: 'ProductVersion' put: '1.0.0';
        at: 'CompanyName' put: 'Employee Management Solutions';
        at: 'FileDescription' put: 'Employee Management System';
        at: 'ProductName' put: 'Employee Management System';
        at: 'LegalCopyright' put: '© 2025 Employee Management Solutions';
        at: 'OriginalFilename' put: 'EmployeeManagement.exe';
        yourself
!

buildInstructions
    ^'To build the Windows executable:

1. Open ObjectStudio IDE
2. Load all .st files from this project
3. Compile all classes
4. Open Deployment Manager
5. Create new deployment configuration:
   - Application Name: ', self applicationName, '
   - Main Class: ', self mainClass name, '
   - Startup Method: ', self startupMethod, '
   - Target: Windows Executable
6. Add required classes and packages
7. Configure deployment settings
8. Build executable

The resulting EmployeeManagement.exe will be a standalone Windows application
that includes the ObjectStudio runtime and all required dependencies.'
! !

!EmployeeManagementDeployment class methodsFor: 'build automation'!

createDeploymentScript
    | script |
    script := '# ObjectStudio Deployment Script
# Employee Management System v', self applicationVersion, '

# Load project files
', (self requiredClasses collect: [:className | 
    'load "', className, '.st"'
]) joinSeparatedBy: String cr, '

# Compile all classes
compile-all

# Create deployment configuration
deployment-config create "', self applicationName, '"
deployment-config set main-class "', self mainClass name, '"
deployment-config set startup-method "', self startupMethod, '"
deployment-config set target "windows-executable"

# Add required classes
', (self requiredClasses collect: [:className |
    'deployment-config add-class "', className, '"'
]) joinSeparatedBy: String cr, '

# Configure settings
deployment-config set executable-name "EmployeeManagement.exe"
deployment-config set include-runtime true
deployment-config set compress-executable true
deployment-config set target-platform "Windows"

# Build executable
deployment-config build

echo "Build completed: EmployeeManagement.exe"
'.
    ^script
! !
