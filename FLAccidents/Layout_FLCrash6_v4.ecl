export Layout_FLCrash6_v4 := record
//	string1   rec_type_6,
	string  accident_nbr,
	string	crash_yr,
	string  section_nbr,
	string	ped_location,
	string  ped_action,
	string	non_motorist_desc,
	string  pedest_first_name,
	string  pedest_middle_initial,
	string  pedest_last_name,
	string  ped_name_suffix,
	string	ped_phone_nbr,  //new field
	string  ped_street,
	string  ped_city,
	string  ped_state,
	string  ped_zip,
	string  ped_dob,
// string  ped_age,
// string  ped_race,
	string   ped_sex,
//	string   ped_work_area,
	string	 ped_alch_use,	//new field
	string   ped_alco_tested,
	string   ped_bac_test_type1,
	string	 ped_alco_results,	//new field
	string   ped_bac_results,
	string	 ped_drug_use,	//new field
	string   ped_drugs_tested,
	string   ped_bac_test_type2,
	string   ped_drug_results,	//new field
	string   ped_injury_sev,
	string	 ems_transport,		//new field
	string	 ems_agency,			//new field
	string	 ems_run_nbr,			//new field
	string	 injured_taken_to_code,	//new field, was in events file	
// string   ped_physical_defect,
// string   ped_residence,
	string		ped_first_contrib_cause,
	string		ped_second_contrib_cause,
//	string   ped_first_contrib_cause,
//	string   ped_second_contrib_cause,
//	string   ped_third_contrib_cause,
//	string   ped_action,
//	string    OMRD_flag
	string		ped_safety_equip1,
	string		ped_safety_equip2
end;