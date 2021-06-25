Class {
	#name : #PCMethodContext,
	#superclass : #PCContext,
	#role : 'Context',
	#type : #variable,
	#instVars : [
		'stackp',
		'method',
		'closureOrNil',
		'receiver'
	],
	#classVars : [ ],
	#category : #'Kernel-Methods'
}

{ #category : #'as yet unclassified' }
PCMethodContext >> asContext [
	^ self
]

{ #category : #'as yet unclassified' }
PCMethodContext >> callStack [
	^ self sender isNil 
		ifTrue:  [{ self } asOrderedCollection]
		ifFalse: [{ self } asOrderedCollection addAll: self sender callStack; yourself ]
]

{ #category : #'as yet unclassified' }
PCMethodContext >> closureOrNil [
	^ closureOrNil
]

{ #category : #'as yet unclassified' }
PCMethodContext >> home [
	"Answer the context in which the receiver was defined."

	closureOrNil == nil
		ifTrue: [ ^ self ].
	^ closureOrNil outerContext home
]

{ #category : #'as yet unclassified' }
PCMethodContext >> method [
	^ method
]

{ #category : #'as yet unclassified' }
PCMethodContext >> printOn: aStream [
	aStream
		nextPutAll:  '*', receiver asString, '* ';
		nextPutAll: receiver class asString;
		nextPutAll: '(', self method methodClass asString, ')';
		nextPutAll: ' >>> ';
		nextPutAll: self method selector asString
]

{ #category : #'as yet unclassified' }
PCMethodContext >> privRefresh [
	"Reinitialize the receiver so that it is in the state it was at its creation."

	closureOrNil
		ifNotNil: [ pc := closureOrNil startpc.
			self stackp: closureOrNil numArgs + closureOrNil numCopiedValues.
			1 to: closureOrNil numCopiedValues do:
				[ :i | self tempAt: closureOrNil numArgs + i put: (closureOrNil at: i) ] ]
		ifNil: [ pc := method initialPC.
			self stackp: method numTemps.
			method numArgs + 1 to: method numTemps do: [ :i | self tempAt: i put: nil ] ]
]

{ #category : #'as yet unclassified' }
PCMethodContext >> receiver [ 
	^ receiver
]

{ #category : #'as yet unclassified' }
PCMethodContext >> removeSelf [
	"Nil the receiver pointer and answer its former value."

	| result |
	result := receiver.
	receiver := nil.
	^ result
]

{ #category : #'as yet unclassified' }
PCMethodContext >> sender [ 
	^ sender
]

{ #category : #'as yet unclassified' }
PCMethodContext >> setSender: s receiver: r method: m closure: c startpc: startpc [
	"Create the receiver's initial state."
PCSystem log: 'alguien llamo a setSender:receiver....'.
	sender := s.
	receiver := r.
	method := m.
	closureOrNil := c.
	pc := startpc.
	stackp := 0
]

{ #category : #'as yet unclassified' }
PCMethodContext >> stackp: newStackp [
	"Storing into the stack pointer is a potentially dangerous thing.
	This primitive stores nil into any cells that become accessible as a result,
	and it performs the entire operation atomically."

	"Once this primitive is implemented, failure code should cause an error"

	<primitive: 76>
	self error: 'stackp store failure'
]

{ #category : #'as yet unclassified' }
PCMethodContext >> stringCallStack [

	| stream |
	stream := PCWriteStream on: (PCString new: 100).
	self callStack do: [:contx | 
		stream 
			nextPutAll: contx asString;
			nextPutAll: PCCharacter cr asString ].
	^ stream contents
]

{ #category : #'as yet unclassified' }
PCMethodContext >> tempAt: index put: value [
	"Store the argument, value, as the temporary variable whose index is the 
	 argument, index.  Primitive. Assumes receiver is indexable. Answer the
	 value of an indexable element in the receiver. Fail if the argument index
	 is not an Integer or is out of bounds. Essential. See Object documentation
	 whatIsAPrimitive.  Override the default at:put: primitive to give latitude to
	 the VM in context management."

	<primitive: 211>
	^self at: index put: value
	
]
