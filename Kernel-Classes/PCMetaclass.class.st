Class {
	#name : #PCMetaclass,
	#superclass : #PCBehavior,
	#instVars : [
		'soleInstance'
	],
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
PCMetaclass >> soleInstance: aClass [
	soleInstance := aClass
]
