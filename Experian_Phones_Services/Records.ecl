
IMPORT BatchServices, Experian_Phones, Gateway, MDR, Progressive_Phone, Royalty, Standard;

EXPORT Records := MODULE

	// EXPORT SearchView() := MODULE 
	// 
	// END;
	
	// EXPORT ReportView() := MODULE 
	// 
	// END;
	
	EXPORT BatchView( DATASET(Experian_Phones_Services.layouts.batch_in_plus) ds_batch_in,
	                  DATASET(Gateway.Layouts.Config) gateways_in,
	                  Experian_Phones_Services.IParam.BatchParams configData ) := MODULE

		SHARED err := Constants.Search_Errors;
	
		// **************************************************************************************
		//   A. Find a did for each input record. Mark any no-hits.
		// **************************************************************************************
		SHARED ds_batch_in_common             := fn_append_dids_to_batch_in(ds_batch_in);		
		SHARED ds_batch_in_common_having_dids := ds_batch_in_common(err_search = Standard.Errors.Search.NO_ERROR);
		
		// **************************************************************************************
		//   B. Obtain current, in-house Experian Phones records by did.
		// **************************************************************************************				
		SHARED ds_inhouse_Experian_recs_pre :=  
			JOIN(
				ds_batch_in_common_having_dids, Experian_Phones.Key_Did,
				KEYED( LEFT.did = RIGHT.did ),
				TRANSFORM( Layouts.acctno_plus_Experian_Phones, 
					SELF.acctno := LEFT.acctno,
					SELF.did    := LEFT.did,
					SELF        := RIGHT,
					SELF        := LEFT
				),
				LEFT OUTER,
				LIMIT(Experian_Phones_Services.Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);
		
		SHARED ds_inhouse_Experian_recs := 
			PROJECT(
				ds_inhouse_Experian_recs_pre,
				TRANSFORM( Layouts.acctno_plus_Experian_Phones,
					SELF.error_code := 
							IF( TRIM(LEFT.Encrypted_Experian_PIN) != '' AND LEFT.is_current, 
									err.EXPERIAN_RECORD_FOUND, 
									err.EXPERIAN_RECORD_NOT_FOUND
								),
					SELF := LEFT
				)
			);
									
		// **************************************************************************************
		//   C. Using in-house Experian records, obtain Experian Phones records by Gateway call.
		// **************************************************************************************		
		SHARED ds_inhouse_Experian_recs_for_Gateway := 
				fn_prep_Experian_records_for_gateway(ds_batch_in_common_having_dids, ds_inhouse_Experian_recs(error_code = err.EXPERIAN_RECORD_FOUND));
		
		SHARED ds_Experian_gateway_records :=
				fn_call_Experian_gateway(gateways_in, ds_inhouse_Experian_recs_for_Gateway);

		// There might be some Metronet Phones we couldn't find. Filter those out. 
		SHARED ds_Experian_gateway_records_filtered := 
				ds_Experian_gateway_records(error_code = err.EXPERIAN_RECORD_FOUND);

		// **************************************************************************************
		//   D. Get Telcordia data to fill in carrier information.
		// **************************************************************************************				
		SHARED ds_phone_recs_for_Telcordia :=
			PROJECT(
				ds_Experian_gateway_records_filtered,
				TRANSFORM( BatchServices.Telecordia_BatchService_Records.rec_input,
					SELF.acctno       := LEFT.acctno,
					SELF.phone_number := LEFT.subj_phone10
				)
			);
			
		SHARED ds_Telcordia_recs := 
				BatchServices.Telecordia_BatchService_Records.BatchView(ds_phone_recs_for_Telcordia);
		
		SHARED ds_Experian_gateway_records_with_carrier_info := 
			JOIN(
				ds_Experian_gateway_records_filtered, ds_Telcordia_recs,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.subj_phone10 = RIGHT.phone_number, 
				TRANSFORM( progressive_phone.layout_progressive_batch_out_with_did,
					SELF.phpl_phone_carrier := RIGHT.ocn,
					SELF.phpl_carrier_city  := RIGHT.city,
					SELF.phpl_carrier_state := RIGHT.st,
					SELF                    := LEFT		
				),
				LEFT OUTER, 
				KEEP(1), LIMIT(0)
			);

		// Project the results we have so far--everything except Feedback data--into the same 
		// layout we expect back from Phones Feedback. This will be the dataset we'll transform 
		// to the final layout if the customer does not want Feedback.
		SHARED ds_Experian_recs_having_no_feedback := 
				PROJECT( 
					ds_Experian_gateway_records_with_carrier_info, 
					TRANSFORM(progressive_phone.layout_progressive_batch_out_with_fb,
						SELF := LEFT,
						SELF := []
					)
				);
		
		// **************************************************************************************
		//   E. Obtain Phones Feedback records, if requested.
		// **************************************************************************************	
		SHARED ds_Experian_recs_having_feedback := 
				progressive_phone.FN_AppendFeedback(ds_Experian_gateway_records_with_carrier_info);

		// **************************************************************************************
		//   F. Transform matching Experian gateway records to final layout.
		// **************************************************************************************
		SHARED ds_matching_records_pre := 
				IF( configData.include_PhonesFeedback, ds_Experian_recs_having_feedback, ds_Experian_recs_having_no_feedback );
	
		SHARED ds_matching_records :=
			JOIN(
				ds_batch_in_common_having_dids,
				ds_matching_records_pre,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Layouts.batch_out_plus,
					SELF.subj_phone10_score           := RIGHT.phone_score,
					SELF.subj_phone_type_new          := Constants.EXPERIAN_INQUIRY_PHONES;
					SELF.subj_phone_duplicate_flag    := RIGHT.dup_phone_flag,
					SELF.phone_feedback_date          := RIGHT.phone_feedback_date_1,
					SELF.phone_feedback_result        := Functions.fn_get_phone_fdbk_result( RIGHT.phone_feedback_date_1, RIGHT.phone_feedback_result_1 ),
					SELF.phone_feedback_first         := RIGHT.phone_feedback_first_1,
					SELF.phone_feedback_middle        := RIGHT.phone_feedback_middle_1,
					SELF.phone_feedback_last          := RIGHT.phone_feedback_last_1,
					SELF.phone_feedback_last_rpc_date := RIGHT.phone_feedback_last_rpc_date_1,
					SELF.err_search                   := LEFT.err_search,
					SELF.error_code                   := RIGHT.error_code,
					// Record royalty data for records found via Experian gateway.
					SELF.royalty_type                 := Royalty.Constants.RoyaltyType.METRONET,
					SELF.royalty_src                  := MDR.sourceTools.src_Metronet_Gateway,
					SELF := LEFT,
					SELF := RIGHT,
					SELF := []
				),
				INNER,
				KEEP(1)
			);
											
		// **************************************************************************************
		//   G. Propogate error codes back to caller. Product requirements state that both hits
		//   and misses (and their error codes) should be returned.
		// **************************************************************************************
		
		// Collect together all records that constitute the no-hits for this search.:
		//   o  all input records that didn't find a DID
		//   o  all DIDed records that didn't find an inhouse Experian record
		//   o  all inhouse Experian records that didn't find a gateway Experian record
		//
		// ...and union, sort and dedup. Then transform to final layout.
		
		// Records having no did:
		SHARED ds_nonmatches_1 := ds_batch_in_common(err_search = Standard.Errors.Search.DID_NOT_FOUND);
		
		// Records finding no inhouse Experian record:
		SHARED ds_nonmatches_2 := 
			JOIN( 
				ds_batch_in_common, ds_inhouse_Experian_recs(error_code = err.EXPERIAN_RECORD_NOT_FOUND), 
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Experian_Phones_Services.layouts.batch_in_plus,
					SELF := RIGHT,
					SELF := LEFT
				),
				INNER,
				KEEP(1)
			);
		
		// Records finding no gateway record:
		SHARED ds_nonmatches_3 := 
			JOIN( 
				ds_batch_in_common, ds_Experian_gateway_records(error_code = err.GATEWAY_RECORD_NOT_FOUND), 
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Experian_Phones_Services.layouts.batch_in_plus,
					SELF := RIGHT,
					SELF := LEFT
				),
				INNER,
				KEEP(1)
			);
	
		// Union, sort, dedup; transform to final layout. 
		SHARED ds_all_nonmatches := 
				DEDUP( SORT( (ds_nonmatches_1 + ds_nonmatches_2 + ds_nonmatches_3), acctno, did, -error_code ), acctno, did );
				
		SHARED ds_nonmatching_records :=
			PROJECT(
				ds_all_nonmatches,
				TRANSFORM( Layouts.batch_out_plus,
					SELF.acctno         := LEFT.acctno, 
					SELF.subj_first     := LEFT.name_first,
					SELF.subj_middle    := LEFT.name_middle,
					SELF.subj_last      := LEFT.name_last,
					SELF.subj_suffix    := LEFT.name_suffix,
					SELF.subj_name_dual := Functions.fn_format_name(LEFT), 
					SELF.subj_phone_type_new := 
					    IF( LEFT.error_code = err.GATEWAY_RECORD_NOT_FOUND, Constants.EXPERIAN_INQUIRY_PHONES, '' ),
					// Record royalty data even though the inhouse Experian data found no records via Experian gateway.
					SELF.royalty_type := 
							IF( LEFT.error_code = err.GATEWAY_RECORD_NOT_FOUND, Royalty.Constants.RoyaltyType.METRONET, '' ),
					SELF.royalty_src :=
							IF( LEFT.error_code = err.GATEWAY_RECORD_NOT_FOUND, MDR.sourceTools.src_Metronet_Gateway, '' ),
					SELF                := LEFT,
					SELF                := []
				)
			);

		// Append non-matching records to the matching records; sort.
		SHARED ds_results_sorted := SORT( (ds_matching_records + ds_nonmatching_records), (UNSIGNED)acctno );
		
		// **************************************************************************************
		//  H. Define royalties dataset. Per the product requirements, we must identify a royalty
		//  for each inquiry to the gateway, not for each hit returned by the gateway.
		// **************************************************************************************
		ds_royalties_byacctno := Royalty.RoyaltyMetronet.GetBatchRoyaltiesByAcctno(ds_batch_in, ds_results_sorted, royalty_src);
		SHARED ds_royalties 	:= Royalty.GetBatchRoyalties(ds_royalties_byacctno, configData.ReturnDetailedRoyalties);

		// **************************************************************************************
		//   I. Define other Exportable attributes.
		// **************************************************************************************
		EXPORT results         := ds_results_sorted;
		EXPORT batch_in_common := ds_batch_in_common;
		EXPORT royalties       := ds_royalties;
		
		// **************************************************************************************
		//                                       DEBUGs.
		// **************************************************************************************
		EXPORT inhouse_Experian_recs             := ds_inhouse_Experian_recs;
		EXPORT inhouse_Experian_recs_for_Gateway := ds_inhouse_Experian_recs_for_Gateway;
		EXPORT Experian_gateway_records          := ds_Experian_gateway_records;
		EXPORT Telcordia_recs                    := ds_Telcordia_recs;
		EXPORT Experian_recs_having_feedback     := ds_Experian_recs_having_feedback;
		EXPORT matching_records                  := ds_matching_records;
		EXPORT nonmatching_records               := ds_nonmatching_records;
		
	END;
	
END;
