import entiera, emailservice, mdr, _validate;
export Map_Entiera_As_Email(version) := function
with_email := entiera.File_Entiera_Base(length(trim(orig_email,left, right)) > 4 and StringLib.StringFindCount(orig_email,  '@') > 0);

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,orig_email);
			
//************Transform to a common email layout
Email_Data.Layout_Email.Base t_map_to_common (domain_d input) := transform
 	self.email_src        						:= mdr.sourceTools.src_entiera;
	self.rec_src_all      						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_entiera);
	self.email_src_all    						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_entiera);
	self.email_src_num 								:= 1;
	self.current_rec      						:= true;
	self.activecode       						:= '';
  self.orig_login_date  							:= if(input.ln_login_date <> '', input.ln_login_date, _validate.date.fCorrectedDateString(StringLib.StringFindReplace(input.orig_login_date, '-', '')[..8]));
	self.orig_email										:= stringlib.stringtouppercase(input.orig_email);
	self.date_first_seen  						:= _validate.date.fCorrectedDateString(self.orig_login_date );
	self.date_last_seen   						:= _validate.date.fCorrectedDateString(self.orig_login_date );
	self.Date_Vendor_First_Reported   := if(_validate.date.fCorrectedDateString(input.Date_Vendor_First_Reported) <> '', _validate.date.fCorrectedDateString(input.Date_Vendor_First_Reported), (string) version);
	self.Date_Vendor_Last_Reported  	:= if(_validate.date.fCorrectedDateString(input.Date_Vendor_Last_Reported) <> '', _validate.date.fCorrectedDateString(input.Date_Vendor_Last_Reported), (string) version);
	self.append_domain 											:= stringlib.stringtouppercase(input.domain);
	self.append_domain_type 									:= stringlib.stringtouppercase(input.domain_type);
	self.append_domain_root 									:= stringlib.stringtouppercase(input.domain_root);
	self.append_domain_ext 									:= stringlib.stringtouppercase(input.domain_ext);
	self.append_is_tld_state									:= input.is_tld_state;
	self.append_is_tld_generic 							:= input.is_tld_generic;
	self.append_is_tld_country 							:= input.is_tld_country;
	self.append_is_valid_domain_ext 					:= input.is_valid_domain_ext;
	self 															:= input;
	self.append_email_username 							:= stringlib.stringtouppercase(Fn_Clean_Email_Username(self.orig_email));
	self.clean_email    							:= trim(self.append_email_username, left, right) + '@' + trim(self.append_domain, left, right);
	
													 
	self.Email_rec_key    						:= Email_rec_key(self.clean_email ,
																									 self.clean_address.prim_range ,
																									 self.clean_address.prim_name, 
																									 self.clean_address.sec_range, 
																									 self.clean_address.zip,
																									 self.Clean_Name.lname, 
																									 self.Clean_Name.fname);
	
end;

t_mappend_f := project(domain_d, t_map_to_common(left));


return t_mappend_f(append_email_username <> '' and append_domain_root <> '' and StringLib.StringFindCount(clean_email,  '.') > 0 and ~Entiera.fn_profanity(clean_email));
end;