IMPORT NAC_V2_Services,STD,Address,NID,ut;
//nacv2 interface
nacv2I:=NAC_V2_Services.IParams.CommonParams;
empty_mod:=module (nacv2I) end;

EXPORT BatchFunctions(nacv2I in_mod = empty_mod) := MODULE

	EXPORT processBatch(DATASET(NAC_V2_Services.Layouts.batch_in_temp) ds_in) := FUNCTION

		NAC_V2_Services.Layouts.process_layout xformInput(ds_in L) := TRANSFORM
			SELF.acctno 						:= (UNSIGNED)L.acctno;// Sequenced acctno
			SELF.orig_acctno 			  := L.orig_acctno;
			useCleanName						:= L.name_first <> '' AND L.name_last <> '';
			nameToClean							:= Address.NameFromComponents(L.name_first, L.name_middle,
			                                                      L.name_last, L.name_suffix);
			cleanName								:= Address.CleanNameFields(Address.CleanPersonFML73(nameToClean)).CleanNameRecord;
			nameLast                := IF(useCleanName, cleanName.lname, L.name_last);
			SELF.name_last 					:= nameLast;
			nameFirst               := IF(useCleanName, cleanName.fname, L.name_first);
			SELF.name_first 				:= nameFirst;
			SELF.name_middle 				:= IF(useCleanName, cleanName.mname, L.name_middle);
			SELF.name_suffix				:= IF(useCleanName, cleanName.name_suffix, L.name_suffix);
			SELF.name_first_pref		:= NID.PreferredFirst(nameFirst);
			SELF.name_first_pref_new:= NID.PreferredFirstNew(nameFirst);
			SELF.orig_name_last			:= L.name_last;
			SELF.orig_name_first		:= L.name_first;
			address1_addr1					:= L.address1_addr1 + ' ' + L.address1_addr2;
			address1_addr2 					:= Address.Addr2FromComponents(L.address1_city, 
			                                                       L.address1_state, L.address1_zip);
			address1_clean_addr 		:= address.GetCleanAddress(address1_addr1,address1_addr2,
			                                                   address.Components.country.US).results;
			SELF.addr1_prim_range		:= address1_clean_addr.prim_range;
			SELF.addr1_prim_name 		:= address1_clean_addr.prim_name;
			SELF.addr1_suffix				:= address1_clean_addr.suffix;
			SELF.addr1_predir 			:= address1_clean_addr.predir;
			SELF.addr1_postdir 			:= address1_clean_addr.postdir;
			SELF.addr1_sec_range		:= address1_clean_addr.sec_range;
			SELF.addr1_city					:= address1_clean_addr.p_city;
			SELF.addr1_state				:= address1_clean_addr.state;
			SELF.addr1_zip					:= address1_clean_addr.zip;
			address2_addr1					:= L.address2_addr1 + ' ' + L.address2_addr2;
			address2_addr2 					:= Address.Addr2FromComponents(L.address2_city,
			                                                       L.address2_state, L.address2_zip);
			address2_clean_addr 		:= address.GetCleanAddress(address2_addr1,address2_addr2,
			                                                   address.Components.country.US).results;
			SELF.addr2_prim_range 	:= address2_clean_addr.prim_range;
			SELF.addr2_prim_name 		:= address2_clean_addr.prim_name;
			SELF.addr2_suffix				:= address2_clean_addr.suffix;
			SELF.addr2_predir 			:= address2_clean_addr.predir;
			SELF.addr2_postdir 			:= address2_clean_addr.postdir;
			SELF.addr2_sec_range		:= address2_clean_addr.sec_range;
			SELF.addr2_city					:= address2_clean_addr.p_city;
			SELF.addr2_state				:= address2_clean_addr.state;
			SELF.addr2_zip					:= address2_clean_addr.zip;
			// For filling match codes correctly if city/state OR zip wasn't actually in the input
			SELF.hasCityStateInput	:= (L.address1_city <> '' AND L.address1_state <> '') 
			                            OR (L.address2_city <> '' AND L.address2_state <> '');
			SELF.hasZipInput				:= L.address1_zip <> '' OR L.address2_zip <> '';
			SELF.ssn			         	:= L.ssn;
			SELF.dob				        := L.dob;

			programCode             := STD.STR.ToUpperCase(L.program_code);
			SELF.in_program_code    := programCode;
			eligibilityPeriodType   := STD.STR.ToUpperCase(L.eligibility_range_type);
			SELF.in_eligibility_period_type:= eligibilityPeriodType;
			
			startDate := TRIM(L.eligibility_start,LEFT);
			endDate   := TRIM(L.eligibility_end,LEFT);
			inHasNoDates:= startDate='' OR endDate='' OR eligibilityPeriodType='';			
			
			//this will check for the length automatically AND for D AND M 
			d_start := (STD.Date.Date_t)IF(eligibilityPeriodType=NAC_V2_Services.Constants.ELI_PERIOD_MONTH,
			                               startDate[..6] + '01',
																		 L.eligibility_start);
			d_end   := IF(eligibilityPeriodType=NAC_V2_Services.Constants.ELI_PERIOD_MONTH,
			              STD.Date.DatesForMonth((STD.Date.Date_t)(endDate[..6] + '01')).enddate,
									 (STD.Date.Date_t)L.eligibility_end);
			SELF.in_eligibility_start:= d_start;
			SELF.in_eligibility_end  := d_end;
			SELF.case_identifier     := STD.STR.ToUpperCase(L.case_identifier);
			SELF.client_identifier   := STD.STR.ToUpperCase(L.client_identifier);
			SELF.IncludeEligibilityHistory := L.IncludeEligibilityHistory;
			SELF.IncludeInterstateAllPrograms := L.IncludeInterstateAllPrograms;
			inHasNoPII	:= ~NAC_V2_Services.Functions().inputHasPII(nameLast, nameFirst, L.ssn,
															L.address1_addr1, L.address1_city, L.address1_state, L.address1_zip,
															L.address2_addr1, L.address2_city, L.address2_state, L.address2_zip);

			SELF.error_code	:= NAC_V2_Services.Functions(in_mod).isMatchInputMet(programCode,eligibilityPeriodType,
			                                             d_start,d_end,inHasNoDates,inHasNoPII);
		END;
		ds_out := PROJECT(ds_in, xformInput(LEFT));
		// Debug
		#IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(ds_out(error_code=0),NAMED('valid_inputs'));
			OUTPUT(ds_out(error_code>0),NAMED('invalid_inputs'));
		#END
		RETURN ds_out;
	END;

	// Rolls up the records to keep the latest and populates all
	//history ranges in string (and not only 12 months back(NAC1))
	EXPORT populateBatchHistory(DATASET(NAC_V2_Services.Layouts.process_layout) ds_in,
	                            DATASET(NAC_V2_Services.Layouts.nac_raw_rec) nac_recs) := FUNCTION
		//since displaying history is record based in nac2, we only do it for the acctno's that have it turned on
		showHist_acctno_set := SET(ds_in(IncludeEligibilityHistory),acctno);
		merged_history_recs := NAC_V2_Services.Functions().mergeContigHistRecs(nac_recs(acctno in showHist_acctno_set));

		initialized_history_ds	:= PROJECT(merged_history_recs,
																	 TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
																				SELF.match_history_period :=
																						LEFT.eligibility_status_indicator + ':' +
																						LEFT.eligibility_period_end_raw + '-' +
																						LEFT.eligibility_period_start_raw,
																				SELF := LEFT));
		// We purposely want a batch history output format of
		//E/A/D/I:YYYYMMDD so even if the DD portion is empty we don't TRIM it.
		ds_rolled_History := ROLLUP(initialized_history_ds,
														 LEFT.acctno = RIGHT.acctno AND
														 LEFT.client_identifier  = RIGHT.client_identifier AND
														 LEFT.case_program_state = RIGHT.case_program_state AND
														 LEFT.nac_groupid        = RIGHT.nac_groupid AND
														 LEFT.case_program_code  = RIGHT.case_program_code,
															 TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
																		SELF.match_history_period := 
																			     LEFT.match_history_period + ',' +
																					 RIGHT.eligibility_status_indicator + ':' +
																					 RIGHT.eligibility_period_end_raw + '-' +
																					 RIGHT.eligibility_period_start_raw,
																		SELF := LEFT));

		parent_recs_duped := DEDUP(nac_recs(isHit),acctno,client_identifier,case_program_state,nac_groupid,case_program_code);		

		// Join parent records with history records
		final_hist_recs := JOIN(parent_recs_duped, ds_rolled_History,
												 		LEFT.acctno             = RIGHT.acctno             AND 
												 		LEFT.client_identifier  = RIGHT.client_identifier  AND 
														LEFT.case_program_state = RIGHT.case_program_state AND 
														LEFT.nac_groupid        = RIGHT.nac_groupid AND 
														LEFT.case_program_code  = RIGHT.case_program_code,
												 TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
																	 SELF.match_history_period := RIGHT.match_history_period,
																	 SELF := LEFT),
														LEFT OUTER,
														LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_RECORDS_PER_ACCTNO));		

		hist_recs_sorted := SORT(final_hist_recs,acctno,-eligibility_period_end_raw, case_program_state,nac_groupid,
														 case_program_code,client_identifier);	
		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)																		
			OUTPUT(showHist_acctno_set,    NAMED('showHist_acctno_set')); 
			OUTPUT(initialized_history_ds, NAMED('initialized_history_ds')); 
			OUTPUT(ds_rolled_History,      NAMED('ds_rolled_History'));
			OUTPUT(parent_recs_duped,      NAMED('parent_recs_duped'));
			OUTPUT(hist_recs_sorted,       NAMED('hist_recs_sorted'));
		#END
		RETURN hist_recs_sorted;
	END;

	EXPORT finalBatchTransform(DATASET(NAC_V2_Services.Layouts.nac_raw_rec) nac_recs) := FUNCTION
		ds_results := PROJECT(nac_recs,
		                 TRANSFORM(NAC_V2_Services.Layouts.nac_batch_out,
													SELF.acctno      := LEFT.orig_acctno, //restore orig acctno's
													SELF.eligibility_period_type             := LEFT.client_period_type,
													SELF.eligibility_period_total_count_days := LEFT.totaldays,
													SELF.eligibility_period_total_count_months := LEFT.totalmonths,
													SELF._penalty   := LEFT.penalt,
													SELF.lexid      := LEFT.did,
													SELF.error_code := (STRING)LEFT.err_search,
													SELF.error_desc := LEFT.err_desc,
													SELF := LEFT));

			ut.mac_TrimFields(ds_results,'ds_results',results);
		RETURN results;
	END;

END;