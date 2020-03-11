Class {
	#name : #PCAssociation,
	#superclass : #PCMagnitude,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Kernel-Collections-Unordered'
}

{ #category : #'as yet unclassified' }
PCAssociation class >> key: newKey value: newValue [
	"Answer a new Association with the given key and value."

	^ self new key: newKey value: newValue
]

{ #category : #'as yet unclassified' }
PCAssociation >> key [
	^ key
]

{ #category : #'as yet unclassified' }
PCAssociation >> key: aKey value: anObject [
	key := aKey.
	value := anObject
]

{ #category : #'as yet unclassified' }
PCAssociation >> value: anObject [
	value := anObject
]
