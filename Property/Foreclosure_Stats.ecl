// Query to create a crosstab with counts by county name from the
// Fares_Deeds property file

#workunit('name','Foreclosure County Stats');

LK := dataset('~thor_data400::base::foreclosure',Property.Layout_Fares_Foreclosure,thor);

// Project Deeds File  to Slim Records
Layout_Foreclosure_County_Codes := RECORD
	///STRING2  state;
	//STRING3  county;
	string2 mstate;
	LK.county;
	string8	 m_recording_date;
END;

Layout_Foreclosure_County_Codes GetCountyCodes(LK L) := TRANSFORM
	self.mstate := Property.Map_FIPS_Code_to_State(L.state);
	self.m_recording_date := L.recording_date;
	self := L;
END;

Foreclosure_County_Codes := PROJECT(LK, GetCountyCodes(LEFT));

// Crosstab to count occurrences of each unique county code
Layout_County_Code_Stat := RECORD
	Foreclosure_County_Codes.mstate;
	Foreclosure_County_Codes.county;
	string8 min_recording_date := min(group,Foreclosure_County_Codes.m_recording_date);
	string8 max_recording_date := max(group,Foreclosure_County_Codes.m_recording_date);
	reccnt := COUNT(GROUP);
END;

County_Codes_Stat := TABLE(Foreclosure_County_Codes, Layout_County_Code_Stat, mstate, county, FEW);

Layout_County_Names := RECORD
	Layout_County_Code_Stat.mstate;
	Layout_County_Code_Stat.county;
	STRING18 county_name;
	Layout_County_Code_Stat.min_recording_date;
	Layout_County_Code_Stat.max_recording_date;
END;

// Join to County Code Name file to get names
Layout_County_Names GetCountyNames(Layout_County_Code_Stat L, Property.Layout_County_Code_Names R) := TRANSFORM
	SELF.county_name := R.county_name;
	SELF := L;
END;

Foreclosure_County_Names := JOIN(County_Codes_Stat(trim(min_recording_date,left,right) <> '0000'),
                                 Property.File_County_Code_Names,
                                 LEFT.mstate = RIGHT.state AND
                                   (INTEGER)LEFT.county = (INTEGER)RIGHT.fips_county_code,
                                 GetCountyNames(LEFT, RIGHT),
                                 LEFT OUTER);

OUTPUT(CHOOSEN(Foreclosure_County_Names(trim(mstate,left,right) <> ''),ALL));