Class {
	#name : #PCClassBuilder,
	#superclass : #PCObject,
	#instVars : [
		'superclass',
		'name',
		'instVarNames',
		'classVariablesNames',
		'formats'
	],
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
PCClassBuilder >> beBytes [
	self isCompiledMethodClassIndex
		ifTrue: [ ^ self beCompiledMethod ].
	^ formats := #(#variable #bytes)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> beCompiledMethod [
	^ formats := #(#compiledMethod #variable #bytes)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> beImmediate [
	^ formats := #(immediate)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> bePointers [
	^ formats := #(#pointers)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> beVariable [
	^ formats := #(#variable #pointers)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> beWeak [
	^ formats := #(#weak #variable #pointers)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> beWords [
	^ formats := #(#variable #words)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> build [
	| metaclass theClass supermetaclass |
	
	supermetaclass := superclass
		ifNil: [ PCClass ]
		ifNotNil: [ superclass class ].
	metaclass := PCMetaclass new.
	metaclass superclass: supermetaclass.
	metaclass setFormat: supermetaclass format.
	theClass := metaclass basicNew initialize.
	theClass superclass: superclass.
	theClass setFormat: self newClassFormat.
	theClass instVarNames: instVarNames asArray.
	theClass name: name.
	theClass classVariables: PCDictionary new.
	self classVariableNames
		do: [ :varName | theClass classVariables at: varName put: nil ].
	metaclass soleInstance: theClass.
	^ theClass
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> classVariableNames [
	^ classVariablesNames
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> classVariableNames: anArray [
	classVariablesNames := anArray
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> compactClassIndex [
	^ self compactClassIndexFor: name
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> compactClassIndexFor: aClassName [
	^ #(#PCCompiledMethod nil #PCArray #PCLargeNegativeInteger #PCLargePositiveInteger #PCFloat nil #PCAssociation #PCPoint #PCRectangle #PCString #PCBlock nil #PCMethodContext nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil)
		indexOf: aClassName
		ifAbsent: [ 0 ]	"#PCBitmap"
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> initialize [
	super initialize.
	instVarNames := ''.
	classVariablesNames := ''.
	superclass := PCObject.
	self bePointers
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> instSize [
	^ (superclass ifNil: [ 0 ] ifNotNil: [ superclass instSize ])
		+ instVarNames size
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> instSpec [
	"NEW:
	 0 = 0 sized objects (UndefinedObject True False et al)
	 1 = non-indexable objects with inst vars (Point et al)
	 2 = indexable objects with no inst vars (Array et al)
	 3 = indexable objects with inst vars (MethodContext AdditionalMethodState et al)
	 4 = weak indexable objects with inst vars (WeakArray et al)
	 5 = weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
	 6 = reserved
	 7 = forwarder format (also immediate class format)
	 9          64-bit indexable
	 10 - 11 32-bit indexable
	 12 - 15 16-bit indexable
	 16 - 23 byte indexable
	 24 - 31 compiled method"

	(self isImmediate) ifTrue: [ ^ 7 ].	
	(self isCompiledMethod) ifTrue: [ ^ 24 ].
	(self isBytes) ifTrue: [ ^ 16 ].
	(self isWords) ifTrue: [ ^ 10 ].
	"(self isEphemeron) ifTrue: [ ^ 5 ]."
	(self instSize = 0 and: [ self isVariable not ]) ifTrue: [ ^ 0 ].
	(self instSize > 0 and: [ self isVariable not ]) ifTrue: [ ^ 1 ].
	(self instSize = 0 and: [ self isVariable     ]) ifTrue: [ ^ 2 ].
	(self instSize > 0 and: [ self isVariable     ]) ifTrue: [ ^ 3 ].
	(self instSize > 0 and: [ self isVariable and: [ self isWeak ] ]) ifTrue: [ ^ 4 ].
	(self instSize > 0 and: [ self isVariable not and: [ self isWeak ] ]) ifTrue: [ ^ 5 ].

	self error: 'illegal old format'
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> instVarNames: anArray [
	instVarNames := anArray
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isBytes [
	^ formats includes: #bytes
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isCompiledMethod [
	^ formats includes: #compiledMethod
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isCompiledMethodClassIndex [
	^ (self compactClassIndexFor: name)
		== (self compactClassIndexFor: #PCCompiledMethod)
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isImmediate [

	^ formats includes: #immediate
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isPointers [
	^ formats includes: #pointers
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isVariable [
	^ formats includes: #variable
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isWeak [
	^ formats includes: #weak
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> isWords [
	^ formats includes: #words
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> name: aName [
	name := aName
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> newClassFormat [

	"A class format is composed by"
	"<5 bits inst spec><16 bits inst size>"
	| instSize newInstSpec |

	instSize := self instSize.
	newInstSpec := self instSpec.
	^(newInstSpec bitShift: 16) + instSize
]

{ #category : #'as yet unclassified' }
PCClassBuilder >> superclass: aClass [
	superclass := aClass
]
