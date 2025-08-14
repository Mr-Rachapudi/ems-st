Object subclass: #DeleteEmployeeValidator
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-Validation'!

!DeleteEmployeeValidator methodsFor: 'validation'!

validateEmployeeForDeletion: anEmployee
    | errors |
    errors := OrderedCollection new.
    
    self validateEmployeeId: anEmployee id errors: errors.
    self validateEmployeeExists: anEmployee errors: errors.
    self validateDeletionPermissions: anEmployee errors: errors.
    
    ^errors
!

validateEmployeeId: anId errors: errors
    anId ifNil: [errors add: 'Employee ID cannot be nil for deletion'. ^self].
    anId isInteger ifFalse: [errors add: 'Employee ID must be an integer'. ^self].
    anId <= 0 ifTrue: [errors add: 'Employee ID must be greater than 0'. ^self].
!

validateEmployeeExists: anEmployee errors: errors
    anEmployee ifNil: [errors add: 'Employee does not exist and cannot be deleted'. ^self].
    anEmployee name ifNil: [errors add: 'Employee record is incomplete'. ^self].
    anEmployee name isEmpty ifTrue: [errors add: 'Employee record is incomplete'. ^self].
!

validateDeletionPermissions: anEmployee errors: errors
    anEmployee ifNil: [^self].
    
    anEmployee department = 'HR' ifTrue: [
        errors add: 'HR employees require special approval for deletion'
    ].
    
    anEmployee salary > 100000 ifTrue: [
        errors add: 'High-salary employees require manager approval for deletion'
    ].
    
    (Date today subtractDays: anEmployee hireDate) < 30 ifTrue: [
        errors add: 'Recently hired employees (less than 30 days) require HR approval for deletion'
    ].
!

validateReferentialIntegrity: anEmployee
    | errors |
    errors := OrderedCollection new.
    
    anEmployee ifNil: [^errors].
    
    ^errors
!

validateDeletionReason: reason
    | errors validReasons |
    errors := OrderedCollection new.
    validReasons := #('Resignation' 'Termination' 'Retirement' 'Transfer' 'Other').
    
    reason ifNil: [errors add: 'Deletion reason is required'. ^errors].
    reason isEmpty ifTrue: [errors add: 'Deletion reason cannot be empty'. ^errors].
    
    (validReasons includes: reason) ifFalse: [
        errors add: 'Deletion reason must be one of: ', (validReasons joinSeparatedBy: ', ')
    ].
    
    ^errors
! !

!DeleteEmployeeValidator class methodsFor: 'instance creation'!

new
    ^super new
! !
