import drivers, doxie_build, doxie_files, DriversV2_Services;

export Layout_dlSearch := 
RECORD
	string1 nonDMVsource := '';
	unsigned8 seq := 0;
	doxie_files.Layout_Drivers and not [dt_first_seen, dt_last_seen];
	unsigned8 dt_first_seen;
	unsigned8 dt_last_seen;
	STRING18 county_name := '';
	string30 history_name := '';
	string30 attention_name := '';
	string30 race_name := '';
	string30 sex_name := '';
	string30 hair_color_name := '';
	string30 eye_color_name := '';
	string30 orig_state_name := '';
	string10 source := doxie_build.buildstate;
	typeof(DriversV2_Services.layouts.result_wide.license_class_name) license_class_name := '';
END;