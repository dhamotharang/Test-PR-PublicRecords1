Export Layout_HRI_Address_Sic :=
record
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string5  zip;
	string4  zip4;
	string4   sic_code;
  	string2 source; // Added
	string4   addr_type;
	unsigned3 dt_first_seen;
	string120	company_name;
end;
