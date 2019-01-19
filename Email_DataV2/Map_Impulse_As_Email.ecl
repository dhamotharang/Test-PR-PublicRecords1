IMPORT impulse_email, emailservice, mdr, _validate, entiera, Email_Data, STD, ut;
EXPORT Map_Impulse_As_Email(version) := FUNCTION

with_email := impulse_email.files.file_Impulse_Email_Base(TRIM(email) <> '');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
	SELF.email_src        						:= mdr.sourceTools.src_impulse;
	SELF.orig_site    								:= input.sourcename;
	SELF.current_rec 									:= true;
	SELF.activecode     							:= '';
	SELF.orig_pmghousehold_id  				:= '';
	SELF.orig_pmgindividual_id  			:= '';
	SELF.orig_first_name  						:= ut.CleanSpacesAndUpper(input.firstname);
	SELF.orig_last_name  							:= ut.CleanSpacesAndUpper(input.lastname);
	SELF.orig_middle_name							:= ut.CleanSpacesAndUpper(input.middlename);
	SELF.Orig_Address  								:= ut.CleanSpacesAndUpper(input.address1 + ' ' + input.address2);
	SELF.Orig_City  									:= ut.CleanSpacesAndUpper(input.city);
	SELF.Orig_State  									:= ut.CleanSpacesAndUpper(input.state);
	SELF.Orig_Zip  										:= input.zip;
	SELF.orig_zip4  									:= '';
	SELF.orig_email 									:= ut.CleanSpacesAndUpper(input.email);
	SELF.orig_ip  										:= input.ipaddress;
	SELF.orig_e360_id  								:= '';
	SELF.orig_teramedia_id  					:= '';
	SELF.orig_ssn											:= input.ssn;
	SELF.orig_dob											:= IF(input.DOB != '', input.DOB, STD.Str.CleanSpaces(input.YEAROB + input.DAYOB + input.MONTHOB));
	SELF.Clean_Name.title  						:= '';
	SELF.Clean_Name.fname  						:= input.cln_fname;
	SELF.Clean_Name.mname  						:= input.cln_mname;
	SELF.Clean_Name.lname  						:= input.cln_lname;
	SELF.Clean_Name.name_suffix  			:= input.cln_name_suffix;
	SELF.Clean_Name.name_score  			:= '';
	SELF.clean_address.prim_range  		:= input.prim_range;
	SELF.clean_address.predir  				:= input.predir;
	SELF.clean_address.prim_name  		:= input.prim_name;
	SELF.clean_address.addr_suffix  	:= input.addr_suffix;
	SELF.clean_address.postdir  			:= input.postdir;
	SELF.clean_address.unit_desig  		:= input.unit_desig;
	SELF.clean_address.sec_range  		:= input.sec_range;
	SELF.clean_address.p_city_name  	:= input.p_city_name;
	SELF.clean_address.v_city_name  	:= input.v_city_name;
	SELF.clean_address.st  						:= input.st;
	SELF.clean_address.zip  					:= input.zip5;
	SELF.clean_address.zip4  					:= input.zip4;
	SELF.clean_address.cart  					:= input.cart;
	SELF.clean_address.cr_sort_sz  		:= input.cr_sort_sz;
	SELF.clean_address.lot  					:= input.lot;
	SELF.clean_address.lot_order  		:= input.lot_order;
	SELF.clean_address.dbpc  					:= input.dbpc;
	SELF.clean_address.chk_digit  		:= input.chk_digit;
	SELF.clean_address.rec_type  			:= input.rec_type;
	SELF.clean_address.county  				:= input.county;
	SELF.clean_address.geo_lat  			:= input.geo_lat;
	SELF.clean_address.geo_long  			:= input.geo_long;
	SELF.clean_address.msa  					:= input.msa;
	SELF.clean_address.geo_blk  			:= input.geo_blk;
	SELF.clean_address.geo_match  		:= input.geo_match;
	SELF.clean_address.err_stat  			:= input.err_stat;
	SELF.Append_RawAID  							:= input.rawaid;
	SELF.clean_ssn  									:= input.ln_ssn;
	SELF.clean_dob  									:= (unsigned)input.ln_dob;
	SELF.date_first_seen  						:= _validate.date.fCorrectedDateString(StringLib.StringFindReplace(input.created, '-', '')[..8]);
	SELF.date_last_seen  							:= _validate.date.fCorrectedDateString(StringLib.StringFindReplace(input.lastmodified, '-', '')[..8]);
	SELF.Date_Vendor_First_Reported   := IF(_validate.date.fCorrectedDateString((string)input.datevendorfirstreported) = '', _validate.date.fCorrectedDateString((string)input.datevendorfirstreported), (string)version);
	SELF.Date_Vendor_Last_Reported  	:= IF(_validate.date.fCorrectedDateString((string)input.datevendorlastreported) = '', _validate.date.fCorrectedDateString((string)input.datevendorlastreported), (string)version);
	SELF.append_domain 								:= ut.CleanSpacesAndUpper(input.domain);
	SELF.append_domain_type 					:= ut.CleanSpacesAndUpper(input.domain_type);
	SELF.append_domain_root 					:= ut.CleanSpacesAndUpper(input.domain_root);
	SELF.append_domain_ext 						:= ut.CleanSpacesAndUpper(input.domain_ext);
	SELF.append_is_tld_state					:= input.is_tld_state;
	SELF.append_is_tld_generic 				:= input.is_tld_generic;
	SELF.append_is_tld_country 				:= input.is_tld_country;
	SELF.append_is_valid_domain_ext 	:= input.is_valid_domain_ext;
	SELF.append_email_username 				:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Username(SELF.orig_email));
	SELF.clean_email    							:= TRIM(SELF.append_email_username, LEFT, RIGHT) + '@' + TRIM(SELF.append_domain, LEFT, RIGHT);
	SELF.email_rec_key 								:= HASH64((data)TRIM(SELF.orig_first_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_last_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_middle_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_address, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_city, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_state, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_zip, LEFT, RIGHT) +
																						(data)TRIM(SELF.clean_email, LEFT, RIGHT) + //using clean field as orig is pretty messy
																						(data)trim(SELF.clean_ssn, LEFT, RIGHT) +
																						(data)trim(SELF.orig_dob, LEFT, RIGHT) +
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.rules												:= 0;
	SELF 															:= input;
	SELF															:= [];
END;

t_mappend_f := PROJECT(domain_d , t_map_to_common(LEFT));

RETURN t_mappend_f(~Entiera.fn_profanity(clean_email));
END;
