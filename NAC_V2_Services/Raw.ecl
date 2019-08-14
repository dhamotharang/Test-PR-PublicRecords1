IMPORT NAC_V2_Services, NAC_V2, BatchServices, Autokey_batch, didville, ut, STD;

EXPORT Raw := MODULE
	EXPORT byDIDs(DATASET(NAC_V2_Services.layouts.search_layout) in_dids) := FUNCTION 

			joinup := JOIN(in_dids,NAC_V2.Key_DID,
			               keyed(LEFT.did=RIGHT.did),
													TRANSFORM(NAC_V2_Services.layouts.search_layout,
																		SELF.acctno := LEFT.acctno,
																		SELF.did := LEFT.did,
																		SELF.isDeepDive := LEFT.isDeepDive,
																		SELF.client_identifier := RIGHT.client_identifier,
																		SELF.case_identifier := RIGHT.case_identifier,
																		SELF.state := RIGHT.case_program_state),
													LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_RECS_PERDID)); 
			RETURN joinup;
	END;

	EXPORT IdsByHeaderLibrary(DATASET(NAC_V2_Services.Layouts.process_layout) ds_in, 
													        	NAC_V2_Services.IParams.commonParams in_mod) := FUNCTION
		//PROJECT to batch layout
		Autokey_batch.Layouts.rec_inBatchMaster xformAddr1(ds_in L) := TRANSFORM
			SELF.acctno 	    := (STRING)L.acctno;
			SELF.prim_range 	:= L.addr1_prim_range;
			SELF.prim_name 		:= L.addr1_prim_name;
			SELF.addr_suffix 	:= L.addr1_suffix;
			SELF.predir 			:= L.addr1_predir;
			SELF.postdir 			:= L.addr1_postdir;
			SELF.sec_range		:= L.addr1_sec_range;
			SELF.p_city_name 	:= L.addr1_city;
			SELF.st 					:= L.addr1_state;
			SELF.z5						:= L.addr1_zip;
			SELF := L; //name fields, ssn, dob
		END;

		Autokey_batch.Layouts.rec_inBatchMaster xformAddr2(ds_in L) := TRANSFORM
		  SELF.acctno 	    := (STRING)L.acctno;
			SELF.prim_range 	:= L.addr2_prim_range;
			SELF.prim_name 		:= L.addr2_prim_name;
			SELF.addr_suffix 	:= L.addr2_suffix;
			SELF.predir 			:= L.addr2_predir;
			SELF.postdir 			:= L.addr2_postdir;
			SELF.sec_range		:= L.addr2_sec_range;
			SELF.p_city_name 	:= L.addr2_city;
			SELF.st 					:= L.addr2_state;
			SELF.z5						:= L.addr2_zip;
			SELF := L; //name fields, ssn, dob
		END;
		ds_addr1 := PROJECT(ds_in, xformAddr1(LEFT));
		// No need to bother with second address search if there are no second address in the input
		ds_addr2 := PROJECT(ds_in(addr2_prim_range <> '' AND addr2_prim_name <> ''), xformAddr2(LEFT)); 

		// Combine - There will be at most two records per acctno
		ds_rec := ds_addr1 + ds_addr2;

		// Deep dive
		deep_dids := PROJECT(BatchServices.functions.fn_find_dids_and_append_to_acctno(ds_rec, NAC_V2_Services.Constants.MAX_DEEP_DIVE_DIDS), 
									 TRANSFORM(NAC_V2_Services.Layouts.search_layout, 
														 SELF.did := LEFT.did,
														 SELF.isDeepDive := TRUE,
														 SELF.acctno := (UNSIGNED)LEFT.acctno,
														 SELF := []));

		deep_dids_DEDUP := DEDUP(SORT(deep_dids,acctno, did),acctno, did);

		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(deep_dids_DEDUP,NAMED('IdsByHeaderLibrary'));
		#END
		RETURN deep_dids_DEDUP;		
	END;

	SHARED IdsByAdlBest(DATASET(NAC_V2_Services.Layouts.process_layout) ds_in, 
										        	NAC_V2_Services.IParams.commonParams in_mod) := FUNCTION
		GLB     := in_mod.isValidGlb();

		ds_filt := ds_in(dob = '' OR ut.Age((UNSIGNED4)dob) >= NAC_V2_Services.Constants.MAX_AGE_ADL_BEST);
		DidVille.Layout_Did_OutBatch xformAddr1(NAC_V2_Services.Layouts.process_layout l) := TRANSFORM
			 SELF.seq 				:= l.acctno;
			 SELF.phone10 		:= '';
			 SELF.title 			:= '';
			 SELF.fname 			:= l.name_first;
			 SELF.mname 			:= l.name_middle;
			 SELF.lname 			:= l.name_last;
			 SELF.suffix 			:= l.name_suffix;
			 SELF.ssn 				:= STD.Str.Filter(l.ssn,'0123456789');
			 SELF.did 				:= 0;
			 SELF.prim_range 	:= L.addr1_prim_range;
			 SELF.predir			:= L.addr1_predir;
			 SELF.prim_name		:= L.addr1_prim_name;
			 SELF.addr_suffix	:= L.addr1_suffix;
			 SELF.postdir			:= L.addr1_postdir;
			 SELF.sec_range		:= L.addr1_sec_range;
			 SELF.p_city_name	:= L.addr1_city;
			 SELF.st					:= L.addr1_state;
			 SELF.z5					:= L.addr1_zip;
			 SELF.unit_desig	:= '';
			 SELF.zip4				:= '';
			 SELF := l;
		END;
		DidVille.Layout_Did_OutBatch xformAddr2(NAC_V2_Services.Layouts.process_layout l) := TRANSFORM
			 SELF.seq 				:= l.acctno;
			 SELF.phone10 		:= '';
			 SELF.title 			:= '';
			 SELF.fname 			:= l.name_first;
			 SELF.mname 			:= l.name_middle;
			 SELF.lname 			:= l.name_last;
			 SELF.suffix 			:= l.name_suffix;
			 SELF.ssn 				:= STD.Str.Filter(l.ssn,'0123456789');
			 SELF.did 				:= 0;
			 SELF.prim_range 	:= L.addr2_prim_range;
			 SELF.predir			:= L.addr2_predir;
			 SELF.prim_name		:= L.addr2_prim_name;
			 SELF.addr_suffix	:= L.addr2_suffix;
			 SELF.postdir			:= L.addr2_postdir;
			 SELF.sec_range		:= L.addr2_sec_range;
			 SELF.p_city_name	:= L.addr2_city;
			 SELF.st					:= L.addr2_state;
			 SELF.z5					:= L.addr2_zip;
			 SELF.unit_desig	:= '';
			 SELF.zip4				:= '';
			 SELF := l;
		END;
		recs_addr1 		:= PROJECT(ds_filt, xformAddr1(LEFT));
		recs_addr2 		:= PROJECT(ds_filt(addr2_prim_range <> '' AND addr2_prim_name <> ''), xformAddr2(LEFT));
		recs					:= recs_addr1 + recs_addr2;
		// We don't care about glb,dppa,industry class, app type etc here since we are only getting DIDs 
		//and we are not getting any other BEST info....
		didville_recs	:= didville.did_service_common_FUNCTION(recs, 
																												  glb_flag          := GLB, 
																													glb_purpose_value := in_mod.glb, 
																													include_minors    := TRUE, 
																													appType           := in_mod.application_type,
																													IndustryClass_val := in_mod.industry_class);
		// Don't RETURN DID's whose score < ADL threshold
		adl_best 			:= PROJECT(didville_recs(score >= NAC_V2_Services.Constants.MIN_ADL_SCORE), 
														TRANSFORM(NAC_V2_Services.Layouts.search_layout, 
																		 SELF.did := LEFT.did,
																		 SELF.isDeepDive := TRUE,
																		 SELF.acctno := LEFT.seq,
																		 SELF := []));

		adl_best_DEDUP:= DEDUP(SORT(adl_best,acctno, did),acctno, did);

		// FOR match search do not use records with more than 1 DID found
		adl_best_filt := UNGROUP(HAVING(GROUP(SORT(adl_best_DEDUP, acctno),
		                     acctno),COUNT(ROWS(LEFT)) <= NAC_V2_Services.Constants.MAX_DEEP_DIVE_PER_ACCTNO));
		// Debug
		#IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(recs,NAMED('recs'));
			OUTPUT(didville_recs,NAMED('didville_recs'));
			OUTPUT(adl_best,NAMED('adl_best'));
			OUTPUT(adl_best_filt,NAMED('IdsByAdlBest'));
		#END
		RETURN adl_best_filt;
	END;

	EXPORT IdsByDeepDive(DATASET(NAC_V2_Services.Layouts.process_layout) ds_in, 
											         NAC_V2_Services.IParams.commonParams in_mod) := FUNCTION		
		recs_by_ppl_header 	:= IdsByHeaderLibrary(ds_in, in_mod);
		recs_by_adl_best		:= IdsByAdlBest(ds_in, in_mod);
		deep_dids_final			:= IF(in_mod.InvestigativePurpose, recs_by_ppl_header, recs_by_adl_best);
		// Go look for ids via dids.
		ds_ids_by_did 			:= byDIDs(deep_dids_final(did <> 0));
	
		RETURN ds_ids_by_did;		
	END;

	EXPORT getRecordsByIds(DATASET(NAC_V2_Services.Layouts.search_layout) in_ids,
												 NAC_V2_Services.IParams.CommonParams in_mod) := FUNCTION

	  recs_w_clientId_only := in_ids(in_mod.InvestigativePurpose and client_identifier<>'' and case_identifier='');
		recs_w_caseIds := in_ids - recs_w_clientId_only;

		recs_sccm := JOIN(recs_w_caseIds, NAC_V2.key_SCCM,
								 KEYED(LEFT.state   = RIGHT.case_program_state AND 
											 LEFT.case_identifier = RIGHT.case_identifier) 
											 // Allow investigators to pull all records in a case
								 AND (LEFT.client_identifier = '' OR LEFT.client_identifier = RIGHT.client_identifier),  
								 TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
													 SELF.acctno := LEFT.acctno,
													 SELF.isDeepDive := LEFT.isDeepDive,
													 SELF := RIGHT),
								 LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_RECS_PERID));

		// NAC1 will never hit the SC key since client only inputs are invalid 						 
		recs_sc := JOIN(recs_w_clientId_only, NAC_V2.key_SC,
						 KEYED(LEFT.state = RIGHT.case_Program_State AND
						       // Allow investigators to pull all client records
									 LEFT.client_identifier = RIGHT.client_identifier),
						 TRANSFORM(NAC_V2_Services.Layouts.nac_raw_rec,
											 SELF.acctno := LEFT.acctno,
											 SELF.isDeepDive := LEFT.isDeepDive,
											 SELF := RIGHT),
						 LIMIT(0), KEEP(NAC_V2_Services.Constants.MAX_RECS_PERID));
		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)			 
			OUTPUT(recs_w_clientId_only,NAMED('recs_w_clientId_only'));
		#END
    // we return either recs_sccm or recs_sc. IWO although I did recs_sccm + recs_sc, one of them will be empty.
		RETURN recs_sccm + recs_sc;
	END;

	EXPORT populateExceptions(raw_recs,in_mod) := FUNCTIONMACRO
	IMPORT NAC_V2;
		recs_exceptions := JOIN(raw_recs, NAC_V2.key_Exception,
												 KEYED(in_mod.SourceState      = RIGHT.SourceProgramState AND 
															 LEFT.in_ProgramCode     = RIGHT.SourceProgramCode  AND
															 LEFT.in_clientIdentifier= RIGHT.SourceClientID AND
															 in_mod.NacGroupId       = RIGHT.sourceGroupID AND
															 LEFT.case_program_state = RIGHT.MatchedState AND
															 LEFT.case_program_code  = RIGHT.MatchedProgramCode AND
															 LEFT.client_identifier  = RIGHT.MatchedClientID AND
															 LEFT.nac_groupid        = RIGHT.MatchedGroupID),
												 TRANSFORM(RECORDOF(raw_recs),
																	 SELF.client_exception_reason_code := RIGHT.reasoncode,
																	 SELF.client_exception_comment     := RIGHT.comments,
																	 SELF := LEFT),
														LEFT OUTER,
														LIMIT(0), keep(NAC_V2_Services.Constants.MAX_RECS_EXCEPTIONS));
	  // Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(recs_exceptions,NAMED('recs_exceptions'));
		#END
		RETURN recs_exceptions;
	ENDMACRO;

END;
