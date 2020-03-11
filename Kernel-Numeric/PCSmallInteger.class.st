Class {
	#name : #PCSmallInteger,
	#superclass : #PCInteger,
	#type : #immediate,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
PCSmallInteger class >> maxVal [
	"Answer the maximum value for a SmallInteger."

	^ 16r3FFFFFFF
]

{ #category : #'as yet unclassified' }
PCSmallInteger class >> minVal [
	"Answer the minimum value for a SmallInteger."

	^ -16r40000000
]

{ #category : #'as yet unclassified' }
PCSmallInteger class >> new [
	"SmallIntegers are created as constants or by performing arithmetic."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> * aNumber [
	"Primitive. Multiply the receiver by the argument and answer with the
	result if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger. Essential. No Lookup. See Object documentation
	whatIsAPrimitive."

	<primitive: 9>
	self = 0
		ifTrue: [ ^ 0 ].	"This eliminates the need for a self=0 check in LargeInteger *"
	^ super * aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> + aNumber [
	"Primitive. Add the receiver to the argument and answer with the result
	if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger  Essential  No Lookup. See Object documentation
	whatIsAPrimitive."

	<primitive: 1>
	aNumber isInteger
		ifTrue: [ ^ super + aNumber ].
	^ aNumber adaptToInteger: self andSend: #+
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> - aNumber [
	"Primitive. Subtract the argument from the receiver and answer with the
	result if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger. Essential. No Lookup. See Object documentation
	whatIsAPrimitive."

	<primitive: 2>
	^ super - aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> // aNumber [
	"Primitive. Divide the receiver by the argument and answer with the
	result. Round the result down towards negative infinity to make it a
	whole integer. Fail if the argument is 0 or is not a SmallInteger.
	Essential. No Lookup. See Object documentation whatIsAPrimitive. "

	<primitive: 12>
	^ super // aNumber	"Do with quo: if primitive fails"
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> < aNumber [
	"Primitive. Compare the receiver with the argument and answer with
	true if the receiver is less than the argument. Otherwise answer false.
	Fail if the argument is not a SmallInteger. Essential. No Lookup. See
	Object documentation whatIsAPrimitive."

	<primitive: 3>
	^ super < aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> <= aNumber [
	"Primitive. Compare the receiver with the argument and answer true if
	the receiver is less than or equal to the argument. Otherwise answer
	false. Fail if the argument is not a SmallInteger. Optional. No Lookup.
	See Object documentation whatIsAPrimitive. "

	<primitive: 5>
	^ super <= aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> = aNumber [
	"Primitive. Compare the receiver with the argument and answer true if
	the receiver is equal to the argument. Otherwise answer false. Fail if the
	argument is not a SmallInteger. Essential. No Lookup. See Object
	documentation whatIsAPrimitive. "

	<primitive: 7>
	^ super = aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> > aNumber [
	"Primitive. Compare the receiver with the argument and answer true if
	the receiver is greater than the argument. Otherwise answer false. Fail if
	the argument is not a SmallInteger. Essential. No Lookup. See Object
	documentation whatIsAPrimitive."

	<primitive: 4>
	^ super > aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> >= aNumber [
	"Primitive. Compare the receiver with the argument and answer true if
	the receiver is greater than or equal to the argument. Otherwise answer
	false. Fail if the argument is not a SmallInteger. Optional. No Lookup.
	See Object documentation whatIsAPrimitive."

	<primitive: 6>
	^ super >= aNumber
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> \\ aNumber [
	"Primitive. Take the receiver modulo the argument. The result is the
	remainder rounded towards negative infinity, of the receiver divided by
	the argument Fail if the argument is 0 or is not a SmallInteger. Optional.
	No Lookup. See Object documentation whatIsAPrimitive."

	<primitive: 11>
	^ super \\ aNumber	"Do with // if primitive fails"
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> bitAnd: arg [
	"Primitive. Answer an Integer whose bits are the logical OR of the
	receiver's bits and those of the argument, arg.
	Numbers are interpreted as having 2's-complement representation.
	Essential.  See Object documentation whatIsAPrimitive."

	<primitive: 14>
	self >= 0
		ifTrue: [ ^ arg bitAnd: self ].
	^ (self bitInvert bitOr: arg bitInvert) bitInvert
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> bitOr: arg [
	"Primitive. Answer an Integer whose bits are the logical OR of the
	receiver's bits and those of the argument, arg.
	Numbers are interpreted as having 2's-complement representation.
	Essential.  See Object documentation whatIsAPrimitive."

	<primitive: 15>
	self >= 0
		ifTrue: [ ^ arg bitOr: self ].
	^ arg < 0
		ifTrue: [ (self bitInvert bitAnd: arg bitInvert) bitInvert ]
		ifFalse: [ (self bitInvert bitClear: arg) bitInvert ]
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> bitShift: arg [
	"Primitive. Answer an Integer whose value is the receiver's value shifted
	left by the number of bits indicated by the argument. Negative arguments
	shift right. The receiver is interpreted as having 2's-complement representation.
	Essential.  See Object documentation whatIsAPrimitive."

	<primitive: 17>
	self >= 0
		ifTrue: [ ^ super bitShift: arg ].
	^ arg >= 0
		ifTrue: [ (self negated bitShift: arg) negated ]
		ifFalse: [ (self bitInvert bitShift: arg) bitInvert ]
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> digitAt: n [
	"Answer the value of an indexable field in the receiver. Fail if the 
	argument (the index) is not an Integer or is out of bounds."

	n > 4
		ifTrue: [ ^ 0 ].
	self < 0
		ifTrue: [ self = PCSmallInteger minVal
				ifTrue:
					[ ^ #(0 0 0 64) at: n ].
			"Can't negate minVal -- treat specially"
			^ (0 - self bitShift: (1 - n) * 8) bitAnd: 16rFF ]
		ifFalse: [ ^ (self bitShift: (1 - n) * 8) bitAnd: 16rFF ]
]

{ #category : #'as yet unclassified' }
PCSmallInteger >> highBit [
	"Answer the index of the high order bit of the receiver, or zero if the receiver is zero. Raise an error if the receiver is negative, since negative integers are defined to have an infinite number of leading 1's in 2's-complement arithmetic."

	| shifted bitNo |
	self < 0
		ifTrue: [ self error: 'highBit is not defined for negative integers' ].
	shifted := self.
	bitNo := 0.
	[ shifted < 16 ]
		whileFalse: [ shifted := shifted bitShift: -4.
			bitNo := bitNo + 4 ].
	[ shifted = 0 ]
		whileFalse: [ shifted := shifted bitShift: -1.
			bitNo := bitNo + 1 ].
	^ bitNo
]
