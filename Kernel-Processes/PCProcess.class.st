Class {
	#name : #PCProcess,
	#superclass : #PCObject,
	#instVars : [
		'nextLink',
		'suspendedContext',
		'priority',
		'myList',
		'threadId',
		'errorHandler'
	],
	#category : #'Kernel-Processes'
}

{ #category : #'as yet unclassified' }
PCProcess class >> for: aContext priority: anInteger [
	"Answer an instance of me for the given context (usually a Block) at the given priority."

	^ self new
		initSuspendedContext: aContext;
		priority: anInteger
]
