//Copied from Infutor_Vin_as_Base
import Address,AID,codes,Lib_StringLib,standard,ut,vehlic,vehicleCodes;

	base_superfile_name				:= '~thor_data400::base::vehiclev2::direct::ma';
	//Build from MA prepped file
	dMAUpdate									:=	VehicleV2.Map_MA_Update;
	//dMAUpdate := dataset('~thor_data400::persist::vehiclev2::ma_update__p4132599704',vehiclev2.layout_ma.MA_as_VehicleV2,thor);
	
	//dMACombined								:= dMAUpdate + VehicleV2.Files.Base.MA;
	dMACombined								:= dMAUpdate;			//Use this line when there is no base file	
 
	//Roll up the records
	dMACombinedDist						:=	distribute(dMACombined,hash(state_origin,orig_vin));
	dMACombinedSort						:=	sort(dMACombinedDist
																		,state_origin
																		,ORIG_VIN
																		,RAW_VEH_YRMFGR
																		,MAKE_CODE
																		,MODEL_DESC
																		,BODY_CODE
																		,MAJOR_COLOR_CODE                 
																		,MINOR_COLOR_CODE
																		,RAW_TITLE_PREFIX
																		,RAW_TITLE_NUMBER
																		,RAW_VEHMAIL_STREET1
																		,RAW_VEHMAIL_STREET2
																		,RAW_VEHMAIL_CITY
																		,RAW_VEHMAIL_STATE
																		,RAW_VEHMAIL_ZIP
																		,RAW_OWNER1_LIC_NUM
																		,RAW_OWNER1_LNAME
																		,RAW_OWNER1_FNAME
																		,RAW_OWNER1_MNAME
																		,RAW_OWNER1_MAIL_STREET1
																		,RAW_OWNER1_MAIL_STREET2
																		,RAW_OWNER1_MAIL_CITY
																		,RAW_OWNER1_MAIL_STATE
																		,RAW_OWNER1_MAIL_ZIP
																		,RAW_OWNER2_LIC_NUM
																		,RAW_OWNER2_LNAME
																		,RAW_OWNER2_FNAME
																		,RAW_OWNER2_MNAME
																		,RAW_OWNER2_MAIL_STREET1
																		,RAW_OWNER2_MAIL_STREET2
																		,RAW_OWNER2_MAIL_CITY
																		,RAW_OWNER2_MAIL_STATE
																		,RAW_OWNER2_MAIL_ZIP
																		,-dt_vendor_LAST_reported
																		,local
																	);

	typeof(dMACombinedSort)	tRollup(dMACombinedSort	L,dMACombinedSort	R)	:=
	transform
		self.dt_first_seen				    :=	ut.min2(L.dt_first_seen,R.dt_first_seen);
		self.dt_last_seen				      :=	ut.max2(L.dt_last_seen,R.dt_last_seen);
		self.dt_vendor_first_reported	:=	ut.min2(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
		self.dt_vendor_last_reported  :=  ut.max2(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		self.source_rec_id						:=  if(L.source_rec_id<>0,if(L.source_rec_id<R.source_rec_id,L.source_rec_id,R.source_rec_id),0);			
		self													:=	L;
	end;

	dMACombinedRollup					:= rollup(dMACombinedSort
																			,tRollup(left,right)
																			,state_origin
																			,ORIG_VIN
																			,RAW_VEH_YRMFGR
																			,MAKE_CODE
																			,MODEL_DESC
																			,BODY_CODE
																			,MAJOR_COLOR_CODE                 
																			,MINOR_COLOR_CODE
																			,RAW_TITLE_PREFIX
																			,RAW_TITLE_NUMBER
																			,RAW_VEHMAIL_STREET1
																			,RAW_VEHMAIL_STREET2
																			,RAW_VEHMAIL_CITY
																			,RAW_VEHMAIL_STATE
																			,RAW_VEHMAIL_ZIP
																			,RAW_OWNER1_LIC_NUM
																			,RAW_OWNER1_LNAME
																			,RAW_OWNER1_FNAME
																			,RAW_OWNER1_MNAME
																			,RAW_OWNER1_MAIL_STREET1
																			,RAW_OWNER1_MAIL_STREET2
																			,RAW_OWNER1_MAIL_CITY
																			,RAW_OWNER1_MAIL_STATE
																			,RAW_OWNER1_MAIL_ZIP
																			,RAW_OWNER2_LIC_NUM
																			,RAW_OWNER2_LNAME
																			,RAW_OWNER2_FNAME
																			,RAW_OWNER2_MNAME
																			,RAW_OWNER2_MAIL_STREET1
																			,RAW_OWNER2_MAIL_STREET2
																			,RAW_OWNER2_MAIL_CITY
																			,RAW_OWNER2_MAIL_STATE
																			,RAW_OWNER2_MAIL_ZIP
																			,local
																		);
	o01 := output(dMACombinedRollup,,named('dMACombinedRollup'));
	
	//****** Join to VINA file and valid VIN
	// change to join on vin_input in VINA file,since that is the value in the vehicle file that is searched in VINA app.
	//---------------------------------------------------------------------------
	//-------APPEND AND VALIDATE VINA 
	//---------------------------------------------------------------------------
	VehicleV2.Mac_validVIN(dMACombinedRollup,validvin_out);
	o02 := output(validvin_out,,named('validvin_out'));

	//****** Improve descriptions
	VehicleV2.MAC_Patch_Vehmain_by_codes(validvin_out,VehicleV2.Layout_MA.MA_as_VehicleV2,veh_vins_done)	
	o03 := output(veh_vins_done,,named('veh_vins_done'));

	//---------------------------------------------------------------------------
	//-------APPEND DESCRIPTIONS FOR CODES
	//---------------------------------------------------------------------------

	//patch descriptions from codeV3
	VehicleV2.MAC_Patch_Desc_by_codesV3(veh_vins_done,VehicleV2.Layout_MA.MA_as_VehicleV2,true,veh_patch_desc);
	o04 := output(veh_patch_desc,,named('veh_patch_desc'));
	
	VehicleV2.Layout_MA.MA_as_VehicleV2	tVehicleKey(veh_patch_desc	pInput)	:=
	transform
		Best_Model_Year								:=	if(pInput.vina_model_year<>'',pInput.vina_model_year,pInput.YEAR_MAKE);
		self.model_year 							:=	Best_Model_Year;
		
		self.vehicle_key   						:=	trim(	if(	pInput.vina_vinflag = 'T'	and	pInput.vina_body_style not in  ['IC'],
																								pInput.VINA_vin,
																								if(	pInput.vina_vinflag = 'T' and pInput.vina_body_style in  ['IC'],
																										pInput.orig_vin,
																									  //if VINA takes a 17 character VIN and "converts" it to 16 characters,take the RAW_vin
																										if(			pInput.vina_vinflag='F'
																												and	length(trim(pInput.orig_vin))	=	17
																												and	length(trim(pInput.VINA_vin))	!=	17,
																												pInput.orig_vin,
																												if(			pInput.orig_vin[1..4]	in	['','NONE','HMDE','HOME','UNK','N0NE','UNKN']
																														or	StringLib.StringFilterOut(pInput.orig_vin,'0|*')	=	''
																														or	regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|vehicle|UNKNOWN|UNKOWN|UNK0WN|NUMBER',pInput.orig_vin)
																														or	pInput.orig_vin in ['N/A','N','NR','NA','ASPT','01','SPCN','O','NO VIN','UKN'],  
																														(string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.TITLE_NUMBER,pInput.vina_make_desc,pInput.year_make), 
																														(string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.vina_make_desc,pInput.year_make)
																													)
																											)
																									 )
																							)
																							,left,right
																						);
	
		self.orig_make_code						:=	pInput.MAKE_CODE;
		self.make_desc								:=	if(pInput.vina_make_desc<>'',pInput.vina_make_desc,'') ;

		self.vehicle_type_desc 				:=	if(pInput.vina_veh_type	<>'',vehicleV2.getVehTypeDesc(pInput.vina_veh_type),'');
		
		self.series_desc 							:=	if(pInput.vina_series_desc<>'',pInput.vina_series_desc,'');	
		
		self.model_desc 							:=	if(pInput.vina_model_desc	<>'', pInput.vina_model_desc, '');
		
		self.body_style_desc 					:=	if(pInput.vina_body_style_desc	<>	'',pInput.vina_body_style_desc,'');

	 //set up color
		SELF.orig_Major_Color_Code		:=	pInput.MAJOR_COLOR_CODE;
		SELF.orig_Minor_Color_Code		:=	pInput.MINOR_COLOR_CODE;
		self.Best_Major_Color_Code	  := 	pInput.MAJOR_COLOR_CODE;
		self.Best_Minor_Color_Code	  := 	pInput.MINOR_COLOR_CODE;
																					
		self.major_color_desc 				:=	pInput.orig_Major_Color_Desc;
		self.minor_color_desc 				:=	pInput.orig_Minor_Color_Desc;
		
		self.source_rec_id 						:=  hash64(pInput.state_origin
																						,pInput.orig_vin
																						,pInput.YEAR_MAKE
																						,pInput.MAKE_CODE
																						,pInput.BODY_CODE
																						,pInput.MODEL_DESC
																						,pInput.MAJOR_COLOR_CODE
																						,pInput.MINOR_COLOR_CODE
																						,pInput.body_style_description
																						,pInput.REGISTRATION_EFFECTIVE_DATE
																						,pInput.REGISTRATION_EXPIRATION_DATE
																						,pInput.REGISTRATION_ISSUE_DATE
																						,pInput.TITLE_NUMBER
																						,pInput.true_license_plste_number
																						,pInput.RAW_VEHMAIL_STREET1
																						,pInput.RAW_VEHMAIL_STREET2
																						,pInput.RAW_VEHMAIL_CITY
																						,pInput.RAW_VEHMAIL_STATE
																						,pInput.RAW_VEHMAIL_ZIP
																						,pInput.RAW_OWNER1_TYPE
																						,pInput.RAW_OWNER1_LIC_NUM
																						,pInput.RAW_OWNER1_LNAME
																						,pInput.RAW_OWNER1_FNAME
																						,pInput.RAW_OWNER1_MNAME
																						,pInput.RAW_OWNER1_MAIL_STREET1
																						,pInput.RAW_OWNER1_MAIL_STREET2
																						,pInput.RAW_OWNER1_MAIL_CITY
																						,pInput.RAW_OWNER1_MAIL_STATE
																						,pInput.RAW_OWNER1_MAIL_ZIP
																						,pInput.RAW_OWNER2_TYPE
																						,pInput.RAW_OWNER2_LIC_NUM
																						,pInput.RAW_OWNER2_LNAME
																						,pInput.RAW_OWNER2_FNAME
																						,pInput.RAW_OWNER2_MNAME
																						,pInput.RAW_OWNER2_MAIL_STREET1
																						,pInput.RAW_OWNER2_MAIL_STREET2
																						,pInput.RAW_OWNER2_MAIL_CITY
																						,pInput.RAW_OWNER2_MAIL_STATE
																						,pInput.RAW_OWNER2_MAIL_ZIP
																						);		
		self													:=	pInput;
	end;

	dMAVehicleKeyProj					:=	project(veh_patch_desc,tVehicleKey(left));
	o1 := output(dMAVehicleKeyProj,,named('dMAVehicleKeyProj'));
	
	createSuperFiles := SEQUENTIAL( fileservices.startsuperfiletransaction();
																	IF(NOT FileServices.SuperFileExists(base_superfile_name),
																								 FileServices.CreateSuperFile(base_superfile_name)),
																	IF(NOT FileServices.SuperFileExists(base_superfile_name+'_father'),
																								 FileServices.CreateSuperFile(base_superfile_name+'_father')),
																	fileservices.finishsuperfiletransaction()
																);

	// output base file
	ut.MAC_SF_BuildProcess(dMAVehicleKeyProj,base_superfile_name,buildMABase,2,,true);

	// Remove update file from MA Building superfile
	removeMABldg			:=	sequential(	fileservices.startsuperfiletransaction(),
																						fileservices.clearsuperfile('~thor_data400::in::vehiclev2::di::ma_building'),
																						fileservices.finishsuperfiletransaction()
																					);

	buildMAAll					:=	sequential(createSuperFiles,buildMABase);

 export	MA_As_Base	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::di::ma_building')	>	0,
   																	buildMAAll,
   																	output('Not building MA base file as no new MA vehicle updates available')
   																);
