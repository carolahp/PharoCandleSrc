Class {
	#name : #PCLargePositiveInteger,
	#superclass : #PCInteger,
	#type : #bytes,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
PCLargePositiveInteger >> \\ anInteger [
	"Primitive. Take the receiver modulo the argument. The result is the
	remainder rounded towards negative infinity, of the receiver divided
	by the argument. Fail if the argument is 0. Fail if either the argument
	or the result is not a SmallInteger or a LargePositiveInteger less than
	2-to-the-30th (1073741824). Optional. See Object documentation whatIsAPrimitive."

	<primitive: 31>
	^ super \\ anInteger
]

{ #category : #'as yet unclassified' }
PCLargePositiveInteger >> digitAt: index put: value [
	"Primitive. Store the second argument (value) in the indexable field of 
	the receiver indicated by index. Fail if the value is negative or is larger 
	than 255. Fail if the index is not an Integer or is out of bounds. Answer 
	the value that was stored. Essential. See Object documentation 
	whatIsAPrimitive."

	<primitive: 61>
	^ super at: index put: value
]
