'From Cuis7.3 [latest update: #7044] on 2 February 2025 at 6:45:50 pm'!
'Description '!
!provides: 'RMVSetup' 1 7!
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


!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 1/19/2025 06:24:56'!
initialize
	| filePath stream |

	Preferences name: #showAssignmentAsLeftArrow category: #programming value: true.
	Preferences saveToDisk: #showAssignmentAsLeftArrow.
	
	PreferenceSet sysPreferences at: #backgroundEffect put: #tile.
	
	filePath := '../Cuis-Smalltalk-RMVSetup/altitude1600.jpg'.
	stream := filePath asFileEntry readStream.
	self runningWorld backgroundImageData: stream binary contentsOfEntireFile.! !

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/2/2025 18:44:35'!
openInWorld: aWorld
	"This msg and its callees result in the window being activeOnlyOnTop"
	| frameRect position windowExtent worldExtent |
	
	windowExtent := self morphExtent.
	"300@200 is the default assigned in the SystemWindow instance method initialize."
	windowExtent = `300 @ 200` ifTrue: [
		frameRect := self initialFrameIn: aWorld.
		windowExtent := frameRect extent.
	].
	self morphExtent: windowExtent.
		
	position := Smalltalk at: #worldClickPosition.
	worldExtent := aWorld morphExtent.
	
	"Move left if hanging off right side of world"
	position x + windowExtent x > worldExtent x ifTrue: [
		position := Point x: (worldExtent  x - windowExtent x) y: position y
	].

	"Move up if hanging off bottom of world."
	position y + windowExtent y > worldExtent y ifTrue: [
		position := Point x: position x y: (worldExtent y - windowExtent y)
	].

	aWorld addMorph: self position: position.! !

!WorldMorph methodsFor: '*RMVSetup' stamp: 'RMV 2/2/2025 16:51:07'!
click: aMouseButtonEvent localPosition: localEventPosition

	Smalltalk at: #worldClickPosition put: localEventPosition.
	^self mouseButton2Activity.! !
RMVSetup initialize!
