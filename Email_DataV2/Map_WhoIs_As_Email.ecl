﻿IMPORT WhoIs, address, ut, emailservice, mdr, _validate, Entiera, lib_StringLib, std, Email_Data;

EXPORT Map_WhoIs_As_Email(version) := FUNCTION

infile     := WhoIs.files.base;
with_email := infile(TRIM(email) <> '' and TRIM(country) = 'UNITED STATES');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,Email);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
	SELF.email_src        					:= 'W '; //mdr.sourceTools.src_WhoIs_Domain;
	SELF.current_rec      					:= input.current_rec;
	SELF.activecode     						:= '';
	SELF.did_type         					:= '';
	SELF.orig_pmghousehold_id  			:= '';
	SELF.orig_pmgindividual_id 			:= '';
	SELF.orig_First_Name  					:= '';
	SELF.orig_Last_Name  						:= '';
	SELF.Orig_Address  							:= ut.CleanSpacesAndUpper(input.street1 + ' ' + input.street2 + ' ' + input.street3 + ' ' + input.street4);
	SELF.Orig_City  								:= input.City;
	SELF.Orig_State  								:= input.State;
	SELF.orig_ZIP  									:= input.postalCode;
	SELF.orig_zip4  								:= '';
	SELF.orig_email 								:= STD.Str.CleanSpaces(input.Email);
	SELF.orig_ip  									:= '';
	SELF.orig_site  								:= '';
	SELF.orig_e360_id  							:= '';
	SELF.orig_teramedia_id  				:= '';
	SELF.orig_phone									:= input.phone;
	SELF.clean_name.title  					:= input.clean_title;
	SELF.clean_name.fname  					:= input.clean_fname;
	SELF.clean_name.mname  					:= input.clean_mname;
	SELF.clean_name.lname  					:= input.clean_lname;
	SELF.clean_name.name_suffix 		:= input.clean_name_suffix;
	SELF.clean_name.name_score  		:= input.clean_name_score;
	SELF.clean_address.prim_range 	:= input.prim_range;
	SELF.clean_address.predir  			:= input.predir;
	SELF.clean_address.prim_name  	:= input.prim_name;
	SELF.clean_address.addr_suffix	:= input.addr_suffix;
	SELF.clean_address.postdir  		:= input.postdir;
	SELF.clean_address.unit_desig 	:= input.unit_desig;
	SELF.clean_address.sec_range  	:= input.sec_range;
	SELF.clean_address.p_city_name 	:= input.p_city_name;
	SELF.clean_address.v_city_name 	:= input.v_city_name;
	SELF.clean_address.st  					:= input.st;
	SELF.clean_address.zip  				:= input.zip;
	SELF.clean_address.zip4  				:= input.zip4;
	SELF.clean_address.cart  				:= input.cart;
	SELF.clean_address.cr_sort_sz  	:= input.cr_sort_sz;
	SELF.clean_address.lot  				:= input.lot;
	SELF.clean_address.lot_order  	:= input.lot_order;
	SELF.clean_address.dbpc  				:= input.dbpc;
	SELF.clean_address.chk_digit  	:= input.chk_digit;
	SELF.clean_address.rec_type  		:= input.rec_type;
	SELF.clean_address.county  			:= input.county;
	SELF.clean_address.geo_lat  		:= input.geo_lat;
	SELF.clean_address.geo_long  		:= input.geo_long;
	SELF.clean_address.msa  				:= input.msa;
	SELF.clean_address.geo_blk  		:= input.geo_blk;
	SELF.clean_address.geo_match  	:= input.geo_match;
	SELF.clean_address.err_stat  		:= input.err_stat;
	SELF.append_rawaid  						:= input.RawAid;
	SELF.clean_ssn 									:= '';
	SELF.clean_dob 									:= 0;
	SELF.date_first_seen  					:= (string8)input.date_first_seen;
	SELF.date_last_seen  						:= (string8)input.date_last_seen;
	SELF.Date_Vendor_First_Reported := (string8)input.date_vendor_first_reported;
	SELF.Date_Vendor_Last_Reported  := (string8)input.date_vendor_last_reported;
	SELF.append_email_username 			:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Username(input.email));
	SELF.append_domain 							:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_domain(input.email));
	SELF.append_domain_type 				:= ut.CleanSpacesAndUpper(input.domain_type);
	SELF.append_domain_root 				:= ut.CleanSpacesAndUpper(input.domain_root);
	SELF.append_domain_ext 					:= ut.CleanSpacesAndUpper(input.domain_ext);
	SELF.append_is_tld_state				:= input.is_tld_state;
	SELF.append_is_tld_generic 			:= input.is_tld_generic;
	SELF.append_is_tld_country 			:= input.is_tld_country;
	SELF.append_is_valid_domain_ext := input.is_valid_domain_ext;
	SELF.clean_email    						:= TRIM(SELF.append_email_username, LEFT,RIGHT) + '@' + TRIM(SELF.append_domain, LEFT,RIGHT);
	SELF.orig_CompanyName						:= ut.CleanSpacesAndUpper(input.clean_cname);
	SELF.cln_CompanyName						:= ut.CleanSpacesAndUpper(input.clean_cname);		
	SELF.email_rec_key 							:= HASH64((data)TRIM(input.name, LEFT, RIGHT) +
																						(data)TRIM(input.EmailType, LEFT, RIGHT) +
																						(data)TRIM(input.organization, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_address, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_city, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_state, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_zip, LEFT, RIGHT) +
																						(data)TRIM(input.country, LEFT, RIGHT) +
																						(data)TRIM(SELF.clean_email, LEFT, RIGHT) + //using clean field as orig is pretty messy
																						// (data)TRIM(SELF.orig_dob, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_CompanyName, LEFT, RIGHT) +
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.process_date               := (string8)input.process_date;
	SELF.rules											:= 0;
	SELF := input;
	SELF := [];
END;

t_mappend_f 	:= PROJECT(domain_d, t_map_to_common(LEFT));

addGlobalSID 	:= mdr.macGetGlobalSID(t_mappend_f,'EmailDataV2','email_src','global_sid'); //DF-25302: Populate Global_SID

RETURN addGlobalSID;
END;