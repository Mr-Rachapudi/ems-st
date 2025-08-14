Panel subclass: #EmployeeFormView
    instanceVariableNames: 'nameField emailField departmentCombo salaryField hireDateField saveButton cancelButton saveBlock cancelBlock currentEmployee'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-GUI'!

!EmployeeFormView methodsFor: 'initialization'!

initialize
    super initialize.
    self initializeComponents.
    self layoutComponents.
!

initializeComponents
    nameField := TextField new.
    emailField := TextField new.
    departmentCombo := ComboBox new.
    salaryField := TextField new.
    hireDateField := TextField new.
    saveButton := Button new.
    cancelButton := Button new.
    
    self initializeDepartmentCombo.
    self initializeButtons.
!

initializeDepartmentCombo
    departmentCombo
        addItems: #('Engineering' 'Sales' 'Marketing' 'HR' 'Finance' 'Operations' 'IT' 'Legal');
        readOnly: true.
!

initializeButtons
    saveButton
        text: 'Save';
        onClicked: [self saveEmployee].
    
    cancelButton
        text: 'Cancel';
        onClicked: [self cancelEdit].
!

layoutComponents
    | formPanel buttonPanel |
    formPanel := GridPanel new rows: 5 columns: 2.
    buttonPanel := Panel new.
    
    formPanel
        add: (Label new text: 'Name:') at: 1@1;
        add: nameField at: 2@1;
        add: (Label new text: 'Email:') at: 1@2;
        add: emailField at: 2@2;
        add: (Label new text: 'Department:') at: 1@3;
        add: departmentCombo at: 2@3;
        add: (Label new text: 'Salary:') at: 1@4;
        add: salaryField at: 2@4;
        add: (Label new text: 'Hire Date:') at: 1@5;
        add: hireDateField at: 2@5.
    
    buttonPanel
        add: saveButton;
        add: cancelButton.
    
    self
        add: formPanel withConstraints: #fill;
        add: buttonPanel withConstraints: #bottom.
! !

!EmployeeFormView methodsFor: 'employee operations'!

displayEmployee: anEmployee
    currentEmployee := anEmployee.
    
    nameField text: (anEmployee name ifNil: ['']).
    emailField text: (anEmployee email ifNil: ['']).
    departmentCombo selectedItem: (anEmployee department ifNil: ['Engineering']).
    salaryField text: (anEmployee salary ifNil: [0]) printString.
    hireDateField text: (anEmployee hireDate ifNil: [Date today]) printString.
!

clearForm
    currentEmployee := nil.
    nameField text: ''.
    emailField text: ''.
    departmentCombo selectedIndex: 1.
    salaryField text: '0'.
    hireDateField text: Date today printString.
!

saveEmployee
    | employee salary hireDate |
    
    [salary := salaryField text asNumber]
        on: Error
        do: [:ex | 
            MessageBox error: 'Invalid salary format'.
            ^self
        ].
    
    [hireDate := Date fromString: hireDateField text]
        on: Error
        do: [:ex |
            MessageBox error: 'Invalid date format (use YYYY-MM-DD)'.
            ^self
        ].
    
    employee := currentEmployee ifNil: [Employee new].
    employee
        name: nameField text;
        email: emailField text;
        department: departmentCombo selectedItem;
        salary: salary;
        hireDate: hireDate.
    
    saveBlock ifNotNil: [saveBlock value: employee].
!

cancelEdit
    cancelBlock ifNotNil: [cancelBlock value].
! !

!EmployeeFormView methodsFor: 'event handling'!

onSave: aBlock
    saveBlock := aBlock
!

onCancel: aBlock
    cancelBlock := aBlock
! !
