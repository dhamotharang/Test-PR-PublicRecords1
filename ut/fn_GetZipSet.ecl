
IMPORT Census_Data, ut, lib_ziplib;

// The following function returns a set of integer zipcodes based on a variety of formal parameter values.
EXPORT SET OF INTEGER4 fn_GetZipSet(STRING city_value = '',
                                    STRING state_value = '',
                                    STRING zip_val = '',																		
                                    STRING county_value = '',
                                    STRING city_zip_value = '',
                                    UNSIGNED2 zipradius_value = 0,
																		STRING cleaned_zip_value = '',
																		BOOLEAN any_addr_error_value = true) :=
	FUNCTION

		// pick the better derived zip -- if the address cleaned, use the cleaned_zip_value; 
		// otherwise, use the city_zip_value
		derived_zip := IF(~any_addr_error_value, cleaned_zip_value, city_zip_value);
		
		// calculate zips around both the input zip and the better derived value (if different); combine them
		zips_around_input := ziplib.ZipsWithinRadius (zip_val, zipradius_value);
		zips_around_calc := ziplib.ZipsWithinRadius (derived_zip, zipradius_value);
		zips_around := zips_around_input + IF(derived_zip <> zip_val,zips_around_calc, []);
		
		// if no zipradius provided, use the input zip and the derived zip
		default_set := 
			if((integer4)zip_val != 0,[(INTEGER4) zip_val],[]) +
			if((integer4)derived_zip != 0,[(INTEGER4) derived_zip],[]);

		zip_list := LIMIT( Census_Data.key_countyst_zip (county_value <> '', state_value <> '', KEYED (county_name = county_value), KEYED( state_code = state_value )), 
											 ut.limits.CENSUS.ZIP_PER_COUNTY_MAX, KEYED, SKIP);

		zips_by_county := SET(nofold(zip_list)((integer4)zip5 != 0), (INTEGER4) zip5);

		// calculate real zip code(s)		
		zip_value := MAP (zip_val <> '' => IF(zipradius_value = 0 or zips_around = [], default_set, zips_around),
											city_value <> '' and state_value <> '' and zipradius_value > 0 => zips_around,  
											state_value <> '' AND county_value <> '' => zips_by_county,  // by county-state
											[]);
											
		// clean up any overlap in the combined sets									
		return zip_value;
											
	END;									