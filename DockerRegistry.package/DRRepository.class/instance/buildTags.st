as yet unclassified
buildTags
	| json |
	json := NeoJSONReader fromString: (registry get: self url / #tags / #list).
	^ (json at: 'tags') collect: [ :tagString |
		DRTag new
			repository: self;
			name: tagString ] 