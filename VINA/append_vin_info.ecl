import VehLic;

export append_vin_info(dataset( VehLic.Layout_VINA) infile) :=
function

		string17 vinchar_substitution(string17 vin) :=
		function
			string17	temp_vin	:=	regexreplace('I',regexreplace('[OQ]',vin,'0'),'1');
			string3		wmi				:=	temp_vin[1..3];
			string5		attribs		:=	temp_vin[4..8];
			string1		chkdgt		:=	temp_vin[9];
			string1		year			:=	regexreplace('Z',temp_vin[10],'2');
			string1		plant			:=	temp_vin[11];
			string6		seq_no		:=	temp_vin[12..17];
			return wmi+attribs+chkdgt+year+plant+seq_no;
		end;
	
	VehLic.Layout_VINA fix_vin(VehLic.Layout_VINA l) :=
	transform
		self.vin	:=	if(l.vin	=	'',vinchar_substitution(trim(l.vin_input,left,right)),l.vin);
		self			:=	l;
	end;

	more_crap :=	project(infile,fix_vin(left));
	
	//Reference new VINtelligence base file
	// VehLic.Layout_VINA join_vins(VehLic.Layout_VINA l,VINA.layout_vina_infile r) :=
	VehLic.Layout_VINA join_vins(VehLic.Layout_VINA l,VINA.layout_base_vintelligence r) :=
	transform
		// populate the proper fields	
		self.vin_input										:=	l.vin_input;
		self.veh_type											:=	if(r.vehicle_type != '',r.vehicle_type,l.veh_type);
		self.ncic_make										:=	if(r.ncic_data[1..4] != '',r.ncic_data[1..4],l.ncic_make);  // 5 byte field
		self.model_year_yy								:=	if(r.model_year[3..4] != '',r.model_year[3..4],l.model_year_yy);
		// self.vin													:=	if(r.match_vin != '',r.match_vin,l.vin);  // might replace this with the input vin
		self.vin													:=	l.vin; 		
		self.vin_error_status							:=	'';
		self.vin_pattern_indicator				:=	if(l.vin_pattern_indicator != '',l.vin_pattern_indicator,'');
		self.vin_pattern									:=	if(r.vin_pattern != '',r.vin_pattern,l.vin_pattern);
		self.bypass_code									:=	if(l.bypass_code != '',l.bypass_code,'');
		self.variable_segment							:=	if(l.variable_segment != '',l.variable_segment,'');
		self.vp_restraint									:=	if(l.vp_restraint != '',l.vp_restraint,''); // cant find this field
		self.vp_abbrev_make_name					:=	if(r.nvpp_make_abbreviation != '',r.nvpp_make_abbreviation,l.vp_abbrev_make_name); // we dont like this .. only 3 chars instead of 4
		self.vp_year											:=	if(r.model_year[3..4] != '',r.model_year[3..4],l.vp_year);		//// duplicate?
		self.vp_series										:=	if(r.series_abbreviation != '',r.series_abbreviation,l.vp_series);
		self.vp_model											:=	if(l.vp_model != '',l.vp_model,'');
		self.vp_air_conditioning					:=	if(r.air_conditioning != '',r.air_conditioning,l.vp_air_conditioning);
		self.vp_power_steering						:=	if(r.power_steering != '',r.power_steering,l.vp_power_steering);
		self.vp_power_brakes							:=	if(r.power_brakes != '',r.power_brakes,l.vp_power_brakes);
		self.vp_power_windows							:=	if(r.power_windows != '',r.power_windows,l.vp_power_windows);
		self.vp_tilt_wheel								:=	if(r.tilt_wheel != '',r.tilt_wheel,l.vp_tilt_wheel);
		self.vp_roof											:=	if(r.roof != '',r.roof,l.vp_roof);
		self.vp_optional_roof1						:=	if(r.optional_roof1 != '',r.optional_roof1,l.vp_optional_roof1);
		self.vp_optional_roof2						:=	if(r.optional_roof2 != '',r.optional_roof2,l.vp_optional_roof2);
		self.vp_radio											:=	if(r.radio != '',r.radio,l.vp_radio);
		self.vp_optional_radio1						:=	if(r.optional_radio1 != '',r.optional_radio1,l.vp_optional_radio1);
		self.vp_optional_radio2						:=	if(r.optional_radio2 != '',r.optional_radio2,l.vp_optional_radio2);
		self.vp_transmission							:=	if(r.transmission != '',r.transmission,l.vp_transmission);
		self.vp_optional_transmission1		:=	if(r.optional_transmission1 != '',r.optional_transmission1,l.vp_optional_transmission1);
		self.vp_optional_transmission2		:=	if(r.optional_transmission2 != '',r.optional_transmission2,l.vp_optional_transmission2);
		self.vp_anti_lock_brakes					:=	if(r.anti_lock_brakes != '',r.anti_lock_brakes,l.vp_anti_lock_brakes);
		self.vp_front_wheel_drive					:=	if(r.proactive_vin = 'N',if(r.driving_wheels='F','Y','N'),l.vp_front_wheel_drive);
		self.vp_four_wheel_drive					:=	if(r.vehicle_type = 'T',if(r.wheels[2] = '8','Y','N'),if(r.proactive_vin = 'N',if(r.driving_wheels	in	['A','4'],'Y','N'),l.vp_four_wheel_drive));
		self.vp_security_system						:=	if(r.security_system != '',r.security_system,l.vp_security_system);
		self.vp_daytime_running_lights		:=	if(r.daytime_running_lights != '',r.daytime_running_lights,l.vp_daytime_running_lights);
		self.vp_reserved									:=	if(l.vp_reserved != '',l.vp_reserved,'');
		self.vp_series_name								:=	if(r.series_name != '',r.series_name,l.vp_series_name);
		self.model_year										:=	if(r.model_year != '',r.model_year,l.model_year);
		self.vina_series									:=	if(r.series_abbreviation != '',r.series_abbreviation,l.vina_series);
		self.vina_model										:=	if(l.vina_model != '',l.vina_model,'');
		self.vina_body_style							:=	if(r.body_type != '',r.body_type,l.vina_body_style);
		self.make_description							:=	if(r.make_name != '',r.make_name,l.make_description);

		// DF-28271 - use base model , instead of series_name, for model_description
		self.model_description						:=	if(r.base_model != '',r.base_model,l.model_description);
		// self.series_description						:=	if(l.series_description != '',l.series_description,'');
		self.series_description						:=	if(l.series_description != '',l.series_description,
														  if(r.series_name != '',r.series_name,
														     ''));
		self.body_style_description				:=	if(r.full_body_style_name != '',r.full_body_style_name,l.body_style_description);
		self.number_of_cylinders					:=	if(r.engine_information_cylinders != '',r.engine_information_cylinders,l.number_of_cylinders);
		self.engine_size									:=	if(r.displacement != '',r.displacement,l.engine_size); ////////  ?????
		self.fuel_code										:=	if(r.fuel != '',r.fuel,l.fuel_code);
		self.vina_price										:=	if(r.base_list_price	!=	'',r.base_list_price,l.vina_price);
		self.cr														:=	'';
	end;

	infile_dist						:=	distribute(more_crap,hash(vin_input[1..8]));
	// file_vina_infile_dist	:=	distribute(VINA.file_vina_infile,hash(match_vin[1..8]));
	file_vina_infile_dist	:=	distribute(VINA.file_vina_base,hash(match_vin[1..8]));
	
	vin_joined	:=	join(	infile_dist,
												file_vina_infile_dist,
												// ((left.vin[1..8]	= right.match_vin[1..8])) and
												// ((left.vin[9]		= right.match_vin[9]) or (right.match_vin[9] = '*')) and
												// ((left.vin[10]		= right.match_vin[10]) or (right.match_vin[10] = '*')) and
												// ((left.vin[11]		= right.match_vin[11]) or (right.match_vin[11] = '*')) and
												// ((left.vin[12]		= right.match_vin[12]) or (right.match_vin[12] = '*')) and
												// ((left.vin[13]		= right.match_vin[13]) or (right.match_vin[13] = '*')) and
												// ((left.vin[14]		= right.match_vin[14]) or (right.match_vin[14] = '*')) and
												// ((left.vin[15]		= right.match_vin[15]) or (right.match_vin[15] = '*')) and
												// ((left.vin[16]		= right.match_vin[16]) or (right.match_vin[16] = '*')) and
												// ((left.vin[17]		= right.match_vin[17]) or (right.match_vin[17] = '*')),
												((left.vin[1..8]	= right.VIN_SIGNI_PATTRN_MASK[1..8])) and
												((left.vin[9]		= right.VIN_SIGNI_PATTRN_MASK[9]) or (right.match_vin[9] = '*')) and
												((left.vin[10]		= right.VIN_SIGNI_PATTRN_MASK[10]) or (right.VIN_SIGNI_PATTRN_MASK[10] = '*')) and
												((left.vin[11]		= right.VIN_SIGNI_PATTRN_MASK[11]) or (right.VIN_SIGNI_PATTRN_MASK[11] = '*')) and
												((left.vin[12]		= right.VIN_SIGNI_PATTRN_MASK[12]) or (right.VIN_SIGNI_PATTRN_MASK[12] = '*')) and
												((left.vin[13]		= right.VIN_SIGNI_PATTRN_MASK[13]) or (right.VIN_SIGNI_PATTRN_MASK[13] = '*')) and
												((left.vin[14]		= right.VIN_SIGNI_PATTRN_MASK[14]) or (right.VIN_SIGNI_PATTRN_MASK[14] = '*')) and
												((left.vin[15]		= right.VIN_SIGNI_PATTRN_MASK[15]) or (right.VIN_SIGNI_PATTRN_MASK[15] = '*')) and
												((left.vin[16]		= right.VIN_SIGNI_PATTRN_MASK[16]) or (right.VIN_SIGNI_PATTRN_MASK[16] = '*')) and
												((left.vin[17]		= right.VIN_SIGNI_PATTRN_MASK[17]) or (right.VIN_SIGNI_PATTRN_MASK[17] = '*')),
												join_vins(left,right),
												left outer,
												local
											);

	return	vin_joined;
end;