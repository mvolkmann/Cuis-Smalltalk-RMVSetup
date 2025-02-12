'From Cuis7.3 [latest update: #7044] on 12 February 2025 at 10:46:04 am'!
'Description '!
!provides: 'RMVSetup' 1 20!
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


!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 2/12/2025 10:44:31'!
initialize
	| filePath stream |

	Preferences name: #showAssignmentAsLeftArrow category: #programming value: true.
	Preferences saveToDisk: #showAssignmentAsLeftArrow.
	
	WindowManager openAtCursor.
	
	"Add World background image."
	Preferences at: #backgroundEffect put: #tile.
	filePath := '../Cuis-Smalltalk-RMVSetup/altitude1600.jpg'.
	stream := filePath asFileEntry readStream.
	self runningWorld backgroundImageData: stream binary contentsOfEntireFile.
	
	self openWindows.! !

!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 2/12/2025 10:45:44'!
openWindows
	| browser browserWidth browserX cpl cplHeight taskbarHeight transcript transcriptHeight workspace world worldHeight worldWidth |
	
	world := UISupervisor ui.
	worldWidth := world morphExtent x.
	worldHeight := world morphExtent y.
	taskbarHeight := world taskbar morphExtent y.

	"Open, position, and size a System Browser."
	browser := Smalltalk browse.
	browserWidth := browser morphExtent x.
	browserX := (worldWidth / 2) - (browserWidth / 2).
	browser morphPosition: browserX @ 0.
	browser morphExtent: browserWidth @ worldHeight.

	"Open, position, and size another System Browser."
	browser := Smalltalk browse.
	browser morphPosition: (browserX - browserWidth) @ 0.
	browser morphExtent: browserWidth @ worldHeight.
	
	"Open, position, and size a Workspace."
	workspace := Workspace open.
	workspace morphExtent: browserWidth @ (worldHeight * 0.7).
	workspace morphPosition: (browserX + browserWidth) @ 0.

	"Open, position, and size a Transcript."
	transcript := Transcript open.
	transcriptHeight := worldHeight * 0.3.
	transcript morphExtent: browserWidth @ transcriptHeight.
	transcript morphPosition: (browserX + browserWidth) @ (worldHeight - transcriptHeight).
	Transcript clearAll.

	"Open, position, and size an Installed Packages window."
	cpl := CodePackageList open.
	cplHeight := cpl morphExtent y.
	cpl morphPosition: 0 @ (worldHeight - cplHeight - taskbarHeight).! !
RMVSetup initialize!
