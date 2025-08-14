Panel subclass: #EmployeeSearchView
    instanceVariableNames: 'searchField searchButton clearButton searchBlock'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'EmployeeManagement-GUI'!

!EmployeeSearchView methodsFor: 'initialization'!

initialize
    super initialize.
    self initializeComponents.
    self layoutComponents.
!

initializeComponents
    searchField := TextField new.
    searchButton := Button new.
    clearButton := Button new.
    
    searchField onTextChanged: [self performSearch].
    
    searchButton
        text: 'Search';
        onClicked: [self performSearch].
    
    clearButton
        text: 'Clear';
        onClicked: [self clearSearch].
!

layoutComponents
    | searchPanel |
    searchPanel := Panel new.
    
    searchPanel
        add: (Label new text: 'Search:');
        add: searchField;
        add: searchButton;
        add: clearButton.
    
    self add: searchPanel withConstraints: #fill.
! !

!EmployeeSearchView methodsFor: 'search operations'!

performSearch
    | searchTerm |
    searchTerm := searchField text.
    searchBlock ifNotNil: [searchBlock value: searchTerm].
!

clearSearch
    searchField text: ''.
    self performSearch.
!

focusSearchField
    searchField focus.
! !

!EmployeeSearchView methodsFor: 'event handling'!

onSearch: aBlock
    searchBlock := aBlock
! !
