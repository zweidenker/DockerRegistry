as yet unclassified
get: aUrl 
	^ ZnClient new
		setBasicAuthenticationUsername: username password: password; 
		url: aUrl ;
		get