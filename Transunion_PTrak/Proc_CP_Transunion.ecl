IMPORT  address, ut, header_slimsort, did_add, didville,watchdog;
#workunit('name','CP Transunion Clean & DID ' );
//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
	//current name, alias, aka and former name

Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Norm_Name t_norm_name (Transunion_PTrak.Layout_CP_Tucs_In L, INTEGER C):= TRANSFORM
	 current_name 						:= StringLib.StringCleanSpaces((L.LAST_NM+', '+L.FIRST_NM+' '+ L.MIDDLE_NM +' '+ L.NM_SUFX + ' ' + L.NM_PRFX));
	 SELF.Name       					:= CHOOSE(C,current_name,L.AKA1_NM,L.AKA2_NM,L.AKA3_NM);
	 SELF.NameType  					:= CHOOSE(C,'O','A1','A2','A3');
	 SELF.Address1						:= StringLib.StringCleanSpaces(L.ADDR_PRMRY_RNGE + ' ' + L.ADDR_PRE_DIR + ' ' + L.ADDR_PRMRY_NM + ' ' + L.ADDR_SUFX + ' ' + L.ADDR_POST_DIR);
	 SELF.Address2                      := StringLib.StringCleanSpaces(L.ADDR_SCNDY_RNGE + ' ' + L.ADDR_UNIT_DSGNTR);
	 SELF           					:= L;
END;

norm_names := NORMALIZE(Transunion_Ptrak.File_CP_Transunion_Full_In, 4, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(TRIM(Name,all) <> '' AND TRIM(Name,all) <> ',') : persist ('transunion_cp_norm_names');

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

Transunion_PTrak.Layout_Transunion_Out.NormCleandNameRec t_CleanName(dedup_names L) := TRANSFORM
	SELF.CleanName := address.cleanpersonfml73(L.Name);
	SELF := L;
END;
name_clean := PROJECT(dedup_names, t_CleanName(LEFT)); 

	//Join Clean Name
Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Final_Out t_join_get_name (d_norm_data L, name_clean R) := TRANSFORM
	SELF.title       	:= R.CleanName[ 1.. 5];
	SELF.fname       	:= R.CleanName[ 6..25];
	SELF.mname       	:= R.CleanName[26..45];
	SELF.lname       	:= R.CleanName[46..65];
	SELF.name_suffix 	:= R.CleanName[66..70];
	SELF.name_score  	:= R.CleanName[71..73];
	SELF				:= L;
	SELF				:= [];
END;

get_name := JOIN (d_norm_data, DISTRIBUTE(name_clean, HASH(Name)), LEFT.Name = RIGHT.Name,
					t_join_get_name(LEFT,RIGHT), LEFT OUTER, LOCAL);
					
					
//-----------------------------------------------------------------
//CLEAN ADDRESSES
//-----------------------------------------------------------------
norm_addresses :=  norm_names_filtered (TRIM(Address1,all) <> '' OR  TRIM(Address2,all)  <> '' OR  TRIM(ADDR_CITY_FULL_NM,all) <> '' OR  TRIM(ADDR_STATE_CD,all) <> '' OR  TRIM(ADDR_ZIP5_CD,all) <> '' );
cash_address		:= Transunion_PTrak.File_Transunion_Cash_Address;
d_addresses:= DISTRIBUTE(norm_addresses,HASH(Address1, Address2, ADDR_CITY_FULL_NM,ADDR_STATE_CD, ADDR_ZIP5_CD)); 
dedup_addr := DEDUP(SORT(d_addresses,Address1, Address2, ADDR_CITY_FULL_NM, ADDR_STATE_CD, ADDR_ZIP5_CD,LOCAL),Address1, Address2, ADDR_CITY_FULL_NM, ADDR_STATE_CD, ADDR_ZIP5_CD, LOCAL) ; 

//-----------------------------------------------------------------
//CHECK CASH ADDRESS TO APPEND DATA THAT HAS ALREADY BEEN CLEANED
//-----------------------------------------------------------------
Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec t_GetCleanAddress (dedup_addr L, cash_address R) := TRANSFORM
	SELF.NormAddress.Address1 	  := L.Address1	;
	SELF.NormAddress.Address2 	  := L.Address2	;
	SELF.NormAddress.City 		  := L.ADDR_CITY_FULL_NM	;
	SELF.NormAddress.State 		  := L.ADDR_STATE_CD	;
	SELF.NormAddress.ZipCode	  := L.ADDR_ZIP5_CD 	;
	SELF.NormAddress.UpdatedDate  := L.ADDR_DT	;	
	SELF.CleanAddress := R.CleanAddress;
	SELF := L;
END;
		//Join to Cash Address only if it has data
address_from_cash := JOIN(dedup_addr,DISTRIBUTE(cash_address,HASH(NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode)), 
																LEFT.Address1 			= RIGHT.NormAddress.Address1 AND
																LEFT.Address2 			= RIGHT.NormAddress.Address2 AND
																LEFT.ADDR_CITY_FULL_NM  = RIGHT.NormAddress.City     AND
																LEFT.ADDR_STATE_CD    	= RIGHT.NormAddress.State    AND
																LEFT.ADDR_ZIP5_CD  		= RIGHT.NormAddress.ZipCode,
																t_GetCleanAddress(LEFT,RIGHT), LEFT OUTER, LOCAL);
																
address_to_clean				:= address_from_cash (CleanAddress = '');
clean_address_from_cash	:= address_from_cash (CleanAddress <> '');

//clean left over addresses
Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec t_CleanAddress(address_to_clean L) := TRANSFORM
	SELF.CleanAddress := address.cleanaddress182(L.NormAddress.Address1 + ' ' + L.NormAddress.Address2, L.NormAddress.City + ' ' + L.NormAddress.State + ' ' + L.NormAddress.ZipCode);
	SELF := L;
END;

addr_clean := PROJECT(address_to_clean, t_CleanAddress(LEFT)); 

//Add clean address to cash address superfile

for_cash_address		:= OUTPUT(addr_clean,,'~thor_data400::in::transunionptrak_cash_address_' + ut.GetDate ,overwrite,__compressed__);
address_clean_final		:= OUTPUT(IF(EXISTS(addr_clean) AND EXISTS(clean_address_from_cash), clean_address_from_cash + addr_clean,
							  	IF(EXISTS(addr_clean), addr_clean, clean_address_from_cash))
									,,'~thor_data400::in::transunion_CP_cleaned_'+ut.GetDate,overwrite,__compressed__);

//-----------------------------------------------------------------
//JOIN CLEAN ADDRESS BACK TO NORMALIZED DATA
//-----------------------------------------------------------------

	//Filter data with no address
filt_address 	:= get_name(TRIM(Address1,all) <> '' OR  TRIM(Address2,all)  <> '' OR  TRIM(ADDR_CITY_FULL_NM,all) <> '' OR  TRIM(ADDR_STATE_CD,all) <> '' OR  TRIM(ADDR_ZIP5_CD,all) <> '' );
blank_address 	:= get_name(TRIM(Address1,all) = '' AND  TRIM(Address2,all)  = '' AND  TRIM(ADDR_CITY_FULL_NM,all) = '' AND  TRIM(ADDR_STATE_CD,all) = '' AND  TRIM(ADDR_ZIP5_CD,all) <> '' );

//Clean Addresses
clean_addr := DATASET('~thor_data400::in::transunion_cp_cleaned', Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec, FLAT);

invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

	//Join Clean Address
Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Final_Out t_join_get_address (filt_address  L, clean_addr R) := TRANSFORM
	STRING28  v_prim_name := R.CleanAddress[13..40];
	STRING5   v_zip       := R.CleanAddress[117..121];
	STRING4   v_zip4      := R.CleanAddress[122..125];
	SELF.prim_range  	:= R.CleanAddress[ 1..  10];
	SELF.predir      	:= R.CleanAddress[ 11.. 12];
	SELF.prim_name   	:= IF(TRIM(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 	:= R.CleanAddress[ 41.. 44];
	SELF.postdir     	:= R.CleanAddress[ 45.. 46];
	SELF.unit_desig  	:= R.CleanAddress[ 47.. 56];
	SELF.sec_range   	:= R.CleanAddress[ 57.. 64];
	SELF.p_city_name 	:= R.CleanAddress[ 65.. 89];
	SELF.v_city_name 	:= R.CleanAddress[ 90..114];
	SELF.st          	:= R.CleanAddress[115..116];
	SELF.zip         	:= IF(v_zip='00000','',v_zip);
	SELF.zip4       	 := IF(v_zip4='0000','',v_zip4);
	SELF.cart        	:= R.CleanAddress[126..129];
	SELF.cr_sort_sz  	:= R.CleanAddress[130..130];
	SELF.lot         	:= R.CleanAddress[131..134];
	SELF.lot_order   	:= R.CleanAddress[135..135];
	SELF.dbpc        	:= R.CleanAddress[136..137];
	SELF.chk_digit   	:= R.CleanAddress[138..138];
	SELF.rec_type    	:= R.CleanAddress[139..140];
	SELF.county      	:= R.CleanAddress[141..145];
	SELF.geo_lat     	:= R.CleanAddress[146..155];
	SELF.geo_long    	:= R.CleanAddress[156..166];
	SELF.msa         	:= R.CleanAddress[167..170];
	SELF.geo_blk     	:= R.CleanAddress[171..177];
	SELF.geo_match   	:= R.CleanAddress[178..178];
	SELF.err_stat    	:= R.CleanAddress[179..182];
	SELF:= L ;
END;

t_get_address := JOIN (	DISTRIBUTE(filt_address, HASH(Address1, Address2, ADDR_CITY_FULL_NM, ADDR_STATE_CD, ADDR_ZIP5_CD)) , 
						DISTRIBUTE(clean_addr,HASH(NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode)) ,
										LEFT.Address1 = RIGHT.NormAddress.Address1 AND
										LEFT.Address2 = RIGHT.NormAddress.Address2 AND	
										LEFT.ADDR_CITY_FULL_NM = RIGHT.NormAddress.City AND
										LEFT.ADDR_STATE_CD = RIGHT.NormAddress.State AND
										LEFT.ADDR_ZIP5_CD = RIGHT.NormAddress.ZipCode,
										t_join_get_address(LEFT,RIGHT), LEFT OUTER, LOCAL);

	//Transform Records with blank addresses to reformat to the same layout as the data with clean address
Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Final_Out t_transform_layout_address (blank_address L) := TRANSFORM
	SELF 				:= L;
END;

t_blank_address := PROJECT(blank_address, t_transform_layout_address(LEFT));

	//Concatenate data with clean addresses and blank addresses
get_address := t_get_address + t_blank_address;
										

//---------------------

normalized_clean := Transunion_PTrak.File_CP_Transunion_Clean_Normalized_Out;

//-----------------------------------------------------------------
//FILE ROLLUP TO HAVE UNIQUE RECORDS
//-----------------------------------------------------------------
d_normalized_clean := DISTRIBUTE(normalized_clean, HASH((INTEGER)PARTY_ID));

s_normalized_clean := SORT(d_normalized_clean, 
								PARTY_ID, 
								fname, 
								mname, 
								lname, 
								prim_range,
								predir,
								prim_name,
								addr_suffix,
								postdir,
								unit_desig,
								sec_range,
								v_city_name,
								st,
								zip,
								zip4,
								SSN,
								PHONE_NBR,
								BIRTH_DT , LOCAL); 
						
				
								
Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Final_Out tRollup(s_normalized_clean L, s_normalized_clean R) := TRANSFORM
   SELF := L;
end;
	
	
r_normalized_clean   := ROLLUP(s_normalized_clean, tRollup(LEFT, RIGHT),
			   PARTY_ID, 
			   fname, 
			   mname,
			   lname,
			   prim_range,
			   predir,
			   prim_name,
			   addr_suffix,
			   postdir,
			   unit_desig,
			   sec_range,
			   v_city_name,
			   st,
			   zip,
			   zip4,
			   SSN,
			   PHONE_NBR,
			   BIRTH_DT                                         
  ,local);
	
//-----------------------------------------------------------------
//APPEND DID
//-----------------------------------------------------------------
								   
matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(r_normalized_clean , matchset,					
	 SSN,BIRTH_DT , fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 DID, Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Final_Out, true, DID_Score_field,
	 75, d_did)

//-----------------------------------------------------------------
//BUILD
//-----------------------------------------------------------------
ut.mac_sf_buildprocess(d_did, '~thor400::base::transunion_CP', build_transunionPTrak_base, 2,,TRUE);

//---------------------------------------------------------------------------------


outputclean := output(get_address,,'~thor_data400::in::transunion_CP_clean_normalized_' +  ut.GetDate  ,overwrite,__compressed__);

EXPORT Proc_CP_Transunion := SEQUENTIAL(//for_cash_address,
															//address_clean_final,
															//FileServices.StartSuperFileTransaction(),
															//FileServices.AddSuperFile('~thor_data400::in::transunionptrak_cash_address','~thor_data400::in::transunionptrak_cash_address_' + ut.GetDate ),
															//FileServices.AddSuperFile('~thor_data400::in::transunion_CP_cleaned','~~thor_data400::in::transunion_CP_cleaned_' + ut.GetDate ),
															//FileServices.FinishSuperFileTransaction(),
															//outputclean,
															//FileServices.StartSuperFileTransaction(),
															//FileServices.AddSuperFile('~thor_data400::in::transunion_CP_clean_normalized','~thor_data400::in::transunion_CP_clean_normalized_' + ut.GetDate ),
															//FileServices.FinishSuperFileTransaction(),
															build_transunionPTrak_base
															);



