IMPORT  address, ut, header_slimsort, did_add, didville,watchdog;
#workunit('name','CP TU True Credit Clean & DID ' );

exp_credit := Transunion_PTrak.File_TU_CP_Credit_In;

//Normalize current name, alias, aka and former name

Transunion_PTrak.Layout_TU_CP_Credit_Out.Layout_TU_Norm_Name t_norm_name (Transunion_PTrak.Layout_TU_CP_Credit_In L, INTEGER C):= TRANSFORM
	 current_name 						:= StringLib.StringCleanSpaces((L.Last_Name +', '+ L.First_Name+ ' '+ L.Middle_Name +' '+ L.exp_Name_Suffix + ' ' + L.Name_Prefix));	
	 SELF.Name       					:= CHOOSE(C,current_name,L.AKA1,L.AKA2,L.AKA3);
	 SELF.NameType  					:= CHOOSE(C,'O','A1','A2','A3');
	 SELF.Address1						:= StringLib.StringCleanSpaces(L.House_Number + ' ' + L.Street_Direction + ' ' + L.Street_Name + ' ' + L.Street_Type + ' ' + L.Street_Post_Direction);
	 SELF.Address2                      := StringLib.StringCleanSpaces(L.Unit_Type + ' ' + L.Unit_Number);
	 SELF           					:= L;
END;

norm_names := NORMALIZE(exp_credit, 4, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(TRIM(Name,all) <> '' AND TRIM(Name,all) <> ',') : persist ('TU_cp_credit_norm_names');

//-----------------------------------------------------------------
//CLEAN NAMES AND ADDRESSES AND JOIN CLEAN NAMES and ADDRESSES TO MAIN OUTPUT FILE: 
//join clean addresses, clean names
//-----------------------------------------------------------------
//filter data with blank names, names = ',' or length 1
d_norm_data 			:= DISTRIBUTE(norm_names_filtered, HASH(Name));

//-----------------------------------------------------------------
//CLEAN NAMES
//-----------------------------------------------------------------
//DEDUP Names
d_names:= DISTRIBUTE(norm_names_filtered, HASH(Name)); 
dedup_names := DEDUP(SORT(d_names,Name,LOCAL),Name, LOCAL) ; 

Transunion_PTrak.Layout_TU_CP_Credit_Out.Norm_Cleand_NameRec t_CleanName(dedup_names L) := TRANSFORM
	SELF.Clean_Name := addrcleanlib.cleanpersonfml73(L.Name);
	SELF := L;
END;
name_clean := PROJECT(dedup_names, t_CleanName(LEFT)); 

	//Join Clean Name
Transunion_PTrak.Layout_TU_CP_Credit_Out.Layout_TU_Norm_Clean_Name t_join_get_name (d_norm_data L, name_clean R) := TRANSFORM
	SELF.title       	:= R.Clean_Name[ 1.. 5];
	SELF.fname       	:= R.Clean_Name[ 6..25];
	SELF.mname       	:= R.Clean_Name[26..45];
	SELF.lname       	:= R.Clean_Name[46..65];
	SELF.name_suffix 	:= R.Clean_Name[66..70];
	SELF.name_score  	:= R.Clean_Name[71..73];
	SELF				:= L;
	SELF				:= [];
END;

get_name := JOIN (d_norm_data, DISTRIBUTE(name_clean, HASH(Name)), LEFT.Name = RIGHT.Name,
					t_join_get_name(LEFT,RIGHT), LEFT OUTER, LOCAL);
					
					
//-----------------------------------------------------------------
//CLEAN ADDRESSES
//-----------------------------------------------------------------

norm_addresses :=  norm_names_filtered (Address1 <> '' OR  Address2  <> '' OR  TRIM(exp_city,all) <> '' OR  TRIM(exp_state,all) <> '' OR  TRIM(exp_zip_code,all) <> '' );
d_addresses:= DISTRIBUTE(norm_addresses,HASH(Address1, Address2, exp_city,exp_state, exp_zip_code)); 
dedup_addr := DEDUP(SORT(d_addresses,Address1, Address2, exp_city,exp_state, exp_zip_code,LOCAL),Address1, Address2, exp_city,exp_state, exp_zip_code, LOCAL) ; 

Transunion_PTrak.Layout_TU_CP_Credit_Out.Norm_Clean_Address_Rec t_Clean_Address(dedup_addr L) := TRANSFORM
	SELF.Address1 := L.Address1;
	SELF.Address2 := L.Address2;
	SELF.City := L.exp_City;
	SELF.State := L.exp_state;
	SELF.ZipCode := L.exp_zip_code;
	SELF.Clean_Address := addrcleanlib.CleanAddress182(L.Address1 + ' ' + L.Address2, L.exp_city + ' ' + L.exp_state+ ' ' + L.exp_zip_code);
	SELF := L;
END;

addr_clean := PROJECT(dedup_addr, t_Clean_Address(LEFT))  : persist ('TU_cp_credit_clean_address'); 


//-----------------------------------------------------------------
//JOIN CLEAN ADDRESS BACK TO NORMALIZED DATA
//-----------------------------------------------------------------

	//Filter data with no address
filt_address 	:= get_name(TRIM(Address1,all) <> '' OR  TRIM(Address2,all)  <> '' OR  TRIM(exp_city,all) <> '' OR  TRIM(exp_state,all) <> '' OR  TRIM(exp_zip_code,all) <> '' );
blank_address 	:= get_name(TRIM(Address1,all) = '' AND  TRIM(Address2,all)  = '' AND  TRIM(exp_city,all) = '' AND  TRIM(exp_state,all) = '' AND  TRIM(exp_zip_code,all) <> '' );

invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

	//Join Clean Address
Transunion_PTrak.Layout_TU_CP_Credit_Out.Layout_TU_Norm_Clean_Address t_join_get_address (filt_address  L, addr_clean  R) := TRANSFORM
	STRING28  v_prim_name := R.Clean_Address[13..40];
	STRING5   v_zip       := R.Clean_Address[117..121];
	STRING4   v_zip4      := R.Clean_Address[122..125];
	SELF.prim_range  	:= R.Clean_Address[ 1..  10];
	SELF.predir      	:= R.Clean_Address[ 11.. 12];
	SELF.prim_name   	:= IF(TRIM(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 	:= R.Clean_Address[ 41.. 44];
	SELF.postdir     	:= R.Clean_Address[ 45.. 46];
	SELF.unit_desig  	:= R.Clean_Address[ 47.. 56];
	SELF.sec_range   	:= R.Clean_Address[ 57.. 64];
	SELF.p_city_name 	:= R.Clean_Address[ 65.. 89];
	SELF.v_city_name 	:= R.Clean_Address[ 90..114];
	SELF.st          	:= R.Clean_Address[115..116];
	SELF.zip         	:= IF(v_zip='00000','',v_zip);
	SELF.zip4       	 := IF(v_zip4='0000','',v_zip4);
	SELF.cart        	:= R.Clean_Address[126..129];
	SELF.cr_sort_sz  	:= R.Clean_Address[130..130];
	SELF.lot         	:= R.Clean_Address[131..134];
	SELF.lot_order   	:= R.Clean_Address[135..135];
	SELF.dbpc        	:= R.Clean_Address[136..137];
	SELF.chk_digit   	:= R.Clean_Address[138..138];
	SELF.rec_type    	:= R.Clean_Address[139..140];
	SELF.county      	:= R.Clean_Address[141..145];
	SELF.geo_lat     	:= R.Clean_Address[146..155];
	SELF.geo_long    	:= R.Clean_Address[156..166];
	SELF.msa         	:= R.Clean_Address[167..170];
	SELF.geo_blk     	:= R.Clean_Address[171..177];
	SELF.geo_match   	:= R.Clean_Address[178..178];
	SELF.err_stat    	:= R.Clean_Address[179..182];
	SELF:= L ;
END;

t_get_address := JOIN (	DISTRIBUTE(filt_address, HASH(Address1, Address2, exp_City, exp_State, exp_Zip_code)) , 
						DISTRIBUTE(addr_clean ,HASH(Address1, Address2, City, State, ZipCode)) ,
										LEFT.Address1 = RIGHT.Address1 AND
										LEFT.Address2 = RIGHT.Address2 AND	
										LEFT.exp_City = RIGHT.City AND
										LEFT.exp_State = RIGHT.State AND
										LEFT.exp_Zip_code = RIGHT.ZipCode,
										t_join_get_address(LEFT,RIGHT), LEFT OUTER, LOCAL);

	//Transform Records with blank addresses to reformat to the same layout as the data with clean address
Transunion_PTrak.Layout_TU_CP_Credit_Out.Layout_TU_Norm_Clean_Address t_transform_layout_address (blank_address L) := TRANSFORM
	SELF 				:= L;
	SELF				:=[];
END;

t_blank_address := PROJECT(blank_address, t_transform_layout_address(LEFT));

	//Concatenate data with clean addresses and blank addresses
get_address := t_get_address + t_blank_address;
										

//-----------------------------------------------------------------
//APPEND DID
//-----------------------------------------------------------------
								   
matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(get_address , matchset,					
	 SSN,Date_of_Birth, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 DID, Transunion_PTrak.Layout_TU_CP_Credit_Out.Layout_TU_All_Out, true, DID_Score_field,
	 75, d_did)

//-----------------------------------------------------------------
//BUILD
//-----------------------------------------------------------------
ut.mac_sf_buildprocess(d_did, '~thor400::base::TU_cp_credit', build_TUCred_base, 2,,TRUE);

//---------------------------------------------------------------------------------

EXPORT Proc_TU_CP_Credit_Clean_DID := SEQUENTIAL(//for_cash_address,
															//address_clean_final,
															//FileServices.StartSuperFileTransaction(),
															//FileServices.AddSuperFile('~thor_data400::in::transunionptrak_cash_address','~thor_data400::in::transunionptrak_cash_address_' + ut.GetDate ),
															//FileServices.AddSuperFile('~thor_data400::in::transunion_CP_cleaned','~~thor_data400::in::transunion_CP_cleaned_' + ut.GetDate ),
															//FileServices.FinishSuperFileTransaction(),
															//outputclean,
															//FileServices.StartSuperFileTransaction(),
															//FileServices.AddSuperFile('~thor_data400::in::transunion_CP_clean_normalized','~thor_data400::in::transunion_CP_clean_normalized_' + ut.GetDate ),
															//FileServices.FinishSuperFileTransaction(),
															build_TUCred_base
															);



