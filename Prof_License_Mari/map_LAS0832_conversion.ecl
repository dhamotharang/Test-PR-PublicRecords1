// LAS0832 / Louisiana Real Estate Commission / Real Estate raw data to common layout for MARI and PL use
#workunit('name','map_LAS0832_conversion'); 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_LAS0832_conversion(STRING pVersion) := FUNCTION

	code 								:= 'LAS0832';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	o_Cmvtranslation:= OUTPUT(Cmvtranslation);

	//Move data from sprayed to using directory
 	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed', 'using');		 

	//The attribute defining LAS0832 has moved from Prof_License_Mari.files_LAS0832 to Prof_License_Mari.file_LAS0832
	re       						:= Prof_License_Mari.file_LAS0832;
	oRE									:= OUTPUT(re);
	
  SUFFIX_PATTERN  := '( JR.$| JR$| SR.$| SR$| III$| II$| IV$)';	
	
	//Remove bad records before processing
	//Not using the BadNameFilter here. It elimimated 3 good records.
	//BROK.0000033776.A-ASA         	DAVID LAVOID HOLLOWAY   - contains void                                                                                                                             	BROK.ASA - Broker Associate Active                	ACTIVE                                            	NORMAL LICENSE STATU
	//BROK.0000042407.A-CORP        	KELLER WILLIAMS REALTY 1-888-351-5111, L.L.C.  - contains 888                                                                                                       	BROK.CORP - Broker Corporation                    	ACTIVE                                            	NORMAL LICENSE STATU
	//BROK.0995680761.A03-BRNC      	KELLER WILLIAMS REALTY 1-888-351-5111, L.L.C.  - contains 888                                                                                                       	BROK.BRNC - Broker Branch Office                  	ACTIVE                                            	NORMAL LICENSE STATU

 //Jira-DF 20443 Per Data Receiving Communication, the Active & Inactive record should be included.
	ValidFile						:= re(TRIM(ORG_NAME,LEFT,RIGHT) != ' ' 
	                          AND StringLib.StringToUpperCase(LIC)[1..3] != 'APR' /* AND StringLib.StringToUpperCase(LICSTAT) != 'INACTIVE'*/
	                          AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(TRIM(ORG_NAME,LEFT,RIGHT))));

	maribase_plus_dbas := RECORD,MAXLENGTH(5200)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_LAS0832 pInput) := TRANSFORM

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

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.slnum);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE	 	:= src_st;

		//initialize raw_license_status from raw data
		tempRawStatus 				  := TRIM(ut.CleanSpacesAndUpper(pInput.licstat),LEFT,RIGHT);
		SELF.RAW_LICENSE_STATUS := tempRawStatus;
		SELF.PROVNOTE_3					:= IF(REGEXFIND('RENEWAL APPLICATION EMAILED TO LICENSEE',tempRawStatus),
																	'RENEWAL APPLICATION EMAILED TO LICENSEE',
																	tempRawStatus);
		// initialize raw_license_type from raw data
		tempRawType  					:= ut.CleanSpacesAndUpper(pInput.lic);											 
		SELF.RAW_LICENSE_TYPE := tempRawType;
	
		tempStdLicType        := MAP(tempRawType[1..4]='SALE' => 'SALE',
			                           tempRawType[1..4]='BROK' => 'BROK',
			                           tempRawType[1..3]='TS.' => 'TSDEV',
																 '');															 
  	SELF.STD_LICENSE_TYPE := tempStdLicType;
		//assigning type code based on license type. Example of license type: BROK.ACT, BROK.INA, BROK.CORP, BROK.ASA,
		//SALE.INA, SALE.ACT
		tempTypeCd		  	:= IF(stringlib.stringfind(tempRawType,'.CORP',1)>0 OR stringlib.stringfind(tempRawType,'.BRNC',1)>0 OR stringlib.stringfind(tempRawType,'.DEV',1)>0,
													 'GR',
													 'MD');
		SELF.TYPE_CD      := tempTypeCd;
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
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		TrimNAME_ORG					:= 	Prof_License_Mari.mod_clean_name_addr.cleanDbaName(pInput.org_name);
				
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     		:= tempTypeCd;
		//2 names requre special handling
		mariParse         		:= MAP(TrimNAME_ORG='JOHN M SALES' => 'MD',  				  //func_is_company sees this name as company
																 TrimNAME_ORG='JOYCE CENTER JEFFREY' => 'MD',		//func_is_company sees this name as company
																 TrimNAME_ORG='LOAN T. NGUYEN' => 'MD',		      //func_is_company sees this name as company
																 TrimNAME_ORG='JULIE LOAN NGUYEN' => 'MD',  				  //func_is_company sees this name as company
																 TrimNAME_ORG='LISA M SOUTHERN' => 'MD',		//func_is_company sees this name as company
																 TrimNAME_ORG='KIM LOAN MAI PHAM' => 'MD',		      //func_is_company sees this name as company
																 TrimNAME_ORG='MITCHELL P. SCHOOLMEYER' => 'MD',		      //func_is_company sees this name as company
																 prof_license_mari.func_is_company(TrimNAME_ORG) = TRUE => 'GR',
																 prof_license_mari.func_is_company(TrimNAME_ORG) = FALSE => 'MD',
																 tempMariParse);
			
		prepNAME_ORG					:= 	trimNAME_ORG;
				
		tmpNick_Name					:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'nick');
		rmv_NickName					:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'strip_nick');		
	
		tempNick							:= IF(StringLib.stringfind(prepNAME_ORG,'\'',2) >0,
																REGEXFIND('^(.*)\'(.*)\'(.*)$',prepNAME_ORG,2),tmpNick_Name);

	  rmvNickName					:= IF(StringLib.stringfind(prepNAME_ORG,'\'',2) >0,
																REGEXREPLACE('\'(.*)\'',prepNAME_ORG,''),rmv_NickName);;
	
		removeSuffix          := stringlib.stringcleanspaces(Stringlib.Stringfindreplace(REGEXREPLACE(SUFFIX_PATTERN, rmvNickName,''),'"',''));
		TmpSufx               := REGEXFIND(SUFFIX_PATTERN, rmvNickName,0);		
		
		StdNAME_ORG						:= IF(removeSuffix != ' ' AND NOT Prof_License_Mari.func_is_company(removeSuffix), 
																removeSuffix, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(removeSuffix));
		// use the right parser for name field
	
    ClnNAME_ORG					:=   MAP(TrimNAME_ORG='SANDRIA L BEAUTY'              => 'MS   SANDRIA             L                   BEAUTY                   99',//cleanFMLName treat first name as the last name
		                             REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 tempTypeCd = 'GR' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 tempTypeCd = 'GR' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(removeSuffix),
											 					 tempTypeCd = 'MD' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(removeSuffix),
																 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 '');	
		re_clean_Name_ORG   := IF(tempTypeCd = 'MD' AND TRIM(ClnNAME_ORG[46..65],LEFT,RIGHT) = '',Address.CleanPersonFML73(removeSuffix),ClnNAME_ORG);	
	  CleanNAME_ORG       := IF(re_clean_Name_ORG <> '', re_clean_Name_ORG,
		                             MAP(//Following names are seen as company name by func_is_company and cleanFMLName fails to parse them as well
																 TrimNAME_ORG='JOHN M SALES'           => 'MR   JOHN                M                   SALES                    99',
																 TrimNAME_ORG='JOYCE CENTER JEFFREY'   => 'MS   JOYCE               CENTER              JEFFREY                  99',
																 TrimNAME_ORG='LOAN T. NGUYEN'         => 'MR   LOAN                T.                  NGUYEN                   99',
																 TrimNAME_ORG='B.R.H. SNAPPY JACOBS'   => 'MR   B.R.H               SNAPPY              JACOBS                   99',
																 TrimNAME_ORG='LINDA JO WMS.-CARTER'   => 'MS   LINDA               JO WMS              CARTER                   99',
																 TrimNAME_ORG='BRENDA JT WATERMAN'     => 'MS   BRENDA              JT                  WATERMAN                 99',
							        	         TrimNAME_ORG='KATHRYN L. F. DAVIS MCLINDON'=> 'MS   KATHRYN             L. F. DAVIS         MCLINDON                 99',
													  	   TrimNAME_ORG='BARBARA B J JEAN BAKER' => 'MS   BARBARA             B J JEAN            BAKER                    99', 
																 TrimNAME_ORG='JULIE LOAN NGUYEN'      => 'MS   JULIE               LOAN                NGUYEN                   99',
							        	         TrimNAME_ORG='LISA M SOUTHERN'        => 'MS   LISA                M                   SOUTHERN                 99',
													  	   TrimNAME_ORG='KIM LOAN MAI PHAM'      => 'MS   KIM                 LOAN MAI            PHAM                     99',
																 TrimNAME_ORG='MITCHELL P. SCHOOLMEYER'=> 'MR   MITCHELL            P.                  SCHOOLMEYER              99',
																 StdNAME_ORG)
		                         );

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
															
		SELF.NAME_FIRST				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT),'');
		SELF.NAME_MID					:= IF(mariParse='MD',TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT),'');
		SELF.NAME_LAST				:= IF(mariParse='MD',TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT),'');
		SELF.NAME_SUFX				:= IF(mariParse='MD' and TRIM(TmpSufx,LEFT,RIGHT) <> '',TRIM(TmpSufx,LEFT,RIGHT),TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT));
		
		SELF.NAME_NICK				:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tmpNick_Name,''),
																StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tmpNick_Name,''),
																SELF.type_cd = 'GR' => '',
																tempNick);
		//Use address cleaner to clean address
		trimAddress1          := ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
		trimAddress2          := ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
  		
		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(trimAddress1+' '+trimAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.CITY_1+' '+pInput.STATE_1 +' '+
		                                                     MAP(LENGTH(TRIM(pInput.ZIP))=3=>'00'+TRIM(pInput.ZIP),
																												     LENGTH(TRIM(pInput.ZIP))=4=>'0'+TRIM(pInput.ZIP),
																														 TRIM(pInput.ZIP))); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  // Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(pInput.CITY_1));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE_1));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_CNTY_1    	:= ut.CleanSpacesAndUpper(pInput.COUNTY);

		// phone
		TrimPhone             := StringLib.StringFilter(pInput.tele_1,'0123456789');
		// SELF.PHN_PHONE_1 			:= ut.CleanPhone(TrimPhone);
		// SELF.PHN_MARI_1  			:= ut.CleanPhone(TrimPhone);
		ClnPhone              := ut.CleanPhone(TrimPhone);
		SELF.PHN_PHONE_1      := IF(ClnPhone = '0000000000','',ClnPhone);
		SELF.PHN_MARI_1       := IF(ClnPhone = '0000000000','',ClnPhone);
		 
		// email
		SELF.EMAIL  					:= ut.CleanSpacesAndUpper(pInput.email_1);
		
		//Prepare the input to address cleaner
		trimAddress1_sup      := ut.CleanSpacesAndUpper(pInput.ADDRESS1_2);
		trimAddress2_sup      := ut.CleanSpacesAndUpper(pInput.ADDRESS2_2);
		trimAddress3_sup      := ut.CleanSpacesAndUpper(pInput.ADDRESS3_2);
		temp_preaddr1_sup 		:= StringLib.StringCleanSpaces(trimAddress1_sup+' '+trimAddress2_sup+' '+trimAddress3_sup); 
		temp_preaddr2_sup			:= StringLib.StringCleanSpaces(pInput.CITY_2+' '+pInput.STATE_2 +' '+
		                                                     MAP(LENGTH(TRIM(pInput.ZIP_2))=3=>'00'+TRIM(pInput.ZIP_2),
																												     LENGTH(TRIM(pInput.ZIP_2))=4=>'0'+TRIM(pInput.ZIP_2),
																														 TRIM(pInput.ZIP_2))); 
		clnAddrAddr2					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1_sup,temp_preaddr2_sup); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_2				:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		AddrWithContact2			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
	  // Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2			:= IF(AddrWithContact2 != ' ' AND tmpADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_2));	
		SELF.ADDR_ADDR2_2			:= IF(AddrWithContact2 != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2		  := IF(TRIM(clnAddrAddr2[65..89])<>'',TRIM(clnAddrAddr2[65..89]),ut.CleanSpacesAndUpper(pInput.CITY_2));
		SELF.ADDR_STATE_2		  := IF(TRIM(clnAddrAddr2[115..116])<>'',TRIM(clnAddrAddr2[115..116]),ut.CleanSpacesAndUpper(pInput.STATE_2));
		SELF.ADDR_ZIP5_2		  := IF(TRIM(clnAddrAddr2[117..121])<>'',TRIM(clnAddrAddr2[117..121]),TRIM(pInput.ZIP_2,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_2		  := clnAddrAddr2[122..125];
		
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  	:= IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY_1 + pInput.STATE_1 + pInput.ZIP,LEFT,RIGHT) != '','B','');		
		
		// assign officename
		trimContact						:= ut.CleanSpacesAndUpper(pInput.contact);
		tempNameOff						:= IF(Prof_License_mari.func_is_company(trimContact),trimContact,'');

		trimNAME_OFFICE     	:= REGEXREPLACE('(L\\.L\\.C\\.|L L C)',tempNameOff,'LLC');
		SELF.NAME_OFFICE    	:= trimNAME_OFFICE;
		
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
		tempContact2    			:= IF(Prof_License_Mari.func_is_company(trimContact),'',trimContact);
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
		SELF.NAME_CONTACT_MID	  := TRIM(parseContact[41..56],LEFT,RIGHT);
		SELF.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX  := TRIM(parseContact[131..134],LEFT,RIGHT);
		SELF.NAME_CONTACT_TTL	  := MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => 'RECEIVER',
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
		
		//New field Application Date. Save it in provnote_2 for now
		//APP_DT exists after 20130314
 		SELF.PROVNOTE_2				:= IF(pInput.APP_DT<>'',
   		                            'APPLICATION DATE=' + prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(pInput.APP_DT),
   																'');

		 // fields used to create mltreckey key are:
			// license number
			// license type
			// source update
			// name
			// address_1
			// dba
			// officename
		 
		//Use hash64 instead of hash32 to avoid dup key. 2/28/13 Cathy Tio 
		mltreckeyHash 				:= HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
																	 +TRIM(tempStdLicType,LEFT,RIGHT)
																	 +TRIM(src_cd,LEFT,RIGHT)
																	 +ut.CleanSpacesAndUpper(StdName_Org)
																	 +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
																	 +ut.CleanSpacesAndUpper(StripDBA)
																	 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
																	 +trimNAME_OFFICE
																	 +trimContact); 
		
		SELF.mltreckey 				:= IF(temp_dba1 != ' ',mltreckeyHash, 0);
		
			// fields used to create unique key are:
			// license number
			// license type
			// source update
			// name
			// address

		//Use hash64 instead of hash32 to avoid dup key. 2/28/13 Cathy Tio 		 
		SELF.cmc_slpk         := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
														 +ut.CleanSpacesAndUpper(pInput.ZIP)
														 +trimNAME_OFFICE
														 +trimContact);
									 

		SELF := [];
		
	END;

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
							   

	// Populate STD_LICENSE_STATUS field via translation on /*RAW_LICENSE_STATUS*/ PROVNOTE_3 field
	maribase_plus_dbas trans_lic_status(ds_map_clean L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF.provnote_3 := ' ';
		SELF := L;
	END;
	
	//cmvtranslation entry contains invalid characters for RENEWAL APPLICATION EMAILED TO LICENSEE.
	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
								TRIM(LEFT.provnote_3,LEFT,RIGHT)[1..39]= TRIM(RIGHT.fld_value,LEFT,RIGHT)[1..39]
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := IF(L.STD_LICENSE_TYPE='TSDEV','RLE',R.DM_VALUE1);
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

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
									 TRIM(LEFT.name_office,LEFT,RIGHT)	= TRIM(RIGHT.name_org_orig,LEFT,RIGHT)
									 AND LEFT.AFFIL_TYPE_CD in ['IN', 'BR'],
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
	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(o_Cmvtranslation,move_to_using, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
END;