/* ************************************************************************
 * This function searches the TransUnion Contact Verification Gateway.	  *
 * -This gateway is only searched if the access rules are met             *
 * -There is a cost associated with use of this gateway									  *
 * -- As of 6-13-2013 Cost: $0.04 for iQ411								                *
 * iQ411 :: Source: TU																										*
 * Adapted from Doxie_Raw/RealTimePhones_Raw															*
 ************************************************************************ */

IMPORT IESP, Gateway, Phone_Shell, RiskWise, UT, STD;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Gateway_TransUnion (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, DATASET(Gateway.Layouts.Config) Gateways, UNSIGNED1 DPPAPurpose, UNSIGNED1 GLBPurpose, STRING30 VerticalMarket, STRING2 SPIIAccessLevel, UNSIGNED1 PhoneRestrictionMask, STRING50 DataRestrictionMask) := FUNCTION
	// Don't run the Gateway if the Market is Receivables Management, the SPII Access Level isn't 5A or 5B, and make sure the GLB Permissible Purpose is for Fraud Prevention
	GatewayCallOK :=	StringLib.StringToUpperCase(TRIM(VerticalMarket)) <> 'RECEIVABLES MANAGEMENT' AND
										StringLib.StringToUpperCase(TRIM(SPIIAccessLevel)) IN ['5A', '5B'] AND
										GLBPurpose = RiskWise.permittedUse.fraudGLBA;

	IESP.gateway_qsent.t_QSentCISSearchRequest prepTransunionSearch(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.SearchBy.BusinessName := IF(le.Clean_Input.TransUnionGatewayEnabled, '', 'DONTRUN');
		SELF.SearchBy.FirstName := le.Clean_Input.FirstName;
		SELF.SearchBy.LastName := le.Clean_Input.LastName;
		SELF.SearchBy.StreetAddress := TRIM(le.Clean_Input.StreetAddress1 + ' ' + le.Clean_Input.StreetAddress2);
		SELF.SearchBy.City := le.Clean_Input.City;
		// If State isn't populated use the ALL option of the gateway
		SELF.SearchBy.State := IF(TRIM(le.Clean_Input.State) <> '', le.Clean_Input.State, 'ALL');
		SELF.SearchBy.SSN := le.Clean_Input.SSN;
		SELF.SearchBy.Zip5 := le.Clean_Input.Zip5;
 		SELF.SearchBy.Zip4 := le.Clean_Input.Zip4;
		// Since we are searching for a phone number we don't have a phone number to pass in
		SELF.SearchBy.phone.phoneNpa := '';
		SELF.SearchBy.phone.phoneNXX := '';
		SELF.SearchBy.phone.phoneLine := '';
		// In case a nickname was used on input search for similar first/last names - if the exact name is found that will be returned first
		SELF.SearchBy.UseSimilarFirstNames := TRUE;
		SELF.SearchBy.UseSimilarLastNames := TRUE;
		// Don't exclude any phones
		SELF.SearchBy.ExcludedPhones := DATASET([], iesp.share.t_StringArrayItem);
		// NonPublished phones are blanked out - we don't want those
		SELF.Options.ShowNonPublished := FALSE;
		// Return both Business and Residential phones
		SELF.Options.QueryType := 'BR';
		// Return indicators of various match levels
		SELF.Options.Match := TRUE;
		// Use TransUnions Smart Search to find the number
		SELF.Options.IntelligentSearch := TRUE;
		// Sort the results by Score ('S').  You can also sort by Alphabetical ('A')
		SELF.Options.MatchSortCode := 'S';
		// Return the best matching phone
		SELF.Options.ResultCount := 1;
		// Only iQ411 allows us to search for phone numbers.  PVS REQUIRES a phone number on input...
		SELF.Options.ServiceType := 'iQ411';
		SELF.Options.RequestCredential := IF(TRIM(DataRestrictionMask[9]) = '', '0', DataRestrictionMask[9]); // Use DataRestrictionMask.RequestCredential logic
			
		SELF.User.GLBPurpose := (STRING)GLBPurpose;
		SELF.User.DLPurpose := (STRING)DPPAPurpose;
		// Save this so that we can tie the Gateway results back to the Input
		SELF.User.QueryID := (STRING)le.Clean_Input.seq;
			
		SELF.SearchBy := [];
		SELF.Options := [];
		SELF.User := [];
		SELF := [];			
	END;
	iQ411InputTemp := PROJECT(Input, prepTransunionSearch(LEFT));
	// Drop the records which either didn't have the Gateway enabled (BusinessName = DONTRUN) or don't have enough input information to find a result
	// Minimum search criteria: First/Last Name and Address OR Last Name and SSN
	iQ411Input := iQ411InputTemp (TRIM(SearchBy.BusinessName) <> 'DONTRUN' AND 
																((TRIM(SearchBy.FirstName) <> '' AND TRIM(SearchBy.LastName) <> '' AND 
																TRIM(SearchBy.StreetAddress) <> '' AND TRIM(SearchBy.City) <> '' AND TRIM(SearchBy.State) <> '' AND TRIM(SearchBy.Zip5) <> '') OR
																(TRIM(SearchBy.LastName) <> '' AND TRIM(SearchBy.SSN) <> '')));
	
	makeGatewayCall := GatewayCallOK AND EXISTS(iQ411Input);
	
	timeoutSecs := 2; // 2 second gateway timeout
	numRetries := 0; // Don't retry because of SLAs
	
	gatewayResults := IF(makeGatewayCall, Gateway.SoapCall_QSentV2(iQ411Input, Gateways (Gateway.Configuration.isQsentV2(servicename))[1], timeoutSecs, numRetries, makeGatewayCall),
																				DATASET([], iesp.gateway_qsent.t_QSentCISSearchResponseEx));
																				
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus parseGateway(iesp.gateway_qsent.t_QSentCIsSearchResponseEx le) := TRANSFORM
		SELF.Clean_Input.seq := (INTEGER)le.response._Header.QueryID;
		// Use these fields to help determine the match codes
		fname := StringLib.StringToUpperCase(TRIM(le.response.ContactResults[1].ContactInfo.Name.First));
		lname := StringLib.StringToUpperCase(TRIM(le.response.ContactResults[1].ContactInfo.Name.Last));
		
		SELF.Clean_Input.FirstName := fname;
		SELF.Clean_Input.LastName := lname;
		
		SELF.Clean_Input.StreetAddress1 := StringLib.StringToUpperCase(TRIM(le.response.ContactResults[1].ContactInfo.GeoAddress.Address.StreetAddress1));
		SELF.Clean_Input.City := StringLib.StringToUpperCase(TRIM(le.response.ContactResults[1].ContactInfo.GeoAddress.Address.City));
		SELF.Clean_Input.State := StringLib.StringToUpperCase(TRIM(le.response.ContactResults[1].ContactInfo.GeoAddress.Address.State));
		SELF.Clean_Input.Zip5 := StringLib.StringToUpperCase(TRIM(le.response.ContactResults[1].ContactInfo.GeoAddress.Address.Zip5[1..5]));
		
		SELF.Gathered_Phone := TRIM(le.response.ContactResults[1].ContactInfo.PhoneInfo.Phone);
		
		SELF.Sources.Source_List := 'TU';
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate(TRIM((STRING)le.response.ContactResults[1].DataSourceInfo.CreationDate.Year) + 
																					 TRIM((STRING)le.response.ContactResults[1].DataSourceInfo.CreationDate.Month) +
																					 TRIM((STRING)le.response.ContactResults[1].DataSourceInfo.CreationDate.Day));
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((string) STD.Date.Today());
		
		SELF.Sources.Source_Owner_Name_First 	:= fname;
		SELF.Sources.Source_Owner_Name_Last		:=lname;
		
		// We hit the Gateway, we owe royalties.
		SELF.Royalties.QSentCIS_Royalty := 1;
		
		SELF := [];
	END;
	
	gatewayParsed := PROJECT(gatewayResults, parseGateway(LEFT));
	
	// The gateway might have errored or not found any phone numbers, in this case filter those records out
	goodResults := gatewayParsed (TRIM(Gathered_Phone) <> '');
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus combineInput(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
		SELF.Gathered_Phone := ri.Gathered_Phone;
		
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.Clean_Input.FirstName,	ri.Clean_Input.LastName, ri.Clean_Input.StreetAddress1, '',						 							'',						 						'',						 						 ri.Clean_Input.City,	ri.Clean_Input.State,	ri.Clean_Input.Zip5,	'',						 							'',						 		 0, 			ri.Gathered_Phone);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.Clean_Input.LastName, isGatewayResult := TRUE), ri.Sources.Source_List, '');
		
		SELF.Sources.Source_List_First_Seen := ri.Sources.Source_List_First_Seen;
		SELF.Sources.Source_List_Last_Seen := ri.Sources.Source_List_Last_Seen;
		SELF.Sources.Source_Owner_Name_First := ri.Sources.Source_Owner_Name_First;
		SELF.Sources.Source_Owner_Name_Last := ri.Sources.Source_Owner_Name_Last;
		
		// Since this is a Gateway search by full name/address or last name/ssn it should be for the Subject
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := Phone_Shell.Constants.Phone_Subject_Level.Subject;
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := 'Subject';

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;
		
		// If we hit the Gateway, we owe royalties.
		SELF.Royalties.QSentCIS_Royalty := ri.Royalties.QSentCIS_Royalty;
		
		SELF := le;
	END;

	result := JOIN(Input, goodResults, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq, combineInput(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost)) (TRIM(Gathered_Phone) <> '' AND TRIM(Sources.Source_List) <> '');
	
	final := DEDUP(SORT(result, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	// Debugging Outputs
	// OUTPUT(GatewayURL, NAMED('TUGatewayURL'));
	// OUTPUT(CHOOSEN(iQ411InputTemp, 100), NAMED('TUiQ411InputTemp'));
	// OUTPUT(CHOOSEN(iQ411Input, 100), NAMED('TUiQ411Input'));
	// OUTPUT(CHOOSEN(gatewayResults, 100), NAMED('TUgatewayResults'));
	// OUTPUT(CHOOSEN(gatewayParsed, 100), NAMED('TUgatewayParsed'));
	// OUTPUT(CHOOSEN(goodResults, 100), NAMED('TUgoodResults'));
	// OUTPUT(CHOOSEN(result, 100), NAMED('TUresult'));
	// OUTPUT(CHOOSEN(final, 100), NAMED('TUfinal'));
	
	RETURN(final);
END;