'From Cuis7.3 [latest update: #7044] on 4 February 2025 at 3:10:42 pm'!
'Description '!
!provides: 'RMVSetup' 1 12!
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

!SystemWindow methodsFor: '*RMVSetup' stamp: 'RMV 2/4/2025 15:10:19'!
openInWorld: aWorld
	"This msg and its callees result in the window being activeOnlyOnTop."
	| fromMenu sender |
	
	"Determine whether this method was invoked from a menu selection
	and capture the HandMorph if it is in the sender stack."
	fromMenu := false.
	sender := thisContext sender.
	[ sender notNil and: [ fromMenu not ] ] whileTrue: [
		fromMenu := sender receiver class = MenuMorph.
		sender := sender sender.
	].
	
	fromMenu
		ifTrue: [	
			| position windowExtent windowHeight windowRect windowWidth worldExtent worldHeight worldWidth |
			
			windowExtent := self morphExtent.
			"300@200 is the default assigned in the SystemWindow instance method initialize."
			windowExtent = `300 @ 200` ifTrue: [
				windowRect := self initialFrameIn: aWorld.
				windowExtent := windowRect extent.
			].
			self morphExtent: windowExtent.
			windowWidth := windowExtent x.
			windowHeight := windowExtent y.
				
			worldExtent := aWorld morphExtent.
			worldWidth := worldExtent x.
			worldHeight := worldExtent y.
			
			position := Smalltalk at: #worldClickPosition.
			
			"Handle case where window is wider than World."
			windowWidth > worldWidth ifTrue: [
				self morphExtent: (Point x: worldWidth y: windowHeight).
				position := Point x: 0 y: position y.
			].
			
			"Handle case where window is taller than World."
			windowHeight > worldHeight ifTrue: [
				self morphExtent: (Point x: windowWidth y: worldHeight).
				position := Point x: position x y: 0.
			].

			"If window extends past right side of world, move it left."
			position x + windowWidth > worldWidth ifTrue: [
				position := Point x: (worldWidth - windowWidth) y: position y
			].

			"If window extends past bottom side of world, move it up."
			position y + windowHeight > worldHeight ifTrue: [
				position := Point x: position x y: (worldHeight - windowHeight)
			].
		
			aWorld addMorph: self position: position.
		]
		ifFalse: [
			| frameRect hand position |
			
			frameRect := self initialFrameIn: aWorld.
			self morphExtent: frameRect extent.
			hand := self runningWorld activeHand.
			position := hand
				ifNil: [ frameRect topLeft ]
				ifNotNil: [ hand location translation ].
			aWorld addMorph: self position: position.
		].! !

!WorldMorph methodsFor: '*RMVSetup' stamp: 'RMV 2/2/2025 16:51:07'!
click: aMouseButtonEvent localPosition: localEventPosition

	Smalltalk at: #worldClickPosition put: localEventPosition.
	^self mouseButton2Activity.! !
RMVSetup initialize!
