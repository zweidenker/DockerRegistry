Class {
	#name : #DockerRegistry,
	#superclass : #Object,
	#instVars : [
		'url',
		'username',
		'password',
		'repositories'
	],
	#classInstVars : [
		'current'
	],
	#category : #DockerRegistry
}

{ #category : #accessing }
DockerRegistry class >> current [
	^ current ifNil: [ 
		current := self new ]
]

{ #category : #initialization }
DockerRegistry class >> reset [ 
	current := nil
]

{ #category : #'instance creation' }
DockerRegistry class >> url: url username: username password: password [
	^ self current
		url: url;
		username: username;
		password: password
]

{ #category : #accessing }
DockerRegistry >> buildRepositories [
	^ (self catalog at: 'repositories') collect: [ :each |
		DRRepository new
			registry: self;
			name: each  ]
]

{ #category : #'as yet unclassified' }
DockerRegistry >> catalog [
	^ NeoJSONReader fromString: (self get: url / '_catalog') 
]

{ #category : #public }
DockerRegistry >> delete: aUri [ 
	^ ZnClient new
		setBasicAuthenticationUsername: username password: password; 
		url: aUri;
		delete;
		response
]

{ #category : #'as yet unclassified' }
DockerRegistry >> get: aUrl [ 
	| response |
	response := ZnClient new
		setBasicAuthenticationUsername: username password: password; 
		url: aUrl ;
		get;
		response.
	response isSuccess ifFalse: [ 
		Error signal: 'no success' ].
	^ response contents
]

{ #category : #'as yet unclassified' }
DockerRegistry >> get: aUrl headers: aDictionary [
	| client |
	client := ZnClient new.
	aDictionary keysAndValuesDo: [ :key :value |
		client headerAt: key put: value ].
	^ client
		setBasicAuthenticationUsername: username password: password; 
		url: aUrl ;
		get;
		response
]

{ #category : #accessing }
DockerRegistry >> password: aString [ 
	password := aString
]

{ #category : #accessing }
DockerRegistry >> repositories [
	^ repositories ifNil: [ 
		repositories := self buildRepositories ]
]

{ #category : #'as yet unclassified' }
DockerRegistry >> repositoryNamed: aString [ 
	^ self repositories 
		detect: [ :each | each name = aString ]
		
]

{ #category : #resetting }
DockerRegistry >> reset [
	repositories := nil
]

{ #category : #'as yet unclassified' }
DockerRegistry >> url [
	^ url
]

{ #category : #accessing }
DockerRegistry >> url: aString [ 
	url := aString asZnUrl 
]

{ #category : #accessing }
DockerRegistry >> username: aString [ 
	username := aString
]
