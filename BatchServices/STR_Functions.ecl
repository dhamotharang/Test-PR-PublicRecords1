import Address_Rank, AutoStandardI, Autokey_Batch, BatchServices, DeathV2_services, DriversV2, DriversV2_Services, doxie, 
			 Header, ut, VehicleV2_Services, VotersV2_Services;

ADDRESS_LABEL 		:= PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt);

export STR_Functions := MODULE

	// returns the min of two dates (unless one is empty)
	EXPORT string min_date(string l, string r) :=		
	FUNCTION
		return if(l<>'' and r<>'', min(l, r), if(l<>'', l, r)); 
	END;

	EXPORT address_to_compare(BatchServices.Layouts.layout_batch_in_for_penalties l, 
		                        BatchServices.STR_Layouts.Working_Property r) :=
		FUNCTION			
			RETURN 
				MODULE(ADDRESS_LABEL)
				
					// The 'input' address:
					EXPORT predir         := l._predir;
					EXPORT prim_name      := l._prim_name;
					EXPORT prim_range     := l._prim_range;
					EXPORT postdir        := l._postdir;
					EXPORT addr_suffix    := l._addr_suffix;
					EXPORT sec_range      := l._sec_range;
					EXPORT p_city_name    := l._p_city_name;
					EXPORT st             := l._st;
					EXPORT z5             := l._z5;					
					
					// The address in the matching record:						
					EXPORT allow_wildcard := FALSE;					
					EXPORT city_field     := r.p_city_name;
					EXPORT city2_field    := '';
					EXPORT pname_field    := r.prim_name;
					EXPORT postdir_field  := r.postdir;
					EXPORT prange_field   := r.prim_range;
					EXPORT predir_field   := r.predir;
					EXPORT state_field    := r.st;
					EXPORT suffix_field   := r.addr_suffix;
					EXPORT zip_field      := r.z5;
					
					EXPORT useGlobalScope := FALSE;
				END;
		END;	
	// Calculate penalty for a pair of addresses.			
	EXPORT penalize_address(BatchServices.Layouts.layout_batch_in_for_penalties l, 
													BatchServices.STR_Layouts.Working_Property r) :=
	FUNCTION			
		RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(address_to_compare(l,r));
	END;			
	
	EXPORT fn_get_best_recs(dataset(doxie.layout_references) dids, 
	                        BatchServices.Interfaces.str_config in_mod) := FUNCTION

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
    glb_ok :=  mod_access.isValidGLB ();
    dppa_ok := mod_access.isValidDPPA ();
		
		ds_best_recs_raw := doxie.best_records(dids
																					 ,doSuppress    := false
																					 ,include_minors:= in_mod.IncludeMinors
																					 ,getSSNBest    := in_mod.GetSSNBest,
																					 modAccess      := mod_access
							                            );
		// additional join to header so we can find a dt_first_seen (not available in best).
		addr_hdr_recs := 
			join(ds_best_recs_raw, doxie.Key_Header, 
							keyed(left.did  = right.s_did) and
							left.prim_range = right.prim_range and
							left.prim_name  = right.prim_name and
							left.zip        = right.zip and
							left.sec_range  = right.sec_range and
							left.predir     = right.predir and 
							left.postdir    = right.postdir and
							left.suffix     = right.suffix ,
						transform(header.Layout_Header, self := right, self := []),
						limit(ut.limits.HEADER_PER_DID, skip));
						
		Header.MAC_GlbClean_Header(addr_hdr_recs,addr_hdr_recs_clean, , , mod_access);

    addr_hrd_recs_by_did := dedup(sort(addr_hdr_recs_clean, did, dt_first_seen=0, dt_first_seen), did);
		//*********************Get address history rank**********************/
		Address_Rank.Layouts.Batch_in addrBestFormat(ds_best_recs_raw l, unsigned c) := transform
			self.acctno      := (string)c;
			self.did         := l.did;
			self.name_first  := l.fname;
			self.name_middle := l.mname;
			self.name_last   := l.lname;
			self.dob         := (string)l.dob;
			self.addr_suffix := l.suffix;
			self.p_city_name := l.city_name;
			self.z5          := (string)l.zip;
			self := l;
			self := [];
		end;
			
		data_in := project(ds_best_recs_raw, addrBestFormat(left, counter));
		mod_bestAddr_params := MODULE(Address_Rank.IParams.BatchParams) 
			EXPORT BOOLEAN IncludeShortTermRental := FALSE;
			EXPORT BOOLEAN IncludeSTRSplitFlag    := FALSE;
			EXPORT UNSIGNED MaxInterHdrRecs       := BatchServices.STR_Constants.Limits.MAX_interHdrRecs;
		END;		
		addr_ranked_recs := Address_Rank.fn_getRank_wMetadata(data_in,mod_bestAddr_params);
		ds_best_addr := 
			join(ds_best_recs_raw, addr_ranked_recs,
						left.did = right.did,
						transform(BatchServices.STR_Layouts.Best_Plus,
							self.prim_range         := right.prim_range,
							self.prim_name          := right.prim_name,
							self.sec_range          := right.sec_range,
							self.predir             := right.predir,
							self.postdir            := right.postdir,
							self.suffix             := right.suffix,
							self.city_name          := right.p_city_name,
							self.st                 := right.st,
							self.zip                := right.z5,
							self.zip4               := right.zip4,
							self.addr_dt_first_seen := (unsigned)right.addr_dt_first_seen,
							self.addr_dt_last_seen  := (unsigned)right.addr_dt_last_seen,
							self.isDeceased         := false,
							self := left),
					 left outer, keep(1), limit(0));			
					 
		ds_best_recs := 
			join(ds_best_addr, addr_hrd_recs_by_did,
						left.did = right.did,
						transform(BatchServices.STR_Layouts.Best_Plus,
											self := left),
					 left outer, keep(1), limit(0));					 
	
	//this join populates the isDeceased flag which is used in
	//STR_Records to filter out deceased records if 
	//SkipDeceasedSubjects = TRUE IOW if we don't want to return deceased records
	  populate_deceasedFlag:= ~in_mod.ReturnDeceased;
		
		// TODO: revisit str_config
		// using global mod below because Interfaces.str_config does not inherit permissions. 
		deathparams := DeathV2_Services.IParam.GetFromDataAccess(mod_access);
		
		ds_best_recs_with_deceased_flag := 
			join(ds_best_recs, doxie.key_death_masterV2_ssa_DID,
					 keyed(left.did = right.l_did) and 
					 not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
					 transform(BatchServices.STR_Layouts.Best_Plus,
										 self.isDeceased := right.l_did > 0,
										 self := left),
					 left outer, keep(1), limit(0));	

		return if(populate_deceasedFlag, ds_best_recs_with_deceased_flag, ds_best_recs);
	END;

	EXPORT fn_get_residents_recs(DATASET(BatchServices.STR_Layouts.Working_Flat) ds_flat_in, 
															 BatchServices.Interfaces.str_config in_mod) :=	
	FUNCTION
	
		res_in_mod := module (BatchServices.Interfaces.res_config)
				export unsigned1 MaxCurrRes  := BatchServices.STR_Constants.Defaults.MAXCURR_RESIDENTS;
				export unsigned1 MaxPriorRes := BatchServices.STR_Constants.Defaults.MAXCURR_RESIDENTS;
				export unsigned4 ThresholdDateForCurrentResidency := BatchServices.STR_Constants.Defaults.THRESHOLD_FOR_CURRENT_RESIDENCY;	// 1 year 
		end;

		res_batch_in := project(ds_flat_in, BatchServices.Layouts.Resident.cln_batch_in);
		ds_ba_recs_1 := BatchServices.Residents_Records(res_batch_in,res_in_mod); 	
		// potentially, there could still be records flagged by residents service as missing secondary range.
		// we'll simply drop those here. the input address will still be used to fetch from other sources.
		ds_ba_recs := ds_ba_recs_1(~missing_sec_range); 

		BatchServices.STR_Layouts.Working_Flat add_best_to_flat(BatchServices.STR_Layouts.Working_Flat L, ds_ba_recs R) := 
		TRANSFORM	
			SELF.did		 					:= R.did;			
			SELF.BA_first_name		:= R.fname;
			SELF.BA_middle_name		:= R.mname;
			SELF.BA_last_name			:= R.lname;
			SELF.BA_name_suffix		:= R.name_suffix;
			SELF.BA_dt_first_seen := (string8) R.dt_first_seen;
			SELF.BA_dt_last_seen  := (string8) R.dt_last_seen;
			SELF.current_address	:= R.current,
			SELF 	:= L;
			SELF	:= R;
		END;	
		
		ds_flat_ba := join(ds_flat_in, ds_ba_recs,
											 left.acctno = right.acctno,
											 add_best_to_flat(LEFT,RIGHT),
											 keep(BatchServices.STR_Constants.Limits.MAX_RECORDS_KEEP), limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));

	  return ds_flat_ba;											
	END;

	EXPORT fn_get_dl_recs(DATASET(BatchServices.STR_Layouts.Working_Flat) ds_flat_in, 
												BatchServices.Interfaces.str_config in_mod) :=	
	FUNCTION
		
		drivers_in_mod := MODULE(DriversV2_Services.GetDLParams.batch_params)
			EXPORT useAllLookups := TRUE;
			EXPORT skip_set := DriversV2.Constants.autokey_skipSet;
			EXPORT boolean return_current_only	:= FALSE : STORED('Return_Current_Only');
		END;
		dl_batch_in := project(ds_flat_in, BatchServices.Layouts.DriversV2.batch_in);
		ds_dl_recs := DriversV2_Services.Batch_Service_Records(dl_batch_in, drivers_in_mod);

		BatchServices.STR_Layouts.Working_Flat add_dl_to_flat(BatchServices.STR_Layouts.Working_Flat L, BatchServices.Layouts.DriversV2.batch_out R) := 
		TRANSFORM
			SELF.did    					 := R.did;
			SELF.DL_first_name		 := R.fname;
			SELF.DL_middle_name		 := R.mname;
			SELF.DL_last_name		 	 := R.lname;
			SELF.DL_name_suffix	 	 := R.name_suffix;
			SELF.DL_first_lic_issue_dt_seen := (string) R.lic_issue_date;
			SELF.DL_last_lic_issue_dt_seen 	:= (string) R.lic_issue_date;
			SELF.DL_last_expiration_dt_seen := (string) R.expiration_date;
			SELF 									 := L;
		END;		

		ds_flat_dl_1 := join(ds_flat_in, ds_dl_recs,
											 left.acctno = right.acctno and		
											 // only keep records with a date we can use
											 right.lic_issue_date<>0,
											 add_dl_to_flat(LEFT,RIGHT),
											 keep(BatchServices.STR_Constants.Limits.MAX_RECORDS_KEEP), limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));

		BatchServices.STR_Layouts.Working_Flat rollup_flat_dl(BatchServices.STR_Layouts.Working_Flat L, BatchServices.STR_Layouts.Working_Flat R) := 
		TRANSFORM							
			self.DL_first_lic_issue_dt_seen := min_date(l.DL_first_lic_issue_dt_seen, r.DL_first_lic_issue_dt_seen); 
			self.DL_last_lic_issue_dt_seen 	:= max(l.DL_last_lic_issue_dt_seen, r.DL_last_lic_issue_dt_seen); 
			self.DL_last_expiration_dt_seen := max(l.DL_last_expiration_dt_seen, r.DL_last_expiration_dt_seen); 
			self := L;
		END;
	
		dl_flat_dl := rollup(sort(ds_flat_dl_1, acctno, did, DL_first_lic_issue_dt_seen, DL_last_lic_issue_dt_seen, DL_last_expiration_dt_seen),
													 rollup_flat_dl(left, right),
													 acctno, did);    												

    return dl_flat_dl;														
	END;
	
  EXPORT fn_get_mvr_recs(DATASET(BatchServices.STR_Layouts.Working_Flat) ds_flat_in, BatchServices.Interfaces.str_config in_mod) :=
	FUNCTION
	
		mvr_batch_in := project(ds_flat_in, VehicleV2_Services.Batch_Layout.Vin_BatchIn); 
		mod := module(VehicleV2_Services.IParam.RTBatch_V2_params)
			EXPORT BOOLEAN penalize_by_party	:= TRUE;
		end;
		ds_mvr_recs := VehicleV2_Services.Vin_Batch_Service_records(mvr_batch_in, mod);										

		BatchServices.STR_Layouts.Working_Flat  add_mvr_to_flat(BatchServices.STR_Layouts.Working_Flat L, 
																														VehicleV2_Services.Batch_Layout.final_layout R) := 
		TRANSFORM
			SELF.did    					     := (unsigned6) R.reg_1_did;
			SELF.MVR_reg_first_name		 := R.reg_1_fname;
			SELF.MVR_reg_middle_name	 := R.reg_1_mname;
			SELF.MVR_reg_last_name		 := R.reg_1_lname;		
			SELF.MVR_reg_name_suffix	 := R.reg_1_name_suffix;
			SELF.did2							 		 := (unsigned6) R.reg_2_did;		
			SELF.MVR_reg2_first_name	 := R.reg_2_fname;
			SELF.MVR_reg2_middle_name	 := R.reg_2_mname;
			SELF.MVR_reg2_last_name		 := R.reg_2_lname;		
			SELF.MVR_reg2_name_suffix	 := R.reg_2_name_suffix;			
			SELF.MVR_first_renewal_dt_seen 	 := min_date(R.reg_earliest_effective_date, R.reg_latest_effective_date);  
			SELF.MVR_last_renewal_dt_seen 	 := max(R.reg_earliest_effective_date, R.reg_latest_effective_date);  
			SELF.MVR_last_expiration_dt_seen := R.reg_latest_expiration_date;		
			SELF.vin  := R.vin;
			SELF 			:= L;
		END;	

		// note: had to take the date check out of the join condition below, as it was causing a join too complex error 
		// when deploying on the latest build_0702_19.
		ds_flat_mvr_1 := join(ds_flat_in, ds_mvr_recs, left.acctno = right.acctno,
													add_mvr_to_flat(LEFT,RIGHT),
													keep(BatchServices.STR_Constants.Limits.MAX_RECORDS_KEEP), limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));

		// only keep records with a date we can use
		ds_flat_mvr_2 := ds_flat_mvr_1(MVR_first_renewal_dt_seen<>'');

		BatchServices.STR_Layouts.Working_Flat split_mvr_recs(BatchServices.STR_Layouts.Working_Flat L, boolean keep_first) := 
		TRANSFORM
			SELF.did    					 			 := if(keep_first, L.did, L.did2);
			SELF.MVR_reg_first_name		 	 := if(keep_first, L.MVR_reg_first_name, L.MVR_reg2_first_name);
			SELF.MVR_reg_middle_name		 := if(keep_first, L.MVR_reg_middle_name, L.MVR_reg2_middle_name);
			SELF.MVR_reg_last_name		 	 := if(keep_first, L.MVR_reg_last_name, L.MVR_reg2_last_name);
			SELF.MVR_reg_name_suffix	 	 := if(keep_first, L.MVR_reg_name_suffix, L.MVR_reg2_name_suffix);
			// dropping reg2 info
			SELF.did2		 	 			 				 := 0;
			SELF.MVR_reg2_first_name		 := '';
			SELF.MVR_reg2_middle_name		 := '';
			SELF.MVR_reg2_last_name		 	 := '';
			SELF.MVR_reg2_name_suffix	 	 := '';
			SELF 									 			 := L;
		END;					

		// splitting records so we can roll the records up by did. 
		ds_flat_mvr_recs_1 := project(ds_flat_mvr_2(did<>0), 	split_mvr_recs(left, true));
		ds_flat_mvr_recs_2 := project(ds_flat_mvr_2(did2<>0), split_mvr_recs(left, false));
														
		BatchServices.STR_Layouts.Working_Flat rollup_flat_mvr(BatchServices.STR_Layouts.Working_Flat L, BatchServices.STR_Layouts.Working_Flat R) := 
		TRANSFORM							
			self.MVR_first_renewal_dt_seen  := min_date(l.MVR_first_renewal_dt_seen, r.MVR_first_renewal_dt_seen); 
			self.MVR_last_renewal_dt_seen  := max(l.MVR_last_renewal_dt_seen, r.MVR_last_renewal_dt_seen); 
			self.MVR_last_expiration_dt_seen := max(l.MVR_last_expiration_dt_seen, r.MVR_last_expiration_dt_seen); 
			self := L;
		END;		
		
		ds_flat_mvr := rollup(sort(ds_flat_mvr_recs_1+ds_flat_mvr_recs_2, acctno, did, MVR_first_renewal_dt_seen, MVR_last_renewal_dt_seen, MVR_last_expiration_dt_seen),
											 rollup_flat_mvr(left, right),
											 acctno, did);	

    return ds_flat_mvr;												
	END;
	
	
	EXPORT fn_get_voter_recs(DATASET(BatchServices.STR_Layouts.Working_Flat) ds_flat_in, BatchServices.Interfaces.str_config in_mod) :=
	FUNCTION
		
		voter_batch_in := project(ds_flat_in, Autokey_batch.Layouts.rec_inBatchMaster);	
		voter_config := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := TRUE;
				export skip_set := ['B'];
		END;
		ds_voter_recs := VotersV2_Services.Batch_Service_Records(voter_batch_in, voter_config);											
		
		BatchServices.STR_Layouts.Working_Flat  add_voter_to_flat(BatchServices.STR_Layouts.Working_Flat L, 
																															VotersV2_Services.Layouts.BatchOutput R) := 
		TRANSFORM
			SELF.did    					 	:= (unsigned6) R.did;
			SELF.Voter_first_name		:= R.fname;
			SELF.Voter_middle_name	:= R.mname;
			SELF.Voter_last_name		:= R.lname;
			SELF.Voter_name_suffix	:= R.name_suffix;
			SELF.Voter_last_vote_dt := R.LastDateVote;
			SELF 									  := L;
			SELF									  := R;		
		END;				
		
		ds_flat_voters_1 := join(ds_flat_in, ds_voter_recs,
											 left.acctno = right.acctno and		
											 // only keep records with dates
											 right.LastDateVote<>'', 
											 add_voter_to_flat(LEFT,RIGHT),
											 keep(BatchServices.STR_Constants.Limits.MAX_RECORDS_KEEP), limit(BatchServices.STR_Constants.Limits.JOIN_LIMIT));	
											 
		BatchServices.STR_Layouts.Working_Flat rollup_flat_voters(BatchServices.STR_Layouts.Working_Flat L, BatchServices.STR_Layouts.Working_Flat R) := 
		TRANSFORM						
			self.Voter_last_vote_dt := max(l.Voter_last_vote_dt, r.Voter_last_vote_dt); 
			self := L;
		END;										 
				
		ds_flat_voters := rollup(sort(ds_flat_voters_1, acctno, did),rollup_flat_voters(left, right),	acctno, did);		

		return ds_flat_voters;
	END;

	// checks for current owner only.
	EXPORT boolean fn_is_owner(BatchServices.STR_Layouts.Working_Property l, unsigned6 did) := 
	FUNCTION	
		// max ownership date to determine current owners
		owners := l.owners(~is_seller);
		max_ownership_date := max(owners, sortby_date)[1..4];		
		
		// try to match owner by did
    current_owners_with_dids := owners(sortby_date[1..4] = max_ownership_date, owner_did<>0);			
		match_by_did := exists(current_owners_with_dids(owner_did=did));
		
		return match_by_did;
		
	END;
	
	EXPORT boolean fn_is_previous_owner(BatchServices.STR_Layouts.Working_Property l, unsigned6 did) := 
	FUNCTION		
		
		max_ownership_date := max(l.owners(~is_seller), sortby_date)[1..4];		
		current_owners_with_dids := l.owners(~is_seller, sortby_date[1..4] = max_ownership_date, owner_did<>0);			
		all_owners_with_dids := l.owners(sortby_date[1..4] <= max_ownership_date, owner_did<>0); 

		match_current_by_did := exists(current_owners_with_dids(owner_did=did));
		match_owner_by_did := exists(all_owners_with_dids(owner_did=did));		
		return ~match_current_by_did and match_owner_by_did;
		
	END;
		
  EXPORT string2 fn_calculate_hit_flag(BatchServices.STR_Layouts.Working_Flat l, boolean noData, boolean is_owner, boolean is_prev_owner, 
																			 boolean is_lt, boolean is_st, boolean is_no_hit, 
																			 string20 fname, string1 mname, string20 lname) := 
	FUNCTION
			// if we found no owners in property records then we try to match by input
			match_owner1_by_input := ut.NameMatch(l.owner1_first, l.owner1_middle,  l.owner1_last, 
																						fname, mname, lname) <= BatchServices.STR_Constants.Defaults.NAME_MATCH_THRESHOLD; 
			match_owner2_by_input := ut.NameMatch(l.owner2_first, l.owner2_middle,  l.owner2_last, 
																						fname, mname, lname) <= BatchServices.STR_Constants.Defaults.NAME_MATCH_THRESHOLD; 
			match_owner_by_input := match_owner1_by_input or match_owner2_by_input;
			
			// the order is important in the map below to keep correct precedence.
			return MAP(noData																					=> BatchServices.STR_Constants.HitFlags.NO_HIT,
								 is_owner and l.current_address									=> BatchServices.STR_Constants.HitFlags.OWNER_OCCUPIED, 
								 is_owner 																			=> BatchServices.STR_Constants.HitFlags.OWNER,  
								 is_prev_owner 																	=> BatchServices.STR_Constants.HitFlags.PREVIOUS_OWNER, 
								 // match by owner above should take precedence over match by input below.
								 match_owner_by_input and l.current_address			=> BatchServices.STR_Constants.HitFlags.OWNER_OCCUPIED, 
								 match_owner_by_input														=> BatchServices.STR_Constants.HitFlags.OWNER, 								 								 
								 // a no hit takes precedence over LT or ST.
								 is_no_hit																			=> BatchServices.STR_Constants.HitFlags.NO_HIT,
								 is_lt 																					=> BatchServices.STR_Constants.HitFlags.LONG_TERM,
								 is_st 																					=> BatchServices.STR_Constants.HitFlags.SHORT_TERM,
								 BatchServices.STR_Constants.HitFlags.NO_HIT);
	END;
	
	EXPORT string2 fn_calculate_ba_hit_flag(BatchServices.STR_Layouts.Working_Flat l, boolean is_owner, boolean is_prev_owner, unsigned2 st_threshold) :=
	FUNCTION

			noData := l.BA_dt_first_seen='' and l.BA_dt_last_seen='';
			isLT := ut.DaysApart(l.BA_dt_last_seen, l.BA_dt_first_seen) > st_threshold;			
			isNH := (unsigned3) l.BA_dt_last_seen[1..4] < l.search_year_since or 
							(unsigned3) l.BA_dt_first_seen[1..4] > l.search_year_until;
			return fn_calculate_hit_flag(l, noData, is_owner, is_prev_owner, isLT, ~isLT, isNH, l.BA_first_name, l.BA_middle_name, l.BA_last_name);

	END;

	EXPORT string2 fn_calculate_dl_hit_flag(BatchServices.STR_Layouts.Working_Flat l, boolean is_owner, boolean is_prev_owner, unsigned2 st_threshold) :=
	FUNCTION

			first_renewal_year := (unsigned3) l.DL_first_lic_issue_dt_seen[1..4];
			last_renewal_dt    := max(l.DL_first_lic_issue_dt_seen, l.DL_last_lic_issue_dt_seen);
			last_renewal_year  := (unsigned3) last_renewal_dt[1..4];

			isWithinDt := (first_renewal_year >= l.search_year_since and first_renewal_year <= l.search_year_until) or
										 (last_renewal_year >= l.search_year_since and last_renewal_year <= l.search_year_until) or
										 (first_renewal_year <= l.search_year_since and last_renewal_year >= l.search_year_until);
			
			noData := last_renewal_year=0 and first_renewal_year=0;
			isLT := isWithinDt;
			isST := isWithinDt and ut.DaysApart(l.DL_first_lic_issue_dt_seen, l.DL_last_expiration_dt_seen)<=st_threshold;			
			isNH := ~isWithinDt;
							
			return fn_calculate_hit_flag(l, noData, is_owner, is_prev_owner, isLT and ~isST, isST, isNH, l.DL_first_name, l.DL_middle_name, l.DL_last_name);
	
	END;

	EXPORT string2 fn_calculate_mvr_hit_flag(BatchServices.STR_Layouts.Working_Flat l, boolean is_owner, boolean is_prev_owner, unsigned2 st_threshold) :=
	FUNCTION

			first_renewal_year 			:= (unsigned3) l.MVR_first_renewal_dt_seen[1..4];
			last_renewal_dt   := max(l.MVR_first_renewal_dt_seen, l.MVR_last_renewal_dt_seen);
			last_renewal_year := (unsigned3) last_renewal_dt[1..4];
			
			isWithinDt := (first_renewal_year >= l.search_year_since and first_renewal_year <= l.search_year_until) or
										 (last_renewal_year >= l.search_year_since and last_renewal_year <= l.search_year_until) or
										 (first_renewal_year <= l.search_year_since and last_renewal_year >= l.search_year_until);
			
			noData := last_renewal_year=0 and first_renewal_year=0;
			isLT := isWithinDt;						
			isST := isWithinDt and ut.DaysApart(l.MVR_first_renewal_dt_seen, l.MVR_last_expiration_dt_seen)<=st_threshold;						
			isNH := ~isWithinDt;
			
			return fn_calculate_hit_flag(l, noData, is_owner, is_prev_owner, isLT and ~isST, isST, isNH, l.MVR_reg_first_name, l.MVR_reg_middle_name, l.MVR_reg_last_name);
			
	END;

	EXPORT string2 fn_calculate_voter_hit_flag(BatchServices.STR_Layouts.Working_Flat l, boolean is_owner, boolean is_prev_owner) :=
	FUNCTION
		
			last_vote_year := (unsigned3) l.Voter_last_vote_dt[1..4];
			isWithinDt := last_vote_year >= l.search_year_since - 4 and last_vote_year <= l.search_year_until;
			
			noData := last_vote_year=0;
			isLT := isWithinDt;					
			isNH := ~isWithinDt;	
			
			return fn_calculate_hit_flag(l, noData, is_owner, is_prev_owner, isLT, false, isNH, l.Voter_first_name, l.Voter_middle_name, l.Voter_last_name);
			
	END;
	
END;