Class {
	#name : #PCSystem,
	#superclass : #PCObject,
	#classVars : [
		'SpecialObjectsArray'
	],
	#category : #'Kernel-System'
}

{ #category : #'as yet unclassified' }
PCSystem class >> allObjectsDo: aBlock [
	"Evaluate the argument, aBlock, for each object in the system excluding SmallIntegers."

	| object |
	object := self someObject.
	[ 0 == object ]
		whileFalse: [ aBlock value: object.
			object := object nextObject ]
]

{ #category : #'as yet unclassified' }
PCSystem class >> append: aString toFile: fileName [
	"Append the given string to the file with the given name."

	| f |
	f := PCFile new.
	f openReadWrite: f localFolderPath , fileName.
	f position: f size.
	f nextPutAll: aString.
	f cr.
	f close
]

{ #category : #'as yet unclassified' }
PCSystem class >> exitToDebugger [
	"Tell the VM that we've encountered an unhandled error or halt."

	<primitive: 114>
	
]

{ #category : #'as yet unclassified' }
PCSystem class >> garbageCollect [
	"Primitive. Reclaims all garbage and answers the number of bytes of available space."

	<primitive: 130>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCSystem class >> getVMParameters [
	"Answer an Array containing the current values of the VM's internal parameter and statistics registers. The same primitive can be called with one integer argument to read a specific parameter and with two parameters to set a writable parameter, although these variations may not be implemented. Optional."

	"VM parameters are numbered as follows:
		1	end of old-space (0-based, read-only)
		2	end of young-space (read-only)
		3	end of memory (read-only)
		4	allocationCount (read-only)
		5	allocations between GCs (read-write)
		6	survivor count tenuring threshold (read-write)
		7	full GCs since startup (read-only)
		8	total milliseconds in full GCs since startup (read-only)
		9	incremental GCs since startup (read-only)
		10	total milliseconds in incremental GCs since startup (read-only)
		11	tenures of surving objects since startup (read-only)
		12-20 specific to the translating VM (obsolete)
		21   root table size (read-only)
		22   root table overflows since startup (read-only)"

	<primitive: 254>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCSystem class >> getchar [
	"Answer the ASCII value of the next character from the keyboard buffer. Answer nil if no key has been typed."

	| ch |
	(ch := self primKeyboardNext)
		ifNil: [ ^ nil ]
		ifNotNil: [ ^ ch bitAnd: 16rFF ]
]

{ #category : #'as yet unclassified' }
PCSystem class >> graphicsTest [
	"This method is called when the image is started. Add a call to your own code here."

	"MSystem graphicsTest"

	| f |
	self log: 'Screen size: ' , PCForm new primScreenSize printString.
	f := PCForm new.
	f beDisplayDepth: 32.
	0 to: 255 do: [ :r | 
		0 to: 255 do: [ :gb | 
			f setColorR: r g: gb b: gb.
			f
				fillRectX: gb
				y: 0
				w: 1
				h: f height ] ].
	f setColorR: 255 g: 255 b: 0.
	f
		fillRectX: 0
		y: 0
		w: 30
		h: 30
]

{ #category : #'as yet unclassified' }
PCSystem class >> incrementalGarbageCollect [
	"Primitive. Reclaims recently created garbage fairly quickly and answers the number of bytes of available space."

	<primitive: 131>
	
]

{ #category : #'as yet unclassified' }
PCSystem class >> log: aString [
	self append: aString toFile: 'log1.txt'
]

{ #category : #'as yet unclassified' }
PCSystem class >> milliseconds [
	"Answer the current value of the millisecond clock. Optional primitive."

	"Note: The millisecond clock may wrap around frequently, depending on the underlaying hardware. If no hardware clock is available, it may always return 0."

	<primitive: 135>
	^ 0
]

{ #category : #'as yet unclassified' }
PCSystem class >> primKeyboardNext [
	"Answer the next keycode from the keyboard buffer. A keycode is 12 bits: four modifier flags in the 4 most significant bits and the 8 bit ISO character in the least significant bits. Answer nil if no key has been typed."

	<primitive: 108>
	^ nil
]

{ #category : #'as yet unclassified' }
PCSystem class >> primitiveGetSpecialObjectsArray [
	"Answer the virtual machine's special objects array."

	<primitive: 129>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
PCSystem class >> quit [
	"Exit from the system."

	<primitive: 113>
	
]

{ #category : #'as yet unclassified' }
PCSystem class >> snapshotAndQuit [
	| snapshotResult isImageStarting | 
	snapshotResult := PCSystem snapshotPrimitive.	"<-- PC frozen here on image file"
	isImageStarting := (snapshotResult == true).
	isImageStarting ifFalse: [ PCSystem quit ]
]

{ #category : #'as yet unclassified' }
PCSystem class >> snapshotPrimitive [
	"Primitive. Write the current state of the object memory on a file in the
	same format as the Smalltalk-80 release. The file can later be resumed,
	returning you to this exact state. Return normally after writing the file.
	Essential. See Object documentation whatIsAPrimitive."
	
	"I will return 
		true if the image is starting or
		false if the image is just resuming"

	<primitive: 97>
	^nil "indicates error writing image file"
]

{ #category : #'as yet unclassified' }
PCSystem class >> specialObjectsArray [
	^ SpecialObjectsArray
]

{ #category : #'as yet unclassified' }
PCSystem class >> specialObjectsArray: anArray [
	SpecialObjectsArray := anArray
]

{ #category : #'as yet unclassified' }
PCSystem class >> start [
	| point |
	thisContext sender asString.
	self log: 'Welcome to Pharo Candle accessing contexts!'.
	self log: 'from System >> start'.
	PCSystem log: '   thisContext sender : ',thisContext sender asString.
	PCSystem log: '   thisContext sender class : ',thisContext sender class asString.
	PCSystem log: '   thisContext closureOrNil : ',thisContext closureOrNil asString.
	PCSystem log: '   thisContext closureOrNil class : ',thisContext closureOrNil class asString.
	PCSystem log: '   thisContext receiver : ',thisContext receiver asString.
	PCSystem log: '   thisContext receiver class : ',thisContext receiver class asString.
	PCSystem log: '   thisContext method class : ',thisContext method class asString.
	PCSystem log: '   thisContext method : ',thisContext method asString.
	
	point := PCPoint new.
	point metodosinparametro.
	point metodoconparametro:1.
	
	self quit
]

{ #category : #'as yet unclassified' }
PCSystem class >> testByteObject [
	| test |
	test := (PCObject
		variableByteSubclass: #Test
		instanceVariableNames: ''
		classVariableNames: '') new: 5.
	self log: 'size of byte object created: ' , test basicSize asString.
	test at: 1 put: 17
]

{ #category : #'as yet unclassified' }
PCSystem class >> testNormalObject [
	| test |
	test := (PCObject
		subclass: #Test
		instanceVariableNames: 'test1 test2'
		classVariableNames: '') new.
	test instVarAt: 1 put: 1.
	test instVarAt: 2 put: (test instVarAt: 1) + 2.
	self log: (test instVarAt: 2) asString
]

{ #category : #'as yet unclassified' }
PCSystem class >> tinyBenchmarks [
	"Report the results of running the two tiny benchmarks."

	| n t1 t2 r |
	n := 25.
	t1 := [ n benchmark ] msecs.
	t2 := [ r := 28 benchFib ] msecs.
	^ (n * 500000 * 1000 // t1) printString , ' bytecodes/sec; '
		, (r * 1000 // t2) printString , ' sends/sec'
]
