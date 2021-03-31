IMPORT BIPV2, PublicRecords_KEL;

EXPORT Fn_AppendBIPIDs_Roxie(
							DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
							DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) Rep1Input,
							PublicRecords_KEL.Interface_Options Options
							) := FUNCTION

	// Prepare the BIP Append input - These should be clean coming in
	BIPV2.IDAppendLayouts.AppendInput PrepBIPInput(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII le, PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII ri) := TRANSFORM
    SELF.request_id := le.G_ProcBusUID;
    SELF.company_name := le.B_InpClnName;
    SELF.prim_range := le.B_InpClnAddrPrimRng;
    SELF.prim_name := le.B_InpClnAddrPrimName;
    SELF.sec_range := le.B_InpClnAddrSecRng;
    SELF.city := le.B_InpClnAddrCity;
    SELF.state := le.B_InpClnAddrState;
    SELF.zip5 := le.B_InpClnAddrZip5;
    SELF.phone10 := le.B_InpClnPhone;
    SELF.fein := le.B_InpClnTIN;
    SELF.email := le.B_InpClnEmail;
    SELF.contact_fname := IF(Options.BIPAppendIncludeAuthRep, ri.P_InpClnNameFirst, '');
    SELF.contact_mname := IF(Options.BIPAppendIncludeAuthRep, ri.P_InpClnNameMid, '');
    SELF.contact_lname := IF(Options.BIPAppendIncludeAuthRep, ri.P_InpClnNameLast, '');
    SELF.contact_ssn := IF(Options.BIPAppendIncludeAuthRep, ri.P_InpClnSSN, '');
    SELF.contact_did := IF(Options.BIPAppendIncludeAuthRep, ri.P_LexID, 0);
    SELF.proxid := le.B_InpLexIDSite;
    SELF.seleid := le.B_InpLexIDLegal;
		
		SELF.url := '';
		SELF.zip_radius_miles := 0;
		SELF.sic_code := '';
    SELF.source := '';
    SELF.source_record_id := 0;
		
 END; 
  
	BIPSearchInput := JOIN(BusinessInput, Rep1Input, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		PrepBIPInput(LEFT, RIGHT), LEFT OUTER, ATMOST(100), KEEP(1));
		
  Append := BIPV2.IdAppendRoxie(BIPSearchInput,
		                            scoreThreshold := Options.BIPAppendScoreThreshold,
		                            weightThreshold := Options.BIPAppendWeightThreshold,
		                            primForce := Options.BIPAppendPrimForce, // Set to true if you only want matches where there is no mismatch on prim_range. 
																						// Setting to true will likely lower recall but may improve precision.
	                            	reAppend := Options.BIPAppendReAppend  // If you already have BIP ids on your input and don't want to look them up again, you can set this to false.
  );
  
  allids := Append.IdsOnly();
  IDsOnly := Append.IdsOnly()(SeleScore >= Options.BIPAppendScoreThreshold AND SeleWeight >= Options.BIPAppendWeightThreshold); 
  
	
	BIPAppendResults := JOIN(BusinessInput, idsOnly, LEFT.G_ProcBusUID = RIGHT.Request_ID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII,
			SELF.B_LexIDUlt := RIGHT.UltID;
			SELF.B_LexIDOrg := RIGHT.OrgID;
			SELF.B_LexIDLegal := RIGHT.SeleID;
			SELF.B_LexIDSite := RIGHT.PowID;
			SELF.B_LexIDLoc := RIGHT.ProxID;
			SELF.B_LexIDLegalScore := RIGHT.SeleScore;
			SELF.B_LexIDLegalWgt := RIGHT.SeleWeight;
			SELF := LEFT), 
		LEFT OUTER, ATMOST(100), KEEP(1));

  // OUTPUT(allids,NAMED('allids'));
  // OUTPUT(IdsOnly,NAMED('IdsOnly'));
  // OUTPUT(BIPAppendResults,NAMED('BIPAppendResults'));

	RETURN BIPAppendResults;

END;
