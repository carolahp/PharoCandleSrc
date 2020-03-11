Class {
	#name : #PCBehavior,
	#superclass : #PCObject,
	#instVars : [
		'superclass',
		'methodDict',
		'format'
	],
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
PCBehavior >> basicNew [
	"Primitive. Answer an instance of the receiver (which is a class) with no indexable fields. Fail if the class is variable-sized. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 70>
	self isVariable
		ifTrue: [ ^ self basicNew: 0 ].	"space must be low"
	self error: 'low space'
]

{ #category : #'as yet unclassified' }
PCBehavior >> basicNew: desiredSize [
	"Primitive. Answer an instance of this class with the given number of indexable variables. Fail if this class is not indexable, if the argument is not a positive Integer, or if there is not enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 71>
	self isVariable
		ifFalse: [ self error: self name , ' is not variable-sized' ].
	(desiredSize isInteger not or: [ desiredSize < 0 ])
		ifTrue: [ self error: 'bad size' ].
	self error: 'low space'
]

{ #category : #'as yet unclassified' }
PCBehavior >> format [
	"Answer a integer that encodes the format of instances of this class receiver."

	^ format
]

{ #category : #'as yet unclassified' }
PCBehavior >> initialize [
	"Default initialization."

	superclass := PCObject.
	format := 2.
	methodDict := PCMethodDictionary new
]

{ #category : #'as yet unclassified' }
PCBehavior >> instSize [
	"Answer the number of named instance variables
	(as opposed to indexed variables) of the receiver.
	 Above Cog Spur the class format is
		<5 bits inst spec><16 bits inst size>"
	^format bitAnd: 16rFFFF
]

{ #category : #'as yet unclassified' }
PCBehavior >> methodDict [
	"Answer my method dictionary."

	^ methodDict
]

{ #category : #'as yet unclassified' }
PCBehavior >> methodDictionary: aMethodDictionary [
	"Set my method dictionary."

	methodDict := aMethodDictionary
]

{ #category : #'as yet unclassified' }
PCBehavior >> new: desiredSize [
	^ self basicNew: desiredSize
]

{ #category : #'as yet unclassified' }
PCBehavior >> setFormat: anInteger [
	"Warning! Risky operation. Should only be done when there are not instances of this class."

	format := anInteger
]

{ #category : #'as yet unclassified' }
PCBehavior >> superclass: aBehaviorOrNil [
	"Set my superclass."

	superclass := aBehaviorOrNil
]
