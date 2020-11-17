Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'receiver',
		'globalEnvironment'
	],
	#category : #'Champollion-Core'
}

{ #category : #visiting }
CHInterpreter >> execute: anAST [ 
	^ self visitNode: anAST
]

{ #category : #executing }
CHInterpreter >> execute: anAST withReceiver: aReceiver [ 
	receiver := aReceiver.
	^ self visitNode: anAST
]

{ #category : #visiting }
CHInterpreter >> globalEnvironment [ 
	^ globalEnvironment 
]

{ #category : #executing }
CHInterpreter >> globalEnvironmentAt: aSymbol put: anObject [
	globalEnvironment at: aSymbol put: anObject
]

{ #category : #executing }
CHInterpreter >> initialize [ 
	super initialize.
	globalEnvironment := Dictionary new.
]

{ #category : #accessing }
CHInterpreter >> receiver [
	^ receiver
]

{ #category : #visiting }
CHInterpreter >> visitAssignmentNode: anAssignmentNode [ 
	"x := 100"
	| value |
	value := (self visitNode: anAssignmentNode value).
	anAssignmentNode variable store: value with: self.
	^ value
]

{ #category : #visiting }
CHInterpreter >> visitGlobalNode: aGlobalNode [ 
	^ self globalEnvironment 
			 at: aGlobalNode name 
			 ifAbsent: [ self error: aGlobalNode name, ' not found' ]
]

{ #category : #visiting }
CHInterpreter >> visitInstanceVariableNode: aVariableNode [ 
	^ self receiver instVarNamed: aVariableNode name
]

{ #category : #visiting }
CHInterpreter >> visitLiteralArrayNode: aLiteralArrayNode [ 
	^ aLiteralArrayNode contents 
		collect: [ :literalNode | self visitNode: literalNode ]
		as: Array
]

{ #category : #visiting }
CHInterpreter >> visitLiteralValueNode: aLiteralValueNode [ 
	^ aLiteralValueNode value
]

{ #category : #visiting }
CHInterpreter >> visitMethodNode: aMethodNode [ 
	^ self visitNode: aMethodNode body "Visit the body of the method"
]

{ #category : #visiting }
CHInterpreter >> visitNode: aNode [ 
	^ aNode acceptVisitor: self
]

{ #category : #visiting }
CHInterpreter >> visitReturnNode: aReturnNode [ 
	^ self visitNode: aReturnNode value.
]

{ #category : #visiting }
CHInterpreter >> visitSelfNode: aNode [ 
	^ self receiver
]

{ #category : #visiting }
CHInterpreter >> visitSequenceNode: aSequenceNode [ 
	"Visit all statements but last without caring about the result"
	aSequenceNode statements allButLastDo: 
		[ :each | self visitNode: each ].
	"Return the result of the final statement"
	^ self visitNode: aSequenceNode statements last
]

{ #category : #visiting }
CHInterpreter >> visitSuperNode: aNode [ 
	^ self receiver
]
