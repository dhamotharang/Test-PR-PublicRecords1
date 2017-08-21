import AID,codes,header,ut,Vehlic,vehicleV2,VehicleCodes;

dMABase											:=	vehiclev2.Files.Base.MA(APPEND_OWNER1_NAME<>'' OR APPEND_OWNER2_NAME<>'');
//dMABase	:=	sample(vehiclev2.Files.Base.MA(APPEND_OWNER1_NAME<>'' OR APPEND_OWNER2_NAME<>''),100000,1);

//Retrieve iteration_key from mapping+ma_temp_main
//Distribute/Sort/Dedep
dMABaseSort									:=	sort(	distribute(dMABase,hash(vehicle_key, state_origin, source_code, ORIG_VIN, model_year, make_desc, series_desc,
																												      VEHICLE_TYPE_desc, MODEL_desc, body_style_desc, Orig_Gross_Weight, MAJOR_COLOR_desc, MINOR_COLOR_desc)),
																			vehicle_key, state_origin, source_code, ORIG_VIN, model_year, make_desc, series_desc, 
																			VEHICLE_TYPE_desc, MODEL_desc, body_style_desc, Orig_Gross_Weight, MAJOR_COLOR_desc, MINOR_COLOR_desc,
																			-dt_vendor_first_reported,
																			-REGISTRATION_EFFECTIVE_DATE,
																			-REGISTRATION_EXPIRATION_DATE,
																			-TITLE_ISSUE_DATE,
																			local
																		);		 
output('# of records in dMABaseSort = ' + count(dMABaseSort));
											 
// Infutor Vin temp main file
dMATempMain									:=	VehicleV2.Mapping_MA_Temp_Main;
dMATempMainSort							:=	sort(	distribute(dMATempMain,hash(vehicle_key, state_origin, source_code, ORIG_VIN, model_year, make_desc, series_desc,
																												          VEHICLE_TYPE_desc, MODEL_desc, body_style_desc, Orig_Gross_Weight, MAJOR_COLOR_desc, MINOR_COLOR_desc)),
																			vehicle_key, state_origin, source_code, ORIG_VIN, model_year, make_desc, series_desc,
																			VEHICLE_TYPE_desc, MODEL_desc, body_style_desc, Orig_Gross_Weight, MAJOR_COLOR_desc, MINOR_COLOR_desc,
																			-dt_vendor_first_reported,
																			-REGISTRATION_EFFECTIVE_DATE,
																			-REGISTRATION_EXPIRATION_DATE,
																			-TITLE_ISSUE_DATE,
																			local
																		); 

temp_ma := record
  string1 delete_flag;
	VehicleV2.Layout_MA.MA_as_VehicleV2;
end;	
	
// join temp main with MA base file using vehicle_key and get iteration key
temp_ma	tIterationKey(dMABaseSort	L, dMATempMainSort	R)	:=
transform
	self.iteration_key	:=	R.iteration_key;
	//set the delete flag to N for those records have no addresses at all
	//after normalization, delete those reocords that have flag set to Y
	address							:=	trim(L.Append_MailAddr2+L.Append_Owner1MailAddr2+L.Append_Owner1ResiAddr2+
															 L.Append_Owner2MailAddr2+L.Append_Owner2ResiAddr2);
	self.delete_flag		:= 	IF(address='','N','Y');												 
	self								:=	L;
end;

dMAIterationKey							:=	join(	dMABaseSort,
																			dMATempMainSort,
																			left.vehicle_key					=	right.vehicle_key						AND
																			left.state_origin					=	right.state_origin					AND
																			left.source_code					=	right.source_code						AND
																			left.ORIG_VIN							=	right.ORIG_VIN							AND
																			left.model_year						=	right.model_year						AND
																			left.make_desc						=	right.make_desc							AND
																			left.series_desc					=	right.series_desc						AND
																			left.VEHICLE_TYPE_desc		=	right.VEHICLE_TYPE_desc			AND
																			left.MODEL_desc						=	right.MODEL_desc						AND
																			left.body_style_desc			=	right.body_style_desc				AND
																			left.Orig_Gross_Weight		=	right.Orig_Gross_Weight			AND
																			left.MAJOR_COLOR_desc			=	right.MAJOR_COLOR_desc			AND
																			left.MINOR_COLOR_desc			=	right.MINOR_COLOR_desc,
																			tIterationKey(left,right),
																			local
																		);

//---------------------------------------------------------------------------
//-------Normalize 2 owners and 3 addresses
//---------------------------------------------------------------------------
temp_party_bip := record
  string1 delete_flag;
	VehicleV2.Layout_Base.Party_BIP;
end;	
temp_party_bip	tParty(dMAIterationKey pInput,integer	cnt)	:=
transform
	self.State_Bitmap_Flag						:=	0;
	self.Date_First_Seen 							:=	(UNSIGNED) pInput.Dt_First_Seen;
	self.Date_Last_Seen  							:=	(UNSIGNED) pInput.Dt_Last_Seen;
	self.Date_Vendor_First_Reported		:=	(UNSIGNED) pInput.Dt_Vendor_First_Reported;
	self.Date_Vendor_Last_Reported		:=	(UNSIGNED) pInput.Dt_Vendor_Last_Reported;
	self.Orig_Party_Type 							:=	CHOOSE(cnt,IF(pInput.RAW_OWNER1_TYPE='1','I','B'),					//owner1, veh address
																									 IF(pInput.RAW_OWNER1_TYPE='1','I','B'),					//owner1, mail address
																									 IF(pInput.RAW_OWNER1_TYPE='1','I','B'),					//owner1, resi address
																									 IF(pInput.RAW_OWNER2_TYPE='1','I','B'),					//owner2, veh address
																									 IF(pInput.RAW_OWNER2_TYPE='1','I','B'),					//owner2, mail address
																									 IF(pInput.RAW_OWNER2_TYPE='1','I','B'));					//owner2, resi address
	self.Orig_Name_Type								:=	'4';
	self.Orig_Conjunction							:=	'';
	self.Orig_Name			 							:=	CHOOSE(cnt,TRIM(pInput.APPEND_OWNER1_NAME,LEFT,RIGHT),
																									 TRIM(pInput.APPEND_OWNER1_NAME,LEFT,RIGHT),
																									 TRIM(pInput.APPEND_OWNER1_NAME,LEFT,RIGHT),
																									 TRIM(pInput.APPEND_OWNER2_NAME,LEFT,RIGHT),
																									 TRIM(pInput.APPEND_OWNER2_NAME,LEFT,RIGHT),
																									 TRIM(pInput.APPEND_OWNER2_NAME,LEFT,RIGHT));
	
	self.Orig_Address		 							:=	CHOOSE(cnt,TRIM(pInput.Append_MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner1MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner1ResiAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner2MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner2ResiAddr1,LEFT,RIGHT));
	self.Orig_City		 								:=	CHOOSE(cnt,TRIM(pInput.RAW_VEHMAIL_CITY,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_MAIL_CITY,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_RESI_CITY,LEFT,RIGHT),
																									 TRIM(pInput.RAW_VEHMAIL_CITY,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_MAIL_CITY,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_RESI_CITY,LEFT,RIGHT));
	self.orig_province								:=	'';
	self.orig_country									:=	'';
	self.Orig_State		 								:=	CHOOSE(cnt,TRIM(pInput.RAW_VEHMAIL_STATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_MAIL_STATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_RESI_STATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_VEHMAIL_STATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_MAIL_STATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_RESI_STATE,LEFT,RIGHT));
	temp_Orig_zip			 								:=	CHOOSE(cnt,TRIM(pInput.RAW_VEHMAIL_ZIP,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_MAIL_ZIP,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_RESI_ZIP,LEFT,RIGHT),
																									 TRIM(pInput.RAW_VEHMAIL_ZIP,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_MAIL_ZIP,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_RESI_ZIP,LEFT,RIGHT));
	self.orig_zip										:= IF(REGEXFIND('^0*$',temp_Orig_zip),'',temp_Orig_zip);
	self.Orig_FEIN										:=	'';
	self.Orig_SSN											:=	'';
	self.Orig_DL_Number 							:=	CHOOSE(cnt,TRIM(pInput.RAW_OWNER1_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_LIC_NUM,LEFT,RIGHT));
	temp_Orig_DOB 										:=	CHOOSE(cnt,TRIM(pInput.RAW_OWNER1_BDATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_BDATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_BDATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_BDATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_BDATE,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_BDATE,LEFT,RIGHT));
  self.Orig_DOB											:=	IF(temp_Orig_DOB='00000000','',temp_Orig_DOB);
	self.Orig_Sex 										:=	CHOOSE(cnt,TRIM(pInput.RAW_OWNER1_SEX,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_SEX,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_SEX,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_SEX,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_SEX,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_SEX,LEFT,RIGHT));
	self.Orig_Lien_Date								:=	'';
	self.title		 										:=	CHOOSE(cnt,TRIM(pInput.OWNER1_CLEAN_TITLE,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_TITLE,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_TITLE,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_TITLE,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_TITLE,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_TITLE,LEFT,RIGHT));
	self.fname		 										:=	CHOOSE(cnt,TRIM(pInput.OWNER1_CLEAN_FNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_FNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_FNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_FNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_FNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_FNAME,LEFT,RIGHT));
	self.mname		 										:=	CHOOSE(cnt,TRIM(pInput.OWNER1_CLEAN_MNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_MNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_MNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_MNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_MNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_MNAME,LEFT,RIGHT));
	self.lname		 										:=	CHOOSE(cnt,TRIM(pInput.OWNER1_CLEAN_LNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_LNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_LNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_LNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_LNAME,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_LNAME,LEFT,RIGHT));
	self.name_suffix									:=	CHOOSE(cnt,TRIM(pInput.OWNER1_CLEAN_SUFFIX,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_SUFFIX,LEFT,RIGHT),
																									 TRIM(pInput.OWNER1_CLEAN_SUFFIX,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_SUFFIX,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_SUFFIX,LEFT,RIGHT),
																									 TRIM(pInput.OWNER2_CLEAN_SUFFIX,LEFT,RIGHT));
	self.name_score										:=	'';
 	self.Append_Clean_cname						:=	CHOOSE(cnt,TRIM(pInput.COMPANY_NAME1,LEFT,RIGHT),
																									 TRIM(pInput.COMPANY_NAME1,LEFT,RIGHT),
																									 TRIM(pInput.COMPANY_NAME1,LEFT,RIGHT),
																									 TRIM(pInput.COMPANY_NAME2,LEFT,RIGHT),
																									 TRIM(pInput.COMPANY_NAME2,LEFT,RIGHT),
																									 TRIM(pInput.COMPANY_NAME2,LEFT,RIGHT));
	
	self.Append_Ace1_PrepAddr1				:=	CHOOSE(cnt,TRIM(pInput.Append_MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner1MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner1ResiAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner2MailAddr1,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner2ResiAddr1,LEFT,RIGHT));
	self.Append_Ace1_PrepAddr2				:=	CHOOSE(cnt,TRIM(pInput.Append_MailAddr2,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner1MailAddr2,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner1ResiAddr2,LEFT,RIGHT),
																									 TRIM(pInput.Append_MailAddr2,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner2MailAddr2,LEFT,RIGHT),
																									 TRIM(pInput.Append_Owner2ResiAddr2,LEFT,RIGHT));
	self.Append_Ace1_RawAID						:=	CHOOSE(cnt,pInput.Append_MailRawAID,
																									 pInput.Append_Owner1MailRawAID,
																									 pInput.Append_Owner1ResiRawAID,
																									 pInput.Append_MailRawAID,
																									 pInput.Append_Owner2MailRawAID,
																									 pInput.Append_Owner2ResiRawAID);		
	self.prim_range										:=	CHOOSE(cnt,TRIM(pInput.veh_mail_prim_range,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_prim_range,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_prim_range,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_prim_range,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_prim_range,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_prim_range,LEFT,RIGHT));
	self.predir												:=	CHOOSE(cnt,TRIM(pInput.veh_mail_predir,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_predir,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_predir,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_predir,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_predir,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_predir,LEFT,RIGHT));
	self.prim_name										:=	CHOOSE(cnt,TRIM(pInput.veh_mail_prim_name,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_prim_name,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_prim_name,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_prim_name,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_prim_name,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_prim_name,LEFT,RIGHT));
	self.addr_suffix									:=	CHOOSE(cnt,TRIM(pInput.veh_mail_suffix,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_suffix,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_suffix,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_suffix,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_suffix,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_suffix,LEFT,RIGHT));
	self.postdir											:=	CHOOSE(cnt,TRIM(pInput.veh_mail_postdir,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_postdir,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_postdir,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_postdir,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_postdir,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_postdir,LEFT,RIGHT));
	self.unit_desig										:=	CHOOSE(cnt,TRIM(pInput.veh_mail_unit_desig,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_unit_desig,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_unit_desig,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_unit_desig,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_unit_desig,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_unit_desig,LEFT,RIGHT));
	self.sec_range										:=	CHOOSE(cnt,TRIM(pInput.veh_mail_sec_range,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_sec_range,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_sec_range,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_sec_range,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_sec_range,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_sec_range,LEFT,RIGHT));
	self.v_city_name										:=	CHOOSE(cnt,TRIM(pInput.veh_mail_v_city_name,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_v_city_name,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_v_city_name,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_v_city_name,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_v_city_name,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_v_city_name,LEFT,RIGHT));
	self.st															:=	CHOOSE(cnt,TRIM(pInput.veh_mail_state,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_state,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_state,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_state,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_state,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_state,LEFT,RIGHT));

	self.zip5															:=	CHOOSE(cnt,TRIM(pInput.veh_mail_zip5,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_zip5,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_zip5,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_zip5,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_zip5,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_zip5,LEFT,RIGHT));
	self.zip4															:=	CHOOSE(cnt,TRIM(pInput.veh_mail_zip4,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_zip4,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_zip4,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_zip4,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_zip4,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_zip4,LEFT,RIGHT));
	self.addr_rec_type										:=	CHOOSE(cnt,TRIM(pInput.veh_mail_rec_type,LEFT,RIGHT),
																									 TRIM(pInput.owner1_mail_rec_type,LEFT,RIGHT),
																									 TRIM(pInput.owner1_resi_rec_type,LEFT,RIGHT),
																									 TRIM(pInput.veh_mail_rec_type,LEFT,RIGHT),
																									 TRIM(pInput.owner2_mail_rec_type,LEFT,RIGHT),
																									 TRIM(pInput.owner2_resi_rec_type,LEFT,RIGHT));
	self.fips_state												:=	CHOOSE(cnt,pInput.veh_mail_county[1..2],
																									 pInput.owner1_mail_county[1..2],
																									 pInput.owner1_resi_county[1..2],
																									 pInput.veh_mail_county[1..2],
																									 pInput.owner2_mail_county[1..2],
																									 pInput.owner2_resi_county[1..2]);
	self.fips_county											:=	CHOOSE(cnt,pInput.veh_mail_county[3..5],
																									 pInput.owner1_mail_county[3..5],
																									 pInput.owner1_resi_county[3..5],
																									 pInput.veh_mail_county[3..5],
																									 pInput.owner2_mail_county[3..5],
																									 pInput.owner2_resi_county[3..5]);
	self.geo_lat													:=	CHOOSE(cnt,pInput.veh_mail_geo_lat,
																									 pInput.owner1_mail_geo_lat,
																									 pInput.owner1_resi_geo_lat,
																									 pInput.veh_mail_geo_lat,
																									 pInput.owner2_mail_geo_lat,
																									 pInput.owner2_resi_geo_lat);
	self.geo_long													:=	CHOOSE(cnt,pInput.veh_mail_geo_long,
																									 pInput.owner1_mail_geo_long,
																									 pInput.owner1_resi_geo_long,
																									 pInput.veh_mail_geo_long,
																									 pInput.owner2_mail_geo_long,
																									 pInput.owner2_resi_geo_long);
	self.err_stat													:=	CHOOSE(cnt,pInput.veh_mail_err_stat,
																									 pInput.owner1_mail_err_stat,
																									 pInput.owner1_resi_err_stat,
																									 pInput.veh_mail_err_stat,
																									 pInput.owner2_mail_err_stat,
																									 pInput.owner2_resi_err_stat);


	self.Append_DID												:=	0;
	self.Append_DID_Score									:=	0;
	self.Append_BDID											:=	0;
	self.Append_BDID_Score								:=	0;
	self.Append_DL_Number									:=	CHOOSE(cnt,TRIM(pInput.RAW_OWNER1_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER1_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_LIC_NUM,LEFT,RIGHT),
																									 TRIM(pInput.RAW_OWNER2_LIC_NUM,LEFT,RIGHT));	
	self.Append_SSN												:=	'';
	self.Append_FEIN											:=	'';
	self.Append_DOB               	  		:=	CHOOSE(cnt,IF(pInput.RAW_OWNER1_BDATE[1..4] in ['1850','0000'],'',pInput.RAW_OWNER1_BDATE),
																									 IF(pInput.RAW_OWNER1_BDATE[1..4] in ['1850','0000'],'',pInput.RAW_OWNER1_BDATE),
																									 IF(pInput.RAW_OWNER1_BDATE[1..4] in ['1850','0000'],'',pInput.RAW_OWNER1_BDATE),
																									 IF(pInput.RAW_OWNER2_BDATE[1..4] in ['1850','0000'],'',pInput.RAW_OWNER2_BDATE),
																									 IF(pInput.RAW_OWNER2_BDATE[1..4] in ['1850','0000'],'',pInput.RAW_OWNER2_BDATE),
																									 IF(pInput.RAW_OWNER2_BDATE[1..4] in ['1850','0000'],'',pInput.RAW_OWNER2_BDATE));	
	
	self.Reg_First_Date										:=	'';
	self.Registration_Effective_Date			:= 	pInput.Registration_Effective_Date;
	self.Registration_Expiration_Date			:= 	pInput.REGISTRATION_EXPIRATION_DATE;
	self.reg_rollup_count        					:=	1;
	self.Reg_True_License_Plate						:= 	TRIM(pInput.TRUE_LICENSE_PLSTE_NUMBER,LEFT,RIGHT);
	self.Reg_License_State								:= 	'';
	self.Reg_License_Plate_Type_Code			:=	TRIM(pInput.vehicle_type,LEFT,RIGHT);
	self.Reg_License_Plate_Type_Desc			:= 	TRIM(pInput.Orig_Vehicle_Type_Desc,LEFT,RIGHT);
	self.Reg_Previous_License_State				:=	'';
	self.Reg_Previous_License_Plate				:=	'';
	
	self.Ttl_Number												:= 	IF(REGEXFIND('^0+$',TRIM(pInput.TITLE_NUMBER,LEFT,RIGHT)),'',TRIM(pInput.TITLE_NUMBER,LEFT,RIGHT));
	self.Title_Issue_Date									:=	IF(pInput.TITLE_ISSUE_DATE<>'00000000',pInput.TITLE_ISSUE_DATE,'');
	self.Ttl_Rollup_Count									:=	0;
	
	self.Reg_Decal_Number									:=	'';
	self.Reg_Decal_Year										:=	'';

	self.Ttl_Odometer_Mileage							:= 	REGEXREPLACE('^0*',TRIM(pInput.RAW_VEHT_TITLE_MILAGE),'');
	self.Ttl_Odometer_Date								:= 	IF(pInput.RAW_VEHT_PURCHDATE<>'00000000',pInput.RAW_VEHT_PURCHDATE,'');
	
	self 																	:=	pInput;
	self																	:=	[];
end;

dMANormalize 				:=	normalize(dMAIterationKey,6,tParty(left,counter));
dMADeduped					:=	dedup(dMANormalize(orig_name	!=	''),all);

//Delete those records that have no addresses and marked as delete. They are the by-product of normalize.
toBeDeleted					:= dMADeduped(Append_Ace1_PrepAddr1='' AND Append_Ace1_PrepAddr2='' AND delete_flag='Y');
dMADedupedFiltered := project(dMADeduped - toBeDeleted, VehicleV2.Layout_Base.Party_BIP);
//output(count(dMADedupedFiltered));

// Pass only records to the function which have the address line last populated
dMAAddrPopulated		:=	dMADedupedFiltered(Append_Ace1_PrepAddr2	!=	'');
dMAAddrNotPopulated	:=	dMADedupedFiltered(Append_Ace1_PrepAddr2	=		'');

// Append clean address by calling the AID macro
unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
															AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(	dMAAddrPopulated,
														Append_Ace1_PrepAddr1,
														Append_Ace1_PrepAddr2,
														Append_Ace1_RawAID,
														dMAAppendAID,
														lAIDAppendFlags
													);

VehicleV2.Layout_Base.Party_BIP	tAceAddress(dMAAppendAID	pInput)	:=
transform
	self.Ace_prim_range			:=	pInput.AIDWork_AceCache.prim_range;
	self.Ace_predir					:=	pInput.AIDWork_AceCache.predir;
	self.Ace_prim_name			:=	pInput.AIDWork_AceCache.prim_name;
	self.Ace_addr_suffix		:=	pInput.AIDWork_AceCache.addr_suffix;
	self.Ace_postdir				:=	pInput.AIDWork_AceCache.postdir;
	self.Ace_unit_desig			:=	pInput.AIDWork_AceCache.unit_desig;
	self.Ace_sec_range			:=	pInput.AIDWork_AceCache.sec_range;
	self.Ace_p_city_name		:=	pInput.AIDWork_AceCache.p_city_name;
	self.Ace_v_city_name		:=	pInput.AIDWork_AceCache.v_city_name;
	self.Ace_st							:=	pInput.AIDWork_AceCache.st;
	self.Ace_zip5						:=	pInput.AIDWork_AceCache.zip5;
	self.Ace_zip4						:=	pInput.AIDWork_AceCache.zip4;
	self.Ace_addr_rec_type	:=	pInput.AIDWork_AceCache.rec_type;
	self.Ace_fips_state			:=	pInput.AIDWork_AceCache.county[1..2];
	self.Ace_fips_county		:=	pInput.AIDWork_AceCache.county[3..5];
	self.Ace_geo_lat				:=	pInput.AIDWork_AceCache.geo_lat;
	self.Ace_geo_long				:=	pInput.AIDWork_AceCache.geo_long;
	self.Ace_cbsa						:=	pInput.AIDWork_AceCache.msa;
	self.Ace_geo_blk				:=	pInput.AIDWork_AceCache.geo_blk;
	self.Ace_geo_match			:=	pInput.AIDWork_AceCache.geo_match;
	self.Ace_err_stat				:=	pInput.AIDWork_AceCache.err_stat;
	
	self.Append_Ace1_RawAID	:=	pInput.AIDWork_RawAID;
	
	self										:=	pInput;
end;

dMACleanAddress	:=	project(dMAAppendAID,tAceAddress(left));

export	Mapping_MA_Temp_Party	:=	dMACleanAddress	+	dMAAddrNotPopulated	:	persist('~thor_data400::persist::vehicleV2::ma_temp_party');