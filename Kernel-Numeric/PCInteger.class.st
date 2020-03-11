Class {
	#name : #PCInteger,
	#superclass : #PCNumber,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
PCInteger class >> new: length neg: neg [
	"Answer an instance of a large integer with the given size and sign."

	neg
		ifTrue: [ ^ PCLargeNegativeInteger new: length ]
		ifFalse: [ ^ PCLargePositiveInteger new: length ]
]

{ #category : #'as yet unclassified' }
PCInteger class >> readFrom: aStream [
	"Answer a new Integer as described on the stream, aStream.
	Embedded radix specifiers not allowed - use Number readFrom: for that."

	^ self readFrom: aStream base: 10
]

{ #category : #'as yet unclassified' }
PCInteger class >> readFrom: aStream base: base [
	"Answer an instance of one of my concrete subclasses. Initial minus sign 
	accepted, and bases > 10 use letters A-Z. Embedded radix specifiers not 
	allowed--use Number readFrom: for that. Answer zero (not an error) if 
	there are no digits."

	| digit value neg |
	neg := aStream peekFor: $-.
	value := 0.
	[ aStream atEnd ]
		whileFalse: [ digit := aStream next digitValue.
			(digit < 0 or: [ digit >= base ])
				ifTrue: [ aStream skip: -1.
					neg
						ifTrue: [ ^ value negated ].
					^ value ]
				ifFalse: [ value := value * base + digit ] ].
	neg
		ifTrue: [ ^ value negated ].
	^ value
]

{ #category : #'as yet unclassified' }
PCInteger >> asCharacter [
	"Answer the Character whose value is the receiver."

	^ PCCharacter value: self
]

{ #category : #'as yet unclassified' }
PCInteger >> bitShift: shiftCount [
	"Answer an Integer whose value (in twos-complement representation) is 
	the receiver's value (in twos-complement representation) shifted left by 
	the number of bits indicated by the argument. Negative arguments shift 
	right. Zeros are shifted in from the right in left shifts."

	| rShift |
	shiftCount >= 0
		ifTrue: [ ^ self digitLshift: shiftCount ].
	rShift := 0 - shiftCount.
	^ (self
		digitRshift: (rShift bitAnd: 7)
		bytes: (rShift bitShift: -3)
		lookfirst: self digitLength) normalize
]

{ #category : #'as yet unclassified' }
PCInteger >> digitLshift: shiftCount [
	| carry rShift mask len result digit byteShift bitShift highBit |
	(highBit := self highBit) = 0
		ifTrue: [ ^ 0 ].
	len := (highBit + shiftCount + 7) // 8.
	result := PCInteger new: len neg: self negative.
	byteShift := shiftCount // 8.
	bitShift := shiftCount \\ 8.
	bitShift = 0
		ifTrue: [ ^ result
				replaceFrom: byteShift + 1
				to: len
				with: self
				startingAt: 1 ].
	"Fast version for byte-aligned shifts"
	carry := 0.
	rShift := bitShift - 8.
	mask := 255 bitShift: 0 - bitShift.
	1 to: byteShift do: [ :i | result digitAt: i put: 0 ].
	1 to: len - byteShift do: [ :i | 
		digit := self digitAt: i.
		result
			digitAt: i + byteShift
			put: (((digit bitAnd: mask) bitShift: bitShift) bitOr: carry).
		carry := digit bitShift: rShift ].
	^ result
]
