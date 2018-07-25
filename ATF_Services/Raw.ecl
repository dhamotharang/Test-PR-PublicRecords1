import atf, iesp, Census_Data, FCRA, FFD, ATF_Services;

export Raw := module

		export ATF_Services.Layouts.atfNumberPlus byDIDs(dataset(ATF_Services.Layouts.search_did) in_dids, 
																				boolean isFCRA = false) := function		
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,atf.Key_atf_did(isFCRA),
										 keyed(left.did= right.did),
										 transform(Layouts.atfNumberPlus,
															self.atf_id :=  right.atf_id, 
															self.license_number := '',
															self.did := right.did,
															self.bdid := 0,
															self.isDeepDive := left.isDeepDive,
															self := right), 
										 limit(atf_services.constants.MAX_ATF_IDS_PER_DID, skip));
			return joinup;
		end;
				
		export ATF_Services.Layouts.atfNumberPlus byBDIDs(dataset(ATF_Services.Layouts.search_bdid) in_bdids) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,atf.Key_atf_BDID(),
											keyed((string) left.bdid = right.bdid),
											transform(Layouts.atfNumberPlus,
																self.license_number := '',
																self.atf_id := right.atf_id,
																self.did := 0,
																self.bdid := (unsigned6) right.bdid,
																self.isDeepDive := left.isDeepDive,
																self := right),
											limit(atf_services.constants.MAX_ATF_IDS_PER_BDID, skip)); 
				
			return joinup;
		end;		
		
		export ATF_Services.Layouts.atfNumberPlus byLicenseNumber(dataset(ATF_Services.Layouts.atfNumberPlus) in_licenseNumber) := function
			deduped := dedup(sort(in_licenseNumber,license_number),license_number);
			joinup := join(deduped,atf.Key_atf_lnum(),
											keyed(left.license_number =  right.license_number),
											transform(Layouts.atfNumberPlus,														 
																self.atf_id := right.atf_id,
																self.license_number  := right.license_number,
																self.bdid := 0,
																self.did := 0,
																self.isDeepDive := left.isDeepDive,
																self := right), 
											limit(atf_services.constants.MAX_ATF_IDS_PER_LNUM, skip)); 
													
			deduped_lnum := dedup(sort(joinup, atf_id), atf_id);
			return deduped_lnum;
		end;
		
		export  byATF_Ids(dataset(ATF_Services.Layouts.ATFNumberPlus) in_recs, 
											boolean isFCRA = false, 
											dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
  										dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
											integer8 inFFDOptionsMask = 0
										  ) := function
		 
			boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
																			 
			atf_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.ATF), record_id);
			atf_correct_ffid    := SET (flagfile (file_id = FCRA.FILE_ID.ATF), flag_file_id);

			// join to payload key.
			recs_1 := join(in_recs,ATF.key_ATF_id(isFCRA),
										 keyed(left.atf_id = right.atf_id) and
										 (~isFCRA or (string)right.atf_id NOT IN atf_correct_rec_id), //atf_id is persitent_record_id for ATF dataset
												transform(atf_Services.Layouts.rawrec,
																	self.bdid := if(left.bdid <> 0, (string) left.bdid, right.bdid),
																	self.did_out := if(left.did <> 0, (string) left.did, right.did_out),
																	self.atf_id :=left.atf_id,
																	self.isDeepDive := left.isDeepDive,
																	self.lic_exp_Date := functions.code_to_year(right.lic_xprdte)+ functions.code_to_month(right.lic_xprdte) + '00',
																	self.StatementIds := [],
																	self.isDisputed := false,
																	self:=right ), 
																	limit(atf_services.constants.MAX_RECS_PER_ATF_ID, skip));
																	
			// overrides
			recs_over := CHOOSEN (fcra.key_override_atf.atf(keyed (flag_file_id IN atf_correct_ffid)),
																FCRA.compliance.MAX_OVERRIDE_LIMIT);

			// put overrides into same layout, combine main data and overrides;
			recs_override_final := project (recs_over, transform (atf_Services.Layouts.rawrec,
																											   self := left,
																												 self.StatementIDS := [] 
																															));
						
			recs_fcra := recs_1 + recs_override_final;
				
			ATF_Services.Layouts.rawrec xformStatements( atf_Services.Layouts.rawrec l , 
																									 FFD.Layouts.PersonContextBatchSlim r ) := transform,
					skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
					self.StatementIDs := r.StatementIDs;
					self.IsDisputed   := r.IsDisputed;
					self := l;
			end;
				
			recs_final_fcra := join(recs_fcra,slim_pc_recs,
															left.did_out = right.lexid and 
															left.atf_id = (integer) right.RecID1,	
															xformStatements(left,right), 
															left outer, 
															keep(1),limit(0));
																			
			recs := if (isFCRA, recs_final_fcra, recs_1);
			no_county_recs := recs(premise_fips_county_name = '');
			census_data.MAC_Fips2County_Keyed(no_county_recs, premise_st, premise_fips_county, premise_fips_County_name, recs_countyname); //less than 1% of the records do not already have a county
			recs_final := recs(premise_fips_county_name <> '') + if(exists(no_county_recs), recs_countyname);
			return recs_final;
		end;
		
		
  // This function gets ATF detailed data to return in an "iesp" search results view
	// for an input dataset of license numbers.  It first gets the atf_id numbers for 
	// the set of input license numbers.  Then it gets the data for those atf_ids from  
	// the associated ATF_id key file.
	// This function was added for the BIP project TopBusiness_Services.SourceService,
	// but may be able to be used for other purposes.
  export search_view := module
	  export bylicensenbr(dataset(ATF_Services.Layouts.atfNumberPlus) in_licensenumbers) := function

      // Use "byLicenseNumber" up in the "Raw" module outside of this search_view
      deduped_atf_ids := byLicenseNumber(in_licensenumbers);
     
			atf_recs 				:= byATF_Ids(deduped_atf_ids);
			atf_recs_dup 		:= dedup(sort(atf_recs, license_number), license_number);

			return atf_recs_dup;
		end;	
	end; // end search_view module

end;