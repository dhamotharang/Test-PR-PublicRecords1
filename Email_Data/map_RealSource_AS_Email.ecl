Import RealSource, address, ut, emailservice, mdr, _validate, Entiera, lib_StringLib, std;

EXPORT map_RealSource_As_Email(version) := FUNCTION

with_email := RealSource.Files.Base_out(length(trim(email,left, right)) > 4 and STD.Str.FindCount(email,  '@') > 0 and current_rec = TRUE);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d input) := TRANSFORM
	self.email_src        					:= mdr.sourceTools.src_RealSource;
	self.rec_src_all      					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_RealSource);
	self.email_src_all    					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_RealSource);
	self.email_src_num 							:= 1;
	self.current_rec      					:= true;
	self.activecode     						:= '';
	self.did_type         					:= '';
	self.orig_pmghousehold_id  			:= '';
	self.orig_pmgindividual_id 			:= '';
	self.orig_First_Name  					:= TRIM(input.FirstName,LEFT,RIGHT);
	self.orig_Last_Name  						:= TRIM(input.LastName,LEFT,RIGHT);
	self.Orig_Address  							:= TRIM(input.Address,LEFT, RIGHT);
	self.Orig_City  								:= input.city;
	self.Orig_State  								:= input.state;
	self.orig_ZIP  									:= input.ZipCode;
	self.orig_zip4  								:= input.ZipPlus4;
	self.orig_email 								:= TRIM(input.email,LEFT,RIGHT);
	self.orig_ip  									:= TRIM(input.IPAddr,LEFT,RIGHT);
	self.orig_site  								:= TRIM(input.URL,LEFT,RIGHT);
	self.orig_e360_id  							:= '';
	self.orig_teramedia_id  				:= '';
	self.clean_name.title  					:= input.clean_title;
	self.clean_name.fname  					:= input.clean_fname;
	self.clean_name.mname  					:= input.clean_mname;
	self.clean_name.lname  					:= input.clean_lname;
	self.clean_name.name_suffix 		:= input.clean_name_suffix;
	self.clean_name.name_score  		:= input.clean_name_score;
	self.clean_address.prim_range 	:= input.prim_range;
	self.clean_address.predir  			:= input.predir;
	self.clean_address.prim_name  	:= input.prim_name;
	self.clean_address.addr_suffix	:= input.addr_suffix;
	self.clean_address.postdir  		:= input.postdir;
	self.clean_address.unit_desig 	:= input.unit_desig;
	self.clean_address.sec_range  	:= input.sec_range;
	self.clean_address.p_city_name 	:= input.p_city_name;
	self.clean_address.v_city_name 	:= input.v_city_name;
	self.clean_address.st  					:= input.st;
	self.clean_address.zip  				:= input.zip;
	self.clean_address.zip4  				:= input.zip4;
	self.clean_address.cart  				:= input.cart;
	self.clean_address.cr_sort_sz  	:= input.cr_sort_sz;
	self.clean_address.lot  				:= input.lot;
	self.clean_address.lot_order  	:= input.lot_order;
	self.clean_address.dbpc  				:= input.dbpc;
	self.clean_address.chk_digit  	:= input.chk_digit;
	self.clean_address.rec_type  		:= input.rec_type;
	self.clean_address.county  			:= input.county;
	self.clean_address.geo_lat  		:= input.geo_lat;
	self.clean_address.geo_long  		:= input.geo_long;
	self.clean_address.msa  				:= input.msa;
	self.clean_address.geo_blk  		:= input.geo_blk;
	self.clean_address.geo_match  	:= input.geo_match;
	self.clean_address.err_stat  		:= input.err_stat;
	self.append_rawaid  						:= input.RawAid;
	self.best_ssn  									:= '';
	self.best_dob  									:= 0;
	self.date_first_seen  					:= (string8)input.date_first_seen;
	self.date_last_seen  						:= (string8)input.date_last_seen;
	self.Date_Vendor_First_Reported :=  (string8)input.date_vendor_first_reported;
	self.Date_Vendor_Last_Reported  := (string8)input.date_vendor_last_reported;
	self.append_email_username 			:= STD.Str.ToUpperCase(Fn_Clean_Email_Username(self.orig_email));
	self.append_domain 							:= STD.Str.ToUpperCase(input.domain);
	self.append_domain_type 				:= STD.Str.ToUpperCase(input.domain_type);
	self.append_domain_root 				:= STD.Str.ToUpperCase(input.domain_root);
	self.append_domain_ext 					:= STD.Str.ToUpperCase(input.domain_ext);
	self.append_is_tld_state				:= input.is_tld_state;
	self.append_is_tld_generic 			:= input.is_tld_generic;
	self.append_is_tld_country 			:= input.is_tld_country;
	self.append_is_valid_domain_ext := input.is_valid_domain_ext;
	self.clean_email    						:= TRIM(self.append_email_username, LEFT,RIGHT) + '@' + TRIM(self.append_domain, LEFT,RIGHT);
	self.Email_rec_key    					:= Email_rec_key(self.clean_email,
																									 self.clean_address.prim_range,
																									 self.clean_address.prim_name, 
																									 self.clean_address.sec_range, 
																									 self.clean_address.zip,
																									 self.Clean_Name.lname, 
																									 self.Clean_Name.fname);
	self := input;	
END;

t_mappend_f := PROJECT(domain_d, t_map_to_common(LEFT));


RETURN t_mappend_f(append_email_username <> '' and append_domain_root <> '' and STD.Str.FindCount(clean_email,  '.') > 0 and ~Entiera.fn_profanity(clean_email));
END;