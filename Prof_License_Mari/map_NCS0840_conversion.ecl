// NCS0840 / North Carolina Real Estate Commission / Real Estate //
#workunit('name','map_NCS0840_conversion');
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_NCS0840_conversion(STRING pVersion) := FUNCTION
#workunit('name',' Yogurt:Prof License MARI - NCS0840 Build   ' + pVersion);

	code 								:= 'NCS0840';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	
	//Move to using
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','sprayed','using');	
																	);

	Rel       					:= Prof_License_Mari.files_NCS0840.active;
	oRel								:= OUTPUT(Prof_License_Mari.files_NCS0840.active);
	
	ValidFile						:= Rel(TRIM(name,LEFT,RIGHT) != ' ' 
																 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(name))
																 AND lictype != ' '
																 AND id != 'LICENSE NUMBER');
	ut.CleanFields(validFile, cln_File);	
	
	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA |T/A )(.*)';
	
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
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|^C/O .* GROUP ' +
					 ')';
	comp_names := '(REMAX|USA 4%|REAL EST|ASSOC|AGCY|RESOURCE|CENTURY 21|BROKERS|REALTY|COMPANY|OFFICE|REAL ESTATE| INC|'+
	              'HOME|BROKER|TEAM|PROPRIETORSHIP|RENTALS'+
								')';
	SUFFIX_PATTERN  := '( JR.,|JR ,| JR,| SR.,| SR,| III,| II,| IV,)';
	
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
	maribase_plus_dbas	TransformToCommon(Prof_License_Mari.Layout_NCS0840 pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;

		// assigning type code based on license type
		tempTypeCd		  			:= 'MD';
		SELF.TYPE_CD      		:= tempTypeCd;

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.id);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE		:= src_st;

		// initialize raw_license_type from raw data
		tempRawType						:= ut.CleanSpacesAndUpper(pInput.lictype);												 
		SELF.RAW_LICENSE_TYPE := tempRawType;
		tempStdLicType				:= tempRawType;												 
		SELF.STD_LICENSE_TYPE := SELF.RAW_LICENSE_TYPE;

		//initialize raw_license_status from raw data
		tempRawStatus := ut.CleanSpacesAndUpper(pInput.status);
		SELF.RAW_LICENSE_STATUS := tempRawStatus;
						
		// assigning dates per business rules
		STRING8 current_date	:= pVersion;
		curr_month 						:= (INTEGER)current_date[5..6];
		curr_year 						:= (INTEGER)current_date[1..4];	
		
		tempExpDt             := IF(tempRawStatus='ACTIVE',
																IF(curr_month < 7,(STRING4)curr_year+'0630',(STRING4)(curr_year+1)+'0630'),
																'17530101');
		SELF.EXPIRE_DTE		  	:= tempExpDt;
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.CURR_ISSUE_DTE		:= '17530101';
			
		// email
		SELF.EMAIL 						:= ut.CleanSpacesAndUpper(pInput.email);
			
		// fax
		tempFax        				:= stringlib.stringfindreplace(pInput.fax,'+1','');
		SELF.PHN_FAX_1 				:= StringLib.StringFilter(tempFax,'0123456789');
		SELF.PHN_MARI_FAX_1  	:= SELF.PHN_FAX_1;
		
		//phone
		TrimPhone           := TRIM(StringLib.StringFilter(pInput.PHONE,'0123456789'),LEFT,RIGHT);
		SELF.PHN_MARI_1			:= ut.CleanPhone(TrimPhone);
		SELF.PHN_PHONE_1    := ut.CleanPhone(TrimPhone);
	
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		tempTrimName     			:= ut.CleanSpacesAndUpper(pInput.name);
		tempTrimNameFix6 			:= prof_license_mari.mod_clean_name_addr.cleanDbaName(tempTrimName);
		TrimNAME_ORG		 			:= IF(REGEXFIND(DBApattern,tempTrimNameFix6) = TRUE,
																 Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix6),
																 tempTrimNameFix6);
													 												 
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     		:= tempTypeCd;
		mariParse         		:= 'MD';
					
		prepNAME_ORG					:= MAP(StringLib.stringfind(TrimNAME_ORG,'D/B/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'D/B/',' '),
																 StringLib.stringfind(TrimNAME_ORG,'T/A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T/A',' '),
																 StringLib.stringfind(TrimNAME_ORG,'T\\A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T\\A',' '),
																 StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
																 StringLib.stringfind(TrimNAME_ORG,'\\',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'\\',' '),
																 trimNAME_ORG);

		tempNick 							:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'strip_nick');			
		GoodName							:= IF(tempNick != '',removeNick,prepNAME_ORG);	
		
		rmvSufxName           := REGEXREPLACE(SUFFIX_PATTERN, GoodName,',');
		TmpSufx               := REGEXREPLACE(',',REGEXFIND(SUFFIX_PATTERN, GoodName,0),'');	

		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(rmvSufxName,'"',''));
		StdNAME_ORG						:= IF(rmvQuoteORG != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));															
		// use the right parser for name field
		CleanNAME_ORG					:= MAP(REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 tempTypeCd = 'GR' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 tempTypeCd = 'GR' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(rmvQuoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'MD' => Address.CleanPersonLFM73(TRIM(REGEXREPLACE('^O ',rmvQuoteOrg,'O'))),
																 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 StdNAME_ORG);
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);																			
		SELF.NAME_ORG 				:= MAP(mariParse='MD'=> stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[6..25]),
																	StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 AND SELF.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																								CleanNAME_ORG);
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
																													
		SELF.NAME_FIRST				:= TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT);
		SELF.NAME_MID					:= TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT);
		SELF.NAME_LAST				:= TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT);
		SELF.NAME_SUFX				:= IF(TmpSufx != '',TRIM(TmpSufx,LEFT,RIGHT),
		                            IF(TmpSufx = '',TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT),''));
																
		SELF.NAME_NICK				:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
																 StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
																 tempNick);
		// 1st set of address fields

		//Use address cleaner to clean address
		trimAddress1          := ut.CleanSpacesAndUpper(pInput.ADD1);
		tmpZip	              := MAP(LENGTH(TRIM(pInput.Zip))=3 => '00'+TRIM(pInput.Zip),
		                             LENGTH(TRIM(pInput.Zip))=4 => '0'+TRIM(pInput.Zip),
						                     TRIM(pInput.Zip));
		tempCity            	:= ut.CleanSpacesAndUpper(pInput.CITY);
		tempCity2           	:= IF(tempCity='N/A','',tempCity);
		tempCity3           	:= IF(tempCity2='MPLS','MINNEAPOLIS',tempCity2);
		tempState           	:= IF(ut.CleanSpacesAndUpper(pInput.STATE)='NULL','',
															ut.CleanSpacesAndUpper(pInput.STATE));
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(tempCity3+' '+tempState +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
	 // assign business address indicator to TRUE (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  	:= IF(TRIM(trimAddress1 + pInput.CITY + pInput.STATE + pInput.ZIP,LEFT,RIGHT) != '','B','');
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),tempCity3);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),tempState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_CNTY_1 			:= ut.CleanSpacesAndUpper(pInput.COUNTY);
		
		//assign officename
		tempNameOff        		:= IF(tempRawStatus='INACTIVE',
																'',
																stringlib.stringfindreplace(stringlib.stringfindreplace(pInput.CO,' DBA/',' DBA '),'^DBA /',' DBA '));
		tempNameOff2       		:= ut.CleanSpacesAndUpper(tempNameOff);
		tempNameOff3       		:= IF(tempNameOff2[1..3]='DBA' or tempNameOff2[1..3]='T/A',tempNameOff2[4..],tempNameOff2);
		tempOffLen         		:= LENGTH(TRIM(tempNameOff3,LEFT,RIGHT));
		tempNameOff4       		:= IF(tempNameOff3[tempOffLen-3..] = 'DBA',tempNameOff3[1..tempOffLen-4],tempNameOff3);
		tempNameOff5       		:= IF(tempNameOff4 != '',prof_license_mari.mod_clean_name_addr.getCORPname(tempNameOff4),'');
		trimNAME_OFFICE     	:= IF(tempNameOff5<>' ',tempNameOff5,tempNameOff4);
		GoodNAME_OFFICE      	:= stringlib.StringfilterOut(trimNAME_OFFICE,'*');
		CleanNAME_OFFICE    	:= MAP(TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST+SELF.NAME_MID+SELF.NAME_LAST,ALL) => '',
		                             TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST+SELF.NAME_LAST,ALL) => '',
																 TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST+SELF.NAME_FIRST,ALL) => '',
																 TRIM(GoodNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST+ SELF.NAME_MID +SELF.NAME_LAST + SELF.NAME_SUFX,ALL) => '',
																 TRIM(GoodNAME_OFFICE,LEFT,RIGHT) = 'N/A' => '',
																 GoodNAME_OFFICE);
		SELF.NAME_OFFICE      := CleanNAME_OFFICE;													 
		// office parse
		tempOffParse1 				:= IF(REGEXFIND(comp_names,CleanNAME_OFFICE) = TRUE,'GR','');
		tempOffParse      		:= MAP(tempOffParse1 = '' AND prof_license_mari.func_is_company(CleanNAME_OFFICE)= TRUE AND CleanNAME_OFFICE != ' '=> 'GR',
																 tempOffParse1 = '' AND prof_license_mari.func_is_company(CleanNAME_OFFICE)= FALSE AND CleanNAME_OFFICE != ' ' => 'MD',
																 tempOffParse1);
		SELF.OFFICE_PARSE 		:= tempOffParse;

		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG		:= tempTrimName;
		SELF.NAME_FORMAT			:= 'L';
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG 		:= CleanNAME_OFFICE; 
		
		//Broker In Charge indicator - 'Y', or license number. If the broker is 'BIC', this field is 'Y'. Otherwise
		//it is the broker license number of the broker in charge.
		tempContSlnum            := Stringlib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.BIC_INDIC),'"');
		SELF.LICENSE_NBR_CONTACT := IF(tempContSlnum = 'Y','',tempContSlnum);
		SELF.BRKR_LICENSE_NBR    := IF(tempContSlnum = 'Y','',tempContSlnum);
		SELF.BRKR_LICENSE_NBR_TYPE := IF(tempContSlnum = '' ,'','BROKER IN CHARGE');
		
		// Business rules to parse contacts
		trimCont        			:= ut.CleanSpacesAndUpper(pInput.BIC);		
		tempContact     			:= IF(tempContSlnum != '',trimCont,'');
		prepContact						:= tempContact;
											
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
		SELF.NAME_CONTACT_MID	  := TRIM(parseContact[41..56],LEFT,RIGHT);
		SELF.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX	:= TRIM(parseContact[131..134],LEFT,RIGHT);
		SELF.NAME_CONTACT_TTL	  := MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => 'RECEIVER',
																 	 StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
																	 StringLib.stringfind(prepContact,'BROKER',1)>0 => 'BROKER',
																	 StringLib.stringfind(prepContact,'MNGR',1)>0 => 'MNGR',
																	 '');	
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		tempDBA       := IF(tempNameOff4 != '',prof_license_mari.mod_clean_name_addr.getDBAname(tempNameOff4),'');
		trimDBA       := ut.CleanSpacesAndUpper(tempDBA);
		trimDBA2      := IF(trimDBA = tempTrimNameFix6,'',trimDBA);
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
		
		//Store the notes in PROVNOTE_1
		tmp_PROVNOTE_1 				:= StringLib.StringCleanSpaces(
																IF(pInput.F22<>'',pInput.F22+';','') +
																IF(pInput.F23<>'',pInput.F23+';','') +
																IF(pInput.F24<>'',pInput.F24+';','') +
																IF(pInput.F25<>'',pInput.F25+';','') +
																IF(pInput.F26<>'',pInput.F26+';','') +
																IF(pInput.F27<>'',pInput.F27+';','') +
																IF(pInput.F28<>'',pInput.F28+';','') +
																IF(pInput.F29<>'',pInput.F29+';','') +
																IF(pInput.F30<>'',pInput.F30+';','') +
																IF(pInput.F31<>'',pInput.F31+';','') +
																IF(pInput.F32<>'',pInput.F32+';','') +
																IF(pInput.F33<>'',pInput.F33+';','') +
																IF(pInput.F34<>'',pInput.F34+';','')
																);
		SELF.PROVNOTE_1				:= IF(tmp_PROVNOTE_1<>'','ADDITIONAL_INFO: ' + tmp_PROVNOTE_1,'');
			
		SELF.affil_type_cd    := IF(SELF.type_cd = 'MD', 'IN','CO');
		
		 // fields used to create mltreckey key are:
			// license number
			// license type
			// source update
			// name
			// address_1
			// dba
			// officename
		mltreckeyHash := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.ADD1)
														 +ut.CleanSpacesAndUpper(StripDBA)
														 ); 
			
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
														 +ut.CleanSpacesAndUpper(pInput.ADD1)
														 +TRIM(pInput.ZIP)
														 );
									 

		SELF := [];		   		   
	END;

	ds_map := PROJECT(Cln_File, TransformToCommon(LEFT));

	// Clean-up Fields
	maribase_plus_dbas	TransformClean(ds_map pInput) := TRANSFORM

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
	ds_map_clean := PROJECT(ds_map , TransformClean(LEFT));
							   

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
		TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
											 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
											 '');
		DBA_SUFX			  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		SELF.NAME_DBA 		  := TRIM(TrimDBASufx,LEFT,RIGHT);
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: TRUE  0: false
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
									 ((TRIM(LEFT.off_license_nbr,LEFT,RIGHT)[1..10]) = (TRIM(RIGHT.off_license_nbr,LEFT,RIGHT)[1..10]))
										 AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
										 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layout_base_in xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	//Add to super files and clean up
	d_final 						:= OUTPUT(OutRecs, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs(NAME_ORG_ORIG != ''));			

	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','using','used');	
																	);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oRel, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;