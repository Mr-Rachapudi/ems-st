Object subclass: #EmployeeManagementApp
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-Application'!

!EmployeeManagementApp class methodsFor: 'application startup'!

main
    | controller |
    [
        self initializeApplication.
        controller := EmployeeManagementController instance.
        controller start.
    ] on: Error do: [:ex |
        Transcript show: 'Application startup failed: ', ex messageText; cr.
        ex pass.
    ]
!

initializeApplication
    Transcript show: 'Starting Employee Management System...'; cr.
    
    EmployeeService initialize.
    
    Transcript show: 'Employee Management System initialized successfully.'; cr.
!

version
    ^'1.0.0'
!

title
    ^'Employee Management System'
!

description
    ^'A complete employee management system built with ObjectStudio ANSI Smalltalk featuring CRUD operations, data validation, Windows GUI, and persistent storage.'
! !

!EmployeeManagementApp class methodsFor: 'application control'!

start
    ^self main
!

stop
    EmployeeManagementController reset.
    Transcript show: 'Employee Management System stopped.'; cr.
! !
