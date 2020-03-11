Class {
	#name : #PCSet,
	#superclass : #PCCollection,
	#instVars : [
		'tally',
		'array'
	],
	#category : #'Kernel-Collections-Unordered'
}

{ #category : #'as yet unclassified' }
PCSet class >> new [
	^ self new: 4
]

{ #category : #'as yet unclassified' }
PCSet class >> new: nElements [
	"Create a Set large enough to hold nElements without growing."

	| initialSize |
	"make large enough size to hold nElements with some slop (see fullCheck)"
	nElements <= 0
		ifTrue: [ initialSize := 1 ]
		ifFalse: [ initialSize := (nElements + 1) * 4 // 3 ].
	^ self basicNew init: initialSize
]

{ #category : #'as yet unclassified' }
PCSet >> atNewIndex: index put: anObject [
	array at: index put: anObject.
	tally := tally + 1.
	self fullCheck
]

{ #category : #'as yet unclassified' }
PCSet >> findElementOrNil: anObject [
	"Answer the index of a first slot containing either a nil (indicating an empty slot) or an element that matches the given object. Answer the index of that slot or zero. Fail if neither a match nor an empty slot is found."

	| index |
	index := self scanFor: anObject.
	index > 0
		ifTrue: [ ^ index ].	"Bad scene.  Neither have we found a matching element
	nor even an empty slot.  No hashed set is ever supposed to get
	completely full."
	self error: 'There is no free space in this set!'
]

{ #category : #'as yet unclassified' }
PCSet >> fullCheck [
	"Keep array at least 1/4 free for decent hash behavior"

	array size - tally < (array size // 4 max: 1)
		ifTrue: [ self grow ]
]

{ #category : #'as yet unclassified' }
PCSet >> grow [
	"Grow the elements array and reinsert the old elements."

	| oldElements |
	oldElements := array.
	array := PCArray new: array size + (array size max: 2).
	tally := 0.
	oldElements
		do: [ :each | 
			each == nil
				ifFalse: [ self noCheckAdd: each ] ]
]

{ #category : #'as yet unclassified' }
PCSet >> init: n [
	"Initialize array to an array size of n."

	array := PCArray new: n.
	tally := 0
]
