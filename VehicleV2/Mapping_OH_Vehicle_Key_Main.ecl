import ut,Vehlic, vehicleV2, VehicleCodes, Codes;

veh_in := VehicleV2.Mapping_OH_Temp_Main;

// generate vehicle_key 

VehicleV2.Layout_OH_Temp_Module.Layout_OH_as_VehicleV2 taddkeys(veh_in L) := transform

		//STRING5 Best_Make_Code			:= IF(L.vina_NCIC_Make<>'',L.vina_NCIC_Make,	L.MAKE_CODE);
		STRING4 Best_Model_Year		  := IF(L.vina_Model_Year<>'',L.vina_Model_Year,L.Year_Make);
		self.vehicle_key   					:= trim(if(L.vina_vinflag = 'T', L.VINA_vin, 
																		//if VINA takes a 17 character VIN and "converts" it to 16 characters, take the orig_vin
																		if(l.vina_vinflag='F' and length(trim(l.orig_vin))=17 and length(trim(l.VINA_vin))!= 17,l.orig_vin,
																		if(L.orig_vin[1..4] in ['', 'NONE', 'HMDE','HOME','UNK', 'N0NE', 'UNKN'] or StringLib.StringFilterOut(L.orig_vin, '0|*') = '' 
																		or regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|VEHICLE|UNKNOWN|UNKOWN|UNK0WN|NUMBER', L.orig_vin) or L.orig_vin in ['N/A', 'N', 'NR', 'NA', 'ASPT', '01', 'SPCN', 'O', 'NO VIN', 'UKN'],  
																		(string30)hash64(L.state_origin,L.orig_vin,L.TITLE_NUMBERxBG9,L.vina_make_desc, Best_Model_Year	,L.LICENSE_PLATE_NUMBERxBG4), 
																		(string30)hash64(L.state_origin, L.orig_vin, L.vina_make_desc, Best_Model_Year	)))),left,right);
					
	  orig_veh_type_code 					:= VehicleV2.translate_DI_orig_vehicle_type(L.orig_vehicle_type_desc);
		best_major_color_desc 			:= VehicleCodes.getColor(L.best_Major_Color_Code);
		best_minor_color_desc 			:= VehicleCodes.getColor(L.best_Minor_Color_Code);
		
		
		/*
		model_year 									:= map(L.vina_model_year <> '' => L.vina_model_year,
																				L.Model_Year<>'' => L.Model_Year,
																				L.Best_Model_Year<>'' => L.Best_Model_Year,
																				L.Year_make);																
		*/
		model_year 									:= IF(L.vina_model_year <> '' , L.vina_model_year, '');
		self.model_year 						:= model_year;
		
		/*
		make_descrip 								:= IF(L.make_description <> '',L.make_description , L.vina_make_desc) ;
		*/
		make_descrip 								:= IF(L.vina_make_desc <> '',L.vina_make_desc, '') ;
		self.make_desc 							:= if( stringlib.StringToUpperCase(make_descrip) = stringlib.StringToUpperCase(L.make_desc)[1..length(trim(make_descrip))] or L.make_desc = '',make_descrip, '');
	
		/*
		self.vehicle_type_desc 			:= IF(orig_veh_type_code <> '', vehicleV2.getVehTypeDesc(orig_veh_type_code),   vehicleV2.getVehTypeDesc(L.vina_veh_type));
		*/
		
		self.vehicle_type_desc 			:= IF(L.vina_veh_type <> '', vehicleV2.getVehTypeDesc(L.vina_veh_type), '');
		/*
		self.series_desc 						:= IF(L.series_desc <> '', L.series_desc, L.vina_series_desc);
		*/
		self.series_desc 						:= IF(L.vina_series_desc <> '', L.vina_series_desc, '');	
		
		/*
		model_descrip 							:= IF(L.model_description <> '', L.model_description, L.vina_model_desc);
		*/
		model_descrip 							:= IF(L.vina_model_desc <> '', L.vina_model_desc, '');
		self.model_desc 						:= if( stringlib.StringToUpperCase(model_descrip)[1..length(l.model_desc)] = stringlib.StringToUpperCase(l.model_desc) or l.model_desc='',model_descrip,'');
		
		/*
		self.body_style_desc 				:= IF(L.body_style_description <> '', L.body_style_description, L.vina_body_style_desc);
		*/
		self.body_style_desc 				:= IF(L.vina_body_style_desc <> '', L.vina_body_style_desc, '');
		
		self.major_color_desc 			:= best_major_color_desc;
		self.minor_color_desc 			:= best_minor_color_desc;
		self.orig_vehicle_use_desc 	:= L.orig_vehicle_use_Desc;
		
		self := L;
		
end;

		
veh_main_pro  := project(veh_in, taddkeys(left));

export Mapping_OH_Vehicle_Key_Main := veh_main_pro:persist('~thor_data400::persist::OH_Temp_Main_VehicleKey');  