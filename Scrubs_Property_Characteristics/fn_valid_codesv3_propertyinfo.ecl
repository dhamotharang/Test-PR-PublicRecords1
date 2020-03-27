import Codes,STD;
EXPORT fn_valid_codesv3_propertyinfo(string code = '', string field_name_in = '', string file_name_in = ''):= function
codes_v3 := Codes.File_Codes_V3_In(file_name = file_name_in);
string to_find := file_name_in + '|' +  field_name_in + '|' + TRIM(code,left,right);
my_dict := project(codes_v3, transform({string search_str},
																	 self.search_str:= trim(left.file_name, left, right) + '|' + 
																									trim(left.field_name, left, right) + '|' + 
																									trim(left.long_desc[1..STD.Str.Find(left.long_desc, '|', 1) -1], right)
																									));
																										 

dict := DICTIONARY(my_dict);
return if(dict[to_find].search_str <> '' or code = '' or code = '0', 1, 0);
end;