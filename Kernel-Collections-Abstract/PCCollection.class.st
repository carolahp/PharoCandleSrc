Class {
	#name : #PCCollection,
	#superclass : #PCObject,
	#category : #'Kernel-Collections-Abstract'
}

{ #category : #'as yet unclassified' }
PCCollection class >> with: anObject [
	"Answer an instance of me containing anObject."

	| newCollection |
	newCollection := self new.
	newCollection add: anObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
PCCollection class >> with: firstObject with: secondObject [
	"Answer an instance of me containing the two arguments as elements."

	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
PCCollection class >> with: firstObject with: secondObject with: thirdObject [
	"Answer an instance of me containing the three arguments as elements."

	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	newCollection add: thirdObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
PCCollection >> asByteArray [
	"Answer a ByteArray containing my elements."

	| result i |
	result := PCByteArray new: self size.
	i := 0.
	self do: [ :each | result at: (i := i + 1) put: each ].
	^ result
]

{ #category : #'as yet unclassified' }
PCCollection >> includes: anObject [
	"Answer whether anObject is one of the receiver's elements."

	self
		do: [ :each | 
			anObject = each
				ifTrue: [ ^ true ] ].
	^ false
]
