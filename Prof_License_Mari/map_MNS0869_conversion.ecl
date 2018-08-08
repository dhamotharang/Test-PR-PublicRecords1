// MNS0869 / Minnesotas Bookstore /	Real Estate // raw data to common layout for MARI and PL use
#workunit('name','Yogurt: map_MNS0869_conversion'); 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_MNS0869_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MNS0869';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	STRING8 current_date:=(STRING8)Lib_StringLib.StringLib.GetDateYYYYMMDD();
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA | DBA: )(.*)';		//Pattern for DBA
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';		//pattern for internet companies

	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd); 
	Ocmv	              := OUTPUT(ds_Cmvtranslation);

	//input file(s)
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rea','sprayed', 'using');		 
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'rec','sprayed', 'using');
																	);
	rea       					:= Prof_License_Mari.files_MNS0869.rea;
	Orea								:= OUTPUT(rea);
	rec	      					:= Prof_License_Mari.files_MNS0869.rec(LICTYPE = 'RC');
	Orec								:= OUTPUT(rec);
											
	reaCommon	  := PROJECT(rea, TRANSFORM(Prof_License_Mari.layout_MNS0869.common, SELF := LEFT; SELF := []));										
	Orea_cmmn   := OUTPUT(reaCommon);
	
	recCommon	  := PROJECT(rec, TRANSFORM(Prof_License_Mari.layout_MNS0869.common, SELF := LEFT; SELF := []));
	Orec_cmmn   := OUTPUT(recCommon);

	ValidCommon := reaCommon + recCommon;
	
	ValidFile 	:= ValidCommon(TRIM(fname,LEFT,RIGHT)+TRIM(lname,LEFT,RIGHT)+TRIM(busname,LEFT,RIGHT) != ' ' 
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(fname))
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(lname))
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(busname))
									 );
	ut.CleanFields(ValidFile,clnValidFile);
	
	maribase_plus_dbas := RECORD,MAXLENGTH(5200)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_MNS0869.common pInput) := TRANSFORM
	
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

		//License number and state
		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.slnum);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE	 	:= src_st;
				
		//License type - MD or GR.
		tempRawType						:= ut.CleanSpacesAndUpper(pInput.lictype);
		tempTypeCd		  			:= IF(tempRawType[1..2] = 'RC','GR','MD');
		SELF.TYPE_CD      		:= tempTypeCd;
		
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		trimFname        			:= ut.CleanSpacesAndUpper(pInput.Fname);
		trimLname         		:= ut.CleanSpacesAndUpper(pInput.Lname);
		trimMname         		:= ut.CleanSpacesAndUpper(pInput.Mname);
		trimJRSR         			:= ut.CleanSpacesAndUpper(pInput.JRSR);
		tempName         			:= trimFname+' '+trimMname+' '+trimLname+' '+trimJRSR;
		trimBusName      			:= ut.CleanSpacesAndUpper(pInput.busName);
		tempName2        			:= IF(tempTypeCd = 'GR',trimBusName,tempName);
		tempTrimName     			:= tempName2;
		tempTrimNameFix6			:= Prof_License_Mari.mod_clean_name_addr.cleanDbaName(tempTrimName);
		TrimNAME_ORG		 			:= IF(REGEXFIND(DBApattern,tempTrimNameFix6) = TRUE,
																Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix6),
																tempTrimNameFix6);
		busDba								:= 	ut.CleanSpacesAndUpper(pInput.BUSDBA);	
		
		// assign mariparse to correctly parse individual names for business records
		tempMariParse     		:= tempTypeCd;
		mariParse         		:= MAP(prof_license_mari.func_is_company(TrimNAME_ORG) OR
																 REGEXFIND('([0-9]+|CARRLL|RL EST|HOUSING)', TrimNAME_ORG) => 'GR',
																 NOT prof_license_mari.func_is_company(TrimNAME_ORG) => 'MD',
																 tempMariParse);
				
		prepNAME_ORG					:= MAP(StringLib.stringfind(TrimNAME_ORG,'D/B/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'D/B/',' '),
																	StringLib.stringfind(TrimNAME_ORG,'T/A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T/A',' '),
																	StringLib.stringfind(TrimNAME_ORG,'T\\A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T\\A',' '),
																	StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
																	StringLib.stringfind(TrimNAME_ORG,'\\',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'\\',' '),
																	trimNAME_ORG);
												 
		//Removing NickName from Corporate NAME field
		tempNick 							:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(prepNAME_ORG,'strip_nick');

		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		StdNAME_ORG						:= IF(rmvQuoteORG != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																rmvQuoteORG, 
																Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));

		// use the right parser for name field
		tmpCleanNAME_ORG					:= MAP(REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																  REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																  REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																  REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																  REGEXFIND('(AFFORDABLE HOUSING|RL EST$|^.* LLLP$| SVCS)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 tempTypeCd = 'GR' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
  															 tempTypeCd = 'GR' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
																 // tempTypeCd = 'GR' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(rmvQuoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(rmvQuoteORG),
																 // tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 StdNAME_ORG);
		
		CleanNAME_ORG					:= IF(tempTypeCd = 'GR' AND mariParse = 'MD' AND LENGTH(TRIM(tmpCleanNAME_ORG[46..65])) < 2, '', tmpCleanNAME_ORG);
		tmpLName							:= TRIM(CleanNAME_ORG[46..65]);												
		
	  // use the right parser for name field
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
	
		//Terri's review comment(BUG 124107) - 3. NAME_ORG is set to last name + first name for MD
		SELF.NAME_ORG 				:= MAP(mariParse='MD' AND LENGTH(tmpLName)>1=> stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[6..25]),
																 tempTypeCd = 'GR' AND mariParse = 'MD' AND LENGTH(TRIM(tmpCleanNAME_ORG[46..65])) < 2 => StdNAME_ORG,
																 mariParse='MD' AND LENGTH(tmpLName)<2 AND trimLname != ''=> trimLname + ' ' + trimFname,
																 REGEXFIND(IPpattern,StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(CleanNAME_ORG),
																 CleanNAME_ORG);
		
		SELF.NAME_ORG_ORIG		:= tempTrimName;    //Names before we clean it
		//Terri's review comment(BUG 124107) - 1. Set the name format.
		SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG_ORIG<>'','F','');
	
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

		SELF.NAME_FIRST				:= IF(mariParse='MD',
																IF(LENGTH(tmpLName)<2 AND trimFname<>' ',
																	 trimFname,
																   TRIM(CleanNAME_ORG[6..25],LEFT,RIGHT)),
																'');
		SELF.NAME_MID					:= IF(mariParse='MD',
																IF(LENGTH(tmpLName)<2,
																	 trimMname,
																   TRIM(CleanNAME_ORG[26..45],LEFT,RIGHT)),
																'');
		SELF.NAME_LAST				:= IF(mariParse='MD',
																IF(LENGTH(tmpLName)<2 AND trimLname<>' ',
																	 trimLname,
																   TRIM(CleanNAME_ORG[46..65],LEFT,RIGHT)),
																'');
		SELF.NAME_SUFX				:= IF(mariParse='MD',
																IF(LENGTH(tmpLName)<2,
																	 trimJRSR,
																   TRIM(CleanNAME_ORG[66..70],LEFT,RIGHT)),
																'');
		SELF.NAME_NICK				:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
																	StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
																	TRIM(SELF.NAME_LAST)='' AND TRIM(SELF.NAME_FIRST)='' => '',
																	tempNick);


		//License type: raw and standardized.
		SELF.RAW_LICENSE_TYPE := tempRawType;
				
		// business rules for license type
		templim1 							:= IF(ut.CleanSpacesAndUpper(pInput.limit1) = 'N','',
		                            IF(ut.CleanSpacesAndUpper(pInput.limit1) IN ['LLP','LLLP'],'LL',ut.CleanSpacesAndUpper(pInput.limit1)));
		templim2 							:= IF(ut.CleanSpacesAndUpper(pInput.limit2) = 'N','',ut.CleanSpacesAndUpper(pInput.limit2));
		templim3 							:= IF(ut.CleanSpacesAndUpper(pInput.limit3) = 'N','',ut.CleanSpacesAndUpper(pInput.limit3));
		templim4 							:= IF(ut.CleanSpacesAndUpper(pInput.limit4) = 'N','',ut.CleanSpacesAndUpper(pInput.limit4));
		templim5 							:= IF(ut.CleanSpacesAndUpper(pInput.limit5) = 'N','',ut.CleanSpacesAndUpper(pInput.limit5));
		
		templim1_2 						:= templim1;
		templim2_2 						:= IF(templim2 = 'Y' AND tempRawType IN ['RC','RA','CL'],'2',templim2);
		templim3_2 						:= IF(templim3 = 'Y' AND tempRawType IN ['RC','RA','CL'],'3',templim3);
		templim4_2 						:= IF(templim4 = 'Y' AND tempRawType IN ['RC','RA','CL'],'4',templim4);
		templim5_2 						:= IF(templim5 = 'Y' AND tempRawType IN ['RC','RA','CL'],'5',templim5);
		
		tempRawType2 					:= IF(tempRawType IN ['RC','RA','CL','AP'],tempRawType+templim1_2+templim2_2+templim3_2+templim4_2+templim5_2,tempRawType);
		tempRawType3 					:= IF(tempRawType2 = 'RA065','RA4',tempRawType2);
																																								
		// map raw license type to standard license type before profcode translations
		tempStdLicType        := tempRawType3;														 
		SELF.STD_LICENSE_TYPE := tempStdLicType;

		// assigning dates per business rules
		trimExpDt            	:= ut.CleanSpacesAndUpper(pInput.expdt);
		SELF.EXPIRE_DTE		   	:= IF(trimExpDt='' OR trimExpDt='NULL','17530101',trimExpDt);
		trimIssueDt          	:= ut.CleanSpacesAndUpper(pInput.issuedt);
		SELF.ORIG_ISSUE_DTE  	:= IF(trimExpDt='','17530101',trimIssueDt);
		trimCurIssueDt       	:= ut.CleanSpacesAndUpper(pInput.curissuedt);
		SELF.CURR_ISSUE_DTE  	:= IF(trimExpDt='','17530101',trimCurIssueDt);
				
		//Phone - digits only
		clnPhone							:= StringLib.StringFilter(pInput.telephone,'0123456789');
		SELF.PHN_PHONE_1 			:= IF(clnPhone = '0000000000','',ut.CleanPhone(clnPhone));
		SELF.PHN_MARI_1  			:= IF(clnPhone = '0000000000','',ut.CleanPhone(clnPhone));				//Phone # before running through out cleaning process
					
		//initialize raw_license_status from raw data
		tempRawStatus 				:= ut.CleanSpacesAndUpper(pInput.licstat);
		tempRawStatus2 				:= MAP(tempRawStatus = ' ' AND trimExpDt > current_date => 'ACTIVE',
																	tempRawStatus = ' ' AND trimExpDt < current_date => 'INACTIVE',
																	tempRawStatus);	
		SELF.RAW_LICENSE_STATUS := tempRawStatus2;
					 
		//Process addresses
   		NAME_PATTERN					:= '(^SYNTHESYS .*$|^REALTY WORLD ROGER MAKI REALTY$|^REALTY WORLD ROGER MAKI|.* REAL ESTATE$|.* INSURANCE$|'+
   		                         '^KATCO$|.* SALES$|.* CARMEL[ ]+PC$|.* AMERICAN REO$|.* APPRAISAL SERV$|.* SHOWCASE PROPERTIE$|' +
   		                         'REALTY EXECUTIVES NP$|.* INVESTORE$|.* CORP\\.$|^MFMC$|MARK REAL ESTATE|.* ASSOC$|.* AGENCY$|' +
   														 '.* LTD PTNSP$|.* MGMT$|.* ABSTRACT$|.* APPR$|.* CO\\.$|.*NO STAR |.* CLEMENT$|' +
   														 '.* DETROIT LAKES$|.* REALTY CTR$|.* BRAINERD LAKES$|.* REALTY ADVISORS$|' + 
   		                         '^C/O[ ]*.*$|^ATTN:[ ]*.*$|.* INC$|.* INC |.* INC\\.|^.* INC\\. .*$| C/O .*$|' +
   														 '.* LLC$|.*,LLC$|.* LLC |.* LLC\\.|.* CORP$|.* CORP |' +
   		                         '.* HOMES$|STATE FARM|.* AFFILIATES|^APPRAISAL .*|^APPRAISALS .*|.* APPRAISAL$|.* APPRAISALS$|' +
   														 '.* SERVICES$|.* SERVICE$|.* SVC$|.* SVCS$|.* CO$|.* COMPANY$|.* TITLE$|.* LTD$|' +
   														 '.* PARTNERS$|[A-Z]+\\.COM$|.* ASSOCIATES$|[A-Z ]+ GROUP$|.* CORPORATION$|' +
   														 '.* PROPERTIES$|.* PROPERTIES NORTH|.* REGIONAL PROPERTIES |.* NETWORK$|.* FIRM$|^.*DEVELOPMENT.*$|SAVVYMOVES|.* AUTHORITY$|'+
   														 '.* APPRAISING$|.* TRUST$|^.* COMPANY|RE/MAX .*|.* CONSULTANTS$|' + 
   														 '^[A-Z]+ BRADLEY [A-Z]+$|^[A-Z]+ NANCY [A-Z]+$|^[A-Z]+ ERIC [A-Z]+$|^[A-Z]+ PAUL [A-Z]+$|' + 
   														 '^[A-Z]+ GREGORY [A-Z]+$|^[A-Z]+ JAMES [A-Z]+$|^[A-Z ]+ LISA [A-Z]+$|^[A-Z]+ JEFFRY [A-Z]+$|' + 
   														 '^[A-Z]+ THOMAS [A-Z]+$|^[A-Z]+ EDWARD [A-Z]+$|^[A-Z]+ LARRY [A-Z]+$|^[A-Z ]+ROBERT [A-Z]+$|' + 
   														 '^[A-Z]+ LAURENCE [A-Z]+$|[A-Z]+ MICHAEL [A-Z ]$|[A-Z]+ CYNTHIA [A-Z]+$|' +
   														 '^[A-Z]+ MARY [A-Z]+$|^[A-Z]+ TERRANCE [A-Z]+$|^[A-Z]+ KEITH [A-Z]+$|^[A-Z]+ DIANE [A-Z]+$|' +
   														 '.* TRANSPORTATION DEPARTMENT$|' + 
   														 '^CENTURY 21 TOWN COUNTRY |^CENTURY 21 .* RLTY IN|^CENTURY 21 .* RLTY |^CENTURY 21 BETTER HOMES|' +
   														 '^CENTURY 21 RUSH REALTY |^MN HOUSING$|^MINN HOUSING$|^.* COMMUNITY HOUSING$|' +
   														 '.* SAVOIE$|^COLDWELL BANKER .*$|^.* RLTY MANAGEMENT |^.* DBA .*|' +
   														 '^RESULTS REALTY .*$|^.* REALTY SOUTH$|^.* REALTY RESOURCES$|^.* REALTY$|^[A-Z ]* REALTY |' +
   														 '[A-Z]+ RICHARD [A-Z]+|^AMCON$|MEHLE .*$|^[A-Z]+ ADAM [A-Z]+$|^GROVER ANDERSON .*$|^KUEFLER .*$|' + 
   														 '^CENTURY 21 |^[A-Z\' ]+ NOTARY$|^[A-Z ]+ CREDIT UNION$|^[A-Z ]+ GILLESPIE REAL ESTATE)';
   	  DISCARD_PATTERN				:= '(^N/A$|^NA$|PHYSICAL ADD|MGMT OFFICE|UNITED STATES)';
   		
   		BOOLEAN isPersonName(STRING iname) := FUNCTION
   			RETURN IF(REGEXFIND('(^[A-Z]+ [A-Z]+$|^[A-Z]+ [A-Z]+ [A-Z]?[\\.]?$|^[A-Z]+ [A-Z][\\.]? [A-Z]+$)',ut.CleanSpacesAndUpper(iname)) AND
   								NOT REGEXFIND('(^UNIT |^SUITE |^STE |^APT |^AVE |^BOX |^MINN | ST$|AVENUE| LEVEL$| LANE$| SQUARE$|' +
   								          '^BLVD |^MAIN | RD$| HOUSING$| FLOOR$| AVE$| TITLE$|^CIRCLE |^ONE |COLONNADE|^PO BOX| MALL$|CIRICLE )',	
   								          ut.CleanSpacesAndUpper(iname)), 
   								TRUE,
   								FALSE);
   		END;						 
   		tempAddress1					:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(
   		                              REGEXREPLACE('[\\[|\\]]',pInput.ADDRESS1,'')));
   		tempAddrName1					:= MAP(REGEXFIND(DISCARD_PATTERN,tempAddress1) => '',
   		                             REGEXFIND(NAME_PATTERN,tempAddress1) => TRIM(REGEXFIND(NAME_PATTERN,tempAddress1,1),LEFT,RIGHT),
   																 isPersonName(tempAddress1) => tempAddress1,
   																 '');
   		tempAddrName1_1				:= REGEXREPLACE('(C/O|ATTN:|ATTN|PERSONAL TO|ATT\\.:)',	tempAddrName1,'');				
   		tempAddress1_1				:= REGEXREPLACE(DISCARD_PATTERN,
   		                                      IF(tempAddrName1<>'',REGEXREPLACE(tempAddrName1,tempAddress1,''),tempAddress1),
   																					'');
   		tempAddress2					:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(
   		                              REGEXREPLACE('[\\[|\\]]',REGEXREPLACE('UNI T A',pInput.ADDRESS2,'UNIT A',NOCASE),'')));
   		tempAddrName2					:= MAP(REGEXFIND(DISCARD_PATTERN,tempAddress2) => '',
   																 REGEXFIND(NAME_PATTERN,tempAddress2) => TRIM(REGEXFIND(NAME_PATTERN,tempAddress2,1),LEFT,RIGHT),
   																 isPersonName(tempAddress2) => tempAddress2,
   																 '');
   		tempAddrName2_1				:= REGEXREPLACE('(C/O|ATTN:|ATTN|PERSONAL TO|ATT\\.:)',	tempAddrName2,'');				
   		tempAddress2_1				:= REGEXREPLACE(DISCARD_PATTERN,
   																					IF(tempAddrName2<>'',REGEXREPLACE(tempAddrName2,tempAddress2,''),tempAddress2),
   																					'');
   	
   		tempAddress1_2				:= IF(TRIM(tempAddress1_1,LEFT,RIGHT)='' AND TRIM(tempAddress2_1,LEFT,RIGHT)<>'',
   		                            TRIM(tempAddress2_1,LEFT,RIGHT),
   																TRIM(tempAddress1_1,LEFT,RIGHT));
   		tempAddress2_2				:= IF(TRIM(tempAddress1_2,LEFT,RIGHT)=TRIM(tempAddress2_1,LEFT,RIGHT),
   		                            '',
   																TRIM(tempAddress2_1,LEFT,RIGHT));
   		//Store the name in name_office or name_contact field
   		TrimAddrNameCompany		:= TRIM(MAP(tempAddrName1_1<>'' AND Prof_License_Mari.func_is_company(tempAddrName1_1) AND
			                                   REGEXFIND('^ALSO DBA .*', tempAddrName2_1)
																				    => tempAddrName1_1 +' '+REGEXFIND('(DBA .*$)',tempAddrName2_1,1),
																				tempAddrName1_1<>'' AND Prof_License_Mari.func_is_company(tempAddrName1_1) AND
			                                   REGEXFIND('^DBA .*', tempAddrName2_1)
																				    => tempAddrName1_1 +' '+tempAddrName2_1,		
			                                   tempAddrName1_1<>'' AND Prof_License_Mari.func_is_company(tempAddrName1_1) => tempAddrName1_1,
																				 tempAddrName1_1<>'' AND REGEXFIND('^(RYAN|LICENSING)$',tempAddrName1_1) => '',
																				 tempAddrName1_1<>'' AND NOT REGEXFIND('( )',tempAddrName1_1) => tempAddrName1_1,
																				 tempAddrName1_1<>'' AND REGEXFIND('(STATE FARM|AGRIFINANCE| HOMES$| TITLE$| HOUSING$| NOTARY$| AFFILIATES$|^[ ]*TITLESMART$| EDC$|,LLC$)',tempAddrName1_1) => tempAddrName1_1,
																				 tempAddrName2_1<>'' AND Prof_License_Mari.func_is_company(tempAddrName2_1) => tempAddrName2_1,
																				 tempAddrName2_1<>'' AND REGEXFIND('^(RYAN|LICENSING)$',tempAddrName2_1) => '',
																				 tempAddrName2_1<>'' AND NOT REGEXFIND('( )',tempAddrName2_1) => tempAddrName2_1,
																				 tempAddrName2_1<>'' AND REGEXFIND('(STATE FARM|AGRIFINANCE| HOMES$| TITLE$| HOUSING$| NOTARY$| AFFILIATES$|^[ ]*TITLESMART$| EDC$|,LLC$)',tempAddrName2_1) => tempAddrName2_1,
   																 ''),LEFT,RIGHT);	
   		TrimAddrNameContact		:= TRIM(MAP(tempAddrName1_1<>'' AND TrimAddrNameCompany<>tempAddrName1_1 AND 
   		                             NOT Prof_License_Mari.func_is_company(tempAddrName1_1) => tempAddrName1_1,
   																 tempAddrName2_1<>'' AND TrimAddrNameCompany<>tempAddrName2_1 AND
   																 NOT Prof_License_Mari.func_is_company(tempAddrName2_1) => tempAddrName2_1,
   																 ''),LEFT,RIGHT);	

		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 'CASEY HATCH|^BREMER BANK BLDG$|COLDWELL BANKER PROPERTIES NORTH|DAN PERSON|DEGROOT FARM LAND SALES|GUNTON LEWIS|' +
					 '^HEGG BARBARA L$|LILIENTHAL LINDA|KINNUNEN AGCY|JENNINGS COLLEEN|N/A|MARGUTH TERRY R|ROBERT S BLANCHARD|'+
					 'RICKS REALTY APPRAISING|RELS VALUATION|RUED DAVID E|UNITED STATES|TRACEY TELLOR|SOLLIE APPRAISAL FIRM|' + 
					 'SEMPER DEVELOPMENT - IDS|ALSO DBA.*$|^.*,LLC$|WESTERN AGENCY|KNUTSON JAMES ALAN|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|^1 STOP REALTY INC' +
					 ')';                         

    trimAddress1_pre     	:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		trimAddress1					:= IF(REGEXFIND('P\\.0\\.',trimAddress1_pre),REGEXREPLACE('P\\.0\\.',trimAddress1_pre,'PO'),trimAddress1_pre);
   	trimAddress2        	:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
		trimCity1							:= ut.CleanSpacesAndUpper(pInput.CITY);
		trimCity           		:= IF(trimCity1='N/A','',trimCity1);
		trimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		tmpZip	            	:= MAP(LENGTH(TRIM(pInput.ZIPCODE))=3 => '00'+TRIM(pInput.ZIPCODE),
																 LENGTH(TRIM(pInput.ZIPCODE))=4 => '0'+TRIM(pInput.ZIPCODE),
																 TRIM(pInput.ZIPCODE)='99999' => '',
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
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.addr_CNTY_1      := ut.CleanSpacesAndUpper(pInput.COUNTY);
		SELF.ADDR_ADDR1_2			:= '';
		SELF.ADDR_ADDR2_2			:= '';
		SELF.ADDR_ADDR3_2			:= '';
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	  	:= IF(TRIM(clnAddrAddr1) != '','B','');
				
		//populate NAME_OFFICE field
		temp_OfficeName				:= IF(TRIM(pInput.OFFICENAME,LEFT,RIGHT) != ' ',
																ut.CleanSpacesAndUpper(pInput.OFFICENAME),
																IF(TrimAddrNameCompany != ' ' AND NOT REGEXFIND('[0-9]+',TrimAddrNameCompany)
																   AND NOT REGEXFIND(' CO RD ',TrimAddrNameCompany),
																	 TrimAddrNameCompany,
																	 ''));
		stdOfficeName1				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_OfficeName);
		stdOfficeName					:= IF(REGEXFIND(DBApattern,stdOfficeName1),
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpName(stdOfficeName1),
																stdOfficeName1);
		clnOfficeName					:= IF(REGEXFIND(' :THE| : THE',stdOfficeName),
																'THE'+' '+TRIM(REGEXREPLACE(':THE|: THE',stdOfficeName,'')),
																StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(stdOfficeName)));
		replOfficeSlash				:= TRIM(REGEXREPLACE('C/O|/',clnOfficeName,' '),LEFT,RIGHT);
    SELF.NAME_OFFICE			:= MAP(REGEXFIND('.COM',stdOfficeName)=>TRIM(stdOfficeName,LEFT,RIGHT),
                                 TRIM(replOfficeSlash,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',		 
																 TRIM(replOfficeSlash,ALL) = TRIM(SELF.Name_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(replOfficeSlash,ALL) = TRIM(SELF.Name_FIRST + SELF.NAME_LAST,ALL) => '',
																 TRIM(REGEXREPLACE(' COMPANY',replOfficeSlash,' CO'),LEFT,RIGHT));
		comp_names 						:= '(REMAX|USA 4%|REAL EST|ASSOC|AGCY)';
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '', 
		                            IF((prof_license_mari.func_is_company(SELF.NAME_OFFICE) OR REGEXFIND(comp_names,SELF.NAME_OFFICE)), 'GR',
		                             'MD'),
																 '');

		//Terri's review comment(BUG 124107) - 2. NAME_MARI_ORG is not being populated correctly when TYPE_CD 'MD'.
		//For MD, it should be set to office name.
		SELF.NAME_MARI_ORG 		:= IF(tempTypeCd='GR',tempTrimName,SELF.NAME_OFFICE); 		//Original organization name not standardized
			
								
		// assign office license number
		tempOffSlnum 					:= ut.CleanSpacesAndUpper(pInput.CID);
		SELF.off_license_nbr 	:= tempOffSlnum;

		//Store	TrimAddrNameContact in contact if the name is in FML or LFM format
		SELF.NAME_CONTACT_FIRST := MAP(REGEXFIND('([A-Z]+) ([A-Z]{1})[\\.]? ([A-Z]+)',TrimAddrNameContact) AND
																	 ut.CleanSpacesAndUpper(pInput.OFFICENAME) <> TrimAddrNameContact
		                                   => REGEXFIND('([A-Z]+) ([A-Z]{1})[\\.]? ([A-Z]+)',TrimAddrNameContact, 1),
																	 REGEXFIND('^([A-Z]+) ([A-Z]+) ([A-Z])[\\.]?$',TrimAddrNameContact) AND
																	 ut.CleanSpacesAndUpper(pInput.OFFICENAME) <> TrimAddrNameContact
		                                   => REGEXFIND('^([A-Z]+) ([A-Z]+) ([A-Z])[\\.]?$',TrimAddrNameContact, 2),
																	 '');		 
		SELF.NAME_CONTACT_LAST := MAP(REGEXFIND('([A-Z]+) ([A-Z]{1})[\\.]? ([A-Z]+)',TrimAddrNameContact) AND
		                              ut.CleanSpacesAndUpper(pInput.OFFICENAME) <> TrimAddrNameContact
		                                   => REGEXFIND('([A-Z]+) ([A-Z]{1})[\\.]? ([A-Z]+)',TrimAddrNameContact, 3),
																	REGEXFIND('^([A-Z]+) ([A-Z]+) ([A-Z])[\\.]?$',TrimAddrNameContact) AND
		                              ut.CleanSpacesAndUpper(pInput.OFFICENAME) <> TrimAddrNameContact
		                                   => REGEXFIND('^([A-Z]+) ([A-Z]+) ([A-Z])[\\.]?$',TrimAddrNameContact, 1),
																	 '');		 
		SELF.NAME_CONTACT_MID := MAP(REGEXFIND('([A-Z]+) ([A-Z]{1})[\\.]? ([A-Z]+)',TrimAddrNameContact) AND
		                             ut.CleanSpacesAndUpper(pInput.OFFICENAME) <> TrimAddrNameContact
		                                   => REGEXFIND('([A-Z]+) ([A-Z]{1})[\\.]? ([A-Z]+)',TrimAddrNameContact, 2),
																 REGEXFIND('^([A-Z]+) ([A-Z]+) ([A-Z])[\\.]?$',TrimAddrNameContact) AND
		                             ut.CleanSpacesAndUpper(pInput.OFFICENAME) <> TrimAddrNameContact
		                                   => REGEXFIND('^([A-Z]+) ([A-Z]+) ([A-Z])[\\.]?$',TrimAddrNameContact, 3),
																	 '');		 

		//Keep the company name extracted from the address field in office_name field if it is blank. Otherwise store it in provnote_2
		//Keep the person's name in contact field if we can parse it. Otherwise store it in provnote_2
		SELF.provnote_2 := IF((pInput.OFFICENAME<>'' AND TrimAddrNameCompany<>'' AND 
		                       ut.CleanSpacesAndUpper(pInput.OFFICENAME)<>Prof_License_Mari.mod_clean_name_addr.strippunctName(TrimAddrNameCompany)) OR 
		                      (TrimAddrNameContact<>'' AND SELF.NAME_CONTACT_FIRST+SELF.NAME_CONTACT_LAST=''),
													'CONTACT INFO FROM ADDR:',
													'') +
		                   IF(pInput.OFFICENAME<>'' AND TrimAddrNameCompany<>'' AND 
		                       ut.CleanSpacesAndUpper(pInput.OFFICENAME)<>Prof_License_Mari.mod_clean_name_addr.strippunctName(TrimAddrNameCompany), 
		                      TrimAddrNameCompany+';',
												 '') +
		                   IF(TrimAddrNameContact<>'' AND SELF.NAME_CONTACT_FIRST+SELF.NAME_CONTACT_LAST='',
		                      TrimAddrNameContact+';',
												  '');
					
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		tempDBA_pre1   				:= MAP(busDba <>'' => busDba,
		                             REGEXFIND(DBApattern,tempTrimNameFix6) 
		                               => prof_license_mari.mod_clean_name_addr.getDBAname(tempTrimNameFix6),
																 REGEXFIND(DBApattern,stdOfficeName) 
		                               => prof_license_mari.mod_clean_name_addr.getDBAname(stdOfficeName),
																 REGEXFIND(DBApattern,TrimAddrNameCompany)
		                               => prof_license_mari.mod_clean_name_addr.getDBAname(TrimAddrNameCompany),
		                             '');
		tempDBA_pre2					:= IF(tempDBA_pre1='N/A' OR tempDBA_pre1='NONE', '', tempDBA_pre1);														 
		tempDBA								:= IF(REGEXFIND('^DBA ', tempDBA_pre2), REGEXFIND('^DBA (.*)$',tempDBA_pre2,1),
		                            IF(REGEXFIND('^(.*) DBA (.*)', tempDBA_pre2), REGEXFIND('^(.*) DBA (.*)$',tempDBA_pre2,2),tempDBA_pre2));	
		trimDBA       				:= ut.CleanSpacesAndUpper(tempDBA);
		trimDBA2      				:= IF(trimDBA = tempTrimNameFix6,'',trimDBA);
		trimFix       				:= MAP(REGEXFIND('RE/MAX',trimDBA2) => stringlib.stringfindreplace(trimDBA2,'RE/MAX','REMAX'),
		                             REGEXFIND('RE/NET',trimDBA2) => stringlib.stringfindreplace(trimDBA2,'RE/NET','RENET'),
		                             REGEXFIND('WI/MN',trimDBA2) => stringlib.stringfindreplace(trimDBA2,'WI MN','WI MN'),
		                             REGEXFIND('PINK/BLUE',trimDBA2) => stringlib.stringfindreplace(trimDBA2,'PINK/BLUE','PINK BLUE'),
																 trimDBA2);
		tempDBA1      				:= MAP(trimDBA=TrimNAME_ORG =>'',
		                             REGEXFIND('^WELDON GROUP INC',trimDBA) => REGEXFIND(' DBA (.*$)',trimDBA,1),
																 trimFix);
		tempDBA2      				:= stringlib.stringfindreplace(tempDBA1,';','/');
		tempDBA3      				:= stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
		tempDBA31      				:= stringlib.stringfindreplace(tempDBA3,'/DBA','/');
		tempDBA4      				:= IF(stringlib.stringfind(tempDBA31,'BURRES AND ASSOCIATES',1)=0
																AND stringlib.stringfind(tempDBA31,'AND LOAN',1)=0,
																stringlib.stringfindreplace(tempDBA31,' AND ','/'),
																tempDBA31);
												
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

		// SELF.dba2 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,2),
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
		tempAffilTypeCd 			:= MAP(tempStdLictype[1..2] = 'RC' AND tempTypeCd = 'GR' => 'CO',
																 tempStdLicType[1..2] IN ['RA','CL'] AND tempTypeCd= 'MD' => 'IN',
																 '');
				
		SELF.affil_type_cd 		:= tempAffilTypeCd;
	
		//fields used to create mltreckey key are:
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
																		 +ut.CleanSpacesAndUpper(pInput.ADDRESS1)
																		 +ut.CleanSpacesAndUpper(StripDBA)
																		 +ut.CleanSpacesAndUpper(pInput.ADDRESS2)
																		 +ut.CleanSpacesAndUpper(pInput.ISSUEDT)); 		
		SELF.mltreckey	 			:= IF(temp_dba1 != ' ',mltreckeyHash, 0);
				
				 // fields used to create unique key are:
					// license number
					// license type
					// source update
					// name
					// address			
		//Use hash64 instead of hash32 to avoid dup keys	
		//Include office name in the key generation to make it unique
		SELF.cmc_slpk         := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 //Terri's review comment(BUG 124107) - 5.b. STDNAME_ORG should be replaced with either all 
														 //raw name fields or NAME_ORG_ORIG.
														 //+ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(tempTrimName)
														 //Terri's review comment(BUG 124107) - 5.c. Add OFF_LICENSE_NBR. 
														 +TRIM(tempOffSlnum,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(stdOfficeName)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS1)
														 +ut.CleanSpacesAndUpper(pInput.ADDRESS2)
														 //Terri's review comment(BUG 124107) - 5.a. Add ZIP just in case if zip is populated only.
														 +ut.CleanSpacesAndUpper(pInput.ZIPCODE)
														 +ut.CleanSpacesAndUpper(pInput.ISSUEDT));
											 
		SELF := [];	
		
	END;

	ds_map := PROJECT(clnValidFile, transformToCommon(LEFT));

	//Terri's review comment(BUG 124107) - 6. Clean Up Fields Address can be removed
	// Clean-up Fields
	
	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
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
	maribase_dbas := RECORD,MAXLENGTH(6500)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	//maribase_dbas	NormIT(ds_map_source_desc L, INTEGER C) := TRANSFORM
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
	oLookup := OUTPUT(SORT(company_only_lookup,license_nbr));
	
	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
										TRIM(LEFT.name_mari_org,LEFT,RIGHT) = TRIM(RIGHT.name_org, LEFT,RIGHT)+ ' '+ TRIM(RIGHT.name_org_sufx,LEFT,RIGHT)
										AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
										 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));
	
	d_final := OUTPUT(OutRecs,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
			
  add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rea','using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rec','using', 'used')
														);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oREA, oREC, Ocmv, Orea_cmmn, Orec_cmmn, oLookup, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;
