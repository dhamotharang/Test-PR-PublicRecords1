// Lookup for Codesv2
// Parameters - file_name, field_name, field_name2 and code
// Return value - description of the code (string330)

import codes;
export Codesv3_Lookup(string fname,string field,string  field2,string cde) := function
	ds := codes.File_Codes_V3_In(trim(file_name)= fname and trim(field_name) = field and 
															trim(field_name2) = field2 and trim(code) = cde);
	
	return ds[1].long_desc;
	
end;	