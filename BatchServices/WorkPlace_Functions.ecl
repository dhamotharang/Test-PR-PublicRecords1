import corp2, doxie, doxie_cbrs, doxie_raw, gong, AutoStandardI, DeathV2_Services,
 Address, Risk_Indicators, WorkPlace_Services, Business_Header, Header;

export WorkPlace_Functions := module
shared	deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
shared  glb_ok := ut.glb_ok(deathparams.glbpurpose);

// using shared data-access module until it is passed in
shared mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

	// This function returns the spouse did  
	export getSpouseDID(dataset(doxie.layout_references) dids) := FUNCTION
		
		// get did for all possible relatives.
    // Note: now this call is using input permission values; before, defaults were used (dppa=glb=date_threshold=0, ln_branded=false)
		relativesDid := Doxie_Raw.relative_raw(dids, mod_access);
		
		// this just removes the deceased
		liveRelDids := join(relativesDid(depth=1), doxie.key_death_masterV2_ssa_DID,
														keyed(left.person2 = right.l_did)
														and not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
														transform({doxie.layout_references,unsigned1 titleNo}, self.did := left.person2, self.titleNo := left.TitleNo),
														left only);
														
		spousesDid := liveRelDids(titleNo in Header.relative_titles.set_Spouse);		
		RETURN spousesDid;
	END;

	// This function returns spouse did in a batch format.
	export getSpouseDidBatch(dataset(WorkPlace_Layouts.subjectSpouse) inDids) := FUNCTION
			outDids := PROJECT(inDids, TRANSFORM(WorkPlace_Layouts.subjectSpouse, 					
					dtspouse := dataset([{left.did}], doxie.layout_references);
					lDid := getSpouseDID(dtspouse);
					self.spousedid := lDid[1].did;							
					self := left));
			RETURN outDids;
	END;
	
	// Given the phone number, this function returns the listing name and address
	EXPORT getBusinessListingBatch(dataset(WorkPlace_Layouts.PhoneListingBatch) phones):= FUNCTION
	
		dk := JOIN(phones, gong.Key_History_phone, 
				       (keyed(right.p7 = left.phone[4..10]) and 
				        keyed(right.p3 = left.phone[1..3]) 
				        and right.current_flag 
				        and right.listing_type_bus = 'B'), 					    
							 TRANSFORM(WorkPlace_Layouts.PhoneListingBatch, 
								 SELF.acctno := LEFT.acctno,
								 SELF.phone := LEFT.phone,
								 SELF := RIGHT),								
					     KEEP(WorkPlace_Constants.Limits.KEEP_LIMIT), 
							 LIMIT(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED)); 
		RETURN dk;
	END;
	
	// Given the bdid, this function returns the phone number
	EXPORT getBusinessPhoneBatch(dataset(WorkPlace_Layouts.bdidPhoneBatch) bdids) := FUNCTION
		kgh := gong.Key_History_BDID;
		
		gh_slim := join(bdids, kgh,
				              left.bdid!=0 and 
				              keyed(left.bdid=right.bdid) and 
										  right.current_record_flag='Y',				 
				            transform(WorkPlace_Layouts.bdidPhoneBatch, 
											self.acctno := left.acctno,		
											self.phone := right.phone10,
											self.bdid := left.bdid),
					          KEEP(WorkPlace_Constants.Limits.KEEP_LIMIT), 
										LIMIT(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));
		
		RETURN gh_slim;
	END;
	
  // This function determines the value for the self_employed indicator	in the WorkPlace output.
	/* No longer needed, but left in as commented out instead of removing in case it
     is needed in the future.
  If needed, then name checking probably needs enhanced to account for small (less than 3/4?
  character) first/last names that could occur anywhere within a company name.
  Maybe first/last name with a space on either side should be checked for instead?
	EXPORT setSelfEmployedFlag(dataset(BatchServices.WorkPlace_Layouts.final) inFinal) := FUNCTION
		
		outFinal := project(inFinal, TRANSFORM(BatchServices.WorkPlace_Layouts.final, 	
		  uc_company_name := StringLib.StringToUpperCase(left.company_name);
			SELF.self_employed :=  
					IF (StringLib.StringFind(uc_company_name, trim(left.subject_first_name,left,right), 1) > 0 or
							StringLib.StringFind(uc_company_name, trim(left.subject_last_name,left,right), 1) > 0 or 
							(unsigned4) left.subject_ssn = left.company_fein, 		
							  BatchServices.WorkPlace_Constants.SELF_EMPLOYED,
							  BatchServices.WorkPlace_Constants.NOT_SELF_EMPLOYED);		  
						
			SELF := LEFT));
			
		RETURN outFinal;
	END;
  */

	
	// This function gets the most recent corp status for each bdid in a dataset of bdids
	// and optionally (if requested) gets multiple other SOS fields for the online report service.
	export getCorpStatus(dataset(doxie_cbrs.layout_references) ds_in_bdids,
	                     boolean IncludeSOSInfo=false) := FUNCTION

	// First use the bdid(s) to look up all the corp_keys on the 
	// thor_data400::key::corp2::qa::corp::bdid key file.
	ds_bdids_corpkey := join(ds_in_bdids, corp2.keys().corp.bdid.qa,
	                           keyed(left.bdid = right.bdid),
													 transform(WorkPlace_Layouts.bdids_corpstat,
													   self.corp_key := right.corp_key, //only keep corp_key from right 
														 self          := left  // keep bdid from left
								           ),
										       inner,
													 limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

	// Then use all the corp_keys to look up the status & status date and other optional 
	// fields on the thor_data400::key::corp2::qa::corp::corp_key.record_type key file.
	ds_bdids_wcorpstat_all := join(ds_bdids_corpkey,corp2.keys().corp.corpkey.qa,
                                   keyed(left.corp_key = right.corp_key and
													               right.record_type = WorkPlace_Constants.CURRENT), // only want current info
	                               transform(WorkPlace_Layouts.bdids_corpstat,
														       // fields from corp::corp_key.record_type key file, 
																	 // see Corp2.Layout_Corporate_Direct_Corp_Base
                                   self.corp_status_desc := right.corp_status_desc,
                                   self.corp_status_date := if(right.corp_status_date<>'',
																	                             right.corp_status_date,
																	    												 right.corp_process_date),
														       // Optional extra corp/SOS info fields needed for
																	 // the online report service output
																	 self.sos_comp_name         := if(IncludeSOSInfo,right.corp_legal_name,''),
 		                               self.sos_name_as_of_date   := if(IncludeSOSInfo,(string8) right.dt_last_seen,''), // or dt_vendor_last_reported or corp_process_date ???
                                   self.sos_name_type         := if(IncludeSOSInfo,right.corp_ln_name_type_desc,''),
		                               //self.sos_comp_address      := if(IncludeSOSInfo,addr1fromcomponents(right.corp_addr1_prim_range,
																	 //                                                                    ),''),
																	 // store addr parts since that is how they are on the corp file???
                                   self.sos_comp_prim_range  := if(IncludeSOSInfo,right.corp_addr1_prim_range,''),
                                   self.sos_comp_predir      := if(IncludeSOSInfo,right.corp_addr1_predir,''),
                                   self.sos_comp_prim_name   := if(IncludeSOSInfo,right.corp_addr1_prim_name,''),
                                   self.sos_comp_addr_suffix := if(IncludeSOSInfo,right.corp_addr1_addr_suffix,''),
                                   self.sos_comp_postdir     := if(IncludeSOSInfo,right.corp_addr1_postdir,''),
                                   self.sos_comp_unit_desig  := if(IncludeSOSInfo,right.corp_addr1_unit_desig,''),
                                   self.sos_comp_sec_range   := if(IncludeSOSInfo,right.corp_addr1_sec_range,''),
                                   self.sos_comp_city        := if(IncludeSOSInfo,right.corp_addr1_p_city_name,''),
                                   self.sos_comp_state       := if(IncludeSOSInfo,right.corp_addr1_state,''),
                                   self.sos_comp_zip         := if(IncludeSOSInfo,right.corp_addr1_zip5,''),
                                   self.sos_comp_zip4        := if(IncludeSOSInfo,right.corp_addr1_zip4,''),
  	                               self.sos_address_type     := if(IncludeSOSInfo,right.corp_address1_type_desc,''),
                                   self.sos_status           := if(IncludeSOSInfo,
																	                                 trim(right.corp_status_desc,left,right) + 
																                                   if(right.corp_status_comment<>'',
																																	   ' - ' + trim(right.corp_status_comment,left,right),
																																	   ''),
																																  ''),
		                               self.sos_business_type    := if(IncludeSOSInfo,right.corp_orig_org_structure_desc,''), //???
		                               self.sos_purpose          := if(IncludeSOSInfo,right.corp_orig_bus_type_desc,''), //???
																	 // v---- have added to iesp.workplace.reportresponse... ???
		                               //self.sos_date_incorp      := if(IncludeSOSInfo,right.corp_inc_date,''),
		                               self.sos_filing_date      := if(IncludeSOSInfo,right.corp_filing_date,''),
		                               self.sos_for_incorp_date  := if(IncludeSOSInfo,right.corp_forgn_date,''),
		                               self.sos_term             := if(IncludeSOSInfo,right.corp_term_exist_desc,''),
		                               self.sos_igs              := if(IncludeSOSInfo,right.corp_standing,''), //check standing value=???
		                               self.sos_reg_agent_name   := if(IncludeSOSInfo,right.corp_ra_name,''),
		                               //self.sos_reg_agent_address := if(IncludeSOSInfo,right.corp_ra_address_line1,''), ???
																	 // store addr parts since that is how they are on the corp file???
                                   self.sos_reg_agent_prim_range  := if(IncludeSOSInfo,right.corp_ra_prim_range,''),
                                   self.sos_reg_agent_predir      := if(IncludeSOSInfo,right.corp_ra_predir,''),
                                   self.sos_reg_agent_prim_name   := if(IncludeSOSInfo,right.corp_ra_prim_name,''),
                                   self.sos_reg_agent_addr_suffix := if(IncludeSOSInfo,right.corp_ra_addr_suffix,''),
                                   self.sos_reg_agent_postdir     := if(IncludeSOSInfo,right.corp_ra_postdir,''),
                                   self.sos_reg_agent_unit_desig  := if(IncludeSOSInfo,right.corp_ra_unit_desig,''),
                                   self.sos_reg_agent_sec_range   := if(IncludeSOSInfo,right.corp_ra_sec_range,''),
                                   self.sos_reg_agent_city        := if(IncludeSOSInfo,right.corp_ra_p_city_name,''),
                                   self.sos_reg_agent_state       := if(IncludeSOSInfo,right.corp_ra_state,''),
                                   self.sos_reg_agent_zip         := if(IncludeSOSInfo,right.corp_ra_zip5,''),
                                   self.sos_reg_agent_zip4        := if(IncludeSOSInfo,right.corp_ra_zip4,''),
		                               self.sos_place_incorp := if(IncludeSOSInfo,
																	                             if(right.corp_forgn_state_desc<>'',
																															    right.corp_forgn_state_desc,
																																	right.corp_state_origin), // convert to state name ???
																	                                  ''),
		                               self.sos_fein         := '', //if(IncludeSOSInfo,right.corp_???,''),

										               // rest of the fields from the left
                                   self              := left), 
												         inner,
													       keep(WorkPlace_Constants.Limits.KEEP_LIMIT), // keep 1
													       limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

    // Sort status info for a bdid by descending non-blank corp_status_date to 
		// keep only the 1 most current status for all current corp recs for a bdid.
		ds_bdids_wcorpstat := dedup(sort(ds_bdids_wcorpstat_all(corp_status_date<>''),
		                                 bdid,-corp_status_date),
																bdid);
		
		return ds_bdids_wcorpstat;
	end; // end of getCorpStatus function
 
  // This function adds any missing company address/phone info from the 
	// business_header "best" file.
 
 export AddBestInfo(dataset(WorkPlace_Services.Layouts.poe_didkey_plus) ds_inRecs) := FUNCTION

	  // 1. For any recs with a non-zero bdid, sort/dedup on bdid to reduce the number 
		//    of lookups against the bh best key file.
    ds_inrecs_bdids_deduped := dedup(sort(ds_inRecs(bdid !=0),bdid),bdid);

    ZIP5_WIDTH        := 5;
    ZIP4_WIDTH        := 4;
	  LEADING_ZERO_FILL := 1;
    // 2. Join the ds of unique non-zero bdids with the business_header best key file.
	  ds_inrecs_bdids_wbestinfo := join(ds_inrecs_bdids_deduped, Business_Header.Key_BH_Best,
	  			                              keyed(left.bdid=right.bdid),
                                      transform(WorkPlace_Services.Layouts.poe_didkey_plus,
																        // save company name/address/phone/fein from right bh best 
                                        self.company_name        := right.company_name,
																				// store full address and address parts; 
																				// since batch uses full and online uses parts and 
																				// this function is used for both batch & online.
		                                    self.company_address     := Address.Addr1FromComponents(
														                                        right.prim_range,
                                                                    right.predir,
                                                                    right.prim_name,
                                                                    right.addr_suffix,
                                                                    right.postdir,
                                                                    right.unit_desig,
                                                                    right.sec_range),
														            self.company_prim_range  := right.prim_range,
                                        self.company_predir      := right.predir,
                                        self.company_prim_name   := right.prim_name,
                                        self.company_addr_suffix := right.addr_suffix,
                                        self.company_postdir     := right.postdir,
                                        self.company_unit_desig  := right.unit_desig,
                                        self.company_sec_range   := right.sec_range,
																																
														            self.company_city        := right.city,
                                        self.company_state       := right.state,
                                        self.company_zip         := if(right.zip <> 0,
																															         // use intformat in case leading digit of zip is zero
																	                                     intformat(right.zip,ZIP5_WIDTH,LEADING_ZERO_FILL) + 
														                                           if(right.zip4 <>0,
																				 	  							                '-' + intformat(right.zip4,ZIP4_WIDTH,LEADING_ZERO_FILL),
																																					''),
																																			 ''),	
                                        self.company_zip5        := if(right.zip <> 0,
																	                                     intformat(right.zip,ZIP5_WIDTH,LEADING_ZERO_FILL),
																																			 ''),
                                        self.company_zip4        := if(right.zip4 <>0,
																				 	  							             intformat(right.zip4,ZIP4_WIDTH,LEADING_ZERO_FILL),
																																			 ''),
																        self.company_phone1      := (string10) right.phone,
																        self.company_fein        := right.fein,
																				// use existing field in the layout to indicate found on bh best
																	      self.from_gong           := true, 
																	      //rest of fields from left
																	      self                     := left),
											                inner, // only recs from left that match right
															        keep(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
																      limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    // 3. Join the ds of best info for the bdids back to the ds of inrecs replacing
		//    missing data as needed.
    ds_inrecs_bestinfo_added := join(ds_inrecs, ds_inrecs_bdids_wbestinfo,
		  		                             left.bdid = right.bdid,
       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
			  // check for missing address parts and set temp indicator
				comp_addr_missing := if(left.company_address = '' or
						      							left.company_city    = '' or
																left.company_state   = '' or
																left.company_zip     = '',
																true,false);
				// Due to potentially bad data in the POE sources, always store best company_name.
				self.company_name        := if(right.from_gong,
				                               right.company_name,left.company_name),
				// store best entire company address if any parts are missing
				self.company_address     := if(comp_addr_missing and right.from_gong,
																	     right.company_address,left.company_address),
        self.company_prim_range  := if(comp_addr_missing and right.from_gong, 
				                               right.company_prim_range,left.company_prim_range),
        self.company_predir      := if(comp_addr_missing and right.from_gong, 
			                                 right.company_predir,left.company_predir),
        self.company_prim_name   := if(comp_addr_missing and right.from_gong, 
			                                 right.company_prim_name,left.company_prim_name),
        self.company_addr_suffix := if(comp_addr_missing and right.from_gong, 
																			 right.company_addr_suffix,left.company_addr_suffix),
        self.company_postdir     := if(comp_addr_missing and right.from_gong, 
																		   right.company_postdir,left.company_postdir),
        self.company_unit_desig  := if(comp_addr_missing and right.from_gong, 
																			 right.company_unit_desig,left.company_unit_desig),
        self.company_sec_range   := if(comp_addr_missing and right.from_gong, 
																			 right.company_sec_range,left.company_sec_range),
        self.company_city        := if(comp_addr_missing and right.from_gong,
			                                 right.company_city,left.company_city),
        self.company_state       := if(comp_addr_missing and right.from_gong,
				                               right.company_state,left.company_state),
        self.company_zip         := if(comp_addr_missing and right.from_gong,
																			 right.company_zip,left.company_zip),
        self.company_zip5        := if(comp_addr_missing and right.from_gong,
																			 (string) right.company_zip5,left.company_zip5),
        self.company_zip4        := if(comp_addr_missing and right.from_gong,
																			 (string) right.company_zip4,left.company_zip4),
	      // store best phone in phone1 if phone1 is empty or 
				// store in phone2 if phone1 is not empty and phone1 is not = phone2.
        self.company_phone1      := if(left.company_phone1 = '' and right.from_gong,
																       right.company_phone1,left.company_phone1),
			  self.company_phone2      := if(left.company_phone1 != '' and
																	     left.company_phone1 != right.company_phone1 and
																	     right.from_gong,
																	     right.company_phone1,left.company_phone2),
				self.company_fein        := if(left.company_fein != 0 and right.from_gong,
				                               right.company_fein,left.company_fein),
        // rest of the fields, keep the ones from the left ds
        self := left),
											               left outer,  // keep all the recs from the left ds
												             atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));

    // Uncomment lines below as needed for debugging	
    //OUTPUT(ds_inrecs,                 NAMED('aci_ds_inrecs'));
    //OUTPUT(ds_inrecs_bdids_deduped,   NAMED('ds_inrecs_bdids_deduped'));
    //OUTPUT(ds_inrecs_bdids_wbestinfo, NAMED('ds_inrecs_bdids_wbestinfo'));
    //OUTPUT(ds_inrecs_bestinfo_added,  NAMED('ds_inrecs_bestinfo_added'));
	
		ds_outRecs := ds_inrecs_bestinfo_added;

		return ds_outRecs;
	end; // end of AddBestInfo function


	// This function cleans/validates the company_phone1&2 fields data.
	export CleanPhones(dataset(WorkPlace_Services.Layouts.poe_didkey_plus) ds_inRecs) := FUNCTION

		// 1. Check company_phone1 on Telecordia key file to see if the area code (npa) and 
		//    the first 3 of the 7 digit phone# (nxx) and the 4th position of the 7 digit 
		//    phone# (tb) are all valid.
	  ds_inrecs_npanxx_checked1 := join(ds_inrecs, Risk_Indicators.key_Telcordia_tds, 
				                               keyed(left.company_phone1[1..3] = right.npa) and 
																			 keyed(left.company_phone1[4..6] = right.nxx) 
																			 and left.company_phone1[7]    = right.tb,
							                       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
								                       // Blank out phone1 if not valid npa/nxx
																	     self.company_phone1 := if(right.npa !='' and right.nxx != '',
																			                           left.company_phone1,''),
																	     // other fields from left
								                       self  := left),
																     left outer,  // keep all recs from left
					                           keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
																     limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));
		
		// 2. Check company_phone1 on gong history to see if it is: 
		//    i.  disconnected (no rec with current_flag = true)                   OR
		//    ii. it is not a business phone# (no rec with business_flag=true).
	  ds_inrecs_gong_checked1 := join(ds_inrecs_npanxx_checked1, gong.Key_History_phone, 
				                               keyed(left.company_phone1[4..10] = right.p7) and 
					                             keyed(left.company_phone1[1..3]  = right.p3) and 
																       right.current_flag and //we only want current data
							                         right.business_flag,   //we only want businesses
							                       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
								                       // Blank out phone1 if not current and not a business
																	     self.company_phone1 := if(right.current_flag and right.business_flag,
																			                           left.company_phone1,''),
																	     // other fields from left
								                       self  := left),
																     left outer,  // keep all recs from left
					                           keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
																     limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

		// 3. Check company_phone2 on Telecordia key file to see if the area code (npa) and 
		//    the first 3 of the 7 digit phone# (nxx) and the 4th position of the 7 digit 
		//    phone# (tb) are all valid.
	  ds_inrecs_npanxx_checked2 := join(ds_inrecs_gong_checked1, Risk_Indicators.key_Telcordia_tds, 
				                               keyed(left.company_phone2[1..3] = right.npa) and 
																			 keyed(left.company_phone2[4..6] = right.nxx) 
																			 and left.company_phone2[7]    = right.tb,
							                       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
								                       // Blank out phone2 if not valid npa/nxx
																	     self.company_phone2 := if(right.npa !='' and right.nxx != '',
																			                           left.company_phone2,''),
																	     // other fields from left
								                       self  := left),
																     left outer,  // keep all recs from left
					                           keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
																     limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));
		
		// 4. Check company_phone2 on gong history to see if it is: 
		//    i.  disconnected (no rec with current_flag = true)                   OR
		//    ii. it is not a business phone# (no rec with business_flag=true).
	  ds_inrecs_gong_checked2 := join(ds_inrecs_npanxx_checked2, gong.Key_History_phone, 
				                               keyed(left.company_phone2[4..10] = right.p7) and 
					                             keyed(left.company_phone2[1..3]  = right.p3) and 
																       right.current_flag and //we only want current data
							                         right.business_flag,   //we only want businesses
							                       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
								                       // Blank out phone1 if not current and not a business
																	     self.company_phone2 := if(right.current_flag and right.business_flag,
																			                           left.company_phone2,''),
																	     // other fields from left
								                       self  := left),
																     left outer,  // keep all recs from left
					                           keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
																     limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    // 5. After both phone#s checked, move phone2 to phone 1 if phone1 is empty
    ds_inrecs_phones_swapped := project(ds_inrecs_gong_checked2,
								                       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
								                       // If phone 1 empty and phone2 is not, move phone2 to phone1
																	     self.company_phone1 := if(left.company_phone1  = '' and 
																			                           left.company_phone2 != '',
																			                           left.company_phone2,left.company_phone1),
																	     self.company_phone2 := if(left.company_phone1  = '' and 
																			                           left.company_phone2 != '',
																			                           '',left.company_phone2),
																	     // other fields from left
								                       self  := left));

    // Uncomment lines below as needed for debugging
    //OUTPUT(ds_inrecs,                 NAMED('cp1_ds_inrecs'));
    //OUTPUT(ds_inrecs_npanxx_checked1, NAMED('ds_inrecs_npanxx_checked1'));
    //OUTPUT(ds_inrecs_gong_checked1,   NAMED('ds_inrecs_gong_checked1'));
    //OUTPUT(ds_inrecs_npanxx_checked2, NAMED('ds_inrecs_npanxx_checked2'));
    //OUTPUT(ds_inrecs_gong_checked2,   NAMED('ds_inrecs_gong_checked2'));
    //OUTPUT(ds_inrecs_phones_swapped,  NAMED('ds_inrecs_phones_swapped'));
	
		ds_outRecs := ds_inrecs_phones_swapped;

		return ds_outRecs;
	end; // end of CleanPhones function

	// This function cleans/validates the company_name field data.
	export CleanCompName(dataset(WorkPlace_Services.Layouts.poe_didkey_plus) ds_inRecs, 
											 BOOLEAN IncludeSelfRepCompanyName = FALSE) := FUNCTION

		// 1. Blank out any company_names that only contain certain invalid terms.
		//    See the specific list in BatchServices.WorkPlace_Constants.INVALID_COMPANY_NAMES_SET
		//    which was based upon the list in requirement 3.1.6 of the WorkPlace Locator 2.2 
		//    Product Specifications document dated 02/08/2011.
    ds_inrecs_compname_checked := project(ds_inrecs,
      transform(WorkPlace_Services.Layouts.poe_didkey_plus,
			 
				company_name := stringlib.StringToUpperCase(trim(left.company_name, left, right));
				
				self.company_name := IF(company_name IN BatchServices.WorkPlace_Constants.INVALID_COMPANY_NAMES_SET OR
															 (~IncludeSelfRepCompanyName AND company_name IN BatchServices.WorkPlace_Constants.SELF_REP_COMPANY_NAMES_SET), '',
																 LEFT.company_name);
																
        self              := left));
 
    // Uncomment lines below as needed for debugging	
    //OUTPUT(ds_inrecs,                  NAMED('ccn_ds_inrecs'));
    //OUTPUT(ds_inrecs_compname_checked, NAMED('ds_inrecs_compname_checked'));
	
		ds_outRecs := ds_inrecs_compname_checked;
		
		return ds_outRecs;
	end; // end of CleanCompName function

end; // end of Functions module