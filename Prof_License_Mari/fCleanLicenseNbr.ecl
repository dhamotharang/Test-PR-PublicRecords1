import ut;

EXPORT fCleanLicenseNbr(string license) := function

	alpha				:= '[[:alpha:]]+';
	whitespace	:= '[[:space:]]*';
	digits			:= '[[:digit:]]+';
	sepchar			:= '[-./*#`\'%+_=",]';
	pound		   	:= '[#]';
	parenth			:= '[()]';
	punct				:= '[:punct:]';

	prefix_alpha 	:= alpha + sepchar;
	prefix_digit 	:= '^([A-Z]{1}[0-9]{1})' + punct;
	suffix_digit	:= punct + alpha + digits;
	suffix_alpha 	:= punct + alpha;
	
	suffix_otn	 	:= alpha + pound + digits;
	suffix_paren	:= parenth + alpha + parenth;
	trl_zero 			:= sepchar + '0+$';
	// trl_zero 			:= punct + '0+$';
		
	
  rmv_slash			:= StringLib.StringFilterOut(license,'\\');  
	rmv_bracket		:= StringLib.StringFilterOut(rmv_slash,']');  
	rmv_spaces		:= regexreplace(whitespace,rmv_bracket, '');
	repl_asterisk	:= regexreplace('\\*\\*',rmv_spaces,'*');
	
	//Stripping trailing # extention
	strip_suffix_pound	:= regexreplace(suffix_otn,repl_asterisk,'');
	strip_suffix_paren	:= regexreplace(suffix_paren,strip_suffix_pound,'');
	
	// Stripping leading alpha characters with indicator
	strip_prefix 	:= regexreplace(prefix_alpha,strip_suffix_paren,'');
	strip_prefix_digit 	:= regexreplace(prefix_digit,strip_prefix,'');
	
	//Stripping trailing alpha characters with indicator
	strip_suffix_digit	:= regexreplace(suffix_digit,strip_prefix_digit,'');
	strip_suffix_alpha	:= regexreplace(suffix_alpha,strip_suffix_digit,'');
	
	// Stripping trailing zero with indicator
	rmv_trl_zero	:= regexreplace(trl_zero,strip_suffix_alpha,'');
	strippunct 		:= regexreplace(sepchar,rmv_trl_zero,'');

	// Stripping leading zero
	license_nbr		:= regexreplace('^0+(?!$)',strippunct,'');
	clean_license	:= if(license_nbr = '0','',license_nbr);
	
 //Ignore Non-Sufficient number/invalid 
	invalid := '(NUMB|INC)';
	exluded_license := regexreplace(invalid,trim(clean_license),'');	
	
	return exluded_license;

END;
	

