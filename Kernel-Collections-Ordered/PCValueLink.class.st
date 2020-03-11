Class {
	#name : #PCValueLink,
	#superclass : #PCObject,
	#instVars : [
		'nextLink',
		'value'
	],
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
PCValueLink class >> value: aValue [
	^ self new value: aValue
]
