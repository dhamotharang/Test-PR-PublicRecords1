
//************************************************************************************************************* */	
//  The purpose of this development is take MO Mortgage License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, STD;
#workunit('name','Yogurt: map_MOS0634_conversion');

EXPORT map_MOS0634_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MOS0634';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';
	
	//Define constant
	IPpattern	:= '^(.*)(\\.COM[,]* |\\.NET |\\.ORG |\\.GOV |\\.EDU |\\.MIL |\\.INT )(.*)';
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |\\D\\B\\A |AKA )(.*)';

	//Move file from sprayed to using
	// move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg','sprayed', 'using'));	

	//input file
	ds_MO_Mortgage	  := Prof_License_Mari.file_MOS0634;
	o_MO_Mortgage     := OUTPUT(ds_MO_Mortgage);
	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	o_cmvtranslation  := OUTPUT(ds_Cmvtranslation);

	//Remove bad RECORDs before processing
	ValidMOFile	:= ds_MO_Mortgage(TRIM(COMPANY_NAME,LEFT,RIGHT) <> ''
	                              AND NOT REGEXFIND('(.*)RESCINDED',TRIM(COMPANY_NAME,LEFT,RIGHT))
																AND NOT REGEXFIND('Mortgage Brokers Exempt from',TRIM(COMPANY_NAME,LEFT,RIGHT)));
																
	O_ValidMOFile	:= OUTPUT(ValidMOFile);																

	maribase_plus_dbas := RECORD,MAXLENGTH(6800)
		Prof_License_Mari.layouts.base;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
		STRING60 dba6;
		STRING60 dba7;
		STRING60 dba8;
		STRING60 dba9;
	END;

	//MO Real Estate/Appraisers layout to Common
	maribase_plus_dbas transformToCommon(Prof_License_Mari.layout_MOS0634.COMMON L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_PROF_CD			:= 'MTG';
		SELF.LICENSE_STATE	 	:= src_st;

		// Use default date of 17530101 for blank dates.
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(L.ISSUED_DTE=' ' or L.ISSUED_DTE = '//','17530101',
																prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(L.ISSUED_DTE));
		TrimEXP_DTE           := IF(L.EXP_DTE = '0/0/0000','',L.EXP_DTE);
		SELF.EXPIRE_DTE				:= IF(TrimEXP_DTE != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(TrimEXP_DTE),'17530101');
	  SELF.STD_LICENSE_STATUS	:= IF(SELF.EXPIRE_DTE > SELF.PROCESS_DATE OR SELF.EXPIRE_DTE = '17530101', 'A','I');		//All licenses are assumed active
	
		//Get input field
		TrimLicNumber					:= ut.CleanSpacesAndUpper(L.LICENSE);
		TrimNameOrg						:= ut.CleanSpacesAndUpper(L.COMPANY_NAME);
		TrimAddress1					:= ut.CleanSpacesAndUpper(L.ADDRESS1);
		TrimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS2);
		TmpAddress            := TrimAddress1 + ' ' + TrimAddress2;
		TrimCity							:= ut.CleanSpacesAndUpper(L.CITY);
		TrimState							:= ut.CleanSpacesAndUpper(L.STATE);
		TrimZip								:= ut.CleanSpacesAndUpper(L.ZIP);
		TrimLicType						:= ut.CleanSpacesAndUpper(L.LIC_TYPE_DS);
		TrimAsset							:= ut.CleanSpacesAndUpper(L.ASSET);
		TrimPhone             := ut.CleanPhone(L.PHONE);
		TrimDBA               := ut.CleanSpacesAndUpper(L.DBA);
		TrimCounty            := ut.CleanSpacesAndUpper(L.COUNTY);
		TrimCEO               := ut.CleanSpacesAndUpper(L.CEO);
		TrimContact           := ut.CleanSpacesAndUpper(IF(L.Contact != '', L.contact, L.Agent));
    TrimBranchNbr         := IF(REGEXFIND('^\\.',L.BRANCH_NBR),'0' + L.BRANCH_NBR, L.BRANCH_NBR);
    TrimApproval          := ut.CleanSpacesAndUpper(L.APPROVAL);	
		
		Title := MAP(TrimCEO != '' AND REGEXFIND('(.*),(.*),(.*/.*)',TrimCEO) => REGEXFIND('(.*),(.*),(.*/.*)',TrimCEO,3),
		             TrimCEO != '' AND REGEXFIND('(.*),(.*/.*)',TrimCEO) => REGEXFIND('(.*),(.*/.*)',TrimCEO,2),
								 TrimCEO != '' AND REGEXFIND('(.*),(.*)',TrimCEO) => REGEXFIND('(.*),(.*)',TrimCEO,2),
								 '');
    				
		// map raw license type to standard license type before profcode translations
		SELF.RAW_LICENSE_TYPE	:= TrimLicType;
		tempStdLicType				:= MAP(StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'RESIDENTIAL REAL ESTATE MORTGAGE BROKER',1)= 1 => 'R',
		                              StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'MORTGAGE BROKER BRANCH',1)= 1 => 'BRC',
		                              StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'MORTGAGE BROKER',1)= 1 => 'R',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'EXEMPT MORTGAGE BROKER',1)= 1 => 'E',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'BROKERS EXEMPT',1)= 1 => 'E',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'TITLE LOAN COMPANIES',1)= 1 => 'TLC',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'SMALL LOAN COMPANIES',1)= 1 => 'SLC',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'CHARTERED BANKS',1)= 1 => 'CB',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'MISSOURI FINANCING INSTITUTIONS',1)= 1 => 'MFI',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'MORTGAGE LOAN ORIGINATOR',1)= 1 => 'MLO',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'CONSUMER INSTALLMENT',1)= 1 => 'CI',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'PAY DAY LENDERS',1)= 1 => 'PDL',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'DEBT ADJUSTERS',1)= 1 => 'DA',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'MONEY ORDERS/TRANSFERS',1)= 1 => 'MOT',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'CREDIT SERVICE ORGANIZATIONS',1)= 1 => 'CSO',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'PREMIUM FINANCING',1)= 1 => 'PF',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'MOTOR VEHICLE TIME SALES',1)= 1 => 'MVS',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'S&L ASSOCIATIONS',1)= 1 => 'SLA',
																	StringLib.StringFind(TRIM(TrimLicType,LEFT,RIGHT),'NONDEPOSIT TRUST',1)= 1 => 'NDT','');
		SELF.STD_LICENSE_TYPE	:=  IF(tempStdLicType = 'BRC','BR',tempStdLicType);
		SELF.STD_LICENSE_DESC :=  TRIM(ut.CleanSpacesAndUpper(TrimLicType),LEFT,RIGHT);
		// SELF.STD_LICENSE_DESC	:=  MAP(StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'CI',1)= 1 => 'CONSUMER INSTALLMENT',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'PDL',1)= 1 => 'PAY DAY LENDERS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'DA',1)= 1 => 'DEBT ADJUSTERS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'MOT',1)= 1 => 'MONEY ORDERS/TRANSFERS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'CSO',1)= 1 => 'CREDIT SERVICE ORGANIZATIONS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'PF',1)= 1 => 'PREMIUM FINANCING',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'MVS',1)= 1 => 'MOTOR VEHICLE TIME SALES',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'SLA',1)= 1 => 'S&L ASSOCIATIONS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'SLC',1)= 1 => 'SMALL LOAN COMPANIES',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'MLO',1)= 1 => 'MORTGAGE LOAN ORIGINATOR',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'TLC',1)= 1 => 'TITLE LOAN COMPANIES',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'MFI',1)= 1 => 'MISSOURI FINANCING INSTITUTIONS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'R',1)= 1 => 'MORTGAGE BROKER',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'BRC',1)= 1 => 'MORTGAGE BROKER BRANCH',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'CB',1)= 1 => 'CHARTERED BANKS',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'E',1)= 1 => 'BROKERS EXEMPT',
																	// StringLib.StringFind(TRIM(tempStdLicType,LEFT,RIGHT),'NDT',1)= 1 => 'NONDEPOSIT TRUST','');	
		SELF.TYPE_CD					:= MAP(tempStdLicType='MLO' => 'MD',
															   tempStdLicType='' => '',
		                             'GR');

		//Clean up org_name
    ClnOrgName						:= MAP(TRIM(SELF.TYPE_CD)='MD' => '',
		                             StringLib.StringFind(TrimNameOrg,' AKA ',1) >0 => StringLib.StringFindReplace(TrimNameOrg,' AKA ',' DBA '),
		                             StringLib.StringFind(TrimNameOrg,' D/B/A ',1) >0 => StringLib.StringFindReplace(TrimNameOrg,' D/B/A ',' DBA '),
		                             StringLib.StringFind(TrimNameOrg,' AND D/B/A ',1) >0 => StringLib.StringFindReplace(TrimNameOrg,' AND D/B/A ',' DBA '),
		                             StringLib.StringFind(TrimNameOrg,' AND/OR D/B/A ',1) >0 => StringLib.StringFindReplace(TrimNameOrg,' AND/OR D/B/A ',' DBA '),
		                             StringLib.StringFind(TrimNameOrg,' AND/OR ',1) >0 => StringLib.StringFindReplace(TrimNameOrg,' AND/OR ',' DBA '),
																 StringLib.StringFind(TrimNameOrg,'D\\B\\',1) >0 => StringLib.StringFindReplace(TrimNameOrg,'\\',' '),
																 TrimNameOrg);
		tempCorpDBA						:= MAP(REGEXFIND('(^.*) DBA (.* DBA .* DBA .*$)',ClnOrgName) => REGEXFIND('(^.*) DBA (.* DBA .* DBA .*$)',ClnOrgName, 2),
		                             REGEXFIND('(^.*) DBA (.* DBA .*$)',ClnOrgName) => REGEXFIND('(^.*) DBA (.* DBA .*$)',ClnOrgName, 2),
																 REGEXFIND(DBApattern,ClnOrgName) => REGEXFIND(DBApattern,ClnOrgName,3),
																 '');
		getCorpOnly						:= MAP(REGEXFIND('(^.*) DBA (.* DBA .* DBA .*$)',ClnOrgName) => REGEXFIND('(^.*) DBA (.* DBA .* DBA .*$)',ClnOrgName, 1),
		                             REGEXFIND('(^.*) DBA (.* DBA .*$)',ClnOrgName) => REGEXFIND('(^.*) DBA (.* DBA .*$)',ClnOrgName, 1),
		                             REGEXFIND(DBApattern,ClnOrgName) => REGEXFIND(DBApattern,ClnOrgName,1),
																 ClnOrgName);		//get names without DBA names
		std_org_name					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getCorpOnly);
		StripOrgName					:= IF(REGEXFIND(IPpattern,std_org_name),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',std_org_name,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',std_org_name,' CO')));  //Without punct. and Sufx removed

		//Clean individual name
		TrimFullName          := MAP(SELF.RAW_LICENSE_TYPE = 'BROKERS EXEMPT' => TrimContact,  
     		                         SELF.RAW_LICENSE_TYPE = 'MORTGAGE BROKER' => TrimContact,
		                             SELF.RAW_LICENSE_TYPE = 'CHARTERED BANKS' => TrimCEO,
																 SELF.RAW_LICENSE_TYPE = 'NONDEPOSIT TRUST' => TrimCEO,
																 SELF.RAW_LICENSE_TYPE = 'S&L ASSOCIATIONS' => TrimCEO,
																 SELF.RAW_LICENSE_TYPE = 'MORTGAGE BROKER' => TrimContact,
		                             TRIM(SELF.TYPE_CD)='MD' AND TrimNameOrg<>'' => TrimNameOrg, 
		                             '');
																 
		SuffixPattern         := '(JR\\.|SR\\.| JR$| JR | SR$| SR | III| II| IV$| IV | VII$| VII | VI$| VI )';
		removesuffix          := REGEXREPLACE(SuffixPattern,TrimFullName,'');
		TmpSuffix             := TRIM(REGEXFIND(SuffixPattern,TrimFullName,0),LEFT,RIGHT);
		ClnLFMName						:= MAP(SELF.TYPE_CD = 'MD' AND TrimNameOrg<>'' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(removeSuffix),
		                             SELF.RAW_LICENSE_TYPE = 'BROKERS EXEMPT' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TRIM(TrimContact,LEFT,RIGHT)),
																 SELF.RAW_LICENSE_TYPE = 'CHARTERED BANKS' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TRIM(REGEXREPLACE(Title, TrimCEO,''),LEFT,RIGHT)),
																 SELF.RAW_LICENSE_TYPE = 'NONDEPOSIT TRUST' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TRIM(REGEXREPLACE(Title, TrimCEO,''),LEFT,RIGHT)),
																 SELF.RAW_LICENSE_TYPE = 'S&L ASSOCIATIONS' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TRIM(REGEXREPLACE(Title, TrimCEO,''),LEFT,RIGHT)),
																 SELF.RAW_LICENSE_TYPE = 'MORTGAGE BROKER' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TRIM(TrimContact,LEFT,RIGHT)),
																 '');
														
		TempLName             := IF(REGEXFIND('(.*),(.*)',removesuffix),REGEXFIND('(.*),(.*)',removesuffix,1),'');
		TempFMName            := IF(REGEXFIND('(.*),(.*)',removesuffix),REGEXFIND('(.*),(.*)',removesuffix,2),''); 
		TempFName             := IF(REGEXFIND('(.*) (.*)',TempFMName),REGEXFIND('(.*) (.*)',TempFMName,1),TempFMName); 
		TempMName             := IF(REGEXFIND('(.*) (.*)',TempFMName),REGEXFIND('(.*) (.*)',TempFMName,2),''); 
		
		GoodNAME_PREFX      	:= IF(ClnLFMName<>'',TRIM(ClnLFMName[1..5],LEFT,RIGHT),'');
		GoodNAME_FIRST				:= IF(ClnLFMName<>'',TRIM(ClnLFMName[6..25],LEFT,RIGHT),'');
		GoodNAME_MID					:= IF(ClnLFMName<>'',TRIM(ClnLFMName[26..45],LEFT,RIGHT),'');
		GoodNAME_LAST				  := IF(ClnLFMName<>'',TRIM(ClnLFMName[46..65],LEFT,RIGHT),'');
		GoodNAME_SUFX				  := IF(TmpSuffix <> '',TmpSuffix,
		                            IF(ClnLFMName<>'',TRIM(ClnLFMName[66..70],LEFT,RIGHT),''));	
						
		SELF.NAME_PREFX     	:= GoodNAME_PREFX;
		
		SELF.NAME_FIRST				:= MAP(TrimFullName[1..2] != GoodNAME_LAST[1..2] AND SELF.type_cd = 'MD' => TRIM(TempFName,LEFT,RIGHT),
		                             ClnLFMName<>''=> TRIM(ClnLFMName[6..25],LEFT,RIGHT),
		                             '');
		SELF.NAME_MID					:= MAP(TrimFullName[1..2] != GoodNAME_LAST[1..2] AND SELF.type_cd = 'MD' => TRIM(TempMName,LEFT,RIGHT),	                             
																 ClnLFMName<>''=> TRIM(ClnLFMName[26..45],LEFT,RIGHT),
		                             '');
		SELF.NAME_LAST				:= MAP(TrimFullName[1..2] != GoodNAME_LAST[1..2] AND SELF.type_cd = 'MD' => TRIM(TempLName,LEFT,RIGHT),		                             
																 ClnLFMName<>''=> TRIM(ClnLFMName[46..65],LEFT,RIGHT),
		                             '');
		SELF.NAME_SUFX				:= GoodNAME_SUFX;


		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(std_org_name);
		SELF.NAME_ORG_PREFX		:= IF(SELF.TYPE_CD = 'GR',Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(std_org_name),'');
		SELF.NAME_ORG					:= IF(SELF.TYPE_CD = 'GR',
		                            StringLib.StringCleanSpaces(StripOrgName),
																TRIM(SELF.NAME_LAST) + ' ' + TRIM(SELF.NAME_FIRST));
		SELF.NAME_ORG_SUFX 		:= IF(SELF.TYPE_CD = 'GR',Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, '')),'');

		//Mari name fields
		SELF.NAME_ORG_ORIG		:= IF(SELF.NAME_ORG<>'',TrimNameOrg,'');
														 
		SELF.NAME_FORMAT			:= MAP(SELF.TYPE_CD = 'GR' AND SELF.NAME_ORG<>'' => 'F',
		                             SELF.TYPE_CD = 'MD' AND TrimNameOrg<>'' => 'L',
																 '');
		
    SELF.LICENSE_NBR      := MAP(TrimLicNumber<>'' AND tempStdLicType = 'BRC'=> TrimLicNumber + L.BRANCH_NBR,
		                             TrimLicNumber<>'' AND tempStdLicType != 'BRC'=> TrimLicNumber,
																 'NR');		
		SELF.OFF_LICENSE_NBR  := MAP(TrimLicNumber<>'' AND tempStdLicType = 'BRC'=> TrimLicNumber,
		                             SELF.RAW_LICENSE_TYPE = 'MORTGAGE LOAN ORIGINATOR' => TrimBranchNbr,
		                             '');													 
		SELF.OFF_LICENSE_NBR_TYPE := MAP(TrimLicNumber<>'' AND tempStdLicType = 'BRC'=>  'AFFILIATED MAIN BRANCH',
		                                 SELF.RAW_LICENSE_TYPE = 'MORTGAGE LOAN ORIGINATOR' => 'EMPLOYER NUMBER',
		                                 '');
		SELF.AFFIL_TYPE_CD    := MAP(TrimLicNumber<>'' AND tempStdLicType = 'BRC'=>  'BR',
		                             SELF.TYPE_CD='MD'=>'IN',
		                             SELF.TYPE_CD='GR'=>'CO',
														     '');																	
													
		//Clean and extract name or company name from address
	  companyNameFmAddress	:= MAP(REGEXFIND('(^C/O[ ]+)([A-Z]+.*),.*,.*$',TmpAddress)
		                                => REGEXFIND('(^C/O[ ]+)([A-Z]+.*),.*,.*$',TmpAddress,2),
																 REGEXFIND('(^C/O[ ]+)([A-Z]+.*),',TmpAddress)
		                                => REGEXFIND('(^C/O[ ]+)([A-Z]+.*),',TmpAddress,2),
																 '');
	  PersonNameFmAddress		:= IF(REGEXFIND('(,[ ]*C/O[ ]+)(.*$)',TmpAddress),REGEXFIND('(,[ ]*C/O[ ]+)(.*$)',TmpAddress,2),'');
		rmCOFmAddress					:= TRIM(REGEXREPLACE('([ ]*C/O)',TmpAddress,''),LEFT,RIGHT);  //remove leading c/o
		rmCompanyFmAddress		:= IF(companyNameFmAddress<>'',REGEXREPLACE(companyNameFmAddress,rmCOFmAddress,''),rmCOFmAddress);
		rmPersonFmAddress			:= IF(PersonNameFmAddress<>'',REGEXREPLACE(PersonNameFmAddress,rmCompanyFmAddress,''),rmCompanyFmAddress);
		clnAddress1 					:= TRIM(REGEXREPLACE('(^,|,$)',TRIM(rmPersonFmAddress,LEFT,RIGHT),''),LEFT,RIGHT);
		temp_mail_preaddr1 		:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_mail_preaddr2 		:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState+' '+TrimZip); 
		clnMailAddrAddr1			:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_mail_preaddr1,temp_mail_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmp_mail_ADDR_ADDR1_1	:= TRIM(clnMailAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[45..46],LEFT,RIGHT);																	
		tmp_mail_ADDR_ADDR2_1	:= TRIM(clnMailAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= MAP(REGEXFIND('WILLIAM D ROEBUCK INDUSTRIAL',TmpAddress)=> TRIM(TmpAddress,LEFT,RIGHT),
		                             tmp_mail_ADDR_ADDR1_1='' => TRIM(tmp_mail_ADDR_ADDR2_1,LEFT,RIGHT),
																 TRIM(tmp_mail_ADDR_ADDR1_1,LEFT,RIGHT));	
		SELF.ADDR_ADDR2_1			:= MAP(REGEXFIND('WILLIAM D ROEBUCK INDUSTRIAL',TmpAddress) => '',
		                             TRIM(SELF.ADDR_ADDR1_1)=TRIM(tmp_mail_ADDR_ADDR2_1) => '',
		                             tmp_mail_ADDR_ADDR2_1); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnMailAddrAddr1[65..89])<>'',TRIM(clnMailAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnMailAddrAddr1[115..116])<>'',TRIM(clnMailAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnMailAddrAddr1[117..121])<>'',TRIM(clnMailAddrAddr1[117..121]),TrimZip);
		SELF.ADDR_ZIP4_1		  := clnMailAddrAddr1[122..125];
		SELF.ADDR_CNTY_1      := IF(REGEXFIND('COMPANY',TrimCounty),'',TrimCounty);
		SELF.ADDR_BUS_IND			:= IF(TRIM(clnMailAddrAddr1)<>'','B','');

		//Set up office name if there is a company name in the address
		tmpNameOffice    			:= MAP(companyNameFmAddress<>''=>Prof_License_Mari.mod_clean_name_addr.strippunctName(companyNameFmAddress),
		                            SELF.RAW_LICENSE_TYPE = 'MORTGAGE LOAN ORIGINATOR' => TrimDBA,
																'');
		stripNameOffice				:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tmpNameOffice);
		SELF.NAME_OFFICE			:= MAP(TRIM(stripNameOffice,ALL) = TRIM(SELF.NAME_ORG,ALL) =>'',
		                             TRIM(stripNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(stripNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(stripNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																 TRIM(stripNameOffice,LEFT,RIGHT));

		SELF.OFFICE_PARSE			:= IF(TRIM(SELF.NAME_OFFICE)='','','GR');
		SELF.NAME_MARI_ORG		:= MAP(SELF.TYPE_CD = 'GR' AND NOT REGEXFIND('(\\.COM|\\.NET)',std_org_name)
																		=> StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(std_org_name)),
														     SELF.TYPE_CD = 'GR' AND REGEXFIND('(\\.COM|\\.NET)',std_org_name)
																		=> StringLib.StringCleanSpaces(std_org_name),
																 SELF.type_cd ='MD' AND TRIM(SELF.NAME_OFFICE)<>''		
																		=> TRIM(SELF.name_office),
																 '');

		TempContact           := MAP(TrimContact != ''=> TrimContact,
		                             TrimCEO != '' => REGEXREPLACE(Title, TrimCEO,''),
		                             PersonNameFmAddress);	
														 
		ParseContact					:= Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TempContact);
		SELF.NAME_CONTACT_PREFX:= TRIM(ParseContact[1..5],LEFT,RIGHT);
		SELF.NAME_CONTACT_FIRST:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID	:= TRIM(ParseContact[26..45],LEFT,RIGHT);
		SELF.NAME_CONTACT_LAST:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX:= TRIM(ParseContact[66..70],LEFT,RIGHT);
		

    SELF.NAME_CONTACT_TTL := MAP(TrimContact != '' => 'AGENT',
		                             Title != '' => TRIM(Title,LEFT,RIGHT),
		                             '');
																 
		SELF.CREDENTIAL       := MAP(SELF.RAW_LICENSE_TYPE = 'MORTGAGE BROKER' => 'AGENT',
		                             SELF.RAW_LICENSE_TYPE = 'CHARTERED BANKS' => SELF.NAME_CONTACT_TTL,
																 SELF.RAW_LICENSE_TYPE = 'NONDEPOSIT TRUST' => SELF.NAME_CONTACT_TTL,
																 SELF.RAW_LICENSE_TYPE = 'S&L ASSOCIATIONS' => SELF.NAME_CONTACT_TTL,
																 '');																		 
																 
		// Identified DBA names
		fixCorpDBA 						:= REGEXREPLACE(';',tempCorpDBA,' DBA ');
		fixCorpDBA1 					:= REGEXREPLACE(' DBA[ ]+DBA ',fixCorpDBA,' DBA ');
		StdNAME_DBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(fixCorpDBA1);
		ClnDBAName						:= MAP(REGEXFIND('ADVANCE AMERICA, CASH ADVANCE CENTERS',StdNAME_DBA) => StringLib.StringCleanSpaces(REGEXREPLACE(',',StdNAME_DBA,'')),
																	REGEXFIND('(, AND DBA)$',StdNAME_DBA) => StringLib.StringCleanSpaces(REGEXREPLACE('(, AND DBA)',StdNAME_DBA,'')),
																	REGEXFIND('(, INC)',StdNAME_DBA) => StringLib.StringCleanSpaces(REGEXREPLACE('(, INC)',StdNAME_DBA,' INC')),
																	REGEXFIND('(,INC)',StdNAME_DBA) => StringLib.StringCleanSpaces(REGEXREPLACE('(,INC)',StdNAME_DBA,' INC')),
																	REGEXFIND('(,[ ]*LLC)',StdNAME_DBA) => StringLib.StringCleanSpaces(REGEXREPLACE('(,[ ]*LLC)',StdNAME_DBA,' LLC')),
																	StdNAME_DBA);
		prepDBA								:= IF(REGEXFIND('(AND OR |AND[ ]*/[ ]*OR DBA |AND[ ]*/[ ]*OR |DBA |D B A |/|,)',ClnDBAName),
														    REGEXREPLACE('(AND OR |AND[ ]*/[ ]*OR DBA |AND[ ]*/[ ]*OR |DBA |D B A |/|,)',ClnDBAName, ' / '),ClnDBAName);
		prepDBA1							:= IF(REGEXFIND('[ ]*/[ ]*/[ ]*',prepDBA),REGEXREPLACE('[ ]*/[ ]*/[ ]*',prepDBA,' / '),prepDBA);
		ClnSpaceDBA						:= StringLib.StringCleanSpaces(prepDBA1);
		
	//Parse DBA fields  
    SELF.DBA1     := IF(SELF.RAW_LICENSE_TYPE != 'MORTGAGE LOAN ORIGINATOR',REGEXREPLACE('DBA ',REGEXFIND('(.*) DBA (.*)',TrimDBA,1),''),'');	
 	  
 	  SELF.DBA2     := IF(SELF.RAW_LICENSE_TYPE != 'MORTGAGE LOAN ORIGINATOR',REGEXFIND('(.*) DBA (.*)',TrimDBA,2),'');	
	
		SELF.DBA3			:=  MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',ClnSpaceDBA,2),
												  StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
												  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,1),
												  StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
												  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,1),
												  StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 => REGEXFIND('^([^\\/]+)[\\/][ ]([^\\/]+)',ClnSpaceDBA,1),
												  StringLib.stringfind(ClnSpaceDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',ClnSpaceDBA,1),ClnSpaceDBA);
				
		SELF.dba4			:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
												 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,2),
											   StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											   REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,2),
											   StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 => REGEXFIND('^([^\\/]+)[\\/][ ]([^\\/]+)',ClnSpaceDBA,2),
											   StringLib.stringfind(ClnSpaceDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',ClnSpaceDBA,2),
																								 ' ');
							
		SELF.dba5 		:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
											   REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
											   StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
										 	   REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
											   StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 =>
											   REGEXFIND('^([^/]+)[/][ ]([^\\/]+)[\\/][ ]([^\\/]+)',ClnSpaceDBA,3),
																									'');
				
		SELF.dba6 		:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
												 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,4),
											   StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											   REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,4),
											   StringLib.stringfind(ClnSpaceDBA,'/',3) > 0 =>
											   REGEXFIND('([^/]+)[/][ ]([^\\/]+)[\\/][ ]([^\\/]+)[/][ ]([^\\/]+)',ClnSpaceDBA,4), 
																									 '');
				
		SELF.dba7 			:= IF(StringLib.stringfind(ClnSpaceDBA,'/',4) > 0,
											    REGEXFIND('^([^/]+)[/][ ]([^\\/]+)[\\/][ ]([^\\/]+)[/][ ]([^\\/]+)[/][ ]([^\\/]+)',ClnSpaceDBA,5),'');

		SELF.dba8 			:= IF(StringLib.stringfind(ClnSpaceDBA,'/',5) > 0,
													REGEXFIND('^([^/]+)[/][ ]([^\\/]+)[\\/][ ]([^\\/]+)[/][ ]([^\\/]+)[/][ ]([^\\/]+)[/][ ]([^\\/]+)',ClnSpaceDBA,6),'');
		SELF.dba9 			:= IF(StringLib.stringfind(ClnSpaceDBA,'/',4) > 0,
													REGEXFIND('^([^/]+)[/][ ]([^\\/]+)[\\/][ ]([^\\/]+)[/][ ]([^\\/]+)[/][ ]([^\\/]+)[/][ ]([^\\/]+)[/][ ]([^\\/]+)',ClnSpaceDBA,7),'');
    SELF.NAME_DBA_ORIG := IF(SELF.RAW_LICENSE_TYPE != 'MORTGAGE LOAN ORIGINATOR',TrimDBA,'');		
																
		TmpApproval        := TRIM(REGEXREPLACE('-',TrimApproval,' '),LEFT,RIGHT);		
		
    SELF.BUSINESS_TYPE := MAP(STD.STR.FIND(TrimCounty,'INTERNET',1)>0 => 'INTERNET COMPANY',
		                          TmpApproval != '' and regexfind('[A-Za-z]',TmpApproval) => TmpApproval,
                              '');
															
    SELF.NMLS_ID       := (INTEGER) IF(SELF.RAW_LICENSE_TYPE = 'MORTGAGE BROKER' OR SELF.RAW_LICENSE_TYPE = 'MORTGAGE LOAN ORIGINATOR',TmpApproval,'');    
		
		SELF.PHN_MARI_1		 := TRIM(TrimPhone,LEFT,RIGHT);
		SELF.PHN_PHONE_1	 := TRIM(TrimPhone,LEFT,RIGHT);
		SELF.EMAIL         := TRIM(L.EMAIL,LEFT,RIGHT);

		SELF.PROVNOTE_1     := IF(TrimApproval<>'','APPROVAL = '+ TrimApproval,'');
		SELF.PROVNOTE_2			:= IF(TrimAsset<>'' AND TrimAsset<>'$','ASSET = '+ TrimAsset+',000','');
		SELF.PROVNOTE_3			:= IF(TrimLicNumber='','{LICENSE NUMBER ASSIGNED};','')+
		                       '{LICENSE STATUS ASSIGNED}';
													 
	/* fields used to create mltreckey key are:
		license number
		license type
		source update
		name
		address_1
	*/
		 
		mltreckeyHash := HASH64(TrimLicNumber 
														+TrimLicType
														+TRIM(src_cd,LEFT,RIGHT)
														+TrimNameOrg
														+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(StdNAME_DBA)
														+TrimAddress1
														+TrimCity
														+TrimState
														+TrimZip); 
			
		SELF.mltreckey := IF(SELF.dba3 != ' ',mltreckeyHash, 0);

		/*fields used to create cmc_slpk unique key are :
			license number
			office license number
			license type
			source update
			standard name_org w/o DBA
			raw address
		*/	
		SELF.CMC_SLPK     := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																+TRIM(SELF.std_license_type,LEFT,RIGHT)
																+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
																+TrimCity
																+TrimState
															  +TrimZip);
		SELF.PCMC_SLPK    := 0;
		
	SELF := [];
	END;

	ds_map   := PROJECT(ValidMOFile, transformToCommon(LEFT));
	O_ds_map := OUTPUT(ds_map);
	
	// Normalized DBA RECORDs
	maribase_dbas := RECORD,MAXLENGTH(7500)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map L, INTEGER C) := TRANSFORM
		SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5, L.DBA6, L.DBA7, L.DBA8, L.DBA9);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map,8,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '' AND DBA6 = '' AND DBA7 = '' AND DBA8 ='' AND DBA9 ='');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
		//Fix some irregular syntax
		tmpDBA							:= TRIM(REGEXREPLACE('AND D B A',L.TMP_DBA,''),LEFT,RIGHT);
		tmpDBA1							:= REGEXREPLACE(' AND$',tmpDBA,'');
		tmpDBA2							:= REGEXREPLACE('^OR',tmpDBA1,'');
		StdNAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpDBA2);
		DBA_SUFX						:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);		   
		ClnDBA				 			:= IF(REGEXFIND(IPpattern,L.TMP_DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')));
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
		SELF.NAME_DBA				:= IF(TRIM(ClnDBA) != TRIM(L.NAME_ORG), ClnDBA,'');
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',DBA_SUFX,'')),''); 
		SELF.NAME_MARI_DBA	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',TRIM(StdNAME_DBA,LEFT,RIGHT),'');  
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));


	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,						              
											 TRIM(LEFT.OFF_LICENSE_NBR,LEFT,RIGHT)	= TRIM(RIGHT.LICENSE_NBR,LEFT,RIGHT)
								       AND LEFT.AFFIL_TYPE_CD IN ['IN','BR'],
											 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);		

	//remove dup RECORDs
	ds_map_base_dep := DEDUP(SORT(DISTRIBUTE(ds_map_affil(NAME_ORG<>''),HASH(name_org,addr_addr1_1,raw_license_type)),name_org,addr_addr1_1,raw_license_type,LOCAL),RECORD,LOCAL);
	
	d_final   := OUTPUT(ds_map_base_dep, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base_dep);
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg','using', 'used'));	

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	

	RETURN SEQUENTIAL(o_MO_Mortgage,o_cmvtranslation,O_ValidMOFile,O_ds_map,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;
