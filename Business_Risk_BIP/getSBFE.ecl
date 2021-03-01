IMPORT BIPV2, Business_Credit, Business_Credit_KEL,  Business_Risk,  Business_Risk_BIP, DID_Add, doxie, MDR, risk_indicators, STD;

EXPORT getSBFE(DATASET(Business_Risk_BIP.Layouts.Shell) Shell_pre,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

  // Add fifteen minutes to the historydatetime to accommodate for delays in
	// the real time database information being available in production runs
	Shell :=
		PROJECT(
			Shell_pre,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				SELF.Clean_Input.HistoryDateTime := IF( ((STRING)LEFT.Clean_Input.HistoryDateTime)[1..6] = '999999', LEFT.Clean_Input.HistoryDateTime, Business_Risk_BIP.Common.getFutureTime(LEFT.Clean_Input.HistoryDateTime, 15) ),
				SELF := LEFT
			)
		);

	SBFERaw := Business_Credit.Key_LinkIds().kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																		mod_access,
                                    Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																		0, /*ScoreThreshold --> 0 = Give me everything*/
																		Business_Risk_BIP.Constants.Limit_SBFE_LinkIds,
																		Options.KeepLargeBusinesses
																		);

	// Restrict SBFE data here in getSBFE to shortcut a lengthy subroutine and so improve performance.
	restrict_sbfe := mod_access.DataPermissionMask[12] IN ['0', ''];

  Business_Risk_BIP.Common.AppendSeq2(SBFERaw, Shell, SBFESeq);


	SBFEIDStatus := JOIN(Shell, SBFESeq, LEFT.Seq = RIGHT.Seq,
															TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																			SBFEHit := TRIM(RIGHT.contract_account_number) <> '';
																			SELF.Verification.InputIDMatchStatus := 'UNKNOWN';
																			SELF.Verification.InputIDMatchCategory := IF(SBFEHit, Business_Risk_BIP.Constants.Category_SBFESingle, Business_Risk_BIP.Constants.Category_None);
																			SELF := LEFT),
															LEFT OUTER, KEEP(1), ATMOST(Business_Risk_BIP.Constants.Limit_SBFE_LinkIds));

		// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(SBFESeq);

	// Build a unique acct_no based on a hash of record information.
	RECORDOF(Business_Credit_KEL.File_SBFE_temp.linkids) getacctno_loaddate(SBFESeq le, RECORDOF(Business_Credit.Key_ReleaseDates()) ri) := TRANSFORM
		SELF.acct_no := HASH(le.seq, le.sbfe_contributor_number, le.contract_account_number, le.account_type_reported);
		load_datetime := ri.prod_date + ri.prod_time;
		load_Date := MAP(le.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate	 																					=> (STRING)le.dt_first_seen,
														(INTEGER)load_datetime=0 AND ((STRING)le.HistoryDateTime)[1..6] = Business_Risk_BIP.Constants.NinesDate	=> (STRING)le.dt_first_seen,
																																																																			load_datetime);
    SELF.load_date := load_date;
		SELF.load_dateYYYYMMDD := load_date[1..8];
		SELF := le;
	END;

	linkid_recs_loaddate := JOIN(SBFESeq, Business_Credit.Key_ReleaseDates(),
	keyed(LEFT.original_version=RIGHT.version), getacctno_loaddate(LEFT,RIGHT),
	LEFT OUTER,
	atmost(10));// shouldn't ever be more than 1, but using 10 just to remove the warning


	linkid_recs_loaddate_dedup := DEDUP(SORT(linkid_recs_loaddate, seq, acct_no, original_version, -load_date), seq, acct_no);

  linkid_recs := Business_Risk_BIP.Common.FilterRecords2(linkid_recs_loaddate_dedup, load_date, MDR.SourceTools.src_Business_Credit, AllowedSourcesSet);

	// Instantiate module for easier reference below.
	mod_SBFE := Business_Credit_KEL.GLUE_fdc_append(linkid_recs);

	// Get majority of SBFE data.
	SBFE_data := mod_SBFE.SBFE_result;

	// identify if this transaction is being run in production traffic to avoid some extra overhead of processing by historydate
	production_realtime_mode := ((string)shell_pre[1].Clean_Input.HistoryDateTime)[1..6] = '999999';

	// Get future Tradelines data.
	linkid_recs_future := Business_Risk_BIP.Common.FilterRecordsFuture(linkid_recs_loaddate_dedup, dt_first_seen, MDR.SourceTools.src_Business_Credit, AllowedSourcesSet);

	// when in production mode, we don't need to add 3 years to the historydate of 999999 
	SBFE_data_future          := if(production_realtime_mode, mod_SBFE.SBFE_Result_Future_ProductionMode, Business_Credit_KEL.GLUE_fdc_append(linkid_recs_future).SBFE_Result_Future);

	// Get BusinessIformation data separately to make work in the Transform below easier.
	BusinessInformation_recs := mod_SBFE.AddBusinessClassification;

	Business_Risk_BIP.Layouts.Shell verifyElements(Business_Risk_BIP.Layouts.Shell le, BusinessInformation_recs ri) := TRANSFORM
		NoScoreValue				:= 255; // This is what the various score functions return if blank is passed in

		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '';
		// In an effort to "short-circuit" all of the fuzzy matching, we will require that the first letter match - if it doesn't match it bypasses the slow fuzzy matching which speeds up our query
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.clean_business_name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.clean_business_name));

		AddressPopulated		:= le.Input.InputCheckBusAddr='1';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		StateMatched				:= STD.Str.ToUpperCase(le.Clean_Input.State) = STD.Str.ToUpperCase(ri.st);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND StateMatched,
															Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																				Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));
		PhonePopulated			:= (INTEGER)le.Clean_Input.Phone10 > 0;
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.Phone_Number[1] OR le.Clean_Input.Phone10[4] = ri.Phone_Number[4] OR le.Clean_Input.Phone10[4] = ri.Phone_Number[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.Phone_Number));
		FEINPopulated				:= le.Input_Echo.FEIN <> '';
		FEINLength 					:= LENGTH(TRIM(le.Input_Echo.FEIN));
		FEINMatched					:= MAP(le.Input_Echo.FEIN = ''																					=> FALSE,
															le.Input_Echo.FEIN[1] = ri.Federal_TaxId_SSN[IF(FEINLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Input_Echo.FEIN, ri.Federal_TaxId_SSN, FEINLength=4)),
																																																		FALSE);

		tempIndustryCodeLayout := RECORD
			UNSIGNED seq;
			BOOLEAN IndustryCodePopulated;
			BOOLEAN IndustryCodePartialMatch;
			BOOLEAN IndustryCodeMatch;
		END;

		tempIndustryCodeLayout verifyIndustryCodes(RECORDOF(ri.BusinessClassification) le, INTEGER sic, INTEGER naic, STRING groupCode_in) := TRANSFORM
				SELF.seq := le.seq;
				//SELF.IndustryCodePopulated := (INTEGER)le.classification_code >0 AND (INTEGER)le.classification_code_type >0;
				IndustryCodePopulated := sic > 0 OR naic > 0;
				SELF.IndustryCodePopulated := IndustryCodePopulated;
				groupCode := MAP(le.classification_code_type = '002' => Business_Risk_BIP.Common.IndustryGroup(le.classification_code, Business_Risk_BIP.Constants.NAIC),
												 le.classification_code_type = '001' => Business_Risk_BIP.Common.IndustryGroup(le.classification_code, Business_Risk_BIP.Constants.SIC),
																																'');
				SELF.IndustryCodePartialMatch := groupCode_in = groupCode AND IndustryCodePopulated;

				SELF.IndustryCodeMatch := (le.classification_code_type = '001' AND (INTEGER)le.classification_code = sic OR
																	le.classification_code_type = '002' AND (INTEGER)le.classification_code = naic) AND IndustryCodePopulated;
		END;

		groupCode_in := IF((INTEGER)le.Clean_input.naic > 0,
										Business_Risk_BIP.Common.IndustryGroup(le.Clean_Input.naic, Business_Risk_BIP.Constants.NAIC),
										Business_Risk_BIP.Common.IndustryGroup(le.Clean_Input.sic, Business_Risk_BIP.Constants.SIC));

		IndustryCodes := PROJECT(ri.BusinessClassification, verifyIndustryCodes(LEFT,(INTEGER)le.Clean_Input.sic, (INTEGER)le.Clean_Input.naic, groupCode_in));


		tempIndustryCodeLayout rollIndustryCodes(IndustryCodes le, IndustryCodes ri) := TRANSFORM
			SELF.seq := le.seq;
			SELF.IndustryCodePopulated := le.IndustryCodePopulated OR ri.IndustryCodePopulated;
			SELF.IndustryCodePartialMatch := le.IndustryCodePartialMatch OR ri.IndustryCodePartialMatch;
			SELF.IndustryCodeMatch	:= le.IndustryCodeMatch OR ri.IndustryCodeMatch;
		END;

		IndustryCodesRolled := ROLLUP(IndustryCodes, LEFT.Seq = RIGHT.Seq, rollIndustryCodes(LEFT, RIGHT));


		SBFEVerBusInputName := MAP(NameMatched AND (FEINMatched OR AddressMatched OR PhoneMatched) 	=> 1,
																				 NamePopulated 																					=> 0,
																																																 	-99);
		SELF.SBFE.SBFEVerBusInputName := (STRING)SBFEVerBusInputName;
		SELF.SBFE.SBFENameMatchDateFirstSeen := MAP(NOT NamePopulated 															=> '-99',
																								NameMatched 																		=> (STRING)ri.dt_first_seen,
																																																	 '');
		SELF.SBFE.SBFENameMatchDateLastSeen := MAP(NOT NamePopulated 																=> '-99',
																								NameMatched 																		=> Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, '0', (UNSIGNED)((STRING)le.Clean_Input.HistoryDateTime)[1..8]),
																																																	 '');


		SBFEVerBusInputAddr	:= MAP(AddressMatched AND (FEINMatched OR PhoneMatched OR NameMatched)	  												=> 2,
																AddressMatched OR (CityStateZipMatched AND (FEINMatched OR PhoneMatched OR NameMatched))  => 1,
																AddressPopulated																																					=> 0,
																																																														 -99);
		SELF.SBFE.SBFEVerBusInputAddr := (STRING)SBFEVerBusInputAddr;
		SELF.SBFE.SBFEAddrMatchDateFirstSeen := MAP(NOT AddressPopulated 														=> '-99',
																								AddressMatched 																	=> (STRING)ri.dt_first_seen,
																																																	 '');
		SELF.SBFE.SBFEAddrMatchDateLastSeen := MAP(NOT AddressPopulated 														=> '-99',
																								AddressMatched 																	=> Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, '0', (UNSIGNED)((STRING)le.Clean_Input.HistoryDateTime)[1..8]),
																																																	 '');



		SBFEVerBusInputPhone := MAP(PhoneMatched AND AddressMatched AND NameMatched 								=> 2,
																PhoneMatched AND (NameMatched OR AddressMatched) 								=> 1,
																PhonePopulated																									=> 0,
																																																	 -99);
		SELF.SBFE.SBFEVerBusInputPhone := (STRING)SBFEVerBusInputPhone;
		SELF.SBFE.SBFEPhoneMatchDateFirstSeen := MAP(NOT PhonePopulated 														=> '-99',
																								 PhoneMatched 																	=> (STRING)ri.dt_first_seen,
																																																	 '');
		SELF.SBFE.SBFEPhoneMatchDateLastSeen := MAP(NOT PhonePopulated 															=> '-99',
																								 PhoneMatched  																	=> Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, '0', (UNSIGNED)((STRING)le.Clean_Input.HistoryDateTime)[1..8]),
																																																	 '');

		SELF.SBFE.SBFEVerBusInputPhoneAddr := MAP(PhoneMatched AND AddressMatched	AND NameMatched		=> '2',
																							AddressMatched AND PhonePopulated	AND NameMatched	=> '1',
																							AddressPopulated AND PhonePopulated 							=> '0',
																																																	 '-99');

		SBFEVerBusInputPhoneFEIN := MAP(FEINMatched AND AddressMatched AND NameMatched 			  			=> 2,
																							FEINMatched AND (AddressMatched OR NameMatched) 	=> 1,
																							FEINPopulated																			=> 0,
																																																	 -99);
		SELF.SBFE.SBFEVerBusInputPhoneFEIN := (STRING)SBFEVerBusInputPhoneFEIN;
		SELF.SBFE.SBFEFEINMatchDateFirstSeen := MAP(NOT FEINPopulated 															=> '-99',
																							 FEINMatched 																			=> (STRING)ri.dt_first_seen,
																																																	 '');
		SELF.SBFE.SBFEFEINMatchDateLastSeen := MAP(NOT FEINPopulated 																=> '-99',
																							 FEINMatched 																			=> Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, '0', (UNSIGNED)((STRING)le.Clean_Input.HistoryDateTime)[1..8]),
																																																	 '');


		SELF.SBFE.SBFEVerBusInputIndustryCode := MAP(IndustryCodesRolled[1].IndustryCodeMatch			   => '2',
																								 IndustryCodesRolled[1].IndustryCodePartialMatch => '1',
																								 IndustryCodesRolled[1].IndustryCodePopulated 	 => '0',
																																																		'-99');
		SELF := le;
	END;

	SBFEVerification := SORT(JOIN(Shell, BusinessInformation_recs(record_type='AB'), LEFT.seq = RIGHT.Seq,
																			verifyElements(LEFT, RIGHT),
																			LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader)), Seq);

	Business_Risk_BIP.Layouts.Shell	rollSBFEVerification(SBFEVerification le, SBFEVerification ri) := TRANSFORM
		SELF.SBFE.SBFEVerBusInputName := (STRING)MAX((INTEGER)le.SBFE.SBFEVerBusInputName, (INTEGER)ri.SBFE.SBFEVerBusInputName );
		SELF.SBFE.SBFENameMatchDateFirstSeen := MAP(le.SBFE.SBFENameMatchDateFirstSeen='' => ri.SBFE.SBFENameMatchDateFirstSeen,
																								ri.SBFE.SBFENameMatchDateFirstSeen='' => le.SBFE.SBFENameMatchDateFirstSeen,
																																												 (STRING)MIN((INTEGER)le.SBFE.SBFENameMatchDateFirstSeen, (INTEGER)ri.SBFE.SBFENameMatchDateFirstSeen));
		SELF.SBFE.SBFENameMatchDateLastSeen := (STRING)MAX(le.SBFE.SBFENameMatchDateLastSeen, ri.SBFE.SBFENameMatchDateLastSeen);
		SELF.SBFE.SBFEVerBusInputAddr	:= (STRING)MAX((INTEGER)le.SBFE.SBFEVerBusInputAddr, (INTEGER)ri.SBFE.SBFEVerBusInputAddr );
		SELF.SBFE.SBFEAddrMatchDateFirstSeen := MAP(le.SBFE.SBFEAddrMatchDateFirstSeen='' => ri.SBFE.SBFEAddrMatchDateFirstSeen,
																								ri.SBFE.SBFEAddrMatchDateFirstSeen='' => le.SBFE.SBFEAddrMatchDateFirstSeen,
																																												 (STRING)MIN((INTEGER)le.SBFE.SBFEAddrMatchDateFirstSeen, (INTEGER)ri.SBFE.SBFEAddrMatchDateFirstSeen));
		SELF.SBFE.SBFEAddrMatchDateLastSeen := (STRING)MAX(le.SBFE.SBFEAddrMatchDateLastSeen, ri.SBFE.SBFEAddrMatchDateLastSeen);
		SELF.SBFE.SBFEVerBusInputPhone := (STRING)MAX((INTEGER)le.SBFE.SBFEVerBusInputPhone, (INTEGER)ri.SBFE.SBFEVerBusInputPhone );
		SELF.SBFE.SBFEPhoneMatchDateFirstSeen := MAP(le.SBFE.SBFEPhoneMatchDateFirstSeen='' => ri.SBFE.SBFEPhoneMatchDateFirstSeen,
																								ri.SBFE.SBFEPhoneMatchDateFirstSeen='' => le.SBFE.SBFEPhoneMatchDateFirstSeen,
																																												 (STRING)MIN((INTEGER)le.SBFE.SBFEPhoneMatchDateFirstSeen, (INTEGER)ri.SBFE.SBFEPhoneMatchDateFirstSeen));
		SELF.SBFE.SBFEPhoneMatchDateLastSeen := (STRING)MAX(le.SBFE.SBFEPhoneMatchDateLastSeen, ri.SBFE.SBFEPhoneMatchDateLastSeen);
		SELF.SBFE.SBFEVerBusInputPhoneAddr := (STRING)MAX((INTEGER)le.SBFE.SBFEVerBusInputPhoneAddr, (INTEGER)ri.SBFE.SBFEVerBusInputPhoneAddr );
		SELF.SBFE.SBFEVerBusInputPhoneFEIN := (STRING)MAX((INTEGER)le.SBFE.SBFEVerBusInputPhoneFEIN, (INTEGER)ri.SBFE.SBFEVerBusInputPhoneFEIN );
		SELF.SBFE.SBFEFEINMatchDateFirstSeen := MAP(le.SBFE.SBFEFEINMatchDateFirstSeen='' => ri.SBFE.SBFEFEINMatchDateFirstSeen,
																								ri.SBFE.SBFEFEINMatchDateFirstSeen='' => le.SBFE.SBFEFEINMatchDateFirstSeen,
																																												 (STRING)MIN((INTEGER)le.SBFE.SBFEFEINMatchDateFirstSeen, (INTEGER)ri.SBFE.SBFEFEINMatchDateFirstSeen));
		SELF.SBFE.SBFEFEINMatchDateLastSeen := (STRING)MAX(le.SBFE.SBFEFEINMatchDateLastSeen, ri.SBFE.SBFEFEINMatchDateLastSeen);
		SELF.SBFE.SBFEVerBusInputIndustryCode := (STRING)MAX((INTEGER)le.SBFE.SBFEVerBusInputIndustryCode , (INTEGER)ri.SBFE.SBFEVerBusInputIndustryCode );
		SELF := le;
	END;

	SBFEVerificationRolled := ROLLUP(SBFEVerification, LEFT.Seq = RIGHT.Seq, rollSBFEVerification(LEFT, RIGHT));

	Business_Risk_BIP.Layouts.Shell verifyPersonElements(Business_Risk_BIP.Layouts.Shell le, BusinessInformation_recs ri) := TRANSFORM
		NoScoreValue				:= 255;
		RepOnFile := ri.record_type='IS'; //if there are no SBFE person records for the business record_type will be ''

		Rep1InputFNamePopulated := TRIM(le.Clean_Input.Rep_FirstName) <> '';
		Rep1InputLNamePopulated := TRIM(le.Clean_Input.Rep_LastName) <> '';
		Rep1InputNamePopulated := Rep1InputFNamePopulated OR Rep1InputLNamePopulated;
		Rep2InputFNamePopulated := TRIM(le.Clean_Input.Rep2_FirstName) <> '';
		Rep2InputLNamePopulated := TRIM(le.Clean_Input.Rep2_LastName) <> '';
		Rep2InputNamePopulated := Rep2InputFNamePopulated OR Rep2InputLNamePopulated;
		Rep3InputFNamePopulated := TRIM(le.Clean_Input.Rep3_FirstName) <> '';
		Rep3InputLNamePopulated := TRIM(le.Clean_Input.Rep3_LastName) <> '';
		Rep3InputNamePopulated := Rep3InputFNamePopulated OR Rep3InputLNamePopulated;
    Rep4InputFNamePopulated := TRIM(le.Clean_Input.Rep4_FirstName) <> '';
		Rep4InputLNamePopulated := TRIM(le.Clean_Input.Rep4_LastName) <> '';
		Rep4InputNamePopulated := Rep4InputFNamePopulated OR Rep4InputLNamePopulated;
		Rep5InputFNamePopulated := TRIM(le.Clean_Input.Rep5_FirstName) <> '';
		Rep5InputLNamePopulated := TRIM(le.Clean_Input.Rep5_LastName) <> '';
		Rep5InputNamePopulated := Rep5InputFNamePopulated OR Rep5InputLNamePopulated;

		Rep1FNameMatched := Rep1InputFNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_fname, le.Clean_Input.Rep_FirstName, 1) > 0)='1';
		Rep1LNameMatched := Rep1InputLNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_lname, le.Clean_Input.Rep_LastName, 1) > 0)='1';
		Rep2FNameMatched := Rep2InputFNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_fname, le.Clean_Input.Rep2_FirstName, 1) > 0)='1';
		Rep2LNameMatched := Rep2InputLNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_lname, le.Clean_Input.Rep2_LastName, 1) > 0)='1';
		Rep3FNameMatched := Rep3InputFNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_fname, le.Clean_Input.Rep3_FirstName, 1) > 0)='1';
		Rep3LNameMatched := Rep3InputLNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_lname, le.Clean_Input.Rep3_LastName, 1) > 0)='1';
		Rep4FNameMatched := Rep4InputFNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_fname, le.Clean_Input.Rep4_FirstName, 1) > 0)='1';
		Rep4LNameMatched := Rep4InputLNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_lname, le.Clean_Input.Rep4_LastName, 1) > 0)='1';
		Rep5FNameMatched := Rep5InputFNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_fname, le.Clean_Input.Rep5_FirstName, 1) > 0)='1';
		Rep5LNameMatched := Rep5InputLNamePopulated AND Business_Risk_BIP.Common.SetBoolean(STD.Str.Find(ri.clean_lname, le.Clean_Input.Rep5_LastName, 1) > 0)='1';


		SELF.SBFE.SBFEBusExecLinkRep1NameonFile := MAP(	Rep1FNameMatched AND Rep1LNameMatched 		=> '3',
																										Rep1LNameMatched													=> '2',
																										Rep1FNameMatched													=> '1',
																										Rep1InputNamePopulated	AND RepOnFile			=> '0',
																										Rep1InputNamePopulated AND NOT RepOnFile	=> '-98',
																																																 '-99');

		SELF.SBFE.SBFEBusExecLinkRep2NameonFile := MAP( Rep2FNameMatched AND Rep2LNameMatched 		=> '3',
																										Rep2LNameMatched													=> '2',
																										Rep2FNameMatched													=> '1',
																										Rep2InputNamePopulated AND RepOnFile			=> '0',
																										Rep2InputNamePopulated AND NOT RepOnFile 	=> '-98',
																																																 '-99');

		SELF.SBFE.SBFEBusExecLinkRep3NameonFile := MAP( Rep3FNameMatched AND Rep3LNameMatched 		=> '3',
																										Rep3LNameMatched													=> '2',
																										Rep3FNameMatched													=> '1',
																										Rep3InputNamePopulated	AND RepOnFile			=> '0',
																										Rep3InputNamePopulated	AND NOT RepOnFile	=> '-98',
																																																 '-99');
		SELF.SBFE.SBFEBusExecLinkRep4NameonFile := MAP( Rep4FNameMatched AND Rep4LNameMatched 		=> '3',
																										Rep4LNameMatched													=> '2',
																										Rep4FNameMatched													=> '1',
																										Rep4InputNamePopulated AND RepOnFile			=> '0',
																										Rep4InputNamePopulated AND NOT RepOnFile 	=> '-98',
																																																 '-99');

		SELF.SBFE.SBFEBusExecLinkRep5NameonFile := MAP( Rep5FNameMatched AND Rep5LNameMatched 		=> '3',
																										Rep5LNameMatched													=> '2',
																										Rep5FNameMatched													=> '1',
																										Rep5InputNamePopulated	AND RepOnFile			=> '0',
																										Rep5InputNamePopulated	AND NOT RepOnFile	=> '-98',
																																																 '-99');


		Rep1InputAddrNotPopulated := TRIM(le.Clean_Input.Rep_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep_City) = '' OR TRIM(le.Clean_Input.Rep_State) = '' OR TRIM(le.Clean_Input.Rep_Zip5) = '';
		Rep1ZIPScore					:= IF(le.Clean_Input.Rep_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep_Zip5, ri.Zip), NoScoreValue);
		Rep1CityStateScore		:= IF(le.Clean_Input.Rep_City <> '' AND le.Clean_Input.Rep_State <> '' AND ri.v_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep_City, le.Clean_Input.Rep_State, ri.v_city_name, ri.st, ''), NoScoreValue);
		Rep1InputAddrMatched := Risk_Indicators.iid_constants.ga(IF(Rep1ZIPScore = NoScoreValue AND Rep1CityStateScore = NoScoreValue, NoScoreValue,
																				Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep_Prim_Range, le.Clean_Input.Rep_Prim_Name, le.Clean_Input.Rep_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep1ZIPScore, Rep1CityStateScore)));

		SELF.SBFE.SBFEBusExecLinkRep1AddronFile	:= MAP( Rep1InputAddrMatched 														=> '1',
																										NOT Rep1InputAddrNotPopulated AND RepOnFile 		=> '0',
																										NOT Rep1InputAddrNotPopulated AND NOT RepOnFile => '-98',
																																																			 '-99');


		Rep2InputAddrNotPopulated := TRIM(le.Clean_Input.Rep2_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep2_City) = '' OR TRIM(le.Clean_Input.Rep2_State) = '' OR TRIM(le.Clean_Input.Rep2_Zip5) = '';
		Rep2ZIPScore					:= IF(le.Clean_Input.Rep2_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep2_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep2_Zip5, ri.Zip), NoScoreValue);
		Rep2CityStateScore		:= IF(le.Clean_Input.Rep2_City <> '' AND le.Clean_Input.Rep2_State <> '' AND ri.v_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep2_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep2_City, le.Clean_Input.Rep2_State, ri.v_city_name, ri.st, ''), NoScoreValue);
		Rep2InputAddrMatched := Risk_Indicators.iid_constants.ga(IF(Rep2ZIPScore = NoScoreValue AND Rep2CityStateScore = NoScoreValue, NoScoreValue,
																				Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep2_Prim_Range, le.Clean_Input.Rep2_Prim_Name, le.Clean_Input.Rep2_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep2ZIPScore, Rep2CityStateScore)));

		SELF.SBFE.SBFEBusExecLinkRep2AddronFile	:= MAP( Rep2InputAddrMatched 														=> '1',
																										NOT Rep2InputAddrNotPopulated AND RepOnFile 		=> '0',
																										NOT Rep2InputAddrNotPopulated AND NOT RepOnFile => '-98',
																																																			 '-99');

		Rep3InputAddrNotPopulated := TRIM(le.Clean_Input.Rep3_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep3_City) = '' OR TRIM(le.Clean_Input.Rep3_State) = '' OR TRIM(le.Clean_Input.Rep3_Zip5) = '';
		Rep3ZIPScore					:= IF(le.Clean_Input.Rep3_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep3_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep3_Zip5, ri.Zip), NoScoreValue);
		Rep3CityStateScore		:= IF(le.Clean_Input.Rep3_City <> '' AND le.Clean_Input.Rep3_State <> '' AND ri.v_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep3_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep3_City, le.Clean_Input.Rep3_State, ri.v_city_name, ri.st, ''), NoScoreValue);
		Rep3InputAddrMatched := Risk_Indicators.iid_constants.ga(IF(Rep3ZIPScore = NoScoreValue AND Rep3CityStateScore = NoScoreValue, NoScoreValue,
																				Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep3_Prim_Range, le.Clean_Input.Rep3_Prim_Name, le.Clean_Input.Rep3_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep3ZIPScore, Rep3CityStateScore)));

		SELF.SBFE.SBFEBusExecLinkRep3AddronFile	:= MAP( Rep3InputAddrMatched 														=> '1',
																										NOT Rep3InputAddrNotPopulated AND RepOnFile 		=> '0',
																										NOT Rep3InputAddrNotPopulated AND NOT RepOnFile => '-98',
																																																			 '-99');

		Rep4InputAddrNotPopulated := TRIM(le.Clean_Input.Rep4_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep4_City) = '' OR TRIM(le.Clean_Input.Rep4_State) = '' OR TRIM(le.Clean_Input.Rep4_Zip5) = '';
		Rep4ZIPScore					:= IF(le.Clean_Input.Rep4_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep4_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep4_Zip5, ri.Zip), NoScoreValue);
		Rep4CityStateScore		:= IF(le.Clean_Input.Rep4_City <> '' AND le.Clean_Input.Rep4_State <> '' AND ri.v_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep4_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep4_City, le.Clean_Input.Rep4_State, ri.v_city_name, ri.st, ''), NoScoreValue);
		Rep4InputAddrMatched := Risk_Indicators.iid_constants.ga(IF(Rep4ZIPScore = NoScoreValue AND Rep4CityStateScore = NoScoreValue, NoScoreValue,
																				Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep4_Prim_Range, le.Clean_Input.Rep4_Prim_Name, le.Clean_Input.Rep4_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep4ZIPScore, Rep4CityStateScore)));

		SELF.SBFE.SBFEBusExecLinkRep4AddronFile	:= MAP( Rep4InputAddrMatched 														=> '1',
																										NOT Rep4InputAddrNotPopulated AND RepOnFile 		=> '0',
																										NOT Rep4InputAddrNotPopulated AND NOT RepOnFile => '-98',
																																																			 '-99');

		Rep5InputAddrNotPopulated := TRIM(le.Clean_Input.Rep5_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep5_City) = '' OR TRIM(le.Clean_Input.Rep5_State) = '' OR TRIM(le.Clean_Input.Rep5_Zip5) = '';
		Rep5ZIPScore					:= IF(le.Clean_Input.Rep5_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep5_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep5_Zip5, ri.Zip), NoScoreValue);
		Rep5CityStateScore		:= IF(le.Clean_Input.Rep5_City <> '' AND le.Clean_Input.Rep5_State <> '' AND ri.v_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep5_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep5_City, le.Clean_Input.Rep5_State, ri.v_city_name, ri.st, ''), NoScoreValue);
		Rep5InputAddrMatched := Risk_Indicators.iid_constants.ga(IF(Rep5ZIPScore = NoScoreValue AND Rep5CityStateScore = NoScoreValue, NoScoreValue,
																				Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep5_Prim_Range, le.Clean_Input.Rep5_Prim_Name, le.Clean_Input.Rep5_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep5ZIPScore, Rep5CityStateScore)));

		SELF.SBFE.SBFEBusExecLinkRep5AddronFile	:= MAP( Rep5InputAddrMatched 														=> '1',
																										NOT Rep5InputAddrNotPopulated AND RepOnFile 		=> '0',
																										NOT Rep5InputAddrNotPopulated AND NOT RepOnFile => '-98',
																																																			 '-99');



		Rep1InputPhonePopulated := TRIM(le.Clean_Input.Rep_Phone10) <> '';
		Rep2InputPhonePopulated := TRIM(le.Clean_Input.Rep2_Phone10) <> '';
		Rep3InputPhonePopulated := TRIM(le.Clean_Input.Rep3_Phone10) <> '';
		Rep4InputPhonePopulated := TRIM(le.Clean_Input.Rep4_Phone10) <> '';
		Rep5InputPhonePopulated := TRIM(le.Clean_Input.Rep5_Phone10) <> '';


		Rep1InputPhoneMatched := Rep1InputPhonePopulated AND (le.Clean_Input.Rep_Phone10[1] = ri.Phone_Number[1] OR le.Clean_Input.Rep_Phone10[4] = ri.Phone_Number[4] OR le.Clean_Input.Rep_Phone10[4] = ri.Phone_Number[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep_Phone10, ri.Phone_Number));
		Rep2InputPhoneMatched := Rep2InputPhonePopulated AND (le.Clean_Input.Rep2_Phone10[1] = ri.Phone_Number[1] OR le.Clean_Input.Rep2_Phone10[4] = ri.Phone_Number[4] OR le.Clean_Input.Rep2_Phone10[4] = ri.Phone_Number[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep2_Phone10, ri.Phone_Number));
		Rep3InputPhoneMatched := Rep3InputPhonePopulated AND (le.Clean_Input.Rep3_Phone10[1] = ri.Phone_Number[1] OR le.Clean_Input.Rep3_Phone10[4] = ri.Phone_Number[4] OR le.Clean_Input.Rep3_Phone10[4] = ri.Phone_Number[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep3_Phone10, ri.Phone_Number));
		Rep4InputPhoneMatched := Rep4InputPhonePopulated AND (le.Clean_Input.Rep4_Phone10[1] = ri.Phone_Number[1] OR le.Clean_Input.Rep4_Phone10[4] = ri.Phone_Number[4] OR le.Clean_Input.Rep4_Phone10[4] = ri.Phone_Number[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep4_Phone10, ri.Phone_Number));
		Rep5InputPhoneMatched := Rep5InputPhonePopulated AND (le.Clean_Input.Rep5_Phone10[1] = ri.Phone_Number[1] OR le.Clean_Input.Rep5_Phone10[4] = ri.Phone_Number[4] OR le.Clean_Input.Rep5_Phone10[4] = ri.Phone_Number[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep5_Phone10, ri.Phone_Number));

		SELF.SBFE.SBFEBusExecLinkRep1PhoneonFile := MAP(Rep1InputPhoneMatched 										=> '1',
																										Rep1InputPhonePopulated AND RepOnFile			=> '0',
																										Rep1InputPhonePopulated AND NOT RepOnFile	=> '-98',
																																																 '-99');

		SELF.SBFE.SBFEBusExecLinkRep2PhoneonFile := MAP(Rep2InputPhoneMatched 										=> '1',
																										Rep2InputPhonePopulated AND RepOnFile			=> '0',
																										Rep2InputPhonePopulated AND NOT RepOnFile	=> '-98',
																																																 '-99');

		SELF.SBFE.SBFEBusExecLinkRep3PhoneonFile := MAP(Rep3InputPhoneMatched 										=> '1',
																										Rep3InputPhonePopulated AND RepOnFile			=> '0',
																										Rep3InputPhonePopulated AND NOT RepOnFile	=> '-98',
																																																 '-99');
			SELF.SBFE.SBFEBusExecLinkRep4PhoneonFile := MAP(Rep4InputPhoneMatched 										=> '1',
																										Rep4InputPhonePopulated AND RepOnFile			=> '0',
																										Rep4InputPhonePopulated AND NOT RepOnFile	=> '-98',
																																																 '-99');

		SELF.SBFE.SBFEBusExecLinkRep5PhoneonFile := MAP(Rep5InputPhoneMatched 										=> '1',
																										Rep5InputPhonePopulated AND RepOnFile			=> '0',
																										Rep5InputPhonePopulated AND NOT RepOnFile	=> '-98',
																																																 '-99');



		Rep1InputSSNPopulated := (INTEGER)le.Clean_Input.rep_ssn > 0;
		Rep2InputSSNPopulated := (INTEGER)le.Clean_Input.rep2_ssn > 0;
		Rep3InputSSNPopulated := (INTEGER)le.Clean_Input.rep3_ssn > 0;
		Rep4InputSSNPopulated := (INTEGER)le.Clean_Input.rep4_ssn > 0;
		Rep5InputSSNPopulated := (INTEGER)le.Clean_Input.rep5_ssn > 0;


		Rep1SSNLength := LENGTH(TRIM(le.Clean_Input.Rep_SSN));
		Rep2SSNLength := LENGTH(TRIM(le.Clean_Input.Rep2_SSN));
		Rep3SSNLength := LENGTH(TRIM(le.Clean_Input.Rep3_SSN));
		Rep4SSNLength := LENGTH(TRIM(le.Clean_Input.Rep4_SSN));
		Rep5SSNLength := LENGTH(TRIM(le.Clean_Input.Rep5_SSN));


		Rep1InputSSNMatched := MAP(le.Clean_Input.Rep_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep_SSN[1] = ri.federal_taxid_ssn[IF(Rep1SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep_SSN, ri.federal_taxid_ssn, Rep1SSNLength=4)),
																																																					FALSE);
		Rep2InputSSNMatched := MAP(le.Clean_Input.Rep2_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep2_SSN[1] = ri.federal_taxid_ssn[IF(Rep2SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep2_SSN, ri.federal_taxid_ssn, Rep2SSNLength=4)),
																																																					FALSE);
		Rep3InputSSNMatched := MAP(le.Clean_Input.Rep3_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep3_SSN[1] = ri.federal_taxid_ssn[IF(Rep3SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep3_SSN, ri.federal_taxid_ssn, Rep3SSNLength=4)),
																																																					FALSE);
		Rep4InputSSNMatched := MAP(le.Clean_Input.Rep4_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep4_SSN[1] = ri.federal_taxid_ssn[IF(Rep4SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep4_SSN, ri.federal_taxid_ssn, Rep4SSNLength=4)),
																																																					FALSE);
		Rep5InputSSNMatched := MAP(le.Clean_Input.Rep5_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep5_SSN[1] = ri.federal_taxid_ssn[IF(Rep5SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep5_SSN, ri.federal_taxid_ssn, Rep5SSNLength=4)),
																																																					FALSE);

		SELF.SBFE.SBFEBusExecLinkRep1SSNonFile := MAP( Rep1InputSSNMatched 			 								=> '1',
																									 Rep1InputSSNPopulated AND RepOnFile 		 	=> '0',
																									 Rep1InputSSNPopulated AND  NOT RepOnFile => '-98',
																																															 '-99');

		SELF.SBFE.SBFEBusExecLinkRep2SSNonFile := MAP( Rep2InputSSNMatched 			 								=> '1',
																									 Rep2InputSSNPopulated AND RepOnFile 		 	=> '0',
																									 Rep2InputSSNPopulated AND  NOT RepOnFile => '-98',
																																															 '-99');

		SELF.SBFE.SBFEBusExecLinkRep3SSNonFile := MAP( Rep3InputSSNMatched 			 								=> '1',
																									 Rep3InputSSNPopulated AND RepOnFile 		 	=> '0',
																									 Rep3InputSSNPopulated AND  NOT RepOnFile => '-98',
																																															 '-99');
		SELF.SBFE.SBFEBusExecLinkRep4SSNonFile := MAP( Rep4InputSSNMatched 			 								=> '1',
																									 Rep4InputSSNPopulated AND RepOnFile 		 	=> '0',
																									 Rep4InputSSNPopulated AND  NOT RepOnFile => '-98',
																																															 '-99');

		SELF.SBFE.SBFEBusExecLinkRep5SSNonFile := MAP( Rep5InputSSNMatched 			 								=> '1',
																									 Rep5InputSSNPopulated AND RepOnFile 		 	=> '0',
																									 Rep5InputSSNPopulated AND  NOT RepOnFile => '-98',
																																															 '-99');

		SELF := le;
	END;

	SBFEPersonVerification := SORT(JOIN(SBFEVerificationRolled, BusinessInformation_recs(record_type='IS'), LEFT.seq = RIGHT.seq,
														verifyPersonElements(LEFT,RIGHT),
														LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader)),Seq);


	Business_Risk_BIP.Layouts.Shell	rollSBFEPersonVerification(SBFEPersonVerification le, SBFEPersonVerification ri) := TRANSFORM
		SELF.SBFE.SBFEBusExecLinkRep1NameonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep1NameonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep1NameonFile );
		SELF.SBFE.SBFEBusExecLinkRep1AddronFile	:= (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep1AddronFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep1AddronFile );
		SELF.SBFE.SBFEBusExecLinkRep1PhoneonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep1PhoneonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep1PhoneonFile );
		SELF.SBFE.SBFEBusExecLinkRep1SSNonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep1SSNonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep1SSNonFile );

		SELF.SBFE.SBFEBusExecLinkRep2NameonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep2NameonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep2NameonFile );
		SELF.SBFE.SBFEBusExecLinkRep2AddronFile	:= (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep2AddronFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep2AddronFile );
		SELF.SBFE.SBFEBusExecLinkRep2PhoneonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep2PhoneonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep2PhoneonFile );
		SELF.SBFE.SBFEBusExecLinkRep2SSNonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep2SSNonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep2SSNonFile );

		SELF.SBFE.SBFEBusExecLinkRep3NameonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep3NameonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep3NameonFile );
		SELF.SBFE.SBFEBusExecLinkRep3AddronFile	:= (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep3AddronFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep3AddronFile );
		SELF.SBFE.SBFEBusExecLinkRep3PhoneonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep3PhoneonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep3PhoneonFile );
		SELF.SBFE.SBFEBusExecLinkRep3SSNonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep3SSNonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep3SSNonFile );

		SELF.SBFE.SBFEBusExecLinkRep4NameonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep4NameonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep4NameonFile );
		SELF.SBFE.SBFEBusExecLinkRep4AddronFile	:= (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep4AddronFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep4AddronFile );
		SELF.SBFE.SBFEBusExecLinkRep4PhoneonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep4PhoneonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep4PhoneonFile );
		SELF.SBFE.SBFEBusExecLinkRep4SSNonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep4SSNonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep4SSNonFile );

		SELF.SBFE.SBFEBusExecLinkRep5NameonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep5NameonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep5NameonFile );
		SELF.SBFE.SBFEBusExecLinkRep5AddronFile	:= (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep5AddronFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep5AddronFile );
		SELF.SBFE.SBFEBusExecLinkRep5PhoneonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep5PhoneonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep5PhoneonFile );
		SELF.SBFE.SBFEBusExecLinkRep5SSNonFile := (STRING)MAX((INTEGER)le.SBFE.SBFEBusExecLinkRep5SSNonFile , (INTEGER)ri.SBFE.SBFEBusExecLinkRep5SSNonFile );
		SELF := le;


	END;

	SBFEPersonVerificationRolled := ROLLUP(SBFEPersonVerification, LEFT.Seq = RIGHT.Seq, rollSBFEPersonVerification(LEFT, RIGHT));

	capNum(field, maxNum) := MIN(field, maxNum);

	SBFE_recs_added :=
		JOIN(SBFEPersonVerificationRolled, SBFE_data,
			LEFT.seq = RIGHT.UID,
			TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				dateToday := IF(((STRING)LEFT.Clean_Input.HistoryDateTime)[1..6] = '999999', STD.Date.Today(), (UNSIGNED4)((((STRING)LEFT.Clean_Input.HistoryDateTime) + '01')[1..8]));

				SBFENameMatchDateFirstSeen := IF(LEFT.SBFE.SBFENameMatchDateFirstSeen ='', '-98', LEFT.SBFE.SBFENameMatchDateFirstSeen);
				SELF.SBFE.SBFENameMatchDateFirstSeen := SBFENameMatchDateFirstSeen;
				SBFENameMatchMonthsFirstSeen := IF((INTEGER)SBFENameMatchDateFirstSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFENameMatchDateFirstSeen, dateToday) + 1, (INTEGER)SBFENameMatchDateFirstSeen);
				SELF.SBFE.SBFENameMatchMonthsFirstSeen := (STRING)capNum(SBFENameMatchMonthsFirstSeen, 600);

				SBFENameMatchDateLastSeen := IF(LEFT.SBFE.SBFENameMatchDateLastSeen ='', '-98', LEFT.SBFE.SBFENameMatchDateLastSeen);
				SELF.SBFE.SBFENameMatchDateLastSeen := SBFENameMatchDateLastSeen;
				SBFENameMatchMonthsLastSeen := IF((INTEGER)SBFENameMatchDateLastSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFENameMatchDateLastSeen, dateToday) + 1, (INTEGER)SBFENameMatchDateLastSeen);
				SELF.SBFE.SBFENameMatchMonthsLastSeen := (STRING)capNum(SBFENameMatchMonthsLastSeen, 600);

				SBFEAddrMatchDateFirstSeen := IF(LEFT.SBFE.SBFEAddrMatchDateFirstSeen ='', '-98', LEFT.SBFE.SBFEAddrMatchDateFirstSeen);
				SELF.SBFE.SBFEAddrMatchDateFirstSeen := SBFEAddrMatchDateFirstSeen;
				SBFEAddrMatchMonthsFirstSeen := IF((INTEGER)SBFEAddrMatchDateFirstSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFEAddrMatchDateFirstSeen, dateToday) + 1, (INTEGER)SBFEAddrMatchDateFirstSeen);
				SELF.SBFE.SBFEAddrMatchMonthsFirstSeen := (STRING)capNum(SBFEAddrMatchMonthsFirstSeen, 600);

				SBFEAddrMatchDateLastSeen := IF(LEFT.SBFE.SBFEAddrMatchDateLastSeen ='', '-98', LEFT.SBFE.SBFEAddrMatchDateLastSeen);
				SELF.SBFE.SBFEAddrMatchDateLastSeen := SBFEAddrMatchDateLastSeen;
				SBFEAddrMatchMonthsLastSeen := IF((INTEGER)SBFEAddrMatchDateLastSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFEAddrMatchDateLastSeen, dateToday) + 1, (INTEGER)SBFEAddrMatchDateLastSeen);
				SELF.SBFE.SBFEAddrMatchMonthsLastSeen := (STRING)capNum(SBFEAddrMatchMonthsLastSeen, 600);

				SBFEPhoneMatchDateFirstSeen := IF(LEFT.SBFE.SBFEPhoneMatchDateFirstSeen ='', '-98', LEFT.SBFE.SBFEPhoneMatchDateFirstSeen);
				SELF.SBFE.SBFEPhoneMatchDateFirstSeen := SBFEPhoneMatchDateFirstSeen;
				SBFEPhoneMatchMonthsFirstSeen := IF((INTEGER)SBFEPhoneMatchDateFirstSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFEPhoneMatchDateFirstSeen, dateToday) + 1, (INTEGER)SBFEPhoneMatchDateFirstSeen);
				SELF.SBFE.SBFEPhoneMatchMonthsFirstSeen := (STRING)capNum(SBFEPhoneMatchMonthsFirstSeen, 600);

				SBFEPhoneMatchDateLastSeen := IF(LEFT.SBFE.SBFEPhoneMatchDateLastSeen ='', '-98', LEFT.SBFE.SBFEPhoneMatchDateLastSeen);
				SELF.SBFE.SBFEPhoneMatchDateLastSeen := IF(LEFT.SBFE.SBFEPhoneMatchDateLastSeen ='', '-98', LEFT.SBFE.SBFEPhoneMatchDateLastSeen);
				SBFEPhoneMatchMonthsLastSeen := IF((INTEGER)SBFEPhoneMatchDateLastSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFEPhoneMatchDateLastSeen, dateToday) + 1, (INTEGER)SBFEPhoneMatchDateLastSeen);
				SELF.SBFE.SBFEPhoneMatchMonthsLastSeen := (STRING)capNum(SBFEPhoneMatchMonthsLastSeen, 600);

				SBFEFEINMatchDateFirstSeen := IF(LEFT.SBFE.SBFEFEINMatchDateFirstSeen ='', '-98', LEFT.SBFE.SBFEFEINMatchDateFirstSeen);
				SELF.SBFE.SBFEFEINMatchDateFirstSeen := SBFEFEINMatchDateFirstSeen;
				SBFEFEINMatchMonthsFirstSeen := IF((INTEGER)SBFEFEINMatchDateFirstSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFEFEINMatchDateFirstSeen, dateToday) + 1, (INTEGER)SBFEFEINMatchDateFirstSeen);
				SELF.SBFE.SBFEFEINMatchMonthsFirstSeen := (STRING)capNum(SBFEFEINMatchMonthsFirstSeen, 600);

				SBFEFEINMatchDateLastSeen := IF(LEFT.SBFE.SBFEFEINMatchDateLastSeen ='', '-98', LEFT.SBFE.SBFEFEINMatchDateLastSeen);
				SELF.SBFE.SBFEFEINMatchDateLastSeen := SBFEFEINMatchDateLastSeen;
				SBFEFEINMatchMonthsLastSeen := IF((INTEGER)SBFEFEINMatchDateLastSeen > 0, STD.DATE.MonthsBetween((UNSIGNED)SBFEFEINMatchDateLastSeen, dateToday) + 1, (INTEGER)SBFEFEINMatchDateLastSeen);
				SELF.SBFE.SBFEFEINMatchMonthsLastSeen := (STRING)capNum(SBFEFEINMatchMonthsLastSeen, 600);

				SELF.SBFE.SBFEBusExecLinkRep1NameonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep1NameonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep1NameonFile);
				SELF.SBFE.SBFEBusExecLinkRep1AddronFile := IF(LEFT.SBFE.SBFEBusExecLinkRep1AddronFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep1AddronFile);
				SELF.SBFE.SBFEBusExecLinkRep1PhoneonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep1PhoneonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep1PhoneonFile);
				SELF.SBFE.SBFEBusExecLinkRep1SSNonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep1SSNonFile='','-98', LEFT.SBFE.SBFEBusExecLinkRep1SSNonFile);
				SELF.SBFE.SBFEBusExecLinkRep2NameonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep2NameonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep2NameonFile);
				SELF.SBFE.SBFEBusExecLinkRep2AddronFile := IF(LEFT.SBFE.SBFEBusExecLinkRep2AddronFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep2AddronFile);
				SELF.SBFE.SBFEBusExecLinkRep2PhoneonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep2PhoneonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep2PhoneonFile);
				SELF.SBFE.SBFEBusExecLinkRep2SSNonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep2SSNonFile='','-98', LEFT.SBFE.SBFEBusExecLinkRep2SSNonFile);
				SELF.SBFE.SBFEBusExecLinkRep3NameonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep3NameonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep3NameonFile);
				SELF.SBFE.SBFEBusExecLinkRep3AddronFile := IF(LEFT.SBFE.SBFEBusExecLinkRep3AddronFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep3AddronFile);
				SELF.SBFE.SBFEBusExecLinkRep3PhoneonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep3PhoneonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep3PhoneonFile);
				SELF.SBFE.SBFEBusExecLinkRep3SSNonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep3SSNonFile='','-98', LEFT.SBFE.SBFEBusExecLinkRep3SSNonFile);
				SELF.SBFE.SBFEBusExecLinkRep4NameonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep4NameonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep4NameonFile);
				SELF.SBFE.SBFEBusExecLinkRep4AddronFile := IF(LEFT.SBFE.SBFEBusExecLinkRep4AddronFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep4AddronFile);
				SELF.SBFE.SBFEBusExecLinkRep4PhoneonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep4PhoneonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep4PhoneonFile);
				SELF.SBFE.SBFEBusExecLinkRep4SSNonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep4SSNonFile='','-98', LEFT.SBFE.SBFEBusExecLinkRep4SSNonFile);
				SELF.SBFE.SBFEBusExecLinkRep5NameonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep5NameonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep5NameonFile);
				SELF.SBFE.SBFEBusExecLinkRep5AddronFile := IF(LEFT.SBFE.SBFEBusExecLinkRep5AddronFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep5AddronFile);
				SELF.SBFE.SBFEBusExecLinkRep5PhoneonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep5PhoneonFile='', '-98', LEFT.SBFE.SBFEBusExecLinkRep5PhoneonFile);
				SELF.SBFE.SBFEBusExecLinkRep5SSNonFile := IF(LEFT.SBFE.SBFEBusExecLinkRep5SSNonFile='','-98', LEFT.SBFE.SBFEBusExecLinkRep5SSNonFile);



				SELF.SBFE.SBFEDateFirstCycleAll := (STRING)RIGHT.SBFEDateFirstCycleAll_,
				SELF.SBFE.SBFETimeOldestCycle := (STRING)capNum(RIGHT.SBFETimeOldestCycle_, 600);
				SELF.SBFE.SBFEDateLastCycleAll := (STRING)RIGHT.SBFEDateLastCycleAll_,
				SELF.SBFE.SBFETimeNewestCycle := (STRING)capNum(RIGHT.SBFETimeNewestCycle_, 600);
				SELF.SBFE.SBFEAccountCount := (STRING)capNum(RIGHT.SBFEAccountCount_, 999),
				SELF.SBFE.SBFEAccountCount12M := (STRING)capNum(RIGHT.SBFEAccountCount12M_, 999),
				SELF.SBFE.SBFEOpenCount03M := (STRING)capNum(RIGHT.SBFEOpenCount03M_, 99);
				SELF.SBFE.SBFEOpenCount06Month := (STRING)capNum(RIGHT.SBFEOpenCount06Month_, 99),
				SELF.SBFE.SBFEOpenCount12Month := (STRING)capNum(RIGHT.SBFEOpenCount12Month_, 99),
				SELF.SBFE.SBFEOpenCount24Month := (STRING)capNum(RIGHT.SBFEOpenCount24Month_, 99),
				SELF.SBFE.SBFEOpenCount36Month := (STRING)capNum(RIGHT.SBFEOpenCount36Month_, 99),
				SELF.SBFE.SBFEOpenCount60Month := (STRING)capNum(RIGHT.SBFEOpenCount60Month_, 99),
				SELF.SBFE.SBFEOpenCount84M := (STRING)capNum(RIGHT.SBFEOpenCount84M_, 99);
				SELF.SBFE.SBFEDateOpenFirstSeenAll := (STRING)RIGHT.SBFEDateOpenFirstSeenAll_,
				SELF.SBFE.SBFETimeOldest := (STRING)capNum(RIGHT.SBFETimeOldest_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentAll := (STRING)RIGHT.SBFEDateOpenMostRecentAll_,
				SELF.SBFE.SBFETimeNewest := (STRING)capNum(RIGHT.SBFETimeNewest_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentAll := (STRING)RIGHT.SBFEDateClosedMostRecentAll_,
				SELF.SBFE.SBFETimeNewestClosed := (STRING)capNum(RIGHT.SBFETimeNewestClosed_, 600);
				SELF.SBFE.SBFELoanCount := (STRING)capNum(RIGHT.SBFELoanCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenLoan := (STRING)RIGHT.SBFEDateOpenFirstSeenLoan_,
				SELF.SBFE.SBFETimeOldestLoan := (STRING)capNum(RIGHT.SBFETimeOldestLoan_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentLoan := (STRING)RIGHT.SBFEDateOpenMostRecentLoan_,
				SELF.SBFE.SBFETimeNewestLoan := (STRING)capNum(RIGHT.SBFETimeNewestLoan_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentLoan := (STRING)RIGHT.SBFEDateClosedMostRecentLoan_,
				SELF.SBFE.SBFETimeNewestClosedLoan := (STRING)capNum(RIGHT.SBFETimeNewestClosedLoan_, 600);
				SELF.SBFE.SBFELineCount := (STRING)capNum(RIGHT.SBFELineCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenLine := (STRING)RIGHT.SBFEDateOpenFirstSeenLine_,
				SELF.SBFE.SBFETimeOldestLine := (STRING)capNum(RIGHT.SBFETimeOldestLine_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentLine := (STRING)RIGHT.SBFEDateOpenMostRecentLine_,
				SELF.SBFE.SBFETimeNewestLine := (STRING)capNum(RIGHT.SBFETimeNewestLine_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentLine := (STRING)RIGHT.SBFEDateClosedMostRecentLine_,
				SELF.SBFE.SBFETimeNewestClosedLine := (STRING)capNum(RIGHT.SBFETimeNewestClosedLine_, 600);
				SELF.SBFE.SBFECardCount := (STRING)capNum(RIGHT.SBFECardCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenCard := (STRING)RIGHT.SBFEDateOpenFirstSeenCard_,
				SELF.SBFE.SBFETimeOldestCard := (STRING)capNum(RIGHT.SBFETimeOldestCard_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentCard := (STRING)RIGHT.SBFEDateOpenMostRecentCard_,
				SELF.SBFE.SBFETimeNewestCard := (STRING)capNum(RIGHT.SBFETimeNewestCard_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentCard := (STRING)RIGHT.SBFEDateClosedMostRecentCard_,
				SELF.SBFE.SBFETimeNewestClosedCard := (STRING)capNum(RIGHT.SBFETimeNewestClosedCard_, 600);
				SELF.SBFE.SBFELeaseCount := (STRING)capNum(RIGHT.SBFELeaseCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenLease := (STRING)RIGHT.SBFEDateOpenFirstSeenLease_,
				SELF.SBFE.SBFETimeOldestLease := (STRING)capNum(RIGHT.SBFETimeOldestLease_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentLease := (STRING)RIGHT.SBFEDateOpenMostRecentLease_,
				SELF.SBFE.SBFETimeNewestLease := (STRING)capNum(RIGHT.SBFETimeNewestLease_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentLease := (STRING)RIGHT.SBFEDateClosedMostRecentLease_,
				SELF.SBFE.SBFETimeNewestClosedLease := (STRING)capNum(RIGHT.SBFETimeNewestClosedLease_, 600);
				SELF.SBFE.SBFELetterCount := (STRING)capNum(RIGHT.SBFELetterCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenLetter := (STRING)RIGHT.SBFEDateOpenFirstSeenLetter_,
				SELF.SBFE.SBFETimeOldestLetter := (STRING)capNum(RIGHT.SBFETimeOldestLetter_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentLetter := (STRING)RIGHT.SBFEDateOpenMostRecentLetter_,
				SELF.SBFE.SBFETimeNewestLetter := (STRING)capNum(RIGHT.SBFETimeNewestLetter_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentLetter := (STRING)RIGHT.SBFEDateClosedMostRecentLetter_,
				SELF.SBFE.SBFETimeNewestClosedLetter := (STRING)capNum(RIGHT.SBFETimeNewestClosedLetter_, 600);
				SELF.SBFE.SBFEOLineCount := (STRING)capNum(RIGHT.SBFEOLineCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenOLine := (STRING)RIGHT.SBFEDateOpenFirstSeenOLine_,
				SELF.SBFE.SBFETimeOldestOELine := (STRING)capNum(RIGHT.SBFETimeOldestOELine_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentOLine := (STRING)RIGHT.SBFEDateOpenMostRecentOLine_,
				SELF.SBFE.SBFETimeNewestOELine := (STRING)capNum(RIGHT.SBFETimeNewestOELine_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentOLine := (STRING)RIGHT.SBFEDateClosedMostRecentOLine_,
				SELF.SBFE.SBFETimeNewestClosedOELine := (STRING)capNum(RIGHT.SBFETimeNewestClosedOELine_, 600);
				SELF.SBFE.SBFEOtherCount := (STRING)capNum(RIGHT.SBFEOtherCount_, 99),
				SELF.SBFE.SBFEDateOpenFirstSeenOther := (STRING)RIGHT.SBFEDateOpenFirstSeenOther_,
				SELF.SBFE.SBFETimeOldestOther := (STRING)capNum(RIGHT.SBFETimeOldestOther_, 600);
				SELF.SBFE.SBFEDateOpenMostRecentOther := (STRING)RIGHT.SBFEDateOpenMostRecentOther_,
				SELF.SBFE.SBFETimeNewestOther := (STRING)capNum(RIGHT.SBFETimeNewestOther_, 600);
				SELF.SBFE.SBFEDateClosedMostRecentOther := (STRING)RIGHT.SBFEDateClosedMostRecentOther_,
				SELF.SBFE.SBFETimeNewestClosedOther := (STRING)capNum(RIGHT.SBFETimeNewestClosedOther_, 600);
				SELF.SBFE.SBFEOpenAllCount := (STRING)capNum(RIGHT.SBFEOpenAllCount_, 999),
				SELF.SBFE.SBFEOpenCountHist03M := (STRING)capNum(RIGHT.SBFEOpenCountHist03M_, 999);
				SELF.SBFE.SBFEOpenCountHist06M := (STRING)capNum(RIGHT.SBFEOpenCountHist06M_, 999);
				SELF.SBFE.SBFEOpenCountHist12M := (STRING)capNum(RIGHT.SBFEOpenCountHist12M_, 999);
				SELF.SBFE.SBFEOpenCountHist24M := (STRING)capNum(RIGHT.SBFEOpenCountHist24M_, 999);
				SELF.SBFE.SBFEOpenCountHist36M := (STRING)capNum(RIGHT.SBFEOpenCountHist36M_, 999);
				SELF.SBFE.SBFEOpenCountHist60M := (STRING)capNum(RIGHT.SBFEOpenCountHist60M_, 999);
				SELF.SBFE.SBFEOpenCountHist84M := (STRING)capNum(RIGHT.SBFEOpenCountHist84M_, 999);
				SELF.SBFE.SBFEOpenLoanCount := (STRING)capNum(RIGHT.SBFEOpenLoanCount_, 99),
				SELF.SBFE.SBFEOpenLoanCount03M := (STRING)capNum(RIGHT.SBFEOpenLoanCount03M_, 999);
				SELF.SBFE.SBFEOpenLoanCount06M := (STRING)capNum(RIGHT.SBFEOpenLoanCount06M_, 999);
				SELF.SBFE.SBFEOpenLoanCount12M := (STRING)capNum(RIGHT.SBFEOpenLoanCount12M_, 999);
				SELF.SBFE.SBFEOpenLoanCount24M := (STRING)capNum(RIGHT.SBFEOpenLoanCount24M_, 999);
				SELF.SBFE.SBFEOpenLoanCount36M := (STRING)capNum(RIGHT.SBFEOpenLoanCount36M_, 999);
				SELF.SBFE.SBFEOpenLoanCount60M := (STRING)capNum(RIGHT.SBFEOpenLoanCount60M_, 999);
				SELF.SBFE.SBFEOpenLoanCount84M := (STRING)capNum(RIGHT.SBFEOpenLoanCount84M_, 999);
				SELF.SBFE.SBFEOpenLineCount := (STRING)capNum(RIGHT.SBFEOpenLineCount_, 99),
				SELF.SBFE.SBFEOpenLineCount03M := (STRING)capNum(RIGHT.SBFEOpenLineCount03M_, 999);
				SELF.SBFE.SBFEOpenLineCount06M := (STRING)capNum(RIGHT.SBFEOpenLineCount06M_, 999);
				SELF.SBFE.SBFEOpenLineCount12M := (STRING)capNum(RIGHT.SBFEOpenLineCount12M_, 999);
				SELF.SBFE.SBFEOpenLineCount24M := (STRING)capNum(RIGHT.SBFEOpenLineCount24M_, 999);
				SELF.SBFE.SBFEOpenLineCount36M := (STRING)capNum(RIGHT.SBFEOpenLineCount36M_, 999);
				SELF.SBFE.SBFEOpenLineCount60M := (STRING)capNum(RIGHT.SBFEOpenLineCount60M_, 999);
				SELF.SBFE.SBFEOpenLineCount84M := (STRING)capNum(RIGHT.SBFEOpenLineCount84M_, 999);
				SELF.SBFE.SBFEOpenCardCount := (STRING)capNum(RIGHT.SBFEOpenCardCount_, 99),
				SELF.SBFE.SBFEOpenCardCount03M := (STRING)capNum(RIGHT.SBFEOpenCardCount03M_, 999);
				SELF.SBFE.SBFEOpenCardCount06M := (STRING)capNum(RIGHT.SBFEOpenCardCount06M_, 999);
				SELF.SBFE.SBFEOpenCardCount12M := (STRING)capNum(RIGHT.SBFEOpenCardCount12M_, 999);
				SELF.SBFE.SBFEOpenCardCount24M := (STRING)capNum(RIGHT.SBFEOpenCardCount24M_, 999);
				SELF.SBFE.SBFEOpenCardCount36M := (STRING)capNum(RIGHT.SBFEOpenCardCount36M_, 999);
				SELF.SBFE.SBFEOpenCardCount60M := (STRING)capNum(RIGHT.SBFEOpenCardCount60M_, 999);
				SELF.SBFE.SBFEOpenCardCount84M := (STRING)capNum(RIGHT.SBFEOpenCardCount84M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount := (STRING)capNum(RIGHT.SBFEOpenLeaseCount_, 99),
				SELF.SBFE.SBFEOpenLeaseCount03M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount03M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount06M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount06M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount12M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount12M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount24M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount24M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount36M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount36M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount60M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount60M_, 999);
				SELF.SBFE.SBFEOpenLeaseCount84M := (STRING)capNum(RIGHT.SBFEOpenLeaseCount84M_, 999);
				SELF.SBFE.SBFEOpenLetterCount := (STRING)capNum(RIGHT.SBFEOpenLetterCount_, 99),
				SELF.SBFE.SBFEOpenLetterCount03M := (STRING)capNum(RIGHT.SBFEOpenLetterCount03M_, 999);
				SELF.SBFE.SBFEOpenLetterCount06M := (STRING)capNum(RIGHT.SBFEOpenLetterCount06M_, 999);
				SELF.SBFE.SBFEOpenLetterCount12M := (STRING)capNum(RIGHT.SBFEOpenLetterCount12M_, 999);
				SELF.SBFE.SBFEOpenLetterCount24M := (STRING)capNum(RIGHT.SBFEOpenLetterCount24M_, 999);
				SELF.SBFE.SBFEOpenLetterCount36M := (STRING)capNum(RIGHT.SBFEOpenLetterCount36M_, 999);
				SELF.SBFE.SBFEOpenLetterCount60M := (STRING)capNum(RIGHT.SBFEOpenLetterCount60M_, 999);
				SELF.SBFE.SBFEOpenLetterCount84M := (STRING)capNum(RIGHT.SBFEOpenLetterCount84M_, 999);
				SELF.SBFE.SBFEOpenOLineCount := (STRING)capNum(RIGHT.SBFEOpenOLineCount_, 99),
				SELF.SBFE.SBFEOpenOELineCount03M := (STRING)capNum(RIGHT.SBFEOpenOELineCount03M_, 999);
				SELF.SBFE.SBFEOpenOELineCount06M := (STRING)capNum(RIGHT.SBFEOpenOELineCount06M_, 999);
				SELF.SBFE.SBFEOpenOELineCount12M := (STRING)capNum(RIGHT.SBFEOpenOELineCount12M_, 999);
				SELF.SBFE.SBFEOpenOELineCount24M := (STRING)capNum(RIGHT.SBFEOpenOELineCount24M_, 999);
				SELF.SBFE.SBFEOpenOELineCount36M := (STRING)capNum(RIGHT.SBFEOpenOELineCount36M_, 999);
				SELF.SBFE.SBFEOpenOELineCount60M := (STRING)capNum(RIGHT.SBFEOpenOELineCount60M_, 999);
				SELF.SBFE.SBFEOpenOELineCount84M := (STRING)capNum(RIGHT.SBFEOpenOELineCount84M_, 999);
				SELF.SBFE.SBFEOpenOtherCount := (STRING)capNum(RIGHT.SBFEOpenOtherCount_, 99),
				SELF.SBFE.SBFEOpenOtherCount03M := (STRING)capNum(RIGHT.SBFEOpenOtherCount03M_, 999);
				SELF.SBFE.SBFEOpenOtherCount06M := (STRING)capNum(RIGHT.SBFEOpenOtherCount06M_, 999);
				SELF.SBFE.SBFEOpenOtherCount12M := (STRING)capNum(RIGHT.SBFEOpenOtherCount12M_, 999);
				SELF.SBFE.SBFEOpenOtherCount24M := (STRING)capNum(RIGHT.SBFEOpenOtherCount24M_, 999);
				SELF.SBFE.SBFEOpenOtherCount36M := (STRING)capNum(RIGHT.SBFEOpenOtherCount36M_, 999);
				SELF.SBFE.SBFEOpenOtherCount60M := (STRING)capNum(RIGHT.SBFEOpenOtherCount60M_, 999);
				SELF.SBFE.SBFEOpenOtherCount84M := (STRING)capNum(RIGHT.SBFEOpenOtherCount84M_, 999);
				SELF.SBFE.SBFEOpenTypeCount := (STRING)RIGHT.SBFEOpenTypeCount_,
				SELF.SBFE.SBFEOpenCardCountOnly := (STRING)RIGHT.SBFEOpenCardCountOnly_,
				SELF.SBFE.SBFEActiveCount := (STRING)capNum(RIGHT.SBFEActiveCount_, 999),
				SELF.SBFE.SBFEActiveLoanCount := (STRING)capNum(RIGHT.SBFEActiveLoanCount_, 99),
				SELF.SBFE.SBFEActiveLineCount := (STRING)capNum(RIGHT.SBFEActiveLineCount_, 99),
				SELF.SBFE.SBFEActiveCardCount := (STRING)capNum(RIGHT.SBFEActiveCardCount_, 99),
				SELF.SBFE.SBFEActiveLeaseCount := (STRING)capNum(RIGHT.SBFEActiveLeaseCount_, 99),
				SELF.SBFE.SBFEActiveLetterCount := (STRING)capNum(RIGHT.SBFEActiveLetterCount_, 99),
				SELF.SBFE.SBFEActiveOLine := (STRING)capNum(RIGHT.SBFEActiveOLine_, 99),
				SELF.SBFE.SBFEActiveOtherCount := (STRING)capNum(RIGHT.SBFEActiveOtherCount_, 99),
				SELF.SBFE.SBFEClosedCount := (STRING)capNum(RIGHT.SBFEClosedCount_, 999),
				SELF.SBFE.SBFEClosedCountLoan := (STRING)capNum(RIGHT.SBFEClosedCountLoan_, 99),
				SELF.SBFE.SBFEClosedCountLine := (STRING)capNum(RIGHT.SBFEClosedCountLine_, 99),
				SELF.SBFE.SBFEClosedCountCard := (STRING)capNum(RIGHT.SBFEClosedCountCard_, 99),
				SELF.SBFE.SBFEClosedCountLease := (STRING)capNum(RIGHT.SBFEClosedCountLease_, 99),
				SELF.SBFE.SBFEClosedCountLetter := (STRING)capNum(RIGHT.SBFEClosedCountLetter_, 99),
				SELF.SBFE.SBFEClosedCountOline := (STRING)capNum(RIGHT.SBFEClosedCountOline_, 99),
				SELF.SBFE.SBFEClosedCountOther := (STRING)capNum(RIGHT.SBFEClosedCountOther_, 99),
				SELF.SBFE.SBFEClosedCountInvoluntary := (STRING)capNum(RIGHT.SBFEClosedCountInvoluntary_, 99),
				SELF.SBFE.SBFEClosedCountVoluntary := (STRING)capNum(RIGHT.SBFEClosedCountVoluntary_, 99),
				SELF.SBFE.SBFEStaleClosedCount := (STRING)capNum(RIGHT.SBFEStaleClosedCount_, 99),
				SELF.SBFE.SBFEStaleClosedCountLoan := (STRING)capNum(RIGHT.SBFEStaleClosedCountLoan_, 99),
				SELF.SBFE.SBFEStaleClosedCountLine := (STRING)capNum(RIGHT.SBFEStaleClosedCountLine_, 99),
				SELF.SBFE.SBFEStaleClosedCountCard := (STRING)capNum(RIGHT.SBFEStaleClosedCountCard_, 99),
				SELF.SBFE.SBFEStaleClosedCountLease := (STRING)capNum(RIGHT.SBFEStaleClosedCountLease_, 99),
				SELF.SBFE.SBFEStaleClosedCountLetter := (STRING)capNum(RIGHT.SBFEStaleClosedCountLetter_, 99),
				SELF.SBFE.SBFEStaleClosedCountOLine := (STRING)capNum(RIGHT.SBFEStaleClosedCountOLine_, 99),
				SELF.SBFE.SBFEStaleClosedCountOther := (STRING)capNum(RIGHT.SBFEStaleClosedCountOther_, 99),
				SELF.SBFE.SBFEInactiveCount := (STRING)capNum(RIGHT.SBFEInactiveCount_, 99),
				SELF.SBFE.SBFEInactiveLoanCount := (STRING)capNum(RIGHT.SBFEInactiveLoanCount_, 99),
				SELF.SBFE.SBFEInactiveLineCount := (STRING)capNum(RIGHT.SBFEInactiveLineCount_, 99),
				SELF.SBFE.SBFEInactiveCardCount := (STRING)capNum(RIGHT.SBFEInactiveCardCount_, 99),
				SELF.SBFE.SBFEInactiveLeaseCount := (STRING)capNum(RIGHT.SBFEInactiveLeaseCount_, 99),
				SELF.SBFE.SBFEInactiveLetterCount := (STRING)capNum(RIGHT.SBFEInactiveLetterCount_, 99),
				SELF.SBFE.SBFEInactiveOLineCount := (STRING)capNum(RIGHT.SBFEInactiveOLineCount_, 99),
				SELF.SBFE.SBFEInactiveOtherCount := (STRING)capNum(RIGHT.SBFEInactiveOtherCount_, 99),
				SELF.SBFE.SBFERecentBalanceAll := (STRING)capNum(RIGHT.SBFERecentBalanceAll_, 99999999),
				SELF.SBFE.SBFERecentBalanceLoan := (STRING)capNum(RIGHT.SBFERecentBalanceLoan_, 99999999),
				SELF.SBFE.SBFERecentBalanceLine := (STRING)capNum(RIGHT.SBFERecentBalanceLine_, 99999999),
				SELF.SBFE.SBFERecentBalanceCard := (STRING)capNum(RIGHT.SBFERecentBalanceCard_, 99999999),
				SELF.SBFE.SBFERecentBalanceLease := (STRING)capNum(RIGHT.SBFERecentBalanceLease_, 99999999),
				SELF.SBFE.SBFERecentBalanceLetter := (STRING)capNum(RIGHT.SBFERecentBalanceLetter_, 99999999),
				SELF.SBFE.SBFERecentBalanceOLine := (STRING)capNum(RIGHT.SBFERecentBalanceOLine_, 99999999),
				SELF.SBFE.SBFERecentBalanceOther := (STRING)capNum(RIGHT.SBFERecentBalanceOther_, 99999999),
				SELF.SBFE.SBFERecentBalanceRevAmt := (STRING)capNum(RIGHT.SBFERecentBalanceRevAmt_, 99999999),
				SELF.SBFE.SBFERecentBalanceInstAmt := (STRING)capNum(RIGHT.SBFERecentBalanceInstAmt_, 99999999),
				SELF.SBFE.SBFEBalanceAmt03M := (STRING)capNum(RIGHT.SBFEBalanceAmt03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmt06M := (STRING)capNum(RIGHT.SBFEBalanceAmt06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmt12M := (STRING)capNum(RIGHT.SBFEBalanceAmt12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmt24M := (STRING)capNum(RIGHT.SBFEBalanceAmt24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmt36M := (STRING)capNum(RIGHT.SBFEBalanceAmt36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmt60M := (STRING)capNum(RIGHT.SBFEBalanceAmt60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmt84M := (STRING)capNum(RIGHT.SBFEBalanceAmt84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan03M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan06M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan12M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan24M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan36M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan60M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLoan84M := (STRING)capNum(RIGHT.SBFEBalanceAmtLoan84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine03M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine06M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine12M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine24M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine36M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine60M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLine84M := (STRING)capNum(RIGHT.SBFEBalanceAmtLine84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard03M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard06M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard12M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard24M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard36M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard60M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtCard84M := (STRING)capNum(RIGHT.SBFEBalanceAmtCard84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease03M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease06M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease12M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease24M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease36M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease60M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLease84M := (STRING)capNum(RIGHT.SBFEBalanceAmtLease84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter03M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter06M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter12M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter24M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter36M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter60M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtLetter84M := (STRING)capNum(RIGHT.SBFEBalanceAmtLetter84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine03M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine06M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine12M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine24M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine36M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine60M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOELine84M := (STRING)capNum(RIGHT.SBFEBalanceAmtOELine84M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther03M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther03M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther06M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther06M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther12M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther12M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther24M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther24M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther36M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther36M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther60M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther60M_, 99999999);
				SELF.SBFE.SBFEBalanceAmtOther84M := (STRING)capNum(RIGHT.SBFEBalanceAmtOther84M_, 99999999);
				SELF.SBFE.SBFEAvgBalance03M := (STRING)capNum(RIGHT.SBFEAvgBalance03M_, 99999999);
				SELF.SBFE.SBFEAveBalance06 := (STRING)capNum(RIGHT.Sbfeavebalance06_, 99999999),
				SELF.SBFE.SBFEAveBalance12 := (STRING)capNum(RIGHT.Sbfeavebalance12_, 99999999),
				SELF.SBFE.SBFEAveBalance24 := (STRING)capNum(RIGHT.Sbfeavebalance24_, 99999999),
				SELF.SBFE.SBFEAveBalance36 := (STRING)capNum(RIGHT.Sbfeavebalance36_, 99999999),
				SELF.SBFE.SBFEAveBalance60 := (STRING)capNum(RIGHT.Sbfeavebalance60_, 99999999),
				SELF.SBFE.SBFEAveBalance84 := (STRING)capNum(RIGHT.Sbfeavebalance84_, 99999999),
				SELF.SBFE.SBFEAveBalanceEver := (STRING)capNum(RIGHT.Sbfeavebalanceever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceLoan03M := (STRING)capNum(RIGHT.SBFEAvgBalanceLoan03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceLoan06 := (STRING)capNum(RIGHT.Sbfeavebalanceloan06_, 99999999),
				SELF.SBFE.SBFEAveBalanceLoan12 := (STRING)capNum(RIGHT.Sbfeavebalanceloan12_, 99999999),
				SELF.SBFE.SBFEAveBalanceLoan24 := (STRING)capNum(RIGHT.Sbfeavebalanceloan24_, 99999999),
				SELF.SBFE.SBFEAveBalanceLoan36 := (STRING)capNum(RIGHT.Sbfeavebalanceloan36_, 99999999),
				SELF.SBFE.SBFEAveBalanceLoan60 := (STRING)capNum(RIGHT.Sbfeavebalanceloan60_, 99999999),
				SELF.SBFE.SBFEAveBalanceLoan84 := (STRING)capNum(RIGHT.Sbfeavebalanceloan84_, 99999999),
				SELF.SBFE.SBFEAveBalanceLoanEver := (STRING)capNum(RIGHT.Sbfeavebalanceloanever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceLine03M := (STRING)capNum(RIGHT.SBFEAvgBalanceLine03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceLine06 := (STRING)capNum(RIGHT.Sbfeavebalanceline06_, 99999999),
				SELF.SBFE.SBFEAveBalanceLine12 := (STRING)capNum(RIGHT.Sbfeavebalanceline12_, 99999999),
				SELF.SBFE.SBFEAveBalanceLine24 := (STRING)capNum(RIGHT.Sbfeavebalanceline24_, 99999999),
				SELF.SBFE.SBFEAveBalanceLine36 := (STRING)capNum(RIGHT.Sbfeavebalanceline36_, 99999999),
				SELF.SBFE.SBFEAveBalanceLine60 := (STRING)capNum(RIGHT.Sbfeavebalanceline60_, 99999999),
				SELF.SBFE.SBFEAveBalanceLine84 := (STRING)capNum(RIGHT.Sbfeavebalanceline84_, 99999999),
				SELF.SBFE.SBFEAveBalanceLineEver := (STRING)capNum(RIGHT.Sbfeavebalancelineever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceCard03M := (STRING)capNum(RIGHT.SBFEAvgBalanceCard03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceCard06 := (STRING)capNum(RIGHT.Sbfeavebalancecard06_, 99999999),
				SELF.SBFE.SBFEAveBalanceCard12 := (STRING)capNum(RIGHT.Sbfeavebalancecard12_, 99999999),
				SELF.SBFE.SBFEAveBalanceCard24 := (STRING)capNum(RIGHT.Sbfeavebalancecard24_, 99999999),
				SELF.SBFE.SBFEAveBalanceCard36 := (STRING)capNum(RIGHT.Sbfeavebalancecard36_, 99999999),
				SELF.SBFE.SBFEAveBalanceCard60 := (STRING)capNum(RIGHT.Sbfeavebalancecard60_, 99999999),
				SELF.SBFE.SBFEAveBalanceCard84 := (STRING)capNum(RIGHT.Sbfeavebalancecard84_, 99999999),
				SELF.SBFE.SBFEAveBalanceCardEver := (STRING)capNum(RIGHT.Sbfeavebalancecardever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceLease03M := (STRING)capNum(RIGHT.SBFEAvgBalanceLease03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceLease06 := (STRING)capNum(RIGHT.Sbfeavebalancelease06_, 99999999),
				SELF.SBFE.SBFEAveBalanceLease12 := (STRING)capNum(RIGHT.Sbfeavebalancelease12_, 99999999),
				SELF.SBFE.SBFEAveBalanceLease24 := (STRING)capNum(RIGHT.Sbfeavebalancelease24_, 99999999),
				SELF.SBFE.SBFEAveBalanceLease36 := (STRING)capNum(RIGHT.Sbfeavebalancelease36_, 99999999),
				SELF.SBFE.SBFEAveBalanceLease60 := (STRING)capNum(RIGHT.Sbfeavebalancelease60_, 99999999),
				SELF.SBFE.SBFEAveBalanceLease84 := (STRING)capNum(RIGHT.Sbfeavebalancelease84_, 99999999),
				SELF.SBFE.SBFEAveBalanceLeaseEver := (STRING)capNum(RIGHT.Sbfeavebalanceleaseever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceLetter03M := (STRING)capNum(RIGHT.SBFEAvgBalanceLetter03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceLetter06 := (STRING)capNum(RIGHT.Sbfeavebalanceletter06_, 99999999),
				SELF.SBFE.SBFEAveBalanceLetter12 := (STRING)capNum(RIGHT.Sbfeavebalanceletter12_, 99999999),
				SELF.SBFE.SBFEAveBalanceLetter24 := (STRING)capNum(RIGHT.Sbfeavebalanceletter24_, 99999999),
				SELF.SBFE.SBFEAveBalanceLetter36 := (STRING)capNum(RIGHT.Sbfeavebalanceletter36_, 99999999),
				SELF.SBFE.SBFEAveBalanceLetter60 := (STRING)capNum(RIGHT.Sbfeavebalanceletter60_, 99999999),
				SELF.SBFE.SBFEAveBalanceLetter84 := (STRING)capNum(RIGHT.Sbfeavebalanceletter84_, 99999999),
				SELF.SBFE.SBFEAveBalanceLetterEver := (STRING)capNum(RIGHT.Sbfeavebalanceletterever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceOELine03M := (STRING)capNum(RIGHT.SBFEAvgBalanceOELine03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceOLine06 := (STRING)capNum(RIGHT.Sbfeavebalanceoline06_, 99999999),
				SELF.SBFE.SBFEAveBalanceOLine12 := (STRING)capNum(RIGHT.Sbfeavebalanceoline12_, 99999999),
				SELF.SBFE.SBFEAveBalanceOLine24 := (STRING)capNum(RIGHT.Sbfeavebalanceoline24_, 99999999),
				SELF.SBFE.SBFEAveBalanceOLine36 := (STRING)capNum(RIGHT.Sbfeavebalanceoline36_, 99999999),
				SELF.SBFE.SBFEAveBalanceOLine60 := (STRING)capNum(RIGHT.Sbfeavebalanceoline60_, 99999999),
				SELF.SBFE.SBFEAveBalanceOLine84 := (STRING)capNum(RIGHT.Sbfeavebalanceoline84_, 99999999),
				SELF.SBFE.SBFEAveBalanceOLineEver := (STRING)capNum(RIGHT.Sbfeavebalanceolineever_, 99999999),
				SELF.SBFE.SBFEAvgBalanceOther03M := (STRING)capNum(RIGHT.SBFEAvgBalanceOther03M_, 99999999);
				SELF.SBFE.SBFEAveBalanceOther06 := (STRING)capNum(RIGHT.Sbfeavebalanceother06_, 99999999),
				SELF.SBFE.SBFEAveBalanceOther12 := (STRING)capNum(RIGHT.Sbfeavebalanceother12_, 99999999),
				SELF.SBFE.SBFEAveBalanceOther24 := (STRING)capNum(RIGHT.Sbfeavebalanceother24_, 99999999),
				SELF.SBFE.SBFEAveBalanceOther36 := (STRING)capNum(RIGHT.Sbfeavebalanceother36_, 99999999),
				SELF.SBFE.SBFEAveBalanceOther60 := (STRING)capNum(RIGHT.Sbfeavebalanceother60_, 99999999),
				SELF.SBFE.SBFEAveBalanceOther84 := (STRING)capNum(RIGHT.Sbfeavebalanceother84_, 99999999),
				SELF.SBFE.SBFEAveBalanceOtherEver := (STRING)capNum(RIGHT.Sbfeavebalanceotherever_, 99999999),
				SELF.SBFE.SBFEHighBalance03M := (STRING)capNum(RIGHT.SBFEHighBalance03M_, 99999999),
				SELF.SBFE.SBFEHighBalance06M := (STRING)capNum(RIGHT.SBFEHighBalance06M_, 99999999),
				SELF.SBFE.SBFEHighBalance12M := (STRING)capNum(RIGHT.SBFEHighBalance12M_, 99999999),
				SELF.SBFE.SBFEHighBalance24M := (STRING)capNum(RIGHT.SBFEHighBalance24M_, 99999999),
				SELF.SBFE.SBFEHighBalance36M := (STRING)capNum(RIGHT.SBFEHighBalance36M_, 99999999),
				SELF.SBFE.SBFEHighBalance60M := (STRING)capNum(RIGHT.SBFEHighBalance60M_, 99999999),
				SELF.SBFE.SBFEHighBalance84M := (STRING)capNum(RIGHT.SBFEHighBalance84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceEver := (STRING)capNum(RIGHT.SBFEHighBalanceEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan03M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan06M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan12M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan24M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan36M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan60M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoan84M := (STRING)capNum(RIGHT.SBFEHighBalanceLoan84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLoanEver := (STRING)capNum(RIGHT.SBFEHighBalanceLoanEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine03M := (STRING)capNum(RIGHT.SBFEHighBalanceLine03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine06M := (STRING)capNum(RIGHT.SBFEHighBalanceLine06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine12M := (STRING)capNum(RIGHT.SBFEHighBalanceLine12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine24M := (STRING)capNum(RIGHT.SBFEHighBalanceLine24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine36M := (STRING)capNum(RIGHT.SBFEHighBalanceLine36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine60M := (STRING)capNum(RIGHT.SBFEHighBalanceLine60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLine84M := (STRING)capNum(RIGHT.SBFEHighBalanceLine84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLineEver := (STRING)capNum(RIGHT.SBFEHighBalanceLineEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard03M := (STRING)capNum(RIGHT.SBFEHighBalanceCard03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard06M := (STRING)capNum(RIGHT.SBFEHighBalanceCard06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard12M := (STRING)capNum(RIGHT.SBFEHighBalanceCard12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard24M := (STRING)capNum(RIGHT.SBFEHighBalanceCard24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard36M := (STRING)capNum(RIGHT.SBFEHighBalanceCard36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard60M := (STRING)capNum(RIGHT.SBFEHighBalanceCard60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCard84M := (STRING)capNum(RIGHT.SBFEHighBalanceCard84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceCardEver := (STRING)capNum(RIGHT.SBFEHighBalanceCardEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease03M := (STRING)capNum(RIGHT.SBFEHighBalanceLease03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease06M := (STRING)capNum(RIGHT.SBFEHighBalanceLease06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease12M := (STRING)capNum(RIGHT.SBFEHighBalanceLease12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease24M := (STRING)capNum(RIGHT.SBFEHighBalanceLease24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease36M := (STRING)capNum(RIGHT.SBFEHighBalanceLease36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease60M := (STRING)capNum(RIGHT.SBFEHighBalanceLease60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLease84M := (STRING)capNum(RIGHT.SBFEHighBalanceLease84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLeaseEver := (STRING)capNum(RIGHT.SBFEHighBalanceLeaseEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter03M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter06M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter12M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter24M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter36M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter60M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetter84M := (STRING)capNum(RIGHT.SBFEHighBalanceLetter84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceLetterEver := (STRING)capNum(RIGHT.SBFEHighBalanceLetterEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine03M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine06M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine12M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine24M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine36M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine60M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELine84M := (STRING)capNum(RIGHT.SBFEHighBalanceOELine84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOELineEver := (STRING)capNum(RIGHT.SBFEHighBalanceOELineEver_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther03M := (STRING)capNum(RIGHT.SBFEHighBalanceOther03M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther06M := (STRING)capNum(RIGHT.SBFEHighBalanceOther06M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther12M := (STRING)capNum(RIGHT.SBFEHighBalanceOther12M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther24M := (STRING)capNum(RIGHT.SBFEHighBalanceOther24M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther36M := (STRING)capNum(RIGHT.SBFEHighBalanceOther36M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther60M := (STRING)capNum(RIGHT.SBFEHighBalanceOther60M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOther84M := (STRING)capNum(RIGHT.SBFEHighBalanceOther84M_, 99999999),
				SELF.SBFE.SBFEHighBalanceOtherEver := (STRING)capNum(RIGHT.SBFEHighBalanceOtherEver_, 99999999),
				SELF.SBFE.SBFEBalanceCount := (STRING)capNum(RIGHT.SBFEBalanceCount_, 999),
				SELF.SBFE.SBFEBalanceCount03M := (STRING)capNum(RIGHT.SBFEBalanceCount03M_, 99);
				SELF.SBFE.SBFEBalanceCount06 := (STRING)capNum(RIGHT.SBFEBalanceCount06_, 99),
				SELF.SBFE.SBFEBalanceCount12 := (STRING)capNum(RIGHT.SBFEBalanceCount12_, 99),
				SELF.SBFE.SBFEBalanceCount24 := (STRING)capNum(RIGHT.SBFEBalanceCount24_, 99),
				SELF.SBFE.SBFEBalanceCount36 := (STRING)capNum(RIGHT.SBFEBalanceCount36_, 99),
				SELF.SBFE.SBFEBalanceCount60 := (STRING)capNum(RIGHT.SBFEBalanceCount60_, 99),
				SELF.SBFE.SBFEBalanceCount84 := (STRING)capNum(RIGHT.SBFEBalanceCount84_, 99),
				SELF.SBFE.SBFEBalanceCountEver := (STRING)capNum(RIGHT.SBFEBalanceCountEver_, 99),
				SELF.SBFE.SBFEBalanceCountLoan := (STRING)capNum(RIGHT.SBFEBalanceCountLoan_, 99),
				SELF.SBFE.SBFEBalanceLoanCount03M := (STRING)capNum(RIGHT.SBFEBalanceLoanCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountLoan06 := (STRING)capNum(RIGHT.SBFEBalanceCountLoan06_, 99),
				SELF.SBFE.SBFEBalanceCountLoan12 := (STRING)capNum(RIGHT.SBFEBalanceCountLoan12_, 99),
				SELF.SBFE.SBFEBalanceCountLoan24 := (STRING)capNum(RIGHT.SBFEBalanceCountLoan24_, 99),
				SELF.SBFE.SBFEBalanceCountLoan36 := (STRING)capNum(RIGHT.SBFEBalanceCountLoan36_, 99),
				SELF.SBFE.SBFEBalanceCountLoan60 := (STRING)capNum(RIGHT.SBFEBalanceCountLoan60_, 99),
				SELF.SBFE.SBFEBalanceCountLoan84 := (STRING)capNum(RIGHT.SBFEBalanceCountLoan84_, 99),
				SELF.SBFE.SBFEBalanceCountLoanEver := (STRING)capNum(RIGHT.SBFEBalanceCountLoanEver_, 99),
				SELF.SBFE.SBFEBalanceCountLine := (STRING)capNum(RIGHT.SBFEBalanceCountLine_, 99),
				SELF.SBFE.SBFEBalanceLineCount03M := (STRING)capNum(RIGHT.SBFEBalanceLineCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountLine06 := (STRING)capNum(RIGHT.SBFEBalanceCountLine06_, 99),
				SELF.SBFE.SBFEBalanceCountLine12 := (STRING)capNum(RIGHT.SBFEBalanceCountLine12_, 99),
				SELF.SBFE.SBFEBalanceCountLine24 := (STRING)capNum(RIGHT.SBFEBalanceCountLine24_, 99),
				SELF.SBFE.SBFEBalanceCountLine36 := (STRING)capNum(RIGHT.SBFEBalanceCountLine36_, 99),
				SELF.SBFE.SBFEBalanceCountLine60 := (STRING)capNum(RIGHT.SBFEBalanceCountLine60_, 99),
				SELF.SBFE.SBFEBalanceCountLine84 := (STRING)capNum(RIGHT.SBFEBalanceCountLine84_, 99),
				SELF.SBFE.SBFEBalanceCountLineEver := (STRING)capNum(RIGHT.SBFEBalanceCountLineEver_, 99),
				SELF.SBFE.SBFEBalanceCountCard := (STRING)capNum(RIGHT.SBFEBalanceCountCard_, 99),
				SELF.SBFE.SBFEBalanceCardCount03M := (STRING)capNum(RIGHT.SBFEBalanceCardCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountCard06 := (STRING)capNum(RIGHT.SBFEBalanceCountCard06_, 99),
				SELF.SBFE.SBFEBalanceCountCard12 := (STRING)capNum(RIGHT.SBFEBalanceCountCard12_, 99),
				SELF.SBFE.SBFEBalanceCountCard24 := (STRING)capNum(RIGHT.SBFEBalanceCountCard24_, 99),
				SELF.SBFE.SBFEBalanceCountCard36 := (STRING)capNum(RIGHT.SBFEBalanceCountCard36_, 99),
				SELF.SBFE.SBFEBalanceCountCard60 := (STRING)capNum(RIGHT.SBFEBalanceCountCard60_, 99),
				SELF.SBFE.SBFEBalanceCountCard84 := (STRING)capNum(RIGHT.SBFEBalanceCountCard84_, 99),
				SELF.SBFE.SBFEBalanceCountCardEver := (STRING)capNum(RIGHT.SBFEBalanceCountCardEver_, 99),
				SELF.SBFE.SBFEBalanceCountLease := (STRING)capNum(RIGHT.SBFEBalanceCountLease_, 99),
				SELF.SBFE.SBFEBalanceLeaseCount03M := (STRING)capNum(RIGHT.SBFEBalanceLeaseCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountLease06 := (STRING)capNum(RIGHT.SBFEBalanceCountLease06_, 99),
				SELF.SBFE.SBFEBalanceCountLease12 := (STRING)capNum(RIGHT.SBFEBalanceCountLease12_, 99),
				SELF.SBFE.SBFEBalanceCountLease24 := (STRING)capNum(RIGHT.SBFEBalanceCountLease24_, 99),
				SELF.SBFE.SBFEBalanceCountLease36 := (STRING)capNum(RIGHT.SBFEBalanceCountLease36_, 99),
				SELF.SBFE.SBFEBalanceCountLease60 := (STRING)capNum(RIGHT.SBFEBalanceCountLease60_, 99),
				SELF.SBFE.SBFEBalanceCountLease84 := (STRING)capNum(RIGHT.SBFEBalanceCountLease84_, 99),
				SELF.SBFE.SBFEBalanceCountLeaseEver := (STRING)capNum(RIGHT.SBFEBalanceCountLeaseEver_, 99),
				SELF.SBFE.SBFEBalanceCountLetter := (STRING)capNum(RIGHT.SBFEBalanceCountLetter_, 99),
				SELF.SBFE.SBFEBalanceLetterCount03M := (STRING)capNum(RIGHT.SBFEBalanceLetterCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountLetter06 := (STRING)capNum(RIGHT.SBFEBalanceCountLetter06_, 99),
				SELF.SBFE.SBFEBalanceCountLetter12 := (STRING)capNum(RIGHT.SBFEBalanceCountLetter12_, 99),
				SELF.SBFE.SBFEBalanceCountLetter24 := (STRING)capNum(RIGHT.SBFEBalanceCountLetter24_, 99),
				SELF.SBFE.SBFEBalanceCountLetter36 := (STRING)capNum(RIGHT.SBFEBalanceCountLetter36_, 99),
				SELF.SBFE.SBFEBalanceCountLetter60 := (STRING)capNum(RIGHT.SBFEBalanceCountLetter60_, 99),
				SELF.SBFE.SBFEBalanceCountLetter84 := (STRING)capNum(RIGHT.SBFEBalanceCountLetter84_, 99),
				SELF.SBFE.SBFEBalanceCountLetterEver := (STRING)capNum(RIGHT.SBFEBalanceCountLetterEver_, 99),
				SELF.SBFE.SBFEBalanceCountOLine := (STRING)capNum(RIGHT.SBFEBalanceCountOLine_, 99),
				SELF.SBFE.SBFEBalanceOELineCount03M := (STRING)capNum(RIGHT.SBFEBalanceOELineCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountOLine06 := (STRING)capNum(RIGHT.SBFEBalanceCountOLine06_, 99),
				SELF.SBFE.SBFEBalanceCountOLine12 := (STRING)capNum(RIGHT.SBFEBalanceCountOLine12_, 99),
				SELF.SBFE.SBFEBalanceCountOLine24 := (STRING)capNum(RIGHT.SBFEBalanceCountOLine24_, 99),
				SELF.SBFE.SBFEBalanceCountOLine36 := (STRING)capNum(RIGHT.SBFEBalanceCountOLine36_, 99),
				SELF.SBFE.SBFEBalanceCountOLine60 := (STRING)capNum(RIGHT.SBFEBalanceCountOLine60_, 99),
				SELF.SBFE.SBFEBalanceCountOLine84 := (STRING)capNum(RIGHT.SBFEBalanceCountOLine84_, 99),
				SELF.SBFE.SBFEBalanceCountOLineEver := (STRING)capNum(RIGHT.SBFEBalanceCountOLineEver_, 99),
				SELF.SBFE.SBFEBalanceCountOther := (STRING)capNum(RIGHT.SBFEBalanceCountOther_, 99),
				SELF.SBFE.SBFEBalanceOtherCount03M := (STRING)capNum(RIGHT.SBFEBalanceOtherCount03M_, 99);
				SELF.SBFE.SBFEBalanceCountOther06 := (STRING)capNum(RIGHT.SBFEBalanceCountOther06_, 99),
				SELF.SBFE.SBFEBalanceCountOther12 := (STRING)capNum(RIGHT.SBFEBalanceCountOther12_, 99),
				SELF.SBFE.SBFEBalanceCountOther24 := (STRING)capNum(RIGHT.SBFEBalanceCountOther24_, 99),
				SELF.SBFE.SBFEBalanceCountOther36 := (STRING)capNum(RIGHT.SBFEBalanceCountOther36_, 99),
				SELF.SBFE.SBFEBalanceCountOther60 := (STRING)capNum(RIGHT.SBFEBalanceCountOther60_, 99),
				SELF.SBFE.SBFEBalanceCountOther84 := (STRING)capNum(RIGHT.SBFEBalanceCountOther84_, 99),
				SELF.SBFE.SBFEBalanceCountOtherEver := (STRING)capNum(RIGHT.SBFEBalanceCountOtherEver_, 99),
				SELF.SBFE.SBFEBalanceCountClosed := (STRING)capNum(RIGHT.SBFEBalanceCountClosed_, 99),
				SELF.SBFE.SBFEBalanceClosedCount03M := (STRING)capNum(RIGHT.SBFEBalanceClosedCount03M_, 99);
				SELF.SBFE.SBFEBalanceClosedCount06M := (STRING)capNum(RIGHT.SBFEBalanceClosedCount06M_, 99);
				SELF.SBFE.SBFEBalanceClosedCount12Month := (STRING)capNum(RIGHT.SBFEBalanceClosedCount12Month_, 99),
				SELF.SBFE.SBFEBalanceClosedCount24M := (STRING)capNum(RIGHT.SBFEBalanceClosedCount24M_, 99);
				SELF.SBFE.SBFEBalanceCard12Month := (STRING)RIGHT.SBFEBalanceCard12Month_,
				SELF.SBFE.SBFEBalanceCard24Month := (STRING)RIGHT.SBFEBalanceCard24Month_,
				SELF.SBFE.SBFEOriginalLimitInstallment := (STRING)capNum(RIGHT.SBFEOriginalLimitInstallment_, 99999999),
				SELF.SBFE.SBFEOriginalLimitLoan := (STRING)capNum(RIGHT.SBFEOriginalLimitLoan_, 99999999),
				SELF.SBFE.SBFEOriginalLimitLease := (STRING)capNum(RIGHT.SBFEOriginalLimitLease_, 99999999),
				SELF.SBFE.SBFECurrentLimitRevolving := (STRING)capNum(RIGHT.SBFECurrentLimitRevolving_, 99999999),
				SELF.SBFE.SBFELimitRevAmt03M := (STRING)capNum(RIGHT.SBFELimitRevAmt03M_, 99999999);
				SELF.SBFE.SBFELimitRevAmt06M := (STRING)capNum(RIGHT.SBFELimitRevAmt06M_, 99999999);
				SELF.SBFE.SBFELimitRevAmt12M := (STRING)capNum(RIGHT.SBFELimitRevAmt12M_, 99999999);
				SELF.SBFE.SBFELimitRevAmt24M := (STRING)capNum(RIGHT.SBFELimitRevAmt24M_, 99999999);
				SELF.SBFE.SBFELimitRevAmt36M := (STRING)capNum(RIGHT.SBFELimitRevAmt36M_, 99999999);
				SELF.SBFE.SBFELimitRevAmt60M := (STRING)capNum(RIGHT.SBFELimitRevAmt60M_, 99999999);
				SELF.SBFE.SBFELimitRevAmt84M := (STRING)capNum(RIGHT.SBFELimitRevAmt84M_, 99999999);
				SELF.SBFE.SBFECurrentLimitLine := (STRING)capNum(RIGHT.SBFECurrentLimitLine_, 99999999),
				SELF.SBFE.SBFELimitLineAmt03M := (STRING)capNum(RIGHT.SBFELimitLineAmt03M_, 99999999);
				SELF.SBFE.SBFELimitLineAmt06M := (STRING)capNum(RIGHT.SBFELimitLineAmt06M_, 99999999);
				SELF.SBFE.SBFELimitLineAmt12M := (STRING)capNum(RIGHT.SBFELimitLineAmt12M_, 99999999);
				SELF.SBFE.SBFELimitLineAmt24M := (STRING)capNum(RIGHT.SBFELimitLineAmt24M_, 99999999);
				SELF.SBFE.SBFELimitLineAmt36M := (STRING)capNum(RIGHT.SBFELimitLineAmt36M_, 99999999);
				SELF.SBFE.SBFELimitLineAmt60M := (STRING)capNum(RIGHT.SBFELimitLineAmt60M_, 99999999);
				SELF.SBFE.SBFELimitLineAmt84M := (STRING)capNum(RIGHT.SBFELimitLineAmt84M_, 99999999);
				SELF.SBFE.SBFECurrentLimitCard := (STRING)capNum(RIGHT.SBFECurrentLimitCard_, 99999999),
				SELF.SBFE.SBFELimitCardAmt03M := (STRING)capNum(RIGHT.SBFELimitCardAmt03M_, 99999999);
				SELF.SBFE.SBFELimitCardAmt06M := (STRING)capNum(RIGHT.SBFELimitCardAmt06M_, 99999999);
				SELF.SBFE.SBFELimitCardAmt12M := (STRING)capNum(RIGHT.SBFELimitCardAmt12M_, 99999999);
				SELF.SBFE.SBFELimitCardAmt24M := (STRING)capNum(RIGHT.SBFELimitCardAmt24M_, 99999999);
				SELF.SBFE.SBFELimitCardAmt36M := (STRING)capNum(RIGHT.SBFELimitCardAmt36M_, 99999999);
				SELF.SBFE.SBFELimitCardAmt60M := (STRING)capNum(RIGHT.SBFELimitCardAmt60M_, 99999999);
				SELF.SBFE.SBFELimitCardAmt84M := (STRING)capNum(RIGHT.SBFELimitCardAmt84M_, 99999999);
				SELF.SBFE.SBFECurrentLimitOLine := (STRING)capNum(RIGHT.SBFECurrentLimitOLine_, 99999999),
				SELF.SBFE.SBFELimitOELineAmt03M := (STRING)capNum(RIGHT.SBFELimitOELineAmt03M_, 99999999);
				SELF.SBFE.SBFELimitOELineAmt06M := (STRING)capNum(RIGHT.SBFELimitOELineAmt06M_, 99999999);
				SELF.SBFE.SBFELimitOELineAmt12M := (STRING)capNum(RIGHT.SBFELimitOELineAmt12M_, 99999999);
				SELF.SBFE.SBFELimitOELineAmt24M := (STRING)capNum(RIGHT.SBFELimitOELineAmt24M_, 99999999);
				SELF.SBFE.SBFELimitOELineAmt36M := (STRING)capNum(RIGHT.SBFELimitOELineAmt36M_, 99999999);
				SELF.SBFE.SBFELimitOELineAmt60M := (STRING)capNum(RIGHT.SBFELimitOELineAmt60M_, 99999999);
				SELF.SBFE.SBFELimitOELineAmt84M := (STRING)capNum(RIGHT.SBFELimitOELineAmt84M_, 99999999);
				SELF.SBFE.SBFEScheduledAll := (STRING)capNum(RIGHT.SBFEScheduledAll_, 999999),
				SELF.SBFE.SBFEScheduledLoan := (STRING)capNum(RIGHT.SBFEScheduledLoan_, 999999),
				SELF.SBFE.SBFEScheduledLine := (STRING)capNum(RIGHT.SBFEScheduledLine_, 999999),
				SELF.SBFE.SBFEScheduledCard := (STRING)capNum(RIGHT.SBFEScheduledCard_, 999999),
				SELF.SBFE.SBFEScheduledLease := (STRING)capNum(RIGHT.SBFEScheduledLease_, 999999),
				SELF.SBFE.SBFEScheduledLetter := (STRING)capNum(RIGHT.SBFEScheduledLetter_, 999999),
				SELF.SBFE.SBFEScheduledOLine := (STRING)capNum(RIGHT.SBFEScheduledOLine_, 999999),
				SELF.SBFE.SBFEScheduledOther := (STRING)capNum(RIGHT.SBFEScheduledOther_, 999999),
				SELF.SBFE.SBFEReceivedAll := (STRING)capNum(RIGHT.SBFEReceivedAll_, 999999),
				SELF.SBFE.SBFEReceivedLoan := (STRING)capNum(RIGHT.SBFEReceivedLoan_, 999999),
				SELF.SBFE.SBFEReceivedLine := (STRING)capNum(RIGHT.SBFEReceivedLine_, 999999),
				SELF.SBFE.SBFEReceivedCard := (STRING)capNum(RIGHT.SBFEReceivedCard_, 999999),
				SELF.SBFE.SBFEReceivedLease := (STRING)capNum(RIGHT.SBFEReceivedLease_, 999999),
				SELF.SBFE.SBFEReceivedLetter := (STRING)capNum(RIGHT.SBFEReceivedLetter_, 999999),
				SELF.SBFE.SBFEReceivedOLine := (STRING)capNum(RIGHT.SBFEReceivedOLine_, 999999),
				SELF.SBFE.SBFEReceivedOther := (STRING)capNum(RIGHT.SBFEReceivedOther_, 999999),
				SELF.SBFE.SBFEUtilizationCurrentRevolving := (STRING)capNum(RIGHT.SBFEUtilizationCurrentRevolving_, 100),
				SELF.SBFE.SBFEAvailableCurrentRevolving := (STRING)capNum(RIGHT.SBFEAvailableCurrentRevolving_, 100),
				SELF.SBFE.SBFEUtilRevolving03M := (STRING)capNum(RIGHT.SBFEUtilRevolving03M_, 100);
				SELF.SBFE.SBFEUtilRevolving06M := (STRING)capNum(RIGHT.SBFEUtilRevolving06M_, 100);
				SELF.SBFE.SBFEUtilRevolving12M := (STRING)capNum(RIGHT.SBFEUtilRevolving12M_, 100);
				SELF.SBFE.SBFEUtilRevolving24M := (STRING)capNum(RIGHT.SBFEUtilRevolving24M_, 100);
				SELF.SBFE.SBFEUtilRevolving36M := (STRING)capNum(RIGHT.SBFEUtilRevolving36M_, 100);
				SELF.SBFE.SBFEUtilRevolving60M := (STRING)capNum(RIGHT.SBFEUtilRevolving60M_, 100);
				SELF.SBFE.SBFEUtilRevolving84M := (STRING)capNum(RIGHT.SBFEUtilRevolving84M_, 100);
				SELF.SBFE.SBFEUtilizationCurrentLine := (STRING)capNum(RIGHT.SBFEUtilizationCurrentLine_, 100),
				SELF.SBFE.SBFEAvailableCurrentLine := (STRING)capNum(RIGHT.SBFEAvailableCurrentLine_, 100),
				SELF.SBFE.SBFEUtilLine03M := (STRING)capNum(RIGHT.SBFEUtilLine03M_, 100);
				SELF.SBFE.SBFEUtilLine06M := (STRING)capNum(RIGHT.SBFEUtilLine06M_, 100);
				SELF.SBFE.SBFEUtilLine12M := (STRING)capNum(RIGHT.SBFEUtilLine12M_, 100);
				SELF.SBFE.SBFEUtilLine24M := (STRING)capNum(RIGHT.SBFEUtilLine24M_, 100);
				SELF.SBFE.SBFEUtilLine36M := (STRING)capNum(RIGHT.SBFEUtilLine36M_, 100);
				SELF.SBFE.SBFEUtilLine60M := (STRING)capNum(RIGHT.SBFEUtilLine60M_, 100);
				SELF.SBFE.SBFEUtilLine84M := (STRING)capNum(RIGHT.SBFEUtilLine84M_, 100);
				SELF.SBFE.SBFEUtilizationCurrentCard := (STRING)capNum(RIGHT.SBFEUtilizationCurrentCard_, 100),
				SELF.SBFE.SBFEAvailableCurrentCard := (STRING)capNum(RIGHT.SBFEAvailableCurrentCard_, 100),
				SELF.SBFE.SBFEUtilCard03M := (STRING)capNum(RIGHT.SBFEUtilCard03M_, 100);
				SELF.SBFE.SBFEUtilCard06M := (STRING)capNum(RIGHT.SBFEUtilCard06M_, 100);
				SELF.SBFE.SBFEUtilCard12M := (STRING)capNum(RIGHT.SBFEUtilCard12M_, 100);
				SELF.SBFE.SBFEUtilCard24M := (STRING)capNum(RIGHT.SBFEUtilCard24M_, 100);
				SELF.SBFE.SBFEUtilCard36M := (STRING)capNum(RIGHT.SBFEUtilCard36M_, 100);
				SELF.SBFE.SBFEUtilCard60M := (STRING)capNum(RIGHT.SBFEUtilCard60M_, 100);
				SELF.SBFE.SBFEUtilCard84M := (STRING)capNum(RIGHT.SBFEUtilCard84M_, 100);
				SELF.SBFE.SBFEUtilizationCurrentOLine := (STRING)capNum(RIGHT.SBFEUtilizationCurrentOLine_, 100),
				SELF.SBFE.SBFEAvailableCurrentOELine := (STRING)capNum(RIGHT.SBFEAvailableCurrentOELine_, 100),
				SELF.SBFE.SBFEUtilOELine03M := (STRING)capNum(RIGHT.SBFEUtilOELine03M_, 100);
				SELF.SBFE.SBFEUtilOELine06M := (STRING)capNum(RIGHT.SBFEUtilOELine06M_, 100);
				SELF.SBFE.SBFEUtilOELine12M := (STRING)capNum(RIGHT.SBFEUtilOELine12M_, 100);
				SELF.SBFE.SBFEUtilOELine24M := (STRING)capNum(RIGHT.SBFEUtilOELine24M_, 100);
				SELF.SBFE.SBFEUtilOELine36M := (STRING)capNum(RIGHT.SBFEUtilOELine36M_, 100);
				SELF.SBFE.SBFEUtilOELine60M := (STRING)capNum(RIGHT.SBFEUtilOELine60M_, 100);
				SELF.SBFE.SBFEUtilOELine84M := (STRING)capNum(RIGHT.SBFEUtilOELine84M_, 100);
				SELF.SBFE.SBFEUtilization75RevolvingCount := (STRING)capNum(RIGHT.SBFEUtilization75RevolvingCount_, 99),
				SELF.SBFE.SBFEUtilization75Line := (STRING)capNum(RIGHT.SBFEUtilization75Line_, 99),
				SELF.SBFE.SBFEUtilization75Card := (STRING)capNum(RIGHT.SBFEUtilization75Card_, 99),
				SELF.SBFE.SBFEUtilization75OLine := (STRING)capNum(RIGHT.SBFEUtilization75OLine_, 99),
				SELF.SBFE.SBFEUtilization30Revolving := (STRING)capNum(RIGHT.SBFEUtilization30Revolving_, 99),
				SELF.SBFE.SBFEUtilization30Line := (STRING)capNum(RIGHT.SBFEUtilization30Line_, 99),
				SELF.SBFE.SBFEUtilization30Card := (STRING)capNum(RIGHT.SBFEUtilization30Card_, 99),
				SELF.SBFE.SBFEUtilization30OLine := (STRING)capNum(RIGHT.SBFEUtilization30OLine_, 99),
				SELF.SBFE.SBFEAvgUtil03M := (STRING)capNum(RIGHT.SBFEAvgUtil03M_, 100);
				SELF.SBFE.SBFEUtilizationAve06 := (STRING)capNum(RIGHT.Sbfeutilizationave06_, 100),
				SELF.SBFE.SBFEUtilizationAve12 := (STRING)capNum(RIGHT.Sbfeutilizationave12_, 100),
				SELF.SBFE.SBFEUtilizationAve24 := (STRING)capNum(RIGHT.Sbfeutilizationave24_, 100),
				SELF.SBFE.SBFEUtilizationAve36 := (STRING)capNum(RIGHT.Sbfeutilizationave36_, 100),
				SELF.SBFE.SBFEUtilizationAve60 := (STRING)capNum(RIGHT.Sbfeutilizationave60_, 100),
				SELF.SBFE.SBFEUtilizationAve84 := (STRING)capNum(RIGHT.Sbfeutilizationave84_, 100),
				SELF.SBFE.SBFEUtilizationAveEver := (STRING)capNum(RIGHT.Sbfeutilizationaveever_, 100),
				SELF.SBFE.SBFEAvgUtilLine03M := (STRING)capNum(RIGHT.SBFEAvgUtilLine03M_, 100);
				SELF.SBFE.SBFEUtilizationAve06Line := (STRING)capNum(RIGHT.Sbfeutilizationave06line_, 100),
				SELF.SBFE.SBFEUtilizationAve12Line := (STRING)capNum(RIGHT.Sbfeutilizationave12line_, 100),
				SELF.SBFE.SBFEUtilizationAve24Line := (STRING)capNum(RIGHT.Sbfeutilizationave24line_, 100),
				SELF.SBFE.SBFEUtilizationAve36Line := (STRING)capNum(RIGHT.Sbfeutilizationave36line_, 100),
				SELF.SBFE.SBFEUtilizationAve60Line := (STRING)capNum(RIGHT.Sbfeutilizationave60line_, 100),
				SELF.SBFE.SBFEUtilizationAve84Line := (STRING)capNum(RIGHT.Sbfeutilizationave84line_, 100),
				SELF.SBFE.SBFEUtilizationAveEverLine := (STRING)capNum(RIGHT.Sbfeutilizationaveeverline_, 100),
				SELF.SBFE.SBFEAvgUtilCard03M := (STRING)capNum(RIGHT.SBFEAvgUtilCard03M_, 100);
				SELF.SBFE.SBFEUtilizationAve06Card := (STRING)capNum(RIGHT.Sbfeutilizationave06card_, 100),
				SELF.SBFE.SBFEUtilizationAve12Card := (STRING)capNum(RIGHT.Sbfeutilizationave12card_, 100),
				SELF.SBFE.SBFEUtilizationAve24Card := (STRING)capNum(RIGHT.Sbfeutilizationave24card_, 100),
				SELF.SBFE.SBFEUtilizationAve36Card := (STRING)capNum(RIGHT.Sbfeutilizationave36card_, 100),
				SELF.SBFE.SBFEUtilizationAve60Card := (STRING)capNum(RIGHT.Sbfeutilizationave60card_, 100),
				SELF.SBFE.SBFEUtilizationAve84Card := (STRING)capNum(RIGHT.Sbfeutilizationave84card_, 100),
				SELF.SBFE.SBFEUtilizationAveEverCard := (STRING)capNum(RIGHT.Sbfeutilizationaveevercard_, 100),
				SELF.SBFE.SBFEAvgUtilOELine03M := (STRING)capNum(RIGHT.SBFEAvgUtilOELine03M_, 100);
				SELF.SBFE.SBFEUtilizationAve06OLine := (STRING)capNum(RIGHT.Sbfeutilizationave06oline_, 100),
				SELF.SBFE.SBFEUtilizationAve12OLine := (STRING)capNum(RIGHT.Sbfeutilizationave12oline_, 100),
				SELF.SBFE.SBFEUtilizationAve24OLine := (STRING)capNum(RIGHT.Sbfeutilizationave24oline_, 100),
				SELF.SBFE.SBFEUtilizationAve36OLine := (STRING)capNum(RIGHT.Sbfeutilizationave36oline_, 100),
				SELF.SBFE.SBFEUtilizationAve60OLine := (STRING)capNum(RIGHT.Sbfeutilizationave60oline_, 100),
				SELF.SBFE.SBFEUtilizationAve84OLine := (STRING)capNum(RIGHT.Sbfeutilizationave84oline_, 100),
				SELF.SBFE.SBFEUtilizationAveEverOLine := (STRING)capNum(RIGHT.Sbfeutilizationaveeveroline_, 100),
				SELF.SBFE.SBFEUtilizationHighRevolving := (STRING)capNum(RIGHT.SBFEUtilizationHighRevolving_, 99999999),
				SELF.SBFE.SBFEUtilizationHighLine := (STRING)capNum(RIGHT.SBFEUtilizationHighLine_, 99999999),
				SELF.SBFE.SBFEUtilizationHighCard := (STRING)capNum(RIGHT.SBFEUtilizationHighCard_, 99999999),
				SELF.SBFE.SBFEUtilizationIndexCard12Month := (STRING)RIGHT.SBFEUtilizationIndexCard12Month_,
				SELF.SBFE.SBFEUtilizationIndexCard24Month := (STRING)RIGHT.SBFEUtilizationIndexCard24Month_,
				SELF.SBFE.SBFEUtiliztionHighOLine := (STRING)capNum(RIGHT.SBFEUtiliztionHighOLine_, 99999999),
				SELF.SBFE.SBFEWorstOpen := (STRING)RIGHT.Sbfeworstopen_,
				SELF.SBFE.SBFEHighDelq03M := (STRING)RIGHT.SBFEHighDelq03M_;
				SELF.SBFE.SBFEWorst06 := (STRING)RIGHT.Sbfeworst06_,
				SELF.SBFE.SBFEWorst12 := (STRING)RIGHT.Sbfeworst12_,
				SELF.SBFE.SBFEWorst24 := (STRING)RIGHT.Sbfeworst24_,
				SELF.SBFE.SBFEWorst36 := (STRING)RIGHT.Sbfeworst36_,
				SELF.SBFE.SBFEWorst60 := (STRING)RIGHT.Sbfeworst60_,
				SELF.SBFE.SBFEWorst84 := (STRING)RIGHT.Sbfeworst84_,
				SELF.SBFE.SBFEWorstEver := (STRING)RIGHT.Sbfeworstever_,
				SELF.SBFE.SBFEWorstLoan := (STRING)RIGHT.Sbfeworstloan_,
				SELF.SBFE.SBFEHighDelqLoan03M := (STRING)RIGHT.SBFEHighDelqLoan03M_;
				SELF.SBFE.SBFEWorstLoan06 := (STRING)RIGHT.Sbfeworstloan06_,
				SELF.SBFE.SBFEWorstLoan12 := (STRING)RIGHT.Sbfeworstloan12_,
				SELF.SBFE.SBFEWorstLoan24 := (STRING)RIGHT.Sbfeworstloan24_,
				SELF.SBFE.SBFEWorstLoan36 := (STRING)RIGHT.Sbfeworstloan36_,
				SELF.SBFE.SBFEWorstLoan60 := (STRING)RIGHT.Sbfeworstloan60_,
				SELF.SBFE.SBFEWorstLoan84 := (STRING)RIGHT.Sbfeworstloan84_,
				SELF.SBFE.SBFEWorstLoanEver := (STRING)RIGHT.Sbfeworstloanever_,
				SELF.SBFE.SBFEWorstLine := (STRING)RIGHT.Sbfeworstline_,
				SELF.SBFE.SBFEHighDelqLine03M := (STRING)RIGHT.SBFEHighDelqLine03M_;
				SELF.SBFE.SBFEWorstLine06 := (STRING)RIGHT.Sbfeworstline06_,
				SELF.SBFE.SBFEWorstLine12 := (STRING)RIGHT.Sbfeworstline12_,
				SELF.SBFE.SBFEWorstLine24 := (STRING)RIGHT.Sbfeworstline24_,
				SELF.SBFE.SBFEWorstLine36 := (STRING)RIGHT.Sbfeworstline36_,
				SELF.SBFE.SBFEWorstLine60 := (STRING)RIGHT.Sbfeworstline60_,
				SELF.SBFE.SBFEWorstLine84 := (STRING)RIGHT.Sbfeworstline84_,
				SELF.SBFE.SBFEWorstLineEver := (STRING)RIGHT.Sbfeworstlineever_,
				SELF.SBFE.SBFEWorstCard := (STRING)RIGHT.Sbfeworstcard_,
				SELF.SBFE.SBFEHighDelqCard03M := (STRING)RIGHT.SBFEHighDelqCard03M_;
				SELF.SBFE.SBFEWorstCard06 := (STRING)RIGHT.Sbfeworstcard06_,
				SELF.SBFE.SBFEWorstCard12 := (STRING)RIGHT.Sbfeworstcard12_,
				SELF.SBFE.SBFEWorstCard24 := (STRING)RIGHT.Sbfeworstcard24_,
				SELF.SBFE.SBFEWorstCard36 := (STRING)RIGHT.Sbfeworstcard36_,
				SELF.SBFE.SBFEWorstCard60 := (STRING)RIGHT.Sbfeworstcard60_,
				SELF.SBFE.SBFEWorstCard84 := (STRING)RIGHT.Sbfeworstcard84_,
				SELF.SBFE.SBFEWorstCardEver := (STRING)RIGHT.Sbfeworstcardever_,
				SELF.SBFE.SBFEWorstLease := (STRING)RIGHT.Sbfeworstlease_,
				SELF.SBFE.SBFEHighDelqLease03M := (STRING)RIGHT.SBFEHighDelqLease03M_;
				SELF.SBFE.SBFEWorstLease06 := (STRING)RIGHT.Sbfeworstlease06_,
				SELF.SBFE.SBFEWorstLease12 := (STRING)RIGHT.Sbfeworstlease12_,
				SELF.SBFE.SBFEWorstLease24 := (STRING)RIGHT.Sbfeworstlease24_,
				SELF.SBFE.SBFEWorstLease36 := (STRING)RIGHT.Sbfeworstlease36_,
				SELF.SBFE.SBFEWorstLease60 := (STRING)RIGHT.Sbfeworstlease60_,
				SELF.SBFE.SBFEWorstLease84 := (STRING)RIGHT.Sbfeworstlease84_,
				SELF.SBFE.SBFEWorstLeaseEver := (STRING)RIGHT.Sbfeworstleaseever_,
				SELF.SBFE.SBFEWorstLetter := (STRING)RIGHT.Sbfeworstletter_,
				SELF.SBFE.SBFEHighDelqLetter03M := (STRING)RIGHT.SBFEHighDelqLetter03M_;
				SELF.SBFE.SBFEWorstLetter06 := (STRING)RIGHT.Sbfeworstletter06_,
				SELF.SBFE.SBFEWorstLetter12 := (STRING)RIGHT.Sbfeworstletter12_,
				SELF.SBFE.SBFEWorstLetter24 := (STRING)RIGHT.Sbfeworstletter24_,
				SELF.SBFE.SBFEWorstLetter36 := (STRING)RIGHT.Sbfeworstletter36_,
				SELF.SBFE.SBFEWorstLetter60 := (STRING)RIGHT.Sbfeworstletter60_,
				SELF.SBFE.SBFEWorstLetter84 := (STRING)RIGHT.Sbfeworstletter84_,
				SELF.SBFE.SBFEWorstLetterEver := (STRING)RIGHT.Sbfeworstletterever_,
				SELF.SBFE.SBFEWorstOLine := (STRING)RIGHT.Sbfeworstoline_,
				SELF.SBFE.SBFEHighDelqOELine03M := (STRING)RIGHT.SBFEHighDelqOELine03M_;
				SELF.SBFE.SBFEWorstOLine06 := (STRING)RIGHT.Sbfeworstoline06_,
				SELF.SBFE.SBFEWorstOLine12 := (STRING)RIGHT.Sbfeworstoline12_,
				SELF.SBFE.SBFEWorstOLine24 := (STRING)RIGHT.Sbfeworstoline24_,
				SELF.SBFE.SBFEWorstOLine36 := (STRING)RIGHT.Sbfeworstoline36_,
				SELF.SBFE.SBFEWorstOLine60 := (STRING)RIGHT.Sbfeworstoline60_,
				SELF.SBFE.SBFEWorstOLine84 := (STRING)RIGHT.Sbfeworstoline84_,
				SELF.SBFE.SBFEWorstOLineEver := (STRING)RIGHT.Sbfeworstolineever_,
				SELF.SBFE.SBFEWorstOther := (STRING)RIGHT.Sbfeworstother_,
				SELF.SBFE.SBFEHighDelqOther03M := (STRING)RIGHT.SBFEHighDelqOther03M_;
				SELF.SBFE.SBFEWorstOther06 := (STRING)RIGHT.Sbfeworstother06_,
				SELF.SBFE.SBFEWorstOther12 := (STRING)RIGHT.Sbfeworstother12_,
				SELF.SBFE.SBFEWorstOther24 := (STRING)RIGHT.Sbfeworstother24_,
				SELF.SBFE.SBFEWorstOther36 := (STRING)RIGHT.Sbfeworstother36_,
				SELF.SBFE.SBFEWorstOther60 := (STRING)RIGHT.Sbfeworstother60_,
				SELF.SBFE.SBFEWorstOther84 := (STRING)RIGHT.Sbfeworstother84_,
				SELF.SBFE.SBFEWorstOtherEver := (STRING)RIGHT.Sbfeworstotherever_,
				SELF.SBFE.SBFEHighDelqRevOpen := (STRING)RIGHT.SBFEHighDelqRevOpen_,
				SELF.SBFE.SBFEHighDelqRev03M := (STRING)RIGHT.SBFEHighDelqRev03M_,
				SELF.SBFE.SBFEHighDelqRev06M := (STRING)RIGHT.SBFEHighDelqRev06M_,
				SELF.SBFE.SBFEHighDelqRev12M := (STRING)RIGHT.SBFEHighDelqRev12M_,
				SELF.SBFE.SBFEHighDelqRev24M := (STRING)RIGHT.SBFEHighDelqRev24M_,
				SELF.SBFE.SBFEHighDelqRev36M := (STRING)RIGHT.SBFEHighDelqRev36M_,
				SELF.SBFE.SBFEHighDelqRev60M := (STRING)RIGHT.SBFEHighDelqRev60M_,
				SELF.SBFE.SBFEHighDelqRev84M := (STRING)RIGHT.SBFEHighDelqRev84M_,
				SELF.SBFE.SBFEHighDelqRevEver := (STRING)RIGHT.SBFEHighDelqRevEver_,
				SELF.SBFE.SBFEHighDelqInstOpen := (STRING)RIGHT.SBFEHighDelqInstOpen_,
				SELF.SBFE.SBFEHighDelqInst03M := (STRING)RIGHT.SBFEHighDelqInst03M_,
				SELF.SBFE.SBFEHighDelqInst06M := (STRING)RIGHT.SBFEHighDelqInst06M_,
				SELF.SBFE.SBFEHighDelqInst12M := (STRING)RIGHT.SBFEHighDelqInst12M_,
				SELF.SBFE.SBFEHighDelqInst24M := (STRING)RIGHT.SBFEHighDelqInst24M_,
				SELF.SBFE.SBFEHighDelqInst36M := (STRING)RIGHT.SBFEHighDelqInst36M_,
				SELF.SBFE.SBFEHighDelqInst60M := (STRING)RIGHT.SBFEHighDelqInst60M_,
				SELF.SBFE.SBFEHighDelqInst84M := (STRING)RIGHT.SBFEHighDelqInst84M_,
				SELF.SBFE.SBFEHighDelqInstEver := (STRING)RIGHT.SBFEHighDelqInstEver_,
				SELF.SBFE.SBFECurrentCount := (STRING)capNum(RIGHT.Sbfecurrentcount_, 99),
				SELF.SBFE.SBFESatisfactoryCount := (STRING)capNum(RIGHT.Sbfesatisfactorycount_, 999),
				SELF.SBFE.SBFESatisfactoryCountLoan := (STRING)capNum(RIGHT.Sbfesatisfactorycountloan_, 99),
				SELF.SBFE.SBFESatisfactoryCountLine := (STRING)capNum(RIGHT.Sbfesatisfactorycountline_, 99),
				SELF.SBFE.SBFESatisfactoryCountCard := (STRING)capNum(RIGHT.Sbfesatisfactorycountcard_, 99),
				SELF.SBFE.SBFESatisfactoryCountLease := (STRING)capNum(RIGHT.Sbfesatisfactorycountlease_, 99),
				SELF.SBFE.SBFESatisfactoryCountLetter := (STRING)capNum(RIGHT.Sbfesatisfactorycountletter_, 99),
				SELF.SBFE.SBFESatisfactoryCountOLine := (STRING)capNum(RIGHT.Sbfesatisfactorycountoline_, 99),
				SELF.SBFE.SBFESatisfactoryCountOther := (STRING)capNum(RIGHT.Sbfesatisfactorycountother_, 99),
				SELF.SBFE.SBFEDPDDateLastSeen := (STRING)RIGHT.Sbfedpddatelastseen_,
				SELF.SBFE.SBFETimeNewestDelq := (STRING)capNum(RIGHT.SBFETimeNewestDelq_, 600);
				SELF.SBFE.SBFEDelq1CountTtl := (STRING)capNum(RIGHT.SBFEDelq1CountTtl_, 99),
				SELF.SBFE.SBFEDelq1CountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq1CountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDPD1Count := (STRING)capNum(RIGHT.Sbfedpd1count_, 99),
				SELF.SBFE.SBFEDelq1Count03M := (STRING)capNum(RIGHT.SBFEDelq1Count03M_, 99);
				SELF.SBFE.SBFEDPD1Count06 := (STRING)capNum(RIGHT.Sbfedpd1count06_, 99),
				SELF.SBFE.SBFEDPD1Count12 := (STRING)capNum(RIGHT.Sbfedpd1count12_, 99),
				SELF.SBFE.SBFEDPD1Count24 := (STRING)capNum(RIGHT.Sbfedpd1count24_, 99),
				SELF.SBFE.SBFEDPD1Count36 := (STRING)capNum(RIGHT.Sbfedpd1count36_, 99),
				SELF.SBFE.SBFEDPD1Count60 := (STRING)capNum(RIGHT.Sbfedpd1count60_, 99),
				SELF.SBFE.SBFEDPD1Count84 := (STRING)capNum(RIGHT.Sbfedpd1count84_, 99),
				SELF.SBFE.SBFEDPD1CountEver := (STRING)capNum(RIGHT.Sbfedpd1countever_, 99),
				SELF.SBFE.SBFEDelq1CountEverTtl := (STRING)capNum(RIGHT.SBFEDelq1CountEverTtl_, 99),
				SELF.SBFE.SBFEDelq1LoanCount := (STRING)capNum(RIGHT.SBFEDelq1LoanCount_, 99),
				SELF.SBFE.SBFEDelq1LoanCount03M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount03M_, 99),
				SELF.SBFE.SBFEDelq1LoanCount06M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount06M_, 99),
				SELF.SBFE.SBFEDelq1LoanCount12M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount12M_, 99),
				SELF.SBFE.SBFEDelq1LoanCount24M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount24M_, 99),
				SELF.SBFE.SBFEDelq1LoanCount36M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount36M_, 99),
				SELF.SBFE.SBFEDelq1LoanCount60M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount60M_, 99),
				SELF.SBFE.SBFEDelq1LoanCount84M := (STRING)capNum(RIGHT.SBFEDelq1LoanCount84M_, 99),
				SELF.SBFE.SBFEDelq1LoanCountEver := (STRING)capNum(RIGHT.SBFEDelq1LoanCountEver_, 99),
				SELF.SBFE.SBFEDelq1LineCount := (STRING)capNum(RIGHT.SBFEDelq1LineCount_, 99),
				SELF.SBFE.SBFEDelq1LineCount03M := (STRING)capNum(RIGHT.SBFEDelq1LineCount03M_, 99),
				SELF.SBFE.SBFEDelq1LineCount06M := (STRING)capNum(RIGHT.SBFEDelq1LineCount06M_, 99),
				SELF.SBFE.SBFEDelq1LineCount12M := (STRING)capNum(RIGHT.SBFEDelq1LineCount12M_, 99),
				SELF.SBFE.SBFEDelq1LineCount24M := (STRING)capNum(RIGHT.SBFEDelq1LineCount24M_, 99),
				SELF.SBFE.SBFEDelq1LineCount36M := (STRING)capNum(RIGHT.SBFEDelq1LineCount36M_, 99),
				SELF.SBFE.SBFEDelq1LineCount60M := (STRING)capNum(RIGHT.SBFEDelq1LineCount60M_, 99),
				SELF.SBFE.SBFEDelq1LineCount84M := (STRING)capNum(RIGHT.SBFEDelq1LineCount84M_, 99),
				SELF.SBFE.SBFEDelq1LineCountEver := (STRING)capNum(RIGHT.SBFEDelq1LineCountEver_, 99),
				SELF.SBFE.SBFEDelq1CardCount := (STRING)capNum(RIGHT.SBFEDelq1CardCount_, 99),
				SELF.SBFE.SBFEDelq1CardCount03M := (STRING)capNum(RIGHT.SBFEDelq1CardCount03M_, 99),
				SELF.SBFE.SBFEDelq1CardCount06M := (STRING)capNum(RIGHT.SBFEDelq1CardCount06M_, 99),
				SELF.SBFE.SBFEDelq1CardCount12M := (STRING)capNum(RIGHT.SBFEDelq1CardCount12M_, 99),
				SELF.SBFE.SBFEDelq1CardCount24M := (STRING)capNum(RIGHT.SBFEDelq1CardCount24M_, 99),
				SELF.SBFE.SBFEDelq1CardCount36M := (STRING)capNum(RIGHT.SBFEDelq1CardCount36M_, 99),
				SELF.SBFE.SBFEDelq1CardCount60M := (STRING)capNum(RIGHT.SBFEDelq1CardCount60M_, 99),
				SELF.SBFE.SBFEDelq1CardCount84M := (STRING)capNum(RIGHT.SBFEDelq1CardCount84M_, 99),
				SELF.SBFE.SBFEDelq1CardCountEver := (STRING)capNum(RIGHT.SBFEDelq1CardCountEver_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount03M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount06M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount06M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount12M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount12M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount24M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount24M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount36M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount36M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount60M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount60M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCount84M := (STRING)capNum(RIGHT.SBFEDelq1LeaseCount84M_, 99),
				SELF.SBFE.SBFEDelq1LeaseCountEver := (STRING)capNum(RIGHT.SBFEDelq1LeaseCountEver_, 99),
				SELF.SBFE.SBFEDelq1LetterCount := (STRING)capNum(RIGHT.SBFEDelq1LetterCount_, 99),
				SELF.SBFE.SBFEDelq1LetterCount03M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount03M_, 99),
				SELF.SBFE.SBFEDelq1LetterCount06M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount06M_, 99),
				SELF.SBFE.SBFEDelq1LetterCount12M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount12M_, 99),
				SELF.SBFE.SBFEDelq1LetterCount24M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount24M_, 99),
				SELF.SBFE.SBFEDelq1LetterCount36M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount36M_, 99),
				SELF.SBFE.SBFEDelq1LetterCount60M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount60M_, 99),
				SELF.SBFE.SBFEDelq1LetterCount84M := (STRING)capNum(RIGHT.SBFEDelq1LetterCount84M_, 99),
				SELF.SBFE.SBFEDelq1LetterCountEver := (STRING)capNum(RIGHT.SBFEDelq1LetterCountEver_, 99),
				SELF.SBFE.SBFEDelq1OELineCount := (STRING)capNum(RIGHT.SBFEDelq1OELineCount_, 99),
				SELF.SBFE.SBFEDelq1OELineCount03M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount03M_, 99),
				SELF.SBFE.SBFEDelq1OELineCount06M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount06M_, 99),
				SELF.SBFE.SBFEDelq1OELineCount12M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount12M_, 99),
				SELF.SBFE.SBFEDelq1OELineCount24M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount24M_, 99),
				SELF.SBFE.SBFEDelq1OELineCount36M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount36M_, 99),
				SELF.SBFE.SBFEDelq1OELineCount60M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount60M_, 99),
				SELF.SBFE.SBFEDelq1OELineCount84M := (STRING)capNum(RIGHT.SBFEDelq1OELineCount84M_, 99),
				SELF.SBFE.SBFEDelq1OELineCountEver := (STRING)capNum(RIGHT.SBFEDelq1OELineCountEver_, 99),
				SELF.SBFE.SBFEDelq1OtherCount := (STRING)capNum(RIGHT.SBFEDelq1OtherCount_, 99),
				SELF.SBFE.SBFEDelq1OtherCount03M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount03M_, 99),
				SELF.SBFE.SBFEDelq1OtherCount06M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount06M_, 99),
				SELF.SBFE.SBFEDelq1OtherCount12M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount12M_, 99),
				SELF.SBFE.SBFEDelq1OtherCount24M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount24M_, 99),
				SELF.SBFE.SBFEDelq1OtherCount36M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount36M_, 99),
				SELF.SBFE.SBFEDelq1OtherCount60M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount60M_, 99),
				SELF.SBFE.SBFEDelq1OtherCount84M := (STRING)capNum(RIGHT.SBFEDelq1OtherCount84M_, 99),
				SELF.SBFE.SBFEDelq1OtherCountEver := (STRING)capNum(RIGHT.SBFEDelq1OtherCountEver_, 99),
				SELF.SBFE.SBFEDelq1LeaseCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq1LeaseCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq1LoanCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq1LoanCountEverTtl_, 99),
				SELF.SBFE.SBFEDelqLetterCountEverTtl := (STRING)capNum(RIGHT.SBFEDelqLetterCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq1InstCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq1InstCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq1InstCountEver := (STRING)capNum(RIGHT.SBFEDelq1InstCountEver_, 99),
				SELF.SBFE.SBFEDelq1InstCountTtl := (STRING)capNum(RIGHT.SBFEDelq1InstCountTtl_, 99),
				SELF.SBFE.SBFEDelq1InstCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq1InstCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq1RevCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq1RevCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq1RevCountEver := (STRING)capNum(RIGHT.SBFEDelq1RevCountEver_, 99),
				SELF.SBFE.SBFEDelq1RevCountTtl := (STRING)capNum(RIGHT.SBFEDelq1RevCountTtl_, 99),
				SELF.SBFE.SBFEDelq1RevCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq1RevCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq31CountTtl := (STRING)capNum(RIGHT.SBFEDelq31CountTtl_, 99),
				SELF.SBFE.SBFEDelq31CountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq31CountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDPD31Count := (STRING)capNum(RIGHT.Sbfedpd31count_, 99),
				SELF.SBFE.SBFEDelq31Count03M := (STRING)capNum(RIGHT.SBFEDelq31Count03M_, 99);
				SELF.SBFE.SBFEDPD31Count06 := (STRING)capNum(RIGHT.Sbfedpd31count06_, 99),
				SELF.SBFE.SBFEDPD31Count12 := (STRING)capNum(RIGHT.Sbfedpd31count12_, 99),
				SELF.SBFE.SBFEDPD31Count24 := (STRING)capNum(RIGHT.Sbfedpd31count24_, 99),
				SELF.SBFE.SBFEDPD31Count36 := (STRING)capNum(RIGHT.Sbfedpd31count36_, 99),
				SELF.SBFE.SBFEDPD31Count60 := (STRING)capNum(RIGHT.Sbfedpd31count60_, 99),
				SELF.SBFE.SBFEDPD31Count84 := (STRING)capNum(RIGHT.Sbfedpd31count84_, 99),
				SELF.SBFE.SBFEDPD31CountEver := (STRING)capNum(RIGHT.Sbfedpd31countever_, 99),
				SELF.SBFE.SBFEDelq31CountEverTtl := (STRING)capNum(RIGHT.SBFEDelq31CountEverTtl_, 99),
				SELF.SBFE.SBFEDPD31CountLoan := (STRING)capNum(RIGHT.SBFEDPD31CountLoan_, 99),
				SELF.SBFE.SBFEDelq31LoanCount03M := (STRING)capNum(RIGHT.SBFEDelq31LoanCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountLoan06 := (STRING)capNum(RIGHT.SBFEDPD31CountLoan06_, 99),
				SELF.SBFE.SBFEDPD31CountLoan12 := (STRING)capNum(RIGHT.SBFEDPD31CountLoan12_, 99),
				SELF.SBFE.SBFEDPD31CountLoan24 := (STRING)capNum(RIGHT.SBFEDPD31CountLoan24_, 99),
				SELF.SBFE.SBFEDPD31CountLoan36 := (STRING)capNum(RIGHT.SBFEDPD31CountLoan36_, 99),
				SELF.SBFE.SBFEDPD31CountLoan60 := (STRING)capNum(RIGHT.SBFEDPD31CountLoan60_, 99),
				SELF.SBFE.SBFEDPD31CountLoan84 := (STRING)capNum(RIGHT.SBFEDPD31CountLoan84_, 99),
				SELF.SBFE.SBFEDPD31CountLoanEver := (STRING)capNum(RIGHT.SBFEDPD31CountLoanEver_, 99),
				SELF.SBFE.SBFEDPD31CountLine := (STRING)capNum(RIGHT.SBFEDPD31CountLine_, 99),
				SELF.SBFE.SBFEDelq31LineCount03M := (STRING)capNum(RIGHT.SBFEDelq31LineCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountLine06 := (STRING)capNum(RIGHT.SBFEDPD31CountLine06_, 99),
				SELF.SBFE.SBFEDPD31CountLine12 := (STRING)capNum(RIGHT.SBFEDPD31CountLine12_, 99),
				SELF.SBFE.SBFEDPD31CountLine24 := (STRING)capNum(RIGHT.SBFEDPD31CountLine24_, 99),
				SELF.SBFE.SBFEDPD31CountLine36 := (STRING)capNum(RIGHT.SBFEDPD31CountLine36_, 99),
				SELF.SBFE.SBFEDPD31CountLine60 := (STRING)capNum(RIGHT.SBFEDPD31CountLine60_, 99),
				SELF.SBFE.SBFEDPD31CountLine84 := (STRING)capNum(RIGHT.SBFEDPD31CountLine84_, 99),
				SELF.SBFE.SBFEDPD31CountLineEver := (STRING)capNum(RIGHT.SBFEDPD31CountLineEver_, 99),
				SELF.SBFE.SBFEDPD31CountCard := (STRING)capNum(RIGHT.SBFEDPD31CountCard_, 99),
				SELF.SBFE.SBFEDelq31CardCount03M := (STRING)capNum(RIGHT.SBFEDelq31CardCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountCard06 := (STRING)capNum(RIGHT.SBFEDPD31CountCard06_, 99),
				SELF.SBFE.SBFEDPD31CountCard12 := (STRING)capNum(RIGHT.SBFEDPD31CountCard12_, 99),
				SELF.SBFE.SBFEDPD31CountCard24 := (STRING)capNum(RIGHT.SBFEDPD31CountCard24_, 99),
				SELF.SBFE.SBFEDPD31CountCard36 := (STRING)capNum(RIGHT.SBFEDPD31CountCard36_, 99),
				SELF.SBFE.SBFEDPD31CountCard60 := (STRING)capNum(RIGHT.SBFEDPD31CountCard60_, 99),
				SELF.SBFE.SBFEDPD31CountCard84 := (STRING)capNum(RIGHT.SBFEDPD31CountCard84_, 99),
				SELF.SBFE.SBFEDPD31CountCardEver := (STRING)capNum(RIGHT.SBFEDPD31CountCardEver_, 99),
				SELF.SBFE.SBFEDPD31CountLease := (STRING)capNum(RIGHT.SBFEDPD31CountLease_, 99),
				SELF.SBFE.SBFEDelq31LeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq31LeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountLease06 := (STRING)capNum(RIGHT.SBFEDPD31CountLease06_, 99),
				SELF.SBFE.SBFEDPD31CountLease12 := (STRING)capNum(RIGHT.SBFEDPD31CountLease12_, 99),
				SELF.SBFE.SBFEDPD31CountLease24 := (STRING)capNum(RIGHT.SBFEDPD31CountLease24_, 99),
				SELF.SBFE.SBFEDPD31CountLease36 := (STRING)capNum(RIGHT.SBFEDPD31CountLease36_, 99),
				SELF.SBFE.SBFEDPD31CountLease60 := (STRING)capNum(RIGHT.SBFEDPD31CountLease60_, 99),
				SELF.SBFE.SBFEDPD31CountLease84 := (STRING)capNum(RIGHT.SBFEDPD31CountLease84_, 99),
				SELF.SBFE.SBFEDPD31CountLeaseEver := (STRING)capNum(RIGHT.SBFEDPD31CountLeaseEver_, 99),
				SELF.SBFE.SBFEDPD31CountLetter := (STRING)capNum(RIGHT.SBFEDPD31CountLetter_, 99),
				SELF.SBFE.SBFEDelq31LetterCount03M := (STRING)capNum(RIGHT.SBFEDelq31LetterCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountLetter06 := (STRING)capNum(RIGHT.SBFEDPD31CountLetter06_, 99),
				SELF.SBFE.SBFEDPD31CountLetter12 := (STRING)capNum(RIGHT.SBFEDPD31CountLetter12_, 99),
				SELF.SBFE.SBFEDPD31CountLetter24 := (STRING)capNum(RIGHT.SBFEDPD31CountLetter24_, 99),
				SELF.SBFE.SBFEDPD31CountLetter36 := (STRING)capNum(RIGHT.SBFEDPD31CountLetter36_, 99),
				SELF.SBFE.SBFEDPD31CountLetter60 := (STRING)capNum(RIGHT.SBFEDPD31CountLetter60_, 99),
				SELF.SBFE.SBFEDPD31CountLetter84 := (STRING)capNum(RIGHT.SBFEDPD31CountLetter84_, 99),
				SELF.SBFE.SBFEDPD31CountLetterEver := (STRING)capNum(RIGHT.SBFEDPD31CountLetterEver_, 99),
				SELF.SBFE.SBFEDPD31CountOLine := (STRING)capNum(RIGHT.SBFEDPD31CountOLine_, 99),
				SELF.SBFE.SBFEDelq31OELineCount03M := (STRING)capNum(RIGHT.SBFEDelq31OELineCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountOLine06 := (STRING)capNum(RIGHT.SBFEDPD31CountOLine06_, 99),
				SELF.SBFE.SBFEDPD31CountOLine12 := (STRING)capNum(RIGHT.SBFEDPD31CountOLine12_, 99),
				SELF.SBFE.SBFEDPD31CountOLine24 := (STRING)capNum(RIGHT.SBFEDPD31CountOLine24_, 99),
				SELF.SBFE.SBFEDPD31CountOLine36 := (STRING)capNum(RIGHT.SBFEDPD31CountOLine36_, 99),
				SELF.SBFE.SBFEDPD31CountOLine60 := (STRING)capNum(RIGHT.SBFEDPD31CountOLine60_, 99),
				SELF.SBFE.SBFEDPD31CountOLine84 := (STRING)capNum(RIGHT.SBFEDPD31CountOLine84_, 99),
				SELF.SBFE.SBFEDPD31CountOLineEver := (STRING)capNum(RIGHT.SBFEDPD31CountOLineEver_, 99),
				SELF.SBFE.SBFEDPD31CountOther := (STRING)capNum(RIGHT.SBFEDPD31CountOther_, 99),
				SELF.SBFE.SBFEDelq31OtherCount03M := (STRING)capNum(RIGHT.SBFEDelq31OtherCount03M_, 99);
				SELF.SBFE.SBFEDPD31CountOther06 := (STRING)capNum(RIGHT.SBFEDPD31CountOther06_, 99),
				SELF.SBFE.SBFEDPD31CountOther12 := (STRING)capNum(RIGHT.SBFEDPD31CountOther12_, 99),
				SELF.SBFE.SBFEDPD31CountOther24 := (STRING)capNum(RIGHT.SBFEDPD31CountOther24_, 99),
				SELF.SBFE.SBFEDPD31CountOther36 := (STRING)capNum(RIGHT.SBFEDPD31CountOther36_, 99),
				SELF.SBFE.SBFEDPD31CountOther60 := (STRING)capNum(RIGHT.SBFEDPD31CountOther60_, 99),
				SELF.SBFE.SBFEDPD31CountOther84 := (STRING)capNum(RIGHT.SBFEDPD31CountOther84_, 99),
				SELF.SBFE.SBFEDPD31CountOtherEver := (STRING)capNum(RIGHT.SBFEDPD31CountOtherEver_, 99),
				SELF.SBFE.SBFEDelinquentCount := (STRING)capNum(RIGHT.Sbfedelinquentcount_, 99),
				SELF.SBFE.SBFEDelq61Count03M := (STRING)capNum(RIGHT.SBFEDelq61Count03M_, 99);
				SELF.SBFE.SBFEDelinquentCount06 := (STRING)capNum(RIGHT.Sbfedelinquentcount06_, 99),
				SELF.SBFE.SBFEDelinquentCount12 := (STRING)capNum(RIGHT.Sbfedelinquentcount12_, 99),
				SELF.SBFE.SBFEDelinquentCount24 := (STRING)capNum(RIGHT.Sbfedelinquentcount24_, 99),
				SELF.SBFE.SBFEDelinquentCount36 := (STRING)capNum(RIGHT.Sbfedelinquentcount36_, 99),
				SELF.SBFE.SBFEDelinquentCount60 := (STRING)capNum(RIGHT.Sbfedelinquentcount60_, 99),
				SELF.SBFE.SBFEDelinquentCount84 := (STRING)capNum(RIGHT.Sbfedelinquentcount84_, 99),
				SELF.SBFE.SBFEDelinquentCountEver := (STRING)capNum(RIGHT.Sbfedelinquentcountever_, 99),
				SELF.SBFE.SBFEDelq31InstCountTtl := (STRING)capNum(RIGHT.SBFEDelq31InstCountTtl_, 99),
				SELF.SBFE.SBFEDelq31InstCountEver := (STRING)capNum(RIGHT.SBFEDelq31InstCountEver_, 99),
				SELF.SBFE.SBFEDelq31InstCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq31InstCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq31RevCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq31RevCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq31RevCountEver := (STRING)capNum(RIGHT.SBFEDelq31RevCountEver_, 99),
				SELF.SBFE.SBFEDelq31RevCountTtl := (STRING)capNum(RIGHT.SBFEDelq31RevCountTtl_, 99),
				SELF.SBFE.SBFEDelq31RevCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq31RevCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq61CountTtl := (STRING)capNum(RIGHT.SBFEDelq61CountTtl_, 99),
				SELF.SBFE.SBFEDelq61CountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq61CountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq61CountEverTtl := (STRING)capNum(RIGHT.SBFEDelq61CountEverTtl_, 99),
				SELF.SBFE.SBFEDelq91CountEverTtl := (STRING)capNum(RIGHT.SBFEDelq91CountEverTtl_, 99),
				SELF.SBFE.SBFEDelq121CountEverTtl := (STRING)capNum(RIGHT.SBFEDelq121CountEverTtl_, 99),
				SELF.SBFE.SBFEDelinquentCountLoan := (STRING)capNum(RIGHT.Sbfedelinquentcountloan_, 99),
				SELF.SBFE.SBFEDelq61LoanCount03M := (STRING)capNum(RIGHT.SBFEDelq61LoanCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountLoan06 := (STRING)capNum(RIGHT.Sbfedelinquentcountloan06_, 99),
				SELF.SBFE.SBFEDelinquentCountLoan12 := (STRING)capNum(RIGHT.Sbfedelinquentcountloan12_, 99),
				SELF.SBFE.SBFEDelinquentCountLoan24 := (STRING)capNum(RIGHT.Sbfedelinquentcountloan24_, 99),
				SELF.SBFE.SBFEDelinquentCountLoan36 := (STRING)capNum(RIGHT.Sbfedelinquentcountloan36_, 99),
				SELF.SBFE.SBFEDelinquentCountLoan60 := (STRING)capNum(RIGHT.Sbfedelinquentcountloan60_, 99),
				SELF.SBFE.SBFEDelinquentCountLoan84 := (STRING)capNum(RIGHT.Sbfedelinquentcountloan84_, 99),
				SELF.SBFE.SBFEDelinquentCountLoanEver := (STRING)capNum(RIGHT.Sbfedelinquentcountloanever_, 99),
				SELF.SBFE.SBFEDelinquentCountLine := (STRING)capNum(RIGHT.Sbfedelinquentcountline_, 99),
				SELF.SBFE.SBFEDelq61LineCount03M := (STRING)capNum(RIGHT.SBFEDelq61LineCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountLine06 := (STRING)capNum(RIGHT.Sbfedelinquentcountline06_, 99),
				SELF.SBFE.SBFEDelinquentCountLine12 := (STRING)capNum(RIGHT.Sbfedelinquentcountline12_, 99),
				SELF.SBFE.SBFEDelinquentCountLine24 := (STRING)capNum(RIGHT.Sbfedelinquentcountline24_, 99),
				SELF.SBFE.SBFEDelinquentCountLine36 := (STRING)capNum(RIGHT.Sbfedelinquentcountline36_, 99),
				SELF.SBFE.SBFEDelinquentCountLine60 := (STRING)capNum(RIGHT.Sbfedelinquentcountline60_, 99),
				SELF.SBFE.SBFEDelinquentCountLine84 := (STRING)capNum(RIGHT.Sbfedelinquentcountline84_, 99),
				SELF.SBFE.SBFEDelinquentCountLineEver := (STRING)capNum(RIGHT.Sbfedelinquentcountlineever_, 99),
				SELF.SBFE.SBFEDelinquentCountCard := (STRING)capNum(RIGHT.Sbfedelinquentcountcard_, 99),
				SELF.SBFE.SBFEDelq61CardCount03M := (STRING)capNum(RIGHT.SBFEDelq61CardCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountCard06 := (STRING)capNum(RIGHT.Sbfedelinquentcountcard06_, 99),
				SELF.SBFE.SBFEDelinquentCountCard12 := (STRING)capNum(RIGHT.Sbfedelinquentcountcard12_, 99),
				SELF.SBFE.SBFEDelinquentCountCard24 := (STRING)capNum(RIGHT.Sbfedelinquentcountcard24_, 99),
				SELF.SBFE.SBFEDelinquentCountCard36 := (STRING)capNum(RIGHT.Sbfedelinquentcountcard36_, 99),
				SELF.SBFE.SBFEDelinquentCountCard60 := (STRING)capNum(RIGHT.Sbfedelinquentcountcard60_, 99),
				SELF.SBFE.SBFEDelinquentCountCard84 := (STRING)capNum(RIGHT.Sbfedelinquentcountcard84_, 99),
				SELF.SBFE.SBFEDelinquentCountCardEver := (STRING)capNum(RIGHT.Sbfedelinquentcountcardever_, 99),
				SELF.SBFE.SBFEDelinquentCountLease := (STRING)capNum(RIGHT.Sbfedelinquentcountlease_, 99),
				SELF.SBFE.SBFEDelq61LeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq61LeaseCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountLease06 := (STRING)capNum(RIGHT.Sbfedelinquentcountlease06_, 99),
				SELF.SBFE.SBFEDelinquentCountLease12 := (STRING)capNum(RIGHT.Sbfedelinquentcountlease12_, 99),
				SELF.SBFE.SBFEDelinquentCountLease24 := (STRING)capNum(RIGHT.Sbfedelinquentcountlease24_, 99),
				SELF.SBFE.SBFEDelinquentCountLease36 := (STRING)capNum(RIGHT.Sbfedelinquentcountlease36_, 99),
				SELF.SBFE.SBFEDelinquentCountLease60 := (STRING)capNum(RIGHT.Sbfedelinquentcountlease60_, 99),
				SELF.SBFE.SBFEDelinquentCountLease84 := (STRING)capNum(RIGHT.Sbfedelinquentcountlease84_, 99),
				SELF.SBFE.SBFEDelinquentCountLeaseEver := (STRING)capNum(RIGHT.Sbfedelinquentcountleaseever_, 99),
				SELF.SBFE.SBFEDelinquentCountLetter := (STRING)capNum(RIGHT.Sbfedelinquentcountletter_, 99),
				SELF.SBFE.SBFEDelq61LetterCount03M := (STRING)capNum(RIGHT.SBFEDelq61LetterCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountLetter06 := (STRING)capNum(RIGHT.Sbfedelinquentcountletter06_, 99),
				SELF.SBFE.SBFEDelinquentCountLetter12 := (STRING)capNum(RIGHT.Sbfedelinquentcountletter12_, 99),
				SELF.SBFE.SBFEDelinquentCountLetter24 := (STRING)capNum(RIGHT.Sbfedelinquentcountletter24_, 99),
				SELF.SBFE.SBFEDelinquentCountLetter36 := (STRING)capNum(RIGHT.Sbfedelinquentcountletter36_, 99),
				SELF.SBFE.SBFEDelinquentCountLetter60 := (STRING)capNum(RIGHT.Sbfedelinquentcountletter60_, 99),
				SELF.SBFE.SBFEDelinquentCountLetter84 := (STRING)capNum(RIGHT.Sbfedelinquentcountletter84_, 99),
				SELF.SBFE.SBFEDelinquentCountLetterEver := (STRING)capNum(RIGHT.Sbfedelinquentcountletterever_, 99),
				SELF.SBFE.SBFEDelinquentCountOLine := (STRING)capNum(RIGHT.Sbfedelinquentcountoline_, 99),
				SELF.SBFE.SBFEDelq61OELineCount03M := (STRING)capNum(RIGHT.SBFEDelq61OELineCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountOLine06 := (STRING)capNum(RIGHT.Sbfedelinquentcountoline06_, 99),
				SELF.SBFE.SBFEDelinquentCountOLine12 := (STRING)capNum(RIGHT.Sbfedelinquentcountoline12_, 99),
				SELF.SBFE.SBFEDelinquentCountOLine24 := (STRING)capNum(RIGHT.Sbfedelinquentcountoline24_, 99),
				SELF.SBFE.SBFEDelinquentCountOLine36 := (STRING)capNum(RIGHT.Sbfedelinquentcountoline36_, 99),
				SELF.SBFE.SBFEDelinquentCountOLine60 := (STRING)capNum(RIGHT.Sbfedelinquentcountoline60_, 99),
				SELF.SBFE.SBFEDelinquentCountOLine84 := (STRING)capNum(RIGHT.Sbfedelinquentcountoline84_, 99),
				SELF.SBFE.SBFEDelinquentCountOLineEver := (STRING)capNum(RIGHT.Sbfedelinquentcountolineever_, 99),
				SELF.SBFE.SBFEDelinquentCountOther := (STRING)capNum(RIGHT.Sbfedelinquentcountother_, 99),
				SELF.SBFE.SBFEDelq61OtherCount03M := (STRING)capNum(RIGHT.SBFEDelq61OtherCount03M_, 99);
				SELF.SBFE.SBFEDelinquentCountOther06 := (STRING)capNum(RIGHT.Sbfedelinquentcountother06_, 99),
				SELF.SBFE.SBFEDelinquentCountOther12 := (STRING)capNum(RIGHT.Sbfedelinquentcountother12_, 99),
				SELF.SBFE.SBFEDelinquentCountOther24 := (STRING)capNum(RIGHT.Sbfedelinquentcountother24_, 99),
				SELF.SBFE.SBFEDelinquentCountOther36 := (STRING)capNum(RIGHT.Sbfedelinquentcountother36_, 99),
				SELF.SBFE.SBFEDelinquentCountOther60 := (STRING)capNum(RIGHT.Sbfedelinquentcountother60_, 99),
				SELF.SBFE.SBFEDelinquentCountOther84 := (STRING)capNum(RIGHT.Sbfedelinquentcountother84_, 99),
				SELF.SBFE.SBFEDelinquentCountOtherEver := (STRING)capNum(RIGHT.Sbfedelinquentcountotherever_, 99),
				SELF.SBFE.SBFEDelq61InstCountTtl := (STRING)capNum(RIGHT.SBFEDelq61InstCountTtl_, 99),
				SELF.SBFE.SBFEDelq61InstCountEver := (STRING)capNum(RIGHT.SBFEDelq61InstCountEver_, 99),
				SELF.SBFE.SBFEDelq61InstCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq61InstCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq61RevCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq61RevCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq61RevCountEver := (STRING)capNum(RIGHT.SBFEDelq61RevCountEver_, 99),
				SELF.SBFE.SBFEDelq61RevCountTtl := (STRING)capNum(RIGHT.SBFEDelq61RevCountTtl_, 99),
				SELF.SBFE.SBFEDelq61RevCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq61RevCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq91CountTtl := (STRING)capNum(RIGHT.SBFEDelq91CountTtl_, 99),
				SELF.SBFE.SBFEDelq121CountTtl := (STRING)capNum(RIGHT.SBFEDelq121CountTtl_, 99),
				SELF.SBFE.SBFEDelq91CountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq91CountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDPD91Count := (STRING)capNum(RIGHT.Sbfedpd91count_, 99),
				SELF.SBFE.SBFEDelq91Count03M := (STRING)capNum(RIGHT.SBFEDelq91Count03M_, 99);
				SELF.SBFE.SBFEDPD91Count06 := (STRING)capNum(RIGHT.Sbfedpd91count06_, 99),
				SELF.SBFE.SBFEDPD91Count12 := (STRING)capNum(RIGHT.Sbfedpd91count12_, 99),
				SELF.SBFE.SBFEDPD91Count24 := (STRING)capNum(RIGHT.Sbfedpd91count24_, 99),
				SELF.SBFE.SBFEDPD91Count36 := (STRING)capNum(RIGHT.Sbfedpd91count36_, 99),
				SELF.SBFE.SBFEDPD91Count60 := (STRING)capNum(RIGHT.Sbfedpd91count60_, 99),
				SELF.SBFE.SBFEDPD91Count84 := (STRING)capNum(RIGHT.Sbfedpd91count84_, 99),
				SELF.SBFE.SBFEDPD91CountEver := (STRING)capNum(RIGHT.Sbfedpd91countever_, 99);
				SELF.SBFE.SBFEDPD91CountLoan := (STRING)capNum(RIGHT.Sbfedpd91countloan_, 99),
				SELF.SBFE.SBFEDelq91LoanCount03M := (STRING)capNum(RIGHT.SBFEDelq91LoanCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountLoan06 := (STRING)capNum(RIGHT.Sbfedpd91countloan06_, 99),
				SELF.SBFE.SBFEDPD91CountLoan12 := (STRING)capNum(RIGHT.Sbfedpd91countloan12_, 99),
				SELF.SBFE.SBFEDPD91CountLoan24 := (STRING)capNum(RIGHT.Sbfedpd91countloan24_, 99),
				SELF.SBFE.SBFEDPD91CountLoan36 := (STRING)capNum(RIGHT.Sbfedpd91countloan36_, 99),
				SELF.SBFE.SBFEDPD91CountLoan60 := (STRING)capNum(RIGHT.Sbfedpd91countloan60_, 99),
				SELF.SBFE.SBFEDPD91CountLoan84 := (STRING)capNum(RIGHT.Sbfedpd91countloan84_, 99),
				SELF.SBFE.SBFEDPD91CountLoanEver := (STRING)capNum(RIGHT.Sbfedpd91countloanever_, 99),
				SELF.SBFE.SBFEDPD91CountLine := (STRING)capNum(RIGHT.Sbfedpd91countline_, 99),
				SELF.SBFE.SBFEDelq91LineCount03M := (STRING)capNum(RIGHT.SBFEDelq91LineCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountLine06 := (STRING)capNum(RIGHT.Sbfedpd91countline06_, 99),
				SELF.SBFE.SBFEDPD91CountLine12 := (STRING)capNum(RIGHT.Sbfedpd91countline12_, 99),
				SELF.SBFE.SBFEDPD91CountLine24 := (STRING)capNum(RIGHT.Sbfedpd91countline24_, 99),
				SELF.SBFE.SBFEDPD91CountLine36 := (STRING)capNum(RIGHT.Sbfedpd91countline36_, 99),
				SELF.SBFE.SBFEDPD91CountLine60 := (STRING)capNum(RIGHT.Sbfedpd91countline60_, 99),
				SELF.SBFE.SBFEDPD91CountLine84 := (STRING)capNum(RIGHT.Sbfedpd91countline84_, 99),
				SELF.SBFE.SBFEDPD91CountLineEver := (STRING)capNum(RIGHT.Sbfedpd91countlineever_, 99),
				SELF.SBFE.SBFEDPD91CountCard := (STRING)capNum(RIGHT.Sbfedpd91countcard_, 99),
				SELF.SBFE.SBFEDelq91CardCount03M := (STRING)capNum(RIGHT.SBFEDelq91CardCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountCard06 := (STRING)capNum(RIGHT.Sbfedpd91countcard06_, 99),
				SELF.SBFE.SBFEDPD91CountCard12 := (STRING)capNum(RIGHT.Sbfedpd91countcard12_, 99),
				SELF.SBFE.SBFEDPD91CountCard24 := (STRING)capNum(RIGHT.Sbfedpd91countcard24_, 99),
				SELF.SBFE.SBFEDPD91CountCard36 := (STRING)capNum(RIGHT.Sbfedpd91countcard36_, 99),
				SELF.SBFE.SBFEDPD91CountCard60 := (STRING)capNum(RIGHT.Sbfedpd91countcard60_, 99),
				SELF.SBFE.SBFEDPD91CountCard84 := (STRING)capNum(RIGHT.Sbfedpd91countcard84_, 99),
				SELF.SBFE.SBFEDPD91CountCardEver := (STRING)capNum(RIGHT.Sbfedpd91countcardever_, 99),
				SELF.SBFE.SBFEDPD91CountLease := (STRING)capNum(RIGHT.Sbfedpd91countlease_, 99),
				SELF.SBFE.SBFEDelq91LeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq91LeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountLease06 := (STRING)capNum(RIGHT.Sbfedpd91countlease06_, 99),
				SELF.SBFE.SBFEDPD91CountLease12 := (STRING)capNum(RIGHT.Sbfedpd91countlease12_, 99),
				SELF.SBFE.SBFEDPD91CountLease24 := (STRING)capNum(RIGHT.Sbfedpd91countlease24_, 99),
				SELF.SBFE.SBFEDPD91CountLease36 := (STRING)capNum(RIGHT.Sbfedpd91countlease36_, 99),
				SELF.SBFE.SBFEDPD91CountLease60 := (STRING)capNum(RIGHT.Sbfedpd91countlease60_, 99),
				SELF.SBFE.SBFEDPD91CountLease84 := (STRING)capNum(RIGHT.Sbfedpd91countlease84_, 99),
				SELF.SBFE.SBFEDPD91CountLeaseEver := (STRING)capNum(RIGHT.Sbfedpd91countleaseever_, 99),
				SELF.SBFE.SBFEDPD91CountLetter := (STRING)capNum(RIGHT.Sbfedpd91countletter_, 99),
				SELF.SBFE.SBFEDelq91LetterCount03M := (STRING)capNum(RIGHT.SBFEDelq91LetterCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountLetter06 := (STRING)capNum(RIGHT.Sbfedpd91countletter06_, 99),
				SELF.SBFE.SBFEDPD91CountLetter12 := (STRING)capNum(RIGHT.Sbfedpd91countletter12_, 99),
				SELF.SBFE.SBFEDPD91CountLetter24 := (STRING)capNum(RIGHT.Sbfedpd91countletter24_, 99),
				SELF.SBFE.SBFEDPD91CountLetter36 := (STRING)capNum(RIGHT.Sbfedpd91countletter36_, 99),
				SELF.SBFE.SBFEDPD91CountLetter60 := (STRING)capNum(RIGHT.Sbfedpd91countletter60_, 99),
				SELF.SBFE.SBFEDPD91CountLetter84 := (STRING)capNum(RIGHT.Sbfedpd91countletter84_, 99),
				SELF.SBFE.SBFEDPD91CountLetterEver := (STRING)capNum(RIGHT.Sbfedpd91countletterever_, 99),
				SELF.SBFE.SBFEDPD91CountOLine := (STRING)capNum(RIGHT.Sbfedpd91countoline_, 99),
				SELF.SBFE.SBFEDelq91OELineCount03M := (STRING)capNum(RIGHT.SBFEDelq91OELineCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountOLine06 := (STRING)capNum(RIGHT.Sbfedpd91countoline06_, 99),
				SELF.SBFE.SBFEDPD91CountOLine12 := (STRING)capNum(RIGHT.Sbfedpd91countoline12_, 99),
				SELF.SBFE.SBFEDPD91CountOLine24 := (STRING)capNum(RIGHT.Sbfedpd91countoline24_, 99),
				SELF.SBFE.SBFEDPD91CountOLine36 := (STRING)capNum(RIGHT.Sbfedpd91countoline36_, 99),
				SELF.SBFE.SBFEDPD91CountOLine60 := (STRING)capNum(RIGHT.Sbfedpd91countoline60_, 99),
				SELF.SBFE.SBFEDPD91CountOLine84 := (STRING)capNum(RIGHT.Sbfedpd91countoline84_, 99),
				SELF.SBFE.SBFEDPD91CountOLineEver := (STRING)capNum(RIGHT.Sbfedpd91countolineever_, 99),
				SELF.SBFE.SBFEDPD91CountOther := (STRING)capNum(RIGHT.Sbfedpd91countother_, 99),
				SELF.SBFE.SBFEDelq91OtherCount03M := (STRING)capNum(RIGHT.SBFEDelq91OtherCount03M_, 99);
				SELF.SBFE.SBFEDPD91CountOther06 := (STRING)capNum(RIGHT.Sbfedpd91countother06_, 99),
				SELF.SBFE.SBFEDPD91CountOther12 := (STRING)capNum(RIGHT.Sbfedpd91countother12_, 99),
				SELF.SBFE.SBFEDPD91CountOther24 := (STRING)capNum(RIGHT.Sbfedpd91countother24_, 99),
				SELF.SBFE.SBFEDPD91CountOther36 := (STRING)capNum(RIGHT.Sbfedpd91countother36_, 99),
				SELF.SBFE.SBFEDPD91CountOther60 := (STRING)capNum(RIGHT.Sbfedpd91countother60_, 99),
				SELF.SBFE.SBFEDPD91CountOther84 := (STRING)capNum(RIGHT.Sbfedpd91countother84_, 99),
				SELF.SBFE.SBFEDPD91CountOtherEver := (STRING)capNum(RIGHT.Sbfedpd91countotherever_, 99),
				SELF.SBFE.SBFEDelq91InstCountTtl := (STRING)capNum(RIGHT.SBFEDelq91InstCountTtl_, 99),
				SELF.SBFE.SBFEDelq91InstCountEver := (STRING)capNum(RIGHT.SBFEDelq91InstCountEver_, 99),
				SELF.SBFE.SBFEDelq91InstCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq91InstCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq91RevCountEverTtl := (STRING)capNum(RIGHT.SBFEDelq91RevCountEverTtl_, 99),
				SELF.SBFE.SBFEDelq91RevCountEver := (STRING)capNum(RIGHT.SBFEDelq91RevCountEver_, 99),
				SELF.SBFE.SBFEDelq91RevCountTtl := (STRING)capNum(RIGHT.SBFEDelq91RevCountTtl_, 99),
				SELF.SBFE.SBFEDelq91RevCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq91RevCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq121CountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq121CountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDPD121Count := (STRING)capNum(RIGHT.Sbfedpd121count_, 99),
				SELF.SBFE.SBFEDelq121Count03M := (STRING)capNum(RIGHT.SBFEDelq121Count03M_, 99);
				SELF.SBFE.SBFEDPD121Count06 := (STRING)capNum(RIGHT.Sbfedpd121count06_, 99),
				SELF.SBFE.SBFEDPD121Count12 := (STRING)capNum(RIGHT.Sbfedpd121count12_, 99),
				SELF.SBFE.SBFEDPD121Count24 := (STRING)capNum(RIGHT.Sbfedpd121count24_, 99),
				SELF.SBFE.SBFEDPD121Count36 := (STRING)capNum(RIGHT.Sbfedpd121count36_, 99),
				SELF.SBFE.SBFEDPD121Count60 := (STRING)capNum(RIGHT.Sbfedpd121count60_, 99),
				SELF.SBFE.SBFEDPD121Count84 := (STRING)capNum(RIGHT.Sbfedpd121count84_, 99),
				SELF.SBFE.SBFEDPD121CountEver := (STRING)capNum(RIGHT.Sbfedpd121countever_, 99),
				SELF.SBFE.SBFEDPD121CountLoan := (STRING)capNum(RIGHT.SBFEDPD121CountLoan_, 99),
				SELF.SBFE.SBFEDelq121LoanCount03M := (STRING)capNum(RIGHT.SBFEDelq121LoanCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountLoan06 := (STRING)capNum(RIGHT.SBFEDPD121CountLoan06_, 99),
				SELF.SBFE.SBFEDPD121CountLoan12 := (STRING)capNum(RIGHT.SBFEDPD121CountLoan12_, 99),
				SELF.SBFE.SBFEDPD121CountLoan24 := (STRING)capNum(RIGHT.SBFEDPD121CountLoan24_, 99),
				SELF.SBFE.SBFEDPD121CountLoan36 := (STRING)capNum(RIGHT.SBFEDPD121CountLoan36_, 99),
				SELF.SBFE.SBFEDPD121CountLoan60 := (STRING)capNum(RIGHT.SBFEDPD121CountLoan60_, 99),
				SELF.SBFE.SBFEDPD121CountLoan84 := (STRING)capNum(RIGHT.SBFEDPD121CountLoan84_, 99),
				SELF.SBFE.SBFEDPD121CountLoanEver := (STRING)capNum(RIGHT.SBFEDPD121CountLoanEver_, 99),
				SELF.SBFE.SBFEDPD121CountLine := (STRING)capNum(RIGHT.SBFEDPD121CountLine_, 99),
				SELF.SBFE.SBFEDelq121LineCount03M := (STRING)capNum(RIGHT.SBFEDelq121LineCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountLine06 := (STRING)capNum(RIGHT.SBFEDPD121CountLine06_, 99),
				SELF.SBFE.SBFEDPD121CountLine12 := (STRING)capNum(RIGHT.SBFEDPD121CountLine12_, 99),
				SELF.SBFE.SBFEDPD121CountLine24 := (STRING)capNum(RIGHT.SBFEDPD121CountLine24_, 99),
				SELF.SBFE.SBFEDPD121CountLine36 := (STRING)capNum(RIGHT.SBFEDPD121CountLine36_, 99),
				SELF.SBFE.SBFEDPD121CountLine60 := (STRING)capNum(RIGHT.SBFEDPD121CountLine60_, 99),
				SELF.SBFE.SBFEDPD121CountLine84 := (STRING)capNum(RIGHT.SBFEDPD121CountLine84_, 99),
				SELF.SBFE.SBFEDPD121CountLineEver := (STRING)capNum(RIGHT.SBFEDPD121CountLineEver_, 99),
				SELF.SBFE.SBFEDPD121CountCard := (STRING)capNum(RIGHT.SBFEDPD121CountCard_, 99),
				SELF.SBFE.SBFEDelq121CardCount03M := (STRING)capNum(RIGHT.SBFEDelq121CardCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountCard06 := (STRING)capNum(RIGHT.SBFEDPD121CountCard06_, 99),
				SELF.SBFE.SBFEDPD121CountCard12 := (STRING)capNum(RIGHT.SBFEDPD121CountCard12_, 99),
				SELF.SBFE.SBFEDPD121CountCard24 := (STRING)capNum(RIGHT.SBFEDPD121CountCard24_, 99),
				SELF.SBFE.SBFEDPD121CountCard36 := (STRING)capNum(RIGHT.SBFEDPD121CountCard36_, 99),
				SELF.SBFE.SBFEDPD121CountCard60 := (STRING)capNum(RIGHT.SBFEDPD121CountCard60_, 99),
				SELF.SBFE.SBFEDPD121CountCard84 := (STRING)capNum(RIGHT.SBFEDPD121CountCard84_, 99),
				SELF.SBFE.SBFEDPD121CountCardEver := (STRING)capNum(RIGHT.SBFEDPD121CountCardEver_, 99),
				SELF.SBFE.SBFEDPD121CountLease := (STRING)capNum(RIGHT.SBFEDPD121CountLease_, 99),
				SELF.SBFE.SBFEDelq121LeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq121LeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountLease06 := (STRING)capNum(RIGHT.SBFEDPD121CountLease06_, 99),
				SELF.SBFE.SBFEDPD121CountLease12 := (STRING)capNum(RIGHT.SBFEDPD121CountLease12_, 99),
				SELF.SBFE.SBFEDPD121CountLease24 := (STRING)capNum(RIGHT.SBFEDPD121CountLease24_, 99),
				SELF.SBFE.SBFEDPD121CountLease36 := (STRING)capNum(RIGHT.SBFEDPD121CountLease36_, 99),
				SELF.SBFE.SBFEDPD121CountLease60 := (STRING)capNum(RIGHT.SBFEDPD121CountLease60_, 99),
				SELF.SBFE.SBFEDPD121CountLease84 := (STRING)capNum(RIGHT.SBFEDPD121CountLease84_, 99),
				SELF.SBFE.SBFEDPD121CountLeaseEver := (STRING)capNum(RIGHT.SBFEDPD121CountLeaseEver_, 99),
				SELF.SBFE.SBFEDPD121CountLetter := (STRING)capNum(RIGHT.SBFEDPD121CountLetter_, 99),
				SELF.SBFE.SBFEDelq121LetterCount03M := (STRING)capNum(RIGHT.SBFEDelq121LetterCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountLetter06 := (STRING)capNum(RIGHT.SBFEDPD121CountLetter06_, 99),
				SELF.SBFE.SBFEDPD121CountLetter12 := (STRING)capNum(RIGHT.SBFEDPD121CountLetter12_, 99),
				SELF.SBFE.SBFEDPD121CountLetter24 := (STRING)capNum(RIGHT.SBFEDPD121CountLetter24_, 99),
				SELF.SBFE.SBFEDPD121CountLetter36 := (STRING)capNum(RIGHT.SBFEDPD121CountLetter36_, 99),
				SELF.SBFE.SBFEDPD121CountLetter60 := (STRING)capNum(RIGHT.SBFEDPD121CountLetter60_, 99),
				SELF.SBFE.SBFEDPD121CountLetter84 := (STRING)capNum(RIGHT.SBFEDPD121CountLetter84_, 99),
				SELF.SBFE.SBFEDPD121CountLetterEver := (STRING)capNum(RIGHT.SBFEDPD121CountLetterEver_, 99),
				SELF.SBFE.SBFEDPD121CountOLine := (STRING)capNum(RIGHT.SBFEDPD121CountOLine_, 99),
				SELF.SBFE.SBFEDelq121OELineCount03M := (STRING)capNum(RIGHT.SBFEDelq121OELineCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountOLine06 := (STRING)capNum(RIGHT.SBFEDPD121CountOLine06_, 99),
				SELF.SBFE.SBFEDPD121CountOLine12 := (STRING)capNum(RIGHT.SBFEDPD121CountOLine12_, 99),
				SELF.SBFE.SBFEDPD121CountOLine24 := (STRING)capNum(RIGHT.SBFEDPD121CountOLine24_, 99),
				SELF.SBFE.SBFEDPD121CountOLine36 := (STRING)capNum(RIGHT.SBFEDPD121CountOLine36_, 99),
				SELF.SBFE.SBFEDPD121CountOLine60 := (STRING)capNum(RIGHT.SBFEDPD121CountOLine60_, 99),
				SELF.SBFE.SBFEDPD121CountOLine84 := (STRING)capNum(RIGHT.SBFEDPD121CountOLine84_, 99),
				SELF.SBFE.SBFEDPD121CountOLineEver := (STRING)capNum(RIGHT.SBFEDPD121CountOLineEver_, 99),
				SELF.SBFE.SBFEDPD121CountOther := (STRING)capNum(RIGHT.SBFEDPD121CountOther_, 99),
				SELF.SBFE.SBFEDelq121OtherCount03M := (STRING)capNum(RIGHT.SBFEDelq121OtherCount03M_, 99);
				SELF.SBFE.SBFEDPD121CountOther06 := (STRING)capNum(RIGHT.SBFEDPD121CountOther06_, 99),
				SELF.SBFE.SBFEDPD121CountOther12 := (STRING)capNum(RIGHT.SBFEDPD121CountOther12_, 99),
				SELF.SBFE.SBFEDPD121CountOther24 := (STRING)capNum(RIGHT.SBFEDPD121CountOther24_, 99),
				SELF.SBFE.SBFEDPD121CountOther36 := (STRING)capNum(RIGHT.SBFEDPD121CountOther36_, 99),
				SELF.SBFE.SBFEDPD121CountOther60 := (STRING)capNum(RIGHT.SBFEDPD121CountOther60_, 99),
				SELF.SBFE.SBFEDPD121CountOther84 := (STRING)capNum(RIGHT.SBFEDPD121CountOther84_, 99),
				SELF.SBFE.SBFEDPD121CountOtherEver := (STRING)capNum(RIGHT.SBFEDPD121CountOtherEver_, 99),
				SELF.SBFE.SBFEDelq121InstCountEver := (STRING)capNum(RIGHT.SBFEDelq121InstCountEver_, 99),
				SELF.SBFE.SBFEDelq121InstCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq121InstCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelq121RevCountEver := (STRING)capNum(RIGHT.SBFEDelq121RevCountEver_, 99),
				SELF.SBFE.SBFEDelq121RevCountTtlChargeoff := (STRING)capNum(RIGHT.SBFEDelq121RevCountTtlChargeoff_, 99),
				SELF.SBFE.SBFEDelinquent31Ratio := (STRING)capNum(RIGHT.SBFEDelinquent31Ratio_, 10),
				SELF.SBFE.SBFEDelinquent31LoanRatio := (STRING)capNum(RIGHT.SBFEDelinquent31LoanRatio_, 10),
				SELF.SBFE.SBFEDelinquent31LineRatio := (STRING)capNum(RIGHT.SBFEDelinquent31LineRatio_, 10),
				SELF.SBFE.SBFEDelinquent31CardRatio := (STRING)capNum(RIGHT.SBFEDelinquent31CardRatio_, 10),
				SELF.SBFE.SBFEDelinquent31LeaseRatio := (STRING)capNum(RIGHT.SBFEDelinquent31LeaseRatio_, 10),
				SELF.SBFE.SBFEDelinquent31LetterRatio := (STRING)capNum(RIGHT.SBFEDelinquent31LetterRatio_, 10),
				SELF.SBFE.SBFEDelinquent31OLineRatio := (STRING)capNum(RIGHT.SBFEDelinquent31OLineRatio_, 10),
				SELF.SBFE.SBFEDelinquent31OtherRatio := (STRING)capNum(RIGHT.SBFEDelinquent31OtherRatio_, 10),
				SELF.SBFE.SBFEDelinquent61Ratio := (STRING)capNum(RIGHT.SBFEDelinquent61Ratio_, 10),
				SELF.SBFE.SBFEDelinquent61LoanRatio := (STRING)capNum(RIGHT.SBFEDelinquent61LoanRatio_, 10),
				SELF.SBFE.SBFEDelinquent61LineRatio := (STRING)capNum(RIGHT.SBFEDelinquent61LineRatio_, 10),
				SELF.SBFE.SBFEDelinquent61CardRatio := (STRING)capNum(RIGHT.SBFEDelinquent61CardRatio_, 10),
				SELF.SBFE.SBFEDelinquent61LeaseRatio := (STRING)capNum(RIGHT.SBFEDelinquent61LeaseRatio_, 10),
				SELF.SBFE.SBFEDelinquent61LetterRatio := (STRING)capNum(RIGHT.SBFEDelinquent61LetterRatio_, 10),
				SELF.SBFE.SBFEDelinquent61OLineRatio := (STRING)capNum(RIGHT.SBFEDelinquent61OLineRatio_, 10),
				SELF.SBFE.SBFEDelinquent61OtherRatio := (STRING)capNum(RIGHT.SBFEDelinquent61OtherRatio_, 10),
				SELF.SBFE.SBFEDelinquent91Ratio := (STRING)capNum(RIGHT.SBFEDelinquent91Ratio_, 10),
				SELF.SBFE.SBFEDelinquent91LoanRatio := (STRING)capNum(RIGHT.SBFEDelinquent91LoanRatio_, 10),
				SELF.SBFE.SBFEDelinquent91LineRatio := (STRING)capNum(RIGHT.SBFEDelinquent91LineRatio_, 10),
				SELF.SBFE.SBFEDelinquent91CardRatio := (STRING)capNum(RIGHT.SBFEDelinquent91CardRatio_, 10),
				SELF.SBFE.SBFEDelinquent91LeaseRatio := (STRING)capNum(RIGHT.SBFEDelinquent91LeaseRatio_, 10),
				SELF.SBFE.SBFEDelinquent91LetterRatio := (STRING)capNum(RIGHT.SBFEDelinquent91LetterRatio_, 10),
				SELF.SBFE.SBFEDelinquent91OLineRatio := (STRING)capNum(RIGHT.SBFEDelinquent91OLineRatio_, 10),
				SELF.SBFE.SBFEDelinquent91OtherRatio := (STRING)capNum(RIGHT.SBFEDelinquent91OtherRatio_, 10),
				SELF.SBFE.SBFEDelinquent121Ratio := (STRING)capNum(RIGHT.SBFEDelinquent121Ratio_, 10),
				SELF.SBFE.SBFEDelinquent121LoanRatio := (STRING)capNum(RIGHT.SBFEDelinquent121LoanRatio_, 10),
				SELF.SBFE.SBFEDelinquent121LineRatio := (STRING)capNum(RIGHT.SBFEDelinquent121LineRatio_, 10),
				SELF.SBFE.SBFEDelinquent121CardRatio := (STRING)capNum(RIGHT.SBFEDelinquent121CardRatio_, 10),
				SELF.SBFE.SBFEDelinquent121LeaseRatio := (STRING)capNum(RIGHT.SBFEDelinquent121LeaseRatio_, 10),
				SELF.SBFE.SBFEDelinquent121LetterRatio := (STRING)capNum(RIGHT.SBFEDelinquent121LetterRatio_, 10),
				SELF.SBFE.SBFEDelinquent121OLineRatio := (STRING)capNum(RIGHT.SBFEDelinquent121OLineRatio_, 10),
				SELF.SBFE.SBFEDelinquent121OtherRatio := (STRING)capNum(RIGHT.SBFEDelinquent121OtherRatio_, 10),
				SELF.SBFE.SBFEDelq1OccurCount03M := (STRING)capNum(RIGHT.SBFEDelq1OccurCount03M_, 99);
				SELF.SBFE.SBFEDPD1OccurCount06 := (STRING)capNum(RIGHT.Sbfedpd1occurcount06_, 99),
				SELF.SBFE.SBFEDPD1OccurCount12 := (STRING)capNum(RIGHT.Sbfedpd1occurcount12_, 99),
				SELF.SBFE.SBFEDPD1OccurCount24 := (STRING)capNum(RIGHT.Sbfedpd1occurcount24_, 99),
				SELF.SBFE.SBFEDPD1OccurCount36 := (STRING)capNum(RIGHT.Sbfedpd1occurcount36_, 99),
				SELF.SBFE.SBFEDPD1OccurCount60 := (STRING)capNum(RIGHT.Sbfedpd1occurcount60_, 99),
				SELF.SBFE.SBFEDPD1OccurCount84 := (STRING)capNum(RIGHT.Sbfedpd1occurcount84_, 99),
				SELF.SBFE.SBFEDPD1OccurCountEver := (STRING)capNum(RIGHT.Sbfedpd1occurcountever_, 99),
				SELF.SBFE.SBFEDelq31OccurCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCount06 := (STRING)capNum(RIGHT.Sbfedpd31occurcount06_, 99),
				SELF.SBFE.SBFEDPD31OccurCount12 := (STRING)capNum(RIGHT.Sbfedpd31occurcount12_, 99),
				SELF.SBFE.SBFEDPD31OccurCount24 := (STRING)capNum(RIGHT.Sbfedpd31occurcount24_, 99),
				SELF.SBFE.SBFEDPD31OccurCount36 := (STRING)capNum(RIGHT.Sbfedpd31occurcount36_, 99),
				SELF.SBFE.SBFEDPD31OccurCount60 := (STRING)capNum(RIGHT.Sbfedpd31occurcount60_, 99),
				SELF.SBFE.SBFEDPD31OccurCount84 := (STRING)capNum(RIGHT.Sbfedpd31occurcount84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountEver := (STRING)capNum(RIGHT.Sbfedpd31occurcountever_, 99),
				SELF.SBFE.SBFEDelq31OccurLoanCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurLoanCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountLoan06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoan06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLoan12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoan12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLoan24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoan24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLoan36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoan36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLoan60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoan60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLoan84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoan84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLoanEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLoanEver_, 99),
				SELF.SBFE.SBFEDelq31OccurLineCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurLineCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountLine06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLine06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLine12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLine12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLine24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLine24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLine36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLine36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLine60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLine60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLine84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLine84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLineEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLineEver_, 99),
				SELF.SBFE.SBFEDelq31OccurCardCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurCardCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountCard06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCard06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountCard12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCard12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountCard24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCard24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountCard36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCard36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountCard60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCard60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountCard84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCard84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountCardEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountCardEver_, 99),
				SELF.SBFE.SBFEDelq31OccurLeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurLeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountLease06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLease06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLease12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLease12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLease24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLease24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLease36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLease36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLease60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLease60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLease84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLease84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLeaseEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLeaseEver_, 99),
				SELF.SBFE.SBFEDelq31OccurLetterCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurLetterCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountLetter06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetter06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLetter12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetter12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLetter24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetter24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLetter36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetter36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLetter60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetter60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLetter84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetter84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountLetterEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountLetterEver_, 99),
				SELF.SBFE.SBFEDelq31OccurOELineCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurOELineCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountOLine06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLine06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOLine12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLine12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOLine24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLine24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOLine36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLine36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOLine60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLine60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOLine84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLine84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOLineEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOLineEver_, 99),
				SELF.SBFE.SBFEDelq31OccurOtherCount03M := (STRING)capNum(RIGHT.SBFEDelq31OccurOtherCount03M_, 99);
				SELF.SBFE.SBFEDPD31OccurCountOther06 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOther06_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOther12 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOther12_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOther24 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOther24_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOther36 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOther36_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOther60 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOther60_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOther84 := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOther84_, 99),
				SELF.SBFE.SBFEDPD31OccurCountOtherEver := (STRING)capNum(RIGHT.SBFEDPD31OccurCountOtherEver_, 99),
				SELF.SBFE.SBFEDelq61OccurCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCount06 := (STRING)capNum(RIGHT.Sbfedpd61occurcount06_, 99),
				SELF.SBFE.SBFEDPD61OccurCount12 := (STRING)capNum(RIGHT.Sbfedpd61occurcount12_, 99),
				SELF.SBFE.SBFEDPD61OccurCount24 := (STRING)capNum(RIGHT.Sbfedpd61occurcount24_, 99),
				SELF.SBFE.SBFEDPD61OccurCount36 := (STRING)capNum(RIGHT.Sbfedpd61occurcount36_, 99),
				SELF.SBFE.SBFEDPD61OccurCount60 := (STRING)capNum(RIGHT.Sbfedpd61occurcount60_, 99),
				SELF.SBFE.SBFEDPD61OccurCount84 := (STRING)capNum(RIGHT.Sbfedpd61occurcount84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountever_, 99),
				SELF.SBFE.SBFEDelq61OccurLoanCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurLoanCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountLoan06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountloan06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLoan12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountloan12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLoan24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountloan24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLoan36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountloan36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLoan60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountloan60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLoan84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountloan84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLoanEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountloanever_, 99),
				SELF.SBFE.SBFEDelq61OccurLineCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurLineCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountLine06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountline06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLine12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountline12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLine24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountline24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLine36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountline36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLine60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountline60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLine84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountline84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLineEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountlineever_, 99),
				SELF.SBFE.SBFEDelq61OccurCardCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurCardCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountCard06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountcard06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountCard12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountcard12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountCard24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountcard24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountCard36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountcard36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountCard60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountcard60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountCard84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountcard84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountCardEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountcardever_, 99),
				SELF.SBFE.SBFEDelq61OccurLeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurLeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountLease06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountlease06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLease12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountlease12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLease24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountlease24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLease36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountlease36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLease60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountlease60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLease84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountlease84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLeaseEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountleaseever_, 99),
				SELF.SBFE.SBFEDelq61OccurLetterCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurLetterCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountLetter06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountletter06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLetter12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountletter12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLetter24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountletter24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLetter36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountletter36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLetter60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountletter60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLetter84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountletter84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountLetterEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountletterever_, 99),
				SELF.SBFE.SBFEDelq61OccurOELineCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurOELineCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountOLine06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountoline06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOLine12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountoline12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOLine24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountoline24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOLine36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountoline36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOLine60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountoline60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOLine84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountoline84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOLineEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountolineever_, 99),
				SELF.SBFE.SBFEDelq61OccurOtherCount03M := (STRING)capNum(RIGHT.SBFEDelq61OccurOtherCount03M_, 99);
				SELF.SBFE.SBFEDPD61OccurCountOther06 := (STRING)capNum(RIGHT.Sbfedpd61occurcountother06_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOther12 := (STRING)capNum(RIGHT.Sbfedpd61occurcountother12_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOther24 := (STRING)capNum(RIGHT.Sbfedpd61occurcountother24_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOther36 := (STRING)capNum(RIGHT.Sbfedpd61occurcountother36_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOther60 := (STRING)capNum(RIGHT.Sbfedpd61occurcountother60_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOther84 := (STRING)capNum(RIGHT.Sbfedpd61occurcountother84_, 99),
				SELF.SBFE.SBFEDPD61OccurCountOtherEver := (STRING)capNum(RIGHT.Sbfedpd61occurcountotherever_, 99),
				SELF.SBFE.SBFEDelq91OccurCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCount06 := (STRING)capNum(RIGHT.Sbfedpd91occurcount06_, 99),
				SELF.SBFE.SBFEDPD91OccurCount12 := (STRING)capNum(RIGHT.Sbfedpd91occurcount12_, 99),
				SELF.SBFE.SBFEDPD91OccurCount24 := (STRING)capNum(RIGHT.Sbfedpd91occurcount24_, 99),
				SELF.SBFE.SBFEDPD91OccurCount36 := (STRING)capNum(RIGHT.Sbfedpd91occurcount36_, 99),
				SELF.SBFE.SBFEDPD91OccurCount60 := (STRING)capNum(RIGHT.Sbfedpd91occurcount60_, 99),
				SELF.SBFE.SBFEDPD91OccurCount84 := (STRING)capNum(RIGHT.Sbfedpd91occurcount84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountever_, 99),
				SELF.SBFE.SBFEDelq91OccurLoanCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurLoanCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountLoan06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountloan06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLoan12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountloan12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLoan24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountloan24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLoan36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountloan36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLoan60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountloan60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLoan84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountloan84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLoanEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountloanever_, 99),
				SELF.SBFE.SBFEDelq91OccurLineCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurLineCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountLine06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountline06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLine12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountline12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLine24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountline24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLine36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountline36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLine60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountline60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLine84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountline84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLineEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountlineever_, 99),
				SELF.SBFE.SBFEDelq91OccurCardCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurCardCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountCard06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountcard06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountCard12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountcard12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountCard24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountcard24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountCard36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountcard36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountCard60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountcard60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountCard84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountcard84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountCardEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountcardever_, 99),
				SELF.SBFE.SBFEDelq91OccurLeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurLeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountLease06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountlease06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLease12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountlease12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLease24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountlease24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLease36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountlease36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLease60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountlease60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLease84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountlease84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLeaseEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountleaseever_, 99),
				SELF.SBFE.SBFEDelq91OccurLetterCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurLetterCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountLetter06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountletter06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLetter12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountletter12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLetter24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountletter24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLetter36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountletter36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLetter60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountletter60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLetter84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountletter84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountLetterEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountletterever_, 99),
				SELF.SBFE.SBFEDelq91OccurOELineCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurOELineCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountOLine06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountoline06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOLine12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountoline12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOLine24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountoline24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOLine36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountoline36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOLine60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountoline60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOLine84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountoline84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOLineEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountolineever_, 99),
				SELF.SBFE.SBFEDelq91OccurOtherCount03M := (STRING)capNum(RIGHT.SBFEDelq91OccurOtherCount03M_, 99);
				SELF.SBFE.SBFEDPD91OccurCountOther06 := (STRING)capNum(RIGHT.Sbfedpd91occurcountother06_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOther12 := (STRING)capNum(RIGHT.Sbfedpd91occurcountother12_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOther24 := (STRING)capNum(RIGHT.Sbfedpd91occurcountother24_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOther36 := (STRING)capNum(RIGHT.Sbfedpd91occurcountother36_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOther60 := (STRING)capNum(RIGHT.Sbfedpd91occurcountother60_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOther84 := (STRING)capNum(RIGHT.Sbfedpd91occurcountother84_, 99),
				SELF.SBFE.SBFEDPD91OccurCountOtherEver := (STRING)capNum(RIGHT.Sbfedpd91occurcountotherever_, 99),
				SELF.SBFE.SBFEDelq121OccurCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCount06 := (STRING)capNum(RIGHT.Sbfedpd121occurcount06_, 99),
				SELF.SBFE.SBFEDPD121OccurCount12 := (STRING)capNum(RIGHT.Sbfedpd121occurcount12_, 99),
				SELF.SBFE.SBFEDPD121OccurCount24 := (STRING)capNum(RIGHT.Sbfedpd121occurcount24_, 99),
				SELF.SBFE.SBFEDPD121OccurCount36 := (STRING)capNum(RIGHT.Sbfedpd121occurcount36_, 99),
				SELF.SBFE.SBFEDPD121OccurCount60 := (STRING)capNum(RIGHT.Sbfedpd121occurcount60_, 99),
				SELF.SBFE.SBFEDPD121OccurCount84 := (STRING)capNum(RIGHT.Sbfedpd121occurcount84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountEver := (STRING)capNum(RIGHT.Sbfedpd121occurcountever_, 99),
				SELF.SBFE.SBFEDelq121OccurLoanCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurLoanCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountLoan06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoan06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLoan12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoan12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLoan24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoan24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLoan36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoan36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLoan60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoan60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLoan84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoan84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLoanEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLoanEver_, 99),
				SELF.SBFE.SBFEDelq121OccurLineCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurLineCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountLine06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLine06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLine12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLine12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLine24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLine24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLine36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLine36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLine60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLine60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLine84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLine84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLineEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLineEver_, 99),
				SELF.SBFE.SBFEDelq121OccurCardCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurCardCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountCard06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCard06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountCard12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCard12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountCard24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCard24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountCard36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCard36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountCard60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCard60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountCard84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCard84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountCardEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountCardEver_, 99),
				SELF.SBFE.SBFEDelq121OccurLeaseCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurLeaseCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountLease06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLease06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLease12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLease12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLease24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLease24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLease36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLease36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLease60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLease60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLease84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLease84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLeaseEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLeaseEver_, 99),
				SELF.SBFE.SBFEDelq121OccurLetterCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurLetterCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountLetter06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetter06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLetter12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetter12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLetter24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetter24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLetter36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetter36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLetter60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetter60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLetter84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetter84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountLetterEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountLetterEver_, 99),
				SELF.SBFE.SBFEDelq121OccurOELineCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurOELineCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountOLine06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLine06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOLine12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLine12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOLine24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLine24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOLine36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLine36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOLine60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLine60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOLine84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLine84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOLineEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOLineEver_, 99),
				SELF.SBFE.SBFEDelq121OccurOtherCount03M := (STRING)capNum(RIGHT.SBFEDelq121OccurOtherCount03M_, 99);
				SELF.SBFE.SBFEDPD121OccurCountOther06 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOther06_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOther12 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOther12_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOther24 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOther24_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOther36 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOther36_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOther60 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOther60_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOther84 := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOther84_, 99),
				SELF.SBFE.SBFEDPD121OccurCountOtherEver := (STRING)capNum(RIGHT.SBFEDPD121OccurCountOtherEver_, 99),
				SELF.SBFE.SBFEDPDAmount := (STRING)capNum(RIGHT.Sbfedpdamount_, 99999999),
				SELF.SBFE.SBFEDPD01Amount := (STRING)capNum(RIGHT.Sbfedpd01amount_, 99999999),
				SELF.SBFE.SBFEDelq01AmtTtl := (STRING)capNum(RIGHT.SBFEDelq01AmtTtl_, 99999999),
				SELF.SBFE.SBFEDelq01Amt03M := (STRING)capNum(RIGHT.SBFEDelq01Amt03M_, 99999999),
				SELF.SBFE.SBFEDelq01Amt06M := (STRING)capNum(RIGHT.SBFEDelq01Amt06M_, 99999999),
				SELF.SBFE.SBFEDelq01Amt12M := (STRING)capNum(RIGHT.SBFEDelq01Amt12M_, 99999999),
				SELF.SBFE.SBFEDelq01Amt24M := (STRING)capNum(RIGHT.SBFEDelq01Amt24M_, 99999999),
				SELF.SBFE.SBFEDelq01Amt36M := (STRING)capNum(RIGHT.SBFEDelq01Amt36M_, 99999999),
				SELF.SBFE.SBFEDelq01Amt60M := (STRING)capNum(RIGHT.SBFEDelq01Amt60M_, 99999999),
				SELF.SBFE.SBFEDelq01Amt84M := (STRING)capNum(RIGHT.SBFEDelq01Amt84M_, 99999999),
				SELF.SBFE.SBFEDPD31Amount := (STRING)capNum(RIGHT.Sbfedpd31amount_, 99999999),
				SELF.SBFE.SBFEDelq31AmtTtl := (STRING)capNum(RIGHT.SBFEDelq31AmtTtl_, 99999999),
				SELF.SBFE.SBFEDelq31Amt03M := (STRING)capNum(RIGHT.SBFEDelq31Amt03M_, 99999999),
				SELF.SBFE.SBFEDelq31Amt06M := (STRING)capNum(RIGHT.SBFEDelq31Amt06M_, 99999999),
				SELF.SBFE.SBFEDelq31Amt12M := (STRING)capNum(RIGHT.SBFEDelq31Amt12M_, 99999999),
				SELF.SBFE.SBFEDelq31Amt24M := (STRING)capNum(RIGHT.SBFEDelq31Amt24M_, 99999999),
				SELF.SBFE.SBFEDelq31Amt36M := (STRING)capNum(RIGHT.SBFEDelq31Amt36M_, 99999999),
				SELF.SBFE.SBFEDelq31Amt60M := (STRING)capNum(RIGHT.SBFEDelq31Amt60M_, 99999999),
				SELF.SBFE.SBFEDelq31Amt84M := (STRING)capNum(RIGHT.SBFEDelq31Amt84M_, 99999999),
				SELF.SBFE.SBFEDPD61Amount := (STRING)capNum(RIGHT.Sbfedpd61amount_, 99999999),
				SELF.SBFE.SBFEDelq61AmtTtl := (STRING)capNum(RIGHT.SBFEDelq61AmtTtl_, 99999999),
				SELF.SBFE.SBFEDelq61Amt03M := (STRING)capNum(RIGHT.SBFEDelq61Amt03M_, 99999999),
				SELF.SBFE.SBFEDelq61Amt06M := (STRING)capNum(RIGHT.SBFEDelq61Amt06M_, 99999999),
				SELF.SBFE.SBFEDelq61Amt12M := (STRING)capNum(RIGHT.SBFEDelq61Amt12M_, 99999999),
				SELF.SBFE.SBFEDelq61Amt24M := (STRING)capNum(RIGHT.SBFEDelq61Amt24M_, 99999999),
				SELF.SBFE.SBFEDelq61Amt36M := (STRING)capNum(RIGHT.SBFEDelq61Amt36M_, 99999999),
				SELF.SBFE.SBFEDelq61Amt60M := (STRING)capNum(RIGHT.SBFEDelq61Amt60M_, 99999999),
				SELF.SBFE.SBFEDelq61Amt84M := (STRING)capNum(RIGHT.SBFEDelq61Amt84M_, 99999999),
				SELF.SBFE.SBFEDPD91Amount := (STRING)capNum(RIGHT.Sbfedpd91amount_, 99999999),
				SELF.SBFE.SBFEDelq91AmtTtl := (STRING)capNum(RIGHT.SBFEDelq91AmtTtl_, 99999999),
				SELF.SBFE.SBFEDelq91Amt03M := (STRING)capNum(RIGHT.SBFEDelq91Amt03M_, 99999999),
				SELF.SBFE.SBFEDelq91Amt06M := (STRING)capNum(RIGHT.SBFEDelq91Amt06M_, 99999999),
				SELF.SBFE.SBFEDelq91Amt12M := (STRING)capNum(RIGHT.SBFEDelq91Amt12M_, 99999999),
				SELF.SBFE.SBFEDelq91Amt24M := (STRING)capNum(RIGHT.SBFEDelq91Amt24M_, 99999999),
				SELF.SBFE.SBFEDelq91Amt36M := (STRING)capNum(RIGHT.SBFEDelq91Amt36M_, 99999999),
				SELF.SBFE.SBFEDelq91Amt60M := (STRING)capNum(RIGHT.SBFEDelq91Amt60M_, 99999999),
				SELF.SBFE.SBFEDelq91Amt84M := (STRING)capNum(RIGHT.SBFEDelq91Amt84M_, 99999999),
				SELF.SBFE.SBFEDPD121Amount := (STRING)capNum(RIGHT.Sbfedpd121amount_, 99999999),
				SELF.SBFE.SBFEDelq121Amt03M := (STRING)capNum(RIGHT.SBFEDelq121Amt03M_, 99999999),
				SELF.SBFE.SBFEDelq121Amt06M := (STRING)capNum(RIGHT.SBFEDelq121Amt06M_, 99999999),
				SELF.SBFE.SBFEDelq121Amt12M := (STRING)capNum(RIGHT.SBFEDelq121Amt12M_, 99999999),
				SELF.SBFE.SBFEDelq121Amt24M := (STRING)capNum(RIGHT.SBFEDelq121Amt24M_, 99999999),
				SELF.SBFE.SBFEDelq121Amt36M := (STRING)capNum(RIGHT.SBFEDelq121Amt36M_, 99999999),
				SELF.SBFE.SBFEDelq121Amt60M := (STRING)capNum(RIGHT.SBFEDelq121Amt60M_, 99999999),
				SELF.SBFE.SBFEDelq121Amt84M := (STRING)capNum(RIGHT.SBFEDelq121Amt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountLoan := (STRING)capNum(RIGHT.Sbfedpdamountloan_, 99999999),
				SELF.SBFE.SBFEDPD01AmountLoan := (STRING)capNum(RIGHT.SBFEDPD01AmountLoan_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt03M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt06M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt12M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt24M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt36M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt60M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01LoanAmt84M := (STRING)capNum(RIGHT.SBFEDelq01LoanAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountLoan := (STRING)capNum(RIGHT.SBFEDPD31AmountLoan_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt03M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt06M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt12M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt24M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt36M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt60M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31LoanAmt84M := (STRING)capNum(RIGHT.SBFEDelq31LoanAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountLoan := (STRING)capNum(RIGHT.SBFEDPD61AmountLoan_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt03M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt06M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt12M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt24M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt36M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt60M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61LoanAmt84M := (STRING)capNum(RIGHT.SBFEDelq61LoanAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountLoan := (STRING)capNum(RIGHT.SBFEDPD91AmountLoan_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt03M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt06M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt12M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt24M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt36M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt60M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91LoanAmt84M := (STRING)capNum(RIGHT.SBFEDelq91LoanAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountLoan := (STRING)capNum(RIGHT.SBFEDPD121AmountLoan_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt03M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt06M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt12M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt24M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt36M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt60M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121LoanAmt84M := (STRING)capNum(RIGHT.SBFEDelq121LoanAmt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountLine := (STRING)capNum(RIGHT.Sbfedpdamountline_, 99999999),
				SELF.SBFE.SBFEDPD01AmountLine := (STRING)capNum(RIGHT.SBFEDPD01AmountLine_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt03M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt06M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt12M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt24M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt36M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt60M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01LineAmt84M := (STRING)capNum(RIGHT.SBFEDelq01LineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountLine := (STRING)capNum(RIGHT.SBFEDPD31AmountLine_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt03M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt06M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt12M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt24M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt36M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt60M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31LineAmt84M := (STRING)capNum(RIGHT.SBFEDelq31LineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountLine := (STRING)capNum(RIGHT.SBFEDPD61AmountLine_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt03M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt06M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt12M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt24M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt36M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt60M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61LineAmt84M := (STRING)capNum(RIGHT.SBFEDelq61LineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountLine := (STRING)capNum(RIGHT.SBFEDPD91AmountLine_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt03M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt06M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt12M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt24M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt36M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt60M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91LineAmt84M := (STRING)capNum(RIGHT.SBFEDelq91LineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountLine := (STRING)capNum(RIGHT.SBFEDPD121AmountLine_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt03M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt06M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt12M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt24M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt36M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt60M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121LineAmt84M := (STRING)capNum(RIGHT.SBFEDelq121LineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountCard := (STRING)capNum(RIGHT.Sbfedpdamountcard_, 99999999),
				SELF.SBFE.SBFEDPD01AmountCard := (STRING)capNum(RIGHT.SBFEDPD01AmountCard_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt03M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt06M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt12M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt24M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt36M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt60M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01CardAmt84M := (STRING)capNum(RIGHT.SBFEDelq01CardAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountCard := (STRING)capNum(RIGHT.SBFEDPD31AmountCard_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt03M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt06M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt12M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt24M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt36M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt60M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31CardAmt84M := (STRING)capNum(RIGHT.SBFEDelq31CardAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountCard := (STRING)capNum(RIGHT.SBFEDPD61AmountCard_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt03M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt06M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt12M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt24M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt36M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt60M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61CardAmt84M := (STRING)capNum(RIGHT.SBFEDelq61CardAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountCard := (STRING)capNum(RIGHT.SBFEDPD91AmountCard_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt03M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt06M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt12M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt24M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt36M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt60M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91CardAmt84M := (STRING)capNum(RIGHT.SBFEDelq91CardAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountCard := (STRING)capNum(RIGHT.SBFEDPD121AmountCard_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt03M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt06M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt12M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt24M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt36M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt60M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121CardAmt84M := (STRING)capNum(RIGHT.SBFEDelq121CardAmt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountLease := (STRING)capNum(RIGHT.Sbfedpdamountlease_, 99999999),
				SELF.SBFE.SBFEDPD01AmountLease := (STRING)capNum(RIGHT.SBFEDPD01AmountLease_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt03M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt06M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt12M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt24M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt36M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt60M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01LeaseAmt84M := (STRING)capNum(RIGHT.SBFEDelq01LeaseAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountLease := (STRING)capNum(RIGHT.SBFEDPD31AmountLease_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt03M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt06M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt12M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt24M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt36M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt60M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31LeaseAmt84M := (STRING)capNum(RIGHT.SBFEDelq31LeaseAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountLease := (STRING)capNum(RIGHT.SBFEDPD61AmountLease_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt03M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt06M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt12M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt24M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt36M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt60M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61LeaseAmt84M := (STRING)capNum(RIGHT.SBFEDelq61LeaseAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountLease := (STRING)capNum(RIGHT.SBFEDPD91AmountLease_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt03M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt06M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt12M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt24M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt36M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt60M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91LeaseAmt84M := (STRING)capNum(RIGHT.SBFEDelq91LeaseAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountLease := (STRING)capNum(RIGHT.SBFEDPD121AmountLease_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt03M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt06M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt12M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt24M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt36M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt60M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121LeaseAmt84M := (STRING)capNum(RIGHT.SBFEDelq121LeaseAmt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountLetter := (STRING)capNum(RIGHT.Sbfedpdamountletter_, 99999999),
				SELF.SBFE.SBFEDPD01AmountLetter := (STRING)capNum(RIGHT.SBFEDPD01AmountLetter_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt03M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt06M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt12M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt24M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt36M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt60M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01LetterAmt84M := (STRING)capNum(RIGHT.SBFEDelq01LetterAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountLetter := (STRING)capNum(RIGHT.SBFEDPD31AmountLetter_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt03M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt06M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt12M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt24M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt36M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt60M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31LetterAmt84M := (STRING)capNum(RIGHT.SBFEDelq31LetterAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountLetter := (STRING)capNum(RIGHT.SBFEDPD61AmountLetter_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt03M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt06M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt12M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt24M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt36M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt60M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61LetterAmt84M := (STRING)capNum(RIGHT.SBFEDelq61LetterAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountLetter := (STRING)capNum(RIGHT.SBFEDPD91AmountLetter_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt03M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt06M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt12M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt24M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt36M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt60M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91LetterAmt84M := (STRING)capNum(RIGHT.SBFEDelq91LetterAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountLetter := (STRING)capNum(RIGHT.SBFEDPD121AmountLetter_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt03M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt06M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt12M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt24M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt36M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt60M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121LetterAmt84M := (STRING)capNum(RIGHT.SBFEDelq121LetterAmt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountOLine := (STRING)capNum(RIGHT.Sbfedpdamountoline_, 99999999),
				SELF.SBFE.SBFEDPD01AmountOLine := (STRING)capNum(RIGHT.SBFEDPD01AmountOLine_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt03M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt06M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt12M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt24M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt36M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt60M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01OELineAmt84M := (STRING)capNum(RIGHT.SBFEDelq01OELineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountOLine := (STRING)capNum(RIGHT.SBFEDPD31AmountOLine_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt03M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt06M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt12M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt24M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt36M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt60M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31OELineAmt84M := (STRING)capNum(RIGHT.SBFEDelq31OELineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountOLine := (STRING)capNum(RIGHT.SBFEDPD61AmountOLine_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt03M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt06M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt12M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt24M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt36M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt60M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61OELineAmt84M := (STRING)capNum(RIGHT.SBFEDelq61OELineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountOLine := (STRING)capNum(RIGHT.SBFEDPD91AmountOLine_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt03M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt06M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt12M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt24M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt36M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt60M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91OELineAmt84M := (STRING)capNum(RIGHT.SBFEDelq91OELineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountOLine := (STRING)capNum(RIGHT.SBFEDPD121AmountOLine_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt03M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt06M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt12M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt24M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt36M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt60M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121OELineAmt84M := (STRING)capNum(RIGHT.SBFEDelq121OELineAmt84M_, 99999999),
				SELF.SBFE.SBFEDPDAmountOther := (STRING)capNum(RIGHT.Sbfedpdamountother_, 99999999),
				SELF.SBFE.SBFEDPD01AmountOther := (STRING)capNum(RIGHT.SBFEDPD01AmountOther_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt03M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt06M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt12M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt24M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt36M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt60M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq01OtherAmt84M := (STRING)capNum(RIGHT.SBFEDelq01OtherAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD31AmountOther := (STRING)capNum(RIGHT.SBFEDPD31AmountOther_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt03M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt06M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt12M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt24M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt36M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt60M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq31OtherAmt84M := (STRING)capNum(RIGHT.SBFEDelq31OtherAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD61AmountOther := (STRING)capNum(RIGHT.SBFEDPD61AmountOther_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt03M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt06M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt12M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt24M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt36M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt60M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq61OtherAmt84M := (STRING)capNum(RIGHT.SBFEDelq61OtherAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD91AmountOther := (STRING)capNum(RIGHT.SBFEDPD91AmountOther_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt03M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt06M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt12M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt24M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt36M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt60M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq91OtherAmt84M := (STRING)capNum(RIGHT.SBFEDelq91OtherAmt84M_, 99999999),
				SELF.SBFE.SBFEDPD121AmountOther := (STRING)capNum(RIGHT.SBFEDPD121AmountOther_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt03M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt03M_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt06M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt06M_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt12M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt12M_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt24M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt24M_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt36M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt36M_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt60M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt60M_, 99999999),
				SELF.SBFE.SBFEDelq121OtherAmt84M := (STRING)capNum(RIGHT.SBFEDelq121OtherAmt84M_, 99999999),
				SELF.SBFE.SBFEDelq1AmtPct := (STRING)capNum(RIGHT.SBFEDelq1AmtPct_, 100),
				SELF.SBFE.SBFEDelq1AmtPct03M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct03M_, 100),
				SELF.SBFE.SBFEDelq1AmtPct06M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct06M_, 100),
				SELF.SBFE.SBFEDelq1AmtPct12M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct12M_, 100),
				SELF.SBFE.SBFEDelq1AmtPct24M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct24M_, 100),
				SELF.SBFE.SBFEDelq1AmtPct36M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct36M_, 100),
				SELF.SBFE.SBFEDelq1AmtPct60M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct60M_, 100),
				SELF.SBFE.SBFEDelq1AmtPct84M := (STRING)capNum(RIGHT.SBFEDelq1AmtPct84M_, 100),
				SELF.SBFE.SBFEDelq1RevAmtPct := (STRING)capNum(RIGHT.SBFEDelq1RevAmtPct_, 100),
				SELF.SBFE.SBFEDelq1InstAmtPct := (STRING)capNum(RIGHT.SBFEDelq1InstAmtPct_, 100),
				SELF.SBFE.SBFEDelq31AmtPct := (STRING)capNum(RIGHT.SBFEDelq31AmtPct_, 100),
				SELF.SBFE.SBFEDelq31AmtPct03M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct03M_, 100),
				SELF.SBFE.SBFEDelq31AmtPct06M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct06M_, 100),
				SELF.SBFE.SBFEDelq31AmtPct12M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct12M_, 100),
				SELF.SBFE.SBFEDelq31AmtPct24M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct24M_, 100),
				SELF.SBFE.SBFEDelq31AmtPct36M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct36M_, 100),
				SELF.SBFE.SBFEDelq31AmtPct60M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct60M_, 100),
				SELF.SBFE.SBFEDelq31AmtPct84M := (STRING)capNum(RIGHT.SBFEDelq31AmtPct84M_, 100),
				SELF.SBFE.SBFEDelq31RevAmtPct := (STRING)capNum(RIGHT.SBFEDelq31RevAmtPct_, 100),
				SELF.SBFE.SBFEDelq31InstAmtPct := (STRING)capNum(RIGHT.SBFEDelq31InstAmtPct_, 100),
				SELF.SBFE.SBFEDelq61AmtPct := (STRING)capNum(RIGHT.SBFEDelq61AmtPct_, 100),
				SELF.SBFE.SBFEDelq61AmtPct03M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct03M_, 100),
				SELF.SBFE.SBFEDelq61AmtPct06M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct06M_, 100),
				SELF.SBFE.SBFEDelq61AmtPct12M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct12M_, 100),
				SELF.SBFE.SBFEDelq61AmtPct24M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct24M_, 100),
				SELF.SBFE.SBFEDelq61AmtPct36M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct36M_, 100),
				SELF.SBFE.SBFEDelq61AmtPct60M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct60M_, 100),
				SELF.SBFE.SBFEDelq61AmtPct84M := (STRING)capNum(RIGHT.SBFEDelq61AmtPct84M_, 100),
				SELF.SBFE.SBFEDelq61RevAmtPct := (STRING)capNum(RIGHT.SBFEDelq61RevAmtPct_, 100),
				SELF.SBFE.SBFEDelq61InstAmtPct := (STRING)capNum(RIGHT.SBFEDelq61InstAmtPct_, 100),
				SELF.SBFE.SBFEDelq91AmtPct := (STRING)capNum(RIGHT.SBFEDelq91AmtPct_, 100),
				SELF.SBFE.SBFEDelq91AmtPct03M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct03M_, 100),
				SELF.SBFE.SBFEDelq91AmtPct06M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct06M_, 100),
				SELF.SBFE.SBFEDelq91AmtPct12M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct12M_, 100),
				SELF.SBFE.SBFEDelq91AmtPct24M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct24M_, 100),
				SELF.SBFE.SBFEDelq91AmtPct36M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct36M_, 100),
				SELF.SBFE.SBFEDelq91AmtPct60M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct60M_, 100),
				SELF.SBFE.SBFEDelq91AmtPct84M := (STRING)capNum(RIGHT.SBFEDelq91AmtPct84M_, 100),
				SELF.SBFE.SBFEDelq91RevAmtPct := (STRING)capNum(RIGHT.SBFEDelq91RevAmtPct_, 100),
				SELF.SBFE.SBFEDelq91InstAmtPct := (STRING)capNum(RIGHT.SBFEDelq91InstAmtPct_, 100),
				SELF.SBFE.SBFEDelq121AmtPct := (STRING)capNum(RIGHT.SBFEDelq121AmtPct_, 100),
				SELF.SBFE.SBFEDelq121AmtPct03M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct03M_, 100),
				SELF.SBFE.SBFEDelq121AmtPct06M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct06M_, 100),
				SELF.SBFE.SBFEDelq121AmtPct12M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct12M_, 100),
				SELF.SBFE.SBFEDelq121AmtPct24M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct24M_, 100),
				SELF.SBFE.SBFEDelq121AmtPct36M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct36M_, 100),
				SELF.SBFE.SBFEDelq121AmtPct60M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct60M_, 100),
				SELF.SBFE.SBFEDelq121AmtPct84M := (STRING)capNum(RIGHT.SBFEDelq121AmtPct84M_, 100),
				SELF.SBFE.SBFEDelq121RevAmtPct := (STRING)capNum(RIGHT.SBFEDelq121RevAmtPct_, 100),
				SELF.SBFE.SBFEDelq121InstAmtPct := (STRING)capNum(RIGHT.SBFEDelq121InstAmtPct_, 100),
				SELF.SBFE.SBFEDelqAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDPDAveAmount06 := (STRING)capNum(RIGHT.Sbfedpdaveamount06_, 99999999),
				SELF.SBFE.SBFEDPDAveAmount12 := (STRING)capNum(RIGHT.Sbfedpdaveamount12_, 99999999),
				SELF.SBFE.SBFEDPDAveAmount24 := (STRING)capNum(RIGHT.Sbfedpdaveamount24_, 99999999),
				SELF.SBFE.SBFEDPDAveAmount36 := (STRING)capNum(RIGHT.Sbfedpdaveamount36_, 99999999),
				SELF.SBFE.SBFEDPDAveAmount60 := (STRING)capNum(RIGHT.Sbfedpdaveamount60_, 99999999),
				SELF.SBFE.SBFEDPDAveAmount84 := (STRING)capNum(RIGHT.Sbfedpdaveamount84_, 99999999),
				SELF.SBFE.SBFEDPDAveAmountEver := (STRING)capNum(RIGHT.Sbfedpdaveamountever_, 99999999),
				SELF.SBFE.SBFEDelqLoanAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqLoanAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqLoanAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqLineAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqLineAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqCardAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqCardAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqLeaseAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqLeaseAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqLetterAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqLetterAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqOELineAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqOELineAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt03M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt03M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt06M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt06M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt12M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt12M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt24M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt24M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt36M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt36M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt60M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt60M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmt84M := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmt84M_, 99999999);
				SELF.SBFE.SBFEDelqOtherAvgAmtEver := (STRING)capNum(RIGHT.SBFEDelqOtherAvgAmtEver_, 99999999);
				SELF.SBFE.SBFEChargeoffCount := (STRING)capNum(RIGHT.Sbfechargeoffcount_, 99),
				SELF.SBFE.SBFEChargeoffLoanCount := (STRING)capNum(RIGHT.SBFEChargeoffLoanCount_, 99),
				SELF.SBFE.SBFEChargeoffLineCount := (STRING)capNum(RIGHT.SBFEChargeoffLineCount_, 99),
				SELF.SBFE.SBFEChargeoffCardCount := (STRING)capNum(RIGHT.SBFEChargeoffCardCount_, 99),
				SELF.SBFE.SBFEChargeoffLeaseCount := (STRING)capNum(RIGHT.SBFEChargeoffLeaseCount_, 99),
				SELF.SBFE.SBFEChargeoffLetterCount := (STRING)capNum(RIGHT.SBFEChargeoffLetterCount_, 99),
				SELF.SBFE.SBFEChargeoffOLineCount := (STRING)capNum(RIGHT.SBFEChargeoffOLineCount_, 99),
				SELF.SBFE.SBFEChargeoffOtherCount := (STRING)capNum(RIGHT.SBFEChargeoffOtherCount_, 99),
				SELF.SBFE.SBFEChargeoffAmount := (STRING)capNum(RIGHT.Sbfechargeoffamount_, 99999999),
				SELF.SBFE.SBFEChargeoffLoanAmount := (STRING)capNum(RIGHT.SBFEChargeoffLoanAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffLineAmount := (STRING)capNum(RIGHT.SBFEChargeoffLineAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffCardAmount := (STRING)capNum(RIGHT.SBFEChargeoffCardAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffLeaseAmount := (STRING)capNum(RIGHT.SBFEChargeoffLeaseAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffLetterAmount := (STRING)capNum(RIGHT.SBFEChargeoffLetterAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffOLineAmount := (STRING)capNum(RIGHT.SBFEChargeoffOLineAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffOtherAmount := (STRING)capNum(RIGHT.SBFEChargeoffOtherAmount_, 99999999),
				SELF.SBFE.SBFEChargeoffDateLastSeen := (STRING)(RIGHT.Sbfechargeoffdatelastseen_),
				SELF.SBFE.SBFETimeNewestChargeoff := (STRING)capNum(RIGHT.SBFETimeNewestChargeoff_, 600);
				SELF.SBFE.SBFEBalloonCount := (STRING)capNum(RIGHT.Sbfeballooncount_, 99),
				SELF.SBFE.SBFEBalloonPaymentAmount := (STRING)capNum(RIGHT.Sbfeballoonpaymentamount_, 999999),
				SELF.SBFE.SBFEBalloonPaymentDueDate := (STRING)RIGHT.Sbfeballoonpaymentduedate_,
				SELF.SBFE.SBFEFirmBusStructure := (STRING)RIGHT.Sbfefirmbusstructure_,
				SELF.SBFE.SBFESICCode := (STRING)RIGHT.Sbfesiccode_,
				SELF.SBFE.SBFENAICSCode := (STRING)RIGHT.Sbfenaicscode_,
				SELF.SBFE.SBFEGovGuaranteeCount := (STRING)capNum(RIGHT.Sbfegovguaranteecount_, 99),
				SELF.SBFE.SBFEGuarantorAccountCount := (STRING)capNum(RIGHT.Sbfeguarantoraccountcount_, 99),
				SELF.SBFE.SBFEGuarantorMinCount := (STRING)capNum(RIGHT.Sbfeguarantormincount_, 99),
				SELF.SBFE.SBFEGuarantorMaxCount := (STRING)capNum(RIGHT.Sbfeguarantormaxcount_, 99),
				SELF.SBFE.SBFEPrincipalAccountCount := (STRING)capNum(RIGHT.Sbfeprincipalaccountcount_, 99),
				SELF.SBFE.SBFEPrincipalMinCount := (STRING)capNum(RIGHT.Sbfeprincipalmincount_, 99),
				SELF.SBFE.SBFEPrincipalMaxCount := (STRING)capNum(RIGHT.Sbfeprincipalmaxcount_, 99),
				SELF := LEFT,
			/*	SELF := []*/), ATMOST(100), KEEP(1));

SBFE_recs_added_Shell := JOIN(SBFEIDStatus, SBFE_recs_added, LEFT.Seq = RIGHT.Seq,
															TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																	SELF.Verification.InputIDMatchStatus := LEFT.Verification.InputIDMatchStatus,
																	SELF.Verification.InputIDMatchCategory := LEFT.Verification.InputIDMatchCategory,
																	SELF.SBFE := RIGHT.SBFE,
																	SELF := LEFT),
															LEFT OUTER, ATMOST(100), KEEP(1));

SBFE_Observed_Layout_temp := RECORD
	UNSIGNED4 seq;
	STRING3 SBFEINTERNALObservedPerf06;
	STRING3 SBFEINTERNALObservedPerf12;
	STRING3 SBFEINTERNALObservedPerf18;
	STRING3 SBFEINTERNALObservedPerf24;
	STRING3 SBFEINTERNALObservedPerf36;
END;

	SBFE_Future_Recs_Added_Temp := JOIN(Shell, SBFE_data_future,
			LEFT.seq = RIGHT.UID,
			TRANSFORM(SBFE_Observed_Layout_temp,
				SELF.seq := LEFT.seq,
				SELF.SBFEINTERNALObservedPerf06 := (STRING)RIGHT.Sbfeinternalobservedperf06_,
				SELF.SBFEINTERNALObservedPerf12 := (STRING)RIGHT.Sbfeinternalobservedperf12_,
				SELF.SBFEINTERNALObservedPerf18 := (STRING)RIGHT.Sbfeinternalobservedperf18_,
				SELF.SBFEINTERNALObservedPerf24 := (STRING)RIGHT.Sbfeinternalobservedperf24_,
				SELF.SBFEINTERNALObservedPerf36 := (STRING)RIGHT.Sbfeinternalobservedperf36_), ATMOST(100), KEEP(1));

	SBFE_Future_Recs_Added := JOIN(SBFE_recs_added_Shell, SBFE_Future_Recs_Added_Temp,
				LEFT.seq = RIGHT.seq,
				TRANSFORM(Business_Risk_BIP.Layouts.Shell,
				SELF.SBFE.SBFEINTERNALObservedPerf06 := RIGHT.SBFEINTERNALObservedPerf06,
				SELF.SBFE.SBFEINTERNALObservedPerf12 := RIGHT.SBFEINTERNALObservedPerf12,
				SELF.SBFE.SBFEINTERNALObservedPerf18 := RIGHT.SBFEINTERNALObservedPerf18,
				SELF.SBFE.SBFEINTERNALObservedPerf24 := RIGHT.SBFEINTERNALObservedPerf24,
				SELF.SBFE.SBFEINTERNALObservedPerf36 := RIGHT.SBFEINTERNALObservedPerf36,
				SELF := LEFT,
				SELF := []), LEFT OUTER, ATMOST(100), KEEP(1));


	withErrorCodes := JOIN(SBFE_Future_Recs_Added, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeSBFE := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(SBFERaw, NAMED('SBFERaw'));
	// OUTPUT(SBFE_data, NAMED('SBFE_data'));
	// OUTPUT(SBFE_raw_data_future, NAMED('SBFErawdatafuture'));
	// OUTPUT(SBFE_recs_added, NAMED('SBFE_recs_added'));
	// OUTPUT(SBFE_data_future, NAMED('SBFE_data_future'));
	// OUTPUT(SBFE_Future_Recs_Added, NAMED('SBFE_Future_Recs_Added'));
	// OUTPUT(withErrorCodes, NAMED('withErrorCodes'));
	// OUTPUT(SBFE_data_future, NAMED('KELFuture'));
	// OUTPUT(SBFEVerification, NAMED('SBFEVerification'));
	// OUTPUT(SBFEVerificationRolled, NAMED('SBFEVerificationRolled'));
	// OUTPUT(mod_SBFE.AddBusinessClassification, NAMED('AddBusinessClassification'));
	RETURN IF( restrict_sbfe, Shell_pre, withErrorCodes );


END;
