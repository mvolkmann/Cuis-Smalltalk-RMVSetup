'From Cuis7.3 [latest update: #7044] on 15 February 2025 at 4:28:36 pm'!
'Description '!
!provides: 'RMVSetup' 1 37!
!requires: 'LogAs' 1 1 nil!
!requires: 'Switch' 1 1 nil!
!requires: 'WindowManager' 1 11 nil!
!requires: 'MethodFinder' 1 121 nil!
!requires: 'SearchBrowser' 1 46 nil!
SystemOrganization addCategory: #RMVSetup!


!classDefinition: #RMVSetup category: #RMVSetup!
Object subclass: #RMVSetup
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RMVSetup'!
!classDefinition: 'RMVSetup class' category: #RMVSetup!
RMVSetup class
	instanceVariableNames: ''!


!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 2/13/2025 13:00:46'!
initialize
	| filePath stream |
	
	"Set preferences."
	Utilities setAuthorName: 'R. Mark Volkmann' initials: 'rmv'.
	Preferences name: #showAssignmentAsLeftArrow category: #programming value: true.
	Preferences saveToDisk: #showAssignmentAsLeftArrow.
	WindowManager openAtCursor.
	
	"Add World background image."
	Preferences at: #backgroundEffect put: #tile.
	filePath := '../Cuis-Smalltalk-RMVSetup/altitude1600.jpg'.
	stream := filePath asFileEntry readStream.
	self runningWorld backgroundImageData: stream binary contentsOfEntireFile.
	
	self openWindows.! !

!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 2/15/2025 16:28:32'!
openWindows
	| browser |
	
	browser := Browser open
		moveTo: #worldXCenter;
		moveTo: #worldTop;
		fullHeight.

	Browser open
		moveLeftOf: browser;
		moveTo: #worldTop;
		fullHeightMinusTaskbar.
	
	Workspace open
		percentHeight: 0.7;
		moveRightOf: browser;
		moveTo: #worldTop.

	Transcript open
		percentHeight: 0.3;
		moveRightOf: browser;
		moveTo: #worldBottom.
	Transcript clearAll.
	
	MessageNames open
		moveTo: #worldRight;
		moveTo: #worldTop.

	CodePackageList open
		moveTo: #worldLeft;
		moveTo: #taskbarTop.
	
	browser activateWindow.! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/14/2025 10:29:52'!
fullHeight
	| world |

	world := UISupervisor ui.
	self morphExtent: (self morphExtent x) @ (world morphExtent y).! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/14/2025 10:30:45'!
fullHeightMinusTaskbar
	| taskbarHeight world |

	world := UISupervisor ui.
	taskbarHeight := world taskbar morphExtent y.
	self morphExtent: (self morphExtent x) @ (world morphExtent y - taskbarHeight).! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/14/2025 10:32:01'!
moveLeftOf: aWindow
	"Move this window to the left of aWindow and guarantee
	that it will not extend past the left edge of the World."
	| newX newY position |

	position := aWindow morphPosition.
	newX := position x - extent x max: 0.
	newY := position y.	
	self morphPosition: newX @ newY.! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/14/2025 10:25:23'!
moveRightOf: aWindow
	"Move this window to the right of aWindow and guarantee
	that it will not extend past the right edge of the World."
	| newX newY position world worldWidth |

	world := UISupervisor ui.
	worldWidth := world morphExtent x.
	position := aWindow morphPosition.
	newX := position x + aWindow morphExtent x min: (worldWidth - extent x).
	newY := position y.	
	self morphPosition: newX @ newY.! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/15/2025 16:21:58'!
moveTo: aSymbol
	| newX newY taskbarHeight world worldHeight worldWidth |

	world := UISupervisor ui.
	worldWidth := world morphExtent x.
	worldHeight := world morphExtent y.
	taskbarHeight := world taskbar morphExtent y.

	newX := aSymbol caseOf: {
		[ #worldLeft ] -> [ 0 ].
		[ #worldRight ] -> [ worldWidth - extent x ].
		[ #worldXCenter ] -> [ (worldWidth / 2) - (extent x / 2) ].
	} otherwise: [ location translation x ].
	
	newY := aSymbol caseOf: {
		[ #worldTop ] -> [ 0 ].
		[ #worldBottom ] -> [ worldHeight - extent y ].
		[ #worldYCenter ] -> [ (worldHeight / 2) - (extent y / 2) ].
		[ #taskbarTop ] -> [ worldHeight - taskbarHeight - self morphExtent y ].
	} otherwise: [ location translation y ].
	
	self morphPosition: newX @ newY.! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/14/2025 10:45:03'!
percentHeight: aNumber
	| world |

	aNumber <= 0 ifTrue: [ Error signal: 'aNumber cannot be zero or less.' ].
	aNumber > 1 ifTrue: [ Error signal: 'aNumber cannot be greater than one.' ].
	
	world := UISupervisor ui.
	self morphExtent: (self morphExtent x) @ (world morphExtent y * aNumber).! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/15/2025 16:26:30'!
percentWidth: aNumber
	| world |

	aNumber <= 0 ifTrue: [ Error signal: 'aNumber cannot be zero or less.' ].
	aNumber > 1 ifTrue: [ Error signal: 'aNumber cannot be greater than one.' ].
	
	world := UISupervisor ui.
	self morphExtent: (world morphExtent x * aNumber) @ (self morphExtent y)
! !
RMVSetup initialize!
