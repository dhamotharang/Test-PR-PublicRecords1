IMPORT BKForeclosure, STD;

EXPORT fn_valid_codes (string code = '', string src = '', string field_name = ''):= function
codes := BKForeclosure.File_BK_Foreclosure.codes_table;
string to_find := src + '|' + field_name + '|' + STD.Str.ToUpperCase(code);
my_dict := project(codes, transform({string search_str},
																	 self.search_str:= trim(left.src, left, right) + '|' +
																										 trim(left.field_name, left, right) + '|' + 
																										 trim(left.code, left, right)));

dict := DICTIONARY(my_dict);
return if(code = '', 1, if(dict[to_find].search_str <> '', 1, 0));
end;