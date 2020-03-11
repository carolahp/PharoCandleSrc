Class {
	#name : #PCOrderedCollection,
	#superclass : #PCSequenceableCollection,
	#instVars : [
		'array',
		'firstIndex',
		'lastIndex'
	],
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
PCOrderedCollection class >> new [
	^ self new: 8
]

{ #category : #'as yet unclassified' }
PCOrderedCollection class >> new: anInteger [
	"If a subclass adds fields, then that subclass must reimplement new:."

	^ self basicNew setCollection: (PCArray new: anInteger)
]
