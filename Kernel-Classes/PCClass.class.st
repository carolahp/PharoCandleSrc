Class {
	#name : #PCClass,
	#superclass : #PCBehavior,
	#instVars : [
		'name',
		'instVarsNames',
		'classVars'
	],
	#classVars : [ ],
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
PCClass >> classSide [
	^ self class
]

{ #category : #'as yet unclassified' }
PCClass >> classVariables [
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."

	^ classVars
]

{ #category : #'as yet unclassified' }
PCClass >> classVariables: aDictionary [
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."
"asd"
	^ classVars := aDictionary
]

{ #category : #'as yet unclassified' }
PCClass >> immediateSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beImmediate;
		build
]

{ #category : #'as yet unclassified' }
PCClass >> initFrom: aPharoClass methodDict: newMethodDict [
	"Fill in my instance variables from the given Class using the given MethodDictionary."

	superclass := PCObject.	"corrected later"
	methodDict := newMethodDict.
	format := aPharoClass format.
	name := (aPharoClass name copyFrom: 2 to: aPharoClass name size)
		asSymbol.	"omit leading M"
	instVarsNames := aPharoClass instVarNames.
	classVars := aPharoClass classPool.
	instVarsNames size = 0
		ifTrue: [ instVarsNames := nil ].
	classVars size = 0
		ifTrue: [ classVars := nil ]
]

{ #category : #'as yet unclassified' }
PCClass >> instVarNames [
	"Answer an Array of the receiver's instance variable names."

	instVarsNames ifNil: [ ^ #() ].
	^ instVarsNames
]

{ #category : #'as yet unclassified' }
PCClass >> instVarNames: anArray [
	instVarsNames := anArray
]

{ #category : #'as yet unclassified' }
PCClass >> isMeta [
	^ false
]

{ #category : #'as yet unclassified' }
PCClass >> name [
	^ name
]

{ #category : #'as yet unclassified' }
PCClass >> name: aSymbol [
	name := aSymbol
]

{ #category : #'as yet unclassified' }
PCClass >> newClassBuilderForSubclass: subclassName instanceVariableNames: instVarNames classVariableNames: classVarNames [
	^ PCClassBuilder new
		superclass: self;
		name: subclassName;
		instVarNames: instVarsNames;
		classVariableNames: classVarNames;
		yourself
]

{ #category : #'as yet unclassified' }
PCClass >> subclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		yourself;
		build
]

{ #category : #'as yet unclassified' }
PCClass >> theNonMetaClass [
	^ self
]

{ #category : #'as yet unclassified' }
PCClass >> variableByteSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beBytes;
		build
]

{ #category : #'as yet unclassified' }
PCClass >> variableSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beVariable;
		build
]

{ #category : #'as yet unclassified' }
PCClass >> variableWordSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beWords;
		build
]

{ #category : #'as yet unclassified' }
PCClass >> weakSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beWeak;
		build
]
