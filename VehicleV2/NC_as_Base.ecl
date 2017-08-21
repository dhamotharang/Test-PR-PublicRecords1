import Address,AID,codes,Lib_StringLib,standard,ut,vehlic,vehicleCodes,PromoteSupers;

dNCUpdate	:=	VehicleV2.Map_NC_Update;

// combine to the base file and rollup data on all the key fields except process date and standardized fields
dNCCombined	:=	dNCUpdate	+	VehicleV2.Files.Base.NC;

dNCCombinedDist	:=	distribute(dNCCombined,hash(state_origin,orig_vin));
dNCCombinedSort	:=	sort(	dNCCombinedDist
														,state_origin
														,orig_vin
														,orig_make_year
														,orig_net_weight
														,orig_make_code
														,orig_series_code
														,body_code
														,vehicle_type
														,LICENSE_PLATE_NUMBERxBG4
														,true_license_plste_number
														,Orig_RegistrationExpDate
														,Orig_RegistrationIssueDate
														,registration_effective_date
														,REGISTRATION_STATUS_CODE
														,TITLE_NUMBERxBG9
														,TITLE_ISSUE_DATE
														,Orig_TitleTypeCode               
														,Orig_TitleTransferDate
														,Orig_REGISTRANT1_CUSTOMER_TYPE
														,REG_1_CUSTOMER_NAME
														,REG_1_STREET_ADDRESS
														,REG_1_CITY
														,REG_1_STATE
														,REG_1_ZIP5_ZIP4_FOREIGN_POSTAL
														,Orig_REGISTRANT2_CUSTOMER_TYPE
														,REG_2_CUSTOMER_NAME
														,REG_2_STREET_ADDRESS
														,REG_2_CITY
														,REG_2_STATE
														,REG_2_ZIP5_ZIP4_FOREIGN_POSTAL
														,-dt_vendor_last_reported
														,local
													);

typeof(dNCCombinedSort)	tRollup(dNCCombinedSort	L,dNCCombinedSort	R)	:=
transform
  self.dt_first_seen				    :=	ut.min2(L.dt_first_seen,R.dt_first_seen);
  self.dt_last_seen				      :=	MAX(L.dt_last_seen,R.dt_last_seen);
	self.dt_vendor_first_reported	:=	ut.min2(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
	self.dt_vendor_last_reported  :=  MAX(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
	self.source_rec_id						:=  if(L.source_rec_id<>0,if(L.source_rec_id<R.source_rec_id,L.source_rec_id,R.source_rec_id),0);			
  self													:=	L;
end;

dNCCombinedRollup	:=	rollup(	dNCCombinedSort
																,tRollup(left,right)
																,state_origin
																,orig_vin
																,orig_make_year
																,orig_net_weight
																,orig_make_code
																,orig_series_code
																,body_code
																,vehicle_type
																,LICENSE_PLATE_NUMBERxBG4
																,true_license_plste_number
																,Orig_RegistrationExpDate
																,Orig_RegistrationIssueDate
																,registration_effective_date
																,REGISTRATION_STATUS_CODE
																,TITLE_NUMBERxBG9
																,TITLE_ISSUE_DATE
																,Orig_TitleTypeCode               
																,Orig_TitleTransferDate
																,Orig_REGISTRANT1_CUSTOMER_TYPE
																,REG_1_CUSTOMER_NAME
																,REG_1_STREET_ADDRESS
																,REG_1_CITY
																,REG_1_STATE
																,REG_1_ZIP5_ZIP4_FOREIGN_POSTAL
																,Orig_REGISTRANT2_CUSTOMER_TYPE
																,REG_2_CUSTOMER_NAME
																,REG_2_STREET_ADDRESS
																,REG_2_CITY
																,REG_2_STATE
																,REG_2_ZIP5_ZIP4_FOREIGN_POSTAL
																,local
															);


//****** Join to VINA file and valid VIN

// change to join on vin_input in VINA file,since that is the value in the vehicle file that is searched in VINA app.
VehicleV2.Mac_validVIN(dNCCombinedRollup,validvin_out)

//****** Improve descriptions
VehicleV2.MAC_Patch_Vehmain_by_codes(validvin_out,VehicleV2.Layout_NC.NC_as_VehicleV2_Layout,veh_vins_done)	

//---------------------------------------------------------------------------
//-------APPEND DESCRIPTIONS FOR CODES
//---------------------------------------------------------------------------

//patch descriptions from codeV3
VehicleV2.MAC_Patch_Desc_by_codesV3(validvin_out,VehicleV2.Layout_NC.NC_as_VehicleV2_Layout,true,veh_patch_desc);

// Generate vehicle key
VehicleV2.Layout_NC.NC_as_VehicleV2_layout	tVehicleKey(veh_patch_desc	pInput)	:=
transform
	best_major_color_desc 				:=	VehicleCodes.getColor(pInput.best_Major_Color_Code);
	best_minor_color_desc 				:=	VehicleCodes.getColor(pInput.best_Minor_Color_Code);
	
	string4 Best_Model_Year		 		:=	if(pInput.vina_Model_Year<>'',pInput.vina_Model_Year,pInput.Year_Make);
	self.vehicle_key   						:=	trim(	if(	pInput.vina_vinflag = 'T',
																							pInput.VINA_vin,
																							//if VINA takes a 17 character VIN and "converts" it to 16 characters,take the orig_vin
																							if(			pInput.vina_vinflag='F'
																									and	length(trim(pInput.orig_vin))	=	17
																									and	length(trim(pInput.VINA_vin))	!=	17,
																									pInput.orig_vin,
																									if(			pInput.orig_vin[1..4]	in	['','NONE','HMDE','HOME','UNK','N0NE','UNKN']	or	StringLib.StringFilterOut(pInput.orig_vin,'0|*')	=	''
																											or	regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|VEHICLE|UNKNOWN|UNKOWN|UNK0WN|NUMBER',pInput.orig_vin) or pInput.orig_vin in ['N/A','N','NR','NA','ASPT','01','SPCN','O','NO VIN','UKN'],
																											(string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.TITLE_NUMBERxBG9,pInput.vina_make_desc,Best_Model_Year),
																											(string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.vina_make_desc,Best_Model_Year)
																										)
																								)
																							)
																							,left,right
																					);
	
	model_year 										:=	if(pInput.vina_model_year	<>	'',pInput.vina_model_year,'');
	self.model_year 							:=	model_year;
	
	make_descrip 									:=	if(pInput.vina_make_desc	<>	'',pInput.vina_make_desc,'') ;
	self.make_desc 								:=	if( stringlib.StringToUpperCase(make_descrip) = stringlib.StringToUpperCase(pInput.make_desc)[1..length(trim(make_descrip))] or pInput.make_desc = '',make_descrip,'');

	self.vehicle_type_desc 				:=	if(pInput.vina_veh_type	<>	'',vehicleV2.getVehTypeDesc(pInput.vina_veh_type),'');
	self.series_desc 							:=	if(pInput.vina_series_desc	<>	'',pInput.vina_series_desc,'');	
	
	model_descrip 								:=	if(pInput.vina_model_desc	<>	'',pInput.vina_model_desc,'');
	self.model_desc 							:=	if( stringlib.StringToUpperCase(model_descrip)[1..length(pInput.model_desc)] = stringlib.StringToUpperCase(pInput.model_desc) or pInput.model_desc='',model_descrip,'');
	
	self.body_style_desc 					:=	if(pInput.vina_body_style_desc	<>	'',pInput.vina_body_style_desc,'');
	
	self.major_color_desc 				:=	best_major_color_desc;
	self.minor_color_desc 				:=	best_minor_color_desc;
	self.source_rec_id 						:=  hash64(  pInput.state_origin
																						,pInput.orig_vin
																						,pInput.orig_make_year
																						,pInput.orig_net_weight
																						,pInput.orig_make_code
																						,pInput.orig_series_code
																						,pInput.body_code
																						,pInput.vehicle_type
																						,pInput.LICENSE_PLATE_NUMBERxBG4
																						,pInput.true_license_plste_number
																						,pInput.Orig_RegistrationExpDate
																						,pInput.Orig_RegistrationIssueDate
																						,pInput.registration_effective_date
																						,pInput.REGISTRATION_STATUS_CODE
																						,pInput.TITLE_NUMBERxBG9
																						,pInput.TITLE_ISSUE_DATE
																						,pInput.Orig_TitleTypeCode               
																						,pInput.Orig_TitleTransferDate
																						,pInput.Orig_REGISTRANT1_CUSTOMER_TYPE
																						,pInput.REG_1_CUSTOMER_NAME
																						,pInput.REG_1_STREET_ADDRESS
																						,pInput.REG_1_CITY
																						,pInput.REG_1_STATE
																						,pInput.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL
																						,pInput.Orig_REGISTRANT2_CUSTOMER_TYPE
																						,pInput.REG_2_CUSTOMER_NAME
																						,pInput.REG_2_STREET_ADDRESS
																						,pInput.REG_2_CITY
																						,pInput.REG_2_STATE
																						,pInput.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL);		
	self													:=	pInput;
end;

dNCVehicleKeyProj	:=	project(veh_patch_desc,tVehicleKey(left));

PromoteSupers.MAC_SF_BuildProcess(dNCVehicleKeyProj,'~thor_data400::base::vehiclev2::direct::nc',buildNCBase,2,,true);

// Remove update file from NC Building superfile
removeNCBldg	:=	sequential(	fileservices.startsuperfiletransaction(),
																fileservices.clearsuperfile('~thor_data400::in::vehiclev2::di::nc_building'),
																fileservices.finishsuperfiletransaction()
															);

buildNCAll	:=	sequential(buildNCBase,removeNCBldg);

export	NC_as_Base	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::di::nc_building')	>	0,
														buildNCAll,
														output('Not building NC base file as there are no update files available')
													);