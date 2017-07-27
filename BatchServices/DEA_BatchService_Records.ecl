IMPORT AutokeyB2, Autokey_batch, Doxie, DEA, DEA_Services, autostandardI, census_data, batchServices, ut, Suppress;
					  
		    penalt_func_calculate(   Autokey_batch.Layouts.rec_inBatchMaster l,
				                         BatchServices.Layouts.DEA.rec_results_raw r)  := FUNCTION
				          
									tempBizMod := MODULE(PROJECT(AutoStandardI.GlobalModule(),
				                          AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
										EXPORT allow_wildcard := false;
									  EXPORT companyname := l.comp_name;									
										EXPORT cname_field := r.cname;			
										EXPORT useGlobalScope := FALSE;
                  end;
									
                   tempindvMod := MODULE(PROJECT(AutoStandardI.GlobalModule(), 
									                  AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))																
								        
								    // input individual name
										EXPORT lastname       := l.name_last;       // the 'input' last name
										EXPORT middlename     := l.name_middle;     // the 'input' middle name
										EXPORT firstname      := l.name_first;      // the 'input' first name
										EXPORT allow_wildcard := FALSE;
										
										//matching rec
										EXPORT lname_field    := r.lname;						                          
										EXPORT mname_field    := r.mname; // the middle name in the matching record
										EXPORT fname_field    := r.fname; // the first name in the matching record
																									
								end;
									
										tempAddrMod := MODULE(PROJECT(AutoStandardI.GlobalModule(), 
						                         AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
					//	The 'input' address:
										EXPORT predir         := l.predir;
										EXPORT prim_name      := l.prim_name;
										EXPORT prim_range     := l.prim_range;
										EXPORT postdir        := l.postdir;
										EXPORT addr_suffix    := l.addr_suffix;
										EXPORT sec_range      := l.sec_range;
										EXPORT p_city_name    := l.p_city_name;
										EXPORT st             := l.st;
										EXPORT z5             := l.z5;
						
						//	The address in the matching record:							
						        EXPORT allow_wildcard := FALSE;
										EXPORT city_field     := r.p_city_name;
										EXPORT city2_field    := '';
										EXPORT pname_field    := r.prim_name;
									  EXPORT postdir_field  := r.postdir;
										EXPORT prange_field   := r.prim_range;
										EXPORT predir_field   := r.predir;
										EXPORT state_field    := r.st;
										EXPORT suffix_field   := r.addr_suffix;
										EXPORT zip_field      := r.zip;								
										EXPORT useGlobalScope := FALSE;
														
									END;				
									  
						 return  AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempIndvMod) +
						         AutoStandardI.LIBCALL_PenaltyI_Biz_name.val(tempBizMod) +
						         AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempAddrMod);
						 						   
						 // represents just one row penalty.
				END;
				
				
				
BatchServices.Layouts.DEA.rec_batch_dea_input file_inDeaBatchMaster(BOOLEAN forceSeq = FALSE) := function 
//
// generic layout with dea registration number added
//
rec := BatchServices.Layouts.DEA.rec_batch_dea_input;

raw1 := DATASET([], rec) : STORED('batch_in', FEW);
raw0 := raw1 : GLOBAL;

rec tra(rec l) := TRANSFORM
	SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, (string4) BatchServices.Constants.DEA_SEQ_MAX_LIMIT);
	SELF := l;
end;

raw := PROJECT(raw0, tra(LEFT));

ut.MAC_Sequence_Records(raw, seq, raw_seq)

	dea_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);				
	
	return dea_file;
	
end;				

//////////////////////////

string splitUpDrugSchedule(string sched) := function

   split_string := ut.Stringsplit(sched, ' ');
	 
	 	s_layout := record
				string str_val;
		end;
	
	 ds := dataset(split_string, s_layout);

// this transform is needed to split out strings such as '22N' into '2 ; 2N'
// this is a requirement from the product as per how drug schedule numbers are listed
// when a string is 3 chars in length and contains an alpha char then it needs to be expanded as above.

	s_layout doTransform(s_layout l) := transform
	  trim_val := trim(l.str_val, left, right);
		self.str_val := if ((length(trim_val) = 3) AND (stringlib.stringFilter(trim_val, ut.alphabet) <> ''),	
											 trim_val[1] + ' ; ' + trim_val[2] + trim_val[3],
											 l.str_val);             																
	end;
	
	result_ds := project(ds, doTransform(left));  
	
	s_layout combine(s_layout l, s_layout r) := transform
	  self.str_val := l.str_val + ' ; ' + r.str_val;
	end;
	
	result_string := rollup(result_ds, true, combine(left, right));	
	return (result_string[1].str_val);
	
end;

EXPORT DEA_BatchService_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION
		
		// 1. Define values for obtaining autokeys and payloads.	
				
		c				:= DEA.Constants('');
		ak_keyname    := c.ak_qaname;
		ak_dataset		:= dataset([],BatchServices.Layouts.DEA.layout_Index);
	
		ak_skipSet		:= c.skip_Set;
		ak_typeStr		:= c.ak_typeStr;
		
		UNSIGNED4 tmp_max_results_per_acct := 100 : STORED('max_results_per_acct');
		
		UNSIGNED4 max_results_per_acct :=  IF ( tmp_max_results_per_acct > 1000, 1000, 
				                                           tmp_max_results_per_acct
				                                           ); 
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		
		string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(AutoStandardI.GlobalModule(),
		                 AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
                             

		// 2. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export skip_set        := ak_skipset;
			// penalt value reference below to slim off results taken from penaltthreshold
			// defined in the interface here
			
		END;

		sample_dea_set := BatchServices._Sample_inBatchMaster('DEA');
		
	  test_dea_recs := PROJECT(sample_dea_set, TRANSFORM(
		                                         BatchServices.Layouts.DEA.rec_batch_dea_input,
		                                               SELF.dea_registration_number := LEFT.filing_number;
		                                               SELF := LEFT));

		// 3. Grab the input XML and throw into a dataset.	
		ds_batch_in_dea := IF (NOT useCannedRecs, 		                 
													file_inDeaBatchMaster(forceSeq := FALSE),
													test_dea_recs
											  );	
											
    // 4 move raw input into layout to pass to autokeys.
		ds_batch_in := PROJECT(ds_batch_in_dea, Autokey_batch.Layouts.rec_inBatchMaster);
		                                                        															
											
		// 5. Get autokeys based on batch input.
		ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
				
		// 6. Get fakeids via autokey payload (outPLfat).
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outPLfat, indid, inbdid, ak_typeStr )
		
		// 7. project payload into layout for output 
		ds_acctnos_Dea_Registration_Number_from_ak_payload := PROJECT( outPLfat, BatchServices.Layouts.DEA.rec_results_raw);
		                                     			
		
		ds_acctnos_Dea_Registration_Number_deduped := DEDUP(SORT(ds_acctnos_Dea_Registration_Number_from_ak_payload, 
																					               acctno,  Dea_Registration_Number),																					 
		                                                     acctno,  Dea_Registration_Number);																								 
		
		// keep dea registration number from any input data (test or real) for later joining.
		raw_in_dea_registration_number := PROJECT( ds_batch_in_dea, TRANSFORM(
		                                             BatchServices.Layouts.DEA.rec_results_raw,
																								  SELF.dea_registration_number := LEFT.dea_registration_number;
																									self.acctno := LEFT.acctno;
																									self.deepdive := false;
																									SELF := []));					
										
    // return layout is doxie.layout_references_acctno										
    ds_acctnos_and_dids := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in)(did != 0);																									
		
    // 8. Match ds_acctnos_Dea_Registration_Number against a slim DEA key.
    ds_from_did := JOIN(  ds_acctnos_and_dids,
			                      DEA.Key_Dea_did,
			                    KEYED(LEFT.did = RIGHT.my_did),
														TRANSFORM(
														 BatchServices.Layouts.DEA.rec_results_raw,
															 SELF.acctno := LEFT.acctno,
															 SELF.did := (string12) LEFT.did,
															 self.deepDive := true;
															 SELF := RIGHT, // sets dea registration number for later join.
															 
															 SELF := []), LIMIT(BatchServices.Constants.DEA_SERVICE_JOIN_LIMIT, SKIP));
													
    ds_did_set := IF (ak_config_data.RunDeepDive, ds_from_did);			
		
		dea_num_combined := ds_acctnos_Dea_Registration_Number_deduped + raw_in_dea_registration_number 
		                            + ds_did_set;
																													
    ds_dea_reg_num_recs_dedup := dedup(sort(dea_num_combined, acctno, dea_registration_number, expiration_date), 
		                                          acctno, dea_registration_number, expiration_date);
				
		ds_dea_reg_num_recs := JOIN(ds_dea_reg_num_recs_dedup,
															  DEA.Key_dea_reg_num,
		                           KEYED(LEFT.dea_registration_number = RIGHT.dea_registration_number),		                        											
               								 TRANSFORM(BatchServices.Layouts.DEA.rec_results_raw, 
															    SELF.acctno := LEFT.acctno;
																	SELF.deepdive := LEFT.deepdive;
																	SELF := RIGHT), LIMIT(BatchServices.Constants.DEA_SEQ_MAX_LIMIT,SKIP));

     ds_dea_reg_num_recs_slim := dedup(sort(ds_dea_reg_num_recs, 
		                                          acctno, lname, fname, prim_name, prim_range, zip, best_ssn,  dea_registration_number, drug_schedules, expiration_date),
																							acctno, lname, fname, prim_name, prim_range, zip, best_ssn,  dea_registration_number, drug_schedules, expiration_date);

     // do pull id's here cause in order to get get all recs pulled in case input is by dea_registration_number only
		 // also do suppression and masking of ssn's as well.
		 
		 Suppress.MAC_Suppress(ds_dea_reg_num_recs_slim,ds_dea_reg_num_recs_slim_pulled,appType,Suppress.Constants.LinkTypes.DID,did);
		 
		  Suppress.MAC_Suppress(ds_dea_reg_num_recs_slim_pulled,ds_dea_reg_num_recs_slim_SSN,
														appType,Suppress.Constants.LinkTypes.SSN,best_ssn);
									
			Suppress.MAC_Mask(ds_dea_reg_num_recs_slim_SSN, ds_dea_reg_num_recs_slim_SSN_MASKED,
												best_ssn, null, true, false);																
			
		// 9. do pentalization													
    BatchServices.Layouts.DEA.rec_results_raw_penalty 
		                            xform_penalt( BatchServices.Layouts.DEA.rec_results_raw r,
																							Autokey_batch.Layouts.rec_inBatchMaster l)
																             
																:= TRANSFORM
                                   self.drug_schedules :=  splitUpDrugSchedule(r.drug_schedules);																				 																	
																	 SELF.penalt := if (r.DeepDive,0, penalt_func_calculate(l, r));
																	 SELF.county_fips := TRIM(r.county[3..5],LEFT,RIGHT); // setup for county name conversion
                                   SELF := r															 																	 
																END;
																			                          		
		ds_dea_recs_pentalized := join(ds_dea_reg_num_recs_slim_SSN_MASKED, ds_batch_in,
		                                 left.acctno = right.acctno,
		                                 xform_penalt(left, right), keep(1), limit(0)); 
		
		ds_dea_recs_pentalized_slim := ds_dea_recs_pentalized(penalt <= ak_config_data.PenaltThreshold);
															
    // put county names in the output data.															
    census_data.MAC_Fips2County_Keyed(ds_dea_recs_pentalized_slim, st, county_fips, County_name, ds_dea_recs_countyname);
		    						
    // sort recs by reverse chronological by expiration_date					
		// TODO : add in the -if (deepdive, 1, 0) to push deep dive recs to the back of the pack
	  ds_results_grouped := GROUP(SORT(ds_dea_recs_countyname, acctno, if(deepDive,1,0), penalt, -expiration_date, record), acctno);
		
    ds_results_grouped_TOPX := TOPN(ds_results_grouped, max_results_per_acct, acctno);
 
    // 10. At this point, 'flatten' the resultant records into the specified output layout using ostensibly															
    ds_results_rolled_flat := ROLLUP(ds_results_grouped_TOPX, GROUP, xfm_DEA_make_flat(LEFT,ROWS(LEFT)));
		//ds_results_rolled_flat := project(ds_dea_registration_number_recs, xfm_DEA_make_flat(LEFT, ROWS(LEFT)));
		
	  // output(ds_acctnos_Dea_Registration_Number_from_ak_payload, named('ds_from_ak_payload'));
		//OUTPUT(ds_fids, NAMED('DS_FIDS'));
		// output(outPLfat, named('outPLfat'));
		// output(ds_Dea_reg_num_recs, named('ds_Dea_reg_num_recs'));
		 //output(ds_dea_recs_pentalized, named('ds_dea_recs_pentalized'));
		 // output(ds_dea_recs_countyname, named('ds_dea_recs_countyname'));
		 // output(ds_dea_reg_num_recs_slim_pulled, named('ds_dea_reg_num_recs_slim_pulled'));
		// output(ds_dea_recs_pentalized, named('ds_dea_recs_pentalized'));
	//	output(ds_results_grouped,named('ds_results_grouped'));
		// output(ds_results_rolled_flat, named('ds_results_rolled_flat'));
		// output(ds_batch_in, named('ds_batch_in'));
		// output(joinset, named('joinset'));
		// output(ds_dea_reg_num_recs_dedup, named('ds_dea_reg_num_recs_dedup'));
		 // output(ds_dea_reg_num_recs, named('ds_dea_reg_num_recs')); 
		// output(ds_acctnos_and_dids, named('ds_acctnos_and_dids'));
		// output(ds_did_set, named('ds_did_set'));
		//output(ds_dea_reg_num_recs_sorted, named('ds_dea_reg_num_recs_sorted'));
		RETURN ds_results_rolled_flat;
		
END;