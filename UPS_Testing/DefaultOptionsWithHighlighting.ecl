IMPORT iesp;

SearchOpts := iesp.rightaddress.t_RightAddressSearchOptions;

UseVals := RECORD
	TYPEOF(SearchOpts.StrictMatch)      StrictMatch := false;
	TYPEOF(SearchOpts.MaxResults)       MaxResults := 100;
	TYPEOF(SearchOpts.UseNickNames)     UseNickNames := true;
	TYPEOF(SearchOpts.IncludeAlsoFound) IncludeAlsoFound := false;
	TYPEOF(SearchOpts.UsePhonetics)     UsePhonetics  := true;
	TYPEOF(SearchOpts.PenaltyThreshold) PenaltyThreshold := 50;
	TYPEOF(SearchOpts.ReturnCount)      ReturnCount := 20;
	TYPEOF(SearchOpts.StartingRecord)   StartingRecord := 1;
	TYPEOF(SearchOpts.highlight)        Highlight := true;
END;	

SearchOpts MyTransform(UseVals L) := TRANSFORM
	SELF := L;
	self := [];
END;

EmptyOption := ROW(UseVals);
export DefaultOptionsWithHighlighting := PROJECT(EmptyOption, MyTransform(LEFT));
