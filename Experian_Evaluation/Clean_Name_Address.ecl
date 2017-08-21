import address;
norm_name := Experian_Evaluation.Normalize_Names;
norm_addr := Experian_Evaluation.Normalize_Addresses;


//-----------------------------------------------------------------
//DEDUP Names
//-----------------------------------------------------------------
d_names:= DISTRIBUTE(norm_name, HASH(Name)); 
dedup_names := DEDUP(SORT(d_names,Name,LOCAL),Name, LOCAL) ; 

//-----------------------------------------------------------------
//STANDARDIZE NAMES: clean names
//-----------------------------------------------------------------
Layout_Experian_CP_Out.Norm_Cleand_NameRec t_CleanName(dedup_names L) := TRANSFORM
	CleanName1 := address.cleanpersonlfm73(L.Name);
	CleanName2 := address.cleanperson73(L.Name);
	CleanName3 := address.cleanpersonlfm73(StringLib.StringFindReplace(L.Name, ',', ' '));
	CleanName4 := address.cleanperson73(StringLib.StringFindReplace(L.Name, ',', ' '));
	self.Clean_Name := map((unsigned1)CleanName1[71..73] > 0  => CleanName1, 
				     (unsigned1)CleanName2[71..73] > 0  => CleanName2,      
					 (unsigned1)CleanName3[71..73] > 0  => CleanName3,
					 (unsigned1)CleanName4[71..73] > 0  => CleanName4,
					 CleanName1);

	SELF := L;
END;

name_clean := PROJECT(dedup_names, t_CleanName(LEFT)) :persist('~thor_data400::persist::experian_cp_clean_names'); 


//-----------------------------------------------------------------
//DEDUP ADDRESSES
//-----------------------------------------------------------------
d_addresses:= DISTRIBUTE(norm_addr,HASH(Address1, Address2, City, State, ZipCode)); 
dedup_addr := DEDUP(SORT(d_addresses,Address1, Address2, City, State,ZipCode,LOCAL),Address1, Address2, City, State, ZipCode, LOCAL) ; 

//-----------------------------------------------------------------
////STANDARDIZE ADDRESSES: clean addresses
//-----------------------------------------------------------------
Layout_Experian_CP_Out.Norm_Clean_Address_Rec t_GetClean_Address (dedup_addr L) := TRANSFORM
	SELF.Clean_Address := address.CleanAddress182(L.Address1 + ' ' + L.Address2, L.City + ' ' + L.State + ' ' + L.ZipCode);
	SELF := L;
END;
		//Join to Cash Address only if it has data
addr_clean := PROJECT(dedup_addr,t_GetClean_Address(LEFT)) : persist('~thor_data400::persist::experian_cp_clean_addr'); 
																

//-----------------------------------------------------------------
//JOIN CLEAN NAMES BACK TO NORMALIZED DATA
//-----------------------------------------------------------------

	//Join Clean Name
Layout_Experian_CP_Out.Layout_Experian_Norm_Name t_join_get_name (norm_addr L, name_clean R) := TRANSFORM
	SELF.title       	:= R.Clean_Name[ 1.. 5];
	SELF.fname       	:= R.Clean_Name[ 6..25];
	SELF.mname       	:= R.Clean_Name[26..45];
	SELF.lname       	:= R.Clean_Name[46..65];
	SELF.name_suffix 	:= R.Clean_Name[66..70];
	SELF.name_score  	:= R.Clean_Name[71..73];
	SELF				:= L;
END;

get_name := JOIN (DISTRIBUTE(norm_addr, HASH(name)) , DISTRIBUTE(name_clean, HASH(Name)), LEFT.Name = RIGHT.Name,
					t_join_get_name(LEFT,RIGHT), LEFT OUTER, LOCAL);
					
					
//-----------------------------------------------------------------
//JOIN CLEAN ADDRESS BACK TO NORMALIZED DATA
//-----------------------------------------------------------------
invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

Layout_Experian_CP_Out.Layout_Experian_Norm_Address t_join_get_address (get_name  L, addr_clean R) := TRANSFORM
	SELF.Social_Security_Number := IF(L.NameType[..2] = 'SP', '', L.Social_Security_Number);
	SELF.Date_of_Birth			:= IF(L.NameType[..2] = 'SP', '', L.Date_of_Birth);
	SELF.Telephone				:= IF(L.NameType[..2] = 'SP', '', L.Telephone);
	SELF.Gender					:= IF(L.NameType[..2] = 'SP', '', L.Gender);
	STRING28  v_prim_name 	:= R.Clean_Address[13..40];
	STRING5   v_zip       	:= R.Clean_Address[117..121];
	STRING4   v_zip4      	:= R.Clean_Address[122..125];
	SELF.prim_range  		:= R.Clean_Address[ 1..  10];
	SELF.predir      		:= R.Clean_Address[ 11.. 12];
	SELF.prim_name   		:= IF(TRIM(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 		:= R.Clean_Address[ 41.. 44];
	SELF.postdir     		:= R.Clean_Address[ 45.. 46];
	SELF.unit_desig  		:= R.Clean_Address[ 47.. 56];
	SELF.sec_range   		:= R.Clean_Address[ 57.. 64];
	SELF.p_city_name 		:= R.Clean_Address[ 65.. 89];
	SELF.v_city_name 		:= R.Clean_Address[ 90..114];
	SELF.st          		:= R.Clean_Address[115..116];
	SELF.zip         		:= IF(v_zip='00000','',v_zip);
	SELF.zip4       	 	:= IF(v_zip4='0000','',v_zip4);
	SELF.cart        		:= R.Clean_Address[126..129];
	SELF.cr_sort_sz  		:= R.Clean_Address[130..130];
	SELF.lot         		:= R.Clean_Address[131..134];
	SELF.lot_order   		:= R.Clean_Address[135..135];
	SELF.dbpc        		:= R.Clean_Address[136..137];
	SELF.chk_digit   		:= R.Clean_Address[138..138];
	SELF.rec_type    		:= R.Clean_Address[139..140];
	SELF.county      		:= R.Clean_Address[141..145];
	SELF.geo_lat     		:= R.Clean_Address[146..155];
	SELF.geo_long    		:= R.Clean_Address[156..166];
	SELF.msa         		:= R.Clean_Address[167..170];
	SELF.geo_blk     		:= R.Clean_Address[171..177];
	SELF.geo_match   		:= R.Clean_Address[178..178];
	SELF.err_stat    		:= R.Clean_Address[179..182];
	SELF					:= L;
END;


t_get_address := JOIN (	DISTRIBUTE(get_name, HASH(Address1,  Address2, City, State, ZipCode)) , 
						DISTRIBUTE(addr_clean,HASH(Address1, Address2, City, State, ZipCode)) ,
										LEFT.Address1 = RIGHT.Address1 AND
										LEFT.Address2 = RIGHT.Address2 AND	
										LEFT.City = RIGHT.City AND
										LEFT.State = RIGHT.State AND
										LEFT.ZipCode = RIGHT.ZipCode,
										t_join_get_address(LEFT,RIGHT), LEFT OUTER, LOCAL);
										
										
EXPORT Clean_Name_Address := t_get_address:persist('~thor_data400::persist::experian_cp_normalized');
