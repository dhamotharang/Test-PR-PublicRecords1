/* ************************************************************************
 * This function searches the Targus PDE Gateway.	  											*
 * -This gateway is only searched if the access rules are met             *
 * -There is a cost associated with use of this gateway									  *
 * -- As of 6-13-2013 Cost: 1-500k $0.08, 500k-1m $0.06, 1-1.5m $0.05,    *
 *                          1.5m+ $0.04                                   *
 * -Address, Name :: Source: PDE																					*
 * Adapted from Risk_Indicators.getTargusGW                               *
 ************************************************************************ */

IMPORT Gateway, Phone_Shell, RiskWise, Targus, STD, ut;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Gateway_Targus (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, DATASET(Gateway.Layouts.Config) Gateways, UNSIGNED1 DPPAPurpose, UNSIGNED1 GLBPurpose, UNSIGNED1 PhoneRestrictionMask) := FUNCTION

    applyOptOut := TRUE; // Temporary variable to enable Targus opt out

	targusURL := Gateways (STD.Str.ToLowerCase(servicename) = 'targus')[1].url;

	Targus.layout_targus_in prep_for_Targus(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.User.GLBPurpose := GLBPurpose;
		SELF.User.DLPurpose := DPPAPurpose;
		SELF.User.QueryID := (STRING)le.Clean_Input.seq;
		SELF.SearchBy.ConsumerName.Fname := TRIM(le.Clean_Input.FirstName);
		SELF.SearchBy.ConsumerName.Middle := TRIM(le.Clean_Input.MiddleName);
		SELF.SearchBy.ConsumerName.Lname := TRIM(le.Clean_Input.LastName);
		SELF.SearchBy.PhoneNumber := IF(TRIM(le.Clean_Input.HomePhone) <> '', le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone);
		SELF.SearchBy.Address.StreetNumber := TRIM(le.Clean_Input.Prim_Range);
		SELF.SearchBy.Address.StreetPreDirection := TRIM(le.Clean_Input.Predir);
		SELF.SearchBy.Address.StreetName := TRIM(le.Clean_Input.Prim_Name);
		SELF.SearchBy.Address.StreetSuffix := TRIM(le.Clean_Input.Addr_Suffix);
		SELF.SearchBy.Address.StreetPostDirection := TRIM(le.Clean_Input.Postdir);
		SELF.SearchBy.Address.UnitDesignation := TRIM(le.Clean_Input.Unit_Desig);
		SELF.SearchBy.Address.UnitNumber := TRIM(le.Clean_Input.Sec_Range);
		SELF.SearchBy.Address.StreetAddress1 := '';
		SELF.SearchBy.Address.StreetAddress2 := '';
		SELF.SearchBy.Address.City := le.Clean_Input.City;
		SELF.SearchBy.Address.State := le.Clean_Input.State;
		SELF.SearchBy.Address.Zip5 := le.Clean_Input.Zip5;
		SELF.SearchBy.Address.Zip4 := le.Clean_Input.Zip4;
		SELF.Options.VerifyExpressOptions.IncludeMatchedOrCorrectedPhone := TRUE; // We want to find a phone number, when TRUE this will allow us to "search" for a phone number based on Name/Address
		SELF.Options.VerifyExpressOptions.IncludeMatchedName := TRUE; // We want to see who the phone returned belongs to.  It could either be the subject, household, or lead to subject
		SELF.Options.VerifyExpressOptions.IncludeMatchedPrimaryAddress := TRUE;
		SELF.Options.VerifyExpressOptions.IncludeMatchedCityName := TRUE;
		SELF.Options.VerifyExpressOptions.IncludeMatchedState := TRUE;
		SELF.Options.VerifyExpressOptions.IncludeMatchedCorrectedZIPCode := TRUE;
		SELF := [];
	END;
	// Only run the records which have TARGUS Gateway Enabled and have First/Last Name and a Cleaned StreetAddress, City, State, Zip5
	TargusClean := Input (Clean_Input.TargusGatewayEnabled = TRUE AND
															Clean_Input.FirstName <> '' AND Clean_Input.LastName <> '' AND
															Clean_Input.StreetAddress1 <> '' AND Clean_Input.City <> '' AND
															Clean_Input.State <> '' AND Clean_Input.Zip5 <> '');
	Targus_in := PROJECT(TargusClean, prep_for_Targus(LEFT));

	timeoutSecs := 2;	// 2 Seconds
	numRetries := 0;	// Don't retry because of SLA's
  gw_mod_access := Gateway.IParam.GetGatewayModAccess(GLBPurpose, DPPAPurpose);

	// Don't call the Gateway unless the Gateway URL is populated
	// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie 
  // ever decides to execute both sides of the IF statement.
  targus_cfg := gateways(Gateway.Configuration.IsTargus(servicename))[1];
	makeGatewayCall := targus_cfg.url != '' AND EXISTS(targus_in);
	gateway_result := IF(makeGatewayCall, 
                       Gateway.SoapCall_Targus(targus_in, targus_cfg, timeoutSecs, numRetries, makeGatewayCall, gw_mod_access, applyOptOut), 
                       DATASET([], targus.layout_targus_out));

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getTargus(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Targus.layout_targus_out ri) := transform
		phone := TRIM(ri.response.VerifyExpressResult.EnhancedData.Phone);
		
		hitPDE := ri.response.VerifyExpressResult.ErrorCode = 0 AND phone <> '';
		
		fullName := STD.Str.ToUpperCase(TRIM(ri.response.VerifyExpressResult.EnhancedData.Name));
		fname := fullName[1..(STD.Str.Find(fullName, ',', 1) - 1)];
		lname := fullName[(STD.Str.Find(fullName, ',', 1) + 1)..];
		streetAddr := STD.Str.ToUpperCase(TRIM(ri.response.VerifyExpressResult.EnhancedData.PrimaryAddress));
		cty := STD.Str.ToUpperCase(TRIM(ri.response.VerifyExpressResult.EnhancedData.CityName));
		st := STD.Str.ToUpperCase(TRIM(ri.response.VerifyExpressResult.EnhancedData.State));
		zip := TRIM(ri.response.VerifyExpressResult.EnhancedData.ZIPCode)[1..5];
		
		SElf.Gathered_Phone := IF(hitPDE, phone, '');
		
		matchCode := IF(hitPDE, Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																																	fname, 										lname, 										streetAddr, 									'',						 							'',						 						'',						 							cty,								St,										Zip,						 			'',												 '',							   0, 			phone), '');
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, lname, isGatewayResult := TRUE), 'PDE', '');
		
		// This data doesn't have first seen/last seen dates, so use todays date just like the "Input" phones																																																							 
		SELF.Sources.Source_List_First_Seen := IF(hitPDE, Phone_Shell.Common.parseDate((STRING)UT.GetDate), '');
		SELF.Sources.Source_List_Last_Seen := IF(hitPDE, Phone_Shell.Common.parseDate((STRING)UT.GetDate), '');

		SELF.Sources.Source_Owner_Name_First := fname;
		SELF.Sources.Source_Owner_Name_Last := lname;
		
		didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
		nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
		addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
		ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;
		
		 // Subject since this includes a match on full name, household if it includes a match on address, otherwise just a lead to the subject
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := IF(hitPDE, 	MAP(nameMatch => Phone_Shell.Constants.Phone_Subject_Level.Subject,
																																					addrMatch => Phone_Shell.Constants.Phone_Subject_Level.Household,
																																											Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject),
																																			0);
																																			
		
		PhoneSubjTitle := MAP(nameMatch				=> 'Subject', 
													addrMatch				=> 'Subject at Household',
													ssnMatch				=> 'Associate By SSN',
																							'Associate'
													);
																															
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := IF(hitPDE, PhoneSubjTitle, '');

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := IF(hitPDE, matchCode, '');
		
		// Only charge the Royalty if we got a response from the gateway
		SELF.Royalties.TargusComprehensive_Royalty := IF(hitPDE, 1, 0);
		
		SELF := le;
	END;
	
	resultTemp := JOIN(Input, gateway_result, LEFT.Clean_Input.seq = (UNSIGNED)RIGHT.response.Header.QueryId, getTargus(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
	
	result := resultTemp (TRIM(Gathered_Phone) <> '' AND TRIM(Sources.Source_List) <> '');
	
	final := DEDUP(SORT(result, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	// Debugging Outputs
	// OUTPUT(TargusURL, NAMED('TargusURL'));
	// OUTPUT(CHOOSEN(Input, 100), NAMED('TargusRawInput'));
	// OUTPUT(CHOOSEN(TargusClean, 100), NAMED('TargusClean'));
	// OUTPUT(CHOOSEN(Targus_in, 100), NAMED('Targus_in'));
	// OUTPUT(CHOOSEN(gateway_result, 100), NAMED('TargusGateway_Result'));
	// OUTPUT(CHOOSEN(resultTemp, 100), NAMED('TargusResultTemp'));
	// OUTPUT(CHOOSEN(result, 100), NAMED('TargusResult'));
	// OUTPUT(CHOOSEN(final, 100), NAMED('TargusFinal'));
	
	RETURN(final);
END;