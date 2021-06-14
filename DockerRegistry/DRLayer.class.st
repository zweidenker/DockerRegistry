Class {
	#name : #DRLayer,
	#superclass : #Object,
	#instVars : [
		'digest',
		'size'
	],
	#category : #DockerRegistry
}

{ #category : #accessing }
DRLayer >> digest: aString [ 
	digest := aString
]

{ #category : #accessing }
DRLayer >> size [
	^ size
]

{ #category : #accessing }
DRLayer >> size: anInteger [ 
	size := anInteger 
]
