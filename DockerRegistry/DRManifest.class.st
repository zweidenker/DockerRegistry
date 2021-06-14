Class {
	#name : #DRManifest,
	#superclass : #Object,
	#instVars : [
		'digest',
		'layers'
	],
	#category : #DockerRegistry
}

{ #category : #accessing }
DRManifest >> completeSize [
	^ layers sum: #size
]

{ #category : #accessing }
DRManifest >> digest [
	^ digest
]

{ #category : #initialization }
DRManifest >> initializeFromJson: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
DRManifest >> initializeFromResponse: response [ 
	| json |
	digest := response headers at: 'Docker-Content-Digest'.
	json := NeoJSONReader fromString: response contents.
	layers := (json at: 'layers') collect: [ :dict |
		DRLayer new 
			digest: (dict at: 'digest');
			size: (dict at: 'size') ]
]
