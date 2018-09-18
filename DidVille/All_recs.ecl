import didville, doxie, header, header_quick, utilfile, STD;

  doxie.MAC_Header_Field_Declare(); //score_threshold_value, phonetics
  mod_access := doxie.functions.GetGlobalDataAccessModule (); 

	//basic id record
	acc_did_rec := record
			 qstring20 acctno;
		unsigned6 did;
	end;

	//hdr+qk&util: match against quick header key
	header.layout_header get_qk_hdr_by_did(acc_did_rec l, header_quick.key_DID r) := transform
		self.rid := (unsigned6)l.acctno,
		self.did := l.did,
		self := r,
	end;


export All_recs := MODULE

	export get_tpl(dataset(didville.layout_bestInfo_batchin) f_in_triple,
								 boolean use_nd_val = FALSE,
								 boolean do_dedup = TRUE,
								 dataset(acc_did_rec) extra = dataset([], acc_did_rec),
								 boolean use_loose_ssn_linking   = FALSE,
								 boolean use_loose_addr_linking  = FALSE,
								 boolean use_loose_phone_linking = FALSE
								) := FUNCTION
	
	//hdr+qk&util: get dids, try all possible(high possibility) methods
	dids_ssn_recs := didville.Did_From_SSN_Batch(f_in_triple,do_dedup,score_threshold_value,true);							
	dids_addr_recs := didville.Did_From_Address_Batch(f_in_triple(name_last<>''),do_dedup,phonetics,1); 
	dids_phone_recs := didville.Did_From_Phone_Batch(f_in_triple,do_dedup);

	dids_all_ready_st := if(use_loose_ssn_linking,  dids_ssn_recs)
	                   + if(use_loose_addr_linking, dids_addr_recs)
										 + if(use_loose_phone_linking,dids_phone_recs)
										 ;

	//only try loose address match if nothing found using any other method
	f_in_triple_ls_rt := join(f_in_triple, dids_all_ready_st,
														left.acctno = right.acctno, 
								transform({didville.layout_bestInfo_batchin},self := left), left only);

	dids_all_ready_ls := didville.Did_From_Address_Batch(f_in_triple_ls_rt,true,phonetics,2);

	//last re-try without considering city
	dids_all_ready_sl := dids_all_ready_st + dids_all_ready_ls; 

	f_in_triple_lt_rt := join(f_in_triple, dids_all_ready_sl,
														left.acctno = right.acctno, 
								transform({didville.layout_bestInfo_batchin},self := left), left only);

	dids_all_ready_lt := didville.Did_From_Address_Batch(f_in_triple_lt_rt,true,phonetics,3);

	dids_all_ready := dids_all_ready_sl +  dids_all_ready_lt;

	//last try for name with only one did 
	f_in_triple_rt := join(f_in_triple, dids_all_ready,
												 left.acctno = right.acctno, 
						 transform({didville.layout_bestInfo_batchin},self := left), left only);
														 
	name_did_rec := record
		acc_did_rec;
		string20 lname;
		string20 fname;
		string20 mname;
	end;
			
	name_did_rec get_name_dids(didville.layout_bestInfo_batchin l, doxie.Key_Header_Wild_Name r) := transform
		self.acctno := l.acctno;
		self.lname := l.name_last;
		self.fname := l.name_first;
		self.mname := l.name_middle;
		self.did := r.did;
	end;		
			
	dids_rt_pre := join(f_in_triple_rt, doxie.Key_Header_Wild_Name,
					keyed(left.name_last = right.lname) and 
											keyed(trim(left.name_first) = right.fname[1..length(trim(left.name_first))]) and
					keyed(left.name_middle[1]=right.minit or left.name_middle='' or right.minit=''),
					get_name_dids(left, right), limit(50, skip));

	dids_rt_dep := dedup(sort(dids_rt_pre(did<>0), record), record);

	name_did_rec get_unique(name_did_rec l) := transform
		self := l;
	end;

	dids_rt_flt1 := join(dids_rt_dep, dids_rt_dep,
											 left.acctno = right.acctno and 
											 left.lname = right.lname and 
					 left.fname = right.fname and 
					 left.mname = right.mname, get_unique(left), limit(1,skip));

	fixed_DRM := Doxie.DataRestriction.fixed_DRM;

	dids_rt_flt2 := dedup(sort(join(dids_rt_flt1, doxie.key_header, 
		left.did = right.s_did and ~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, fixed_DRM),
		get_unique(left), limit(50, skip)), record), record);
							
	dids_rt := project(dids_rt_flt2, transform({acc_did_rec}, self := left));					  				  					  
	//end of last try

	// no one uses the option usenameuniquedid option so we effectively don't need dids_rt, this code is
	// also causing an error: 30398
	
	boolean use_loose_linking := use_loose_ssn_linking  =true 
	                          or use_loose_addr_linking =true
														or use_loose_phone_linking=true
														;
																												
	dids_w_wo_rt := extra + if(use_loose_linking,dids_all_ready);
	//dids_w_wo_rt := if(use_nd_val, dids_all_ready + dids_rt, dids_all_ready);

	
	dids_all_dep := dedup(sort((dids_w_wo_rt)(did<>0), record), record);

	//hdr+qk&util: match against header key
	header.layout_header get_hdr(acc_did_rec l, doxie.key_header r) := transform
		self.rid := (unsigned6)l.acctno,
		self.did := l.did,
		self := r,
	end;
				
	tpl_hdr_rl_recs := join(dids_all_dep, doxie.key_header, 
		keyed(left.did = right.s_did) and 
		~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, fixed_DRM),
		get_hdr(left, right), LIMIT(500,SKIP));
					 

				
	tpl_hdr_qk_recs := join(dids_all_dep, header_quick.key_DID, 
											keyed(left.did = right.did),
							 get_qk_hdr_by_did(left, right), LIMIT(500,SKIP));				 

	//hdr+qk&util: get util recs by did
	unsigned3 add4(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);
	unsigned3 todaydate := (unsigned3)(STD.Date.Today () div 100);
	unsigned3 lesser(unsigned3 dt2) := if (add4(dt2) < todaydate, add4(dt2),todaydate);

	header.layout_header get_util_by_did(acc_did_rec l, utilfile.Key_Util_Daily_Did r) := transform
		self.rid := (unsigned6)l.acctno,
		self.did := l.did,
		self.rec_type := '1';
		self.src := 'UD';
		self.vendor_id := r.id;
		self.suffix := r.addr_suffix;
		self.city_name := r.v_city_name;
		self.dt_first_seen :=  (integer)r.date_first_seen div 100;
		self.dt_last_seen := if((integer)r.date_first_seen div 100=0,0,
														lesser((integer)r.date_first_seen div 100));
		self.dt_vendor_first_reported := self.dt_first_seen;
		self.dt_vendor_last_reported := self.dt_last_seen;
			 self.dt_nonglb_last_seen := self.dt_last_seen;
		self.county := r.county[3..5];
		self.tnt := 'Y';
		self.dob := (unsigned)r.dob;
		SELF := r;
		self := [];
	end;
				
	tpl_util_did_recs := join(dids_all_dep, utilfile.Key_Util_Daily_Did, 
														keyed(left.did = right.s_did),
										get_util_by_did(left, right), LIMIT(500,SKIP));

	//hdr+qk&util: get util recs by ssn and name			
	tpl_util_ssn_recs := didville.Fun_Get_UtilDaily_By_SSN(f_in_triple, score_threshold_value);

	tpl_util_recs := dedup(sort(tpl_util_did_recs + tpl_util_ssn_recs, record), record);

	tpl_raw_recs := group(sort(tpl_hdr_rl_recs + tpl_hdr_qk_recs + tpl_util_recs, rid), rid);

	tpl_flt_recs := didville.fun_filter_by_best_ssn(tpl_raw_recs, f_in_triple, score_threshold_value);


	header.MAC_GlbClean_Header(tpl_flt_recs, tpl_clean_recs, , , mod_access);
	
	// switch did and rid fields so that mac_monitoring_best_addr works properly, i.e it
	// dedups on the did field which is not really a did and the did is preserved in the rid field
	tpl_best_ready := project(tpl_clean_recs, transform({header.layout_header}, 
																										 self.did := left.rid,
																										 self.rid := left.did, self := left));	

	
	return tpl_best_ready;

	END;

export get_dbl(dataset(didville.layout_bestInfo_batchin) f_in_double) := FUNCTION

	//qk&util: get util recs by ssn and name	
	dbl_qk_fdids := header_quick.QuickDid_From_SSN_Batch(f_in_double,true,score_threshold_value);

	dbl_qk_did_recs := join(dbl_qk_fdids, header_quick.key_DID, 
													keyed(left.did = right.did),
								get_qk_hdr_by_did(left, right), LIMIT(500,SKIP));	
		
	header.layout_header get_qk_hdr_by_fdid(acc_did_rec l, header_quick.key_AutokeyPayload r) := transform
		self.rid := (unsigned6)l.acctno,
		self.did := l.did,
		self := r,
	end;
			
	dbl_qk_fdid_recs := join(dbl_qk_fdids, header_quick.key_AutokeyPayload,
													 keyed(left.did = right.fakeid),
							 get_qk_hdr_by_fdid(left, right), LIMIT(500,SKIP));				

	dbl_util_recs := didville.Fun_Get_UtilDaily_By_SSN(f_in_double, score_threshold_value); 

	dbl_raw_recs := group(sort(dbl_qk_did_recs + dbl_qk_fdid_recs + dbl_util_recs, rid), rid);
		 
	dbl_flt_recs := didville.fun_filter_by_best_ssn(dbl_raw_recs, f_in_double, score_threshold_value);
				 
	header.MAC_GlbClean_Header(dbl_flt_recs, dbl_clean_recs, , , mod_access);
	dbl_best_ready := project(dbl_clean_recs, transform({header.layout_header}, 
																										 self.did := left.rid, self := left));
	return dbl_best_ready;
	
	END;	

export get_sgl(dataset(didville.layout_bestInfo_batchin) f_in_single) := FUNCTION
	//util only: get util recs by ssn and name
	sgl_util_recs := didville.Fun_Get_UtilDaily_By_SSN(f_in_single, score_threshold_value);

	sgl_raw_recs := group(sort(sgl_util_recs, rid), rid);
		 
	sgl_flt_recs := didville.fun_filter_by_best_ssn(sgl_raw_recs, f_in_single, score_threshold_value);

	header.MAC_GlbClean_Header(sgl_flt_recs, sgl_clean_recs, , , mod_access);
	sgl_ready := project(sgl_clean_recs, 
											 transform({header.layout_header},
													 self.did := left.rid,self:=left));

	return sgl_ready;	
	
	END;	
	
END;