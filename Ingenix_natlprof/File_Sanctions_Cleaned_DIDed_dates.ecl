import ut;

raw_sanc_did_file := Ingenix_NatlProf.Basefile_Sanctions;
				
raw_sanc_did_file append_st(raw_sanc_did_file l) := transform
	self.ProvCo_Address_Clean_st := if(l.ProvCo_Address_Clean_st<>'',
	                                   l.ProvCo_Address_Clean_st, l.sanc_state);
	self := l;
end;	
			
base_file := project(raw_sanc_did_file, append_st(left));

base_dst := distribute(base_file, hash(sanc_id));
base_srt := sort(base_dst, sanc_id, -(integer)process_date, local);

base_srt roll_it(base_srt l, base_srt r) := transform
     self.did := if(l.did='', r.did, l.did);
	
	self.prov_clean_fname := if(l.prov_clean_fname = '', r.prov_clean_fname, l.prov_clean_fname);
	self.prov_clean_mname := if(l.prov_clean_mname = '', r.prov_clean_mname, l.prov_clean_mname);
	self.prov_clean_lname := if(l.prov_clean_lname = '', r.prov_clean_lname, l.prov_clean_lname);
	self.prov_clean_name_suffix := if(l.prov_clean_name_suffix = '' or ut.Translate_Suffix(l.prov_clean_name_suffix)=r.prov_clean_name_suffix, 
	                                  r.prov_clean_name_suffix, 
							    l.prov_clean_name_suffix);
							    
	self.ProvCo_Address_Clean_prim_range := if(l.ProvCo_Address_Clean_prim_range='', 
	                                           r.ProvCo_Address_Clean_prim_range, l.ProvCo_Address_Clean_prim_range);
	self.ProvCo_Address_Clean_predir := if(l.ProvCo_Address_Clean_predir='', 
	                                       r.ProvCo_Address_Clean_predir, l.ProvCo_Address_Clean_predir);
	self.ProvCo_Address_Clean_prim_name := if(l.ProvCo_Address_Clean_prim_name='', 
	                                          r.ProvCo_Address_Clean_prim_name, l.ProvCo_Address_Clean_prim_name);
	self.ProvCo_Address_Clean_addr_suffix := if(l.ProvCo_Address_Clean_addr_suffix='', 
	                                            r.ProvCo_Address_Clean_addr_suffix, l.ProvCo_Address_Clean_addr_suffix);
	self.ProvCo_Address_Clean_postdir := if(l.ProvCo_Address_Clean_postdir='',
	                                        r.ProvCo_Address_Clean_postdir, l.ProvCo_Address_Clean_postdir);
	self.ProvCo_Address_Clean_unit_desig := if(l.ProvCo_Address_Clean_unit_desig='',
	                                           r.ProvCo_Address_Clean_unit_desig, l.ProvCo_Address_Clean_unit_desig);
	self.ProvCo_Address_Clean_sec_range := if(l.ProvCo_Address_Clean_sec_range='',
	                                          r.ProvCo_Address_Clean_sec_range, l.ProvCo_Address_Clean_sec_range);
	self.ProvCo_Address_Clean_p_city_name := if(l.ProvCo_Address_Clean_p_city_name='',
	                                            r.ProvCo_Address_Clean_p_city_name, l.ProvCo_Address_Clean_p_city_name);
	self.ProvCo_Address_Clean_v_city_name := if(l.ProvCo_Address_Clean_v_city_name='',
	                                            r.ProvCo_Address_Clean_v_city_name, l.ProvCo_Address_Clean_v_city_name);
	self.ProvCo_Address_Clean_st := if(l.ProvCo_Address_Clean_st='', 
	                                   r.ProvCo_Address_Clean_st, l.ProvCo_Address_Clean_st);
	self.ProvCo_Address_Clean_zip := if(l.ProvCo_Address_Clean_zip='', 
	                                    r.ProvCo_Address_Clean_zip, l.ProvCo_Address_Clean_zip);
	self.ProvCo_Address_Clean_zip4 := if(l.ProvCo_Address_Clean_zip4='', 
	                                     r.ProvCo_Address_Clean_zip4, l.ProvCo_Address_Clean_zip4);
	self.ProvCo_Address_Clean_geo_lat := if(l.ProvCo_Address_Clean_geo_lat='', 
	                                        r.ProvCo_Address_Clean_geo_lat, l.ProvCo_Address_Clean_geo_lat);
	self.ProvCo_Address_Clean_geo_long := if(l.ProvCo_Address_Clean_geo_long='',
	                                         r.ProvCo_Address_Clean_geo_long, l.ProvCo_Address_Clean_geo_long);
	
	self.sanc_dob := if(l.sanc_dob='', r.sanc_dob, l.sanc_dob);
	self.sanc_tin := if(l.sanc_tin='', r.sanc_tin, l.sanc_tin);
	self.sanc_upin := if(l.sanc_upin='', r.sanc_upin, l.sanc_upin);
	
	self.SANC_PROVTYPE := if(l.SANC_PROVTYPE='', r.SANC_PROVTYPE, l.SANC_PROVTYPE);
	self.SANC_SANCDTE_form := if(l.SANC_SANCDTE_form='', r.SANC_SANCDTE_form, l.SANC_SANCDTE_form);
	self.SANC_SANCDTE := if(l.SANC_SANCDTE_form='', r.SANC_SANCDTE, l.SANC_SANCDTE);
	self.SANC_LICNBR := if(l.SANC_LICNBR='', r.SANC_LICNBR, l.SANC_LICNBR);
	self.SANC_SANCST := if(l.SANC_SANCST='', r.SANC_SANCST, l.SANC_SANCST);
	self.SANC_BRDTYPE := if(l.SANC_BRDTYPE='', r.SANC_BRDTYPE, l.SANC_BRDTYPE);
	self.SANC_SRC_DESC := if(l.SANC_SRC_DESC='', r.SANC_SRC_DESC, l.SANC_SRC_DESC);
	self.SANC_TYPE := if(l.SANC_TYPE='', r.SANC_TYPE, l.SANC_TYPE);
	self.SANC_TERMS := if(l.SANC_TERMS='', r.SANC_TERMS, l.SANC_TERMS);
	self.SANC_REAS := if(l.SANC_REAS='', r.SANC_REAS, l.SANC_REAS);
	self.SANC_COND := if(l.SANC_COND='', r.SANC_COND, l.SANC_COND);
	self.SANC_FINES := if(l.SANC_FINES='', r.SANC_FINES, l.SANC_FINES);		
	self.SANC_UPDTE_form := if(l.SANC_UPDTE_form='', r.SANC_UPDTE_form, l.SANC_UPDTE_form);
	self.SANC_UPDTE := if(l.SANC_UPDTE_form='', r.SANC_UPDTE, l.SANC_UPDTE);
	
	self.date_first_reported := (string8)ut.EarliestDate((integer)l.date_first_reported, (integer)r.date_first_reported);
	self.date_last_reported := (string8)ut.LatestDate((integer)l.date_last_reported, (integer)r.date_last_reported);
	
	self.SANC_REINDTE_form := if(l.SANC_REINDTE_form='', r.SANC_REINDTE_form, l.SANC_REINDTE_form);
	self.SANC_REINDTE := if(l.SANC_REINDTE_form='', r.SANC_REINDTE, l.SANC_REINDTE);
	self.SANC_FAB := if(l.SANC_FAB='', r.SANC_FAB, l.SANC_FAB);
	self.SANC_UNAMB_IND := if(l.SANC_UNAMB_IND='', r.SANC_UNAMB_IND, l.SANC_UNAMB_IND);
	
     self.process_date := (string8)ut.LatestDate((integer)l.process_date, (integer)r.process_date);
	self.date_first_seen := (string8)ut.EarliestDate((integer)l.date_first_seen, (integer)r.date_first_seen);
	self.date_last_seen := (string8)ut.LatestDate((integer)l.date_last_seen, (integer)r.date_last_seen);

	self := l;
end;
 
export File_Sanctions_Cleaned_DIDed_dates := rollup(base_srt, left.sanc_id=right.sanc_id, roll_it(left, right), local) : persist('per_File_Sanctions_Cleaned_DIDed_dates');					  
			
