IMPORT Business_Risk_BIP, BIPV2, SALT28;

// This function takes in a dataset of Layouts.Input and appends the various BIP Link ID's
// NOTE: This function will NOT take only a SeleID as input and process it successfully.

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
	
	BIPSearchInput := PROJECT(Input, prepBIPInput(LEFT));

  append := bipv2.IdAppendRoxie(BIPSearchInput
    ,scoreThreshold := Options.BIPAppend_ScoreThreshold
		,weightThreshold := Options.BipAppend_WeightThreshold
		,primForce := Options.BIPAppend_primForce // Set to true if you only want matches where there is no mismatch on prim_range. 
		                    // Setting to true will likely lower recall but may improve precision.
		,reAppend := true  // If you already have BIP ids on your input and don't want to look them up again, you can set this to false.
		,allowInvalidResults := FALSE //Options.BIPAppend_AllowInvalidResults
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
		SELF.Weight := LEFT.SeleWeight;  // For the new BIP-append function, use the SeleWeight as "Weight".
    SELF := []));

	// Attempt to pick the "Best" ID's.  This is done by keeping the record which hits on the first of these rules:
	Business_Risk_BIP.Layouts.LinkID_Results setBestIDs(Business_Risk_BIP.Layouts.Input le, tempLinkingRecord ri) := TRANSFORM
    SELF.seq := le.seq;
		SELF.PowID	:= if( ri.SeleID = 0, ROW({0,		0,		0,	0}, Business_Risk_BIP.Layouts.LinkIDs) ,ROW({ri.PowID,		ri.PowIDWeight,		ri.PowIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs));
		SELF.ProxID	:= if( ri.SeleID = 0, ROW({0,		0,		0,	0}, Business_Risk_BIP.Layouts.LinkIDs) ,ROW({ri.ProxID,		ri.ProxIDWeight,		ri.ProxIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs));
		SELF.SeleID	:= if( ri.SeleID = 0, ROW({0,		0,		0,	0}, Business_Risk_BIP.Layouts.LinkIDs) ,ROW({ri.SeleID,		ri.SeleIDWeight,		ri.SeleIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs));
		SELF.OrgID	:= if( ri.SeleID = 0, ROW({0,		0,		0,	0}, Business_Risk_BIP.Layouts.LinkIDs) ,ROW({ri.OrgID,		ri.OrgIDWeight,		ri.OrgIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs));
		SELF.UltID	:= if( ri.SeleID = 0, ROW({0,		0,		0,	0}, Business_Risk_BIP.Layouts.LinkIDs) ,ROW({ri.UltID,		ri.UltIDWeight,		ri.UltIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs));
		SELF.Weight := if( ri.SeleID = 0, 0, ri.Weight);
    SELF := [];
	END;
	
  finalBIPIDsAppended := JOIN(Input, SlimLinkIDsRaw, LEFT.Seq = RIGHT.Seq, setBestIDs(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
	RETURN finalBIPIDsAppended;
END;


