IMPORT Address, Address_Attributes, STD, UT, DeathV2_Services;
	
EXPORT TaxRefundISv3_BatchService_Records(
          dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in) ds_in, 
          BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in
			 ) := function

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
  ds_addrBest_res := BatchServices.TaxRefundISv3_BatchService_Functions.getBestAddress(
	                                 ds_clean_batch_w_did, args_in);
 
	// *--- Run through Deceased batch service ---* //
  set_deceased_match_codes := ['ANSZC', 'ANSZ', 'ANSC', 'ANS', 'SNCZ', 'SNC', 'SNZ', 'SN', 'S'];

  death_in_mod := MODULE(project(DeathV2_Services.IParam.getBatchParams(), 
	                               DeathV2_Services.IParam.BatchParams, opt))
   			EXPORT BOOLEAN ExtraMatchCodes := TRUE;
  END;			

  //Have to translate the information into something the Death batch service can recognize.
	//TRIS v3.2.1 req 4.1.5: Adding did (LexID) to values passed in to deceased service
  death_clean_batch := PROJECT(ds_clean_batch_w_did, DeathV2_Services.Layouts.BatchIn);
  ds_death_res := DeathV2_Services.BatchRecords(death_clean_batch, death_in_mod)
	                     (matchcode in set_deceased_match_codes);	
   
	// *--- Run input subjects through the Criminal Batch Services ---* //
	ds_crim_res := BatchServices.TaxRefundISv3_BatchService_Functions.getCriminalRecords(
	                             ds_clean_batch_w_did);

	 // Get phone info
  ds_phone_res := BatchServices.TaxRefundISv3_BatchService_Functions.getPhoneRecords(
   	                                                                   ds_clean_batch_w_did,
   																																		 args_in.dppa,
   																																		 args_in.glb);
   
	// **** TRIS v3.2 Enhancement project : 
	// As per Requirements # 3.1.3.14, 3.1.4, 3.1.5, NetAcuity Gateway call will be removed and 
	// ip metadata will be gathered by using "BatchServices.IP_Metadata_BatchService". ****
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
		boolean isInputAddrMatch := L.prim_range = addr_rec.prim_range         and 
																L.prim_name  = addr_rec.prim_name          and 
																((L.p_city_name = addr_rec.p_city_name 
																  and 
																	L.st          = addr_rec.st) or
																	L.z5          = addr_rec.z5)             and
															  (L.prim_range <> '' or L.prim_name <> '');
		
		boolean isInputFullNameMatch := L.name_first = ssn_rec.best_fname AND
																		L.name_last = ssn_rec.best_lname;
		
		boolean hasInputAddrInHistory := StringLib.StringContains(addr_rec.matchcodes, 'A', TRUE) or 
		                                                          addr_rec.hasInputAddr;
		boolean is_input_state := args_in.isInputState(addr_rec.st);
		
		//TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic
		boolean take_best := ~( isInputAddrMatch);
		boolean take_best_name := ~(isInputFullNameMatch);
		// req 4.1.22 -- TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic
		self.address_outside_of_agency_state := if(~is_input_state, 'OS', '');
		// req. 4.1.23		-- TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic, and 4.1.3 fill in best field if not match to input
		self.Address_Confidence := addr_rec.conf_flag;

		self.best_fname := if(take_best_name, ssn_rec.best_fname, '');
		self.best_lname := if(take_best_name, ssn_rec.best_lname, '');
		self.best_addr1 := if(take_best, Address.Addr1FromComponents(addr_rec.prim_range, 
		                                                             addr_rec.predir, 
																																 addr_rec.prim_name, 
																																 addr_rec.suffix, 
																																 addr_rec.postdir, 
																																 addr_rec.unit_desig, 
																																 addr_rec.sec_range),'');
		self.best_city  := if(take_best, addr_rec.p_city_name, '');
		self.best_state := if(take_best, addr_rec.st, '');
		self.best_zip   := if(take_best, addr_rec.z5, '');
		self.date_last_seen := if(take_best, addr_rec.addr_dt_last_seen, '');
		// end req 4.1.23		
  
		// TRISv3.0.1 2015 enhancements req. 4.1.10, add 1 new output field BestAddrChangeDistance
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
    
		// v3.0 req 4.1.24	-- TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic
		self.InputAddrDate	:= addr_rec.InputAddrDate;

		//TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic
		self.MatchedInputAddr := map(addr_rec.InputAddrDate <> ''                     => '', 
																 (isInputAddrMatch or hasInputAddrInHistory)        and 
																 addr_rec.InputAddrDate = ''  => 'Y'
																 ,'N');
		
		//TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic
		self.InputAddrZipDate := if (addr_rec.InputZipMatch, addr_rec.InputZipMatchDate,''); //YYYYMMDD format	

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
		self.dod                 := temp_dod;
		self.deceased_matchcode  := if(isDeceased, death_rec[1].matchcode, '');

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
		boolean use_crim_rec := if(yobs_not_blank,crim_yob_matches_best_yob and 
		                           crim_SSN_matches_input, crim_SSN_matches_input);
   
		// req. 4.1.36, same as v2
		self.doc_state_origin := if (use_crim_rec, crim_rec.state_origin,'');
		self.doc_sdid  := if (use_crim_rec,intformat(crim_rec.did,12,1),'');
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
		act_rel_dt1				:= map((crim_rec.sch_rel_dt_1 <> '' and crim_rec.act_rel_dt_1<>'') 
		                                                      => crim_rec.act_rel_dt_1,
														 crim_rec.act_rel_dt_1 	<> '' => crim_rec.act_rel_dt_1,
														 crim_rec.sch_rel_dt_1 	<> '' => crim_rec.sch_rel_dt_1,
														 '');
		act_rel_dt2				:= if (use_crim_rec,act_rel_dt1, '');														 
		act_rel_dt0				:= if (use_crim_rec, crim_rec.act_rel_dt_1, '');                                  
		self.act_rel_dt_1	:= if (StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',
		                         act_rel_dt2,act_rel_dt0);
		
		ip_address_rec	:= ds_ip_metadata(acctno = L.acctno)[1]; 
		
		temp_ValidationIpProblems := 
		   BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(
			   clean_batch_rec.ip_address , ip_address_rec.ip_address1, 
				 ip_address_rec.edge_country1);
		self.ValidationIpProblems  := temp_ValidationIpProblems;
		self.ValidationIpProblems1 := temp_ValidationIpProblems;
		self.ValidationIpProblems2 := 
		   BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(
			   clean_batch_rec.device_ini_ip_address, ip_address_rec.ip_address2, 
				 ip_address_rec.edge_country2);
		self.ValidationIpProblems3 := 
		   BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(
			   clean_batch_rec.device_submit_ip_address, ip_address_rec.ip_address3, 
				 ip_address_rec.edge_country3);

		temp_IPAddrExceedsInputAddr	 := 
		   BatchServices.TaxRefundISv3_BatchService_Functions.getIPAddrExceedsInputAddr(
			   input_lat, input_long, clean_batch_rec.ip_address, 
				 ip_address_rec.edge_latitude1, ip_address_rec.edge_longitude1, args_in);
		self.IPAddrExceedsInputAddr  := temp_IPAddrExceedsInputAddr;
		self.IPAddrExceedsInputAddr1 := temp_IPAddrExceedsInputAddr;
		self.IPAddrExceedsInputAddr2 := 
		   BatchServices.TaxRefundISv3_BatchService_Functions.getIPAddrExceedsInputAddr(
			   input_lat, input_long, clean_batch_rec.device_ini_ip_address, 
				 ip_address_rec.edge_latitude2, ip_address_rec.edge_longitude2, args_in);
		self.IPAddrExceedsInputAddr3 := 
		   BatchServices.TaxRefundISv3_BatchService_Functions.getIPAddrExceedsInputAddr(
			   input_lat, input_long, clean_batch_rec.device_submit_ip_address, 
         ip_address_rec.edge_latitude3, ip_address_rec.edge_longitude3, args_in);

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
  ds_w_ssn_issuance_res := 
	   BatchServices.TaxRefundISv3_BatchService_Functions.getSSNIssuanceRecords(ds_recs_pre_res);

  // *--- Get Criminal records that have different input and best SSN ---* //
	ds_diff_bestSSN_batch := project(ds_recs_pre_res(best_ssn <> ssn and best_ssn <> ''), 
																	 transform(recordof(ds_clean_batch_w_did),
																		 self.ssn := Left.best_ssn,
																		 self.did := (integer)left.did,
																		 self := left));
  
	ds_crim_res_bestSSN := 
	   BatchServices.TaxRefundISv3_BatchService_Functions.getCriminalRecords(ds_diff_bestSSN_batch);
  
	// *--- Call DidVille.RAN_BestInfo_Batch_Service_Records and set output flag if and relative addr = input addr ---* // 
	AddrRelAssocRecs := 
	   BatchServices.TaxRefundISv3_BatchService_Functions.get_rel_addr_match(ds_clean_batch_w_did);

	// *----Call FraudPoint 2.0----* //
	FraudPoint_result := BatchServices.TaxRefundISv3_BatchService_Functions.callFraudPoint2(
	                                                                  args_in.glb,
																																		args_in.dppa,
																																		args_in.DataRestrictionMask,
		                                                                args_in.industry_class,
																																	  args_in.ModelName,
																																	  ds_clean_batch_w_did,
																																    args_in.DataPermissionMask
																																		); 

  // *--- Second transform to combine 2nd set of info accumlated ---* //
	rec_out xformFinal(rec_out L) := transform

		ssn_rec := ds_AdlBest_res(seq = L.seq)[1];  
		temp_verify_best_ssn  := if (ssn_rec.verify_best_ssn = 255, 0, ssn_rec.verify_best_ssn);
		temp_verify_best_name := if (ssn_rec.verify_best_name = 255, 0, ssn_rec.verify_best_name);
		// SSNIssuance info
		ssn_iss_rec := ds_w_ssn_issuance_res(acctno = L.acctno)[1];
		// req 4.1.26
		self.possible_age_ssn_issuance := if(ssn_iss_rec.issued_start_date <> '',
		                                     (string3)ut.Age((unsigned4)ssn_iss_rec.issued_start_date), '');

		// Criminal best SSN info
		crim_best_rec := ds_crim_res_bestSSN(acctno = L.acctno)[1];
		// TRISv2, Bug:122469 YOB comparison
		//	This is to check for father-son with same name but different YOBs.
		//	-If one or both DOBs are blank, then just match SSNs.
		//	-If both DOBs are populated then match SSNs and YOBs. (Icing on cake situation)		
		
		//TRIS v3.2.1 update req 4.2.1 remove NameScore logic and 4.2.2 remove SSNScore logic
		dob_to_use := if((INTEGER)ssn_rec.best_dob <> 0,ssn_rec.best_dob[1..4],'');

		boolean yobs_not_blank := ((INTEGER)crim_best_rec.dob[1..4] <> 0  and (INTEGER)dob_to_use <> 0);
		boolean crim_yob_matches_best_yob := (crim_best_rec.dob[1..4] = dob_to_use) ;
		boolean crim_bestSSN_matches_input_bestSSN  := (crim_best_rec.ssn = L.best_ssn) and crim_best_rec.ssn <> '';
		boolean use_crim_best_rec := if(yobs_not_blank,
		                                crim_yob_matches_best_yob and crim_bestSSN_matches_input_bestSSN,
																		crim_bestSSN_matches_input_bestSSN);
			
		self.doc_state_origin_bestSSN := if (use_crim_best_rec,crim_best_rec.state_origin,'');
		self.doc_sdid_bestSSN  := if (use_crim_best_rec,intformat(crim_best_rec.did,12,1) ,'');
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
		self.sch_rel_dt_1_bestSSN	:= if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',
		                                '',sch_rel_dt_1_bestSSN);
																																	
		best_act_rel_dt1					:= map((crim_best_rec.sch_rel_dt_1<> ''and crim_best_rec.act_rel_dt_1 <> '') 
		                                                                   => crim_best_rec.act_rel_dt_1,
																			crim_best_rec.act_rel_dt_1 <> '' => crim_best_rec.act_rel_dt_1,
																			crim_best_rec.sch_rel_dt_1 <> '' => crim_best_rec.sch_rel_dt_1,
																			'');
		best_act_rel_dt2					:= if (use_crim_best_rec,best_act_rel_dt1,'');
		best_act_rel_dt0          := if (use_crim_best_rec,crim_best_rec.act_rel_dt_1,'');
																			
		self.act_rel_dt_1_bestSSN := if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',
		                                best_act_rel_dt2,best_act_rel_dt0);
																	
		ctl_rel_dt_1_bestSSN      := if (use_crim_best_rec,crim_best_rec.ctl_rel_dt_1,'');																															
		self.ctl_rel_dt_1_bestSSN := if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',
		                                '',ctl_rel_dt_1_bestSSN);

		//Addr RelAssoc info
		addrRelAssocRec := AddrRelAssocRecs(acctno = L.acctno)[1];
		// req 4.1.39
		self.inputAddrRel := if (addrRelAssocRec.input_addr_matched_rel,'Y','N');

		// req 4.1.40
		self.inputRelLastName := if(addrRelAssocRec.input_addr_name_matched_rel, 'Y', 'N');

		// req 4.1.41 & 4.1.42 - npi_indicator to score and value of 0 for no model.
		FPrec := if(exists(FraudPoint_result),FraudPoint_result(acctno = L.acctno)[1]); 
	 
		self.score := if ((STD.Str.CleanSpaces(args_in.ModelName)  <> '') and 
		                  exists(FraudPoint_result) ,FPrec.score1,'');
		// req 4.1.43
		self.VariationSsnCount   := if(exists(FraudPoint_result), FPrec.v2_VariationSsnCount,'');
		self.DivSSNIdentityCount := if(exists(FraudPoint_result), FPrec.v2_DivSSNIdentityCount, '');
		self.IDVerSSN            := if(exists(FraudPoint_result), FPrec.v2_IDVerSSN, '');
		// req 4.1.44
		self.ValidationAddrProblem   := if(exists(FraudPoint_result), FPrec.v2_ValidationAddrProblems, '');
		self.InputAddrDwellType      := if(exists(FraudPoint_result), FPrec.v2_InputAddrDwellType, '');
		self.DivAddrIdentityCountNew := if(exists(FraudPoint_result), FPrec.v2_DivAddrIdentityCountNew, '');

		self := L; 
		self := [];
	end;

	// Project interim ds using final transform to save the 2nd set of data accumlated.
	ds_final_1  := project(ds_recs_pre_res, xformFinal(left));

	// get hri codes	v3.2 req 3.1.3.7 from IID & FP results
 	ds_hri_recs := BatchServices.trisv31_get_hri(ds_clean_batch_w_did,args_in,FraudPoint_result);
   		
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
	  self.Suspected_Discrepancy1                  := R[1].classification_Activity.Suspected_Discrepancy;
		self.Confidence_that_activity_was_deceitful1 := R[1].classification_Activity.Confidence_that_activity_was_deceitful;
		self.Channels1                               := R[1].classification_Activity.Channels;
		self.Threat1                                 := R[1].classification_Activity.Threat;
		self.Entity_type1                            := R[1].classification_Entity.Entity_type;
		self.role1                                   := R[1].classification_Entity.role;
		self.Evidence1                               := R[1].classification_Entity.Evidence;
		self.Suspected_Discrepancy2                  := R[2].classification_Activity.Suspected_Discrepancy;
		self.Confidence_that_activity_was_deceitful2 := R[2].classification_Activity.Confidence_that_activity_was_deceitful;
		self.Channels2                               := R[2].classification_Activity.Channels;
		self.Threat2                                 := R[2].classification_Activity.Threat;
		self.Entity_type2                            := R[2].classification_Entity.Entity_type;
		self.role2                                   := R[2].classification_Entity.role;
		self.Evidence2                               := R[2].classification_Entity.Evidence;
	  self.Suspected_Discrepancy3                  := R[3].classification_Activity.Suspected_Discrepancy;
		self.Confidence_that_activity_was_deceitful3 := R[3].classification_Activity.Confidence_that_activity_was_deceitful;
		self.Channels3                               := R[3].classification_Activity.Channels;
		self.Threat3                                 := R[3].classification_Activity.Threat;
		self.Entity_type3                            := R[3].classification_Entity.Entity_type;
		self.role3                                   := R[3].classification_Entity.role;
		self.Evidence3                               := R[3].classification_Entity.Evidence;	

		//	Filter rules changed per TRIS Rewrite (V3) Rules
	  SET OF STRING2 ACCEPTABLE_HRI_CODES_ID_risk   := STD.Str.SplitWords(args_in.IdentityRiskHRICodes, ',');
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
		 
	ds_final_DeNormedRecs := DENORMALIZE(ds_hri_cnt_join,ds_fdn,
	                                      left.acctno = right.acctno,
																				GROUP,DeNormThem(left,ROWS(right)));

	ds_final := if(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER',
	               ds_final_DeNormedRecs,ds_final_1);
	
	//TRIS v3.2 Enhancement : Adding contributory data for some states. 
	ds_final_w_contrib := BatchServices.TaxRefundISv3_BatchService_Functions.getContribRecs(
	                                    ds_final , args_in.DataPermissionMask);

	// Call function to apply the main filter and fill in output field named "output_status"
	ds_final_mainfilt := BatchServices.TaxRefundISv3_BatchService_Functions.MainFilter(
	                                   ds_final_w_contrib,args_in);

	// Combine datasets of rejected recs with everyting else.
	ds_final_recs :=  ds_marked_rejected + ds_final_mainfilt + 
	                  project(ds_in(acctno = ''), transform(rec_out,
																													  self := left,
																														self := []));
	// Sort back into acctno order.
	ds_final_recs_sorted := sort(ds_final_recs, acctno);

  return ds_final_recs_sorted;

  // *--- DEBUG outputs ---* //
	//output(ds_in,                named('ds_in'));
  //output(ds_in_acctno,         named('ds_in_acctno')); 
  //output(ds_clean_batch,       named('ds_clean_batch'));
	//output(ds_batch_in_marked,   named('ds_batch_in_marked'));
	//output(ds_having_suff_input, named('ds_having_suff_input'));
	//output(ds_marked_rejected,   named('ds_marked_rejected'));
  //output(ds_AdlBest_res,       named('ds_AdlBest_res'));
  //output(ds_clean_batch_w_did, named('ds_clean_batch_w_did'));
  //output(ds_addrBest_res,      named('ds_addrBest_res'));
  //output(death_clean_batch,    named('death_clean_batch'));
  //output(ds_death_res,         named('ds_death_res'));
  //output(ds_crim_res,          named('ds_crim_res'));
  //output(ds_ip_metadata,       named('ds_ip_metadata'));
	//output(ds_recs_pre_res_temp, named('ds_recs_pre_res_temp'));
  //output(FraudPoint_result,    named('FraudPoint_result'));
  //output(ds_final_1,           named('ds_final_1')); 
  //output(ds_hri_recs,          named('ds_hri_recs'));
  //return ds_recs_pre_res_temp; // 11/08/17 criminal research slimmed testing
  //return ds_final_1; // 11/10/17 fraudpoint research slimmed testing
  //return ds_recs_join; // 11/14/17 hri changes slimmed testing

END;
