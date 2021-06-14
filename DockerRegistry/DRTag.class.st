Class {
	#name : #DRTag,
	#superclass : #Object,
	#instVars : [
		'repository',
		'name',
		'digest',
		'size'
	],
	#category : #DockerRegistry
}

{ #category : #accessing }
DRTag >> completeSize [ 
	^ self manifest completeSize
]

{ #category : #'submorphs-add/remove' }
DRTag >> delete [
	^ [ self registry
		delete: self manifestUri ]
		on: Error do: [ :err | "ignore" ]
]

{ #category : #accessing }
DRTag >> digest [
	^ self manifest digest
]

{ #category : #accessing }
DRTag >> fetchManifest [
	| res |
	res := self registry 
		get: self manifestUri
		headers: {  
			'Accept' -> 'application/vnd.docker.distribution.manifest.v2+json' } asDictionary.
	res isSuccess ifFalse: [ 
		Error signal: 'no success' ].
	^ DRManifest new initializeFromResponse: res
]

{ #category : #accessing }
DRTag >> manifest [ 
	^ self fetchManifest 
]

{ #category : #'as yet unclassified' }
DRTag >> manifestUri [
	^ repository url / #manifests / name 
]

{ #category : #accessing }
DRTag >> name [
	^ name
]

{ #category : #accessing }
DRTag >> name: aString [ 
	name := aString
]

{ #category : #printing }
DRTag >> printOn: aStream [
	repository printOn: aStream.
	aStream << '/' << name.
	size ifNotNil: [ 
		aStream << '(' << size asString << ')' ]
]

{ #category : #accessing }
DRTag >> registry [
	^ repository registry
]

{ #category : #accessing }
DRTag >> repository [
	^ repository
]

{ #category : #accessing }
DRTag >> repository: anObject [
	repository := anObject
]

{ #category : #accessing }
DRTag >> resolveDigest [
	| res |
	res := self registry 
		get: self manifestUri
		headers: {  
			'Accept' -> 'application/vnd.docker.distribution.manifest.v2+json' } asDictionary.
	res isSuccess ifFalse: [ 
		Error signal: 'no success' ].
	^ res headers at: 'Docker-Content-Digest'
]

{ #category : #accessing }
DRTag >> size [ 
	^ size ifNil: [ 
		size := self completeSize ]
]
