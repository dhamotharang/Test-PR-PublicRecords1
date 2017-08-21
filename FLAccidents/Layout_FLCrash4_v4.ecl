export Layout_FLCrash4_v4 := record
	string   accident_nbr,
	string	 crash_yr,	//new field added yyyy
	string   section_nbr,		//now seperate vehicle and person number fields.
	string   driver_nbr,	//new field, was part of section_nbr	
	string   recommand_reexam,
	string   driver_dl_nbr,
	string   driver_lic_st,
	string	 driver_expire_dte,
	string   driver_lic_type,
	string	 driver_distraction,	//new field
	string   driver_physical_defects,
	string   req_endorsement,
	string	 vision_obstructed,	//new field, was part of events file
	string	 ins_company_name,	//new field, was part of vehicles file
	string	 ins_policy_nbr,		//new field, was part of vehicles file
	string   driver_fname,
	string   driver_mname,
	string   driver_lname,
	string   driver_name_suffix,
	string	 driver_phone_nbr,
//string    driver_action,
	string   driver_street,
	string   driver_city,
	string   driver_resident_state,
	string   driver_zip,
	string   driver_dob,
	string   driver_sex,
//	string   driver_age,
//	string   driver_race,
	string	 helmet_code,		//new field, was driver_safety fields
	string	 restraint_system,	//new field, was driver_safety fields
	string	 eye_protection,		//new field, was driver_safety fields
	string	 airbag_deployment,	//new field, was driver_safety fields
	string   driver_eject_code,
	string   alch_drug_use1,
	string	 alch_drug_tested1,	//new field
	string   driver_bac_test_type1,
  string   driver_bac_test_results1,
	string	 blood_alch_content,		//new field
	string   alch_drug_use2,
	string	 alch_drug_tested2,	//new field
	string   driver_bac_test_type2,
  string   driver_bac_test_results2,
	string   driver_injury_severity,
	string	 ems_transport,		//new field
	string	 ems_agency,			//new field
	string	 ems_run_nbr,			//new field
	string	 injured_taken_to_code,	//new field, was in events file
	string	 seat_position,		//new field
	string	 row_position,		//new field
	string	 other_position,	//new field
	string   first_contrib_cause,
	string   second_contrib_cause,
	string   third_contrib_cause,
	string   fourth_contrib_cause	//new field
//	string   driver_residence,
//	string    omrd_flag
end;