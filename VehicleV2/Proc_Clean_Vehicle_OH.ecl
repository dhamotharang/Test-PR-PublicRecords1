IMPORT ut, Address;
export Proc_Clean_Vehicle_OH (STRING FileDate):= FUNCTION
//-----------------------------------------------------------------
//NORMALIZE NAME
//-----------------------------------------------------------------
VehicleV2.Layout_OH_Clean.Layout_Norm_Names t_norm_name (VehicleV2.Layout_OH_In L, INTEGER C):= TRANSFORM
	 SELF.Name       	:= CHOOSE(C,L.OwnerName,L.AdditionalOwnerName);
	 SELF.NameType  	:= CHOOSE(C,'O1','O2');
	 SELF           	:= L;
END;

norm_names 					:= NORMALIZE(VehicleV2.File_Vehicle_OH_IN, 2, t_norm_name(LEFT, COUNTER));

norm_names_filt 		:= norm_names(TRIM(Name, LEFT,RIGHT) <> ''									and 
																	TRIM(Name, LEFT,RIGHT) <> ','									and 
																	~ut.IsCompany(Name)														and 
																	StringLib.StringFind(Name, 'REPLACED ',1) = 0	and
																	StringLib.StringFind(Name, 'EXCHANGED ',1) = 0);

//-----------------------------------------------------------------
//DEDUP NAMES
//-----------------------------------------------------------------
d_names							:= DISTRIBUTE(norm_names_filt, HASH(Name)); 
dedup_names 				:= DEDUP(SORT(d_names,Name,LOCAL),Name, LOCAL) ; 

//-----------------------------------------------------------------
//DEDUP ADDRESSES
//-----------------------------------------------------------------
d_addresses					:= DISTRIBUTE(VehicleV2.File_Vehicle_OH_IN,HASH(OwnerStreetAddress, OwnerCity, OwnerState, OwnerZip)); 
dedup_addr 					:= DEDUP(SORT(d_addresses,OwnerStreetAddress, OwnerCity, OwnerState, OwnerZip, LOCAL),OwnerStreetAddress, OwnerCity, OwnerState, OwnerZip, LOCAL) ; 

//-----------------------------------------------------------------
//STANDARDIZE NAME: Clean name
//-----------------------------------------------------------------
VehicleV2.Layout_OH_Clean.Layout_Norm_Names_Clean t_CleanName(dedup_names L) := TRANSFORM
	//Names come in a varous formats: 1)F|M|L 2)LF,M  3)LF...and could be others.

	BOOLEAN v_name_LFM := IF(StringLib.StringFind(L.Name, ',' , 1) > 0, TRUE, FALSE);
	STRING35 v_reformat_replace_comma := IF (v_name_LFM, REGEXREPLACE(',', L.Name, ' '), '');
	UNSIGNED2 v_first_space_pos:= StringLib.stringfind(v_reformat_replace_comma, ' ', 1);
	
	//Format 2)LF,M is converted to L,FM and run through the function CleanPersonLFM73
	//All other name patters are run through CleanPerson73
	STRING35 v_reformat_name_LFM := IF (v_reformat_replace_comma <> '', v_reformat_replace_comma[..v_first_space_pos - 1] + ',' +  v_reformat_replace_comma[v_first_space_pos..],'');
	SELF.CleanName := IF(v_name_LFM, Address.CleanPersonLFM73(v_reformat_name_LFM), Address.CleanPerson73(L.Name));
	SELF := L;
END;

name_clean := PROJECT(dedup_names, t_CleanName(LEFT)); 


//-----------------------------------------------------------------
//STANDARDIZE ADDRESS: Clean address
//-----------------------------------------------------------------
VehicleV2.Layout_OH_Clean.Layout_Addresses_Clean t_CleanAddress(dedup_addr L) := TRANSFORM
	SELF.CleanAddress := Address.cleanaddress182(L.OwnerStreetAddress, L.OwnerCity + ' ' + L.OwnerState + ' ' + L.OwnerZip);
	SELF := L;
END;

addr_clean := PROJECT(dedup_addr, t_CleanAddress(LEFT)); 

//-----------------------------------------------------------------
//APPEND CLEAN ADDRESS, NAME1 AND NAME2 TO CLEAN FILE
//-----------------------------------------------------------------
	
//Join Clean Address, populate company name fields when applicable, and get plate number from invalid owner names
invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

VehicleV2.Layout_OH_Clean.Layout_OH_Clean_Main t_join_get_address (VehicleV2.Layout_OH_In  L, addr_clean R) := TRANSFORM

	//Get invalid names with patterns like REPLACED BY [PlateNumber] OR EXCHANGED FOR [PlateNumber]
	BOOLEAN v_is_name1_invalid  	:= IF(StringLib.StringFind(L.OwnerName, 'EXCHANGED ',1) > 0 OR StringLib.StringFind(L.OwnerName, 'REPLACED ',1) > 0,TRUE, FALSE);
	BOOLEAN v_is_name2_invalid  	:= IF(StringLib.StringFind(L.AdditionalOwnerName, 'EXCHANGED ',1) > 0 OR StringLib.StringFind(L.AdditionalOwnerName, 'REPLACED ',1) > 0,TRUE, FALSE);
	STRING8 v_name1_invalid   		:= IF(v_is_name1_invalid, StringLib.StringFindReplace(StringLib.StringFindReplace(L.OwnerName, 'EXCHANGED FOR ',''), 'REPLACED BY ',''), '');
	STRING8 v_name2_invalid   		:= IF(v_is_name2_invalid, StringLib.StringFindReplace(StringLib.StringFindReplace(L.AdditionalOwnerName, 'EXCHANGED FOR ',''), 'REPLACED BY ',''),'');
	STRING28  v_prim_name 				:= R.CleanAddress[13..40];
	STRING5   v_zip       				:= R.CleanAddress[117..121];
	STRING4   v_zip4      				:= R.CleanAddress[122..125];
	SELF.ProcessDate							:= (STRING8) FileDate;
	SELF.prim_range  							:= R.CleanAddress[ 1..  10];
	SELF.predir      							:= R.CleanAddress[ 11.. 12];
	SELF.prim_name   							:= IF(TRIM(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 							:= R.CleanAddress[ 41.. 44];
	SELF.postdir     							:= R.CleanAddress[ 45.. 46];
	SELF.unit_desig  							:= R.CleanAddress[ 47.. 56];
	SELF.sec_range   							:= R.CleanAddress[ 57.. 64];
	SELF.p_city_name 							:= R.CleanAddress[ 65.. 89];
	SELF.v_city_name 							:= R.CleanAddress[ 90..114];
	SELF.st          							:= R.CleanAddress[115..116];
	SELF.zip         							:= IF(v_zip='00000','',v_zip);
	SELF.zip4        							:= IF(v_zip4='0000','',v_zip4);
	SELF.cart        							:= R.CleanAddress[126..129];
	SELF.cr_sort_sz  							:= R.CleanAddress[130..130];
	SELF.lot         							:= R.CleanAddress[131..134];
	SELF.lot_order   							:= R.CleanAddress[135..135];
	SELF.dbpc        							:= R.CleanAddress[136..137];
	SELF.chk_digit   							:= R.CleanAddress[138..138];
	SELF.rec_type    							:= R.CleanAddress[139..140];
	SELF.county      							:= R.CleanAddress[141..145];
	SELF.geo_lat     							:= R.CleanAddress[146..155];
	SELF.geo_long    							:= R.CleanAddress[156..166];
	SELF.msa         							:= R.CleanAddress[167..170];
	SELF.geo_blk     							:= R.CleanAddress[171..177];
	SELF.geo_match   							:= R.CleanAddress[178..178];
	SELF.err_stat    							:= R.CleanAddress[179..182];
	SELF.title       							:= '';
	SELF.fname             				:= '';
	SELF.mname             				:= '';
	SELF.lname             				:= '';
	SELF.name_suffix       				:= '';
	SELF.name_score        				:= '';
	//company names	
	SELF.company_name1 						:=  IF(ut.IsCompany(L.OwnerName), L.OwnerName, '');
	SELF.company_name2 						:=  IF(ut.IsCompany(L.AdditionalOwnerName), L.AdditionalOwnerName,'');
	
	//Get plate number from invalid names	
	SELF.prev_plate_from_name   	:= IF ((v_is_name1_invalid OR v_is_name2_invalid) AND v_name1_invalid <> '', v_name1_invalid, v_name2_invalid);
	
	SELF.OwnerStreetAddress				:= IF(~REGEXFIND('[^[:alnum:]]',L.OwnerStreetAddress) , VehicleV2.FN_Clean_String_Garbage(L.OwnerStreetAddress), L.OwnerStreetAddress);
	SELF.OwnerCity								:= IF(~REGEXFIND('[^[:alnum:]]',L.OwnerCity), VehicleV2.FN_Clean_String_Garbage(L.OwnerCity), L.OwnerCity);
	SELF.OwnerState								:= IF(~REGEXFIND('[^[:alnum:]]',L.OwnerState), VehicleV2.FN_Clean_String_Garbage(L.OwnerState), L.OwnerState);
	SELF.OwnerZip									:= IF(~REGEXFIND('[^[:alnum:]]',L.OwnerZip), VehicleV2.FN_Clean_String_Garbage(L.OwnerZip), L.OwnerZip);
	/*
	SELF.VIN											:= IF(~REGEXFIND('[^[:alnum:]]',L.VIN), VehicleV2.FN_Clean_String_Garbage(L.VIN), L.VIN);
	SELF.TitleNum									:= IF(~REGEXFIND('[^[:alnum:]]',L.TitleNum), VehicleV2.FN_Clean_String_Garbage(L.TitleNum), L.TitleNum);
	SELF.PlateNum									:= IF(~REGEXFIND('[^[:alnum:]]',L.PlateNum), VehicleV2.FN_Clean_String_Garbage(L.PlateNum), L.PlateNum);
	SELF.PreviousPlateNum					:= IF(~REGEXFIND('[^[:alnum:]]',L.PreviousPlateNum), VehicleV2.FN_Clean_String_Garbage(L.PreviousPlateNum), L.PreviousPlateNum);
	SELF.RegistrationIssueDt			:= IF(~REGEXFIND('[^[:alnum:]]',L.RegistrationIssueDt), VehicleV2.FN_Clean_String_Garbage(L.RegistrationIssueDt), L.RegistrationIssueDt);
	SELF.VehicleMake							:= IF(~REGEXFIND('[^[:alnum:]]',L.VehicleMake), VehicleV2.FN_Clean_String_Garbage(L.VehicleMake), L.VehicleMake);
	SELF.VehicleType							:= IF(~REGEXFIND('[^[:alnum:]]',L.VehicleType), VehicleV2.FN_Clean_String_Garbage(L.VehicleType), L.VehicleType);
	SELF.VehicleExpDt							:= IF(~REGEXFIND('[^[:alnum:]]',L.VehicleExpDt), VehicleV2.FN_Clean_String_Garbage(L.VehicleExpDt), L.VehicleExpDt);
	SELF.VehicleTaxCode						:= IF(~REGEXFIND('[^[:alnum:]]',L.VehicleTaxCode), VehicleV2.FN_Clean_String_Garbage(L.VehicleTaxCode), L.VehicleTaxCode);
	*/
	SELF:= L;
END;

get_address := JOIN(DISTRIBUTE(VehicleV2.File_Vehicle_OH_IN, HASH(OwnerStreetAddress, OwnerCity, OwnerState, OwnerZip)),
										addr_clean, 
										LEFT.OwnerStreetAddress = RIGHT.OwnerStreetAddress AND
										LEFT.OwnerCity = RIGHT.OwnerCity AND	
										LEFT.OwnerState= RIGHT.OwnerState AND
										LEFT.OwnerZip = RIGHT.OwnerZip,
										t_join_get_address(LEFT,RIGHT),
										LEFT OUTER,
										LOCAL);


//separete records with invalidnames
//Join Name1
VehicleV2.Layout_OH_Clean.Layout_OH_Clean_Main t_join_get_name1 (get_address  L, name_clean R) := TRANSFORM
	STRING60 CompanyName   				:= IF(VehicleV2.IsVehicleCompany(L.OwnerName)								AND
																			StringLib.StringFind(L.OwnerName, 'EXCHANGED ',1) = 0	AND 
																			StringLib.StringFind(L.OwnerName, 'REPLACED ',1) = 0	AND
																			L.company_name1 = '',
																			L.OwnerName,
																			''
																			);
	SELF.title       							:= IF(CompanyName = '' and L.company_name1 = '',R.CleanName[1.. 5],'');
	SELF.fname       							:= IF(CompanyName = '' and L.company_name1 = '',R.CleanName[6..25],'');
	SELF.mname       							:= IF(CompanyName = '' and L.company_name1 = '',R.CleanName[26..45],'');
	SELF.lname       							:= IF(CompanyName = '' and L.company_name1 = '',R.CleanName[46..65],'');
	SELF.name_suffix 							:= IF(CompanyName = '' and L.company_name1 = '',R.CleanName[66..70],'');
	SELF.name_score  							:= IF(CompanyName = '' and L.company_name1 = '',R.CleanName[71..73],'');
	SELF.company_name1 						:= IF(L.company_name1 = '', CompanyName, L.company_name1);
	SELF													:= L;

END;

get_name1 := JOIN(DISTRIBUTE(get_address , HASH(OwnerName)),
									name_clean , 
									LEFT.OwnerName = RIGHT.Name,
									t_join_get_name1(LEFT,RIGHT),
									LEFT OUTER,
									LOCAL);


//Join Name2
VehicleV2.Layout_OH_Clean.Layout_OH_Clean_Main t_join_get_name2 (get_name1 L, name_clean R) := TRANSFORM
	STRING60 CompanyName   				:= IF(VehicleV2.IsVehicleCompany(L.AdditionalOwnerName)								AND 
																			StringLib.StringFind(L.AdditionalOwnerName, 'EXCHANGED ',1) = 0	AND 
																			StringLib.StringFind(L.AdditionalOwnerName, 'REPLACED ',1) = 0	AND
																			L.company_name2 = '',
																			L.AdditionalOwnerName,
																			''
																			);
	SELF.title2       						:= IF(CompanyName = '' and L.company_name2 = '',R.CleanName[1.. 5],'');
	SELF.fname2       						:= IF(CompanyName = '' and L.company_name2 = '',R.CleanName[6..25],'');
	SELF.mname2       						:= IF(CompanyName = '' and L.company_name2 = '',R.CleanName[26..45],'');
	SELF.lname2       						:= IF(CompanyName = '' and L.company_name2 = '',R.CleanName[46..65],'');
	SELF.name_suffix2 						:= IF(CompanyName = '' and L.company_name2 = '',R.CleanName[66..70],'');
	SELF.name_score2  						:= IF(CompanyName = '' and L.company_name2 = '',R.CleanName[71..73],'');
	SELF.company_name2						:= IF(L.company_name2 = '', CompanyName, L.company_name2);
	SELF													:= L;
END;

get_name2 := JOIN(DISTRIBUTE(get_name1, HASH(AdditionalOwnerName)),
									name_clean , 
									LEFT.AdditionalOwnerName = RIGHT.Name,
									t_join_get_name2(LEFT,RIGHT),
									LEFT OUTER,
									LOCAL);

// Filtered out records which have "replaced" or "exchanged" in either OwnerName or AdditionalOwnerName - Bug# 41496
get_name2	tCleanName(get_name2	pInput)	:=
transform
	self.OwnerName						:=	if(	~REGEXFIND('[^[:alnum:]]',pInput.OwnerName),
																		VehicleV2.FN_Clean_String_Garbage(pInput.OwnerName),
																		pInput.OwnerName
																	);
	self.AdditionalOwnerName	:=	if(	regexfind('REPLACED |EXCHANGED ', pInput.AdditionalOwnerName),
																		'',
																		if(	~REGEXFIND('[^[:alnum:]]', pInput.AdditionalOwnerName),
																				VehicleV2.FN_Clean_String_Garbage(pInput.AdditionalOwnerName),
																				pInput.AdditionalOwnerName
																			)
																	);
	self											:=	pInput;
end;

get_final_clean  := project(get_name2, tCleanName(left));

// Distribute records evenly on all the nodes - Bug# 42581
get_final_clean_dist	:=	distribute(	get_final_clean((trim(OwnerName, left, right) != '' or trim(AdditionalOwnerName, left, right) != '')
																											and
																											(~regexfind('REPLACED |EXCHANGED ', OwnerName, nocase))
																										 ),
																			random()
																		);

outputclean := output(get_final_clean_dist,,'~thor_data400::in::vehreg_OH_update_clean_' + FileDate,overwrite,__compressed__);

BuildClean:= SEQUENTIAL(outputclean,
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::vehreg_OH_update_clean','~thor_data400::in::vehreg_OH_update_clean_' + FileDate),
												FileServices.AddSuperFile('~thor_data400::in::vehreg_OH_DI_update_archive', '~thor_data400::in::vehreg_OH_DI_update',, true),
												FileServices.ClearSuperFile('~thor_data400::in::vehreg_OH_DI_update'),
												FileServices.FinishSuperFileTransaction()
												);

RETURN BuildClean;

END;