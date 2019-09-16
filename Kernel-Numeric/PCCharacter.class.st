Class {
	#name : #PCCharacter,
	#superclass : #PCMagnitude,
	#category : 'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
PCCharacter class >> cr [
	"Answer the Character representing a carriage return."

	^ 13 asCharacter
]

{ #category : #'as yet unclassified' }
PCCharacter class >> digitValue: x [
	"Answer the Character whose digit value is x. For example,
	 answer $9 for x=9, $0 for x=0, $A for x=10, $Z for x=35."

	| n |
	n := x asInteger.
	^self value: (n < 10 ifTrue: [n + 48] ifFalse: [n + 55])
]

{ #category : #'as yet unclassified' }
PCCharacter class >> lf [
	"Answer the Character representing a linefeed."

	^ 10 asCharacter
]

{ #category : #'as yet unclassified' }
PCCharacter class >> new [
	"There are 256 unique Characters; creating new ones is not allowed."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
PCCharacter class >> space [
	"Answer the Character representing a space."

	^ 32 asCharacter
]

{ #category : #'as yet unclassified' }
PCCharacter class >> tab [
	"Answer the Character representing a tab."

	^ 9 asCharacter
]

{ #category : #'as yet unclassified' }
PCCharacter class >> value: anInteger [
	"Answer the Character whose value is anInteger."
	<primitive: 170>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCCharacter >> < aCharacter [
	"Answer true if my value is less than the given character's value."

	^ self asciiValue < aCharacter asciiValue
]

{ #category : #'as yet unclassified' }
PCCharacter >> = aCharacter [
	"Primitive. Answer true if the receiver and the argument are the same object (have the same object pointer) and false otherwise. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 110>
	^ self == aCharacter
]

{ #category : #'as yet unclassified' }
PCCharacter >> > aCharacter [
	"Answer true if my value is greater than the given character's value."

	^ self asciiValue > aCharacter asciiValue
]

{ #category : #'as yet unclassified' }
PCCharacter >> asCharacter [
	"Answer the receiver itself."

	^ self
]

{ #category : #'as yet unclassified' }
PCCharacter >> asInteger [
	"Answer the receiver's character code."
	<primitive: 171>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCCharacter >> asLowercase [
	"If I am uppercase, answer the matching lowercase Character. Otherwise, answer myself."

	(65 <= self asciiValue and: [ self asciiValue <= 90 ])
		ifTrue: [ ^ (self asciiValue + 32) asCharacter ]
		ifFalse: [ ^ self ]	"self isUppercase"
]

{ #category : #'as yet unclassified' }
PCCharacter >> asString [
	^ PCString with: self
]

{ #category : #'as yet unclassified' }
PCCharacter >> asUppercase [
	"If the receiver is lowercase, answer its matching uppercase Character."

	(97 <= self asciiValue and: [ self asciiValue <= 122 ])
		ifTrue: [ ^ (self asciiValue - 32) asCharacter ]
		ifFalse: [ ^ self ]	"self isLowercase"
]

{ #category : #'as yet unclassified' }
PCCharacter >> asciiValue [
	"Answer the receiver's character code.
	 This will be ascii for characters with value <= 127,
	 and Unicode for those with higher values."
	<primitive: 171>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCCharacter >> basicCopy [
	"Answer myself because Characters are unique."

	^ self
]

{ #category : #'as yet unclassified' }
PCCharacter >> digitValue [
	"Answer 0-9 if the receiver is $0-$9, 10-35 if it is $A-$Z, and -1 otherwise. This is used to parse literal numbers of radix 2-36."

	self asciiValue <= $9 asciiValue
		ifTrue: [ ^ self asciiValue - $0 asciiValue ].
	self asciiValue >= $A asciiValue
		ifTrue: [ self asciiValue <= $Z asciiValue
				ifTrue: [ ^ self asciiValue - $A asciiValue + 10 ] ].
	^ -1
]

{ #category : #'as yet unclassified' }
PCCharacter >> hash [
	"Hash is reimplemented because = is implemented.
	 Answer the receiver's character code."
	<primitive: 171>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCCharacter >> isDigit [
	"Answer whether the receiver is a digit."

	^ self asciiValue >= 48 and: [ self asciiValue <= 57 ]
]

{ #category : #'as yet unclassified' }
PCCharacter >> isLetter [
	"Answer whether the receiver is a letter."

	^ (65 <= self asciiValue and: [ self asciiValue <= 90 ])
		or: [ 97 <= self asciiValue and: [ self asciiValue <= 122 ] ]
]

{ #category : #'as yet unclassified' }
PCCharacter >> isSpecial [
	"Answer whether the receiver is one of the special characters"

	^ '+/\*~<>=@%|&?!' includes: self
]

{ #category : #'as yet unclassified' }
PCCharacter >> isUppercase [
	"Answer whether the receiver is an uppercase letter."

	^ 65 <= self asciiValue and: [ self asciiValue <= 90 ]
]

{ #category : #'as yet unclassified' }
PCCharacter >> isVowel [
	"Answer true if the receiver is one of the vowels AEIOU (either upper- or lowercase)."

	^ 'AEIOU' includes: self asUppercase
]

{ #category : #'as yet unclassified' }
PCCharacter >> printOn: aStream [
	aStream nextPut: $$.
	aStream nextPut: self
]

{ #category : #'as yet unclassified' }
PCCharacter >> to: other [
	"Answer with a collection of all characters in the given ASCII range. For example, $a to: $z"

	^ (self asciiValue to: other asciiValue)
		collect: [ :i | i asCharacter ]
]

{ #category : #'as yet unclassified' }
PCCharacter >> tokenish [
	"Answer true if the receiver is a valid token-character--that is, a letter, digit, or colon."

	^ self isLetter or: [ self isDigit or: [ self = $: ] ]
]
