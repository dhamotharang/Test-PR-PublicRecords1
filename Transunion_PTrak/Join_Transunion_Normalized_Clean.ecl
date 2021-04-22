import _validate;
//-----------------------------------------------------------------
//JOIN CLEAN NAMES and ADDRESSES TO MAIN OUTPUT FILE: join clean addresses, clean names, format dates, phone numbers and SSN
//-----------------------------------------------------------------
EXPORT Join_Transunion_Normalized_Clean(STRING Full_filedate,STRING Update_filedate) := FUNCTION

Import ut;

norm_data := Transunion_PTrak.Normalize_Transunion_Update(Full_filedate,Update_filedate);

//filter data with blank names, names = ',' or length 1

d_norm_data 			:= DISTRIBUTE(norm_data , HASH(Name));

//-----------------------------------------------------------------
//JOIN CLEAN NAMES BACK TO NORMALIZED DATA
//-----------------------------------------------------------------
//Clean Name
	name_clean := Transunion_PTrak.Clean_Transunion_Name(Full_filedate,Update_filedate);

	//Join Clean Name
Transunion_PTrak.Layout_Transunion_Out.FinalNormCleanNameRec t_join_get_name (d_norm_data L, name_clean R) := TRANSFORM
	SELF.CleanName 	:= R.CleanName;
	SELF			:= L;
END;

get_name := JOIN (d_norm_data, DISTRIBUTE(name_clean, HASH(Name)), LEFT.Name = RIGHT.Name,
					t_join_get_name(LEFT,RIGHT), LEFT OUTER, LOCAL);
					
					
//-----------------------------------------------------------------
//JOIN CLEAN ADDRESS BACK TO NORMALIZED DATA
//-----------------------------------------------------------------

	//Filter data with no address
filt_address 	:= get_name(TRIM(NormAddress.Address1,all) <> '' OR  TRIM(NormAddress.Address2,all)  <> '' OR  TRIM(NormAddress.City,all) <> '' OR  TRIM(NormAddress.State,all) <> '' OR  TRIM(NormAddress.ZipCode,all) <> '' );
blank_address 	:= get_name(TRIM(NormAddress.Address1,all) = '' AND  TRIM(NormAddress.Address2,all)  = '' AND  TRIM(NormAddress.City,all) = '' AND  TRIM(NormAddress.State,all) = '' AND  TRIM(NormAddress.ZipCode,all) <> '' );

//Clean Addresses
addr_clean := Transunion_PTrak.File_Transunion_Clean_Address;	
	//Join Clean Address
Transunion_PTrak.Layout_Transunion_Out.FinalNormCleanNameAddressRec t_join_get_address (filt_address  L, addr_clean R) := TRANSFORM
	SELF.CleanAddress 	:= R.CleanAddress;
	SELF				:= L;
END;

t_get_address := JOIN (	DISTRIBUTE(filt_address, HASH(NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode)) , 
						DISTRIBUTE(addr_clean,HASH(NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode)) ,
										LEFT.NormAddress.Address1 = RIGHT.NormAddress.Address1 AND
										LEFT.NormAddress.Address2 = RIGHT.NormAddress.Address2 AND	
										LEFT.NormAddress.City = RIGHT.NormAddress.City AND
										LEFT.NormAddress.State = RIGHT.NormAddress.State AND
										LEFT.NormAddress.ZipCode = RIGHT.NormAddress.ZipCode,
										t_join_get_address(LEFT,RIGHT), LEFT OUTER, LOCAL);

	//Transform Records with blank addresses to reformat to the same layout as the data with clean address
 Transunion_PTrak.Layout_Transunion_Out.FinalNormCleanNameAddressRec t_transform_layout_address (blank_address L) := TRANSFORM
	SELF.CleanAddress 	:= '';
	SELF 				:= L;
END;

t_blank_address := PROJECT(blank_address, t_transform_layout_address(LEFT));

	//Concatenate data with clean addresses and blank addresses
get_address := t_get_address + t_blank_address;
										
//-----------------------------------------------------------------
//REFORMAT TO FINAL LAYOUT
//-----------------------------------------------------------------		
							
invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut t_output_formatting (get_address L) := TRANSFORM
 
	 STRING28  v_prim_name 			:= L.CleanAddress[13..40];
	 STRING5   v_zip       			:= L.CleanAddress[117..121];
	 STRING4   v_zip4      			:= L.CleanAddress[122..125];
	 STRING9   v_sss_unformatted  	:= IF(L.FileType = 'F', TRIM(StringLib.StringFindReplace(L.SSNFirst5Digit + L.SSNLast4Digit, '-',''), left, right), L.SSNFull);
	 STRING7   v_phone_unformatted 	:= TRIM(StringLib.StringFindReplace(L.TelephoneNumber, '-',''), left, right);
	 STRING8   v_dob_unformatted	:= L.CurrentName.Dob_YYYY + INTFORMAT((UNSIGNED1)L.CurrentName.Dob_MM, 2,1) + INTFORMAT((UNSIGNED1)L.CurrentName.Dob_DD, 2,1);
	 
	SELF.FileDate	 	:= if(Full_filedate <> '',Full_filedate,Update_filedate);
	SELF.dt_first_seen  := (unsigned) (L.COMPILATIONDATE[5..]+ L.COMPILATIONDATE[1..2] + L.COMPILATIONDATE[3..4]);
	SELF.dt_last_seen  	:= (unsigned) (L.COMPILATIONDATE[5..]+ L.COMPILATIONDATE[1..2] + L.COMPILATIONDATE[3..4]);
	SELF.dt_vendor_first_reported  := (unsigned) if(Full_filedate <> '',Full_filedate,Update_filedate) ;
	SELF.dt_vendor_last_reported  	:= (unsigned) if(Full_filedate <> '',Full_filedate,Update_filedate) ;
	SELF.title       	:= L.CleanName[ 1.. 5];
	SELF.fname       	:= L.CleanName[ 6..25];
	SELF.mname       	:= L.CleanName[26..45];
	SELF.lname       	:= L.CleanName[46..65];
	SELF.name_suffix 	:= L.CleanName[66..70];
	SELF.name_score  	:= L.CleanName[71..73];
	SELF.prim_range  	:= L.CleanAddress[ 1..  10];
	SELF.predir      	:= L.CleanAddress[ 11.. 12];
	SELF.prim_name   	:= IF(TRIM(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 	:= L.CleanAddress[ 41.. 44];
	SELF.postdir     	:= L.CleanAddress[ 45.. 46];
	SELF.unit_desig  	:= L.CleanAddress[ 47.. 56];
	SELF.sec_range   	:= L.CleanAddress[ 57.. 64];
	SELF.p_city_name 	:= L.CleanAddress[ 65.. 89];
	SELF.v_city_name 	:= L.CleanAddress[ 90..114];
	SELF.st          	:= L.CleanAddress[115..116];
	SELF.zip         	:= IF(v_zip='00000','',v_zip);
	SELF.zip4       	 := IF(v_zip4='0000','',v_zip4);
	SELF.cart        	:= L.CleanAddress[126..129];
	SELF.cr_sort_sz  	:= L.CleanAddress[130..130];
	SELF.lot         	:= L.CleanAddress[131..134];
	SELF.lot_order   	:= L.CleanAddress[135..135];
	SELF.dbpc        	:= L.CleanAddress[136..137];
	SELF.chk_digit   	:= L.CleanAddress[138..138];
	SELF.rec_type    	:= L.CleanAddress[139..140];
	SELF.county      	:= L.CleanAddress[141..145];
	SELF.geo_lat     	:= L.CleanAddress[146..155];
	SELF.geo_long    	:= L.CleanAddress[156..166];
	SELF.msa         	:= L.CleanAddress[167..170];
	SELF.geo_blk     	:= L.CleanAddress[171..177];
	SELF.geo_match   	:= L.CleanAddress[178..178];
	SELF.err_stat    	:= L.CleanAddress[179..182];
	
	SELF.TRANSFERDATE_Unformatted 		:= Transunion_PTrak.FN_Date_Reformat_To_YYYYMMDD(L.TransferDate);
	SELF.BIRTHDATE_unformatted 	 		:= IF((unsigned)_validate.date.fCorrectedDateString(v_dob_unformatted,false) > 0 ,_validate.date.fCorrectedDateString(v_dob_unformatted,false),'');
	SELF.UPDATEDATE_unformatted 		:= Transunion_PTrak.FN_Date_Reformat_To_YYYYMMDD(L.NormAddress.UpdatedDate);
	SELF.FILESINCEDATE_unformatted 		:= L.FILESINCEDATE[5..]+ L.FILESINCEDATE[1..2] + L.FILESINCEDATE[3..4];
	SELF.COMPILATIONDATE_unformatted 	:= L.COMPILATIONDATE[5..]+ L.COMPILATIONDATE[1..2] + L.COMPILATIONDATE[3..4];
	SELF.CONSUMERUPDATEDATE_unformatted := Transunion_PTrak.FN_Date_Reformat_To_YYYYMMDD(L.ConsumerUpdateDate); 
	SELF.SSN_unformatted				:= IF((unsigned) v_sss_unformatted > 0 ,v_sss_unformatted,'');
	SELF.TELEPHONE_unformatted			:= if((unsigned) v_phone_unformatted > 0,v_phone_unformatted,'');
	SELF.DECEASEDINDICATOR 				:= IF(L.CurrentName.DeathIndicator = 'DECEASED' OR L.Orig_DECEASEDINDICATOR = 'Y', 'Y', '');
  SELF.DECEASEDDATE := if((unsigned) _validate.date.fCorrectedDateString(l.deceaseddate,false) > 0, _validate.date.fCorrectedDateString(l.deceaseddate,false),'') ,   
	SELF.is_current := true;
	SELF:= L ;
END; 

d_clean := project(get_address,t_output_formatting(LEFT)) : persist('~thor_data400::persist::transunionptrak_clean_normalized');

RETURN d_clean;
END;