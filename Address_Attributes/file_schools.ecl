import ut;

//layout
layout_schools := record
	string15	UNITID;
	string1		Inst_type;
	string120	school_name;
	STRING10 	prim_range;
	STRING2  	predir;
	STRING28 	prim_name;
	STRING4  	suffix;
	STRING2  	postdir;
	STRING10 	unit_desig;
	STRING8  	sec_range;
	STRING25 	p_city_name;
	STRING2  	st;
	STRING5  	zip;
	STRING4  	zip4;
	STRING10 	geo_lat;
	STRING11 	geo_long;
	STRING7	 	geo_blk;
	STRING5	 	county;
	STRING4  	msa;
	STRING1	 	geo_match;
	STRING12	geolink;
end;

schools := dataset('~thor_data400::school_master', layout_schools, thor);

export file_schools := schools;