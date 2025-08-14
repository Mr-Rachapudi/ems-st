Object subclass: #Employee
    instanceVariableNames: 'id name email department salary hireDate'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-Model'!

!Employee methodsFor: 'initialization'!

initialize
    super initialize.
    id := nil.
    name := ''.
    email := ''.
    department := ''.
    salary := 0.
    hireDate := Date today.
!

initializeWithId: anId name: aName email: anEmail department: aDepartment salary: aSalary hireDate: aDate
    self initialize.
    id := anId.
    name := aName.
    email := anEmail.
    department := aDepartment.
    salary := aSalary.
    hireDate := aDate.
! !

!Employee methodsFor: 'accessing'!

id
    ^id
!

id: anId
    id := anId
!

name
    ^name
!

name: aName
    name := aName
!

email
    ^email
!

email: anEmail
    email := anEmail
!

department
    ^department
!

department: aDepartment
    department := aDepartment
!

salary
    ^salary
!

salary: aSalary
    salary := aSalary
!

hireDate
    ^hireDate
!

hireDate: aDate
    hireDate := aDate
! !

!Employee methodsFor: 'operations'!

displayString
    ^name, ' (', department, ')'
!

isValid
    ^name notEmpty and: [email notEmpty and: [department notEmpty and: [salary > 0]]]
!

asString
    ^'Employee[id=', id printString, ', name=', name, ', email=', email, ', department=', department, ', salary=', salary printString, ', hireDate=', hireDate printString, ']'
! !

!Employee methodsFor: 'comparing'!

= anEmployee
    ^self class = anEmployee class and: [id = anEmployee id]
!

hash
    ^id hash
! !

!Employee class methodsFor: 'instance creation'!

new
    ^super new initialize
!

withId: anId name: aName email: anEmail department: aDepartment salary: aSalary hireDate: aDate
    ^self new initializeWithId: anId name: aName email: anEmail department: aDepartment salary: aSalary hireDate: aDate
! !
