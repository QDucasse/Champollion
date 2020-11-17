Class {
	#name : #CHInterpretable,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'Champollion-Tests'
}

{ #category : #'value creation' }
CHInterpretable >> returnBoolean [
	^ false 
	
]

{ #category : #'value creation' }
CHInterpretable >> returnEmptyLiteralArray [ 
	^ #()
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
