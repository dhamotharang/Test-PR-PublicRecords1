IMPORT SalesChannel, address, ut,emailservice, mdr, _validate, Entiera, STD, Email_Data;
EXPORT Map_SalesChannel_As_Email(version) := FUNCTION

with_email := SalesChannel.Files().base.qa(TRIM(rawfields.email) <> '');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,rawfields.email);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d pInput) := TRANSFORM
	SELF.email_src        					:= mdr.sourceTools.src_SalesChannel;
	SELF.current_rec      					:= pInput.current_rec;
	SELF.activecode     						:= '';
	SELF.did_type         					:= '';
	SELF.orig_pmghousehold_id  			:= '';
	SELF.orig_pmgindividual_id  		:= '';
	SELF.orig_First_Name  					:= ut.CleanSpacesAndUpper(pInput.rawfields.First_Name);
	SELF.orig_Last_Name  						:= ut.CleanSpacesAndUpper(pInput.rawfields.Last_Name);
	SELF.orig_Middle_Name  					:= ut.CleanSpacesAndUpper(pInput.rawfields.Middle_Name);
	SELF.Orig_Address  							:= ut.CleanSpacesAndUpper(pInput.rawfields.address + ' ' + pInput.rawfields.address1);
	SELF.Orig_City  								:= pInput.rawfields.city;
	SELF.Orig_State  								:= pInput.rawfields.state;
	SELF.orig_ZIP  									:= pInput.rawfields.zip_code;
	SELF.orig_zip4  								:= '';
	SELF.orig_email 								:= ut.CleanSpacesAndUpper(pInput.rawfields.email);
	SELF.orig_ip  									:= '';
	SELF.orig_site  								:= ut.CleanSpacesAndUpper(pInput.rawfields.Web_Address);
	SELF.orig_e360_id  							:= '';
	SELF.orig_teramedia_id  				:= '';
	SELF.orig_phone									:= pInput.rawfields.phone_number;
	SELF.clean_name.title  					:= '';
	SELF.clean_name.fname  					:= pInput.clean_name.fname;;
	SELF.clean_name.mname  					:= pInput.clean_name.mname;
	SELF.clean_name.lname  					:= pInput.clean_name.lname;
	SELF.clean_name.name_suffix  		:= pInput.clean_name.name_suffix;
	SELF.clean_name.name_score  		:= pInput.clean_name.name_score;
	SELF.clean_address.prim_range  	:= pInput.clean_address.prim_range;
	SELF.clean_address.predir  			:= pInput.clean_address.predir;
	SELF.clean_address.prim_name  	:= pInput.clean_address.prim_name;
	SELF.clean_address.addr_suffix  := pInput.clean_address.addr_suffix;
	SELF.clean_address.postdir  		:= pInput.clean_address.postdir;
	SELF.clean_address.unit_desig  	:= pInput.clean_address.unit_desig;
	SELF.clean_address.sec_range  	:= pInput.clean_address.sec_range;
	SELF.clean_address.p_city_name  := pInput.clean_address.p_city_name;
	SELF.clean_address.v_city_name  := pInput.clean_address.v_city_name;
	SELF.clean_address.st  					:= pInput.clean_address.st;
	SELF.clean_address.zip  				:= pInput.clean_address.zip;
	SELF.clean_address.zip4  				:= pInput.clean_address.zip4;
	SELF.clean_address.cart  				:= pInput.clean_address.cart;
	SELF.clean_address.cr_sort_sz   := pInput.clean_address.cr_sort_sz;
	SELF.clean_address.lot  				:= pInput.clean_address.lot;
	SELF.clean_address.lot_order  	:= pInput.clean_address.lot_order;
	SELF.clean_address.dbpc  				:= pInput.clean_address.dbpc;
	SELF.clean_address.chk_digit  	:= pInput.clean_address.chk_digit;
	SELF.clean_address.rec_type  		:= pInput.clean_address.rec_type;
	SELF.clean_address.geo_lat  		:= pInput.clean_address.geo_lat;
	SELF.clean_address.geo_long  		:= pInput.clean_address.geo_long;
	SELF.clean_address.msa  				:= pInput.clean_address.msa;
	SELF.clean_address.county  			:= ''; //Not used in SalesChannel build
	SELF.clean_address.geo_blk  		:= pInput.clean_address.geo_blk;
	SELF.clean_address.geo_match  	:= pInput.clean_address.geo_match;
	SELF.clean_address.err_stat  		:= pInput.clean_address.err_stat;
	SELF.append_rawaid  						:= pInput.RawAid;
	SELF.clean_phone								:= STD.Str.CleanSpaces(STD.Str.Filter(pInput.rawfields.phone_number, '0123456789'));
	SELF.clean_ssn  								:= '';
	SELF.clean_dob  									:= 0;
	SELF.date_first_seen  					:= (string8)pInput.date_first_seen;
	SELF.date_last_seen  						:= (string8)pInput.date_last_seen;
	
	SELF.Date_Vendor_First_Reported := (string8)pInput.date_vendor_first_reported;
	SELF.Date_Vendor_Last_Reported  := (string8)pInput.date_vendor_last_reported;
	SELF.append_email_username 			:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Username(SELF.orig_email));
	SELF.append_domain 							:= ut.CleanSpacesAndUpper(pInput.domain);
	SELF.append_domain_type 				:= ut.CleanSpacesAndUpper(pInput.domain_type);
	SELF.append_domain_root 				:= ut.CleanSpacesAndUpper(pInput.domain_root);
	SELF.append_domain_ext 					:= ut.CleanSpacesAndUpper(pInput.domain_ext);
	SELF.append_is_tld_state				:= pInput.is_tld_state;
	SELF.append_is_tld_generic 			:= pInput.is_tld_generic;
	SELF.append_is_tld_country 			:= pInput.is_tld_country;
	SELF.append_is_valid_domain_ext := pInput.is_valid_domain_ext;
	SELF.clean_email    						:= TRIM(SELF.append_email_username, LEFT, RIGHT) + '@' + TRIM(SELF.append_domain, LEFT, RIGHT);											 
	SELF.email_rec_key 							:= HASH64((data)TRIM(SELF.orig_first_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_last_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_middle_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_address, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_city, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_state, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_zip, LEFT, RIGHT) +
																						(data)TRIM(SELF.clean_email, LEFT, RIGHT) + //using clean field as orig is pretty messy
																						(data)TRIM(SELF.clean_phone, LEFT, RIGHT) +
																						(data)TRIM(pInput.rawfields.company_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.orig_CompanyName						:= ut.CleanSpacesAndUpper(pInput.rawfields.company_name);
	SELF.cln_CompanyName						:= ut.CleanSpacesAndUpper(pInput.rawfields.company_name);
	SELF.CompanyTitle								:= ut.CleanSpacesAndUpper(pInput.rawfields.Title);
	SELF.rules											:= 0;
	SELF := pInput;
	SELF := [];
END;

t_mappend_f := PROJECT(domain_d, t_map_to_common(left));


RETURN t_mappend_f(~Entiera.fn_profanity(clean_email));
END;