export Fn_Clean_Email_Username (string email) := function
	att_pos 							:= StringLib.StringFind(email, '@',StringLib.StringFindCount(email, '@'));
	username 							:= stringlib.stringtouppercase(email[1..att_pos -1]);
	//blank any characters not [Aa-Zz] or [0-9] or [! # $ % & ' * + - / = ? ^ _ ` { | } ~ ]
	blank_bad_chars 			:= regexreplace('[^[:alnum:]!#$%&\'*+-/=?^_`{|}~]',username ,'');
	//blank leading or ending characters [.'+,/-]
	blank_leading_bad_chars:= regexreplace('(^[*.\'+/,-]+)|([*.\'+/,-]+$)',blank_bad_chars ,'');
	//blank usernames with all characters being multiple 0s
	blank_zeros						:=  regexreplace('^[0!#$%&\'*+-/=?^_`{|}~]+[0!#$%&\'*+-/=?^_`{|}~][0!#$%&\'*+-/=?^_`{|}~]+$',blank_leading_bad_chars ,'');
	alphachar := regexfind('[A-Za-z0-9]',blank_zeros);
	
	return  if(alphachar, trim(blank_zeros,all), '');
end;	

