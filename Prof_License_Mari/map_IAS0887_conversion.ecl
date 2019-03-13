/*2018-01-27T02:50:23Z (Sheng, Xia (RIS-BCT))
DF-20752 layout change
*/
// Purpose : map IAS0887 / Iowa Real Estate Commission & Appraisal / Real Estate raw data to common layout for MARI and PL use
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_IAS0887_conversion(STRING pVersion) := FUNCTION
	code 								:= 'IAS0887';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';


	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
  O_Cmv       := OUTPUT(Cmvtranslation);
	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';
  //Suffix Name Pattern
	Sufx_Pattern      := '( SR.| SR| JR.| JR| III| II| IV| VII| VI)';
	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';

	//Use address cleaner to clean address
	CoPattern 	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|REGULAR BAPTIST CAMP|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';
	//Move data from sprayed to using directory
 	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle','sprayed', 'using');	
	
	//input files
	rle_preClean  := Prof_License_Mari.file_IAS0887;
	ut.CleanFields(rle_preClean, rle);
	oRle				  := OUTPUT(rle);

	//Remove bad records before processing
	ValidFile	    	:= rle_preClean(TRIM(full_name,LEFT,RIGHT)+TRIM(last_Name,left,right) != ' ');

	//raw to MARIBASE layout
	Prof_License_Mari.layouts.base	transformToCommon(Prof_License_Mari.Layout_IAS0887.common pInput) :=TRANSFORM
	
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

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.SLNM);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE	 	:= src_st;
						
		//initialize raw_license_status from raw data
		tempRawStatus 				  := ut.CleanSpacesAndUpper(pInput.LIC_STATUS);				
		SELF.RAW_LICENSE_STATUS := tempRawStatus;
		
		// initialize raw_license_type from raw data ['B','F','S']
		tempRawType 					:= tempLicNum[1];
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																				
		// map raw license type to standard license type before profcode translations													 
		tempStdLicType 				:= IF(tempRawType = '',
															  REGEXFIND('(^[A-Z]+)[0-9]+', tempLicNum, 1),
															  tempRawType);														 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
		tempBrokerType        := ut.CleanSpacesAndUpper(pInput.Entity_type);// I meaning individual, F meaning firm, salesperson, broker
  GR_Type := ['F','T'];
		// assigning type code based on license type
		tempTypeCd		  			:= IF(tempStdLicType in GR_Type,'GR','MD');
		SELF.TYPE_CD      		:= tempTypeCd;
		tempMariParse     		:= tempTypeCd;
    mariParse             := map(tempBrokerType = 'I' => 'MD',
		                             tempBrokerType = 'F' AND tempStdLicType = 'B' => 'MD',
																               tempBrokerType = 'F' AND tempStdLicType = 'S' => 'MD',
																               tempBrokerType = 'F' AND tempStdLicType = 'F' => 'GR',
																							        tempStdLicType = 'T' => 'GR',
															              	 tempMariParse);		
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		//This logic can be simplified. Cathy 2/11/13
		//Some of the names are treated as company. Fix them.

		// Name parsing
		TrimFullName  := ut.CleanSpacesAndUpper(pInput.Full_Name);
		TrimLastName  := ut.CleanSpacesAndUpper(pInput.Last_Name);
		TrimFirstName := ut.CleanSpacesAndUpper(pInput.First_Name);
		TrimMidName   := ut.CleanSpacesAndUpper(pInput.Mid_Name);
		
		//Remove Nick Name
		tempLNick := Prof_License_Mari.fGetNickname(TrimLastName,'nick');
		tempFNick := Prof_License_Mari.fGetNickname(TrimFirstName,'nick');
		tempMNick := Prof_License_Mari.fGetNickname(TrimMidName,'nick');
		tempNick  := IF(SELF.TYPE_CD = 'MD', Prof_License_Mari.fGetNickname(TrimFullName,'nick'),'');
		
		stripNickLName := Prof_License_Mari.fGetNickname(TrimLastName,'strip_nick');
		stripNickFName := Prof_License_Mari.fGetNickname(TrimFirstName,'strip_nick');
		stripNickMName := Prof_License_Mari.fGetNickname(TrimMidName,'strip_nick');
		stripNickName  := Prof_License_Mari.fGetNickname(TrimFullName,'strip_nick');
		
		//Remove Suffix
		SUFFIX_PATTERN  := '( JR.$| JR$| SR.$| SR$| III$| II$| IV$)';	
		rmvSufxLName    := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickLName,''));
		rmvSufxFName    := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickFName,''));
		rmvSufxMName    := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickMName,''));
		rmvSufxName     := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickName,''));
		tmp_Suffix				 	:= StringLib.StringCleanSpaces(REGEXREPLACE(',',REGEXFIND(SUFFIX_PATTERN,stripNickName,0),''));
		
    ParsedName := Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvSufxName);
		// ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName);
    StdNAME_ORG			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimFullName);	
   	SELF.NAME_FIRST				:= IF(rmvSufxFName = '',TRIM(ParsedName[6..25],LEFT,RIGHT),rmvSufxFName);
   	SELF.NAME_MID					:= IF(rmvSufxMName = '',TRIM(ParsedName[26..45],LEFT,RIGHT),rmvSufxMName);
   	SELF.NAME_LAST				:= IF(rmvSufxLName = '',TRIM(ParsedName[46..65],LEFT,RIGHT),rmvSufxLName);
   	SELF.NAME_SUFX				:= IF(tmp_Suffix = '',TRIM(ParsedName[66..70],LEFT,RIGHT),tmp_Suffix);
		SELF.NAME_Nick  := tempNick;	
	  ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(SELF.NAME_LAST +' '+SELF.NAME_FIRST);
		SELF.NAME_ORG_PREFX		:= '';
		SELF.NAME_ORG				   	:= IF(ConcatNAME_FULL <> ' ', ConcatNAME_FULL,
		                           Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',TrimFullName,' CO')));
		SELF.NAME_ORG_SUFX	  := '';
		SELF.NAME_ORG_ORIG    := IF(TrimFullName!= '',TrimFullName,TrimFirstName + ' ' + TrimMidName + ' ' +TrimLastName);	
		SELF.NAME_FORMAT  := 'F';
		
		// assign officename and office parse field : GR if company, MD if individual 
		// TrimOffice          := REGEXFIND('^(.*) ((.*))$',ut.CleanSpacesAndUpper(pInput.FIRM_NAME),1);
		TrimOffice          := ut.CleanSpacesAndUpper(pInput.FIRM_NAME);
		OffieName         	:= IF(Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimOffice)<>'',
		               TRIM(Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimOffice),LEFT,RIGHT),
															 	TRIM(TrimOffice,LEFT,RIGHT));
		SELF.NAME_OFFICE    	:= MAP(tempTypeCd = 'MD' AND REGEXFIND(TRIM(SELF.NAME_ORG,LEFT,RIGHT), OffieName)=> '', 
		                             TRIM(OffieName,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(OffieName,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) =>'', 
																 TRIM(OffieName,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(OffieName,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(OffieName,ALL) = TRIM(REGEXREPLACE(',',SELF.NAME_ORG_ORIG,' '),ALL) => '',
																 OffieName);													
		SELF.OFFICE_PARSE   := IF(SELF.NAME_OFFICE != '',
		                          IF(Prof_License_Mari.func_is_company(OffieName),'GR','MD'),'');													

		SELF.NAME_MARI_ORG		:= IF(mariParse = 'GR' ,StdNAME_ORG, IF(SELF.NAME_OFFICE != '',SELF.NAME_OFFICE,'')); //only business names
		
		// Reformatting dates from MM/DD/YYYY to YYYYMMDD
		//The date format has changed from yyyy-mm-dd to mm/dd/yyyy in 20130329 input. 4/4/13 Cathy
		tempIssueDt         	:= prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.issue_date);
		SELF.ORIG_ISSUE_DTE		:= (STRING) tempIssueDt;
		//input date format YYYY-MM-DD	
		SELF.EXPIRE_DTE		   	:= IF(pInput.exp_date='','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.exp_date));
		tempCurIssueDt      	:= prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.effective_date);
		SELF.CURR_ISSUE_DTE 	:= (STRING) tempCurIssueDt;

		// SELF.PROVNOTE_3				  := IF(tempRawType = '','{LICENSE TYPE ASSIGNED};','') + 
		                         // '{LICENSE_STATUS ASSIGNED};';	 

    //Parsing address
	 	trimAddress          := ut.CleanSpacesAndUpper(pInput.ADDR_LINE1);
		
	  //Extract company name
		tmpNameContact				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress, CoPattern);

		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.CITY+' '+pInput.STATE +' '+pInput.ZIP); 
		clnAddrAddr1				 	:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																           StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		 := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(pInput.CITY));
		SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE));
		SELF.ADDR_ZIP5_1		 := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		 := clnAddrAddr1[122..125];

		SELF.ADDR_CNTY_1   := ut.CleanSpacesAndUpper(pInput.COUNTY);
		SELF.ADDR_CNTRY_1  := ut.CleanSpacesAndUpper(pInput.COUNTRY);

		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	:= IF(TRIM(pInput.ADDR_LINE1 + pInput.CITY + pInput.STATE + pInput.ZIP,LEFT,RIGHT) != '','B','');


    //Parsing address
	 	trimAddress2          := ut.CleanSpacesAndUpper(pInput.CONT_ADDR_LINE1);
		
	  //Extract company name
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);

		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_contaddr1 				:= StringLib.StringCleanSpaces(clnAddress2); 
		temp_contaddr2 				:= StringLib.StringCleanSpaces(pInput.CONT_CITY+' '+pInput.CONT_STATE +' '+pInput.CONT_ZIP); 
		clnAddrAddr2				 	:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_contaddr1,temp_contaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_2				:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		AddrWithContact2				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2		:= IF(AddrWithContact2 != ' ' AND tmpADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																           StringLib.StringCleanSpaces(tmpADDR_ADDR1_2));	
		SELF.ADDR_ADDR2_2		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2		 := IF(TRIM(clnAddrAddr2[65..89])<>'',TRIM(clnAddrAddr2[65..89]),ut.CleanSpacesAndUpper(pInput.CONT_CITY));
		SELF.ADDR_STATE_2		:= IF(TRIM(clnAddrAddr2[115..116])<>'',TRIM(clnAddrAddr2[115..116]),ut.CleanSpacesAndUpper(pInput.CONT_STATE));
		SELF.ADDR_ZIP5_2		 := IF(TRIM(clnAddrAddr2[117..121])<>'',TRIM(clnAddrAddr2[117..121]),TRIM(pInput.CONT_ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_2		 := clnAddrAddr2[122..125];
		
		//opulate email field
		//email field is removed from input file since 20130802
		//uncomment email assignment. This field is included in 20131008
		//populate phone field
		SELF.PHN_PHONE_1    := IF(ut.CleanSpacesAndUpper(pInput.PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.PHONE,'0123456789'));
		SELF.PHN_MARI_1     := IF(ut.CleanSpacesAndUpper(pInput.PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.PHONE,'0123456789'));
		//populate fax field
		SELF.PHN_FAX_1      := IF(ut.CleanSpacesAndUpper(pInput.FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.FAX,'0123456789'));
		SELF.PHN_MARI_FAX_1 := IF(ut.CleanSpacesAndUpper(pInput.FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.FAX,'0123456789'));

		SELF.ORIGIN_CD				:= CASE(ut.CleanSpacesAndUpper(pInput.LICENSE_METHOD),
																	'EXAM' 	=> 	'E',
																	'RECIPROCITY'		=>	'R',
																	'UNDEFINED'  => 'U',
																	'UNKNOWN'  => 'U',  // NEW CODES   
																	'RULE 5.3'  => '5',
																	'APPLICATN' => 'O',
																	'RCPRCTY'   => 'R',
																	'CREDENTIAL' => 'C',
																	'TESTING'  => 'O',
																	'OTHER'    => 'O',
																	'ORIGINAL' => 'L', 
                 'WAIVER' => 'W', 
																	'');			
		
		
		//assign affiliation type codes
		SELF.affil_type_cd 	:= MAP(tempTypeCd = 'GR' => 'CO',
															 tempTypeCd = 'MD' => 'IN',
															 ' ');
																		
		//fields used to create mltreckey key are:
		//license number
		//license type
		//source update
		//name
		//address_1
		//dba
		//officename

		//Use hash64 to avoid dup keys		 
		// mltreckeyHash 			:= HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 // +TRIM(tempStdLicType,LEFT,RIGHT)
														 // +TRIM(src_cd,LEFT,RIGHT)
														 // +ut.CleanSpacesAndUpper(StdName_Org)
														 // +ut.CleanSpacesAndUpper(pInput.ADDR_LINE1)
														 // +ut.CleanSpacesAndUpper(StripDBA)
														 // +ut.CleanSpacesAndUpper(TrimOffice)); 
		
	SELF.mltreckey 			:= 0;
				
		//fields used to create unique key are:
		//	license number
		//	license type
		//	source update
		//	name
		//	address
		//	office name
						 
		SELF.cmc_slpk        := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.ADDR_LINE1)
														 +ut.CleanSpacesAndUpper(pInput.CITY)
														 +ut.CleanSpacesAndUpper(pInput.STATE)
														 +ut.CleanSpacesAndUpper(pInput.ZIP)
														 +ut.CleanSpacesAndUpper(TrimOffice));
		SELF := [];		   		   
		
	END;

	ds_map := PROJECT(ValidFile, transformToCommon(LEFT));

	// Clean-up Fields
	Prof_License_Mari.layouts.base	transformClean(ds_map pInput) :=TRANSFORM
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
	ds_map_clean	:= PROJECT(ds_map , transformClean(LEFT));
							   
	//Skip county id to name conversion because the result is not consistant with what vendor provided in previous updates and
	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layouts.base trans_lic_status(ds_map_clean L, Cmvtranslation R) :=TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
														LEFT.STD_SOURCE_UPD=RIGHT.source_upd   //Added 4/4/13
														AND TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
														AND RIGHT.fld_name='LIC_STATUS',
														trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) :=TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_base := JOIN(ds_map_stat_trans, Cmvtranslation,
														LEFT.STD_SOURCE_UPD=RIGHT.source_upd //Added 4/4/13
														AND TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
														AND RIGHT.fld_name='LIC_TYPE' 
														AND RIGHT.dm_name1 = 'PROFCODE',
														trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) :=TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
							TRIM(LEFT.name_office[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org_orig[1..50],LEFT,RIGHT)
							AND TRIM(LEFT.addr_addr1_1[1..15],LEFT,RIGHT) = TRIM(RIGHT.addr_addr1_1[1..15],LEFT,RIGHT)
							AND TRIM(LEFT.addr_addr2_1[1..15],LEFT,RIGHT) = TRIM(RIGHT.addr_addr2_1[1..15],LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);
		SELF := L;
	END;

	OutRecs := PROJECT(DEDUP(SORT(DISTRIBUTE(ds_map_affil,HASH(name_org)),RECORD,LOCAL),RECORD,LOCAL), xTransPROVNOTE(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmv, move_to_using, oRle,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;