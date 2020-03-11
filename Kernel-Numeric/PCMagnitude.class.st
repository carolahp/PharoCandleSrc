Class {
	#name : #PCMagnitude,
	#superclass : #PCObject,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
PCMagnitude >> max: aMagnitude [
	"Answer the receiver or the argument, whichever has the greater 
	magnitude."

	self > aMagnitude
		ifTrue: [ ^ self ]
		ifFalse: [ ^ aMagnitude ]
]

{ #category : #'as yet unclassified' }
PCMagnitude >> min: aMagnitude [
	"Answer the receiver or the argument, whichever has the lesser 
	magnitude."

	self < aMagnitude
		ifTrue: [ ^ self ]
		ifFalse: [ ^ aMagnitude ]
]
