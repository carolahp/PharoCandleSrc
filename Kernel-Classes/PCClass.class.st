Class {
	#name : #PCClass,
	#superclass : #PCBehavior,
	#instVars : [
		'name',
		'instVarNames',
		'classVariables'
	],
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
PCClass >> classVariables [
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."

	^ classVariables
]

{ #category : #'as yet unclassified' }
PCClass >> classVariables: aDictionary [
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."

	^ classVariables := aDictionary
]

{ #category : #'as yet unclassified' }
PCClass >> instVarNames: anArray [
	instVarNames := anArray
]

{ #category : #'as yet unclassified' }
PCClass >> name: aSymbol [
	name := aSymbol
]
