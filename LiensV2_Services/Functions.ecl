import BatchServices, AutoStandardI, D2C, FCRA, FFD, NID, STD;

EXPORT Functions := MODULE
  
	shared tmp_penalt_layout := record
		unsigned2 penalt;
	end;
	
	SHARED tmp_int_layout := RECORD
		UNSIGNED2 val := 0;
	END;
	
	SHARED default_penalty := 20;
	
	EXPORT isRestricted(boolean is_cnsmr, string tmsid) := is_cnsmr AND D2C.Constants.LiensRestrictedSources(tmsid);

	penalt_addr(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l,
							dataset(liensv2_services.layout_lien_party_address) r) := function
 
		ds_out_addr_penalt := project(r, transform(tmp_penalt_layout,
								addresses_to_compare := 
			MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
				// The 'input' address:
				EXPORT predir         := l.predir;
				EXPORT prim_name      := l.prim_name;
				EXPORT prim_range     := l.prim_range;
				EXPORT postdir        := l.postdir;
				EXPORT addr_suffix    := l.addr_suffix;
				EXPORT sec_range      := l.sec_range;
				EXPORT p_city_name    := l.p_city_name;
				EXPORT st             := l.st;
				EXPORT z5             := l.z5;					
				// The address in the matching record:						
				EXPORT allow_wildcard  := FALSE;					
				EXPORT city_field      := left.v_city_name;
				EXPORT city2_field     := '';
				EXPORT pname_field     := left.prim_name;
				EXPORT postdir_field   := left.postdir;
				EXPORT prange_field    := left.prim_range;
				EXPORT predir_field    := left.predir;
				EXPORT state_field     := left.st;
				EXPORT suffix_field    := left.addr_suffix;
				EXPORT zip_field       := left.zip;		
				EXPORT sec_range_field := left.sec_range;
				EXPORT useGlobalScope  := FALSE;
			END;
			highPenalt := if (left.v_city_name = '' AND left.st= '' AND left.zip='', default_penalty, 0);			
			// NOTE : this is calling a new penalization routine
			//  in so much as the input values (left side i.e. non
			// candidate records) are not being obtained via
			// interface translator (IT)  They are being obtained directly
			// from the passed in input values.  This was done
			// as a fix for bug RR 103650 to fix batch timeouts
			// specifically and only for Judgements and liens batch service.
			// the main reason is that by by passing the IT calls
			// the address cleaner is called less thus causing
			// larger return sets for particular inputs of batch
			// to process successfully instead of timing out.
			self.penalt := Max(AutoStandardI.LIBCALL_PenaltyI_AddrNEW.val(addresses_to_compare), highPenalt);	
			));				
		return min(ds_out_addr_penalt, penalt);				
	end;
				
	penalt_ind_name(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid  l,
									dataset(liensv2_services.layout_lien_party_parsed) r) := function
																	// project necessary cause of multiple layers in addresses and
																	// parsed parties.
		ds_out_indname_penalt := project(r, transform(tmp_penalt_layout,						 					 
			tempindvmod :=                               
				MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
					EXPORT lastname       := l.name_last;       // the 'input' last name
					EXPORT middlename     := l.name_middle;     // the 'input' middle name
					EXPORT firstname      := l.name_first;      // the 'input' first name
					EXPORT allow_wildcard := FALSE;
					EXPORT lname_field    := left.lname; // matching record.						                           
					EXPORT mname_field    := left.mname; 
					EXPORT fname_field    := left.fname; 	
					EXPORT useGlobalScope := FALSE;
				END;					 								    
			high_ind_penalt := if (left.lname = '' AND left.fname ='', default_penalty, 0); // to catch blank fields in rec going against
																											 // so it doesn't skew the min for that particular row.
			self.penalt := Max(AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod), high_ind_penalt);
			));				   
		return min(ds_out_indname_penalt, penalt);					 
	end;
	
	penalt_buz_cname(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid  l,	
									 DATASET(liensv2_services.layout_lien_party_parsed) r) := function
		ds_out_buzname_penalt := PROJECT(r, TRANSFORM(tmp_penalt_layout,	
			tempbizmod := 
				MODULE(PROJECT(AutoStandardI.GlobalModule(),
					AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
						EXPORT allow_wildcard := FALSE;
						EXPORT useGlobalScope := FALSE;
						EXPORT companyname := l.comp_name;	// the 'input' company name								
						EXPORT cname_field := left.cname;		// matching record.															
					END;		
					// so it doesn't skew the min for that particular row so set to a high value.
				high_biz_penalt := if (left.cname = '', default_penalty, 0);
				
				self.penalt := Max(AutoStandardI.LIBCALL_PenaltyI_Biz_name.val(tempBizMod), high_biz_penalt);
				));
		 return min(ds_out_buzname_penalt, penalt);		
	end;
	
	EXPORT tmp_penalt_layout penalt_func_calculate(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l,
																								 DATASET(liensv2_services.layout_lien_party) r	)  := FUNCTION	
		out_ds := PROJECT(r, TRANSFORM(tmp_penalt_layout,	
				tmp_addr := if (exists(left.addresses), penalt_addr(l, left.addresses), default_penalty);															 
				tmp_ind_name := if (exists(left.parsed_parties), penalt_ind_name(l, left.parsed_parties), default_penalty);																										
				tmp_buz_cname := if (exists(left.parsed_parties), penalt_buz_cname(l, left.parsed_parties), default_penalty);																										
				self.penalt := (unsigned2)  min( tmp_buz_cname,tmp_ind_name) + tmp_addr;
				));     
		RETURN out_ds;
		// represents just one row penalty.
	END;	
	
	//name
	BOOLEAN fn_match_name( dataset (liensv2_services.layout_lien_party) LE,
												 LiensV2_Services.Batch_Layouts.batch_in R)  := FUNCTION	
																	
		tmp_int_layout x_name( liensv2_services.layout_lien_party_parsed   ind_party,
													 LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM              
			self.val := if (((ind_party.fname = R.name_first AND ind_party.fname <> '') OR (NID.mod_PFirstTools.PFLeqPFR(ind_party.fname, R.name_first) AND ind_party.fname <> '')) AND
																		 (ind_party.lname = R.name_last AND ind_party.lname <> ''), 1, 2);
		END;							 					   
		BOOLEAN ret_val := min(project(LE.parsed_parties, x_name(LEFT,R)), val) = 1;
		RETURN (ret_val);									
	END;						
	
	// ssn
	BOOLEAN fn_match_ssn( dataset (liensv2_services.layout_lien_party) LE,
												LiensV2_Services.Batch_Layouts.batch_in R)  := FUNCTION	
																	
		tmp_int_layout x_ssn( liensv2_services.layout_lien_party_parsed   L,
													LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM                    
			self.val := if ((L.ssn = stringlib.stringfilterout(R.ssn, '-') and L.ssn <> ''), 1, 2);
		END;							 					   
		BOOLEAN ret_val := min(project(LE.parsed_parties, x_ssn(LEFT,R)), val) = 1;
		RETURN (ret_val);									
	END;
	
	// DID		
	BOOLEAN fn_match_did( dataset (liensv2_services.layout_lien_party) LE,
												LiensV2_Services.Batch_Layouts.batch_in RI)  := FUNCTION	
																	
		tmp_int_layout loop_did( liensv2_services.layout_lien_party_parsed  L,
														 LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM              	            
			self.val := if ((unsigned6) L.did = R.did AND L.did <> '', 1, 2); 				   
		END;							 					   
		BOOLEAN ret_val := min(project(LE.parsed_parties, loop_did(LEFT,RI)), val) = 1;
		RETURN (ret_val);									
	END;
	
	// street address
	BOOLEAN fn_match_streetAddress ( dataset (liensv2_services.layout_lien_party) LE,
																	 LiensV2_Services.Batch_Layouts.batch_in RI) := FUNCTION
		tmp_int_layout xform_streetAddr(liensv2_services.layout_lien_party_address L,
																		LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
			self.val := if (L.prim_name = R.prim_name AND L.prim_range = R.prim_range AND
											L.predir = R.predir       AND L.postdir = R.postdir       AND
											L.addr_suffix = R.addr_suffix and (l.prim_name <> '' AND L.prim_range <> '')
											, 1, 2);
		END;
		BOOLEAN ret_val := min(project(LE.addresses, xform_streetAddr(LEFT,RI)), val) = 1;
		RETURN (ret_val);
	END;

	// city
	BOOLEAN fn_match_city( dataset (liensv2_services.layout_lien_party) LE,
												 LiensV2_Services.Batch_Layouts.batch_in RI)  := FUNCTION	
																
		tmp_int_layout loop_city( liensv2_services.layout_lien_party_address  L,
															LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM              	            
			self.val := if (L.p_city_name = R.p_city_name AND L.p_city_name <> '', 1, 2); 				   
		END;							 					   
		BOOLEAN ret_val := min(project(LE.addresses, loop_city(LEFT,RI)), val) = 1;
		RETURN (ret_val);									
	END;
	
	// state
	BOOLEAN fn_match_state( dataset (liensv2_services.layout_lien_party) LE,
													LiensV2_Services.Batch_Layouts.batch_in RI)  := FUNCTION	
															
		tmp_int_layout loop_state( liensv2_services.layout_lien_party_address  L,
															 LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM              	            
			self.val := if ( L.st = R.st and L.st <> '', 1, 2); 				   
		END;							 					   
		BOOLEAN ret_val := min(project(LE.addresses, loop_state(LEFT,RI)), val) = 1;
		RETURN (ret_val);									
	END;
	
	// zip5
	BOOLEAN fn_match_zip( dataset (liensv2_services.layout_lien_party) LE,
												 LiensV2_Services.Batch_Layouts.batch_in RI)  := FUNCTION	
																
		tmp_int_layout loop_zip( liensv2_services.layout_lien_party_address  L,
														LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM              	            
			self.val := if ( L.zip = R.z5 and L.zip <> '', 1, 2); 				   
		END;							 					   
		BOOLEAN ret_val := min(project(LE.addresses, loop_zip(LEFT,RI)), val) = 1;
		RETURN (ret_val);									
	END;
	
	//Add matchcodes
  EXPORT fn_addMatchcodes(dataset(liensv2_services.layout_lien_rollup) in_rec,
                          dataset(LiensV2_Services.Batch_Layouts.batch_in) batch_in,
                          LiensV2_Services.IParam.batch_params configData) := function

    match_debtor := 'D' in configData.party_types;
    match_creditor := 'C' in configData.party_types;
    match_attorney := 'A' in configData.party_types;

    LiensV2_Services.Batch_Layouts.int_layout_match_bool add_matchcodeValues(in_rec L,
                                                                             batch_in R)  := TRANSFORM
      // fn_match* are called in order to match anything deeper in possible child datasets.
      tmp_match_nameD  := if (match_debtor, fn_match_name(L.debtors,  R), false);
      tmp_match_nameC  := if (match_creditor, fn_match_name(L.creditors,  R), false);
      tmp_match_nameA  := if (match_attorney, fn_match_name(L.attorneys,  R), false);
      tmp_match_name := tmp_match_nameD or tmp_match_nameC or tmp_match_nameA;
      SELF.match_name := tmp_match_name;

      tmp_match_street_addressD  := if (match_debtor, fn_match_streetaddress(L.debtors,  R), false);
      tmp_match_street_addressC  := if (match_creditor, fn_match_streetaddress(L.creditors,  R), false);
      tmp_match_street_addressA  := if (match_attorney, fn_match_streetaddress(L.attorneys,  R), false);
      tmp_match_street_address := tmp_match_street_addressD or tmp_match_street_addressC or tmp_match_street_addressA;
      SELF.match_street_address := tmp_match_street_address;

      tmp_match_cityD  := if (match_debtor, fn_match_city(L.debtors,  R), false);
      tmp_match_cityC  := if (match_creditor, fn_match_city(L.creditors,  R), false);
      tmp_match_cityA  := if (match_attorney, fn_match_city(L.attorneys,  R), false);
      tmp_match_city := tmp_match_cityD or tmp_match_cityC or tmp_match_cityA;
      SELF.match_city  := tmp_match_city;

      tmp_match_stateD  := if (match_debtor, fn_match_state(L.debtors,  R), false);
      tmp_match_stateC  := if (match_creditor, fn_match_state(L.creditors,  R), false);
      tmp_match_stateA  := if (match_attorney, fn_match_state(L.attorneys,  R), false);
      tmp_match_state := tmp_match_stateD or tmp_match_stateC or tmp_match_stateA;
      SELF.match_state := tmp_match_state;

      tmp_match_zipD  := if (match_debtor, fn_match_zip(L.debtors,  R), false);
      tmp_match_zipC  := if (match_creditor, fn_match_zip(L.creditors,  R), false);
      tmp_match_zipA  := if (match_attorney, fn_match_zip(L.attorneys,  R), false);
      tmp_match_zip := tmp_match_zipD or tmp_match_zipC or tmp_match_zipA;
      SELF.match_zip   := tmp_match_zip;

      tmp_match_ssnD  := if (match_debtor, fn_match_ssn(L.debtors,  R), false);
      tmp_match_ssnC  := if (match_creditor, fn_match_ssn(L.creditors,  R), false);
      tmp_match_ssnA  := if (match_attorney, fn_match_ssn(L.attorneys,  R), false);
      tmp_match_ssn := tmp_match_ssnD or tmp_match_ssnC or tmp_match_ssnA;
      SELF.match_ssn   := tmp_match_ssn;

      //adding DID match
      // tmp_match_didD  := if ('D' in configData.party_types, fn_match_did(L.debtors,  R), true);
      // tmp_match_didC  := if ('C' in configData.party_types, fn_match_did(L.creditors,  R), true);
      // tmp_match_didA  := if ('A' in configData.party_types, fn_match_did(L.attorneys,  R), true);
      // tmp_match_did := tmp_match_didD OR tmp_match_didC OR tmp_match_didA;
      // SELF.match_did   := tmp_match_did;

      SELF.match_dob   := true; // set here cause no DOB data in J & L output.

      SELF.acctno      := L.acctno; // sets acctno
      nameV   := ((~(configData.MatchName)) OR (tmp_match_name));
      streetV := ((~(configData.MatchStrAddr)) OR (tmp_match_street_address));
      cityV  :=  ((~(configData.MatchCity)) OR (tmp_match_city));
      stateV :=  ((~(configData.MatchState)) OR (tmp_match_state));
      zipV   :=  ((~(configData.MatchZip)) OR (tmp_match_zip));
      ssnV   :=  ((~(configData.MatchSSN)) OR (tmp_match_ssn));

      SELF.matches :=  nameV AND streetV AND cityV AND StateV AND zipV AND ssnV;
      SELF.matchcodes := BatchServices.Functions.match_code_result(tmp_match_name, tmp_match_street_address,
                                                                   tmp_match_city, tmp_match_state,tmp_match_zip,
                                                                   // tmp_match_ssn, FALSE,tmp_match_did);
                                                                   tmp_match_ssn, FALSE,false);
      SELF  := L;

      SELF := [];
    END;

    out_rec := join(in_rec, batch_in,
                    LEFT.acctno = RIGHT.acctno,
                    add_matchcodeValues(LEFT, RIGHT));
    RETURN out_rec;
  END;	
	
	EXPORT fn_applyBatchFcraOverrides(dataset(LiensV2_Services.layout_lien_rollup) raw_rec,
																		dataset(LiensV2_Services.Batch_Layouts.layout_batchids) batch_in,
																		dataset(fcra.Layout_override_flag) flagfile,
																		string in_ssn_mask_value = '',
																		DATASET(FFD.Layouts.PersonContextBatchSlim) dsSlimPC = DATASET([],FFD.Layouts.PersonContextBatchSlim),
																		integer8 inFFDOptionsMask = 0)  := FUNCTION
		
		// Get overrides records:
		ds_flags := flagfile(file_id = FCRA.FILE_ID.LIEN);
		liens_correct_tmsid_record_id := SET (ds_flags, record_id[1..50]); //there is no rmsid
		liens_correct_record_id := SET (ds_flags, record_id);

		// Get only "good" records (filtered out by both main- and party- override ids:
		LiensV2_Services.layout_lien_rollup xformCleanRecs(LiensV2_Services.Batch_Layouts.layout_batchids L, LiensV2_Services.layout_lien_rollup R) 
			:= transform, 
				 skip(R.tmsid IN set(ds_flags((unsigned6)did = L.did), record_id[1..50]) // old way of filtering records prior to 11/13/2012
							or (string)R.persistent_record_id IN set(ds_flags((unsigned6)did = L.did), record_id) 
							or exists(R.debtors((string)persistent_record_id IN set(ds_flags((unsigned6)did = L.did), record_id))) 
							or exists(R.creditors((string)persistent_record_id IN set(ds_flags((unsigned6)did = L.did), record_id)))
							or exists(R.attorneys((string)persistent_record_id IN set(ds_flags((unsigned6)did = L.did), record_id))) 
							or exists(R.thds((string)persistent_record_id IN set(ds_flags((unsigned6)did = L.did), record_id))) 
							or exists(R.filings((string)persistent_record_id IN set(ds_flags((unsigned6)did = L.did), record_id)))) // new way, using the persistent_record_id
			self := R;
		end;
		ds_clean := join(batch_in, raw_rec, 
										 left.acctno = right.acctno
										 and left.tmsid = right.tmsid,
										 xformCleanRecs(left, right));
													
		//get corrections (both for main- and search- files)
		ds_party_overrides := join(ds_flags, FCRA.key_Override_liensv2_party_ffid,
															keyed(left.flag_file_id = right.flag_file_id),
															transform(liensv2_services.layout_lien_party_raw,self:=right,self:=[]),
															keep(1));
		ds_party_corrections := GROUP (SORT (ds_party_overrides, acctno), acctno);
														
		ds_main_overrides := join(ds_flags, FCRA.key_Override_liensv2_main_ffid,
															keyed(left.flag_file_id = right.flag_file_id),
															transform(right),
															keep(1));
														
		liensv2_services.layout_liens_case_extended GetCase (ds_main_overrides r) := TRANSFORM
			SELF.filing_status := choosen(r.filing_status,10);
			SELF.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(r.filing_jurisdiction);
			SELF := r;
			SELF := [];
		END;
		ds_case_corrections := PROJECT (ds_main_overrides, GetCase (Left));

		liensv2_services.layout_liens_history_extended GetHistory (ds_main_overrides r) := TRANSFORM
			SELF.filings := dataset ([{r.filing_number, r.filing_type_desc, r.orig_filing_date, r.filing_date, r.filing_time,
																 r.filing_book, r.filing_page, r.agency, r.agency_state, r.agency_city,
																 r.agency_county, r.persistent_record_id, DATASET([], FFD.Layouts.StatementIdRec), false, r.bcbflag}],
                               liensv2_services.layout_lien_history_w_bcb);
			SELF.tmsid := r.tmsid;
			self.acctno := '';
		END;
		ds_history_corrections_pre := PROJECT (ds_main_overrides, GetHistory (Left));
		ds_history_corrections := join(ds_history_corrections_pre,batch_in,
																	  left.tmsid = right.tmsid , 
																		transform(liensv2_services.layout_liens_history_extended,
																							self.acctno := right.acctno, self := left),
																		left outer);
		

		// Run through amelioration process (fcra-neutral)
		ds_correct := LiensV2_Services.GetCRSOutput (ds_party_corrections, ds_case_corrections, 
																								 ds_history_corrections, in_ssn_mask_value, true,
																									'',FALSE,FALSE,dsSlimPC,inFFDOptionsMask);
		//join to get acctno for ds_correct
		ds_correct_plus_acctno := join(ds_correct, batch_in, 
																	 left.tmsid = right.tmsid, 
																	 transform(LiensV2_Services.layout_lien_rollup, 
																						 self.acctno := right.acctno, 
																						 self := left));
		
		// add user's (override) records 
		ds_correct_final := join(ds_correct_plus_acctno, ds_clean,
														 left.acctno = right.acctno and
														 left.tmsid = right.tmsid,
														 transform(left),
														 left only); //to make sure that if there are two records that share a tmsid only the ones that has overrides based on the DID gets the override records
		ds_final := ds_clean + ds_correct_final;

	RETURN ds_final (FCRA.lien_is_ok ((STRING)STD.Date.Today(), orig_filing_date)); //filter by fcra-date criteria
    
	END;
	export STRING fn_DisplayAddress1( DATASET(liensv2_services.layout_lien_party_address) address) :=
	FUNCTION
		RETURN TRIM(address[1].prim_range) + ' ' 
				 + TRIM(address[1].predir) + ' ' 
				 + TRIM(address[1].prim_name) + ' ' 
				 + TRIM(address[1].addr_suffix) + ' ' 
				 + TRIM(address[1].postdir);
	END;

export STRING fn_DisplayAddress2( DATASET(liensv2_services.layout_lien_party_address) address) :=
	FUNCTION
		RETURN TRIM(address[1].unit_desig) + ' ' + TRIM(address[1].sec_range);
	END;
	
export STRING fn_FormatSSN(STRING9 ssn) :=
	FUNCTION
		unformattedSSN := IF( LENGTH(TRIM(ssn)) = 4,
		                      '00000' + ssn,
		                      ssn
		                    );
		formattedSSN := unformattedSSN[1..3] + '-' + unformattedSSN[4..5] + '-' + unformattedSSN[6..9];
		
		RETURN IF( LENGTH(TRIM(ssn)) = 0, '', formattedSSN );
	END;
	
END;