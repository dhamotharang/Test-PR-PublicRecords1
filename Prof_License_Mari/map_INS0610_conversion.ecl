//************************************************************************************************************* */	
//  The purpose of this development is take IN Mortgage License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
#workunit('name','Yogurt: map_INS0610_conversion');
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_INS0610_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'INS0610';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

  broker      						:= Prof_License_Mari.file_INS0610.broker;
	//Dataset reference files for lookup joins
	/*ds_License_Desc	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0610');
	ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
	ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
	ds_Src_Desc			:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0610');*/
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Move data from sprayed to using directory
 	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'broker','sprayed', 'using');		 

	//IN input file
	ds_IN_Brokers	:= Prof_License_Mari.file_INS0610.broker;
	oBrks := OUTPUT(ds_IN_Brokers);

	//Remove bad records before processing
	//ValidINFile	:= ds_IN_Brokers(TRIM(COMPANYID,LEFT,RIGHT) != 'Company Id' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |D B A |D/B/A )(.*)';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';

	//layout to Common
  Prof_License_Mari.layout_INS0610.common map_broker(Prof_License_Mari.layout_INS0610.broker pInput) := TRANSFORM
      SELF := pInput;
      SELF := [];
  END;

	brCommon	:= PROJECT(broker, map_broker(LEFT));

	//Remove bad records before processing
	ValidINFile	:= brCommon(TRIM(COMPANYID,LEFT,RIGHT) != 'Company Id' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));
										
	Prof_License_Mari.layouts.base	TransformToCommon(Prof_License_Mari.layout_INS0610.common L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		//SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd
		SELF.STAMP_DTE				:= Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(TRIM(L.REPORT_DATE));

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';
		SELF.TYPE_CD					:= 'GR';
		
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		//Clean and parse Org_name
		trim_org_name			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.ORG_NAME);
		StdOrgDBA					:= REGEXREPLACE('(D[.]*B[.]*A[.]*) ',trim_org_name,'DBA ');
		tmpNameOrg				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(StdOrgDBA); //business name with standard corp abbr.
		getCorpOnly				:= IF(REGEXFIND(DBApattern, tmpNameOrg), Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
														,tmpNameOrg);		 //get names without DBA names
		tmpNameOrgSufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);
		SELF.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly);
		SELF.NAME_ORG				:= IF(REGEXFIND(IPpattern,getCorpOnly),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')));   //Without punct. and Sufx removed
		SELF.NAME_FORMAT		:= 'F';
		SELF.NAME_ORG_SUFX 	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
	 //get names with DBA prefix
		temp_dba_name				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOrg);
		tmpNameDBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba_name); //business name with standard corp abbr.
		tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		SELF.NAME_DBA				:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG				:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
	
		//SLNUM is no longer provided 2/6/13 Cathy Tio
		/*tempLicNum					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.SLNUM);
		SELF.LICENSE_NBR		:= tempLicNum; */
		
		SELF.LICENSE_STATE	:= src_st;
	
		//SELF.RAW_LICENSE_STATUS	:= IF(tempLicNum = 'EXEMPT','EXEMPT','ACTIVE');		//All records are active licenses
		SELF.RAW_LICENSE_STATUS	:= 'ACTIVE';		//All records are active licenses
		
		SELF.RAW_LICENSE_TYPE	:= 'LB';
		SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;
		
		// Use default date of 17530101 for blank dates.  Expires 12/31 of current year
		SELF.CURR_ISSUE_DTE		:= IF(TRIM(L.LICSTAT_DATE,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.LICSTAT_DATE), '17530101');
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		//TG- Not provided(20150724)
		// SELF.ORIG_ISSUE_DTE		:= IF(L.ORIG_ISSUE_DATE='','17530101',
		                            // Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(TRIM(L.ORIG_ISSUE_DATE)));
		
		next_year := ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
		SELF.EXPIRE_DTE				:= MAP(SELF.LAST_UPD_DTE[5..8]< '1231' => StringLib.GetDateYYYYMMDD()[1..4]+'1231',
																	SELF.LAST_UPD_DTE[5..8] > '1231' => (STRING4)next_year+'1231','17530101');
	
		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= TRIM(trim_org_name,LEFT,RIGHT);
		SELF.NAME_DBA_ORIG		:= IF(SELF.NAME_DBA != ' ',SELF.NAME_DBA,'');
		SELF.NAME_MARI_ORG		:= IF(TRIM(getCorpOnly) != ' ',TRIM(getCorpOnly,LEFT,RIGHT),' ');
		SELF.NAME_MARI_DBA		:= tmpNameDBA;
	
		SELF.ADDR_ADDR1_1			:= IF(L.ADDRESS1 != '' ,Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS1),'');
		SELF.ADDR_CITY_1		  := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.CITY);
		SELF.ADDR_STATE_1			:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.STATE);
		tmpZip	              := MAP(LENGTH(TRIM(L.ZIP))=3 => '00'+TRIM(L.ZIP),
		                             LENGTH(TRIM(L.ZIP))=4 => '0'+TRIM(L.ZIP),
						                     TRIM(L.ZIP));
		SELF.ADDR_ZIP5_1		  := tmpZip[1..5];
		SELF.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,LEFT,RIGHT)[7..11],
																 TRIM(L.ZIP,LEFT,RIGHT)[6..10]);
		SELF.ADDR_CNTRY_1     := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.COUNTRY);
		
		//If BRANCH_MGR is populated, move to contact name
		ClnUpperContact					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.BRANCH_MGR);
		ParseName								:= Address.CleanPersonFML73(ClnUpperContact);
		SELF.NAME_CONTACT_FIRST	:= IF(ClnUpperContact != ' ',ParseName[6..25],' ');
		SELF.NAME_CONTACT_MID		:= IF(ClnUpperContact != ' ',ParseName[26..45],' ');
		SELF.NAME_CONTACT_LAST	:= IF(ClnUpperContact != ' ',ParseName[46..65],' ');
		SELF.NAME_CONTACT_SUFX	:= IF(ClnUpperContact != ' ',ParseName[66..70],' ');
		
		SELF.EMAIL						  := ut.fnTrim2Upper(L.EMAIL);
		SELF.PHN_CONTACT				:= StringLib.StringFilter(REGEXREPLACE('\\+1',L.PHONE,''),'0123456789');
		//TG- Not provided(20150724)
		// SELF.RENEWAL_DTE		  	:= ut.fnTrim2Upper(L.RENEWAL_YR);

		SELF.PROVNOTE_3 	    := '{LICENSE_STATUS ASSIGNED}';
	
		//fields used to create mltreckey key are:
		//license number
		//license type
		//source update
		//name
		//address
		SELF.mltreckey 				:= 0;  //data does not contain multiple DBA names
			
		//fields used to create unique key are:
		//license number
		//license type
		//source update
		//name
		//address
		//Use hash64 to avoid dup key 
		//This vendor does not provide license number. Will use companyid and branchid to contruct the license number
		tempLicNum 		 := TRIM(L.COMPANYID,LEFT,RIGHT) + 
											IF(L.BRANCHID<>'','-' + TRIM(L.BRANCHID,LEFT,RIGHT),
											   '');
		SELF.LICENSE_NBR 			:= TRIM(tempLicNum,LEFT,RIGHT);											 
		SELF.PROVNOTE_1				:= '{LICENSE_NBR ASSIGNED}';

		//Expected codes [CO,BR,IN]
		SELF.AFFIL_TYPE_CD		:= IF(L.BRANCHID<>'', 'BR', 'CO');
		
		SELF.cmc_slpk  := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
		                       +TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)
										       +TRIM(src_cd,LEFT,RIGHT)
				                   +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ORG_NAME)
										       +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS1)
													 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.CITY)
													 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ZIP));										 

		SELF := [];		   		   
		
	END;

	ds_map := PROJECT(ValidINFile, TransformToCommon(LEFT));

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layouts.base trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);
								
	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_stat_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := join(ds_map_stat_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(trim(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=trim(right.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// company only table for affiliation code
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');																		
																			
	Prof_License_Mari.layouts.base	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
											 LEFT.AFFIL_TYPE_CD='BR' AND
						           TRIM(LEFT.license_nbr[..StringLib.stringfind(LEFT.license_nbr,'-',1)-1],LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT),
						           assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	

	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	d_final := output(ds_map_affil, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil);

	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'broker','using', 'used');	 

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oBrks, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

