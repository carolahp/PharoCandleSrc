Class {
	#name : #PCArrayedCollection,
	#superclass : #PCSequenceableCollection,
	#category : #'Kernel-Collections-Abstract'
}

{ #category : #'as yet unclassified' }
PCArrayedCollection class >> new [
	"Answer a new instance of me, with size = 0."

	^ self new: 0
]

{ #category : #'as yet unclassified' }
PCArrayedCollection class >> with: anObject [
	"Answer a new instance of me, containing only anObject."

	| newCollection |
	newCollection := self new: 1.
	newCollection at: 1 put: anObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
PCArrayedCollection class >> with: firstObject with: secondObject [
	"Answer a new instance of me containing the two arguments as elements."

	| newCollection |
	newCollection := self new: 2.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
PCArrayedCollection class >> with: firstObject with: secondObject with: thirdObject [
	"Answer a new instance of me, containing the three arguments as elements."

	| newCollection |
	newCollection := self new: 3.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
PCArrayedCollection >> size [
	"Primitive. Answer the number of indexable fields in the receiver. This value is the same as the largest legal subscript. Primitive is specified here to override MSequenceableCollection size. Essential. See Object documentation whatIsAPrimitive. "

	<primitive: 62>
	^ self basicSize
]
