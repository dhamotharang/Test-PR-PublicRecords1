export Layout_Common := record
	unsigned6 rid := 0;
	string1 source;

	unsigned6 bdid := 0;
	integer2 bdid_score := 0;
	
	string350 name;
	string10  fein;
	string10 phone10;

	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
end;