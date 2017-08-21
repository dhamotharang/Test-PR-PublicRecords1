export Mac_validVIN(veh_in,veh_out)	:=	macro

	import ut,Vehlic,vehicleV2;

	string8	yyyymmdd(string	date_field)	:=	if(	length(trim(date_field,all))	=	6,
																							trim(date_field,all)	+	'01',
																							date_field
																						);

	recordof(veh_in)	tjoinVINA(veh_in	L,VehLic.Vin_Matches	R)	:=
	transform
		self.vina_vinflag										:=	if(	regexfind('1|S|X|E|Z',r.vin_error_status)	and	r.vin_input	=	r.vin	and	r.model_year_yy	=	'08',
																								'T',
																								if(	regexfind('1|S|X|E|Z',r.vin_error_status)	or	r.vin_error_status	=	'',
																										'F',
																										'T'
																									)
																							);
		self.vina_vin												:=	r.vin;
		self.vina_veh_type									:=	R.veh_type;
		self.vina_ncic_make									:=	R.ncic_make;
		self.vina_model_year_yy							:=	R.model_year_yy;
		self.vina_vin_pattern_indicator			:=	R.vin_pattern_indicator;
		self.vina_bypass_code								:=	R.bypass_code;
		self.vina_vp_restraint							:=	R.vp_restraint;
		self.vina_vp_abbrev_make_name				:=	R.vp_abbrev_make_name;
		self.vina_vp_year										:=	R.vp_year;
		self.vina_vp_series									:=	R.vp_series;
		self.vina_vp_model									:=	R.vp_model;
		self.vina_vp_air_conditioning				:=	R.vp_air_conditioning;
		self.vina_vp_power_steering					:=	R.vp_power_steering;
		self.vina_vp_power_brakes						:=	R.vp_power_brakes;
		self.vina_vp_power_windows					:=	R.vp_power_windows;
		self.vina_vp_tilt_wheel							:=	R.vp_tilt_wheel;
		self.vina_vp_roof										:=	R.vp_roof;
		self.vina_vp_optional_roof1					:=	R.vp_optional_roof1;
		self.vina_vp_optional_roof2					:=	R.vp_optional_roof2;
		self.vina_vp_radio									:=	R.vp_radio;
		self.vina_vp_optional_radio1				:=	R.vp_optional_radio1;
		self.vina_vp_optional_radio2				:=	R.vp_optional_radio2;
		self.vina_vp_transmission						:=	R.vp_transmission;
		self.vina_vp_optional_transmission1	:=	R.vp_optional_transmission1;
		self.vina_vp_optional_transmission2	:=	R.vp_optional_transmission2;
		self.vina_vp_anti_lock_brakes				:=	R.vp_anti_lock_brakes;
		self.vina_vp_front_wheel_drive			:=	R.vp_front_wheel_drive;
		self.vina_vp_four_wheel_drive				:=	R.vp_four_wheel_drive;
		self.vina_vp_security_system				:=	R.vp_security_system;
		self.vina_vp_daytime_running_lights	:=	R.vp_daytime_running_lights;
		self.vina_vp_series_name						:=	R.vp_series_name;
		self.vina_model_year								:=	R.model_year;
		self.vina_series										:=	R.vina_series;
		self.vina_model											:=	R.vina_model;
		self.vina_body_style								:=	R.vina_body_style;
		self.vina_series_desc								:=	R.series_description;

		self.vina_make_desc									:=	IF(	R.vina_body_style	in	['IC'],
																								'',
																								vehlic.proper_case(R.make_description)
																							);
		self.vina_model_desc								:=	IF(	R.vina_body_style	in	['IC'],
																								'',
																								vehlic.proper_case(R.model_description)
																							);
		self.vina_body_style_desc						:=	MAP(	R.vina_body_style	in	['IC']	=>	'',
																									R.vina_body_style	= 	'2W'		=>	'2 Dr Wagon Sport Utility',
																									R.vina_body_style	= 	'4W'		=>	'4 Dr Wagon Sport Utility',
																									vehlic.proper_case(R.body_style_description)
																								);

		self.vina_number_of_cylinders				:=	R.number_of_cylinders;
		self.vina_engine_size								:=	R.engine_size;
		self.vina_fuel_code									:=	R.fuel_code;

		self.vina_price											:=	if(	r.vina_price	!=	'',
																								vehlic.translate_price(r.vina_price),
																								map(	r.veh_type	=	'T'					=>	vehlic.translate_price(r.variable_segment[21..25]),
																											r.veh_type	in	['P','M']	=>	vehlic.translate_price(r.variable_segment[4..8]),
																											''
																										)
																							);

		self							:=	L;
	end;

	veh_join	:=	join(	distribute(veh_in,hash((string25)orig_vin)),
											VehLic.Vin_Matches,
											left.orig_vin	=	right.vin_input,
											tjoinVINA(left,right),
											left outer,
											local
										);
					 
	veh_temp	:=	dedup(veh_join,all,local);


	recordof(veh_in)	tvaldates(veh_temp	L)	:=
	transform
		self.REGISTRATION_EFFECTIVE_DATE	:=	yyyymmdd(if(	(unsigned6)L.REGISTRATION_EFFECTIVE_DATE[1..6]	<	(unsigned6)L.REGISTRATION_EXPIRATION_DATE[1..6],
																												L.REGISTRATION_EFFECTIVE_DATE,
																												''
																											)
																									);
		self.REGISTRATION_EXPIRATION_DATE	:=	yyyymmdd(if(	(unsigned6)L.REGISTRATION_EFFECTIVE_DATE[1..6]	<	(unsigned6)L.REGISTRATION_EXPIRATION_DATE[1..6],
																												L.REGISTRATION_EXPIRATION_DATE,
																												''
																											)
																									);
		self															:=	L;
	end;

	veh_out	:=	project(veh_temp,tvaldates(left));
endmacro;