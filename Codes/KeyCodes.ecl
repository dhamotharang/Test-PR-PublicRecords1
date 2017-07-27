export varstring 
KeyCodes(
	string file_name_value, 
	string field_name_value, 
	string field_name2_value = '',
	string code_value,
	boolean allowNullCodes = false
	) := 
FUNCTION

i := limit(codes.Key_Codes_V3(
			keyed(file_name = StringLib.StringToUpperCase(file_name_value)), 
			keyed(field_name = StringLib.StringToUpperCase(field_name_value)),
			keyed(field_name2_value = '' or field_name2 = StringLib.StringToUpperCase(field_name2_value), opt),
			keyed(code = code_value, opt)), 10, skip); //limit not keyed since field_name2_value often blank
		
s := if(allowNullCodes or (code_value<>''), i[1].long_desc, '');
		
return s;

END;