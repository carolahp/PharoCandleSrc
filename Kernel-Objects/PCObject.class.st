Class {
	#name : #PCObject,
	#superclass : #nil,
	#category : #'Kernel-Objects'
}

{ #category : #'as yet unclassified' }
PCObject class >> cannotInstantiate [
	"This message is sent if you try to create new instances of classes with unique instances such as booleans or characters."

	self error: 'You cannot create new instances of ' , self name
]

{ #category : #'as yet unclassified' }
PCObject class >> new [
	"Create a new instance of me and initialize it."

	^ self basicNew initialize
]

{ #category : #'as yet unclassified' }
PCObject >> -> anObject [
	"Answer an Association with myself as its key and anObject as its value."

	^ PCAssociation new key: self value: anObject
]

{ #category : #'as yet unclassified' }
PCObject >> = anObject [
	"Answer whether the receiver and the argument represent the same 
	object. If = is redefined in any subclass, consider also redefining the 
	message hash."

	^ self == anObject
]

{ #category : #'as yet unclassified' }
PCObject >> == anObject [
	"Primitive. Answer whether the receiver and the argument are the same 
	object (have the same object pointer). Do not redefine the message == in 
	any other class! Essential. No Lookup. Do not override in any subclass. 
	See Object documentation whatIsAPrimitive."

	<primitive: 110>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCObject >> asString [
	^ self printString
]

{ #category : #'as yet unclassified' }
PCObject >> at: index [
	"Primitive. Assumes receiver is indexable. Answer the value of an indexable element in the receiver. Fail if the argument index is not an  Integer or is out of bounds. Essential. Do not override in a subclass. See Object documentation whatIsAPrimitive."

	<primitive: 60>
	index isInteger
		ifTrue: [ self errorSubscriptBounds: index ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
PCObject >> at: index put: value [
	"Primitive. Assumes receiver is indexable. Store the second argument 
	value in the indexable element of the receiver indicated by index. Fail 
	if the index is not an Integer or is out of bounds. Or fail if the value is 
	not of the right type for this kind of collection. Answer the value that 
	was stored. Essential. Do not override in a subclass. See Object 
	documentation whatIsAPrimitive."

	<primitive: 61>
	index isInteger
		ifTrue: [ (index >= 1 and: [ index <= self size ])
				ifTrue: [ self errorImproperStore ]
				ifFalse: [ self errorSubscriptBounds: index ] ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger put: value ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
PCObject >> basicAt: index [
	"Primitive. Assumes receiver is indexable. Answer the value of an indexable element in the receiver. Fail if the argument index is not an  Integer or is out of bounds. Essential. Do not override in a subclass. See Object documentation whatIsAPrimitive."

	<primitive: 60>
	index isInteger
		ifTrue: [ self errorSubscriptBounds: index ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
PCObject >> basicAt: index put: value [
	"Primitive. Assumes receiver is indexable. Store the second argument 
	value in the indexable element of the receiver indicated by index. Fail 
	if the index is not an Integer or is out of bounds. Or fail if the value is 
	not of the right type for this kind of collection. Answer the value that 
	was stored. Essential. Do not override in a subclass. See Object 
	documentation whatIsAPrimitive."

	<primitive: 61>
	index isInteger
		ifTrue: [ (index >= 1 and: [ index <= self size ])
				ifTrue: [ self errorImproperStore ]
				ifFalse: [ self errorSubscriptBounds: index ] ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger put: value ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
PCObject >> basicCopy [
	"Answer a copy of the receiver that shares the receiver's instance variables. This is usually handled by the primitive, so the code below is for documentation."

	<primitive: 148>
	| class result sz |
	class := self class.
	class isVariable
		ifTrue: [ sz := self basicSize.
			result := class basicNew: sz.
			1 to: sz do: [ :i | result basicAt: i put: (self basicAt: i) ] ]
		ifFalse: [ result := class basicNew ].
	1 to: class instSize do: [ :i | result instVarAt: i put: (self instVarAt: i) ].
	^ result
]

{ #category : #'as yet unclassified' }
PCObject >> basicIdentityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	This method must not be overridden, except by SmallInteger.
	Primitive. Fails if the receiver is a SmallInteger. Essential.
	See Object documentation whatIsAPrimitive.

	Do not override. Use #identityHash unless you really know what you're doing.'"

	<primitive: 75>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCObject >> basicSize [
	"Primitive. Answer the number of indexable variables in the receiver. This value is the same as the largest legal subscript. Essential. Do not override in any subclass. See Object documentation whatIsAPrimitive."

	<primitive: 62>
	^ 0	"for fixed-size objects"
]

{ #category : #'as yet unclassified' }
PCObject >> become: otherObject [
	"Swap the object pointers of the receiver and the argument. After this, all variables in the entire system that used to point to the receiver now point to the argument, and vice-versa. Fails if either object is a SmallInteger."

	(PCArray with: self)
		elementsExchangeIdentityWith: (PCArray with: otherObject)
]

{ #category : #'as yet unclassified' }
PCObject >> class [
	"Primitive. Answer the object which is the receiver's class. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 111>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCObject >> copy [
	"Answer a copy of me. Subclasses should usually override this method to change copying behavior, not basicCopy. The exception is classes with unique instances, such as Symbol. This operation does not generally copy all the objects that I refer to.."

	^ self basicCopy
]

{ #category : #'as yet unclassified' }
PCObject >> identityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity. This method must not be overridden, except by SmallInteger. Primitive. Fails if the receiver is a SmallInteger. Essential. See Object documentation whatIsAPrimitive. Do not override!"

	^ self basicIdentityHash bitShift: 18
]

{ #category : #'as yet unclassified' }
PCObject >> ifNil: nilBlock ifNotNil: ifNotNilBlock [
	"Evaluate the block, unless I'm == nil (q.v.)"

	^ ifNotNilBlock value
]

{ #category : #'as yet unclassified' }
PCObject >> initialize [
	"Initialize this object. Usually called by new when a new object is created. This default implementation does nothing."

	^ self
]

{ #category : #'as yet unclassified' }
PCObject >> instVarAt: index put: anObject [
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable or indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	 (index isInteger 
		and: [ index between: 1 and: self class instSize + self basicSize]) 
			ifFalse: [ ^ self errorSubscriptBounds: index ].
	self isReadOnlyObject 
		ifTrue: [ ^ self modificationForbiddenFor: #instVarAt:put: index: index value: anObject ]
]

{ #category : #'as yet unclassified' }
PCObject >> printString [
	"Answer a string describing me."

	| stream |
	stream := PCWriteStream on: (PCString new: 100).
	self printOn: stream.
	^ stream contents
]

{ #category : #'as yet unclassified' }
PCObject >> species [
	"Answer the preferred class for reconstructing the receiver, which is typically some kind of collection. For example, the response to this message determines the type of object returned by the collect: or select: messages. Species and class are not always the same. For example, the species of Interval is Array."

	^ self class
]

{ #category : #'as yet unclassified' }
PCObject >> yourself [
	"Answer the receiver. Useful in cascaded message expressions."

	^ self
]
