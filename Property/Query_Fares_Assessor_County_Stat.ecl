import ut;
// Query to create a crosstab with counts by county name from the
// Fares_Assessor property file

#workunit('name','Property Assessor County Stats');

// Project Deeds File  to Slim Records
Layout_Property_County_Codes := RECORD
	STRING2  state;
	STRING3  fips_county_code;
	string4  tax_year;	
END;

Layout_Property_County_Codes GetCountyCodes(Property.Layout_Fares_Assessor L) := TRANSFORM
	SELF.state := Property.Map_FIPS_Code_to_State(L.fips_code[1..2]);
	SELF.fips_county_code := if(L.fips_code = '12025', '086',L.fips_code[3..5]);  // Last 3 characters are the FIPS county code
	self := L;
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

currentYear := ut.GetDate[1..4];

NumSet := ['0','1','2','3','4','5','6','7','8','9'];

hasValidCoverageDate := trim(Fares_Assessor_County_Codes.tax_year) <> ''
	and	length(trim(Fares_Assessor_County_Codes.tax_year)) = 4
	and Fares_Assessor_County_Codes.tax_year[1] in NumSet
	and	Fares_Assessor_County_Codes.tax_year[2] in NumSet
	and Fares_Assessor_County_Codes.tax_year[3] in NumSet
	and Fares_Assessor_County_Codes.tax_year[4] in NumSet
	and (integer)Fares_Assessor_County_Codes.tax_year >= 1990
	and	(integer)Fares_Assessor_County_Codes.tax_year <= (integer)currentYear;

Layout_County_Code_Stat_2 := RECORD
	Fares_Assessor_County_Codes.state;
	Fares_Assessor_County_Codes.fips_county_code;
	minCoverageDate := min(group,Fares_Assessor_County_Codes.tax_year);
	maxCoverageDate := max(group,Fares_Assessor_County_Codes.tax_year);
END;

County_Codes_Stat_2 := TABLE(Fares_Assessor_County_Codes(stringlib.stringfilter(fips_county_code, '0123456789') = fips_county_code and hasValidCoverageDate), Layout_County_Code_Stat_2, state, fips_county_code, FEW);

Layout_County_Code_Stat_Final := RECORD
	Fares_Assessor_County_Names.state;
	Fares_Assessor_County_Names.fips_county_code;
	Fares_Assessor_County_Names.county_name;
	Fares_Assessor_County_Names.reccnt;
	County_Codes_Stat_2.minCoverageDate;
	County_Codes_Stat_2.maxCoverageDate;
END;

Layout_County_Code_Stat_Final joinStats(Layout_County_Names L, Layout_County_Code_Stat_2 R) := transform
	self.minCoverageDate := R.minCoverageDate;
	self.maxCoverageDate := R.maxCoverageDate;
	self := L;
end;

Fares_Assessor_County_Stat_Joined := join(Fares_Assessor_County_Names,
										County_Codes_Stat_2,
										LEFT.state = RIGHT.state AND
										(INTEGER)LEFT.fips_county_code = (INTEGER)RIGHT.fips_county_code,
										joinStats(LEFT,RIGHT),left outer);

OUTPUT(CHOOSEN(Fares_Assessor_County_Stat_Joined(county_name<>'' AND state <>''),ALL));