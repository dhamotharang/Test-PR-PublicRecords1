export Layout_InstantID_NuGenPlus := record,MAXLENGTH(50000)
	risk_indicators.Layout_InstandID_NuGen;
	// Removed socllowissue as it isn't being used within the Identifier2 product. And soclhighissue is the same field as ssa_date_last.
	UNSIGNED2 combo_dobcount := 0;
	UNSIGNED2 combo_ssncount := 0;
	UNSIGNED1 combo_ssnscore := 0;
	UNSIGNED2 combo_lastcount := 0;
	// field added strictly for FlexID
	STRING1 DLValid := '0';
	BOOLEAN SSNDeceased := false;
	string10 combo_prim_range := '';
	string28 combo_prim_name:= '';
	string8  combo_sec_range:= '';
	STRING25 combo_city := '';
	STRING2 combo_state := '';
	STRING5 combo_zip := '';
	
	unsigned1 DIDCount := 0;	// - The total number of DIDs found	
	unsigned6 DID2 := 0;	// - The second DID returned from the DID Append
	unsigned6 DID3 := 0;	// - The third DID returned from the DID Append
	
	// BOOLEAN addressIsPOBox := false; // for flex ID logic is 'PO' + '12' - this is now in layout nugen
	// BOOLEAN sicIsCMRA := false; // for flexID is hrisk sic in subset of CMRA codes - this is now in layout nugen
	// Address Risk Fields -- Added for Identifier 2 Enhancements
	BOOLEAN ADVODoNotDeliver := false;
	STRING1 ADVODropIndicator := '';
	BOOLEAN ADVOAddressVacancyIndicator := false;
	STRING1 ADVOResidentialOrBusinessInd := '';
	BOOLEAN USPISHotList := false;
	STRING8 Sic_Code := '';
	// new core identity verification fields
	UNSIGNED1  NameStreetAddressMatch := 0;
	UNSIGNED1  NameCityStateMatch := 0;
	UNSIGNED1  NameZipMatch := 0;
	UNSIGNED1  SSN5FullNameMatch := 0;
	
	STRING9 combo_ssn := '';
end;
