export Layout_FLCrash5_v4 := record
//	string1   rec_type_5,
	string   accident_nbr,
	string	 crash_yr,	//new field added yyyy
	string   section_nbr,
	string   passenger_nbr,
	string   passenger_firstname,
	string   passenger_middleinitial,
	string   passenger_lastname,
	string   passenger_name_suffix,
	string	 passenger_phone_nbr,
	string   passenger_street,
  string   passenger_city,
	string   passenger_state,
	string   passenger_zip,
	string   passenger_dob,
//	string   passenger_age,
//	string   passenger_race,
	string   passenger_sex,
	string	 helmet_code,				//new field, was passenger_safe fields
	string	 restraint_system,	//new field, was passenger_safe fields
	string	 eye_protection,		//new field, was passenger_safe fields
	string	 airbag_deployment,	//new field, was passenger_safe fields
	string   passenger_eject_code,
	string   passenger_injury_sev,
// string   first_passenger_safe,
// string   second_passenger_safe,
//	string    OMRD_flag
	string   seat_position,				//was part of passenger_location
	string	 row_position,				//was part of passenger_location
	string	 other_position				//new field added
end;