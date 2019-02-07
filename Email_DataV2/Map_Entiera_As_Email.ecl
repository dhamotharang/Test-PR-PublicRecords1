IMPORT entiera, emailservice, mdr, _validate, ut, Email_Data, STD;
EXPORT Map_Entiera_As_Email(version) := FUNCTION
with_email := entiera.File_Entiera_Base(TRIM(orig_email) <> '');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,orig_email);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
 	SELF.email_src        						:= mdr.sourceTools.src_entiera;
	SELF.current_rec      						:= input.current_rec;
	SELF.orig_pmghousehold_id					:= input.orig_pmghousehold_id;
  SELF.orig_pmgindividual_id				:= input.orig_pmgindividual_id;
	SELF.orig_First_Name  						:= input.orig_first_name;
	SELF.orig_Last_Name  							:= input.orig_last_name;
	SELF.Orig_Address  								:= input.orig_address;
	SELF.Orig_City  									:= input.orig_city;
	SELF.Orig_State  									:= input.orig_state;
	SELF.orig_ZIP  										:= input.orig_zip;
	SELF.orig_zip4  									:= input.orig_zip4;
	SELF.orig_site  									:= input.orig_site;
	SELF.orig_e360_id  								:= input.orig_e360_id;
	SELF.orig_teramedia_id  					:= input.orig_teramedia_id;
	SELF.activecode       						:= '';
  SELF.orig_login_date  						:= IF(input.ln_login_date <> '', input.ln_login_date, _validate.date.fCorrectedDateString(StringLib.StringFindReplace(input.orig_login_date, '-', '')[..8]));
	SELF.orig_email										:= ut.CleanSpacesAndUpper(input.orig_email);
	SELF.orig_ip  										:= input.orig_ip;
	ValidLoginDate										:= STD.DATE.IsValidDate((integer)input.ln_login_date);
	SELF.date_first_seen  						:= IF(ValidLoginDate, SELF.orig_login_date, '');
	SELF.date_last_seen   						:= IF(ValidLoginDate, SELF.orig_login_date, '');
	SELF.Date_Vendor_First_Reported   := IF(TRIM(input.Date_Vendor_First_Reported) <> '',input.Date_Vendor_First_Reported, (string) version);
	SELF.Date_Vendor_Last_Reported  	:= IF(TRIM(input.Date_Vendor_Last_Reported) <> '',input.Date_Vendor_Last_Reported, (string) version);
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
	SELF.email_rec_key 								:= HASH64((data)TRIM(SELF.orig_pmghousehold_id, LEFT, RIGHT) + 																																																									 
																							(data)TRIM(SELF.orig_pmgindividual_id, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_first_name, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_last_name, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_address, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_city, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_state, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_zip, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_zip4, LEFT, RIGHT) +
																							(data)TRIM(SELF.clean_email, LEFT, RIGHT) + //using clean field as orig is pretty messy
																							(data)TRIM(SELF.orig_e360_id, LEFT, RIGHT) +
																							(data)TRIM(SELF.orig_teramedia_id, LEFT, RIGHT) +
																							(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.rules											:= 0;
	SELF := input;
	SELF := [];
END;

t_mappend_f := PROJECT(domain_d, t_map_to_common(left));


RETURN t_mappend_f;//(~Entiera.fn_profanity(clean_email));
END;