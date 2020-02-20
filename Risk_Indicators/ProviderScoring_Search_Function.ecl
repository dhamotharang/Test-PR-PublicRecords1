IMPORT STD, Address, Business_Header_SS, Risk_Indicators, RiskWise, ut, gateway;

// The default values should be set at the service level and passed into this function, don't assume any defaults here
EXPORT ProviderScoring_Search_Function (DATASET(Risk_Indicators.Layout_Provider_Scoring.Input) Batch_Input, 
																				UNSIGNED1 BSVersion,
																				UNSIGNED1 DPPAPurpose, 
																				UNSIGNED1 GLBPurpose, 
																				STRING50 DataRestrictionMask, 
																				UNSIGNED3 HistoryDate,
																				DATASET(Gateway.Layouts.Config) gateways,
																				string50 DataPermission=iid_constants.default_DataPermission,
                                                                                unsigned1 LexIdSourceOptout = 1,
                                                                                string TransactionID = '',
                                                                                string BatchUID = '',
                                                                                unsigned6 GlobalCompanyId = 0) := FUNCTION
	layout_IID_Prep_AcctNo := RECORD
		STRING30 AcctNo := '';
		Risk_Indicators.Layout_Input;
		STRING9 FEIN := '';
		STRING120 Company_Name := '';
		STRING100 Medical_License := '';
	END;
	
	layout_IID_Prep_AcctNo iidPrep(Batch_Input le) := TRANSFORM
		// Save input data for output
		SELF.AcctNo := le.AcctNo;
		
		// This is our internal sequence number, passed in by the top level service in Batch_Input
		SELF.seq := le.seq;
		
		// Use the history date on the record if populated, if not populated use the global history date
		histDate := if(le.HistoryDateYYYYMM = 0, HistoryDate, le.HistoryDateYYYYMM);
		SELF.historydate := histDate;
		SELF.ssn := le.ssn;
		SELF.dob := le.DateOfBirth;
		SELF.age := if ((integer)le.DateOfBirth != 0,	(STRING3)ut.Age((unsigned)le.DateOfBirth, (unsigned)risk_indicators.iid_constants.myGetDate(historydate)), '0');

		cleaned_name := address.CleanPerson73(le.Provider_Full_Name);
		BOOLEAN valid_cleaned := le.Provider_Full_Name <> '';
		
		SELF.fname  := STD.STR.ToUpperCase(if(le.Provider_First_Name='' AND valid_cleaned, cleaned_name[6..25], le.Provider_First_Name));
		SELF.lname  := STD.STR.ToUpperCase(if(le.Provider_Last_Name='' AND valid_cleaned, cleaned_name[46..65], le.Provider_Last_Name));
		SELF.mname  := STD.STR.ToUpperCase(if(le.Provider_Middle_Name='' AND valid_cleaned, cleaned_name[26..45], le.Provider_Middle_Name));
		SELF.suffix := STD.STR.ToUpperCase(if(valid_cleaned, cleaned_name[66..70], ''));	
		SELF.title  := STD.STR.ToUpperCase(if(valid_cleaned, cleaned_name[1..5],''));
		
		clean_a2 := risk_indicators.MOD_AddressClean.clean_addr(le.StreetAddress1 + ' ' + le.StreetAddress2, le.City, le.St, le.Zip);											

		SELF.in_streetAddress := le.StreetAddress1 + ' ' + le.StreetAddress2;
		SELF.in_city          := le.City;
		SELF.in_state         := le.St;
		SELF.in_zipCode       := le.Zip;
			
		SELF.prim_range    := clean_a2[1..10];
		SELF.predir        := clean_a2[11..12];
		SELF.prim_name     := clean_a2[13..40];
		SELF.addr_suffix   := clean_a2[41..44];
		SELF.postdir       := clean_a2[45..46];
		SELF.unit_desig    := clean_a2[47..56];
		SELF.sec_range     := clean_a2[57..65];
		SELF.p_city_name   := clean_a2[90..114];
		SELF.st            := clean_a2[115..116];
		SELF.z5            := clean_a2[117..121];
		SELF.zip4          := clean_a2[122..125];
		SELF.lat           := clean_a2[146..155];
		SELF.long          := clean_a2[156..166];
		SELF.addr_type     := clean_a2[139];
		SELF.addr_status   := clean_a2[179..182];
		SELF.county        := clean_a2[143..145];
		SELF.geo_blk       := clean_a2[171..177];
		
		SELF.FEIN := le.fein;
		SELF.company_name := le.Provider_Business_Name;
		SELF.Medical_License := le.Medical_License;

		SELF := [];
	END;
	prep_acct := PROJECT(Batch_Input, iidPrep(LEFT));

	iid_prep := PROJECT(prep_acct, TRANSFORM(Risk_Indicators.Layout_Input, SELF.employer_name := LEFT.company_name; SELF := LEFT));
	
	/* *********************************************
	 * Set IID, Boca Shell and BDID Append Options *
	 *********************************************** */
	isUtility           := FALSE;
	includeRel          := TRUE;
	includeDL           := TRUE;
	includeVeh          := TRUE;
	includeDerog        := TRUE;
	isFCRA              := FALSE;
	ln_branded          := FALSE;
	ofac_only           := TRUE;
	suppressNearDups    := FALSE;
	require2ele         := FALSE;
	from_biid           := FALSE;
	excludeWatchlists   := FALSE;
	from_IT1O           := FALSE;
	ofac_version        := 1;
	include_ofac        := FALSE;
	addtl_watchlists    := FALSE;
	watchlist_threshold := 0.84;
	dob_radius          := -1;
	doScore             := TRUE;
	nugen               := TRUE;
	AppendBest					:= 0;
	
	appends 						:= 'BEST_ALL';
	verify							:= 'BEST_ALL';
	thresh_num					:= 0;  
	bdids_to_keep				:= 5;
	
	/* *********************************************
	 *     Get IID, Boca Shell and BDID Append     *
	 *********************************************** */
	iid := Risk_Indicators.InstantID_Function(iid_prep, gateways, DPPAPurpose, GLBPurpose, isUtility, ln_branded, ofac_only, suppressNearDups, require2ele, isFCRA, from_biid, 
																						ExcludeWatchLists, from_IT1O, ofac_version, include_ofac, addtl_watchlists, watchlist_threshold, dob_radius, BSVersion, 
																						in_DataRestriction := DataRestrictionMask, in_append_best := AppendBest, in_DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, TransactionID := TransactionID, BatchUID := BatchUID, GlobalCompanyID := GlobalCompanyID);
	
	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPAPurpose, GLBPurpose, isUtility, ln_branded, includeRel, includeDL, includeVeh, includeDerog, BSVersion, 
																						doScore, nugen, DataRestriction := DataRestrictionMask, DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, TransactionID := TransactionID, BatchUID := BatchUID, GlobalCompanyID := GlobalCompanyID);

	bdidprep := PROJECT(prep_acct, TRANSFORM(Business_Header_SS.Layout_BDID_InBatch, SELF := LEFT));
	
	Business_Header_SS.MAC_BDID_Append(bdidprep, bdidappend1, thresh_num, bdids_to_keep);

	// Turn those bdids into a dataset, keeping only non-zero bdids:
	layout_bdids := RECORD
		UNSIGNED4 seq;
		DATASET({UNSIGNED6 bdid} ) bdids {MAXCOUNT(5)};
	END;
	
	layout_bdids aggregate_bdids( bdidappend1 le ) := TRANSFORM
		SELF.seq := le.seq;
		SELF.bdids := DATASET([{le.bdid}], {UNSIGNED6 bdid});
	END;
	
	bdid_ds := PROJECT(bdidappend1(bdid != 0), aggregate_bdids(LEFT));

	// Combine all bdids for a particular seq into a child dataset
	layout_bdids roll_bdids(layout_bdids le, layout_bdids ri) := TRANSFORM
		SELF.seq := le.seq;
		SELF.bdids := le.bdids + ri.bdids;
	END;
	
	bdids := ROLLUP(SORT(bdid_ds, seq), roll_bdids(LEFT,RIGHT), seq);

	/* *********************************************
	 *    Prepare BDIDs and Clam for Shell Input   *
	 *********************************************** */
	Risk_Indicators.Layout_Provider_Scoring.Clam_Plus make_hc_in(clam le, bdid_ds ri) := TRANSFORM
		SELF.bdids := ri.bdids;
		SELF := le;
	END;
	
	clam_plus := JOIN(clam, bdids, LEFT.seq = RIGHT.seq, make_hc_in(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	/* *********************************************
	 *          Get Healthcare Shell Data          *
	 *********************************************** */
	healthcare_shell := RiskWise.HealthCare_Shell(clam_plus);
		
	Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare combineShells(Risk_Indicators.Layout_Provider_Scoring.Clam_Plus le, Risk_Indicators.Layouts.Layout_Healthcare_Shell ri) := TRANSFORM
		SELF.input_seq := le.seq;
		SELF.BocaShell := le;
		SELF.HealthCareShell := ri;
		
		SELF := [];
	END;
	// Should be 1 Boca Shell result and 1 Healthcare Shell result per sequence number
	combinedShellsTemp := JOIN(clam_plus, healthcare_shell, LEFT.seq = RIGHT.seq, combineShells(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare combineInput(Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare le, layout_IID_Prep_AcctNo ri) := TRANSFORM
		SELF.input_seq := le.input_seq;
		SELF.AcctNo := ri.AcctNo;
			
		SELF := le;
		SELF := [];
	END;
	// Retreive the input account number
	combinedShells := JOIN(combinedShellsTemp, prep_acct, LEFT.BocaShell.seq = RIGHT.seq, combineInput(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	RETURN(combinedShells);
END;