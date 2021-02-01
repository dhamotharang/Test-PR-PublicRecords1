IMPORT Business_Risk_BIP, BIPV2, Risk_Indicators, SALT28, UT, Doxie, STD;

EXPORT getBusinessByAddress(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
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
		UNSIGNED OrgAddrLegalEntityCountActive;
		UNSIGNED OrgAddrLegalEntityCountInactive;
		UNSIGNED OrgAddrLegalEntityCountDefunct;
		// UNSIGNED InputAddrTINCount;
		BOOLEAN AddressMatched;
		UNSIGNED DateFirstSeen;
		STRING TodaysDate;
		STRING FEIN;
	END;

	// ------- Get Address Matches across all businesses ------------- //
	For_Address_Search := PROJECT(Shell, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
				SELF.acctno := (string)LEFT.Seq,
				SELF.prim_range := LEFT.Clean_Input.Prim_Range;
				SELF.prim_name := LEFT.Clean_Input.Prim_Name;
				SELF.zip5 := LEFT.Clean_Input.Zip5;
				SELF.sec_range := LEFT.Clean_Input.Sec_Range;
				SELF.city := LEFT.Clean_Input.City;
				SELF.state := LEFT.Clean_Input.State;
				SELF := []));

	Address_results_w_acct := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(For_Address_Search).uid_results_w_acct,
																			TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID := (UNSIGNED)LEFT.acctno,
																								SELF.UltID := LEFT.UltID,
																								SELF.OrgID := LEFT.OrgID,
																								SELF.SeleID := LEFT.SeleID,
																								SELF.ProxID := LEFT.ProxID,
																								SELF.PowID := LEFT.PowID,
																								SELF := []));


	UniqueRawAddressMatches := DEDUP(SORT(Address_results_w_acct, UniqueID, UltID, OrgID, SeleID, ProxID, PowID),	UniqueID, UltID, OrgID, SeleID, ProxID, PowID);


	BusinessHeaderRawAddress1 := BIPV2.Key_BH_Linking_Ids.kFetch2(UniqueRawAddressMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.Default), // Search at most restrictive level since we already know the full BIP ID set of the FEIN match
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses,
																							mod_access := mod_access);

	// clean up the business header before doing anything else
  Business_Risk_BIP.Common.mac_slim_header(BusinessHeaderRawAddress1, BusinessHeaderRawAddress);

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BusinessHeaderRawAddress, Shell, BusinessHeaderAddressSeq);


	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeaderAddress := GROUP(Business_Risk_BIP.Common.FilterRecords(BusinessHeaderAddressSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);


	tempVerificationLayout verifyAddresses(Shell le, BusinessHeaderAddress ri) := TRANSFORM
		BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
		TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, le.Clean_Input.HistoryDate);
		SELF.TodaysDate := TodaysDate;

		RawInputIDMatchStatus := MAP(Options.LinkSearchLevel = Business_Risk_BIP.Constants.LinkSearch.Default => ri.sele_seg,
												Options.LinkSearchLevel = Business_Risk_BIP.Constants.LinkSearch.PowID 	=> ri.pow_seg,
												Options.LinkSearchLevel = Business_Risk_BIP.Constants.LinkSearch.ProxID 	=> ri.prox_seg,
												Options.LinkSearchLevel = Business_Risk_BIP.Constants.LinkSearch.SeleID 	=> ri.sele_seg,
												Options.LinkSearchLevel = Business_Risk_BIP.Constants.LinkSearch.OrgID 	=> ri.org_seg,
												Options.LinkSearchLevel = Business_Risk_BIP.Constants.LinkSearch.UltID 	=> ri.ult_seg,
																																																						'0');

		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		NoScoreValue				:= 255; // This is what the various score functions return if blank is passed in
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		StateMatched				:= STD.Str.ToUpperCase(le.Clean_Input.State) = STD.Str.ToUpperCase(ri.st);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND StateMatched,
															Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= AddressPopulated AND Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);

		AddressScore := MAP(NOT AddressPopulated => NoScoreValue,
												AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue => NoScoreValue,
																																		Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																																		ri.prim_range, ri.prim_name, ri.sec_range,
																																		ZIPScore, CityStateScore));
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);
		SELF.AddressMatched := AddressMatched;
		SELF.DateFirstSeen			:= ri.dt_first_seen;

		SELF.Seq 							 := le.Seq;
		SELF.UltID						 := ri.UltID;
		SELF.OrgID						 := ri.OrgID;
		SELF.SeleID						 := ri.SeleID;
		SELF.FEIN							 := ri.company_FEIN;

		DaysApart := ut.DaysApart((STRING)ri.dt_last_seen, TodaysDate);

		SELF.InputElementEntityCount := IF(AddressPopulated AND AddressMatched, 1, 0);
		SELF.InputElementEntityCount24Mos := IF(AddressPopulated AND AddressMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= ut.DaysInNYears(2), 1, 0);
		SELF.InputElementEntityCount12Mos := IF(AddressPopulated AND AddressMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= ut.DaysInNYears(1), 1, 0);
		SELF.InputElementEntityCount06Mos := IF(AddressPopulated AND AddressMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.InputElementEntityCount03Mos := IF(AddressPopulated AND AddressMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
		SELF.InputElementEntityCount01Mos := IF(AddressPopulated AND AddressMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.OneMonth, 1, 0);

		SELF.OrgAddrLegalEntityCountActive := IF(AddressPopulated AND AddressMatched AND RawInputIDMatchStatus IN ['3','2','1','T','E'], 1, 0);
		SELF.OrgAddrLegalEntityCountInactive := IF(AddressPopulated AND AddressMatched AND RawInputIDMatchStatus = 'I', 1, 0);
		SELF.OrgAddrLegalEntityCountDefunct := IF(AddressPopulated AND AddressMatched AND RawInputIDMatchStatus = 'D', 1, 0);

		// SELF.InputAddrTINCount := IF(AddressPopulated AND AddressMatched AND ri.company_FEIN <> '', 1, 0);
	END;

	AddressVerification := JOIN(Shell, BusinessHeaderAddress, LEFT.Seq = RIGHT.Seq,
																	verifyAddresses(LEFT,RIGHT),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));
	AddressVerificationMatched := AddressVerification(AddressMatched);

  AddressVerificationSorted := SORT(AddressVerificationMatched, Seq, UltID, OrgID, SeleID, -InputElementEntityCount01Mos, -InputElementEntityCount03Mos, InputElementEntityCount06Mos, InputElementEntityCount12Mos, InputElementEntityCount24Mos);
	AddressVerificationRolled := ROLLUP(AddressVerificationSorted, LEFT.Seq = RIGHT.Seq,
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

																							SELF.OrgAddrLegalEntityCountActive := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.OrgAddrLegalEntityCountActive,
																																						LEFT.OrgAddrLegalEntityCountActive + RIGHT.OrgAddrLegalEntityCountActive);
																							SELF.OrgAddrLegalEntityCountInactive := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.OrgAddrLegalEntityCountInactive,
																																						LEFT.OrgAddrLegalEntityCountInactive + RIGHT.OrgAddrLegalEntityCountInactive);
																							SELF.OrgAddrLegalEntityCountDefunct := IF(LEFT.UltID = RIGHT.UltID AND LEFT.OrgID = RIGHT.OrgID AND LEFT.SeleID = RIGHT.SeleID,
																																						LEFT.OrgAddrLegalEntityCountDefunct,
																																						LEFT.OrgAddrLegalEntityCountDefunct + RIGHT.OrgAddrLegalEntityCountDefunct);
																							SELF := []));

	withAddressVerification := JOIN(Shell, AddressVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							AddressNotInput := LEFT.Input.InputCheckBusAddrZip = '0';
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount := IF(AddressNotInput, '-1',  (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount24Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount24Mos, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount12Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount12Mos, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount06Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount06Mos, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount03Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount03Mos, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount01Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount01Mos, -1, 50));

																							SELF.Organizational_Structure.OrgAddrLegalEntityCountActive := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.OrgAddrLegalEntityCountActive, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCountInactive := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.OrgAddrLegalEntityCountInactive, -1, 50));
																							SELF.Organizational_Structure.OrgAddrLegalEntityCountDefunct := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.OrgAddrLegalEntityCountDefunct, -1, 50));

																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

		EmergingAddressVerification := DEDUP(SORT(AddressVerification((UNSIGNED)DateFirstSeen <> 0), Seq, UltID, OrgID, SeleID, DateFirstSeen, -AddressMatched), Seq, UltID, OrgID, SeleID);

		GetEmergingAddressCounts := TABLE(EmergingAddressVerification,
																			{Seq,
																			UNSIGNED EmergingAddressCount := COUNT(GROUP, AddressMatched),
																			UNSIGNED EmergingAddressCount24 := COUNT(GROUP, AddressMatched AND ut.DaysApart((STRING)DateFirstSeen, TodaysDate) <= ut.DaysInNYears(2)),
																			UNSIGNED EmergingAddressCount12 := COUNT(GROUP, AddressMatched AND ut.DaysApart((STRING)DateFirstSeen, TodaysDate) <= ut.DaysInNYears(1)),
																			UNSIGNED EmergingAddressCount06 := COUNT(GROUP, AddressMatched AND ut.DaysApart((STRING)DateFirstSeen, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths),
																			UNSIGNED EmergingAddressCount03 := COUNT(GROUP, AddressMatched AND ut.DaysApart((STRING)DateFirstSeen, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths),
																			UNSIGNED EmergingAddressCount01 := COUNT(GROUP, AddressMatched AND ut.DaysApart((STRING)DateFirstSeen, TodaysDate) <= Business_Risk_BIP.Constants.OneMonth)},
																			Seq);
		withEmergingAddressCounts := JOIN(withAddressVerification, GetEmergingAddressCounts,	LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								AddressNotInput := LEFT.Input.InputCheckBusAddrZip = '0';
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeenEver := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.EmergingAddressCount, -1, 50));
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen24Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.EmergingAddressCount24, -1, 50));
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen12Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.EmergingAddressCount12, -1, 50));
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen06Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.EmergingAddressCount06, -1, 50));
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen03Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.EmergingAddressCount03, -1, 50));
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen01Mos := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.EmergingAddressCount01, -1, 50));
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

		AddressFEINVerification := TABLE(AddressVerificationMatched((UNSIGNED)FEIN>0),
																			{seq, FEIN, UNSIGNED RecordCount := COUNT(GROUP)}, seq, FEIN);

		GetFEINsPerAddr := TABLE(AddressFEINVerification,
																			{seq, UNSIGNED FEINCount := COUNT(GROUP, (INTEGER)FEIN > 0)}, seq);

		withFEINsPerAddr := JOIN(withEmergingAddressCounts, GetFEINsPerAddr, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								AddressNotInput := LEFT.Input.InputCheckBusAddrZip = '0';
																								SELF.Input_Characteristics.InputAddrTINCount := IF(AddressNotInput, '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.FEINCount, -1, 99999));
																								SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(Shell, 100), NAMED('Sample_Shell'));
	// OUTPUT(CHOOSEN(For_Address_Search, 100), NAMED('Sample_For_Address_Search'));
	// OUTPUT(CHOOSEN(Address_results_w_acct, 100), NAMED('Sample_Address_results_w_acct'));
	// OUTPUT(CHOOSEN(UniqueRawAddressMatches, 100), NAMED('Sample_UniqueRawAddressMatches'));
	// OUTPUT(CHOOSEN(BusinessHeaderAddress, 100), NAMED('Sample_BusinessHeaderAddress'));
	// OUTPUT(CHOOSEN(AddressVerification, 100), NAMED('Sample_AddressVerification'));
	// OUTPUT(CHOOSEN(AddressVerificationMatched, 100), NAMED('Sample_AddressVerificationMatched'));
	// OUTPUT(CHOOSEN(AddressVerificationRolled, 100), NAMED('Sample_AddressVerificationRolled'));
	// OUTPUT(CHOOSEN(withAddressVerification, 100), NAMED('Sample_withAddressVerification'));
	// OUTPUT(CHOOSEN(EmergingAddressVerification, 100), NAMED('Sample_EmergingAddressVerification'));
	// OUTPUT(CHOOSEN(GetEmergingAddressCounts, 100), NAMED('Sample_GetEmergingAddressCounts'));
	// OUTPUT(CHOOSEN(withEmergingAddresCounts, 100), NAMED('Sample_withEmergingAddresCounts'));
	// OUTPUT(CHOOSEN(AddressFEINVerification, 100), NAMED('Sample_AddressFEINVerification'));
	// OUTPUT(CHOOSEN(GetFEINsPerAddr, 100), NAMED('Sample_GetFEINsPerAddr'));
	// OUTPUT(CHOOSEN(withFEINsPerAddr, 100), NAMED('Sample_withFEINsPerAddr'));

	RETURN withFEINsPerAddr;
END;
