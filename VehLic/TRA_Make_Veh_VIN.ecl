export 

//these vina_body_style codes will have their VIN, make, model, and body_style blanked
//lBadVINABodyStyleCodes := ['IC'];

vehlic.layout_vehicles TRA_Make_Veh_VIN
	(vehlic.layout_vehicles l,
	 vehlic.layout_vina r,
	 string str_vin_2, boolean set_flagvin, boolean set_flagmatchcode) := transform

//self.vin17 := r.vin17;
self.veh_type := r.veh_type;
self.ncic_make := r.ncic_make;
self.model_year_yy := r.model_year_yy;
//self.vin := r.vin;
//self.vin_error_status := r.vin_error_status;
self.vin_pattern_indicator := r.vin_pattern_indicator;
//self.vin_pattern := r.vin_pattern;
self.bypass_code := r.bypass_code;
//self.variable_segment := r.variable_segment;
self.vp_restraint := r.vp_restraint;
self.vp_abbrev_make_name := r.vp_abbrev_make_name;
self.vp_year := r.vp_year;
self.vp_series := r.vp_series;
self.vp_model := r.vp_model;
self.vp_air_conditioning := r.vp_air_conditioning;
self.vp_power_steering := r.vp_power_steering;
self.vp_power_brakes := r.vp_power_brakes;
self.vp_power_windows := r.vp_power_windows;
self.vp_tilt_wheel := r.vp_tilt_wheel;
self.vp_roof := r.vp_roof;
self.vp_optional_roof1 := r.vp_optional_roof1;
self.vp_optional_roof2 := r.vp_optional_roof2;
self.vp_radio := r.vp_radio;
self.vp_optional_radio1 := r.vp_optional_radio1;
self.vp_optional_radio2 := r.vp_optional_radio2;
self.vp_transmission := r.vp_transmission;
self.vp_optional_transmission1 := r.vp_optional_transmission1;
self.vp_optional_transmission2 := r.vp_optional_transmission2;
self.vp_anti_lock_brakes := r.vp_anti_lock_brakes;
self.vp_front_wheel_drive := r.vp_front_wheel_drive;
self.vp_four_wheel_drive := r.vp_four_wheel_drive;
self.vp_security_system := r.vp_security_system;
self.vp_daytime_running_lights := r.vp_daytime_running_lights;
//self.vp_reserved := r.vp_reserved;
self.vp_series_name := r.vp_series_name;
self.model_year := r.model_year;
self.vina_series := r.vina_series;
self.vina_model := r.vina_model;
self.vina_body_style := r.vina_body_style;
//self.make_description := r.make_description;
//self.model_description := r.model_description;
self.series_description := r.series_description;
//self.body_style_description := r.body_style_description;

self.make_description 
 := if(r.vina_body_style in ['IC'],
	   '',
	   vehlic.proper_case(r.make_description)
	  );
self.model_description
 := if(r.vina_body_style in ['IC'],
	   '',
	   vehlic.proper_case(r.model_description)
	  );
self.body_style_description
 := map(r.vina_body_style in ['IC'] => '',
		r.vina_body_style = '2W' => '2 Dr Wagon Sport Utility',
		r.vina_body_style = '4W' => '4 Dr Wagon Sport Utility',
		vehlic.proper_case(r.body_style_description)
	   );
self.vin
 := if(r.vina_body_style in ['IC'],
	   '',
	   r.vin
	  );

self.number_of_cylinders := r.number_of_cylinders;
self.engine_size := r.engine_size;
self.fuel_code := r.fuel_code;

self.vina_price := map(
	r.veh_type = 'T' => vehlic.translate_price(r.variable_segment[21..25]),
	r.veh_type in ['P','M'] => vehlic.translate_price(r.variable_segment[4..8]),
	'');


self.vin_2 := str_vin_2;
self.flagvin := if(r.vin <> '' and set_flagvin, (string8)stringlib.getdateYYYYMMDD(), l.flagvin);
self.flagmatchcode := if(r.vin <> '' and set_flagmatchcode, (string8)stringlib.getdateYYYYMMDD(), l.flagmatchcode);
self := l;

end;