
import impulse_email, emailservice, mdr, _validate, entiera, ut;
export Map_Impulse_As_Email(version) := function

with_email := impulse_email.files.file_Impulse_Email_Base(length(trim(email,left, right)) > 4 and StringLib.StringFindCount(email,  '@') > 0);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,email);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d input) := transform
	self.email_src        						:= mdr.sourceTools.src_impulse;
	self.rec_src_all      						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_impulse);
	self.email_src_all    						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_impulse);
	self.email_src_num 								:= 1;
	self.orig_site    								:= input.sourcename;
	self.current_rec 									:= true;
	self.activecode     							:= '';
	SELF.orig_pmghousehold_id  				:= '';
	SELF.orig_pmgindividual_id  			:= '';
	SELF.orig_first_name  						:= ut.CleanSpacesAndUpper(trim(trim(input.firstname, left, right) + ' ' + trim(input.middlename, left, right), left, right));
	SELF.orig_last_name  							:= ut.CleanSpacesAndUpper(trim(input.lastname, left, right));
	SELF.Orig_Address  								:= ut.CleanSpacesAndUpper(trim(input.address1 + ' ' + input.address2, left, right));
	SELF.Orig_City  									:= ut.CleanSpacesAndUpper(input.city);
	SELF.Orig_State  									:= ut.CleanSpacesAndUpper(input.state);
	SELF.Orig_Zip  										:= input.zip;
	SELF.orig_zip4  									:= '';
	SELF.orig_email 									:= ut.CleanSpacesAndUpper(input.email);
	SELF.orig_ip  										:= input.ipaddress;
	SELF.orig_e360_id  								:= '';
	SELF.orig_teramedia_id  					:= '';
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
	SELF.best_ssn  										:= input.ln_ssn;
	SELF.best_dob  										:= (unsigned)input.ln_dob;
	SELF.date_first_seen  						:= _validate.date.fCorrectedDateString(StringLib.StringFindReplace(input.created, '-', '')[..8]);
	SELF.date_last_seen  							:= _validate.date.fCorrectedDateString(StringLib.StringFindReplace(input.lastmodified, '-', '')[..8]);
	SELF.Date_Vendor_First_Reported   := if(_validate.date.fCorrectedDateString((string)input.datevendorfirstreported) = '', _validate.date.fCorrectedDateString((string)input.datevendorfirstreported), (string)version);
	SELF.Date_Vendor_Last_Reported  	:= if(_validate.date.fCorrectedDateString((string)input.datevendorlastreported) = '', _validate.date.fCorrectedDateString((string)input.datevendorlastreported), (string)version);
	self.append_domain 								:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Domain(input.domain));
	self.append_domain_type 					:= ut.CleanSpacesAndUpper(input.domain_type);
	self.append_domain_root 								:= ut.CleanSpacesAndUpper(input.domain_root);
	self.append_domain_ext 									:= ut.CleanSpacesAndUpper(input.domain_ext);
	self.append_is_tld_state								:= input.is_tld_state;
	self.append_is_tld_generic 							:= input.is_tld_generic;
	self.append_is_tld_country 							:= input.is_tld_country;
	self.append_is_valid_domain_ext 				:= input.is_valid_domain_ext;
	self 															:= input;
	self.append_email_username 						:= ut.CleanSpacesAndUpper(Fn_Clean_Email_Username(self.orig_email));
	self.clean_email    							:= trim(self.append_email_username, left, right) + '@' + trim(self.append_domain, left, right);
										 
	self.Email_rec_key    						:= Email_rec_key(self.clean_email ,
																									 self.clean_address.prim_range ,
																									 self.clean_address.prim_name, 
																									 self.clean_address.sec_range, 
																									 self.clean_address.zip,
																									 self.Clean_Name.lname, 
																									 self.Clean_Name.fname);
	end;

t_mappend_f := project(domain_d , t_map_to_common(left));

return t_mappend_f(append_email_username <> '' and append_domain_root <> '' and StringLib.StringFindCount(clean_email,  '.') > 0 and ~Entiera.fn_profanity(clean_email));
end;
