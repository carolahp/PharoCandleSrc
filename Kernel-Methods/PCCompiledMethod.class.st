Class {
	#name : #PCCompiledMethod,
	#superclass : #PCByteArray,
	#type : #compiledMethod,
	#category : #'Kernel-Methods'
}

{ #category : #'as yet unclassified' }
PCCompiledMethod >> asString [ 
	| literalsString |

	literalsString := (self literals inject: '' into: [ :a :b | a asString , ', ', b asString ]).
	literalsString := 
		(literalsString size > 2) 
			ifTrue: [literalsString copyFrom: 3 to: literalsString size]
			ifFalse: [''].

	^ 'a CompiledMethod', 
			' header : ', self header asString, 
			', numArgs: ', self numArgs asString,
			', numLiterals: ', self numLiterals asString,
			', literals: (', literalsString ,
			'), numArgs: ', self numArgs asString,
			', numTemps: ', self numTemps asString
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> frameSize [
	"Answer the size of temporary frame needed to run the receiver."

	"NOTE:  Versions 2.7 and later use two sizes of contexts."

	^ 0 = (self header bitAnd: 16r20000) 
		ifTrue: [ ^ 16 ]
		ifFalse: [ ^ 56 ]
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> header [
	"Answer the method header word containing information about the form of this method (e.g., number of literals) and the context needed to run it."

	^ self objectAt: 1
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> initialPC [
	"Answer the program counter for my first bytecode."

	^ 4 * (self numLiterals + 1) + 1
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> isCompiledMethod [
	^ true
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> literalAt: index [ 
	"Answer the literal indexed by the argument."

	^self objectAt: index + 1
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> literals [
	"Answer an Array of the literals referenced by the receiver.	
	 Exclude superclass + selector/properties"
	| literals numberLiterals |
	literals := PCArray new: (numberLiterals := self numLiterals - self numberOfReservedLiterals).
	1 to: numberLiterals do: [:index |
		literals at: index put: (self objectAt: index + 1)].
	^literals
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> numArgs [
	"Answer the number of arguments the receiver takes."

	^ (self header bitShift: -24) bitAnd: 16r0F
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> numLiterals [
	"Answer the number of literals used by the receiver."

	"^ (self header bitShift: -9) bitAnd: 16rFF"
	^ self header bitAnd: 16r7FFF
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> numTemps [
	"Answer the number of temporary variables used by this method."

	^ (self header bitShift: -18) bitAnd: 16r3F
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> numberOfReservedLiterals [

	^ 2
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> objectAt: index [
	"Primitive. Answer the method header (if index = 1) or a literal (if index > 1) from the receiver. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 68>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> objectAt: index put: value [
	"Primitive. Store the value argument into a literal in the receiver. An index of 2 corresponds to the first literal. Fails if the index is less than 2 or greater than the number of literals. Answer the value as the result. Normally only the compiler sends this message because only the compiler stores values in CompiledMethods. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 69>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> penultimateLiteral [
	"Answer the penultimate literal of the receiver, which holds either
	 the receiver's selector or its properties (which will hold the selector)."
	| pIndex |
	^(pIndex := self numLiterals - 1) > 0 
		ifTrue: [self literalAt: pIndex]
		ifFalse: [nil]
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> primitive [
	"Answer the primitive index associated with the receiver.
	 Zero indicates that this is not a primitive method."
	| initialPC |
	^(self header anyMask: 65536) "Is the hasPrimitive? flag set?"
		ifTrue: [(self at: (initialPC := self initialPC) + 1) + ((self at: initialPC + 2) bitShift: 8)]
		ifFalse: [0]
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> methodClass [

	^self classBinding value
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> classBinding [

	^self literalAt: self numLiterals
]

{ #category : #'as yet unclassified' }
PCCompiledMethod >> selector [
	"Answer a method's selector.  This is either the penultimate literal,
	 or, if the method has any properties or pragmas, the selector of
	 the MethodProperties stored in the penultimate literal."
	| penultimateLiteral | 
	penultimateLiteral := self penultimateLiteral.
	penultimateLiteral isNil ifTrue: [^nil].
	^ penultimateLiteral isSymbol
		ifTrue: [penultimateLiteral]
		ifFalse: [penultimateLiteral instVarAt: 2]
]
