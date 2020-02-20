IMPORT Autokey_batch, AutoStandardI, BatchServices, Doxie, ut, dx_Header;

penalize_fullname(Autokey_batch.Layouts.rec_inBatchMaster l, BatchServices.Layouts.OthersUsingSSN.rec_results_raw r) :=
	FUNCTION				

		fullnames_to_compare :=  
			MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))	
					// the 'input' name
				EXPORT lastname       := l.name_last;       
				EXPORT middlename     := l.name_middle; 
				EXPORT firstname      := l.name_first;      
					// the name in the matching record
				EXPORT allow_wildcard := FALSE;
				EXPORT lname_field    := r.lname;
				EXPORT mname_field    := r.mname; 
				EXPORT fname_field    := r.fname; 						
			END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(fullnames_to_compare);

	END;
	
penalize_fullname_ne(Autokey_batch.Layouts.rec_inBatchMaster l, BatchServices.Layouts.OthersUsingSSN.rec_results_raw r) :=
	FUNCTION				

		fullnames_to_compare :=  
			MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))	
					// the 'input' name
				EXPORT lastname       := l.name_last;       
				EXPORT middlename     := l.name_middle; 
				EXPORT firstname      := l.name_first;      
					// the name in the matching record
				EXPORT allow_wildcard := FALSE;
				EXPORT lname_field    := r.lname;
				EXPORT mname_field    := r.mname; 
				EXPORT fname_field    := r.fname; 						
			END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(fullnames_to_compare);

	END;
	
EXPORT OthersUsingSSN_BatchService_Records(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster),
                                           BOOLEAN return_subject_also) := FUNCTION

		ds_batch_in_with_ssn    := ds_batch_in(TRIM(ssn) != '');
		ds_batch_in_with_no_ssn := ds_batch_in(TRIM(ssn) = '');
		
		gm := AutoStandardI.GlobalModule();

		// 2. Get DIDs for each input record. At this point, we're splitting the input batch into two types
		// of input: records having SSNs and those not having SSNs. For those records NOT having SSNs, we want 
		// to resolve to one DID. If it doesn't resolve to one DID, don't evaluate the record. However, we 
		// want to evaluate all input records containing SSNs, whether that SSN resolves to one DID or more.
		ds_acctnos_and_dids_having_ssn := 
		     BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_with_ssn);

		ds_acctnos_and_dids_not_having_ssn := 
		     BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_with_no_ssn);

		// ... Have any acctnos having no SSN resolved to more than one DID? Remove them.
		tbl_count_acctnos := TABLE( ds_acctnos_and_dids_not_having_ssn, {acctno, cnt := COUNT(GROUP)}, acctno );
		ds_acctnos_and_dids_unique := 
		                JOIN(ds_acctnos_and_dids_not_having_ssn, tbl_count_acctnos,
		                     LEFT.acctno = RIGHT.acctno AND RIGHT.cnt < 2,
		                     TRANSFORM(LEFT), INNER, LIMIT(BatchServices.Constants.OTHERS_USING_SSN_JOIN_LIMIT));

		// .. Union, sort, dedup all acctnos and DIDs.
		ds_all_acctnos_and_dids := DEDUP(SORT( (ds_acctnos_and_dids_unique + ds_acctnos_and_dids_having_ssn), 
		                                       acctno, did), 
		                                 acctno, did);

		// 3. Find best SSN for each input record.		
		dids := dedup(sort(project(ds_all_acctnos_and_dids, doxie.layout_references), did), did);
		
		doxie.mac_best_records(dids, did, best_recs_ssn, true, ut.glb_ok(gm.GLBPurpose), , doxie.DataRestriction.fixed_DRM);	
		
		ds_best_ssns := join(ds_all_acctnos_and_dids, best_recs_ssn,
												 left.did = right.did,
												 TRANSFORM({doxie.layout_references_acctno, STRING9 ssn, STRING1 valid_ssn},
												            SELF.ssn 			 := RIGHT.ssn,
																		SELF.valid_ssn := RIGHT.valid_ssn,
																		SELF    			 := LEFT));

		// 4. Find DIDs of other people using the same SSN.
		ds_other_people_using_same_ssn := 
										JOIN(ds_best_ssns, dx_Header.key_SSN(),
												 KEYED(RIGHT.s1 = LEFT.ssn[1]) AND
												 KEYED(RIGHT.s2 = LEFT.ssn[2]) AND
												 KEYED(RIGHT.s3 = LEFT.ssn[3]) AND
												 KEYED(RIGHT.s4 = LEFT.ssn[4]) AND
												 KEYED(RIGHT.s5 = LEFT.ssn[5]) AND
												 KEYED(RIGHT.s6 = LEFT.ssn[6]) AND
												 KEYED(RIGHT.s7 = LEFT.ssn[7]) AND
												 KEYED(RIGHT.s8 = LEFT.ssn[8]) AND
												 KEYED(RIGHT.s9 = LEFT.ssn[9]),
												 TRANSFORM( {doxie.layout_references_acctno, STRING9 ssn, STRING1 valid_ssn, UNSIGNED6 other_did},
																		SELF.other_did := RIGHT.did,
																		SELF       := LEFT),
												 INNER, KEEP(BatchServices.Constants.OTHERS_USING_SSN_JOIN_KEEP_VAL));

		ds_others_sorted := SORT(ds_other_people_using_same_ssn, acctno, other_did,-(VALID_SSN = 'G'));
		ds_others_deduped := DEDUP(ds_others_sorted, acctno, other_did);

		// 5. Get personal information of everyone gathered so far. Per Product's request, penalize names of
		// all matching entities and then sort by penalty in order to list same or similar names first in the 
		// final output.
		matching_other_dids := dedup(sort(ds_others_deduped, other_did), other_did);

		matching_dids := project(matching_other_dids, transform(doxie.layout_references, self.did := left.other_did));
		doxie.mac_best_records(matching_dids, did, best_recs_results, true, ut.glb_ok(gm.GLBPurpose), , doxie.DataRestriction.fixed_DRM);

		ds_results0 := JOIN(matching_other_dids, best_recs_results,
		                   LEFT.other_did = RIGHT.did,
		                   TRANSFORM( BatchServices.Layouts.OthersUsingSSN.rec_results_raw,
											            SELF.did       := LEFT.did,
		                              SELF.acctno    := LEFT.acctno,
		                              SELF.other_did := RIGHT.did,
																	SELF.penalt    := 0,
		                              SELF           := RIGHT));
											 
		ds_results := JOIN(ds_batch_in, ds_results0,
			                 LEFT.acctno = RIGHT.acctno,
			                 TRANSFORM( {BatchServices.Layouts.OthersUsingSSN.rec_results_raw, Boolean subject_flag},
																	SELF.penalt := penalize_fullname(LEFT,RIGHT),
																	SELF.subject_flag := LEFT.did  = RIGHT.other_did OR 
																											 RIGHT.ssn = LEFT.ssn AND LEFT.did = 0 AND RIGHT.valid_ssn = 'G';
																	SELF        := RIGHT));
				
		ds_results_sorted  := SORT(ds_results(other_did != 0), acctno, penalt, -subject_flag);
		ds_results_grouped := GROUP(ds_results_sorted, acctno);
		subject_filter 		 := IF( return_subject_also,  
														  ds_results_grouped,
														  ds_results_grouped(subject_flag != true)
														 );
		ds_final_recs := PROJECT(subject_filter, BatchServices.Layouts.OthersUsingSSN.rec_results_raw);						
		ds_results_rolled_flat := ROLLUP(ds_final_recs, GROUP, xfm_OthersUsingSSN_make_flat(LEFT,ROWS(LEFT))); 

		RETURN ds_results_rolled_flat;
END;
