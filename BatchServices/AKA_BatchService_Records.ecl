IMPORT Autokey_batch, AutoStandardI, BatchServices, Doxie; 

penalize_name_ssn(Autokey_batch.Layouts.rec_inBatchMaster l, BatchServices.Layouts.AKAs.rec_results_temp r) :=
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
			
		ssns_to_compare :=  
			MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_SSN.full, opt))
				// the 'input' ssn
				EXPORT ssn        := l.ssn;
				
				// the ssn in the matching record
				EXPORT allow_wildcard := FALSE;
				EXPORT ssn_field      := r.ssn;
			END;		
		
		RETURN (AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(fullnames_to_compare) +
						AutoStandardI.LIBCALL_PenaltyI_SSN.val(ssns_to_compare));
	END;


EXPORT AKA_BatchService_Records(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster), 
                                UNSIGNED1 did_limit = 0) := FUNCTION

    // Set an adjusted did_limit to 1 just in case it gets accidently input as 0
    did_limit_adjusted := if(did_limit=0,1,did_limit);

		// 2a. Get the DID for each input record.
		ds_acctnos_and_dids1 := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in);

		// 2b.  Check for any acctnos with no dids found.
		// Use left only join to join the original input dataset with the dataset out of 
		// functions above to find which acctnos did not return a did.
		// Then use transform to blank out address search data so can try it again.
		ds_batch_in_no_hit := join (ds_batch_in,ds_acctnos_and_dids1,
		                            LEFT.acctno = RIGHT.acctno,
																TRANSFORM(recordof (ds_batch_in),
																	    SELF.prim_range  := ' ',
																			SELF.predir      := ' ',
																	    SELF.prim_name   := ' ',
																	    SELF.addr_suffix := ' ',
																			SELF.postdir     := ' ',
																	    SELF.unit_desig  := ' ',
																			SELF.sec_range   := ' ',
																	    SELF.p_city_name := ' ',
																	    SELF.st          := ' ',
																	    SELF.z5          := ' ',
																	    SELF.zip4        := ' ',
																			SELF := LEFT),
																LEFT ONLY);
	
		// 2c. If any acctnos had no dids, get the DID using the revised input records.
		ds_acctnos_and_dids2 := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_no_hit);

    // 2d. Combine the acctnos/dids from 2a & 2c above.
    ds_acctnos_and_dids := ds_acctnos_and_dids1 + ds_acctnos_and_dids2;

		// 2e. Have any acctnos resolved to more than the parmed in did limit? 
		// If so, remove them; too ambiguous.
		tbl_count_acctnos := TABLE( ds_acctnos_and_dids, {acctno, cnt := COUNT(GROUP)}, acctno );
		ds_acctnos_and_dids_unique := JOIN(ds_acctnos_and_dids, tbl_count_acctnos,
																			 LEFT.acctno = RIGHT.acctno AND RIGHT.cnt <= did_limit_adjusted,
																			 TRANSFORM(LEFT), INNER);

    // 3a. strip acctno off to create a ds of just dids to pass into doxie.header_records_byDID
		ds_target_dids := project(ds_acctnos_and_dids_unique,
		                          TRANSFORM(doxie.layout_references_hh,
															          SELF :=LEFT));

		// 3b. Get all the appropriate header records for the dids.
		ds_hdr_recs_for_dids := doxie.header_records_byDID(dids := ds_target_dids, include_dailies := false, allow_wildcard := false, ReturnLimit := 25000);
		
		// 3c. Join back to get acctnos for dids along with a transform using a slimmed 
		// record layout to just pull off the fields needed for sorting or output and 
		// also calculating the penalty for the records based upon the input name.
    ds_all_recs_for_dids_pre := JOIN(ds_acctnos_and_dids_unique, ds_hdr_recs_for_dids,
		                            LEFT.did = RIGHT.s_did,
																TRANSFORM(BatchServices.Layouts.AKAs.rec_results_temp,
																	SELF.acctno      := LEFT.acctno,
																	SELF.dob         := if(RIGHT.dob=0,'',(string8) RIGHT.dob),
																	// Fix bad suffixes (UNK, UN1, UN2, etc.) on some header file recs
																	SELF.name_suffix := if(RIGHT.name_suffix[1..1]='U','',RIGHT.name_suffix),
																	// Match acctno to batch_in ds to get the input name parts for penalty checking
		                              SELF.penalt      := 0;
																	SELF             := RIGHT),
																LIMIT(BatchServices.Constants.AKA_JOIN_LIMIT));
		
		// 3.d. SORT-DEDUP to reduce the number of intermediate records and forestall possible memory issues.
		// See Bug 111371.
		ds_all_recs_for_dids := 
			DEDUP( 
				SORT( 
					ds_all_recs_for_dids_pre, 
					did, acctno, ssn, dob, lname, fname, mname, name_suffix, -dt_last_seen
				),
				did, acctno, ssn, dob, lname, fname, mname, name_suffix
			);
		
		// 3d. Penalize. See Bug 41795.
		ds_all_recs_w_penalty := JOIN(ds_batch_in, ds_all_recs_for_dids,
		                            LEFT.acctno = RIGHT.acctno,
																TRANSFORM(BatchServices.Layouts.AKAs.rec_results_temp,
		                              SELF.penalt      := penalize_name_ssn(LEFT,RIGHT);
																	SELF             := RIGHT)); 
		
		// 3e. Filter out dids with penalty > 10 (current value in Constants),
		// then sort/dedup on did.
		ds_dids_pen_deduped := dedup(sort(ds_all_recs_w_penalty(penalt <= BatchServices.Constants.AKA_PENALTY_LIMIT),
		                                  did),
															   did); 
		
		// 3f. Rejoin resulting dids back to ds_all_recs_for_dids to get all recs for the dids
		// that are lower than the penalty limit
		ds_all_recs_after_pen := JOIN(ds_dids_pen_deduped, ds_all_recs_for_dids,
		                            LEFT.did = RIGHT.did,
																TRANSFORM(BatchServices.Layouts.AKAs.rec_results_temp,
																	SELF := RIGHT),
																LIMIT(BatchServices.Constants.AKA_JOIN_LIMIT)); 
		
		// 4a. First sort on acctno, name parts and descending on date-last-seen to get the 
		// latest record for each name variation to sort first.
		// Next, dedupe on acctno and name parts to get only 1 rec for each name variation.
	  //ds_all_recs_sorted := DEDUP(SORT(ds_all_recs_for_dids,
		ds_all_recs_sorted := DEDUP(SORT(ds_all_recs_after_pen,
		                                 acctno,lname,fname,mname,name_suffix,-dt_last_seen),         
                                acctno,lname,fname,mname,name_suffix);
		
    // 4b. Do a join to remove any name variation that exactly matches the input name.
		ds_all_recs_filtered := JOIN(ds_all_recs_sorted,ds_batch_in,
		                                      LEFT.acctno = RIGHT.acctno AND 
																					LEFT.fname       = RIGHT.name_first AND
																					LEFT.mname       = RIGHT.name_middle AND
																					LEFT.lname       = RIGHT.name_last AND 
																					LEFT.name_suffix = RIGHT.name_suffix,
																	TRANSFORM(LEFT), 
																	LEFT ONLY);
		
		// 4c. Re-sort to put names back in descending date-last-seen order. Then Group, Topn,
		// flatten and return.
	  ds_top_recs := TOPN( GROUP( SORT(ds_all_recs_filtered,acctno,-dt_last_seen), acctno ), 20, acctno );
		
		ds_results_rolled_flat := ROLLUP(ds_top_recs, GROUP, xfm_AKA_make_flat(LEFT,ROWS(LEFT)));

    // Uncomment lines below as needed for debugging
		// OUTPUT(ds_batch_in_raw, NAMED('akabsr_ds_batch_in_raw'));
		// OUTPUT(ds_batch_in, NAMED('akabsr_ds_batch_in'));
		// OUTPUT(ds_batch_in_no_hit, NAMED('akabsr_ds_batch_in_no_hit'));
		// OUTPUT(ds_acctnos_and_dids1,named('akabsr_ds_acctnos_and_dids1'));
		// OUTPUT(ds_acctnos_and_dids2,named('akabsr_ds_acctnos_and_dids2'));
		// OUTPUT(ds_acctnos_and_dids,named('akabsr_ds_acctnos_and_dids'));
		// OUTPUT(tbl_count_acctnos,named('akabsr_ds_tbl_count_acctnos'));
    // OUTPUT(ds_acctnos_and_dids_unique,named('akabsr_ds_acctnos_and_dids_unique'));
		// OUTPUT(ds_target_dids,named('akabsr_ds_target_dids'));
		// OUTPUT(ds_hdr_recs_for_dids,named('akabsr_ds_hdr_recs_for_dids'));
    // OUTPUT(ds_all_recs_for_dids,named('akabsr_ds_all_recs_for_dids'));
		// OUTPUT(ds_dids_pen_deduped,named('akabsr_ds_dids_pen_deduped'));
		// OUTPUT(ds_all_recs_after_pen,named('akabsr_ds_all_recs_after_pen'));
		// OUTPUT(ds_all_recs_sorted,named('akabsr_ds_all_recs_sorted'));
		// OUTPUT(ds_all_recs_filtered,named('akabsr_ds_all_recs_filtered'));
		// OUTPUT(ds_results_rolled_flat,named('akabsr_ds_results_rolled_flat'));
		
		RETURN ds_results_rolled_flat;

END;
