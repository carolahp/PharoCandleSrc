Class {
	#name : #PCPoint,
	#superclass : #PCObject,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Kernel-Optional'
}

{ #category : #'as yet unclassified' }
PCPoint class >> r: rho degrees: theta [
	"Answer an instance of me with polar coordinates rho and theta."

	^ self new setR: rho degrees: theta
]

{ #category : #'as yet unclassified' }
PCPoint class >> x: xValue y: yValue [
	"Answer an instance of me with the given coordinates."

	^ self new setX: xValue setY: yValue
]
