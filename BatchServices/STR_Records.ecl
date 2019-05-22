import Advo, BatchServices, suppress, doxie;

export STR_Records(DATASET(BatchServices.STR_Layouts.batch_in) batch_in, 
									 BatchServices.Interfaces.str_config in_mod) := 
FUNCTION

	/*
	//////////////////////////////////////////////////////////////////////////
	Phase 2 Enhancements:
		4.1.1. Allow property search by APN.
				- need to expose apn in the input layout and use property address to find residents.
		4.1.2/4.1.6. Return family member indicator (LNMatchesOwner_flag).
				- match subject last name against property owners' last names.
		4.1.4. Return owner's best address. 
				- along with already returned best name, ssn.
		4.1.5. Do not return deceased subjects.
				- add option to not return the subject in case of deceased.
		4.1.7. Return file_split_flag for each acctno.
				- based on overall_hit_flag returned for each record.
		4.1.8. Return property address.
				- we currently do not return this, now needed because you may have searches by APN only.
	//////////////////////////////////////////////////////////////////////////	
	*/

	doxie.MAC_Header_Field_Declare();
	
	//////////////////////////////////////////////////////////////////////////
	// cleanup addresses and drop records missing secondary range
	//////////////////////////////////////////////////////////////////////////	

	ds_batch_in_clean := project(dedup(sort(batch_in, acctno), acctno), BatchServices.STR_Transforms.clean_batch_in(LEFT));	
	// address search must not use apn.
	ds_batch_in_addr	:= project(ds_batch_in_clean, transform(BatchServices.STR_Layouts.batch_in_ready, self.apn := '', self := left));
	ds_drop_batch_in := join(ds_batch_in_addr,Advo.Key_Addr1,   // join to the advo file looking for drop indicator
												keyed(left.z5 != '' and left.z5 = right.zip) and
												keyed(left.prim_range = right.prim_range) and
												keyed(left.prim_name = right.prim_name) and
												keyed(left.addr_suffix = right.addr_suffix) and
												keyed(left.predir = right.predir) and
												keyed(left.postdir = right.postdir) 
												and	(left.sec_range = right.sec_range or left.sec_range = '') 
												and right.drop_indicator = 'Y'
												, transform(BatchServices.STR_Layouts.batch_in_ready,
																		self.drop_ind := right.drop_indicator,
																		self.missing_sec_range := right.drop_indicator = 'Y' or left.missing_sec_range,
																		self := left), 
												keep(1), limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT), left outer);
	ds_batch_in_all := if(in_mod.ExcludeDropIndCheck, ds_batch_in_addr, ds_drop_batch_in);
	ds_batch_in_addr_clean_ok := ds_batch_in_all(error_code=BatchServices.STR_Constants.ErrorCodes.NO_ERROR);	
		
	//////////////////////////////////////////////////////////////////////////
	// Properties:
	//  For each input address, find the latest tax, sale and ownership information 
	//  within the date range specifiend on input. 
	//////////////////////////////////////////////////////////////////////////	

	// first we'll run a regular property search by address only. 	
	p_mod_addr := BatchServices.STR_Property_Records(ds_batch_in_addr_clean_ok, in_mod);
	ds_props_recs_addr 		 := p_mod_addr.records;
	ds_batch_in_addr_nohit := join(ds_batch_in_clean, ds_props_recs_addr, 
																 left.acctno = right.acctno, TRANSFORM(LEFT), 
																 left only);	

	// then, if apn has been provided and no records were found by address, run a search by apn.
	ds_batch_in_apn	:= project(ds_batch_in_addr_nohit(apn<>''), BatchServices.STR_Transforms.fixInputForApnSearch(left));	
	p_mod_apn := BatchServices.STR_Property_Records(ds_batch_in_apn, in_mod);
	ds_props_recs_apn := p_mod_apn.records;

	// TO BE CONFIRMED: is this guaranteed to only execute apn search for acctnos where no records can be found by address?
	ds_props_recs_pre_best := ds_props_recs_addr + ds_props_recs_apn;

	//////////////////////////////////////////////////////////////////////////

	// below, we will fetch records from multiple sources (Residents, DL, MVR and voters).
	// those records will be joined with property records found above to produce final output.
	
	// must update input used to fetch from other sources with property address found in case of search by apn.
  ds_flat_in := join(ds_batch_in_clean, ds_props_recs_pre_best,
										 left.acctno = right.acctno, 
										 BatchServices.STR_Transforms.updateInputForSearch(left, right),
										 left outer, limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT))
										 (error_code=BatchServices.STR_Constants.ErrorCodes.NO_ERROR);
	
	ds_flat_res  		:= BatchServices.STR_Functions.fn_get_residents_recs(ds_flat_in, in_mod);
	// DPPA is applied to both dl and mvr recs. Although not explicitly passing it here, the dppa parameter is read from global module directly (deep down the rabbit hole...).
  ds_flat_dl 			:= BatchServices.STR_Functions.fn_get_dl_recs(ds_flat_in, in_mod);	
	ds_flat_mvr 		:= BatchServices.STR_Functions.fn_get_mvr_recs(ds_flat_in, in_mod);
	ds_flat_voters 	:= BatchServices.STR_Functions.fn_get_voter_recs(ds_flat_in, in_mod);
	ds_flat_all			:= ds_flat_res + ds_flat_dl + ds_flat_mvr + ds_flat_voters;
	
	//////////////////////////////////////////////////////////////////////////

	// we'll also need to pull best information for all residents and owners.
	
	// grab the owner datasets from property records so we can pull all owner dids.
  ds_owners_norm := normalize(ds_props_recs_pre_best, left.owners, 
															TRANSFORM(BatchServices.STR_Layouts.property_owner, self.acctno := left.acctno, self := right));														
  // and the dids from all residents.															
	ds_res_dids 	:= project(ds_flat_all, transform(doxie.layout_references, self.did := left.did))(did<>0);
	ds_owner_dids := project(ds_owners_norm(owner_did<>0), TRANSFORM(doxie.layout_references, SELF.did := LEFT.owner_did));	
	ds_dids 			:= dedup(sort(ds_res_dids+ds_owner_dids, did));	
	
	// now go get best information and update records gathered so far.
	ds_best_recs 	:= BatchServices.STR_Functions.fn_get_best_recs(ds_dids, in_mod);
	ds_flat_all_with_best := join(ds_flat_all, ds_best_recs,
														left.did = right.did,
														BatchServices.STR_Transforms.bestify_residents(left, right), 
														left outer, limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));
	
	//////////////////////////////////////////////////////////////////////////
			
	// update owners with best information.
	ds_owners_best := join(ds_owners_norm, ds_best_recs,
												 left.owner_did = right.did,
												 BatchServices.STR_Transforms.bestify_owners(left, right), 
												 left outer, limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));
	ds_owners_best_sorted := sort(ds_owners_best, acctno, -sortby_date, is_seller, -owner_did, -owner_lname, -owner_fname, -owner_cname);

	// update property records with best owner info. here we are replacing the existing owner dataset
	// with the 'bestified' version (hence denormalize group by acctno only).
  ds_props_recs := denormalize(ds_props_recs_pre_best, ds_owners_best_sorted, left.acctno = right.acctno, GROUP,																		
															 BatchServices.STR_Transforms.add_best_owners_back(left, rows(right)));

	ds_flat_props := join(ds_flat_in, ds_props_recs,
												left.acctno = right.acctno, 														
												TRANSFORM(BatchServices.STR_Layouts.Working_Property,
													SELF.acctno				 := left.acctno,
													SELF.owner1_first  := left.owner1_first,
													SELF.owner1_middle := left.owner1_middle,
													SELF.owner1_last   := left.owner1_last,
													SELF.owner1_suffix := left.owner1_suffix,
													SELF.owner2_first  := left.owner2_first,
													SELF.owner2_middle := left.owner2_middle,
													SELF.owner2_last   := left.owner2_last,
													SELF.owner2_suffix := left.owner2_suffix,
													// need to pull in owners, address, sales and tax information from property recs.
													SELF								:= right,
													SELF								:= left),
													// left outer so even if we can't find property records, we still have one record in the final response
													left outer, limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));

	//////////////////////////////////////////////////////////////////////////
		
	// by dropping all records with no dids, we could potentially be losing some data. might have to revisit if it becomes an issue.
	// also dripping any deceased residents, if requested.
	ds_flat_s := sort(ds_flat_all_with_best(did<>0, in_mod.ReturnDeceased or ~isDeceased), acctno, did);
	ds_flat_r	:= rollup(ds_flat_s, BatchServices.STR_Transforms.rollup_flat_sources(left, right), acctno, did);	

	ds_flat_sources := ds_flat_r(
											 (
													(unsigned3) BA_dt_last_seen div 100 >= search_year_since and (unsigned3) BA_dt_first_seen div 100 <= search_year_until
											  ) or (													
													DL_first_lic_issue_dt_seen<>'' and  
													// keep records issued before end of date range 
													(unsigned3) DL_first_lic_issue_dt_seen[1..4] <= search_year_until	and
													// if we were to use DL expiration date here we could end up with too many NOHITs,
													// so we go with a last issue date after the beginning of search date range
													(unsigned3) DL_last_lic_issue_dt_seen[1..4] >= search_year_since													
													// if expiration available, keep records expiring after beginning of date range
													//(DL_last_expiration_dt_seen='' or (unsigned3) DL_last_expiration_dt_seen[1..4] >= search_year_since)														
												) or (
													// only keep records with at least one date
													MVR_first_renewal_dt_seen<>'' and
													// if we have a renewal date, keep records with renewal date before end of date range
													(unsigned3)MVR_first_renewal_dt_seen[1..4] <= search_year_until and											
													// if we have an expiration date, keep records expiring after beginning of date range 
													(MVR_last_expiration_dt_seen='' or (unsigned3)MVR_last_expiration_dt_seen[1..4] >= search_year_since) 
												) or (												
													(unsigned3)Voter_last_vote_dt[1..4] >= search_year_since-4 and  
													(unsigned3)Voter_last_vote_dt[1..4] <= search_year_until
												)
											);

	ds_flat_sources_with_props := join(ds_flat_props, ds_flat_sources, 
																		 left.acctno = right.acctno, 
																		 BatchServices.STR_Transforms.add_to_final_flat(left, right),
																		 left outer);  

	// sanity check just to make sure we are not exceeding max results per acct																				
	ds_flat_sources_with_props_s 	:= sort(ds_flat_sources_with_props, acctno, -BA_dt_last_seen, -DL_last_expiration_dt_seen, -MVR_last_expiration_dt_seen, -Voter_last_vote_dt, did);	
	ds_flat_final_grouped 				:= group(ds_flat_sources_with_props_s, acctno);
	
	unsigned8 Max_Results_Per_Acct := in_mod.MaxResultsPerAcct;
	ds_flat_final_top_recs 				:= topn(ds_flat_final_grouped, Max_Results_Per_Acct, acctno);

	// we should have ownership information now, so go ahead and calculate hit flags.
	ds_flat_final_with_hitflags := project(ungroup(ds_flat_final_top_recs), BatchServices.STR_Transforms.calculate_hitflags(LEFT, in_mod.ShortTermThreshold));		
	
	// appending failures to output
	ds_flat_failed 		:= join(ds_batch_in_all(error_code<>BatchServices.STR_Constants.ErrorCodes.NO_ERROR), ds_flat_final_with_hitflags, 
														left.acctno = right.acctno, 
														transform(BatchServices.STR_Layouts.Working_Flat, 
															self.overall_hit_flag := BatchServices.STR_Constants.HitFlags.NO_HIT,
															self := left, 
															self := []), 
														left only);
	
	ds_final_pre0		 	:= ds_flat_final_with_hitflags + ds_flat_failed;

	//////////////////////////////////////////////////////////////////////////
	
	// Logic below will set an additional flag (file_split_flag) by checking the hit flag 
	// values returned for each acctno and applying some rules defined by the product team. 
	// Batch consultants will use this flag to split the results into different output files.
	
	// slim the layout so we can group it all together.
	ds_splitfp := project(ds_final_pre0, transform(BatchServices.STR_Layouts.Layout_SplitFlags, 
														_hitflags 		:= dataset([{left.BA_hit_flag},{left.DL_hit_flag},{left.MVR_hit_flag},{left.Voter_hit_flag}], {string2 hf;});
														o_hit_flag := if(left.LNMatchesOwner_flag='Y', '', // Req 4.1.7: if LNMatchesOwner_flag=Y, ignore this hit flag.
																					   left.overall_hit_flag);				
														self.hitflags := dataset([{o_hit_flag}],{string2 hf;}),
														self := left));
														
  // group all hit flags together and apply logic to calculate file split flag.															
	ds_splitfr := rollup(sort(ds_splitfp, acctno), left.acctno = right.acctno,
								 transform(BatchServices.STR_Layouts.Layout_SplitFlags, 
													 self.hitflags := left.hitflags + right.hitflags, 
													 self := left));													
	ds_splitf	:= project(ds_splitfr, BatchServices.STR_Transforms.calculateSplitFlag(left));	
	
	// update results 
	ds_final_split := join(ds_final_pre0, ds_splitf, 
												 left.acctno = right.acctno,
												 transform(BatchServices.STR_Layouts.Working_Flat, 
																	 self.file_split_flag := if(left.error_code=BatchServices.STR_Constants.ErrorCodes.NO_ERROR, 
																															right.file_split_flag, 
																															BatchServices.STR_Constants.SplitFlags.REJECT),
																	 self := left));
	
	//////////////////////////////////////////////////////////////////////////																	 

	ds_final_pre  		:= project(ds_final_split, BatchServices.STR_Transforms.xform_output(left));

  Suppress.MAC_Suppress(ds_final_pre,ds_final_pre_1,application_type_value,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Mask(ds_final_pre_1, ds_final_pre_2, owner1_ssn, '', true, false,,,,ssn_mask_value);	
	Suppress.MAC_Mask(ds_final_pre_2, ds_final_pre_3, owner2_ssn, '', true, false,,,,ssn_mask_value);		

	ds_final := sort(ds_final_pre_3, acctno, -current_address, -BA_dt_last_seen, -DL_last_expiration_dt_seen, -MVR_last_expiration_dt_seen, -Voter_last_vote_dt, did);

	return ds_final;

END;
