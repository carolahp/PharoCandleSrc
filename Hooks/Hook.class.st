Class {
	#name : #Hook,
	#superclass : #PCObject,
	#category : #Hooks
}

{ #category : #'as yet unclassified' }
Hook class >> initializeSystemDictionary: aSystemDictionary [
	"aSystemDictionary is an instance of the class with role SystemDictionary and it already contains the globals defined in the language definition, with value nil. 
	In here you can add elements to aSystemDictionary or assign it (for example to Smalltalk globals)"
	| smalltalk |
	smalltalk := PCSmalltalk new.
	"assign the system dictionary to the inst var 'globals' of the smalltalk object"
	smalltalk instVarAt: 1 put: aSystemDictionary.
	smalltalk globals at: #Smalltalk put: smalltalk
]
