Class {
	#name : #PCArray,
	#superclass : #PCArrayedCollection,
	#type : #variable,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
PCArray >> asArray [
	"Answer with the receiver itself."

	^ self
]

{ #category : #'as yet unclassified' }
PCArray >> asDictionary [
	| dictionary |

	dictionary := PCDictionary new.
	self do: [ :each | dictionary add: each ].
	^ dictionary
]

{ #category : #'as yet unclassified' }
PCArray >> elementsExchangeIdentityWith: otherArray [
	"This primitive performs a bulk mutation, causing all pointers to the elements of this array to be replaced by pointers to the corresponding elements of otherArray.  At the same time, all pointers to the elements of otherArray are replaced by pointers to the corresponding elements of this array."

	<primitive: 128>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCArray >> printOn: aStream [
	aStream nextPutAll: '#('.
	self
		do: [ :each | 
			each printOn: aStream.
			aStream space ].
	aStream nextPut: $)
]
