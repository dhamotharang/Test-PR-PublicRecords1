//---------------------------------------------------------------------------
//-------GENERATE ITERATION KEY USING: 
//  (REGISTRATION_EFFECTIVE_DATE OR REGISTRATION_expiration_DATE OR TITLE_ISSUE_DATE OR dt_vendor_first_reported) 
//  + state_origin 
// 	+ source_code
//---------------------------------------------------------------------------


import ut,Vehlic, vehicleV2, VehicleCodes, Codes;

veh_main_pro := VehicleV2.Mapping_OH_Vehicle_Key_Main;
		
veh_main_dist := distribute(veh_main_pro, hash(vehicle_key));

veh_main_sort := sort(veh_main_dist,
				vehicle_key,
				state_origin,
				source_code,
				ORIG_VIN ,
				model_year ,
				make_desc ,
				series_desc,
				VEHICLE_TYPE_desc,
				MODEL_desc,
				body_style_desc,
				Net_Weight,
				Number_Of_Axles,
				MAJOR_COLOR_desc,
				MINOR_COLOR_desc, 
			-dt_vendor_first_reported,
      -REGISTRATION_EFFECTIVE_DATE ,
	    -REGISTRATION_expiration_DATE,
      -TITLE_ISSUE_DATE ,
     local);
		 
veh_main_dedup := dedup(veh_main_sort,
      vehicle_key,
      state_origin,
      source_code,
      ORIG_VIN ,
			model_year ,
      make_desc ,
			series_desc,
      VEHICLE_TYPE_desc,
      MODEL_desc,
      body_style_desc,
			Net_Weight,
			Number_Of_Axles,
      MAJOR_COLOR_desc,
      MINOR_COLOR_desc,
	 local);

veh_main_dedup iterationkey1(veh_main_dedup L, veh_main_dedup R) := transform

		self.REGISTRATION_EFFECTIVE_DATE 	:= if(L.vehicle_key = R.vehicle_key,if((unsigned6)L.REGISTRATION_EFFECTIVE_DATE <> (unsigned6)R.REGISTRATION_EFFECTIVE_DATE,
		R.REGISTRATION_EFFECTIVE_DATE, ''), R.REGISTRATION_EFFECTIVE_DATE);

		self.REGISTRATION_expiration_DATE := if(L.vehicle_key = R.vehicle_key,if((unsigned6)L.REGISTRATION_expiration_DATE <> (unsigned6)R.REGISTRATION_expiration_DATE,
		R.REGISTRATION_expiration_DATE, ''), R.REGISTRATION_expiration_DATE);

		self.TITLE_ISSUE_DATE 						:= if(L.vehicle_key = R.vehicle_key,if((unsigned6)L.TITLE_ISSUE_DATE <> (unsigned6)R.TITLE_ISSUE_DATE,
		R.TITLE_ISSUE_DATE, ''), R.TITLE_ISSUE_DATE);

		self.dt_first_seen 								:= if(L.vehicle_key = R.vehicle_key,if(L.dt_first_seen <> R.dt_first_seen,
		R.dt_first_seen, ''), R.dt_first_seen);

		self.dt_vendor_first_reported 		:= IF(L.vehicle_key = R.vehicle_key,if(L.dt_vendor_first_reported <> R.dt_vendor_first_reported,
		R.dt_vendor_first_reported,''), R.dt_vendor_first_reported);

/*
		self.iteration_key_temp 					:= trim(if(self.REGISTRATION_EFFECTIVE_DATE <> '' or self.TITLE_ISSUE_DATE <> '' or self.REGISTRATION_expiration_DATE <> '', 
		validate_date.fEarliestNonZeroDate(validate_date.fEarliestNonZeroDate(self.REGISTRATION_EFFECTIVE_DATE,self.TITLE_ISSUE_DATE),self.REGISTRATION_expiration_DATE), 
		validate_date.fEarliestNonZeroDate(self.dt_first_seen, self.dt_vendor_first_reported)), all) + R.state_origin + R.source_code;
*/

		self.iteration_key_temp 					:= trim(MAP(self.REGISTRATION_EFFECTIVE_DATE <> '' or self.REGISTRATION_expiration_DATE <> ''  =>
			validate_date.fEarliestNonZeroDate(self.REGISTRATION_EFFECTIVE_DATE,self.REGISTRATION_expiration_DATE),
		self.dt_first_seen <> '' OR self.dt_vendor_first_reported <> ''  => 
			validate_date.fEarliestNonZeroDate(self.dt_first_seen, self.dt_vendor_first_reported),
		self.TITLE_ISSUE_DATE <> '' => self.TITLE_ISSUE_DATE,
		R.dt_vendor_last_reported), all) + R.state_origin + R.source_code;
		SELF := R;
end;

/*
main_iterate1 			:= iterate(sort(veh_main_dedup,vehicle_key,dt_vendor_first_reported, TITLE_ISSUE_DATE),iterationkey1(left, right), local);
*/

main_iterate1 			:= iterate(sort(veh_main_dedup,vehicle_key,-dt_vendor_first_reported, -REGISTRATION_EFFECTIVE_DATE),iterationkey1(left, right), local);

main_iterate1_sort 	:= sort(main_iterate1, vehicle_key, -iteration_key_temp, -dt_vendor_first_reported,-TITLE_ISSUE_DATE, local);

main_iterate1_sort iterationkey2(main_iterate1_sort L, main_iterate1_sort R) := transform

	/*
	self.iteration_key := if(L.vehicle_key = R.vehicle_key and L.iteration_key_temp = r.iteration_key_temp, if(L.dt_vendor_first_reported <> R.dt_vendor_first_reported and R.dt_vendor_first_reported != '', R.dt_vendor_first_reported + R.state_origin + R.source_code,
	R.dt_vendor_last_reported + R.state_origin + R.source_code), R.iteration_key_temp );
*/

	self.iteration_key := if(L.vehicle_key = R.vehicle_key and L.iteration_key_temp = r.iteration_key_temp, 
					MAP(L.iteration_key_temp <> R.iteration_key_temp and R.iteration_key_temp != ''=> R.iteration_key_temp + R.state_origin + R.source_code,
							L.REGISTRATION_EFFECTIVE_DATE <> R.REGISTRATION_EFFECTIVE_DATE and R.REGISTRATION_EFFECTIVE_DATE != '' => R.REGISTRATION_EFFECTIVE_DATE + R.state_origin + R.source_code,
							L.dt_first_seen <> R.dt_first_seen and R.dt_first_seen != ''=> R.dt_first_seen + R.state_origin + R.source_code,	
							L.TITLE_ISSUE_DATE <> R.TITLE_ISSUE_DATE and R.TITLE_ISSUE_DATE != '' => R.TITLE_ISSUE_DATE + R.state_origin + R.source_code,			
							L.dt_vendor_first_reported <> R.dt_vendor_first_reported and R.dt_vendor_first_reported != ''=> R.dt_vendor_first_reported + R.state_origin + R.source_code,		
							L.dt_vendor_last_reported <> R.dt_vendor_last_reported and R.dt_vendor_last_reported != ''=> R.dt_vendor_last_reported + R.state_origin + R.source_code,
							L.REGISTRATION_expiration_DATE <> R.REGISTRATION_expiration_DATE and R.REGISTRATION_expiration_DATE != '' => R.REGISTRATION_expiration_DATE + R.state_origin + R.source_code, R.dt_vendor_last_reported), 
							R.iteration_key_temp);
self := R;

end;

main_iterate2 := iterate(main_iterate1_sort,iterationkey2(left, right), local);

export Mapping_OH_Iteration_Key_main := main_iterate2:persist('~thor_data400::persist::OH_Temp_Main_IterationKey');  

//export mapping_TEMP_main := main_iterate2;


