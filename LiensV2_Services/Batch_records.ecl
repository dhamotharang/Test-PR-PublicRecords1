IMPORT Autokey_batch, AutokeyB2_batch, BatchServices, 
       FCRA, FFD, LiensV2, LiensV2_Services, ut,
       Suppress;
       
// ***** STRATEGY *****
/* Judgments and Liens records will be retrieved via autokeys and via the Header (getting DIDs and BDIDs. 
	 We'll then union, sort and dedup fromAK and ds_acctnos_and_tmsids_by_did to 
	 get all tmsids and then join against another key to filter based on party_type(s) selected by the customer. 
	 Last, we'll obtain JL records.
	 
	 On both passes we'll filter out any party_types the customer is not interested in. These party_types are 
	 passed in as a formal parameter and applied as a simple filter against the J&L records that the system
	 returns in each of the passes.

   Gotchas: liensv2_services.layout_TMSID and doxie.layout_references_acctno have the same signature, but
	 we use them both here since the functions they call accept a formal parameter of one or the other.
*/
EXPORT Batch_records(DATASET(LiensV2_Services.Batch_Layouts.batch_in) ds_batch_in,
										 LiensV2_Services.IParam.batch_params configData,
										 BOOLEAN isFCRA = FALSE,
										 DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
										 DATASET(FCRA.Layout_override_flag) ds_flags = DATASET([], FCRA.Layout_override_flag)
										 ) := 
	FUNCTION

		TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;
		SET OF STRING1 party_types := configData.party_types;
		ds_batch_in_common 	:= PROJECT(ds_batch_in, Autokey_batch.Layouts.rec_inBatchMaster);	
		
		boolean is_cnsmr := configData.isConsumer();
		boolean is_restricted(boolean cnsmr, string tmsid) := cnsmr AND tmsid[1..2]='CA';	// D2C restrictions			
																									 
		party_key := IF(isFCRA, liensV2.key_liens_party_id_FCRA, liensV2.key_liens_party_id);
		
		// ************************** TMSIDS BY AUTOKEY **************************
		// 1. Search via Autokey
		fromAK := LiensV2_Services.Batch_ids.AutoKeyIds(ds_batch_in_common, party_types);

		// ************************** TMSIDS BY THE HEADER **************************
		// 2. ...search via dids.
		fromDID := LiensV2_Services.Batch_ids.IdsByDID(ds_batch_in_common, ~configData.no_did_append, isFCRA); //no_did_append is equivalent of noDeepDive
		// 3. ...search via bdids.
		fromBDID := LiensV2_Services.Batch_ids.IdsByBDID(ds_batch_in_common, ~configData.no_bdid_append); //no_bdid_append is equivalent of noDeepDive
	  // 4. ...search via LinkIds. JIRA RR-10543
    fromLinkIds := LiensV2_Services.Batch_ids.IdsByLinkId(ds_batch_in, configData);
    
	  // 5. ...combine dids, bdids & LinkIds 
		//    ...if isFCRA only keep the DIDs		
    ds_combined := IF(isFCRA, fromDID, fromDID + fromBDID + fromLinkIds);    
		
		// 6. ...apply D2C restrictions
		ds_combined_restricted := ds_combined(~(is_restricted(is_cnsmr, tmsid)));
		ds_ak_restricted := fromAK(~(is_restricted(is_cnsmr, tmsid)));
		
		// 6. ...filter by party_type
		ds_combined_filtered := 
      JOIN( ds_combined_restricted, party_key,
            KEYED(RIGHT.tmsid = LEFT.tmsid) AND
            ((LEFT.did <> 0 AND(UNSIGNED)RIGHT.did = LEFT.did) 
              OR (LEFT.bdid <> 0 AND (UNSIGNED)RIGHT.bdid = LEFT.bdid)
              OR (LEFT.UltID <> 0 AND RIGHT.UltId = LEFT.UltId )
              ) AND //we either have a DID, BDID or LinkIds on the left side
            RIGHT.name_type[1] IN party_types,
            TRANSFORM(LEFT),
            LIMIT(Batchservices.Constants.JudgementsAndLiens.Join_limit)); //INNER JOIN
                                  
		// ************************************ GET J&L RECORDS ************************************
		// 7. Union, sort, dedup all acctnos and tmsids.
		// if isFCRA skip autokey search
		acctNos 			:= if(isFCRA, ds_combined_filtered, ds_ak_restricted + ds_combined_filtered);											 
		acctNos_final := DEDUP(SORT(acctNos, acctno, tmsid), acctno, tmsid);
		acctNos_grp   := GROUP(project(dedup(sort(acctNos_final, tmsid), tmsid), LiensV2_Services.layout_TMSID), acctno);		//retrieving raw records does not take acctno into account
		

		// 8. Get raw records
		ds_JL_recs_raw := LiensV2_Services.liens_raw.report_view.by_tmsid_batch(acctNos_grp,,isFCRA,,,,
																																						configData.application_type,
																																						false,
																																						ds_slim_pc, configData.FFDOptionsMask);	
		// retrieve acctno
		ds_JL_recs_plus_acctnos :=  JOIN(acctNos_final, ds_JL_recs_raw, 
																		 LEFT.tmsid = RIGHT.tmsid,
																		 TRANSFORM(liensv2_services.layout_lien_rollup,
																							 SELF := LEFT;
																							 SELF := RIGHT),
																		 KEEP(Batchservices.Constants.JudgementsAndLiens.Join_limit));
		
		// 9. apply overrides if isFCRA
		ds_JL_recs_fcra := LiensV2_Services.Functions.fn_applyBatchFcraOverrides(ds_JL_recs_plus_acctnos, 
											 acctNos_final, ds_flags,,ds_slim_pc,configData.FFDOptionsMask);//apply corrections per acctno
		ds_JL_recs := if(isFCRA, ds_JL_recs_fcra, ds_JL_recs_plus_acctnos);
		
		// 10. Apply non subject suppression
		ds_JL_recs_nss_pulled := if(configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.doNothing, 
																ds_JL_recs,
																LiensV2_Services.fn_applyNonSubjectSuppression(ds_JL_recs, project(acctNos_final, LiensV2_Services.layout_ids), configData.non_subject_suppression));
		
		tmp_penalt_layout := record
					unsigned2 penalt;
		end;						
	
		liensv2_services.layout_lien_rollup xfm_penalize_results(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l, 
																			liensv2_services.layout_lien_rollup r) := TRANSFORM																	
			tmp_penalt_dsD := LiensV2_Services.functions.penalt_func_calculate(l,r.debtors);
			tmp_penalt_dsC := LiensV2_Services.functions.penalt_func_calculate(l,r.creditors);
			tmp_penalt_dsA := LiensV2_Services.functions.penalt_func_calculate(l,r.attorneys);										 
			tmp_penalt_dsT := LiensV2_Services.functions.penalt_func_calculate(l,r.thds);		
			SELF.penalt 	 := IF(isFCRA, 0, MIN(PROJECT(tmp_penalt_dsD + tmp_penalt_dsC +
																									tmp_penalt_dsA + tmp_penalt_dsT, tmp_penalt_layout), penalt));
			SELF.acctno 	 := l.acctno;
      SELF        	 := r;
		END;
	
		ds_JL_recs_slim := dedup(sort(ds_JL_recs_nss_pulled, tmsid), tmsid);
	 
		// 11. Penalize.
		ds_batch_in_with_tmsIds := join(acctNos_final, ds_batch_in,
																		left.acctno = right.acctno,
																		transform(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid,
																							self := left,
																							self := right																			
																							));
		// there may be multiple tmsid per acctno and penalty needs to be calculated for each tmsid record
		ds_JL_recs_penalt := join(ds_batch_in_with_tmsIds, ds_JL_recs_slim,
															left.tmsid = right.tmsid,																							
															xfm_penalize_results(LEFT, RIGHT),
															limit(Batchservices.Constants.JudgementsAndLiens.Join_limit, skip));
		
		// if isFCRA no penalt calculations 
		ds_JL_recs_penalt_slim := if(isFCRA, ds_JL_recs_nss_pulled, ds_JL_recs_penalt(penalt <= configData.penaltthreshold));
		
		// 12. Put in match codes here.		
		ds_JL_recs_unmatched := LiensV2_Services.Functions.fn_addMatchcodes(ds_JL_recs_penalt_slim, ds_batch_in, configData);
		
		// return records with TOO_MANY_MATCHES failed status from AK
		too_many := ds_ak_restricted(search_status = TOO_MANY_MATCHES);
		
		too_many_w_error_code := PROJECT(too_many, TRANSFORM(LiensV2_Services.Batch_Layouts.int_layout_error_match_codes,
																												 SELF.error_code := LEFT.search_status,
																												 SELF.acctno := LEFT.acctno,
																												 SELF := []
																												 ));

		ds_JL_recs_trimmedTmp := ds_JL_recs_unmatched(matches);
		ds_JL_recs_final := PROJECT(ds_JL_recs_trimmedTmp,
																TRANSFORM(LiensV2_Services.Batch_Layouts.int_layout_error_match_codes,
																					SELF.error_code := 0;
																					SELF := LEFT));
					
		// combine
		ds_results := ds_JL_recs_final + too_many_w_error_code;
    
// DEBUG 
//output(ds_batch_in_common,named('ds_batch_in_common'));
//output(ds_JL_recs_raw,named('ds_JL_recs_raw'));
//output(ds_results,named('ds_results'));

		RETURN ds_results;
		
END;
	

// NOTES: 
// party_type is '' by default, returning all possible records. But, it may be 'A' for Attorney,
// 'C' for Creditor/Secured Party, or 'D' for Debtor.
	