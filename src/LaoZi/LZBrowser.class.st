Class {
	#name : #LZBrowser,
	#superclass : #ComposablePresenter,
	#instVars : [
		'menu',
		'bottomTabs',
		'logs',
		'errors',
		'status',
		'leftPanel',
		'centralPanel',
		'rightPanel'
	],
	#category : #'LaoZi-SpecUI'
}

{ #category : #specs }
LZBrowser class >> buildMainlayout: mainRow [
	mainRow
		newColumn: #leftPanel width: 100;
		newColumn: #centralPanel;
		newColumn: #rightPanel width: 200
]

{ #category : #specs }
LZBrowser class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :g | 
			g
				newRow: #menu height: self toolbarHeight;
				newRow: [ :mainRow |self buildMainlayout: mainRow ];
				newRow: #bottomTabs height: 150;
				newRow: #status height: 30  ];
		yourself
]

{ #category : #specs }
LZBrowser class >> generalMenu: aBuilder [
	<worldMenu>
	(aBuilder item: #'Lao Zi')
		order: 2.0;
		target: self;
		help: 'Set of tools to get a better Pharo experience.'
]

{ #category : #specs }
LZBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Lesson browser')
		parent: #'Lao Zi';
		order: 320;
		action: [ self new openWithSpec
				extent: 1280.0 @ 771.0;
				title: 'LaoZi - Lesson browser' ];
		help: 'Learn and test :)';
		icon: self taskbarIcon.
	aBuilder withSeparatorAfter
]

{ #category : #accessing }
LZBrowser >> bottomTabs [
	^ bottomTabs
]

{ #category : #accessing }
LZBrowser >> centralPanel [
	^ centralPanel
]

{ #category : #accessing }
LZBrowser >> cleanUpTabs [
	leftPanel tabs do: [ :t | leftPanel removeTab: t ].
	centralPanel tabs do: [ :t | leftPanel removeTab: t ].
	rightPanel tabs do: [ :t | leftPanel removeTab: t ].
]

{ #category : #initialization }
LZBrowser >> initializeWidgets [
	self installMenu.
	self installLog.
	self installStatus.
	self installPanels.
]

{ #category : #initialization }
LZBrowser >> installLog [
	bottomTabs := self newTabManager.
	logs := self newList.
	errors := self newList.
	bottomTabs addTab: (self newTab: 'Logs' for: logs).
	bottomTabs addTab: (self newTab: 'Errors' for: errors)
]

{ #category : #initialization }
LZBrowser >> installMenu [

	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: '';
						icon: (self iconNamed: #addIcon);
						action: [ self openLesson ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Save session';
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self saveLesson ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Restart';
						icon: (self iconNamed: #refresh);
						action: [ self newRosConnection ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Step';
						icon: (self iconNamed: #glamorousInto);
						action: [ self stepOneInstructionOnInterpreter ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Execute';
						icon: (self iconNamed: #smallDoIt);
						action: [ self runInterpreter ] ] ].
	menu applyTo: self
]

{ #category : #initialization }
LZBrowser >> installPanels [
	leftPanel := self newTabManager.
	centralPanel := self newTabManager.
	rightPanel := self newTabManager
]

{ #category : #initialization }
LZBrowser >> installStatus [
	status := self newLabel label: 'Status'
]

{ #category : #accessing }
LZBrowser >> leftPanel [
	^ leftPanel
]

{ #category : #initialization }
LZBrowser >> menu [
	^ menu
]

{ #category : #accessing }
LZBrowser >> newCenterTab: aTitle for: aWidget [
	| tab |
	tab := self newTab: aTitle for: aWidget.
	centralPanel addTab: tab.
	^ tab
]

{ #category : #accessing }
LZBrowser >> newLeftTab: aTitle for: aWidget [
	| tab |
	tab := self newTab: aTitle for: aWidget.
	leftPanel addTab: tab.
	^ tab
]

{ #category : #accessing }
LZBrowser >> newRightTab: aTitle for: aWidget [
	| tab |
	tab := self newTab: aTitle for: aWidget.
	rightPanel addTab: tab.
	^ tab
]

{ #category : #accessing }
LZBrowser >> newTab: aTitle for: aWidget [
	| tab |
	tab := self newTab.
	tab closeable: false.
	tab
		label: aTitle;
		presenter: aWidget.
	^ tab
]

{ #category : #accessing }
LZBrowser >> rightPanel [
	^ rightPanel
]

{ #category : #initialization }
LZBrowser >> status [
	^ status
]
