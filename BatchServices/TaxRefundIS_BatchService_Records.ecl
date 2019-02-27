import Address, ut, STD, BatchServices, DeathV2_Services;

in_rec := BatchServices.Layouts.TaxRefundIS.batch_in;
out_rec := BatchServices.Layouts.TaxRefundIS.batch_out;
	
EXPORT TaxRefundIS_BatchService_Records(DATASET(in_rec) indata , BatchServices.TaxRefundIS_BatchService_Interfaces.Input args ) := function
	
	/*---Check if we have the inputs to invoke FraudPoint 2.0 and run filter----*/	
	
	isFraudPoint := (args.NPIThreshold <> '' ) and (STD.Str.CleanSpaces(args.ModelName) <> '' ) and (STD.Str.CleanSpaces(args.FilterRule) <> ''); 
	
	/*---clean_input ---*/
  indata_acctno := indata(acctno <> ''); //Get rid of records with no acctno
	
	clean_batch :=  BatchServices.TaxRefundIS_BatchService_Functions.clean_batch(indata_acctno);
	
  /*----Call FraudPoint 2.0----*/
	FraudPoint_result := if(isFraudPoint,
	                         BatchServices.TaxRefundIS_BatchService_Functions.callFraudPoint2 (args.glb,
																																														 args.dppa,
																																														 args.DataRestrictionMask,
													                                                                   args.industry_class,
																																														 args.ModelName,
																																														 clean_batch,
																																														 args.DataPermissionMask)); 
	
	/*--- Run through AC Deceased batch service ---*/
	deceased_match_codes := ['ANSZC', 'ANSZ', 'ANSC', 'ANS', 'SNCZ', 'SNC', 'SNZ', 'SN'];
	death_in_mod := MODULE(DeathV2_Services.IParam.getBatchParams())
			EXPORT BOOLEAN ExtraMatchCodes 						:= TRUE;
		END;			
	//Have to translate the information into something the Death batch service can recognize.
	death_clean_batch := PROJECT(clean_batch, DeathV2_Services.Layouts.BatchIn);		
	death_res := DeathV2_Services.BatchRecords(death_clean_batch, death_in_mod)(matchcode in deceased_match_codes);	

	/*--- Go through Best Address batch ---*/
  
	addrBest_res := BatchServices.TaxRefundIS_BatchService_Functions.getBestAddress(clean_batch);

	/*--- Take Input through ADL_Best -> DidVille.Did_Batch_Service_Raw ---*/
	w_bestSsn_res := BatchServices.TaxRefundIS_BatchService_Functions.getBestSSNInfo(clean_batch, 
																																									 args.glb, 
																																									 args.dppa, 
																																									 args.append_l, 
																																									 args.application_type,
																																									 args.industry_class,
																																									 args.verify_l);
	         
	/*--- Run CIID process ---*/
  w_ciid_res := BatchServices.TaxRefundIS_BatchService_Functions.getIIDRecords(clean_batch,,
                                                                              args.dppa, 
                                                                              args.glb, 
                                                                              args.industry_class, 
                                                                              args.DataRestrictionMask,
																																							args.DataPermissionMask);
  
  /*--- Run input subjects through the Criminal Batch Services ---*/
	crim_res := BatchServices.TaxRefundIS_BatchService_Functions.getCriminalRecords(clean_batch);
		
  /*--- Combine info ---*/
  out_rec xformOutRecs(clean_batch L) := transform
  //  deceased info
    death_rec := death_res(acctno = L.acctno);
    boolean isDeceased := exists(death_rec);
		self.deceased_first_name := if(isDeceased, death_rec[1].fname, '');
		self.deceased_last_name := if(isDeceased, death_rec[1].lname, '');
		self.dod := if(isDeceased, death_rec[1].dod8, '');
		self.deceased_matchcode := if(isDeceased, death_rec[1].matchcode, '');
 //   AddrBest info
    addr_rec := addrBest_res(acctno = L.acctno)[1];
		temp_addr_ssn_score := if ((integer)addr_rec.ssn_score = 255, 0, (integer)addr_rec.ssn_score);
		temp_addr_name_score := if ((integer)addr_rec.name_score = 255, 0, (integer)addr_rec.name_score);
    boolean isInputAddrMatch := L.prim_range = addr_rec.prim_range and 
																L.prim_name = addr_rec.prim_name and 
																((L.p_city_name = addr_rec.p_city_name and L.st = addr_rec.st) or L.z5 = addr_rec.z5)
                                and (L.prim_range <> '' or L.prim_name <> '');
    boolean hasInputAddrInHistory := StringLib.StringContains(addr_rec.matchcodes, 'A', TRUE) or addr_rec.hasInputAddr;
		boolean is_input_state := args.isInputState(addr_rec.st);
    boolean take_best := ~(isInputAddrMatch and is_input_state) and 
		                      (temp_addr_name_score >= args.BestNameScoreMin) and 
		                      (temp_addr_ssn_score >= args.BestSSNScoreMin);
		self.address_outside_of_home_state := if(~is_input_state AND
																							(temp_addr_name_score >= args.BestNameScoreMin) and 
																						  (temp_addr_ssn_score >= args.BestSSNScoreMin), 'OS', '');
		self.Address_Confidence := if ((temp_addr_name_score >= args.BestNameScoreMin) and 
		                               (temp_addr_ssn_score >= args.BestSSNScoreMin), addr_rec.conf_flag, '');
		self.best_fname := if(take_best, addr_rec.name_first, '');
		self.best_lname := if(take_best, addr_rec.name_last, ''); 
		self.best_addr1 := if(take_best, 
														Address.Addr1FromComponents(addr_rec.prim_range, addr_rec.predir, addr_rec.prim_name, addr_rec.suffix, addr_rec.postdir, addr_rec.unit_desig, addr_rec.sec_range), 
														'');
		self.best_city := if(take_best, addr_rec.p_city_name, '');
		self.best_state := if(take_best, addr_rec.st, '');
		self.best_zip := if(take_best, addr_rec.z5, '');
		self.date_last_seen := if(take_best, addr_rec.addr_dt_last_seen, '');
		self.InputAddrDate := if ((temp_addr_name_score >= args.BestNameScoreMin) and 
		                           (temp_addr_ssn_score >= args.BestSSNScoreMin) , addr_rec.InputAddrDate, '');
		self.MatchedInputAddr := map(addr_rec.InputAddrDate <> '' => '', 
                                 (isInputAddrMatch or hasInputAddrInHistory) and 
																	 addr_rec.InputAddrDate = '' and
																	 (temp_addr_name_score >= args.BestNameScoreMin) and 
		                               (temp_addr_ssn_score >= args.BestSSNScoreMin) => 'Y',
                                  'N');
																	
    self.InputAddrZipDate := if ((temp_addr_name_score >= args.BestNameScoreMin) and 
		                             (temp_addr_ssn_score >= args.BestSSNScoreMin)  and 
		                             addr_rec.InputZipMatch,
																 addr_rec.InputZipMatchDate,''); //YYYYMMDD format																	
   // ADL Best info
    ssn_rec := w_bestSsn_res(seq = L.seq)[1];
		temp_verify_best_ssn := if (ssn_rec.verify_best_ssn = 255, 0, ssn_rec.verify_best_ssn);
		temp_verify_best_name := if (ssn_rec.verify_best_name = 255, 0, ssn_rec.verify_best_name);
    self.best_ssn := if((ssn_rec.best_ssn <> L.ssn) and 
		                     (temp_verify_best_ssn >= args.SSNScoreMin) and 
		                     (temp_verify_best_name >= args.NameScoreMin) , ssn_rec.best_ssn, '');
		use_best_dob := ssn_rec.best_dob <> '' and 
		                ssn_rec.best_dob <> '0' and  
		                (temp_verify_best_ssn >= args.SSNScoreMin) and
									  temp_verify_best_name >= args.NameScoreMin ;
		self.possible_age_dob := if (use_best_dob, (string3)ut.Age((unsigned4)ssn_rec.best_dob), '');
    //CIID info
    ciid_rec := w_ciid_res(acctno = L.acctno)[1];
		self.ssn_invalid_flag := if(ciid_rec.isInvalidSSN, 'Y', 'N');
		self.ssn_randomization_flag := if(ciid_rec.isRandomizedSSN, 'Y', 'N');
		self.Identity_Verification_NAS_Code := ciid_rec.nas_summary;
		self.Identity_Verification_CVI_Code := ciid_rec.cvi;
		self.hri_1_indicator := ciid_rec.hri_1;
		self.hri_1_description := ciid_rec.hri_desc_1;
		self.hri_2_indicator := ciid_rec.hri_2;
		self.hri_2_description := ciid_rec.hri_desc_2;
		self.hri_3_indicator := ciid_rec.hri_3;
		self.hri_3_description := ciid_rec.hri_desc_3;
		self.hri_4_indicator := ciid_rec.hri_4;
		self.hri_4_description := ciid_rec.hri_desc_4;
		self.hri_5_indicator := ciid_rec.hri_5;
		self.hri_5_description := ciid_rec.hri_desc_5;
		self.hri_6_indicator := ciid_rec.hri_6;
		self.hri_6_description := ciid_rec.hri_desc_6;
  //  Criminal input SSN info
    crim_rec := crim_res(acctno = L.acctno)[1];
		
		/* Bug:122469 YOB comparison
         This is to check for father-son with same name but different YOBs.
         -If one or both DOBs are blank, then just match SSNs.
         -If both DOBs are populated then match SSNs and YOBs. (Icing on cake situation)		
    */
    dob_to_use := if(use_best_dob,ssn_rec.best_dob[1..4],'');		
		boolean yobs_not_blank := ( (INTEGER)crim_rec.dob[1..4] <> 0 and (INTEGER) dob_to_use <> 0);
		boolean crim_yob_matches_best_yob := (crim_rec.dob[1..4] = dob_to_use) ;
		boolean crim_SSN_matches_input := (crim_rec.ssn = L.ssn) and crim_rec.ssn <> '';
		boolean use_crim_rec := if(yobs_not_blank,crim_yob_matches_best_yob and crim_SSN_matches_input,crim_SSN_matches_input);
		
    self.doc_state_origin := if (use_crim_rec, crim_rec.state_origin,'');
		self.doc_sdid := if (use_crim_rec,intformat(crim_rec.did,12,1),'');
		self.doc_ssn_1 := if (use_crim_rec,crim_rec.ssn,'');
		self.doc_lname := if (use_crim_rec,crim_rec.lname,'');
		self.doc_fname := if (use_crim_rec,crim_rec.fname,'');
		self.doc_mname := if (use_crim_rec,crim_rec.mname,'');
		self.doc_num := if (use_crim_rec,crim_rec.doc_num,'');
		self.doc_dob := if (use_crim_rec,crim_rec.dob,'');
		self.curr_incar_flag := if (use_crim_rec,crim_rec.curr_incar_flag,'');
		self.curr_probation_flag := if (use_crim_rec,crim_rec.curr_probation_flag,'');
		self.curr_parole_flag := if (use_crim_rec,crim_rec.curr_parole_flag,'');
   // Input
    self := L;
   // Other info -> SSNIssuance info and Criminal best SSN info
    self := [];
  end;
  
  recs_pre_res := project(clean_batch, xformOutRecs(left));
	
   /*--- Get SSNIssuance info for filling possible_age_ssn_issuance for records 
          that do not have possible_age_dob already filled ---*/
  w_ssn_issuance_res := BatchServices.TaxRefundIS_BatchService_Functions.getSSNIssuanceRecords(recs_pre_res);
        	
	/*--- Get Criminal records that have different input and best SSN ---*/
	diff_bestSSN_batch := project(recs_pre_res(best_ssn <> ssn and best_ssn <> ''), transform(recordof(clean_batch),
																																self.ssn := Left.best_ssn,
																																self := left));
  
	crim_res_bestSSN := BatchServices.TaxRefundIS_BatchService_Functions.getCriminalRecords(diff_bestSSN_batch);
  
	/*--- Call DidVille.RAN_BestInfo_Batch_Service_Records and set output flag if and relative addr = input addr ---*/
  AddrRelAssocRecs := BatchServices.TaxRefundIS_BatchService_Functions.get_rel_addr_match(clean_batch);

  /*--- Combine final info ---*/
  out_rec xformFinal(out_rec L) := transform
	  ssn_rec := w_bestSsn_res(seq = L.seq)[1];  
		temp_verify_best_ssn := if (ssn_rec.verify_best_ssn = 255, 0, ssn_rec.verify_best_ssn);
		temp_verify_best_name := if (ssn_rec.verify_best_name = 255, 0, ssn_rec.verify_best_name);
 
    // SSNIssuance info
    ssn_iss_rec := w_ssn_issuance_res(acctno = L.acctno)[1];
    self.possible_age_ssn_issuance := if(L.possible_age_dob = '', (string3)ut.Age((unsigned4)ssn_iss_rec.issued_start_date), '');
   
    // Criminal best SSN info
    crim_best_rec := crim_res_bestSSN(acctno = L.acctno)[1];
		
		/* Bug:122469 YOB comparison
         This is to check for father-son with same name but different YOBs.
         -If one or both DOBs are blank, then just match SSNs.
         -If both DOBs are populated then match SSNs and YOBs. (Icing on cake situation)		
    */
		
    dob_to_use := if((INTEGER)ssn_rec.best_dob <> 0 and
		                                             temp_verify_best_ssn >= args.BestSSNScoreMin and
																                 temp_verify_best_name >= args.BestNameScoreMin,ssn_rec.best_dob[1..4],'');;		
		boolean yobs_not_blank := ((INTEGER)crim_best_rec.dob[1..4] <> 0  and (INTEGER)dob_to_use <> 0);
		boolean crim_yob_matches_best_yob := (crim_best_rec.dob[1..4] = dob_to_use) ;
		boolean crim_bestSSN_matches_input_bestSSN  := (crim_best_rec.ssn = L.best_ssn) and crim_best_rec.ssn <> '';
		boolean use_crim_best_rec := if(yobs_not_blank,crim_yob_matches_best_yob and crim_bestSSN_matches_input_bestSSN,crim_bestSSN_matches_input_bestSSN);
//------------		
		self.doc_state_origin_bestSSN := if (use_crim_best_rec,crim_best_rec.state_origin,'');
		self.doc_sdid_bestSSN := if (use_crim_best_rec,intformat(crim_best_rec.did,12,1) ,'');
		self.doc_ssn_1_bestSSN := if (use_crim_best_rec,crim_best_rec.ssn,'');
		self.doc_lname_bestSSN := if (use_crim_best_rec,crim_best_rec.lname,'');
		self.doc_fname_bestSSN := if (use_crim_best_rec,crim_best_rec.fname,'');
		self.doc_mname_bestSSN := if (use_crim_best_rec,crim_best_rec.mname,'');
		self.doc_num_bestSSN := if (use_crim_best_rec,crim_best_rec.doc_num,'');
		self.doc_dob_bestSSN := if (use_crim_best_rec,crim_best_rec.dob,'');
		self.curr_incar_flag_bestSSN := if (use_crim_best_rec,crim_best_rec.curr_incar_flag,'');
		self.curr_probation_flag_bestSSN := if (use_crim_best_rec,crim_best_rec.curr_probation_flag,'');
		self.curr_parole_flag_bestSSN := if (use_crim_best_rec,crim_best_rec.curr_parole_flag,'');
			// Addr RelAssoc info
		addrRelAssocRec := AddrRelAssocRecs(acctno = L.acctno)[1];
		self.inputAddrRel := if (addrRelAssocRec.input_addr_matched_rel,'Y','N');
		FPrec := if(exists(FraudPoint_result),FraudPoint_result(acctno = L.acctno)[1]); 
		self.npi_indicator := if(isFraudPoint and exists(FraudPoint_result) ,FPrec.score1,''); 
		self.identity_filter :='';
		self := L;
	end;
	
	final_crim_recs := project(recs_pre_res, xformFinal(left));
  // Fill o/p field "identity_filter":   
	final_crim_recs1 := IF(isFraudPoint,BatchServices.TaxRefundIS_BatchService_Functions.MainFilter(final_crim_recs,args.FilterRule,args.NPIThreshold),final_crim_recs);
  final_recs :=  final_crim_recs1 + project(indata(acctno = ''), transform(out_rec,
                                                                        self := left,
                                                                        self := []));

	// /*--- DEBUG ---*/                  
	// output(clean_batch, named('clean_batch'));
  // output(death_res, named('death_res'));
  // output(addrBest_res, named('addrBest_res'));
  // output(w_bestSsn_res, named('w_bestSsn_res'));
  // output(w_ciid_res, named('w_ciid_res'));
  // output(crim_res, named('crim_res'));
  // output(w_ssn_issuance_res, named('w_ssn_issuance_res'));
	// output(crim_res_bestSSN, named('crim_res_bestSSN'));
	// output(final_crim_recs, named('final_crim_recs'));
	// output(AddrRelAssocRecs,named('AddrRelAssocRecs'));
  // output(FraudPoint_result,named('FraudPoint_result'));

	return final_recs;
end;
	