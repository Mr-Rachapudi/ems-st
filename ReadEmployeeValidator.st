Object subclass: #ReadEmployeeValidator
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-Validation'!

!ReadEmployeeValidator methodsFor: 'validation'!

validateEmployeeId: anId
    | errors |
    errors := OrderedCollection new.
    
    anId ifNil: [errors add: 'Employee ID cannot be nil'. ^errors].
    anId isInteger ifFalse: [errors add: 'Employee ID must be an integer'. ^errors].
    anId <= 0 ifTrue: [errors add: 'Employee ID must be greater than 0'. ^errors].
    anId > 2147483647 ifTrue: [errors add: 'Employee ID is too large'. ^errors].
    
    ^errors
!

validateSearchCriteria: searchCriteria
    | errors |
    errors := OrderedCollection new.
    
    searchCriteria ifNil: [^errors].
    searchCriteria isEmpty ifTrue: [^errors].
    
    searchCriteria size > 100 ifTrue: [
        errors add: 'Search criteria cannot exceed 100 characters'
    ].
    
    ^errors
!

validateDepartmentFilter: department
    | errors validDepartments |
    errors := OrderedCollection new.
    validDepartments := #('Engineering' 'Sales' 'Marketing' 'HR' 'Finance' 'Operations' 'IT' 'Legal').
    
    department ifNil: [^errors].
    department isEmpty ifTrue: [^errors].
    
    (validDepartments includes: department) ifFalse: [
        errors add: 'Invalid department filter: ', department
    ].
    
    ^errors
!

validateSalaryRange: minSalary to: maxSalary
    | errors |
    errors := OrderedCollection new.
    
    minSalary ifNotNil: [
        minSalary < 0 ifTrue: [errors add: 'Minimum salary cannot be negative'].
        minSalary > 1000000 ifTrue: [errors add: 'Minimum salary cannot exceed 1,000,000'].
    ].
    
    maxSalary ifNotNil: [
        maxSalary < 0 ifTrue: [errors add: 'Maximum salary cannot be negative'].
        maxSalary > 1000000 ifTrue: [errors add: 'Maximum salary cannot exceed 1,000,000'].
    ].
    
    (minSalary notNil and: [maxSalary notNil]) ifTrue: [
        minSalary > maxSalary ifTrue: [
            errors add: 'Minimum salary cannot be greater than maximum salary'
        ]
    ].
    
    ^errors
! !

!ReadEmployeeValidator class methodsFor: 'instance creation'!

new
    ^super new
! !
