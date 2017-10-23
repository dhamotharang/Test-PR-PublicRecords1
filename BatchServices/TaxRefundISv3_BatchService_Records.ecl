IMPORT Address, Address_Attributes, STD, UT, DeathV2_Services;
	
EXPORT TaxRefundISv3_BatchService_Records(
          dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in) ds_in, 
          BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in
			 ) := function

	// TRIS v3.2 Enhancement : Commenting out following boolean as Gateway call to netacuity is removed, IP_Metadata Batch service will be used instead.  
	// boolean IncludeGateway       := args_in.IncludeIPAddrGW;
	// boolean DontIncludeGateway   := NOT IncludeGateway;
	// boolean GatewaysInIsNotEmpty := Gateways_In[1].Url <> '';
	// boolean GatewaysInIsEmpty    := NOT GatewaysInIsNotEmpty;
	
  // input & output record layouts name aliases
	rec_in_wdid  := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid;
	rec_out 		 := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out;
	
  // Clean input
  ds_in_acctno   := ds_in(acctno <> ''); //Get rid of records with no acctno

	ds_clean_batch := BatchServices.TaxRefundISv3_BatchService_Functions.fnc_clean_batch(
	                                                                     ds_in_acctno);
																																			 
	// Determine whether each input record has all of the required fields to be processed.
	ds_batch_in_marked := project(ds_clean_batch,
				BatchServices.TaxRefundISv3_BatchService_Functions.xfm_in_marked(LEFT));		

	// Those records having insufficient input will be considered 'rejected'. 
	ds_having_suff_input := ds_batch_in_marked(NOT is_rejected_rec);
	ds_marked_rejected := project(ds_batch_in_marked(is_rejected_rec), 
																			transform(rec_out, 
																					self.output_status := 'Rejected',
																					self.did := (string)left.did;
																					self.score := (string)left.score;
																					self := left,
																					self := []));
																																									 																																	
	// *--- Take Input through ADL Best ---> didville.did_service_common_function ---* //
  ds_AdlBest_res := BatchServices.TaxRefundISv3_BatchService_Functions.getAdlBestInfo(
                                  ds_having_suff_input, args_in);

	// *--- Append best DID to clean input ---* //
	ds_clean_batch_w_did := join(ds_AdlBest_res, ds_having_suff_input,
											         left.seq = right.seq,
															 transform(rec_in_wdid,
																						self.did := left.did,
																				    self := right)); 
																					
	// *--- Go through Best Address/Address history batch ---* //
  ds_addrBest_res := BatchServices.TaxRefundISv3_BatchService_Functions.getBestAddress(ds_clean_batch_w_did, args_in);
   
	// *--- Run through Deceased batch service ---* //
  set_deceased_match_codes := ['ANSZC', 'ANSZ', 'ANSC', 'ANS', 'SNCZ', 'SNC', 'SNZ', 'SN', 'S'];

  death_in_mod := MODULE(project(DeathV2_Services.IParam.getBatchParams(), DeathV2_Services.IParam.BatchParams, opt))							
   			EXPORT BOOLEAN ExtraMatchCodes := TRUE;
  END;			

  //Have to translate the information into something the Death batch service can recognize.
  death_clean_batch := PROJECT(ds_clean_batch, DeathV2_Services.Layouts.BatchIn);		
  ds_death_res := DeathV2_Services.BatchRecords(death_clean_batch, death_in_mod)(matchcode in set_deceased_match_codes);	
   
	// *** TRIS v3.2 Enhancement: All the below coding no longer to be used by TRIS, Commenting out.
	// Req 4.1.30, values as mentioned in the req and as needed for checking below.
	// string8   today 		  := StringLib.getdateYYYYMMDD();
	// unsigned2 CurrentYear := (unsigned)(today[1..4]);
	// unsigned2 CYearMinus3 := CurrentYear - 3;
   
	// *--- For req 4.1.30.1, depending upon DOD existence/value and deceased matchcode, 
	// run only the records meeting the criteria through the: 
	// Bankruptcy, Driver License, Property, Vehicle & Voter Batch services.
	//
	// So first filter/sort/dedup the death batch service results since it can return more
	// than 1 record per acctno.  In case there are more than 1 rec per acctno, 
	// use the one with the highest dod and the highest filedate value.
  // ds_death_res_deduped := dedup(sort(ds_death_res(
                                        // use use deceased recs where the deceased 
																				// matchcode is not 'S' only (meaning it only matched on the SSN.)
                                        // matchcode != 'S' AND //req 4.1.30.1
																				// and the DOD year is at least 2 years back from current runtime year
                                        // (unsigned2) dod8[1..4] <= CYearMinus3 //req 4.1.30
                                        // ), // end of filter
   	                                // acctno,-dod8,-filedate),
																		// acctno);
   	
	// Next join the cleaned input ds with dids to the output ds of the death batch service 
	// that was filtered and then deduped, to only keep input recs that have a 
	// dod in the required timeframe and did not match on SSN only (matchcode='S').
  // ds_clean_batch_w_did_dod2yr := join(ds_clean_batch_w_did,ds_death_res_deduped,
                                           // left.acctno = right.acctno,
                                         // transform(left));
  
  // boolean SomeRecsHave2yrDods := exists(ds_clean_batch_w_did_dod2yr);
   
  // *--- Req 4.1.31, run input subjects matching the dod criteria through the Bankruptcy Batch Services ---* //
  // ds_bankr_res := if(SomeRecsHave2yrDods,
                        // BatchServices.TaxRefundISv3_BatchService_Functions.func_get_bankr_data(
   	                        // ds_clean_batch_w_did_dod2yr),
   									   // dataset([],BatchServices.TaxRefundISv3_BatchService_Layouts.rec_bankr_res) // else empty ds
   									  // );
   
	// NOTE: For the next 2 calls to batch sub-services, during testing when the 
	// "#STORED"s were put into the function coding, they did not seem to work. 
	// So they were put here.

	// *--- Req 4.1.32, run input subjects matching the dod criteria through the Driver License Batch Services ---* //
	// Store the 2 input options values mentioned in req 4.1.32 bullet point 1, 
	// into DL batch service global option names. 
  // ds_dl_res := if(SomeRecsHave2YrDods,
   	                // BatchServices.TaxRefundISv3_BatchService_Functions.func_get_dl_data(
   	                     // ds_clean_batch_w_did_dod2yr),

   									// dataset([],BatchServices.TaxRefundISv3_BatchService_Layouts.rec_dl_res) // else empty ds
   								 // );
  
	// *--- Req 4.1.33, run input subjects matching the dod criteria through the Property Batch Service ---* //
	// Store appropriate input options values mentioned in req 4.1.33 bullet point 1 
	// (and a few others), into property batch service global option names.
	// #STORED ('Return_Assessments',FALSE);
	// #STORED ('Return_Deeds',TRUE);
	// #STORED ('Return_Mortgages',FALSE);
	// #STORED ('Return_Owners',TRUE);
	// #STORED ('Return_Property',TRUE);
	// #STORED ('Return_Borrower',FALSE);
	// #STORED ('Return_Seller',TRUE);
	// #STORED ('Return_Care_Of',FALSE);
	// #STORED ('Max_Results_Per_Acct', 30);
	// ds_propdeed_res := if(SomeRecsHave2yrDods,
												// BatchServices.TaxRefundISv3_BatchService_Functions.func_get_propdeed_data(
														 // ds_clean_batch_w_did_dod2yr),
												// dataset([],BatchServices.TaxRefundISv3_BatchService_Layouts.rec_propdeed_res) // else empty ds
											 // );
   											 
	// *--- Req 4.1.34, run input subjects matching the dod criteria through the Vehicle Batch Service ---* //
	// Store 3 input options values mentioned in req 4.1.34 bullet point 1, 
	// into VehicleV2_Services.RealTime_Batch_ServiceV2 global option names. 
	// ds_mvr_res := if(SomeRecsHave2yrDods,
									 // BatchServices.TaxRefundISv3_BatchService_Functions.func_get_mvr_data(
												// ds_clean_batch_w_did_dod2yr),
									 // dataset([],BatchServices.TaxRefundISv3_BatchService_Layouts.rec_propdeed_res) // else empty ds
									// );
   
	// *--- Req 4.1.35, run input subjects matching the dod criteria through the Voter Batch Services ---* //
	// ds_voter_res := if(SomeRecsHave2yrDods,
										 // BatchServices.TaxRefundISv3_BatchService_Functions.func_get_voter_data(
													// ds_clean_batch_w_did_dod2yr),
										 // dataset([],BatchServices.TaxRefundISv3_BatchService_Layouts.rec_propdeed_res) // else empty ds
										// );

	// *--- Run input subjects through the Criminal Batch Services ---* //
	ds_crim_res := BatchServices.TaxRefundISv3_BatchService_Functions.getCriminalRecords(ds_clean_batch_w_did);
	
	// TRIS v3.2 Enhancement : Req# 3.1.3.1 : Following field is no longer required and needs to be blanked out.
	// ds_crim_felony_res := BatchServices.TaxRefundISv3_BatchService_Functions.getFeloniesAtAddressRecords(ds_clean_batch_w_did);

	 // Get phone info
  ds_phone_res := BatchServices.TaxRefundISv3_BatchService_Functions.getPhoneRecords(
   	                                                                   ds_clean_batch_w_did,
   																																		 args_in.dppapurpose,
   																																		 args_in.glbpurpose);
   
	// **** TRIS v3.2 Enhancement project : As per Requirement # 3.1.3.14, 3.1.4, 3.1.5, NetAcuity Gateway call will be removed and 
	//						ip metadata will be gathered by using "BatchServices.IP_Metadata_BatchService". ****
	// ds_ip_address_res := if(IncludeGateway and GatewaysInIsNotEmpty,
																											// BatchServices.TaxRefundISv3_BatchService_Functions.getIpAddressRecords(
																													// ds_clean_batch_w_did,
																													// args_in.dppapurpose, 
																													// args_in.glbpurpose,
																													// gateways_in)
																											// ,
																										 // Otherwise return an empty dataset in the layout out of 
																										 // Risk_Indicators.getNetAcuity
																											// dataset ([], riskwise.Layout_IP2O)
																								// );

	ds_ip_metadata := BatchServices.TaxRefundISv3_BatchService_Functions.getIPMetaDataRecords(ds_clean_batch_w_did);
	
	// *--- First/interim transform to combine info accumlated so far ---* //
	rec_out xformOutRecs(ds_clean_batch_w_did L) := transform
		// ADL Best info
		ssn_rec := ds_AdlBest_res(seq = L.seq)[1];

		// req 4.1.20 
		self.best_ssn := if((ssn_rec.best_ssn <> L.ssn) and (ssn_rec.score >= args_in.DIDScoreThreshold), ssn_rec.best_ssn, '');
		use_best_dob := ssn_rec.best_dob <> '' and 
										ssn_rec.best_dob <> '0' and  
										(ssn_rec.score >= args_in.DIDScoreThreshold);

		self.possible_age_dob := if (use_best_dob, (string3)ut.Age((unsigned4)ssn_rec.best_dob), '');
   
   	// req 4.1.21
   	self.did := if(ssn_rec.score >= args_in.DIDScoreThreshold, (string)L.did, '');

		// Best Address info
		addr_rec := ds_addrBest_res(acctno = L.acctno)[1];

		temp_addr_ssn_score  := if ((integer)addr_rec.ssn_score = 255, 0, (integer)addr_rec.ssn_score);
		temp_addr_name_score := if ((integer)addr_rec.name_score = 255, 0, (integer)addr_rec.name_score);
		boolean isInputAddrMatch := L.prim_range = addr_rec.prim_range and 
																L.prim_name = addr_rec.prim_name and 
																((L.p_city_name = addr_rec.p_city_name and L.st = addr_rec.st) or L.z5 = addr_rec.z5) and
															  (L.prim_range <> '' or L.prim_name <> '');
		boolean hasInputAddrInHistory := StringLib.StringContains(addr_rec.matchcodes, 'A', TRUE) or addr_rec.hasInputAddr;
		boolean is_input_state := args_in.isInputState(addr_rec.st);
		boolean take_best := ~( isInputAddrMatch and is_input_state) and 
													(temp_addr_name_score >= args_in.BestNameScoreMin) and 
													(temp_addr_ssn_score >= args_in.BestSSNScoreMin);
		// req 4.1.22
		self.address_outside_of_agency_state := if(~is_input_state AND
																							(temp_addr_name_score >= args_in.BestNameScoreMin) and 
																							(temp_addr_ssn_score >= args_in.BestSSNScoreMin), 'OS', '');
		// req. 4.1.23		
		self.Address_Confidence := if ((temp_addr_name_score >= args_in.BestNameScoreMin) and  
																	 (temp_addr_ssn_score >= args_in.BestSSNScoreMin), addr_rec.conf_flag, '');

		self.best_fname := if(take_best, ssn_rec.best_fname, '');
		self.best_lname := if(take_best, ssn_rec.best_lname, ''); 
		self.best_addr1 := if(take_best, Address.Addr1FromComponents(addr_rec.prim_range, addr_rec.predir, addr_rec.prim_name, addr_rec.suffix, addr_rec.postdir, addr_rec.unit_desig, addr_rec.sec_range),'');
		self.best_city  := if(take_best, addr_rec.p_city_name, '');
		self.best_state := if(take_best, addr_rec.st, '');
		self.best_zip   := if(take_best, addr_rec.z5, '');
		self.date_last_seen := if(take_best, addr_rec.addr_dt_last_seen, '');
		// end req 4.1.23		
  
		// TRISv3 2015 enhancements req. 4.1.10, add 1 new output field BestAddrChangeDistance
		clean_batch_rec := ds_clean_batch(acctno = L.acctno)[1]; 
		input_lat  := (REAL) clean_batch_rec.lat;
		input_long := (REAL) clean_batch_rec.long;

		best_lat   := (REAL) addr_rec.latitude;
		best_long  := (REAL) addr_rec.longitude;
		best_dist  := (unsigned) Address_Attributes.functions.GeoDist(input_lat,input_long,best_lat,best_long);

		self.BestAddrChangeDistance := if(clean_batch_rec.prim_name ='' or 
																			(input_lat = 0 and input_long = 0) or 
																			(best_lat = 0  and best_long = 0),
																			'-1',
																			if(best_dist < 10000, (string4) best_dist,'9999')
																			);
    
		// v3.0 req 4.1.24	
		self.InputAddrDate	:= if ((temp_addr_name_score >= args_in.BestNameScoreMin) and 
															(temp_addr_ssn_score >= args_in.BestSSNScoreMin), 
															addr_rec.InputAddrDate, '');

		self.MatchedInputAddr := map(addr_rec.InputAddrDate <> '' => '', 
																(isInputAddrMatch or hasInputAddrInHistory) and 
																addr_rec.InputAddrDate = '' and
																(temp_addr_name_score >= args_in.BestNameScoreMin) and 
																(temp_addr_ssn_score >= args_in.BestSSNScoreMin) => 'Y',
																'N');
															
		self.InputAddrZipDate := if ((temp_addr_name_score >= args_in.BestNameScoreMin) and 
														 (temp_addr_ssn_score >= args_in.BestSSNScoreMin)  and 
														 addr_rec.InputZipMatch,
														 addr_rec.InputZipMatchDate,''); //YYYYMMDD format	

		// end v3.0 req 4.1.24
				
		// v3.0 req 4.1.25
		self.InputAddrState := if(addr_rec.InputStateMatch, 'Y', 'N');
    
    // v3.2 08/11/17 reqs 3.1.11 & 3.1.12 
		self.InputAddrFirst_Seen := addr_rec.InputAddrFirstSeen;
		self.InputAddrLast_Seen  := addr_rec.InputAddrLastSeen;

		// Deceased info needed for reqs 4.1.27 thru 4.1.35
		death_rec := ds_death_res(acctno = L.acctno);
		boolean isDeceased := exists(death_rec);
		
		// req 4.1.28
		self.deceased_first_name := if(isDeceased, death_rec[1].fname, '');
		self.deceased_last_name  := if(isDeceased, death_rec[1].lname, '');
		temp_dod                 := if(isDeceased, death_rec[1].dod8, '');
		// string8 temp_dod60  		 := ut.date_math(temp_dod,60);  // will add 60 days to the dod
		// string8 temp_dod180      := ut.date_math(temp_dod,180); // will add 180 days to the dod
		self.dod                 := temp_dod;
		self.deceased_matchcode  := if(isDeceased, death_rec[1].matchcode, '');

		// TRISv3.2 Enhancement: Req 3.1.3.2 : dod_bkr_flag, dod_dl_flag, dod_deed_flag, dod_mvr_flag and dod_voter_flag are not used...
		// ...The field headers will continue to appear in the 3.1 output, but the fields will be blank.

		// Req 4.1.31
		// bankr_rec := ds_bankr_res(acctno = L.acctno);
		// self.dod_bkr_flag        := if(temp_dod != '' and
																 // (bankr_rec[1].date_filed       >= temp_dod or
																	// bankr_rec[1].orig_filing_date >= temp_dod),
																 // 'Y','');

		// Req 4.1.32
		// dl_rec := ds_dl_res(acctno = L.acctno);
		// self.dod_dl_flag        := if(temp_dod != '' and
																// dl batch service output lic_issue_date is unsigned4,
																// so cast temp_dod to same type for comparing
																// dl_rec[1].lic_issue_date >= (unsigned4) temp_dod,
																 // 'Y','');

		// Req 4.1.33
		// deed_rec := ds_propdeed_res(acctno = L.acctno);
		// self.dod_deed_flag  := if(temp_dod != '' and
																// (deed_rec[1].deed_contract_date  >= temp_dod60 or
																 // deed_rec[1].deed_recording_date >= temp_dod60),
																 // 'Y','');
		// Req 4.1.34
		// mvr_rec := ds_mvr_res(acctno = L.acctno);
		// self.dod_mvr_flag       := if(temp_dod != '' and
																// mvr_rec[1].reg_latest_effective_date >= temp_dod180,
																 // 'Y','');


		// Req 4.1.35
		// voter_rec := ds_voter_res(acctno = L.acctno);
		// self.dod_voter_flag     := if(temp_dod != '' and
																 // (voter_rec[1].RegDate      >= temp_dod or
																	// voter_rec[1].LastDateVote >= temp_dod),
																 // 'Y','');
   	 
		// Criminal input SSN info
		crim_rec := ds_crim_res(acctno = L.acctno)[1];

		// TRSIv2, Bug:122469 YOB comparison
		//   This is to check for father-son with same name but different YOBs.
		//   -If one or both DOBs are blank, then just match SSNs.
		//   -If both DOBs are populated then match SSNs and YOBs. (Icing on cake situation)		
		//
		dob_to_use := if(use_best_dob,ssn_rec.best_dob[1..4],'');		
		boolean yobs_not_blank := ( (INTEGER)crim_rec.dob[1..4] <> 0 and (INTEGER) dob_to_use <> 0);
		boolean crim_yob_matches_best_yob := (crim_rec.dob[1..4] = dob_to_use) ;
		boolean crim_SSN_matches_input := (crim_rec.ssn = L.ssn) and crim_rec.ssn <> '';
		boolean use_crim_rec := if(yobs_not_blank,crim_yob_matches_best_yob and crim_SSN_matches_input,crim_SSN_matches_input);
   
		// req. 4.1.36, same as v2
		self.doc_state_origin := if (use_crim_rec, crim_rec.state_origin,'');
		self.doc_sdid  := if (use_crim_rec,intformat(crim_rec.did,12,1),'');
		
		// TRIS v3.2 Enhancement : Following field is no longer required and needs to be blanked out. {Req #3.1.3.3}
		// self.doc_ssn_1 := if (use_crim_rec,crim_rec.ssn,'');
		
		self.doc_lname := if (use_crim_rec,crim_rec.lname,'');
		self.doc_fname := if (use_crim_rec,crim_rec.fname,'');
		self.doc_mname := if (use_crim_rec,crim_rec.mname,'');
		self.doc_num   := if (use_crim_rec,crim_rec.doc_num,'');
		self.doc_dob   := if (use_crim_rec,crim_rec.dob,'');
		self.curr_incar_flag     := if (use_crim_rec,crim_rec.curr_incar_flag,'');
		self.curr_probation_flag := if (use_crim_rec,crim_rec.curr_probation_flag,'');
		self.curr_parole_flag    := if (use_crim_rec,crim_rec.curr_parole_flag,'');

		// req. 4.1.36, v3 additional fields
		self.off_desc_1_1					:= if (use_crim_rec, crim_rec.off_desc_1_1, '');
		self.cur_stat_inm_desc_1	:= if (use_crim_rec, crim_rec.cur_stat_inm_desc_1, '');
		self.in_event_dt_1				:= if (use_crim_rec, crim_rec.in_event_dt_1, '');
		self.latest_adm_dt_1			:= if (use_crim_rec, crim_rec.latest_adm_dt_1, '');	

		// TRIS v3.2 Enhancement : Req# 3.1.13 : Following field is no longer required and needs to be blanked out.
		// sch_rel_dt1				:= if (use_crim_rec, crim_rec.sch_rel_dt_1, '');	
		// self.sch_rel_dt_1	:= if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER','',sch_rel_dt1);
																 
		act_rel_dt1				:= map((crim_rec.sch_rel_dt_1 <> '' and crim_rec.act_rel_dt_1<>'') => crim_rec.act_rel_dt_1,
														 crim_rec.act_rel_dt_1 	<> '' => crim_rec.act_rel_dt_1,
														 crim_rec.sch_rel_dt_1 	<> '' => crim_rec.sch_rel_dt_1,
														 '');
		act_rel_dt2				:= if (use_crim_rec,act_rel_dt1, '');														 
		act_rel_dt0				:= if (use_crim_rec, crim_rec.act_rel_dt_1, '');                                  
		self.act_rel_dt_1	:= if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',act_rel_dt2,act_rel_dt0);
		
		// TRIS v3.2 Enhancement : Req# 3.1.13 : Following field is no longer required and needs to be blanked out.
		// ctl_rel_dt1		:= if (use_crim_rec, crim_rec.ctl_rel_dt_1, '');
		// self.ctl_rel_dt_1	:= if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER','',ctl_rel_dt1);

		// TRIS v3.2 Enhancement : Req# 3.1.3.1 : Following field is no longer required and needs to be blanked out.
		// ds_crim_felony := ds_crim_felony_res(acctno = L.acctno);
		// self.InputAddrFelonyCount := (string)count(ds_crim_felony);

		ip_address_rec	:= ds_ip_metadata(acctno = L.acctno)[1]; 
		
		temp_ValidationIpProblems := BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(clean_batch_rec.ip_address , ip_address_rec.ip_address1, ip_address_rec.edge_country1);
		self.ValidationIpProblems := temp_ValidationIpProblems;
		self.ValidationIpProblems1 := temp_ValidationIpProblems;
		self.ValidationIpProblems2 := BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(clean_batch_rec.device_ini_ip_address , ip_address_rec.ip_address2, ip_address_rec.edge_country2);
		self.ValidationIpProblems3 := BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(clean_batch_rec.device_submit_ip_address , ip_address_rec.ip_address3, ip_address_rec.edge_country3);

		temp_IPAddrExceedsInputAddr	:= BatchServices.TaxRefundISv3_BatchService_Functions.getIPAddrExceedsInputAddr(input_lat, input_long, clean_batch_rec.ip_address, 
																																																								ip_address_rec.edge_latitude1, ip_address_rec.edge_longitude1,
																																																								args_in);
		self.IPAddrExceedsInputAddr := temp_IPAddrExceedsInputAddr;
		self.IPAddrExceedsInputAddr1:= temp_IPAddrExceedsInputAddr;
		self.IPAddrExceedsInputAddr2:= BatchServices.TaxRefundISv3_BatchService_Functions.getIPAddrExceedsInputAddr(input_lat, input_long, clean_batch_rec.device_ini_ip_address, 
																																																								ip_address_rec.edge_latitude2, ip_address_rec.edge_longitude2,
																																																								args_in);
		self.IPAddrExceedsInputAddr3:= BatchServices.TaxRefundISv3_BatchService_Functions.getIPAddrExceedsInputAddr(input_lat, input_long, clean_batch_rec.device_submit_ip_address, 
																																																								ip_address_rec.edge_latitude3, ip_address_rec.edge_longitude3,
																																																								args_in);

		// TRIS 3.2 Enhancement : Commenting Royalty_NAG calculation, as this field doesn't make any sense after removal of NetAcuity Gateway call.
		// self.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(ip_address_rec.ipaddr, ip_address_rec.iptype);
   		
   	//  phone indicator req. 4.1.48
		phone_rec := ds_phone_res(acctno = L.acctno)[1];
		self.phone_number := IF(phone_rec.subj_phone10 <> '', '1', '');

    self := L;
    self := [];
	end;
  
	// Project cleaned input with did, using interim transform to save the data accumlated so far.
	ds_recs_pre_res_temp := project(ds_clean_batch_w_did, xformOutRecs(left));
  
	// TRIS v3.2 Enhancement : Req# 3.1.3.12 : Return IP data using BatchServices.IP_Metadata_BatchService.
	ds_recs_ip_metadata_res := join(ds_recs_pre_res_temp ,ds_ip_metadata,
																		left.acctno = right.acctno,
																		transform (rec_out,
																				Self.acctno := Left.acctno,
																				self := right,
																				self := left), left outer);

	// req 4.1.38
	ds_hri_res := BatchServices.TaxRefundISv3_BatchService_Functions.getHRIRecords(ds_clean_batch_w_did);
	ds_recs_pre_res := join (ds_recs_ip_metadata_res, ds_hri_res,
														left.acctno = right.acctno,
														transform(rec_out,
															self.InputAddrPrison := if(left.acctno = right.acctno, 'Y', ''),
															self := left), left outer);

  // TRIS v3.2 Enhancement : Req# 3.1.10 : Get SSNIssuance info for filling possible_age_ssn_issuance and possible_age_dob. 
  ds_w_ssn_issuance_res := BatchServices.TaxRefundISv3_BatchService_Functions.getSSNIssuanceRecords(ds_recs_pre_res);

  // *--- Get Criminal records that have different input and best SSN ---* //
	ds_diff_bestSSN_batch := project(ds_recs_pre_res(best_ssn <> ssn and best_ssn <> ''), 
																													transform(recordof(ds_clean_batch_w_did),
																																self.ssn := Left.best_ssn,
																																self.did := (integer)left.did,
																																self := left));
  
	ds_crim_res_bestSSN := BatchServices.TaxRefundISv3_BatchService_Functions.getCriminalRecords(ds_diff_bestSSN_batch);
  
	// *--- Call DidVille.RAN_BestInfo_Batch_Service_Records and set output flag if and relative addr = input addr ---* // 
	AddrRelAssocRecs := BatchServices.TaxRefundISv3_BatchService_Functions.get_rel_addr_match(ds_clean_batch_w_did);

	// *----Call FraudPoint 2.0----* //
	FraudPoint_result := BatchServices.TaxRefundISv3_BatchService_Functions.callFraudPoint2(args_in.glbpurpose,
																																		args_in.dppapurpose,
																																		args_in.DataRestriction, 
		                                                                args_in.industryclass,
																																	  args_in.ModelName,
																																	  ds_clean_batch_w_did,
																																    args_in.DataPermission
																																		); 

  // *--- Second transform to combine 2nd set of info accumlated ---* //
	rec_out xformFinal(rec_out L) := transform

		ssn_rec := ds_AdlBest_res(seq = L.seq)[1];  
		temp_verify_best_ssn  := if (ssn_rec.verify_best_ssn = 255, 0, ssn_rec.verify_best_ssn);
		temp_verify_best_name := if (ssn_rec.verify_best_name = 255, 0, ssn_rec.verify_best_name);
		// SSNIssuance info
		ssn_iss_rec := ds_w_ssn_issuance_res(acctno = L.acctno)[1];
		// req 4.1.26
		self.possible_age_ssn_issuance := if(ssn_iss_rec.issued_start_date <> '', (string3)ut.Age((unsigned4)ssn_iss_rec.issued_start_date), '');

		// Criminal best SSN info
		crim_best_rec := ds_crim_res_bestSSN(acctno = L.acctno)[1];
		// TRISv2, Bug:122469 YOB comparison
		//	This is to check for father-son with same name but different YOBs.
		//	-If one or both DOBs are blank, then just match SSNs.
		//	-If both DOBs are populated then match SSNs and YOBs. (Icing on cake situation)		

		dob_to_use := if((INTEGER)ssn_rec.best_dob <> 0 and
											temp_verify_best_ssn >= args_in.BestSSNScoreMin and
											temp_verify_best_name >= args_in.BestNameScoreMin,ssn_rec.best_dob[1..4],'');

		boolean yobs_not_blank := ((INTEGER)crim_best_rec.dob[1..4] <> 0  and (INTEGER)dob_to_use <> 0);
		boolean crim_yob_matches_best_yob := (crim_best_rec.dob[1..4] = dob_to_use) ;
		boolean crim_bestSSN_matches_input_bestSSN  := (crim_best_rec.ssn = L.best_ssn) and crim_best_rec.ssn <> '';
		boolean use_crim_best_rec := if(yobs_not_blank,crim_yob_matches_best_yob and crim_bestSSN_matches_input_bestSSN,crim_bestSSN_matches_input_bestSSN);
			
		self.doc_state_origin_bestSSN := if (use_crim_best_rec,crim_best_rec.state_origin,'');
		self.doc_sdid_bestSSN  := if (use_crim_best_rec,intformat(crim_best_rec.did,12,1) ,'');
		
		// TRIS v3.2 Enhancement : Following field is no longer required and should be blanked out. {Req #3.1.3.3}
		// self.doc_ssn_1_bestSSN := if (use_crim_best_rec,crim_best_rec.ssn,'');

		self.doc_lname_bestSSN := if (use_crim_best_rec,crim_best_rec.lname,'');
		self.doc_fname_bestSSN := if (use_crim_best_rec,crim_best_rec.fname,'');
		self.doc_mname_bestSSN := if (use_crim_best_rec,crim_best_rec.mname,'');
		self.doc_num_bestSSN   := if (use_crim_best_rec,crim_best_rec.doc_num,'');
		self.doc_dob_bestSSN   := if (use_crim_best_rec,crim_best_rec.dob,'');
		self.curr_incar_flag_bestSSN     := if (use_crim_best_rec,crim_best_rec.curr_incar_flag,'');
		self.curr_probation_flag_bestSSN := if (use_crim_best_rec,crim_best_rec.curr_probation_flag,'');
		self.curr_parole_flag_bestSSN    := if (use_crim_best_rec,crim_best_rec.curr_parole_flag,'');

		// req 4.1.37
		self.off_desc_1_1_bestSSN    := if (use_crim_best_rec,crim_best_rec.off_desc_1_1,'');
		self.cur_stat_inm_desc_1_bestSSN := if (use_crim_best_rec,crim_best_rec.cur_stat_inm_desc_1,'');
		self.in_event_dt_1_bestSSN   := if (use_crim_best_rec,crim_best_rec.in_event_dt_1,'');
		self.latest_adm_dt_1_bestSSN := if (use_crim_best_rec,crim_best_rec.latest_adm_dt_1,'');
		// req v3.1 1.8.1

		sch_rel_dt_1_bestSSN			:= if (use_crim_best_rec,crim_best_rec.sch_rel_dt_1,'');
		self.sch_rel_dt_1_bestSSN	:= if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER','',sch_rel_dt_1_bestSSN);
																																	
		best_act_rel_dt1					:= map((crim_best_rec.sch_rel_dt_1<> ''and crim_best_rec.act_rel_dt_1 <> '') => crim_best_rec.act_rel_dt_1,
																			crim_best_rec.act_rel_dt_1 <> '' => crim_best_rec.act_rel_dt_1,
																			crim_best_rec.sch_rel_dt_1 <> '' => crim_best_rec.sch_rel_dt_1,
																			'');
		best_act_rel_dt2					:= if (use_crim_best_rec,best_act_rel_dt1,'');
		best_act_rel_dt0          := if (use_crim_best_rec,crim_best_rec.act_rel_dt_1,'');
																			
		self.act_rel_dt_1_bestSSN := if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',best_act_rel_dt2,best_act_rel_dt0);
																	
		ctl_rel_dt_1_bestSSN      := if (use_crim_best_rec,crim_best_rec.ctl_rel_dt_1,'');																															
		self.ctl_rel_dt_1_bestSSN := if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER','',ctl_rel_dt_1_bestSSN);

		//Addr RelAssoc info
		addrRelAssocRec := AddrRelAssocRecs(acctno = L.acctno)[1];
		// req 4.1.39
		self.inputAddrRel := if (addrRelAssocRec.input_addr_matched_rel,'Y','N');

		// req 4.1.40
		self.inputRelLastName := if(addrRelAssocRec.input_addr_name_matched_rel, 'Y', 'N');

		// req 4.1.41 & 4.1.42 - npi_indicator to score and value of 0 for no model.
		FPrec := if(exists(FraudPoint_result),FraudPoint_result(acctno = L.acctno)[1]); 
	 
		self.score := if ((STD.Str.CleanSpaces(args_in.ModelName)  <> '') and exists(FraudPoint_result) ,FPrec.score1,'');
		// req 4.1.43
		self.VariationSsnCount   := if(exists(FraudPoint_result), FPrec.v2_VariationSsnCount,'');
		self.DivSSNIdentityCount := if(exists(FraudPoint_result), FPrec.v2_DivSSNIdentityCount, '');
		self.IDVerSSN            := if(exists(FraudPoint_result), FPrec.v2_IDVerSSN, '');
		// self.SourcePublicRecord  := if(exists(FraudPoint_result), FPrec.v2_SourcePublicRecord,'');
		// self.DivSSNLNameCount    := if(exists(FraudPoint_result), FPrec.v2_DivSSNLNameCount,'');
		// self.IDVerName           := if(exists(FraudPoint_result), FPrec.v2_IDVerName, '');

		// req 4.1.44
		self.ValidationAddrProblem   := if(exists(FraudPoint_result), FPrec.v2_ValidationAddrProblems, '');
		self.InputAddrDwellType      := if(exists(FraudPoint_result), FPrec.v2_InputAddrDwellType, '');
		// self.IDVerAddress            := if(exists(FraudPoint_result), FPrec.v2_IDVerAddress, '');
		// self.DivAddrIdentityCount    := if(exists(FraudPoint_result), FPrec.v2_DivAddrIdentityCount, '');
		self.DivAddrIdentityCountNew := if(exists(FraudPoint_result), FPrec.v2_DivAddrIdentityCountNew, '');
		// self.AddrChangeDistance      := if(exists(FraudPoint_result), FPrec.v2_AddrChangeDistance, '');

		self := L; 
		self := [];
	end;

	// Project interim ds using final transform to save the 2nd set of data accumlated.
	ds_final_1  := project(ds_recs_pre_res, xformFinal(left));
	
	// TRIS v3.2 Enhancement : Req# 3.1.3.1, All 30 occurrences of J&L fields are no longer needed. Commenting out.
  // ds_final_lj := 
              // if(NOT (StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER'),
	               // BatchServices.TaxRefundISv3_BatchService_Functions.getLienRecords(ds_final_1, ds_clean_batch_w_did, args_in),
								 // Otherwise return the dataset immediately above/out of xformFinal transform
							   // ds_final_1);							 
																					
	// get hri codes	v3.2 req 3.1.3.7									
	ds_hri_recs := BatchServices.trisv31_get_hri(ds_clean_batch_w_did,args_in);
   		
  ds_recs_join := join(ds_final_1,ds_hri_recs,
   		                     left.acctno = right.acctno,
   												 transform(rec_out,
   												 self.hri_1_code	:= right.hri_1_code,
   		                     self.hri_1_desc1	:= right.hri_1_desc1,
   		                     self.hri_2_code	:= right.hri_2_code,
   		                     self.hri_2_desc2	:= right.hri_2_desc2,
													 self.hri_3_code	:= right.hri_3_code,
													 self.hri_4_code	:= right.hri_4_code,
													 self.did	:= (string)left.did,
													 self	:= left,
													 self	:= []),
												left outer);		
	// 	v3.1 req 1.5											 
	dep_cnt := BatchServices.trisv31_get_dep_count(ds_clean_batch_w_did(args_in.includeDependantID = true and StringLib.StringToUpperCase(filer_type)= 'DEP'));
		
	ds_hri_cnt_join := join(ds_recs_join,dep_cnt,
													left.acctno = right.acctno,
													 transform(rec_out,
															 self.derogatory_count  := right.derogatory_count,
															 self.asset_count  := right.asset_count,
															 self.professional_count  := right.professional_count,
															 self :=left,
															 self := []),
													 left outer);	
																			
	// ***************** call to FDN v3.1 req 1.14 **********************

  ds_fdn := BatchServices.trisv31_get_fdn(ds_clean_batch_w_did,args_in);
   
	rec_out DeNormThem(rec_out L,dataset(recordof(ds_fdn))R) := TRANSFORM
		
	  self.fdn_id_risk := exists(R(acctno != ''));
	  self.Suspected_Discrepancy1 :=  R[1].classification_Activity.Suspected_Discrepancy;
		self.Confidence_that_activity_was_deceitful1 := R[1].classification_Activity.Confidence_that_activity_was_deceitful;
		self.Channels1  := R[1].classification_Activity.Channels;
		self.Threat1     := R[1].classification_Activity.Threat;
		self.Entity_type1 := R[1].classification_Entity.Entity_type;
		self.role1       := R[1].classification_Entity.role;
		self.Evidence1     := R[1].classification_Entity.Evidence;
		self.Suspected_Discrepancy2 :=  R[2].classification_Activity.Suspected_Discrepancy;
		self.Confidence_that_activity_was_deceitful2 := R[2].classification_Activity.Confidence_that_activity_was_deceitful;
		self.Channels2  := R[2].classification_Activity.Channels;
		self.Threat2     := R[2].classification_Activity.Threat;
		self.Entity_type2 := R[2].classification_Entity.Entity_type;
		self.role2       := R[2].classification_Entity.role;
		self.Evidence2     := R[2].classification_Entity.Evidence;
	  self.Suspected_Discrepancy3 :=  R[3].classification_Activity.Suspected_Discrepancy;
		self.Confidence_that_activity_was_deceitful3 := R[3].classification_Activity.Confidence_that_activity_was_deceitful;
		self.Channels3  := R[3].classification_Activity.Channels;
		self.Threat3     := R[3].classification_Activity.Threat;
		self.Entity_type3 := R[3].classification_Entity.Entity_type;
		self.role3       := R[3].classification_Entity.role;
		self.Evidence3     := R[3].classification_Entity.Evidence;	

		//	Filter rules changed per TRIS Rewrite (V3) Rules
	  SET OF STRING2 ACCEPTABLE_HRI_CODES_ID_risk := STD.Str.SplitWords(args_in.IdentityRiskHRICodes, ',');
		SET OF STRING2 ACCEPTABLE_HRI_CODES_ADDR_risk := STD.Str.SplitWords(args_in.AddressRiskHRICodes, ',');

   SELF.identity_risk := if((L.hri_1_code in ACCEPTABLE_HRI_CODES_ID_risk) or
														(L.hri_2_code in ACCEPTABLE_HRI_CODES_ID_risk) or
														(L.hri_3_code in ACCEPTABLE_HRI_CODES_ID_risk) or
														(L.hri_4_code in ACCEPTABLE_HRI_CODES_ID_risk)
														,'Y','');
														
	  SELF.address_risk := if((L.hri_1_code in ACCEPTABLE_HRI_CODES_ADDR_risk) or
														(L.hri_2_code in ACCEPTABLE_HRI_CODES_ADDR_risk) or
														(L.hri_3_code in ACCEPTABLE_HRI_CODES_ADDR_risk) or
														(L.hri_4_code in ACCEPTABLE_HRI_CODES_ADDR_risk)
														,'Y','');
	  SELF.FDN_COUNT := COUNT(R);
		SELF := L;
	  SELF := [];
	END;
		 
	ds_final_DeNormedRecs := DENORMALIZE(ds_hri_cnt_join,ds_fdn,left.acctno = right.acctno,GROUP,DeNormThem(left,ROWS(right)));
	ds_final := if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',ds_final_DeNormedRecs,ds_final_1);
	
	//TRIS v3.2 Enhancement : Adding contributory data for some states. 
	ds_final_w_contrib := BatchServices.TaxRefundISv3_BatchService_Functions.getContribRecs(ds_final , args_in.DataPermission);

	// Call function to apply the main filter and fill in output field named "output_status"
	ds_final_mainfilt := BatchServices.TaxRefundISv3_BatchService_Functions.MainFilter(ds_final_w_contrib,args_in);

	// Combine datasets of rejected recs with everyting else.
	ds_final_recs :=  ds_marked_rejected + ds_final_mainfilt + project(ds_in(acctno = ''), transform(rec_out,
																																														self := left,
																																														self := []));
	// Sort back into acctno order.
	ds_final_recs_sorted := sort(ds_final_recs, acctno);

 return ds_final_recs_sorted;

END;