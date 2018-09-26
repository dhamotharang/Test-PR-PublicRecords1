import MediaOne, address, ut,emailservice, mdr, _validate, Entiera;
export Map_MediaOne_as_Email(version) := function
//************Acquireweb is under develoment.  AID and other fields will be mapped when available
with_email := MediaOne.file_base.file(length(trim(email,left, right)) > 4 and StringLib.StringFindCount(email,  '@') > 0 and current_rec = TRUE);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d input) := transform
	self.email_src        					:= mdr.sourceTools.src_MediaOne;
	self.rec_src_all      					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_MediaOne);
	self.email_src_all    					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_MediaOne);
	self.email_src_num 							:= 1;
	self.current_rec      					:= input.current_rec;
	self.activecode     							:= '';
	self.did_type         					:= '';
	self.orig_pmghousehold_id  			:= '';
	self.orig_pmgindividual_id  		:= '';
	self.orig_First_Name  					:= stringlib.stringtouppercase(TRIM(input.fname,RIGHT,LEFT));
	self.orig_Last_Name  						:= stringlib.stringtouppercase(TRIM(input.lname,RIGHT,LEFT));
	self.Orig_Address  							:= stringlib.stringtouppercase(TRIM(input.address, RIGHT,LEFT));
	self.Orig_City  								:= input.city;
	self.Orig_State  								:= input.state;
	self.orig_ZIP  									:= input.zip;
	self.orig_zip4  								:= '';
	self.orig_email 								:= stringlib.stringtouppercase(TRIM(input.email, RIGHT,LEFT));
	self.orig_ip  									:= input.ip;
	self.orig_site  								:= stringlib.stringtouppercase(TRIM(input.source, RIGHT,LEFT));
	self.orig_e360_id  							:= '';
	self.orig_teramedia_id  				:= '';
	self.clean_name.title  					:= '';
	self.clean_name.fname  					:= input.clean_fname;;
	self.clean_name.mname  					:= input.clean_mname;
	self.clean_name.lname  					:= input.clean_lname;
	self.clean_name.name_suffix  		:= input.clean_name_suffix;
	self.clean_name.name_score  		:= input.clean_name_score;
	self.clean_address.prim_range  	:= input.clean_prim_range;
	self.clean_address.predir  			:= input.clean_predir;
	self.clean_address.prim_name  	:= input.clean_prim_name;
	self.clean_address.addr_suffix  := input.clean_addr_suffix;
	self.clean_address.postdir  		:= input.clean_postdir;
	self.clean_address.unit_desig  	:= input.clean_unit_desig;
	self.clean_address.sec_range  	:= input.clean_sec_range;
	self.clean_address.p_city_name  := input.clean_p_city_name;
	self.clean_address.v_city_name  := input.clean_v_city_name;
	self.clean_address.st  					:= input.clean_st;
	self.clean_address.zip  				:= input.clean_zip;
	self.clean_address.zip4  				:= input.clean_zip4;
	self.clean_address.cart  				:= input.clean_cart;
	self.clean_address.cr_sort_sz   := input.clean_cr_sort_sz;
	self.clean_address.lot  				:= input.clean_lot;
	self.clean_address.lot_order  	:= input.clean_lot_order;
	self.clean_address.dbpc  				:= input.clean_dbpc;
	self.clean_address.chk_digit  	:= input.clean_chk_digit;
	self.clean_address.rec_type  		:= input.clean_rec_type;
	self.clean_address.county  			:= input.clean_county;
	self.clean_address.geo_lat  		:= input.clean_geo_lat;
	self.clean_address.geo_long  		:= input.clean_geo_long;
	self.clean_address.msa  				:= input.clean_msa;
	self.clean_address.geo_blk  		:= input.clean_geo_blk;
	self.clean_address.geo_match  	:= input.clean_geo_match;
	self.clean_address.err_stat  		:= input.clean_err_stat;
	self.append_rawaid  						:= input.aid;
	self.best_ssn  									:= '';
	self.best_dob  									:= (unsigned) ut.date_slashed_MMDDYYYY_to_YYYYMMDD(input.dob);
	//***********Check the AcquireWeb to check the latest data setup (build is under development)
	self.date_first_seen  					:= _validate.date.fCorrectedDateString(input.date_first_seen);
	self.date_last_seen  						:= _validate.date.fCorrectedDateString(input.date_last_seen);
	
	self.Date_Vendor_First_Reported :=  input.date_vendor_first_reported;
	self.Date_Vendor_Last_Reported  := input.date_vendor_last_reported;
	self.append_email_username 						:= stringlib.stringtouppercase(Fn_Clean_Email_Username(self.orig_email));
	self.append_domain 										:= stringlib.stringtouppercase(input.domain);
	self.append_domain_type 								:= stringlib.stringtouppercase(input.domain_type);
	self.append_domain_root 								:= stringlib.stringtouppercase(input.domain_root);
	self.append_domain_ext 								:= stringlib.stringtouppercase(input.domain_ext);
	self.append_is_tld_state								:= input.is_tld_state;
	self.append_is_tld_generic 						:= input.is_tld_generic;
	self.append_is_tld_country 						:= input.is_tld_country;
	self.append_is_valid_domain_ext 				:= input.is_valid_domain_ext;
	self.clean_email    						:= trim(self.append_email_username, left, right) + '@' + trim(self.append_domain, left, right);											 
	self.Email_rec_key    					:= Email_rec_key(self.clean_email ,
																									 self.clean_address.prim_range ,
																									 self.clean_address.prim_name, 
																									 self.clean_address.sec_range, 
																									 self.clean_address.zip,
																									 self.Clean_Name.lname, 
																									 self.Clean_Name.fname);
	self := input;	
end;

t_mappend_f := project(domain_d, t_map_to_common(left));


return t_mappend_f(append_email_username <> '' and append_domain_root <> '' and StringLib.StringFindCount(clean_email,  '.') > 0 and ~Entiera.fn_profanity(clean_email));
end;