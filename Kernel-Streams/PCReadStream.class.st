Class {
	#name : #PCReadStream,
	#superclass : #PCObject,
	#instVars : [
		'collection',
		'position',
		'readLimit'
	],
	#category : #'Kernel-Streams'
}

{ #category : #'as yet unclassified' }
PCReadStream class >> on: aCollection [
	"Answer an instance of me, streaming over the elements of aCollection."

	^ self basicNew on: aCollection
]

{ #category : #'as yet unclassified' }
PCReadStream >> on: aCollection [
	"Initialize myself for streaming over the given collection."

	collection := aCollection.
	readLimit := aCollection size.
	position := 0
]
