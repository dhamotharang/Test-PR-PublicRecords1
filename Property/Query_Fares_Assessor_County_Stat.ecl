// Query to create a crosstab with counts by county name from the
// Fares_Assessor property file

#workunit('name','Property Assessor County Stats');

// Project Deeds File  to Slim Records
Layout_Property_County_Codes := RECORD
	STRING2  state;
	STRING3  fips_county_code;
END;

Layout_Property_County_Codes GetCountyCodes(Property.Layout_Fares_Assessor L) := TRANSFORM
	SELF.state := Property.Map_FIPS_Code_to_State(L.fips_code[1..2]);
	SELF.fips_county_code := if(L.fips_code = '12025', '086',L.fips_code[3..5]);  // Last 3 characters are the FIPS county code
END;

Fares_Assessor_County_Codes := PROJECT(Property.File_Fares_Assessor, GetCountyCodes(LEFT));

// Crosstab to count occurrences of each unique county code
Layout_County_Code_Stat := RECORD
	Fares_Assessor_County_Codes.state;
	Fares_Assessor_County_Codes.fips_county_code;
	reccnt := COUNT(GROUP);
END;

County_Codes_Stat := TABLE(Fares_Assessor_County_Codes(stringlib.stringfilter(fips_county_code, '0123456789') = fips_county_code), Layout_County_Code_Stat, state, fips_county_code, FEW);

Layout_County_Names := RECORD
	Layout_County_Code_Stat;
	STRING18 county_name;
END;

// Join to County Code Name file to get names
Layout_County_Names GetCountyNames(Layout_County_Code_Stat L, Property.Layout_County_Code_Names R) := TRANSFORM
	SELF.county_name := R.county_name;
	SELF := L;
END;

Fares_Assessor_County_Names := JOIN(County_Codes_Stat,
                                 Property.File_County_Code_Names,
                                 LEFT.state = RIGHT.state AND
                                   (INTEGER)LEFT.fips_county_code = (INTEGER)RIGHT.fips_county_code,
                                 GetCountyNames(LEFT, RIGHT));

OUTPUT(CHOOSEN(Fares_Assessor_County_Names(county_name<>'' AND state <>''),ALL));