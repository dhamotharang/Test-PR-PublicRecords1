export Layout_In_Alt := record
  string1    alt_type;  // B = Best, R = Relative, S = Sex Offender
  string10   alt_prim_range;
	string2    alt_predir;
	string28   alt_prim_name;
	string4    alt_suffix;
	string2    alt_postdir;
	string10   alt_unit_desig;
	string8    alt_sec_range;
	string25   alt_city_name;
	string2    alt_st;
	string5    alt_zip;
	string4    alt_zip4;
	unsigned3  alt_addr_dt_first_seen;
	unsigned3  alt_addr_dt_last_seen;	
	unsigned1  alt_GLB;
	unsigned1  alt_dppa;
	STRING2 	 src;
	boolean  	 isMismatched := false;
end;