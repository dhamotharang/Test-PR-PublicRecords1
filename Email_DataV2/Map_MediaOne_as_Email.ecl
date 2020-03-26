﻿IMPORT MediaOne, address, ut,emailservice, mdr, _validate, STD, Entiera, Email_Data;
EXPORT Map_MediaOne_as_Email(version) := FUNCTION

with_email := MediaOne.file_base.file(TRIM(email) <> '');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);

	fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d',
		'%Y%m%d'
	];
	fmtout := '%Y%m%d';
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
	SELF.email_src        					:= mdr.sourceTools.src_MediaOne;
	SELF.current_rec      					:= true;
	SELF.activecode     						:= '';
	SELF.did_type         					:= '';
	SELF.orig_pmghousehold_id  			:= '';
	SELF.orig_pmgindividual_id  		:= '';
	SELF.orig_First_Name  					:= ut.CleanSpacesAndUpper(TRIM(input.fname,RIGHT,LEFT));
	SELF.orig_Last_Name  						:= ut.CleanSpacesAndUpper(TRIM(input.lname,RIGHT,LEFT));
	SELF.Orig_Address  							:= ut.CleanSpacesAndUpper(TRIM(input.address,RIGHT,LEFT));
	SELF.Orig_City  								:= input.city;
	SELF.Orig_State  								:= input.state;
	SELF.orig_ZIP  									:= input.zip;
	SELF.orig_zip4  								:= '';
	SELF.orig_email 								:= ut.CleanSpacesAndUpper(TRIM(input.email, RIGHT,LEFT));
	SELF.orig_ip  									:= input.ip;
	SELF.orig_site  								:= ut.CleanSpacesAndUpper(TRIM(input.source, RIGHT,LEFT));
	SELF.orig_e360_id  							:= '';
	SELF.orig_teramedia_id  				:= '';
	SELF.orig_phone									:= IF(ut.CleanSpacesAndUpper(input.phone) = 'NULL','',input.phone);
	SELF.orig_dob										:= IF(ut.CleanSpacesAndUpper(input.dob) = 'NULL','',input.dob);
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
	SELF.clean_phone								:= STD.Str.CleanSpaces(STD.Str.Filter(SELF.orig_phone, '0123456789'));
	SELF.clean_ssn  								:= '';
	SELF.clean_dob  								:= (unsigned)STD.Date.ConvertDateFormatMultiple(SELF.orig_dob,fmtsin,fmtout);
	//***********Check the AcquireWeb to check the latest data setup (build is under development)
	SELF.date_first_seen  					:= input.date_first_seen;
	SELF.date_last_seen  						:= input.date_last_seen;
	
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
																						(data)trim(SELF.clean_phone, LEFT, RIGHT) +
																						(data)trim(SELF.orig_dob, LEFT, RIGHT) +
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.rules											:= 0;
	SELF := input;
	SELF := [];
END;

t_mappend_f 	:= PROJECT(domain_d, t_map_to_common(left));

addGlobalSID 	:= mdr.macGetGlobalSID(t_mappend_f,'EmailDataV2','email_src','global_sid'); //DF-25302: Populate Global_SID

RETURN addGlobalSID;//(~Entiera.fn_profanity(clean_email));
END;