Extension { #name : #RBVariableNode }

{ #category : #'*Champollion-Core' }
RBVariableNode >> store: anObject with: anInterpreter [ 
	anInterpreter receiver instVarNamed: name put: anObject
]
