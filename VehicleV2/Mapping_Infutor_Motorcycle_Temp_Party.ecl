import AID,codes,header,ut,Vehlic,vehicleV2,VehicleCodes;

dInfutorMotorcycleBase			:=	vehiclev2.Files.Base.Infutor_Motorcycle(append_ownername<>'');
//dInfutorMotorcycleBase			:=	sample(vehiclev2.Files.Base.Infutor_Motorcycle(append_ownername<>''),10000,1);

//Retrieve iteration_key from mapping+infutor_motorcycle_temp_main
//Distribute/Sort/Dedep
dInfutorMotorcycleBaseDist	:=	distribute(dInfutorMotorcycleBase,hash(vehicle_key));
dInfutorMotorcycleBaseSort	:=	sort(	dInfutorMotorcycleBaseDist,
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
																			local
																		);		 
dInfutorMotorcycleBaseDedup	:=	dedup(	dInfutorMotorcycleBaseSort,
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
											 
// Infutor Vin temp main file
dInfutorMotorcycleTempMain					:=	VehicleV2.Mapping_Infutor_Motorcycle_Temp_Main;
dInfutorMotorcycleMainDist					:=	distribute(dInfutorMotorcycleTempMain,hash(vehicle_key));
dInfutorMotorcycleMainSort					:=	sort(	dInfutorMotorcycleMainDist,
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
																			-dt_vendor_first_reported,
																			local
																		); 

// join temp main with Infutor base file using vehicle_key and get iteration key
VehicleV2.Layout_Infutor_Motorcycle.Infutor_Motorcycle_as_VehicleV2	tIterationKey(dInfutorMotorcycleBaseDedup	L,dInfutorMotorcycleMainSort	R)	:=
transform
	self.iteration_key	:=	R.iteration_key;
	self								:=	L;
end;

dInfutorMotorcycleIterationKey			:=	join(	dInfutorMotorcycleBaseDedup,
																			dInfutorMotorcycleMainSort,
																			left.vehicle_key					=	right.vehicle_key						AND
																			left.state_origin					=	right.state_origin					AND
																			left.source_code					=	right.source_code						AND
																			left.ORIG_VIN							=	right.ORIG_VIN							AND
																			left.model_year						=	right.model_year						AND
																			left.make_desc						=	right.make_desc							AND
																			left.series_desc					=	right.series_desc						AND
																			left.MODEL_desc						=	right.MODEL_desc						AND
																			left.body_style_desc			=	right.body_style_desc,
																			tIterationKey(left,right),
																			local
																		);


VehicleV2.Layout_Base.Party_CCPA	tParty(dInfutorMotorcycleIterationKey pInput)	:=
transform
	self.State_Bitmap_Flag						:=	0;
	self.Date_First_Seen 							:=	0;  //(UNSIGNED) pInput.Dt_First_Seen;
	self.Date_Last_Seen  							:=	0;  //(UNSIGNED) pInput.Dt_Last_Seen;
	self.Date_Vendor_First_Reported		:=	(UNSIGNED) pInput.Dt_Vendor_First_Reported;
	self.Date_Vendor_Last_Reported		:=	(UNSIGNED) pInput.Dt_Vendor_Last_Reported;
	self.Orig_Party_Type 							:=	pInput.CUSTOMER_TYPE;
	self.Orig_Name_Type								:=	'1';
	self.Orig_Conjunction							:=	'';
	self.Orig_Name 										:=	TRIM(pInput.APPEND_OWNERNAME,LEFT,RIGHT);
	
	self.Orig_Address						 			:=	TRIM(pInput.APPEND_PREPADDR1,LEFT,RIGHT);
	self.Orig_City			 							:=	TRIM(pInput.RAW_CITY,LEFT,RIGHT);
	self.Orig_State			 							:=	TRIM(pInput.RAW_STATE,LEFT,RIGHT);
	self.Orig_Zip			 								:=	TRIM(pInput.RAW_ZIP,LEFT,RIGHT)+TRIM(pInput.RAW_Z4,LEFT,RIGHT);
	
	self.Orig_FEIN										:=	'';
	self.Orig_SSN											:=	'';
	self.Orig_DL_Number 							:=	'';
	self.Orig_DOB 										:=	'';
	self.Orig_Sex 										:=	pInput.RAW_GENDER;
	self.Orig_Lien_Date 							:=	'';

	self.title 												:=	TRIM(pInput.TITLE,LEFT,RIGHT);
	self.fname 												:=	TRIM(pInput.FNAME,LEFT,RIGHT);
	self.mname 												:=	TRIM(pInput.MNAME,LEFT,RIGHT);
	self.lname 												:=	TRIM(pInput.LNAME,LEFT,RIGHT);
	self.name_suffix 									:=	TRIM(pInput.NAME_SUFFIX,LEFT,RIGHT);
	self.name_score										:=	TRIM(pInput.NAME_SCORE,LEFT,RIGHT);
	
	self.Append_Ace1_PrepAddr1				:=	TRIM(pInput.APPEND_PREPADDR1);
	self.Append_Ace1_PrepAddr2				:=	TRIM(pInput.APPEND_PREPADDR2);
	self.Append_Ace1_RawAID						:=	pInput.APPEND_RAWAID;
	
 	self.Append_Clean_cname						:=	TRIM(pInput.COMPANY_NAME1);
	
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

	//populate sequence key here because we are using raw_idate
	//DF-16772. Modified to remove warning messae substring applied to value of type integer.
	self.sequence_key									:=	TRIM(pInput.RAW_IDATE) +	((string8) pInput.Dt_Vendor_Last_Reported)[1..6]	+	'R';	

	self.Ttl_Number 									:= 	'';                  //Infutor does not provide title info. pInput.TITLE_NUMBERxBG9;
	self.SRC_FIRST_DATE								:= pInput.RAW_IDATE;
	self.SRC_LAST_DATE								:= pInput.RAW_ODATE;
	self 															:=	pInput;
	self															:=	[];
end;

//dOHNormalize :=	normalize(dOHIterationKey,2,tParty(left,counter));
dInfutorMotorcycleNormalize := project(dInfutorMotorcycleIterationKey, tParty(LEFT));

dInfutorMotorcycleIterationKeyDist	:=	distribute(dInfutorMotorcycleNormalize,hash(vehicle_key));
dInfutorMotorcycleIterationKeySort	:=	sort(	dInfutorMotorcycleIterationKeyDist,
																							vehicle_key,
																							state_origin,
																							source_code,
																							st,
																							zip5,
																							zip4,
																							v_city_name,
																							local
																						);		 
dInfutorMotorcycleIterationKeyDedup:=	dedup(	dInfutorMotorcycleIterationKeySort,
																							vehicle_key,
																							state_origin,
																							source_code,
																							st,
																							zip5,
																							zip4,
																							v_city_name,
																							local
																						);

// Pass only records to the function which have the address line last populated
dInfutorMotorcycleAddrPopulated		:=	dInfutorMotorcycleIterationKeyDedup(Append_Ace1_PrepAddr1<>'');
dInfutorMotorcycleAddrNotPopulated	:=	dInfutorMotorcycleIterationKeyDedup(Append_Ace1_PrepAddr1='');

// Append clean address by calling the AID macro
unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
															AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(	dInfutorMotorcycleAddrPopulated,
														Append_Ace1_PrepAddr1,
														Append_Ace1_PrepAddr2,
														Append_Ace1_RawAID,
														dInfutorMotorcycleAppendAID,
														lAIDAppendFlags
													);

VehicleV2.Layout_Base.Party_CCPA	tAceAddress(dInfutorMotorcycleAppendAID	pInput)	:=
transform
	//Map_Infutor_Motorcycle_Update save the AIDWork_RawAID but nothing else. Use the clean address from this macro call.
	self.prim_range					:=	pInput.AIDWork_AceCache.prim_range;
	self.predir							:=	pInput.AIDWork_AceCache.predir;
	self.prim_name					:=	pInput.AIDWork_AceCache.prim_name;;
	self.addr_suffix				:=	pInput.AIDWork_AceCache.addr_suffix;
	self.postdir						:=	pInput.AIDWork_AceCache.postdir;
	self.unit_desig					:=	pInput.AIDWork_AceCache.unit_desig;
	self.sec_range					:=	pInput.AIDWork_AceCache.sec_range;
	self.v_city_name				:=	pInput.AIDWork_AceCache.v_city_name;
	self.st									:=	pInput.AIDWork_AceCache.st;
	self.zip5								:=	pInput.AIDWork_AceCache.zip5;
	self.zip4								:=	pInput.AIDWork_AceCache.zip4;
	self.fips_state					:=	pInput.AIDWork_AceCache.county[1..2];
	self.fips_county				:=	pInput.AIDWork_AceCache.county[3..5];
	self.geo_lat						:=	pInput.AIDWork_AceCache.geo_lat;
	self.geo_long						:=	pInput.AIDWork_AceCache.geo_long;
	self.cbsa								:=	pInput.AIDWork_AceCache.msa;
	self.geo_blk						:=	pInput.AIDWork_AceCache.geo_blk;
	self.geo_match					:=	pInput.AIDWork_AceCache.geo_match;
	self.err_stat						:=	pInput.AIDWork_AceCache.err_stat;

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


dInfutorMotorcycleCleanAddress	:=	project(dInfutorMotorcycleAppendAID,tAceAddress(left));

EXPORT Mapping_Infutor_Motorcycle_Temp_Party	:=	dInfutorMotorcycleCleanAddress	+	dInfutorMotorcycleAddrNotPopulated	
                                                  :	persist('~thor_data400::persist::vehicleV2::inf_nondppa_motorcycle_temp_party');
