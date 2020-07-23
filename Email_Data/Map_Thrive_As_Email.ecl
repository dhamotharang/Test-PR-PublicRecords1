import Thrive, address, ut,emailservice, mdr, _validate, entiera;
export Map_Thrive_as_Email(version) := function

with_email :=  Thrive.Files().Base.qa(length(trim(email,left, right)) > 4 and StringLib.StringFindCount(email,  '@') > 0);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d input) := transform
	self.email_src        					:= input.src;
	self.rec_src_all      					:= translation_codes.source_bitmap_code(input.src);
	self.email_src_all    					:= translation_codes.source_bitmap_code(input.src);
	self.email_src_num 							:= 1;
	self.current_rec      					:= true;
	self.activecode     							:= '';
	self.did_type         					:= '';
	self.orig_pmghousehold_id  			:= '';
	self.orig_pmgindividual_id  		:= '';
	self.orig_First_Name  					:= input.orig_fname;
	self.orig_Last_Name  						:= input.orig_lname;
	self.Orig_Address  							:= input.orig_Addr;
	self.Orig_City  								:= input.orig_city;
	self.Orig_State  								:= input.orig_state;
	self.orig_ZIP  									:= input.orig_zip5;
	self.orig_zip4  								:= input.orig_zip4;
	self.orig_email 								:= input.email;
	self.orig_ip  									:= input.ip;
	self.orig_site  								:= '';
	self.orig_e360_id  							:= '';
	self.orig_teramedia_id  				:= '';
	self.clean_name.title  					:= input.title;
	self.clean_name.fname  					:= input.fname;;
	self.clean_name.mname  					:= input.mname;
	self.clean_name.lname  					:= input.lname;
	self.clean_name.name_suffix  		:= input.name_suffix;
	self.clean_name.name_score  		:= '';
	self.clean_address.prim_range  	:= input.prim_range;
	self.clean_address.predir  			:= input.predir;
	self.clean_address.prim_name  	:= input.prim_name;
	self.clean_address.addr_suffix  := input.addr_suffix;
	self.clean_address.postdir  		:= input.postdir;
	self.clean_address.unit_desig  	:= input.unit_desig;
	self.clean_address.sec_range  	:= input.sec_range;
	self.clean_address.p_city_name  := input.p_city_name;
	self.clean_address.v_city_name  := input.v_city_name;
	self.clean_address.st  					:= input.st;
	self.clean_address.zip  				:= input.zip;
	self.clean_address.zip4  				:= input.zip4;
	self.clean_address.cart  				:= input.cart;
	self.clean_address.cr_sort_sz   := input.cr_sort_sz;
	self.clean_address.lot  				:= input.lot;
	self.clean_address.lot_order  	:= input.lot_order;
	self.clean_address.dbpc  				:= input.dbpc;
	self.clean_address.chk_digit  	:= input.chk_digit;
	self.clean_address.rec_type  		:= input.rec_type;
	self.clean_address.county  			:= input.fips_st + input.fips_county;
	self.clean_address.geo_lat  		:= input.geo_lat;
	self.clean_address.geo_long  		:= input.geo_long;
	self.clean_address.msa  				:= input.msa;
	self.clean_address.geo_blk  		:= input.geo_blk;
	self.clean_address.geo_match  	:= input.geo_match;
	self.clean_address.err_stat  		:= input.err_stat;
	self.append_rawaid  						:= input.rawaid;
	self.best_ssn  									:= '';
	self.best_dob  									:= (unsigned) input.clean_dob;
	//***********Check the AcquireWeb to check the latest data setup (build is under development)
	self.date_first_seen  					:= _validate.date.fCorrectedDateString((string)input.dt_first_seen);
	self.date_last_seen  						:= _validate.date.fCorrectedDateString((string)input.dt_last_seen);
	
	self.Date_Vendor_First_Reported :=  (string)input.dt_vendor_first_reported;
	self.Date_Vendor_Last_Reported  :=  (string)input.dt_vendor_last_reported;
	self.append_email_username 						:= ut.CleanSpacesAndUpper(Fn_Clean_Email_Username(self.orig_email));
	self.append_domain 										:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Domain(input.domain));
	self.append_domain_type 							:= ut.CleanSpacesAndUpper(input.domain_type);
	self.append_domain_root 							:= ut.CleanSpacesAndUpper(input.domain_root);
	self.append_domain_ext 								:= ut.CleanSpacesAndUpper(input.domain_ext);
	self.append_is_tld_state							:= input.is_tld_state;
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



