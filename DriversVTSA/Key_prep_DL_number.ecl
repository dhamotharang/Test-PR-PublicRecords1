import DriversV2, doxie, doxie_build, census_data, ut, lib_stringlib;

ExtendedLayout :=
RECORD
	//DriversV2.file_dl_keybuilding;
	DriversV2.Layout_Drivers;
	// coded fields
	STRING18 county_name := '';
	string30 history_name := '';
	string30 attention_name := '';
	string30 race_name := '';
	string30 sex_name := '';
	string30 hair_color_name := '';
	string30 eye_color_name := '';
	string30 orig_state_name := '';
END;

//dl4key := TABLE(DriversV2.file_dl_keybuilding(dl_number <> ''), ExtendedLayout);

ExtendedLayout getCountyName(ExtendedLayout le, Census_data.File_Fips2County ri) :=
TRANSFORM
	SELF.county_name := ri.county_name;
	SELF := le;
END;


ExtendedLayout GetExtendedValues(DriversV2.Layout_DL L) := transform
	self.sex_name := map(L.sex_flag = 'U' => 'UNKNOWN',
						 L.sex_flag = 'M' => 'MALE',
						 L.sex_flag = 'F' => 'FEMALE',
						 'UNKNOWN'); 
	self.race_name := map(L.race = 'W' => 'WHITE',
					  L.race = 'B' => 'BLACK',
					  L.race = 'H' => 'HISPANIC',
					  L.race = 'A' => 'ASIAN',
					  L.race = 'I' => 'NATIVE AMERICAN',
					  L.race = 'O' => 'OTHER',
					  L.race);
	self.history_name := case(L.History,
							'C' => 'CURRENT',
							'H' => 'HISTORICAL',
							''  => 'CURRENT',
							'');
	self.orig_state_name := ut.St2Name(L.orig_state);
	self.eye_Color_name := Lookups.lookup_Eye_Color(L.eye_color);
	self.hair_Color_name := Lookups.lookup_Hair_Color(L.hair_color);
	self.attention_name := '';	// not populated
	SELF.county_name := '';		// populated in join step
	self.record_type := '';
	self := L;
end;

expanded :=	Project(CompDL, GetExtendedValues(LEFT));

export Key_prep_DL_number := JOIN(expanded, Census_data.File_Fips2County, 
				LEFT.county = RIGHT.county_fips AND LEFT.st = RIGHT.state_code, 
				getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);

