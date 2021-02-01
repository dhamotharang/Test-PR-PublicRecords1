IMPORT Business_Risk_BIP, BIPV2, Risk_Indicators, SALT28, UT, doxie;

EXPORT getBusinessByPhone(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
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
	END;

		// ------- Get Phone Matches across all businesses ------------- //
	For_Phone_Search := PROJECT(Shell, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
				SELF.acctno := (string)LEFT.Seq,
				SELF.phone10 := LEFT.Clean_Input.Phone10,
				SELF := []));

	Phone_results_w_acct := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(For_Phone_Search).uid_results_w_acct,
																			TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID := (UNSIGNED)LEFT.acctno,
																								SELF.UltID := LEFT.UltID,
																								SELF.OrgID := LEFT.OrgID,
																								SELF.SeleID := LEFT.SeleID,
																								SELF.ProxID := LEFT.ProxID,
																								SELF.PowID := LEFT.PowID,
																								SELF := []));


	UniqueRawPhoneMatches := DEDUP(SORT(Phone_results_w_acct, UniqueID, UltID, OrgID, SeleID, ProxID, PowID),	UniqueID, UltID, OrgID, SeleID, ProxID, PowID);


	BusinessHeaderRawPhone1 := BIPV2.Key_BH_Linking_Ids.kFetch2(UniqueRawPhoneMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.PowID), // Search at most restrictive level since we already know the full BIP ID set of the FEIN match
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses,
																							mod_access := mod_access);

	// clean up the business header before doing anything else
  Business_Risk_BIP.Common.mac_slim_header(BusinessHeaderRawPhone1, BusinessHeaderRawPhone);

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BusinessHeaderRawPhone, Shell, BusinessHeaderPhoneSeq);


	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeaderPhone := GROUP(Business_Risk_BIP.Common.FilterRecords(BusinessHeaderPhoneSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);


	tempVerificationLayout verifyPhones(Shell le, BusinessHeaderPhone ri) := TRANSFORM
		BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
		TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, le.Clean_Input.HistoryDate);
		NoScoreValue 				:= 255;
		PhonePopulated			:= (INTEGER)le.Clean_Input.Phone10 > 0 AND (INTEGER)ri.Company_Phone > 0;
		PhoneScore 					:= IF(PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Phone10[4] = ri.Company_Phone[1]), Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.Company_Phone), NoScoreValue);
		PhoneMatched				:= Risk_Indicators.iid_constants.gn(PhoneScore);

		SELF.Seq 							 := le.Seq;
		SELF.UltID						 := ri.UltID;
		SELF.OrgID						 := ri.OrgID;
		SELF.SeleID						 := ri.SeleID;

		DaysApart := ut.DaysApart((STRING)ri.dt_last_seen, TodaysDate);
    SELF.InputElementEntityCount := IF(PhonePopulated AND PhoneMatched, 1, 0);
		SELF.InputElementEntityCount24Mos := IF(PhonePopulated AND PhoneMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= ut.DaysInNYears(2), 1, 0);
		SELF.InputElementEntityCount12Mos := IF(PhonePopulated AND PhoneMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= ut.DaysInNYears(1), 1, 0);
		SELF.InputElementEntityCount06Mos := IF(PhonePopulated AND PhoneMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.InputElementEntityCount03Mos := IF(PhonePopulated AND PhoneMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
		SELF.InputElementEntityCount01Mos := IF(PhonePopulated AND PhoneMatched AND (INTEGER)ri.dt_last_seen > 0 AND DaysApart <= Business_Risk_BIP.Constants.OneMonth, 1, 0);
	END;

	PhoneVerification := JOIN(Shell, BusinessHeaderPhone, LEFT.Seq = RIGHT.Seq AND LEFT.Clean_Input.Phone10 = RIGHT.Company_Phone,
																	verifyPhones(LEFT,RIGHT),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));

  // Sort most recent phone hits to the top so we count time buckets correctly.
  PhoneVerificationSorted := SORT(PhoneVerification, Seq, UltID, OrgID, SeleID, -InputElementEntityCount01Mos, -InputElementEntityCount03Mos, -InputElementEntityCount06Mos, -InputElementEntityCount12Mos, -InputElementEntityCount24Mos);

  PhoneVerificationRolled := ROLLUP(PhoneVerificationSorted, LEFT.Seq = RIGHT.Seq,
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
																																						LEFT.InputElementEntityCount01Mos + RIGHT.InputElementEntityCount01Mos)));

	withPhoneVerification := JOIN(Shell, PhoneVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              SELF.Input_Characteristics.InputPhoneEntityCount := IF(LEFT.Clean_Input.Phone10 = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount, -1, 50));
																							SELF.Input_Characteristics.InputPhoneEntityCount24Mos := IF(LEFT.Clean_Input.Phone10 = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount24Mos, -1, 50));
																							SELF.Input_Characteristics.InputPhoneEntityCount12Mos := IF(LEFT.Clean_Input.Phone10 = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount12Mos, -1, 50));
																							SELF.Input_Characteristics.InputPhoneEntityCount06Mos := IF(LEFT.Clean_Input.Phone10 = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount06Mos, -1, 50));
																							SELF.Input_Characteristics.InputPhoneEntityCount03Mos := IF(LEFT.Clean_Input.Phone10 = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount03Mos, -1, 50));
																							SELF.Input_Characteristics.InputPhoneEntityCount01Mos := IF(LEFT.Clean_Input.Phone10 = '', '-1', (STRING)Business_Risk_BIP.Common.CapNum(RIGHT.InputElementEntityCount01Mos, -1, 50));
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(For_Phone_Search, 100), NAMED('Sample_For_Phone_Search'));
	// OUTPUT(CHOOSEN(Phone_results_w_acct, 100), NAMED('Sample_Phone_results_w_acct'));
	// OUTPUT(CHOOSEN(UniqueRawPhoneMatches, 100), NAMED('Sample_UniqueRawPhoneMatches'));
	// OUTPUT(CHOOSEN(BusinessHeaderPhoneSeq, 100), NAMED('Sample_BusinessHeaderPhoneSeq'));
	// OUTPUT(CHOOSEN(BusinessHeaderPhone, 100), NAMED('Sample_BusinessHeaderPhone'));
	// OUTPUT(CHOOSEN(PhoneVerification, 100), NAMED('Sample_PhoneVerification'));
	// OUTPUT(CHOOSEN(PhoneVerificationRolled, 100), NAMED('Sample_PhoneVerificationRolled'));
	// OUTPUT(CHOOSEN(withPhoneVerification, 100), NAMED('Sample_withPhoneVerification'));
  // OUTPUT(AllowedSourcesSet,NAMED('Allowed_Srcs_BusPhone'));

	RETURN withPhoneVerification;
END;
