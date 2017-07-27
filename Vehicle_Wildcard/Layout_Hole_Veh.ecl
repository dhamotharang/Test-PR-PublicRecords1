export Layout_Hole_veh := record
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string15 Sequence_Key;
  BIG_ENDIAN unsigned4 wd_veh_id := 0;
  BIG_ENDIAN unsigned2 wd_YEAR_MAKE;
  BIG_ENDIAN unsigned2 wd_MAKE_CODE;
  BIG_ENDIAN unsigned2 wd_MODEL_description;
  BIG_ENDIAN unsigned1 wd_MAJOR_COLOR_CODE;
  // BIG_ENDIAN unsigned1 wd_MINOR_COLOR_CODE; //
  qstring10             wd_PLATE_NUMBER;
  qstring25             wd_VIN;
  // BIG_ENDIAN unsigned4 wd_fname; //
  // string1              wd_fnamei; //
  // BIG_ENDIAN unsigned4 wd_mname; //
  // string1              wd_mnamei; //
  // BIG_ENDIAN unsigned4 wd_lname; //
  string1              wd_gender;
  BIG_ENDIAN unsigned1 wd_years_since_1900;
  BIG_ENDIAN unsigned3 wd_zip;
  BIG_ENDIAN unsigned1 wd_state;
  BIG_ENDIAN unsigned1 wd_orig_state;
  BIG_ENDIAN unsigned1 wd_person_source;
	unsigned2 wd_body_code;
end;