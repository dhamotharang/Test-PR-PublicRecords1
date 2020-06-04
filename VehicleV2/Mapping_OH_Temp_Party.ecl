import AID,codes,header,ut,Vehlic,vehicleV2,VehicleCodes;

//---------------------------------------------------------------------------
//-------APPEND ITERATION KEY AND NORMALIZE TWO REGISTERED OWNERS
//---------------------------------------------------------------------------
dOHBase	:=	vehiclev2.Files.Base.OH(REG_1_CUSTOMER_NAME	<>	''	or	REG_2_CUSTOMER_NAME	<>	'');

// Append iteration key
dOHBaseDist	:=	distribute(	dOHBase,
														hash(	vehicle_key,
																	state_origin,
																	source_code,
																	ORIG_VIN,
																	model_year,
																	make_desc,
																	series_desc,
																	VEHICLE_TYPE_desc,
																	MODEL_desc,
																	body_style_desc,
																	// Orig_Net_Weight,			//DF-8238
																	Number_Of_Axles,
																	MAJOR_COLOR_desc,
																	MINOR_COLOR_desc 
																)
													);
											 
dOHBaseSort	:=	sort(	dOHBaseDist,
											vehicle_key,
											state_origin,
											source_code,
											ORIG_VIN,
											model_year,
											make_desc,
											series_desc,
											VEHICLE_TYPE_desc,
											MODEL_desc,
											body_style_desc,
											// Orig_Net_Weight,						//DF-8238
											Number_Of_Axles,
											MAJOR_COLOR_desc,
											MINOR_COLOR_desc,
											-dt_vendor_first_reported,
											-REGISTRATION_EFFECTIVE_DATE,
											-REGISTRATION_EXPIRATION_DATE,
											-TITLE_ISSUE_DATE,
											local
										);

// OH temp main file
dOHTempMain	:=	VehicleV2.Mapping_OH_Temp_Main;

dOHTempMainDist	:=	distribute(	dOHTempMain,
																hash( vehicle_key,
																			state_origin,
																			source_code,
																			ORIG_VIN,
																			model_year,
																			make_desc,
																			series_desc,
																			VEHICLE_TYPE_desc,
																			MODEL_desc,
																			body_style_desc,
																			// Orig_Net_Weight,						//DF-8238
																			Number_Of_Axles,
																			MAJOR_COLOR_desc,
																			MINOR_COLOR_desc
																		)
															);  
			

dOHTempMainSort	:=	sort(	dOHTempMainDist,
													vehicle_key,
													state_origin,
													source_code,
													ORIG_VIN,
													model_year,
													make_desc,
													series_desc,
													VEHICLE_TYPE_desc,
													MODEL_desc,
													body_style_desc,
													// Orig_Net_Weight,						//DF-8238
													Number_Of_Axles,
													MAJOR_COLOR_desc,
													MINOR_COLOR_desc,
													local
												);

// join temp main with OH base file using vehicle_key and get iteration key
VehicleV2.Layout_OH.OH_as_VehicleV2	tIterationKey(dOHBaseSort	L,dOHTempMainSort	R)	:=
transform
	self.iteration_key	:=	R.iteration_key;
	self								:=	L;
end;

dOHIterationKey	:=	join(	dOHBaseSort,
													dOHTempMainSort,
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
													// left.Orig_Net_Weight			=	right.Orig_Net_Weight				AND			//DF-8238
													left.Number_Of_Axles			=	right.Number_Of_Axles				AND
													left.MAJOR_COLOR_desc			=	right.MAJOR_COLOR_desc			AND
													left.MINOR_COLOR_desc			=	right.MINOR_COLOR_desc,
													tIterationKey(left,right),
													local
												);

//---------------------------------------------------------------------------
//-------NORMALIZE TWO REGISTERED OWNERS
//---------------------------------------------------------------------------

VehicleV2.Layout_Base.Party_CCPA	tParty(dOHIterationKey	pInput,integer	cnt)	:=
transform
	self.State_Bitmap_Flag						:=	0;
	self.Date_First_Seen 							:=	(UNSIGNED) pInput.Dt_First_Seen;
	self.Date_Last_Seen  							:=	(UNSIGNED) pInput.Dt_Last_Seen;
	self.Date_Vendor_First_Reported		:=	(UNSIGNED) pInput.Dt_Vendor_First_Reported;
	self.Date_Vendor_Last_Reported		:=	(UNSIGNED) pInput.Dt_Vendor_Last_Reported;
	self.Orig_Party_Type 							:=	choose(cnt,pInput.REGISTRANT_1_CUSTOMER_TYPE,pInput.REGISTRANT_2_CUSTOMER_TYPE);
	self.Orig_Name_Type								:=	choose(cnt,'4','4');
	self.Orig_Conjunction							:=	'';
	self.Orig_Name 										:=	choose(cnt,pInput.REG_1_CUSTOMER_NAME,pInput.REG_2_CUSTOMER_NAME);
	
	self.Orig_Address						 			:=	choose(cnt,pInput.REG_1_STREET_ADDRESS + pInput.REG_1_APARTMENT_NUMBER,pInput.REG_2_STREET_ADDRESS + pInput.REG_2_APARTMENT_NUMBER);
	self.Orig_City		 								:=	choose(cnt,pInput.REG_1_CITY,pInput.REG_2_CITY);
	self.Orig_State			 							:=	choose(cnt,pInput.REG_1_STATE,pInput.REG_2_STATE);
	self.Orig_Zip			 								:=	choose(cnt,pInput.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,pInput.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	
	self.Orig_FEIN										:=	'';
	self.Orig_SSN											:=	'';
	self.Orig_DL_Number 							:=	'';
	self.Orig_DOB 										:=	'';
	self.Orig_Sex 										:=	'';
	self.Orig_Lien_Date 							:=	'';

	self.title 												:=	choose(cnt,pInput.reg_1_title,pInput.reg_2_title);
	self.fname 												:=	choose(cnt,pInput.reg_1_fname,pInput.reg_2_fname);
	self.mname 												:=	choose(cnt,pInput.reg_1_mname,pInput.reg_2_mname);
	self.lname 												:=	choose(cnt,pInput.reg_1_lname,pInput.reg_2_lname);
	self.name_suffix 									:=	choose(cnt,pInput.reg_1_name_suffix,pInput.reg_2_name_suffix);
	self.name_score										:=	'';
	
	self.Append_Ace1_PrepAddr1				:=	choose(cnt,pInput.Append_Reg1_PrepAddr1,pInput.Append_Reg2_PrepAddr1);
	self.Append_Ace1_PrepAddr2				:=	choose(cnt,pInput.Append_Reg1_PrepAddr2,pInput.Append_Reg2_PrepAddr2);
	self.Append_Ace1_RawAID						:=	choose(cnt,pInput.Append_Reg1_RawAID,pInput.Append_Reg2_RawAID);
	
	self.Append_Clean_cname						:=	choose(cnt,pInput.reg_1_company_name,pInput.reg_2_company_name);
	self.prim_range										:=	choose(cnt,pInput.reg_1_prim_range,pInput.reg_2_prim_range);
	self.predir												:=	choose(cnt,pInput.reg_1_predir,pInput.reg_2_predir);
	self.prim_name										:=	choose(cnt,pInput.reg_1_prim_name,pInput.reg_2_prim_name);
	self.addr_suffix									:=	choose(cnt,pInput.reg_1_suffix,pInput.reg_2_suffix);
	self.postdir											:=	choose(cnt,pInput.reg_1_postdir,pInput.reg_2_postdir);
	self.unit_desig										:=	choose(cnt,pInput.reg_1_unit_desig,pInput.reg_2_unit_desig);
	self.sec_range										:=	choose(cnt,pInput.reg_1_sec_range,pInput.reg_2_sec_range);
	self.v_city_name									:=	choose(cnt,pInput.reg_1_v_city_name,pInput.reg_2_v_city_name);
	self.st														:=	choose(cnt,pInput.reg_1_state_2,pInput.reg_2_state_2);
	self.zip5													:=	choose(cnt,pInput.reg_1_zip5,pInput.reg_2_zip5);
	self.zip4													:=	choose(cnt,pInput.reg_1_zip4,pInput.reg_2_zip4);
	self.fips_state										:=	'';
	self.fips_county									:=	choose(cnt,pInput.reg_1_county,pInput.reg_2_county);
	self.geo_lat											:=	choose(cnt,pInput.reg_1_geo_lat,pInput.reg_2_geo_lat);
	self.geo_long											:=	choose(cnt,pInput.reg_1_geo_long,pInput.reg_2_geo_long);
	self.cbsa													:=	'';
	self.geo_blk											:=	'';
	self.geo_match										:=	'';
	self.err_stat											:=	choose(cnt,pInput.reg_1_err_stat,pInput.reg_2_err_stat);
	
	self.Append_DID										:=	0;
	self.Append_DID_Score							:=	0;
	self.Append_BDID									:=	0;
	self.Append_BDID_Score						:=	0;
	self.Append_DL_Number							:=	'';
	self.Append_SSN										:=	'';
	self.Append_FEIN									:=	'';
	self.Append_DOB               	  :=	'';
	
	self.reg_rollup_count        			:=	1;
	self.Reg_First_Date								:=	'';
	self.Reg_Decal_Number							:=	'';
	self.Reg_Decal_Year								:=	'';
	self.Reg_Status_Code							:=	pInput.REGISTRATION_STATUS_CODE;
	self.Reg_Status_Desc							:=	'';
	self.Reg_True_License_Plate				:=	pInput.TRUE_LICENSE_PLSTE_NUMBER;
	self.Reg_License_Plate						:=	pInput.LICENSE_PLATE_NUMBERxBG4;
	self.Reg_License_State						:=	'';
	self.Reg_License_Plate_Type_Code	:=	pInput.VEHICLE_TYPE;
	self.Reg_License_Plate_Type_Desc	:=	pInput.Orig_Vehicle_Type_Desc;
	self.Reg_Previous_License_State		:=	'';
	self.Reg_Previous_License_Plate		:=	pInput.PreviousPlateNum;
	self.Ttl_Number										:=	pInput.TITLE_NUMBERxBG9;
	self.Ttl_Earliest_Issue_Date    	:=	pInput.title_Issue_Date;
	self.Ttl_Latest_Issue_Date				:=	pInput.Title_Issue_Date;
	self.Ttl_Previous_Issue_Date			:=	'';
	self.Ttl_Status_Code							:=	'';
	self.Ttl_Status_Desc							:=	'';
	self.Ttl_Odometer_Mileage					:=	'';
	self.Ttl_Odometer_Status_Code			:=	'';
	self.Ttl_Odometer_Status_Desc			:=	'';
	self.Ttl_Odometer_Date						:=	'';
	self.ttl_rollup_count							:=	0;
	self 															:=	pInput;
	self															:=	[];
end;

dOHNormalize :=	normalize(dOHIterationKey,2,tParty(left,counter));

dOHDeduped	:=	dedup(dOHNormalize(orig_name	!=	''),all);

// get descriptions from codeV3
dFileCodesV3	:=	Codes.File_Codes_V3_In(	file_name		=	'VEHICLE_REGISTRATION'	and
																					field_name	=	'REGISTRATION_STATUS_CODE'
																				);

dRegCodesV3NoJoin	:=	dOHDeduped(REG_STATUS_CODE	=	'');

VehicleV2.Layout_Base.Party_CCPA	tRegStatus(dOHDeduped	L,dFileCodesV3	R)	:=
transform
	self.Reg_Status_Desc	:=	R.long_desc;
	self									:=	L;
end;

dOHRegStatusCodesV3	:=	JOIN(	dOHDeduped(REG_STATUS_CODE	!=	''), 
															dFileCodesV3(code	!=	''), 
															left.REG_STATUS_CODE	=	right.code and 
															left.state_origin			=	right.field_name2, 
															tRegStatus(left,right),
															LEFT OUTER,
															lookup
														);

dOHRegStatusDesc	:=	IF(EXISTS(dOHRegStatusCodesV3),dOHRegStatusCodesV3	+	dRegCodesV3NoJoin,dRegCodesV3NoJoin);

// Pass only records to the function which have the address line last populated
dOHAddrPopulated		:=	dOHRegStatusDesc(Append_Ace1_PrepAddr2	!=	'');
dOHAddrNotPopulated	:=	dOHRegStatusDesc(Append_Ace1_PrepAddr2	=		'');

// Append clean address by calling the AID macro
unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
															AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(	dOHAddrPopulated,
														Append_Ace1_PrepAddr1,
														Append_Ace1_PrepAddr2,
														Append_Ace1_RawAID,
														dOHAppendAID,
														lAIDAppendFlags
													);

VehicleV2.Layout_Base.Party_CCPA	tAceAddress(dOHAppendAID	pInput)	:=
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

dOHCleanAddress	:=	project(dOHAppendAID,tAceAddress(left));

export	Mapping_OH_Temp_Party	:=	dOHCleanAddress	+	dOHAddrNotPopulated	:	persist('~thor_data400::persist::vehicleV2::oh_temp_party');