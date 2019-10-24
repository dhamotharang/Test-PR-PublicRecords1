import codes,ut,vehicleV2,vehiclecodes,vehlic;

dExperianMainTemp	:=	vehiclev2.Map_Experian_Main_Temp;
// dExperianMainTemp	:=	dataset('~thor_data400::persist::vehiclev2::experian_main_temp',VehicleV2.Layout_Experian.layout_temp_main,thor);

// Reformat to the common main layout
VehicleV2.Layout_Base_Main tExpMain(dExperianMainTemp	pInput)	:=
transform
	string3 v_major	:=	vehiclecodes.statecolorToNCICcolor(pInput.state_origin,pInput.major_color_code);
	string3 v_minor	:=	vehiclecodes.statecolorToNCICcolor(pInput.state_origin,pInput.minor_color_code);

  self.state_bitmap_flag					:=	0;
  self.orig_vin										:=	pInput.orig_vin;
	self.orig_year									:=	pInput.year_make;
	self.orig_make_code							:=	pInput.make_code;
	self.orig_series_code						:=	'';
	self.orig_model_code						:=	'';
	self.orig_body_code							:=	pInput.body_code;
	self.orig_vehicle_type_code			:=	pInput.vehicle_type;
	self.orig_vehicle_use_code 			:=	'';
	self.orig_vehicle_use_desc			:=	'';
	self.orig_major_color_code			:=	pInput.major_color_code;
	self.orig_minor_color_code			:=	pInput.minor_color_code;
	self.best_make_code							:=	if(pInput.vina_ncic_make	<>	'',pInput.vina_ncic_make,pInput.make_code);
	self.best_series_code						:=	if(pInput.vina_series	<>	'',pInput.vina_series,pInput.model);
	self.best_model_code						:=	pInput.vina_model;
	self.best_body_code							:=	if(pInput.vina_body_style	<>	'',pInput.vina_body_style,pInput.body_code);
	self.best_model_year						:=	if(pInput.vina_model_year	<>	'',pInput.vina_model_year,pInput.year_make);
	self.best_major_color_code			:=	if(	trim(pInput.major_color_code)	=	'',
																					'UNK',
																					if(	v_major	<>	'UNK',
																							v_major,
																							pInput.major_color_code
																						)
																				);
	self.best_minor_color_code			:=	if(	trim(pInput.minor_color_code)	=	'',
																					'UNK',
																					if(	v_minor	<>	'UNK',
																							v_minor,
																							pInput.minor_color_code
																						)
																				);
	self.orig_net_weight						:=	pInput.net_weight;
  self.orig_number_of_axles				:=	pInput.number_of_axles;
	self.orig_gross_weight					:=	'';
  self.vina_body_style_desc				:=	if(	pInput.vina_body_style_desc	<>	'',
																					pInput.vina_body_style_desc,
																					pInput.orig_body_desc
																				);
	self														:=	pInput;
end;
 
dExperianMain	:=	project(dExperianMainTemp,tExpMain(left));

export	Map_Experian_Main	:=	dExperianMain	:	persist('~thor_data400::persist::vehiclev2::experian_main');