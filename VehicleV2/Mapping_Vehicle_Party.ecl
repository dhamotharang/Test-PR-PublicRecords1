import VehLic,Vehiclev2,address,doxie_files,Codes,watchdog,ut,VehicleCodes,header;

temp_veh_in	:=	VehicleV2.mapping_TEMP_party;

//temp_veh_in	:=	dataset('~thor_data400::persist::vehicleV2::vehicleV1_temp_party',VehicleV2.Layout_Base.Party,thor);

//mapping owner
VehicleV2.Layout_Base.Party_CCPA	townerparty(temp_veh_in	L,integer	cnt)	:=
transform
	self.sequence_key                 :=	(string15)L.sequence_key;
	self.State_Bitmap_Flag						:=	0;
	self.Orig_name_Type 							:=	choose(cnt,'1','1','7','7','7');
	self.Orig_party_Type							:=	choose(cnt,L.OWNER_1_CUSTOMER_TYPExBG3,L.OWNER_2_CUSTOMER_TYPE,L.LEIN_HOLDER_1_CUSTOMER_TYPE,L.LEIN_HOLDER_2_CUSTOMER_TYPE,L.LEIN_HOLDER_3_CUSTOMER_TYPE);
	self.Orig_Conjunction							:=	L.JOINT_OWNERSHIP_CODExAND_OR;
	self.Orig_Name 										:=	choose(cnt,L.OWN_1_CUSTOMER_NAME,if(L.OWN_2_CUSTOMER_NAME <> '',L.OWN_2_CUSTOMER_NAME,IF(l.OWN_2_LNAME  <> '',L.OWN_1_CUSTOMER_NAME,'')),L.LH_1_CUSTOMER_NAME,L.LH_2_CUSTOMER_NAME,L.LH_3_CUSTOMER_NAME);
	self.Orig_Address									:=	choose(cnt,L.OWN_1_STREET_ADDRESS + L.OWN_1_APARTMENT_NUMBER,L.OWN_2_STREET_ADDRESS + L.OWN_2_APARTMENT_NUMBER,L.LH_1_STREET_ADDRESS + L.LH_1_APARTMENT_NUMBER,L.LH_2_STREET_ADDRESS + L.LH_2_APARTMENT_NUMBER,L.LH_3_STREET_ADDRESS + L.LH_3_APARTMENT_NUMBER);
	self.Orig_City 										:=	choose(cnt,L.OWN_1_CITY,L.OWN_2_CITY,L.LH_1_CITY,L.LH_2_CITY,L.LH_3_CITY);
	self.Orig_State 									:=	choose(cnt,L.OWN_1_STATE,L.OWN_2_STATE,L.LH_1_STATE,L.LH_2_STATE,L.LH_3_STATE);
	self.Orig_Zip			 								:=	choose(cnt,L.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,L.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL,L.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,L.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL,L.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.Orig_SSN 										:=	choose(	cnt,if(L.OWNER_1_CUSTOMER_TYPExBG3='I',L.OWN_1_FEID_SSN,''),
																										if(L.OWNER_2_CUSTOMER_TYPE='I',L.OWN_2_FEID_SSN,''),
																										if(L.LEIN_HOLDER_1_CUSTOMER_TYPE='I',L.LH_1_FEID_SSN,''),
																										if(L.LEIN_HOLDER_2_CUSTOMER_TYPE='I',L.LH_2_FEID_SSN,''),
																										if(L.LEIN_HOLDER_3_CUSTOMER_TYPE='I',L.LH_3_FEID_SSN,'')
																							);
	self.Orig_FEIN										:=	choose(	cnt,if(L.OWNER_1_CUSTOMER_TYPExBG3='B',L.OWN_1_FEID_SSN,''),
																										if(L.OWNER_2_CUSTOMER_TYPE='B',L.OWN_2_FEID_SSN,''),
																										if(L.LEIN_HOLDER_1_CUSTOMER_TYPE='B',L.LH_1_FEID_SSN,''),
																										if(L.LEIN_HOLDER_2_CUSTOMER_TYPE='B',L.LH_2_FEID_SSN,''),
																										if(L.LEIN_HOLDER_3_CUSTOMER_TYPE='B',L.LH_3_FEID_SSN,'')
																							);
	self.Orig_DL_Number 							:=	choose(cnt,L.OWN_1_DRIVER_LICENSE_NUMBER,L.OWN_2_DRIVER_LICENSE_NUMBER,L.LH_1_DRIVER_LICENSE_NUMBER,L.LH_2_DRIVER_LICENSE_NUMBER,L.LH_3_DRIVER_LICENSE_NUMBER);
	self.Orig_DOB 										:=	choose(	cnt,L.OWN_1_DOB,L.OWN_2_DOB,
																								if(L.LEIN_HOLDER_1_CUSTOMER_TYPE<>'B',L.LH_1_DOB,''),
																								if(L.LEIN_HOLDER_2_CUSTOMER_TYPE<>'B',L.LH_2_DOB,''),
																								if(L.LEIN_HOLDER_3_CUSTOMER_TYPE<>'B',L.LH_3_DOB,'')
																							);
	self.Orig_Sex 										:=	choose(cnt,L.OWN_1_SEX,L.OWN_2_SEX,L.LH_1_SEX,L.LH_2_SEX,L.LH_3_SEX);
	self.Orig_Lien_Date 							:=	choose(cnt,'','',L.LH_1_LIEN_DATE,L.LH_2_LEIN_DATE,L.LH_3_LIEN_DATE);

	self.title 												:=	choose(cnt,L.own_1_title,L.own_2_title,'','','');
	self.fname 												:=	choose(cnt,L.own_1_fname,L.own_2_fname,'','','');
	self.mname 												:=	choose(cnt,L.own_1_mname,L.own_2_mname,'','','');
	self.lname 												:=	choose(cnt,L.own_1_lname,L.own_2_lname,'','','');
	self.name_suffix 									:=	choose(cnt,L.own_1_name_suffix,L.own_2_name_suffix,'','','');
	self.name_score										:=	'';
	self.Append_Clean_cname						:=	choose(	cnt,L.own_1_company_name,L.own_2_company_name,if(L.LEIN_HOLDER_1_CUSTOMER_TYPE = 'B',L.LH_1_CUSTOMER_NAME ,''),
																								if(L.LEIN_HOLDER_2_CUSTOMER_TYPE = 'B',L.LH_2_CUSTOMER_NAME,''),
																								if(L.LEIN_HOLDER_3_CUSTOMER_TYPE = 'B',L.LH_3_CUSTOMER_NAME,'')
																							);

	self.Append_Ace1_PrepAddr1				:=	choose(cnt,L.Append_Own1_PrepAddr1,L.Append_Own2_PrepAddr1,'','','');
	self.Append_Ace1_PrepAddr2				:=	choose(cnt,L.Append_Own1_PrepAddr2,L.Append_Own2_PrepAddr2,'','','');
	self.Append_Ace1_RawAID						:=	choose(cnt,L.Append_Own1_RawAID,L.Append_Own2_RawAID,0,0,0);
	
	self.prim_range										:=	choose(cnt,L.own_1_prim_range,L.own_2_prim_range,'' ,'','');
	self.predir												:=	choose(cnt,L.own_1_predir,L.own_2_predir,'','','');
	self.prim_name										:=	choose(cnt,L.own_1_prim_name,L.own_2_prim_name,'','','');
	self.addr_suffix									:=	choose(cnt,L.own_1_suffix,L.own_2_suffix,'','','');
	self.postdir											:=	choose(cnt,L.own_1_postdir,L.own_2_postdir,'','','');
	self.unit_desig										:=	choose(cnt,L.own_1_unit_desig,L.own_2_unit_desig,'','','');
	self.sec_range										:=	choose(cnt,L.own_1_sec_range,L.own_2_sec_range,'','','');
	self.v_city_name									:=	choose(cnt,L.own_1_v_city_name,L.own_2_v_city_name,'','','');
	self.st														:=	choose(cnt,L.own_1_state_2,L.own_2_state_2,'','','');
	self.zip5													:=	choose(cnt,L.own_1_zip5,L.own_2_zip5,'','','');
	self.zip4													:=	choose(cnt,L.own_1_zip4,L.own_2_zip4,'','','');
	self.fips_state										:=	choose(cnt,L.own_1_county[1..2],L.own_2_county[1..2],'','','');
	self.fips_county									:=	choose(cnt,L.own_1_county[3..5],L.own_2_county[3..5],'','','');
	self.geo_lat											:=	choose(cnt,L.own_1_geo_lat,L.own_2_geo_lat,'','','');
	self.geo_long											:=	choose(cnt,L.own_1_geo_long,L.own_2_geo_long,'','','');
	self.cbsa													:=	'';
	self.geo_blk											:=	'';
	self.geo_match										:=	'';
	self.err_stat											:=	choose(cnt,L.own_1_err_stat,L.own_2_err_stat,'','','');
	
	self.ace_prim_range								:=	choose(cnt,L.own_1_prim_range,L.own_2_prim_range,'' ,'','');
	self.ace_predir										:=	choose(cnt,L.own_1_predir,L.own_2_predir,'','','');
	self.ace_prim_name								:=	choose(cnt,L.own_1_prim_name,L.own_2_prim_name,'','','');
	self.ace_addr_suffix							:=	choose(cnt,L.own_1_suffix,L.own_2_suffix,'','','');
	self.ace_postdir									:=	choose(cnt,L.own_1_postdir,L.own_2_postdir,'','','');
	self.ace_unit_desig								:=	choose(cnt,L.own_1_unit_desig,L.own_2_unit_desig,'','','');
	self.ace_sec_range								:=	choose(cnt,L.own_1_sec_range,L.own_2_sec_range,'','','');
	self.ace_v_city_name							:=	choose(cnt,L.own_1_v_city_name,L.own_2_v_city_name,'','','');
	self.ace_st												:=	choose(cnt,L.own_1_state_2,L.own_2_state_2,'','','');
	self.ace_zip5											:=	choose(cnt,L.own_1_zip5,L.own_2_zip5,'','','');
	self.ace_zip4											:=	choose(cnt,L.own_1_zip4,L.own_2_zip4,'','','');
	self.ace_fips_state								:=	choose(cnt,L.own_1_county[1..2],L.own_2_county[1..2],'','','');
	self.ace_fips_county							:=	choose(cnt,L.own_1_county[3..5],L.own_2_county[3..5],'','','');
	self.ace_geo_lat									:=	choose(cnt,L.own_1_geo_lat,L.own_2_geo_lat,'','','');
	self.ace_geo_long									:=	choose(cnt,L.own_1_geo_long,L.own_2_geo_long,'','','');
	self.ace_cbsa											:=	'';
	self.ace_geo_blk									:=	'';
	self.ace_geo_match								:=	'';
	self.ace_err_stat									:=	choose(cnt,L.own_1_err_stat,L.own_2_err_stat,'','','');
	
	self.Append_DID										:=	0;
	self.Append_DID_Score							:=	0;
	self.Append_BDID									:=	0;
	self.Append_BDID_Score						:=	0;
	self.Append_DL_Number							:=	'';
	self.Append_SSN										:=	'';
	self.Append_FEIN									:=	'';
	self.Append_DOB										:=	'';
	self.Reg_First_Date								:=	'';
	self.Reg_Earliest_Effective_Date	:=	'';
	self.Reg_Latest_Effective_Date		:=	'';
	self.Reg_Latest_Expiration_Date		:=	'';
	self.Reg_Decal_Number							:=	'';
	self.Reg_Decal_Year								:=	'';
	self.Reg_Status_Code							:=	'';
	self.Reg_Status_Desc							:=	'';
	self.Reg_True_License_Plate				:=	'';
	self.Reg_License_Plate						:=	'';
	self.Reg_License_State						:=	'';
	self.Reg_License_Plate_Type_Code	:=	'';
	self.Reg_License_Plate_Type_Desc	:=	'';
	self.Reg_Previous_License_State		:=	'';
	self.Reg_Previous_License_Plate		:=	'';
	self.reg_rollup_count							:=	0;
	self.Ttl_Number										:=	L.TITLE_NUMBERxBG9;
	self.Ttl_Rollup_Count        			:=	L.Ttl_Rollup_Count;
	self.Ttl_Previous_Issue_Date			:=	L.PREVIOUS_TITLE_ISSUE_DATE;
	self.Ttl_Status_Code							:=	L.TITLE_STATUS_CODE;
	self.Ttl_Status_Desc							:=	'';
	self.Ttl_Odometer_Mileage					:=	L.ODOMETER_MILEAGE;
	self.Ttl_Odometer_Status_Code			:=	L.ODOMETER_STATUS;
	self.Ttl_Odometer_Status_Desc			:=	'';
	self.Ttl_Odometer_Date						:=	L.ODOMETER_DATE;
	self.PREVIOUS_TITLE_STATE					:=	'';
	self.history											:=	if(L.history = 'E','H',L.history);
	//Added for CCPA-103
	// self.global_sid                   := 0;
	// self.record_sid                   := 0;
	//Added for DF-25578
	// self.raw_name                     := '';

	self															:=	L;
	self															:=	[];
end;

Vehicle_owner_norm 	:= normalize(temp_veh_in,5,townerparty(left,counter));

//Add Title_Status_Description
//add filtering condition to get records without blank a name
file_owner_add_field1  	:=	Vehicle_owner_norm(orig_name <> '' or lname <> '');

file_codesV3_desc_ttl  	:=	Codes.File_Codes_V3_In(file_name	=	'VEHICLE_REGISTRATION'	and	field_name	=	'TITLE_STATUS_CODE');
						
VehicleV2.Layout_Base.Party_CCPA	tjoin2_ttl(file_owner_add_field1	L,file_codesV3_desc_ttl	R)	:=
transform
	self.ttl_Status_Desc	:=	R.long_desc;
	self									:=	L;
end;


owner_codesV3_join_ttl 	:=	JOIN(	file_owner_add_field1,
																	file_codesV3_desc_ttl,
																	left.Ttl_STATUS_CODE  = right.code and 
																	left.state_origin = right.field_name2,
																	tjoin2_ttl(left,right),
																	LEFT OUTER,
																	lookup
																);

owner_concat_ttl       	:=	owner_codesV3_join_ttl;

//Add Odometer_Status_Description
file_codesV3_desc_odm	:= Codes.File_Codes_V3_In(file_name	=	'VEHICLE_REGISTRATION'	and	field_name	=	'ODOMETER_STATUS');
							
VehicleV2.Layout_Base.Party_CCPA tjoin2_odm(owner_concat_ttl	L,file_codesV3_desc_odm	R )	:=
transform
	self.Ttl_Odometer_Status_Desc	:=	R.long_desc;
	self													:=	L;
end;

owner_codesV3_join_odm 	:=	JOIN(	owner_concat_ttl,
																	file_codesV3_desc_odm,
																	left.Ttl_Odometer_Status_Code  = right.code and
																	left.state_origin = right.field_name2,
																	tjoin2_odm(left,right),
																	LEFT OUTER,
																	lookup
																);

vehicle_owner			:= owner_codesV3_join_odm;

//*************************************************************************************************************
//*************************************************************************************************************
//mapping registration 

VehicleV2.Layout_Base.Party_CCPA tregparty(temp_veh_in L,integer cnt)	:=
transform
	self.sequence_key                 :=	(string15)L.sequence_key;
	self.State_Bitmap_Flag						:=	0;
	self.Orig_name_Type 							:=	choose(cnt,'4','4');
	self.Orig_party_Type							:=	choose(cnt,L.REGISTRANT_1_CUSTOMER_TYPExBG5,L.REGISTRANT_2_CUSTOMER_TYPE);
	self.Orig_Conjunction							:=	L.JOINT_OWNERSHIP_CODExAND_OR;
	self.Orig_Name 										:=	choose(cnt,L.REG_1_CUSTOMER_NAME,if(L.REG_2_CUSTOMER_NAME <> '',L.REG_2_CUSTOMER_NAME,if(L.REG_2_LNAME <> '',L.REG_1_CUSTOMER_NAME,'')));
	self.Orig_Address 								:=	choose(cnt,L.REG_1_STREET_ADDRESS + L.REG_1_APARTMENT_NUMBER,L.REG_2_STREET_ADDRESS + L.REG_2_APARTMENT_NUMBER);
	self.Orig_City 										:=	choose(cnt,L.REG_1_CITY,L.REG_2_CITY);
	self.Orig_State 									:=	choose(cnt,L.REG_1_STATE,L.REG_2_STATE);
	self.Orig_Zip 										:=	choose(cnt,L.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,L.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.Orig_SSN 										:=	choose(	cnt,if(L.REGISTRANT_1_CUSTOMER_TYPExBG5='I',L.REG_1_FEID_SSN,''),
																										if(L.REGISTRANT_2_CUSTOMER_TYPE='I',L.REG_2_FEID_SSN,'')
																							);
												 
	self.Orig_FEIN										:=	choose(	cnt,
																								if(L.REGISTRANT_1_CUSTOMER_TYPExBG5='B',L.REG_1_FEID_SSN,''),
																								if(L.REGISTRANT_2_CUSTOMER_TYPE='B',L.REG_2_FEID_SSN,'')
																							);
												 
	self.Orig_DL_Number 							:=	choose(cnt,L.REG_1_DRIVER_LICENSE_NUMBER,L.REG_2_DRIVER_LICENSE_NUMBER);
	self.Orig_DOB 										:=	choose(cnt,L.REG_1_DOB,L.REG_2_DOB);
	self.Orig_Sex 										:=	choose(cnt,L.REG_1_SEX,L.REG_2_SEX);
	self.Orig_Lien_Date 							:=	'';

	self.title 												:=	choose(cnt,L.reg_1_title,L.reg_2_title);
	self.fname 												:=	choose(cnt,L.reg_1_fname,L.reg_2_fname);
	self.mname 												:=	choose(cnt,L.reg_1_mname,L.reg_2_mname);
	self.lname 												:=	choose(cnt,L.reg_1_lname,L.reg_2_lname);
	self.name_suffix 									:=	choose(cnt,L.reg_1_name_suffix,L.reg_2_name_suffix);
	self.name_score										:=	'';
	self.Append_Clean_cname						:=	choose(cnt,L.reg_1_company_name,L.reg_2_company_name);
	
	self.Append_Ace1_PrepAddr1				:=	choose(cnt,L.Append_Reg1_PrepAddr1,L.Append_Reg2_PrepAddr1);
	self.Append_Ace1_PrepAddr2				:=	choose(cnt,L.Append_Reg1_PrepAddr2,L.Append_Reg2_PrepAddr2);
	self.Append_Ace1_RawAID						:=	choose(cnt,L.Append_Reg1_RawAID,L.Append_Reg2_RawAID);
	
	self.prim_range										:=	choose(cnt,L.reg_1_prim_range,L.reg_2_prim_range);
	self.predir												:=	choose(cnt,L.reg_1_predir,L.reg_2_predir);
	self.prim_name										:=	choose(cnt,L.reg_1_prim_name,L.reg_2_prim_name);
	self.addr_suffix									:=	choose(cnt,L.reg_1_suffix,L.reg_2_suffix);
	self.postdir											:=	choose(cnt,L.reg_1_postdir,L.reg_2_postdir);
	self.unit_desig										:=	choose(cnt,L.reg_1_unit_desig,L.reg_2_unit_desig);
	self.sec_range										:=	choose(cnt,L.reg_1_sec_range,L.reg_2_sec_range);
	self.v_city_name									:=	choose(cnt,L.reg_1_v_city_name,L.reg_2_v_city_name);
	self.st														:=	choose(cnt,L.reg_1_state_2,L.reg_2_state_2);
	self.zip5													:=	choose(cnt,L.reg_1_zip5,L.reg_2_zip5);
	self.zip4													:=	choose(cnt,L.reg_1_zip4,L.reg_2_zip4);
	self.fips_state										:=	choose(cnt,L.reg_1_county[1..2],L.reg_2_county[1..2]);
	self.fips_county									:=	choose(cnt,L.reg_1_county[3..5],L.reg_2_county[3..5]);
	self.geo_lat											:=	choose(cnt,L.reg_1_geo_lat,L.reg_2_geo_lat);
	self.geo_long											:=	choose(cnt,L.reg_1_geo_long,L.reg_2_geo_long);
	self.cbsa													:=	'';
	self.geo_blk											:=	'';
	self.geo_match										:=	'';
	self.err_stat											:=	choose(cnt,L.reg_1_err_stat,L.reg_2_err_stat);

	self.ace_prim_range								:=	choose(cnt,L.reg_1_prim_range,L.reg_2_prim_range);
	self.ace_predir										:=	choose(cnt,L.reg_1_predir,L.reg_2_predir);
	self.ace_prim_name								:=	choose(cnt,L.reg_1_prim_name,L.reg_2_prim_name);
	self.ace_addr_suffix							:=	choose(cnt,L.reg_1_suffix,L.reg_2_suffix);
	self.ace_postdir									:=	choose(cnt,L.reg_1_postdir,L.reg_2_postdir);
	self.ace_unit_desig								:=	choose(cnt,L.reg_1_unit_desig,L.reg_2_unit_desig);
	self.ace_sec_range								:=	choose(cnt,L.reg_1_sec_range,L.reg_2_sec_range);
	self.ace_v_city_name							:=	choose(cnt,L.reg_1_v_city_name,L.reg_2_v_city_name);
	self.ace_st												:=	choose(cnt,L.reg_1_state_2,L.reg_2_state_2);
	self.ace_zip5											:=	choose(cnt,L.reg_1_zip5,L.reg_2_zip5);
	self.ace_zip4											:=	choose(cnt,L.reg_1_zip4,L.reg_2_zip4);
	self.ace_fips_state								:=	choose(cnt,L.reg_1_county[1..2],L.reg_2_county[1..2]);
	self.ace_fips_county							:=	choose(cnt,L.reg_1_county[3..5],L.reg_2_county[3..5]);
	self.ace_geo_lat									:=	choose(cnt,L.reg_1_geo_lat,L.reg_2_geo_lat);
	self.ace_geo_long									:=	choose(cnt,L.reg_1_geo_long,L.reg_2_geo_long);
	self.ace_cbsa											:=	'';
	self.ace_geo_blk									:=	'';
	self.ace_geo_match								:=	'';
	self.ace_err_stat									:=	choose(cnt,L.reg_1_err_stat,L.reg_2_err_stat);
	
	self.Append_DID										:=	0;
	self.Append_DID_Score							:=	0;
	self.Append_BDID									:=	0;
	self.Append_BDID_Score						:=	0;
	self.Append_DL_Number							:=	'';
	self.Append_SSN										:=	'';
	self.Append_FEIN									:=	'';
	self.Append_DOB                   :=	'';
	self.Reg_First_Date								:=	'';
	self.Reg_Decal_Number							:=	L.DECAL_NUMBER;
	self.Reg_Decal_Year								:=	L.DECAL_YEAR;
	self.Reg_Status_Code							:=	L.REGISTRATION_STATUS_CODE;
	self.Reg_Status_Desc							:=	'';
	self.Reg_True_License_Plate				:=	L.TRUE_LICENSE_PLSTE_NUMBER;
	self.Reg_License_Plate						:=	L.LICENSE_PLATE_NUMBERxBG4;
	self.Reg_License_State						:=	'';
	self.Reg_License_Plate_Type_Code	:=	L.LICENSE_PLATE_CODE;
	self.Reg_License_Plate_Type_Desc	:=	VehicleCodes.GetLicensePlate(L.LICENSE_PLATE_CODE);
	self.Reg_Previous_License_State		:=	'';
	self.Reg_Previous_License_Plate		:=	'';
	self.Ttl_Number										:=	'';
	self.Ttl_Earliest_Issue_Date			:=	'';
	self.Ttl_Latest_Issue_Date        :=	'';
	self.Ttl_Previous_Issue_Date      :=	'';
	self.Ttl_Status_Code              :=	'';
	self.Ttl_Status_Desc							:=	'';
	self.Ttl_Odometer_Mileage					:=	'';
	self.Ttl_Odometer_Status_Code			:=	'';
	self.Ttl_Odometer_Status_Desc			:=	'';
	self.Ttl_Odometer_Date						:=	'';
	self.PREVIOUS_TITLE_STATE         :=	'';
	self.ttl_rollup_count             :=	0;
	self															:=	L;
	self															:=	[];
end;

Vehicle_REG_norm 	:= normalize(temp_veh_in,2,tregparty(left,counter));

// Add Registration_Status_Description
// add filtering condition to get records without blank a name
file_reg_add_field	:=	Vehicle_REG_norm(orig_name <> '' or lname <> '');

file_codesV3_desc	:=	Codes.File_Codes_V3_In(file_name	=	'VEHICLE_REGISTRATION'	and	field_name	=	'REGISTRATION_STATUS_CODE');
reg_codeV3_nojoin	:=	file_reg_add_field(REG_STATUS_CODE = '');

VehicleV2.Layout_Base.Party_CCPA	tjoin2(file_reg_add_field	L,file_codesV3_desc	R )	:=
transform
	self.Reg_Status_Desc	:=	R.long_desc;
	self									:=	L;
end;

reg_codesV3_join	:=	JOIN(	file_reg_add_field(REG_STATUS_CODE<>''),
														file_codesV3_desc(code<>''),
														left.REG_STATUS_CODE = right.code and 
														left.state_origin = right.field_name2,
														tjoin2(left,right),
														LEFT OUTER,
														lookup
													);

reg_concat	:=	reg_codeV3_nojoin	+	reg_codesV3_join;

// Add Registration_License_Plate_Type_Description
file_codesV3_desc2	:= Codes.File_Codes_V3_In(file_name	=	'VEHICLE_REGISTRATION'	and	field_name	=	'LICENSE_PLATE_CODE');

reg_codeV3_nojoin2	:= reg_concat(Reg_License_Plate_Type_Code = '' or (Reg_License_Plate_Type_Code<>'' and Reg_License_Plate_Type_desc <> ''));

reg_concat tjoin4(reg_concat L,file_codesV3_desc2 R )	:=
transform
	self.Reg_License_Plate_Type_Desc	:=	R.long_desc;
	self															:=	L;
end;

reg_codesV3_join2	:=	JOIN(	reg_concat(Reg_License_Plate_Type_Code<>'' and Reg_License_Plate_Type_desc = ''),
														file_codesV3_desc2(code<>''),
														trim(left.Reg_License_Plate_Type_Code,all) = trim(right.code,all) and
														left.state_origin = right.field_name2,
														tjoin4(left,right),
														LEFT OUTER,
														lookup
													);
	
reg_concat2 :=	reg_codeV3_nojoin2	+	reg_codesV3_join2;

vehicle_reg	:= reg_concat2;


// modify pname and cname issues when orig_party_type = 'B' and 'I'
VehicleV2.Layout_Base.Party_CCPA tfixname(VehicleV2.Layout_Base.Party_CCPA L)	:=
transform
	boolean iscname					:=	if(L.lname in ['LT','INFINITI LT'],true,false);																						 
												 
	self.title 							:=	if(iscname,'', L.title);                                                                                                                      
	self.fname 							:=	if(iscname,'', L.fname);                                                                                                                                                                                              
	self.mname 							:=	if(iscname,'', L.mname);                                                                                                                                                                                           
	self.lname 							:=	if(iscname,'', L.lname);                                                                                                                                                                                           
	self.name_suffix				:=	if(iscname,'', L.name_suffix);                                                                                                                                                                                           
	self.name_score					:=	if(iscname,'', L.name_score);                                                                      
	self.Append_Clean_cname	:=	if(iscname,l.orig_name,l.Append_Clean_cname);
	self										:=	L;
end;
	
vehicle_party	:=	project(vehicle_owner + vehicle_reg,tfixname(left));

vehicle_party_in	:=	dedup(distribute(vehicle_party,hash(vehicle_key,iteration_key)),all,local);

export mapping_vehicle_party	:=	vehicle_party_in	:	persist('~thor_data400::persist::vehicleV2::vehicleV1_party');