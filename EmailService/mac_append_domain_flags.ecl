export mac_append_domain_flags(infile,outfile,email_field) := macro

#uniquename(r1);
#uniquename(x1);
#uniquename(x2);
#uniquename(p1);
#uniquename(p2);
#uniquename(append_defaults);
#uniquename(has_email);
#uniquename(skip_these);

%r1% := record
 infile;
 string120 domain             :='';
 string12  domain_type        :='';
 string100 domain_root        :='';
 string20  domain_ext         :='';
 boolean   is_tld_state       :=false;
 boolean   is_tld_generic     :=false;
 boolean   is_tld_country     :=false;
 boolean   is_valid_domain_ext:=false;
end;

%append_defaults% := project(infile,%r1%);
%has_email%       := %append_defaults%(email_field<>'');
%skip_these%      := %append_defaults%(email_field ='');

%r1% %x1%(%has_email% le) := transform


	email := stringlib.stringtolowercase(email_data.Fn_Clean_Email_Username(le.email_field) + '@' + 	email_data.Fn_Clean_Email_Domain(le.email_field));
  str_tail(string str, pos) 				:= stringlib.stringtolowercase('.' + trim(str[(length(trim(str, left, right)) - pos + 1) ..], left, right));
	fix_domain(string str, pos) 			:= trim(str[..length(trim(str, left, right)) - pos], left, right) +  str_tail(str, pos);

 integer v_pos_amp := stringlib.stringfind(email,'@',StringLib.StringFindCount(email, '@'));
 string  v_domain_o:= StringLib.StringFindReplace(trim(StringLib.StringFindReplace(StringLib.StringFindReplace(stringlib.stringtolowercase(if(v_pos_amp>0,email[v_pos_amp+1..100],'')), ' home', ''), ' work', ''), left, right), ' ', '.');
 string  v_domain_v1:= regexreplace('[^[:alnum:]!#$%&\'*+-/=?^_`{|}~]',v_domain_o ,'');
 string  v_domain_v2:= regexreplace('(^[*.-]+)|([*.-]+$)',v_domain_v1 ,'');
 integer v_pos1    := if(v_pos_amp>0,stringlib.stringfind(email[v_pos_amp                         +1..100],'.',1),0);
 integer v_pos2    := if(v_pos1>0,stringlib.stringfind(email[v_pos_amp+v_pos1                     +1..100],'.',1),0);
  string v_domain   := if(StringLib.StringFindCount(v_domain_v2,  '.') > 0 , 
														 v_domain_v2,
														 map(str_tail(v_domain_v2, 6) in emailservice.mod_domains.generic_tld => fix_domain(v_domain_v2,6),
																 str_tail(v_domain_v2, 5) in emailservice.mod_domains.generic_tld => fix_domain(v_domain_v2,5),
																 str_tail(v_domain_v2, 4) in emailservice.mod_domains.generic_tld => fix_domain(v_domain_v2,4),
																 str_tail(v_domain_v2, 3) in emailservice.mod_domains.generic_tld => fix_domain(v_domain_v2,3),
																 str_tail(v_domain_v2, 2) in emailservice.mod_domains.generic_tld or str_tail(v_domain_v2, 2) in emailservice.mod_domains.state_level_tld or str_tail(v_domain_v2, 2) in emailservice.mod_domains.country_code_tld => fix_domain(v_domain_v2,2),
																								v_domain_v2));
 
 
 self.domain           := StringLib.StringFindReplace(v_domain, ',.', '.');
 
 self.domain_root      := stringlib.stringtolowercase(if(v_pos_amp>0 and v_pos1>0,email[v_pos_amp+1..v_pos_amp+v_pos1-1],''));
 self.domain_ext       := if(v_domain<>'',
                            v_domain[StringLib.StringFind(v_domain, '.',StringLib.StringFindCount(v_domain,  '.'))..StringLib.StringFind(v_domain, '.',StringLib.StringFindCount(v_domain,  '.'))+10],
						   					    '');
 
 self.is_tld_generic      := self.domain_ext in emailservice.mod_domains.generic_tld;
 self.is_tld_country      := self.domain_ext in emailservice.mod_domains.country_code_tld and self.domain_root<>'shaw' and ((v_pos1>0 and v_pos2>0) or stringlib.stringfind(v_domain,'.co.',1)>0);
 self.is_tld_state        := self.domain_ext in emailservice.mod_domains.state_level_tld and self.is_tld_country=false;
 self.is_valid_domain_ext := self.is_tld_state or self.is_tld_generic or self.is_tld_country;
 self                     := le;
end;

%p1% := project(%has_email%,%x1%(left));

%r1% %x2%(%r1% le) := transform
  
 self.domain_ext  := if(le.is_tld_country=true,'foreign_tld',le.domain_ext);
 self.domain_type := if(le.domain_ext='.edu','edu',
                       if(le.domain_root in emailservice.mod_domains.free_domain_root,'free',
                       if(le.domain_root in emailservice.mod_domains.isp_domains,'isp',
				       if(le.domain_root in emailservice.mod_domains.corporate_domains,'corp',
				       ''))));
					 
 self := le;
end;

%p2% := project(%p1%,%x2%(left));

outfile := %p2%+%skip_these%;

endmacro;