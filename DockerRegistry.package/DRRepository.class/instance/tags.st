accessing
tags
	^ tags ifNil: [ 
		tags := self buildTags ]