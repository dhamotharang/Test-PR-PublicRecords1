import Census_data, doxie_build, doxie, data_services;

pf := doxie_build.file_header_building;


Layout_xpf :=
RECORD
	pf;
	STRING18 county_name;
END;

Layout_xpf getCountyName(pf le, Census_data.File_Fips2County ri) :=
TRANSFORM
	SELF.county_name := ri.county_name;
	SELF := le;
END;
f := JOIN(pf, Census_data.File_Fips2County, 
		LEFT.county = RIGHT.county_fips AND LEFT.st = RIGHT.state_code, 
		getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);

slim :=
RECORD
	STRING20 lname := f.lname;
	f.county_name;
	STRING2 st := f.st;
	STRING20 fname := f.fname;
	STRING20 mname := f.mname;
	f.did;
END;


p := TABLE(f,slim);

d := DEDUP(SORT(P,record),record);

export Key_Header_CountyName := INDEX(d,
                                      {d},
                                      data_services.data_location.prefix() + 'thor_data400::key::header.county_' + doxie.Version_SuperKey);