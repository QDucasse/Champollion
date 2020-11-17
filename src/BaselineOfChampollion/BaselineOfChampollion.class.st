Class {
	#name : #BaselineOfChampollion,
	#superclass : #BaselineOf,
	#category : #BaselineOfChampollion
}

{ #category : #baselines }
BaselineOfChampollion >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'ContainersStack' 
   			with: [ spec repository: 'github://pharo-containers/Containers-Stack:v1.0/src' ].
			
		spec package: 'Champollion-Core'.
		spec package: 'Champollion-Tests'.
		]
]
