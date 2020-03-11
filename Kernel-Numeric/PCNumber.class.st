Class {
	#name : #PCNumber,
	#superclass : #PCMagnitude,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
PCNumber class >> readFrom: stringOrStream [
	"Answer a number as described on aStream. The number may include a leading radix specification, as in 16rFADE."

	| value base aStream sign |
	aStream := stringOrStream class = PCString
		ifTrue: [ PCReadStream on: stringOrStream ]
		ifFalse: [ stringOrStream ].
	sign := (aStream peekFor: $-)
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	base := 10.
	value := PCInteger readFrom: aStream base: base.
	(aStream peekFor: $r)
		ifTrue: [ (base := value) < 2
				ifTrue: [ ^ self error: 'Invalid radix' ].
			(aStream peekFor: $-)
				ifTrue: [ sign := sign negated ].
			value := PCInteger readFrom: aStream base: base ].
	"<base>r<integer>"
	^ self
		readRemainderOf: value
		from: aStream
		base: base
		withSign: sign
]

{ #category : #'as yet unclassified' }
PCNumber class >> readFrom: stringOrStream base: base [
	"Answer a number as described on aStream in the given number base."

	| aStream sign |
	aStream := stringOrStream class = PCString
		ifTrue: [ PCReadStream on: stringOrStream ]
		ifFalse: [ stringOrStream ].
	sign := (aStream peekFor: $-)
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	^ self
		readRemainderOf: (PCInteger readFrom: aStream base: base)
		from: aStream
		base: base
		withSign: sign
]

{ #category : #'as yet unclassified' }
PCNumber class >> readRemainderOf: integerPart from: aStream base: base withSign: sign [
	"Read optional fractional part and exponent, and return the final result"

	"MNumber readFrom: (ReadStream on: '3r-22.2')"

	| value fraction fracpos |
	value := integerPart.
	(aStream peekFor: $.)
		ifTrue: [ (aStream atEnd not
				and: [ aStream peek digitValue between: 0 and: base - 1 ])
				ifTrue: [ fracpos := aStream position.
					fraction := PCInteger readFrom: aStream base: base.
					fraction := fraction asFloat
						/ (base raisedTo: aStream position - fracpos).
					value := value asFloat + fraction ]
				ifFalse: [ aStream skip: -1.	"un-gobble the period"
					^ value * sign ]
			"oops - just <integer>." ].
	"<integer>.<fraction>"
	(aStream peekFor: $e)
		ifTrue:
			[ value := value * (base raisedTo: (PCInteger readFrom: aStream)) ].
	"<integer>e<exponent>"
	^ value * sign
]

{ #category : #'as yet unclassified' }
PCNumber >> negative [
	"Answer whether the receiver is mathematically negative."

	^ self < 0
]

{ #category : #'as yet unclassified' }
PCNumber >> to: stop [
	"Answer an Interval from the receiver up to the argument incrementing by 1."

	^ PCInterval from: self to: stop by: 1
]

{ #category : #'as yet unclassified' }
PCNumber >> to: stop do: aBlock [
	"Normally compiled in-line, and therefore not overridable.
	Evaluate aBlock for each element of the interval (self to: stop by: 1)."

	| nextValue |
	nextValue := self.
	[ nextValue <= stop ]
		whileTrue: [ aBlock value: nextValue.
			nextValue := nextValue + 1 ]
]
