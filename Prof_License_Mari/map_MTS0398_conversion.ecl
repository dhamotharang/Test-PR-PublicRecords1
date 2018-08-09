// MTS0398 / Montana Department of Labor and Industry /	Multiple Professions / raw data to common layout for MARI and PL use
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;
#workunit('name','Yogurt: map_MTS0398_conversion'); 

EXPORT map_MTS0398_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MTS0398';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//input file(s)
	move_to_using 			:= Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed','using');	
	mt_all       				:= Prof_License_Mari.file_MTS0398;
	oRE									:= OUTPUT(mt_all);
	
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	ValidFile	:= mt_all(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(first_name))
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(last_name))
									 AND lic != ' '
									 AND slnum != 'LICENSE NUMBER');
									 							
	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA )(.*)';

  //Suffix Name Pattern
	Sufx_Pattern      := '( SR.| SR| JR.| JR| III| II| IV| VII| VI)';
	
	maribase_plus_dbas := RECORD,MAXLENGTH(5200)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	test_file := CHOOSEN(ValidFile,10000);

	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_MTS0398 pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.slnum);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE	 	:= src_st;

		// initialize raw_license_type from raw data
		tempRawType  					:= ut.CleanSpacesAndUpper(pInput.lic);
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																				
		// map raw license type to standard license type before profcode translations
		tempStdLicType        :=MAP(tempRawType = 'BROKER (BRO)' => 'BRO',
																 tempRawType = 'PROPERTY MANAGER (RPM)' => 'RPM',
																 tempRawType = 'SALESPERSON (RBS)' => 'RBS',
																 tempRawType = 'TIMESHARE SALESPERSON (TSS)' => 'TSS',
																 tempRawType = 'CE COURSE (CEC)'=> 'CEC',
																 tempRawType = 'CE INSTRUCTOR (CEI)'=> 'CEI',
																 '');
		SELF.STD_LICENSE_TYPE := tempStdLicType;
				
		// assigning dates per business rules
		SELF.EXPIRE_DTE		   	:= IF(pInput.expdt=' ','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.expdt));
		SELF.ORIG_ISSUE_DTE  	:= IF(pInput.issuedt=' ','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.issuedt));
		SELF.CURR_ISSUE_DTE  	:= '17530101';
				
		//initialize raw_license_status from raw data
		tempRawStatus 				:= ut.CleanSpacesAndUpper(pInput.licstat);
		SELF.RAW_LICENSE_STATUS :=MAP(tempRawStatus='TERMINATED' => 'TERMINATED LICENSE',
																	 tempRawStatus='EXPIRED' 		=> 'EXPIRED LICENSE',
		                               tempRawStatus);
				
		// assigning type code based on license type
		tempTypeCd		  			:= IF(tempStdLicType IN ['RPM','BRO','RBS','TSS','CEI'],'MD',
		                            IF(tempStdLicType IN ['CEC'],'GR',''));
		SELF.TYPE_CD      		:= tempTypeCd;
																			
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		trimFname        			:= ut.CleanSpacesAndUpper(pInput.First_name);
		tempFName  			      := IF(REGEXFIND(Sufx_Pattern,trimFName),REGEXREPLACE(Sufx_Pattern,trimFName,''),trimFName);
		trimMname        			:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		tempMName  			      := IF(REGEXFIND(Sufx_Pattern,trimMName),REGEXREPLACE(Sufx_Pattern,trimMName,''),trimMName);
		trimLname        			:= ut.CleanSpacesAndUpper(pInput.Last_name);
		tempLName  			      := IF(REGEXFIND(Sufx_Pattern,trimLName),REGEXREPLACE(Sufx_Pattern,trimLName,''),trimLName);
		tempName         			:= tempFname+' '+tempMname+' '+tempLname;
		trimSufxName          := ut.CleanSpacesAndUpper(pInput.NAME_SUFX);
		tmpSufxName				  	:=MAP(trimSufxName <> '' => trimSufxName,
		                             REGEXFIND(Sufx_Pattern,trimMName) => REGEXFIND(Sufx_Pattern,trimMName,0),
		                             REGEXFIND(Sufx_Pattern,trimFName) => REGEXFIND(Sufx_Pattern,trimFName,0),
																 REGEXFIND(Sufx_Pattern,trimLName) => REGEXFIND(Sufx_Pattern,trimLName,0),
																 '');		
		
		//Use office name as the org name if it is available
		tempTrimOfficeName		:= ut.CleanSpacesAndUpper(pInput.OFFICENAME);
		tempTrimName					:= IF(tempTrimOfficeName<>' ',tempTrimOfficeName,tempName);
		tempTrimNameFix6			:= Prof_License_Mari.mod_clean_name_addr.cleanDbaName(tempTrimName);
		TrimNAME_ORG		 			:= IF(REGEXFIND(DBApattern,tempTrimNameFix6) = TRUE,
																 Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix6),
																 tempTrimNameFix6);
	
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     		:= tempTypeCd;
		mariParse         		:=MAP(TRIM(TrimNAME_ORG,LEFT,RIGHT)='MICHAEL R GLASSCOCK' => 'MD',
																 TRIM(TrimNAME_ORG,LEFT,RIGHT)='KATHY CHURCH' => 'MD',
																 TRIM(TrimNAME_ORG,LEFT,RIGHT)='D MARINE MCKINNEY' => 'MD',
																 TRIM(TrimNAME_ORG,LEFT,RIGHT)='KATHLEEN ELIZABETH SOUTHERN' => 'MD',
																 tempTrimOfficeName<>' ' => 'GR',    //if business name is provided, it is GR.
																 prof_license_mari.func_is_company(TrimNAME_ORG) = TRUE => 'GR',
																 prof_license_mari.func_is_company(TrimNAME_ORG) = FALSE => 'MD',
																 tempMariParse);
		prepNAME_ORG					:=MAP(StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
																 trimNAME_ORG);
																 
	
		//Removing NickName from Corporate NAME field
		tempNick							:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'strip_nick');
		
		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		StdNAME_ORG						:= IF(rmvQuoteORG != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
			
		// use the right parser for name field
		CleanNAME_ORG					:=MAP(REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 tempTypeCd = 'MD' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 StdNAME_ORG);
	
		ParsedFirstName				:= IF(mariParse='MD',
															  IF(LENGTH(TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT))=0,
																   trimFname,
		                               TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT)),
																' ');
		ParsedMidName					:= IF(mariParse='MD',
		                            IF(LENGTH(TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT))<2,
																   trimMname,
		                               TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT)),
																' ');
		ParsedLastName				:= IF(mariParse='MD',
		                            IF(LENGTH(TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT))<2,
																   trimLname,
																   TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT)),
																' ');
		Suffix	  						:= IF(mariParse='MD',stringlib.stringcleanspaces(tmpSufxName),' ');
		ClnLastName						:= IF(NOT REGEXFIND('[ ]+',ParsedLastName),ParsedLastName,
																IF((ParsedLastName+' '+Suffix)=trimLname,ParsedLastName,   //Like Van Dyke
																   REGEXFIND('(.*) (.*)', ParsedLastName, 2)));
		ClnMidName						:= IF(NOT REGEXFIND('[ ]+',ParsedLastName),ParsedMidName,
																IF((ParsedLastName+' '+Suffix)=trimLname,ParsedMidName,   //Like Van Dyke
																   ParsedMidName + ' ' + REGEXFIND('(.*) (.*)', ParsedLastName, 1)));
		FirstName							:= ParsedFirstName;
		MidName								:= TRIM(ClnMidName,LEFT,RIGHT);
		LastName							:= TRIM(ClnLastName,LEFT,RIGHT);
		FullName							:= IF(tempTypeCd = 'MD' AND FirstName = ' ',
																Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick),
																StringLib.StringCleanSpaces(LastName+' '+FirstName));

		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
		SELF.NAME_ORG 				:=MAP(mariParse='MD' => FullName, 
									               StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 AND SELF.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																 CleanNAME_ORG);	
		// Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
		
	 // Parsed out ORG_NAME Suffix
		SELF.NAME_ORG_SUFX		:=MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
																 NOT REGEXFIND('LLP',StdNAME_ORG) AND REGEXFIND('(LP)$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
																 REGEXFIND('(L[.]P[.])$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																 Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
														
		tempNAME_PREFX     		:= IF(mariParse='MD',TRIM(CleanNAME_ORG[1..5],LEFT,RIGHT),'');
		tempNAME_FIRST				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT),'');
		tempNAME_MID			  	:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT),'');
		tempNAME_LAST			  	:= IF(mariParse='MD',TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT),'');
		tempNAME_SUFX			  	:= IF(mariParse='MD',TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT),'');
		tempNAME_NICK			  	:=MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
																 StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
															   tempNick);
		tempNAME_FIRST1     	:= IF(tempNAME_FIRST = '' AND tempNAME_LAST = 'MAC FRASER','MAC',tempNAME_FIRST);
		tempNAME_LAST1      	:= IF(tempNAME_FIRST1 = 'MAC' AND tempNAME_LAST = 'MAC FRASER','FRASER',tempNAME_LAST);
		isMultiLastName     	:= IF(stringlib.stringfind(TRIM(pInput.last_name,LEFT,RIGHT),' ',1)!=0,'true','false');
		tempNAME_FIRST2     	:= IF(isMultiLastName = 'true' AND TRIM(tempNAME_FIRST1,LEFT,RIGHT) != trimFname,trimFname,tempNAME_FIRST1);
		tempNAME_LAST2      	:= IF(isMultiLastName = 'true' AND TRIM(tempNAME_LAST1,LEFT,RIGHT) != trimLname,trimLname,tempNAME_LAST1);
		tempNAME_MID1       	:= IF(isMultiLastName = 'true', '', tempNAME_MID);
		
		SELF.NAME_FIRST 			:= FirstName;
		SELF.NAME_MID   			:= MidName;
		SELF.NAME_LAST  			:= LastName;
		SELF.NAME_NICK  			:= tempNAME_NICK;			
		SELF.NAME_SUFX  			:= Suffix;		

		comp_names 						:= '(REMAX|RE/MAX|USA 4%|REAL EST|ASSOC|AGCY|RESOURCE|CENTURY 21|'+
		                         'CENT 21|BROKERS|REALTY|COMPANY|OFFICE|REAL ESTATE| INC| CO$| LLC$| CONSULTING$|'+
														 'PROPERTY MANAGEMENT|COLDWELL BANKER|^CB WESTERN STATES|HIGH ST PROPERTIES|'+
														 '^FIVE STAR RENTALS|^ERA-SUPER STAR$| INT\'L$|^MR 4 U$| REAL ESTATE CORPORATION|'+
														 'ROBERT STOLZENBACH BROKER| SKY PROPERTES$| STATE ACQUISITIONS$)';

		//Use address cleaner to clean address
		CoPattern								:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
															 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
															 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
															 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
															 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
															 ')';
		RemovePattern						:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
															 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
															 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
															 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
															 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
															 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
															 '^.* BUILDING$|^.* LAKE RESORT$|GVA KIDDER MATHEWS|SALI ARMSTRONG|GILT EDGE|^KM$' +
															 ')';
		
		trimAddress1          := ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
   	trimAddress2          := ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
   	trimAddress3          := ut.CleanSpacesAndUpper(pInput.ADDRESS3_1);
  		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(pInput.ADDRESS1_1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(pInput.ADDRESS2_1, CoPattern);
		tmpNameContact3				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(pInput.ADDRESS3_1, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(pInput.ADDRESS1_1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(pInput.ADDRESS2_1, RemovePattern);
		clnAddress3						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(pInput.ADDRESS3_1, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2+' '+clnAddress3); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.CITY_1+' '+pInput.STATE_1 +' '+pInput.ZIP); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(pInput.CITY_1));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE_1));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_CNTRY_1 		:= ut.CleanSpacesAndUpper(pInput.country_1);
		SELF.OOC_IND_1				:= IF(TRIM(SELF.ADDR_CNTRY_1)<>'' AND TRIM(SELF.ADDR_CNTRY_1)<>'UNITED STATES',1,0);
		
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  	:= IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY_1 + pInput.STATE_1 + pInput.ZIP,LEFT,RIGHT) != '','B','');

		//assign officename
		tempNameOff         	:=MAP(tmpNameContact1='1A CLONINGER' => ' ',   //This should be an address, not a company.
																 tempTypeCd = 'MD' AND 
		                             (NOT prof_license_mari.func_is_address(tmpNameContact1)
															    OR REGEXFIND(comp_names,tmpNameContact1)) =>
															      tmpNameContact1,
															   '');
		trimNAME_OFFICE     	:= tempNameOff;

		// office parse
		tempOffParse1 				:= IF(REGEXFIND(comp_names,trimNAME_OFFICE) = TRUE,'GR','');
		tempOffParse      		:=MAP(tempOffParse1 = '' AND prof_license_mari.func_is_company(trimNAME_OFFICE)= TRUE AND trimNAME_OFFICE != ' '=> 'GR',
																 tempOffParse1 = '' AND prof_license_mari.func_is_company(trimNAME_OFFICE)= FALSE AND trimNAME_OFFICE != ' ' => 'MD',
																 tempOffParse1);
		SELF.OFFICE_PARSE 		:= tempOffParse;
		
		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG		:= tempTrimName;
		SELF.NAME_FORMAT			:= 'F';
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG 		:= StdNAME_ORG; 
		
		// Business rules to standardize DBA(s) for splitting into multiple records

		// Populate if DBA exist in ORG_NAME field
		//DBA can be in org name or office name. In this dataset, they are in the office name (address_1)
		tempDBA								:=MAP(REGEXFIND(DBApattern,tempTrimNameFix6) => prof_license_mari.mod_clean_name_addr.getDBAname(tempTrimNameFix6),
																 REGEXFIND(DBApattern,trimNAME_OFFICE) => prof_license_mari.mod_clean_name_addr.getDBAname(trimNAME_OFFICE),
																 ' ');													 
		trimDBA       				:= ut.CleanSpacesAndUpper(tempDBA);
		trimDBA2      				:= IF(trimDBA = tempTrimNameFix6,'',trimDBA);
		trimFix       				:= stringlib.stringfindreplace(trimDBA2,'RE/MAX','REMAX');
		tempDBA1      				:= IF(trimDBA=TrimNAME_ORG,'',trimFix);
		tempDBA2      				:= stringlib.stringfindreplace(tempDBA1,';','/');
		tempDBA3      				:= stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
		tempDBA4      				:= IF(stringlib.stringfind(tempDBA3,'BURRES AND ASSOCIATES',1)=0
																AND stringlib.stringfind(tempDBA3,'AND LOAN',1)=0,
																stringlib.stringfindreplace(tempDBA3,' AND ','/'),
																tempDBA3);
												
		StripDBA      				:= stringlib.stringfindreplace(tempDBA4,'CORPORATION','CORP');
		sepSpot       				:= stringlib.stringfind(StripDBA,'/',1);
		SELF.dba							:= StripDBA[1..stringlib.stringfind(StripDBA,'/',1)-1];
		SELF.dba_flag 				:= IF(StripDBA != ' ', 1, 0);
		temp_dba1							:=MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
																 StripDBA);
																						
		SELF.dba1 						:= temp_dba1;

		SELF.dba2							:=MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
																		 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
																 ' ');
					
		SELF.dba3 						:=MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
																 StringLib.stringfind(StripDBA,'/',2) > 0 =>
																	REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																 '');
		
		SELF.dba4 						:=MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																	REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
																 StringLib.stringfind(StripDBA,'/',3) > 0 =>
																	REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																 '');
		
		SELF.dba5 						:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
																REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');						   
		
		//If DBA name is extracted from the office name, remove it.
		SELF.NAME_OFFICE    	:= IF(tempDBA<>' ' AND REGEXFIND(tempDBA,trimNAME_OFFICE),
																prof_license_mari.mod_clean_name_addr.GetCorpName(trimNAME_OFFICE),
																trimNAME_OFFICE);

		 // fields used to create mltreckey key are:
			// license number
			// license type
			// source update
			// name
			// address_1
			// dba
			// officename
		 
		mltreckeyHash 				:= hash64(TRIM(tempLicNum,LEFT,RIGHT) 
																	 +TRIM(tempStdLicType,LEFT,RIGHT)
																	 +TRIM(src_cd,LEFT,RIGHT)
																	 +ut.CleanSpacesAndUpper(StdName_Org)
																	 +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
																	 +ut.CleanSpacesAndUpper(StripDBA)
																	 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
																	 ); 
		
		SELF.mltreckey 				:= IF(temp_dba1 != ' ',mltreckeyHash, 0);
		
		 // fields used to create unique key are:
			// license number
			// license type
			// source update
			// name
			// address
		 
		SELF.cmc_slpk   			:= hash64(TRIM(tempLicNum,LEFT,RIGHT) 
																 +TRIM(tempStdLicType,LEFT,RIGHT)
																 +TRIM(src_cd,LEFT,RIGHT)
																 +TRIM(SELF.NAME_ORG_ORIG)
																 +TRIM(pInput.ADDRESS1_1)
																 +TRIM(pInput.ADDRESS2_1)
																 +TRIM(pInput.ZIP)
																 );
									 

		SELF 									:= [];		   		   
	END;


	ds_map := PROJECT(ValidFile, transformToCommon(LEFT));
	//remove dup records and keep the one with greatest expiration date
	ds_map_sorted	:= SORT(DISTRIBUTE(ds_map,HASH(cmc_slpk,name_org)),cmc_slpk,-EXPIRE_DTE,LOCAL);
	ds_map_deduped := DEDUP(ds_map_sorted,cmc_slpk);
	
	// Clean-up Fields
	maribase_plus_dbas	transformClean(ds_map_deduped pInput) := TRANSFORM

			SELF.ADDR_ADDR1_1		:=MAP(StringLib.stringfind(pInput.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '#'),	
																																						 pInput.ADDR_ADDR1_1);
			SELF.ADDR_ADDR2_1		:=MAP(StringLib.stringfind(pInput.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '#'),	
																																						 pInput.ADDR_ADDR2_1);
			
			SELF.ADDR_ADDR3_1		:=MAP(StringLib.stringfind(pInput.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '#'),	
																																						 pInput.ADDR_ADDR3_1);
			
			SELF := pInput;
	END;
	ds_map_clean := PROJECT(ds_map_deduped, transformClean(LEFT));	

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map_clean L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
				
	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5300)
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
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
			SELF.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
			TrimDBASufx			:=MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		SELF.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		SELF.NAME_MARI_DBA	:=MAP(L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
									 L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(L.TMP_DBA,LEFT,RIGHT),
									 L.type_cd = 'MD' => TRIM(L.TMP_DBA,LEFT,RIGHT), ''); 
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
									 ((TRIM(LEFT.off_license_nbr,LEFT,RIGHT)[1..10]) = (TRIM(RIGHT.off_license_nbr,LEFT,RIGHT)[1..10]))
										AND LEFT.AFFIL_TYPE_CD in ['IN', 'BR'],
										 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 :=MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	//Adding to Superfile

	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
			
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');	

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;	