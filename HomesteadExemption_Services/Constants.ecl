EXPORT Constants := MODULE

	export Defaults := module
		export integer MaxResults          := 2000;
		export integer MaxResultsPerAcctno := 20;
		export integer DIDScoreThreshold   := 89;
	end;
	
	export Limits := module
		export integer MAX_JOIN_LIMIT := 1000;
	end;
	
	export Death := module
		export string YES         := 'Y';
		export string NO          := 'N';
		export string CONDITIONAL := 'C';
		export string SSN_MATCH   := 'S';
		export string NAME_MATCH  := 'N';
	end;
	
	export AlphaNumericOnlyChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
	
END;