﻿import emailservice;
export Fn_Clean_Email_Domain (string email) := function
	att_pos 							:= StringLib.StringFind(email, '@',StringLib.StringFindCount(email, '@'));
	domain_           := stringlib.stringtouppercase(trim(StringLib.StringFindReplace(StringLib.StringFindReplace(email[att_pos+1.. length(email)], ',.', '.'), '.,' ,'.'), all));
	//blank any characters not [Aa-Zz] or [0-9] or [-.]
	blank_bad_chars 			:= regexreplace('[^[:alnum:].-]',domain_ ,'');
	//blank leading or ending characters , -, .
	blank_leading_bad_chars:= regexreplace('(^[*.-]+)|([*.-]+$)',blank_bad_chars ,'');
	//blank with all characters being multiple 0s
	blank_zeros						:=  regexreplace('^[0!#$%&\'*+-/=?^_`{|}~]+[0!#$%&\'*+-/=?^_`{|}~][0!#$%&\'*+-/=?^_`{|}~]+$',blank_leading_bad_chars ,'');
	//fix mispells of .COM

	 domain_root       := if(blank_zeros<>'',
                         blank_zeros[1..StringLib.StringFind(blank_zeros, '.',StringLib.StringFindCount(blank_zeros,  '.'))-1],
						   					    '');
	
	domain_ext       := if(blank_zeros<>'',
                            blank_zeros[StringLib.StringFind(blank_zeros, '.',StringLib.StringFindCount(blank_zeros,  '.'))..StringLib.StringFind(blank_zeros, '.',StringLib.StringFindCount(blank_zeros,  '.'))+10],
						   					    '');
	
	is_tld_generic      := domain_ext in emailservice.mod_domains.generic_tld;
  is_tld_country      := domain_ext in emailservice.mod_domains.country_code_tld and domain_root<>'SHAW' and (StringLib.StringFindCount(blank_zeros,  '.') > 1 or stringlib.stringfind(blank_zeros,'.CO.',1)>0);
  is_tld_state        := domain_ext in emailservice.mod_domains.state_level_tld and is_tld_country=false;
	
	is_bad_com       := if(stringlib.stringtouppercase(trim(domain_ext,all)) in ['.COMM', '.CON', '.CCOM', '.C0M', 'COOM'] or
												 (stringlib.stringtouppercase(trim(domain_ext,all)) <> '.COM' and stringlib.stringtouppercase(trim(domain_root, all)) in ['YAHOO', 'HOTMAIL', 'AOL', 'GMAIL', 'MSN','NTLWORLD'] and is_tld_country = false and is_tld_state = false),
												true, false);
	
	
	is_bad_net       := if((stringlib.stringtouppercase(trim(domain_ext,all)) <> '.NET' and stringlib.stringtouppercase(trim(domain_root, all)) in ['COMCAST', 'SBCGLOBAL', 'BELLSOUTH', 'VERIZON', 'EARTHLINK','COX', 'CHARTER'] and is_tld_country = false and is_tld_state = false),
											true, false);
											
	fix_bad_com_net  := map(is_bad_com => domain_root + '.COM',
													is_bad_net => domain_root + '.NET',
													blank_zeros	);
	
	
	alphachar := regexfind('[A-Z]',domain_root);
	
return  if(alphachar, trim(fix_bad_com_net, all), '');
end;	
