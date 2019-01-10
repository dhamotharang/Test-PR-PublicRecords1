IMPORT lib_stringlib, ut, mdr;

EXPORT Translation_Codes := MODULE

//Setting bit map for the validation rules
EXPORT rules_bitmap_code(string rules = '')  := MAP(
																										rules = 'invalid_domain_ext'			  					=> ut.bit_set(0,0),
																										rules = 'missing_domain_ext'									=> ut.bit_set(0,1),
																										rules = 'invalid_domain'											=> ut.bit_set(0,2),
																										rules = 'invalid_email'												=> ut.bit_set(0,3),
																										rules = 'missing_username'										=> ut.bit_set(0,4),
																										rules = 'missing_@_symbol'										=> ut.bit_set(0,5),
																										rules = 'dod_b4_email'												=> ut.bit_set(0,6),
																										0);

//Testing if bitmap is set
EXPORT fFlagIsOn(unsigned bitmap, unsigned bitmap_rules)	:=	FUNCTION
	RETURN bitmap & bitmap_rules = bitmap_rules;
END;

//Function to obtain the validation rules that are set
EXPORT	STRING	fGet_rules_from_bitmap(unsigned bitmap_rules) := FUNCTION
		STRING		translated_value	:=	IF(bitmap_rules = 0,
																			'',											   
																		IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('invalid_domain_ext')),			' ' + 'Invalid_Domain_ext','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('missing_domain_ext')),			' ' + 'Missing_Domain_ext','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('invalid_domain')),					' ' + 'Invalid_Domain','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('invalid_email')),						' ' + 'Invalid_email','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('missing_username')),				' ' + 'Missing_username','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('missing_@_symbol')),				' ' + 'Missing_@_symbol','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('dod_b4_email')),						' ' + 'DOD_b4_email','')
																			);
RETURN		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
END;

END;