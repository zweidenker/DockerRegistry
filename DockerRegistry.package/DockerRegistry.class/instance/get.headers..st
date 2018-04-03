as yet unclassified
get: aUrl headers: aDictionary
	| client |
	client := ZnClient new.
	aDictionary keysAndValuesDo: [ :key :value |
		client headerAt: key put: value ].
	^ client
		setBasicAuthenticationUsername: username password: password; 
		url: aUrl ;
		get;
		response