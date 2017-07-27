import iesp, doxie_crs,risk_indicators , DriversV2_Services, DeaV2_Services;

extra_fields := record
	string3 SubjectSSNCount := '';
	string20 verDL := '';
	string8 deceasedDate := '';
	string8 deceasedDOB := '';
	string15 deceasedFirst := '';
	string20 deceasedLast := '';
	dataset(risk_indicators.layouts.layout_watchlists_plus_seq) watchlists {maxcount(7)};	
	string1 passportValidated := '';
	string1 dobmatchlevel := '';  //KWH - CIV - this field is now included in the iesp layout so need to add it to extra fields here so it is not duplicated
end;

export Layout_Identifier2 := record,MAXLENGTH(50000)
	risk_indicators.Layout_InstandID_NuGen - extra_fields;
	iesp.mod_identifier2.t_Identifier2Result - Models;

	unsigned1 DIDCount := 0;	// - The total number of DID’s found	
	unsigned6 DID2 := 0;	// - The second DID returned from the DID Append
	unsigned6 DID3 := 0;	// - The third DID returned from the DID Append
	// Address Risk Fields
	BOOLEAN ADVODoNotDeliver := false;
	STRING1 ADVODropIndicator := '';
	BOOLEAN ADVOAddressVacancyIndicator := false;
	STRING1 ADVOResidentialOrBusinessInd := '';
	BOOLEAN USPISHotList := false;
	STRING8 Sic_Code := '';
end;
