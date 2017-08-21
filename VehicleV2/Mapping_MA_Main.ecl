import ut,VehicleV2,VehicleCodes,CODES,vehlic;

//---------------------------------------------------------------------------
//-------MAP to BASE MAIN FORMAT LAYOUT
//---------------------------------------------------------------------------

// MA vehicle temp main file
dMATempMain	:=	VehicleV2.Mapping_MA_Temp_Main;

// Map to the base vehiclev2 main layout
VehicleV2.Layout_Base_Main	tReformat2Main(dMATempMain	pInput)	:=
transform
	
	self.State_BitMAP_Flag 					:=	0;
  self.orig_vin										:=	pInput.orig_vin;
	self.orig_year									:=	pInput.year_make;
	self.orig_series_code						:=	'';
	self.orig_series_desc						:=	'';
	self.orig_model_code						:=	'';
	self.orig_Body_Code							:=	pInput.BODY_CODE;
	self.orig_body_desc							:=	pInput.body_style_description;
	self.orig_Make_Desc							:= stringlib.StringToUpperCase(VehicleCodes.getMake(pInput.state_origin,pInput.Make_code));

	//self.orig_Model_code						:=	pInput.MODEL;
	//self.orig_number_of_axles				:=	pInput.NUMBER_OF_AXLES;
	self.orig_Vehicle_Type_Code			:=	pInput.vehicle_type;
	self.orig_Vehicle_Type_Desc			:=  VehicleV2.getVehTypeDesc(pInput.vehicle_type);
	self.orig_vehicle_use_code			:=	'';
	self.orig_vehicle_use_desc			:=	'';
	self.orig_major_color_code			:=	pInput.major_color_code;
	self.orig_minor_color_code			:=	pInput.minor_color_code;
	
	self.Best_Make_Code			      	:=	if(pInput.vina_NCIC_Make	<>	'',pInput.vina_NCIC_Make,	pInput.MAKE_CODE);
	self.Best_Series_Code		      	:=	if(pInput.VINA_Series	<>	'',pInput.VINA_Series,pInput.MODEL);
	self.Best_Model_Code		      	:=	pInput.VINA_Model;  
	self.Best_Body_Code			      	:=	if(pInput.VINA_Body_Style	<>	'',pInput.VINA_Body_Style,pInput.BODY_CODE);
	self.Best_Model_Year		      	:=	if(pInput.vina_Model_Year	<>	'',pInput.vina_Model_Year,pInput.Year_Make);
	self.Best_Major_Color_Code			:=	if(	TRIM(pInput.MAJOR_COLOR_CODE)	=	'','UNK',pInput.MAJOR_COLOR_CODE);
	self.Best_Minor_Color_Code			:=	if(	TRIM(pInput.MINOR_COLOR_CODE)	=	'','UNK',pInput.MINOR_COLOR_CODE);
	self.vina_body_style_desc     	:=	if(pInput.vina_body_style_desc	<>	'',pInput.vina_body_style_desc,pInput.body_style_description);
	self.VINA_Number_Of_Cylinders		:=	if(trim(pInput.VINA_Number_Of_Cylinders,left,right) <>'',
																				 pInput.VINA_Number_Of_Cylinders,
																				 IF(pInput.number_of_cylinders<>0,
																					  (string2) pInput.number_of_cylinders,
																					  ''));
	
	SELF.ORIG_NET_WEIGHT						:= '';

	self														:=	pInput;
	self														:=	[];
end;
 
dMAMain	:=	PROJECT(dMATempMain,tReformat2Main(LEFT));

export Mapping_MA_Main 	:= dMAMain : persist('~thor_data400::persist::vehicleV2::ma_main');
