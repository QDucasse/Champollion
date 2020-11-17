Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'globalEnvironment'
	],
	#category : #'Champollion-Core'
}

{ #category : #visiting }
CHInterpreter >> execute: anAST [ 
	^ self visitNode: anAST
]

{ #category : #visiting }
CHInterpreter >> execute: anAST withReceiver: anObject [ 
	^ self 
		execute: anAST
		withReceiver: anObject 
		andArguments: #()
]

{ #category : #executing }
CHInterpreter >> execute: anAST withReceiver: anObject andArguments: aCollection [
	| result |
	"Push a new frame on the stack"
	self pushNewFrame.
	"Push the receiver of the method as self in the top frame"
	self tempAt: #self put: anObject.
	"Add the arguments to the top frame"
	anAST arguments 
		with: aCollection 
		do: [ :arg :value | self topFrame at: arg name put: value ].
	"Visit the method ast"
	result := self visitNode: anAST.
	self popFrame.
	^ result
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
	stack := CTStack new.
]

{ #category : #executing }
CHInterpreter >> popFrame [ 
	stack pop
]

{ #category : #executing }
CHInterpreter >> pushNewFrame [ 
	| newTop |
	newTop := Dictionary new.
	stack push: newTop.
	^ newTop
]

{ #category : #accessing }
CHInterpreter >> receiver [
	^ self tempAt: self
]

{ #category : #executing }
CHInterpreter >> tempAt: aSymbol [ 
	self topFrame at: aSymbol 
]

{ #category : #executing }
CHInterpreter >> tempAt: aSymbol put: anObject [
	self topFrame at: aSymbol put: anObject
]

{ #category : #accessing }
CHInterpreter >> topFrame [ 
	^ stack top
]

{ #category : #executing }
CHInterpreter >> visitArrayNode: anArrayNode [
	^ anArrayNode statements 
		collect: [ :e | self visitNode: e ]
		as: Array
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
CHInterpreter >> visitMessageNode: aMessageNode [ 
	| newReceiver method args |
	"Visit the arguments of the method"
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	"Visit the receiver of the message"
	newReceiver := self visitNode: aMessageNode receiver.
	method := (newReceiver class compiledMethodAt: aMessageNode selector) ast.
	^ self execute: method withReceiver: newReceiver andArguments: args
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

{ #category : #visiting }
CHInterpreter >> visitTemporaryNode: anArgumentNode [ 
	^ self tempAt: anArgumentNode name
]
