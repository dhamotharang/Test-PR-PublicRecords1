import doxie_files, doxie_build;

export Layout_VehicleSearch := 
RECORD
	doxie_files.Layout_Vehicles;
	string30 history_name := '';
	string30 major_color_name := '';
	string30 minor_color_name := '';
	string30 orig_state_name := '';
	string30 body_code_name := '';
	string30 fuel_type_name := '';
	string30 hull_material_type_name := '';
	string75 license_plate_code_name := '';
	string30 odometer_status_name := '';
	string30 title_status_code_name := '';
	string30 vehicle_type_name := '';
	string30 vehicle_use_name := '';
	string30 vessel_propulsion_type_name := '';
	string30 vessel_type_name := '';
	string30	lh_1_county_name := '';
	string30	lh_2_county_name := '';
	string30	lh_3_county_name := '';
	string5   lh_1_zip5 := '';
	string4   lh_1_zip4 := '';
	string5   lh_2_zip5 := '';
	string4   lh_2_zip4 := '';
	string5   lh_3_zip5 := '';
	string4   lh_3_zip4 := '';
	unsigned1 pick := 0;
	string10 source := doxie_build.buildstate;
	unsigned8 seq := 0;
END;