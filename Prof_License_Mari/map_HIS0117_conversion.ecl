//************************************************************************************************************* */	
//  The purpose of this development is take HI Professional License raw files and convert them to a 
//  common professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */
IMPORT Prof_License_Mari, Address, Ut, Lib_FileServices, lib_strINglib, lib_date, standard;

EXPORT map_HIS0117_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'HIS0117';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move input file from sprayed to using
	move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'legal_sortname', 'sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'license_data', 'sprayed', 'using');
														);


	//HI input files
	ds_HI_license	   := Prof_License_Mari.files_HIS0117.license_data;
	o_ds_HI_license  := OUTPUT(ds_HI_license);
	ds_HI_sortname	 := Prof_License_Mari.files_HIS0117.legal_sortname;
	o_ds_HI_sortname := OUTPUT(ds_HI_sortname);
	
	//If not in list, License_types are blank
	//Remove Condo operator from this list
	GR_Lic_types := ['660MB','660MBB','900RB','900RBO'];
	MD_Lic_types := ['660MS','890CGA','890CRA','890SLA','900RS'];
	BR_Lic_types := ['660MBB', '900RBO']; 
	
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* PACIFIC BANK$|^.* GROUP$|^APPRAISERS$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA | DBA| \\(DBA\\)|%)(.*)';

	//Pattern for bad address
	BadAddrpattern	:= '^(.*)( NOT EMPLOYED |SELF-EMPLOYED |NO ADDRESS )(.*)';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Name parse patterns
	ThreePlusParse	:= '^([A-Za-z ][^ ]+)[ ]([A-Za-z]+[ ][A-Za-z]+[ ][A-Za-z]+)[ ]([A-Za-z]+)(.*)';

	//Layout to add clean name fields for common mapping purposes
	Layout_clean_name := RECORD
			Prof_License_Mari.layout_HIS0117.license;
			STRING20	stdLicType;
			Standard.Name;
			STRING70  cname;
			STRING5  title2;
			STRING20 fname2;
			STRING20 mname2;
			STRING20 lname2;
			STRING5  name_suffix2;
			STRING70  cname2;
	END;

	Layout_clean_name mapClnFields(ds_HI_license l)	:= TRANSFORM
	SELF.stdLicType := TRIM(l.BOARD_CODE,LEFT,RIGHT)+TRIM(l.LIC_TYPE,LEFT,RIGHT);
	SELF	:= l;
	SELF	:= [];
	END;
 
	StdNameLicense	:= PROJECT(ds_HI_license,mapClnFields(LEFT));
	
	//Input file includes all professional licensees. We will process real estate appraisers, brokers, etc
	//Filter by currently processed license types
	FilterLicense	:= StdNameLicense(stdLicType IN GR_Lic_types OR stdLicType IN MD_Lic_types);

	//Layout to join sortname(DBA) file to license file
	layout_license_with_Dba	:= RECORD
		UNSIGNED1 numRows;
		Layout_clean_name;
		STRING80	DBA1	:= ' ';
		STRING60	DBA2	:= ' ';
		STRING50	DBA3	:= ' ';
		STRING50	DBA4	:= ' ';
		STRING50	DBA5	:= ' ';
		STRING60	DBA6	:= ' ';
	END;

	layout_license_with_Dba map_license_dba(Layout_clean_name L):= TRANSFORM
		SELF.numRows	:= 0;
		SELF := L;
	END;

	ds_license_dba	:= PROJECT(FilterLicense, map_license_dba(LEFT));

	srt_License_Dba	:= SORT(ds_license_dba, lic_num, lic_office, board_code, lic_type, sortname);
	srt_sortname		:= SORT(ds_HI_sortname, lic_num, lic_office, board_code, lic_type, org_name);

	//Denormalize the license file to include multiple DBA's linked by lic_num, lic_office, lic_type, board_cd, and org_name
	layout_license_with_Dba DenormDBA(layout_license_with_Dba L, ds_HI_sortname R, INTEGER C) := TRANSFORM
			SELF.NumRows := C;
			SELF.DBA1	:= IF(C=1, R.DBA, L.DBA1);
			SELF.DBA2	:= IF(C=2, R.DBA, L.DBA2);
			SELF.DBA3	:= IF(C=3, R.DBA, L.DBA3);
			SELF.DBA4	:= IF(C=4, R.DBA, L.DBA4);
			SELF.DBA5	:= IF(C=5, R.DBA, L.DBA5);
			SELF.DBA6	:= IF(C=6, R.DBA, L.DBA6);
			SELF	:= L;
	END;

	DeNormedRecs := DENORMALIZE(srt_License_Dba, srt_sortname,
														LEFT.LIC_NUM = RIGHT.LIC_NUM AND
														LEFT.LIC_OFFICE = RIGHT.LIC_OFFICE AND
														LEFT.BOARD_CODE = RIGHT.BOARD_CODE AND
														LEFT.LIC_TYPE = RIGHT.LIC_TYPE AND
														LEFT.SORTNAME = RIGHT.ORG_NAME,
														DenormDBA(LEFT,RIGHT,COUNTER));
														
	//Append multiple DBA's to maribase layout for mltreckey hash	
	maribase_plus_dbas := RECORD,MAXLENGTH(5000)
		Prof_License_Mari.layout_base_in;
		STRING60 DBA;
		STRING60 DBA1;
		STRING60 DBA2;
		STRING60 DBA3;
		STRING60 DBA4;
		STRING60 DBA5;
	END;

	//Remove bad records before processing
	ValidHILicense	:= DeNormedRecs(TRIM(SORTNAME) != ' ' AND LIC_NUM != ' '
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(SORTNAME)));
	
	maribase_plus_dbas	transformToCommon(layout_license_with_Dba L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
	
		//determine if a business is a business its license type
		tmpIsCompany					:= IF(TRIM(L.stdLicType) IN GR_Lic_types, TRUE, FALSE);

		//Clean and parse first name, last name, and middle. They were populated by Mac_Is_Business. However it is too resource consuming,
		//and caused a code generation error in ECL IDE. Replace the macro by following
		//CleanPersonFML parses these 4 names incorrectly (last name is A). We shall overwrite them.
		tmpParsedName := IF(L.SORTNAME<>'' AND NOT Prof_License_Mari.func_is_company(L.SORTNAME) AND NOT REGEXFIND('(^SVC.* LP$)',TRIM(L.SORTNAME),NOCASE),
										 MAP(L.SORTNAME='DONALD A SIX'				 =>'MR   DONALD              A                   SIX                      99',
												 L.SORTNAME='KIMBERLEY A O\'REILLY'=>'MS   KIMBERLEY           A                   O\'REILLY                 99',
												 L.SORTNAME='SHANTI A OM'          =>'     SHANTI              A                   OM                       99',
												 L.SORTNAME='PATRICIA A WALKABOUT' =>'MS   PATRICIA            A                   WALKABOUT                99',
												 L.SORTNAME='ANTHONY K KOR'        =>'MR   ANTHONY             K                   KOR                      99',
												 L.SORTNAME='AUDREY P HON'         =>'MS   AUDREY              P                   HON                      99',
												 L.SORTNAME='ALEX T T DO'          =>'     ALEX                T T                 DO                       99',
												 L.SORTNAME='ALAN J MA'            =>'MR   ALAN                J                   MA                       99',
												 L.SORTNAME='BARBARA ANNE S ROSA'  =>'MS   BARBARA             ANNE S              ROSA                     99',
												 L.SORTNAME='BONNIE L TRAYMORE'    =>'MS   BONNIE              L                   TRAYMORE                 99',
												 L.SORTNAME='CHANSONETTE F KOA'    =>'MR   CHANSONETTE         F                   KOA                      99',
												 L.SORTNAME='CHAUNCEY W PA'        =>'MR   CHAUNCEY            W                   PA                       99',
												 L.SORTNAME='CHAUNCEY K PA'        =>'MR   CHAUNCEY            K                   PA                       99',
												 L.SORTNAME='DAVID M ON'           =>'MR   DAVID               M                   ON                       99',
												 L.SORTNAME='GABRIEL P SUR'        =>'MR   GABRIEL             P                   SUR                      99',
												 L.SORTNAME='GERARDO M TECH'       =>'MR   GERARDO             M                   TECH                     99',
												 L.SORTNAME='JASON M FABRIC'       =>'MR   JASON               M                   FABRIC                   99',
												 L.SORTNAME='JASON H BACH'         =>'MR   JASON               H                   BACH                     99',
												 L.SORTNAME='JO ANN J OCHI'        =>'MS   JO ANN              J                   OCHI                     99',
												 L.SORTNAME='JULIE L DO'           =>'MS   JULIE               L                   DO                       99',
												 L.SORTNAME='KATHY J CARD'         =>'MS   KATHY               J                   CARD                     99',
												 L.SORTNAME='LAURIE ANN L TOM'     =>'MS   LAURIE              ANN L               TOM                      99',
												 L.SORTNAME='MICHAEL D LA'         =>'MR   MICHAEL             D                   LA                       99',
												 L.SORTNAME='MADELYN C SALES'      =>'MS   MADELYN             C                   SALES                    99',
												 L.SORTNAME='REBECCA L WRITER'     =>'MS   REBECCA             L                   WRITER                   99',
												 L.SORTNAME='RITA M AMONG'         =>'MS   RITA                M                   AMONG                    99',
												 L.SORTNAME='RUBY MARY H L PATROCINIO'
												                                   =>'MS   RUBY                MARY H L            PATROCINIO               99',
												 L.SORTNAME='SEAN F O\'REILLY'     =>'MS   SEAN                F                   O\'REILLY                 99',
												 L.SORTNAME='STEVE H DO'           =>'MR   STEVE               H                   DO                       99',
												 L.SORTNAME='SHAWN T GIRLINGTON'   =>'MR   SHAWN               T                   GIRLINGTON               99',
												 L.SORTNAME='SUSAN M DES JARLAIS'  =>'MS   SUSAN               M                   DES JARLAIS              99',
												 L.SORTNAME='SEAN K DO'            =>'     SEAN                K                   DO                       99',
												 L.SORTNAME='SHERI S Y MURASAKI'   =>'MS   SHERI               S Y                 MURASAKI                 99',
												 L.SORTNAME='STEVEN P CUP CHOY'    =>'MR   STEVEN              P CUP               CHOY                     99',
												 L.SORTNAME='SHARALYN R FIRST'     =>'     SHARALYN            R                   FIRST                    99',
												 L.SORTNAME='SHANNON P AMONG'      =>'     SHANNON             P                   AMONG                    99',
												 L.SORTNAME='TUAN NHA N LA'        =>'     TUAN NHA            N                   LA                       99',
												 L.SORTNAME='VINCENT D PACIFIC'    =>'MR   VINCENT             D                   PACIFIC                  99',
												 L.SORTNAME='WALTER T RECORDS III' =>'MR   WALTER              T                   RECORDS             III  99',
												 L.SORTNAME='BYEONGNAM AN' 				 =>'     BYEONGNAM                               AN                       99',
												 L.SORTNAME='LARRY FUDGE' 				 =>'MR   LARRY                                   FUDGE                    99',
												 L.SORTNAME='ESSEX M PORTER' 			 =>'MR   ESSEX               M                   PORTER                   99',
												 L.SORTNAME='DE\'AN F FLUD' 			 =>'MR   DEAN                F                   FLUD                     99',
												 L.SORTNAME='GEN NISHIMURA' 			 =>'MR   GEN                                     NISHIMURA                99',
												 L.SORTNAME='GEN HORIE' 			 			=>'MR   GEN                                    HORIE                    99',
 StringLib.StringToUpperCase(Address.CleanPersonFML73(L.SORTNAME))),
										 '');		 

ParsedName := IF(LENGTH(TRIM(tmpParsedName[46..65])) < 2, Prof_License_Mari.mod_clean_name_addr.cleanFMLName(L.SORTNAME),tmpParsedName);

   	SELF.NAME_FIRST				:= IF(ParsedName<>' ' AND NOT tmpIsCompany,TRIM(ParsedName[6..25],LEFT,RIGHT),'');
   	SELF.NAME_MID					:= IF(ParsedName<>' ' AND NOT tmpIsCompany,TRIM(ParsedName[26..45],LEFT,RIGHT),'');
   	SELF.NAME_LAST				:= IF(ParsedName<>' ' AND NOT tmpIsCompany,TRIM(ParsedName[46..65],LEFT,RIGHT),'');
   	SELF.NAME_SUFX				:= IF(ParsedName<>' ' AND NOT tmpIsCompany,TRIM(ParsedName[66..70],LEFT,RIGHT),'');

 		//Clean and parse company 
   	std_org_name					:= IF(ParsedName='', ut.CleanSpacesAndUpper(L.SORTNAME),'');
		std_org_name_suffix		:= TRIM(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(std_org_name));													 
   	tmpNameOrg 						:= IF(Prof_License_Mari.mod_clean_name_addr.GetCorpName(std_org_name_suffix)<>'',
																Prof_License_Mari.mod_clean_name_addr.GetCorpName(std_org_name_suffix),
		                            std_org_name_suffix); //business name with standard corp abbr.
   	tmpNameOrgSufx				:= IF(TRIM(tmpNameOrg) != '',Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg),'');
		tmpCName							:= IF(tmpIsCompany,std_org_name,'');
		
   	clnOrgName						:= IF(tmpIsCompany AND NOT REGEXFIND(IPpattern,tmpNameOrg),
   															Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
   															IF(tmpIsCompany AND REGEXFIND(IPpattern,tmpNameOrg),
   																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),' '));
  	clnParseName					:= IF(NOT tmpIsCompany AND TRIM(SELF.NAME_FIRST) != '',
																StringLib.StringCleanSpaces(TRIM(SELF.NAME_LAST,LEFT,RIGHT)+' '+TRIM(SELF.NAME_FIRST,LEFT,RIGHT)),
																 IF(NOT tmpIsCompany AND TRIM(SELF.NAME_FIRST) = '' AND TRIM(SELF.NAME_LAST) != '',
																		StringLib.StringCleanSpaces(TRIM(SELF.NAME_LAST,LEFT,RIGHT)+' '+TRIM(SELF.NAME_FIRST,LEFT,RIGHT)),
																			''));

   		ISOddParse					:= IF(NOT tmpIsCompany AND tmpCName != ' ' AND REGEXFIND(ThreePlusParse,tmpNameOrg),tmpNameOrg,' ');

   		ForceNameParse			:= IF(NOT tmpIsCompany AND clnParseName = ' ' AND ISOddParse = ' ', 
																Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tmpNameOrg),
   															'');			
   		SELF.NAME_ORG_PREFX	:= IF(TRIM(tmpNameOrg)!='',Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg),' ');
   		SELF.NAME_ORG				:= MAP(clnOrgName!='' => clnOrgName,
   															 clnParseName!='' => clnParseName,
   															 ForceNameParse!='' => StringLib.StringCleanSpaces(ForceNameParse[46..65]+' '+ForceNameParse[6..25]),
																 tmpIsCompany AND tmpNameOrg='' AND ParsedName<>'' => TRIM(ParsedName[46..65],LEFT,RIGHT)+ ' ' + TRIM(ParsedName[6..25],LEFT,RIGHT),
																 tmpNameOrg);  //Without punct. and Sufx removed
   		SELF.NAME_ORG_SUFX 	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));

 		  //get DBA name
  		temp_dba_name				:= IF(TRIM(L.LIC_SORTNAME) != ' ',StringLib.StringToUpperCase(L.LIC_SORTNAME),
			                           IF(Prof_License_Mari.mod_clean_name_addr.GetDBAName(std_org_name)<>'',
																    Prof_License_Mari.mod_clean_name_addr.GetDBAName(std_org_name),
																		' '));
   		std_temp_dba				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba_name);
			
  		clnNAME_DBA					:= IF(REGEXFIND('( DBA |^DBA )',std_temp_dba), Prof_License_Mari.mod_clean_name_addr.GetDBAName(std_temp_dba),'');	
			
   		SELF.NAME_DBA				:= ' ';
			
    	SELF.TYPE_CD				:= IF(TRIM(L.stdLicType) IN GR_Lic_types, 'GR',
      														IF(TRIM(L.stdLicType) IN MD_Lic_types, 'MD',
      															 IF(SELF.NAME_FIRST != '','MD','GR')));
   		SELF.LICENSE_STATE	:= src_st;
   		SELF.RAW_LICENSE_TYPE	:= TRIM(L.stdLicType,LEFT,RIGHT);
   		SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;

			//Hawaii RE license has the format of license_type-license_number
			SELF.LICENSE_NBR		:= TRIM(L.LIC_TYPE,LEFT,RIGHT) + '-' + TRIM(L.LIC_NUM,LEFT,RIGHT);
			
   		SELF.OFF_LICENSE_NBR:= TRIM(L.LIC_OFFICE,LEFT,RIGHT);
   		SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.LIC_STATUS);
   		
   		//Default date is 17530101
   		//Convert MMDDYY to YYYYMMDD
   		SELF.CURR_ISSUE_DTE		:= '17530101';
   		tmpIssueDte						:= (STRING)lib_date.Date_MMDDYY_I2(L.EFFECTIVE_DATE);
   		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(L.EFFECTIVE_DATE)='',
			                            '17530101',
																	tmpIssueDte[1..4]+tmpIssueDte[5..6]+tmpIssueDte[7..8]);

   		tmpExpireDte					:= (STRING)Prof_License_Mari.DateCleaner.FromMMDDYY(L.EXPIRATION_DATE);
   		SELF.EXPIRE_DTE				:= IF(TRIM(L.EXPIRATION_DATE)='',
			                            '17530101',
																	tmpExpireDte[1..4]+tmpExpireDte[5..6]+tmpExpireDte[7..8]);

   		//Contact or Business name may be in Address1 field
			//determine cname2. 
			//determine if a business is a business using employ_full_name
			tmpIsCompany2					:= IF(TRIM(L.EMPLOY_FULL_NAME)!=' ',
																Prof_License_Mari.func_is_company(L.EMPLOY_FULL_NAME),
																FALSE);
   		FullAddress						:= TRIM(L.BUS_ADDRESS1,LEFT,RIGHT)+' '+TRIM(L.BUS_ADDRESS2,LEFT,RIGHT);
   		SELF.ADDR_BUS_IND			:= IF(TRIM(FullAddress,LEFT,RIGHT) != ' ','B',' ');
   		SELF.NAME_ORG_ORIG		:= IF(TRIM(L.SORTNAME,LEFT,RIGHT) != ' ' ,StringLib.StringToUpperCase(TRIM(L.SORTNAME,LEFT,RIGHT)),' ');
			SELF.NAME_FORMAT			:= 'F';
																																		
   		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',SELF.NAME_DBA,' ');
   		
   		//The following attempts to remove the business name from address
    		  clnBadAddress  			  := IF(REGEXFIND(BadAddrpattern,L.BUS_ADDRESS1),' ',StringLib.StringToUpperCase(TRIM(L.BUS_ADDRESS1,LEFT,RIGHT)));
      		RmvPercent						:= REGEXREPLACE('%',clnBadAddress,'');
      		//Indicates whether address_1 is an address or business name	
       		IsAddr								:= IF(REGEXFIND('^[0-9]+',RmvPercent)
         															OR StringLib.StringContains(RmvPercent,'PO BOX', TRUE)
         															OR StringLib.StringContains(RmvPercent,'P.O. BOX', TRUE)
         															OR StringLib.StringContains(RmvPercent,'P. O. BOX', TRUE)
         															OR StringLib.StringContains(RmvPercent,'P O BOX', TRUE)
         															OR StringLib.StringContains(RmvPercent,'P.O.BOX', TRUE)
         															OR StringLib.StringContains(RmvPercent,'PO ', TRUE)
         															OR StringLib.StringContains(RmvPercent,'BOX ', TRUE)
         															OR StringLib.StringContains(RmvPercent,' REGION ', TRUE)
         															OR StringLib.StringContains(RmvPercent,' RD ', TRUE)
         															OR StringLib.StringContains(RmvPercent,' AIRPORT ', TRUE)
         															OR StringLib.StringContains(RmvPercent,' HWY ', TRUE)
         															OR StringLib.StringContains(RmvPercent,' BLD ', TRUE),
         															TRUE,
         															FALSE);
      		tmpNameContact				:= IF(TRIM(L.BUS_ADDRESS2) != ' ' AND IsAddr != TRUE, RmvPercent,' '); //Get contact name from address

			//Use address cleaner to clean address
		
		  trimAddress1        := ut.CleanSpacesAndUpper(L.BUS_ADDRESS1);
	   	trimAddress2        := ut.CleanSpacesAndUpper(L.BUS_ADDRESS2);
			trimCity						:= ut.CleanSpacesAndUpper(L.BUS_CITY);
			trimState						:= ut.CleanSpacesAndUpper(L.BUS_STATE);
			tmpZip	            := MAP(LENGTH(TRIM(L.BUS_ZIPCODE))=3 => '00'+TRIM(L.BUS_ZIPCODE),
		                            LENGTH(TRIM(L.BUS_ZIPCODE))=4 => '0'+TRIM(L.BUS_ZIPCODE),
																TRIM(L.BUS_ZIPCODE));
  		
			clnAddress1					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
			clnAddress2					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

			//Prepare the input to address cleaner
			temp_preaddr1 			:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
			temp_preaddr2 			:= StringLib.StringCleanSpaces(trimCity+' '+trimState+' '+tmpZip); 
			clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
			tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
			tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
			AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
			//Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
			SELF.ADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
			SELF.ADDR_ADDR2_1		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
			SELF.ADDR_CITY_1		:= IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
			SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trimState);
			SELF.ADDR_ZIP5_1		:= IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
			SELF.ADDR_ZIP4_1		:= clnAddrAddr1[122..125];
   
   		//Determine office based on Employer name or business name in address1	
			ClnNAME_CONTACT     := IF(REGEXFIND('( DBA |^DBA )',std_temp_dba), Prof_License_Mari.mod_clean_name_addr.GetCorpName(std_temp_dba),'');
   		SELF.NAME_OFFICE		:= IF(tmpIsCompany2 AND SELF.TYPE_CD = 'MD',StringLib.StringToUpperCase(TRIM(L.EMPLOY_FULL_NAME,LEFT,RIGHT)),
   															IF(SELF.TYPE_CD = 'GR' AND Prof_License_Mari.func_is_company(tmpNameContact) = TRUE, tmpNameContact,''));
 
      SELF.OFFICE_PARSE		:= IF(TRIM(SELF.NAME_OFFICE)!= '','GR','');
			
   		SELF.NAME_MARI_ORG	:= IF(SELF.TYPE_CD = 'GR', SELF.NAME_ORG_ORIG,
   																IF(SELF.TYPE_CD = 'MD' AND tmpIsCompany2,ut.CleanSpacesAndUpper(L.EMPLOY_FULL_NAME),
																			  SELF.NAME_OFFICE));   		
			
   		SELF.NAME_CONTACT_FIRST	:= IF(SELF.TYPE_CD = 'GR' AND NOT tmpIsCompany2,StringLib.StringToUpperCase(SELF.NAME_FIRST),' ');
   		SELF.NAME_CONTACT_MID		:= IF(SELF.TYPE_CD = 'GR' AND NOT tmpIsCompany2,StringLib.StringToUpperCase(L.mname),' ');
   		SELF.NAME_CONTACT_LAST	:= IF(SELF.TYPE_CD = 'GR' AND NOT tmpIsCompany2,StringLib.StringToUpperCase(L.lname),' '); 
   		SELF.NAME_CONTACT_SUFX	:= IF(SELF.TYPE_CD = 'GR' AND NOT tmpIsCompany2,StringLib.StringToUpperCase(L.name_suffix),' ');

		
 		// Populate if DBA exist in multiple DBA fields			
   		SELF.dba			:= IF(clnNAME_DBA != ' ',clnNAME_DBA,
   												IF(clnNAME_DBA = ' ' AND L.DBA1 != '',ut.CleanSpacesAndUpper(L.DBA1),' '));
   		SELF.dba1			:= IF(clnNAME_DBA = ' ' AND L.DBA2 != '',ut.CleanSpacesAndUpper(L.DBA2),
   												IF(clnNAME_DBA != ' ', ut.CleanSpacesAndUpper(L.DBA1),' '));
   		SELF.dba2			:= IF(clnNAME_DBA = ' ' AND L.DBA3 != '',ut.CleanSpacesAndUpper(L.DBA3),
   												IF(clnNAME_DBA != ' ', ut.CleanSpacesAndUpper(L.DBA2),' '));
   		SELF.dba3 		:= IF(clnNAME_DBA = ' ' AND L.DBA4 != '',ut.CleanSpacesAndUpper(L.DBA4),
   												IF(clnNAME_DBA != ' ', ut.CleanSpacesAndUpper(L.DBA3),' '));		
   		SELF.dba4 		:= IF(clnNAME_DBA = ' ' AND L.DBA5 != '',ut.CleanSpacesAndUpper(L.DBA5),
   												IF(clnNAME_DBA != ' ', ut.CleanSpacesAndUpper(L.DBA4),' '));			
   		SELF.dba5 		:= IF(clnNAME_DBA = ' ' AND L.DBA6 != '',ut.CleanSpacesAndUpper(L.DBA6),
   												IF(clnNAME_DBA != ' ', ut.CleanSpacesAndUpper(L.DBA5),' '));
   
   		//fields used to create mltrec_key are :
   		//license number
   		//office license number
   		//license type
   		//source update
   		//raw name including DBA's
   		//raw address 
			//Use hash64 to avoid dup keys
																
			// fields used to create mltreckey key are:
			// license number
			// license type
			// source update
			// name
			// address_1
			// dba
			// officename 
			//Use hash64 instead of hash32 to avoid dup keys
			mltreckeyHash 			:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																	 +TRIM(SELF.std_license_type,LEFT,RIGHT)
																	 +TRIM(SELF.std_source_upd,LEFT,RIGHT)
																	 +ut.CleanSpacesAndUpper(L.SORTNAME)
																	 +TRIM(SELF.dba,LEFT,RIGHT)
																	 +TRIM(SELF.dba1,LEFT,RIGHT)
																	 +TRIM(SELF.dba2,LEFT,RIGHT)
																	 +TRIM(SELF.dba3,LEFT,RIGHT)
																	 +TRIM(SELF.dba4,LEFT,RIGHT)
																	 +TRIM(SELF.dba5,LEFT,RIGHT)
																	 +TRIM(L.BUS_ADDRESS1,LEFT,RIGHT)
																	 +TRIM(L.BUS_ADDRESS2,LEFT,RIGHT)
																	 +TRIM(L.BUS_CITY,LEFT,RIGHT)
																	 +TRIM(L.BUS_STATE,LEFT,RIGHT)
																	 +TRIM(L.BUS_ZIPCODE,LEFT,RIGHT));
				
			SELF.mltreckey 			:= IF(SELF.dba1 != ' ',mltreckeyHash, 0);
															
   		//Expected codes [CO,BR,IN]
   		SELF.AFFIL_TYPE_CD	:= IF(SELF.TYPE_CD = 'MD ','IN',
   																IF(SELF.TYPE_CD = 'GR' AND SELF.TYPE_CD IN BR_Lic_types,'BR',
   																	IF(SELF.TYPE_CD = 'GR' AND SELF.TYPE_CD not IN BR_Lic_types,'CO',' ')));
   		
   		//fields used to create cmc_slpk unique key are :
   		//license number
   		//office license number
   		//license type
   		//source update
   		//standard name_org w/o DBA
   		//raw address 	
   		SELF.CMC_SLPK     	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																		+TRIM(SELF.OFF_LICENSE_NBR)
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																		+TRIM(L.BUS_ADDRESS1,LEFT,RIGHT)
																		+TRIM(L.BUS_ADDRESS2,LEFT,RIGHT)
																		+TRIM(L.BUS_CITY,LEFT,RIGHT)
																		+TRIM(L.BUS_STATE,LEFT,RIGHT)
																		+TRIM(L.BUS_ZIPCODE,LEFT,RIGHT));
	
			SELF := [];
	END;	

	ds_map := PROJECT(ValidHILicense, transformToCommon(LEFT));

	// populate std_license_status field via translation on raw_license_status field
	maribase_plus_dbas trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// populate prof code field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_type,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
			SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,6,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := TRANSFORM
		SELF.NAME_ORG_SUFX	:= REGEXREPLACE('[^a-zA-Z0-9_]',L.NAME_ORG_SUFX,'');
		StdDBASufx					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);
		DBA_SUFX						:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdDBASufx);						   
		SELF.NAME_DBA 			:= IF(REGEXFIND(IPpattern,L.TMP_DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',StdDBASufx,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdDBASufx,' CO')));
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: TRUE  0: FALSE
		SELF.NAME_DBA_SUFX	:= REGEXREPLACE('[^a-zA-Z0-9_]',DBA_SUFX,''); 
		SELF.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
																L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(StdDBASufx,LEFT,RIGHT),
																L.type_cd = 'MD' => TRIM(StdDBASufx,LEFT,RIGHT), ''); 
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));
																
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
							TRIM(LEFT.name_org[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org[1..50],LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layout_base_in xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'legal_sortname', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'license_data', 'using', 'used')
														);
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, o_ds_HI_license,o_ds_HI_sortname,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;