IMPORT DriversV2;

EXPORT Layout_DL_Decoded_Restricted := RECORD
	DriversV2.Layout_Drivers;
	// coded fields
	STRING18 county_name := '';
	STRING30 history_name := '';
	STRING30 attention_name := '';
	STRING30 race_name := '';
	STRING30 sex_name := '';
	STRING30 hair_color_name := '';
	STRING30 eye_color_name := '';
	STRING30 orig_state_name := '';
END;