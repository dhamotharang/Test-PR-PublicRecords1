IMPORT BIPV2, Business_Risk, Business_Risk_BIP, dx_Gong, MDR, Risk_Indicators, UT, Doxie, Suppress;

EXPORT getEDA(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	shell_version := Options.BusShellVersion;

	// ---------------- Gong - EDA Phone Data ------------------
	GongAddressSeq_unsuppressed := JOIN(Shell, dx_Gong.key_history_address(), TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																	KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND LEFT.Clean_Input.State = RIGHT.st AND
																				LEFT.Clean_Input.Zip5 = RIGHT.Z5) AND ut.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range)
																	AND RIGHT.Current_Flag = TRUE AND RIGHT.Business_Flag = TRUE,
															TRANSFORM({dx_Gong.layouts.i_history_address, UNSIGNED4 Seq, UNSIGNED3 HistoryDate}, SELF.Seq := LEFT.Seq; SELF.HistoryDate := LEFT.Clean_Input.HistoryDate; SELF := RIGHT),
													ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	GongAddressSeq := Suppress.Mac_SuppressSource(GongAddressSeq_unsuppressed, mod_access);
	// Filter out records after our history date
	GongAddress := Business_Risk_BIP.Common.FilterRecords(GongAddressSeq, dt_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, '', AllowedSourcesSet);

	// Figure out which sources match Company Name, Company Address, Company Phone, Company FEIN
	Business_Risk_BIP.Layouts.Shell verifyElements(Business_Risk_BIP.Layouts.Shell le, GongAddress ri) := TRANSFORM
		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.Phone10) <> '';
		// In an effort to "short circuit" the fuzzy matching we require that the first character match before we compare the remaining characters - this helps with latency
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.Phone10[1] OR le.Clean_Input.Phone10[4] = ri.Phone10[4] OR le.Clean_Input.Phone10[4] = ri.Phone10[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.Phone10));

		NamePopulated				:= le.Clean_Input.CompanyName <> '';
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.Listed_Name AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Listed_Name));

		AddressPopulated		:= le.Clean_Input.Prim_Name <> '' AND le.Clean_Input.Zip5 <> '';
		NoScoreValue				:= 255;
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Z5 <> '' AND le.Clean_Input.Zip5[1] = ri.Z5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Z5), NoScoreValue);
		CityStateScore			:= IF(ZIPScore <> NoScoreValue AND le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																					Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));

		VerificationBusInputPhoneAddrLevel := MAP(PhonePopulated = FALSE																									=> '-2', // Phone Not Input - this will be blanked out later, just need a low integer so MAX works in the rollup
																	(INTEGER)ri.Phone10 = 0 OR NamePopulated = FALSE OR AddressPopulated = FALSE				=> '-1', // No phone records found, checking (INTEGER)RIGHT.Phone = 0 catches if the join resulted in no hits
																	AddressMatched = TRUE AND NameMatched = FALSE AND PhoneMatched = FALSE							=> '0', // Business and Phone not verified at Address
																	AddressMatched = TRUE AND NameMatched = TRUE AND PhoneMatched = FALSE								=> '1', // Phone not verified at Address
																	AddressMatched = TRUE AND NameMatched = TRUE AND PhoneMatched = TRUE								=> '2', // Business and Phone verified at Address
																																																												 '-1'); // No phone records found
		SELF.Verification.VerificationBusInputPhoneAddr := VerificationBusInputPhoneAddrLevel; // This calculation will also happen in Business_Risk_BIP.getBusinessHeader, take the max of both in Business_Shell_Function

		SELF := le;
	END;
	GongVerification := SORT(JOIN(Shell, GongAddress, LEFT.Seq = RIGHT.Seq,
																			verifyElements(LEFT, RIGHT),
																			LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default)), Seq);

	Business_Risk_BIP.Layouts.Shell rollGongVerification(Business_Risk_BIP.Layouts.Shell le, Business_Risk_BIP.Layouts.Shell ri) := TRANSFORM
		SELF.Verification.VerificationBusInputPhoneAddr := (STRING)MAX((INTEGER)le.Verification.VerificationBusInputPhoneAddr, (INTEGER)ri.Verification.VerificationBusInputPhoneAddr);

		SELF := le;
	END;
	GongVerificationRolled := ROLLUP(GongVerification, LEFT.Seq = RIGHT.Seq, rollGongVerification(LEFT, RIGHT));

	withGongVerification := JOIN(Shell, GongVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.VerificationBusInputPhoneAddr := RIGHT.Verification.VerificationBusInputPhoneAddr;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	tempGongCalc := RECORD
		UNSIGNED4 Seq;
		STRING2 BNAP;
		STRING1 PhoneMatch;
		BOOLEAN NameMatched;
		BOOLEAN AddressMatched;
		BOOLEAN PhoneMatched;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) NameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) AddressVerSources;
	END;

  key_history_phone := dx_Gong.key_history_phone();
	{tempGongCalc, UNSIGNED4 global_sid, UNSIGNED6 did} calcGong(Business_Risk_BIP.Layouts.Shell le, key_history_phone ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.did := ri.did;
		SELF.Seq := le.Seq;

		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Listed_Name) <> '';
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.Listed_Name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Listed_Name));

		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Z5) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Z5 <> '' AND le.Clean_Input.Zip5[1] = ri.Z5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Z5), NoScoreValue);
		CityStateScore			:= IF(ZIPScore <> NoScoreValue AND le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));

		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.Phone10) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.Phone10[1] OR le.Clean_Input.Phone10[4] = ri.Phone10[4] OR le.Clean_Input.Phone10[4] = ri.Phone10[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.Phone10));
		// This is also being calculated in Business_Risk_BIP.getBusinessHeader and Business_Risk_BIP.getOtherSources to help boost verification,
		// Only the levels that can be calculated with a phone match will be calculated here
		BNAPCalc := Business_Risk_BIP.Common.calcBNAP_narrow(NameMatched, AddressMatched, PhoneMatched);

		SELF.BNAP := BNAPCalc;
		// A BNAP of 4, 5, or 8 should also update the PhoneMatch flag as we effectively have verified the input phone against the input Business Name AND/OR Business Address
		SELF.PhoneMatch := Business_Risk_BIP.Common.SetBoolean(BNAPCalc IN ['4', '5', '8']);

		Sources  := IF(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v31 AND Options.MarketingMode = 1,
                    DATASET([], Business_Risk_BIP.Layouts.LayoutSources),
                    DATASET([{MDR.SourceTools.src_Gong_History,
													Business_Risk_BIP.Common.checkInvalidDate(((STRING)ri.dt_first_Seen), Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
													Business_Risk_BIP.Constants.MissingDate, //no vendor dates
													Business_Risk_BIP.Common.checkInvalidDate(((STRING)ri.dt_last_seen), Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
													Business_Risk_BIP.Constants.MissingDate, //no vendor dates
													1}], Business_Risk_BIP.Layouts.LayoutSources));

		SELF.PhoneSources := IF(BNAPCalc IN ['4', '5', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.NameSources := IF(shell_version >= 22 AND BNAPCalc IN ['5', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources)); // Require Name and Phone match and Business shell version of 2.2 or higher to retain source
		SELF.AddressVerSources := IF(shell_version >= 22 AND BNAPCalc IN ['4', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));	// Require Address and Phone match and Business shell version of 2.2 or higher to retain source

		// For BNAP2 we want to rollup the various match elements across all header records to catch situations where FEIN verified on one record, but wasn't populated on the header record that Address verified.
		SELF.NameMatched := NameMatched;
		SELF.AddressMatched := AddressMatched;
		SELF.PhoneMatched := PhoneMatched;
	END;
	gongBNAPRaw_unsuppressed := JOIN(Shell, key_history_phone, (INTEGER)LEFT.Clean_Input.Phone10 > 0 AND KEYED(LEFT.Clean_Input.Phone10[1..3] = RIGHT.p3 AND LEFT.Clean_Input.Phone10[4..10] = RIGHT.p7) AND
																						// See comments for Business_Risk_BIP.Common.FilterRecords for full explaination - the <= and < checks are valid and should be different below for realtime vs historical modes
																						((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)RIGHT.dt_first_seen)[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(((STRING)RIGHT.dt_first_seen)[1..6]) < LEFT.Clean_Input.HistoryDate)
																						AND (INTEGER)RIGHT.dt_first_seen > 0,
																				calcGong(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	gongBNAPRaw := Suppress.Suppress_ReturnOldLayout(gongBNAPRaw_unsuppressed, mod_access, tempGongCalc);

	gongBNAP := ROLLUP(SORT(gongBNAPRaw, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempGongCalc,
																								SELF.BNAP := (STRING)MAX((INTEGER)LEFT.BNAP, (INTEGER)RIGHT.BNAP);
																								SELF.PhoneMatch := (STRING)MAX((INTEGER)LEFT.PhoneMatch, (INTEGER)RIGHT.PhoneMatch);
																								SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																								SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																								SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																								SELF.NameMatched := LEFT.NameMatched OR RIGHT.NameMatched;
																								SELF.AddressMatched := LEFT.AddressMatched OR RIGHT.AddressMatched;
																								SELF.PhoneMatched := LEFT.PhoneMatched OR RIGHT.PhoneMatched;
																								SELF := LEFT));

	withGongBNAP := JOIN(withGongVerification, gongBNAP, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.BNAP := RIGHT.BNAP; // Requires all elements verify within the same phone record
																							SELF.Verification.BNAP2 := Business_Risk_BIP.Common.calcBNAP_narrow(RIGHT.NameMatched, RIGHT.AddressMatched, RIGHT.PhoneMatched); // Uses the combination of all phone records to verify elements
																							SELF.Verification.PhoneMatch := RIGHT.PhoneMatch;
																							SELF.PhoneSources := RIGHT.PhoneSources;
																							SELF.NameSources := RIGHT.NameSources;
																							SELF.AddressVerSources := RIGHT.AddressVerSources;
																							SELF.Sources := LEFT.Sources + RIGHT.PhoneSources; // Make sure we copy the phone sources to the main source list as well
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


		// ---------------- Gong - EDA Phone Data ------------------
	GongLinkIdRaw := dx_Gong.key_history_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell), mod_access,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);

	Business_Risk_BIP.Common.AppendSeq2(GongLinkIdRaw, Shell, GongLinkIdSeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(GongLinkIdSeq);

	GongLinkIds := Business_Risk_BIP.Common.FilterRecords(GongLinkIdSeq, dt_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_Gong_History, AllowedSourcesSet);


	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) LinkIdSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneIDSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) NameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) AddressVerSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) BestAddressSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutBestAddrPhones) BestAddrPhones;
	END;


	GongLinkIdStatsTemp := JOIN(Shell, GongLinkIds, RIGHT.Seq = LEFT.Seq, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				Sources  := DATASET([{MDR.SourceTools.src_Gong_History,
																															Business_Risk_BIP.Common.checkInvalidDate(((STRING)RIGHT.dt_first_Seen), Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate)[1..6],
																															Business_Risk_BIP.Constants.MissingDate, //no vendor dates
																															Business_Risk_BIP.Common.checkInvalidDate(((STRING)RIGHT.dt_last_seen), Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDate)[1..6],
																															Business_Risk_BIP.Constants.MissingDate, //no vendor dates
																															1}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.LinkIdSources := Sources;
																				PhonePopulated			:= TRIM(LEFT.Clean_Input.Phone10) <> '' AND TRIM(RIGHT.Phone10) <> '';
																				PhoneMatched				:= PhonePopulated AND (LEFT.Clean_Input.Phone10[1] = RIGHT.Phone10[1] OR LEFT.Clean_Input.Phone10[4] = RIGHT.Phone10[4] OR LEFT.Clean_Input.Phone10[4] = RIGHT.Phone10[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Phone10, RIGHT.Phone10));
																				NamePopulated				:= TRIM(LEFT.Clean_Input.CompanyName) <> '' AND TRIM(RIGHT.Listed_Name) <> '';
																				NameMatched					:= NamePopulated AND LEFT.Clean_Input.CompanyName[1] = RIGHT.Listed_Name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(LEFT.Clean_Input.CompanyName, RIGHT.Listed_Name));
																				NoScoreValue				:= 255;
																				AddressPopulated		:= TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(RIGHT.prim_name) <> '' AND TRIM(RIGHT.Z5) <> '';
																				ZIPScore						:= IF(LEFT.Clean_Input.Zip5 <> '' AND RIGHT.Z5 <> '' AND LEFT.Clean_Input.Zip5[1] = RIGHT.Z5[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Zip5, RIGHT.Z5), NoScoreValue);
																				CityStateScore			:= IF(ZIPScore <> NoScoreValue AND LEFT.Clean_Input.City <> '' AND LEFT.Clean_Input.State <> '' AND RIGHT.p_city_name <> '' AND RIGHT.st <> '' AND LEFT.Clean_Input.State[1] = RIGHT.st[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.City, LEFT.Clean_Input.State, RIGHT.p_city_name, RIGHT.st, ''), NoScoreValue);
																				CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
																				AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																																										Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Prim_Range, LEFT.Clean_Input.Prim_Name, LEFT.Clean_Input.Sec_Range,
																																										RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																										ZIPScore, CityStateScore)));

																				BestAddressPopulated		:= TRIM(LEFT.Best_Info.BestPrimName) <> '' AND TRIM(LEFT.Best_Info.BestCompanyZip) <> '' AND TRIM(RIGHT.prim_name) <> '' AND TRIM(RIGHT.Z5) <> '';
																				BestZIPScore						:= IF(LEFT.Best_Info.BestCompanyZip <> '' AND RIGHT.Z5 <> '' AND LEFT.Best_Info.BestCompanyZip[1] = RIGHT.Z5[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Best_Info.BestCompanyZip, RIGHT.Z5), NoScoreValue);
																				BestCityStateScore			:= IF(BestZIPScore <> NoScoreValue AND LEFT.Best_Info.BestCompanyCity <> '' AND LEFT.Best_Info.BestCompanyState <> '' AND RIGHT.p_city_name <> '' AND RIGHT.st <> '' AND LEFT.Best_Info.BestCompanyState[1] = RIGHT.st[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Best_Info.BestCompanyCity, LEFT.Best_Info.BestCompanyState, RIGHT.p_city_name, RIGHT.st, ''), NoScoreValue);
																				BestCityStateZipMatched	:= Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore) AND BestAddressPopulated;
																				BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(IF(BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue, NoScoreValue,
																																										Risk_Indicators.AddrScore.AddressScore(LEFT.Best_Info.BestPrimRange, LEFT.Best_Info.BestPrimName, LEFT.Best_Info.BestSecRange,
																																										RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																										BestZIPScore, BestCityStateScore)));

																				SELF.PhoneIdSources := IF(PhoneMatched, Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF.NameSources := IF(shell_version >= 22 AND NameMatched, Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF.AddressVerSources := IF(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22 AND AddressMatched, Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF.BestAddressSources := IF(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched, Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF.BestAddrPhones := IF(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched AND TRIM(RIGHT.Phone10) <> '',
																				DATASET([{RIGHT.Phone10}], Business_Risk_BIP.Layouts.LayoutBestAddrPhones), DATASET([], Business_Risk_BIP.Layouts.LayoutBestAddrPhones));

																				SELF := []));

	GongLinkIdRolled := ROLLUP(SORT(GongLinkIdStatsTemp, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.LinkIdSources := LEFT.LinkIdSources + RIGHT.LinkIdSources;
																				SELF.PhoneIDSources := LEFT.PhoneIDSources + RIGHT.PhoneIDSources;
																				SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																				SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																				SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																				SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																				SELF := LEFT));

	withGongLinkIdStats := JOIN(Shell, GongLinkIdRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.LinkIdSources := RIGHT.LinkIdSources;
																							SELF.PhoneIDSources := RIGHT.PhoneIDSources;
																							SELF.NameSources := RIGHT.NameSources;
																							SELF.AddressVerSources := RIGHT.AddressVerSources;
																							SELF.BestAddressSources := RIGHT.BestAddressSources;
																							SELF.BestAddrPhones := RIGHT.BestAddrPhones;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withGongLinkId := JOIN(withGongBNAP, withGongLinkIdStats, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.LinkIdSources := RIGHT.LinkIdSources;
																							SELF.PhoneIDSources := RIGHT.PhoneIDSources;
																							SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																							SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																							SELF.BestAddressSources := RIGHT.BestAddressSources;
																							SELF.BestAddrPhones := RIGHT.BestAddrPhones;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withErrorCodes := JOIN(withGongLinkId, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeEDA := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(GongAddress, 100), NAMED('Sample_GongAddress'));
	// OUTPUT(CHOOSEN(GongVerification, 100), NAMED('Sample_GongVerification'));
	// OUTPUT(CHOOSEN(GongVerificationRolled, 100), NAMED('Sample_GongVerificationRolled'));
	// OUTPUT(CHOOSEN(withGongVerification, 100), NAMED('Sample_withGongVerification'));
	// OUTPUT(CHOOSEN(gongBNAPRaw, 100), NAMED('Sample_gongBNAPRaw'));
	// OUTPUT(CHOOSEN(gongBNAP, 100), NAMED('Sample_gongBNAP'));
	// OUTPUT(CHOOSEN(GongLinkIdRaw, 100), NAMED('GongLinkIdRaw'));
	// OUTPUT(CHOOSEN(GongLinkIds, 100), NAMED('GongLinkIds'));
	// OUTPUT(CHOOSEN(GongLinkIdStatsTemp, 100), NAMED('GongLinkIdStatsTemp'));
	// OUTPUT(CHOOSEN(GongLinkIdRolled, 100), NAMED('GongLinkIdRolled'));
	// OUTPUT(CHOOSEN(withGongLinkIdStats, 100), NAMED('withGongLinkIdStats'));
	// OUTPUT(CHOOSEN(withGongLinkId, 100), NAMED('withGongLinkId'));
	RETURN withErrorCodes;
END;
