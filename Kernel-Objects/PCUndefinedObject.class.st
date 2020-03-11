Class {
	#name : #PCUndefinedObject,
	#superclass : #PCObject,
	#category : #'Kernel-Objects'
}

{ #category : #'as yet unclassified' }
PCUndefinedObject class >> new [
	"There is a single unique instance of me."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
PCUndefinedObject >> ifNil: nilBlock ifNotNil: ifNotNilBlock [
	"Evaluate the block for nil because I'm == nil"

	^ nilBlock value
]
