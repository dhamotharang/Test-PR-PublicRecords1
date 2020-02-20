IMPORT NAC_V2_Services, iesp, AutoStandardI, Address, STD, AutoKeyI;
//nacv2 interface
nacv2I:=NAC_V2_Services.IParams.CommonParams;
empty_mod:=module (nacv2I) end;

EXPORT Functions(nacv2I in_mod = empty_mod) := MODULE

	EXPORT StoreIesp(inIesp,suffix_name='SuffixName') := MACRO
			// SET ESP #STORED for penalty AND autokeys
			iesp.ECL2ESP.SetInputBaseRequest(inIesp);
			// This will #store some standard input parameters (generally, for search purposes)
			iesp.ECL2ESP.SetInputReportBy(ROW(inIesp.SearchBy.Identity,
				TRANSFORM(iesp.bpsreport.t_BpsReportBy,
						 SELF.Name := iesp.ECL2ESP.SetName(LEFT.FirstName, LEFT.middleName,
																							 LEFT.LastName,  LEFT.suffix_name, '', LEFT.FullName),
						 SELF.Address := iesp.ECL2ESP.SetAddress('', '', '', '', '', '', '', 
																										 LEFT.Address1.city, LEFT.Address1.State, LEFT.Address1.Zip, 
																										 '', '', '',
																										 LEFT.Address1.StreetAddress1, LEFT.Address1.StreetAddress2, ''),
						 SELF.DOB := iesp.ECL2ESP.toDatestring8(LEFT.DOB),
						 SELF.SSN := LEFT.SSN,
						 SELF:=[])));
	ENDMACRO;

	EXPORT inputHasPII(STRING lname,STRING fname,STRING ssn, 
									   STRING addr1_addr1,STRING addr1_city,STRING addr1_state,STRING addr1_zip,
										 STRING addr2_addr1,STRING addr2_city,STRING addr2_state,STRING addr2_zip) := FUNCTION
		// IN NAC investigative searches, we return rare first matches by first name only ex - TAMYAHA
		hasName := lname <> '' OR fname <> '';
		hasSSN  :=  ssn <> '';
		hasAddress := addr1_addr1 <> '' OR addr1_city <> '' OR addr1_state <> '' OR addr1_zip <> '' OR
									addr2_addr1 <> '' OR addr2_city <> '' OR addr2_state <> '' OR addr2_zip <> '';

		RETURN hasName OR hasSSN OR hasAddress;
	END;	

	EXPORT isMatchInputMet(STRING1 program_code,STRING1 e_date_type,STD.DATE.date_t e_start_date,
	                       STD.DATE.date_t e_end_date,BOOLEAN hasNoDates,BOOLEAN hasNoPII) := FUNCTION	

		hasInValidDates	:= ~STD.DATE.IsValidDate(e_start_date) OR ~STD.DATE.IsValidDate(e_end_date) 
		                    OR e_start_date>e_end_date OR e_date_type NOT IN NAC_V2_Services.Constants.ELI_PERIOD_SET;
	  hasNoProgramCode := program_code = '';
		// Config error - This means they can't see any data
	  hasInValidMBSProgramInputs := COUNT(in_mod.SET_PAS)=0 OR COUNT(in_mod.SET_PAR)=0;
		// Invalid input error - IN case they pass us an invalid program code from batch OR xml direct
		hasValidProgramCode      := program_code IN NAC_V2_Services.Constants.PROGRAM_SET;
		hasInValidProgramCode    := ~hasValidProgramCode;
		// Config error - If they search on a program for which they don't have rights
		hasUnauthorizedProgramCode := hasValidProgramCode AND program_code NOT IN in_mod.SET_PAS;
		// Config error - Because its supplied by MBS for online and read from the batch input file for the batch query
	  hasNoGroupIDorSourceState := in_mod.NacGroupId = '' OR in_mod.SourceState = '';

		RETURN MAP(hasNoDates OR hasNoProgramCode OR hasNoPII    => AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT
		,hasInValidMBSProgramInputs OR
		 hasUnauthorizedProgramCode OR hasNoGroupIDorSourceState => AutoKeyI.errorcodes._codes.CONFIG_ERR
		,hasInValidDates OR hasInValidProgramCode                => AutoKeyI.errorcodes._codes.INVALID_INPUT
		,0);														
	END;

	SHARED calculatePenalty(NAC_V2_Services.Layouts.process_layout L, 
													NAC_V2_Services.Layouts.nac_raw_rec R) := FUNCTION
		// Need to use fake module to satisfy the interface signature
		default_mod := AutoStandardI.DefaultModule();
		mod_w_addr1 := 
			MODULE(PROJECT(default_mod, AutoStandardI.LIBIN.PenaltyI_Indv.full, opt))
				// The 'input' name:
				EXPORT lastname       := l.name_last;   
				EXPORT middlename     := l.name_middle; 
				EXPORT firstname      := l.name_first;  
				EXPORT ssn            := l.ssn;
				EXPORT dob            := (UNSIGNED)l.dob;
				// The 'input' address:
				EXPORT predir         := l.addr1_predir;
				EXPORT prim_name      := l.addr1_prim_name;
				EXPORT prim_range     := l.addr1_prim_range;
				EXPORT postdir        := l.addr1_postdir;
				EXPORT addr_suffix    := l.addr1_suffix;
				EXPORT sec_range      := l.addr1_sec_range;
				EXPORT p_city_name    := l.addr1_city;
				EXPORT st             := l.addr1_state;
				EXPORT z5             := l.addr1_zip;
				// The name IN the matching record:
				EXPORT lname_field    := r.lname; 
				EXPORT mname_field    := r.mname; 
				EXPORT fname_field    := r.fname; 
				EXPORT ssn_field      := r.clean_ssn;
				EXPORT dob_field      := (STRING)r.clean_dob;
				// The address IN the matching record:						
				EXPORT allow_wildcard := FALSE;					
				EXPORT pname_field    := r.prim_name;
				EXPORT postdir_field  := r.postdir;
				EXPORT prange_field   := r.prim_range;
				EXPORT predir_field   := r.predir;
				EXPORT sec_range_field:= r.sec_range;
				EXPORT city_field     := r.p_city_name;
				EXPORT state_field    := r.st;
				EXPORT zip_field      := r.zip;
				EXPORT suffix_field   := r.addr_suffix;
				EXPORT useGlobalScope := FALSE;
				EXPORT city2_field    := '';
				EXPORT county_field   := '';
				EXPORT DID_field      := '';
				EXPORT phone_field    := '';
			END;
		mod_w_addr2 := 
			MODULE(PROJECT(default_mod, AutoStandardI.LIBIN.PenaltyI_Indv.full, opt))
				// The 'input' name:
				EXPORT lastname       := l.name_last;   
				EXPORT middlename     := l.name_middle; 
				EXPORT firstname      := l.name_first;  
				EXPORT ssn            := l.ssn;
				EXPORT dob            := (UNSIGNED)l.dob;
				// The 'input' address:
				EXPORT predir         := l.addr2_predir;
				EXPORT prim_name      := l.addr2_prim_name;
				EXPORT prim_range     := l.addr2_prim_range;
				EXPORT postdir        := l.addr2_postdir;
				EXPORT addr_suffix    := l.addr2_suffix;
				EXPORT sec_range      := l.addr2_sec_range;
				EXPORT p_city_name    := l.addr2_city;
				EXPORT st             := l.addr2_state;
				EXPORT z5             := l.addr2_zip;
				// The name IN the matching record:
				EXPORT lname_field    := r.lname; 
				EXPORT mname_field    := r.mname; 
				EXPORT fname_field    := r.fname; 
				EXPORT ssn_field      := r.clean_ssn;
				EXPORT dob_field      := (STRING)r.clean_dob;
				// The address IN the matching record:						
				EXPORT allow_wildcard := FALSE;					
				EXPORT pname_field    := r.prim_name;
				EXPORT postdir_field  := r.postdir;
				EXPORT prange_field   := r.prim_range;
				EXPORT predir_field   := r.predir;
				EXPORT sec_range_field:= r.sec_range;
				EXPORT city_field     := r.p_city_name;
				EXPORT state_field    := r.st;
				EXPORT zip_field      := r.zip;
				EXPORT suffix_field   := r.addr_suffix;
				EXPORT useGlobalScope := FALSE;
				EXPORT city2_field    := '';				
				EXPORT county_field   := '';
				EXPORT DID_field      := '';
				EXPORT phone_field    := '';
			END;
			hasAddress1 := l.addr1_prim_name <> '' AND l.addr1_prim_range <> '';
			hasAddress2 := l.addr2_prim_name <> '' AND l.addr2_prim_range <> '';
			penalty_address1 := AutoStandardI.LIBCALL_PenaltyI_Addr.val(mod_w_addr1);
			penalty_address2 := AutoStandardI.LIBCALL_PenaltyI_Addr.val(mod_w_addr2);
			penalty_address  := MAP(hasAddress1 AND hasAddress2 => MIN(penalty_address1, penalty_address2),
														  hasAddress1								  => penalty_address1,
														  hasAddress2								  => penalty_address2,
														  0);
			// Calculate penalty for Name,address,DOB,SSN
			penalty_score := penalty_address + 
											 AutoStandardI.LIBCALL_PenaltyI_DOB.val(mod_w_addr1) + 
											 AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(mod_w_addr1) + 
											 AutoStandardI.LIBCALL_PenaltyI_SSN.val(mod_w_addr1);
		RETURN penalty_score;
	END;

	// IN NAC1 AND NAC2, S (SNAP) & D (DSNAP) records should find/include/exclude each other
	SHARED is_program_S_or_D(STRING1 out_program,STRING1 in_program):= 
						out_program IN NAC_V2_Services.Constants.SNAP_DSNAP_SET AND
						in_program  IN NAC_V2_Services.Constants.SNAP_DSNAP_SET;

	SHARED EX_IN_clusive_Filters(STRING out_caseID,STRING in_caseID,STRING out_clientID,STRING in_clientID,STRING4 out_groupid,
	                             STRING2 out_state,STRING1 out_program,STRING1 in_program,STRING1 e_s_indicator) := FUNCTION

		is_S_or_D := is_program_S_or_D(out_program,in_program);

		// If match search (InvestigativePurpose = false), apply Match_EXclusive_Filter
		// This filter ensures that We EXCLUDE records with case OR client ID's,
		//state, program and groupID that = input case/client ID, state, program & groupID.
		// NAC2-exclusive on Case AND Client. NAC1-exclusive on Case only
		// HOWEVER, for NAC2, we don't want to remove the CASEID records until we apply
		//history which is why there is no caseID checks in the filter below
		//so we flag it as a "no match" below and it will get filtered out after history
		Match_ClientID_EXclusive_Filter := 
		~(  out_clientID = in_clientID AND
				out_groupid  = in_mod.NacGroupID AND
			  out_state    = in_mod.SourceState AND
			 (out_program  = in_program OR is_S_or_D) );

		// If we are in investigative mode, apply Investigative_INclusive_Filter
		// This filter ensures that We only INCLUDE records with case AND client ID's,
		//state & program that = input case/client ID, state & program.
		// NAC2-inclusive on Case AND Client. NAC1-inclusive on Case only
		// IF there is no CASE OR CLIENT id, it filters by program only unless valid wildcard * was past in
		Investigative_INclusive_Filter :=
		((out_caseID    = in_caseID OR in_caseID = '' ) AND
		 (out_clientID  = in_clientID OR in_clientID = '') AND
		 // Input State can be '' for PII ONLY (no input case/client ID's) investigative searches
		 (out_state     = in_mod.InvestigativeState OR (in_caseID = '' AND in_clientID = '')) AND 
		 (out_program   = in_program OR is_S_or_D OR in_program = NAC_V2_Services.Constants._ALL) AND
		 // This allows investigators to filter for E,I,A OR D records only
		 (e_s_indicator = in_mod.EligibilityStatus OR in_mod.EligibilityStatus=''));

		// for both Match & Investigator searches, they can only see programs that is IN their PROGRAMS-ALLOWED-RETURN bit string
		EX_IN_clusive_Filter := IF(in_mod.InvestigativePurpose,
		                           Investigative_INclusive_Filter,
															 Match_ClientID_EXclusive_Filter)
														// Return only records that the users are allowed to see
														AND out_program IN in_mod.SET_PAR
														// We never return 'N' indicator records
														AND e_s_indicator<>NAC_V2_Services.Constants.NO_BENEFIT_RECEIVED;
		RETURN EX_IN_clusive_Filter;
	END;

	SHARED applyMatchCoreLogic(STRING2 out_state,STRING4 out_groupID,STRING1 out_program,STRING1 in_program,STRING out_caseID,
														 STRING in_caseID,BOOLEAN IncludeInterstateAllPrograms) := FUNCTION

		is_S_or_D := is_program_S_or_D(out_program,in_program);
		in_state := in_mod.SourceState;

    // See Match_ClientID_EXclusive_Filter comments above
		CaseID_isNot_EXclusively_FilteredOut := 
		~(  out_caseID  = in_caseID AND
			  out_groupID = in_mod.NacGroupID AND
			  out_state   = in_state AND
			 (out_program = in_program OR is_S_or_D) );		

		outProgram_Equals_inProgram := out_program = in_program OR is_S_or_D;

		// INTRAState Match (IN state matches) - records with the same state AND program as the input.
		// We are interested IN INTRAState matches because although a subject is allowed to receive
		//different benefits IN the same state for the same time frame, they are NOT allowed to
		//receive the SAME benefit multiple times IN the same state for the same time frame.
		isINTRA_State_Match := out_state = in_state AND outProgram_Equals_inProgram;

		// INTERState Match (out of state matches) - records with any program (including input program)
		//in any state outside of the source state. We are interested IN INTERState matches because
		//it's suspicious to receive multiple out of state benefits for the same time frame.
		isINTER_State_Match := out_state <> in_state;

		// Put it all together based flag
		isMatch := IF(IncludeInterstateAllPrograms,
									isINTRA_State_Match OR isINTER_State_Match,// NAC1 always hits this one
									outProgram_Equals_inProgram) // Return ONLY input program matches regardless of state
									AND CaseID_isNot_EXclusively_FilteredOut;
		RETURN isMatch;
	END;

	SHARED penaltyAndFilterLogic(DATASET(NAC_V2_Services.Layouts.process_layout) in_rec, 
	                             DATASET(NAC_V2_Services.Layouts.nac_raw_rec) nac_recs) := FUNCTION												 
		nac_recs_w_penalty := 
			JOIN(in_rec, nac_recs,
				LEFT.acctno = RIGHT.acctno AND
				EX_IN_clusive_Filters(RIGHT.case_identifier,LEFT.case_identifier,RIGHT.client_identifier,LEFT.client_identifier,RIGHT.nac_groupid,
						RIGHT.case_program_state,RIGHT.case_program_code,LEFT.in_program_code,RIGHT.eligibility_status_indicator),
				TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
						isRecInRange :=  ~( (LEFT.in_eligibility_start > RIGHT.eligibility_period_end) OR 
																(LEFT.in_eligibility_end   < RIGHT.eligibility_period_start) );
						isMatch := applyMatchCoreLogic(RIGHT.case_program_state,RIGHT.nac_groupid,RIGHT.case_program_code,LEFT.in_program_code,
																					 RIGHT.case_identifier,LEFT.case_identifier,LEFT.IncludeInterstateAllPrograms);
						SELF.isHit   := (in_mod.InvestigativePurpose OR isMatch) AND isRecInRange;
						SELF.penalt  := calculatePenalty(left, RIGHT),
						SELF.isFullSSNMatch :=  LEFT.ssn = RIGHT.clean_ssn, //if we have a full SSN, we want to bypass penalty AND keep the match
						SELF.in_programCode :=  LEFT.in_program_code, 
						SELF.in_clientIdentifier :=  LEFT.client_identifier,
						//for nac1
						SELF.nac1_in_month         := LEFT.benefit_month;
						SELF.nac1_in_start_month   := LEFT.benefit_month_start;
						SELF.nac1_in_end_month     := LEFT.benefit_month_END;
						SELF.isBenefitTypeMatch    := in_mod.InvestigativePurpose OR isMatch;
						SELF.isEligibleStatusMatch := (LEFT.eligibility_status = '' OR 
																					 LEFT.eligibility_status = RIGHT.eligibility_status_indicator),
						SELF := RIGHT),
						LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_IDS_PER_ACCTNO));

		// If we have a full SSN OR deep dive record, we want to bypass penalty AND keep the match
		nac_recs_penalty_filt := nac_recs_w_penalty (penalt <= in_mod.PenaltThreshold OR isDeepDive OR isFullSSNMatch);

		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)	
			OUTPUT(nac_recs_w_penalty,    NAMED('nac_recs_w_penalty'));
			OUTPUT(nac_recs_penalty_filt, NAMED('nac_recs_penalty_filt'));
		#END
		RETURN nac_recs_penalty_filt;
	END;
	
	EXPORT getNacRecs(DATASET(NAC_V2_Services.Layouts.process_layout) ds_in) := FUNCTION
		// Deep Dive to get IDs
		deep_ids := NAC_V2_Services.Raw.IdsByDeepDive(ds_in,in_mod);

		// Use autokeys to get additional IDs
		// Don't use autokeys for match searches if there are no SSN OR DOB
		ak_ids := NAC_V2_Services.Autokey_ids.val(ds_in(in_mod.InvestigativePurpose OR ssn <> '' OR dob <> ''), in_mod);

		// IDs are already provided in the input
    CaseOrClientInput := ds_in(case_identifier <> '' OR client_identifier <> ''); 		

		// Due to the strict min input checks, the ds_in records at this point will always have the required fields
		in_ids := PROJECT(CaseOrClientInput, 
											TRANSFORM(NAC_V2_Services.Layouts.search_layout,
																SELF.state   := in_mod.InvestigativeState,
																SELF := LEFT, //acctno, case_identifier, client_identifier
																SELF := [])); //isdeepdive, matchCode, did
		// Combine results:
		// We want to find as many IDs as possible
		pii_ids := DEDUP(SORT(deep_ids + ak_ids, 
													 acctno, case_identifier, client_identifier, state, -isDeepDive), 
											acctno, case_identifier, client_identifier, state);
		// If they enter case or client, we ignore PII
		nac_ids :=  IF(in_mod.InvestigativePurpose AND EXISTS(CaseOrClientInput), in_ids, pii_ids);

		// Hit NAC payload
		nac_recs := NAC_V2_Services.Raw.getRecordsByIds(nac_ids,in_mod);

		// Apply penalty, exclusionary and inclusionary nac filters and set match hits
    nac_recs_penal_filt := penaltyAndFilterLogic(ds_in,nac_recs);

		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(deep_ids, NAMED('deep_ids'));
			OUTPUT(ak_ids,   NAMED('ak_ids'));
			OUTPUT(in_ids,   NAMED('in_ids'));
		  OUTPUT(pii_ids,  NAMED('pii_ids'));
			OUTPUT(nac_ids,  NAMED('nac_ids'));
			OUTPUT(nac_recs, NAMED('nac_recs'));
		#END
		RETURN nac_recs_penal_filt;
	END;

	EXPORT MatchCodeLogic(ds_in,ds_int,_mod_in) := FUNCTIONMACRO
		IMPORT STD,BatchServices,Address,HEADER;
		trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);
		strEql  (STRING str1, STRING str2, BOOLEAN noBlnk = TRUE) := IF(noBlnk, str1 = str2 AND LENGTH(str2) > 0,
																																	 (LENGTH(str2) = 0) OR (str1 = str2));
		strEqlTrim (STRING str1, STRING str2, BOOLEAN noBlnk = TRUE) := strEql(trimBoth(str1), trimBoth(str2), noBlnk);
		getMatchVal(BOOLEAN isMatch, STRING1 matchVal) := IF(isMatch, matchVal, '');
		nameMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_NAME);
		ssnMatchVal (BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_SSN);
		probSsnMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_PROB_SSN);
		dobMatchVal    (BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_DOB);
		probDobMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_PROB_DOB);
		addrMatchVal   (BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_ADDR);
		cityStateMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_CITY_STATE);
		zipMatchVal      (BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_ZIP);
		lnamePartialFnameMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_LNAME_PARTIAL_FNAME);
		lnameMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, NAC_V2_Services.Constants.STR_MATCH_LNAME);

		SetRank(STRING mc,UNSIGNED lexidScore) := 
													MAP(lexidScore <> 0                     => 0, //LexID match
														 STD.Str.Contains(mc, 'NSD', true)		=> 1,
														 STD.Str.Contains(mc, 'VSD', true)		=> 2,
														 STD.Str.Contains(mc, 'NSB', true)		=> 3,
														 STD.Str.Contains(mc, 'VSB', true)		=> 4,
														 STD.Str.Contains(mc, 'NPD', true)		=> 5,
														 STD.Str.Contains(mc, 'VPD', true)		=> 6,
														 STD.Str.Contains(mc, 'NPB', true)		=> 7,
														 STD.Str.Contains(mc, 'VPB', true)		=> 8,
														 STD.Str.Contains(mc, 'S', true)			=> 9,
														 STD.Str.Contains(mc, 'NDACZ', true)	=> 10,
														 STD.Str.Contains(mc, 'NDAC', true)	
														OR STD.Str.Contains(mc, 'NDAZ', true) => 11,
														 STD.Str.Contains(mc, 'VDACZ', true)	=> 12,
														 STD.Str.Contains(mc, 'VDAC', true)	
														OR STD.Str.Contains(mc, 'VDAZ', true )=> 13,
														 STD.Str.Contains(mc, 'NBACZ', true)	=> 14,
														 STD.Str.Contains(mc, 'NBAC', true)	
														OR STD.Str.Contains(mc, 'NBAZ', true) => 15,
														 STD.Str.Contains(mc, 'VBACZ', true)	=> 16,
														 STD.Str.Contains(mc, 'VBAC', true)	
														OR STD.Str.Contains(mc, 'VBAZ', true) => 17,
												   100);

		RECORDOF(ds_int) xformMatchCode(ds_int L, ds_IN R) := TRANSFORM
			nameMatch := (strEqlTrim(l.lname, r.name_last) AND l.fname IN [r.name_first, r.name_first_pref, r.name_first_pref_new])
										 OR (r.orig_name_last IN [l.lname, l.client_last_name] AND r.orig_name_first IN [l.fname, l.client_first_name]);
			ssnMatch 	:= strEqlTrim(l.clean_ssn, r.ssn);
			// Returns true if SSNs are NOT the same (if we have ssnMatch we dont care to get probSsnMatch),
			//but there is one differing digit OR two transposed digits
			probSsnMatch 	:= BatchServices.Functions.fn_ssn_accunear(l.clean_ssn, r.ssn);
			dobMatch			:= strEqlTrim((STRING)l.clean_dob, r.dob);
			probDobMatch	:= Header.sig_near_dob(l.clean_dob, (UNSIGNED)r.dob) AND NOT dobMatch;
			Addr1Match 		:= (strEqlTrim(l.prim_name, r.addr1_prim_name) AND 
												strEqlTrim(l.prim_range, r.addr1_prim_range) AND 
												strEqlTrim(l.sec_range, r.addr1_sec_range, FALSE))
											 OR
											 (Address.isPOBox(l.prim_name) AND 
												strEqlTrim(l.prim_name, r.addr1_prim_name));
			Addr2Match 	:= (strEqlTrim(l.prim_name, r.addr2_prim_name) AND 
											strEqlTrim(l.prim_range, r.addr2_prim_range) AND 
											strEqlTrim(l.sec_range, r.addr2_sec_range, FALSE))
										 OR
										 (Address.isPOBox(l.prim_name) AND 
											strEqlTrim(l.prim_name, r.addr2_prim_name));
			addrMatch 	:= Addr1Match OR Addr2Match;
			addr1CityStateMatch			:= strEqlTrim(l.p_city_name, r.addr1_city) AND strEqlTrim(l.st, r.addr1_state);
			addr2CityStateMatch			:= strEqlTrim(l.p_city_name, r.addr2_city) AND strEqlTrim(l.st, r.addr2_state);
			cityStateMatch					:= (addr1CityStateMatch OR addr2CityStateMatch) AND r.hasCityStateInput;
			addr1ZipMatch 					:= strEqlTrim(l.zip, r.addr1_zip);
			addr2ZipMatch						:= strEqlTrim(l.zip, r.addr2_zip);
			zipMatch 								:= (addr1ZipMatch OR addr2ZipMatch) AND r.hasZipInput;
			// If we already have a full name match we dont care to get a lname match OR lname+partial fname match
			lname_match							:= (strEqlTrim(l.lname, R.name_last) AND NOT nameMatch)
																				 OR (r.orig_name_last IN [l.lname, l.client_last_name] AND NOT nameMatch); 
			lnamePartialFnameMatch 	:= lname_match AND (l.fname[1] IN [r.name_first[1], r.name_first_pref[1], r.name_first_pref_new[1]]
																													OR r.orig_name_first[1] IN [l.fname[1], l.client_first_name[1]]);
			lnameMatch 							:= lname_match AND NOT lnamePartialFnameMatch;
			mcode := nameMatchVal(nameMatch) + lnamePartialFnameMatchVal(lnamePartialFnameMatch) + lnameMatchVal(lnameMatch) +
							 ssnMatchVal(ssnMatch)   + probSsnMatchVal(probSsnMatch) + 
							 dobMatchVal(dobMatch)   + probDobMatchVal(probDobMatch) +
							 addrMatchVal(addrMatch) + cityStateMatchVal(cityStateMatch) + zipMatchVal(zipMatch);
			SELF.matchcode  := mcode;
			did_score				:= IF(L.isDeepDive, L.did_score, 0);
			SELF.lexid_score	:= did_score;
			SELF.rank_order		:= setRank(mcode,did_score);
			SELF := L;
		END;

		ds_RankedMatchCodes := JOIN(ds_int, ds_in, 
		                            LEFT.acctno = RIGHT.acctno,
																xformMatchCode(left, RIGHT),
																LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_IDS_PER_ACCTNO));

    ds_sortedMatchCodes:= SORT(GROUP(SORT(ds_RankedMatchCodes, acctno), acctno), rank_order, penalt);		

	  //Final filtering: only allow matchcodes with rank order 0-17
	  nac_rank_filt := IF(_mod_in.InvestigativePurpose,
		                    ds_sortedMatchCodes, 
												ds_sortedMatchCodes(rank_order < NAC_V2_Services.Constants.MAX_SORT_RANK_MATCHES));
		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(ds_RankedMatchCodes,NAMED('ds_RankedMatchCodes')); 
			OUTPUT(ds_sortedMatchCodes,NAMED('ds_sortedMatchCodes'));
			OUTPUT(nac_rank_filt,      NAMED('nac_rank_filt'));
		#END
		RETURN nac_rank_filt;
	ENDMACRO;

	// To combine records that only have different addresses since they don't look for those IN match searches	
	EXPORT mergeContigHistRecs(DATASET(NAC_V2_Services.Layouts.nac_raw_rec) nac_history_recs) := FUNCTION

	  ds_hist_sorted := SORT(nac_history_recs,acctno,client_identifier,case_program_state,
		                       case_program_code,-eligibility_period_end_raw,-isHit);		

		ds_hist_grouped := GROUP(ds_hist_sorted,acctno,client_identifier,case_program_state,case_program_code);

		ds_contig_hist := ROLLUP(ds_hist_grouped,
												 LEFT.acctno = RIGHT.acctno AND 
												 LEFT.case_identifier = RIGHT.case_identifier AND
												 LEFT.client_identifier = RIGHT.client_identifier AND
												 LEFT.case_program_state = RIGHT.case_program_state AND
												 LEFT.nac_groupid = RIGHT.nac_groupid AND
												 LEFT.case_program_code = RIGHT.case_program_code AND
												 LEFT.eligibility_status_indicator = RIGHT.eligibility_status_indicator AND
												 // Check if the periods are followed - by doing startdate-(enddate +1 day) = 0
												 LEFT.eligibility_period_start - STD.date.AdjustDate(RIGHT.eligibility_period_end,,,1) = 0 AND
												 LEFT.matchcode = RIGHT.matchcode AND
												 LEFT.lexid_score = RIGHT.lexid_score,
												 TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
														e_p_start := MIN(LEFT.eligibility_period_start,RIGHT.eligibility_period_start);
														e_p_end   := MAX(LEFT.eligibility_period_end  ,RIGHT.eligibility_period_end );	
														SELF.eligibility_period_start     := e_p_start;
														SELF.eligibility_period_end       := e_p_END;
														SELF.eligibility_period_start_raw := IF(LEFT.client_period_type='M', ((STRING)e_p_start)[..6], (STRING)e_p_start);
														SELF.eligibility_period_end_raw   := IF(LEFT.client_period_type='M', ((STRING)e_p_end)[..6]  , (STRING)e_p_end);
														SELF.eligible_period_count_days   := LEFT.eligible_period_count_days   + RIGHT.eligible_period_count_days ;																 
														SELF.eligible_period_count_months := LEFT.eligible_period_count_months + RIGHT.eligible_period_count_months ;
														SELF := LEFT));
	  // Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(ds_hist_sorted, NAMED('ds_sorted_PRE_Conguous_hist')); 
			OUTPUT(ds_hist_grouped,NAMED('ds_grouped_PRE_Conguous_hist')); 
			OUTPUT(ds_contig_hist, NAMED('ds_POST_contig_hist'));
		#END
		RETURN ds_contig_hist;
	END;

	// Cross tab logic to handle TOO_MANY_SUBJECTS error
	EXPORT MAC_handleTooManySubjects(in_ds,out_ds,out_acctno_set,maxRecs):= MACRO
		count_rec := RECORD 
			in_ds.acctno;
			total_num := COUNT(GROUP);
		END;
		count_table := TABLE(in_ds, count_rec, acctno)(total_num > maxRecs);
		// Set with the acctno's that have too many subjects
		out_acctno_set := SET(count_table, acctno);	

		// This join ensures that any acctno with more than 60 records will NOT be returned at all
		//so out_ds only contains the acctno's without too many subjects
		out_ds  := JOIN(in_ds, count_table,
									 LEFT.acctno = RIGHT.acctno,
									 TRANSFORM(LEFT),
									 LEFT ONLY,
									 ATMOST(maxRecs));
		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)					 
			OUTPUT(acctno_set,NAMED('acctno_set'));
		#END
	ENDMACRO;

	EXPORT populateErrors(input_recs,nac_recs,acctno_set) := FUNCTIONMACRO
		IMPORT AutoKeyI;
		nac_w_errors := JOIN(input_recs, nac_recs,
										LEFT.acctno = RIGHT.acctno,
										TRANSFORM(RECORDOF(nac_recs),
															SELF.orig_acctno := LEFT.orig_acctno, // Restore acctno's for batch
															err_code := MAP(LEFT.acctno IN acctno_set  => AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS, //203
																							LEFT.error_code IN NAC_V2_Services.Constants.SET_Input_errors	=> LEFT.error_code, // 301,303,101
																							RIGHT.case_identifier = '' => AutoKeyI.errorcodes._codes.NO_RECORDS, //10
																							0);
															SELF.err_search := err_code,
															SELF.err_desc := IF(err_code <> 0, AutoKeyI.errorcodes._msgs(err_code), ''),
															SELF.sequence_number := COUNTER,
															SELF := RIGHT),
										LEFT OUTER,
										LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_RECORDS_PER_ACCTNO));
		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(nac_w_errors,NAMED('nac_w_errors'));
		#END
		RETURN nac_w_errors;
	ENDMACRO;

	EXPORT applyCommonProcedures(in_recs,nac_recs,mod_in) := FUNCTIONMACRO
    // for the batch service, we do this after suppressing the acctno's with 60+ records
		NAC_V2_Services.Functions().MAC_handleTooManySubjects(nac_recs,
										valid_nac_recs,acctno_set,NAC_V2_Services.Constants.MAX_RECORDS_PER_ACCTNO);

	  // Populate exceptions if any - done only for NAC2 match searches
		ds_exceptions := NAC_V2_Services.Raw.populateExceptions(valid_nac_recs,mod_in);

		cond_nac_recs := IF(mod_in.InvestigativePurpose,valid_nac_recs,ds_exceptions);

		ds_batch_errors := NAC_V2_Services.Functions().populateerrors(in_recs,cond_nac_recs,acctno_set);

		RETURN ds_batch_errors;
	ENDMACRO;

END;
