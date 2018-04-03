accessing
resolveDigest
	| res |
	res := self registry 
		get: self tagUri
		headers: {  
			'Accept' -> 'application/vnd.docker.distribution.manifest.v2+json' } asDictionary.
	^ res headers at: 'Docker-Content-Digest'