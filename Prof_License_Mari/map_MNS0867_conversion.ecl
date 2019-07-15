// MNS0867 / Minnesotas Bookstore /	Real Estate Appraisers raw data to common layout for MARI and PL use
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_MNS0867_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MNS0867';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA )(.*)';

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd); 
  O_Cmvtranslation  := OUTPUT(ds_Cmvtranslation);
	//input file(s)
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');		 
	apr_all       := Prof_License_Mari.file_MNS0867;
	oApr					:= OUTPUT(apr_all);
	ut.CleanFields(apr_all, cln_apr_all);
	
	//Remove bad records before processing
	ValidFile	:= cln_apr_all(TRIM(lname,LEFT,RIGHT)+TRIM(fname,LEFT,RIGHT) != ' '
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(lname))
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(fname))
									 AND ut.CleanSpacesAndUpper(licnum) != 'LICENSENUMBER');                 

	maribase_plus_dbas := RECORD,MAXLENGTH(5000)
		Prof_License_Mari.layout_base_in;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_MNS0867 pInput) := TRANSFORM
	
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

		tempLicNum           := ut.CleanSpacesAndUpper(pInput.licnum);
		SELF.LICENSE_NBR	   := tempLicNum;
		SELF.LICENSE_STATE	 := src_st;
			
		// initialize raw_license_type from raw data
		lictype := ut.CleanSpacesAndUpper(pInput.lictype);
		limit1  := ut.CleanSpacesAndUpper(pInput.limit1);
		limit1a := IF(limit1 = 'N','',limit1);
		limit2  := ut.CleanSpacesAndUpper(pInput.limit2);
		limit2a := MAP(limit2 = 'N' => '',
										limit2 = 'Y' => '2',
										limit2);
		limit3  := ut.CleanSpacesAndUpper(pInput.limit3);
		limit3a := MAP(limit3 = 'N' => '',
										limit3 = 'Y' => '3',
										limit3);
		limit4  := ut.CleanSpacesAndUpper(pInput.limit4);
		limit4a := MAP(limit4 = 'N' => '',
										limit4 = 'Y' => '4',
										limit4);	
		limit5  := ut.CleanSpacesAndUpper(pInput.limit5);
		limit5a := MAP(limit5 = 'N' => '',
										limit5 = 'Y' => '4',
										limit5);				
 // License Types 															
 // AP1  => REGISTERED REAL PROPERTY APPRAISER
 // AP2  => LICENSED REAL PROPERTY APPRAISER
 // AP3  => CERTIFIED RESIDENTIAL PROPERTY APPRAISER
 // AP4  => CERTIFIED GENERAL PROPERTY APPRAISER
 // AP14 => RESIDENT APPRAISER
 // AP24 => LICENSED RESIDENTIAL NON-RESIDENT APPRAISER
 // AP34 => CERTIFIED RESIDENTIAL RESIDENT APPRAISER
 // AP44 => CERTIFIED GENERAL RESIDENT APPRAISER
 // AP15 => RESIDENT APPRAISER TRAINEE
 // AP25 => LICENSED RESIDENTIAL RESIDENT APPRAISER
 // AP35 => CERTIFIED RESIDENTIAL RESIDENT APPRAISER
 // AP45 => CERTIFIED GENERAL NON-RESIDENT APPRAISER						
		tempRawType  := IF(lictype != '', lictype+limit1a+limit2a+limit3a+limit4a+limit5a,'');											 
		SELF.RAW_LICENSE_TYPE := ut.CleanSpacesAndUpper(tempRawType);
																																		
		// map raw license type to standard license type before profcode translations
		tempStdLicType        := tempRawType;																 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
			
		// assigning dates per business rules
		trimExpDt            := ut.CleanSpacesAndUpper(pInput.expdate);
		SELF.EXPIRE_DTE		   := trimExpDt;
		trimIssueDt          := ut.CleanSpacesAndUpper(pInput.issuedt);
		SELF.ORIG_ISSUE_DTE  := trimIssueDt;
		trimCurIssueDt       := ut.CleanSpacesAndUpper(pInput.curissuedt);
		SELF.CURR_ISSUE_DTE  := trimCurIssueDt;
			
		// phone
		TrimPhone             := StringLib.StringFilter(pInput.telephone,'0123456789');
		SELF.PHN_MARI_1				:= IF(TrimPhone = '0000000000','',ut.CleanPhone(TrimPhone));				//the phone number before running through our clean process
		SELF.PHN_PHONE_1			:= IF(TrimPhone = '0000000000','',ut.CleanPhone(TrimPhone));	
				
		//initialize raw_license_status from raw data
		tempRawStatus 		:= ut.CleanSpacesAndUpper(pInput.licstat);			
		SELF.RAW_LICENSE_STATUS := tempRawStatus;
		
		// assigning type code based on license type
		tempTypeCd		  	:= 'MD';
		SELF.TYPE_CD      := tempTypeCd;
			                            
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		f_name 						:= ut.CleanSpacesAndUpper(pInput.fname);
		m_name 						:= ut.CleanSpacesAndUpper(pInput.mname);
		l_name 						:= ut.CleanSpacesAndUpper(pInput.lname);
		sufx   						:= ut.CleanSpacesAndUpper(pInput.jrsr);
		tempTrimName     	:= f_name+' '+m_name+' '+l_name+' '+sufx;
		tempTrimNameFix  	:= IF(tempTrimName[1..3]= 'C/O', TRIM(tempTrimName[4..],LEFT,RIGHT),tempTrimName);
		tempTrimNameFix2 	:= IF(tempTrimNameFix[1..4]= 'DBA ', TRIM(tempTrimNameFix[5..],LEFT,RIGHT),tempTrimNameFix);
		tempTrimNameFix3 	:= stringlib.stringfindreplace(tempTrimNameFix2,'/DBA ',' DBA ');
		tempTrimNameFix4 	:= stringlib.stringfindreplace(tempTrimNameFix3,' D B A ',' DBA ');
		tempTrimNameFix5 	:= stringlib.stringfindreplace(tempTrimNameFix4,'RE/GROUP ','RE GROUP ');
		tempTrimNameFix6 	:= stringlib.stringcleanspaces(tempTrimNameFix5);
		TrimNAME_ORG		 	:= IF(REGEXFIND(DBApattern,tempTrimNameFix6) = TRUE,
													 Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix6),
													 tempTrimNameFix6);
														 
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     := tempTypeCd;
		mariParse         := MAP(prof_license_mari.func_is_company(TrimNAME_ORG) = TRUE => 'GR',
														 prof_license_mari.func_is_company(TrimNAME_ORG) = FALSE => 'MD',
														 tempMariParse);
	
		prepNAME_ORG			:= MAP(StringLib.stringfind(TrimNAME_ORG,'D/B/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'D/B/',' '),
															StringLib.stringfind(TrimNAME_ORG,'T/A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T/A',' '),
															StringLib.stringfind(TrimNAME_ORG,'T\\A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T\\A',' '),
															StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
															StringLib.stringfind(TrimNAME_ORG,'\\',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'\\',' '),
															StringLib.stringfind(TrimNAME_ORG,'FLORIDA DEPARTMENT OF TRANSPORTATION (DO',1) >0 
																			=> stringlib.stringfindreplace(TrimNAME_ORG,'FLORIDA DEPARTMENT OF TRANSPORTATION (DO','FLORIDA DEPARTMENT OF TRANSPORTATION'),
																						trimNAME_ORG);
										 
		tempNick 							:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'nick');			
		removeNick						:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'strip_nick');
		
		rmvQuoteORG     	:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		StdNAME_ORG				:= IF(rmvQuoteORG != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
														rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
	
		// use the right parser for name field
		CleanNAME_ORG			:= MAP(REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
														 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
														 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
														 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
														 tempTypeCd = 'GR' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
														 tempTypeCd = 'GR' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
														 tempTypeCd = 'MD' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
														 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
														 StdNAME_ORG);
	
		SELF.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
		tmpLName						:= IF(LENGTH(TRIM(CleanNAME_ORG[46..65]))<2,l_name,TRIM(CleanNAME_ORG[46..65]));															
		tmpFName						:= IF(LENGTH(TRIM(CleanNAME_ORG[46..65]))<2,f_name,TRIM(CleanNAME_ORG[6..25]));															
		SELF.NAME_ORG 			:= MAP(mariParse='MD'=> stringlib.stringcleanspaces(tmpLName+' '+tmpFName),
															StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 AND SELF.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																								CleanNAME_ORG);
	// Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2					:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3					:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
		
	 // Parsed out ORG_NAME Suffix
		SELF.NAME_ORG_SUFX	:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
															 NOT REGEXFIND('LLP',StdNAME_ORG) AND REGEXFIND('(LP)$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
															 REGEXFIND('(L[.]P[.])$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
															 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																										Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
														
		SELF.NAME_FIRST				:= IF(mariParse='MD',tmpFName,'');
		SELF.NAME_MID					:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT),'');
		SELF.NAME_LAST				:= IF(mariParse='MD',tmpLName,'');
		SELF.NAME_SUFX				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT),'');
		SELF.NAME_NICK				:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
																StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
																tempNick);

		// office address fields
 		tempAdd1_1_1_pre      := ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		tempAdd1_1_1					:= IF(REGEXFIND('8009- ',tempAdd1_1_1_pre),REGEXREPLACE('8009- ',tempAdd1_1_1_pre,'8009 '),tempAdd1_1_1_pre);
   	tempAdd2_1_1          := ut.CleanSpacesAndUpper(pInput.ADDRESS2);
   		
   	tempAdd1_1_2          := IF(NOT Prof_License_Mari.func_is_address(tempAdd1_1_1) OR REGEXFIND(' INC$',tempAdd1_1_1) OR
   		                            REGEXFIND('^APPRAISERTECH ',tempAdd1_1_1) OR REGEXFIND('VANGEN STEVEN', tempAdd1_1_1),
   		                            tempAdd2_1_1,
   																tempAdd1_1_1);
  	tempAdd1_1_3          := MAP(tempAdd1_1_2 = '' AND tempAdd2_1_1 != '' => tempAdd2_1_1,
   																	 tempAdd1_1_2);
   		
  	tempAdd2_1_2          := IF(tempAdd1_1_3 = tempAdd2_1_1,'',tempAdd2_1_1);
  	tempZip3             	:= ut.CleanSpacesAndUpper(stringlib.stringfindreplace(pInput.ZIPCODE,'-',''));

		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* ASSOC|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|SVOR VALORA|MESSER BRIAN|LUDWIG ROBERT J|KIM NORD|' +
					 'EILERTSON MICHAEL|DORN STASIA|UNITED FCS|ST LOUIS COUNTY LAND DEPT|^RELS$|PTCO2  MN DEPT OF REVENUE|' +
					 '^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY|^.* CONSULTING$|^BPETERSON$|' +
					 'MN DEPT OF TRANSPORTATION|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|BAUSMAN BRIAN LEE|^ITASCA CO LAND DEPT$|^RELS VALUATION'+
					 ')';

		trimAddress1        	:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		trimAddress2        	:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
 		trimCity            	:= ut.CleanSpacesAndUpper(pInput.CITY);
		trimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		tmpZip	            	:= MAP(LENGTH(TRIM(pInput.ZIPCODE))=3 => '00'+TRIM(pInput.ZIPCODE),
																 LENGTH(TRIM(pInput.ZIPCODE))=4 => '0'+TRIM(pInput.ZIPCODE),
																 TRIM(pInput.ZIPCODE));
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);
		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trimCity+' '+trimState+' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trimState);
		SELF.ADDR_CNTY_1      := ut.CleanSpacesAndUpper(pInput.COUNTY);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_BUS_IND	    := IF(TRIM(pInput.ADDRESS1 + pInput.CITY + pInput.STATE + pInput.ZIPCODE,LEFT,RIGHT) != '','B','');
				
		//assign officename
		tempNameOff         := MAP(tempTypeCd = 'MD' AND NOT Prof_License_Mari.func_is_address(tempAdd1_1_1) => tempAdd1_1_1,
		                           tempTypeCd = 'MD' AND REGEXFIND('($ INC$)',tempAdd1_1_1) => tempAdd1_1_1,
		                           tempTypeCd = 'MD' AND REGEXFIND('($ INC$)',tempAdd2_1_1) => tempAdd2_1_1,
															 '');
																														 
		trimNAME_OFFICE     := IF(REGEXFIND('(.*) DBA$',tempNameOff),REGEXFIND('(.*) DBA$',tempNameOff,1),tempNameOff);
		SELF.NAME_OFFICE    := MAP(TRIM(trimNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST,ALL) => '',
                            	 TRIM(trimNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
                            	 TRIM(trimNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
		                           TRIM(trimNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_MID + SELF.NAME_FIRST,ALL) => '',
															 TRIM(trimNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST + SELF.NAME_MID,ALL) => '',
		                           TRIM(trimNAME_OFFICE,LEFT,RIGHT));
		
		//office parse
		tempOffParse      := MAP(prof_license_mari.func_is_company(SELF.NAME_OFFICE)= TRUE AND SELF.NAME_OFFICE != ' '=> 'GR',
														 prof_license_mari.func_is_company(SELF.NAME_OFFICE)= FALSE AND SELF.NAME_OFFICE != ' ' => 'MD',
														 '');
		SELF.OFFICE_PARSE := tempOffParse;

		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG	:= tempTrimName;
		SELF.NAME_FORMAT		:= 'F';
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG := IF(tempTypeCd='MD',trimNAME_OFFICE,StdNAME_ORG); 
		
		//Continue Education
		SELF.CONT_EDUCATION_REQ := pInput.CEHOURS;
		SELF.CONT_EDUCATION_TERM := pInput.CEDUEDATE;
		
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		tempDBA       := IF(tempNameOff != '', Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempNameOff), '');
		trimDBA       := ut.CleanSpacesAndUpper(tempDBA);
		trimDBA2      := IF(trimDBA = tempTrimName,'',trimDBA);
		trimFix       := stringlib.stringfindreplace(trimDBA2,'RE/MAX','REMAX');
		tempDBA1      := IF(trimDBA=TrimNAME_ORG,'',trimFix);
		tempDBA2      := stringlib.stringfindreplace(tempDBA1,';','/');
		tempDBA3      := stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
		tempDBA4      := IF(stringlib.stringfind(tempDBA3,'BURRES AND ASSOCIATES',1)=0
												AND stringlib.stringfind(tempDBA3,'AND LOAN',1)=0,
												stringlib.stringfindreplace(tempDBA3,' AND ','/'),
												tempDBA3);
												
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
																						
		SELF.dba1     := temp_dba1;
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
		
	
	
			 // fields used to create mltreckey key are:
			// license number
			// license type
			// source update
			// name
			// address_1
			// address_2

		//Use hash64 instead of hash32 to avoid dup key 2/28/13 Cathy Tio 
		mltreckeyHash := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS1)
														 +ut.CleanSpacesAndUpper(StripDBA)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS2)
														 +tempZip3
														 ); 
		
		SELF.mltreckey := IF(temp_dba1 != ' ',mltreckeyHash, 0);
		
		 // fields used to create unique key are:
			// license number
			// license type
			// source update
			// name
			// address
		 
		//Use hash64 instead of hash32 to avoid dup key 2/28/13 Cathy Tio 
		SELF.cmc_slpk         := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS1)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS2)
														 +tempZip3
														 );
									 
		SELF := [];		 
		
	END;

	//ds_map := PROJECT(prof_license_mari.file_MNS0867, transformToCommon(LEFT));
	ds_map := PROJECT(ValidFile, transformToCommon(LEFT));

	// Clean-up Fields
	maribase_plus_dbas	transformClean(ds_map pInput) := TRANSFORM
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
	ds_map_clean := PROJECT(ds_map , transformClean(LEFT));
							   

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map_clean L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_clean, ds_Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, ds_Cmvtranslation,
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
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := TRANSFORM
			SELF.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
			TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
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

	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
									 ((TRIM(LEFT.name_org,LEFT,RIGHT)[1..50] + TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT)[1..2])	= 
										 (TRIM(RIGHT.name_org,LEFT,RIGHT)[1..50] + TRIM(RIGHT.STD_LICENSE_TYPE,LEFT,RIGHT)[1..2]))
									 AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
										assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layout_base_in xTransProvnote(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransProvnote(LEFT));

	//Adding to Superfile
		
	d_final := OUTPUT(OutRecs,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
			

	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, O_Cmvtranslation, oApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;