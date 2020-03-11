Class {
	#name : #PCInterval,
	#superclass : #PCSequenceableCollection,
	#instVars : [
		'start',
		'stop',
		'step'
	],
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
PCInterval class >> from: startInteger to: stopInteger [
	"Answer an instance of me, starting at startNumber, ending at stopNumber, and with an interval increment of 1."

	^ self basicNew setFrom: startInteger to: stopInteger by: 1
]

{ #category : #'as yet unclassified' }
PCInterval class >> from: startInteger to: stopInteger by: stepInteger [
	"Answer an instance of me, starting at startNumber, ending at stopNumber, and with an interval increment of stepNumber."

	^ self basicNew setFrom: startInteger to: stopInteger by: stepInteger
]

{ #category : #'as yet unclassified' }
PCInterval >> collect: aBlock [
	| nextValue result |
	result := self species new: self size.
	nextValue := start.
	1 to: result size do: [ :i | 
		result at: i put: (aBlock value: nextValue).
		nextValue := nextValue + step ].
	^ result
]

{ #category : #'as yet unclassified' }
PCInterval >> do: aBlock [
	| aValue |
	aValue := start.
	step < 0
		ifTrue: [ [ stop <= aValue ]
				whileTrue: [ aBlock value: aValue.
					aValue := aValue + step ] ]
		ifFalse: [ [ stop >= aValue ]
				whileTrue: [ aBlock value: aValue.
					aValue := aValue + step ] ]
]

{ #category : #'as yet unclassified' }
PCInterval >> setFrom: startInteger to: stopInteger by: stepInteger [
	start := startInteger.
	stop := stopInteger.
	step := stepInteger
]

{ #category : #'as yet unclassified' }
PCInterval >> size [
	step < 0
		ifTrue: [ start < stop
				ifTrue: [ ^ 0 ]
				ifFalse: [ ^ (stop - start) // step + 1 ] ]
		ifFalse: [ stop < start
				ifTrue: [ ^ 0 ]
				ifFalse: [ ^ (stop - start) // step + 1 ] ]
]

{ #category : #'as yet unclassified' }
PCInterval >> species [
	^ PCArray
]
