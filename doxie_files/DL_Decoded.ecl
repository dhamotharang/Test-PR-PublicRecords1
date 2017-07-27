import doxie, doxie_build, codes, census_data, ut, FCRA;


export DL_Decoded(BOOLEAN IsFCRA) := function

ExtendedLayout := layout_dl_decoded;

all_zeros := '00000000000000';

dl4key := TABLE(file_dl(~isFCRA or ~FCRA.Restricted_DL_Source(source_code),
												stringlib.StringCleanSpaces(dl_number)<>'',
                        stringlib.StringCleanSpaces(dl_number)<>
													all_zeros[1..length(stringlib.StringCleanSpaces(dl_number))]),
                ExtendedLayout);

ExtendedLayout getCountyName(ExtendedLayout le, Census_data.File_Fips2County ri) :=
TRANSFORM
	SELF.county_name := ri.county_name;
	SELF := le;
END;
o0 := JOIN(dl4key, Census_data.File_Fips2County, 
				LEFT.county = RIGHT.county_fips AND LEFT.st = RIGHT.state_code, 
				getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);

ExtendedLayout getHist(ExtendedLayout L, codes.File_Codes_V3_In R):= transform
	self.history_name := R.long_desc;
	self := L;
end;
o1 := join(o0,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name = 'HISTORY'),
		 (string15)left.history = right.code,getHist(LEFT,RIGHT),left outer, lookup);


ExtendedLayout getAttention(ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.attention_name:= IF(R.long_desc != '', R.long_desc, L.attention_flag);
	self := L;
end;
o2 := join(o1,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name = 'ATTENTION_FLAG'),
		 (String15)left.attention_flag = right.code and left.orig_state = right.field_name2,
		 getAttention(LEFT,RIGHT),left outer, lookup);


ExtendedLayout GetSexAndRace(ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.sex_name := R.long_desc;
	self.race_name := map(L.race = 'W' => 'WHITE',
										L.race = 'B' => 'BLACK',
										L.race = 'H' => 'HISPANIC',
										L.race = 'A' => 'ASIAN',
										L.race = 'I' => 'NATIVE AMERICAN',
										L.race = 'O' => 'OTHER',
										L.race);
	self := L;
end;
o3 := join(o2,codes.File_Codes_V3_In(file_name = 'GENERAL',field_name = 'GENDER'),
		 (string15)left.sex_flag = right.code, getSexAndRace(LEFT,RIGHT),left outer, lookup);


ExtendedLayout getHairColor(ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.hair_color_name := R.long_desc;
	self := L;
end;
o4 := join(o3,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name = 'HAIR_COLOR'),
		 left.orig_state = right.field_name2 and left.hair_color = right.code,
		 getHairColor(LEFT,RIGHT),left outer, lookup);


ExtendedLayout getEyeColor(ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.eye_Color_name := R.long_desc;
	self := L;
end;
o5 := join(o4,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name= 'EYE_COLOR'), 
		 left.orig_state = right.field_name2 and left.eye_color = right.code, 
		 getEyeColor(LEFT,RIGHT),left outer, lookup);

ExtendedLayout getState(ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.orig_state_name := R.long_desc;
	self := L;
end;
o6 := join(o5,
		 codes.File_Codes_V3_In(file_name = 'GENERAL', field_name= 'STATE_LONG'),
		 left.orig_state = right.code,
		 getState(LEFT,RIGHT),left outer, lookup);


return o6;

end;