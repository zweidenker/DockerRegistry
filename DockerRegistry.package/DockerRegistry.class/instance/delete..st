public
delete: aUri 
	^ ZnClient new
		setBasicAuthenticationUsername: username password: password; 
		url: aUri;
		delete;
		response