IMPORT lib_stringlib, ut, mdr;

EXPORT Translation_Codes := MODULE

//Setting bit map for the validation rules
export rules_bitmap_code(string rules = '')  := map(
																										rules = 'Invalid_Domain_ext'			  					=> ut.bit_set(0,0),
																										rules = 'Missing_Domain_ext'									=> ut.bit_set(0,1),
																										rules = 'Invalid_Domain'											=> ut.bit_set(0,2),
																										rules = 'Invalid_email'												=> ut.bit_set(0,3),
																										rules = 'Missing_username'										=> ut.bit_set(0,4),
																										rules = 'Missing_@_symbol'										=> ut.bit_set(0,5),
																										rules = 'DOD_b4_email'												=> ut.bit_set(0,6),
																										0);

//Function to obtain the validation rules that are set
export	string	fGet_rules_from_bitmap(unsigned bitmap_rules) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_rules)	:=	pValue & bitmap_rules = bitmap_rules;
		string		translated_value	:=	if(bitmap_rules = 0,
																			'',											   
																		if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Invalid_Domain_ext')),			' ' + 'Invalid_Domain_ext','')
																+	  if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Missing_Domain_ext')),			' ' + 'Missing_Domain_ext','')
																+	  if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Invalid_Domain')),					' ' + 'Invalid_Domain','')
																+	  if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Invalid_email')),						' ' + 'Invalid_email','')
																+	  if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Missing_username')),				' ' + 'Missing_username','')
																+	  if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Missing_@_symbol')),				' ' + 'Missing_@_symbol','')
																+	  if(fFlagIsOn(bitmap_rules, rules_bitmap_code('DOD_b4_email')),						' ' + 'DOD_b4_email','')
																			);
return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;

end;