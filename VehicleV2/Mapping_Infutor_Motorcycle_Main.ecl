import ut,VehicleV2,VehicleCodes;

//---------------------------------------------------------------------------
//-------MAP to BASE MAIN FORMAT LAYOUT
//---------------------------------------------------------------------------

dInfutorMotorcycleTempMain	:=	VehicleV2.Mapping_Infutor_Motorcycle_Temp_Main;

// Map to the base vehiclev2 main layout
VehicleV2.Layout_Base_Main tReformat2Main(dInfutorMotorcycleTempMain	pInput)	:=
transform
	
	self.State_BitMAP_Flag 					:=	0; //update later
	self.orig_Year									:=	pInput.YEAR_MAKE;
	self.orig_Make_Code							:=	pInput.make_code;
	self.orig_Make_Desc							:=	IF(VehicleCodes.getMake(pInput.state_origin,pInput.Make_code)='',
	                                       pInput.make_desc,
	                                       StringLib.StringToUpperCase(VehicleCodes.getMake(pInput.state_origin,pInput.Make_code)));
	self.orig_Series_Code						:=	'';
	self.orig_Series_Desc						:=	'';
	self.orig_Model_Code						:=	'';			
	self.orig_Body_Code							:=	pInput.Body_Code;
	self.orig_Body_Desc							:=	pInput.RAW_Body_Code;					//provided in vendor file
	self.Orig_Net_Weight						:=	'';
	self.Orig_Gross_Weight					:=	'';
	self.Orig_Number_Of_Axles				:=	'';
	self.Orig_Vehicle_Use_code			:=	'';
	self.Orig_Vehicle_Use_Desc			:=	'';
	self.Orig_Vehicle_Type_Code			:=	'M';
	self.Orig_Vehicle_Type_Desc			:=	'MOTORCYCLE';
	self.orig_major_color_code			:=	pInput.major_color_code;
	self.Orig_Major_Color_Desc			:=	pInput.major_color_desc;
	self.Orig_Minor_Color_Code			:=	pInput.minor_color_code;
	self.Orig_Minor_Color_Desc			:=	pInput.minor_color_desc;
	self.Best_Make_Code			      	:=	if(pInput.vina_NCIC_Make<>'',pInput.vina_NCIC_Make,	pInput.MAKE_CODE);
	self.Best_Series_Code		      	:=	if(pInput.VINA_Series<>'',pInput.VINA_Series,'');
	self.Best_Model_Code		      	:=	pInput.VINA_Model;
	self.Best_Body_Code			      	:=	if(pInput.VINA_Body_Style	<>	'',pInput.VINA_Body_Style,pInput.BODY_CODE);
	self.Best_Model_Year		      	:=	if(pInput.vina_Model_Year	<>	'',pInput.vina_Model_Year,pInput.Year_Make);
	self.Best_Major_Color_Code			:=	'UNK';
	self.Best_Minor_Color_Code			:=	'UNK';
	self.vina_body_style_desc     	:=	if(pInput.vina_body_style_desc<>'',
	                                       pInput.vina_body_style_desc,
																				 pInput.body_style_description);
	
	//Added for CCPA-103
	// self.global_sid                 := 0;
	// self.record_sid                 := 0;
	self														:=	pInput;
	self														:=	[];
end;
 
dInfutorMotorcycleMain	:=	PROJECT(dInfutorMotorcycleTempMain,tReformat2Main(LEFT));

EXPORT Mapping_Infutor_Motorcycle_Main 	:= dInfutorMotorcycleMain : persist('~thor_data400::persist::vehiclev2::inf_nondppa_motorcycle_main');
