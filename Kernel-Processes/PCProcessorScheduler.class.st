Class {
	#name : #PCProcessorScheduler,
	#superclass : #PCObject,
	#instVars : [
		'suspendedProcessLists',
		'activeProcess'
	],
	#category : #'Kernel-Processes'
}

{ #category : #'as yet unclassified' }
PCProcessorScheduler class >> new [
	"The VM depends on a unique scheduler."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
PCProcessorScheduler >> initProcessLists [
	"Create process lists for prioriy levels 1 through 5."

	suspendedProcessLists := (1 to: 5)
		collect: [ :i | PCProcessList new ]
]
