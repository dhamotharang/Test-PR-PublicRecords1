//************************************************************************************************************* */	
//  The purpose of this development is take LA Appraisers License raw file and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//  The new appraiser file has the same format as the broker/salesperson layout. Use the code from map_LAS0832_conversion
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_LAS0833_conversion(STRING pVersion) := FUNCTION

	code 								:= 'LAS0833';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	ocmv 						:= OUTPUT(Cmvtranslation);
	
	//Move data from sprayed to using directory
 	move_to_using   := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');		 

	//The attribute defining LAS0833 has moved from Prof_License_Mari.files_LAS0833 to Prof_License_Mari.file_LAS0833
	re_all       		:= Prof_License_Mari.file_LAS0833;
	oApr						:= OUTPUT(re_all);
	
	//Remove bad records before processing
	ValidFile	:= re_all(TRIM(org_name,LEFT,RIGHT) != ' ' 
	                 AND StringLib.StringToUpperCase(slnum)[1..3] = 'APR'
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));
  ut.CleanFields(ValidFile, clnValidFile);
	maribase_plus_dbas := RECORD,MAXLENGTH(5200)
		Prof_License_Mari.layout_base_in;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_LAS0833 pInput) := TRANSFORM

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

		//initialize raw_license_status from raw data
		tempRawStatus 				:= ut.CleanSpacesAndUpper(pInput.licstat);
		tempRawStatus2 				:= IF(stringlib.stringfind(tempRawStatus,'RENEWAL APPLICATION EMAILED',1)>0,
																'INCOMPLETE RENEWAL APR',
																tempRawStatus);
		SELF.RAW_LICENSE_STATUS := tempRawStatus2;

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.slnum);
		SELF.LICENSE_NBR      := IF(NOT REGEXFIND('[0-9]',tempLicNum) AND SELF.RAW_LICENSE_STATUS = 'PENDING','NR',tempLicNum);
		
		SELF.LICENSE_STATE	 	:= src_st;	         
					 
		// initialize raw_license_type from raw data
		tempRawType  					:= ut.CleanSpacesAndUpper(pInput.lic);											 
		SELF.RAW_LICENSE_TYPE := tempRawType;
																	 													          
		//First 7 characters of raw license type identifies the license type; APR.CGA - Certified General Appraiser License;
		//APR.CRA - Certified Residential Appraiser License;APR.TRA - Appraiser Trainee;AMC. - APPRAISAL MANAGEMENT COMPANY
		tempStdLicType        := MAP(tempRawType[1..3]='AMC' => 'AT',
																 tempRawType[1..8]='APR.TEMP' => 'AT',
																 tempRawType[1..7]='APR.CGA' => 'CGAL',
																 tempRawType[1..7]='APR.CRA' => 'CRAL',
																 tempRawType[1..7]='APR.TRA' => 'TA',
																 tempRawType[1..8]='BROK.ACT' => 'BROKACT',
																 tempRawType[1..8]='BROK.ASA' => 'BROKASA',
																 tempRawType[1..9]='BROK.BRNC' => 'BROKBRNC',
																 tempRawType[1..9]='BROK.CORP' => 'BROKCORP',
																 tempRawType[1..8]='SALE.ACT' => 'SALEACT',
																 tempRawType[1..8]='SALE.INA' => 'SALEINACT',
																 tempRawType='APPRAISER TRAINEE' => 'TA',
																 tempRawType='CERTIFIED GENERAL APPRAISER LICENSE' => 'CGAL',
																 tempRawType='CERTIFIED RESIDENTIAL APPRAISER LICENSE' => 'CRAL',
																 tempRawType='APPRAISAL MANAGEMENT COMPANY' => 'AT',
																 tempRawType='TEMPORARY APPRAISER' => 'AT',
																 ' ');														 
		SELF.STD_LICENSE_TYPE := tempStdLicType;

		// assigning type code based on license type
		tempTypeCd		  			:= IF(tempStdLicType='AT', 'GR', 'MD');
		SELF.TYPE_CD      		:= tempTypeCd;
			                            
		// assigning dates per business rules
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUEDT=' ',
																'17530101',
																prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUEDT));
		SELF.CURR_ISSUE_DTE		:= IF(pInput.CURISSUEDT=' ',
																'17530101',
																prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CURISSUEDT));
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT=' ',
																'17530101',
																prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPDT));
	
		SELF.PROVNOTE_2				:= IF(pInput.APPLICATION_DT<>'',
		                            'APPLICATION DATE='+prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(pInput.APPLICATION_DT),
																'');
																
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		TrimNAME_ORG					:= 	TRIM(Prof_License_Mari.mod_clean_name_addr.cleanDbaName(pInput.org_name),LEFT,RIGHT);
				
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     		:= tempTypeCd;
		//2 names requre special handling
		mariParse         		:= MAP(TrimNAME_ORG='JOHN M SALES' => 'MD',
																 TrimNAME_ORG='JOHN RUSH ALLPHIN' => 'MD',
																 prof_license_mari.func_is_company(TrimNAME_ORG) = TRUE => 'GR',
																 prof_license_mari.func_is_company(TrimNAME_ORG) = FALSE => 'MD',
																 tempMariParse);
			
		prepNAME_ORG					:= 	trimNAME_ORG;
		
	  TempNick        := Prof_License_Mari.fGetNickname(trimNAME_ORG,'nick');	
	  stripNickName 	:= Prof_License_Mari.fGetNickname(trimNAME_ORG,'strip_nick');
	  removeNick    	:= IF(TempNick != '',stripNickName,trimNAME_ORG);
		
		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		StdNAME_ORG						:= IF(rmvQuoteORG != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
    SufxPattern           := '(^JR |^SR |^II |^III |^IV |^VI | JR | JR.| SR |SR.| II | III | IV | VI | JR$| SR$| II$| III$| IV$| VI$)';
    TempSufx              := IF(REGEXFIND(SufxPattern,rmvQuoteORG),TRIM(REGEXFIND(SufxPattern,rmvQuoteORG,0),LEFT,RIGHT),'');
		rmvSufx               := IF(REGEXFIND(SufxPattern,rmvQuoteORG),TRIM(REGEXREPLACE(SufxPattern,rmvQuoteORG,''),LEFT,RIGHT),rmvQuoteORG);
		// use the right parser for name field
		CleanNAME_ORG					:= MAP(TrimNAME_ORG='LOWELL K. MAJOR'   => 'MR   LOWELL              K                   MAJOR                    99',
																 TrimNAME_ORG='LUIGI M. MAJOR'    => 'MR   LUIGI               M                   MAJOR                    99',
																 TrimNAME_ORG='CLINT R. LAND'     => 'MR   CLINT               R                   LAND                     99',
																 TrimNAME_ORG='JOHN M SALES'      => 'MR   JOHN                M                   SALES                    99',
																 TrimNAME_ORG='JOHN RUSH ALLPHIN' => 'MR   JOHN                RUSH                ALLPHIN                  99',
																 TrimNAME_ORG='ROGER G. LAND'     => 'MR   ROGER               G                   LAND                     99',
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 tempTypeCd = 'GR' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 tempTypeCd = 'GR' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvSufx),
											 					 tempTypeCd = 'MD' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvSufx),
																 // tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 StdNAME_ORG);

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
															
		//SELF.NAME_PREFX     	:= IF(mariParse='MD',TRIM(CleanNAME_ORG[1..5],LEFT,RIGHT),'');
		SELF.NAME_FIRST				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT),'');
		SELF.NAME_MID					:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT),'');
		SELF.NAME_LAST				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT),'');
		SELF.NAME_SUFX				:= MAP(mariParse='MD' AND TempSufx != ''=> TempSufx,
		                             mariParse='MD' AND TempSufx  = ''=> TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT),
																 '');
		SELF.NAME_NICK				:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
																StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
																tempNick);

		//SELF.office_parse := mariParse;		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
																			
		SELF.NAME_ORG 				:= MAP(mariParse='MD'=> stringlib.stringcleanspaces(SELF.NAME_LAST+' '+SELF.NAME_FIRST),
																StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 AND SELF.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																CleanNAME_ORG);

		// office address fields
 		tempAdd1            	:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
 		tempAdd2            	:= ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
 		tempAdd1_1          	:= IF(tempAdd1='' OR REGEXFIND('(^C/O|^ATTENTION)',tempAdd1),tempAdd2,tempAdd1);
 		tempAdd2_1          	:= IF(tempAdd1_1 = tempAdd2,'',tempAdd2);
  														
 		tempAdd3            	:= IF(Prof_License_Mari.func_is_address(tempAdd1)= false,tempAdd2_1,tempAdd1_1);
   																		
		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

    trimAddress1        	:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
    trimAddress2        	:= ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
		trimCity							:= ut.CleanSpacesAndUpper(pInput.CITY_1);
		trimState							:= ut.CleanSpacesAndUpper(pInput.STATE_1);
		tmpZip	            	:= MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
																 LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
  		
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
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_CNTY_1    	:= ut.CleanSpacesAndUpper(pInput.COUNTY);

		// phone
		tempPhone        			:= TRIM(StringLib.StringFilter(pInput.tele_1,'0123456789'))[1..10];
		SELF.PHN_PHONE_1 			:= tempPhone;
		SELF.PHN_MARI_1  			:= tempPhone;
		// email
		SELF.EMAIL  					:= ut.CleanSpacesAndUpper(pInput.email_1);
	
    trimAddress1_2        := ut.CleanSpacesAndUpper(pInput.ADDRESS1_2);
    trimAddress2_2       	:= ut.CleanSpacesAndUpper(pInput.ADDRESS2_2);
    trimAddress3_2       	:= ut.CleanSpacesAndUpper(pInput.ADDRESS3_2);
		trimCity_2						:= ut.CleanSpacesAndUpper(pInput.CITY_2);
		trimState_2						:= ut.CleanSpacesAndUpper(pInput.STATE_2);
		tmpZip_2	            := MAP(LENGTH(TRIM(pInput.ZIP_2))=3 => '00'+TRIM(pInput.ZIP_2),
																 LENGTH(TRIM(pInput.ZIP_2))=4 => '0'+TRIM(pInput.ZIP_2),
																 TRIM(pInput.ZIP_2));
  		
	  //Extract company name
		clnAddress1_2					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1_2, RemovePattern);
		clnAddress2_2					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2_2, RemovePattern);
		clnAddress3_2					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress3_2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1_2				:= StringLib.StringCleanSpaces(clnAddress1_2+' '+clnAddress2_2+' '+clnAddress3_2); 
		temp_preaddr2_2				:= StringLib.StringCleanSpaces(trimCity_2+' '+trimState_2+' '+tmpZip_2); 
		clnAddrAddr1_2				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1_2,temp_preaddr2_2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1_2			:= TRIM(clnAddrAddr1_2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1_2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1_2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1_2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1_2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1_2			:= TRIM(clnAddrAddr1_2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1_2[57..64],LEFT,RIGHT);
		AddrWithContact_2			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1_2); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2			:= IF(AddrWithContact_2 != ' ' AND tmpADDR_ADDR2_1_2 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1_2),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1_2));	
		SELF.ADDR_ADDR2_2			:= IF(AddrWithContact_2 != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1_2)); 
		SELF.ADDR_CITY_2		  := IF(TRIM(clnAddrAddr1_2[65..89])<>'',TRIM(clnAddrAddr1_2[65..89]),trimCity_2);
		SELF.ADDR_STATE_2		  := IF(TRIM(clnAddrAddr1_2[115..116])<>'',TRIM(clnAddrAddr1_2[115..116]),trimState_2);
		SELF.ADDR_ZIP5_2		  := IF(TRIM(clnAddrAddr1_2[117..121])<>'',TRIM(clnAddrAddr1_2[117..121]),tmpZip_2[1..5]);
		SELF.ADDR_ZIP4_2		  := clnAddrAddr1_2[122..125];
		
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  	:= IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY_1 + pInput.STATE_1 + pInput.ZIP,LEFT,RIGHT) != '','B','');		
		
		// assign officename
		tempNameOff         	:= MAP(Prof_License_Mari.func_is_company(pInput.contact)
		                               => ut.CleanSpacesAndUpper(pInput.contact),
																 Prof_License_Mari.func_is_company(REGEXFIND('^C/O (.*)$',tempAdd1,1)) 
																	 => REGEXFIND('^C/O (.*)$',tempAdd1,1),
																 '');
																														 
		trimNAME_OFFICE 			:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tempNameOff);
		SELF.NAME_OFFICE    	:= StringLib.StringCleanSpaces(trimNAME_OFFICE);
		
		//office parse
		tempOffParse      		:= MAP(prof_license_mari.func_is_company(trimNAME_OFFICE)= TRUE AND trimNAME_OFFICE != ' '=> 'GR',
																prof_license_mari.func_is_company(trimNAME_OFFICE)= FALSE AND trimNAME_OFFICE != ' ' => 'MD',
																'');
		SELF.OFFICE_PARSE 		:= tempOffParse;
		
		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG		:= ut.CleanSpacesAndUpper(pInput.org_name);
		SELF.NAME_FORMAT			:= 'F';

		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG 		:= IF(tempTypeCd='GR',	StdNAME_ORG,trimNAME_OFFICE); 
		
		// Business rules to parse contacts
		tempContact     			:= ut.CleanSpacesAndUpper(pInput.contact);
		tempContact2    			:= IF(Prof_License_Mari.func_is_company(tempContact),'',tempContact);
		prepContact						:= tempContact2;
											
		stripTitle						:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => StringLib.StringFindReplace(prepContact,'RECEIVER',''),
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
		
		parseContact					:= MAP(prepContact != '' AND StringLib.stringfind(TRIM(stripTitle,LEFT,RIGHT),' ',1)< 1 => ' ',
																 prepContact != '' AND NOT Prof_License_Mari.func_is_company(stripTitle) => datalib.NameClean(stripTitle),
																 ' ');
									 
		SELF.NAME_CONTACT_FIRST := TRIM(parseContact[1..15],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID 	:= TRIM(parseContact[41..56],LEFT,RIGHT);
		SELF.NAME_CONTACT_LAST := TRIM(parseContact[81..111],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX := TRIM(parseContact[131..134],LEFT,RIGHT);
		SELF.NAME_CONTACT_TTL	 := MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => 'RECEIVER',
																 StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
																 StringLib.stringfind(prepContact,'BROKER',1)>0 => 'BROKER',
																 StringLib.stringfind(prepContact,'MNGR',1)>0 => 'MNGR',
																 '');	
		
		// Business rules to standardize DBA(s) for splitting into multiple records

		// Populate if DBA exist in ORG_NAME field
		tempDBA       				:= Prof_License_Mari.mod_clean_name_addr.getDbaName(pInput.org_name);
		trimDBA       				:= ut.CleanSpacesAndUpper(tempDBA);
		trimFix       				:= stringlib.stringfindreplace(trimDBA,'RE/MAX','REMAX');
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
		temp_dba1							:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
																 StripDBA);
																						
		SELF.dba1 						:= temp_dba1;

		SELF.dba2							:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
																 ' ');
					
		SELF.dba3 						:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
																 StringLib.stringfind(StripDBA,'/',2) > 0 =>
																 REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																 '');
		
		SELF.dba4 						:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
																 StringLib.stringfind(StripDBA,'/',3) > 0 =>
																 REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																 '');
		
		SELF.dba5 						:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
																 REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');						   

		//affiliation type code
		tempAffilTypeCd 			:= MAP(tempTypeCd = 'GR' => 'CO',
																 tempTypeCd = 'MD' => 'IN',
																 '');
		
		SELF.affil_type_cd 		:= tempAffilTypeCd;
	
		 // fields used to create mltreckey key are:
			// license number
			// license type
			// source update
			// name
			// address_1
			// dba
			// officename
		
		//Use hash64 instead of hash32 to avoid dup key 2/28/13 Cathy Tio 
		mltreckeyHash 				:= HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
																	 +TRIM(tempStdLicType,LEFT,RIGHT)
																	 +TRIM(src_cd,LEFT,RIGHT)
																	 +ut.CleanSpacesAndUpper(StdName_Org)
																	 +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
																	 +ut.CleanSpacesAndUpper(StripDBA)
																	 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
																	 +tmpZip
																	 +trimNAME_OFFICE
																	 +tempContact); 
		
		SELF.mltreckey 				:= IF(temp_dba1 != ' ',mltreckeyHash, 0);
		
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
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
														 +trimNAME_OFFICE
														 +tempContact);						 

		SELF := [];
		
	END;

	ds_map := PROJECT(clnValidFile, transformToCommon(LEFT));
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
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := TRANSFORM
		SELF.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
		TrimDBASufx		   	:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
										  	 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
											  '');
		DBA_SUFX			      := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		SELF.NAME_DBA 	  	:= TRIM(TrimDBASufx,LEFT,RIGHT);
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
									 TRIM(LEFT.name_office,LEFT,RIGHT)	= TRIM(RIGHT.name_org_orig,LEFT,RIGHT)
									 AND LEFT.AFFIL_TYPE_CD in ['IN', 'BR'],
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
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, ocmv, oApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;
