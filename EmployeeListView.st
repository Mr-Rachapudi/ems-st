ListBox subclass: #EmployeeListView
    instanceVariableNames: 'employees selectionChangedBlock'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-GUI'!

!EmployeeListView methodsFor: 'initialization'!

initialize
    super initialize.
    employees := OrderedCollection new.
    self
        multipleSelection: false;
        hasHorizontalScrollBar: true;
        hasVerticalScrollBar: true.
    self onSelectionChanged: [self handleSelectionChanged].
!

displayEmployees: employeeCollection
    employees := employeeCollection copy.
    self removeAll.
    employees do: [:employee |
        self addItem: employee displayString
    ].
! !

!EmployeeListView methodsFor: 'event handling'!

onSelectionChanged: aBlock
    selectionChangedBlock := aBlock
!

handleSelectionChanged
    | selectedIndex selectedEmployee |
    selectedIndex := self selectedIndex.
    selectedEmployee := selectedIndex > 0
        ifTrue: [employees at: selectedIndex]
        ifFalse: [nil].
    selectionChangedBlock ifNotNil: [
        selectionChangedBlock value: selectedEmployee
    ].
! !

!EmployeeListView methodsFor: 'accessing'!

selectedEmployee
    | selectedIndex |
    selectedIndex := self selectedIndex.
    ^selectedIndex > 0
        ifTrue: [employees at: selectedIndex]
        ifFalse: [nil]
!

employeeCount
    ^employees size
! !
