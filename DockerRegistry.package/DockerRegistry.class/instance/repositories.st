accessing
repositories
	^ (self catalog at: 'repositories') collect: [ :each |
		DRRepository new
			registry: self;
			name: each  ]