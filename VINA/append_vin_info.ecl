import VehLic;

export append_vin_info(dataset( VehLic.Layout_VINA) infile) :=  function

/*
vin_copied := record
infile;

boolean vin_valid;
end;




vin_copied populate_vin(infile l) := transform
self.vin := vinchar_substitution(l.vin);
self.vin_valid = vin_is_valid(vinchar_substitution(l.vin));
self := l;
end;

*/

VehLic.Layout_VINA join_vins(VehLic.Layout_VINA l,VINA.layout_vina_infile r) := transform
// populate the proper fields	

self.vin_input := l.vin_input;
self.veh_type := r.vehicle_type;
self.ncic_make := r.ncic_data[1..4];  // 5 byte field
self.model_year_yy := r.model_year[3..4];
self.vin := r.match_vin;  // might replace this with the input vin
self.vin_error_status := '';
self.vin_pattern_indicator := '';
self.vin_pattern := r.vin_pattern;
self.bypass_code := '';
self.variable_segment := '';
self.vp_restraint := ''; // cant find this field
self.vp_abbrev_make_name  := r.nvpp_make_abbreviation; // we dont like this .. only 3 chars instead of 4
self.vp_year :=  r.model_year[3..4];		//// duplicate?
self.vp_series := r.series_abbreviation;
self.vp_model := '';
self.vp_air_conditioning := r.air_conditioning;
self.vp_power_steering := r.power_steering;
self.vp_power_brakes := r.power_brakes;
self.vp_power_windows := r.power_windows;
self.vp_tilt_wheel := r.tilt_wheel;
self.vp_roof := r.roof;
self.vp_optional_roof1 := r.optional_roof1;
self.vp_optional_roof2 := r.optional_roof2;
self.vp_radio := r.radio;
self.vp_optional_radio1 := r.optional_radio1;
self.vp_optional_radio2 := r.optional_radio2;
self.vp_transmission := r.transmission;
self.vp_optional_transmission1 := r.optional_transmission1;
self.vp_optional_transmission2 := r.optional_transmission2;
self.vp_anti_lock_brakes := r.anti_lock_brakes;
self.vp_front_wheel_drive := if(r.proactive_vin = 'N',if(r.driving_wheels='F','Y','N'),'');
self.vp_four_wheel_drive := if(r.vehicle_type = 'T',if(r.wheels[2] = '8','Y','N'),if(r.proactive_vin = 'N',if(r.driving_wheels='4','Y','N'),''));
self.vp_security_system := r.security_system;
self.vp_daytime_running_lights := r.daytime_running_lights;
self.vp_reserved := '';
self.vp_series_name := r.series_name;
self.model_year := r.model_year;
self.vina_series := r.series_abbreviation;
self.vina_model := '';
self.vina_body_style := r.body_type;
self.make_description := r.make_name;
self.model_description := r.series_name;
self.series_description := '';
self.body_style_description := r.full_body_style_name;
self.number_of_cylinders := r.engine_information_cylinders;
self.engine_size := r.displacement; ////////  ?????
self.fuel_code := r.fuel;
self.cr := '';	 
	 end;



vin_joined	:=	join(infile, VINA.file_vina_infile, 
					 ((left.vin_input[1] = right.match_vin[1]) or (right.match_vin[1] = '*')) and
					 
					 ((left.vin_input[2] = right.match_vin[2]) or (right.match_vin[2] = '*')) and
					 ((left.vin_input[3] = right.match_vin[3]) or (right.match_vin[3] = '*')) and
					 ((left.vin_input[4] = right.match_vin[4]) or (right.match_vin[4] = '*')) and
					 ((left.vin_input[5] = right.match_vin[5]) or (right.match_vin[5] = '*')) and
					 ((left.vin_input[6] = right.match_vin[6]) or (right.match_vin[6] = '*')) and
					 ((left.vin_input[7] = right.match_vin[7]) or (right.match_vin[7] = '*')) and
					 ((left.vin_input[8] = right.match_vin[8]) or (right.match_vin[8] = '*')) and
					 ((left.vin_input[9] = right.match_vin[9]) or (right.match_vin[9] = '*')) and
					 ((left.vin_input[10] = right.match_vin[10]) or (right.match_vin[10] = '*')) and
					 ((left.vin_input[11] = right.match_vin[11]) or (right.match_vin[11] = '*')) and
					 ((left.vin_input[12] = right.match_vin[12]) or (right.match_vin[12] = '*')) and
					 ((left.vin_input[13] = right.match_vin[13]) or (right.match_vin[13] = '*')) and
					 ((left.vin_input[14] = right.match_vin[14]) or (right.match_vin[14] = '*')) and
					 ((left.vin_input[15] = right.match_vin[15]) or (right.match_vin[15] = '*')) and
					 ((left.vin_input[16] = right.match_vin[16]) or (right.match_vin[16] = '*')) and
					 ((left.vin_input[17] = right.match_vin[17]) or (right.match_vin[17] = '*')),
					 
					 join_vins(left, right),hash);
return vin_joined;

//outfile := vin_joined;

end;