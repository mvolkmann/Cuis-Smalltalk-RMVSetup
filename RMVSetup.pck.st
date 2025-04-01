'From Cuis7.3 [latest update: #7092] on 1 April 2025 at 12:27:39 pm'!
'Description '!
!provides: 'RMVSetup' 1 49!
!requires: 'FeatureRequirer' 1 3 nil!
!requires: 'WindowManager' 1 11 nil!
!requires: 'MethodFinder' 1 121 nil!
!requires: 'SearchBrowser' 1 46 nil!
!requires: 'Extras' 1 0 nil!
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


!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 2/16/2025 11:16:53'!
coolDemo
	| target |
	
	target := TextEditor open
		percentWidth: 0.1;
		percentHeight: 0.2;
		x: #worldCenter y: #worldCenter.
	TextEditor open
		percentWidth: 0.1;
		percentHeight: 0.2;
		x: #leftOf -> target y: #worldCenter.
	TextEditor open
		percentWidth: 0.1;
		percentHeight: 0.2;
		x: #rightOf -> target y: #worldCenter.
	TextEditor open
		percentWidth: 0.1;
		percentHeight: 0.2;
		x: #worldCenter y: #topOf -> target.
	TextEditor open
		percentWidth: 0.1;
		percentHeight: 0.2;
		x: #worldCenter y: #bottomOf -> target.! !

!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 3/4/2025 13:35:13'!
initialize
	
	"Set preferences."
	Utilities setAuthorName: 'R. Mark Volkmann' initials: 'rmv'.
	Preferences name: #showAssignmentAsLeftArrow category: #programming value: true.
	Preferences saveToDisk: #showAssignmentAsLeftArrow.
	WindowManager openAtCursor.
	
	"Add World background image."
	WindowManager tileImage: '../Cuis-Smalltalk-RMVSetup/altitude1600.jpg'.
	
	self openWindows.! !

!RMVSetup class methodsFor: 'class initialization' stamp: 'rmv 3/12/2025 20:59:04'!
openWindows
	"Open my preferred initial windows in the locations and sizes I prefer.
	Specify size before location because the location calculation can depend on the size.
	Most of the methods used here were added to the SystemWindow class."
	| browser |
	
	browser := Browser open
		fullHeight;
		x: #worldCenter y: #worldTop.

	Browser open
		fullHeightMinusTaskbar;
		x: #leftOf -> browser y: #worldTop.
	
	Workspace open
		percentHeight: 0.7;
		x: #rightOf -> browser y: #worldTop.

	Transcript open
		percentHeight: 0.3;
		x: #rightOf -> browser y: #worldBottom.
	Transcript clearAll.
	
	MessageNames open
		x: #worldRight y: #worldTop.

	CodePackageList open
		x: #worldLeft y: #taskbarTop.
			
	browser activateWindow.! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/16/2025 11:04:38'!
fullHeight
	| world |

	world := UISupervisor ui.
	self morphExtent: (extent x) @ (world morphExtent y).! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/14/2025 10:30:45'!
fullHeightMinusTaskbar
	| taskbarHeight world |

	world := UISupervisor ui.
	taskbarHeight := world taskbar morphExtent y.
	self morphExtent: (self morphExtent x) @ (world morphExtent y - taskbarHeight).! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/16/2025 11:04:28'!
fullWidth
	| world |

	world := UISupervisor ui.
	self morphExtent: (world morphExtent x) @ (extent y)! !

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

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/16/2025 11:15:41'!
x: xLocation y: yLocation
	"Move this window to a new location specified by xLocation and yLocation.
	The arguments can be specific symbols or Associations where
	the key is a specific symbol and the value is another window."
	| newX newY taskbarHeight windowHeight windowWidth world worldHeight worldWidth |

	world := UISupervisor ui.
	worldWidth := world morphExtent x.
	worldHeight := world morphExtent y.
	taskbarHeight := world taskbar morphExtent y.
	windowWidth := extent x.
	windowHeight := extent y.

	newX := xLocation caseOf: {
		[ #worldLeft ] -> [ 0 ].
		[ #worldRight ] -> [ worldWidth - windowWidth ].
		[ #worldCenter ] -> [ (worldWidth / 2) - (windowWidth / 2) ].
	} otherwise: [
		xLocation isKindOf: Association ::
			ifTrue: [
				| targetWindow |
				targetWindow := xLocation value.
				xLocation key caseOf: {
					[ #leftOf ] -> [ targetWindow morphPosition x - windowWidth ].
					[ #rightOf ] -> [
						targetWindow morphPosition x + targetWindow morphExtent x
					].
				} otherwise: nil.
			]
			ifFalse: nil
	].
	
	newY := yLocation caseOf: {
		[ #worldTop ] -> [ 0 ].
		[ #worldBottom ] -> [ worldHeight - windowHeight ].
		[ #worldCenter ] -> [ (worldHeight / 2) - (windowHeight / 2) ].
		[ #taskbarTop ] -> [ worldHeight - taskbarHeight - windowHeight ].
	} otherwise: [
		yLocation isKindOf: Association ::
			ifTrue: [
				| targetWindow |
				targetWindow := yLocation value.
				yLocation key caseOf: {
					[ #topOf ] -> [ targetWindow morphPosition y - windowHeight ].
					[ #bottomOf ] -> [
						targetWindow morphPosition y + targetWindow morphExtent y
					].
				} otherwise: nil.
			]
			ifFalse: nil
	].
	
	"If newX or newY are not set, use their current values."
	newX ifNil: [ newX := location translation x ].
	newY ifNil: [ newY := location translation y ].
	
	"Ensure that using newX and newY will result in
	the window being entirely inside the World."
	newX < 0 ifTrue: [ newX := 0 ].
	newX + windowWidth > worldWidth ifTrue: [ newX := worldWidth - windowWidth ].
	newY < 0 ifTrue: [ newY := 0 ].
	newY + windowHeight > worldHeight ifTrue: [ newY := worldHeight - windowHeight ].
	
	self morphPosition: newX @ newY.! !
RMVSetup initialize!
