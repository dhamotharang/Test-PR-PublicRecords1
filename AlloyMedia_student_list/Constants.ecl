EXPORT Constants := MODULE

	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::alloy::qa::ffid. This is also used to
	// deprecate fields in thor_data400::key::fcra::alloymedia_student_list::qa::did
	EXPORT fields_to_clear_alloy := 'address_info_code,clean_fips_county,clean_phone_number,clean_title,clean_v_city_name,' +
																 'gender_code,home_housing_code,home_info_time_zone,home_phone_number,intl_exchange_student_code,' +
																 'school_address_1_primary,school_address_2_secondary,school_city,school_housing_code,' +
																 'school_info_time_zone,school_phone_number,school_state,school_zip4,school_zip5';

END;