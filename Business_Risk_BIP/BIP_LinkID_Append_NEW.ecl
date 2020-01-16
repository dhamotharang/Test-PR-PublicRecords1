IMPORT Business_Risk_BIP, BIPV2, SALT28, Address, Risk_Indicators;

// This function takes in a dataset of Layouts.Input and appends the various BIP Link ID's

EXPORT BIP_LinkID_Append_NEW(DATASET(Business_Risk_BIP.Layouts.Input) Input, 
																		 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
                                     BIPV2.mod_sources.iParams linkingOptions
					) := FUNCTION

	// Prepare the BIP Append input - These should be clean coming in
	bipv2.idappendlayouts.AppendInput prepBIPInput(Business_Risk_BIP.Layouts.Input le) := TRANSFORM
    SELF.request_id := le.Seq;
    SELF.company_name := le.CompanyName;
    SELF.prim_range := le.Prim_Range;
    SELF.prim_name := le.Prim_Name;
    SELF.sec_range := le.Sec_Range;
    SELF.city := le.City;
    SELF.state := le.State;
    SELF.zip5 := le.Zip5;
    SELF.zip_radius_miles := 0;
    SELF.phone10 := le.Phone10;
    SELF.fein := le.FEIN;
    SELF.url := le.CompanyURL;
    SELF.email := le.Rep_Email;
    SELF.contact_fname := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_FirstName );
    SELF.contact_mname := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_MiddleName );
    SELF.contact_lname := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_LastName );
    SELF.contact_ssn := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_SSN );
    SELF.contact_did := IF( Options.DoNotUseAuthRepInBIPAppend, 0, le.Rep_LexID );
    // SELF.sic_code := ;
    // SELF.source := ;
    // SELF.source_record_id := ;
    SELF.proxid := le.ProxID;
    SELF.seleid := le.SeleID;
    SELF := [];  
 END; 
  
  CntSeleID := COUNT(Input(SeleID <> 0));   // AND CompanyName = '' AND City = '' AND State = ''));
        
  AppendBestsFromLexIDs := CntSeleid > 0;

	BIPSearchInputMain := PROJECT(Input, prepBIPInput(LEFT));
	    
  BIPSearchInput := IF(AppendBestsFromLexIDs, Business_Risk_BIP.BIP_Append_FromSeleid(Input, Options, linkingOptions), BIPSearchInputMain);
  
	// BIPSearchInput := BIPSearchInputMain;

  append := bipv2.IdAppendRoxie(BIPSearchInput
    ,scoreThreshold := Options.BIPAppend_ScoreThreshold
		,weightThreshold := Options.BipAppend_WeightThreshold
		,primForce := Options.BIPAppend_primForce // Set to true if you only want matches where there is no mismatch on prim_range. 
		                    // Setting to true will likely lower recall but may improve precision.
		,reAppend := true  // If you already have BIP ids on your input and don't want to look them up again, you can set this to false.
		,allowInvalidResults := FALSE //Options.BIPAppend_AllowInvalidResults
  );

  withBest := append.WithBest(
		fetchLevel := BIPV2.IdConstants.fetch_level_seleid,
		allBest := true,
    isMarketing := IF(Options.MarketingMode = 1, TRUE, FALSE)
  );
  
  idsOnly := append.IdsOnly(); 
  
	tempLinkingRecord := RECORD
		UNSIGNED4 Seq;
		SALT28.UIDType UltID;
		INTEGER2 UltIDWeight;
		UNSIGNED2 UltIDScore;
		SALT28.UIDType OrgID;
		INTEGER2 OrgIDWeight;
		UNSIGNED2 OrgIDScore;
		SALT28.UIDType SeleID;
		INTEGER2 SeleIDWeight;
		UNSIGNED2 SeleIDScore;
		SALT28.UIDType ProxID;
		INTEGER2 ProxIDWeight;
		UNSIGNED2 ProxIDScore;
		SALT28.UIDType PowID;
		INTEGER2 PowIDWeight;
		UNSIGNED2 PowIDScore;
		INTEGER2 Weight;
		STRING120 Company_Name;
	END;
	
	SlimLinkIDsRaw := PROJECT(idsOnly, TRANSFORM(tempLinkingRecord,
		SELF.Seq := (UNSIGNED)LEFT.request_id;
		SELF.UltID := LEFT.UltID;
		SELF.UltIDWeight := LEFT.UltWeight;
		SELF.UltIDScore := LEFT.UltScore;
		SELF.OrgID := LEFT.OrgID;
		SELF.OrgIDWeight := LEFT.OrgWeight;
		SELF.OrgIDScore := LEFT.OrgScore;
		SELF.SeleID := LEFT.SeleID;
		SELF.SeleIDWeight := LEFT.SeleWeight;
		SELF.SeleIDScore := LEFT.SeleScore;
		SELF.ProxID := LEFT.ProxID;
		SELF.ProxIDWeight := LEFT.ProxWeight;
		SELF.ProxIDScore := LEFT.ProxScore;
		SELF.PowID := LEFT.PowID;
		SELF.PowIDWeight := LEFT.PowWeight;
		SELF.PowIDScore := LEFT.PowScore;
    SELF := []));

	// Attempt to pick the "Best" ID's.  This is done by keeping the record which hits on the first of these rules:
	Business_Risk_BIP.Layouts.LinkID_Results setBestIDs(Business_Risk_BIP.Layouts.Input le, tempLinkingRecord ri) := TRANSFORM
    SELF.seq := le.seq;
		SELF.PowID	:= ROW({ri.PowID,		ri.PowIDWeight,		ri.PowIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.ProxID	:= ROW({ri.ProxID,	ri.ProxIDWeight,	ri.ProxIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.SeleID	:= ROW({ri.SeleID,	ri.SeleIDWeight,	ri.SeleIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.OrgID	:= ROW({ri.OrgID,		ri.OrgIDWeight,		ri.OrgIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.UltID	:= ROW({ri.UltID,		ri.UltIDWeight,		ri.UltIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
    SELF := [];
	END;
	
  finalBIPIDsAppended := JOIN(Input, SlimLinkIDsRaw, LEFT.Seq = RIGHT.Seq, setBestIDs(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
  
  withCompanyName := JOIN(finalBIPIDsAppended, withBest, LEFT.seq = RIGHT.request_id,
       TRANSFORM( Business_Risk_BIP.Layouts.Shell,
       
              SELF.Seq := RIGHT.request_id;

              SELF.BIP_IDs := LEFT;
              SELF.UltIDWeight := LEFT.UltID.Weight;
              SELF.UltIDScore := LEFT.UltID.Score;
              SELF.OrgIDWeight := LEFT.OrgID.Weight;
              SELF.OrgIDScore := LEFT.OrgID.Score;
              SELF.SeleIDWeight := LEFT.SeleID.Weight;
              SELF.SeleIDScore := left.SeleID.Score;
              SELF.ProxIDWeight := LEFT.ProxID.Weight;
              SELF.ProxIDScore := LEFT.ProxID.Score;
              SELF.PowIDWeight := LEFT.PowID.Weight;
              SELF.PowIDScore := LEFT.PowID.Score;
              
              SELF.Clean_Input.StreetAddress1 := 	Risk_Indicators.MOD_AddressClean.street_address('', RIGHT.Prim_Range, RIGHT.Predir, RIGHT.Prim_Name, 
																											RIGHT.Addr_Suffix, RIGHT.Postdir, RIGHT.Unit_Desig, RIGHT.Sec_Range);

              SELF.Clean_Input.companyname := RIGHT.company_name;
              SELF.Clean_Input.city := RIGHT.v_city_name;
              SELF.Clean_Input.state := RIGHT.st;
              SELF.Clean_Input.zip := RIGHT.zip;
              SELF.Clean_Input.phone10 := RIGHT.company_phone;
              SELF.Clean_Input.Prim_Range := RIGHT.Prim_Range;
              SELF.Clean_Input.Prim_Name := RIGHT.Prim_Name;
              SELF.Clean_Input.Addr_Suffix := RIGHT.Addr_Suffix;

              SELF.Clean_Input.Predir := RIGHT.Predir;
              SELF.Clean_Input.FEIN := RIGHT.company_fein;
              SELF.Clean_Input.Postdir := RIGHT.Postdir;
              SELF.Clean_Input.Unit_Desig := RIGHT.Unit_Desig;
              SELF.Clean_Input.Sec_Range := RIGHT.Sec_Range;
              
              SELF := LEFT;
              SELF := [];
              ),
					LEFT OUTER, KEEP(1), ATMOST(100), FEW);
          
  // FinalResults := SORT((finalBIPIDsAppended), Seq);
  FinalResults := SORT((withCompanyName), Seq);
   
  // OUTPUT(Input,NAMED('NEW_Append_Input'));
  // OUTPUT(withBest, NAMED('withBest'));
  // OUTPUT(withBest_Acct, NAMED('withBest_Acct'));
  // OUTPUT(withBest_Acct[1], NAMED('withBest_Acct_firstRec'));
  // OUTPUT(withCompanyName, NAMED('withRecords'));
  // OUTPUT(FinalResults, NAMED('FinalResults'));
  // OUTPUT(withBestDeDupped , NAMED('withBestDeDupped '));
  // OUTPUT(AppendBestsFromLexIDs, NAMED('AppendBestsFromLexIDs'));
  
  // OUTPUT(idsOnly,NAMED('idsOnly'));
  // OUTPUT(BIPSearchInput,NAMED('BIPSearchInput'));
  // OUTPUT(BIPSearchInputMain,NAMED('BIPSearchInputMain'));
  
	RETURN(FinalResults);
   
END;


