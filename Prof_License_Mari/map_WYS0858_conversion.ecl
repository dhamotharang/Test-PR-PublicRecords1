//  The purpose of this development is take KansasProfessional License raw files and convert them to a common
//  professional license (BASE) layout to be used for MARI and PL_BASE development.
//	06/10/2015 T.George - New Development
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_WYS0858_conversion(STRING pVersion) := FUNCTION
#workunit('name',' Yogurt:Prof License MARI - WYS0858     ' + pVersion);
	code 		:= 'WYS0858';
	src_cd	:= 'S0858';
	src_st	:= 'WY';	//License state

	//Move file(s) from ::sprayed:: to ::using::
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rel', 'sprayed', 'using');

	// Filter records w/o ORG_NAME being not populated
	ValidFile	:= Prof_License_Mari.file_WYS0858(~(REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUppercase(TRIM(BUSINESS_NAME,LEFT,RIGHT)))
																							or REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUppercase(TRIM(NAME_LAST,LEFT,RIGHT)))
																								));

  oApr	:= OUTPUT(ValidFile);
	
	// Reference Files
	cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
	OCmv := OUTPUT(cmvTransLkp);
	
	Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';

	AddrExceptions := '(PLAZA|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY)';

	invalid_addr := '(N/A|NONE |NO VALID|SAME )';
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	setValidSuffix	:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
	
	CoPattern	      := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
								    	'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
								    	'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$|^ATTN:.*$' +
								    	'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
								    	'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* BUILDING$|^.* OFFICE$' +
								    	')';
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
											'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
											'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^C/O.*$|^ATTN.*$|' +
											'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES' +
											'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATTN:.*$|' +
											'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
											'^.* BUILDING$|^.* LAKE RESORT$|^ATT:.*$|^.* AM$' +
											')';

	maribase_plus_dbas := RECORD, maxsize(5000)
		Prof_License_Mari.layout_base_in;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
		STRING60 dba6;
	END;

	//AR S0824
	maribase_plus_dbas	TRANSFORMToCommon(Prof_License_Mari.layout_wys0858.common pInput) := TRANSFORM

			SELF.PRIMARY_KEY			:= 0;
			SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
			SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
			SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd
			SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
			SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

			SELF.STD_SOURCE_UPD		:= src_cd;
			
			SELF.STD_SOURCE_DESC	:= ' ';
			SELF.STD_PROF_CD		  := ' ';
			SELF.STD_PROF_DESC		:= ' ';
			
			SELF.LICENSE_NBR	:= IF(pInput.LICENSE_NBR != '', ut.CleanSpacesAndUpper(pInput.LICENSE_NBR),'NR');
			SELF.LICENSE_STATE:= src_st;
		
			SELF.RAW_LICENSE_TYPE		:= StringLib.StringToUpperCase(pInput.LICENSE_TYPE);
			SELF.STD_LICENSE_TYPE		:= CASE(TRIM(SELF.RAW_LICENSE_TYPE),
																			'ASSOCIATE BROKER LICENSE' 			=> 'REAB',
																			'REAL ESTATE SALESMAN LICENSE' 	=> 'RES',
																			'RESPONSIBLE BROKER LICENSE'		=> 'REB',
																			'CERTIFIED GENERAL APPRAISER PERMIT'				=> 'ACG',
																			'CERTIFIED RESIDENTIAL APPRAISER PERMIT'		=> 'ACR',
																			'CERTIFIED APPRAISER TRAINEE PERMIT'				=> 'AT',
																			'TEMPORARY CERTIFIED APPRAISER PERMIT'			=> 'ATC',
																			'APPRAISAL MANAGEMENT COMPANY REGISTRATION' => 'AMC',
																			'REAL ESTATE FIRM LICENSE'								  => 'REF',
																			'REAL ESTATE SALESPERSON LICENSE'           => 'RES',
																			'');

			SELF.RAW_LICENSE_STATUS	:= StringLib.StringToUpperCase(pinput.LICENSE_STATUS);
			SELF.STD_LICENSE_STATUS	:= IF(SELF.RAW_LICENSE_STATUS = '', 'A','');
			SELF.TYPE_CD						:= IF(SELF.STD_LICENSE_TYPE IN ['AMC','REF'],'GR','MD');
				    
      //Reformatting date from MM/DD/YYYY to YYYYMMDD
			SELF.ORIG_ISSUE_DTE	  	:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ORIG_ISSUE_DTE);
			SELF.CURR_ISSUE_DTE			:= '17530101';
			SELF.EXPIRE_DTE					:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPIRE_DTE);	 
					 
      // If individual and not identified as a corporation names, parse into (FMLS) fmt
			TrimNAME_LAST			:= ut.CleanSpacesAndUpper(pInput.NAME_LAST);
			TrimNAME_FIRST		:= ut.CleanSpacesAndUpper(pInput.NAME_FIRST);
			TrimNAME_MID			:= ut.CleanSpacesAndUpper(pInput.NAME_MIDDLE);
			TrimNAME_ORG			:= ut.CleanSpacesAndUpper(pInput.BUSINESS_NAME);
			TrimAddress1			:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
			TrimAddress2			:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
			TrimCity					:= ut.CleanSpacesAndUpper(pInput.CITY);

    // Identify NICKNAME in the various format 
		tempFNick							:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		tempLNick							:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');
		tempMNick							:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');
		removeFNick						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick');
		removeMNick						:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick');
		stripNickFName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));
		stripNickLName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
		stripNickMName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick));
			
		GoodFirstName					:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		GoodLastName					:= IF(tempLNick != '',stripNickLName,TrimNAME_LAST);
		GoodMidName   				:= IF(tempMNick != '',stripNickMName,TrimNAME_MId);		
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName);
		
    // Corporation Names
		clnNAME_ORG						:= IF(SELF.TYPE_CD = 'GR',REGEXREPLACE('(^DBA )', TrimNAME_ORG,''),'');
		prepNAME_ORG					:= IF(StringLib.Stringfind(clnNAME_ORG,' T/A ',1) > 0, 
		                            StringLib.StringFindReplace(clnNAME_ORG,' T/A ',' D/B/A '),
																clnNAME_ORG);
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																prepNAME_ORG);		
		StdNAME_ORG 					:= IF(SELF.TYPE_CD = 'MD','',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG));
		CleanNAME_ORG					:= MAP(SELF.TYPE_CD = 'MD' => ConcatNAME_FULL,
																 REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
												         REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' '));
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));		
		SELF.NAME_FIRST		   	:= GoodFirstName;
		SELF.NAME_MID					:= Stringlib.stringFilterOut(GoodMidName,'.');
		SELF.NAME_LAST		   	:= GoodLastName;
		SELF.NAME_NICK				:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																 tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																 '');
    //Remove DBA Name																 
    getNAME_DBA						:=IF(REGEXFIND(DBA_Ind,TrimNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_ORG),
																																						''); 
    StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
															
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
	
	
    //Prepping OFFICE NAMES
		getOFFICE_NAME				:= IF(SELF.TYPE_CD = 'MD',TrimNAME_ORG,'');
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,getOFFICE_NAME) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(getOFFICE_NAME),
																getOFFICE_NAME[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(getOFFICE_NAME),
																REGEXFIND(C_O_Ind,getOFFICE_NAME)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(getOFFICE_NAME),
																																		getOFFICE_NAME);
																					
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																			Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
																			
		SELF.NAME_OFFICE		:= MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + ' ' + SELF.NAME_MID + ' ' + SELF.NAME_LAST,ALL) => '',
		                           TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST + ' ' + SELF.NAME_FIRST + ' ' + SELF.NAME_MID,ALL) => '',
															 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
															 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
		                           StringLib.StringCleanSpaces(CleanNAME_OFFICE));
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
																							
																							
		SELF.NAME_FORMAT    := IF(SELF.TYPE_CD = 'MD','L','F');
		SELF.NAME_ORG_ORIG	:= IF(SELF.TYPE_CD = 'MD',StringLib.StringCleanSpaces(TrimNAME_LAST + ', ' + TrimNAME_FIRST + ' ' + TrimNAME_MID),
																TrimNAME_ORG);
			
		SELF.NAME_DBA_ORIG			:= '';
		SELF.NAME_MARI_ORG			:= IF(SELF.TYPE_CD = 'MD',SELF.NAME_OFFICE,
																		IF(SELF.TYPE_CD = 'GR',StdNAME_ORG,''));
		SELF.NAME_MARI_DBA			:= StdNAME_DBA;
		trimPhone           := ut.CleanPhone(TRIM(pInput.BUS_PHONE,LEFT,RIGHT));
		trimFax             := ut.CleanPhone(TRIM(pInput.BUS_FAX,LEFT,RIGHT));
		SELF.PHN_MARI_1			:= trimPhone;
		SELF.PHN_MARI_FAX_1	:= trimFax;
		SELF.PHN_PHONE_1		:= trimPhone;
		SELF.PHN_FAX_1			:= trimFax;
			
					 
    //Use address cleaner to clean address

		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern);
		clnAddress1						:= IF(REGEXFIND('^(C/O MARINEVEST)\\s([A-Z\\s]+)$', TrimAddress1),REGEXFIND('^(C/O MARINEVEST)\\s([A-Z\\s]+)$', TrimAddress1,2), 
																Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern));
																	
		
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress2, CoPattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress2, RemovePattern);
		

		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(clnAddress2); 
		
											
			SELF.ADDR_BUS_IND  	:= IF(TRIM(TrimAddress1 +TrimCity+ pInput.ZIP) != '','B','');
			SELF.ADDR_ADDR1_1		:= IF(temp_preaddr1 != '', temp_preaddr1,temp_preaddr2);
			SELF.ADDR_ADDR2_1		:= IF(temp_preaddr1 != '',temp_preaddr2,'');
			SELF.ADDR_CITY_1		:= TrimCity;
			SELF.ADDR_STATE_1		:= pInput.STATE;
			ParsedZIP           := REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.ZIP, 0);
			SELF.ADDR_ZIP5_1		:= ParsedZIP[1..5];
			SELF.ADDR_ZIP4_1		:= ParsedZIP[7..10];
			SELF.ADDR_CNTY_1   	:= '';
			SELF.EMAIL					:= ut.CleanSpacesAndUpper(pInput.EMAIL);	
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD	:= IF(SELF.TYPE_CD = 'MD','IN',
																IF(SELF.TYPE_CD ='GR','CO',
																	''));  
					
			/* fields used to create mltrec_key unique record split dba key are :
					 TRANSFORMed license number
					 standardized license type
					 standardized source update
					 raw name containing dba name(s)
					 raw address
			*/
			SELF.mltreckey		:= 0;
					 
				/* fields used to create cmc_slpk unique key are :
					license number
					license type
					source update
					name
					address */
			//Use hash64 instead of hash32 to avoid dup keys		 
			SELF.CMC_SLPK       := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) +','
																		+TRIM(SELF.std_license_type,LEFT,RIGHT) +','
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT) +','
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT) +','
																		+TRIM(TrimAddress1,LEFT,RIGHT) +','
																		+TRIM(TrimCity,LEFT,RIGHT) +','
																		+TRIM(pInput.ZIP));
			SELF.PROVNOTE_1				:= '';																	
			SELF.PROVNOTE_2				:= '';
			SELF.PROVNOTE_3 	    := IF(SELF.RAW_LICENSE_STATUS = '','{LIC_STATUS ASSIGNED}','');
			SELF.PREV_PRIMARY_KEY	:= 0;
			SELF.PREV_MLTRECKEY		:= 0;
			SELF.PREV_CMC_SLPK		:= 0;
			SELF.PREV_PCMC_SLPK		:= 0;
			SELF.CONT_EDUCATION_ERND	:= '';
			SELF.CONT_EDUCATION_REQ		:= '';
			SELF.CONT_EDUCATION_TERM	:= '';
			SELF := [];		   		   
			
	END;

	ds_map := PROJECT(ValidFile, TRANSFORMToCommon(LEFT));
	

// Populate STD_STATUS_CD field via translation on statu field
maribase_plus_dbas 	trans_lic_status(ds_map L, cmvTransLkp R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map, cmvTransLkp,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
	// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

ds_map_lic_prof := JOIN(ds_map_status_trans, cmvTransLkp,
												TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
												AND RIGHT.fld_name='LIC_TYPE' 
												AND RIGHT.dm_name1 = 'PROFCODE',
												trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

																		
company_only_lookup := ds_map_lic_prof(affil_type_cd='CO');																		
																			
	//maribase_plus_dbas 		assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := TRANSFORM
	maribase_plus_dbas 		assign_pcmcslpk(ds_map_lic_prof L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_prof, company_only_lookup,
								  TRIM(LEFT.license_nbr[..StringLib.stringfind(LEFT.license_nbr,'.',1)-1],LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT),
									assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
						
						
	maribase_plus_dbas	 xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
											TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
													 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
													 'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;
	ds_map_assign := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));


	// Normalized DBA records
	maribase_plus_tmp := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_plus_tmp	NormIT(ds_map_assign L, INTEGER C) := TRANSFORM
			SELF := L;
			SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5, L.DBA6);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_assign,6,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = ' ' AND DBA1 = ' ' AND DBA2 = ' ' 
					AND DBA3 =  '' AND DBA4 = ' ' AND DBA5 = ' ', DBA6 = ' ');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	AllRecs  := DBARecs + NoDBARecs;

	// TRANSFORM expanded dataset to MARIBASE layout
	Prof_License_Mari.layout_base_in trans_to_base(AllRecs L) := TRANSFORM
		SELF := L;
	END;

	ds_map_base := PROJECT(AllRecs, trans_to_base(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(ds_map_base , ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rel', 'using', 'used');
	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	
	RETURN SEQUENTIAL(move_to_using, oApr, OCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;