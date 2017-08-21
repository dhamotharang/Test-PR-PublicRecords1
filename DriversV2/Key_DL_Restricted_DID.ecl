// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

IMPORT Census_data, Codes, Data_Services, doxie, Doxie_Build, DriversV2, Data_Services;

// Pulled code from DL_Decoded and repurposed it to work for the restricted data.
ExtendedLayout := DriversV2.Layout_DL_Decoded_Restricted;

dl4key := PROJECT(DriversV2.File_DL_Restricted, TRANSFORM(ExtendedLayout, SELF := LEFT, SELF := []));

ExtendedLayout getCountyName(ExtendedLayout L, Census_data.File_Fips2County R) := TRANSFORM
	SELF.county_name := R.county_name;
	SELF := L;
END;

o0 := JOIN(dl4key, Census_data.File_Fips2County, 
				   LEFT.county = RIGHT.county_fips AND
					    LEFT.st = RIGHT.state_code, 
				   getCountyName(LEFT, RIGHT),
					 LOOKUP,
					 LEFT OUTER);

ExtendedLayout getHist(ExtendedLayout L, Codes.File_Codes_V3_In R):= TRANSFORM
	SELF.history_name := stringlib.stringToUpperCase(R.long_desc);
	SELF := L;
END;

o1 := JOIN(o0, Codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE2', field_name = 'HISTORY'),
		       (STRING15)LEFT.history = RIGHT.code,
					 getHist(LEFT, RIGHT),
					 LEFT OUTER,
					 LOOKUP);

ExtendedLayout getAttention(ExtendedLayout L, Codes.File_Codes_V3_In R) := TRANSFORM
	SELF.attention_name:= IF(R.long_desc != '', stringlib.stringToUpperCase(R.long_desc), L.attention_flag);
	SELF := L;
END;

o2 := JOIN(o1, Codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE2', field_name = 'ATTENTION_FLAG'),
		       (STRING15)LEFT.attention_flag = RIGHT.code AND
					    LEFT.orig_state = RIGHT.field_name2,
		       getAttention(LEFT, RIGHT),
					 LEFT OUTER,
					 LOOKUP);

ExtendedLayout GetSexAndRace(ExtendedLayout L, Codes.File_Codes_V3_In R) := TRANSFORM
	SELF.sex_name := stringlib.stringToUpperCase(R.long_desc);
	SELF.race_name := MAP(L.race = 'W' => 'WHITE',
						            L.race = 'B' => 'BLACK',
			  			          L.race = 'H' => 'HISPANIC',
						            L.race = 'A' => 'ASIAN',
			                  L.race = 'I' => 'NATIVE AMERICAN',
			                  L.race = 'O' => 'OTHER',
						            L.race);
	SELF := L;
END;

o3 := JOIN(o2, Codes.File_Codes_V3_In(file_name = 'GENERAL', field_name = 'GENDER'),
		       (STRING15)LEFT.sex_flag = RIGHT.code,
					 getSexAndRace(LEFT, RIGHT),
					 LEFT OUTER,
					 LOOKUP);

ExtendedLayout getHairColor(ExtendedLayout L, Codes.File_Codes_V3_In R) := TRANSFORM
	SELF.hair_color_name := stringlib.stringToUpperCase(R.long_desc);
	SELF := L;
END;

o4 := JOIN(o3, Codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE2', field_name = 'HAIR_COLOR'),
		       LEFT.orig_state = RIGHT.field_name2 AND
					    LEFT.hair_color = RIGHT.code,
		       getHairColor(LEFT, RIGHT),
					 LEFT OUTER,
					 LOOKUP);

ExtendedLayout getEyeColor(ExtendedLayout L, Codes.File_Codes_V3_In R) := TRANSFORM
	SELF.eye_color_name := stringlib.stringToUpperCase(R.long_desc);
	SELF := L;
END;

o5 := JOIN(o4, Codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE2', field_name= 'EYE_COLOR'), 
		       LEFT.orig_state = RIGHT.field_name2 AND
					    LEFT.eye_color = RIGHT.code, 
		       getEyeColor(LEFT, RIGHT),
					 LEFT OUTER,
					 LOOKUP);

ExtendedLayout getState(ExtendedLayout L, Codes.File_Codes_V3_In R) := TRANSFORM
	SELF.orig_state_name := stringlib.stringToUpperCase(R.long_desc);
	SELF := L;
END;

o6 := JOIN(o5, Codes.File_Codes_V3_In(file_name = 'GENERAL', field_name= 'STATE_LONG'),
		       LEFT.orig_state = RIGHT.code,
		       getState(LEFT, RIGHT),
					 LEFT OUTER,
					 LOOKUP);

base := DEDUP(SORT(DISTRIBUTE(o6(did != 0), HASH(did)), RECORD, LOCAL), RECORD, LOCAL);

EXPORT Key_DL_Restricted_DID := INDEX(base,
						                          {did},
						                          {base},
						                          Data_Services.Data_location.Prefix('DLS') + 'thor_data400::key::dl2::' +
																			   doxie.Version_SuperKey + '::dl_restricted_did_' + Doxie_Build.buildstate);
						   