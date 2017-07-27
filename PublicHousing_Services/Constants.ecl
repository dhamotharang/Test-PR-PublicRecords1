EXPORT Constants := MODULE

	export Defaults := module
		export integer MaxResults          := 2000;
		export integer MaxResultsPerAcctno := 20;
		export integer DIDScoreThreshold   := 80;
	end;
	
	export Limits := module
		export integer MAX_JOIN_LIMIT := 1000;
	end;
	
	export AlphaNumericOnlyChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
	
END;