Class {
	#name : #CHInterpretable,
	#superclass : #Object,
	#instVars : [
		'x',
		'collaborator',
		'current',
		'evaluationOrder'
	],
	#category : #'Champollion-Tests'
}

{ #category : #'value creation' }
CHInterpretable >> changeCollaboratorWithArgument [
	collaborator x: 500
]

{ #category : #'value creation' }
CHInterpretable >> changeCollaboratorX [
	collaborator store100IntoX
]

{ #category : #'value creation' }
CHInterpretable >> collaborator [ 
	^ collaborator
]

{ #category : #'value creation' }
CHInterpretable >> collaborator: anObject [ 
	collaborator := anObject.
]

{ #category : #'as yet unclassified' }
CHInterpretable >> evaluateReceiver [ 	
	evaluationOrder := self next.
	^ self
]

{ #category : #'value creation' }
CHInterpretable >> evaluationOrder [ 	
	^ evaluationOrder 
]

{ #category : #'value creation' }
CHInterpretable >> initialize [ 
	super initialize.
	current := { "empty" }
]

{ #category : #'as yet unclassified' }
CHInterpretable >> messageArg1: arg1 arg2: arg2 arg3: arg3 [ 
	^ { arg1 . arg2 . arg3 } 
]

{ #category : #'value creation' }
CHInterpretable >> next [ 
	| next |
	"Implement a stream as an increment in terms of Peano axioms"
	next := current.
	current := { current }.
	^ next
]

{ #category : #'value creation' }
CHInterpretable >> returnBoolean [
	^ false 
	
]

{ #category : #'value creation' }
CHInterpretable >> returnEmptyLiteralArray [ 
	^ #()
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnEvaluationOrder [ 
	^ self evaluateReceiver 
			messageArg1: self next
			arg2: self next
			arg3: self next
]

{ #category : #'value creation' }
CHInterpretable >> returnFloat [ 
	^ 3.14
]

{ #category : #'value creation' }
CHInterpretable >> returnGlobal [ 
	^ Global
]

{ #category : #'value creation' }
CHInterpretable >> returnInteger [
	^ 5
]

{ #category : #'value creation' }
CHInterpretable >> returnRecursiveLiteralArray [ 
	^ #(true 1 #('haha'))
]

{ #category : #'value creation' }
CHInterpretable >> returnSelf [
	^ self
]

{ #category : #'value creation' }
CHInterpretable >> returnSuper [ 
	^ super
]

{ #category : #'value creation' }
CHInterpretable >> returnX [ 
	^ x
]

{ #category : #'value creation' }
CHInterpretable >> sendMessageReturnX [
	^ self returnX
]

{ #category : #'value creation' }
CHInterpretable >> setXAndMessage [
	x := 1000.
	collaborator returnX.
	^ x
]

{ #category : #'value creation' }
CHInterpretable >> store100IntoX [ 
	^ x := 100
]

{ #category : #'value creation' }
CHInterpretable >> x [
	^ x
]

{ #category : #'value creation' }
CHInterpretable >> x: anInteger [
	x := anInteger
]
