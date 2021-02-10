IMPORT Business_Risk_BIP, BIPV2, Business_Risk, Risk_Indicators, SALT28, UT, Doxie, STD;

EXPORT getBusinessByFEIN(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

  mod_access := PROJECT(Options, doxie.IDataAccess);

	tempVerificationLayout := RECORD
		UNSIGNED4 Seq,
		SALT28.UIDType UltID;
		SALT28.UIDType OrgID;
		SALT28.UIDType SeleID;
		UNSIGNED InputElementEntityCount;
		UNSIGNED InputElementEntityCount24Mos;
		UNSIGNED InputElementEntityCount12Mos;
		UNSIGNED InputElementEntityCount06Mos;
		UNSIGNED InputElementEntityCount03Mos;
		UNSIGNED InputElementEntityCount01Mos;
		STRING2 FEINOnFile;
		STRING2 FEINBusinessMatchLevel;
		STRING2 FEINAddrNameMatchLevel;
	END;

	// ------- Get FEIN Matches across all businesses ------------- //
	For_FEIN_Search := PROJECT(Shell, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
				SELF.acctno := (string)LEFT.Seq,
				SELF.FEIN := LEFT.Clean_Input.FEIN,
				SELF := []));

	FEIN_results_w_acct := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(For_FEIN_Search).uid_results_w_acct,
																			TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID := (UNSIGNED)LEFT.acctno,
																								SELF.UltID := LEFT.UltID,
																								SELF.OrgID := LEFT.OrgID,
																								SELF.SeleID := LEFT.SeleID,
																								SELF.ProxID := LEFT.ProxID,
																								SELF.PowID := LEFT.PowID,
																								SELF := []));


	UniqueRawFEINMatches := DEDUP(SORT(FEIN_results_w_acct, UniqueID, UltID, OrgID, SeleID, ProxID, PowID),	UniqueID, UltID, OrgID, SeleID, ProxID, PowID);


	BusinessHeaderRaw1 := BIPV2.Key_BH_Linking_Ids.kFetch2(UniqueRawFEINMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.PowID), // Search at most restrictive level since we already know the full BIP ID set of the FEIN match
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses,
																							mod_access := mod_access);

	// clean up the business header before doing anything else
  Business_Risk_BIP.Common.mac_slim_header(BusinessHeaderRaw1, BusinessHeaderRaw);

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BusinessHeaderRaw, Shell, BusinessHeaderSeq);


	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeader := GROUP(Business_Risk_BIP.Common.FilterRecords(BusinessHeaderSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);

	tempVerificationLayout verifyFEINs(Shell le, BusinessHeader ri) := TRANSFORM
		BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
		TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, le.Clean_Input.HistoryDate);

		FEINInput 						 := le.Input_Echo.FEIN <> '';
		FEINMatched 					 := (INTEGER)ri.Company_FEIN > 0 AND le.Clean_Input.FEIN = ri.Company_FEIN;
		NoScoreValue					 := 255;
		BusinessNamePopulated  := TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Company_Name) <> '';
		BusinessNameMatchScore := IF(BusinessNamePopulated AND le.Clean_Input.CompanyName[1] = ri.Company_Name[1], Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Company_Name), NoScoreValue);
		BusinessNameMatched 	 := Risk_Indicators.iid_constants.g(BusinessNameMatchScore);

		AddressPopulated 			 := TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		ZIPScore							 := IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		StateMatched					 := STD.Str.ToUpperCase(le.Clean_Input.State) = STD.Str.ToUpperCase(ri.st);
		CityStateScore				 := IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND StateMatched,
															Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched		 := AddressPopulated AND Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressScore 					 := MAP(NOT AddressPopulated 																														 => NoScoreValue,
																  AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue   => NoScoreValue,
																							Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																							ri.prim_range, ri.prim_name, ri.sec_range,
																							ZIPScore, CityStateScore));
		AddressMatched 				 := AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);

		BIPIDsMatched 				 := le.BIP_IDs.UltID.LinkID = ri.UltID AND
														  (le.BIP_IDs.OrgID.LinkID = ri.OrgID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltIDSet)) AND
															(le.BIP_IDs.SeleID.LinkID = ri.SeleID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgIDSet)) AND
															(le.BIP_IDs.ProxID.LinkID = ri.ProxID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgSeleIDSet)) AND
														  (le.BIP_IDs.PowID.LinkID = ri.PowID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgSeleProxIDSet));

		SELF.Seq 							 := le.Seq;
		SELF.UltID						 := ri.UltID;
		SELF.OrgID						 := ri.OrgID;
		SELF.SeleID						 := ri.SeleID;

		DaysApart := ut.DaysApart((STRING)ri.dt_last_seen, TodaysDate);
		SELF.InputElementEntityCount := IF(FEINInput AND FEINMatched, 1, 0);
		SELF.InputElementEntityCount24Mos := IF(FEINInput AND FEINMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= ut.DaysInNYears(2), 1, 0);
		SELF.InputElementEntityCount12Mos := IF(FEINInput AND FEINMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= ut.DaysInNYears(1), 1, 0);
		SELF.InputElementEntityCount06Mos := IF(FEINInput AND FEINMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.InputElementEntityCount03Mos := IF(FEINInput AND FEINMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
		SELF.InputElementEntityCount01Mos := IF(FEINInput AND FEINMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.OneMonth, 1, 0);


		SELF.FEINOnFile := MAP(NOT FEINInput 																															=> '-1', // FEIN not Input
													FEINInput AND NOT FEINMatched																								=> '0',	 // FEIN not found
													FEINInput AND FEINMatched 																									=> '1',	 // FEIN found on Business Header
																																																				 '0');

		SELF.FEINBusinessMatchLevel := MAP(NOT FEINInput 																									=> '-1', // FEIN not input
																			FEINInput AND NOT FEINMatched 																	=> '0',	 // Input FEIN not found in Business Header
																			FEINMatched AND NOT BIPIDsMatched 															=> '1',  // FEIN found with different BIP IDs from input business
																			FEINMatched AND BIPIDsMatched 																	=> '2',	 // FEIN found with same BIP IDs as input business
																																																				 '0');

		SELF.FEINAddrNameMatchLevel := MAP(NOT FEINInput 																									                                                  => '-1', // FEIN not Input
                                      Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND
                                       (TRIM(le.Clean_Input.CompanyName) = '' OR TRIM(le.Clean_Input.Prim_Name) = '' OR TRIM(le.Clean_Input.Zip5) = '') => '-1', // In version 3.0 and up, need name and address input to calculate
																			FEINInput AND NOT FEINMatched 																	                                                  => '0',	 // FEIN not found
																			FEINMatched AND NOT BusinessNameMatched AND NOT AddressMatched 	                                                  => '1',	 // FEIN found with different Name and Address
																			FEINMatched AND BusinessNameMatched AND NOT AddressMatched 			                                                  => '2',	 // FEIN found with matching Name and different Address
																			FEINMatched AND NOT BusinessNameMatched AND AddressMatched 			                                                  => '3',	 // FEIN found with different Name and mathcing Address
																			FEINMatched AND BusinessNameMatched AND AddressMatched 					                                                  => '4',	 // FEIN found with matching Name and Address
                                                                                                                                                           '0');
		//SELF := [];
	END;

	FEINVerification := JOIN(Shell, BusinessHeader, LEFT.Seq = RIGHT.Seq AND LEFT.Clean_Input.FEIN = RIGHT.Company_FEIN,
																	verifyFEINs(LEFT,RIGHT),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));

  // Sort most recent FEIN hits to the top so we count time buckets correctly.
  FEINVerificationSorted := SORT(FEINVerification, Seq, UltID, OrgID, SeleID, -InputElementEntityCount01Mos,-InputElementEntityCount03Mos,-InputElementEntityCount06Mos,-InputElementEntityCount12Mos,-InputElementEntityCount24Mos, -InputElementEntityCount);

  FEINVerificationRolled := ROLLUP(FEINVerificationSorted, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(tempVerificationLayout,
																							SELF.Seq := LEFT.Seq;
																							SELF.UltID := RIGHT.UltID;
																							SELF.OrgID := RIGHT.OrgID;
																							SELF.SeleID := RIGHT.SeleID;
																							SELF.InputElementEntityCount := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.InputElementEntityCount,
																																						LEFT.InputElementEntityCount + RIGHT.InputElementEntityCount);
																							SELF.InputElementEntityCount24Mos := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.InputElementEntityCount24Mos,
																																						LEFT.InputElementEntityCount24Mos + RIGHT.InputElementEntityCount24Mos);
																							SELF.InputElementEntityCount12Mos := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.InputElementEntityCount12Mos,
																																						LEFT.InputElementEntityCount12Mos + RIGHT.InputElementEntityCount12Mos);
																							SELF.InputElementEntityCount06Mos := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.InputElementEntityCount06Mos,
																																						LEFT.InputElementEntityCount06Mos + RIGHT.InputElementEntityCount06Mos);
																							SELF.InputElementEntityCount03Mos := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.InputElementEntityCount03Mos,
																																						LEFT.InputElementEntityCount03Mos + RIGHT.InputElementEntityCount03Mos);
																							SELF.InputElementEntityCount01Mos := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.InputElementEntityCount01Mos,
																																						LEFT.InputElementEntityCount01Mos + RIGHT.InputElementEntityCount01Mos);

																							SELF.FEINOnFile := (STRING)MAX((INTEGER)LEFT.FEINOnFile, (INTEGER)RIGHT.FEINOnFile);
																							SELF.FEINBusinessMatchLevel := (STRING)MAX((INTEGER)LEFT.FEINBusinessMatchLevel, (INTEGER)RIGHT.FEINBusinessMatchLevel);
																							SELF.FEINAddrNameMatchLevel := (STRING)MAX((INTEGER)LEFT.FEINAddrNameMatchLevel, (INTEGER)RIGHT.FEINAddrNameMatchLevel);
																							//SELF := []
																							));


	withFEINVerification := JOIN(Shell, FEINVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Input_Characteristics.InputTINEntityCount := IF(LEFT.Clean_Input.FEIN = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount, -1, 50));
																							SELF.Input_Characteristics.InputTINEntityCount24Mos := IF(LEFT.Clean_Input.FEIN = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount24Mos, -1, 50));
																							SELF.Input_Characteristics.InputTINEntityCount12Mos := IF(LEFT.Clean_Input.FEIN = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount12Mos, -1, 50));
																							SELF.Input_Characteristics.InputTINEntityCount06Mos := IF(LEFT.Clean_Input.FEIN = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount06Mos, -1, 50));
																							SELF.Input_Characteristics.InputTINEntityCount03Mos := IF(LEFT.Clean_Input.FEIN = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount03Mos, -1, 50));
																							SELF.Input_Characteristics.InputTINEntityCount01Mos := IF(LEFT.Clean_Input.FEIN = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount01Mos, -1, 50));

																							SELF.Verification.FEINOnFile := RIGHT.FEINOnFile;
																							SELF.Verification.FEINBusinessMismatch := MAP(RIGHT.FEINBusinessMatchLevel = '-1' => '-1', // FEIN not provided
																																														RIGHT.FEINBusinessMatchLevel = '0' => '0',	 // Input FEIN not found in Business Header
																																														RIGHT.FEINBusinessMatchLevel = '1' => '2',	 // FEIN found with different BIP IDs from input business
																																														RIGHT.FEINBusinessMatchLevel = '2' => '1',   // FEIN found with same BIP IDs as input business
																																																																	'0');

																							SELF.Verification.FEINAddrNameMismatch := MAP(RIGHT.FEINAddrNameMatchLevel = '-1' => '-1', // FEIN not Input
																																														RIGHT.FEINAddrNameMatchLevel = '0' => '0',	 // FEIN not found
																																														RIGHT.FEINAddrNameMatchLevel = '1' => '4',   // FEIN found with different Name and Address
																																														RIGHT.FEINAddrNameMatchLevel = '2' => '3',   // FEIN found with matching Name and different Address
																																														RIGHT.FEINAddrNameMatchLevel = '3' => '2',   // FEIN found with different Name and mathcing Address
																																														RIGHT.FEINAddrNameMatchLevel = '4' => '1',	 // FEIN found with matching Name and Address
																																																																	'0');
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(Shell, 100), NAMED('Sample_Shell'));
	// OUTPUT(CHOOSEN(RawFEINMatches, 100), NAMED('Sample_RawFEINMatches'));
	// OUTPUT(CHOOSEN(UniqueRawFEINMatches, 100), NAMED('Sample_UniqueRawFEINMatches'));
  // OUTPUT(CHOOSEN(BusinessHeaderRaw1,100),NAMED('BusinessHeaderRaw1'));
	// OUTPUT(CHOOSEN(BusinessHeaderRaw, 100), NAMED('Sample_BusinessHeaderRaw'));
	// OUTPUT(CHOOSEN(BusinessHeader, 100), NAMED('Sample_BusinessHeader'));
	// OUTPUT(CHOOSEN(FEINVerification, 100), NAMED('Sample_FEINVerification'));
	// OUTPUT(CHOOSEN(FEINVerificationRolled, 100), NAMED('Sample_FEINVerificationRolled'));
	// OUTPUT(CHOOSEN(withFEINVerification, 100), NAMED('Sample_withFEINVerification'));

	RETURN withFEINVerification;
END;
