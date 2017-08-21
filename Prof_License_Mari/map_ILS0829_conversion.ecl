// Purpose : map ILS0829 / Illinois Department of Professional Regulation / Multiple Professions raw data to common layout for MARI and PL use
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_ILS0829_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'ILS0829';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move data from sprayed to using directory
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed', 'using');
	
	//input file(s)
	re_all       	:= Prof_License_Mari.files_ILS0829.relic;
	oAReAll				:= OUTPUT(re_all);
	
	//Remove bad records before processing
	ValidFile						:= re_all(TRIM(org_name,left,right)+trim(org_name,left,right) != ' ' 
																AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME))
																AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));
	//test_file := choosen(ValidFile,10000);

	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD=src_cd);

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA )(.*)';

	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';

	// company lic_type data set
	//GR_types := ['477','478','479','481'];
	//license type 480 is corporation as well. Cathy Tio 2/5/13
	GR_types := ['477','478','479','480','481'];

	// individual names identified as companies and parsed incorrectly
	not_GR_names := ['CAROL J WORKER','WAYNE J WORKER','HYMAN J DIRECTOR','ATY BISWESE'];
                      

	maribase_plus_dbas := record,maxlength(5000)
		Prof_License_Mari.layouts.base;
		string60 dba;
		string60 dba1;
		string60 dba2;
		string60 dba3;
		string60 dba4;
		string60 dba5;
	end;


	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_ILS0829 pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		tempLicNum           := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.slnum);
		SELF.LICENSE_NBR	   := tempLicNum;
		SELF.LICENSE_STATE	 := src_st;
			
		// initialize raw_license_type from raw data
		tempRawType := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_type);
		SELF.RAW_LICENSE_TYPE := tempRawType;
																	 													          
		// map raw license type to standard license type before profcode translations
		tempStdLicType				:= tempRawType;
  	SELF.STD_LICENSE_TYPE := tempStdLicType;
			
		// assigning dates per business rules
		tempExpDt            := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.EXPDT);
		SELF.EXPIRE_DTE		   := IF(tempExpDt='','17530101',tempExpDt);
		tempIssueDate        := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ISSUEDT);
		SELF.ORIG_ISSUE_DTE  := IF(tempIssueDate='','17530101',tempIssueDate);
		self.CURR_ISSUE_DTE	 := '17530101';
				
		//initialize raw_license_status from raw data
		tempRawStatus 			 := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.licstat);
		SELF.RAW_LICENSE_STATUS := IF(tempRawStatus='FAC TERMINATED',
																	'TERMINATED',
																	tempRawStatus);
			
		// assigning type code based on license type
		tempTypeCd		  		 := MAP(tempRawType IN GR_types => 'GR',
														 tempRawType NOT IN GR_types => 'MD',
														 '');
		SELF.TYPE_CD      	 := tempTypeCd;
	
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		tempTrimName     		 := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.org_name);
		tempTrimNameFix  		 := IF(tempTrimName[1..3]= 'C/O', TRIM(tempTrimName[4..],LEFT,RIGHT),tempTrimName);
		tempTrimNameFix2 		 := IF(tempTrimNameFix[1..4]= 'DBA ', TRIM(tempTrimNameFix[5..],LEFT,RIGHT),tempTrimNameFix);
		tempTrimNameFix3 		 := stringlib.stringfindreplace(tempTrimNameFix2,'/DBA ',' DBA ');
		tempTrimNameFix4 		 := stringlib.stringfindreplace(tempTrimNameFix3,' D B A ',' DBA ');
		tempTrimNameFix5 		 := stringlib.stringfindreplace(tempTrimNameFix4,'RE/GROUP ','RE GROUP ');
		tempTrimNameFix6 		 := stringlib.stringcleanspaces(tempTrimNameFix5);
		tempTrimNameFix7 		 := IF(tempTrimNameFix6[1..4]= 'AKA ', TRIM(tempTrimNameFix6[5..],LEFT,RIGHT),tempTrimNameFix6);
		tempTrimNameFix8 		 := stringlib.stringfindreplace(tempTrimNameFix7,' LLC/OG ',' LLC AKA OG ');
		TrimNAME_ORG		 		 := IF(REGEXFIND(DBApattern,tempTrimNameFix8) = true,
															Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix8),
															tempTrimNameFix8);

		// assign mariparse to correctly parse individual names for business records
		tempMariParse     	 := tempTypeCd;
		mariParse         	 := MAP(prof_license_mari.func_is_company(TrimNAME_ORG) = TRUE => 'GR',
															prof_license_mari.func_is_company(TrimNAME_ORG) = FALSE => 'MD',
															tempMariParse);
		// noquoteORG      := if(mariParse='GR',stringlib.stringfindreplace(TrimNAME_ORG,'"',''),TrimNAME_ORG);
			
		prepNAME_ORG				 := MAP(StringLib.stringfind(TrimNAME_ORG,'D/B/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'D/B/',' '),
																StringLib.stringfind(TrimNAME_ORG,'T/A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T/A',' '),
																StringLib.stringfind(TrimNAME_ORG,'T\\A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T\\A',' '),
																StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
																StringLib.stringfind(TrimNAME_ORG,'\\',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'\\',' '),
																trimNAME_ORG);
										   
		tempNick						 := IF(StringLib.stringfind(prepNAME_ORG,'"',1) >0 and StringLib.stringfind(prepNAME_ORG,'(',1) >0,
																REGEXFIND('^([A-Za-z ][^("]+)[\\(][\\"]([A-Za-z ][^\\"]+)[\\"][\\)]',prepNAME_ORG,2),'');
			
		//Removing NickName from Corporate NAME field
		removeNick					 := IF(tempNick != ' ',REGEXREPLACE(tempNick,prepNAME_ORG,''), prepNAME_ORG);
		
		rmvQuoteORG     		 := stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		StdNAME_ORG					 := IF(rmvQuoteORG != ' ' and NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
															 rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
										 
	
		// use the right parser for name field
		CleanNAME_ORG		:= map(// tempTypeCd = 'GR' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   tempTypeCd = 'GR' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									   tempTypeCd = 'GR' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
									   tempTypeCd = 'MD' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
									   // tempTypeCd = 'MD' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
									   tempTypeCd = 'MD' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
		                 StdNAME_ORG);
			
		//self.office_parse := mariParse;
		self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
		LenLName				 := LENGTH(TRIM(CleanNAME_ORG[46..65], LEFT, RIGHT));	
		//Modifed to handle the case where the parsed last name	(CleanNAME_ORG[46..65]) has length 1. This is when the last name
		//has special meaning, like six, trainer, etc, and cleanFMLName is not able to parse the name correctly. 2/8/13 Cathy Tio
		//self.NAME_ORG 	 := MAP(mariParse='MD'=> stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[66..70]
		//												+' '+CleanNAME_ORG[6..25]+' '+CleanNAME_ORG[26..45]),
		//												StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 and self.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
		//												CleanNAME_ORG);
		PrepNameOrg						:= MAP(mariParse='MD'=> 
																IF(LenLName=1 AND pInput.L_NAME<>' ', Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.L_NAME) + ' ' + Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.F_NAME),
																	 stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[6..25])),
																StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 and self.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																CleanNAME_ORG);
		PrepNameOrg1	 	 			:= IF(REGEXFIND('^(.*) DBA',TRIM(PrepNameOrg)),REGEXFIND('^(.*) DBA',TRIM(PrepNameOrg),1),TRIM(PrepNameOrg));
		PrepNameOrg2					:= IF(REGEXFIND('(D/B/A$|^AKA )', PrepNameOrg1),
																REGEXREPLACE('(D/B/A$|^AKA )',PrepNameOrg1,''),
																PrepNameOrg1);
		SELF.NAME_ORG					:= MAP(PrepNameOrg2<>'' => StringLib.stringCleanSpaces(PrepNameOrg2),
		                             tempTypeCd='MD'  => Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.L_NAME) + ' ' +
																                     Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.F_NAME),
																 tempTypeCd='GR'  => StdNAME_ORG,									 
																 '');									 
		
		// Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
			
	 // Parsed out ORG_NAME Suffix
		SELF.NAME_ORG_SUFX	:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
															 NOT REGEXFIND('LLP',StdNAME_ORG) AND REGEXFIND('(LP)$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
															 REGEXFIND('(L[.]P[.])$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
															 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
									  					 Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
															
		//SELF.NAME_FIRST			:= IF(mariParse='MD',TRIM(CleanNAME_ORG[6..25],left,right),'');
		//Use the first name provided in the raw input file. 2/6/13 Cathy
		SELF.NAME_FIRST			:= IF(tempTypeCd='MD' AND mariParse='MD',
															Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.F_NAME),
															'');
		//SELF.NAME_MID				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],left,right),'');
		tmpMName							:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],left,right),'');
		SELF.NAME_MID				:= IF(tempTypeCd='MD' AND mariParse='MD',
															IF(lib_StringLib.stringlib.StringContains(SELF.NAME_FIRST,' ' + tmpMName, TRUE),  //The parsed middle name is part of the first name
															   '',
																 tmpMName),
															'');	 
		//SELF.NAME_LAST			:= if(mariParse='MD',TRIM(CleanNAME_ORG[46..65],left,right),'');
		//Use the last name provided in the raw input file. 2/6/13 Cathy
		SELF.NAME_LAST			:= IF(tempTypeCd='MD' AND mariParse='MD',
															Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.L_NAME),
															'');
/* 		SELF.NAME_PREFX     := IF(mariParse='MD' AND SELF.NAME_LAST<>'',
   														  IF(TRIM(CleanNAME_ORG[1..5],left,right)='MS' OR TRIM(CleanNAME_ORG[1..5],left,right)='MR',
   																	TRIM(CleanNAME_ORG[1..5],left,right),
   																	''),
   															'');
*/

		SELF.NAME_SUFX			:= IF(mariParse='MD' AND SELF.NAME_LAST<>'',TRIM(CleanNAME_ORG[66..70],left,right),'');
		SELF.NAME_NICK			:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
															 StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
															 tempNick);

		// office address fields
		COMPANY_IN_ADDR_PATTERN	:= '^(.* LLC|.* INC|.* CORP|.* CORP\\.|.* COMPANY|.* RLTRS|.* REALTORS|RE CORP OF .*)$';
		/*trimAddr1          	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1_1);
		trimAddr2          	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS2_1);
self.provnote_1:= trimAddr1+'|'+trimAddr2+'|'+tempTrimName+'|'+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.L_NAME)+
                  '|'+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.F_NAME);
		tmpAddr1						:= MAP(REGEXFIND('^(C/O |D/B/A |ATTN:|ATTN |ATTENTION:|ATTENTION )', trimAddr1) => '',
															 REGEXFIND(COMPANY_IN_ADDR_PATTERN, trimAddr1) => '',
														   REGEXFIND('^.* INC ([0-9]+ .*)$', trimAddr1) => REGEXFIND('^.* INC ([0-9]+ .*)$', trimAddr1, 1),
															 REGEXFIND('^.* INC CO ([0-9]+ .*)$', trimAddr1) => REGEXFIND('^.* INC CO ([0-9]+ .*)$', trimAddr1, 1),
																 trimAddr1);
		tmpAddr2						:= MAP(REGEXFIND('^(C/O |D/B/A |ATTN:|ATTN |ATTENTION:|ATTENTION )', trimAddr2) => '',
															 REGEXFIND(COMPANY_IN_ADDR_PATTERN, trimAddr2) => '',
															 REGEXFIND('^(.*)(C/O)$',trimAddr2) => REGEXFIND('^(.*)(C/O)$',trimAddr2, 1),
															 trimAddr2);	                           
		
 		tempAdd1          	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1_1);
   		tempAdd2          	:= IF(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS2_1) = 
   															Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1_1), '',
   															Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS2_1));
   		tempAdd3          	:= IF(Prof_License_Mari.func_is_address(tempAdd1)= FALSE, 
   															tempAdd2,
   															tempAdd1);
*/
                                 			
/* 		SELF.ADDR_ADDR1_1	  := tempAdd3;
   		SELF.ADDR_ADDR2_1   := if(tempAdd2=tempAdd3,'',tempAdd2);
   		
   		SELF.ADDR_CITY_1		:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.CITY_1);
   		tempState           := if(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.STATE_1)='NULL','',
   															Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.STATE_1));
   		SELF.ADDR_STATE_1	  := tempState;
   		tempZip             := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(stringlib.stringfindreplace(pInput.ZIP,'-',''));
   		SELF.ADDR_ZIP5_1		:= tempZip[1..5];
   		tempZip4        		:= tempZip[6..9];
   		SELF.ADDR_ZIP4_1    := if(tempZip4 = '0000',' ',tempZip4); 
*/

		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^D/B/A .*$|^.* RLTRS$|^.* REALTORS$|^RE CORP OF .*$|^.* 2000 INC | COMPANY REALTORS|MID-AMERICA REAL ESTATE CORP |' +
					 '107 INC DBA MEL FOSTER CO|^.* BROKERS INC |^.* LTD$|TREASURE ISLAND|THE ISLANDS|^REFERRAL NETWORK$|^UNKNOWN$|' +
					 '^.*REFERRAL CO$|^REFERRAL ASSOC$|^REALTY CO\\. -|REALTY CO|^REALTORS$|^REAL ESTATE OF .*$|^REAL ESTATE$|' +
					 '^RE/MAX .*$|^RE CO$|^RE DIVISION$|^.* SUBDIVISION|^.* AND CO$|^.* GROUP$|MANAGEMENT CO|^NORTHERN IL[A-Z]*$|' +
					 '^.* MANAGEMENT OFFICE$|^OF [A-Z ]+$|^UNITED PROPERTIES$|^.* AGENCY$|^THE GALLERY OF .*$|' +
					 '^WILLIAM [A-Z] [A-Z]+$|^WARREN [A-Z] [A-Z]+$|^STE.* [A-Z] [A-Z]+$|^ROBERT [A-Z]+$|^ROBERT [A-Z] [A-Z]+$|' +
					 '^VICTOR [A-Z] [A-Z]+$|^VICTOR [A-Z]+$|^VERNON [A-Z]+$|^VERNON [A-Z] [A-Z]+$|^RICHARD [A-Z] [A-Z]+$|' +
					 '^PATRICIA [A-Z] [A-Z]+$|^PETER [A-Z] [A-Z]+$|^PERRY [A-Z]+$|^THOMAS [A-Z] [A-Z]+$|^SUSAN [A-Z ]+$|^SAMUEL [A-Z ]+$|' +
					 '^MARK [A-Z] [A-Z]+$|^MICHAEL [A-Z] [A-Z]+$|^NOAH [A-Z]+$|^NILES [A-Z]+$|^RONALD [A-Z]+$|^RONALD [A-Z] [A-Z]+$|' +
					 '^NELSON [A-Z] [A-Z]+$|^NELSON [A-Z]+$|^NEDRA [A-Z] [A-Z]+$|' +
					 '^ROCK ISLAND$|^ROMACK CO$|^.* CONST CO$|^RE [A-Z ]+$|^REAL ESTATE .*$|^RESIDENTIAL .*|^.* COUNSELORS$|^.* UNLIMITED$|' +
					 '^PROPERTIES$|^PREFERRED PROPERTIES$|^LTD$|^.* AND SON[S]?$|^JOHN [A-Z ]+$|^JEAN [A-Z ]+$|^JAY [A-Z ]+$|^JAMES [A-Z ]+$|' +
					 '^IVY [A-Z ]+$|^IRA [A-Z ]+$|^HOWARD [A-Z ]+$|^HUGH [A-Z ]+$|^HELEN [A-Z ]+$|^HARRY [A-Z ]+$|^HAROLD [A-Z ]+$|' +
					 '^INSURANCE CO$|^INC RLTR$|^INC$|^INC OF [A-Z]+$|^INC CENTURY 21$|^INVESTMENT .* CO$|^HOME SWEET HOME$|' +
					 '^HOELZ PROFESSIONALS$|^HOMETOWN RLTY DWIGHT$|^HEARTLAND RE$|^.* RLTY$|^GROUP ING$|HANNER AND JOHNSON|' +
					 '^ADDRESS LINE1$|^APARTMENT MART$|' +
					 'ROYAL LEAMINGTON SPA| DBA .* CO |CENTURY21 OLSICK INC CO|^RLTRS$|^RLTY$|^RLTY CO$' +
				 ')';                                 
                                
		trimAddress1          := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1_1);
	  trimAddress2          := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS2_1);
 		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.CITY_1);
		TrimState							:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.STATE_1);
		tmpZip	              := MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
		                             LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
 		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+tmpZip); 
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1_1			:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
		tmpADDR_ADDR2_1				:= IF(REGEXFIND('^(.*)C/O',tmpADDR_ADDR2_1_1),REGEXFIND('^(.*)C/O',tmpADDR_ADDR2_1_1,1),tmpADDR_ADDR2_1_1);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_CITY_1			:= IF(TRIM(clnAddress[65..89])='',TrimCity,TRIM(clnAddress[65..89]));
		SELF.OOC_IND_1			:= IF(REGEXFIND('(ETOBICOKE|VANCOUVER BC|UNITED KINGDOM)',SELF.ADDR_CITY_1),1,0);

		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != '' and tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1<>''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1='' AND SELF.OOC_IND_1=1
																   => StringLib.StringCleanSpaces(trimAddress1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact!='' => '',
																	 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR2_1)=TRIM(tmpADDR_ADDR1_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_STATE_1			:= IF(TRIM(clnAddress[115..116])='',TrimState,TRIM(clnAddress[115..116]));
   	SELF.ADDR_ZIP5_1			:= IF(TRIM(clnAddress[117..121])='',StringLib.StringFilter(tmpZip,'0123456789'),TRIM(clnAddress[117..121]));
   	SELF.ADDR_ZIP4_1			:= clnAddress[122..125];
		//self.provnote_1 := trimAddress1+'|'+trimAddress2+'|'+TrimCity+'|'+TrimState+'|'+TRIM(pInput.ZIP)+'|'+tmpADDR_ADDR1_1+'|'+tmpADDR_ADDR2_1;
		SELF.ADDR_CNTY_1    := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.COUNTY);
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  := IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY_1 + pInput.STATE_1 + pInput.ZIP,LEFT,RIGHT) != '','B','');
			
		// assign officename
		tempNameOff         := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.officename);
		tempNameOff2        := MAP(tempNameOff<>'' AND REGEXFIND('( DBA |/DBA | DBA$|^DBA | D/B/A )',tempNameOff)
		                              => Prof_License_Mari.mod_clean_name_addr.getCorpName(tempNameOff),
															 tempNameOff<>'' AND NOT REGEXFIND('( DBA |/DBA | DBA$|^DBA | D/B/A )',tempNameOff)
		                              => tempNameOff,
															 tempTypeCd ='MD' AND REGEXFIND('^D/B/A (.*)',trimAddress1)
																	=> REGEXFIND('^D/B/A (.*)',trimAddress1, 1),
															 tempTypeCd ='MD' AND REGEXFIND('^C/O (.*)',trimAddress1)
																	=> REGEXFIND('^C/O (.*)',trimAddress1, 1),
															 tempTypeCd ='MD' AND REGEXFIND(COMPANY_IN_ADDR_PATTERN,trimAddress1)
																	=> trimAddress1,
															 tempTypeCd ='MD' AND REGEXFIND('^(.* INC) [0-9]+',trimAddress1)
																	=> REGEXFIND('^(.* INC) [0-9]+',trimAddress1,1),
															 tempTypeCd ='MD' AND REGEXFIND('^(.* INC) CO [0-9]+',trimAddress1)
																	=> REGEXFIND('^(.* INC) CO [0-9]+',trimAddress1,1),
															 tempTypeCd ='MD' AND REGEXFIND('^C/O (.*)',trimAddress2)
																	=> REGEXFIND('^C/O (.*)',trimAddress2, 1),
															 tempTypeCd ='MD' AND REGEXFIND(COMPANY_IN_ADDR_PATTERN,trimAddress2)
																	=> trimAddress2,
															 //Prof_License_Mari.func_is_address(tempAdd1)= false and tempNameOff = ''  => tempAdd1,
															 //tempTypeCd = 'MD' and Prof_License_Mari.func_is_address(tempAdd1)= false and tempNameOff != '' => tempNameOff,
															 '');
															 																 
		trimNAME_OFFICE     := IF(REGEXFIND('(.*)/$',tempNameOff2),REGEXFIND('(.*)/$',tempNameOff2,1),tempNameOff2);
		trimNAME_OFFICE1		:= IF(REGEXFIND('(D/B/A$|^AKA )', trimNAME_OFFICE),
		                          REGEXREPLACE('(D/B/A$|^AKA )',trimNAME_OFFICE,''),
															trimNAME_OFFICE);
		trimNAME_OFFICE2		:= MAP(trimNAME_OFFICE1='& ASSOC IN' => '',
		                           trimNAME_OFFICE1='& ASSOCS IN' => '',
		                           trimNAME_OFFICE1='& ASSOCIATES IN' => '',
															 trimNAME_OFFICE1);
		SELF.NAME_OFFICE    := StringLib.stringCleanSpaces(trimNAME_OFFICE2);
      
		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG	:= tempTrimName;
		self.NAME_FORMAT		:= 'F';
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG := if(tempTypeCd='GR',	StdNAME_ORG,trimNAME_OFFICE); 

		// disciplinary action type code
		tempDispType := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.DISPTYPE);
		SELF.DISP_TYPE_CD := if(tempDispType = 'Y','D','');
			
			
		// Business rules to parse contacts
		tempContact     := Prof_License_Mari.mod_clean_name_addr.trimupper(pInput.attline);
		tempContact2    := if(Prof_License_Mari.func_is_company(tempContact) = true,'',tempContact);
		prepContact			:= tempContact2;
												
			
		stripTitle			:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => StringLib.StringFindReplace(prepContact,'RECEIVER',''),
													 StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => StringLib.StringFindReplace(prepContact,'CONSERVATOR',''),
													 StringLib.stringfind(prepContact,'BROKER',1)>0 => StringLib.StringFindReplace(prepContact,'BROKER',''),
													 StringLib.stringfind(prepContact,'MNGR',1)>0 => StringLib.StringFindReplace(prepContact,'MNGR',''),
													 StringLib.stringfind(prepContact,'GENERAL COUNSEL',1)>0 => StringLib.StringFindReplace(prepContact,'GENERAL COUNSEL',''),
													 StringLib.stringfind(prepContact,'C/O',1)>0 => StringLib.StringFindReplace(prepContact,'C/O',''),
													 StringLib.stringfind(prepContact,'CAPITAL',1) >0 => StringLib.StringFindReplace(prepContact,'CAPITAL',''),
													 StringLib.stringfind(prepContact,'LEGAL DEPARTMENT',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPARTMENT',''),
													 StringLib.stringfind(prepContact,'LEGAL DEPT',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPT',''),
													 StringLib.stringfind(prepContact,'LEGAL DEPT.',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPT.',''),
													 StringLib.stringfind(prepContact,'OFFICE',1) >0 => StringLib.StringFindReplace(prepContact,'OFFICE',''),
													 StringLib.stringfind(prepContact,'A PARTNERSHIP',1) >0 => StringLib.StringFindReplace(prepContact,'A PARTNERSHIP',''),
													 prepContact);
			
		parseContact		:= MAP(prepContact != '' and StringLib.stringfind(TRIM(stripTitle,left,right),' ',1)< 1 => ' ',
													 prepContact != '' and NOT Prof_License_Mari.func_is_company(stripTitle) => datalib.NameClean(stripTitle),
													 ' ');
									 
		self.NAME_CONTACT_FIRST := TRIM(parseContact[1..15],left,right);
		self.NAME_CONTACT_MID	:= TRIM(parseContact[41..56],left,right);
		self.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],left,right);
		self.NAME_CONTACT_SUFX	:= TRIM(parseContact[131..134],left,right);
		self.NAME_CONTACT_TTL	:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => 'RECEIVER',
																 StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
																 StringLib.stringfind(prepContact,'BROKER',1)>0 => 'BROKER',
																 StringLib.stringfind(prepContact,'MNGR',1)>0 => 'MNGR',
																 '');	
			
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		tempDBA       := Prof_License_Mari.mod_clean_name_addr.getDbaName(pInput.org_name);
		trimDBA       := Prof_License_Mari.mod_clean_name_addr.trimUpper(tempDBA);
		trimFix       := stringlib.stringfindreplace(trimDBA,'RE/MAX','REMAX');
		//trimDBA2      := if(tempTypeCd = 'GR' and Prof_License_Mari.func_is_address(tempAdd1)= false and trimDBA = '',tempAdd1, trimDBA);
		tempDBA1      := if(trimDBA=TrimNAME_ORG,'',trimFix);
		tempDBA2      := stringlib.stringfindreplace(tempDBA1,';','/');
		tempDBA3      := stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
		tempDBA4      := if(stringlib.stringfind(tempDBA3,'BURRES AND ASSOCIATES',1)=0
												AND stringlib.stringfind(tempDBA3,'AND LOAN',1)=0,
												stringlib.stringfindreplace(tempDBA3,' AND ','/'),
												tempDBA3);
												
		StripDBA      := stringlib.stringfindreplace(tempDBA4,'CORPORATION','CORP');
		sepSpot       := stringlib.stringfind(StripDBA,'/',1);
		self.dba			:= StripDBA[1..stringlib.stringfind(StripDBA,'/',1)-1];
		self.dba_flag := if(StripDBA != ' ', 1, 0);
		temp_dba1			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
									 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
																						StripDBA);
																						
		self.dba1 := temp_dba1;

		// self.dba2 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,2),
		self.dba2			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
											 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
																						 ' ');
					
		self.dba3 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									 StringLib.stringfind(StripDBA,'/',2) > 0 =>
									REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																							'');
		
		self.dba4 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									 StringLib.stringfind(StripDBA,'/',3) > 0 =>
									REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																							 '');
		
		self.dba5 			:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
									REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');						   
			
		// fields used to create mltreckey key are:
		//    license number
		//	  license type
		//	  source update
		//	  name
		//	  address_1
		//		dba
		//		officename
			 
		mltreckeyHash := hash64(trim(tempLicNum,left,right) 
														 +trim(tempStdLicType,left,right)
														 +trim(src_cd,left,right)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(StdName_Org)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1_1)
														 +tmpZip
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(StripDBA)
														); 
			
		self.mltreckey 				:= if(temp_dba1 != ' ',mltreckeyHash, 0);
			
		// fields used to create unique key are:
		//    license number
		//	  license type
		//	  source update
		//	  name
		//	  address			 
		self.cmc_slpk         := hash64(trim(tempLicNum,left,right) 
														 +trim(tempStdLicType,left,right)
														 +trim(src_cd,left,right)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(StdName_Org)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1_1));									 
			//Patch them in for now
			SELF.STD_PROF_CD		:= MAP(TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)='474' => 'RLE',
																 TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)='480' => 'RLE',
																 TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)='554' => 'APR',
																 ' ');
	//self.provnote_3 := TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)+ '=>' + SELF.STD_PROF_CD;
		SELF := [];
		
	END;

	ds_map := PROJECT(ValidFile, transformToCommon(LEFT));
	//ds_map := PROJECT(test_file, transformToCommon(LEFT));

	// Clean-up Fields
	maribase_plus_dbas	transformClean(ds_map pInput) :=  TRANSFORM
		// clnParseName			:= IF(pInput.NAME_ORG_ORIG != '' and Prof_License_Mari.func_is_company(pInput.NAME_ORG_ORIG),
											// '', datalib.NameClean(pInput.NAME_ORG));

		self.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '.'),
									   StringLib.stringfind(pInput.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, ','),
									   StringLib.stringfind(pInput.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '#'),	
										                                                       pInput.ADDR_ADDR1_1);
		self.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '.'),
									   StringLib.stringfind(pInput.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, ','),
									   StringLib.stringfind(pInput.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '#'),	
										                                                       pInput.ADDR_ADDR2_1);
		
		self.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '.'),
									   StringLib.stringfind(pInput.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, ','),
									   StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '#'),	
										                                                       pInput.ADDR_ADDR3_1);
		
		self := pInput;
	END;
	ds_map_clean := project(ds_map , transformClean(left));
							   

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map_clean L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
								left.STD_SOURCE_UPD=right.source_upd
								AND TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
									AND right.fld_name='LIC_STATUS',
								trans_lic_status(left,right),left outer,lookup);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := transform
		//self.STD_PROF_CD := R.DM_VALUE1;
		//This is just a patch. Remove after 474, 480, and 554 are added to the translation table
		SELF.STD_PROF_CD		:= MAP(TRIM(L.STD_LICENSE_TYPE,LEFT,RIGHT)='474' => 'RLE',
																 TRIM(L.STD_LICENSE_TYPE,LEFT,RIGHT)='480' => 'RLE',
																 TRIM(L.STD_LICENSE_TYPE,LEFT,RIGHT)='554' => 'APR',
																 R.DM_VALUE1);	
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							left.STD_SOURCE_UPD=right.source_upd
							AND TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer,lookup);
																		
/* // Populate prof code description
   maribase_plus_dbas  trans_prof_desc(ds_map_lic_trans L, Prof_Desc R) := transform
     self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
   	self := L;
   end;

 
   ds_map_prof_desc := JOIN(ds_map_lic_trans, Prof_Desc,
   						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
   						 trans_prof_desc(left,right),left outer,lookup);
   																		
   
   // Populate License Status Description field
   maribase_plus_dbas trans_status_desc(ds_map_prof_desc L, Status_Desc R) := transform
     self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
     self := L;
   end;
   
   ds_map_status_desc := jOIN(ds_map_prof_desc, Status_Desc,
   							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
   							trans_status_desc(left,right),left outer,lookup);
   																		
   																		
   //Populate License Type Description field
   maribase_plus_dbas trans_type_desc(ds_map_status_desc L, License_Desc R) := transform
     self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
     self := L;
   end;
   
   ds_map_type_desc := JOIN(ds_map_status_desc, License_Desc,
   						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
   						trans_type_desc(left,right),left outer,lookup);
   						
   //Populate Disciplinary Action Type Description field
   maribase_plus_dbas trans_disp_desc(ds_map_type_desc L, Disp_Desc R) := transform
     self.DISP_TYPE_DESC := StringLib.stringtouppercase(trim(R.disp_desc,left,right));
     self := L;
   end;
   
   ds_map_disp_desc := join(ds_map_type_desc, Disp_Desc,
   						TRIM(left.DISP_TYPE_CD,left,right)= TRIM(right.disp_type,left,right),
   						trans_disp_desc(left,right),left outer,lookup);
   						
   						
   //Populate Source Description field
   maribase_plus_dbas trans_source_desc(ds_map_disp_desc L, Src_Desc R) := transform
     self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
     self := L;
   end;
   
   ds_map_source_desc := join(ds_map_disp_desc, Src_Desc,
   						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
   						trans_source_desc(left,right),left outer,lookup);
*/

	// Normalized DBA records
	maribase_dbas := record,maxlength(5000)
		maribase_plus_dbas;
		string60 tmp_dba;
	end;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
			self := L;
		self.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	//NormDBAs 	:= DEDUP(NORMALIZE(ds_map_source_desc,6,NormIT(left,counter)),all,record);
	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,6,NormIT(left,counter)),all,record);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := transform
			self.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
			TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		self.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
		self.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		self.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
									 L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(L.TMP_DBA,left,right),
									 L.type_cd = 'MD' => TRIM(L.TMP_DBA,left,right), ''); 
		self := L;
	end;

	ds_map_base := project(FilteredRecs, xTransToBase(left));
																
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	ds_map_affil := join(ds_map_base, company_only_lookup,
							TRIM(left.off_license_nbr,left,right)	= TRIM(right.license_nbr,left,right)
							AND left.AFFIL_TYPE_CD in ['IN', 'BR'],
							assign_pcmcslpk(left,right),left outer,lookup);																		

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := transform
		self.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,left,right)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		self := L;
	end;

	OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

	//Adding to Superfile
		
	d_final := output(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__compressed__,overwrite);
			
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using', 'used');
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oAReAll, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;
