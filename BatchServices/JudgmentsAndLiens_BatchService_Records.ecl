
IMPORT AutokeyB2, Autokey_batch, AutoHeaderI, AutoStandardI, Blackbaud, Doxie, doxie_cbrs, LiensV2, LiensV2_Services, AutokeyB2_batch;

// ***** STRATEGY *****
/* Judgments and Liens records will be retrieved via autokeys and via the Header (getting DIDs and BDIDs. 
	 We'll then union, sort and dedup ds_acctnos_and_tmsids_by_ak and ds_acctnos_and_tmsids_by_did to 
	 get all tmsids and then join against another key to filter based on party_type(s) selected by the customer. 
	 Last, we'll obtain JL records.
	 
	 On both passes we'll filter out any party_types the customer is not interested in. These party_types are 
	 passed in as a formal parameter and applied as a simple filter against the J&L records that the system
	 returns in each of the passes.

   Gotchas: liensv2_services.layout_TMSID and doxie.layout_references_acctno have the same signature, but
	 we use them both here since the functions they call accept a formal parameter of one or the other.
*/
EXPORT JudgmentsAndLiens_BatchService_Records( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster),
                                               SET OF STRING party_types = ['A','C','D',''] ) := 
	FUNCTION

		// UNSIGNED1 DPPA_Purpose  := 1     : STORED('DPPAPurpose');
		// UNSIGNED1 GLB_Purpose   := 8     : STORED('GLBPurpose');
		UNSIGNED4 Max_Results   := 10000 : STORED('MaxResults');	

		/* ***** System flags and values ***** */
		BOOLEAN forceSeqNumber  := TRUE;
		// INTEGER pt              := 20 : STORED('PenaltThreshold');

		BOOLEAN no_did_append					 := FALSE : STORED('NoDIDAppend');
		BOOLEAN no_bdid_append				 := FALSE : STORED('NoBDIDAppend');
		
		TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;
		

		// ************************** TMSIDS BY THE HEADER **************************

		// 1. ...go look for tmsids via dids.
		
		ds_acctnos_and_dids := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in);
		
		ds_normalized_dids_grpd := GROUP(ds_acctnos_and_dids, acctno);

		ds_tmsids_by_did := LiensV2_Services.liens_raw.get_tmsids_from_dids_batch(ds_normalized_dids_grpd);		
		
		rec_acctnos_dids_tmsids := RECORD
			doxie.layout_references_acctno;
			STRING50 tmsid           := '';
		END;
		
		ds_acctnos_dids_tmsids := JOIN(ds_acctnos_and_dids, ds_tmsids_by_did,
		                               LEFT.acctno = RIGHT.acctno,
		                               TRANSFORM(rec_acctnos_dids_tmsids,
		                                         SELF.acctno := LEFT.acctno;
																						 SELF.did    := LEFT.did;
																						 SELF.tmsid  := RIGHT.tmsid),
		                               INNER, KEEP(Batchservices.Constants.JudgementsAndLiens.Join_limit));
		
		ds_tmsids_by_did_filtered_by_party_type := JOIN(ds_acctnos_dids_tmsids, liensv2.key_liens_party_ID,
		                                                KEYED(RIGHT.tmsid = LEFT.tmsid) AND
		                                                (UNSIGNED)RIGHT.did = LEFT.did AND
		                                                RIGHT.name_type[1] IN party_types,
																										INNER, KEEP(Batchservices.Constants.JudgementsAndLiens.Join_limit));
		
		// .. Project acctnos and tmsids into the otherwise identical layout_TMSID.
		ds_acctnos_and_tmsids_by_appending_did := PROJECT(ds_tmsids_by_did_filtered_by_party_type, liensv2_services.layout_TMSID);
		ds_blank_tmsids_for_did := DATASET([], liensv2_services.layout_TMSID); 
		ds_acctnos_and_tmsids_by_did := if(no_did_append, ds_blank_tmsids_for_did, ds_acctnos_and_tmsids_by_appending_did);

		// 2. ...and then go look for tmsids via bdids.
		
		ds_acctnos_and_bdids := BatchServices.Functions.fn_find_bdids_and_append_to_acctno(ds_batch_in);

		ds_acctnos_and_layout_references := PROJECT(ds_acctnos_and_bdids, 
		                                            TRANSFORM(doxie_cbrs.layout_references_acctno,
		                                                      SELF.acctno := LEFT.acctno,
																													SELF.bdid   := LEFT.bdid));
		
		ds_tmsids_by_bdid := LiensV2_Services.liens_raw.get_tmsids_from_bdids_batch(ds_acctnos_and_layout_references);

		rec_acctnos_bdids_tmsids := RECORD
			doxie_cbrs.layout_references_acctno;
			STRING50 tmsid  := '';
		END;		
		
		ds_acctnos_bdids_tmsids := JOIN(ds_acctnos_and_bdids, ds_tmsids_by_bdid,
		                                LEFT.acctno = RIGHT.acctno,
		                                TRANSFORM(rec_acctnos_bdids_tmsids,
		                                          SELF.acctno := LEFT.acctno,
		                                          SELF.bdid   := LEFT.bdid,
		                                          SELF.tmsid  := RIGHT.tmsid),
		                                INNER, KEEP(10000));
		
		ds_tmsids_by_bdid_filtered_by_party_type := JOIN(ds_acctnos_bdids_tmsids, liensv2.key_liens_party_ID,
		                                                KEYED(RIGHT.tmsid = LEFT.tmsid) AND
		                                                (UNSIGNED)RIGHT.bdid = LEFT.bdid AND
		                                                RIGHT.name_type[1] IN party_types,
																										INNER, KEEP(10000));
		
		ds_acctnos_and_tmsids_by_appending_bdid := PROJECT(ds_tmsids_by_bdid_filtered_by_party_type, liensv2_services.layout_TMSID);
		ds_blank_tmsids_for_bdid := DATASET([], liensv2_services.layout_TMSID); 
	 	ds_acctnos_and_tmsids_by_bdid := if(no_bdid_append, ds_blank_tmsids_for_bdid, ds_acctnos_and_tmsids_by_appending_bdid);

		ds_acctnos_and_tmsids_by_header := ds_acctnos_and_tmsids_by_did + ds_acctnos_and_tmsids_by_bdid;
																						 
		// ************************** TMSIDS BY AUTOKEY **************************
		
		// 3. Define values for obtaining autokeys and payloads.		
		ak_keyname := LiensV2.str_AutokeyName;
		ak_dataset := LiensV2.file_SearchAutokey(DATASET([],LiensV2.Layout_liens_party));
		ak_typeStr := 'BC';
			
		// 4. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			//export PenaltThreshold := 20;  // not needed here already set inside "interfaces" above.
			export skip_set        := auto_skip + ['P'];
		END;
		
		boolean nameMatch_value := ak_config_data.MatchName;
		boolean streetAddressMatch_value := ak_config_data.MatchStrAddr;
		boolean cityMatch_value := ak_config_data.MatchCity;
		boolean stateMatch_value := ak_config_data.MatchState;
		boolean zipMatch_value := ak_config_data.MatchZip;
		boolean ssnMatch_value := ak_config_data.MatchSSN;
							
		// 5. Get autokeys and payloads based on batch input. Filter autokey records by party_type. Slim to 
		// just acctnos and tmsids.
		ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outPLfat, intdid, intbdid, ak_typeStr )
		outPLfat_filtered_by_party_type := outPLfat(name_type[1] IN party_types);
		ds_acctnos_and_tmsids_by_ak := PROJECT(outPLfat_filtered_by_party_type, liensv2_services.layout_TMSID);
		
		// ************************************ GET J&L RECORDS ************************************
		
		// 6. Union, sort, dedup all acctnos and tmsids.
		ds_all_acctnos_and_tmsids := ds_acctnos_and_tmsids_by_ak + ds_acctnos_and_tmsids_by_header;
															 
		ds_all_acctnos_and_tmsids_deduped := DEDUP(SORT(ds_all_acctnos_and_tmsids, acctno, tmsid), acctno, tmsid);
		ds_acctnos_and_tmsids_grpd        := GROUP(ds_all_acctnos_and_tmsids_deduped, acctno);		

		// 7. Get the JL records and join back to their respective acctnos.
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		ds_JL_recs := LiensV2_Services.liens_raw.report_view.by_tmsid_batch(ds_acctnos_and_tmsids_grpd,,,,,,appType);		
		
		ds_JL_recs_plus_acctnos :=  JOIN(ds_all_acctnos_and_tmsids_deduped, ds_JL_recs, 
																		 LEFT.tmsid = RIGHT.tmsid,
																		 TRANSFORM(liensv2_services.layout_lien_rollup,
																							 SELF := LEFT;
																							 SELF := RIGHT),
																		 INNER, KEEP(Batchservices.Constants.JudgementsAndLiens.Join_limit));
																		 
    
		ds_batch_in_with_tmsIds := join(ds_all_acctnos_and_tmsids_deduped, ds_batch_in,
																		left.acctno = right.acctno,
																		transform(BatchServices.layouts.Liens.rec_autokey_batch_tmsid,
																		self := left,
																		self := right																			
																		));
		tmp_penalt_layout := record
					unsigned2 penalt;
		end;						
	
		liensv2_services.layout_lien_rollup 
								xfm_penalize_results( BatchServices.layouts.Liens.rec_autokey_batch_tmsid l, 
																			liensv2_services.layout_lien_rollup r) := TRANSFORM
																			
			tmp_penalt_dsD := BatchServices.functions.JudgementsAndLiens.penalt_func_calculate(l,r.debtors);
			tmp_penalt_dsC := BatchServices.functions.JudgementsAndLiens.penalt_func_calculate(l,r.creditors);
			tmp_penalt_dsA := BatchServices.functions.JudgementsAndLiens.penalt_func_calculate(l,r.attorneys);										 
			tmp_penalt_dsT := BatchServices.functions.JudgementsAndLiens.penalt_func_calculate(l,r.thds);
			
			self.penalt := min(project(tmp_penalt_dsD + tmp_penalt_dsC +
																 tmp_penalt_dsA + tmp_penalt_dsT, tmp_penalt_layout), penalt);
			self.acctno := l.acctno;
			SELF        := r;
		END;
	
		// need to dedup by tmsid here cause there is no return current only logic
		// in ucc this gets taken care of by the return current only logic.
		ds_JL_recs_plus_acctnos_slim := dedup(sort(ds_JL_recs_plus_acctnos, tmsid), tmsid);
	 
		// 8. Penalize. 
		ds_JL_recs_plus_acctnoPentalized := join(ds_batch_in_with_tmsids, ds_JL_recs_plus_acctnos_slim,
																						left.tmsid = right.tmsid,																							
																					xfm_penalize_results(LEFT, RIGHT),
																					limit(Batchservices.Constants.JudgementsAndLiens.Join_limit, skip));
																								
		ds_JL_recs_plus_acctnoPentalized_slim := ds_JL_recs_plus_acctnoPentalized(penalt <= ak_config_data.penaltthreshold);
		
		ds_batch_in_capitalized := project(ds_batch_in, batchservices.transforms.xfm_capitalize_input(left));			
		
		STRING8 mc := batchservices.functions.match_code_result(NameMatch_value, StreetAddressMatch_value,
			cityMatch_value, stateMatch_value,zipMatch_value, ssnMatch_value, FALSE,FALSE);
		
		// 9. Put in match codes here.
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
			batchservices.Layouts.Liens.layout_lien_rollup_error_code_and_matchcodes;							 
		END;		
		
		temp_layout add_matchcodeValues(liensv2_services.layout_lien_rollup L,
																Autokey_batch.Layouts.rec_inBatchMaster R)  := TRANSFORM
			// functions in JudgementsAndLiens fn_match* are called in order to match anything
			// deeper in possible child datasets.
			tmp_match_nameD  := if ('D' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_name(L.debtors,  R), true);
			tmp_match_nameC  := if ('C' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_name(L.creditors,  R), true);
			tmp_match_nameA  := if ('A' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_name(L.attorneys,  R), true);
			tmp_match_name := tmp_match_nameD OR tmp_match_nameC OR tmp_match_nameA;
			SELF.match_name := tmp_match_name;
			
			tmp_match_street_addressD  := if ('D' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_streetaddress(L.debtors,  R), true);
			tmp_match_street_addressC  := if ('C' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_streetaddress(L.creditors,  R), true);
			tmp_match_street_addressA  := if ('A' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_streetaddress(L.attorneys,  R), true);		                         
			tmp_match_street_address := tmp_match_street_addressD OR tmp_match_street_addressC OR tmp_match_street_addressA;		
			SELF.match_street_address := tmp_match_street_address;																						
			
			
			tmp_match_cityD  := if ('D' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_city(L.debtors,  R), true);
			tmp_match_cityC  := if ('C' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_city(L.creditors,  R), true);
			tmp_match_cityA  := if ('A' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_city(L.attorneys,  R), true);		                         
			tmp_match_city := tmp_match_cityD OR tmp_match_cityC OR tmp_match_cityA;																					
			SELF.match_city  := tmp_match_city;
			
			tmp_match_stateD  := if ('D' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_state(L.debtors,  R), true);
			tmp_match_stateC  := if ('C' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_state(L.creditors,  R), true);
			tmp_match_stateA  := if ('A' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_state(L.attorneys,  R), true);		                         
			tmp_match_state := tmp_match_stateD OR tmp_match_stateC OR tmp_match_stateA;							  				
			SELF.match_state := tmp_match_state;
			
			tmp_match_zipD  := if ('D' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_zip(L.debtors,  R), true);
			tmp_match_zipC  := if ('C' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_zip(L.creditors,  R), true);
			tmp_match_zipA  := if ('A' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_zip(L.attorneys,  R), true);		                         
			tmp_match_zip := tmp_match_zipD OR tmp_match_zipC OR tmp_match_zipA;									
			SELF.match_zip   := tmp_match_zip;				
			
			tmp_match_ssnD  := if ('D' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_ssn(L.debtors,  R), true);
			tmp_match_ssnC  := if ('C' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_ssn(L.creditors,  R), true);
			tmp_match_ssnA  := if ('A' in party_types, batchservices.functions.JudgementsAndLiens.fn_match_ssn(L.attorneys,  R), true);		                         
			tmp_match_ssn := tmp_match_ssnD OR tmp_match_ssnC OR tmp_match_ssnA;									
			SELF.match_ssn   := tmp_match_ssn;	
							
			SELF.match_dob   := true; // set here cause no DOB data in J & L output.				
																		 
			SELF.acctno      := L.acctno; // sets acctno
			nameV   := ((~(nameMatch_value)) OR (tmp_match_name));
			streetV := ((~(StreetAddressMatch_value)) OR (tmp_match_street_address));
			cityV  :=  ((~(cityMatch_value)) OR (tmp_match_city));
			stateV :=  ((~(stateMatch_value)) OR (tmp_match_state));
			zipV   :=  ((~(zipMatch_value)) OR (tmp_match_zip));
			ssnV   :=  ((~(ssnMatch_value)) OR (tmp_match_ssn));		    
			
			SELF.matches :=  nameV AND streetV AND cityV AND StateV AND zipV AND ssnV;							
			SELF.matchcodes := batchservices.functions.match_code_result(
											 tmp_match_name, tmp_match_street_address,
											tmp_match_city, tmp_match_state,tmp_match_zip,
											tmp_match_ssn, FALSE,FALSE);
			SELF  := L;						
			
			SELF := [];							
		END;

		ds_JL_recs_plus_acctNoPentalized_trimmedTmp_unmatched := 
				join(ds_JL_recs_plus_acctnoPentalized_slim, ds_batch_in_capitalized,
					LEFT.acctno = RIGHT.acctno,													
						add_matchcodeValues(LEFT, RIGHT));    			

		too_many := ds_fids(search_status = TOO_MANY_MATCHES);
		
		too_many_w_error_code := project(too_many, TRANSFORM(batchservices.Layouts.Liens.layout_lien_rollup_error_code_and_matchcodes,
																		 SELF.error_code := LEFT.search_status,
																		 SELF := LEFT,
																		 SELF := []
																		 ));

		ds_JL_recs_plus_acctNoPentalized_trimmedTmp := ds_JL_recs_plus_acctNoPentalized_trimmedTmp_unmatched(matches=true);
		ds_JL_recs_plus_acctNoPentalized_trimmed := project(ds_JL_recs_plus_acctNoPentalized_trimmedTmp,
																					TRANSFORM(batchservices.Layouts.Liens.layout_lien_rollup_error_code_and_matchcodes,
																					SELF.error_code := 0;
																					SELF := LEFT));
					
		// end of match codes
	
		// 10. Flatten, sort and return. 		
		ds_JL_recs_flat := PROJECT( ds_JL_recs_plus_acctnoPentalized_trimmed + too_many_w_error_code, BatchServices.xfm_JudgmentsAndLiens_make_flat(LEFT));		

		ds_results := SORT(ds_JL_recs_flat, acctno, penalt, -orig_filing_date, -release_Date, filing_jurisdiction, orig_filing_number);

		RETURN ds_results;
		
END;
	

// NOTES: 
// party_type is '' by default, returning all possible records. But, it may be 'A' for Attorney,
// 'C' for Creditor/Secured Party, or 'D' for Debtor.
	