as yet unclassified
catalog
	^ NeoJSONReader fromString: (self get: url / '_catalog')