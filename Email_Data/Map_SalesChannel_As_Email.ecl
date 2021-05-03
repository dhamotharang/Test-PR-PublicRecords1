import SalesChannel, address, ut,emailservice, mdr, _validate, Entiera, lib_StringLib;
export Map_SalesChannel_As_Email(version) := function

with_email := SalesChannel.Files().base.qa(length(trim(rawfields.email,left, right)) > 4 and StringLib.StringFindCount(rawfields.email,  '@') > 0);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,rawfields.email);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d pInput) := transform
	self.email_src        					:= mdr.sourceTools.src_SalesChannel;
	self.rec_src_all      					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_SalesChannel);
	self.email_src_all    					:= translation_codes.source_bitmap_code(mdr.sourceTools.src_SalesChannel);
	self.email_src_num 							:= 1;
	self.current_rec      					:= true;
	self.activecode     						:= '';
	self.did_type         					:= '';
	self.orig_pmghousehold_id  			:= '';
	self.orig_pmgindividual_id  		:= '';
	self.orig_First_Name  					:= stringlib.stringtouppercase(TRIM(ut.fn_KeepPrintableChars(pInput.rawfields.First_Name),RIGHT,LEFT));
	self.orig_Last_Name  						:= stringlib.stringtouppercase(TRIM(ut.fn_KeepPrintableChars(pInput.rawfields.Last_Name),RIGHT,LEFT));
	self.Orig_Address  							:= stringlib.stringtouppercase(TRIM(StringLib.StringCleanSpaces(ut.fn_KeepPrintableChars(pInput.rawfields.address) + ' ' + ut.fn_KeepPrintableChars(pInput.rawfields.address1)),LEFT,RIGHT));
	self.Orig_City  								:= ut.fn_KeepPrintableChars(pInput.rawfields.city);
	self.Orig_State  								:= ut.fn_KeepPrintableChars(pInput.rawfields.state);
	self.orig_ZIP  									:= ut.fn_KeepPrintableChars(pInput.rawfields.zip_code);
	self.orig_zip4  								:= '';
	self.orig_email 								:= stringlib.stringtouppercase(TRIM(ut.fn_KeepPrintableChars(pInput.rawfields.email), RIGHT,LEFT));
	self.orig_ip  									:= '';
	self.orig_site  								:= stringlib.stringtouppercase(TRIM(ut.fn_KeepPrintableChars(pInput.rawfields.Web_Address), RIGHT,LEFT));
	self.orig_e360_id  							:= '';
	self.orig_teramedia_id  				:= '';
	self.clean_name.title  					:= '';
	self.clean_name.fname  					:= pInput.clean_name.fname;;
	self.clean_name.mname  					:= pInput.clean_name.mname;
	self.clean_name.lname  					:= pInput.clean_name.lname;
	self.clean_name.name_suffix  		:= pInput.clean_name.name_suffix;
	self.clean_name.name_score  		:= pInput.clean_name.name_score;
	self.clean_address.prim_range  	:= pInput.clean_address.prim_range;
	self.clean_address.predir  			:= pInput.clean_address.predir;
	self.clean_address.prim_name  	:= pInput.clean_address.prim_name;
	self.clean_address.addr_suffix  := pInput.clean_address.addr_suffix;
	self.clean_address.postdir  		:= pInput.clean_address.postdir;
	self.clean_address.unit_desig  	:= pInput.clean_address.unit_desig;
	self.clean_address.sec_range  	:= pInput.clean_address.sec_range;
	self.clean_address.p_city_name  := pInput.clean_address.p_city_name;
	self.clean_address.v_city_name  := pInput.clean_address.v_city_name;
	self.clean_address.st  					:= pInput.clean_address.st;
	self.clean_address.zip  				:= pInput.clean_address.zip;
	self.clean_address.zip4  				:= pInput.clean_address.zip4;
	self.clean_address.cart  				:= pInput.clean_address.cart;
	self.clean_address.cr_sort_sz   := pInput.clean_address.cr_sort_sz;
	self.clean_address.lot  				:= pInput.clean_address.lot;
	self.clean_address.lot_order  	:= pInput.clean_address.lot_order;
	self.clean_address.dbpc  				:= pInput.clean_address.dbpc;
	self.clean_address.chk_digit  	:= pInput.clean_address.chk_digit;
	self.clean_address.rec_type  		:= pInput.clean_address.rec_type;
	self.clean_address.geo_lat  		:= pInput.clean_address.geo_lat;
	self.clean_address.geo_long  		:= pInput.clean_address.geo_long;
	self.clean_address.msa  				:= pInput.clean_address.msa;
	self.clean_address.county  			:= ''; //Not used in SalesChannel build
	self.clean_address.geo_blk  		:= pInput.clean_address.geo_blk;
	self.clean_address.geo_match  	:= pInput.clean_address.geo_match;
	self.clean_address.err_stat  		:= pInput.clean_address.err_stat;
	self.append_rawaid  						:= pInput.RawAid;
	self.best_ssn  									:= '';
	self.best_dob  									:= 0;
	//***********Check the AcquireWeb to check the latest data setup (build is under development)
	self.date_first_seen  					:= (string8)pInput.date_first_seen;
	self.date_last_seen  						:= (string8)pInput.date_last_seen;
	
	self.Date_Vendor_First_Reported :=  (string8)pInput.date_vendor_first_reported;
	self.Date_Vendor_Last_Reported  := (string8)pInput.date_vendor_last_reported;
	self.append_email_username 						:= ut.CleanSpacesAndUpper(Fn_Clean_Email_Username(self.orig_email));
	self.append_domain 										:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Domain(pInput.domain));
	self.append_domain_type 								:= ut.CleanSpacesAndUpper(pInput.domain_type);
	self.append_domain_root 								:= ut.CleanSpacesAndUpper(pInput.domain_root);
	self.append_domain_ext 								:= ut.CleanSpacesAndUpper(pInput.domain_ext);
	self.append_is_tld_state								:= pInput.is_tld_state;
	self.append_is_tld_generic 						:= pInput.is_tld_generic;
	self.append_is_tld_country 						:= pInput.is_tld_country;
	self.append_is_valid_domain_ext 				:= pInput.is_valid_domain_ext;
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