'From Cuis7.3 [latest update: #7044] on 13 February 2025 at 1:24:27 pm'!
'Description '!
!provides: 'RMVSetup' 1 25!
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

!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 2/13/2025 13:24:24'!
openWindows
	| browser1 browser2 browserWidth browserX cpl cplHeight
	  filled height taskbarHeight transcript transcriptHeight
	  workspace world worldHeight worldWidth x |
	
	"Get sizes that will be used to position and size some window."
	world := UISupervisor ui.
	worldWidth := world morphExtent x.
	worldHeight := world morphExtent y.
	taskbarHeight := world taskbar morphExtent y.

	"Open, position, and size a System Browser."
	browser1 := Smalltalk browse.
	browserWidth := browser1 morphExtent x.
	browserX := (worldWidth / 2) - (browserWidth / 2).
	browser1 morphPosition: browserX @ 0.
	browser1 morphExtent: browserWidth @ worldHeight.

	"Open, position, and size a Workspace."
	workspace := Workspace open.
	workspace morphExtent: browserWidth @ (worldHeight * 0.7).
	x := browserX + browserWidth.
	filled := x + browserWidth > worldWidth.
	filled ifTrue: [ x := worldWidth - browserWidth ].
	x + browserWidth > worldWidth ifTrue: [ x := worldWidth - browserWidth ].
	workspace morphPosition: x @ 0.

	"Open, position, and size a Transcript."
	transcript := Transcript open.
	transcriptHeight := worldHeight * 0.3.
	transcript morphExtent: browserWidth @ transcriptHeight.
	transcript morphPosition: x @ (worldHeight - transcriptHeight).
	Transcript clearAll.

	"Open, position, and size another System Browser."
	browser2 := Smalltalk browse.
	"Making the x position no less than 30 leaves a vertical strip of the World visible
	so that can be clicked to open the World menu."
	browser2 morphPosition: (browserX - browserWidth max: 30) @ 0.
	height := filled ifTrue: [ worldHeight - taskbarHeight ] ifFalse: worldHeight.
	browser2 morphExtent: browserWidth @ height.
	
	"Open, position, and size an Installed Packages window."
	cpl := CodePackageList open.
	cplHeight := cpl morphExtent y.
	cpl morphPosition: 0 @ (worldHeight - cplHeight - taskbarHeight).
	
	browser1 activateWindow.! !
RMVSetup initialize!
