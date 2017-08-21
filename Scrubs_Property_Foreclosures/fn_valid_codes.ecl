import Property;
EXPORT fn_valid_codes (string code = '',string code_type = ''):= function
codes := Property.File_Foreclosure_Codes;
string to_find := code_type + '|' + code;
my_dict := project(codes, transform({string search_str},
																	 self.search_str:= trim(left.code_type, left, right) + '|' + 
																										 trim(left.code, left, right)));

dict := DICTIONARY(my_dict);
return if(code = '', 1, if(dict[to_find].search_str <> '', 1, 0));
end;

