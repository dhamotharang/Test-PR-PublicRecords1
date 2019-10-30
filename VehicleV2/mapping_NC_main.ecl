//---------------------------------------------------------------------------
//-------MAP to BASE MAIN FORMAT LAYOUT
//---------------------------------------------------------------------------

import CODES,VehicleV2,VehicleCodes,vehlic;

// NC vehicle temp main
dNCTempMain	:=	VehicleV2.Mapping_NC_Temp_Main;

// dNCTempMain	:=	dataset('~thor_data400::persist::vehicleV2::nc_temp_main',VehicleV2.Layout_NC.NC_as_VehicleV2_Layout,thor);

VehicleV2.Layout_Base_Main tNCMain(dNCTempMain	pInput)	:=
transform
	string3 v_major 								:=	VehicleCodes.StateColorToNCICColor(pInput.STATE_origin,pInput.MAJOR_COLOR_CODE);
	string3 v_minor 								:=	VehicleCodes.StateColorToNCICColor(pInput.STATE_origin,pInput.MINOR_COLOR_CODE);

	self.State_BitMAP_Flag 					:=	0;
	self.orig_Year									:=	pInput.YEAR_MAKE;
	self.orig_Make_Code							:=	pInput.make_code;
	self.orig_Make_Desc							:=	VehicleCodes.getMake(pInput.state_origin,pInput.Make_code);
	self.orig_Model_code						:=	pInput.MODEL;
	self.orig_Body_Code							:=	pInput.BODY_CODE;
	self.orig_number_of_axles				:=	pInput.NUMBER_OF_AXLES;
	self.orig_Vehicle_Type_Code			:=	VehicleV2.translate_DI_orig_vehicle_type(pInput.orig_vehicle_type_desc);
	self.orig_vehicle_use_code			:=	pInput.vehicle_use;
	self.orig_major_color_code			:=	pInput.major_color_code;
	self.orig_minor_color_code			:=	pInput.minor_color_code;
	self.Best_Make_Code			      	:=	if(pInput.vina_NCIC_Make	<>	'',pInput.vina_NCIC_Make,	pInput.MAKE_CODE);
	self.Best_Series_Code		      	:=	if(pInput.VINA_Series	<>	'',pInput.VINA_Series,pInput.MODEL);
	self.Best_Model_Code		      	:=	pInput.VINA_Model;  // we don't keep this separate from state
	self.Best_Body_Code			      	:=	if(pInput.VINA_Body_Style	<>	'',pInput.VINA_Body_Style,pInput.BODY_CODE);
	self.Best_Model_Year		      	:=	if(pInput.vina_Model_Year	<>	'',pInput.vina_Model_Year,pInput.Year_Make);
	self.Best_Major_Color_Code			:=	if(	TRIM(pInput.MAJOR_COLOR_CODE)	=	'',
																					'UNK',
																					if(	v_major	<>	'UNK',
																							v_major,
																							pInput.MAJOR_COLOR_CODE
																						)
																				);
	self.Best_Minor_Color_Code			:=	if(	TRIM(pInput.MINOR_COLOR_CODE)	=	'',
																					'UNK',
																					if(	v_minor	<>	'UNK',
																							v_minor,
																							pInput.MINOR_COLOR_CODE
																						)
																				);
	self.vina_body_style_desc     	:=	if(pInput.vina_body_style_desc	<>	'',pInput.vina_body_style_desc,pInput.body_style_description);
	//Added for CCPA-103
	// self.global_sid                 := 0;
	// self.record_sid                 := 0;
	
	self														:=	pInput;
	self:= [] ; //Blank all experian new fields added to main layout
end;
 
dNCVehicleMain	:=	PROJECT(dNCTempMain,tNCMain(LEFT));

export	mapping_NC_main	:=	dNCVehicleMain	:	persist('~thor_data400::persist::vehicleV2::nc_main');