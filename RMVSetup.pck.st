'From Cuis7.3 [latest update: #6991] on 18 January 2025 at 10:54:23 am'!
'Description '!
!provides: 'RMVSetup' 1 3!
!requires: 'LogAs' 1 1 nil!
!requires: 'WindowManager' 1 11 nil!
!requires: 'FindByExample' 1 121 nil!
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


!RMVSetup class methodsFor: 'class initialization' stamp: 'RMV 1/18/2025 10:54:14'!
initialize
	| filePath stream |

	Preferences name: #showAssignmentAsLeftArrow category: #programming value: true.
	Preferences saveToDisk: #showAssignmentAsLeftArrow.
	
	PreferenceSet sysPreferences at: #backgroundEffect put: #tile.
	
	filePath := '/Users/volkmannm/Pictures/images/altitude1600.jpg'.
	stream := filePath asFileEntry readStream.
	self runningWorld backgroundImageData: stream binary contentsOfEntireFile.! !
RMVSetup initialize!
