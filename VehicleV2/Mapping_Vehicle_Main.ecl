import lib_stringlib,vehicleV2,vehlic,VehicleCodes,codes,ut;

dVehicleTempMain	:=	VehicleV2.Mapping_TEMP_main;

// dVehicleTempMain	:=	dataset('~thor_data400::persist::vehicleV2::vehicleV1_temp_main',VehicleV2.Layout_temp_module.Layout_temp_main,flat);

VehicleV2.Layout_Base_Main tMappingMain(VehicleV2.Layout_temp_module.Layout_temp_main	L)	:=
transform
	self.State_Bitmap_Flag				:=	0;//change later
	
	self.orig_VIN									:=	L.ORIG_VIN;
	self.orig_Year								:=	L.YEAR_MAKE;
	self.orig_Make_Code						:=	L.MAKE_CODE;
	self.orig_Series_Code					:=	'';
	self.orig_Model_Code					:=	L.MODEL;
	self.orig_Body_Code						:=	L.BODY_CODE;
	self.orig_Vehicle_Type_Code		:=	VehicleV2.translate_DI_orig_vehicle_type(L.orig_vehicle_type_desc);
	self.orig_Major_Color_Code		:=	L.MAJOR_COLOR_CODE;
	self.orig_Minor_Color_Code		:=	L.MINOR_COLOR_CODE;
	self.orig_Vehicle_use_Code		:=	L.vehicle_use;
	self.orig_gross_weight        :=	L.gross_weight;
	self.Orig_Net_Weight          :=	L.Net_Weight;
  self.Orig_Number_Of_Axles     :=	if(	(unsigned6)L.Number_Of_Axles = 0,
										                    '',
										                    trim((string)(integer4)L.Number_Of_Axles,all)
																			);
	
	// Giving preference to Vina values, and there are around 250K model desc in DI data not in vina file and these vehicle keys doesnt exist in AE. 
	  
  self.VINA_Make_Desc						:=	if(trim(l.VINA_Make_Desc,left,right) <>''  ,l.VINA_Make_Desc,L.make_description);
	self.VINA_Model_Desc					:=	if(trim(l.VINA_Model_Desc,left,right) <>'' ,l.VINA_Model_Desc,L.model_description);
	self.VINA_Series_Desc					:=	if(trim(l.VINA_Series_Desc,left,right)<>'' ,l.VINA_Series_Desc,L.series_description);
	self.VINA_Engine_Size					:=	if(trim(l.VINA_Engine_Size,left,right)<>'' ,l.VINA_Engine_Size,L.engine_size);
	self.VINA_Fuel_Code						:=	if(trim(l.VINA_Fuel_Code,left,right)  <>'' ,l.VINA_Fuel_Code,L.fuel_code);
	self.VINA_Model_Year					:=	if(trim(l.Vina_model_year,left,right) <>'', l.vina_model_year, L.model_year);
	self.VINA_Number_Of_Cylinders	:=	if(trim(l.VINA_Number_Of_Cylinders,left,right) <>'',l.VINA_Number_Of_Cylinders, L.number_of_cylinders);
 	self.vina_body_style_desc			:=	map(trim(L.vina_body_style_desc,left,right)	<>	'' => L.vina_body_style_desc,
																					trim(L.body_style_description,left,right) <> ''  => l.body_style_description,L.orig_body_desc
																				    );
	//Added for CCPA-103
	// self.global_sid               := 0;
	// self.record_sid               := 0;
																						
	self													:=	L;
	self := [] ;//blank all experian new fields.
end;

dMappingMain	:=	project(dVehicleTempMain,tMappingMain(left));

export	Mapping_Vehicle_Main	:=	dMappingMain	:	persist('~thor_data400::persist::vehiclev2::vehiclev1_main');