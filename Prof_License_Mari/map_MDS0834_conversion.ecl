// MDS0834 / Maryland Commission of Real Estate App & Home Insp / Real Estate Appraisers //
#workunit('name','map_MDS0834_conversion'); 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_MDS0834_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MDS0834';
	src_cd							:= 'S0834';
	src_st							:= 'MD';	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA )(.*)';

	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	cmv := OUTPUT(ds_Cmvtranslation);
	
	apr									:= Prof_License_Mari.files_MDS0834;
	oApr								:= OUTPUT(apr);
	
	//Remove bad records before processing
	//There is a record Stacie Testman which will be identified as bad name, but is is a valid record.
	ValidFile						:= apr(StringLib.StringToUpperCase(TRIM(first_name,LEFT,RIGHT)+' '+TRIM(last_name,LEFT,RIGHT))='STACIE TESTERMAN' OR
														 (TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) + TRIM(name_full,LEFT,RIGHT) != ' '
															AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME))));

	maribase_plus_dbas := RECORD,MAXLENGTH(5000)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(ValidFile pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	 := pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD	:= src_cd;

		// assigning type code based on license type
		tempTypeCd		  			    := 'MD';
		SELF.TYPE_CD       		:= tempTypeCd;

		//Populate license number
		tempLicNum          	:= ut.CleanSpacesAndUpper(pInput.slnum);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE	 	:= src_st;

		// initialize raw_license_type from raw data
		tempRawType  					    := ut.CleanSpacesAndUpper(pInput.lic_type);												 
		SELF.RAW_LICENSE_TYPE := IF(LENGTH(tempRawType) = 1,'0'+tempRawType,tempRawType);
																	 													          
		//Standardize license type by removing leading 0
		tempStdLicType       	:= IF(LENGTH(tempRawType) = 1,tempRawType, REGEXFIND('^(0){1}([1-9]){1}$', tempRawType, 2));												 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
		
		// assigning dates per business rules fmt_dateMMDDYYYY/*fmt_dateMMDDYYYY*/
		//Need to support date format mm/dd/yy and yyyy-mm-dd		
		tempExpdt							:= MAP(REGEXFIND('/',pInput.EXPDT) =>
																			Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(TRIM(pInput.EXPDT,LEFT,RIGHT)),
																 REGEXFIND('-',pInput.EXPDT) =>
																			REGEXREPLACE('-',TRIM(pInput.EXPDT,LEFT,RIGHT),''),
																 '17530101');			
		SELF.EXPIRE_DTE		   	:= tempExpdt;

		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.CURR_ISSUE_DTE		:= '17530101';
			
		//Derive raw_license_status from raw data
		STRING8 current_date	:=(STRING8)Lib_StringLib.StringLib.GetDateYYYYMMDD();
		tempRawStatus 				:= MAP(tempExpdt >= current_date => 'A',
																 tempExpdt < current_date => 'I',
																 '');
		SELF.RAW_LICENSE_STATUS := tempRawStatus;
		SELF.STD_LICENSE_STATUS := tempRawStatus;
	
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		tempTrimName					:= IF(ut.CleanSpacesAndUpper(pInput.first_name + pInput.last_name) <> '', 
		                            ut.CleanSpacesAndUpper(pInput.first_name) + ' ' + ut.CleanSpacesAndUpper(pInput.last_name),
																ut.CleanSpacesAndUpper(pInput.name_full));
														 
		tempTrimNameFix  			:= IF(tempTrimName[1..3]= 'C/O', TRIM(tempTrimName[4..],LEFT,RIGHT),tempTrimName);  //remove leading c/o
		tempTrimNameFix2 			:= IF(tempTrimNameFix[1..4]= 'DBA ', TRIM(tempTrimNameFix[5..],LEFT,RIGHT),tempTrimNameFix); //remove leading dba
		tempTrimNameFix3 			:= stringlib.stringfindreplace(tempTrimNameFix2,'/DBA ',' DBA ');
		tempTrimNameFix4 			:= stringlib.stringfindreplace(tempTrimNameFix3,' D B A ',' DBA ');
		tempTrimNameFix5 			:= stringlib.stringfindreplace(tempTrimNameFix4,'RE/GROUP ','RE GROUP ');
		tempTrimNameFix6 			:= stringlib.stringcleanspaces(tempTrimNameFix5);
		TrimNAME_ORG		 			:= IF(REGEXFIND(DBApattern,tempTrimNameFix6) = TRUE,
																 Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix6),
																 tempTrimNameFix6);
														 
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     		:= tempTypeCd;
		mariParse        			:= MAP(prof_license_mari.func_is_company(TrimNAME_ORG) = TRUE => 'GR',
																 prof_license_mari.func_is_company(TrimNAME_ORG) = FALSE => 'MD',
																 tempMariParse);
			
		prepNAME_ORG					:= trimNAME_ORG;									   
		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(prepNAME_ORG,'"',''));
		StdNAME_ORG						:= IF(rmvQuoteORG != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																rmvQuoteORG, 
																Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
		
		//The CleanName is constructed from First and Last names. Use cleanFMLName to parse the string for MD or cleanFName for GR
		CleanNAME_ORG					:= IF(mariParse='GR',
																Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG));
			
		SELF.NAME_FIRST				:= IF(mariParse='MD',
																IF(TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT)<>' ',
																	 TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT),
																	 TRIM(pInput.first_name,LEFT,RIGHT)),
																'');
		SELF.NAME_MID					:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT),'');
		SELF.NAME_LAST				:= IF(mariParse='MD',
																IF(TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT)<>' ',
																	 TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT),
																	 TRIM(pInput.last_name,LEFT,RIGHT)),
																'');
		SELF.NAME_SUFX				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT),'');
	
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);																				
		SELF.NAME_ORG 				:= IF(mariParse='MD',
		                            stringlib.stringcleanspaces(SELF.NAME_LAST + ' ' + SELF.NAME_FIRST),
																CleanNAME_ORG);
		SELF.NAME_ORG_ORIG		:= tempTrimName;			//first name + ' ' + last name
		SELF.NAME_FORMAT			:= 'F';
		
		// Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
			
		// Parsed out ORG_NAME Suffix
		SELF.NAME_ORG_SUFX		:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
																 NOT REGEXFIND('LLP',StdNAME_ORG) AND REGEXFIND('(LP)$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
																 REGEXFIND('(L[.]P[.])$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																											Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
																
	
		//Determine if office name is in address
		IsAddr								:= prof_license_mari.func_is_address_v2(pInput.ADDRESS1_1);		
		IsComp								:= prof_license_mari.func_is_company(pInput.ADDRESS1_1) AND		//Determine if office name is in address
														 NOT REGEXFIND('^([0-9]+ )', TRIM(pInput.ADDRESS1_1));
		// assign officename
		tempNameOff          	:= IF(NOT IsAddr AND  IsComp,			//if address1_1 is not and address and is a company name
															  ut.CleanSpacesAndUpper(pInput.ADDRESS1_1),
															  ' ');
		SELF.NAME_OFFICE    	:= IF(REGEXFIND('^C/O ',tempNameOff),
		                            REGEXREPLACE('^C/O ',tempNameOff,''),
																tempNameOff);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE<>' ','GR', ' ');
			
    // office address fields
		//Use address cleaner to clean address
		tmpZip	              := MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
		                             LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
		
		trimAddress1          := ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
	  trimAddress2          := ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.CITY_1+' '+pInput.STATE_1 +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		FOREIGN_COUNTRY				:= 'ISRAEL';
		SELF.OOC_IND_1				:= IF(REGEXFIND(FOREIGN_COUNTRY, temp_preaddr1), 1, 0);

	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(SELF.OOC_IND_1=1,
		                            clnAddress1,
																IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																   StringLib.StringCleanSpaces(tmpADDR_ADDR1_1)));	
		SELF.ADDR_ADDR2_1			:= MAP(SELF.OOC_IND_1=1 AND trimAddress2 = 'REHOVOT 7625640, ISRAEL' => '',
		                             SELF.OOC_IND_1=1 AND trimAddress2 != 'REHOVOT 7625640, ISRAEL' => clnAddress2,
																 AddrWithContact != '' => '',
																 StringLib.StringCleanSpaces(tmpADDR_ADDR2_1));
																 
		SELF.ADDR_CITY_1		  := MAP(SELF.OOC_IND_1=1 AND trimAddress2 = 'REHOVOT 7625640, ISRAEL' => 'REHOVOT',
		                             SELF.OOC_IND_1=1 AND trimAddress2 != 'REHOVOT 7625640, ISRAEL' => ut.CleanSpacesAndUpper(pInput.CITY_1),
																 TRIM(clnAddrAddr1[65..89])<>'' => TRIM(clnAddrAddr1[65..89]),
																 ut.CleanSpacesAndUpper(pInput.CITY_1));
																
		SELF.ADDR_STATE_1		  := IF(SELF.OOC_IND_1=1,
		                            ut.CleanSpacesAndUpper(pInput.STATE_1),
																IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE_1)));
		prepADDR_ZIP5_1 		  := IF(SELF.OOC_IND_1=1,
		                            ut.CleanSpacesAndUpper(pInput.ZIP),
																IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]));
		SELF.ADDR_ZIP5_1		  := IF(prepADDR_ZIP5_1 = '0','',prepADDR_ZIP5_1);									
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

	  SELF.ADDR_CNTRY_1     := IF(SELF.OOC_IND_1=1 AND trimAddress2 = 'REHOVOT 7625640, ISRAEL','ISREAL','');	 
			
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  := IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY_1 + pInput.STATE_1 + pInput.ZIP,LEFT,RIGHT) != '','B','');
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG := IF(tempTypeCd='GR',	StdNAME_ORG,tempNameOff); 
			
		  // Business rules to standardize DBA(s) for splitting into multiple records
		  // Populate if DBA exist in ORG_NAME field
			tempDBA       := Prof_License_Mari.mod_clean_name_addr.getDbaName(pInput.LAST_name);
			trimDBA       := ut.CleanSpacesAndUpper(tempDBA);
			trimFix       := stringlib.stringfindreplace(trimDBA,'RE/MAX','REMAX');
			tempDBA1      := IF(trimDBA=TrimNAME_ORG,'',trimFix);
			tempDBA2      := stringlib.stringfindreplace(tempDBA1,';','/');
			tempDBA3      := stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
			tempDBA4      := IF(stringlib.stringfind(tempDBA3,'BURRES AND ASSOCIATES',1)=0
			                    AND stringlib.stringfind(tempDBA3,'AND LOAN',1)=0,
													stringlib.stringfindreplace(tempDBA3,' AND ','/'),
												  tempDBA3);

			// added 20150415 update
			SELF.EMAIL  	:= ut.CleanSpacesAndUpper(pInput.EMAIL);
													
			StripDBA      := stringlib.stringfindreplace(tempDBA4,'CORPORATION','CORP');
			sepSpot       := stringlib.stringfind(StripDBA,'/',1);
			SELF.dba			:= StripDBA[1..stringlib.stringfind(StripDBA,'/',1)-1];
			SELF.dba_flag := IF(StripDBA != ' ', 1, 0);
		  temp_dba1			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
									   StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
										 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									   StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									   StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
									   StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
									   		   										StripDBA);
																							
			SELF.dba1 := temp_dba1;

			SELF.dba2			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
									    StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
							        StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
									    StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
									   									   		   ' ');
			 			
			SELF.dba3 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									    StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									    StringLib.stringfind(StripDBA,'/',2) > 0 =>
										  REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																	            	'');
			
			SELF.dba4 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									    StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									    StringLib.stringfind(StripDBA,'/',3) > 0 =>
										  REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																		             '');
			
			SELF.dba5 			:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
									  	REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');						   
			
		   //fields used to create mltreckey key are:
		   // license number
			 // license type
			 //  source update
			 // name
			 // address_1
			 // dba
			 // officename
			//Change the hash function from hash32 to hash64 to avoid dup keys 2/28/13 Cathy Tio
			mltreckeyHash := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
		                           +TRIM(tempStdLicType,LEFT,RIGHT)
										           +TRIM(src_cd,LEFT,RIGHT)
				                       +ut.CleanSpacesAndUpper(StdName_Org)
										           +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
															 +ut.CleanSpacesAndUpper(StripDBA)
															 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)); 
			
			SELF.mltreckey := IF(temp_dba1 != ' ',mltreckeyHash, 0);
			
			// fields used to create unique key are:
			// license number
			// license type
			// source update
			// name
			// address
			 
			SELF.cmc_slpk         := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
		                           +TRIM(tempStdLicType,LEFT,RIGHT)
										           +TRIM(src_cd,LEFT,RIGHT)
				                       +ut.CleanSpacesAndUpper(StdName_Org)
										           +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
															 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
															 +TRIM(pInput.ZIP)
															 );
										 

			SELF := [];		   		   
	END;

	ds_map := PROJECT(ValidFile, transformToCommon(LEFT));

	// Clean-up Fields
	maribase_plus_dbas	transformClean(ds_map pInput) 
			:= 
			 TRANSFORM
			SELF.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '#'),	
																																						 pInput.ADDR_ADDR1_1);
			SELF.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '#'),	
																																						 pInput.ADDR_ADDR2_1);
			
			SELF.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '#'),	
																																						 pInput.ADDR_ADDR3_1);
			
			SELF := pInput;
	END;
	ds_map_clean := PROJECT(ds_map, transformClean(LEFT));
							   
	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_clean L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_clean, ds_Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
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
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
			SELF.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
			TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			    := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		SELF.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		SELF.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
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
									 TRIM(LEFT.name_office,LEFT,RIGHT)	= TRIM(RIGHT.name_org_orig,LEFT,RIGHT)
									 AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
										assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(OutRecs,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
		
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'file','using', 'used')
														);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes   := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(cmv, oApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;