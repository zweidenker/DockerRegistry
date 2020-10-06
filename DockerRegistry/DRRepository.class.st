Class {
	#name : #DRRepository,
	#superclass : #Object,
	#instVars : [
		'registry',
		'name',
		'tags'
	],
	#category : #DockerRegistry
}

{ #category : #'instance creation' }
DRRepository class >> name: aString [
	^ self new
		name: aString
]

{ #category : #'as yet unclassified' }
DRRepository >> buildTags [
	| json |
	json := NeoJSONReader fromString: (registry get: self url / #tags / #list).
	^ (json at: 'tags') ifNotNil: [ :ts | 
		ts collect: [ :tagString |
			DRTag new
				repository: self;
				name: tagString ] ]
]

{ #category : #accessing }
DRRepository >> name [
	^ name
]

{ #category : #accessing }
DRRepository >> name: anObject [
	name := anObject
]

{ #category : #printing }
DRRepository >> printOn: aStream [
	aStream nextPutAll: name asString
]

{ #category : #accessing }
DRRepository >> registry [
	^ registry
]

{ #category : #accessing }
DRRepository >> registry: anObject [
	registry := anObject
]

{ #category : #'as yet unclassified' }
DRRepository >> repository: aDockerRegistry [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
DRRepository >> reset [
	tags := nil
]

{ #category : #accessing }
DRRepository >> tags [
	^ tags ifNil: [ 
		tags := self buildTags ]
]

{ #category : #'as yet unclassified' }
DRRepository >> url [
	^ registry url / name
]
