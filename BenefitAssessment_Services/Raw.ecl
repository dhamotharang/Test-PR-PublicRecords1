IMPORT BatchShare, FCRA, Risk_Indicators, ut, Header, SexOffender_Services, CriminalRecords_BatchService, riskwise, LN_PropertyV2_Services,
       doxie, suppress, RiskWiseFCRA, marriage_divorce_v2_Services, liensv2, BankruptcyV2, BankruptcyV3;

EXPORT Raw := module
	EXPORT GetDecHits(DATASET(BenefitAssessment_Services.Layouts.Batch_In_plus) ds_input_for_dec, 
										boolean isFCRA = false, 
										DATASET(fcra.Layout_override_flag) ds_flagFile) := function 

		ssn_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.ssn), flag_file_id );
		ssn_ids := SET(ds_flagfile(file_id = FCRA.FILE_ID.ssn), record_id);
		ssn_corr := FCRA.Key_Override_SSN_Table_FFID(KEYED(flag_file_id IN ssn_ffids), isdeceased = true);
		ds_ssn_corr	:= JOIN(ds_input_for_dec, ssn_corr, 
										LEFT.Input_ssn = RIGHT.ssn,
										TRANSFORM(BenefitAssessment_Services.Layouts.layout_ssn, SELF.Did := LEFT.Did, SELF := RIGHT), KEEP(1), LIMIT(0));
		ds_ssn_main := JOIN(ds_input_for_dec, Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA,
										 KEYED(LEFT.Input_ssn=RIGHT.ssn) AND RIGHT.ssn NOT IN ssn_ids AND RIGHT.isdeceased = true,
										 TRANSFORM(BenefitAssessment_Services.Layouts.layout_ssn, SELF.Did := LEFT.Did, SELF := RIGHT), KEEP(1), LIMIT(0));
		dec_ssn_recs := ds_ssn_main + ds_ssn_corr;
		ds_dechits := JOIN(ds_input_for_dec, dec_ssn_recs,
														LEFT.Input_ssn = RIGHT.ssn AND 
														LEFT.did = RIGHT.did AND
														ut.NNEQ_Int(LEFT.Input_dob[1..4], (STRING8) RIGHT.decs_dob[1..4]),
													  Transforms.makeDecHit(LEFT, RIGHT), LEFT OUTER, LIMIT(Constants.COUNT_IN_RECS, SKIP)); 							
		ds_dec_hits := DEDUP(SORT(ds_dechits, acctno, -DeceasedMatchCode), acctno);
		RETURN ds_dec_hits;
	END;

	EXPORT GetCrimHits(DATASET(BenefitAssessment_Services.Layouts.layout_dec_crim_sofr) ds_input,
				boolean isFCRA = false,
				BatchShare.IParam.BatchParams config_Data) := function 	

		ds_crim_input := PROJECT(ds_input(DeceasedMatchCode = ''), Transforms.MakeCrimInput(LEFT));		
		crim_config := module(PROJECT(config_Data, CriminalRecords_BatchService.IParam.batch_params, opt));
			export boolean Return_SSN := TRUE;
			export boolean Return_DOC_Name := TRUE;
		end;		
		ds_tmp_crim_hits := CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records(crim_config, ds_crim_input, isFCRA);		
		ds_crim_hits_bfr_filter := JOIN(ds_input, ds_tmp_crim_hits.Records,
										LEFT.acctno = RIGHT.acctno, 
										Transforms.SetCrimHitsMatchCode(LEFT, RIGHT),
										INNER, LIMIT(Constants.MAX_RECS, SKIP)); 
		ds_crim_hits_bfr_filter_deduped := DEDUP(SORT(ds_crim_hits_bfr_filter(Incarcerated_Flag = '1' and incr_match_code != ''), acctno, -incr_match_code, -event_dt), acctno);
		ds_dec_crim_hits := ds_crim_hits_bfr_filter_deduped + 
												ds_input(DeceasedMatchCode != '');		
		ds_crim_non_hits :=	JOIN(ds_input, ds_dec_crim_hits,
										LEFT.acctno = RIGHT.acctno, 
										TRANSFORM(BenefitAssessment_Services.Layouts.layout_dec_crim_sofr, SELF := LEFT),
										LEFT ONLY);
		ds_crim_hits := ds_crim_non_hits + ds_dec_crim_hits;

		RETURN ds_crim_hits;
	END;

	EXPORT GetSofrHits(DATASET(BenefitAssessment_Services.Layouts.layout_dec_crim_sofr) ds_input,
				boolean isFCRA = false,
				BatchShare.IParam.BatchParams configData) := function 		

		ds_sofr_input :=	PROJECT(ds_input(DeceasedMatchCode = '' AND
										Incarcerated_Flag != '1'), SexOffender_Services.Layouts.batch_in);
		//Find Sex Offender Hits	
		ds_sofr_batch_output := SexOffender_Services.batch_records(configData, 
					ds_sofr_input, isFCRA);		
					
		ds_sofr_batch_recs := ds_sofr_batch_output.records;
		ds_sofr_batch_offdrs := ds_sofr_batch_output.offenders;
		ds_sofr_batch_offdr_recs := JOIN(ds_sofr_batch_recs, ds_sofr_batch_offdrs,
							LEFT.acctno = RIGHT.acctno, 
							Transforms.MakeSofrHits(LEFT, RIGHT), LIMIT(Constants.MAX_RECS, SKIP));			
		ds_TMP_sex_hits := JOIN(ds_input, ds_sofr_batch_offdr_recs,
												LEFT.acctno = RIGHT.acctno, 
												Transforms.DecIncSOFOutput(LEFT, RIGHT), LIMIT(Constants.MAX_RECS, SKIP));
		ds_TMP_sex_hits_deduped := 	DEDUP(SORT(ds_TMP_sex_hits, acctno, -date_last_seen), acctno);							
		ds_dec_crim_sofr_hits := ds_input(Incarcerated_Flag = '1' or DeceasedMatchCode != '') + 		
																										 ds_TMP_sex_hits_deduped(SOFR_Flag = '1');	
		ds_non_hits := JOIN(ds_input, ds_dec_crim_sofr_hits,
												LEFT.acctno = RIGHT.acctno, 
												TRANSFORM(layouts.layout_dec_crim_sofr, SELF := LEFT), LEFT ONLY);			
		ds_sex_hits := ds_non_hits + ds_dec_crim_sofr_hits;

		RETURN ds_sex_hits;
	END;
	
	EXPORT GetFids(DATASET(BenefitAssessment_Services.Layouts.rec_inputWithSearchID) ds_just_dids,
				boolean isFCRA = false,
				BenefitAssessment_Services.IParam.batch_params configData,
				integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing) := function				

		ds_dids := PROJECT(ds_just_dids, LN_PropertyV2_Services.layouts.search_did);
		//get fids from dids - suppression applied in this function
		ds_fids_by_did2 := PROJECT(LN_PropertyV2_Services.Raw.get_fids_from_dids(ds_dids, isFCRA), TRANSFORM(LN_PropertyV2_Services.layouts.search_fid, 
															SELF.isDeepDive := FALSE,  SELF.ln_fares_id := LEFT.ln_fares_id, SELF := LEFT)); 
		
		ds_fids_with_input := JOIN(ds_just_dids, ds_fids_by_did2,
				LEFT.did = RIGHT.search_did, TRANSFORM(BenefitAssessment_Services.Layouts.rec_propFidsOnInput, 
				SELF := LEFT, SELF := RIGHT), LEFT OUTER, LIMIT(Constants.MAX_RECS, SKIP));
		//get the deeds and assessments for each fares id - suppression applied in this function
		ds_prop_search_out := LN_PropertyV2_Services.resultFmt.widest_view.get_by_sid(ds_fids_by_did2,,,nonSS,isFCRA);
		
		//attach acctno to the deeds and assessments
		ds_searched_prop_acctno := JOIN(ds_fids_with_input, ds_prop_search_out,
			LEFT.ln_fares_id = RIGHT.ln_fares_id, 
			TRANSFORM(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno, SELF.acctno := LEFT.acctno, SELF := RIGHT) , LIMIT(Constants.MAX_RECS, SKIP));
			
			// output(ds_just_dids,named('ds_just_dids'));
			// output(ds_fids_by_did2,named('ds_fids_by_did2'));
			// output(ds_fids_with_input,named('ds_fids_with_input'));
			// output(ds_prop_search_out,named('ds_prop_search_out'));
			// output(ds_searched_prop_acctno,named('ds_searched_prop_acctno'));
		
		RETURN ds_searched_prop_acctno;
	END;
	
	EXPORT GetCurrentPropHits(DATASET(BenefitAssessment_Services.Layouts.rec_inputWithSearchID) ds_input_with_searchids, 
														DATASET(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno) ds_searched_prop_acctno,
														DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_input,
														boolean isFCRA = false,
														BenefitAssessment_Services.IParam.batch_params configData) := function
		
		ds_deeds := PROJECT(ds_searched_prop_acctno(fid_type = LN_PropertyV2_Services.consts.FID_TYPE_DEED), 
										Transforms.MakeDeedFlat(LEFT));
		//order by addresses and dates then dedupe by address
		ds_sorted_owners := DEDUP(SORT(ds_deeds, acctno,
			Curr_Property_address, Curr_Property_Zip, -(UNSIGNED) Curr_sortby_date),
			acctno, Curr_Property_address, 
			Curr_Property_Zip);
	 //join input to the deed hits
		ds_owners_with_input := JOIN(ds_sorted_owners, ds_input_with_searchids, 
			LEFT.acctno = RIGHT.acctno AND
				((LEFT.ossn1 = RIGHT.Input_SSN and 
				LEFT.ofname1 = RIGHT.Input_name_first AND LEFT.oLname1 = RIGHT.Input_name_last) OR
				(LEFT.ossn2 = RIGHT.Input_SSN and 
				LEFT.ofname2= RIGHT.Input_name_first AND LEFT.oLname2 = RIGHT.Input_name_last)),
			TRANSFORM(BenefitAssessment_Services.Layouts.rec_propOwnerOnInput, 
						SELF.Current_Property_Owned_OOS := If(left.acctno != '', MAP(RIGHT.input_state = '' => '',
							LEFT.Curr_Property_St = RIGHT.INPUT_STATE => 'Y',
							'N'),'');
						SELF := RIGHT, 
						SELF := LEFT),
						LIMIT(Constants.MAX_RECS, SKIP));
		//get the non-deeds hits into the format to look for assessments
		ds_ass_of_nondeeds := JOIN(ds_owners_with_input, ds_searched_prop_acctno, 
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno, SELF := RIGHT), LIMIT(Constants.MAX_RECS, SKIP)/*, RIGHT ONLY*/);
		//search for assessments for non-deeds
		ds_assmts := PROJECT(ds_ass_of_nondeeds(fid_type = LN_PropertyV2_Services.consts.VENDOR_FARES), 
											BenefitAssessment_Services.Transforms.MakeAssessmentFlat(LEFT));
		//order by addresses and dates then dedupe by address
		ds_sorted_assmts := DEDUP(SORT(ds_assmts, acctno,
			Curr_Property_address, Curr_Property_Zip, -Curr_sortby_date), 
			acctno, Curr_Property_address, 
			Curr_Property_Zip);
		//join input to the assessment hits
		ds_assmts_with_input := JOIN(ds_sorted_assmts, ds_input_with_searchids, 
			LEFT.acctno = RIGHT.acctno AND
				((LEFT.ossn1 = RIGHT.Input_SSN and 
				LEFT.ofname1 = RIGHT.Input_name_first AND LEFT.oLname1 = RIGHT.Input_name_last) OR
				(LEFT.ossn2 = RIGHT.Input_SSN and 
				LEFT.ofname2= RIGHT.Input_name_first AND LEFT.oLname2 = RIGHT.Input_name_last)),
			TRANSFORM(BenefitAssessment_Services.Layouts.rec_propOwnerOnInput, 
						SELF.Current_Property_Owned_OOS := MAP(RIGHT.input_state = '' => '',
							LEFT.Curr_Property_St = RIGHT.INPUT_STATE => 'Y',
							'N');
						SELF := RIGHT, 
						SELF := LEFT), LIMIT(Constants.MAX_RECS, SKIP));
		ds_owners_with_inputTMP :=	ds_owners_with_input + ds_assmts_with_input;
		ds_owners_with_input2 := JOIN(ds_owners_with_inputTMP, ds_input_with_searchids,
																	LEFT.acctno = RIGHT.acctno,
																			TRANSFORM(BenefitAssessment_Services.Layouts.rec_propOwnerOnInput, 
																					SELF := LEFT, 
																					SELF := RIGHT), 
																					LEFT OUTER, LIMIT(Constants.MAX_RECS, SKIP));
		ds_sorted_owners_with_input := SORT(ds_owners_with_input2, acctno, -(UNSIGNED) Curr_Total_Property_Value, -(UNSIGNED) Curr_sortby_date);
			
		prop_rec_count := IF(configData.property_return_count > Constants.max_property_return_count or configData.property_return_count <= 0,
				Constants.default_property_return_count, configData.property_return_count);				
	
		ds_input_w_acctno := PROJECT(ds_sorted_owners_with_input, 
														TRANSFORM(BenefitAssessment_Services.layouts.prop_curr_w_acctno, 
																SELF := LEFT, SELF := []));	
	
		// TOPN is used to limit the dataset to the number of records specified by the input parameter
		// PropertyReturnCount.  It is done this way because the counter passed to the DeNorm macro
		// must be a constant.
		ds_in_grouped := TOPN(GROUP(SORT(ds_input_w_acctno, acctno), acctno), prop_rec_count, acctno);
			
		ds_curr_denormed := BatchShare.MAC_ExpandLayout.Denorm(ds_input,
																													 ds_in_grouped,
																													 BenefitAssessment_Services.layouts.prop_curr_flat,
																													 '',
																													 BenefitAssessment_Services.Constants.max_property_return_count);
		
		BenefitAssessment_Services.Layouts.temp_cumulative_rec xform_w_cnt(
																BenefitAssessment_Services.Layouts.temp_cumulative_rec le) := TRANSFORM
			
			SELF.curr_prop_cnt := (UNSIGNED1)(le.Curr_Property_address1<>'')+
														(UNSIGNED1)(le.Curr_Property_address2<>'')+
														(UNSIGNED1)(le.Curr_Property_address3<>'')+
														(UNSIGNED1)(le.Curr_Property_address4<>'')+
														(UNSIGNED1)(le.Curr_Property_address5<>'');
			SELF := le;
			
		END;
		
		ds_props_with_total := PROJECT(ds_curr_denormed, xform_w_cnt(LEFT));
		ds_curr_output := ds_props_with_total + ds_input(DeceasedMatchCode != '' OR
											Incarcerated_Flag = '1');
											
		ds_curr_out := JOIN(ds_input, ds_curr_output,
												LEFT.acctno = RIGHT.acctno,
															TRANSFORM(BenefitAssessment_Services.layouts.temp_cumulative_rec, SELF := LEFT),	
																	LEFT ONLY);
																	
		ds_curr := 	ds_curr_out + ds_curr_output;
			
		// output(ds_searched_prop_acctno,named('ds_searched_prop_acctno'));		
		// output(ds_input,named('ds_input'));		
		// output(ds_deeds,named('ds_deeds'));		
		// output(ds_sorted_owners,named('ds_sorted_owners'));		
		// output(ds_input_with_searchids,named('ds_input_with_searchids'));		
		// output(ds_owners_with_input,named('ds_owners_with_input'));		
		 // output(ds_ass_of_nondeeds,named('ds_ass_of_nondeeds'));		
		// output(ds_assmts,named('ds_assmts'));		
		// output(ds_sorted_assmts,named('ds_sorted_assmts'));		
		// output(ds_assmts_with_input,named('ds_assmts_with_input'));		
		// output(ds_owners_with_inputTMP,named('ds_owners_with_inputTMP'));		
		// output(ds_owners_with_input2,named('ds_owners_with_input2'));		
		// output(ds_sorted_owners_with_input,named('ds_sorted_owners_with_input'));		
		// output(prop_rec_count,named('prop_rec_count'));		
		// output(ds_input_w_acctno,named('ds_input_w_acctno'));		
		// output(ds_in_grouped,named('ds_in_grouped'));		
		
		

		RETURN ds_curr;
	END;
	
	EXPORT GetPriorPropHits(DATASET(BenefitAssessment_Services.Layouts.rec_inputWithSearchID) ds_input_searchids, 
													DATASET(BenefitAssessment_Services.Layouts.rec_propOutWithAcctno) ds_prop_searched_acctno,
													DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_input,
													boolean isFCRA = false,
													BenefitAssessment_Services.IParam.batch_params configData) := function
	
		daysOfmaxPropertiesTransferred :=  if(configData.property_transfer_period <= 0, 365, 
																					if(configData.property_transfer_period >= 84, 2555,
																						roundup(configData.property_transfer_period/12)*365));
		todays_yyyymm := ut.GetDate[1..6];		

		ds_sellers := PROJECT(ds_prop_searched_acctno(fid_type = LN_PropertyV2_Services.consts.FID_TYPE_DEED), 
											BenefitAssessment_Services.Transforms.MakeSellerDeedFlat(LEFT));
	
		ds_sorted_sellers := DEDUP(SORT(ds_sellers, acctno, 
			Prior_Property_address, Prior_Property_Zip, -(UNSIGNED) Prior_sortby_date),
			acctno, Prior_Property_address, 
			Prior_Property_Zip);				
			
		ds_sellers_with_input := JOIN(ds_sorted_sellers, ds_input_searchids,
				LEFT.acctno = RIGHT.acctno AND ((LEFT.ossn1 = RIGHT.Input_SSN and 
				LEFT.ofname1 = RIGHT.Input_name_first AND LEFT.oLname1 = RIGHT.Input_name_last) OR
				(LEFT.ossn2 = RIGHT.Input_SSN and 
				LEFT.ofname2= RIGHT.Input_name_first AND LEFT.oLname2 = RIGHT.Input_name_last)),
			TRANSFORM(BenefitAssessment_Services.Layouts.rec_propSellerOnInput, 
						SELF.Prior_Property_Owned_OOS := MAP(RIGHT.input_state = '' => '',
							LEFT.Prior_Property_St = RIGHT.INPUT_STATE => 'Y',
							'N');
						SELF.Recent_Property_Transfer :=  MAP(LEFT.Prior_sortBy_Date = '' => '',
							ut.DaysApart(LEFT.Prior_SortBy_Date, todays_yyyymm) <= daysOfmaxPropertiesTransferred => 'Y', 'N'); 					
						SELF := RIGHT,  
						SELF := LEFT), LIMIT(Constants.MAX_RECS, SKIP));
						
		ds_sorted_sellers_with_input := SORT(ds_sellers_with_input, acctno, -(UNSIGNED) Prior_Total_Property_Value, -(UNSIGNED) Prior_sortby_date);						
		
		prop_rec_count := if(configData.property_return_count > Constants.max_property_return_count or configData.property_return_count <= 0,
			Constants.default_property_return_count, configData.property_return_count);

		ds_prior_w_acctno := PROJECT(ds_sorted_sellers_with_input, 
														TRANSFORM(BenefitAssessment_Services.layouts.prop_prior_w_acctno,
																SELF := LEFT, SELF := []));

		// TOPN is used to limit the dataset to the number of records specified by the input parameter
		// PropertyReturnCount.  It is done this way because the counter passed to the DeNorm macro
		// must be a constant.
		ds_in_grouped :=  TOPN(GROUP(SORT(ds_prior_w_acctno, acctno), acctno), prop_rec_count, acctno);
		
		ds_seller_denormed := BatchShare.MAC_ExpandLayout.Denorm(ds_input,
																													   ds_in_grouped,
																													   BenefitAssessment_Services.layouts.prop_prior_flat,
																													   '',
																													   BenefitAssessment_Services.Constants.max_property_return_count);
		RETURN ds_seller_denormed;
	END;

EXPORT GetCrimDerogHits(DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_input,
				boolean isFCRA = false,
				BatchShare.IParam.BatchParams config_Data) := FUNCTION 	
		ds_crimderog_input := PROJECT(ds_input(DeceasedMatchCode = '' and Incarcerated_Flag != '1'), Transforms.MakeCrimDerogInput(LEFT));		
		crim_config := module(project(config_Data, CriminalRecords_BatchService.IParam.batch_params, opt)); end;
		ds_tmp_crimderog_hits_all := CriminalRecords_BatchService.BatchRecords(crim_config, ds_crimderog_input, isFCRA);		
		ds_tmp_crimderog_hits := ds_tmp_crimderog_hits_all.Records;
	//we only want misdemeanors and felonies that have a stc_dt_1 populated
		ds_felony_misdemeanor := ds_tmp_crimderog_hits((off_typ_1 = 'M' OR off_typ_1 = 'F') AND stc_dt_1 != '');
		ds_crimderog_hits := JOIN(ds_input, ds_felony_misdemeanor,
										LEFT.acctno = RIGHT.acctno, 
										Transforms.SetCrimDerogHits(LEFT, RIGHT),
										INNER, LIMIT(Constants.MAX_RECS, SKIP));								
		ds_tmp_crim_derog_hits := DEDUP(SORT(ds_crimderog_hits, acctno, -process_date), acctno);	
		ds_crim_derog_hits := JOIN(ds_input,	ds_tmp_crim_derog_hits, 
					LEFT.acctno = RIGHT.acctno, 
					Transforms.AddonCrimDerogHits(LEFT, RIGHT),
					LEFT OUTER, LIMIT(Constants.COUNT_IN_RECS, SKIP));
					
		RETURN ds_crim_derog_hits;
	END;

EXPORT GetFamilyComp(DATASET(BenefitAssessment_Services.Layouts.layout_batch_out_plus) ds_input,
				boolean isFCRA = false,	
				BenefitAssessment_Services.IParam.batch_params Config_data,
				DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION	

		ds_familycomp_input := ds_input(DeceasedMatchCode = '' and Incarcerated_Flag != '1');
		ds_familycomp_dids:= PROJECT(ds_familycomp_input, doxie.layout_references);			
		
		ds_best_addresses := FCRA.comp_subject(ds_familycomp_dids, Config_data.DPPAPurpose,
						Config_data.GLBPurpose, false, , ,, ds_flags);

    // *** Beginning of 01/31/2017 changes to use a new key for the Gov Best Addr/Addr_rank process
		// Similar to changes made in Address_Rank.fn_getAddressHistory

	  // Instead of using the header addr_rank key, use a new key via an interface/function, 
	  // which will take in a dataset of dids only.
	  ds_best_addrs_did_dd := DEDUP(SORT(PROJECT(ds_best_addresses.addresses,doxie.layout_references),
		                                   did),did);

	  ds_append_addr_ind_recs := Header.Append_addr_ind(ds_best_addrs_did_dd
																										  , //bypassTU? use default=false
																										  , //returnInsAdr? use default=false 
																										  , //returnDates? use default=false 
																										  , //slimOutput? default=false 
																										  ,TRUE  //isFCRA?
																										 );

		//get only the one best ranked address per did
		ds_best_addr := JOIN(ds_best_addresses.addresses, ds_append_addr_ind_recs,
										LEFT.did 	        = RIGHT.did         AND
										LEFT.prim_range 	= RIGHT.prim_range 	AND
										LEFT.predir 			= RIGHT.predir 			AND
										LEFT.prim_name 		= RIGHT.prim_name 	AND
										LEFT.suffix 			= RIGHT.addr_suffix	AND
										LEFT.postdir 			= RIGHT.postdir 		AND
										LEFT.sec_range 		= RIGHT.sec_range 	AND
										LEFT.zip 					= RIGHT.zip
										,
										LIMIT(0), KEEP(1),LEFT OUTER) ;                                                                                                               

		grecs   		:= GROUP(DEDUP(SORT(ds_best_addr, did, addr_ind, best_addr_rank),
		                           did, addr_ind),
												 did);

  // Uncomment as needed for debugging 
	// ", EXTEND" added??? due to compiler error, but displays confusing results	when running the query
	//OUTPUT(ds_best_addresses.addresses, named('bas_raw_ds_best_addresses')); //, EXTEND);
	//OUTPUT(ds_best_addr, named('bas_raw_ds_best_addr')); //, EXTEND);
	//OUTPUT(grecs,        named('bas_raw_grecs')); //, EXTEND);

		//since FCRA it will only return data in last 7 years but should verify that is true
		current_date := ut.GetDate;
		days_7_years := ut.DaysInNYears(7); 
		//choose the best ranked address per did
		topAddrs := TOPN(grecs(ut.DaysApart (current_date, (STRING8)dt_last_seen) <= days_7_years),1, 
		                 did, addr_ind); 
    // *** End of 01/31/2017 changes to use a new key for the Gov Best Addr/Addr_rank process

		best_rec := project(topAddrs, recordof(ds_best_addresses.addresses));

		ds_all_recs_with_bestaddr := JOIN(ds_input, best_rec ,
																			LEFT.did = RIGHT.did,
																			Transforms.SetBestADLHits(LEFT, RIGHT),
																			LEFT OUTER, LIMIT(0), KEEP (1));		
	//OUTPUT(best_rec, named('bas_raw_best_rec')); //, EXTEND);
	//OUTPUT(ds_all_recs_with_bestaddr,  named('bas_raw_ds_all_recs_wba')); //, EXTEND);

		//get the adults living at the input address with the last year from today
		addr_info :=JOIN(ds_familycomp_input, doxie.Key_FCRA_Header_Address,
											LEFT.Input_z5 !='' AND LEFT.Input_Prim_Name != '' AND KEYED(LEFT.Input_Prim_Name=RIGHT.prim_name) AND 
											KEYED(LEFT.Input_z5=RIGHT.zip) AND KEYED(LEFT.Input_Prim_Range=RIGHT.prim_range) AND 
											KEYED(LEFT.Input_Sec_Range=RIGHT.sec_range) AND
											RIGHT.dob != 0 AND ut.DaysApart(ut.GetDate, (STRING8) RIGHT.dt_last_seen) <= ut.DaysInNYears(1) and
											ut.DaysApart(ut.GetDate, (STRING8) RIGHT.dob) >= ut.DaysInNYears(18) AND RIGHT.did != 0,
											TRANSFORM(layouts.Addr_info, SELF.Acctno := LEFT.Acctno, 
													SELF.dids_per_addr := 1, SELF := RIGHT),
											LIMIT(BenefitAssessment_Services.Constants.MAX_RECS, SKIP));			
		ds_dedup_addr := DEDUP(SORT(addr_info, acctno, did), acctno, did);
		//counts per did at each acctno
		tbl_addr := TABLE(ds_dedup_addr, {acctno, _dids_per_addr := count(group, dids_per_addr>0)}, acctno);
		//we have all the hit info on ds_all_recs_with_bestaddr so now just append on the adult count
		ds_family_comp_hits := JOIN(ds_all_recs_with_bestaddr, tbl_addr,
																LEFT.ACCTNO = RIGHT.Acctno,
																TRANSFORM(BenefitAssessment_Services.Layouts.layout_batch_out_plus, 	
																	did_cnt := (STRING2) RIGHT._dids_per_addr;
																	SELF.num_adults_input_addr := IF(did_cnt = '0', '', did_cnt);
																	SELF := LEFT),
																LEFT OUTER, LIMIT(0), KEEP(1));
		RETURN ds_family_comp_hits;
	END;

	EXPORT GetProfLics(DATASET(doxie.layout_references) in_dids, DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_cumulative, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		l:=BenefitAssessment_Services.Layouts;
		c:=BenefitAssessment_Services.Constants;

		proflic_recs := RiskWiseFCRA._Prof_License_data(in_dids, ds_flags,,c._7_Year_Filter);
		
    proflic_recs_deduped := DEDUP(SORT(proflic_recs, did, prolic_key, -date_last_seen), did, prolic_key);		
		
    //repopulate acctno for Denorm
		proflic_recs_with_acctno := JOIN(ds_cumulative,proflic_recs_deduped,
														         LEFT.did = RIGHT.did,
														         TRANSFORM(l.prof_lic_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));
		//displaying max of 3 most recent records per acctno												
		proflic_recs_sorted := TOPN(GROUP(SORT(proflic_recs_with_acctno,acctno,-date_last_seen),acctno),c.MAX_FLAT_RECS,acctno,-date_last_seen);
 
		all_with_prof_lics := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, proflic_recs_sorted, l.pl_main);

		// output(proflic_recs,named('profLics'));
		// output(proflic_recs_deduped,named('proflic_recs_deduped'));
		// output(proflic_recs_with_acctno,named('proflic_recs_with_acctno'));
		// output(proflic_recs_sorted,named('proflic_recs_sorted'));
		// output(all_with_prof_lics,named('all_with_prof_lics'));

		RETURN all_with_prof_lics;
	END;
	
	EXPORT GetPaw(DATASET(doxie.layout_references) in_dids, DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_cumulative, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		l:=BenefitAssessment_Services.Layouts;
		c:=BenefitAssessment_Services.Constants;

		paw_recs := RiskWiseFCRA._PAW_data(in_dids, ds_flags,c._12_Month_Filter);
		
		paw_recs_deduped := DEDUP(SORT(paw_recs((unsigned2)score>=15), did, contact_id, -dt_last_seen), did, contact_id);
		
    //repopulate acctno for Denorm
		paw_recs_with_acctno := JOIN(ds_cumulative,paw_recs_deduped,
												         LEFT.did = RIGHT.did,
												         TRANSFORM(l.paw_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));
		//displaying max of 3 most recent records per acctno								
		paw_recs_sorted := TOPN(GROUP(SORT(paw_recs_with_acctno,acctno,-dt_last_seen),acctno),c.MAX_FLAT_RECS,acctno,-dt_last_seen);

		all_with_paw := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, paw_recs_sorted, l.paw_main);
					
		// output(paw_recs,named('paw_recs'));
		// output(paw_recs_deduped,named('paw_recs_deduped'));
		// output(paw_recs_with_acctno,named('paw_recs_with_acctno'));
		// output(paw_recs_sorted,named('paw_recs_sorted'));
		// output(all_with_paw,named('all_with_paw'));

		RETURN all_with_paw;
	END;
	
	EXPORT GetWc(DATASET(doxie.layout_references) in_dids, DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_cumulative, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		l:=BenefitAssessment_Services.Layouts;
		c:=BenefitAssessment_Services.Constants;

		wc_recs := RiskWiseFCRA._watercraft_data(in_dids, ds_flags,,c._7_Year_Filter).owners;
		
		wc_recs_deduped := DEDUP(SORT(wc_recs, did, state_origin, watercraft_key[1..10], -sequence_key), did, state_origin, watercraft_key[1..10]);
		
    //repopulate acctno for Denorm
		wc_recs_with_acctno := JOIN(ds_cumulative,wc_recs_deduped,
														    LEFT.did = (unsigned6)RIGHT.did,
													    	TRANSFORM(l.wc_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));
		//displaying max of 3 most recent records per acctno													
		wc_recs_sorted := TOPN(GROUP(SORT(wc_recs_with_acctno,acctno,-date_last_seen),acctno),c.MAX_FLAT_RECS,acctno,-date_last_seen); //displaying max of 3 most recent records
		
		all_with_wc := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, wc_recs_sorted, l.wc_main);
		
		// output(wc_recs,named('wc_recs'));
		// output(wc_recs_deduped,named('wc_recs_deduped'));
		// output(wc_recs_with_acctno,named('wc_recs_with_acctno'));
		// output(wc_recs_sorted,named('wc_recs_sorted'));
		// output(all_with_wc,named('all_with_wc'));

		RETURN all_with_wc;
	END;
	
	EXPORT GetAc(DATASET(doxie.layout_references) in_dids, DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_cumulative, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		l:=BenefitAssessment_Services.Layouts;
		c:=BenefitAssessment_Services.Constants;
		
		ac_recs := RiskWiseFCRA._FAA_data(in_dids, ds_flags, c._7_Year_Filter).aircrafts;
		
		ac_recs_deduped := DEDUP(SORT(ac_recs(current_flag=c.ac_ACTIVE), did_out, serial_number, -date_last_seen), did_out, serial_number);		
		
		//repopulate acctno for Denorm
		ac_recs_with_acctno := JOIN(ds_cumulative,ac_recs_deduped,
														LEFT.did = (unsigned6)RIGHT.did_out,
														TRANSFORM(l.ac_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));
    //displaying max of 3 most recent records per acctno
		ac_recs_sorted  := TOPN(GROUP(SORT(ac_recs_with_acctno,acctno,-date_last_seen),acctno),c.MAX_FLAT_RECS,acctno,-date_last_seen);
			
		all_with_ac := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, ac_recs_sorted, l.ac_main);

		// output(ac_recs,named('ac_recs'));
		// output(ac_recs_deduped,named('ac_recs_deduped'));
		// output(ac_recs_with_acctno,named('ac_recs_with_acctno'));
		// output(ac_recs_sorted,named('ac_recs_sorted'));
		// output(all_with_ac,named('all_with_ac'));

		RETURN all_with_ac;
	END;
	
	EXPORT GetBankrupties(DATASET(doxie.layout_references) in_dids, DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_cumulative, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		l:=BenefitAssessment_Services.Layouts;
		c:=BenefitAssessment_Services.Constants;
		
		RiskWiseFCRA._Bankruptcy_data(in_dids, ds_flags, bk_search, bk_main, bk_court, , bk_withdraw); //retruns b records with unique orig_case_number not older than last 10 years of the date_filed
		
    bk_search_deduped := dedup(sort(bk_search((name_type=c.l_DEBTOR), (unsigned6)did<>0),did, tmsid, court_code, case_number, -date_filed),did, tmsid, court_code, case_number, chapter);	
		bk_main_deduped   := dedup(sort(bk_main, tmsid, court_code, case_number, -date_filed), tmsid, court_code, case_number, orig_chapter);	
		
		//set correct did and get values from bk_main										
		b_recs_debtor_main := JOIN(bk_search_deduped,bk_main_deduped,
															 Left.tmsid = Right.tmsid,
															 TRANSFORM(l.b_with_acctno, SELF.debtor_did := (unsigned6)LEFT.did,
																													SELF.acctno :='', //gets set in next join
																													SELF := RIGHT));
		//repopulate acctno for Denorm
		b_recs_with_acctno := JOIN(ds_cumulative,b_recs_debtor_main,
													   	 LEFT.did = RIGHT.debtor_did,
														   TRANSFORM(l.b_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));
		
		//displaying max of 3 most recent records per acctno
		b_recs_sorted  := TOPN(GROUP(SORT(b_recs_with_acctno,acctno,-date_filed),acctno),c.MAX_FLAT_RECS,acctno,-date_filed);
			
		all_with_b := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, b_recs_sorted, l.b_main);
		
		// output(bk_search,named('bk_search'));	
		// output(bk_main,named('bk_main'));	
		// output(bk_search_deduped,named('bk_search_deduped'));	
		// output(bk_main_deduped,named('bk_main_deduped'));	
		// output(b_recs_debtor_main,named('b_recs_debtor_main'));	
		// output(b_recs_with_acctno,named('b_recs_with_acctno'));	
		// output(b_recs_sorted,named('b_recs_sorted'));
		// output(all_with_b,named('all_with_b'));

		RETURN all_with_b;
	END;
	
	EXPORT GetMarDiv(DATASET(BenefitAssessment_Services.Layouts.layout_batch_out_plus) ds_cumulative, BenefitAssessment_Services.IParam.batch_params Config_data, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		l:=BenefitAssessment_Services.Layouts;
		c:=BenefitAssessment_Services.Constants;
		t:=BenefitAssessment_Services.Transforms;
		mds:=marriage_divorce_v2_Services;
		
		//call the marriage divorce fcra service logic 
		//since the RiskWiseFCRA._MarriageDivorce_data does not return the data in party1 and party2 format
		md_in := PROJECT(ds_cumulative,TRANSFORM(mds.layouts.batch_in, SELF := LEFT, SELF := []));
		
		batch_params := module (project (Config_data, mds.input.batch_params, opt))
			export integer1 non_subject_suppression := 3; //the md logic below depends on the non subject data being blank and non subject did=0
		end;
				
		md_all  := marriage_divorce_v2_Services.batch_records(batch_params,md_in,true);
		md_recs := md_all.Records;
		 
		 
		//for md, we only display records from last 7 years
		todaysdate := ut.GetDate;
		md_main_recs := PROJECT(md_recs(ut.fn_date_is_ok(todaysdate, process_date, c._7_Year_Filter)), t.set_MD_main(LEFT));
		
    //repopulate acctno for Denorm
		md_recs_with_acctno := JOIN(ds_cumulative, md_main_recs,
													     (LEFT.did = RIGHT.party_did),
													      TRANSFORM(l.md_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));
														
		//displaying max of 3 most recent records per acctno
		md_recs_sorted  := TOPN(GROUP(SORT(md_recs_with_acctno,acctno,-process_date),acctno),c.MAX_FLAT_RECS,acctno,-process_date);
			
		all_with_md := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, md_recs_sorted, l.md_main);
		
		// output(md_recs,named('md_recs'));
		// output(md_main_recs,named('md_main_recs'));
		// output(md_recs_with_acctno,named('md_recs_with_acctno'));
		// output(md_recs_sorted,named('md_recs_sorted'));
		// output(all_with_md,named('all_with_md'));

		RETURN all_with_md;
	END;
	
	// The liens & judgments section is being removed from the response for project JULI.
	// Just commenting it out in case we need to add it back later.
	// EXPORT GetLiens(DATASET(doxie.layout_references) in_dids, DATASET(BenefitAssessment_Services.Layouts.temp_cumulative_rec) ds_cumulative, DATASET(fcra.Layout_override_flag) ds_flags) := FUNCTION
		// l:=BenefitAssessment_Services.Layouts;
		// c:=BenefitAssessment_Services.Constants;
		
		//get liens_main & liens_party from the following MACRO
		// RiskWiseFCRA._Lien_data(in_dids, ds_flags, liens_main_f, liens_party_f,,,,,c._24_Month_Filter);
		
		// l_main_deduped  := DEDUP(SORT(liens_main_f, tmsid, rmsid, -orig_filing_date), tmsid, rmsid);
		// l_party_deduped := DEDUP(SORT(liens_party_f(name_type=c.l_DEBTOR), did, tmsid, rmsid, -date_last_seen),did, tmsid, rmsid);
		
		//populate and get date from main
		// l_recs_with_date := JOIN(l_party_deduped,l_main_deduped,
												    // (Left.tmsid = Right.tmsid) and (Left.rmsid = Right.rmsid),
									      	   // TRANSFORM(l.l_with_acctno, SELF.debtor_did := (unsigned6)LEFT.did,
																												// SELF.orig_filing_date := RIGHT.orig_filing_date,
																												// SELF.acctno :='', //gets set in next join
																												// SELF := LEFT));
		//repopulate acctno for Denorm
		// l_recs_with_acctno := JOIN(ds_cumulative,l_recs_with_date,
												       // LEFT.did = RIGHT.debtor_did,
												       // TRANSFORM(l.l_with_acctno, SELF.acctno := LEFT.acctno, SELF := RIGHT));

		//displaying max of 3 most recent records per acctno
		// l_recs_sorted := TOPN(GROUP(SORT(l_recs_with_acctno,acctno,-orig_filing_date),acctno),c.MAX_FLAT_RECS,acctno,-orig_filing_date);
		
		// all_with_l := BatchShare.MAC_ExpandLayout.Denorm(ds_cumulative, l_recs_sorted, l.l_main);
		
		// output(liens_main_f,named('liens_main_f'));
		// output(liens_party_f,named('liens_party_f'));
		// output(l_main_deduped,named('l_main_deduped'));
		// output(l_party_deduped,named('l_party_deduped'));
		// output(l_recs_with_date,named('l_recs_with_date'));
		// output(l_recs_with_acctno,named('l_recs_with_acctno'));
		// output(l_recs_sorted,named('l_recs_sorted'));
		// output(all_with_l,named('all_with_l'));

		// RETURN all_with_l;
	// END;
	
END;	