Class {
	#name : #PCCharacter,
	#superclass : #PCMagnitude,
	#category : #'Kernel-Numeric'
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
PCCharacter >> asLowercase [
	"If I am uppercase, answer the matching lowercase Character. Otherwise, answer myself."

	(65 <= self asciiValue and: [ self asciiValue <= 90 ])
		ifTrue: [ ^ (self asciiValue + 32) asCharacter ]
		ifFalse: [ ^ self ]	"self isUppercase"
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
