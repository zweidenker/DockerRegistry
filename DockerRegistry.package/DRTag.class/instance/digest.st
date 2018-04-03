accessing
digest
	^ digest ifNil: [ 
		digest := self resolveDigest ]