import Address, LN_PropertyV2_Services, ut;

export STR_Transforms := 
MODULE

	export STR_Layouts.batch_in_ready clean_batch_in(STR_Layouts.batch_in l) := 
		TRANSFORM
			addr1 			:= 	If(l.addr <> '', l.addr,StringLib.StringCleanSpaces(l.prim_range + ' ' +l.predir + ' '+l.prim_name 
													+ ' ' + l.addr_suffix + ' ' + l.postdir + ' ' + l.unit_desig + ' ' + l.sec_range ));
			addr2 			:= StringLib.StringCleanSpaces(l.p_city_name + ' ' + l.st + ' ' +	l.z5);
			clean_addr 	:= address.GetCleanAddress(addr1,addr2,0).str_addr;
			ca					:= Address.CleanFields(clean_addr);		
			insufficient_input := (ca.prim_range = '' or ca.prim_name = '' or (ca.zip <> '' and (ca.p_city_name = '' or ca.st = '')));
			missing_sec_range  := (ca.rec_type = 'H' or ca.rec_type ='HD') and ca.sec_range = '';
			
			self.prim_range 	:= ca.prim_range;
			self.predir 			:= ca.predir;
			self.prim_name 		:= ca.prim_name;
			self.addr_suffix 	:= ca.addr_suffix;
			self.postdir 			:= ca.postdir;
			self.unit_desig 	:= ca.unit_desig;
			self.sec_range 		:= ca.sec_range;
			self.p_city_name 	:= ca.p_city_name;
			self.st 					:= ca.st;
			self.z5 					:= ca.zip;
			self.zip4 				:= ca.zip4;
			self.county				:= ca.county;
			self.missing_sec_range := missing_sec_range;
			self.error_code		:= MAP(missing_sec_range 	=> STR_Constants.ErrorCodes.MISSING_SEC_RANGE,
															 insufficient_input => STR_Constants.ErrorCodes.INSUFFICIENT_INPUT,
															 STR_Constants.ErrorCodes.NO_ERROR);
			year_to_search 				 := (unsigned3) IF(l.year<>'',l.year, stringlib.GetDateYYYYMMDD()[1..4]);
			years_to_search 			 := IF(l.years_to_search<>'', (unsigned2) l.years_to_search, 1);
			
			self.search_year_until := year_to_search;
			self.search_year_since := year_to_search - years_to_search; 
			self.owner1_first 		 := if(l.owner1_first<>'',TRIM(stringlib.StringToUpperCase(l.owner1_first), LEFT), '');
			self.owner1_middle 		 := if(l.owner1_middle<>'',TRIM(stringlib.StringToUpperCase(l.owner1_middle), LEFT), '');
			self.owner1_last 			 := if(l.owner1_last<>'',TRIM(stringlib.StringToUpperCase(l.owner1_last), LEFT), '');
			self.owner1_suffix		 := if(l.owner1_suffix<>'',TRIM(stringlib.StringToUpperCase(l.owner1_suffix), LEFT), '');
			self.owner2_first 		 := if(l.owner2_first<>'',TRIM(stringlib.StringToUpperCase(l.owner2_first), LEFT), '');
			self.owner2_middle 	   := if(l.owner2_middle<>'',TRIM(stringlib.StringToUpperCase(l.owner2_middle), LEFT), '');
			self.owner2_last 		   := if(l.owner2_last<>'',TRIM(stringlib.StringToUpperCase(l.owner2_last), LEFT), '');
			self.owner2_suffix		 := if(l.owner2_suffix<>'',TRIM(stringlib.StringToUpperCase(l.owner2_suffix), LEFT), '');
			self.apn							 := l.apn,
			self 									 := l
		END;

	export STR_Layouts.batch_in_ready fixInputForApnSearch(STR_Layouts.batch_in_ready l) := 
	TRANSFORM
		self.apnSearch 		:= true,
		self.prim_range 	:= '', // must not use address when searching by apn.
		self.predir 			:= '',
		self.prim_name 		:= '',
		self.addr_suffix 	:= '',
		self.postdir 			:= '',
		self.unit_desig 	:= '',
		self.sec_range 		:= '',
		self.p_city_name 	:= '',
		self.st 					:= '',
		self.z5 					:= '',
		self.zip4 				:= '',	
		self.missing_sec_range := false, // must reset previous error conditions
		self.error_code		:= 0,
		self 					 		:= l
	END;

	/** project input records to input layout needed for penalty functions */	
	export BatchServices.Layouts.layout_batch_in_for_penalties prepare_to_penalize(STR_Layouts.batch_in_ready L) :=
	TRANSFORM 
		SELF._acctno			:= L.acctno;
		SELF._prim_name 	:= L.prim_name;   
		SELF._prim_range 	:= L.prim_range; 
		SELF._postdir 		:= L.postdir;    
		SELF._addr_suffix := L.addr_suffix; 
		SELF._predir 			:= L.predir;	 
		SELF._sec_range 	:= L.sec_range;   
		SELF._p_city_name := L.p_city_name;
		SELF._st 					:= L.st;    
		SELF._z5 					:= L.z5;
	END;
	
	string8 deed_recency(LN_PropertyV2_Services.layouts.deeds.raw_source d) := function
		return map(
			d.contract_date<>''				=> d.contract_date,
			d.recording_date
		);
	end;
	
	export STR_Layouts.Working_Property add_deed_to_flat(STR_Layouts.Working_Property L, 
																											 LN_PropertyV2_Services.layouts.deeds.raw_source R) := 
	TRANSFORM
		// only keep sale date and value for Warranty Deeds. also ignore sale info if refinance deed.
		original_sale := R.document_type_code='WD' and R.fares_refi_flag <> 'T';	
		SELF.sale_date 					:= IF(original_sale, deed_recency(r),'');
		SELF.sale_amount 				:= IF(original_sale, R.sales_price, '');		

		SELF.tax_year 					:= R.sortby_date[1..4];		
		SELF.sortby_date 				:= R.sortby_date;		
		SELF.document_type_code := R.document_type_code;
		SELF.fares_refi_flag 		:= R.fares_refi_flag;
		SELF.apn								:= R.fares_unformatted_apn;
		SELF.rec_type						:= L.ln_fares_id[2];
		SELF										:= L; // we want to keep input fields
	END;	
	
	export STR_Layouts.Working_Property add_assess_to_flat(STR_Layouts.Working_Property L, 
																												 LN_PropertyV2_Services.layouts.assess.raw_source R) := 
	TRANSFORM
		SELF.apn						:= R.fares_unformatted_apn;
		SELF.assessed_value := R.assessed_total_value;
		SELF.sale_amount 		:= R.sales_price;
		SELF.sale_date 			:= R.sale_date;
		SELF.tax_year 			:= R.sortby_date[1..4];		
		SELF.sortby_date 		:= R.sortby_date;		
		SELF.rec_type				:= L.ln_fares_id[2];
		SELF								:= L; // we want to keep input fields
	END;		
	seach_key_rec	:= recordof(LN_PropertyV2_Services.keys.search());
	export STR_Layouts.Working_Property add_party_to_flat(STR_Layouts.Working_Property L, 
																												seach_key_rec R) := 
	TRANSFORM		
		// only add owner if there is something we can work with
		SELF.owners				:= IF(R.did<>0 or R.fname<> '' or R.lname <> '' or R.cname<> '',
														DATASET([{L.acctno, R.did, R.app_ssn, R.fname, R.mname, R.lname, R.name_suffix, 
																			R.bdid, R.cname, R.source_code_1 = 'S', L.sortby_date}], 
																			STR_Layouts.property_owner));			
																	
		// grab address information for this party
		SELF.prim_range 	:= R.prim_range;
		SELF.predir 			:= R.predir;
		SELF.prim_name 		:= R.prim_name;
		SELF.addr_suffix 	:= R.suffix;
		SELF.postdir 			:= R.postdir;
		SELF.unit_desig 	:= R.unit_desig;
		SELF.sec_range 		:= R.sec_range;
		SELF.p_city_name 	:= R.p_city_name;
		SELF.st 					:= R.st;
		SELF.z5 					:= R.zip;
		SELF.zip4					:= R.zip4;		
		SELF.county				:= R.county;
		
		SELF.party_type		:= R.source_code_1;
		SELF 							:= L;
	END;
	
	export STR_Layouts.Working_Property rollup_property_records(STR_Layouts.Working_Property L, 
																															STR_Layouts.Working_Property R) := 
	TRANSFORM		
		// the final dataset of owners will have a history of all owners ordered by sortby_date.
		// sellers are flagged also, so most recent owners should be on top.
	  owners							:= L.owners+R.owners;
		owners_with_dids		:= dedup(sort(owners(owner_did<>0), owner_did, -sortby_date), owner_did);		
		// we could have owners with no did information. roll them up by name.
		owners_no_dids			:= dedup(sort(owners(owner_did=0), owner_lname, owner_fname, owner_mname, owner_suffix, owner_cname, -sortby_date), owner_lname, owner_fname, owner_mname, owner_suffix, owner_cname);
		// negative owner_did to prevent dropping records with no owner did
		s_owners						:= sort(owners_with_dids+owners_no_dids, -sortby_date, is_seller, -owner_did, -owner_lname, -owner_fname, -owner_mname, -owner_suffix, -owner_cname);		
		SELF.owners 				:= choosen(s_owners, STR_Constants.Limits.MAX_OWNERS_KEEP);
		
		// we are rolling up to the most recent record (sortby_date), so we want to keep 
		// whatever value is on the right side
		SELF.assessed_value := IF(R.assessed_value<>'', R.assessed_value, L.assessed_value); 
		SELF.sale_date 			:= IF(R.sale_date<>'', R.sale_date, L.sale_date);
		SELF.sale_amount 		:= IF(R.sale_amount<>'', R.sale_amount, L.sale_amount); 		

		// will flag cases where we may be dealing with multiple addresses.
		// this could be the case if we're searching by APN only.		
		SELF.multipleApnLocation := L.multipleApnLocation or ~ut.NNEQ(L.st, R.st) or ~ut.NNEQ(L.county, R.county), 						
		
		SELF.prim_range 	:= if(R.prim_range<>'', R.prim_range, L.prim_range);
		SELF.predir 			:= if(R.predir<>'', R.predir, L.predir);
		SELF.prim_name 		:= if(R.prim_name<>'', R.prim_name, L.prim_name);
		SELF.addr_suffix 	:= if(R.addr_suffix<>'', R.addr_suffix, L.addr_suffix);
		SELF.postdir 			:= if(R.postdir<>'', R.postdir, L.postdir);
		SELF.unit_desig 	:= if(R.unit_desig<>'', R.unit_desig, L.unit_desig);
		SELF.sec_range 		:= if(R.sec_range<>'', R.sec_range, L.sec_range);
		SELF.p_city_name 	:= if(R.p_city_name<>'', R.p_city_name, L.p_city_name);
		SELF.st 					:= if(R.st<>'', R.st, L.st);
		SELF.z5 					:= if(R.z5<>'', R.z5, L.z5);
		SELF.zip4					:= if(R.zip4<>'', R.zip4, L.zip4);	
		SELF.county				:= if(R.county<>'', R.county, L.county);	
		
		SELF := R;
	END;		
	
	export STR_Layouts.Working_Flat updateInputForSearch(STR_Layouts.batch_in_ready l, 
																											 STR_Layouts.Working_Property r) := 
	TRANSFORM
		self.prim_range 	:= if(r.apnSearch, r.prim_range, l.prim_range), 
		self.predir 			:= if(r.apnSearch, r.predir, l.predir), 
		self.prim_name 		:= if(r.apnSearch, r.prim_name, l.prim_name), 
		self.addr_suffix 	:= if(r.apnSearch, r.addr_suffix, l.addr_suffix), 
		self.postdir 			:= if(r.apnSearch, r.postdir, l.postdir), 
		self.unit_desig 	:= if(r.apnSearch, r.unit_desig, l.unit_desig), 
		self.sec_range 		:= if(r.apnSearch, r.sec_range, l.sec_range), 
		self.p_city_name 	:= if(r.apnSearch, r.p_city_name, l.p_city_name), 
		self.st 					:= if(r.apnSearch, r.st, l.st), 
		self.z5 					:= if(r.apnSearch, r.z5, l.z5), 
		self.zip4 				:= if(r.apnSearch, r.zip4, l.zip4), 
		self.error_code 	:= if(r.apnSearch, r.error_code, l.error_code), 
		self.missing_sec_range := if(r.apnSearch, r.missing_sec_range, l.missing_sec_range), 
		self							:= l,
		self							:= []	
	END;	
	
	export STR_Layouts.Working_Flat bestify_residents(STR_Layouts.Working_Flat l, 
																										STR_Layouts.Best_Plus r) := 
	TRANSFORM	  
	
		self.isDeceased := if(r.did<>0, r.isDeceased, false);	
		// this will be also called for left outer records, so we need r.did<>0		
		self.best_addr 			:= if(r.did<>0, Address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name, r.suffix, r.postdir, r.unit_desig, r.sec_range), l.best_addr),
		self.best_addr_city := if(r.did<>0, r.city_name, l.best_addr_city),
		self.best_addr_st 	:= if(r.did<>0, r.st, l.best_addr_st),
		self.best_addr_zip 	:= if(r.did<>0, r.zip+IF(r.zip4<>'','-'+r.zip4,''), l.best_addr_zip);				
		self.best_addr_dt_first_seen 	:= IF(l.current_address or r.did=0, l.BA_dt_first_seen, (string8) r.addr_dt_first_seen);
		self.best_addr_dt_last_seen 	:= IF(l.current_address or r.did=0, l.BA_dt_last_seen,  (string8) r.addr_dt_last_seen);
		self 								:= l;
	END;	
	
	export STR_Layouts.property_owner bestify_owners(STR_Layouts.property_owner l, 
																									 STR_Layouts.Best_Plus r) := 
	TRANSFORM	  
		// this will be also called for left outer records, so we need r.did<>0
		self.owner_did 			:= IF(r.did<>0, r.did, l.owner_did);
		self.owner_ssn 			:= IF(r.did<>0, r.ssn, l.owner_ssn);
		self.owner_fname 		:= IF(r.did<>0, r.fname, l.owner_fname);
		self.owner_mname 		:= IF(r.did<>0, r.mname, l.owner_mname);
		self.owner_lname 		:= IF(r.did<>0, r.lname, l.owner_lname);
		self.owner_suffix 	:= IF(r.did<>0, r.name_suffix, l.owner_suffix);		
		self.owner_addr 		:= IF(r.did<>0, Address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name, r.suffix, r.postdir, r.unit_desig, r.sec_range), '');
		self.owner_addr_city:= IF(r.did<>0, r.city_name, '');
		self.owner_addr_st 	:= IF(r.did<>0, r.st, '');
		self.owner_addr_zip := IF(r.did<>0, r.zip+if(r.zip4<>'','-','')+r.zip4, l.owner_suffix);
		self.owner_dt_first_seen 	:= IF(r.did<>0, r.addr_dt_first_seen, 0);
		self.owner_dt_last_seen 	:= IF(r.did<>0, r.addr_dt_last_seen, 0);
		self 											:= l;
	END;
	
	export STR_Layouts.Working_Property  add_best_owners_back(STR_Layouts.Working_Property  L, 
																														DATASET(STR_Layouts.property_owner) R) :=
	TRANSFORM
		self.owners := R;
		self := L;
	END;	
		
	export STR_Layouts.Working_Flat rollup_flat_sources(STR_Layouts.Working_Flat L, 
																											STR_Layouts.Working_Flat R) := 
	TRANSFORM	
		// we should have a single BA, a single DL, a single MVR and a single Voter for each did at this point.
		SELF.current_address					:= max(L.current_address, R.current_address);
		SELF.BA_hit_flag							:= IF(L.BA_hit_flag<>'',L.BA_hit_flag, R.BA_hit_flag);		
		SELF.BA_first_name						:= IF(L.BA_first_name<>'',L.BA_first_name, R.BA_first_name);
		SELF.BA_middle_name						:= IF(L.BA_middle_name<>'',L.BA_middle_name, R.BA_middle_name);
		SELF.BA_last_name							:= IF(L.BA_last_name<>'',L.BA_last_name, R.BA_last_name);
		SELF.BA_name_suffix						:= IF(L.BA_name_suffix<>'',L.BA_name_suffix, R.BA_name_suffix);
		SELF.BA_dt_first_seen 				:= STR_Functions.min_date(L.BA_dt_first_seen, R.BA_dt_first_seen);
		SELF.BA_dt_last_seen 					:= max(L.BA_dt_last_seen, R.BA_dt_last_seen);
		SELF.DL_hit_flag							:= IF(L.DL_hit_flag<>'',L.DL_hit_flag, R.DL_hit_flag);
		SELF.DL_first_name						:= IF(L.DL_first_name<>'',L.DL_first_name, R.DL_first_name);
		SELF.DL_middle_name						:= IF(L.DL_middle_name<>'',L.DL_middle_name, R.DL_middle_name);
		SELF.DL_last_name							:= IF(L.DL_last_name<>'',L.DL_last_name, R.DL_last_name);
		SELF.DL_name_suffix						:= IF(L.DL_name_suffix<>'',L.DL_name_suffix, R.DL_name_suffix);
		SELF.DL_first_lic_issue_dt_seen := STR_Functions.min_date(L.DL_first_lic_issue_dt_seen, R.DL_first_lic_issue_dt_seen);
		SELF.DL_last_lic_issue_dt_seen 	:= max(L.DL_last_lic_issue_dt_seen, R.DL_last_lic_issue_dt_seen);
		SELF.DL_last_expiration_dt_seen := max(L.DL_last_expiration_dt_seen, R.DL_last_expiration_dt_seen);
		SELF.MVR_hit_flag			 				:= IF(L.MVR_hit_flag<>'',L.MVR_hit_flag, R.MVR_hit_flag);
		SELF.MVR_reg_first_name				:= IF(L.MVR_reg_first_name<>'',L.MVR_reg_first_name, R.MVR_reg_first_name);
		SELF.MVR_reg_middle_name			:= IF(L.MVR_reg_middle_name<>'',L.MVR_reg_middle_name, R.MVR_reg_middle_name);
		SELF.MVR_reg_last_name				:= IF(L.MVR_reg_last_name<>'',L.MVR_reg_last_name, R.MVR_reg_last_name);
		SELF.MVR_reg_name_suffix			:= IF(L.MVR_reg_name_suffix<>'',L.MVR_reg_name_suffix, R.MVR_reg_name_suffix);
		SELF.MVR_first_renewal_dt_seen 	 := STR_Functions.min_date(L.MVR_first_renewal_dt_seen, R.MVR_first_renewal_dt_seen);
		SELF.MVR_last_renewal_dt_seen 	 := max(L.MVR_last_renewal_dt_seen, R.MVR_last_renewal_dt_seen);
		SELF.MVR_last_expiration_dt_seen := max(L.MVR_last_expiration_dt_seen, R.MVR_last_expiration_dt_seen);	
		SELF.Voter_first_name					:= IF(L.Voter_first_name<>'',L.Voter_first_name, R.Voter_first_name);
		SELF.Voter_middle_name				:= IF(L.Voter_middle_name<>'',L.Voter_middle_name, R.Voter_middle_name);
		SELF.Voter_last_name					:= IF(L.Voter_last_name<>'',L.Voter_last_name, R.Voter_last_name);
		SELF.Voter_name_suffix				:= IF(L.Voter_name_suffix<>'',L.Voter_name_suffix, R.Voter_name_suffix);
		SELF.Voter_last_vote_dt 			:= max(L.Voter_last_vote_dt, R.Voter_last_vote_dt);
		SELF 													:= L;
		SELF 													:= R;
	END;		

	// left is property, right is other sources (ba,dl,mvr,voters)
	export STR_Layouts.Working_Flat add_to_final_flat(STR_Layouts.Working_Property L, STR_Layouts.Working_Flat R) := 	
	TRANSFORM		
	  SELF.acctno					:= L.acctno; 
		
		// grabbing top 2 current owners
		owners := L.owners(~is_seller); 
		max_ownership_date := max(owners, sortby_date)[1..4];			
		current_owners := owners(sortby_date[1..4] = max_ownership_date);		
		o1 := current_owners[1];
		o2 := current_owners[2];

		o1_name := StringLib.StringCleanSpaces(o1.owner_fname + ' ' + o1.owner_mname + ' ' + o1.owner_lname + ' ' + o1.owner_suffix);
		o2_name := StringLib.StringCleanSpaces(o2.owner_fname + ' ' + o2.owner_mname + ' ' + o2.owner_lname + ' ' + o2.owner_suffix);
		o1_input_name := StringLib.StringCleanSpaces(L.owner1_first + ' ' + L.owner1_middle + ' ' + L.owner1_last + ' ' + L.owner1_suffix);
		o2_input_name := StringLib.StringCleanSpaces(L.owner2_first + ' ' + L.owner2_middle + ' ' + L.owner2_last + ' ' + L.owner2_suffix);		
		
		// we do have parties with cname instead of first, middle and last name. 		
		SELF.owner1_did 	:= o1.owner_did;
		SELF.owner1_bdid 	:= o1.owner_bdid;
		SELF.owner1_is_business := map(o1.owner_bdid<>0 or o1.owner_cname<>'' => 'Y', o1.owner_did<>0 or o1_name<>'' => 'N', '');
		SELF.owner1_name 	:= MAP(o1_name<>'' => o1_name, o1.owner_cname<>'' => o1.owner_cname, o1_input_name), // owner name may have been passed in the input
		SELF.owner1_ssn  	:= o1.owner_ssn;
		SELF.owner1_addr	 		:= o1.owner_addr;
		SELF.owner1_addr_city	:= o1.owner_addr_city;
		SELF.owner1_addr_st 	:= o1.owner_addr_st;
		SELF.owner1_addr_zip 	:= o1.owner_addr_zip;		
		SELF.owner1_first_seen:= (string8) o1.owner_dt_first_seen;
		SELF.owner1_last_seen	:= (string8) o1.owner_dt_last_seen;
		SELF.owner2_did  := o2.owner_did;
		SELF.owner2_bdid := o2.owner_bdid;
		SELF.owner2_is_business := map(o2.owner_bdid<>0 or o2.owner_cname<>'' => 'Y', o2.owner_did<>0 or o2_name<>'' => 'N', '');
		SELF.owner2_name 	:= MAP(o2_name<>'' => o2_name, o2.owner_cname<>'' => o2.owner_cname, o2_input_name), // owner name may have been passed in the input
		SELF.owner2_ssn  := o2.owner_ssn;				
		SELF.owner2_addr	 		:= o2.owner_addr;
		SELF.owner2_addr_city	:= o2.owner_addr_city;
		SELF.owner2_addr_st 	:= o2.owner_addr_st;
		SELF.owner2_addr_zip 	:= o2.owner_addr_zip;
		SELF.owner2_first_seen:= (string8) o2.owner_dt_first_seen;
		SELF.owner2_last_seen	:= (string8) o2.owner_dt_last_seen;
		SELF.tax_year 			:= L.tax_year;
		SELF.assessed_value := L.assessed_value;
		SELF.sale_date 			:= L.sale_date;
		SELF.sale_amount 		:= L.sale_amount;
		SELF.parcelID_addr				:= Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.addr_suffix, L.postdir, L.unit_desig, L.sec_range),
		SELF.parcelID_addr_city 	:= L.p_city_name,
		SELF.parcelID_addr_st			:= L.st,
		SELF.parcelID_addr_zip		:= L.z5+if(L.zip4<>'','-','')+L.zip4,
		SELF.LNMatchesOwner_flag	:= if(exists(L.owners(owner_lname<>'' and owner_lname in [R.ba_last_name, R.dl_last_name, R.MVR_reg_last_name, R.Voter_last_name])), 'Y', 'N');
		SELF.hasOwnerInfo 				:= exists(L.owners) or L.owner1_last<>'' or L.owner2_last<>'';
		SELF.isOwner 							:= STR_Functions.fn_is_owner(L, R.did);
		SELF.isPreviousOwner 			:= STR_Functions.fn_is_previous_owner(L, R.did); 
		SELF.apn									:= L.apn,
		SELF.apnSearch						:= L.apnSearch,
		SELF := R;
	END;	
			
	export STR_Layouts.Working_Flat calculate_hitflags(STR_Layouts.Working_Flat L, unsigned2 st_threshold) := 
	TRANSFORM

		// all hit flags are calculated based on who the property owner is:
		// OO - if the record belongs to current owner and owner lives in the property
		// O  - if the record belongs to current owner but owner lives in another address
		// PO - if the record belongs to a previous owner
		// LT - if the record does not belong to owner and the record matches Long Term criteria
		// ST - if the record toes not belong to owner and matches Short Term criteria
		// NO - not enough information to flag record as anything else

		// if we have no owner info, set all flags to no hit
		BA_hit_flag 		:= 
		 IF(L.hasOwnerInfo, STR_Functions.fn_calculate_ba_hit_flag(L, L.isOwner, L.isPreviousOwner, st_threshold), STR_Constants.HitFlags.NO_HIT);			
		DL_hit_flag 		:= 
		 IF(L.hasOwnerInfo, STR_Functions.fn_calculate_dl_hit_flag(L, L.isOwner, L.isPreviousOwner, st_threshold), STR_Constants.HitFlags.NO_HIT);			
		MVR_hit_flag 	:= 
		 IF(L.hasOwnerInfo, STR_Functions.fn_calculate_mvr_hit_flag(L, L.isOwner, L.isPreviousOwner, st_threshold), STR_Constants.HitFlags.NO_HIT);			
		Voter_hit_flag := 
		 IF(L.hasOwnerInfo, STR_Functions.fn_calculate_voter_hit_flag(L, L.isOwner, L.isPreviousOwner), STR_Constants.HitFlags.NO_HIT);		
		
		SELF.BA_hit_flag 		:= BA_hit_flag;
		SELF.DL_hit_flag 		:= DL_hit_flag;
		SELF.MVR_hit_flag 	:= MVR_hit_flag;
		SELF.Voter_hit_flag := Voter_hit_flag;
		
		// overall hit flag will be determined based on combination of dates from each data source
		// we will combine the dates to create one date range with the best information we have
		
		string8 first_dt_1 := STR_Functions.min_date(l.BA_dt_first_seen,l.DL_first_lic_issue_dt_seen);
		string8 first_dt_2 := STR_Functions.min_date(first_dt_1, l.MVR_first_renewal_dt_seen);
		string8 first_dt   := STR_Functions.min_date(first_dt_2, l.Voter_last_vote_dt);		
		string8 last_dt := max(first_dt, l.BA_dt_last_seen, l.DL_last_lic_issue_dt_seen, l.MVR_last_renewal_dt_seen, l.Voter_last_vote_dt);
		
		// days_apart only valid in this context if both dates are valid. otw, set to 0 as this is, at best, an indication of ST.
		days_apart 	 := if((integer)last_dt>0 and (integer)first_dt>0, ut.DaysApart(last_dt, first_dt), 0);
		// no hit if dates fall outside date range. takes precedence over LT/ST.
		boolean isNH := (unsigned3) first_dt[1..4] > l.search_year_until or (last_dt<> '' and (unsigned3) last_dt[1..4] < l.search_year_since);
		// only flagging LT if we do have enough evidence, ie. 2 dates more than 180 days apart
		// we might want to consider adding an extra check in case we want to turn any vote dt within date range as LT		
		boolean isLT := last_dt<>'' and days_apart >= st_threshold; 
		// if all we have is a single date, then we'll flag is as ST 
		boolean isST := (last_dt<>'' and days_apart < st_threshold) or (first_dt=last_dt and ~isNH);
		
		_overall_hit_flag := STR_Functions.fn_calculate_hit_flag(l, ~L.hasOwnerInfo, L.isOwner, L.isPreviousOwner, isLT, isST, isNH, 
																														 l.BA_first_name, l.BA_middle_name, l.BA_last_name);
		SELF.overall_hit_flag	:= _overall_hit_flag,
		// Req 4.1.6: Must return blank LNMatchesOwner_flag if overall_hit_flag is not 'ST' or 'LT'
		SELF.LNMatchesOwner_flag := if(L.did<>0 and _overall_hit_flag in [STR_Constants.HitFlags.LONG_TERM, STR_Constants.HitFlags.SHORT_TERM], L.LNMatchesOwner_flag, ''),
		SELF := L;
	END;		
	
   
	EXPORT STR_Layouts.Layout_SplitFlags calculateSplitFlag(STR_Layouts.Layout_SplitFlags l) := transform
		
		/*
			From the requirements: 
				Split flag should be set according to the followng combination of hit flags:
				ST: [ST] or [O] or [PO] or [ST,O] or [ST,O,PO] or [O,PO]
				LT: [LT] or [LT,O] or [LT,O,PO] or [LT,ST] or [LT,ST,O] or [LT,ST,O,PO]
				OO: [OO]
				NO: [NO]
				UD: any other	combination

			We'll use the following bitmasks to check for these combinations:

			 |-----------------------------------------------|
       | Split Flag || NO || OO || LT || ST || O || PO | <---- Hit Flags       
		 	 |-----------------------------------------------|
			 |     ST     || 0  || 0  || 0  || 0  || 0 || 0  | 0x0
       |     ST     || X  || 0  || 0  || 0  || 0 || 1  | 0x1,  0x21  
       |     ST     || X  || 0  || 0  || 0  || 1 || 0  | 0x2,  0x22
       |     ST     || X  || 0  || 0  || 0  || 1 || 1  | 0x3,  0x23
		   |     ST     || X  || 0  || 0  || 1  || 0 || 0  | 0x4,  0x24 
		   |     ST     || X  || 0  || 0  || 1  || 0 || 1  | 0x5,  0x25 
			 |     ST     || X  || 0  || 0  || 1  || 1 || 0  | 0X6,  0x26 
       |     ST     || X  || 0  || 0  || 1  || 1 || 1  | 0x7,  0x27 
			 |     LT     || X  || 0  || 1  || 0  || 0 || 0  | 0x8,  0x28 
			 |     LT     || X  || 0  || 1  || 0  || 0 || 1  | 0x9,  0x29 // Not in the original requirements, but I checked with product and this is correct.
       |     LT     || X  || 0  || 1  || 0  || 1 || 0  | 0xA,  0x2A 
       |     LT     || X  || 0  || 1  || 0  || 1 || 1  | 0xB,  0x2B
       |     LT     || X  || 0  || 1  || 1  || 0 || 0  | 0xC,  0x2C
       |     LT     || X  || 0  || 1  || 1  || 1 || 0  | 0xE,  0x2E
       |     LT     || X  || 0  || 1  || 1  || 1 || 1  | 0xF,  0x2F
       |     OO     || X  || 1  || 0  || 0  || 0 || 0  | 0x10, 0x30  
       |     NO     || 1  || 0  || 0  || 0  || 0 || 0  | 0x20
			 |-----------------------------------------------|
		*/		
		
		hasLT			:=  (unsigned1) exists(l.hitflags(hf=STR_Constants.HitFlags.LONG_TERM));						
		hasST 		:=  (unsigned1) exists(l.hitflags(hf=STR_Constants.HitFlags.SHORT_TERM));
		hasOO			:=  (unsigned1) exists(l.hitflags(hf=STR_Constants.HitFlags.OWNER_OCCUPIED));
		hasO			:=  (unsigned1) exists(l.hitflags(hf=STR_Constants.HitFlags.OWNER));
		hasPO			:=  (unsigned1) exists(l.hitflags(hf=STR_Constants.HitFlags.PREVIOUS_OWNER));
		hasNO			:=  (unsigned1) exists(l.hitflags(hf=STR_Constants.HitFlags.NO_HIT));

		// bit order: NO | OO | LT | ST | O | PO 
		bitmask := 	(hasNO<<5) | (hasOO<<4) | (hasLT<<3) | (hasST<<2) | (hasO<<1) | (hasPO<<0);	
		
		self.file_split_flag := map(
					bitmask = 0x0	=> STR_Constants.SplitFlags.SHORT_TERM,	
					bitmask = 0x1 or bitmask = 0x21 	=> STR_Constants.SplitFlags.SHORT_TERM,	
					bitmask = 0x2	or bitmask = 0x22 	=> STR_Constants.SplitFlags.SHORT_TERM,	
					bitmask = 0x3	or bitmask = 0x23 	=> STR_Constants.SplitFlags.SHORT_TERM,	
					bitmask = 0x4	or bitmask = 0x24 	=> STR_Constants.SplitFlags.SHORT_TERM,	
					bitmask = 0x5	or bitmask = 0x25 	=> STR_Constants.SplitFlags.SHORT_TERM,									
					bitmask = 0x6	or bitmask = 0x26 	=> STR_Constants.SplitFlags.SHORT_TERM,									
					bitmask = 0x7	or bitmask = 0x27 	=> STR_Constants.SplitFlags.SHORT_TERM,									
					bitmask = 0x8	or bitmask = 0x28 	=> STR_Constants.SplitFlags.LONG_TERM,									
					bitmask = 0x9	or bitmask = 0x29 	=> STR_Constants.SplitFlags.LONG_TERM,									
					bitmask = 0xA or bitmask = 0x2A 	=> STR_Constants.SplitFlags.LONG_TERM,
					bitmask = 0xB or bitmask = 0x2B 	=> STR_Constants.SplitFlags.LONG_TERM,	
					bitmask = 0xC or bitmask = 0x2C 	=> STR_Constants.SplitFlags.LONG_TERM,	
					bitmask = 0xE or bitmask = 0x2E 	=> STR_Constants.SplitFlags.LONG_TERM,	
					bitmask = 0xF or bitmask = 0x2F 	=> STR_Constants.SplitFlags.LONG_TERM,	
					bitmask = 0x10 or bitmask = 0x30 	=> STR_Constants.SplitFlags.OWNER_OCCUPIED,									
					bitmask = 0x20	=> STR_Constants.SplitFlags.NO_HIT, 				
					STR_Constants.SplitFlags.UNKNOWN),
								
    self := l								
	end;
	
	export STR_Layouts.batch_out xform_output(STR_Layouts.Working_Flat l) :=
	TRANSFORM		
		SELF.current_address := if(l.current_address, 'Y', if(l.did<>0, 'N', '')),
		SELF := L;
	END;	
	
END;
