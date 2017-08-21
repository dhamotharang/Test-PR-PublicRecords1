//************************************************************************************************************* */	
//  The purpose of this development is take MI Real Estate Appraisers/Brokers and Misc. License raw files and 
//  convert them to a common professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, NID;

EXPORT map_MIS0298_conversion(STRING pVersion) := FUNCTION
#workunit('name','map_MIS0298_conversion');
	code 								:= 'MIS0298';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Define constants
	DBApattern	:= '^(.*)(DBA |AKA|C/O |D B A |D\\.B\\.A |D/B/A |T/A )(.*)';
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';		//pattern for internet companies
	Datepattern := '^(.*)/(.*)/(.*)$';																					//date pattern
	BadStatus	:= ['1000','1026','1050','1000.00','1050.00'];										//invalid status. Add 1026 to this list. 2/22/13 Cathy Tio
  //12 => Appraiser License
	ValidProfID	:= ['65','12','12.00'];																									//valid prof IDs

	//Pattern for address2 in address1 field
	Addr2Pattern		:= '^(S(?:UITE|TUITE|TE)[S]*|LOT |UNIT |CONDO |CROSSING|DEPT[.]*|PO BOX|P O BOX|P[.]O[.] BOX|BLD|GENERAL DELIVERY|ONE |TWO |FOUR |#)';
	Addr2_2Pattern	:= '(.*)( BLDG| CONDO[S]*|HOTEL |MOTEL |LANDING | FLOOR| PLAZA| TOWER| SQUARE| (PARK$))';
 
  //Suffix Name Pattern
	Sufx_Pattern      := '[,]?( SR\\.| SR| JR\\.| JR| III| II$| II| IV$| IV | VII$| VII | VI$| VI )';

	//Pattern for out of state address
	ForeignPattern	:= '(.*)(LONDON|ONTARIO|ALBERTA|CANADA)(.*)';

	//Pattern for office name exclusions
	ExcludeOffice		:= '^(DIRECTOR OF|ATTN: |ATTN |DETROIT MI|APPRAISALS BY|SE | SE$|NE | NE$|SW | SW$|NORTH|SOUTH EAST)[ ]*[A-Z]*';

	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^.* VALUATIONLTD$|^.* CTY ESTATES$|^.* BANK$|THE SIGNAL GROUP |INTEGRA REALTY RESOURCES|GREENVILLE COLLEGE|GRAY FOX|' +
					 'GENERAL DELIVERY|^.* BUILDING$|^.* LAKE RESORT$|^C/O [A-Z ]$' +
					 ')';

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd); 
	O_Cmvtranslation  := OUTPUT(ds_Cmvtranslation);

	ds_MI_Broker	:= Prof_License_Mari.files_MIS0298.Broker;
	ds_MI_RealEstate	:= Prof_License_Mari.files_MIS0298.re;
	ds_MI_Misc		:= Prof_License_Mari.files_MIS0298.MiscLic(NOT REGEXFIND('(^NUMBER USED TO|^PUBLICATION/TEACHING|^OUT OF STATE)',ORG_NAME,NOCASE));
	oBroker				:= OUTPUT(ds_MI_Broker);
	oRE						:= OUTPUT(ds_MI_RealEstate);
	oMisc					:= OUTPUT(ds_MI_Misc);
	
	/*Combine all three into one common layout for processing and standardize dates*/
	layout_raw_common	:= RECORD
			STRING11   PROFID;
			STRING15   SLNUM;
			STRING150  ORG_NAME;
			STRING3	   ORG_TYPE; 	
			STRING10   ISSUEDT;
			STRING30   COUNTY;
			STRING3	   CNTRY_CD;
			STRING60   ADDRESS1;
			STRING60   ADDRESS2;
			STRING60   ADDRESS3;
			STRING35   CITY;
			STRING2    STATE;
			STRING5	   ZIP;
			STRING11   LIC_TYPE;
			STRING15   LICSTAT;
			STRING10   STAT_DATE;
			STRING10   EXPDT;
			STRING15   OFF_SLNUM;
			STRING60	 OFFICENAME,
			STRING150	 DBA;
			STRING40	 PREADDRESS1;
			STRING40	 PREADDRESS2;
			STRING40	 PREADDRESS3;
			STRING35	 PRECITY;
			STRING2		 PRESTATE;
			STRING5		 PREZIP;
			STRING10   PREENTITYID;
			STRING10	 PREPERSONID;
		END;
		
	layout_raw_common map_MI_Broker(ds_MI_Broker L)	:= TRANSFORM
		SELF.ISSUEDT		:= TRIM(L.ISSUEDT);
		SELF.STAT_DATE	:= TRIM(L.STAT_DATE);
		SELF.EXPDT			:= TRIM(L.EXPDT);												
		SELF      := L;
		SELF      := [ ];
	END;
	ds_Broker_common	:= PROJECT(ds_MI_Broker,map_MI_Broker(LEFT));
	
	layout_raw_common map_MI_RealEstate(ds_MI_RealEstate L)	:= TRANSFORM
		SELF.DBA			  := TRIM(L.DBA_NAME);
		SELF.ISSUEDT		:= TRIM(L.ISSUEDT);
		SELF.EXPDT			:= TRIM(L.EXPDT);												
		SELF            := L;
		SELF            := [ ];
	END;
	ds_RealEstate_common	:= PROJECT(ds_MI_RealEstate,map_MI_RealEstate(LEFT));

	layout_raw_common map_MI_Misc(ds_MI_MISC L)	:= TRANSFORM
		SELF.ISSUEDT		  := TRIM(L.ISSUEDT);
		SELF.STAT_DATE	  := TRIM(L.STAT_DATE);
		SELF.EXPDT			  := TRIM(L.EXPDT);
		SELF.PREPERSONID	:= TRIM(L.PRESLNUM);
		SELF      := L;
		SELF      := [ ];
	END;
	ds_Misc_common	:= PROJECT(ds_MI_MISC,map_MI_Misc(LEFT));
	
	ds_raw_common	:= ds_Broker_common+ds_RealEstate_common+ds_Misc_common;

	
	//Remove bad records before processing
	ValidMIFile	:= ds_raw_common(TRIM(ORG_NAME,LEFT,RIGHT) <> ' ' AND 
															 TRIM(ORG_NAME,LEFT,RIGHT) != 'RELICENSURE DUMMY RECORD' AND
															 TRIM(LICSTAT,LEFT,RIGHT) NOT IN BadStatus AND 
															 TRIM(PROFID,LEFT,RIGHT) IN ValidProfID AND
															 TRIM(SLNUM,LEFT,RIGHT) <> ' ');

	//raw to MARIBASE layout
	Prof_License_Mari.layouts.base	transformToCommon(layout_raw_common L) := TRANSFORM
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
		
		TrimOrgName						:= ut.CleanSpacesAndUpper(L.ORG_NAME);
		TrimOrgType						:= ut.CleanSpacesAndUpper(L.ORG_TYPE);		
		
		TmpOrgTypePerson			:= IF(TrimOrgType = 'N' OR TrimOrgType = 'I' OR TrimOrgType = 'SP',TRUE,FALSE);
		SELF.TYPE_CD					:= IF(TmpOrgTypePerson,'MD','GR');

		TrimSufxName          := MAP(TrimOrgType IN ['I','SP','N'] AND REGEXFIND('(^.*),(.*),(.*)',TrimOrgName) => TRIM(REGEXFIND('(^.*),(.*),(.*)',TrimOrgName,3),LEFT,RIGHT),
		                             TrimOrgType IN ['I','SP','N'] AND REGEXFIND(Sufx_Pattern,TrimOrgName) => TRIM(REGEXFIND(Sufx_Pattern,TrimOrgName,0),LEFT,RIGHT),
																 '');
		removeSufxName        := IF(REGEXFIND(Sufx_Pattern,TrimOrgName),REGEXREPLACE(Sufx_Pattern,TrimOrgName,''),TrimOrgName);														 
		TrimLastName          := IF(TRIM(TrimOrgType) IN ['I','SP','N'] AND REGEXFIND('(^.*),(.*)',removeSufxName),
                                TRIM(REGEXFIND('(^.*),(.*)',removeSufxName,1),LEFT,RIGHT),'');
		TempLastName          := IF(REGEXFIND(Sufx_Pattern,TrimLastName),REGEXREPLACE(Sufx_Pattern,TrimLastName,''),TrimLastName);														
		TrimFMName            := IF(TRIM(TrimOrgType) IN ['I','SP','N'] AND REGEXFIND('(^.*),(.*)',removeSufxName),
		                            TRIM(REGEXFIND('(^.*),(.*)',removeSufxName,2),LEFT,RIGHT),'');	
		TempFNName    			  := IF(REGEXFIND(Sufx_Pattern,TrimFMName),REGEXREPLACE(Sufx_Pattern,TrimFMName,''),TrimFMName);											
		TrimFirstName         := IF(TRIM(TrimOrgType) IN ['I','SP','N'] AND REGEXFIND('(.*) (.*)',TempFNName),REGEXFIND('(.*) (.*)',TempFNName,1),TempFNName); 
		TrimMidName           := IF(TRIM(TrimOrgType) IN ['I','SP','N'] AND REGEXFIND('(.*) (.*)',TempFNName),REGEXFIND('(.*) (.*)',TempFNName,2),''); 

		//org_names of org_type I and SP are in the format of last_name, first_name middle_name, suffix
		tmpOrgName						:= IF(TrimOrgType IN ['I','SP','N'],removeSufxName,
																TrimOrgName);														
		//Org_type can be I,Y,N,C,P,PC,PL,LP,LLP,SP. Any org that is not N,I,SP, has its business name in org_name field.								
		// assigning type code based on license type
		IndName								:= IF(TmpOrgTypePerson,
																StringLib.StringToUpperCase(tmpOrgName),
																' ');																
		ClnIndName						:= MAP(tmpOrgName<>'' AND TrimOrgType='I' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(tmpOrgName),
															   tmpOrgName<>'' AND TrimOrgType='SP' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(tmpOrgName),
																 tmpOrgName<>'' AND TrimOrgType='N' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tmpOrgName),
																 ' ');																
		
		StdName								:= MAP(ClnIndName<>' ' AND  TrimOrgType<>'I'=> StringLib.StringCleanSpaces(ClnIndName[46..65]+' '+ClnIndName[6..25]),
		                             ClnIndName<>' ' AND  TrimOrgType = 'I' => StringLib.StringCleanSpaces(TempLastName + ' ' + TrimFirstName),
															 	' ');	
		ClnStdName						:= IF(TRIM(StdName) = ' ',Prof_License_Mari.mod_clean_name_addr.strippunctName(IndName),StdName);

		//Any org that is not N,I,SP, has its business name in org_name field.								
		BusName								:= IF(IndName = ' ',
															  StringLib.StringToUpperCase(tmpOrgName),
																IF(StdName=' ',
																	 IndName,
																	 ' '));
		
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(BusName); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);

		cln_std_corp					:= IF(REGEXFIND(IPpattern,BusName),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(BusName),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')));
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
		SELF.NAME_ORG					:= IF(TRIM(cln_std_corp) = ' ',ClnStdName,REGEXREPLACE('/',REGEXREPLACE(' COMPANY',cln_std_corp,' CO'),' '));
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
		//Clean DBA name
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		clnDba								:= MAP(REGEXFIND(IPpattern,tmpNameDBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNameDBA),
		                             REGEXFIND('AKA',tmpNameDBA) => REGEXREPLACE('AKA',tmpNameDBA,''),
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE('/',tmpNameDBA,' ')));
		SELF.NAME_DBA					:= REGEXREPLACE(' COMPANY',clnDba,' CO');
		SELF.NAME_DBA_SUFX		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0);
		
		SELF.NAME_FIRST				:= IF(TrimOrgType = 'I' AND LENGTH(TRIM(ClnIndName[46..65]))=1, TrimFirstName,
		                             IF(TmpOrgTypePerson AND ClnIndName!=' ', ClnIndName[6..25],
																 ' '));
		SELF.NAME_MID					:= IF(TrimOrgType = 'I' AND LENGTH(TRIM(ClnIndName[46..65]))=1, TrimMidName,
		                             IF(TmpOrgTypePerson AND ClnIndName!=' ', ClnIndName[26..45],
																 ' '));
		SELF.NAME_LAST				:= IF(TrimOrgType = 'I' AND LENGTH(TRIM(ClnIndName[46..65]))=1, TempLastName,
		                             IF(TmpOrgTypePerson AND ClnIndName!=' ', ClnIndName[46..65],
																 ' '));
		ClnName_Sufx          := TRIM(StringLib.StringFilterOut(TrimSufxName,','),LEFT,RIGHT);
		SELF.NAME_SUFX				:= IF(ClnName_Sufx <> '',ClnName_Sufx,ClnIndName[66..70]);	
		
		//Identify if officename exists in address and validate addresses
		ClnAddr1							:= ut.CleanSpacesAndUpper(L.ADDRESS1);
		ClnAddr2							:= ut.CleanSpacesAndUpper(L.ADDRESS2);
		ClnAddr3							:= ut.CleanSpacesAndUpper(L.ADDRESS3);

		ValidAddr1						:= IF(REGEXFIND('^[0-9]|(.*)[0-9]',ClnAddr1) OR REGEXFIND(Addr2Pattern,ClnAddr1) OR REGEXFIND(Addr2_2Pattern,ClnAddr1),ClnAddr1,
																IF(Prof_License_Mari.func_is_address(ClnAddr1) = TRUE,ClnAddr1,' '));
		ValidAddr2						:= IF(REGEXFIND('^[0-9]|(.*)[0-9]',ClnAddr2) OR REGEXFIND(Addr2Pattern,ClnAddr2) OR REGEXFIND(Addr2_2Pattern,ClnAddr2) AND NOT REGEXFIND(ForeignPattern,ClnAddr2),ClnAddr2,
																IF(Prof_License_Mari.func_is_address(ClnAddr2) = TRUE,ClnAddr2,' '));
		ValidAddr3						:= IF(REGEXFIND('^[0-9]|(.*)[0-9]',ClnAddr3) OR REGEXFIND(Addr2Pattern,ClnAddr2) OR REGEXFIND(Addr2_2Pattern,ClnAddr2) AND NOT REGEXFIND(ForeignPattern,ClnAddr3),ClnAddr3,
																IF(Prof_License_Mari.func_is_address(ClnAddr3) = TRUE,ClnAddr3,' '));
		FullStreet						:= StringLib.StringCleanSpaces(ValidAddr1+' '+ValidAddr2+' '+ValidAddr3);
		CityStZip							:= StringLib.StringCleanSpaces(L.CITY+' '+L.STATE+' '+L.ZIP);

		TempName1							:= IF(ValidAddr1 = ' ' AND NOT REGEXFIND('UNKNOWN|ADDRESS NOT KNOWN',ClnAddr1),ClnAddr1,' ');
		TempName1_2						:= IF(ValidAddr2 = ' ' AND NOT REGEXFIND('UNKNOWN|ADDRESS NOT KNOWN',ClnAddr2) AND NOT REGEXFIND(ForeignPattern,ClnAddr2),ClnAddr2,' ');
		
		ClnPreAddr1						:= ut.CleanSpacesAndUpper(L.PREADDRESS1);
		ClnPreAddr2						:= ut.CleanSpacesAndUpper(L.PREADDRESS2);
		ClnPreAddr3						:= ut.CleanSpacesAndUpper(L.PREADDRESS3);

		ValidPreAddr1					:= IF(REGEXFIND('^[0-9]|(.*)[0-9]',ClnPreAddr1) OR REGEXFIND(Addr2Pattern,ClnPreAddr1) OR REGEXFIND(Addr2_2Pattern,ClnPreAddr1),ClnPreAddr1,
																IF(Prof_License_Mari.func_is_address(ClnPreAddr1) = TRUE,ClnPreAddr1,' '));
		ValidPreAddr2					:= IF(REGEXFIND('^[0-9]|(.*)[0-9]',ClnPreAddr2) OR REGEXFIND(Addr2Pattern,ClnPreAddr2) OR REGEXFIND(Addr2_2Pattern,ClnPreAddr2) AND NOT REGEXFIND(ForeignPattern,ClnPreAddr2),ClnPreAddr2,
																IF(Prof_License_Mari.func_is_address(ClnPreAddr2) = TRUE,ClnPreAddr2,' '));
		ValidPreAddr3					:= IF(REGEXFIND('^[0-9]|(.*)[0-9]',ClnPreAddr3) OR REGEXFIND(Addr2Pattern,ClnPreAddr3) OR REGEXFIND(Addr2_2Pattern,ClnPreAddr3) AND NOT REGEXFIND(ForeignPattern,ClnPreAddr3),ClnPreAddr3,
																IF(Prof_License_Mari.func_is_address(ClnPreAddr3) = TRUE,ClnPreAddr3,' '));
		FullPreStreet					:= StringLib.StringCleanSpaces(ValidPreAddr1+' '+ValidPreAddr2+' '+ValidPreAddr3);
		PreCityStZip 					:= StringLib.StringCleanSpaces(L.PRECITY+' '+L.PRESTATE+' '+L.PREZIP);

		TempName2							:= IF(ValidPreAddr1 = ' ' AND NOT REGEXFIND('UNKNOWN|ADDRESS NOT KNOWN',ClnPreAddr1),ClnPreAddr1,' ');
		TempName2_2						:= IF(ValidPreAddr2 = ' ' AND NOT REGEXFIND('UNKNOWN|ADDRESS NOT KNOWN',ClnPreAddr2) AND NOT REGEXFIND(ForeignPattern,ClnPreAddr2),ClnPreAddr2,' ');
		TrimOfficeName        := ut.CleanSpacesAndUpper(L.OFFICENAME);
		temp_OfficeName				:= MAP(TrimOfficeName!=' '
		                               => TrimOfficeName,
																 TrimOfficeName=' ' AND REGEXFIND('( LLC$| INC$| INC\\.$| REALT$)',	 TempName1)
																	 => TempName1,
																 TrimOfficeName=' ' AND REGEXFIND('( LLC$| INC$| INC\\.$| REALT$)',	 TempName2)
																	 => TempName2,
																 TrimOfficeName=' ' AND TempName2!=' ' AND NOT REGEXFIND('[0-9]+',TempName2)
																	 => TempName2,
																 TrimOfficeName=' ' AND TempName1 != ' ' AND NOT REGEXFIND('[0-9]+',TempName1)
																	 => TempName1,
																 ' ');
		stdOfficeName					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_OfficeName);
		clnOfficeName					:= IF(REGEXFIND(' :THE| : THE',stdOfficeName),
																'THE'+' '+TRIM(REGEXREPLACE(':THE|: THE',stdOfficeName,'')),
																StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(stdOfficeName)));
		replOfficeSlash				:= REGEXREPLACE('^C/O|/|^DBA ',clnOfficeName,'');
		removeExclusion				:= REGEXREPLACE(ExcludeOffice,replOfficeSlash,' ');
		SELF.NAME_OFFICE			:= MAP(REGEXFIND('.COM',stdOfficeName) => TRIM(stdOfficeName,LEFT,RIGHT),
				                         TRIM(removeExclusion,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(removeExclusion,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																 TRIM(removeExclusion,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(removeExclusion,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST + SELF.NAME_MID,ALL) => '',
		                             TRIM(REGEXREPLACE(' COMPANY',removeExclusion,' CO'),LEFT,RIGHT));

  	SELF.OFFICE_PARSE		:= MAP(SELF.NAME_OFFICE = ' ' => ' ',
										           SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'GR',
										           SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
										           SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
										           SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
										           SELF.NAME_OFFICE != ' ' AND REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',SELF.NAME_OFFICE) => 'GR', 'MD');
	
	
		SELF.LICENSE_NBR			:= ut.CleanSpacesAndUpper(L.SLNUM);
		SELF.OFF_LICENSE_NBR	:= ut.CleanSpacesAndUpper(L.OFF_SLNUM);
		SELF.LICENSE_STATE		:= src_st;
		TrimRawLicense_Type   := ut.CleanSpacesAndUpper(L.LIC_TYPE);

		SELF.RAW_LICENSE_TYPE	:= REGEXREPLACE('\\.00',TrimRawLicense_Type,'');
		//remove leading 0                      '0[1-5]{1}$'
		SELF.STD_LICENSE_TYPE	:= IF(SELF.RAW_LICENSE_TYPE[1..1]='0',
																SELF.RAW_LICENSE_TYPE[2..2],
																SELF.RAW_LICENSE_TYPE);
		SELF.RAW_LICENSE_STATUS	:= REGEXREPLACE('\\.00',ut.CleanSpacesAndUpper(TRIM(L.LICSTAT,LEFT,RIGHT)),'');
		
		// Use default date of 17530101 for blank dates
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(L.ISSUEDT) = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(L.ISSUEDT));
		SELF.EXPIRE_DTE				:= IF(TRIM(L.EXPDT) = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(L.EXPDT));
		SELF.STATUS_EFFECT_DTE	:= IF(TRIM(L.STAT_DATE) = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(L.STAT_DATE));
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(PreCityStZip) != '','B',
																IF(TRIM(CityStZip) != '','B',''));
		SELF.NAME_ORG_ORIG		:= TrimOrgName;
		SELF.NAME_FORMAT			:= IF(TrimOrgType IN ['I','SP'], 'L', 'F');

		SELF.NAME_DBA_ORIG		:= ut.CleanSpacesAndUpper(L.DBA);
		SELF.NAME_MARI_ORG		:= IF(SELF.TYPE_CD = 'GR',REGEXREPLACE('/',tmpNameOrg,''),
																IF(SELF.TYPE_CD = 'MD' AND TRIM(ClnOfficeName) != '',TRIM(removeExclusion,LEFT,RIGHT),''));	
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != '',tmpNameDBA,'');

		// Identify officename from address1.  If found, move address2 to address1.
		// Also need to identify if PreAddress is populated, if not, then Address1 is used as business address
		// otherwise Address1 is secondary(mailing) address

		//Use address cleaner to clean address
		tmpZip	               := MAP(LENGTH(TRIM(L.ZIP))=3 => '00'+TRIM(L.ZIP),
		                              LENGTH(TRIM(L.ZIP))=4 => '0'+TRIM(L.ZIP),
																	TRIM(L.ZIP));		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnAddr1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnAddr2, RemovePattern);
		clnAddress3						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnAddr3, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2+' '+clnAddress3); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.CITY+' '+L.STATE+' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		GoodADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		GoodADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 														
		SELF.ADDR_ADDR1_1			:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR1_1,GoodADDR_ADDR2_1);																
		SELF.ADDR_ADDR2_1			:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR2_1,'');
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		SELF.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT));
		SELF.ADDR_CNTRY_1			:= IF(ClnPreAddr1 != ' ' AND REGEXFIND(ForeignPattern,ClnPreAddr2),'CANADA',
																IF(ClnPreAddr3 != ' ' AND REGEXFIND(ForeignPattern,ClnPreAddr3),'CANADA',
																	IF(ClnPreAddr1 = ' ' AND ClnAddr1 != ' ' AND REGEXFIND(ForeignPattern,ClnAddr2),'CANADA',
																		IF(ClnPreAddr1 = ' ' AND ClnAddr3 != ' ' AND REGEXFIND(ForeignPattern,ClnAddr3),'CANADA',' '))));
		
		/*Identify officename from address1.  If found, move address2 to address1.
	 Also need to identify if PreAddress is populated, if so, then Address1 is used as mailing address*/
		SELF.ADDR_MAIL_IND		:= IF(FullStreet != ' ' AND FullPreStreet != ' ','M',' ');

		tmpPreZip             := MAP(LENGTH(TRIM(L.PREZIP))=3 => '00'+TRIM(L.PREZIP),
		                             LENGTH(TRIM(L.PREZIP))=4 => '0'+TRIM(L.PREZIP),
																 TRIM(L.PREZIP));		

		clnPreAddress1				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnPreAddr1, RemovePattern);
		clnPreAddress2				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnPreAddr2, RemovePattern);
		clnPreAddress3				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnPreAddr3, RemovePattern);

		//Prepare the input to address cleaner
		temp_prepreaddr1 			:= StringLib.StringCleanSpaces(clnPreAddress1+' '+clnPreAddress2+' '+clnPreAddress3); 
		temp_prepreaddr2 			:= StringLib.StringCleanSpaces(L.PRECITY+' '+L.PRESTATE+' '+tmpPreZip); 
		clnAddrAddr2					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_prepreaddr1,temp_prepreaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_2				:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		PreAddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2			:= IF(PreAddrWithContact != ' ' AND tmpADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_2));	
		SELF.ADDR_ADDR2_2			:= IF(PreAddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2		  := IF(TRIM(clnAddrAddr2[65..89])<>'',TRIM(clnAddrAddr2[65..89]),ut.CleanSpacesAndUpper(L.PRECITY));
		SELF.ADDR_STATE_2		  := IF(TRIM(clnAddrAddr2[115..116])<>'',TRIM(clnAddrAddr2[115..116]),ut.CleanSpacesAndUpper(L.PRESTATE));
		SELF.ADDR_ZIP5_2		  := IF(TRIM(clnAddrAddr2[117..121])<>'',TRIM(clnAddrAddr2[117..121]),tmpPreZip[1..5]);
		SELF.ADDR_ZIP4_2		  := clnAddrAddr2[122..125];

		SELF.ADDR_CNTY_2			:= IF(SELF.ADDR_MAIL_IND != ' ',StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT)),' ');
		SELF.ADDR_CNTRY_2			:= IF(ClnPreAddr1 != ' ' AND REGEXFIND(ForeignPattern,ClnAddr2),'CANADA',
																IF(ClnPreAddr1 != ' ' AND REGEXFIND(ForeignPattern,ClnAddr3),'CANADA',' '));
		
		//If ATTN: is in address field, move to contact name
		TempContact						:= IF(REGEXFIND('(ATTN:|ATTN)(.*)',TempName2),TempName2,
																IF(REGEXFIND('(ATTN:|ATTN)(.*)',TempName2_2),TempName2_2,
																	IF(REGEXFIND('(ATTN:|ATTN)(.*)',TempName1),TempName1,
																		IF(REGEXFIND('(ATTN:|ATTN)(.*)',TempName1_2),TempName1_2,' '))));
		clnTempContact				:= REGEXREPLACE('ATTN:|ATTN',TempContact,'');
		 
		ParseContact					:= Address.NameCleaner.CleanPerson73(clnTempContact);
		SELF.NAME_CONTACT_FIRST	:= IF(ParseContact != ' ',ParseContact[6..25],' ');
		SELF.NAME_CONTACT_MID		:= IF(ParseContact != ' ',ParseContact[26..45],' ');
		SELF.NAME_CONTACT_LAST	:= IF(ParseContact != ' ',ParseContact[46..65],' ');
		SELF.NAME_CONTACT_SUFX	:= IF(ParseContact != ' ',ParseContact[66..70],' ');
		
		//Expected codes [CO,BR,IN]
		SELF.AFFIL_TYPE_CD		:= IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'N' OR TrimRawLicense_Type IN ['1','01','2','02','4','04'],'IN',
																IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'I' AND TrimRawLicense_Type IN ['3','03'],'IN',
																 IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'Y' AND TrimRawLicense_Type NOT IN ['6506','6507'],'CO',
																	IF(TrimRawLicense_Type IN ['5','05'],'CO',
																		IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'Y' AND TrimRawLicense_Type IN ['6506','6507'],'BR',
																			IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) != 'I' AND TrimRawLicense_Type IN ['3','03'],'BR',' '))))));
		
		// fields used to create mltrec_key are :
		// license number
		// office license number
		// license type
		// source update
		// raw name including DBA's
		// raw address
		SELF.MLTRECKEY	:= 0;

		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// name
		// address
		// dba	
		SELF.CMC_SLPK     := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																+TRIM(SELF.std_license_type,LEFT,RIGHT)
																+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																+TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR2_1,LEFT,RIGHT)
																+TRIM(L.CITY,LEFT,RIGHT)
																+TRIM(L.STATE,LEFT,RIGHT)
																+TRIM(L.ZIP,LEFT,RIGHT));	
																
		//a patch for now

		SELF := [];
	END;

	ds_map := PROJECT(ValidMIFile, transformToCommon(LEFT));

	//Clean up address one final time
	Prof_License_Mari.layouts.base fix_address(ds_map L) := TRANSFORM
		SELF.ADDR_ADDR1_1 := IF(TRIM(L.ADDR_ADDR2_1) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_1) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_1),L.ADDR_ADDR2_1,L.ADDR_ADDR1_1);
		SELF.ADDR_ADDR2_1	:= IF(TRIM(L.ADDR_ADDR2_1) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_1) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_1),L.ADDR_ADDR1_1,L.ADDR_ADDR2_1);
		SELF.ADDR_ADDR1_2 := IF(TRIM(L.ADDR_ADDR2_2) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_2) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_2),L.ADDR_ADDR2_2,L.ADDR_ADDR1_2);
		SELF.ADDR_ADDR2_2	:= IF(TRIM(L.ADDR_ADDR2_2) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_2) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_2),L.ADDR_ADDR1_2,L.ADDR_ADDR2_2);
		SELF := L;
	END;

	ds_ClnAddress	:= PROJECT(ds_map,fix_address(LEFT)); 

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_ClnAddress L, ds_Cmvtranslation R) := TRANSFORM
		//a patch for now
		SELF.STD_PROF_CD := IF(TRIM(L.STD_LICENSE_TYPE,LEFT,RIGHT) IN ['1205','1206'],'APR',R.DM_VALUE1);
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_ClnAddress, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																			
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_ClnAddress(affil_type_cd='CO');

	//Perform affiliation lookup for affil_type_cd = 'IN'
	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_status_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := IF(TRIM(L.affil_type_cd,LEFT,RIGHT) = 'IN',R.cmc_slpk,L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_status_trans, company_only_lookup,
												TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)
												AND LEFT.affil_type_cd = 'IN',
												assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	//Perform affiliation lookup for affil_type_cd = 'BR'
	Prof_License_Mari.layouts.base assign_pcmcslpk2(ds_map_affil L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := IF(TRIM(L.affil_type_cd,LEFT,RIGHT) = 'BR',R.cmc_slpk,L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil2 := JOIN(ds_map_affil, company_only_lookup,
												TRIM(LEFT.NAME_ORG[1..50],LEFT,RIGHT)	= TRIM(RIGHT.NAME_ORG[1..50],LEFT,RIGHT)
												AND LEFT.affil_type_cd = 'BR',
												assign_pcmcslpk2(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																									

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil2 L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil2, xTransPROVNOTE(LEFT));


	d_final := OUTPUT(OutRecs(TRIM(name_org_orig)<>','),, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs(TRIM(name_org_orig)<>','));
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'broker','using', 'used'),
													 Prof_License_Mari.func_move_file.MyMoveFile(code, 'real_estate','using', 'used'),
													 Prof_License_Mari.func_move_file.MyMoveFile(code, 'misclic','using', 'used')
													 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmvtranslation, oBroker, oRE, oMisc, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;

