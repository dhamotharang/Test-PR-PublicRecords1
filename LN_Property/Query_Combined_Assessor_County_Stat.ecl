
Import property;

// Query to create a crosstab with counts by county name from the
// Fares_Assessor property file

#workunit('name','Combined Property Assessor County Stats');


d := dataset('~thor_data400::out::ln_property::built::assessor', LN_Property.Layout_Moxie_Property_Common_Model_BASE, thor);

// Project Deeds File  to Slim Records
Layout_Property_County_Codes := RECORD
	STRING2  state;
	STRING3  fips_county_code;
	STRING5  vendor_source_flag;
	
END;

Layout_Property_County_Codes GetCountyCodes(LN_Property.Layout_Moxie_Property_Common_Model_BASE L) := TRANSFORM
	SELF.state := Property.Map_FIPS_Code_to_State(L.fips_code[1..2]);
	SELF.fips_county_code := if(L.fips_code = '12025', '086',L.fips_code[3..5]);  // Last 3 characters are the FIPS county code
	SELF := L;
END;

Combined_Assessor_County_Codes := PROJECT(d, GetCountyCodes(LEFT));

// Crosstab to count occurrences of each unique county code
Layout_County_Code_Stat := RECORD
	Combined_Assessor_County_Codes.state;
	Combined_Assessor_County_Codes.fips_county_code;
	Combined_Assessor_County_Codes.vendor_source_flag;
	reccnt := COUNT(GROUP);
END;

County_Codes_Stat := TABLE(Combined_Assessor_County_Codes(stringlib.stringfilter(fips_county_code, '0123456789') = fips_county_code), Layout_County_Code_Stat, state, fips_county_code, vendor_source_flag, FEW);

Layout_County_Names := RECORD
	Layout_County_Code_Stat;
	STRING18 county_name;
END;

// Join to County Code Name file to get names
Layout_County_Names GetCountyNames(Layout_County_Code_Stat L, Property.Layout_County_Code_Names R) := TRANSFORM
	SELF.county_name := R.county_name;
	SELF := L;
END;

Query_Combined_Assessor_County_Stat := JOIN(County_Codes_Stat,
                                 Property.File_County_Code_Names,
                                 LEFT.state = RIGHT.state AND
                                   (INTEGER)LEFT.fips_county_code = (INTEGER)RIGHT.fips_county_code,
                                 GetCountyNames(LEFT, RIGHT));

OUTPUT(CHOOSEN(Query_Combined_Assessor_County_Stat(county_name<>'' AND state <>''),ALL));
