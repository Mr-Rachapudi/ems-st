Object subclass: #EmployeeDatabase
    instanceVariableNames: 'connection'
    classVariableNames: 'Instance'
    poolDictionaries: ''
    category: 'EmployeeManagement-Database'!

!EmployeeDatabase methodsFor: 'initialization'!

initialize
    super initialize.
    self initializeDatabase.
!

initializeDatabase
    | dbPath |
    dbPath := 'employees.db'.
    connection := SQLiteConnection on: dbPath.
    connection open.
    self createEmployeeTable.
!

createEmployeeTable
    | sql |
    sql := 'CREATE TABLE IF NOT EXISTS employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        department TEXT NOT NULL,
        salary REAL NOT NULL,
        hire_date TEXT NOT NULL
    )'.
    connection execute: sql.
! !

!EmployeeDatabase methodsFor: 'database operations'!

insertEmployee: anEmployee
    | sql statement |
    sql := 'INSERT INTO employees (name, email, department, salary, hire_date) VALUES (?, ?, ?, ?, ?)'.
    statement := connection prepare: sql.
    statement
        bind: 1 to: anEmployee name;
        bind: 2 to: anEmployee email;
        bind: 3 to: anEmployee department;
        bind: 4 to: anEmployee salary;
        bind: 5 to: anEmployee hireDate asString.
    statement execute.
    anEmployee id: connection lastInsertRowId.
    statement finalize.
    ^anEmployee
!

findEmployeeById: anId
    | sql statement result employee |
    sql := 'SELECT id, name, email, department, salary, hire_date FROM employees WHERE id = ?'.
    statement := connection prepare: sql.
    statement bind: 1 to: anId.
    result := statement step.
    result ifTrue: [
        employee := Employee new
            id: (statement columnAt: 1);
            name: (statement columnAt: 2);
            email: (statement columnAt: 3);
            department: (statement columnAt: 4);
            salary: (statement columnAt: 5);
            hireDate: (Date fromString: (statement columnAt: 6));
            yourself.
    ].
    statement finalize.
    ^employee
!

findAllEmployees
    | sql statement employees employee |
    employees := OrderedCollection new.
    sql := 'SELECT id, name, email, department, salary, hire_date FROM employees ORDER BY name'.
    statement := connection prepare: sql.
    [statement step] whileTrue: [
        employee := Employee new
            id: (statement columnAt: 1);
            name: (statement columnAt: 2);
            email: (statement columnAt: 3);
            department: (statement columnAt: 4);
            salary: (statement columnAt: 5);
            hireDate: (Date fromString: (statement columnAt: 6));
            yourself.
        employees add: employee.
    ].
    statement finalize.
    ^employees
!

updateEmployee: anEmployee
    | sql statement |
    sql := 'UPDATE employees SET name = ?, email = ?, department = ?, salary = ?, hire_date = ? WHERE id = ?'.
    statement := connection prepare: sql.
    statement
        bind: 1 to: anEmployee name;
        bind: 2 to: anEmployee email;
        bind: 3 to: anEmployee department;
        bind: 4 to: anEmployee salary;
        bind: 5 to: anEmployee hireDate asString;
        bind: 6 to: anEmployee id.
    statement execute.
    statement finalize.
    ^anEmployee
!

deleteEmployee: anEmployee
    | sql statement |
    sql := 'DELETE FROM employees WHERE id = ?'.
    statement := connection prepare: sql.
    statement bind: 1 to: anEmployee id.
    statement execute.
    statement finalize.
! !

!EmployeeDatabase methodsFor: 'connection management'!

close
    connection ifNotNil: [connection close. connection := nil].
! !

!EmployeeDatabase class methodsFor: 'instance creation'!

instance
    Instance ifNil: [Instance := self new].
    ^Instance
!

reset
    Instance ifNotNil: [Instance close].
    Instance := nil.
! !
