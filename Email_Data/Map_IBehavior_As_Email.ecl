import IBehavior, address, ut,emailservice, mdr, _validate, lib_StringLib, entiera;
export Map_IBehavior_As_Email(version) := function

IBehavior.layouts.layout_consumer t_norm(IBehavior.layouts.layout_consumer le, c) := transform
self.email_address_1 := if(c = 1, le.email_address_1,
													if(c = 2, le.email_address_2, le.email_address_3));
self := le;
end;

Norm:= normalize(IBehavior.Files.File_consumer (email_address_1 <> '' or 
																			email_address_2 <> '' or
																			email_address_3 <> ''),	3, t_norm(left, counter)) (email_address_1 <> '');	
		
with_email := Norm(length(trim(email_address_1,left, right)) > 4 and StringLib.StringFindCount(email_address_1,  '@') > 0);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email_address_1);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d pInput) := transform
	self.email_src        					:= mdr.sourceTools.src_Ibehavior;
	self.rec_src_all      					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_Ibehavior);
	self.email_src_all    					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_Ibehavior);
	self.email_src_num 							:= 1;
	self.current_rec      					:= true;
	self.activecode     						:= '';
	self.did_type         					:= '';
	self.orig_pmghousehold_id  			:= '';
	self.orig_pmgindividual_id  		:= '';
	self.orig_First_Name  					:= ut.CleanSpacesAndUpper(TRIM(TRIM(pinput.First_Name, RIGHT,LEFT) + ' ' + TRIM(pinput.Middle_Initial,RIGHT,LEFT), RIGHT,LEFT));
	self.orig_Last_Name  						:= ut.CleanSpacesAndUpper(TRIM(pinput.Last_Name,RIGHT,LEFT));
	self.Orig_Address  							:= ut.CleanSpacesAndUpper(TRIM(StringLib.StringCleanSpaces(pinput.address_line1 + pinput.address_line2), LEFT, RIGHT));
	self.Orig_City  								:= pInput.city;
	self.Orig_State  								:= pInput.state;
	self.orig_ZIP  									:= pInput.zip_code;
	self.orig_zip4  								:= pInput.zip_4;
	self.orig_email 								:= ut.CleanSpacesAndUpper(TRIM(pInput.email_address_1, RIGHT,LEFT));
	self.orig_ip  									:= '';
	self.orig_site  								:= '';
	self.orig_e360_id  							:= '';
	self.orig_teramedia_id  				:= '';
	self.clean_name.title  					:= pInput.title;
	self.clean_name.fname  					:= pInput.fname;
	self.clean_name.mname  					:= pInput.mname;
	self.clean_name.lname  					:= pInput.lname;
	self.clean_name.name_suffix  		:= pInput.name_suffix;
	self.clean_name.name_score  		:= '';
	self.clean_address.prim_range  	:= pInput.prim_range;
	self.clean_address.predir  			:= pInput.predir;
	self.clean_address.prim_name  	:= pInput.prim_name;
	self.clean_address.addr_suffix  := pInput.addr_suffix;
	self.clean_address.postdir  		:= pInput.postdir;
	self.clean_address.unit_desig  	:= pInput.unit_desig;
	self.clean_address.sec_range  	:= pInput.sec_range;
	self.clean_address.p_city_name  := pInput.p_city_name;
	self.clean_address.v_city_name  := pInput.v_city_name;
	self.clean_address.st  					:= pInput.st;
	self.clean_address.zip  				:= pInput.zip5;
	self.clean_address.zip4  				:= pInput.zip4;
	self.clean_address.cart  				:= pInput.cart;
	self.clean_address.cr_sort_sz   := pInput.cr_sort_sz;
	self.clean_address.lot  				:= pInput.lot;
	self.clean_address.lot_order  	:= pInput.lot_order;
	self.clean_address.dbpc  				:= pInput.dbpc;
	self.clean_address.chk_digit  	:= pInput.chk_digit;
	self.clean_address.rec_type  		:= pInput.rec_type;
	self.clean_address.geo_lat  		:= pInput.geo_lat;
	self.clean_address.geo_long  		:= pInput.geo_long;
	self.clean_address.msa  				:= pInput.msa;
	self.clean_address.county  			:= pInput.county; 
	self.clean_address.geo_blk  		:= pInput.geo_blk;
	self.clean_address.geo_match  	:= pInput.geo_match;
	self.clean_address.err_stat  		:= pInput.err_stat;
	self.append_rawaid  						:= pInput.RawAid;
	self.best_ssn  									:= '';
	self.best_dob  									:= 0;
	//***********Check the AcquireWeb to check the latest data setup (build is under development)
	self.date_first_seen  					:= (string8)pInput.date_first_seen;
	self.date_last_seen  						:= (string8)pInput.date_last_seen;
	
	self.Date_Vendor_First_Reported :=  (string8)pInput.date_vendor_first_reported;
	self.Date_Vendor_Last_Reported  := (string8)pInput.date_vendor_last_reported;
	self.append_email_username 						:= ut.CleanSpacesAndUpper(Fn_Clean_Email_Username(self.orig_email));
	self.append_domain 										:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Domain(input.domain));
	self.append_domain_type 							:= ut.CleanSpacesAndUpper(pInput.domain_type);
	self.append_domain_root 							:= ut.CleanSpacesAndUpper(pInput.domain_root);
	self.append_domain_ext 								:= ut.CleanSpacesAndUpper(pInput.domain_ext);
	self.append_is_tld_state							:= pInput.is_tld_state;
	self.append_is_tld_generic 						:= pInput.is_tld_generic;
	self.append_is_tld_country 						:= pInput.is_tld_country;
	self.append_is_valid_domain_ext 			:= pInput.is_valid_domain_ext;
	self.clean_email    						:= trim(self.append_email_username, left, right) + '@' + trim(self.append_domain, left, right);											 
	self.Email_rec_key    					:= Email_rec_key(self.clean_email ,
																									 self.clean_address.prim_range ,
																									 self.clean_address.prim_name, 
																									 self.clean_address.sec_range, 
																									 self.clean_address.zip,
																									 self.Clean_Name.lname, 
																									 self.Clean_Name.fname);
	self := pInput;	
end;

t_mappend_f := project(domain_d, t_map_to_common(left));


return t_mappend_f(append_email_username <> '' and append_domain_root <> '' and StringLib.StringFindCount(clean_email,  '.') > 0 and ~Entiera.fn_profanity(clean_email));
end;