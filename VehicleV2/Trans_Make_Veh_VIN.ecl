import VehicleV2, vehlic;

export 

VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_veh_vina Trans_Make_Veh_VIN(VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_veh_vina l, vehlic.layout_vina r) := transform

//self.vina_vinflag  := if(regexfind('1|s|x|e|z', r.vin_error_status), 'F', 'T'); 
self.vina_veh_type := r.veh_type;
self.vina_ncic_make := r.ncic_make;
self.vina_model_year_yy := r.model_year_yy;
//self.vin := r.vin;
//self.vin_error_status := r.vin_error_status;
self.vina_vin_pattern_indicator := r.vin_pattern_indicator;
//self.vin_pattern := r.vin_pattern;
self.vina_bypass_code := r.bypass_code;
//self.variable_segment := r.variable_segment;
self.vina_vp_restraint := r.vp_restraint;
self.vina_vp_abbrev_make_name := r.vp_abbrev_make_name;
self.vina_vp_year := r.vp_year;
self.vina_vp_series := r.vp_series;
self.vina_vp_model := r.vp_model;
self.vina_vp_air_conditioning := r.vp_air_conditioning;
self.vina_vp_power_steering := r.vp_power_steering;
self.vina_vp_power_brakes := r.vp_power_brakes;
self.vina_vp_power_windows := r.vp_power_windows;
self.vina_vp_tilt_wheel := r.vp_tilt_wheel;
self.vina_vp_roof := r.vp_roof;
self.vina_vp_optional_roof1 := r.vp_optional_roof1;
self.vina_vp_optional_roof2 := r.vp_optional_roof2;
self.vina_vp_radio := r.vp_radio;
self.vina_vp_optional_radio1 := r.vp_optional_radio1;
self.vina_vp_optional_radio2 := r.vp_optional_radio2;
self.vina_vp_transmission := r.vp_transmission;
self.vina_vp_optional_transmission1 := r.vp_optional_transmission1;
self.vina_vp_optional_transmission2 := r.vp_optional_transmission2;
self.vina_vp_anti_lock_brakes := r.vp_anti_lock_brakes;
self.vina_vp_front_wheel_drive := r.vp_front_wheel_drive;
self.vina_vp_four_wheel_drive := r.vp_four_wheel_drive;
self.vina_vp_security_system := r.vp_security_system;
self.vina_vp_daytime_running_lights := r.vp_daytime_running_lights;
//self.vina_vp_reserved := r.vp_reserved;
self.vina_vp_series_name := r.vp_series_name;
self.vina_model_year := r.model_year;
self.vina_series := r.vina_series;
self.vina_model := r.vina_model;
self.vina_body_style := r.vina_body_style;
//self.make_description := r.make_description;
//self.model_description := r.model_description;
self.vina_series_desc:= r.series_description;
//self.body_style_description := r.body_style_description;

self.vina_make_desc 
 := if(r.vina_body_style in ['IC'],
	   '',
	   vehlic.proper_case(r.make_description)
	  );
self.vina_model_desc
 := if(r.vina_body_style in ['IC'],
	   '',
	   vehlic.proper_case(r.model_description)
	  );
self.vina_body_style_desc
 := map(r.vina_body_style in ['IC'] => '',
		r.vina_body_style = '2W' => '2 Dr Wagon Sport Utility',
		r.vina_body_style = '4W' => '4 Dr Wagon Sport Utility',
		vehlic.proper_case(r.body_style_description)
	   );
self.vina_vin
 := if(r.vina_body_style in ['IC'],
	   '',
	   r.vin
	  );

self.vina_number_of_cylinders := r.number_of_cylinders;
self.vina_engine_size := r.engine_size;
self.vina_fuel_code := r.fuel_code;

self.vina_price := map(
	r.veh_type = 'T' => vehlic.translate_price(r.variable_segment[21..25]),
	r.veh_type in ['P','M'] => vehlic.translate_price(r.variable_segment[4..8]),
	'');

self := l;

end;