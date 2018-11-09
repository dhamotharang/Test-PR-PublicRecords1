//************************************************************************************************************* */	
//  The purpose of this development is take ARS0835 Professional License raw files and convert them to a common
//  professional license (BASE) layout to be used for MARI and PL_BASE development.
//	01/04/2013 Cathy Tio - Modified for new layout change (removal of DOB) and new work flow
//	01/11/2013 Cathy Tio - Set LAST_UPD_DTE to pVersion
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_ARS0835_conversion(STRING pVersion) := FUNCTION

	code 		:= 'ARS0835';
	src_cd	:= 'S0835';
	src_st	:= 'AR';	//License state
	STRING8 process_date:=(STRING8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

	//Move file(s) from ::sprayed:: to ::using::
	move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active', 'sprayed', 'using');
	                          Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive', 'sprayed', 'using');
														);

	//AR input files
  ds_AR_Active		:= Prof_License_Mari.files_ARS0835.active(LENGTH(TRIM(Prof_License_Mari.files_ARS0835.Active.LicenseNum,LEFT, RIGHT)) > 4);	
	//Remove bad records before processing
	Valid_AR_Active	:= ds_AR_Active(TRIM(LastName,LEFT,RIGHT)+TRIM(FirstName,LEFT,RIGHT) <> '' 
																	AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LastName))
																	AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FirstName)));

	oActive := OUTPUT(Valid_AR_Active);
	
  ds_AR_Inactive	:= Prof_License_Mari.files_ARS0835.inactive(LENGTH(TRIM(LicenseNum,LEFT, RIGHT)) > 4
																	/*AND TRIM(Company, LEFT, RIGHT) <>' '*/);    //There are some invalid records that non-blank company name
	//Remove bad records before processing
	Valid_AR_Inactive	:= ds_AR_Inactive(TRIM(LastName,LEFT,RIGHT)+TRIM(FirstName,LEFT,RIGHT) <> '' 
																	AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LastName))
																	AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FirstName)));
																	

	oInactive := OUTPUT(Prof_License_Mari.files_ARS0835.inactive);

	//Dataset reference files for lookup joins
	//ds_License_Desc		:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0835');;
	//ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
	//ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
	//ds_Src_Desc				:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0835');
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	ARCommonDest		:= '~thor_data400::in::prolic::mari::'+pVersion+'::'+src_cd+'';


//Prof License ARS835_Active layout to Common
	Prof_License_Mari.layouts.base	transformActToCommon(Prof_License_Mari.layout_ARS0835.Common L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;						 //yyyymmdd
		SELF.STAMP_DTE				:= pVersion; 					 	 //yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_DESC		:= ' ';
		
		//Added based on the implementation from AKS0376
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE		:= thorlib.wuid()[2..9];


		//Corp(GR) or Individual(MD) code
		SELF.TYPE_CD				 := 'MD';  
		
		trimNAME_LAST				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.LastName);
		trimNAME_FIRST			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirstName);
		trimNAME_MID				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.MiddleName);	
		trimNAME_SUFX				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Suffix);
		trimNAME_FULL       := Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FullName);

		
		tmpNameOffice				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Company);
		stripNameOffice			:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tmpNameOffice);
					


		tmpNAME_DBA						:= IF(REGEXFIND('( DBA )',tmpNameOffice), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOffice),'');
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		SELF.NAME_MARI_DBA	  := tmpNAME_DBA;
		SELF.NAME_DBA					:= stdNAME_DBA;
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		
		tempFullName					:= IF(trimNAME_FULL <>'', TRIM(trimNAME_FULL,LEFT,RIGHT),
																stringlib.stringcleanspaces(trimNAME_FIRST+' '+trimNAME_MID+' '+trimNAME_LAST));	
	  tempFNick      := Prof_License_Mari.fGetNickname(trimNAME_FIRST,'nick');
	  tempMNick	     := Prof_License_Mari.fGetNickname(trimNAME_MID,'nick');
   	tempLNick	     := Prof_License_Mari.fGetNickname(trimNAME_LAST,'nick');
		tempNick       := Prof_License_Mari.fGetNickname(tempFullName,'nick');
		
  	stripNickFName := Prof_License_Mari.fGetNickname(trimNAME_FIRST,'strip_nick');
	  stripNickMName := Prof_License_Mari.fGetNickname(trimNAME_MID,'strip_nick');
	  stripNickLName := Prof_License_Mari.fGetNickname(trimNAME_LAST,'strip_nick');				
		nick_name 		 := MAP(tempFNick <> '' => StringLib.StringCleanSpaces(tempFNick),
													tempMNick <> '' => StringLib.StringCleanSpaces(tempMNick),
													tempNick  <> '' => StringLib.StringCleanSpaces(tempNick),
													'');		
		SELF.NAME_NICK				:= nick_name;											

		temp_name			 := Prof_License_Mari.fGetNickname(tempFullName, 'strip_nick');

  	GoodFirstName	 := IF(tempFNick != '',stripNickFName,trimNAME_FIRST);
	  GoodMidName	   := IF(tempMNick != '',stripNickMName,trimNAME_MID);
	  GoodLastName	 := IF(tempLNick != '',stripNickMName,trimNAME_LAST);		
		
		tempSufxName	 := MAP(trimNAME_SUFX <> ''=>trimNAME_SUFX,
		                      REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_LAST,NOCASE)=>REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_LAST,2,NOCASE),
                          REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_MID,NOCASE)=>REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_MID,2,NOCASE),
													REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_FIRST,NOCASE)=>REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_FIRST,2,NOCASE),
													'');
													
    prepNAME_FIRST         := IF(GoodFirstName<>'' AND tempSufxName = '',TRIM(GoodFirstName,LEFT,RIGHT),
		                            IF(GoodFirstName<>'' AND tempSufxName <> '', REGEXREPLACE(tempSufxName,GoodFirstName,''),
																   TrimNAME_First));
		GoodNAME_FIRST         := IF(REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',prepNAME_FIRST,NOCASE),
														     REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',prepNAME_FIRST,1,NOCASE),
														     prepNAME_FIRST);		
		
		prepNAME_MID          := IF(GoodMidName<>'' AND tempSufxName = '',TRIM(GoodMidName,LEFT,RIGHT),
		                            IF(GoodMidName<>'' AND tempSufxName <> '', REGEXREPLACE(tempSufxName,GoodMidName,''),
																   TrimNAME_Mid));
		GoodNAME_MID          := IF(REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',prepNAME_MID,NOCASE),
														    REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',prepNAME_MID,1,NOCASE),
														    prepNAME_MID);		
															
		prepNAME_LAST         := IF(GoodLastName<>'' AND tempSufxName = '',TRIM(GoodLastName,LEFT,RIGHT),
		                            IF(GoodLastName<>'' AND tempSufxName <> '', REGEXREPLACE(tempSufxName,GoodLastName,''),
																   TrimNAME_LAST));
		goodNAME_LAST         := IF(REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',prepNAME_LAST,NOCASE),
														    REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',prepNAME_LAST,1,NOCASE),
														    prepNAME_LAST);														
		clnNAME_LAST          := REGEXREPLACE(',|(\\.)',goodNAME_LAST,'');
		SELF.NAME_PREFX     	:= '';		
		SELF.NAME_LAST        := clnNAME_LAST;
		SELF.NAME_FIRST				:= IF(TRIM(GoodFirstName,LEFT,RIGHT)<>'',GoodFirstName,
		                            IF(GoodFirstName = '' AND GoodMidName <> '',GoodMidName,''));			
		SELF.NAME_MID			  	:= IF(GoodFirstName = '' AND GoodName_MID != '','',GoodNAME_MID);			
		
		SELF.NAME_SUFX				:= TRIM(tempSufxName,LEFT,RIGHT);				
		tempNameOrg 					 := SELF.NAME_LAST+ ' '+SELF.NAME_FIRST;
		SELF.NAME_ORG 				:= stringlib.stringcleanspaces(tempNameOrg);
		
  SELF.NAME_OFFICE    := MAP(StringLib.StringFind(stripNameOffice, 'DBA',1) > 0=>TRIM(REGEXFIND('^(.*)DBA(.*)',stripNameOffice,1),LEFT,RIGHT),
		                           TRIM(stripNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID +SELF.NAME_LAST,ALL)=> '',
														               TRIM(stripNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL)=> '',
													                stripNameOffice);

		SELF.OFFICE_PARSE   := MAP(SELF.NAME_OFFICE != '' AND StringLib.StringFind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1) < 1 => 'GR',
															 SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) => 'GR',
															 SELF.NAME_OFFICE != '' AND REGEXFIND('(AND|APPRAISAL$|BRANCH|BLACKWOOD TEAM|COMMERCIAL|C0|DATA|'+
																																		'^INC|MARKETING|REMAX|SEARCHERS|THE)',SELF.NAME_OFFICE) => 'GR',
															 SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) 
															 AND NOT REGEXFIND('(AND|APPRIASAL$|BRANCH|BLACKWOOD TEAM|COMMERCIAL|C0|DATA|^INC|MARKETING|'+
																								'REMAX|SEARCHERS|THE)',SELF.NAME_OFFICE)=> 'MD','');		
		
		//Comment out next line because DOB is not in the input datasets
		//BOD is back starting 20130531
		SELF.BIRTH_DTE          := Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.DOB); //yyyymmdd
		//CEAccru - New field since 20130531. It is the continue-education accrued credit hours
		SELF.CONT_EDUCATION_ERND := TRIM(L.CEAccru);

		SELF.LICENSE_NBR				:= TRIM(L.LicenseNum,LEFT,RIGHT);
		SELF.OFF_LICENSE_NBR		:= IF(L.PBroker<>'',TRIM(L.PBroker,LEFT,RIGHT),' ');
		SELF.OFF_LICENSE_NBR_TYPE		:= IF(L.PBroker<>'','BROKER','');
		SELF.BRKR_LICENSE_NBR		:= IF(L.PBroker<>'',TRIM(L.PBroker,LEFT,RIGHT),' ');
		SELF.LICENSE_STATE			:= src_st;
		SELF.RAW_LICENSE_TYPE		:= SELF.LICENSE_NBR[1..2];
		SELF.STD_LICENSE_TYPE		:= SELF.RAW_LICENSE_TYPE;
		
		//This field is implicitly defined in the file name;
		SELF.RAW_LICENSE_STATUS	:= 'ACTIVE';
		SELF.PROVNOTE_3					:= '{LICENSE STATUS ASSIGNED}';
		
  	//Use default date of 17530101 for blank dates. Use this instead of norm_date2->date_slashed_mmddyyy_to_yyymmdd
		SELF.CURR_ISSUE_DTE			:= IF(L.IssueDate != '',
											            Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.IssueDate),'17530101');//yyyymmdd
		tmpOrigIssueDate				:= IF(L.FirstLicenseDate != '',
											            Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.FirstLicenseDate),'17530101'); //yyyymmdd									
		SELF.ORIG_ISSUE_DTE			:= IF(REGEXFIND('^[0-9]{8}$',tmpOrigIssueDate),tmpOrigIssueDate,'17530101');
 		SELF.EXPIRE_DTE					:= IF(L.ExpirationDate != '',
   											          Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.ExpirationDate),'17530101'); //yyyymmdd
	
		tmpNameOrgOrig			    := StringLib.StringCleanSpaces(trimNAME_LAST
		                               + IF(L.Suffix='',', ',' ' + Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Suffix)+', ')
											             + trimNAME_FIRST + ' ' + trimNAME_MID);
											
		SELF.NAME_ORG_ORIG    := tmpNameOrgOrig;
		SELF.NAME_FORMAT		  := 'L';	   
		SELF.NAME_MARI_ORG		:= IF(StringLib.StringFind(tmpNameOffice, 'DBA',1) > 0,
															TRIM(REGEXFIND('^(.*)DBA(.*)',tmpNameOffice,1),LEFT,RIGHT),
															tmpNameOffice);
		SELF.PHN_MARI_1				:= StringLib.StringFilter(L.Phone,'0123456789');
		SELF.ADDR_BUS_IND			:= IF(L.FirmAddress1 != '','B',''); // B = Business Address

		prepAddress11					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmAddress1);
		prepAddress21					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmAddress2);
		prepAddr_Line_11			:= prepAddress11 + ' ' + prepAddress21;
		prepAddr_Line_21			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmCity) + ' ' +
		                         Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmState) + ' ' +
														 Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmZip);
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_11,prepAddr_Line_21);
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact1			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact1 != '' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_1, NOCASE)	
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact1!='' => '',
																 tmpADDR_ADDR2_1='' => '',
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_1, NOCASE)	=> '',
																 TRIM(tmpADDR_ADDR1_1)=TRIM(tmpADDR_ADDR2_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr1[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr1[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];

		SELF.PHN_PHONE_1      := StringLib.StringFilter(L.Phone,'0123456789');
		SELF.ADDR_MAIL_IND		:= IF(L.Address1 != '','M',''); // M = MAIL Address

		prepAddress12					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Address1);
		prepAddress22					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Address2);
		prepAddr_Line_12			:= prepAddress12 + ' ' + prepAddress22;
		prepAddr_Line_22			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Address3);
		clnAddrAddr2					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_12,prepAddr_Line_22);
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_2				:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		AddrWithContact2			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_ADDR1_2			:= MAP(AddrWithContact2 != '' AND tmpADDR_ADDR2_2 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																 tmpADDR_ADDR1_2=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_2, NOCASE)	
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_2));
		SELF.ADDR_ADDR2_2			:= MAP(AddrWithContact2!='' => '',
																 tmpADDR_ADDR2_2='' => '',
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_2, NOCASE)	=> '',
																 TRIM(tmpADDR_ADDR1_2)=TRIM(tmpADDR_ADDR2_2) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2			:= TRIM(clnAddrAddr2[65..89]);
		SELF.ADDR_STATE_2			:= TRIM(clnAddrAddr2[115..116]);
   	SELF.ADDR_ZIP5_2			:= TRIM(clnAddrAddr2[117..121]);
   	SELF.ADDR_ZIP4_2			:= clnAddrAddr2[122..125];

		
		SELF.PHN_PHONE_2      := StringLib.StringFilter(L.Phone,'0123456789');
		SELF.AFFIL_TYPE_CD		:= 'IN';
	 
		/* fields used to create mltrec_key unique record split dba key are :
					 transformed license number
					 standardized license type
					 standardized source update
					 raw name containing dba name(s)
					 raw address
	*/
		SELF.MLTRECKEY				:= 0;
		
	/* Fields used to create unique Main key: license number(license type included), 
		 source update code, corp name, address, first name, last name, mid name
	*/
		SELF.CMC_SLPK  := HASH64(TRIM(SELF.LICENSE_NBR,LEFT,RIGHT)
														+ TRIM(SELF.OFF_LICENSE_NBR,LEFT,RIGHT)
														+ TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
														+ TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
														+ tmpNameOffice
														+ Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmADDRESS1)
														+ Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmADDRESS2)
													  + TRIM(L.FirmZIP));

		SELF.PREV_PRIMARY_KEY	:= 0;
		SELF.PREV_MLTRECKEY		:= 0;
		SELF.PREV_CMC_SLPK		:= 0;
		SELF.PREV_PCMC_SLPK		:= 0;
		SELF := [];
	END;

	ds_ARActiveStnd	:= PROJECT(Valid_AR_Active,transformActToCommon(LEFT));



	//Prof License ARS835_Inactve layout to Common
	Prof_License_Mari.layouts.base	transformInActToCommon(Prof_License_Mari.layout_ARS0835.Common L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;
		SELF.STAMP_DTE				:= pVersion; 					 //yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_DESC		:= ' ';
		
		//Added based on the implementation from AKS0376
 		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE		:= thorlib.wuid()[2..9];


		//Corp(GR) or Individual(MD) code
		SELF.TYPE_CD				 := 'MD';  
	

		trimNAME_LAST				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.LastName);
		trimNAME_FIRST			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirstName);
		trimNAME_MID				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.MiddleName);	
		trimNAME_SUFX				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Suffix);
		trimNAME_FULL       := Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FullName);
		

		tempFullName					:= IF(trimNAME_FULL <>'', TRIM(trimNAME_FULL,LEFT,RIGHT),
																stringlib.stringcleanspaces(trimNAME_FIRST+' '+trimNAME_MID+' '+trimNAME_LAST));	
	  tempFNick      := Prof_License_Mari.fGetNickname(trimNAME_FIRST,'nick');
	  tempMNick	     := Prof_License_Mari.fGetNickname(trimNAME_MID,'nick');
   	tempLNick	     := Prof_License_Mari.fGetNickname(trimNAME_LAST,'nick');
		tempNick       := Prof_License_Mari.fGetNickname(tempFullName,'nick');
		
  	stripNickFName := Prof_License_Mari.fGetNickname(trimNAME_FIRST,'strip_nick');
	  stripNickMName := Prof_License_Mari.fGetNickname(trimNAME_MID,'strip_nick');
	  stripNickLName := Prof_License_Mari.fGetNickname(trimNAME_LAST,'strip_nick');				
		nick_name 		 := MAP(tempFNick <> '' => StringLib.StringCleanSpaces(tempFNick),
													tempMNick <> '' => StringLib.StringCleanSpaces(tempMNick),
													tempNick  <> '' => StringLib.StringCleanSpaces(tempNick),
													'');		
		SELF.NAME_NICK				:= nick_name;											

		temp_name			 := Prof_License_Mari.fGetNickname(tempFullName, 'strip_nick');

  	GoodFirstName	 := IF(tempFNick != '',stripNickFName,trimNAME_FIRST);
	  GoodMidName	   := IF(tempMNick != '',stripNickMName,trimNAME_MID);
	  GoodLastName	 := IF(tempLNick != '',stripNickMName,trimNAME_LAST);		
		
		tempSufxName	 := IF(trimNAME_SUFX <> '',trimNAME_SUFX,
		                     IF(REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_LAST,NOCASE),
														REGEXFIND('(.*) (SR|JR|I|II|III|IV|V|VI|VII)(\\.?)$',trimNAME_LAST,2,NOCASE),
														''));
														
		SELF.NAME_PREFX     	:= '';
		SELF.NAME_FIRST				:= IF(TRIM(GoodFirstName,LEFT,RIGHT)<>'',GoodFirstName,
		                            IF(GoodFirstName = '' AND GoodMidName != '',GoodMidName,''));	
		SELF.NAME_MID			  	:= IF(GoodFirstName = '' AND GoodMidName != '','',GoodMidName);															
		prepNAME_LAST         := IF(GoodLastName<>'' AND tempSufxName = '',TRIM(GoodLastName,LEFT,RIGHT),
		                            IF(GoodLastName<>'' AND tempSufxName <> '', REGEXREPLACE(tempSufxName,GoodLastName,''),
																TrimNAME_LAST));
		clnNAME_LAST          := REGEXREPLACE(',|(\\.)',prepNAME_LAST,'');
		SELF.NAME_LAST        := clnNAME_LAST;
		SELF.NAME_SUFX				:= TRIM(tempSufxName,LEFT,RIGHT);				
		tempNameOrg 					:= SELF.NAME_LAST+ ' '+SELF.NAME_FIRST;
		SELF.NAME_ORG 				:= stringlib.stringcleanspaces(tempNameOrg);
		
									
		SELF.DBA_FLAG       := 0;       // VALID ENTRY- 1:TRUE, 0:FALSE

	  //DOB field has been removed  
		//DOB is back starting 20130531
		SELF.BIRTH_DTE      := Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.DOB); //yyyymmdd
		//CEAccru - New field since 20130531. It is the continue-education accrued credit hours
		SELF.CONT_EDUCATION_ERND := TRIM(L.CEAccru);
		
		SELF.LICENSE_NBR				:= TRIM(L.LicenseNum,LEFT,RIGHT);
		SELF.LICENSE_STATE			:= src_st;
		SELF.RAW_LICENSE_TYPE		:= SELF.LICENSE_NBR[1..2];
		SELF.STD_LICENSE_TYPE		:= SELF.RAW_LICENSE_TYPE;

		SELF.RAW_LICENSE_STATUS	:= 'INACTIVE';
		SELF.PROVNOTE_3					:= '{LICENSE STATUS ASSIGNED}';

	//Use default date of 17530101 for blank dates. Use this instead of norm_date2->date_slashed_mmddyyy_to_yyymmdd
		SELF.CURR_ISSUE_DTE		  := IF(L.IssueDate != '',
																  Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.IssueDate),'17530101');//yyyymmdd
		tmpOrigIssueDate				:= IF(L.FirstLicenseDate != '',
											            Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.FirstLicenseDate),'17530101'); //yyyymmdd									
		SELF.ORIG_ISSUE_DTE			:= IF(REGEXFIND('^[0-9]{8}$',tmpOrigIssueDate),tmpOrigIssueDate,'17530101');

 		SELF.EXPIRE_DTE					:= IF(L.ExpirationDate != '',
																	Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.ExpirationDate),'17530101'); //yyyymmdd

		SELF.ADDR_BUS_IND		  := IF(L.Address1 != '','B',''); // B = Bussines Address
								
		tmpNameOrgOrig			  := StringLib.StringCleanSpaces(trimNAME_LAST
		                               + IF(L.Suffix='',', ',' ' + Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Suffix)+', ')
											             + trimNAME_FIRST + ' ' + trimNAME_MID);
		SELF.NAME_ORG_ORIG    := tmpNameOrgOrig;

		SELF.NAME_FORMAT		  := 'L';				
		//Comment out next line. We should remove all characters other than digits. 1/7/2013 Cathy Tio
 		SELF.PHN_MARI_1			:= StringLib.StringFilter(TRIM(L.Phone, LEFT, RIGHT),'0123456789');

		prepAddress11					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Address1);
		prepAddress21					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.ADDRESS2);
		prepAddr_Line_11			:= prepAddress11 + ' ' + prepAddress21;
		prepAddr_Line_21			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.City) + ' ' +
		                         Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.State) + ' ' +
														 Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.ZIP);
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_11,prepAddr_Line_21);
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact1			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact1 != '' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_1, NOCASE)	
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact1!='' => '',
																 tmpADDR_ADDR2_1='' => '',
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_1, NOCASE)	=> '',
																 TRIM(tmpADDR_ADDR1_1)=TRIM(tmpADDR_ADDR2_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr1[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr1[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];

		SELF.PHN_PHONE_1    := StringLib.StringFilter(L.Phone,'0123456789');
		SELF.ADDR_MAIL_IND	:= MAP(StringLib.stringfind(L.ADDRESS2,',',2)>0 => 'M', 
																StringLib.stringfind(L.ADDRESS2,',',1)>0 AND
																REGEXFIND('^(([A-Za-z ][^\\,]+)[\\,]?[ ]([A-Z]{2}))',L.Address2) =>'M',
																StringLib.stringfind(L.ADDRESS2,',',1)>0 AND 
																REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,]?[ ]([0-9]{5}(-[0-9]{4})?))',L.Address2) => 'M',
																''); // M = MAIL Address
																
		// IF Address2 contains address, city,state,zip information
		tmpAddress2					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.Address2);																		
		SELF.ADDR_ADDR1_2		:= MAP(StringLib.stringfind(L.ADDRESS2, ',',2) > 0 =>
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Z]{2})[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,2),
															StringLib.stringfind(tmpAddress2,'VAN BUREN, AR',1) > 0 => '',
															StringLib.stringfind(L.ADDRESS2,',',1) > 0  =>
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,]?[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,2),
															'');
		SELF.ADDR_CITY_2    := MAP(StringLib.stringfind(L.ADDRESS2, ',',2) > 0 =>
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Z]{2})[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,3),
															StringLib.stringfind(tmpAddress2,'VAN BUREN, AR',1) > 0 =>
															REGEXFIND('^(([A-Za-z ][^\\,]+)[\\,]?[ ]([A-Z]{2}))',tmpAddress2,2),
															StringLib.stringfind(L.ADDRESS2,',',1) > 0 AND REGEXFIND('[0-9]{5}(-[0-9]{4})?', tmpAddress2) =>	
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,]?[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,3),
															StringLib.stringfind(L.ADDRESS2,',',1) > 0 AND REGEXFIND('^(([A-Za-z ][^\\,]+)[\\,]?[ ]([A-Z]{2}))',tmpAddress2) =>
															REGEXFIND('^(([A-Za-z ][^\\,]+)[\\,]?[ ]([A-Z]{2}))',tmpAddress2,2),'');
		SELF.ADDR_STATE_2  := MAP(StringLib.stringfind(L.ADDRESS2, ',',2) > 0 =>
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Z]{2})[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,4),
															StringLib.stringfind(L.ADDRESS2,',',1)> 0 =>
															REGEXFIND('^(([A-Za-z ][^\\,]+)[\\,]?[ ]([A-Z]{2}))',tmpAddress2,3),'');
		
		tmpZIP             := MAP(StringLib.stringfind(L.ADDRESS2, ',',2) > 0 =>
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Z]{2})[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,5),
															StringLib.stringfind(L.ADDRESS2,',',1) > 0 =>
															REGEXFIND('[0-9]{5}(-[0-9]{4})?', tmpAddress2,0),
															StringLib.stringfind(L.ADDRESS2,',',1) > 0 =>	
															REGEXFIND('^(([0-9A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,]?[ ]([0-9]{5}(-[0-9]{4})?))',tmpAddress2,4),
															'');
		SELF.ADDR_ZIP5_2			:= tmpZIP[1..5];
		SELF.ADDR_ZIP4_2			:= tmpZIP[7..10];
	
		SELF.PHN_PHONE_2      := StringLib.StringFilter(L.Phone,'0123456789');
		SELF.AFFIL_TYPE_CD		:= 'IN';
		FIRM_ID               := IF(L.FIRM_ID <> '0' AND L.Firm_ID <>'', L.FIRM_ID, '');		
		SELF.PROVNOTE_1 			:= IF(TRIM(FIRM_ID)<>'' OR TRIM(L.COMPANY)<>'',
		                            IF(TRIM(FIRM_ID)<>'','FIRM_ID='+TRIM(FIRM_ID)+',','')+
																IF(TRIM(L.COMPANY)<>'','COMPANY='+Prof_License_MARI.mod_clean_name_addr.TrimUpper(L.COMPANY),''),
																'');
	/* fields used to create mltrec_key unique record split dba key are :
			   transformed license number
			   standardized license type
			   standardized source update
			   raw name containing dba name(s)
			   raw address
		SELF.MLTRECKEY				:= 0;
					
		/* Fields used to create unique Main key: license number(include license type),source update code,
			 address, first name, last name, mid name
		*/
		//Use HASH64 instead of HASH32 to avoid dup keys
		SELF.CMC_SLPK         :=HASH64(TRIM(SELF.LICENSE_NBR,LEFT,RIGHT)
																 + TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
																 + TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																 //+ TRIM(SELF.CURR_ISSUE_DTE,LEFT,RIGHT)   //one agent has 2 records that have different curr_issue_dte
																 + Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmADDRESS1)
																 + Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FirmADDRESS2)
																 + TRIM(L.FirmZIP));
											 
		SELF.PREV_PRIMARY_KEY	:= 0;
		SELF.PREV_MLTRECKEY		:= 0;
		SELF.PREV_CMC_SLPK		:= 0;
		SELF.PREV_PCMC_SLPK		:= 0;
		SELF := [];
END;

ds_ARInactiveStnd	:= PROJECT(Valid_AR_Inactive,transformInActToCommon(LEFT));
ds_ARCommon		:= ds_ARActiveStnd + ds_ARInactiveStnd;

// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_ARCommon L, ds_Cmvtranslation R) := TRANSFORM
     SELF.STD_PROF_CD := R.DM_VALUE1;
   	SELF := L;
   END;
   
  ds_map_lic_trans := JOIN(ds_ARCommon, ds_Cmvtranslation,
   													LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
   													trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := TRANSFORM
     SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
   	SELF := L;
   END;
   
  ds_map_status_trans := JOIN(ds_map_lic_trans, ds_Cmvtranslation,
   														LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
   														trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);
   
	ds_ARCommon_Final := ds_map_status_trans;
						
	// Adding to Superfile
	d_final := OUTPUT(ds_ARCommon_Final, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);


  add_super := Prof_License_Mari.fAddNewUpdate(ds_ARCommon_Final(NAME_ORG_ORIG != ''));
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active', 'using', 'used'),
													 Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive', 'using', 'used'));

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oActive, oInactive, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;