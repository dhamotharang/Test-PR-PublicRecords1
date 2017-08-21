//Copied from Infutor_Vin_as_Base
import Address,AID,codes,Lib_StringLib,standard,ut,vehlic,vehicleCodes,PromoteSupers;

	createSuperFiles := SEQUENTIAL( fileservices.startsuperfiletransaction();
																	IF(NOT FileServices.SuperFileExists('~thor_data400::base::vehiclev2::inf_nondppa_motorcycle'),
																								 FileServices.CreateSuperFile('~thor_data400::base::vehiclev2::inf_nondppa_motorcycle')),
																	IF(NOT FileServices.SuperFileExists('~thor_data400::base::vehiclev2::inf_nondppa_motorcycle'+'_father'),
																								 FileServices.CreateSuperFile('~thor_data400::base::vehiclev2::inf_nondppa_motorcycle'+'_father')),
																	fileservices.finishsuperfiletransaction()
																);

	// Infutor VIN prepped file
	dInfutorMotorcycleUpdate	:=	VehicleV2.Map_Infutor_Motorcycle_Update;
	
	dInfutorMotorcycleCombined := dInfutorMotorcycleUpdate + VehicleV2.Files.Base.Infutor_Motorcycle;
	
	//Roll up the records
	dInfutorMotorcycleCombinedDist		:=	distribute(dInfutorMotorcycleCombined,hash(state_origin,RAW_VIN));
	dInfutorMotorcycleCombinedSort		:=	sort(	dInfutorMotorcycleCombinedDist
																							,state_origin
																							,RAW_VIN
																							,RAW_YEAR_MAKE
																							,RAW_CLASS_CODE
																							,RAW_MAKE_CODE
																							,RAW_MODEL
																							,RAW_BODY_CODE
																							,RAW_FUEL_TYPE_CODE
																							,RAW_FNAME
																							,RAW_MI
																							,RAW_LNAME
																							,RAW_SUFFIX
																							,RAW_MFG_CODE
																							,RAW_MILEAGECD
																							,RAW_NBR_VEHICLES
																							,RAW_GENDER
																							,RAW_HOUSE
																							,RAW_PREDIR
																							,RAW_STREET
																							,RAW_STRTYPE
																							,RAW_POSTDIR
																							,RAW_APTTYPE
																							,RAW_APTNBR
																							,RAW_CITY
																							,RAW_STATE
																							,RAW_ZIP
																							,RAW_Z4
																							,-dt_vendor_last_reported
																							,local
																	);

	typeof(dInfutorMotorcycleCombinedSort)	tRollup(dInfutorMotorcycleCombinedSort	L,dInfutorMotorcycleCombinedSort	R)	:=
	transform
		self.dt_first_seen				    :=	ut.min2(L.dt_first_seen,R.dt_first_seen);
		self.dt_last_seen				      :=	MAX(L.dt_last_seen,R.dt_last_seen);
		self.dt_vendor_first_reported	:=	ut.min2(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
		self.dt_vendor_last_reported  :=  MAX(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		self.source_rec_id						:=  if(L.source_rec_id<>0,if(L.source_rec_id<R.source_rec_id,L.source_rec_id,R.source_rec_id),0);			
		self													:=	L;
	end;

	dInfutorMotorcycleCombinedRollup	:= rollup(dInfutorMotorcycleCombinedSort
																			,tRollup(left,right)
																							,state_origin
																							,RAW_VIN
																							,RAW_YEAR_MAKE
																							,RAW_CLASS_CODE
																							,RAW_MAKE_CODE
																							,RAW_MODEL
																							,RAW_BODY_CODE
																							,RAW_FUEL_TYPE_CODE
																							,RAW_FNAME
																							,RAW_MI
																							,RAW_LNAME
																							,RAW_SUFFIX
																							,RAW_MFG_CODE
																							,RAW_MILEAGECD
																							,RAW_NBR_VEHICLES
																							,RAW_GENDER
																							,RAW_HOUSE
																							,RAW_PREDIR
																							,RAW_STREET
																							,RAW_STRTYPE
																							,RAW_POSTDIR
																							,RAW_APTTYPE
																							,RAW_APTNBR
																							,RAW_CITY
																							,RAW_STATE
																							,RAW_ZIP
																							,RAW_Z4
																			,local
																		);
	//****** Join to VINA file and valid VIN
	// change to join on vin_input in VINA file,since that is the value in the vehicle file that is searched in VINA app.

	//Do not do vin match since we don't have vin in infutor motorcycle
	//---------------------------------------------------------------------------
	//-------APPEND AND VALIDATE VINA 
	//---------------------------------------------------------------------------
	VehicleV2.Mac_validVIN(dInfutorMotorcycleCombinedRollup,validvin_out);

	//****** Improve descriptions
	VehicleV2.MAC_Patch_Vehmain_by_codes(validvin_out,VehicleV2.Layout_Infutor_Motorcycle.Infutor_Motorcycle_as_VehicleV2,veh_vins_done)	

	//---------------------------------------------------------------------------
	//-------APPEND DESCRIPTIONS FOR CODES
	//---------------------------------------------------------------------------

	//patch descriptions from codeV3
	VehicleV2.MAC_Patch_Desc_by_codesV3(veh_vins_done,VehicleV2.Layout_Infutor_VIN.Infutor_Vin_as_VehicleV2,true,veh_patch_desc);

	VehicleV2.Layout_Infutor_Motorcycle.Infutor_Motorcycle_as_VehicleV2	tVehicleKey(veh_patch_desc	pInput)	:=
	transform
		Best_Model_Year								:=	if(pInput.vina_model_year<>'',pInput.vina_model_year,pInput.year_make);
		self.model_year 							:=	Best_Model_Year;
		
		self.vehicle_key   						:=	trim(	if(	pInput.vina_vinflag = 'T',
																								pInput.VINA_vin,
																								//if VINA takes a 17 character VIN and "converts" it to 16 characters,take the RAW_vin
																								if(	pInput.vina_vinflag='F'
																										and	length(trim(pInput.orig_vin))	=	17
																										and	length(trim(pInput.VINA_vin))	!=	17,
																										pInput.orig_vin,
                                                 (string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.raw_pid,pInput.vina_make_desc,Best_Model_Year)
																									)
																							)
																							,left,right
																						);
		
		//RAW_MAKE contains the full manufacture name
 		self.make_desc								:=	if(pInput.vina_make_desc<>'',
   		                                     pInput.vina_make_desc,
   																				 StringLib.StringToProperCase(pInput.RAW_MAKE_CODE)) ;

		
		self.vehicle_type_desc 				:=	if(pInput.vina_veh_type	<>	'',vehicleV2.getVehTypeDesc(pInput.vina_veh_type),'');
		
		self.series_desc 							:=	if(pInput.vina_series_desc	<>	'',pInput.vina_series_desc,'');	
		
		self.model_desc 							:=	pInput.vina_model_desc;
		
		self.body_style_desc 					:=	MAP(pInput.vina_body_style_desc<>'' => pInput.vina_body_style_desc,
		                                      pInput.RAW_BODY_CODE<>'' => StringLib.StringToProperCase(pInput.RAW_BODY_CODE),
		                                      pInput.RAW_CLASS_CODE<>'' => StringLib.StringToProperCase(pInput.RAW_CLASS_CODE),
																					''
																					);
		self.body_style_description		:=	TRIM(self.body_style_desc,LEFT,RIGHT);

		//Color information is not available in Infutor vendor files
		self.major_color_desc 				:=	'';
		self.minor_color_desc 				:=	'';
		self.source_rec_id 						:=  hash64(pInput.state_origin
																						,pInput.raw_vin
																						,pInput.RAW_YEAR_MAKE
																						,pInput.RAW_MAKE_CODE
																						,pInput.RAW_MODEL
																						,pInput.RAW_BODY_CODE
																						,pInput.RAW_FUEL_TYPE_CODE
																						,pInput.RAW_FNAME
																						,pInput.RAW_MI
																						,pInput.RAW_LNAME
																						,pInput.RAW_SUFFIX
																						,pInput.RAW_GENDER
																						,pInput.RAW_HOUSE
																						,pInput.RAW_STREET
																						,pInput.RAW_STRTYPE
																						,pInput.RAW_POSTDIR
																						,pInput.RAW_APTTYPE
																						,pInput.RAW_APTNBR
																						,pInput.RAW_CITY
																						,pInput.RAW_STATE
																						,pInput.RAW_ZIP
																						,pInput.RAW_Z4
																						);		
		self.REGISTRATION_EFFECTIVE_DATE := '';
		self.REGISTRATION_EXPIRATION_DATE := '';
		self													:=	pInput;
	end;

	dInfutorMotorcycleVehicleKeyProj	:=	project(veh_patch_desc,tVehicleKey(left));
	
	// output base file
	PromoteSupers.MAC_SF_BuildProcess(dInfutorMotorcycleVehicleKeyProj,'~thor_data400::base::vehiclev2::inf_nondppa_motorcycle',buildInfutorMotorcycleBase,2,,true);

	// Remove update file from OH Building superfile
	removeInfutorVinBldg			:=	sequential(	fileservices.startsuperfiletransaction(),
																						fileservices.clearsuperfile('~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_building'),
																						fileservices.finishsuperfiletransaction()
																					);

	buildInfutorMotorcycleAll					:=	sequential(createSuperFiles,buildInfutorMotorcycleBase,removeInfutorVinBldg);

 EXPORT	Infutor_Motorcycle_as_Base	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_building')	>	0,
																						buildInfutorMotorcycleAll,
																						output('Not building Infutor motorcycle base file as no new infutor motorcycle updates available')
   																);
