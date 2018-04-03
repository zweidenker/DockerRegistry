as yet unclassified
repositoryNamed: aString 
	^ self repositories 
		detect: [ :each | each name = aString ]
		