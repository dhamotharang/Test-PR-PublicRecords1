IMPORT AID,Address,ut,VehicleV2,VehicleCodes,Codes,STD;

// OH prepped file
OH_Vehicle_In	:=	VehicleV2.Files.In.OH.PreppedBldg;

// Clean all fields to make sure we keep only the printable characters
ut.CleanFields(OH_Vehicle_In,OH_Vehicle_Clean);

//-----------------------------------------------------------------
//DEDUP ADDRESSES
//-----------------------------------------------------------------
d_addresses					:=	DISTRIBUTE(OH_Vehicle_Clean,HASH(OwnerStreetAddress,OwnerCity,OwnerState,OwnerZip));
dedup_addr 					:=	DEDUP(SORT(d_addresses,OwnerStreetAddress,OwnerCity,OwnerState,OwnerZip,LOCAL),OwnerStreetAddress,OwnerCity,OwnerState,OwnerZip,LOCAL);

//-----------------------------------------------------------------
//STANDARDIZE ADDRESS: Clean address
//-----------------------------------------------------------------
rCleanAddress_layout	:=
RECORD
	STRING30				OwnerStreetAddress;
	STRING15				OwnerCity;
	STRING2					OwnerState;
	STRING9					OwnerZip;
	STRING100				Append_PrepAddr1;
	STRING50				Append_PrepAddr2;
	AID.Common.xAID	Append_RawAID;
END;

rCleanAddress_layout	t_CleanAddress(dedup_addr	L)	:=
TRANSFORM
	SELF.Append_PrepAddr1	:=	stringlib.stringtouppercase(trim(L.OwnerStreetAddress,left,right));
	SELF.Append_PrepAddr2	:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																			stringlib.stringcleanspaces(		if(L.OwnerCity	!=	'',trim(L.OwnerCity,left,right)	+	',','')
																																																		+	' '
																																																		+	L.OwnerState
																																																		+	' '
																																																		+	if(trim(L.OwnerZip,left,right)[1..5]	!=	'00000',trim(L.OwnerZip,left,right)[1..5],'')
																																																	),
																																			''
																																		)
																												);
	SELF.Append_RawAID		:=	0;
	SELF									:=	L;
END;

addr_prep	:=	PROJECT(dedup_addr,t_CleanAddress(LEFT));

// Pass only records where Append_PrepAddr2 is not blank
bad_primname_srch_ptrn	:=	'NONE|UNKNOWN|UNKNWN|UNKNOWEN|UNKNONW|UNKNON|UNKNWON|UNKONWN|UNEKNOWN|UN KNOWN|GENERAL DELIVERY';

addr_prep_addr_populated			:=	addr_prep(Append_PrepAddr2	!=	''	and	~(regexfind(bad_primname_srch_ptrn,Append_PrepAddr1,nocase)));
addr_prep_addr_not_populated	:=	addr_prep(~(Append_PrepAddr2	!=	''	and	~(regexfind(bad_primname_srch_ptrn,Append_PrepAddr1,nocase))));

// Pass the records to the AddressID macro to fetch the RawAID
AID.MacAppendFromRaw_2Line(	addr_prep_addr_populated,
														Append_PrepAddr1,
														Append_PrepAddr2,
														Append_RawAID,
														addr_clean_AppendAID,
														AID.Common.eReturnValues.RawAID
													);

// Combine the blank or invalid address records after passing to the AID macro
rCleanAddress_layout	tReformatAID(addr_clean_appendAID	L)	:=
transform
	self.Append_RawAID	:=	L.AIDWork_RawAID;
	self								:=	L;
end;

addr_clean	:=	project(addr_clean_AppendAID,tReformatAID(left))	+	addr_prep_addr_not_populated;

//-----------------------------------------------------------------
//APPEND CLEAN ADDRESS,NAME1 AND NAME2 TO CLEAN FILE
//-----------------------------------------------------------------
	
//Join Clean Address,populate company name fields when applicable,and get plate number from invalid owner names
VehicleV2.Layout_OH.Clean_Main	t_join_get_address (VehicleV2.Layout_OH.Prepped	L,addr_clean	R)	:=
TRANSFORM
	//Get invalid names with patterns like REPLACED BY [PlateNumber] OR EXCHANGED FOR [PlateNumber]
	BOOLEAN v_is_name1_invalid  	:=	IF(StringLib.StringFind(L.OwnerName,'EXCHANGED ',1) > 0 OR StringLib.StringFind(L.OwnerName,'REPLACED ',1) > 0,TRUE,FALSE);
	BOOLEAN v_is_name2_invalid  	:=	IF(StringLib.StringFind(L.AdditionalOwnerName,'EXCHANGED ',1) > 0 OR StringLib.StringFind(L.AdditionalOwnerName,'REPLACED ',1) > 0,TRUE,FALSE);
	STRING8 v_name1_invalid   		:=	IF(v_is_name1_invalid,StringLib.StringFindReplace(StringLib.StringFindReplace(L.OwnerName,'EXCHANGED FOR ',''),'REPLACED BY ',''),'');
	STRING8 v_name2_invalid   		:=	IF(v_is_name2_invalid,StringLib.StringFindReplace(StringLib.StringFindReplace(L.AdditionalOwnerName,'EXCHANGED FOR ',''),'REPLACED BY ',''),'');
	
	SELF.Orig_OwnerName						:=	L.OwnerName;
	SELF.Orig_AdditionalOwnerName	:=	L.AdditionalOwnerName;
	
	SELF.title       							:=	'';
	SELF.fname             				:=	'';
	SELF.mname             				:=	'';
	SELF.lname             				:=	'';
	SELF.name_suffix       				:=	'';
	SELF.name_score        				:=	'';
	//company names	
	SELF.company_name1 						:=	 IF(L.Append_OwnerNameTypeInd	=	'B',L.OwnerName,'');
	SELF.company_name2 						:=	 IF(L.Append_AddlOwnerNameTypeInd	=	'B',L.AdditionalOwnerName,'');
	
	//Get plate number from invalid names	
	SELF.prev_plate_from_name   	:=	IF((v_is_name1_invalid	OR	v_is_name2_invalid)	AND	v_name1_invalid	<>	'',
																				v_name1_invalid,
																				v_name2_invalid
																			);
	
	SELF.Append_PrepAddr1					:=	R.Append_PrepAddr1;
	SELF.Append_PrepAddr2					:=	R.Append_PrepAddr2;
	SELF.Append_RawAID						:=	R.Append_RawAID;

	SELF													:=	L;
END;

get_address :=	JOIN(	OH_Vehicle_Clean,
											addr_clean,
											LEFT.OwnerStreetAddress	=	RIGHT.OwnerStreetAddress	AND
											LEFT.OwnerCity					=	RIGHT.OwnerCity						AND	
											LEFT.OwnerState					=	RIGHT.OwnerState					AND
											LEFT.OwnerZip						=	RIGHT.OwnerZip,
											t_join_get_address(LEFT,RIGHT),
											LEFT OUTER,
											hash
										);

//-----------------------------------------------------------------
//NORMALIZE NAME AND CLEAN
//-----------------------------------------------------------------
rNormNames_layout	:=
RECORD
	STRING35	Name;
	STRING2		NameType;
	STRING1		NameTypeInd;
	STRING73	CleanName	:=	'';
END;

rNormNames_layout t_norm_name(VehicleV2.Layout_OH.Prepped	L,INTEGER	C)	:=
TRANSFORM
	 SELF.Name       	:=	CHOOSE(C,L.OwnerName,L.AdditionalOwnerName);
	 SELF.NameType  	:=	CHOOSE(C,'O1','O2');
	 SELF.NameTypeInd	:=	CHOOSE(C,L.Append_OwnerNameTypeInd,L.Append_AddlOwnerNameTypeInd);
	 SELF           	:=	L;
END;

norm_names 					:=	NORMALIZE(OH_Vehicle_Clean,2,t_norm_name(LEFT,COUNTER));

norm_names_filt 		:=	norm_names(	TRIM(Name,LEFT,RIGHT)	<>	''									and 
																		TRIM(Name,LEFT,RIGHT)	<>	','									and 
																		NameTypeInd						<>	'B'									and 
																		StringLib.StringFind(Name,'REPLACED ',1) = 0	and
																		StringLib.StringFind(Name,'EXCHANGED ',1) = 0
																	);

//-----------------------------------------------------------------
//DEDUP NAMES
//-----------------------------------------------------------------
d_names							:=	DISTRIBUTE(norm_names_filt,HASH(Name)); 
dedup_names 				:=	DEDUP(SORT(d_names,Name,LOCAL),Name,LOCAL) ; 

//-----------------------------------------------------------------
//STANDARDIZE NAME: Clean name
//-----------------------------------------------------------------
rNormNames_layout	t_CleanName(dedup_names	L)	:=
TRANSFORM
	//Names come in a varous formats: 1)F|M|L 2)LF,M  3)LF...and could be others.

	BOOLEAN		v_name_LFM								:=	IF(StringLib.StringFind(L.Name,',',1)	>	0,TRUE,FALSE);
	STRING35	v_reformat_replace_comma	:=	IF(v_name_LFM,REGEXREPLACE(',',L.Name,' '),'');
	UNSIGNED2	v_first_space_pos					:=	StringLib.stringfind(v_reformat_replace_comma,' ',1);
	
	//Format 2)LF,M is converted to L,FM and run through the function CleanPersonLFM73
	//All other name patters are run through CleanPerson73
	STRING35	v_reformat_name_LFM				:=	IF(	v_reformat_replace_comma	<>	'',
																							v_reformat_replace_comma[..v_first_space_pos	-	1]	+
																							','	+ 
																							v_reformat_replace_comma[v_first_space_pos..],
																							''
																						);
	SELF.CleanName											:=	IF(	v_name_LFM,
																							Address.CleanPersonLFM73(v_reformat_name_LFM),
																							Address.CleanPerson73(L.Name)
																						);
	SELF																:=	L;
END;

name_clean	:=	PROJECT(dedup_names,t_CleanName(LEFT)); 

//separete records with invalidnames
//Join Name1
VehicleV2.Layout_OH.Clean_Main	t_join_get_name1(get_address	L,name_clean	R)	:=
TRANSFORM
	STRING60 CompanyName   				:=	IF(	VehicleV2.IsVehicleCompany(L.OwnerName)								AND	
																				StringLib.StringFind(L.OwnerName,'EXCHANGED ',1)	= 0	AND
																				StringLib.StringFind(L.OwnerName,'REPLACED ',1)		= 0	AND
																				L.company_name1																		=	'',
																				L.OwnerName,
																				''
																			);
	SELF.title       							:=	IF(CompanyName = ''	and L.company_name1 = '',R.CleanName[1.. 5],'');
	SELF.fname       							:=	IF(CompanyName = ''	and L.company_name1 = '',R.CleanName[6..25],'');
	SELF.mname       							:=	IF(CompanyName = ''	and L.company_name1 = '',R.CleanName[26..45],'');
	SELF.lname       							:=	IF(CompanyName = ''	and L.company_name1 = '',R.CleanName[46..65],'');
	SELF.name_suffix 							:=	IF(CompanyName = ''	and L.company_name1 = '',R.CleanName[66..70],'');
	SELF.name_score  							:=	IF(CompanyName = ''	and	L.company_name1	= '',R.CleanName[71..73],'');
	SELF.company_name1 						:=	IF(L.company_name1	= '',CompanyName,L.company_name1);
	SELF													:=	L;

END;

get_name1	:=	JOIN(	DISTRIBUTE(get_address,HASH(OwnerName)),
										name_clean,
										LEFT.OwnerName = RIGHT.Name,
										t_join_get_name1(LEFT,RIGHT),
										LEFT OUTER,
										LOCAL
									);

//Join Name2
VehicleV2.Layout_OH.Clean_Main	t_join_get_name2 (get_name1	L,name_clean	R)	:=
TRANSFORM
	STRING60 CompanyName   				:=	IF(	VehicleV2.IsVehicleCompany(L.AdditionalOwnerName)								AND 
																				StringLib.StringFind(L.AdditionalOwnerName,'EXCHANGED ',1)	= 0	AND 
																				StringLib.StringFind(L.AdditionalOwnerName,'REPLACED ',1)		= 0	AND
																				L.company_name2																							=	'',
																				L.AdditionalOwnerName,
																				''
																			);
	SELF.title2       						:=	IF(CompanyName = '' and L.company_name2 = '',R.CleanName[1.. 5],'');
	SELF.fname2       						:=	IF(CompanyName = '' and L.company_name2 = '',R.CleanName[6..25],'');
	SELF.mname2       						:=	IF(CompanyName = '' and L.company_name2 = '',R.CleanName[26..45],'');
	SELF.lname2       						:=	IF(CompanyName = '' and L.company_name2 = '',R.CleanName[46..65],'');
	SELF.name_suffix2 						:=	IF(CompanyName = '' and L.company_name2 = '',R.CleanName[66..70],'');
	SELF.name_score2  						:=	IF(CompanyName = '' and L.company_name2 = '',R.CleanName[71..73],'');
	SELF.company_name2						:=	IF(L.company_name2 = '',CompanyName,L.company_name2);
	SELF													:=	L;
END;

get_name2 :=	JOIN(	get_name1(AdditionalOwnerName	!=	''),
										name_clean,
										LEFT.AdditionalOwnerName	=	RIGHT.Name,
										t_join_get_name2(LEFT,RIGHT),
										LEFT OUTER
									);

get_clean_name	:=	get_name2	+	get_name1(AdditionalOwnerName	=	'');

// Filtered out records which have "replaced" or "exchanged" in either OwnerName or AdditionalOwnerName - Bug# 41496
get_name2	tCleanName(get_clean_name	pInput)	:=
transform
	self.AdditionalOwnerName	:=	if(	regexfind('REPLACED |EXCHANGED ',pInput.AdditionalOwnerName),
																		'',
																		pInput.AdditionalOwnerName
																	);
	self											:=	pInput;
end;

get_final_clean	:=	project(get_clean_name,tCleanName(left));

// Distribute records evenly on all the nodes - Bug# 42581
get_final_clean_dist	:=	distribute(	get_final_clean((trim(OwnerName,left,right)	!= ''	or	trim(AdditionalOwnerName,left,right)	!=	'')
																											and
																											(~regexfind('REPLACED |EXCHANGED ',OwnerName,nocase))
																										 ),
																			random()
																		);

//---------------------------------------------------------------------------
//-------REFORMAT OH SOURCE TO VEHICLEV2 FORMAT AND APPEND AND VALIDATE VINA 
//---------------------------------------------------------------------------
VehicleV2.Layout_OH.OH_as_VehicleV2	OHToCommon(get_final_clean_dist	pLEFT)	:=
TRANSFORM
	SELF.dt_first_seen 									:=	IF(	pLEFT.RegistrationIssueDt				<=	pLEFT.ProcessDate	AND
																							TRIM(pLEFT.RegistrationIssueDt)	<>	'',
																							(integer)pLEFT.RegistrationIssueDt,
																							(integer)pLEFT.ProcessDate
																						);
	SELF.dt_last_seen 									:=	IF(	pLEFT.RegistrationIssueDt				<=	pLEFT.ProcessDate	AND
																							TRIM(pLEFT.RegistrationIssueDt)	<>	'',
																							(integer)pLEFT.RegistrationIssueDt,
																							(integer)pLEFT.ProcessDate
																						);
	SELF.dt_vendor_first_reported				:=	(integer)pLEFT.ProcessDate;
	SELF.dt_vendor_last_reported				:=	(integer)pLEFT.ProcessDate;
	SELF.Raw_VIN												:=	pLEFT.VIN;
	SELF.ORIG_VIN 											:=	pLEFT.VIN;
	SELF.YEAR_MAKE 											:=	IF((UNSIGNED)pLEFT.ModelYr	<>	0,pLEFT.ModelYr,'');
	SELF.Orig_MAKE_YEAR									:=	pLEFT.ModelYr;
	SELF.Orig_MAKE_CODE									:=	pLEFT.VehicleMake;
	SELF.MAKE_CODE 											:=	pLEFT.VehicleMake;
	SELF.Orig_BODY_CODE									:=	pLEFT.VehicleType;
	SELF.BODY_CODE 											:=	pLEFT.VehicleType;
	SELF.LICENSE_PLATE_NUMBERxBG4 			:=	pLEFT.PlateNum;
	SELF.Orig_RegistrationIssueDate			:=	pLEFT.RegistrationIssueDt;
	SELF.REGISTRATION_Effective_DATE 		:=	IF(	(UNSIGNED)pLEFT.RegistrationIssueDt	<>	0,
																							pLEFT.RegistrationIssueDt,
																							''
																						);
	SELF.Orig_RegistrationExpDate				:=	pLEFT.VehicleExpDt;
	SELF.REGISTRATION_EXPIRATION_DATE 	:=	IF((UNSIGNED)pLEFT.VehicleExpDt	<>	0,pLEFT.VehicleExpDt,''); 
	SELF.REGISTRATION_STATUS_CODE 			:=	'';
	SELF.TRUE_LICENSE_PLSTE_NUMBER 			:=	pLEFT.PlateNum;
	SELF.history 												:=	if(	SELF.REGISTRATION_EXPIRATION_DATE	<	((STRING8) Std.Date.Today())[1..6]	AND
																							(UNSIGNED4)(SELF.REGISTRATION_EXPIRATION_DATE[1..6])	<>	0,
																							'E',
																							''
																						);
	SELF.REGISTRANT_1_CUSTOMER_TYPE 		:=	map(	pLEFT.Append_OwnerNameTypeInd	in	['D','P']	=>	'I',
																								pLEFT.Append_OwnerNameTypeInd	=		'I'				=>	'W',
																								pLEFT.Append_OwnerNameTypeInd
																							);
	SELF.Orig_Reg_1_Customer_name				:=	pLEFT.Orig_OwnerName;
	SELF.REG_1_CUSTOMER_NAME 						:=	pLEFT.OwnerName;
	SELF.REG_1_STREET_ADDRESS 					:=	pLEFT.OwnerStreetAddress;
	SELF.REG_1_CITY 										:=	pLEFT.OwnerCity;
	SELF.REG_1_STATE 										:=	pLEFT.OwnerState;
	SELF.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	IF(	pLEFT.OwnerZip[6..9]	=	'0000',
																							pLEFT.OwnerZip[1..5],
																							pLEFT.OwnerZip[1..5]	+	'-'	+	pLEFT.OwnerZip[6..9]
																						);
	SELF.Orig_County										:=	pLEFT.CountyNumber;
	SELF.Orig_Reg_2_Customer_Name				:=	pLEFT.Orig_AdditionalOwnerName;
	SELF.REG_2_CUSTOMER_NAME 						:=	pLEFT.AdditionalOwnerName;
	SELF.REGISTRANT_2_CUSTOMER_TYPE 		:=	map(	pLEFT.Append_AddlOwnerNameTypeInd	in	['D','P']	=>	'I',
																								pLEFT.Append_AddlOwnerNameTypeInd	=		'I'				=>	'W',
																								pLEFT.Append_AddlOwnerNameTypeInd
																							);
	SELF.REG_2_STREET_ADDRESS 					:=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							pLEFT.OwnerStreetAddress,
																							''
																						);
	SELF.REG_2_CITY 										:=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							pLEFT.OwnerCity,
																							''
																						);
	SELF.REG_2_STATE 										:=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							pLEFT.OwnerState,
																							''
																						);
	SELF.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL :=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							IF(	pLEFT.OwnerZip[6..9]	=	'0000',
																									pLEFT.OwnerZip[1..5],
																									pLEFT.OwnerZip[1..5]	+	'-'	+	pLEFT.OwnerZip[6..9]
																								),
																							''
																						);
	SELF.TITLE_NUMBERxBG9 							:=	pLEFT.TitleNum;
	SELF.TITLE_ISSUE_DATE 							:=	IF(	(UNSIGNED)pLEFT.VehiclePurchaseDt	<>	0,
																							pLEFT.VehiclePurchaseDt,
																							''
																						);
	
	SELF.reg_1_title 										:=	pLEFT.title;
	SELF.reg_1_fname 										:=	pLEFT.fname;
	SELF.reg_1_mname 										:=	pLEFT.mname;
	SELF.reg_1_lname 										:=	pLEFT.lname;
	SELF.reg_1_name_suffix 							:=	pLEFT.name_suffix;
	SELF.reg_1_company_name 						:=	pLEFT.company_name1;
	
	SELF.Append_Reg1_PrepAddr1					:=	pLEFT.Append_PrepAddr1;
	SELF.Append_Reg1_PrepAddr2					:=	pLEFT.Append_PrepAddr2;
	SELF.Append_Reg1_RawAID							:=	pLEFT.Append_RawAID;
	
	SELF.reg_2_title 										:=	pLEFT.title2;
	SELF.reg_2_fname 										:=	pLEFT.fname2;
	SELF.reg_2_mname 										:=	pLEFT.mname2;
	SELF.reg_2_lname 										:=	pLEFT.lname2;
	SELF.reg_2_name_suffix 							:=	pLEFT.name_suffix2;
	SELF.reg_2_company_name 						:=	pLEFT.company_name2;
	
	SELF.Append_Reg2_PrepAddr1					:=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							pLEFT.Append_PrepAddr1,
																							''
																						);
	SELF.Append_Reg2_PrepAddr2					:=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							pLEFT.Append_PrepAddr2,
																							''
																						);
	SELF.Append_Reg2_RawAID							:=	IF(	TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																							pLEFT.Append_RawAID,
																							0
																						);

	SELF.PreviousPlateNum 							:=	pLEFT.PreviousPlateNum;
	SELF.VehiclePurchaseDt  						:=	IF((UNSIGNED)pLEFT.VehiclePurchaseDt	<>	0,pLEFT.VehiclePurchaseDt,'');
	SELF.Orig_VehicleTaxWeight					:=	pLEFT.VehicleTaxWeight;
	SELF.Orig_VehicleTaxCode						:=	pLEFT.VehicleTaxCode;
	SELF.Orig_GROSS_WEIGHT							:=	pLEFT.GrossWeight;
	SELF.Orig_NET_WEIGHT								:=	pLEFT.VehicleUnladdenWeight;
	SELF.CategoryCode										:=	pLEFT.CategoryCode;
	SELF.Vehicle_Type										:=	pLEFT.CategoryCode;
	SELF.Vehicle_Use										:=	TRIM(pLEFT.OwnerCode,all);
	
	SELF																:=	pLEFT;
	SELF																:=	[];
end;

veh_OH	:=	project(get_final_clean_dist,OHToCommon(LEFT));

EXPORT	Map_OH_Update	:=	veh_OH/*	:	persist('~thor_data400::persist::vehicleV2::oh_update')*/;