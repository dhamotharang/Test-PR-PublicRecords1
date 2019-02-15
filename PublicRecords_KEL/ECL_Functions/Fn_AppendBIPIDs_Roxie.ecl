IMPORT BIPV2, PublicRecords_KEL;

EXPORT Fn_AppendBIPIDs_Roxie(
							DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
							DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Rep1Input,
							PublicRecords_KEL.Interface_Options Options
							) := FUNCTION

	// Prepare the BIP Append input - These should be clean coming in
	BIPV2.IDAppendLayouts.AppendInput PrepBIPInput(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII le, PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII ri) := TRANSFORM
    SELF.request_id := le.BusInputUIDAppend;
    SELF.company_name := le.BusInputNameClean;
    SELF.prim_range := le.BusInputPrimRangeClean;
    SELF.prim_name := le.BusInputPrimNameClean;
    SELF.sec_range := le.BusInputSecRangeClean;
    SELF.city := le.BusInputCityClean;
    SELF.state := le.BusInputStateClean;
    SELF.zip5 := le.BusInputZip5Clean;
    SELF.phone10 := le.BusInputPhoneClean;
    SELF.fein := le.BusInputTINClean;
    SELF.email := le.BusInputEmailClean;
    SELF.contact_fname := IF(Options.BIPAppendIncludeAuthRep, ri.InputFirstNameClean, '');
    SELF.contact_mname := IF(Options.BIPAppendIncludeAuthRep, ri.InputMiddleNameClean, '');
    SELF.contact_lname := IF(Options.BIPAppendIncludeAuthRep, ri.InputLastNameClean, '');
    SELF.contact_ssn := IF(Options.BIPAppendIncludeAuthRep, ri.InputSSNClean, '');
    SELF.contact_did := IF(Options.BIPAppendIncludeAuthRep, ri.LexIDAppend, 0);
    SELF.proxid := le.InputLexIDBusPlaceGroupEcho;
    SELF.seleid := le.InputLexIDBusLegalEntityEcho;
		
		SELF.url := '';
		SELF.zip_radius_miles := 0;
		SELF.sic_code := '';
    SELF.source := '';
    SELF.source_record_id := 0;
		
 END; 
  
	BIPSearchInput := JOIN(BusinessInput, Rep1Input, LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend,
		PrepBIPInput(LEFT, RIGHT), LEFT OUTER, ATMOST(100), KEEP(1));
		
  Append := BIPV2.IdAppendRoxie(BIPSearchInput,
		scoreThreshold := Options.BIPAppendScoreThreshold,
		weightThreshold := Options.BIPAppendWeightThreshold,
		primForce := Options.BIPAppendPrimForce, // Set to true if you only want matches where there is no mismatch on prim_range. 
																						// Setting to true will likely lower recall but may improve precision.
		reAppend := Options.BIPAppendReAppend  // If you already have BIP ids on your input and don't want to look them up again, you can set this to false.
  );
  
  IDsOnly := Append.IdsOnly()(SeleScore >= Options.BIPAppendScoreThreshold AND SeleWeight >= Options.BIPAppendWeightThreshold); 
	
	BIPAppendResults := JOIN(BusinessInput, idsOnly, LEFT.BusInputUIDAppend = RIGHT.Request_ID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII,
			SELF.LexIDBusExtendedFamilyAppend := RIGHT.UltID;
			SELF.LexIDBusLegalFamilyAppend := RIGHT.OrgID;
			SELF.LexIDBusLegalEntityAppend := RIGHT.SeleID;
			SELF.LexIDBusPlaceGroupAppend := RIGHT.ProxID;
			SELF.LexIDBusPlaceAppend := RIGHT.PowID;
			SELF.BusLexIDScoreAppend := RIGHT.SeleScore;
			SELF.BusLexIDWeightAppend := RIGHT.SeleWeight;
			SELF := LEFT), 
		LEFT OUTER, ATMOST(100), KEEP(1));

	RETURN BIPAppendResults;

END;