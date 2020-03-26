// Purpose : map IDS0658 / Idaho Dept of Finance / Multiple Professions // raw data to common layout for MARI and PL use
//Source file location - \\Tapeload02b\k\professional_licenses\mari\id\idaho_mortgage_lenders_(en)\
IMPORT Prof_License, Prof_License_Mari, Address, Lib_FileServices, lib_stringlib,ut;

EXPORT map_IDS0658_conversion(STRING pVersion) := FUNCTION

	code 								:= 'IDS0658';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mortgage','sprayed','using');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'icc','sprayed','using');
												 );

	//Pattern for DBA
	DBApattern			:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';

	ICC_common					:= PROJECT(Prof_License_Mari.files_IDS0658.icc,
																 TRANSFORM(Prof_License_Mari.layout_IDS0658.common,
																					 SELF := LEFT;
																					 SELF := []));
	oICC								:= OUTPUT(ICC_common); 
	//Remove bad records before processing
	ValidIcc	:= ICC_common(TRIM(COMPANY_NAME) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMPANY_NAME)));

	Prof_License_Mari.layout_IDS0658.common map_mortgage(Prof_License_Mari.layout_IDS0658.mortgage L) := TRANSFORM
		SELF    := L;
	END;

	Mortgage_common					:= PROJECT(Prof_License_Mari.files_IDS0658.mortgage,
																 TRANSFORM(Prof_License_Mari.layout_IDS0658.common,
																					 SELF := LEFT));
	oMort										:= OUTPUT(Mortgage_common); 
	
	//Remove bad records before processing
	ValidMortgage	:= Mortgage_common(TRIM(COMPANY_NAME,LEFT,RIGHT) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMPANY_NAME)));

	ValidFile	:= ValidMortgage + ValidIcc;
	
	ut.CleanFields(ValidFile,clnValidFile);

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
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_IDS0658.common pInput) := TRANSFORM
	
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
		SELF.LICENSE_STATE	 	:= src_st;

		SELF.TYPE_CD      		:= 'GR';

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.license_number);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		// initialize office license number
		tempOffSlnum 					:= ut.CleanSpacesAndUpper(pInput.home_office_numr);
		SELF.OFF_LICENSE_NBR 	:= tempOffSlnum;
		
		// initialize raw_license_type from raw data
		tempRawType 					:= ut.CleanSpacesAndUpper(pInput.company_type);										 
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																				
		// map raw license type to standard license type before profcode translations
		tempStdLicType 				:= MAP(tempRawType = 'BANKER' => 'BNKR', 
																 tempRawType = 'BROKER' => 'BOKR',
																 tempRawType = 'REGULATED LENDER' => 'RGLN',
																 tempRawType = 'SECOND MORTGAGE' => 'SDMG',
																 ' ');																	 
		SELF.STD_LICENSE_TYPE := tempStdLicType;

		// assigning dates per business rules
		STRING8 today        	:= Lib_StringLib.StringLib.GetDateYYYYMMDD();
		tempExpDt            	:= MAP(tempStdLicType IN ['RGLN','SDMG'] AND today[5..6]<'02' => today[1..4]+'0131',
																 tempStdLicType IN ['RGLN','SDMG'] AND today[5..6]>'01' => ((STRING4)((INTEGER)today[1..4]+1))+'0131', 
																 tempStdLicType IN ['BNKR','BOKR'] AND today[5..6]<'09' => today[1..4]+'0831', 
																 tempStdLicType IN ['BNKR','BOKR'] AND today[5..6]>'08' => ((STRING4)((INTEGER)today[1..4]+1))+'0831', 
																 ' ');
		SELF.EXPIRE_DTE		   	:= tempExpDt;
		SELF.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.effective_date);
		SELF.CURR_ISSUE_DTE		:= '17530101';
		
		//initialize raw_license_status from raw data
		tempStdStatus 				:= IF(tempExpDt>today,'A','I');		
		SELF.STD_LICENSE_STATUS := tempStdStatus;
		SELF.PROVNOTE_3 	    := '{LICENSE_STATUS ASSIGNED}';
								
		// assigning type code based on license type
																				
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes

		tempTrimName					:= ut.CleanSpacesAndUpper(pInput.company_name);
		prepNAME_ORG    			:= tempTrimName;						
		StdNAME_ORG						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_ORG);
		mariParse							:= IF(REGEXFIND('^[A-Z]+, ',tempTrimName) AND NOT REGEXFIND('^.* INC[.]?$|^.*, LLC$',tempTrimName),'MD','GR');
			
		// use the right parser for name field
		CleanNAME_ORG					:= MAP(REGEXFIND(' DBA ', StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('(^.* FINANCE[ ]+LP$)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('(^.* CHURCH EXTENSION.*$)',StdNAME_ORG) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',StdNAME_ORG) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',StdNAME_ORG) => StdNAME_ORG,
																 mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(StdNAME_ORG),
																 StdNAME_ORG);
		stdNAME_ORG_PREFX     := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);														 
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(stdNAME_ORG_PREFX);
		SELF.NAME_ORG 				:= MAP(mariParse='MD'=> stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[6..25]),
																 StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 AND SELF.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																 stdNAME_ORG_PREFX<>'' AND REGEXFIND(stdNAME_ORG_PREFX, CleanNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND(stdNAME_ORG_PREFX, CleanNAME_ORG,2),
																 CleanNAME_ORG);
		// Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
		SELF.NAME_ORG_SUFX		:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
																 NOT REGEXFIND('LLP',StdNAME_ORG) AND REGEXFIND('(LP)$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
																 REGEXFIND('(L[.]P[.])$',StdNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => '',
																 Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));	

		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG		:= tempTrimName;
		SELF.NAME_FORMAT			:= IF(REGEXFIND('^[A-Z]+, ',tempTrimName) AND NOT REGEXFIND(' INC$',tempTrimName),'L','F');
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG		:= StdNAME_ORG; 
		SELF.NAME_DBA_ORIG    := ut.CleanSpacesAndUpper(TRIM(pInput.DBA,LEFT,RIGHT));
					 

		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|ATTN LICENSING' +
					 ')';

    trimAddress1        	:= ut.CleanSpacesAndUpper(pInput.STREET_ADDR);
		trimCity							:= ut.CleanSpacesAndUpper(pInput.CITY);
		trimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		tmpZip	            	:= MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
																 LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
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
		
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND			:= IF(TRIM(pInput.STREET_ADDR + pInput.CITY + pInput.STATE + pInput.ZIP,LEFT,RIGHT) != '','B','');


		//populate phone field
		SELF.PHN_PHONE_1    	:= ut.CleanPhone(pInput.PHONE);
		SELF.PHN_MARI_1     	:= ut.CleanPhone(pInput.PHONE);
		//populate fax field
		SELF.PHN_FAX_1      	:= ut.CleanPhone(pInput.FAX);
		SELF.PHN_MARI_FAX_1 	:= ut.CleanPhone(pInput.FAX);				
						
		// Business rules to parse contacts							   
		prepContact						:= ut.CleanSpacesAndUpper(pInput.attention);
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
		SELF.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX  := TRIM(parseContact[131..134],LEFT,RIGHT);
		SELF.NAME_CONTACT_TTL	  := MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => 'RECEIVER',
																   StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
																   StringLib.stringfind(prepContact,'BROKER',1)>0 => 'BROKER',
																   StringLib.stringfind(prepContact,'MNGR',1)>0 => 'MNGR',
																   '');							
								
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		trimDBA       				:= ut.CleanSpacesAndUpper(pInput.DBA);
		tempDBA1      				:= IF(trimDBA=tempTrimName,'',trimDBA);
		tempDBA2      				:= stringlib.stringfindreplace(tempDBA1,';','/');
		tempDBA3      				:= stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
		tempDBA4      				:= IF(stringlib.stringfind(tempDBA3,'BURRES AND ASSOCIATES',1)=0
																AND stringlib.stringfind(tempDBA3,'FARM AND RANCH ',1)=0
																AND stringlib.stringfind(tempDBA3,'AND LOAN',1)=0,
																stringlib.stringfindreplace(tempDBA3,' AND ','/'),
																tempDBA3);												
		tempDBA5      				:= stringlib.stringfindreplace(tempDBA4,'CORPORATION','CORP');
		//Special processing for this one record that uses - instead / to separate DBAs
		//PHH MORTGAGE SERVICES-INSTAMORTGAGE.COM-COLDWELL BANKER MTG-CENTURY 21 MTG-ERA MTG/ DOMAIN DIST PROP
		//FIRST OPTION LENDING LLC WWW.THEPEOPLEYOUCALLFIRST.COM/WWW.FIRSTOPTIONTV.COM
		//LAND/HOME FINANCIAL SERVICES
		tempDBA6      				:= stringlib.stringfindreplace(tempDBA5,' SERVICES-',' SERVICES/');
		tempDBA7      				:= stringlib.stringfindreplace(tempDBA6,'.COM-','.COM/');
		tempDBA8      				:= stringlib.stringfindreplace(tempDBA7,' MTG-',' MTG/');
		tempDBA9      				:= stringlib.stringfindreplace(tempDBA8,'LAND/HOME','LAND&HOME');
		StripDBA      				:= stringlib.stringfindreplace(tempDBA9,' LLC WWW',' LLC/WWW');
		
		SELF.dba_flag 				:= IF(StripDBA != ' ', 1, 0);
		SELF.dba							:= MAP(StripDBA=' '=>' ',
		                             REGEXFIND('^([^/]+)/',StripDBA) => TRIM(REGEXFIND('^([^/]+)/',StripDBA,1),LEFT,RIGHT),
		                             REGEXFIND('^(.*)$',StripDBA) => TRIM(REGEXFIND('^(.*)$',StripDBA,1),LEFT,RIGHT),
																 TRIM(StripDBA,LEFT,RIGHT));
		SELF.dba1							:= MAP(TRIM(SELF.dba,LEFT,RIGHT)=' ' => ' ',
															 REGEXFIND('^([^/]+)/([^/]+)/',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/',StripDBA,2),LEFT,RIGHT),
															 REGEXFIND('^([^/]+)/([^/]+)$',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)$',StripDBA,2),LEFT,RIGHT),
															 ' ');
		SELF.dba2							:= MAP(TRIM(SELF.dba1,LEFT,RIGHT)=' ' => ' ',
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/',StripDBA,3),LEFT,RIGHT),
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)$',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)$',StripDBA,3),LEFT,RIGHT),
															 ' ');
		SELF.dba3							:= MAP(TRIM(SELF.dba2,LEFT,RIGHT)=' ' => ' ',
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/',StripDBA,4),LEFT,RIGHT),
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)$',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)$',StripDBA,4),LEFT,RIGHT),
															 ' ');
		SELF.dba4							:= MAP(TRIM(SELF.dba3,LEFT,RIGHT)=' ' => ' ',
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)/',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)/',StripDBA,5),LEFT,RIGHT),
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)$',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)$',StripDBA,5),LEFT,RIGHT),
															 ' ');
		SELF.dba5							:= MAP(TRIM(SELF.dba4,LEFT,RIGHT)=' ' => ' ',
															 REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)/(.*)$',StripDBA) => TRIM(REGEXFIND('^([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)/(.*)$',StripDBA,6),LEFT,RIGHT),
															 ' ');
		//assign affiliation type codes
		SELF.affil_type_cd 		:= MAP(tempOffSlnum=' ' OR tempOffSlnum=tempLicNum => 'CO',
																 tempOffSlnum != ' ' AND tempOffSlnum != tempLicNum  => 'BR',
															   ' ');
																				
		// fields used to create mltreckey key are:
		// license number
		// license type
		// source update
		// name
		// address_1
		// dba
		// officename			 
		mltreckeyHash 				:= HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
																	 +TRIM(tempStdLicType,LEFT,RIGHT)
																	 +TRIM(src_cd,LEFT,RIGHT)
																	 +ut.CleanSpacesAndUpper(tempTrimName)
																	 +ut.CleanSpacesAndUpper(pInput.STREET_ADDR)
																	 +ut.CleanSpacesAndUpper(StripDBA)); 		
		SELF.mltreckey 				:= IF(SELF.DBA1 != ' ',mltreckeyHash, 0);
				
		// fields used to create unique key are:
		// license number
		// license type
		// source update
		// name
		// address				 
		SELF.cmc_slpk         := hash64(trim(tempLicNum,LEFT,RIGHT) 
																	 +trim(tempStdLicType,LEFT,RIGHT)
																	 +trim(src_cd,LEFT,RIGHT)
																	 +ut.CleanSpacesAndUpper(tempTrimName)
																	 +ut.CleanSpacesAndUpper(pInput.STREET_ADDR)
																	 +ut.CleanSpacesAndUpper(pInput.ZIP)
																	 );
		SELF := [];		 
				
	END;

	ds_map := PROJECT(clnValidFile, transformToCommon(LEFT));

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
	ds_map_clean := PROJECT(ds_map , transformClean(LEFT));
							   
	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_clean L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_clean, Cmvtranslation,
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
		TrimDBASufx1				:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
														   NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
														   '');
		//Special handling for Land/Home Financial Services 
		TrimDBASufx      		:= stringlib.stringfindreplace(TrimDBASufx1,'LAND&HOME','LAND/HOME');

		DBA_SUFX						:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		DBA_PREFIX					:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(L.TMP_DBA);						   
		SELF.NAME_DBA 			:= IF(DBA_PREFIX<>'' AND REGEXFIND(DBA_PREFIX, TrimDBASufx),REGEXFIND(DBA_PREFIX,TrimDBASufx,2)
		                          ,stringlib.stringcleanspaces(TrimDBASufx));
		SELF.DBA_FLAG       := IF(trim(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(StringLib.StringFilterOut(DBA_PREFIX, '.')); 
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
							TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layout_base_in xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

  //Adding to Superfile
	d_final 						:= OUTPUT(OutRecs, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);						

	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mortgage','using','used');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'icc','using','used');
												 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oICC,oMort, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;
