//************************************************************************************************************* */	
//  The purpose of this development is take ND Real Estate License raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_NDS0855_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt:Prof License MARI - NDS0855 Build ' + pVersion);

	code 								:= 'NDS0855';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation	:= OUTPUT(Cmvtranslation);
	
  SufxPattern         := ' JR| SR| JR.| SR.|JR,|SR,| III| II| IV| VI';		
			
	//Move to using
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed','using');	
																	);

	//ND input files
	re									:= Prof_License_Mari.files_NDS0855.RE(ut.CleanSpacesAndUpper(ORG_NAME) NOT IN ['','NAME'] AND
	                                                          LICSTAT<>'');
	oRe									:= OUTPUT(re);

	//Layout to add clean name fields for identifying business vs individual name
	Layout_clean_name := RECORD
			Prof_License_Mari.layout_NDS0855;
			Standard.Name;
			STRING70  cname;
	END;

	Layout_clean_name mapClnFields(re l)	:= TRANSFORM
	SELF := l;
	SELF := [];
	END;
	 
	StdNameLicense	:= PROJECT(re,mapClnFields(LEFT));

	//call Macro to differentiate company vs person in OFFICENAME field
	Address.Mac_Is_Business(StdNameLicense,OFFICENAME,ClnName,name_flag,FALSE,TRUE);

	//Map identified name fields fields
	Layout_clean_name clnLicense(ClnName l) := TRANSFORM
			clean_name_U			:= IF(l.name_flag = 'U',Address.CleanPerson73(l.OFFICENAME),'');
			SELF.title 				:= MAP( l.name_flag = 'P' OR l.name_flag = 'D' => l.cln_title,
														l.name_flag = 'U' => clean_name_U[1..5],'');										
			SELF.fname 				:= MAP( l.name_flag = 'P' OR l.name_flag = 'D' => l.cln_fname,
														l.name_flag = 'U' => clean_name_U[6..25],'');										
			SELF.mname 				:= MAP( l.name_flag = 'P' OR l.name_flag = 'D' => l.cln_mname,
														l.name_flag = 'U' => clean_name_U[26..45],'');					
			SELF.lname 				:=  MAP( l.name_flag = 'P' OR l.name_flag = 'D' => l.cln_lname,
															l.name_flag = 'U' => clean_name_U[46..65],'');
			SELF.name_suffix 	:=  MAP( l.name_flag = 'P' OR l.name_flag = 'D' => l.cln_suffix,
														l.name_flag = 'U' => clean_name_U[66..70],'');
			SELF.cname	 			:= IF(l.name_flag = 'B',l.OFFICENAME,'');

			SELF := l;
			SELF := [];
	END;

	ds_ND_clnName	:= PROJECT(ClnName,clnLicense(LEFT));
	ut.CleanFields(ds_ND_clnName,ds_Cln_Record);

	//ND Real Estate layout to Common
	Prof_License_Mari.layout_base_in TransformToCommon(Layout_clean_name L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;

		SELF.TYPE_CD					:= 'MD';
		
    TrimOrgName           := ut.CleanSpacesAndUpper(L.ORG_NAME);
		TrimOfficeName        := ut.CleanSpacesAndUpper(L.OFFICENAME);
		TrimFirmName          := ut.CleanSpacesAndUpper(L.fname);

		TrimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS1);
		TrimCityStZip         := ut.CleanSpacesAndUpper(L.CITYSTZIP);
		
		//Remove nickname. Parse name using F M. and L, Sx. pattern
		tmpNick_Name          := IF(REGEXFIND('^(.*) AKA ([A-Z]+)\\s(.*)$', TrimOrgName),REGEXFIND('^(.*) AKA ([A-Z]+)\\s(.*)$', TrimOrgName,2,NOCASE),Prof_License_Mari.fGetNickname(TrimOrgName,'nick'));		
		rmv_NickName          := MAP(REGEXFIND('^(.*) AKA ([A-Z]+)\\s(.*)$', TrimOrgName) => REGEXFIND('^(.*) AKA ([A-Z]+)\\s(.*)$', TrimOrgName,1,NOCASE) + ' ' + REGEXFIND('^(.*) AKA ([A-Z]+)\\s(.*)$', TrimOrgname,3,NOCASE),
		                             Prof_License_Mari.fGetNickname(L.ORG_NAME,'nick') != '' => Prof_License_Mari.fGetNickname(TrimOrgName,'strip_nick'),
																 TrimOrgName);
    
		tmpSufxName           := IF(REGEXFIND(SufxPattern,rmv_NickName),REGEXFIND(SufxPattern,rmv_NickName,0),'');
    stripSufxName         := IF(REGEXFIND(SufxPattern,rmv_NickName),REGEXREPLACE(SufxPattern,rmv_NickName,''),rmv_NickName);
		
		TmpLastName           := IF(REGEXFIND('^(.*), (.*)',stripSufxName),REGEXFIND('^(.*), (.*)',stripSufxName,1),'');
		ClnNameFull           := Address.CleanPersonLFM73(stripSufxName);
		CleanNameFull         := IF(LENGTH(TRIM(ClnNameFUll[6..25]))<2 OR LENGTH(TRIM(ClnNameFUll[46..65]))<2 OR TRIM(ClnNameFULL[46..65])!=TRIM(TmpLastName),NID.CleanPerson73(stripSufxName),ClnNameFull);		
	
		//Parse name
		SELF.NAME_FIRST			  := TRIM(CleanNameFull[6..25],LEFT,RIGHT);
  	SELF.NAME_MID				  := TRIM(CleanNameFull[26..45],LEFT,RIGHT);	
		SELF.NAME_LAST				:= TRIM(CleanNameFull[46..65],LEFT,RIGHT);
		SELF.NAME_SUFX				:= IF(tmpSufxName !='',TRIM(tmpSufxName,LEFT,RIGHT),TRIM(StringLib.StringToUpperCase(CleanNameFull[66..70]),LEFT,RIGHT));
		SELF.NAME_NICK				:= TRIM(tmpNick_Name,LEFT,RIGHT);
		SELF.NAME_ORG         := StringLib.StringCleanSpaces(SELF.NAME_LAST+' '+SELF.NAME_FIRST);
		SELF.LICENSE_NBR	   	:= 'NR';
		SELF.LICENSE_STATE	 	:= src_st;
		SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.LICSTAT);

		// initialize raw_license_type from raw data											 
		SELF.RAW_LICENSE_TYPE := ut.CleanSpacesAndUpper(L.LICTYPE);						 
		SELF.STD_LICENSE_TYPE := MAP(TRIM(SELF.RAW_LICENSE_STATUS)='INACTIVE'
		                             => 'IBS',
		                             TRIM(SELF.RAW_LICENSE_TYPE)='SALESPERSON' 
																 => 'SL',
		                             TRIM(SELF.RAW_LICENSE_TYPE)='BROKER' 
																 => 'BR',
		                             TRIM(SELF.RAW_LICENSE_TYPE)='BROKER ASSOCIATE' 
																 => 'BA',
																 '');
		SELF.PROV_STAT				:= IF(SELF.RAW_LICENSE_STATUS IN ['D','DECEASED'], 'D','');
		SELF.DISP_TYPE_CD			:= IF(SELF.RAW_LICENSE_STATUS IN ['R','REVOKED'], 'R','');
		
		//Fix the last name if the parser return a 1 character last name
		stdOfficeName					:= IF(TrimFirmName = ' ',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimOfficeName),TrimOfficeName);
		clnOfficeName					:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdOfficeName),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdOfficeName),
		                            StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(stdOfficeName)));
		SELF.NAME_OFFICE			:= MAP(REGEXFIND(' COMPANY',clnOfficeName) => REGEXREPLACE(' COMPANY',clnOfficeName,' CO'),
		                             TRIM(clnOfficeName) = TRIM(SELF.name_first) + ' ' + TRIM(SELF.name_last) => '',
																 TRIM(clnOfficeName) = TRIM(SELF.name_first) + ' ' + TRIM(SELF.name_mid) + ' ' + TRIM(SELF.name_last) => '',
																 TRIM(clnOfficeName) = TRIM(SELF.NAME_ORG) => '',
		                             clnOfficeName);
		SELF.OFFICE_PARSE			:= MAP(SELF.NAME_OFFICE != '' AND TrimFirmName = ''=>'GR',
																 SELF.NAME_OFFICE != '' AND TrimFirmName != ''=>'MD',
																 '');
																
		/*Default issue date is 17530101 
		Expire date is 12/31 each year based on last update date*/
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		next_year := ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
		SELF.EXPIRE_DTE				:= MAP(TRIM(SELF.RAW_LICENSE_STATUS)='DECEASED' => '17530101',
		                             SELF.LAST_UPD_DTE[5..8]< '1231' => StringLib.GetDateYYYYMMDD()[1..4]+'1231',
																 SELF.LAST_UPD_DTE[5..8] > '1231' => (STRING4)next_year+'1231',
																 '17530101');
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= TrimOrgName;
		SELF.NAME_FORMAT			:= 'L';						//Name format changed from F to L starting from 20140529
		SELF.NAME_MARI_ORG		:= IF(TRIM(SELF.NAME_OFFICE) != ' ',TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ');
		
		//Clean address to parse out city, state, zip
		ClnAddress	:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(TrimAddress1, TrimCityStZip);
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(TRIM(ClnAddress[1..10],LEFT,RIGHT)+' '+TRIM(ClnAddress[11..12],LEFT,RIGHT)+' '
															+TRIM(ClnAddress[13..40],LEFT,RIGHT)+' '+TRIM(ClnAddress[41..44],LEFT,RIGHT)+' '
															+TRIM(ClnAddress[45..46],LEFT,RIGHT));
		SELF.ADDR_ADDR2_1			:= StringLib.StringCleanSpaces(TRIM(ClnAddress[47..56],LEFT,RIGHT)+' '+TRIM(ClnAddress[57..64],LEFT,RIGHT));
		SELF.ADDR_CITY_1		  := TRIM(ClnAddress[65..89],LEFT,RIGHT);
		SELF.ADDR_STATE_1			:= TRIM(ClnAddress[115..116],LEFT,RIGHT);
		SELF.ADDR_ZIP5_1		  := TRIM(ClnAddress[117..121],LEFT,RIGHT);
		SELF.ADDR_ZIP4_1		  := TRIM(ClnAddress[122..125],LEFT,RIGHT);
		SELF.ADDR_CNTY_1			:= ut.CleanSpacesAndUpper(L.COUNTY);
		
		//Clean Phone #
		SELF.PHN_PHONE_1			:= ut.CleanPhone(L.PHONE);
		SELF.PHN_MARI_1				:= TRIM(SELF.PHN_PHONE_1);
		
		// fields used to create mltrec_key are :
		// license number
		// office license number
		// license type
		// source update
		// raw name including DBA's
		// raw address 
		SELF.MLTRECKEY				:= 0;

		// fields used to create cmc_slpk unique key are :
		// license number -- this source does not contain license field
		// license type
		// source update
		// name
		// address
		// dba 
		//Sometimes address fields contain non-printable characters which result in different cmc_slpk even the addr appears the same.
		//Remove null, \r, \n, blank, and ".
		tmpCmcSlpk						:= SELF.std_license_type
													 + SELF.std_source_upd
												   + SELF.NAME_ORG_ORIG
												   + ut.CleanSpacesAndUpper(TrimAddress1)
													 + ut.CleanSpacesAndUpper(TrimCityStZip);

 		tmpCmcSlpk_1					:= REGEXREPLACE(x'00',tmpCmcSlpk,'');
   	tmpCmcSlpk_2					:= REGEXREPLACE(x'0a',tmpCmcSlpk_1,'');
   	tmpCmcSlpk_3					:= REGEXREPLACE(x'0d',tmpCmcSlpk_2,'');
   	tmpCmcSlpk_4					:= REGEXREPLACE(' ',tmpCmcSlpk_3,'');
   	tmpCmcSlpk_5					:= REGEXREPLACE('"',tmpCmcSlpk_4,'');
		SELF.CMC_SLPK					:= HASH64(tmpCmcSlpk_5);
		//citystzip sometimes has a trailing ", sometimes not.
		SELF 									:= [];
		
	END;

	ds_map := PROJECT(ds_Cln_Record, TransformToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
		
	// look up standard license status 
	Prof_License_Mari.layout_base_in trans_status_trans(ds_map_lic_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
	d_final 						:= OUTPUT(ds_map_status_trans, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_status_trans(NAME_ORG_ORIG != ''));

	move_to_used				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');	
																	);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oRe, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;