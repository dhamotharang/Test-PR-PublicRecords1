IMPORT Business_Risk_BIP, BIPV2, SALT28;

// This function takes in a dataset of Layouts.Input and appends the various BIP Link ID's

EXPORT BIP_LinkID_Append (DATASET(Business_Risk_BIP.Layouts.Input) Input, BOOLEAN ForceAppend = FALSE, BOOLEAN DoNotUseAuthRepInBIPAppend = FALSE) := FUNCTION
	
  // If we aren't forcing the append process, pull out the records on input that have the BIP ID fields populated, use those BIP IDs
	UseInputBIPIDs := IF(ForceAppend = FALSE, Input (PowID > 0 AND ProxID > 0 AND SeleID > 0 AND OrgID > 0 AND UltID > 0), DATASET([], Business_Risk_BIP.Layouts.Input));
	
  // If we aren't forcing the append process, pull out the records on input that don't have the BIP ID fields all populated, append new BIP IDs
	AppendBIPIDs := IF(ForceAppend = FALSE, Input (PowID = 0 OR ProxID = 0 OR SeleID = 0 OR OrgID = 0 OR UltID = 0), Input);

	// Prepare the BIP Append input - These should be clean coming in
	BIPV2.IDFunctions.rec_SearchInput prepBIPInput(Business_Risk_BIP.Layouts.Input le, BOOLEAN useAlt) := TRANSFORM
		SELF.company_name := IF(useAlt = FALSE, le.CompanyName, le.AltCompanyName);
		SELF.prim_range := le.Prim_Range;
		SELF.prim_name := le.Prim_Name;
		SELF.zip5 := le.Zip5;
		SELF.sec_range := le.Sec_Range;
		SELF.city := le.City;
		SELF.state := le.State;
		SELF.phone10 := le.Phone10;
		SELF.fein := le.FEIN;
		SELF.URL := le.CompanyURL;
		SELF.Email := le.Rep_Email;
		SELF.Contact_fname := IF( DoNotUseAuthRepInBIPAppend, '', le.Rep_FirstName );
		SELF.Contact_mname := IF( DoNotUseAuthRepInBIPAppend, '', le.Rep_MiddleName );
		SELF.Contact_lname := IF( DoNotUseAuthRepInBIPAppend, '', le.Rep_LastName );
		SELF.contact_ssn := IF( DoNotUseAuthRepInBIPAppend, '', le.Rep_SSN );
		SELF.contact_did := IF( DoNotUseAuthRepInBIPAppend, 0, le.Rep_LexID );
		SELF.acctno := (STRING)le.Seq; // Use the AcctNo field to merge back to the original Seq number
		// Everything below is default values
		SELF.zip_radius_miles := 0;
		SELF.sic_code := ''; // Filter results by Sic_Code (Filter results out) - Blank returns all records
		SELF.results_limit := 0; // Limit the number of results - 0 returns all possible results
		SELF.inSeleid := ''; // Specific SeleID to search for - 0 does default searching
		SELF.allow7DigitMatch := FALSE; // Allows for 7 digit match on Phone10
		SELF.HSort := FALSE;
	END;
  
	// Check to see if there was a unique AltCompanyName entered as well - attempt to use that for linking in case the primary company name finds nothing
	AlsoSearchFor := AppendBIPIDs (AltCompanyName NOT IN ['', CompanyName]);

	BIPSearchInputMain := PROJECT(AppendBIPIDs, prepBIPInput(LEFT, FALSE));
	
	BIPSearchInputAlt := PROJECT(AlsoSearchFor, prepBIPInput(LEFT, TRUE));
	
	BIPSearchInput := BIPSearchInputMain + BIPSearchInputAlt;

	// Fetch all Link IDs.  This is a non-restricted source search.
	// LinkIDsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIPSearchInput).Data2_;
	//LinkIDsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIPSearchInput).UnsuppressedData2_;
	LinkIDData := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIPSearchInput);
	LinkIDsRawData := LinkIDData.uid_results_w_acct;
	LinkID_Layout := RECORDOF(LinkIDData.UnsuppressedData2_);

	LinkIDsRaw := PROJECT(LinkIDsRawData, TRANSFORM(LinkID_Layout, SELF := LEFT, SELF := []));
	
	// Get all of the Unique ID's as well as their record source counts
	UniquePowIDs	:= SORT(TABLE(LinkIDsRaw, {UNSIGNED4 Seq := (UNSIGNED)AcctNo, SALT28.UIDType LinkID := PowID, INTEGER2 Weight := PowWeight, UNSIGNED2 Score := PowScore, UNSIGNED4 LinkCount := COUNT(GROUP)}, AcctNo, PowID, PowWeight, PowScore, FEW) (LinkID <> 0), Seq -Score, -Weight, -LinkCount, LinkID, FEW);
	UniqueProxIDs	:= SORT(TABLE(LinkIDsRaw, {UNSIGNED4 Seq := (UNSIGNED)AcctNo, SALT28.UIDType LinkID := ProxID, INTEGER2 Weight := ProxWeight, UNSIGNED2 Score := ProxScore, UNSIGNED4 LinkCount := COUNT(GROUP)}, AcctNo, ProxID, ProxWeight, ProxScore, FEW) (LinkID <> 0), Seq -Score, -Weight, -LinkCount, LinkID, FEW);
	UniqueSeleIDs	:= SORT(TABLE(LinkIDsRaw, {UNSIGNED4 Seq := (UNSIGNED)AcctNo, SALT28.UIDType LinkID := SeleID, INTEGER2 Weight := SeleWeight, UNSIGNED2 Score := SeleScore, UNSIGNED4 LinkCount := COUNT(GROUP)}, AcctNo, SeleID, SeleWeight, SeleScore, FEW) (LinkID <> 0), Seq -Score, -Weight, -LinkCount, LinkID, FEW);
	UniqueOrgIDs	:= SORT(TABLE(LinkIDsRaw, {UNSIGNED4 Seq := (UNSIGNED)AcctNo, SALT28.UIDType LinkID := OrgID, INTEGER2 Weight := OrgWeight, UNSIGNED2 Score := OrgScore, UNSIGNED4 LinkCount := COUNT(GROUP)}, AcctNo, OrgID, OrgWeight, OrgScore, FEW) (LinkID <> 0), Seq -Score, -Weight, -LinkCount, LinkID, FEW);
	UniqueUltIDs	:= SORT(TABLE(LinkIDsRaw, {UNSIGNED4 Seq := (UNSIGNED)AcctNo, SALT28.UIDType LinkID := UltID, INTEGER2 Weight := UltWeight, UNSIGNED2 Score := UltScore, UNSIGNED4 LinkCount := COUNT(GROUP)}, AcctNo, UltID, UltWeight, UltScore, FEW) (LinkID <> 0), Seq -Score, -Weight, -LinkCount, LinkID, FEW);
	UniqueCompanyNames := SORT(TABLE(LinkIDsRaw, {UNSIGNED4 Seq := (UNSIGNED)AcctNo, STRING250 Name := CNP_Name, UNSIGNED4 LinkCount := COUNT(GROUP)}, AcctNo, CNP_Name, FEW) (TRIM(Name) <> ''), Seq -LinkCount, Name, FEW);

	// Place the TABLES above into a dataset layout so that we can rollup the Uniqe Link ID's by Seq
	tempIDsLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LinkIDs) Links;
	END;
	tempIDsLayout cleanLinks(RECORDOF(UniqueUltIDs) le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.Links := DATASET([{le.LinkID, le.Weight, le.Score, le.LinkCount}], Business_Risk_BIP.Layouts.LinkIDs);
	END;
	cleanedPowIDs := PROJECT(UniquePowIDs, cleanLinks(LEFT));
	cleanedProxIDs := PROJECT(UniqueProxIDs, cleanLinks(LEFT));
	cleanedSeleIDs := PROJECT(UniqueSeleIDs, cleanLinks(LEFT));
	cleanedOrgIDs := PROJECT(UniqueOrgIDs, cleanLinks(LEFT));
	cleanedUltIDs := PROJECT(UniqueUltIDs, cleanLinks(LEFT));
	
	tempNamesLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.CompanyNames) Names;
	END;
  
	tempNamesLayout cleanNames(RECORDOF(UniqueCompanyNames) le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.Names := DATASET([{le.Name, le.LinkCount}], Business_Risk_BIP.Layouts.CompanyNames);
	END;
  
	cleanedCompanyNames := PROJECT(UniqueCompanyNames, cleanNames(LEFT));
	
	// Rollup our Unique Link ID's by Seq so that we can combine everything by Seq below
	rolledPowIDs := ROLLUP(cleanedPowIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempIDsLayout, SELF.Links := LEFT.Links + RIGHT.Links; SELF := LEFT));
	rolledProxIDs := ROLLUP(cleanedProxIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempIDsLayout, SELF.Links := LEFT.Links + RIGHT.Links; SELF := LEFT));
	rolledSeleIDs := ROLLUP(cleanedSeleIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempIDsLayout, SELF.Links := LEFT.Links + RIGHT.Links; SELF := LEFT));
	rolledOrgIDs := ROLLUP(cleanedOrgIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempIDsLayout, SELF.Links := LEFT.Links + RIGHT.Links; SELF := LEFT));
	rolledUltIDs := ROLLUP(cleanedUltIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempIDsLayout, SELF.Links := LEFT.Links + RIGHT.Links; SELF := LEFT));
	rolledCompanyNames := ROLLUP(cleanedCompanyNames, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempNamesLayout, SELF.Names := LEFT.Names + RIGHT.Names; SELF := LEFT));
	
	// Now that we have the Unique IDs with counts, JOIN everything together
	withPowIDs := JOIN(AppendBIPIDs, rolledPowIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results,
																																			SELF.Seq := LEFT.Seq;
																																			SELF.PowIDs := RIGHT.Links;
																																			SELF := []), // For the first JOIN to our Input we need to blank out the other sets just in case an input Seq doesn't find Link IDs 
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
                          
	withProxIDs := JOIN(withPowIDs, rolledProxIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results,
																																			SELF.ProxIDs := RIGHT.Links;
																																			SELF := LEFT), 
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	withSeleIDs := JOIN(withProxIDs, rolledSeleIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results,
																																			SELF.SeleIDs := RIGHT.Links;
																																			SELF := LEFT), 
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
                          
	withOrgIDs := JOIN(withSeleIDs, rolledOrgIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results,
																																			SELF.OrgIDs := RIGHT.Links;
																																			SELF := LEFT), 
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
                          
	withUltIDs := JOIN(withOrgIDs, rolledUltIDs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results,
																																			SELF.UltIDs := RIGHT.Links;
																																			SELF := LEFT), 
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
                          
	withCompanyNames := JOIN(withUltIDs, rolledCompanyNames, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results,
																																			SELF.CompanyNames := RIGHT.Names;
																																			SELF := LEFT), 
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
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
	
	SlimLinkIDsRaw := PROJECT(LinkIDsRaw, TRANSFORM(tempLinkingRecord,
		SELF.Seq := (UNSIGNED)LEFT.AcctNo;
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
		SELF.Weight := LEFT.Weight;
		SELF.Company_Name := LEFT.Company_Name));

	
	
	// Attempt to pick the "Best" ID's.  This is done by keeping the record which hits on the first of these rules:
	// 1.) Highest overall weight
	// 2.) Highest Ult Weight/Score
	// 3.) Highest Org Weight/Score
	// 4.) Highest Sele Weight/Score
	// 5.) Highest Prox Weight/Score
	// 6.) Highest Pow Weight/Score
	// 7.) Lastly the lowest ID's to make this sort deterministic
	SortedLinkIDsRaw := SORT(SlimLinkIDsRaw, Seq, -Weight, UltID, OrgID, SeleID, ProxID, PowID);

	// Keep the first record per Seq
	RolledLinkIDsRaw := ROLLUP(SortedLinkIDsRaw, LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
	
	Business_Risk_BIP.Layouts.LinkID_Results setBestIDs(Business_Risk_BIP.Layouts.LinkID_Results le, tempLinkingRecord ri) := TRANSFORM
		SELF.PowID	:= ROW({ri.PowID,		ri.PowIDWeight,		ri.PowIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.ProxID	:= ROW({ri.ProxID,	ri.ProxIDWeight,	ri.ProxIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.SeleID	:= ROW({ri.SeleID,	ri.SeleIDWeight,	ri.SeleIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.OrgID	:= ROW({ri.OrgID,		ri.OrgIDWeight,		ri.OrgIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.UltID	:= ROW({ri.UltID,		ri.UltIDWeight,		ri.UltIDScore,	0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.CompanyName := ROW({ri.Company_Name, 0}, Business_Risk_BIP.Layouts.CompanyNames);
		SELF.Weight := ri.weight;
		SELF.BIPIDSourceInput := FALSE; // We used the BIP ID append process for these, not the input BIP IDs
		
		SELF := le;
	END;
  
	finalBIPIDsAppended := JOIN(withCompanyNames, RolledLinkIDsRaw, LEFT.Seq = RIGHT.Seq, setBestIDs(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
	Business_Risk_BIP.Layouts.LinkID_Results setInputIDs(UseInputBIPIDs le) := TRANSFORM
		SELF.Seq := le.Seq;
		
		SELF.BIPIDSourceInput := TRUE; // We used the input IDs for these BIP ID's - they are now candidates for the "Best Information ADL Append"
		
		SELF.PowIDs := DATASET([{le.PowID, 0, 0, 0}], Business_Risk_BIP.Layouts.LinkIDs);
		SELF.ProxIDs := DATASET([{le.ProxID, 0, 0, 0}], Business_Risk_BIP.Layouts.LinkIDs);
		SELF.SeleIDs := DATASET([{le.SeleID, 0, 0, 0}], Business_Risk_BIP.Layouts.LinkIDs);
		SELF.OrgIDs := DATASET([{le.OrgID, 0, 0, 0}], Business_Risk_BIP.Layouts.LinkIDs);
		SELF.UltIDs := DATASET([{le.UltID, 0, 0, 0}], Business_Risk_BIP.Layouts.LinkIDs);
		SELF.CompanyNames := DATASET([{le.CompanyName, 0}], Business_Risk_BIP.Layouts.CompanyNames);
		
		SELF.PowID := ROW({le.PowID, 0, 0, 0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.ProxID := ROW({le.ProxID, 0, 0, 0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.SeleID := ROW({le.SeleID, 0, 0, 0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.OrgID := ROW({le.OrgID, 0, 0, 0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.UltID := ROW({le.UltID, 0, 0, 0}, Business_Risk_BIP.Layouts.LinkIDs);
		SELF.Weight := 100;
		SELF.CompanyName := ROW({le.CompanyName, 0}, Business_Risk_BIP.Layouts.CompanyNames);
	END;
	finalInputBIPIDs := PROJECT(UseInputBIPIDs, setInputIDs(LEFT));
	
	FinalResults := SORT((finalBIPIDsAppended + finalInputBIPIDs), Seq);
	
	// *****************
	// Debugging Outputs
	// *****************
	// OUTPUT(CHOOSEN(BIPSearchInput, 100), NAMED('Sample_BIP_Input_Dataset'));
	// OUTPUT(CHOOSEN(LinkIDsRaw, 100), NAMED('Sample_BIP_Raw_Link_IDs'));
	// OUTPUT(CHOOSEN(withCompanyNames, 100), NAMED('Sample_Appended_Link_IDs'));
	// OUTPUT(CHOOSEN(finalResults, 100), NAMED('Sample_finalResults'));
	// *****************
	
	RETURN(FinalResults);
  
END;