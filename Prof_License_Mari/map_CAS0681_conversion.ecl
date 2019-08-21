//************************************************************************************************************* */	
//  The purpose of this development is take CA Real Estate License raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Ut;

EXPORT map_CAS0681_conversion(STRING pVersion) := FUNCTION

	code 								:= 'CAS0681';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//The valid license type are Salesperson, Broker, Corporation, and Officer
	//MD_Lic_types := ['S','B','O'];
	MD_Lic_types 				:= ['SALESPERSON', 'BROKER', 'OFFICER'];

	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
  O_Cmvtranslation    := output(ds_Cmvtranslation);
	
	//CA input file
	ds_CA_RealEstate		:= Prof_License_Mari.file_CAS0681.real_estate;

	//Remove bad records before processing
	ValidCAFile					:= ds_CA_RealEstate(lastname_primary != '' AND 
																NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUppercase(TRIM(lastname_primary,LEFT,RIGHT))));
	oFile								:= OUTPUT(ValidCAFile);
	
	//Pattern for DBA
	DBApattern					:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA |^AKA |T/A )(.*)';
	Sufx_Pattern        := '(,SR\\.|,SR| SR\\.| SR|, JR|, JR\\.| JR\\.| JR| III| II| IV| VI | VII)';	
	
	//Not a Foreign city pattern
	NotForeign					:= ['USA','NO CITY'];
	
	//CA Real Estate layout to Common
	Prof_License_Mari.layout_base_in	TransformToCommon(Prof_License_Mari.layout_CAS0681.common L) := TRANSFORM
		
			SELF.PRIMARY_KEY		:= 0;
			SELF.CREATE_DTE			:= thorlib.wuid()[2..9];	//yyyymmdd
			SELF.LAST_UPD_DTE		:= pVersion;							//it was set to process_date before
			SELF.STAMP_DTE			:= pVersion; 					 		//yyyymmdd
			SELF.STD_SOURCE_UPD	:= src_cd;
			SELF.STD_SOURCE_DESC:= ' ';
			SELF.STD_PROF_CD		:= ' ';
			SELF.STD_PROF_DESC	:= ' ';
 			//Determine TYPE_CD based on lic_type which can be Salesperson, Officer, Broker, or Corporation
   		tmpLicenseType 			:= ut.CleanSpacesAndUpper(L.license_type);
  		SELF.TYPE_CD				:= IF(tmpLicenseType = 'CORPORATION', 'GR',
																IF(tmpLicenseType IN MD_Lic_types,'MD',' '));
																
			SELF.DATE_FIRST_SEEN:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
			SELF.PROCESS_DATE		:= thorlib.wuid()[2..9];
	
			SELF.LICENSE_STATE	:= src_st;
			SELF.RAW_LICENSE_TYPE	:= tmpLicenseType;
			SELF.STD_LICENSE_TYPE	:= tmpLicenseType[1];

			TrimLastName				:= ut.CleanSpacesAndUpper(L.lastname_primary);
			TrimFMName			   	:= ut.CleanSpacesAndUpper(L.firstname_secondary);
			TrimSuffixName			:= ut.CleanSpacesAndUpper(L.name_suffix);
			TrimEmplLastName		:= ut.CleanSpacesAndUpper(L.empl_lastname_primary);
			TrimEmplFirstName		:= ut.CleanSpacesAndUpper(L.empl_firstname_secondary);
			TrimEmplSuffixName	:= ut.CleanSpacesAndUpper(L.empl_name_suffix);
			TrimOfficerLastName	:= ut.CleanSpacesAndUpper(L.officer_lastname);
			TrimOfficerFirstName:= ut.CleanSpacesAndUpper(L.officer_firstname);
			TrimOfficerSuffixName:= ut.CleanSpacesAndUpper(L.officer_suffix);

     	//Name Parsing
			TrimFirstName       := IF(REGEXFIND('([A-Za-z\']+) (.*)',TrimFMName),REGEXFIND('([A-Za-z\']+) (.*)', TrimFMName,1),TrimFMName);
			TrimMidName         := IF(REGEXFIND('([A-Za-z\']+) (.*)',TrimFMName),REGEXFIND('([A-Za-z\']+) (.*)', TrimFMName,2),'');
	    // Corporation Name
			std_org_name				:= IF(SELF.TYPE_CD='GR',TRIM(TrimLastName+' '+TrimFirstName),'');
			// Individual Name
			tmpFullName         := IF(SELF.TYPE_CD='MD',
			                          TRIM(TrimFirstName + ' ' + TrimMidName + ' ' + TrimLastName,LEFT, RIGHT),
																'');
			TmpLastName 			:= IF(REGEXFIND(Sufx_Pattern,TrimLastName),REGEXREPLACE(Sufx_Pattern,TrimLastName,''),TrimLastName);
			TmpFirstName  		:= IF(REGEXFIND(Sufx_Pattern,TrimFirstName),REGEXREPLACE(Sufx_Pattern,TrimFirstName,''),TrimFirstName);
			TmpMidName  			:= IF(REGEXFIND(Sufx_Pattern,TrimMidName),REGEXREPLACE(Sufx_Pattern,TrimMidName,''),TrimMidName);
		
			TmpSuffix         := MAP(REGEXFIND(Sufx_Pattern,TrimLastName)=>TRIM(REGEXFIND(Sufx_Pattern,TrimLastName,0),LEFT,RIGHT),
			                         REGEXFIND(Sufx_Pattern,TrimMidName)=>TRIM(REGEXFIND(Sufx_Pattern,TrimMidName,0),LEFT,RIGHT),
			                         REGEXFIND(Sufx_Pattern,TrimFirstName)=>TRIM(REGEXFIND(Sufx_Pattern,TrimFirstName,0),LEFT,RIGHT),
															 TrimSuffixName);			
			
			// Identify NICKNAME 
			tempFNick						:= Prof_License_Mari.fGetNickname(TmpFirstName,'nick');
			tempLNick						:= Prof_License_Mari.fGetNickname(TmpLastName,'nick');
			tempMNick						:= Prof_License_Mari.fGetNickname(TmpMidName,'nick');
			
			removeFNick					:= Prof_License_Mari.fGetNickname(TmpFirstName,'strip_nick');
			removeLNick					:= Prof_License_Mari.fGetNickname(TmpLastName,'strip_nick');
			removeMNick					:= Prof_License_Mari.fGetNickname(TmpMidName,'strip_nick');

			stripNickFName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));
			stripNickLName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
			stripNickMName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick));
			
			GoodFirstName       :=  IF(TmpFirstNAME != '' AND tempFNick != '',stripNickFName,TmpFirstName);
			GoodMidName         :=  IF(TmpMidNAME   != '' AND tempMNick != '',stripNickMName,TmpMidName);
			GoodLastName        :=  IF(TmpLastNAME  != '' AND tempLNick != '',stripNickLName,TmpLastName);
	
			SELF.NAME_FIRST 		:= IF(SELF.TYPE_CD = 'MD',GoodFirstName,'');
			SELF.NAME_MID		  	:= IF(SELF.TYPE_CD = 'MD',GoodMidName,'');
			SELF.NAME_LAST			:= IF(SELF.TYPE_CD = 'MD',GoodLastName,'');
			SELF.NAME_SUFX			:= IF(SELF.TYPE_CD = 'MD',TmpSuffix,'');	
			SELF.NAME_NICK			:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																 tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																 '');
	    //Clean Corporation Name		
			tmpNameOrg					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('(^DBA )',std_org_name,'')); //business name with standard corp abbr.
			getCorpOnly			  	:= IF(REGEXFIND(DBApattern, tmpNameOrg), Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
														 ,tmpNameOrg);		 //get names without DBA names
			tmpNameOrgSufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);


			SELF.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly);
			SELF.NAME_ORG				:= IF(SELF.TYPE_CD='GR',
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')),
															  StringLib.StringCleanSpaces(SELF.NAME_LAST+' ' + SELF.NAME_FIRST));  //Without punct. and Sufx removed
			SELF.NAME_ORG_SUFX 	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
			SELF.NAME_FORMAT		:= IF(SELF.TYPE_CD='GR','F', 'L');
			
	    //Address Parsing
 			tmpTrimAddr_1				:= ut.CleanSpacesAndUpper(L.address_1);
			tmpTrimAddr_2				:= ut.CleanSpacesAndUpper(L.address_2);

			//Clean up the address fields
			trimAddr_1					:= MAP(StringLib.StringFind(tmpTrimAddr_1,'C/0',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/0','C/O'),
																 StringLib.StringFind(tmpTrimAddr_1,'C/O CENTURY 21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O CENTURY 21','C/O CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/0 CENTURY 21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/0 CENTURY 21','C/O CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C-21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C-21','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/0 C-21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/0 C-21','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C21 ',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C21 ','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/21 ',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/21 ','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'CENTURY21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'CENTURY21','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/O C 21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O C 21','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/0 C 21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/0 C 21','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_1,'XXX',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'XXX',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'P 0',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'P 0','P O'),	
																 StringLib.StringFind(tmpTrimAddr_1,'NOT LISTED',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'NOT LISTED',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'NOADDRESS',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'NOADDRESS',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/O GENERAL DELIVERY',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O GENERAL DELIVERY',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'GENERAL DELIVERY',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'GENERAL DELIVERY',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/9',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/9','C/O'),	
																 StringLib.StringFind(tmpTrimAddr_1,'BL VD',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'BL VD','BLVD'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/O17215',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O17215','C/O 17215'),	
																 StringLib.StringFind(tmpTrimAddr_1,'B O BOX',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'B O BOX','P O BOX'),	
																 StringLib.StringFind(tmpTrimAddr_1,'NO BUSINESS ADDRESS',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'NO BUSINESS ADDRESS',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'N0 BUSINESS ADDRESS',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'N0 BUSINESS ADDRESS',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'9OO',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'9OO','900'),	
																 StringLib.StringFind(tmpTrimAddr_1,'THE DONATELLO HOTEL /',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'THE DONATELLO HOTEL /',''),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/O TARBELL1403',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O TARBELL1403','C/O TARBELL 1403'),	
																 StringLib.StringFind(tmpTrimAddr_1,'C/O GRAND TERRACE APTS ',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O GRAND TERRACE APTS ',''),	
                                 StringLib.StringFind(tmpTrimAddr_1,'1032 CRI INC COMMUNITY REALTY & INVESTM',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'1032 CRI INC COMMUNITY REALTY & INVESTM',''),																	   
																 StringLib.StringFind(tmpTrimAddr_1,'C/O NORTHMARQ CAPITAL ',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_1,'C/O NORTHMARQ CAPITAL ',''),	
															   StringLib.StringFind(tmpTrimAddr_1,'@GMAIL',1) > 0
																		=> '',	
																 tmpTrimAddr_1);	
			trimAddr_2			  := MAP(StringLib.StringFind(tmpTrimAddr_2,'CENTURY 21',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_2,'CENTURY 21','CENTURY TWNETYONE'),	
																 StringLib.StringFind(tmpTrimAddr_2,'/ HUMAN RESOURCES',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_2,'/ HUMAN RESOURCES',''),	
																 StringLib.StringFind(tmpTrimAddr_2,'P 0 BOX',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_2,'P 0 BOX','P O BOX'),	
																 StringLib.StringFind(tmpTrimAddr_2,'XXXXXXX',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_2,'XXXXXXX',''),	
																 StringLib.StringFind(tmpTrimAddr_2,'GENERAL DELIVERY',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_2,'GENERAL DELIVERY',''),	
																 StringLib.StringFind(tmpTrimAddr_2,'NO BUSINESS AFFILIATION',1) > 0
																		=> StringLib.StringFindReplace(tmpTrimAddr_2,'NO BUSINESS AFFILIATION',''),	
																 StringLib.StringFind(tmpTrimAddr_2,'ATTN: ',1) > 0
																		=> '',	
																 tmpTrimAddr_2);	

			tmpGetDBAName				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddr_1); //Get contact name from address
			tmpGetCorpName			:= Prof_License_Mari.mod_clean_name_addr.GetCorpName(trimAddr_1); 
			tmpGetContactName		:= Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpGetDBAName);
			GetContactNoAddr1		:= MAP(REGEXFIND('(ONE|THREE) .* (PLAZA|CENTER|PLACE|MALL|DRIVE|CIRCLE|BOULEVARD|TOWER)',trimAddr_1)
																	 => '',																 
																 REGEXFIND('NORTHMARQ CAPITAL',trimAddr_1)
																	 => 'NORTHMARQ CAPITAL',
																 REGEXFIND('GLENWOOD CIRCLE',trimAddr_1)
																	 => '',
																 NOT REGEXFIND('[0-9]+',trimAddr_1) AND TRIM(tmpGetDBAName,LEFT,RIGHT)<>''  AND TRIM(tmpGetCorpName,LEFT,RIGHT)<>''
																   => TRIM(tmpGetCorpName,LEFT,RIGHT) + ' DBA ' + TRIM(tmpGetDBAName,LEFT,RIGHT),
																 NOT REGEXFIND('[0-9]+',trimAddr_1) AND TRIM(tmpGetDBAName,LEFT,RIGHT)<>'' 
																   => TRIM(tmpGetDBAName,LEFT,RIGHT),
																 NOT REGEXFIND('[0-9]+',trimAddr_1) AND TRIM(tmpGetContactName,LEFT,RIGHT)<>'' 
																   => TRIM(tmpGetContactName,LEFT,RIGHT),
																 NOT REGEXFIND('[0-9]+',trimAddr_1) AND TRIM(tmpGetCorpName,LEFT,RIGHT)<>'' 
																   => TRIM(tmpGetCorpName,LEFT,RIGHT),
																 NOT REGEXFIND('[0-9]+',trimAddr_1) AND
																 Prof_License_Mari.mod_clean_name_addr.IsCompanyName(trimAddr_1)<>''
																   => Prof_License_Mari.mod_clean_name_addr.IsCompanyName(trimAddr_1),
																 NOT REGEXFIND('[0-9]+',trimAddr_1) AND
																 NOT Prof_License_Mari.func_is_address(trimAddr_1)
																   => TRIM(trimAddr_1,LEFT,RIGHT),
																 REGEXFIND('M4 MANAGEMENT INC',trimAddr_1)
																   => 'M4 MANAGEMENT INC',
																 REGEXFIND('COLDWE581 HOLBROOK LL BANKER STAR REALTY',trimAddr_1)
																   => 'COLDWE581 HOLBROOK LL BANKER STAR REALTY',
																 '');	 
			GetContactNoAddr		:= StringLib.StringFindReplace(GetContactNoAddr1,'CENTURY TWNETYONE','CENTURY 21');
			
			//blank out trimAddr_1 if it is a company name with the following pattern. The address cleaning tool
			//has a problem cleaning it (because the company name contains digit?)
			clnAddr_1						:= IF(REGEXFIND('^.*[0-9]+.* INC$',trimAddr_1),'',trimAddr_1);
			temp_preaddr1_1 		:= StringLib.StringCleanSpaces(clnAddr_1+' '+trimAddr_2); //Concat addr1 and addr2 for cleaning
			temp_preaddr1				:= StringLib.StringFindReplace(
			                        IF(GetContactNoAddr<>'',
			                           StringLib.StringFindReplace(temp_preaddr1_1,GetContactNoAddr,''),
															   temp_preaddr1_1),
															'C/O',
															'');
			temp_preaddr2 			:= StringLib.StringCleanSpaces(L.city+' '+L.state +' '+L.zip_code); //Concat city, state, zipe for cleaning
			clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
			tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
			tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
			AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
			clnADDR_ADDR1_1			:= IF(tmpADDR_ADDR1_1='208 COLUMBINE RTE 1',
																'208 COLUMBINE RTE 1',
																IF(AddrWithContact != '' AND tmpADDR_ADDR2_1 != '',
																	 StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																	 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1)));
			clnADDR_ADDR2_1			:= IF(AddrWithContact != '',
																'',
																StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
			
		 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
			SELF.ADDR_ADDR1_1		:= IF(clnADDR_ADDR1_1 <> '',clnADDR_ADDR1_1,clnADDR_ADDR2_1);	
			SELF.ADDR_ADDR2_1		:= IF(clnADDR_ADDR1_1 <> '',clnADDR_ADDR2_1,''); 
			SELF.ADDR_CITY_1		:= IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TRIM(L.city));
			SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TRIM(L.state));
			SELF.ADDR_ZIP5_1		:= IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(L.zip_code[1..5]));
			SELF.ADDR_ZIP4_1		:= clnAddrAddr1[122..125];
			SELF.ADDR_CNTY_1		:= ut.CleanSpacesAndUpper(L.county_name);
			//County code (L.county_code) is duplicate information, and intentionally not stored in MARI base file.
			SELF.OOC_IND_1			:= IF(LENGTH(TRIM(L.foreign_nation+L.foreign_postal_info))>0 
																AND StringLib.StringToUpperCase(TRIM(L.foreign_nation)) NOT IN NotForeign,
																1,
																0); // 1=TRUE, 0=FALSE
			SELF.ADDR_CNTRY_1		:= IF(SELF.OOC_IND_1 = 1, StringLib.StringToUpperCase(TRIM(L.foreign_nation,LEFT,RIGHT)),' ');
			//store the email address(s) in email field
			SELF.EMAIL					:= IF(StringLib.StringFind(tmpTrimAddr_1,'@GMAIL',1) > 0,tmpTrimAddr_1,'');
			
			//Get Office Name
			tempOfficeName			:= MAP(tmpLicenseType='OFFICER' AND TRIM(TrimOfficerLastName+TrimOfficerFirstName)<>''
			                             => TrimOfficerLastName  + ' ' + TrimOfficerFirstName,
																 tmpLicenseType='SALESPERSON' AND TRIM(TrimEmplLastName+TrimEmplFirstName)<>''
																   => TrimEmplLastName + ' ' + TrimEmplFirstName,
																 GetContactNoAddr<>'' AND Prof_License_Mari.func_is_company(GetContactNoAddr)
																   => GetContactNoAddr,
																 '');
			//NAME_OFFICE is the business name. The following code is replaced to populate business name
			clnOfficeName				:= StringLib.StringCleanSpaces(
			                         Prof_License_Mari.mod_clean_name_addr.strippunctName(tempOfficeName)
														 ) ;
			SELF.NAME_OFFICE		:= MAP(Prof_License_Mari.mod_clean_name_addr.GetCorpName(clnOfficeName)<>''
			                             => Prof_License_Mari.mod_clean_name_addr.GetCorpName(clnOfficeName),
																 TRIM(clnOfficeName,LEFT,RIGHT)[1..4]='DBA '
																   => '',  //This office name has only DBA name
																clnOfficeName);
			comp_names 					:= '(REMAX|USA 4%|REAL EST|ASSOC|AGCY| CO$)';												 
			SELF.OFFICE_PARSE		:= IF(SELF.NAME_OFFICE != ' ',
																IF(prof_license_mari.func_is_company(SELF.NAME_OFFICE) OR
																   REGEXFIND(comp_names,TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)),
																   'GR',
																	 'MD'),
																' ');

			//get names with DBA prefix
			temp_dba_name_org		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOrg);
			temp_dba_name_off		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempOfficeName);
			temp_dba_name				:= MAP(temp_dba_name_org<>'' => temp_dba_name_org,
																 temp_dba_name_off<>'' => temp_dba_name_off,
																 '');
			clnDBA_name					:= REGEXREPLACE(DBApattern,StringLib.StringToUpperCase(temp_dba_name),'');
			tmpNameDBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
			tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(clnDBA_name);
			SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(clnDBA_name); //split corporation prefix from name
			SELF.NAME_DBA				:= REGEXREPLACE(' COMPANY',clnDBA_name,' CO');
			SELF.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
			SELF.DBA_FLAG				:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
			SELF.NAME_DBA_ORIG	:= IF(TRIM(temp_dba_name,LEFT,RIGHT) != ' ',StringLib.StringToUpperCase(TRIM(temp_dba_name,LEFT,RIGHT)),' ');
			SELF.NAME_MARI_DBA	:= IF(SELF.type_cd='GR' AND SELF.NAME_DBA != ' ',SELF.NAME_DBA_ORIG,' ');

			SELF.LICENSE_NBR		:= StringLib.StringToUpperCase(TRIM(L.license_number,LEFT,RIGHT));
			SELF.OFF_LICENSE_NBR:= IF(TRIM(L.rel_lic_number) != ' '
																	,StringLib.StringToUpperCase(TRIM(L.rel_lic_number,LEFT,RIGHT)),' ');
			SELF.OFF_LICENSE_NBR_TYPE:=ut.CleanSpacesAndUpper(L.rel_license_type);
			//If the office license type is broker, store the license number in BRKR_LICENSE_NBR
			SELF.BRKR_LICENSE_NBR:= IF(TRIM(SELF.STD_LICENSE_TYPE)='S' AND TRIM(SELF.OFF_LICENSE_NBR_TYPE)='BROKER',
																 TRIM(SELF.OFF_LICENSE_NBR),
																 '');
	
			//License status can be Licensed, Licensed NBA.
			//Concat license_status + restricted_flag + misc_indicator = License_status code
			SELF.RAW_LICENSE_STATUS	:= TRIM(L.license_status,LEFT,RIGHT) + TRIM(L.restricted_flag,LEFT,RIGHT) + TRIM(L.misc_indicator,LEFT,RIGHT);
			TmpLicStatus				:= IF(TRIM(L.license_status,LEFT,RIGHT) <>'',
																StringLib.StringToUpperCase(TRIM(L.license_status,LEFT,RIGHT)[1]),
																'');
			SELF.STD_LICENSE_STATUS	:= TmpLicStatus + TRIM(L.restricted_flag,LEFT,RIGHT) + TRIM(L.misc_indicator,LEFT,RIGHT);
			
			SELF.CURR_ISSUE_DTE	:= IF(L.license_effective_date = ' ','17530101',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.license_effective_date));
			SELF.ORIG_ISSUE_DTE	:= '17530101';
			SELF.EXPIRE_DTE			:= IF(L.license_expiration_date = ' ','17530101',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.license_expiration_date));

			//Concat address1 and address2 for 'IF address populated' statements
			full_address				:= TRIM(L.address_1,LEFT,RIGHT)+TRIM(L.address_2,LEFT,RIGHT);
			SELF.ADDR_BUS_IND		:= IF(TRIM(full_address) != ' ','B',' ');
			SELF.NAME_ORG_ORIG	:= IF(SELF.TYPE_CD = 'GR',StringLib.StringCleanSpaces(std_org_name),
			                          StringLib.StringCleanSpaces(TRIM(TrimLastName + ' ' + TrimSuffixName + ' ' + TrimFMName,LEFT, RIGHT)));
			SELF.NAME_MARI_ORG	:= IF(SELF.type_cd='GR',getCorpOnly,
																IF(SELF.NAME_OFFICE != ' ',SELF.NAME_OFFICE,' '));

			//For CORPORATION, store the officer name in contact name
			//The source file has an error that TrimOfficerLastName contains first and middle name.
			//We will code accordingly and correct this when they correct their error
			tmpContactName			:= IF(tmpLicenseType='CORPORATION' AND TRIM(SELF.OFF_LICENSE_NBR_TYPE)='OFFICER',
																TRIM(TrimOfficerLastName + ' ' + TrimOfficerFirstName + ' ' + TrimOfficerSuffixName),
																'');
			clnContactName			:= IF(tmpContactName<>'',
																Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tmpContactName),
																'');
			SELF.NAME_CONTACT_FIRST:= IF(TRIM(clnContactName)<>'',
																TRIM(clnContactName[6..25],LEFT,RIGHT),
																'');
			SELF.NAME_CONTACT_MID:= IF(TRIM(clnContactName)<>'',
																TRIM(clnContactName[26..45],LEFT,RIGHT),
																'');
			SELF.NAME_CONTACT_LAST:= IF(TRIM(clnContactName)<>'',
																TRIM(clnContactName[46..65],LEFT,RIGHT),
																'');
			SELF.NAME_CONTACT_SUFX:= IF(TRIM(clnContactName)<>'',
																TRIM(clnContactName[66..70],LEFT,RIGHT),
																'');
																
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD	:= MAP(SELF.type_cd = 'GR' AND  SELF.std_license_type <> ''  => 'CO',
																 SELF.type_cd = 'MD' AND  SELF.std_license_type <> '' => 'IN', ' ');	

			SELF.PROVNOTE_1				:= MAP(L.license_type[1]='C' AND SELF.OFF_LICENSE_NBR <> '' => 'DESIGNATED OFFICER:'+ TRIM(SELF.OFF_LICENSE_NBR),
																	 L.license_type[1]='S' AND SELF.OFF_LICENSE_NBR <> '' => 'EMPLOYING BROKER\'S LICENSE NUMBER:'+ TRIM(SELF.OFF_LICENSE_NBR),
																	 L.license_type[1]='O' AND SELF.OFF_LICENSE_NBR <> '' => 'AFFILIATED LICENSED CORPORATION(S):'+ TRIM(SELF.OFF_LICENSE_NBR),
																	 ' ');

			//store MULTIPLE_LICENSE_IND and ETHICS_AND_AGENCY_IND in PROVNOTE_2
			SELF.PROVNOTE_2 		:= TRIM('MULTIPLE_LICENSE_IND:'+TRIM(L.multiple_license_ind,LEFT,RIGHT) + '|' +
														      'ETHICS_AND_AGENCY_IND:'+TRIM(L.ethics_and_agency_ind,LEFT,RIGHT) +
														      IF(TRIM(GetContactNoAddr,LEFT,RIGHT)<>'' AND
																	   TRIM(GetContactNoAddr,LEFT,RIGHT)<>TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),
														         '|CONTACT INFO FROM ADDR:'+GetContactNoAddr,
														         ''),
																	LEFT,
																	RIGHT
																  );
												 
	/* fields used to create unique key are:
				license number
					license type
					source update
					name
					address
					office name 
	*/
			//Use hash64 instead of hash32 to avoid dup keys
			SELF.CMC_SLPK  			:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
													 +TRIM(L.rel_lic_number,LEFT,RIGHT)
													 +TRIM(L.license_type,LEFT,RIGHT)
													 +TRIM(L.multiple_license_ind,LEFT,RIGHT)
													 +TRIM(SELF.std_source_upd,LEFT,RIGHT)
													 +TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
													 +ut.CleanSpacesAndUpper(full_address)
													 +TRIM(SELF.ADDR_CITY_1)
													 +TRIM(SELF.ADDR_STATE_1)
													 +TRIM(SELF.ADDR_ZIP5_1));										 
				SELF := [];		   		   
	END;

	ds_map := PROJECT(ValidCAFile, TransformToCommon(LEFT));

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map(affil_type_cd='CO');

	// populate std_license_status field via translation on raw_license_status field
	Prof_License_Mari.layout_base_in trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.std_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map_stat_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	//perform lookup to join children to parents and assign cmc_slpk field value of parent to pcmc_slpk field of child  
	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := IF(L.affil_type_cd = 'IN',R.cmc_slpk,L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
															TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)																	
															AND LEFT.affil_type_cd != 'CO',
															assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	d_final := OUTPUT(ds_map_affil, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'real_estate', 'using', 'used');

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmvtranslation, oFile, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	

END;