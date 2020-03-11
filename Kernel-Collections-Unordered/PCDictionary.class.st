Class {
	#name : #PCDictionary,
	#superclass : #PCSet,
	#category : #'Kernel-Collections-Unordered'
}

{ #category : #'as yet unclassified' }
PCDictionary >> add: anAssociation [
	| index element |
	index := self findElementOrNil: anAssociation key.
	element := array at: index.
	element == nil
		ifTrue: [ self atNewIndex: index put: anAssociation ]
		ifFalse: [ element value: anAssociation value ].
	^ anAssociation
]

{ #category : #'as yet unclassified' }
PCDictionary >> at: key put: anObject [
	"Set the value at key to be anObject.  If key is not found, create a new
	entry for key and set is value to anObject. Answer anObject."

	| index element |
	index := self findElementOrNil: key.
	element := array at: index.
	element == nil
		ifTrue:
			[ self atNewIndex: index put: (PCAssociation key: key value: anObject) ]
		ifFalse: [ element value: anObject ].
	^ anObject
]

{ #category : #'as yet unclassified' }
PCDictionary >> noCheckAdd: anObject [
	"Must be defined separately for Dictionary because (self findElementOrNil:) expects a key, not an association.  9/7/96 tk"

	array at: (self findElementOrNil: anObject key) put: anObject.
	tally := tally + 1
]

{ #category : #'as yet unclassified' }
PCDictionary >> scanFor: anObject [
	"Scan the key array for the first slot containing either a nil (indicating an empty slot) or an element that matches anObject. Answer the index of that slot or zero if no slot is found. This method will be overridden in various subclasses that have different interpretations for matching elements."

	| element start finish |
	start := anObject hash \\ array size + 1.
	finish := array size.	"Search from (hash mod size) to the end."
	start to: finish do: [ :index | 
		((element := array at: index) == nil or: [ element key = anObject ])
			ifTrue: [ ^ index ] ].	"Search from 1 to where we started."
	1 to: start - 1 do: [ :index | 
		((element := array at: index) == nil or: [ element key = anObject ])
			ifTrue: [ ^ index ] ].
	^ 0	"No match AND no empty slot"
]
