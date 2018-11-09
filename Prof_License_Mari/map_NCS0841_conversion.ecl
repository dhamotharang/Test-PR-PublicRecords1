//************************************************************************************************************* */	
//  The purpose of this development is take NC Appraisal Board raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_StringLib;

EXPORT  map_NCS0841_conversion(STRING pVersion) := FUNCTION
	src_cd	:= 'S0841'; //Vendor code
	src_st	:= 'NC';	//License state
	code		:= src_st+src_cd;
	STRING8 process_date:=(STRING8)Lib_StringLib.StringLib.GetDateYYYYMMDD();
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//move sprayed file from sprayed to using
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','sprayed','using');	
												 );

	//MS input file
	ds_NC_Appraisal	:= Prof_License_Mari.file_NCS0841;
	oRel	:= OUTPUT(ds_NC_Appraisal);

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0841');
	oCmv	:= OUTPUT(ds_Cmvtranslation);	

	//Pattern for DBA
	DBApattern	:= '^(.*)( DBA|D B A|D/B/A|\\(DBA\\))';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Remove bad records before processing
	ValidNCFile	:= ds_NC_Appraisal(TRIM(LASTNAME,LEFT,RIGHT) != 'NONE');

	//NC Appraisal layout to Common
	Prof_License_Mari.layouts.base	TransformToCommon(Prof_License_Mari.layout_NCS0841.src L) := TRANSFORM
	
		SELF.PRIMARY_KEY	:= 0;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := L.LN_FILEDATE;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.LN_FILEDATE;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= L.LN_FILEDATE;
		SELF.STAMP_DTE				:= L.LN_FILEDATE; //yyyymmdd
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.TYPE_CD					:= 'MD';
		SELF.LICENSE_STATE		:= src_st;

		//Clean Individual name for name_org field
		FullName							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(L.LASTNAME+' '+L.FIRSTNAME));

		//Extrace nick name
		tmpNick_Name					:= Prof_License_Mari.fGetNickname(FullName,'nick');
		rmv_NickName					:= Prof_License_Mari.fGetNickname(FullName,'strip_nick');

		ParsName							:= Address.CleanPersonLFM73(StringLib.StringCleanSpaces(rmv_NickName));
		CleanName							:= StringLib.StringCleanSpaces(ParsName[46..65]+' '+ParsName[66..70]+' '+ParsName[6..25]);
		SELF.NAME_ORG					:= CleanName;
		SELF.NAME_FORMAT			:= 'L';
		SELF.NAME_ORG_ORIG		:= ut.CleanSpacesAndUpper(ut.fn_FormatFullName(L.LASTNAME, L.FIRSTNAME));
		
		//Parse suffix from last name and middle name from first name
		SELF.NAME_FIRST				:= TRIM(ParsName[6..25],LEFT,RIGHT);
		SELF.NAME_MID					:= TRIM(ParsName[26..45],LEFT,RIGHT);
		SELF.NAME_LAST				:= TRIM(ParsName[46..65],LEFT,RIGHT);
		SELF.NAME_SUFX				:= TRIM(ParsName[66..70],LEFT,RIGHT);
		
		//Cleaned Office from DBA
		UpperOfficeName				:= ut.CleanSpacesAndUpper(L.FIRMNAME);
		GetOffice							:= IF(REGEXFIND(DBApattern,UpperOfficeName),Prof_License_Mari.mod_clean_name_addr.GetCorpName(UpperOfficeName),
														UpperOfficeName);
		GetDBA								:= IF(REGEXFIND(DBApattern,UpperOfficeName),Prof_License_Mari.mod_clean_name_addr.GetDBAName(UpperOfficeName),
														'');
		stdOfficeName			:= IF(UpperOfficeName != ' ' AND GetOffice = ' ',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('/',UpperOfficeName,' ')),
														Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('/',GetOffice,' ')));
		clnOfficeName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(StringLib.StringFindReplace(stdOfficeName,'DBA','')));
		GoodNAME_OFFICE	:= IF(REGEXFIND(IPpattern,stdOfficeName),TRIM(stdOfficeName,LEFT,RIGHT),REGEXREPLACE(' COMPANY',clnOfficeName,' CO'));
		SELF.NAME_OFFICE	  := MAP(TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST + SELF.NAME_SUFX,ALL)=> '',
		                           TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
		                           TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
															 TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
		                           StringLib.StringCleanSpaces(GoodNAME_OFFICE));
		SELF.OFFICE_PARSE	:= IF(SELF.NAME_OFFICE != ' ','GR','');
		
	  //Clean DBA name and remove from Officename field
		tmpNameDBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('"',GetDBA,'')); //business name with standard corp abbr.
		tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		clnDba							:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNameDBA),
															Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE('/',tmpNameDBA,' ')));
		SELF.NAME_DBA				:= REGEXREPLACE(' COMPANY',clnDba,' CO');
		SELF.NAME_DBA_SUFX	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG				:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0);
		SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(tmpNameDBA);
		
		tempLicenseNbr					:= ut.CleanSpacesAndUpper(L.LICENSEID);
		SELF.LICENSE_NBR				:= tempLicenseNbr;
		
		tempRawLicType				:= ut.CleanSpacesAndUpper(L.LICTYPE);
		SELF.RAW_LICENSE_TYPE	:= tempRawLicType;
		SELF.STD_LICENSE_TYPE	:= tempRawLicType;
		
		SELF.RAW_LICENSE_STATUS	:= 'A';		//All records are active licenses
		SELF.STD_LICENSE_STATUS	:= SELF.RAW_LICENSE_STATUS;
		
		// Use default date of 17530101 for blank dates.  Expires 6/30 of current year
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		next_year := ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
		SELF.EXPIRE_DTE				:= MAP(SELF.LAST_UPD_DTE[5..8]< '0630' => StringLib.GetDateYYYYMMDD()[1..4]+'0630',
																 SELF.LAST_UPD_DTE[5..8] > '0630' => (STRING4)next_year+'0630','17530101');
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS) != ' ','B',' ');
		SELF.NAME_MARI_ORG		:= SELF.NAME_OFFICE;	
		
		//Clean phone/fax and remove +1 and non-numerics
		clnPhone              := TRIM(StringLib.StringFilter(L.PHONE1,'0123456789'));
		SELF.PHN_MARI_1				:= IF(clnPhone = '0000000000','',ut.CleanPhone(clnPhone));				//PHN_MARI_1 - Phone number before running through our clean process.
		SELF.PHN_PHONE_1			:= IF(clnPhone = '0000000000','',ut.CleanPhone(clnPhone));

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.STRINGCleanSpaces(L.ADDRESS); 
		temp_preaddr2 				:= StringLib.STRINGCleanSpaces(L.CITY+' '+L.STATE +' '+L.ZIP); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address

		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.STRINGCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.STRINGCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.STRINGCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(L.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
																
		SELF.ADDR_CNTY_1			:= IF(TRIM(L.COUNTY,LEFT,RIGHT) = 'OUT OF STATE','',ut.CleanSpacesAndUpper(L.COUNTY));
		UpperEmail						:= ut.CleanSpacesAndUpper(L.EMAIL);
		SELF.EMAIL						:= IF(TRIM(UpperEmail) = 'NONE','',UpperEmail);
		SELF.PROVNOTE_3 	    := '[LICENSE_STATUS ASSIGNED]';
		
		/* fields used to create mltreckey key are:
	 license number
	 license type
	 source update
	 name
	 address_1
	 dba
	 officename
	*/
				 
		SELF.mltreckey := 0; //This file doesn't have multiple DBA's
				
	/* fields used to create cmc_slpk unique key are :
	license number
	office license number
	license type
	source update
	standard name_org w/o DBA
	raw address */	
		SELF.CMC_SLPK     := HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) +','
																+TRIM(SELF.std_license_type,LEFT,RIGHT) +','
																+TRIM(SELF.std_source_upd,LEFT,RIGHT) +','
																+TRIM(SELF.NAME_ORG,LEFT,RIGHT) +','
																+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT) +','
																+TRIM(L.CITY,LEFT,RIGHT) +','
																+TRIM(L.STATE,LEFT,RIGHT) +','
																+TRIM(L.ZIP,LEFT,RIGHT));
			
		SELF := [];
	END;

	ds_map := PROJECT(ValidNCFile, TRANSFORMToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.STRINGToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																																
	d_final   := OUTPUT(ds_map_lic_trans, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));			

	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','using','used');	
																	);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	RETURN SEQUENTIAL(move_to_using, oRel, oCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	END;