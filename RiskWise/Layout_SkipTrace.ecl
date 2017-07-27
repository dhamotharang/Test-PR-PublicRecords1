import risk_indicators;

export Layout_SkipTrace := record
	risk_indicators.layout_input;
	// these are the 5 fields from sure contact that we need to re-create on roxie for the legacy recover scores
	string1 addr_type_a := '';
	string1 addr_confidence_a := '';
	string1 phone_type_a := '';
	// these are fields that infoTrace legacy products will output
	string1 bansmatchflag := '';
     string12 banscasenum := '';
     string2 bansprcode := '';
     string2 bansdispcode := '';
     string8 bansdatefiled := '';
     string15 bansfirst := '';
     string15 bansmiddle := '';
     string20 banslast := '';
     string30 banscnty := '';
     string1 bansecoaflag := '';
     string1 decsflag := '';
     string8 decsdob := '';
     string5 decszip := '';
     string5 decszip2 := '';
     string20 decslast := '';
     string15 decsfirst := '';
     string8 decsdod := '';
end;