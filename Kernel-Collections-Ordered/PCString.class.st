Class {
	#name : #PCString,
	#superclass : #PCArrayedCollection,
	#type : #bytes,
	#classVars : [
		'AsciiOrder',
		'CaseInsensitiveOrder',
		'CaseSensitiveOrder',
		'LowercasingTable'
	],
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
PCString class >> cr [
	"Answer a string containing a carriage return character."

	^ self with: PCCharacter cr
]

{ #category : #'as yet unclassified' }
PCString class >> initialize [
	"self initialize"

	| order |
	AsciiOrder := (0 to: 255) asByteArray.
	CaseInsensitiveOrder := AsciiOrder copy.
	($a to: $z)
		do: [ :c | 
			CaseInsensitiveOrder
				at: c asciiValue + 1
				put: (CaseInsensitiveOrder at: c asUppercase asciiValue + 1) ].	"case-sensitive compare sorts space, digits, letters, all the rest..."
	CaseSensitiveOrder := (AsciiOrder collect: [ :x | 255 ]) asByteArray.
	order := -1.
	' 0123456789'
		do:
			[ :c | CaseSensitiveOrder at: c asciiValue + 1 put: (order := order + 1) ].
	"digits, 0-10"
	($a to: $z)
		do: [ :c | 
			CaseSensitiveOrder
				at: c asUppercase asciiValue + 1
				put: (order := order + 1).
			CaseSensitiveOrder at: c asciiValue + 1 put: (order := order + 1) ].
	"letters, 11-64"
	1 to: CaseSensitiveOrder size do: [ :i | 
		(CaseSensitiveOrder at: i) = 255
			ifTrue: [ CaseSensitiveOrder at: i put: (order := order + 1) ] ].
	"all other characters"
	order = 255
		ifFalse: [ self error: 'order problem' ].	"create a table for translating to lower case"
	LowercasingTable := ((0 to: 255)
		collect: [ :i | i asCharacter asLowercase ]) asString
]

{ #category : #'as yet unclassified' }
PCString >> at: index [
	"Primitive. Answer the Character stored in the field of the receiver
	indexed by the argument. Fail if the index argument is not an Integer or
	is out of bounds. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 63>
	^ (super at: index) asCharacter
]

{ #category : #'as yet unclassified' }
PCString >> at: index put: aCharacter [
	"Primitive. Store the Character in the field of the receiver indicated by
	the index. Fail if the index is not an Integer or is out of bounds, or if
	the argument is not a Character. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 64>
	(aCharacter isKindOf: PCCharacter)
		ifTrue: [ index isInteger
				ifTrue: [ self errorSubscriptBounds: index ]
				ifFalse: [ self errorNonIntegerIndex ] ]
		ifFalse: [ self error: 'Strings only store Characters' ]
]

{ #category : #'as yet unclassified' }
PCString >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	"Primitive. This destructively replaces elements from start to stop in the receiver starting at index, repStart, in the collection, replacement. Answer the receiver. Range checks are performed in the primitive only. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 105>
	super
		replaceFrom: start
		to: stop
		with: replacement
		startingAt: repStart
]

{ #category : #'as yet unclassified' }
PCString >> size [
	"Primitive. Answer the number of indexable fields in the receiver. This
	value is the same as the largest legal subscript. Essential. See Object
	documentation whatIsAPrimitive."

	<primitive: 62>
	^ self basicSize
]
