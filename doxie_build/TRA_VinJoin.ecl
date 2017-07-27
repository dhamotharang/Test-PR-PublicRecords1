import VehicleCodes, VehLic, doxie_files;

// we don't like vina's with body_style = 'IC'
export doxie_files.Layout_VehicleVehicles TRA_VinJoin (doxie_files.Layout_slimvin L, doxie_files.Layout_VehicleVehicles R) :=

TRANSFORM

	SELF.history 				:= L.history;

	self.BODY_CODE 				:= vehiclecodes.filterBodyStyleCode(R.orig_state, R.BODY_CODE);
	self.MINOR_COLOR_CODE 		:= if(R.MINOR_COLOR_CODE = R.MAJOR_COLOR_CODE, '', R.MINOR_COLOR_CODE);
	
	self.make_description 		:= MAP(L.vina_body_style IN ['IC'] => '',
									   L.vin <> '' => VehLic.proper_case(L.make_description), 
									   VehicleCodes.getMake(R.orig_state, R.make_code));

	self.model_description 		:= MAP(L.vina_body_style IN ['IC'] => '',
									   L.vin <> '' => VehLic.proper_case(L.model_description),
									   VehicleCodes.getVehicleType(R.orig_state, R.vehicle_type, R.vessel_type));
									   
	self.orig_vin 				:= if((integer)R.YEAR_MAKE >= 1972 and 
										stringlib.StringFind(R.orig_vin, '?',1) > 0, 
										stringlib.StringFilterOut(R.orig_vin, '?'),
										R.orig_vin);
	// 2W/4W are really sport utilities... we'll call them...
	self.body_style_description := MAP( L.vina_body_style in ['IC'] => '',
										L.vina_body_style = '2W' => '2 Dr Wagon Sport Utility',
										L.vina_body_style = '4W' => '4 Dr Wagon Sport Utility',
										L.vin <> '' => vehlic.proper_case(L.body_style_description),
									    VehicleCodes.getBodyType(self.BODY_CODE));

self.veh_type := L.veh_type;
self.ncic_make := L.ncic_make;
self.model_year_yy := L.model_year_yy;
self.vin_pattern_indicator := L.vin_pattern_indicator;
self.bypass_code := L.bypass_code;
self.vp_restraint := L.vp_restraint;
self.vp_abbrev_make_name := L.vp_abbrev_make_name;
self.vp_year := L.vp_year;
self.vp_series := L.vp_series;
self.vp_model := L.vp_model;
self.vp_air_conditioning := L.vp_air_conditioning;
self.vp_power_steering := L.vp_power_steering;
self.vp_power_brakes := L.vp_power_brakes;
self.vp_power_windows := L.vp_power_windows;
self.vp_tilt_wheel := L.vp_tilt_wheel;
self.vp_roof := L.vp_roof;
self.vp_optional_roof1 := L.vp_optional_roof1;
self.vp_optional_roof2 := L.vp_optional_roof2;
self.vp_radio := L.vp_radio;
self.vp_optional_radio1 := L.vp_optional_radio1;
self.vp_optional_radio2 := L.vp_optional_radio2;
self.vp_transmission := L.vp_transmission;
self.vp_optional_transmission1 := L.vp_optional_transmission1;
self.vp_optional_transmission2 := L.vp_optional_transmission2;
self.vp_anti_lock_brakes := L.vp_anti_lock_brakes;
self.vp_front_wheel_drive := L.vp_front_wheel_drive;
self.vp_four_wheel_drive := L.vp_four_wheel_drive;
self.vp_security_system := L.vp_security_system;
self.vp_daytime_running_lights := L.vp_daytime_running_lights;
self.vp_series_name := L.vp_series_name;
self.model_year := L.model_year;
self.vina_series := L.vina_series;
self.vina_model := L.vina_model;
self.vina_body_style := L.vina_body_style;
self.series_description := L.series_description;

self.vin
 := if(L.vina_body_style in ['IC'],
	   '',
	   L.vin
	  );

self.number_of_cylinders := L.number_of_cylinders;
self.engine_size := L.engine_size;
self.fuel_code := L.fuel_code;

self.vina_price := map(
	L.veh_type = 'T' => vehlic.translate_price(L.variable_segment[21..25]),
	L.veh_type in ['P','M'] => vehlic.translate_price(L.variable_segment[4..8]),
	'');

self.vin_2 := IF(VehLic.ValidVin(R.orig_vin), R.orig_vin, '');
self.flagvin := R.flagvin;
self.flagmatchcode := if(L.vin <> '' , (string8)stringlib.getdateYYYYMMDD(), R.flagmatchcode);

	self.Best_Make_Code			:= if(L.NCIC_Make <> '', L.NCIC_Make, R.MAKE_CODE);
	self.Best_Series_Code		:= if(L.VINA_Series<>'',L.VINA_Series, R.MODEL);
	self.Best_Model_Code		:= L.VINA_Model;
	self.Best_Body_Code			:= if(L.VINA_Body_Style<>'',L.VINA_Body_Style, R.BODY_CODE);
	self.Best_Model_Year		:= if(L.Model_Year<>'', L.Model_Year, R.Year_Make);
	self.Best_Major_Color_Code	:= VehicleCodes.StateColorToNCICColor(R.ORIG_STATE, R.MAJOR_COLOR_CODE);
	self.Best_Minor_Color_Code	:= VehicleCodes.StateColorToNCICColor(R.ORIG_STATE, SELF.MINOR_COLOR_CODE);

self := R;

end;