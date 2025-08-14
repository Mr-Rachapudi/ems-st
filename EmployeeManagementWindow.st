ApplicationWindow subclass: #EmployeeManagementWindow
    instanceVariableNames: 'employeeListView employeeFormView searchView currentEmployee service'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-GUI'!

!EmployeeManagementWindow methodsFor: 'initialization'!

initialize
    super initialize.
    service := EmployeeService instance.
    self initializeWindow.
    self initializeComponents.
    self layoutComponents.
    self refreshEmployeeList.
!

initializeWindow
    self
        title: 'Employee Management System';
        bounds: (Rectangle origin: 100@100 extent: 800@600);
        minimumSize: 600@400.
!

initializeComponents
    employeeListView := EmployeeListView new.
    employeeFormView := EmployeeFormView new.
    searchView := EmployeeSearchView new.
    
    employeeListView onSelectionChanged: [:employee | self selectEmployee: employee].
    employeeFormView onSave: [:employee | self saveEmployee: employee].
    employeeFormView onCancel: [self clearSelection].
    searchView onSearch: [:criteria | self searchEmployees: criteria].
!

layoutComponents
    | mainPanel leftPanel rightPanel |
    mainPanel := Panel new.
    leftPanel := Panel new.
    rightPanel := Panel new.
    
    leftPanel
        add: searchView withConstraints: #top;
        add: employeeListView withConstraints: #fill.
    
    rightPanel
        add: employeeFormView withConstraints: #fill.
    
    mainPanel
        add: leftPanel withConstraints: (LayoutConstraints new leftFraction: 0; rightFraction: 0.5);
        add: rightPanel withConstraints: (LayoutConstraints new leftFraction: 0.5; rightFraction: 1).
    
    self add: mainPanel withConstraints: #fill.
! !

!EmployeeManagementWindow methodsFor: 'employee operations'!

selectEmployee: anEmployee
    currentEmployee := anEmployee.
    employeeFormView displayEmployee: anEmployee.
!

clearSelection
    currentEmployee := nil.
    employeeFormView clearForm.
!

saveEmployee: anEmployee
    [
        anEmployee id ifNil: [
            service createEmployee: anEmployee.
            self showMessage: 'Employee created successfully'.
        ] ifNotNil: [
            service updateEmployee: anEmployee.
            self showMessage: 'Employee updated successfully'.
        ].
        self refreshEmployeeList.
        self clearSelection.
    ] on: Error do: [:ex |
        self showError: ex messageText
    ]
!

deleteSelectedEmployee
    currentEmployee ifNil: [
        self showMessage: 'Please select an employee to delete'.
        ^self
    ].
    
    (self confirm: 'Are you sure you want to delete ', currentEmployee name, '?') ifTrue: [
        [
            service deleteEmployee: currentEmployee.
            self showMessage: 'Employee deleted successfully'.
            self refreshEmployeeList.
            self clearSelection.
        ] on: Error do: [:ex |
            self showError: ex messageText
        ]
    ]
!

searchEmployees: searchCriteria
    | results |
    [
        results := searchCriteria isEmpty
            ifTrue: [service readAllEmployees]
            ifFalse: [service searchEmployeesByName: searchCriteria].
        employeeListView displayEmployees: results.
    ] on: Error do: [:ex |
        self showError: ex messageText
    ]
!

refreshEmployeeList
    [
        employeeListView displayEmployees: service readAllEmployees.
    ] on: Error do: [:ex |
        self showError: ex messageText
    ]
! !

!EmployeeManagementWindow methodsFor: 'menu actions'!

createMenuBar
    | menuBar fileMenu employeeMenu helpMenu |
    menuBar := MenuBar new.
    
    fileMenu := Menu new.
    fileMenu
        addItem: 'New Employee' action: [self newEmployee];
        addItem: 'Refresh' action: [self refreshEmployeeList];
        addSeparator;
        addItem: 'Exit' action: [self close].
    
    employeeMenu := Menu new.
    employeeMenu
        addItem: 'Create Employee' action: [self newEmployee];
        addItem: 'Edit Employee' action: [self editSelectedEmployee];
        addItem: 'Delete Employee' action: [self deleteSelectedEmployee];
        addSeparator;
        addItem: 'Search Employees' action: [self focusSearch].
    
    helpMenu := Menu new.
    helpMenu
        addItem: 'About' action: [self showAbout].
    
    menuBar
        addMenu: fileMenu label: 'File';
        addMenu: employeeMenu label: 'Employee';
        addMenu: helpMenu label: 'Help'.
    
    self menuBar: menuBar.
!

newEmployee
    self clearSelection.
    employeeFormView displayEmployee: Employee new.
!

editSelectedEmployee
    currentEmployee ifNil: [
        self showMessage: 'Please select an employee to edit'.
    ]
!

focusSearch
    searchView focusSearchField.
!

showAbout
    self showMessage: 'Employee Management System v1.0
Built with ObjectStudio ANSI Smalltalk
© 2025 Employee Management Solutions'
! !

!EmployeeManagementWindow methodsFor: 'user feedback'!

showMessage: aMessage
    MessageBox information: aMessage
!

showError: anErrorMessage
    MessageBox error: anErrorMessage
!

confirm: aMessage
    ^MessageBox question: aMessage
! !

!EmployeeManagementWindow class methodsFor: 'instance creation'!

open
    ^self new open
! !
