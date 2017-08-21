export Layout_FLCrash7_v4 := record
//	string1   rec_type_7,
	string   accident_nbr,
	string	 crash_yr,
//	string   prop_damage_nbr,	//replaced by seperate vehicle and person number fields
	string	vehicle_nbr,		//new field
	string	person_nbr,			//new field
	string  prop_damaged,
	string  prop_damage_amount,
	string  prop_owner_firstname,
	string  prop_owner_middleinitial,
	string  prop_owner_lastname,
	string  prop_owner_suffix,
	string	prop_business_name,	//new field
	string	prop_business_ind,	//new field
	string  prop_owner_street,
	string  prop_owner_city,
	string  prop_owner_state,
	string  prop_owner_zip
//	string   ORMD_flag
end;