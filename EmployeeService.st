Object subclass: #EmployeeService
    instanceVariableNames: 'database createValidator readValidator updateValidator deleteValidator'
    classVariableNames: 'Instance'
    poolDictionaries: ''
    category: 'EmployeeManagement-Service'!

!EmployeeService methodsFor: 'initialization'!

initialize
    super initialize.
    database := EmployeeDatabase instance.
    createValidator := CreateEmployeeValidator new.
    readValidator := ReadEmployeeValidator new.
    updateValidator := UpdateEmployeeValidator new.
    deleteValidator := DeleteEmployeeValidator new.
! !

!EmployeeService methodsFor: 'CRUD operations'!

createEmployee: anEmployee
    | errors |
    errors := createValidator validateEmployee: anEmployee.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Employee creation failed' errors: errors
    ].
    
    [^database insertEmployee: anEmployee]
        on: Error
        do: [:ex | self signalDatabaseError: 'Failed to create employee' cause: ex]
!

readEmployee: anId
    | errors employee |
    errors := readValidator validateEmployeeId: anId.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Employee retrieval failed' errors: errors
    ].
    
    [employee := database findEmployeeById: anId]
        on: Error
        do: [:ex | self signalDatabaseError: 'Failed to read employee' cause: ex].
    
    employee ifNil: [
        self signalNotFoundError: 'Employee with ID ', anId printString, ' not found'
    ].
    
    ^employee
!

readAllEmployees
    [^database findAllEmployees]
        on: Error
        do: [:ex | self signalDatabaseError: 'Failed to read employees' cause: ex]
!

updateEmployee: anEmployee
    | errors existingEmployee |
    errors := updateValidator validateEmployeeForUpdate: anEmployee.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Employee update failed' errors: errors
    ].
    
    existingEmployee := self readEmployee: anEmployee id.
    
    errors := updateValidator validateSalaryIncrease: existingEmployee salary newSalary: anEmployee salary.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Salary update validation failed' errors: errors
    ].
    
    [^database updateEmployee: anEmployee]
        on: Error
        do: [:ex | self signalDatabaseError: 'Failed to update employee' cause: ex]
!

deleteEmployee: anEmployee
    | errors |
    errors := deleteValidator validateEmployeeForDeletion: anEmployee.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Employee deletion failed' errors: errors
    ].
    
    [database deleteEmployee: anEmployee]
        on: Error
        do: [:ex | self signalDatabaseError: 'Failed to delete employee' cause: ex]
!

deleteEmployeeById: anId
    | employee |
    employee := self readEmployee: anId.
    self deleteEmployee: employee.
! !

!EmployeeService methodsFor: 'search operations'!

searchEmployeesByName: searchTerm
    | errors allEmployees |
    errors := readValidator validateSearchCriteria: searchTerm.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Search validation failed' errors: errors
    ].
    
    allEmployees := self readAllEmployees.
    searchTerm ifNil: [^allEmployees].
    searchTerm isEmpty ifTrue: [^allEmployees].
    
    ^allEmployees select: [:emp | emp name includesSubstring: searchTerm caseSensitive: false]
!

searchEmployeesByDepartment: department
    | errors allEmployees |
    errors := readValidator validateDepartmentFilter: department.
    errors isEmpty ifFalse: [
        ^self signalValidationError: 'Department search validation failed' errors: errors
    ].
    
    allEmployees := self readAllEmployees.
    department ifNil: [^allEmployees].
    department isEmpty ifTrue: [^allEmployees].
    
    ^allEmployees select: [:emp | emp department = department]
! !

!EmployeeService methodsFor: 'error handling'!

signalValidationError: message errors: errors
    | errorMessage |
    errorMessage := message, ': ', (errors joinSeparatedBy: '; ').
    ValidationError signal: errorMessage
!

signalDatabaseError: message cause: exception
    | errorMessage |
    errorMessage := message, ': ', exception messageText.
    DatabaseError signal: errorMessage
!

signalNotFoundError: message
    NotFoundError signal: message
! !

!EmployeeService class methodsFor: 'instance creation'!

instance
    Instance ifNil: [Instance := self new].
    ^Instance
!

reset
    Instance := nil.
! !

!EmployeeService class methodsFor: 'error definitions'!

initialize
    ValidationError := Error subclass: #ValidationError
        instanceVariableNames: ''
        classVariableNames: ''
        poolDictionaries: ''
        category: 'EmployeeManagement-Exceptions'.
    
    DatabaseError := Error subclass: #DatabaseError
        instanceVariableNames: ''
        classVariableNames: ''
        poolDictionaries: ''
        category: 'EmployeeManagement-Exceptions'.
    
    NotFoundError := Error subclass: #NotFoundError
        instanceVariableNames: ''
        classVariableNames: ''
        poolDictionaries: ''
        category: 'EmployeeManagement-Exceptions'.
! !
