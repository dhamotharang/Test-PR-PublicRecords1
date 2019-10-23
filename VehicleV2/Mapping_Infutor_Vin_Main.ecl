import ut,VehicleV2,VehicleCodes/*,CODES,vehlic*/;

//---------------------------------------------------------------------------
//-------MAP to BASE MAIN FORMAT LAYOUT
//---------------------------------------------------------------------------

// OH vehicle temp main file
dInfutorVinTempMain	:=	VehicleV2.Mapping_Infutor_Vin_Temp_Main;
// output(sample(dInfutorVinTempMain,100,1),,named('dInfutorVinTempMain'));
// output('dInfutorVinBase cnt='+count(dInfutorVinTempMain));
//Map class code to vehicle type. Sorry last minute change and this is the easiest way to fix the problem.
string1 Infutor_Vehicle_Type_Mapping(string class_code) := 
				CASE(TRIM(class_code),
						 'SMALL CAR' 				=> 'P',
						 'MID SIZE CAR'			=> 'P',
						 'FULL SIZE SUV'		=> 'P',
						 'FULL SIZE TRUCK'	=> 'T',
						 'SMALL SUV'				=> 'P',
						 'FULL SIZE CAR'		=> 'P',
						 'MINIVAN'					=> 'P',
						 'CROSSOVER'				=> 'P',
						 'SMALL TRUCK'			=> 'L',
						 'MID SIZE TRUCK'		=> 'T',
						 'FULL SIZE VAN'		=> 'P',
						 'FULL SIZE'				=> 'U',
						 'U');

// Map to the base vehiclev2 main layout
VehicleV2.Layout_Base_Main tReformat2Main(dInfutorVinTempMain	pInput)	:=
transform
	
	self.State_BitMAP_Flag 					:=	0; //update later
	self.orig_Year									:=	pInput.YEAR_MAKE;
	self.orig_Make_Code							:=	pInput.make_code;
	self.orig_Make_Desc							:=	StringLib.StringToUpperCase(VehicleCodes.getMake(pInput.state_origin,pInput.Make_code));
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
	self.Orig_Vehicle_Type_Code			:=	Infutor_Vehicle_Type_Mapping(pInput.raw_class_code);
	self.Orig_Vehicle_Type_Desc			:=	VehicleV2.getVehTypeDesc(self.Orig_Vehicle_Type_Code);
	self.orig_major_color_code			:=	pInput.major_color_code;
	self.Orig_Major_Color_Desc			:=	pInput.major_color_desc;
	self.Orig_Minor_Color_Code			:=	pInput.minor_color_code;
	self.Orig_Minor_Color_Desc			:=	pInput.minor_color_desc;
	self.Best_Make_Code			      	:=	if(pInput.vina_NCIC_Make<>'',pInput.vina_NCIC_Make,	pInput.MAKE_CODE);
	self.Best_Series_Code		      	:=	if(pInput.VINA_Series<>'',pInput.VINA_Series,'');
	self.Best_Model_Code		      	:=	pInput.VINA_Model;
	self.Best_Body_Code			      	:=	if(pInput.VINA_Body_Style	<>	'',pInput.VINA_Body_Style,pInput.BODY_CODE);
	self.Best_Model_Year		      	:=	if(pInput.vina_Model_Year	<>	'',pInput.vina_Model_Year,pInput.Year_Make);
	self.Best_Major_Color_Code			:=	if(	TRIM(pInput.MAJOR_COLOR_CODE)	=	'','UNK',pInput.MAJOR_COLOR_CODE);
	self.Best_Minor_Color_Code			:=	if(	TRIM(pInput.MINOR_COLOR_CODE)	=	'','UNK',pInput.MINOR_COLOR_CODE);
	self.vina_body_style_desc     	:=	if(pInput.vina_body_style_desc<>'',
	                                       pInput.vina_body_style_desc,
																				 pInput.body_style_description);
	
	//Added for CCPA-103
	// self.global_sid                 := 0;
	// self.record_sid                 := 0;
	self														:=	pInput;
	self														:=	[];
end;
 
dInfutorVinMain	:=	PROJECT(dInfutorVinTempMain,tReformat2Main(LEFT));

export Mapping_Infutor_Vin_Main 	:= dInfutorVinMain : persist('~thor_data400::persist::vehicleV2::inf_nondppa_vin_main');