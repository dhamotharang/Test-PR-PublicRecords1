IMPORT Acquireweb_Email, aid, address, ut,emailservice, mdr, _validate, entiera, email_data, STD;
EXPORT Map_AcquireWeb_As_Email(version) := FUNCTION
//************Acquireweb is under develoment.  AID and other fields will be mapped when available
with_email := Acquireweb_Email.files.file_Acquireweb_Base(TRIM(email) <> '');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
	SELF.email_src        					:= mdr.sourceTools.src_acquiredweb;
	SELF.current_rec      					:= input.current_rec;
	SELF.did_type         					:= '';
	SELF.activecode     						:= input.activecode;
	SELF.orig_pmghousehold_id  			:= '';
	SELF.orig_pmgindividual_id  		:= '';
	SELF.orig_First_Name  					:= input.firstname;
	SELF.orig_Last_Name  						:= input.lastname;
	SELF.Orig_Address  							:= ut.CleanSpacesAndUpper(input.address1 + ' ' + input.address2);
	SELF.Orig_City  								:= input.city;
	SELF.Orig_State  								:= input.state;
	SELF.orig_ZIP  									:= input.zip;
	SELF.orig_zip4  								:= input.zip4;
	SELF.orig_email 								:= ut.CleanSpacesAndUpper(input.email);
	SELF.orig_ip  									:= '';
	SELF.orig_site  								:= '';
	SELF.orig_e360_id  							:= '';
	SELF.orig_teramedia_id  				:= '';
	SELF.orig_phone									:= input.phone;
	SELF.orig_dob										:= input.dob;
	SELF.clean_name.title  					:= '';
	SELF.clean_name.fname  					:= input.clean_fname;;
	SELF.clean_name.mname  					:= input.clean_mname;
	SELF.clean_name.lname  					:= input.clean_lname;
	SELF.clean_name.name_suffix  		:= input.clean_name_suffix;
	SELF.clean_name.name_score  		:= input.clean_name_score;
	SELF.clean_address.prim_range  	:= input.clean_prim_range;
	SELF.clean_address.predir  			:= input.clean_predir;
	SELF.clean_address.prim_name  	:= input.clean_prim_name;
	SELF.clean_address.addr_suffix  := input.clean_addr_suffix;
	SELF.clean_address.postdir  		:= input.clean_postdir;
	SELF.clean_address.unit_desig  	:= input.clean_unit_desig;
	SELF.clean_address.sec_range  	:= input.clean_sec_range;
	SELF.clean_address.p_city_name  := input.clean_p_city_name;
	SELF.clean_address.v_city_name  := input.clean_v_city_name;
	SELF.clean_address.st  					:= input.clean_st;
	SELF.clean_address.zip  				:= input.clean_zip;
	SELF.clean_address.zip4  				:= input.clean_zip4;
	SELF.clean_address.cart  				:= input.clean_cart;
	SELF.clean_address.cr_sort_sz   := input.clean_cr_sort_sz;
	SELF.clean_address.lot  				:= input.clean_lot;
	SELF.clean_address.lot_order  	:= input.clean_lot_order;
	SELF.clean_address.dbpc  				:= input.clean_dbpc;
	SELF.clean_address.chk_digit  	:= input.clean_chk_digit;
	SELF.clean_address.rec_type  		:= input.clean_rec_type;
	SELF.clean_address.county  			:= input.clean_county;
	SELF.clean_address.geo_lat  		:= input.clean_geo_lat;
	SELF.clean_address.geo_long  		:= input.clean_geo_long;
	SELF.clean_address.msa  				:= input.clean_msa;
	SELF.clean_address.geo_blk  		:= input.clean_geo_blk;
	SELF.clean_address.geo_match  	:= input.clean_geo_match;
	SELF.clean_address.err_stat  		:= input.clean_err_stat;
	SELF.append_rawaid  						:= input.aid;
	SELF.clean_phone								:= STD.Str.Filter(input.phone,'0123456789');
	SELF.clean_ssn  								:= '';
	SELF.clean_dob  								:= (integer)input.dob;
	//***********Check the AcquireWeb to check the latest data setup (build is under development)
	SELF.date_first_seen  					:= _validate.date.fCorrectedDateString(input.date_first_seen);
	SELF.date_last_seen  						:= _validate.date.fCorrectedDateString(input.date_last_seen);
	
	SELF.Date_Vendor_First_Reported := input.date_vendor_first_reported;
	SELF.Date_Vendor_Last_Reported  := input.date_vendor_last_reported;
	SELF.append_email_username 			:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Username(SELF.orig_email));
	SELF.append_domain 							:= ut.CleanSpacesAndUpper(input.domain);
	SELF.append_domain_type 				:= ut.CleanSpacesAndUpper(input.domain_type);
	SELF.append_domain_root 				:= ut.CleanSpacesAndUpper(input.domain_root);
	SELF.append_domain_ext 					:= ut.CleanSpacesAndUpper(input.domain_ext);
	SELF.append_is_tld_state				:= input.is_tld_state;
	SELF.append_is_tld_generic 			:= input.is_tld_generic;
	SELF.append_is_tld_country 			:= input.is_tld_country;
	SELF.append_is_valid_domain_ext := input.is_valid_domain_ext;
	SELF.clean_email    						:= TRIM(SELF.append_email_username, LEFT, RIGHT) + '@' + TRIM(SELF.append_domain, LEFT, RIGHT);											 
	SELF.email_rec_key 							:= HASH64((data)TRIM(SELF.orig_first_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_last_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_address, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_city, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_state, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_zip, LEFT, RIGHT) +
																						(data)TRIM(SELF.clean_email, LEFT, RIGHT) + //using clean field as orig is pretty messy
																						(data)trim(SELF.activecode, LEFT, RIGHT) +
																						(data)TRIM(SELF.clean_phone, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_dob, LEFT, RIGHT) +
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
 		
	SELF.rules											:= 0;
	SELF 														:= input;
	SELF														:= [];	
END;

t_mappend_f := PROJECT(domain_d, t_map_to_common(left));


RETURN t_mappend_f(~Entiera.fn_profanity(clean_email));
END;