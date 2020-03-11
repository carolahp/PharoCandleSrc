Class {
	#name : #PCSymbol,
	#superclass : #PCString,
	#type : #bytes,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
PCSymbol class >> new: size [
	"Symbols are unique. You can create a new Symbol from a String using 'asSymbol'."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
PCSymbol >> = anObject [
	^ self == anObject
]

{ #category : #'as yet unclassified' }
PCSymbol >> hash [
	^ self identityHash
]
