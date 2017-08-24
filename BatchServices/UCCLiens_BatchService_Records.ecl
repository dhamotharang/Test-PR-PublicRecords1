
IMPORT AutokeyB2, Autokey_batch, UCCV2, UCCV2_Services, batchservices, autostandardi, BIPV2;

rec_acctno_tmsid := RECORD
	STRING30 acctno;
	UCCv2_Services.layout_tmsid; // i.e. just tmsid
END;

rec_acctno_tmsid_rmsid := RECORD
	STRING30 acctno;
	UCCv2_Services.layout_rmsid; // i.e. tmsid and rmsid
	BIPV2.IDlayouts.l_key_ids_bare;
END;

rec_UCCs_slim := RECORD
	STRING30 acctno;
	UCCV2.Layout_UCC_Common.Layout_ucc_new;
END;


fn_convert_to_yyyymmdd(STRING10 date_value) :=
	FUNCTION
		searchpattern := '^(.*)/(.*)/(.*)$';
		RETURN REGEXFIND(searchpattern, date_value, 3) + // i.e. '1968' in '10/12/1968'
		       REGEXFIND(searchpattern, date_value, 1) + // i.e. '10' in '10/12/1968'
		       REGEXFIND(searchpattern, date_value, 2);  // i.e. '12' in '10/12/1968'
	END;
	

// The following function performs the majority of post-filtering chores on a slim result set of UCC Liens.
//
// BUSINESS RULES:
//
// Per R.M., only California supplies a filing_status at all for their UCC Liens. So, if the job specifies
// a state besides CA and a particular filing_status, there will be zero matches. We need to ignore a valid 
// filing_status in such cases and filter rather on the state.
//
// if filing_jurisdiction != CA, then filter only on filing_jurisdiction, ignoring filing_status
// if filing_jurisdiction  = CA, then filter both on filing_jurisdiction and filing_status
// if filing_jurisdiction  = '', then filter only on filing_status
//
// Moreover, per R.M., 'amount' does not appear in any UCC Lien file.  They only appear in IL Federal Tax Liens.
// So, at this juncture, even though 'amount' is specified as a filter criterion in the product spec, we'll 
// ignore it as such. TODO: Get 'amount' removed as a requirement by Product Management.
//
fn_filter_UCC_recs(BatchServices.Interfaces.UCCV2.i_Query_Filters filters,
                          DATASET(rec_UCCs_slim) ds_recs) := 
	FUNCTION
	  // Modified to switch all IF statements to MAP statements, a performance boost of approx 30% was realized.
	  // Additional filters: min_date, max_date, filing_status_desc, state, amount, collateral, and debtor_zip.

		// Filter on the easy/inexpensive things in one expression.
		ds_recs_filtered1 := ds_recs(orig_filing_date >= fn_convert_to_yyyymmdd(filters.min_date)      AND
		                             orig_filing_date <= fn_convert_to_yyyymmdd(filters.max_date)      AND
		                             REGEXFIND(TRIM(filters.filing_jurisdiction), filing_jurisdiction));
																 
		// Filter on filing_status based on the rules described above.
		ds_recs_filtered2 := MAP( TRIM(filters.filing_jurisdiction) NOT IN ['CA', Constants.MATCH_ANYTHING] => ds_recs_filtered1,
		                                           ds_recs_filtered1(REGEXFIND(TRIM(filters.filing_status_desc), TRIM(status_type)))
													);
		// Filtering on Collateral can be potentially costly in terms of performance. Use a conditional.
		ds_filtered_on_collateral := MAP(  filters.collateral = Constants.MATCH_ANYTHING => ds_recs_filtered2,
				                             ds_recs_filtered2(REGEXFIND(TRIM(filters.collateral), collateral_desc))
                                    );
		
		// And finally, filter on the Debtor Zip code, if it exists, using a join to the UCCV2 Party key.
		ds_filtered_on_debtor_zip := MAP ( filters.debtor_zip = Constants.MATCH_ANYTHING => ds_filtered_on_collateral,
		                                   JOIN(ds_filtered_on_collateral, UCCV2.Key_Rmsid_Party (),
		                                      KEYED(RIGHT.tmsid = LEFT.tmsid) AND 
		                                        KEYED(RIGHT.rmsid = LEFT.rmsid) AND
		                                        RIGHT.party_type = 'D' AND // 'D' for Debtor, right? I hope so....
		                                        RIGHT.Orig_zip5 = filters.debtor_zip[1..5],
		                                      TRANSFORM(rec_UCCs_slim, SELF := LEFT;),
																					INNER,LIMIT(Batchservices.Constants.UCCLiens.JOIN_LIMIT, SKIP))
		                                 );

		RETURN ds_filtered_on_debtor_zip;

	END;
	
	
EXPORT UCCLiens_BatchService_Records(DATASET(BatchServices.Layouts.ucc.batch_in) ds_batch_in = DATASET([],BatchServices.Layouts.ucc.batch_in),
																		 BatchServices.Interfaces.UCCV2.i_Query_Filters filters,
                                     BOOLEAN current_job_has_addl_search_filters = FALSE,
																		 BOOLEAN useCannedRecs = FALSE,
																		 BOOLEAN Return_Current_Only = FALSE,
																		 STRING BIPFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID
																		) := FUNCTION

		// UNSIGNED1 DPPA_Purpose  := 1     : STORED('DPPAPurpose');
		// UNSIGNED1 GLB_Purpose   := 8     : STORED('GLBPurpose');
		UNSIGNED4 Max_Results   := 10000 : STORED('MaxResults');	

		/* ***** System flags and values ***** */
		BOOLEAN forceSeqNumber   := TRUE;
		//INTEGER pt               := 20 : STORED('PenaltThreshold');
		STRING  in_ssn_mask_type := '';
		
		// 1. Define values for obtaining autokeys and payloads.	
		constants  := UCCV2.Constants(UCCv2.Version.key);
		ak_keyname := constants.ak_keyname;
		ak_dataset := UCCV2.file_SearchAutokey;
		ak_typeStr := constants.ak_typeStr;
		
		// 2. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			//export PenaltThreshold := 20;
			export skip_set        := auto_skip;
		END;

		// 4. Get autokeys based on batch input.
		ak_batch_in := PROJECT(ds_batch_in,TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,SELF := LEFT));
		
		ds_fids := Autokey_batch.get_fids(ak_batch_in, ak_keyname, ak_config_data);
		
		// 5. Get tmsids and rmsids...		
		
		//   .. via autokey payloads.
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outPLfat, did, bdid, ak_typeStr )
		
		//   .. and via filing_number.
		ds_tmsids_from_filing_no := JOIN(ak_batch_in, UCCV2.Key_filing_number,
		                                 LEFT.filing_number = RIGHT.filing_number,
		                                 INNER,LIMIT(Batchservices.Constants.UCCLiens.JOIN_LIMIT, SKIP));
			// 5.5 get recs from matching did
						
			ds_acctnos_and_dids := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ak_batch_in);
											
			ds_from_did := join( ds_acctNos_and_dids,
			                      UCCV2.Key_Did,
			                    keyed(left.did = right.did),
														transform ( rec_acctno_tmsid_rmsid,
															 self.acctno := left.acctno,
															 self := right, // sets tmsid and rmsid
															 self := []), limit(Batchservices.Constants.UCCLiens.DID_JOIN_LIMIT, skip));
													
      ds_did_set := if (ak_config_data.RunDeepDive, ds_from_did);		
													
			// 5.6 get tmsids from linkids
			// Fetch Lien data and exclude assignee party types	
			ds_linkIds := PROJECT(ds_batch_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
			ds_from_linkids := PROJECT(UCCv2.Key_LinkIds.kFetch2(ds_linkIds,bipFetchLevel)(party_type[1] != 'A'),
															 TRANSFORM(rec_acctno_tmsid_rmsid,
																					SELF.acctno := '',
																					SELF := LEFT));
		
		  // Add back acctno 
			ds_tmsids_linkids := JOIN(ds_from_linkids,ds_batch_in,
																LEFT.UltID = RIGHT.UltID AND
																(LEFT.OrgID = RIGHT.OrgID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_OrgID) AND
																(LEFT.SeleID = RIGHT.SeleID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_SELEID) AND
																(LEFT.ProxID = RIGHT.ProxID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_ProxID) AND
																(LEFT.PowID = RIGHT.PowID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_PowID) AND
																(LEFT.EmpID = RIGHT.EmpID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_EmpID) AND
																(LEFT.DotID = RIGHT.ProxID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_DotID),
																TRANSFORM(rec_acctno_tmsid_rmsid,
																							SELF.acctno := RIGHT.acctno,
																							SELF := LEFT));
																		
		// 6. Slim both datasets of tmsids to just what's needed for matching (i.e. acctnos, tmsids and rmsids). 
		// Then union, sort and dedup.
		ds_tmsids_and_rmsids_from_filing_no  := PROJECT(ds_tmsids_from_filing_no, TRANSFORM(rec_acctno_tmsid_rmsid,SELF := LEFT, SELF :=[]));		
		ds_tmsids_and_rmsids_from_ak_payload := PROJECT(outPLfat, TRANSFORM(rec_acctno_tmsid_rmsid,SELF := LEFT, SELF :=[]));				
		ds_acctnos_tmsids_and_rmsids         := SORT(ds_tmsids_and_rmsids_from_filing_no  
		                                             + ds_tmsids_and_rmsids_from_ak_payload
																								 + ds_did_set + ds_tmsids_linkids,
																					       acctno, tmsid, rmsid); 
		
		ds_acctnos_tmsids_and_rmsids_deduped := DEDUP(ds_acctnos_tmsids_and_rmsids, acctno, tmsid, rmsid);  // Dedup, keeping the most recent recs for a tmsid.
		
		
		// 7. Match ds_acctnos_tmsids_and_rmsids_deduped against a slim UCC key and apply filters. After 
		// filters are applied, the remaining records will be used to get the more expensive UCC records. 
		// BE SURE to use non-deduped (ds_acctnos_tmsids_and_rmsids), since certain rmsids will contain 
		// the information the filters will match against.
		ds_rmsid_main_recs := JOIN(ds_acctnos_tmsids_and_rmsids, UCCV2.Key_Rmsid_Main (),
		                           LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid,
															 TRANSFORM(rec_UCCs_slim, SELF := LEFT; SELF := RIGHT;),
		                           INNER,LIMIT(Batchservices.Constants.UCCLiens.JOIN_LIMIT, SKIP));

		// Sort and dedup to keep the most recent filing per tmsid.
		ds_rmsid_main_recs_dedup := DEDUP(SORT(ds_rmsid_main_recs,tmsid,-filing_date,-filing_number,filing_type),tmsid);
		
		// Use a conditional to determine whether there are any addtional filtering criteria at all. If not, 
		// let's save the CPU some work. 
		// Modified to use MAP instead of IF, testing resulted in performance boost.
		ds_rmsid_main_recs_filtered := MAP(NOT(current_job_has_addl_search_filters) => ds_rmsid_main_recs_dedup,
																																									fn_filter_UCC_recs(filters, ds_rmsid_main_recs_dedup));	
																																									
		
		// Since the function we'll be using to obtain the more comprehensive records no longer performs
		// the fetch based on the rmsid--just the tmsid--we'll sort and dedup only on the tmsid here.
		ds_rmsid_main_recs_filtered_and_deduped := DEDUP(SORT(ds_rmsid_main_recs_filtered, tmsid), tmsid);											 
		
		// 8. Finally, obtain matching domain-specific, fat records we want via a ready-made function. 
		// NOTE: This function no longer searches by rmsid, despite its name. It searches by TMSID only.
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		ds_UCC_recs := UCCv2_Services.UCCRaw.source_view.by_rmsid( PROJECT(ds_rmsid_main_recs_filtered_and_deduped, 
		                                                           UCCv2_services.layout_rmsid), in_ssn_mask_type,,appType);
						
		// 9. Join all of the fat UCC records retrieved against the slimmer, filtered set from above to get
		// a filtered set of the fat ones.
		ds_UCC_recs_filtered := JOIN(ds_ucc_recs, ds_rmsid_main_recs_filtered_and_deduped,
		                             LEFT.tmsid = RIGHT.tmsid,
		                             TRANSFORM(uccv2_services.layout_ucc_rollup_src, SELF := LEFT;),
		                             INNER);
																 
   // 9.5 filter out the 'current only recs' if this soap field is set
	 
	  //ds_UCC_recs_filtered_currentOnly := 
		ds_UCC_recs_filtered_currentOnly := if (Return_Current_Only,
		                                         ds_UCC_recs_filtered(
		                                           NOT exists(filing_status(trim(filing_status, left, right) = 'L'))
																							   // above condition is for non d & b data. L stands for Lapsed i.e. not active 
																								 // and the "L" field is only in the CA data.
		                                              AND 																																											
		                                           NOT exists(filings(trim(filing_type, left, right) = 'TERMINATION'))
																							 // above condition is for D & B data
																							    AND
																							 NOT exists(filing_status(trim(filing_status_desc, left, right) = 'TERMINATED')) 
																							 // this is for TX data
																			
																					  ),
																						ds_UCC_recs_filtered);
		                                     																				                     		                                    				
		// 9.75 penaltize here before flat but after filter on current only.
		
		 ds_acctnos_and_tmsids := DEDUP(PROJECT(ds_acctnos_tmsids_and_rmsids_deduped, rec_acctno_tmsid), tmsid);
		 // ds_acctnos_and_tmsids := DEDUP(PROJECT(ds_UCC_recs_filtered_currentOnly, rec_acctno_tmsid), tmsid);
		
		ds_batch_in_with_tmsids := JOIN(ds_acctnos_and_tmsids, ds_batch_in,
		                                LEFT.acctno = RIGHT.acctno,
																		TRANSFORM( BatchServices.layouts.ucc.rec_autokey_batch_tmsid,
																		           //{RECORDOF(ds_batch_in), rec_acctno_tmsid AND NOT acctno},																																			
																		           SELF := LEFT,
																							 SELF := RIGHT),
																		INNER);
    tmp_penalt_layout := record
				    unsigned2 penalt;
			end;																			
		
		BatchServices.layouts.ucc.rec_ucc_rollup_src_acctno
		              xfm_penalize_results( BatchServices.layouts.ucc.rec_autokey_batch_tmsid l, 
		                                    uccv2_services.layout_ucc_rollup_src r) := TRANSFORM
								
					      penalt_d := BatchServices.functions.UCC.penalt_func_calculate(l,r.debtors);
							  penalt_S := BatchServices.functions.UCC.penalt_func_calculate(l,r.secureds);
							  penalt_A := BatchServices.functions.UCC.penalt_func_calculate(l,r.assignees);
							  penalt_C := BatchServices.functions.UCC.penalt_func_calculate(l,r.creditors);							
								self.penalt := min(project(penalt_D + penalt_S +
			                           penalt_A + penalt_C, tmp_penalt_layout), penalt);
																 
						   	SELF.acctno := l.acctno;
								SELF        := r;
		END;
		
		ds_UCC_recs_rejoined_with_penalty := JOIN(ds_batch_in_with_tmsids, ds_UCC_recs_filtered_currentOnly,
		                             LEFT.tmsid = RIGHT.tmsid,
																 xfm_penalize_results(LEFT, RIGHT),
																 INNER,limit(Batchservices.Constants.UCCLiens.JOIN_LIMIT, skip));
																 
		ds_ucc_recs_filtered_by_penalty := 
			ds_UCC_recs_rejoined_with_penalty(penalt <= ak_config_data.penaltThreshold );

		// 10. Sort by acctno and then by date of the most recent filing, descending. Of the various filing 
		// records that are associated with a UCC Lien, from filing_1_filing_date to filing_N_filing_date, 
		// filing_1_filing_date is always the most recent. But, it's not always present.		
		ds_UCC_recs_sorted := 
			SORT(
				ds_ucc_recs_filtered_by_penalty, 
				acctno, 
				-( MAX( (UNSIGNED)filings[1].filing_date, (UNSIGNED)orig_filing_date ) )
			);
		
		ds_UCC_recs_grouped := GROUP(ds_UCC_recs_sorted, acctno);
		
		ds_top_ucc_recs := TOPN(ds_UCC_recs_grouped, filters.max_results_per_acct, acctno);
		
		// 11. Flatten and then join back to acctno.
		ds_results := PROJECT(ds_top_ucc_recs, BatchServices.xfm_UCCLiens_make_flat(LEFT));		

    // output(ds_UCC_recs_filtered,named('ds_UCC_recs_filtered'));
		 // output(ds_UCC_recs_filtered_currentonly,named('ds_UCC_recs_filtered_currentonly'));
		//output(ds_recs_with_sortby_date,named('ds_recs_with_sortby_date'));
		// output(ds_UCC_recs,named('ds_UCC_recs'));
		//output(ds_UCC_recs, named('ds_UCC_recs'));
		 // output(ds_did_set, named('ds_did_set'));
		//  output(ds_UCC_recs_rejoined_with_penalty, named('ds_UCC_recs_rejoined_with_penalty'));
		//  output(ds_ucc_recs_rejoined_with_penalty_slim_sorted, named('ds_ucc_recs_rejoined_with_penalty_slim_sorted'));
		 
		// output(ds_batch_in_with_tmsids , named('ds_batch_in_with_tmsids'));
		
		RETURN ds_results;
		
END;




/* ***************************** JUNK ****************************** */

		// Debug: view the parties retrieved if you need to.
//		ds_parties := JOIN(ds_rmsid_main_recs_filtered, UCCV2.Key_Rmsid_Party,
//		                   KEYED(RIGHT.tmsid = LEFT.tmsid) AND 
//		                   KEYED(RIGHT.rmsid = LEFT.rmsid) AND
//		                   RIGHT.party_type = 'D',
//											 TRANSFORM(UCCV2.Layout_UCC_Common.Layout_Party, SELF := RIGHT;), 
//											 INNER);
