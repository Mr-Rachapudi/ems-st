Object subclass: #EmployeeManagementController
    instanceVariableNames: 'mainWindow service'
    classVariableNames: 'Instance'
    poolDictionaries: ''
    category: 'EmployeeManagement-Controller'!

!EmployeeManagementController methodsFor: 'initialization'!

initialize
    super initialize.
    service := EmployeeService instance.
    self initializeMainWindow.
!

initializeMainWindow
    mainWindow := EmployeeManagementWindow new.
    mainWindow createMenuBar.
! !

!EmployeeManagementController methodsFor: 'application control'!

start
    mainWindow open.
    ^mainWindow
!

shutdown
    service ifNotNil: [
        EmployeeDatabase reset.
        EmployeeService reset.
    ].
    mainWindow ifNotNil: [mainWindow close].
! !

!EmployeeManagementController class methodsFor: 'instance creation'!

instance
    Instance ifNil: [Instance := self new].
    ^Instance
!

reset
    Instance ifNotNil: [Instance shutdown].
    Instance := nil.
! !
