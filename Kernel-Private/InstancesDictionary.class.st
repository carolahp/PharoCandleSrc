Class {
	#name : #InstancesDictionary,
	#superclass : #PCDictionary,
	#classVars : [ ],
	#category : #'Kernel-Private'
}

InstancesDictionary >> at: key put: anObject [
	"Set the value at key to be anObject.  If key is not found, create a new
	entry for key and set is value to anObject. Answer anObject."

	| index element |
	index := self findElementOrNil: key.
	element := array at: index.
	element == nil
		ifTrue:
			[ self atNewIndex: index put: (PCAssociation privateNew key: key value: anObject) ]
		ifFalse: [ element value: anObject ].
	^ anObject
]

InstancesDictionary >> grow [
	"Grow the elements array and reinsert the old elements."

	| oldElements |
	oldElements := array.
	array := PCArray privateNew: array size + (array size max: 2).
	tally := 0.
	oldElements
		do: [ :each | 
			each == nil
				ifFalse: [ self noCheckAdd: each ] ]
]

InstancesDictionary >> init: n [
	"Initialize array to an array size of n."

	array := PCArray privateNew: n.
	tally := 0
]

InstancesDictionary class >> new: nElements [
	"Create a Set large enough to hold nElements without growing."

	| initialSize |
	"make large enough size to hold nElements with some slop (see fullCheck)"
	nElements <= 0
		ifTrue: [ initialSize := 1 ]
		ifFalse: [ initialSize := (nElements + 1) * 4 // 3 ].
	^ self privateNew init: initialSize
]