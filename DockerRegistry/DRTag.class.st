Class {
	#name : #DRTag,
	#superclass : #Object,
	#instVars : [
		'repository',
		'name',
		'digest'
	],
	#category : 'DockerRegistry'
}

{ #category : #'submorphs-add/remove' }
DRTag >> delete [
	^ self registry
		delete: self manifestUri 
]

{ #category : #accessing }
DRTag >> digest [
	^ digest ifNil: [ 
		digest := self resolveDigest ]
]

{ #category : #'as yet unclassified' }
DRTag >> manifestUri [
	^ repository url / #manifests / self digest 
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
	aStream << '/' << name
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
		get: self tagUri
		headers: {  
			'Accept' -> 'application/vnd.docker.distribution.manifest.v2+json' } asDictionary.
	^ res headers at: 'Docker-Content-Digest'
]

{ #category : #'as yet unclassified' }
DRTag >> tagUri [
	^ repository url / #manifests / name 
]
