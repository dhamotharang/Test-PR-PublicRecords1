IMPORT AutokeyB2_batch, BatchServices,LN_PropertyV2_Services,LN_PropertyV2,BatchShare,ut,Gateway,FFD, FCRA;

rec_batch_in_plus_date_filter := LN_PropertyV2_Services.layouts.batch_in_plus_date_filter;


EXPORT Property_BatchCommon (boolean isFCRA, unsigned1 nss, boolean useCannedRecs,
													   DATASET(LN_PropertyV2_Services.layouts.batch_in_plus_date_filter) ds_in,
														 STRING BIPFetchLevel = 'S'):= FUNCTION
														 
		#OPTION('optimizeProjects', TRUE);
		isCNSMR := ut.IndustryClass.is_Knowx;
		// Constants.
		
		TOO_MANY_MATCHES              := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;		
		OTHERWISE_DISPLAY_NO_PENALTY  := '-';

		// Locals.
		
		BOOLEAN unformatted_values 			:= FALSE : STORED('Return_Unformatted_Values');
		INTEGER max_results_per_acct    := 20    : STORED('Max_Results_Per_Acct');
		
		BOOLEAN return_current_only     := FALSE : STORED('Return_Current_Only');
		BOOLEAN skip_dedup              := FALSE : STORED('Skip_Dedup');
		
			// FFD				 
		INTEGER8 inFFDOptionsMask := FFD.FFDMask.Get();
		INTEGER8 inFCRAPurpose := FCRA.FCRAPurpose.Get();
		gw_config := Gateway.Configuration.Get();
		
		UNSIGNED PARTY_TYPE := BatchServices.Functions.LN_Property.return_party_types;
		
		// Not very graceful, but it works on all Roxie platforms.
		SET OF STRING record_types := BatchServices.Functions.LN_Property.return_record_types;
	
		
		/* ****************************** CAPTURE AND FORMAT INPUT BATCH ****************************** */

  	
		
		ds_xml_in := IF( NOT useCannedRecs, 
		                           ds_in, 
		                           PROJECT(BatchServices._Sample_inBatchMaster('Property'), rec_batch_in_plus_date_filter) 
                     );
															
		rec_batch_in_plus_date_filter xfm_set_date_range(ds_xml_in l) :=
			TRANSFORM
				SELF.min_year := IF( TRIM(l.min_year) = '', '0', TRIM(l.min_year) );
				SELF.max_year := IF( TRIM(l.max_year) = '', '9999', TRIM(l.max_year) );
				SELF := l;
			END;
			
		ds_batch_in_raw := PROJECT(ds_xml_in, xfm_set_date_range(LEFT));


//////////////////////////////////////////////////////////

		/* ********************************** OBTAIN PROPERTY RECORDS ********************************* */
	// common batch settings, including a gateway to a remote Picklist
	  batch_params := module (BatchShare.IParam.getBatchParams())
      export dataset (Gateway.layouts.config) gateways := gw_config;
		  export integer1 non_subject_suppression := nss;
    end;
	 	BatchShare.MAC_SequenceInput(ds_batch_in_raw, ds_sequenced);
	  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in_pre);

  // append DID (a soap call to Picklist service
	  BatchShare.MAC_AppendPicklistDID (ds_batch_in_pre, ds_batch_did, batch_params, true);		

		ds_ready := if (isFcra, ds_batch_did, ds_batch_in_pre);		
		ds_batch_in := PROJECT(ds_ready, LN_PropertyV2_Services.layouts.batch_in);
		
		/* ********************************** OBTAIN PROPERTY RECORDS ********************************* */
		// FFD 
		// a) we are using the subject DID rather than the Best DID 
		ds_dids := project(ds_batch_in(did>0),FFD.Layouts.DidBatch);
			
		// b) Call the person context		
		pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gw_config, FFD.Constants.DataGroupSet.Property, inFFDOptionsMask));

  alert_flags := if(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, inFFDOptionsMask));
	
	
		// c) Slim down the PersonContext				 
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);
		
    ds_best := project(ds_batch_in, transform(doxie.layout_best, self.did := left.did, self:=[]));
    ds_flags := if(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));

		p := BatchServices.Property_BatchService_Records(ds_batch_in, record_types, party_type, nSS, isFCRA, 
																											BIPFetchLevel, slim_pc_recs, inFFDOptionsMask, ds_flags, isCNSMR);
		 
		// obtain the match codes from the soap inputs.
		boolean nameMatch_value :=    p.NameMatch_value;
		boolean streetAddressMatch_value := p.StreetAddressMatch_value;
		boolean stateMatch_value :=   p.StateMatch_value;  
		boolean cityMatch_value  :=   p.CityMatch_value;  
		boolean zipMatch_value   :=   p.ZipMatch_value; 
		boolean dobMatch_value   :=   p.DobMatch_value; 
		boolean ssnMatch_value   :=   p.SSNMatch_value; 		
		boolean didMatch_value   :=   p.DIDMatch_value; 
		
		// Get the top 20 records for each acctno here. Note: we DON'T want to just get the top 20 ln_fares_ids for
		// each acctno and then match those against the property records, because many of those ln_fares_ids might be 
		// misses. Instead, attach the acctnos back to the property recs first, sort, and then get the top 20.		
		BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos xfm_prepend_acctnos(p.ds_all_fares_ids l, p.ds_property_recs r) :=
			TRANSFORM
				SELF := l;
				SELF := r;
			END;
		
		ds_property_recs_filtered := IF(return_current_only, 
		                                p.ds_property_recs(TRIM(current_record) = 'Y'), 
		                                p.ds_property_recs);
		
		ds_property_recs_plus_acctnos_unfiltered := 
		                JOIN(p.ds_all_fares_ids, ds_property_recs_filtered,
		                     LEFT.ln_fares_id = RIGHT.ln_fares_id
												 and LEFT.search_did = RIGHT.search_did,
		                     xfm_prepend_acctnos(LEFT, RIGHT),
		                     INNER);
		
		ds_property_recs_plus_acctnos := 
		                JOIN(ds_property_recs_plus_acctnos_unfiltered, ds_ready,
		                     LEFT.acctno = RIGHT.acctno AND
												 (UNSIGNED2)LEFT.sortby_date[1..4] BETWEEN (UNSIGNED2)RIGHT.min_year AND (UNSIGNED2)RIGHT.max_year,
												 TRANSFORM(LEFT), INNER);												 

	 // add in match code layout
	  temp_layout := 	record
		  BOOLEAN match_name;
		  BOOLEAN match_street_address;
		  BOOLEAN match_city;
		  BOOLEAN match_state;
		  BOOLEAN match_zip;
		  BOOLEAN match_ssn;
	    BOOLEAN match_dob;
		  BOOLEAN match_did;
			BOOLEAN matches;
			BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes;
	  END;		
	
    temp_layout add_matchcodeValues(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos L,
					                        LN_PropertyV2_Services.layouts.batch_in R)  := TRANSFORM
			

			tmp_match_name1  := batchservices.functions.LN_Property.fn_match_name(L.parties[1].entity, R);
			tmp_match_name2  := batchservices.functions.LN_Property.fn_match_name(L.parties[2].entity, R);
			tmp_match_name3  := batchservices.functions.LN_Property.fn_match_name(L.parties[3].entity, R);
			tmp_match_name4  := batchservices.functions.LN_Property.fn_match_name(L.parties[4].entity, R);
			tmp_match_name5  := batchservices.functions.LN_Property.fn_match_name(L.parties[5].entity, R);
			tmp_match_name := tmp_match_name1 OR tmp_match_name2 OR tmp_match_name3 OR tmp_match_name4 OR tmp_match_name5;
			SELF.match_name := tmp_match_name;																										 
		  tmp_match_street_address := (L.parties[1].prim_range = R.prim_range AND R.prim_range <> '') AND
																(L.parties[1].prim_name = R.prim_name AND R.prim_name <> '') AND
															  (L.parties[1].suffix = R.addr_suffix AND R.addr_suffix <> '') AND
																(L.parties[1].predir = R.predir) AND
																(L.parties[1].postdir = R.postdir);
      SELF.match_street_address := tmp_match_street_address;																						
      tmp_match_city  := (L.parties[1].p_city_name = R.p_city_name AND R.p_city_name <> '');																						
		  SELF.match_city  := tmp_match_city;
		  tmp_match_state := (L.parties[1].st = R.st AND R.st <> '');
		  SELF.match_state := tmp_match_state;
		  tmp_match_zip   := (L.parties[1].zip = R.z5 AND R.z5 <> '');
		  SELF.match_zip   := tmp_match_zip;
		  tmp_match_ssn1 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[1].entity, R); 
			tmp_match_ssn2 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[2].entity, R); 
			tmp_match_ssn3 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[3].entity, R); 
			tmp_match_ssn4 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[4].entity, R); 
			tmp_match_ssn5 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[5].entity, R); 
			tmp_match_ssn := tmp_match_ssn1 OR tmp_match_ssn2 OR tmp_match_ssn3 OR tmp_match_ssn4 OR tmp_match_ssn5;		
		  SELF.match_ssn   := tmp_match_ssn;
		  SELF.match_dob   := TRUE;
		
		  tmp_match_did1  :=  batchservices.functions.LN_Property.fn_match_did(L.parties[1].entity, R);  
			tmp_match_did2 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[2].entity, R); 
			tmp_match_did3 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[3].entity, R); 
			tmp_match_did4 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[4].entity, R); 
			tmp_match_did5 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[5].entity, R); 
			tmp_match_did := tmp_match_did1 OR tmp_match_did2 OR tmp_match_did3 OR tmp_match_did4 OR tmp_match_did5;
		  SELF.match_did := tmp_match_did;
								                   
		  SELF.acctno      := L.acctno; // sets acctno
		  nameV  :=  ((~(nameMatch_value)) OR (tmp_match_name));		                                    						
		  streetV := ((~(streetAddressMatch_value)) OR (tmp_match_street_address));
	    cityV  :=  ((~(cityMatch_value)) OR (tmp_match_city));
		  stateV :=  ((~(stateMatch_value)) OR (tmp_match_state));
		  zipV   :=  ((~(zipMatch_value))  OR (tmp_match_zip));
		  ssnV   :=  ((~(ssnMatch_value)) OR (tmp_match_ssn));
		  didV   := 	((~(didMatch_value)) OR (tmp_match_did));		
		  SELF.matches := nameV AND streetV AND cityV AND StateV AND zipV AND ssnV AND didV;					
			SELF.matchcodes := batchservices.functions.match_code_result(
		           tmp_match_name, tmp_match_street_address, tmp_match_city, tmp_match_state,
							 tmp_match_zip, tmp_match_ssn, FALSE, tmp_match_did);
      SELF := L;							
      SELF := [];							
		END;
							 
    ds_property_recs_plus_acctnos_trimmed_unmatched := join(ds_property_recs_plus_acctnos, ds_batch_in,
                  left.acctno = right.acctno,													
							   add_matchcodeValues(left, right));    	
								 
    ds_property_recs_plus_acctnos_trimmed := 	ds_property_recs_plus_acctnos_trimmed_unmatched(matches=true);							 

	  ds_property_recs_plus_acctnos_tmp := project(ds_property_recs_plus_acctnos_trimmed,
		                                        transform(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes,																					
																						self := left));

		// *** NOTE: we may change the sort field 'sortby_date' to 'recording_date' at some point. We'll see. ***
		ds_property_recs_grouped := GROUP(SORT(ds_property_recs_plus_acctnos_tmp, acctno, -sortby_date), acctno);

		ds_top_property_recs := TOPN(ds_property_recs_grouped, max_results_per_acct, acctno, -sortby_date);
		  // NOTE: we'll use this attribute (which has child datasets) to derive matchcodes, since the flattened 
			// version of the property records won't have atomic name or address data.
		
		/* ************************************** ADD MATCHCODES ************************************** */
		
		// 0. Reduce p.ds_all_fares_ids only to those ln_fares_ids for which an actual property record was found.
		ds_valid_ln_fares_ids := JOIN(p.ds_all_fares_ids, ds_top_property_recs,
		                              LEFT.acctno = RIGHT.acctno AND 
		                              LEFT.ln_fares_id = RIGHT.ln_fares_id,
																	TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids, SELF := LEFT;),
																	INNER);
																	
		// 1. Attach fake ids and matchcodes to the input batch records.		
		ds_input_and_matchcodes := JOIN(ds_batch_in, ds_valid_ln_fares_ids,
																		LEFT.acctno = RIGHT.acctno,
																		BatchServices.transforms.LN_Property.xfm_add_matchcodes(LEFT,RIGHT), 
																		INNER);
		
		// 2. Join ds_input_and_matchcodes to the matching property records, and determine matchcodes.
		
		// The following transform assigns a matchcode to a particular matchcode field. Each matchcode is determined
		// by assesing a penalty value for each input and matching record pair.
		//
		// *** TODO: *** Add another matchcode type 'C' for 'Care Of'. Occurs where there is a buyer and/or a seller
		// in a transaction of type 'deed'.		
		//
		UCase            := StringLib.StringToUpperCase;
		apply_penalty_to := BatchServices.Functions.LN_Property.fn_apply_penalty;

		BatchServices.Layouts.LN_Property.rec_input_and_matchcodes xfm_derive_matchcodes(ds_input_and_matchcodes l, 
		                                                                                 BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes r)   :=
			TRANSFORM
				SELF.assess_prop_addr_match_code := 
				      IF( EXISTS(r.parties(UCase(party_type_name) = 'PROPERTY')) AND
									EXISTS(r.parties(UCase(party_type_name) = 'ASSESSEE')),
									apply_penalty_to(l, r.parties(UCase(party_type_name) = 'PROPERTY')[1], isFCRA),
									OTHERWISE_DISPLAY_NO_PENALTY
								 );
				SELF.assess_mail_addr_match_code := 
				      IF( EXISTS(r.parties(UCase(party_type_name) = 'ASSESSEE')),
									apply_penalty_to(l, r.parties(UCase(party_type_name) = 'ASSESSEE')[1], isFCRA),
									OTHERWISE_DISPLAY_NO_PENALTY
								 );
				SELF.assess_ownr_addr_match_code := 
				      IF( EXISTS(r.parties(UCase(party_type_name) = 'OWNER')),
									apply_penalty_to(l, r.parties(UCase(party_type_name) = 'OWNER')[1], isFCRA),
									OTHERWISE_DISPLAY_NO_PENALTY
								 );
				SELF.deed_prop_addr_match_code   := 
				      IF( EXISTS(r.parties(UCase(party_type_name) = 'PROPERTY')) AND NOT
									EXISTS(r.parties(UCase(party_type_name) = 'ASSESSEE')),																								
									apply_penalty_to(l, r.parties(UCase(party_type_name) = 'PROPERTY')[1], isFCRA),
									OTHERWISE_DISPLAY_NO_PENALTY
								 );
				SELF.deed_buyr_addr_match_code   := 
				      IF( EXISTS(r.parties(UCase(party_type_name) = 'BUYER')),
									apply_penalty_to(l, r.parties(UCase(party_type_name) = 'BUYER')[1], isFCRA),
									OTHERWISE_DISPLAY_NO_PENALTY
								 );
				SELF.deed_sell_addr_match_code   := 
				      IF( EXISTS(r.parties(UCase(party_type_name) = 'SELLER')),
									apply_penalty_to(l, r.parties(UCase(party_type_name) = 'SELLER')[1], isFCRA),
									OTHERWISE_DISPLAY_NO_PENALTY
								 );				
				SELF                             := l;
				
			END;
			
		ds_input_and_calculated_matchcodes := JOIN(ds_input_and_matchcodes, ds_top_property_recs,
		                                           LEFT.acctno = RIGHT.acctno AND 
		                                           LEFT.ln_fares_id = RIGHT.ln_fares_id,
		                                           xfm_derive_matchcodes(LEFT,RIGHT),
											                         LEFT OUTER); 		
		// Flatten the property records.
		ds_flat_final_recs := PROJECT(UNGROUP(ds_top_property_recs), BatchServices.xfm_Property_make_flat(LEFT, unformatted_values, counter));
	
		// Move the matchcodes from ds_input_and_calculated_matchcodes over to the flattened records.
		ds_flattened_property_recs_with_matchcodes := 
		      JOIN(ds_flat_final_recs, ds_input_and_calculated_matchcodes,
							 LEFT.acctno = RIGHT.acctno AND 
							 LEFT.ln_fares_id = RIGHT.ln_fares_id,
							 TRANSFORM(BatchServices.layout_Property_Batch_out_pre,
												 SELF.assess_prop_addr_match_code := RIGHT.assess_prop_addr_match_code;
												 SELF.assess_mail_addr_match_code := RIGHT.assess_mail_addr_match_code;
												 SELF.assess_ownr_addr_match_code := RIGHT.assess_ownr_addr_match_code;
												 SELF.deed_prop_addr_match_code   := RIGHT.deed_prop_addr_match_code;
												 SELF.deed_buyr_addr_match_code   := RIGHT.deed_buyr_addr_match_code;
												 SELF.deed_sell_addr_match_code   := RIGHT.deed_sell_addr_match_code;
												 SELF                             := LEFT;),
							 LEFT OUTER);																											 

		/* ******************************* ADD 'TOO MANY MATCHES' RECORDS ****************************** */
		
		// Now, get all of the account numbers which complained of having too_many_matches (error_code 203)  
		// during the different autokey fetches. We'd like to return these records because they'll be a good
		// clue describing why a search failed for a particular input record.
		ds_too_many_results := DEDUP(SORT(p.ds_fids(search_status = TOO_MANY_MATCHES), acctno), acctno);

		// Format for output those acctnos having too_many_matches.
		BatchServices.layout_Property_Batch_out_pre xfm_recs_having_too_many_results(AutokeyB2_batch.Layouts.rec_output_IDs_batch l) := 
			TRANSFORM
				SELF.acctno     := l.acctno;
				SELF.error_code := l.search_status;
				SELF            := [];
			END;
			
		ds_too_many_formatted := PROJECT(ds_too_many_results, xfm_recs_having_too_many_results(LEFT));
		
		// Obtain only those records (1) having too many results for a particular autokey fetch and (2) having 
		// no matching property records otherwise.
		ds_too_many_having_no_matching_property_recs := dedup(sort(JOIN(ds_too_many_formatted, ds_flattened_property_recs_with_matchcodes,
																										LEFT.acctno = RIGHT.acctno,LEFT OUTER),acctno),acctno);
	
		// Rejoin to the property recs.				
		ds_all_recs := SORT(ds_flattened_property_recs_with_matchcodes   + if(~isFCRA,ds_too_many_having_no_matching_property_recs), 
												acctno, -sortby_date);
		
		//Resolution for bug 48778.
		ds_all_normal := ds_all_recs(error_code <> TOO_MANY_MATCHES);
		
		ds_all_abnormal := ds_all_recs(error_code = TOO_MANY_MATCHES);
		
		ds_all := ds_all_normal + ds_all_abnormal(acctNo not in set(ds_all_normal,acctNo));
											
		ds_all_sort := sort(ds_all,fid_type_desc,-LN_PropertyV2.fn_strip_pnum(assess_apna_or_pin_number),-LN_PropertyV2.fn_strip_pnum(deed_apnt_or_pin_number),-sortby_date,vendor_source_flag,acctno);
		
				ds_flat_sorted_recs := sort(
                              if(skip_dedup,
		                           ds_all_sort,
															 dedup(ds_all_sort,fid_type_desc,LN_PropertyV2.fn_strip_pnum(assess_apna_or_pin_number),LN_PropertyV2.fn_strip_pnum(deed_apnt_or_pin_number),sortby_date,acctno)
															)
														 ,acctno);

    // data maybe suppressed due to alerts
    ds_flat_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(ds_flat_sorted_recs, alert_flags, StatementsAndDisputes, BatchServices.layout_Property_Batch_out_pre, inFFDOptionsMask);

		// add resolved LexId to the results for inquiry history logging support                    
    ds_flat_with_inquiry := FFD.Mac.InquiryLexidBatch(ds_ready, ds_flat_with_alerts, BatchServices.layout_Property_Batch_out_pre, 0);

    ds_flat_property_recs := if(isFCRA, ds_flat_with_inquiry, ds_flat_sorted_recs);

		//one := p.ds_property_recs;
		// two := p.ds_all_fares_ids;
		// three := p.ds_property_output;
		// four := p.ds_fids;
		
		// output(one,named ('ds_property_recs'));
		// output(ds_batch_in_pre,named ('ds_batch_in_pre'));
		// output(ds_batch_in,named ('ds_batch_in'));
		// output(two, named('ds_all_fares_ids'));
		// output(three, named('ds_property_output'));
		// output(four, named('ds_fids'));
		
		// output(ds_property_recs_plus_acctnos_trimmed_unmatched, named('ds_property_recs_plus_acctnos_trimmed_unmatched'));
		
		// output(ds_property_recs_plus_acctnos_trimmed, named('ds_property_recs_plus_acctnos_trimmed'));
		
		// ds_flat_property_recs_plus_actual_acctnos := join(ds_batch_in_raw,ds_flat_property_recs,
			// left.acctno = right.acctno,
			// transform(recordof(ds_flat_property_recs),
				// self.acctno := left.old_acctno,
				// self := right));

	consumer_statements := NORMALIZE(ds_flat_property_recs, LEFT.StatementsAndDisputes, 
															TRANSFORM(FFD.Layouts.ConsumerStatementBatch, 
															SELF.Acctno := left.Acctno,
															SELF.SequenceNumber := left.SequenceNumber,
															SELF := RIGHT));
		
	// consumer statements dataset contains information about disputed records as well as Statements.
	consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, inFFDOptionsMask));
 consumer_alerts  := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, inFFDOptionsMask));                                               
 consumer_statements_alerts := consumer_statements_prep + consumer_alerts;

	BatchShare.MAC_RestoreAcctno(ds_ready, consumer_statements_alerts, consumer_statements_acctno,false,false);
	
 	BatchShare.MAC_RestoreAcctno(ds_ready, ds_flat_property_recs, ds_batch_ready);	
	Pre_results := ds_batch_ready;
	ut.mac_TrimFields(Pre_results, 'Pre_results', result);

	out := project(result,BatchServices.layout_Property_Batch_out);
	FFD.MAC.PrepareResultRecordBatch(out, record_out, consumer_statements_acctno, BatchServices.layout_Property_Batch_out);
	
	
/* 	output(ds_top_property_recs,named('ds_top_property_recs'));
   	output(result,named('resultInside'));	
   	output(record_out.Records,named('Records'));	
   	output(record_out.Statements,named('Statements'));	
*/
	
	
  	RETURN record_out;
END;