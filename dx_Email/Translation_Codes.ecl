﻿IMPORT lib_stringlib, ut, mdr;

EXPORT Translation_Codes := MODULE

//Setting bit map for the validation rules
EXPORT rules_bitmap_code(string rules = '')  := MAP(
																										rules = 'not_used_0'			  	   				      => ut.bit_set(0,0),
																										rules = 'missing_domain_ext'									=> ut.bit_set(0,1),
																										rules = 'invalid_domain'											=> ut.bit_set(0,2),
																										rules = 'on_known_invalid_list'								=> ut.bit_set(0,3),
																										rules = 'missing_username'										=> ut.bit_set(0,4),
																										rules = 'missing_@_symbol'										=> ut.bit_set(0,5),
																										rules = 'dod_b4_email'												=> ut.bit_set(0,6),
																										rules = 'invalid_account'											=> ut.bit_set(0,7),
																										rules = 'includes_profanity'									=> ut.bit_set(0,8),
																										rules = 'disposable_address'									=> ut.bit_set(0,9),
																										rules = 'role_address'												=> ut.bit_set(0,10),
																										0);

//Testing if bitmap is set
EXPORT fFlagIsOn(unsigned bitmap, unsigned bitmap_rules)	:=	FUNCTION
	RETURN bitmap & bitmap_rules = bitmap_rules;
END;

//Function to obtain the validation rules that are set
EXPORT	STRING	fGet_rules_from_bitmap(unsigned bitmap_rules) := FUNCTION
		STRING		translated_value	:=	IF(bitmap_rules = 0,
																			'',											   
																		IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('not_used_0')),			        ' ' + 'not_used_0','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('missing_domain_ext')),			' ' + 'missing_domain_ext','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('invalid_domain')),					' ' + 'invalid_domain','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('on_known_invalid_list')),		' ' + 'on_known_invalid_list','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('missing_username')),				' ' + 'missing_username','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('missing_@_symbol')),				' ' + 'missing_@_symbol','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('dod_b4_email')),						' ' + 'dod_b4_email','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('invalid_account')),					' ' + 'invalid_account','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('includes_profanity')),			' ' + 'includes_profanity','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('disposable_address')),			' ' + 'disposable_address','')
																+	  IF(fFlagIsOn(bitmap_rules, rules_bitmap_code('role_address')),						' ' + 'role_address','')
																			);
RETURN		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
END;

END;