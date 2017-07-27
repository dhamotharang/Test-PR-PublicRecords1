export PickScore(unsigned6 selfdid, unsigned6 ledid, unsigned6 ridid, integer2 lescore, integer2 riscore) := 
	if(ledid = ridid,	//if within same did, then take higher score
		IF ( lescore < riscore, riscore, lescore ),
		if ( selfdid = ridid, 
			 riscore,   //or we unseated the left, so take the right
			 lescore));	//or we kept the left and dropped the right