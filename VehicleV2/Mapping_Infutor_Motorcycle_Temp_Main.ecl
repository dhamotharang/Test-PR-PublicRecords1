//Copied from VehicleV2.Mapping_OH_Temp_Main
import ut,VehicleV2;

// Infutor Vin Vehicle base file
dInfutorMotorcycleBase							:=	VehicleV2.Files.Base.Infutor_Motorcycle;

dInfutorMotorcycleBaseDist					:=	distribute(dInfutorMotorcycleBase,hash(vehicle_key));
dInfutorMotorcycleBaseSort					:=	sort(	dInfutorMotorcycleBaseDist,
																							vehicle_key,
																							state_origin,
																							source_code,
																							RAW_VIN ,
																							model_year ,
																							make_desc ,
																							series_desc,
																							VEHICLE_TYPE_desc,
																							MODEL_desc,
																							body_style_desc,
																							-dt_vendor_first_reported,
																							//-REGISTRATION_EFFECTIVE_DATE ,
																							//-REGISTRATION_expiration_DATE,
																							local
																						);
		 
dInfutorMotorcycleBaseDedup				:=	dedup(	dInfutorMotorcycleBaseSort,
																							vehicle_key,
																							state_origin,
																							source_code,
																							RAW_VIN ,
																							model_year ,
																							make_desc ,
																							series_desc,
																							VEHICLE_TYPE_desc,
																							MODEL_desc,
																							body_style_desc,
																							local
																						);

	// Append temporary iteration key
	rInfutorMotorcycleTemp_layout	:= 	RECORD
		VehicleV2.Layout_Infutor_Motorcycle.Infutor_Motorcycle_as_VehicleV2;
		string15	Iteration_Key_Temp	:=	'';
	end;

	dInfutorMotorcycleAppendTempIterationKey	:=	project(dInfutorMotorcycleBaseDedup,rInfutorMotorcycleTemp_layout);

	// Generate iteration key
	rInfutorMotorcycleTemp_layout	iterationkey1(dInfutorMotorcycleAppendTempIterationKey	L,dInfutorMotorcycleAppendTempIterationKey	R)	:=
	TRANSFORM
		SELF.REGISTRATION_EFFECTIVE_DATE	:=	'';			//Not provided by vendor
		SELF.REGISTRATION_EXPIRATION_DATE	:=	'';			//Not provided by vendor

		self.dt_first_seen 								:=	if(	L.vehicle_key	=	R.vehicle_key,
																							if(	L.dt_first_seen	<>	R.dt_first_seen,
																									R.dt_first_seen,
																									0
																								),
																							R.dt_first_seen
																						);

		self.dt_vendor_first_reported 		:=	if(	L.vehicle_key	=	R.vehicle_key,
																							if(	L.dt_vendor_first_reported	<>	R.dt_vendor_first_reported,
																									R.dt_vendor_first_reported,
																									0
																								),
																							R.dt_vendor_first_reported
																						);

		self.iteration_key_temp 					:=	trim(	MAP(	//self.REGISTRATION_EFFECTIVE_DATE	<>	''	or	self.REGISTRATION_expiration_DATE	<>	''	=>	validate_date.fEarliestNonZeroDate(self.REGISTRATION_EFFECTIVE_DATE,self.REGISTRATION_expiration_DATE),
																											self.dt_first_seen								<>	0		or	self.dt_vendor_first_reported			<>	0		=>	validate_date.fEarliestNonZeroDate((string8)self.dt_first_seen,(string8)self.dt_vendor_first_reported),
																											//self.TITLE_ISSUE_DATE							<>	''																								=> self.TITLE_ISSUE_DATE,
																											(string8)R.dt_vendor_last_reported
																										),
																								all
																							)	+	R.state_origin	+	R.source_code;
		self															:=	R;
	end;

	dInfutorMotorcycleMainIterate1 :=	iterate(sort(	dInfutorMotorcycleAppendTempIterationKey,
																						vehicle_key,
																						-dt_vendor_first_reported,
																						local
																					),
																			iterationkey1(left,right),
																			local
																		 );

	dInfutorMotorcycleMainIterate1Sort 	:=	sort(	dInfutorMotorcycleMainIterate1,
																								vehicle_key,
																								-iteration_key_temp,
																								-dt_vendor_first_reported,
																								local
																							);

	rInfutorMotorcycleTemp_layout	iterationkey2(dInfutorMotorcycleMainIterate1Sort	L,dInfutorMotorcycleMainIterate1Sort	R)	:=
	transform
		self.iteration_key	:=	if(	L.vehicle_key	=	R.vehicle_key	and	L.iteration_key_temp	=	r.iteration_key_temp,
																MAP(	L.iteration_key_temp						<>	R.iteration_key_temp						and	R.iteration_key_temp						!=	''	=>	R.iteration_key_temp						+	R.state_origin	+	R.source_code,
																			//L.REGISTRATION_EFFECTIVE_DATE		<>	R.REGISTRATION_EFFECTIVE_DATE		and	R.REGISTRATION_EFFECTIVE_DATE		!=	''	=>	R.REGISTRATION_EFFECTIVE_DATE		+ R.state_origin	+	R.source_code,
																			L.dt_first_seen									<>	R.dt_first_seen									and	R.dt_first_seen									!=	0		=>	R.dt_first_seen									+	R.state_origin	+	R.source_code,
																			//L.TITLE_ISSUE_DATE							<>	R.TITLE_ISSUE_DATE							and	R.TITLE_ISSUE_DATE							!=	''	=>	R.TITLE_ISSUE_DATE							+	R.state_origin	+	R.source_code,			
																			L.dt_vendor_first_reported			<>	R.dt_vendor_first_reported			and	R.dt_vendor_first_reported			!=	0		=>	R.dt_vendor_first_reported			+	R.state_origin	+	R.source_code,		
																			L.dt_vendor_last_reported				<>	R.dt_vendor_last_reported				and	R.dt_vendor_last_reported				!=	0		=>	R.dt_vendor_last_reported				+	R.state_origin	+	R.source_code,
																			L.REGISTRATION_expiration_DATE	<>	R.REGISTRATION_expiration_DATE	and	R.REGISTRATION_expiration_DATE	!=	''	=>	R.REGISTRATION_expiration_DATE	+	R.state_origin	+	R.source_code,
																			(string8)R.dt_vendor_last_reported
																		),
																			R.iteration_key_temp
															);
		self								:=	R;
	end;

	//Use group with iterate. Code review comment
	dInfutorMotorcycleMainIterate2	:=	ungroup(iterate(group(dInfutorMotorcycleMainIterate1Sort,
																														vehicle_key,
																														iteration_key_temp,
																														dt_vendor_first_reported),
																											iterationkey2(left,right)));

	dInfutorMotorcycleTempMain	:=	project(dInfutorMotorcycleMainIterate2,VehicleV2.Layout_Infutor_Vin.Infutor_Vin_as_VehicleV2);

	export Mapping_Infutor_Motorcycle_Temp_Main 	:= dInfutorMotorcycleTempMain	:	persist('~thor_data400::persist::vehicleV2::inf_nondppa_motorcycle_temp_main');
