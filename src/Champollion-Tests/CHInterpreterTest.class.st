Class {
	#name : #CHInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'receiver'
	],
	#category : #'Champollion-Tests'
}

{ #category : #tests }
CHInterpreterTest >> executeSelector: aSymbol [ 
	^ self executeSelector: aSymbol withReceiver: receiver
]

{ #category : #execution }
CHInterpreterTest >> executeSelector: aSymbol withReceiver: aReceiver [ 
	| ast |
	ast := (CHInterpretable >> aSymbol) ast.
	^ interpreter execute: ast withReceiver: aReceiver
]

{ #category : #tests }
CHInterpreterTest >> interpreter [ 
	^ interpreter
]

{ #category : #running }
CHInterpreterTest >> setUp [
	super setUp.
	receiver := CHInterpretable new.
	interpreter := CHInterpreter new.
]

{ #category : #tests }
CHInterpreterTest >> testAssignmentReturnsAssignedValue [
	"Assignment returns the assigned value by default"
	self 
		assert: (self executeSelector: #store100IntoX)
		equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testReturnBoolean [ 
	"Do not use deny: to make explicite the expectation of the value false"
	self 
		assert: (self executeSelector: #returnBoolean)
		equals: false
]

{ #category : #tests }
CHInterpreterTest >> testReturnEmptyLiteralArray [
	self
		assert: (self executeSelector: #returnEmptyLiteralArray)
		equals: #()
]

{ #category : #tests }
CHInterpreterTest >> testReturnFloat [
	self 
		assert: (self executeSelector: #returnFloat)
		equals: 3.14
]

{ #category : #tests }
CHInterpreterTest >> testReturnGlobal [ 
	| globalObject |
	globalObject := Object new.
	interpreter globalEnvironmentAt: #Global put: globalObject.
	self 
		assert: (self executeSelector: #returnGlobal) 
		equals: globalObject
]

{ #category : #tests }
CHInterpreterTest >> testReturnInstanceVariableRead [ 
	receiver x: 100.
	self 
		assert: (self executeSelector: #returnX)
		equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testReturnInteger [
	self 
		assert: (self executeSelector: #returnInteger)
		equals: 5
]

{ #category : #tests }
CHInterpreterTest >> testReturnRecursiveLiteralArray [
	self
		assert: (self executeSelector: #returnRecursiveLiteralArray)
		equals: #(true 1 #('haha'))
]

{ #category : #tests }
CHInterpreterTest >> testReturnSelf [
	self 
		assert: (self executeSelector: #returnSelf)
		equals: receiver
]

{ #category : #tests }
CHInterpreterTest >> testReturnSuper [
	self 
		assert: (self executeSelector: #returnSuper)
		equals: receiver
]

{ #category : #tests }
CHInterpreterTest >> testStore100IntoX [ 
	receiver x: 17. "Initial value"
	self executeSelector: #store100IntoX.
	self assert: receiver x equals: 100.
]
