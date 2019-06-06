IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;
		 
EXPORT map_NMS0822_conversion(STRING pVersion) := FUNCTION
#workunit('name',' Yogurt:Prof License MARI - NMS0822 Build     ' + pVersion);

	code 								:= 'NMS0822';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Reference Files for lookup joins
	cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	Ocmv        := OUTPUT(cmvTransLkp);

	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES| GROUP|REALTORS| RE BRK|SEC\'Y| INC$| RE AGENCY | SERVS|INVESTMENTS)';
										
	AddrExceptions:= '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
										'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS|DRAWER)';

	invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN)';
	C_O_Ind      := '(C/O |ATTN: |ATTN )';
	DBA_Ind      := '( DBA |D/B/A |/DBA| DBA/| A/K/A | AKA |,DBA )';

	//Process and combine 2 input files
	Individual  := Prof_License_Mari.files_NMS0822.pr;
	oRes		:= OUTPUT(individual);
	inFile  := Individual;

	//Filtering out BAD RECORDS
	GoodFilterRec    	:= inFile(TRIM(LIC_TYPE + LAST_NAME + FIRST_NAME) <> '');
  ut.CleanFields(GoodFilterRec,clnFilterRec);
 
	maribase_plus_dbas := RECORD, maxsize(5200)
		//Prof_License_Mari.layouts_reference.MARIBASE;
		Prof_License_Mari.layout_base_in;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	//Real Estate License to common MARIBASE layout
	maribase_plus_dbas 		xformToCommon(Prof_License_Mari.layout_NMS0822.COMMON pInput) := TRANSFORM
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
		SELF.TYPE_CD					:= 'MD';

		//Standardize Fields
		TrimNAME_PREFIX 			:= ut.CleanSpacesAndUpper(pInput.NAME_PREFIX);			
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);		
		TrimNAME_MID 			  	:= ut.CleanSpacesAndUpper(pInput.MID_NAME);	
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_OFFICE				:= IF(pInput.OFFICENAME='',
																' ',
																ut.CleanSpacesAndUpper(pInput.OFFICENAME));
		TrimLIC_TYPE 					:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);
		TrimLIC_STATUS 				:= ut.CleanSpacesAndUpper(pInput.LICSTAT);
		TrimAddress1 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
		TrimAddress2 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_2);		
		TrimCity 							:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimCounty						:= ut.CleanSpacesAndUpper(pInput.COUNTY);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		
		// License Information
		SELF.LICENSE_NBR	  	:= IF(pInput.SLNUM = '', 'NR',ut.CleanSpacesAndUpper(pInput.SLNUM));
		SELF.LICENSE_STATE	 	:= src_st;
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		SELF.STD_LICENSE_TYPE := IF(SELF.RAW_LICENSE_TYPE= 'ASSOCIATE BROKER','AB',SELF.RAW_LICENSE_TYPE);		
		SELF.RAW_LICENSE_STATUS     := TrimLIC_STATUS;
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUEDT != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUEDT),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPDT),'17530101');
		SELF.RENEWAL_DTE			:= IF(pInput.LAST_RENEWED_DT != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.LAST_RENEWED_DT),'17530101');	
		SELF.BIRTH_DTE				:= IF(pInput.DOB != '', Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.DOB),'');
		SELF.PROVNOTE_3       := IF(pInput.APPL_RECEIVED_DT != '','APPLICATION RECEIVED AT '+ ut.CleanSpacesAndUpper(pInput.APPL_RECEIVED_DT),'');	
		// Identify NICKNAME in the various format 
		tempFNick 						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		tempMNick							:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');	
		tempLNick							:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');	
	
		
		stripNickFName				:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		stripNickMName				:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick');		
		stripNickLName				:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick');		
		
		GoodFirstName					:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		GoodMidName		  			:= IF(tempLNick != '',stripNickLName,TrimNAME_MID);		
		GoodLastName					:= IF(tempLNick != '',stripNickLName,TrimNAME_LAST);
		
		ParsedName 						:= Address.CleanPersonFML73(GoodFirstName + ' ' + GoodMidName + ' ' + GoodLastName);
		FirstName 						:= IF(ParsedName[6..25]<>'' AND LENGTH(TRIM(ParsedName[46..65]))>1,TRIM(ParsedName[6..25],LEFT,RIGHT),GoodFirstName);
		MidName   						:= IF(ParsedName[26..45]<>'' AND LENGTH(TRIM(ParsedName[46..65]))>1,TRIM(ParsedName[26..45],LEFT,RIGHT),GoodMidName);	
		LastName  						:= IF(ParsedName[46..65]<>'' AND LENGTH(TRIM(ParsedName[46..65]))>1,TRIM(ParsedName[46..65],LEFT,RIGHT),GoodLastName); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);


		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_PREFX       := TrimNAME_PREFIX;
		SELF.NAME_FIRST		   	:= FirstName ;
		SELF.NAME_MID					:= MidName;
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),'');
				
		//Identifying DBA NAMES
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(TrimNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ',' DBA '),
                                 StringLib.Stringfind(TrimNAME_OFFICE,',DBA ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,',DBA ',' DBA '),
																 StringLib.Stringfind(TrimNAME_OFFICE,'DBA/',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'DBA/',' DBA '),	
															 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
																 StringLIb.stringfind(TrimLIC_STATUS,'INACTIVE',1) > 0 => '',
																 TrimNAME_OFFICE);

		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																																						'');
		SELF.DBA1							:= IF(StringLib.stringfind(getNAME_DBA,',',2) > 1 AND
																	REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)',getNAME_DBA),
																		REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)',getNAME_DBA,1),
																			getNAME_DBA);
		SELF.DBA2							:= IF(StringLib.stringfind(getNAME_DBA,',',2) > 1 AND
																	REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)',getNAME_DBA),
																		REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)',getNAME_DBA,2),
																			'');
		SELF.DBA3							:= IF(StringLib.stringfind(getNAME_DBA,',',2) > 1 AND
																	REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)',getNAME_DBA),
																		REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)',getNAME_DBA,3),
																			'');
		SELF.PHN_MARI_1				:= ut.CleanPhone(pInput.TELE_1);
		
	//Identifying Contact Info		
	  TrimAddress           := StringLib.StringCleanSpaces(TrimAddress1 + ' '+ TrimAddress2);
		prepAddress           :=  IF(NOT REGEXFIND('[a-zA-Z]',TrimAddress),'',
		                             IF(REGEXFIND(invalid_addr,TrimAddress),'',TrimAddress));
		prepAddress1          :=  IF(NOT REGEXFIND('[a-zA-Z]',TrimAddress1),'',
		                             IF(REGEXFIND(invalid_addr,TrimAddress1),'',TrimAddress1));
		prepAddress2          :=  IF(NOT REGEXFIND('[a-zA-Z]',TrimAddress2),'',
		                             IF(REGEXFIND(invalid_addr,TrimAddress2),'',TrimAddress2));			
		
		tmpAddr1Contact				:= IF(REGEXFIND(C_O_Ind,prepAddress), Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress),'');
	
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 REGEXFIND(BusExceptions,tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
		ParseContact	:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact)
																AND NOT REGEXFIND(BusExceptions,prepAddr1Contact) => '',
												 prepAddr1Contact != '' and NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																							Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																																																			'');
		SELF.LICENSE_NBR_CONTACT 	:= '';											
		SELF.NAME_CONTACT_PREFX		:= '';
		SELF.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
		SELF.NAME_CONTACT_NICK		:= '';
		SELF.NAME_CONTACT_TTL			:= '';
		
		//Identifying BUSINESS NAME(s) from CONTACT NAME(s)
		contact1OFFICE	:= MAP(REGEXFIND(DBA_Ind,tmpAddr1Contact) => '',
													 StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => tmpAddr1Contact,
													 tmpAddr1Contact != '' AND Prof_License_MARI.func_is_company(tmpAddr1Contact)
																	AND NOT REGEXFIND(AddrExceptions,tmpAddr1Contact) => tmpAddr1Contact,
													 REGEXFIND(BusExceptions,tmpAddr1Contact) => tmpAddr1Contact, 
																								'');
																																							
		//Identify Business Names	from Address Fields
		addrOFFICE	:= MAP(ParseContact != '' => '',
											 contact1OFFICE != '' => '',
											 NOT StringLib.stringfind(TRIM(prepAddress),' ',1) > 0 => prepAddress,
											 REGEXFIND(BusExceptions,prepAddress)AND NOT REGEXFIND(C_O_Ind,prepAddress) 
													AND NOT REGEXFIND(DBA_Ind,prepAddress) => prepAddress,
												
												NOT REGEXFIND('[0-9]', prepAddress) AND NOT REGEXFIND(AddrExceptions,TrimAddress)
															AND NOT REGEXFIND(C_O_Ind,prepAddress) AND NOT REGEXFIND(DBA_Ind,TrimAddress) => prepAddress,
																		'');
																													
		getContactOFFICE := MAP(contact1OFFICE != '' => contact1OFFICE,
													 addrOFFICE != '' => addrOFFICE,'');
								
		//Prepping OFFICE NAMES												
		rmvOfficeDBA := MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																													prepNAME_OFFICE);
						
		getNAME_OFFICE := IF(getContactOFFICE != '' AND rmvOfficeDBA = '',getContactOFFICE,rmvOfficeDBA);																			
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);	
		
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
														IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE	    := StringLib.StringCleanSpaces(CleanNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));			
		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_LAST);
		SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_DBA_ORIG	  := IF(REGEXFIND(DBA_Ind,TrimNAME_OFFICE),TrimNAME_OFFICE,'');
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;
		SELF.NAME_MARI_DBA	  := '';


		//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|ATTN:|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|GENERAL DELIVERY|^.*QUALIFIES FOR UPGRADE TO QB|' +
					 '^.* BUILDING$|^C/O .*,|^C/O .*\\-' +
					 ')';

		tmpZip	      				:= MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
		                             LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(prepAddress, CoPattern);
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddress, RemovePattern);
    clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddress1, RemovePattern);
    clnAddress2 					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddress2, RemovePattern);
		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState + ' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
    GoodAddr1             := IF(REGEXFIND(TrimCity,clnAddress1) OR REGEXFIND(TrimState,clnAddress1) OR REGEXFIND(tmpZip,clnAddress1),
		                            IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
															   	 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1)),
																   clnAddress1);	 
    GoodAddr2             := IF(REGEXFIND(TrimCity,clnAddress2) OR REGEXFIND(TrimState,clnAddress2) OR REGEXFIND(tmpZip,clnAddress2),
		                            IF(AddrWithContact != ' ' ,'',
																   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)),
																   clnAddress2);	 
		SELF.ADDR_ADDR1_1			:= GoodAddr1;																										
		SELF.ADDR_ADDR2_1			:= GoodAddr2; 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_CNTY_1	  	:= TrimCounty;	
		SELF.PHN_PHONE_1			:= SELF.PHN_MARI_1;
						
		SELF.EMAIL						:= IF(pInput.EMAIL_1!='',
																ut.CleanSpacesAndUpper(pInput.EMAIL_1),
																'');
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		
	
	/* fields used to create mltrec_key unique record split dba key are :
				 transformed license number,standardized license type,standardized source update, raw name containing dba name(s),raw address
	*/
		SELF.MLTRECKEY			:= 		IF(SELF.DBA1 != ' ' AND SELF.DBA2 != ' ' AND SELF.DBA1 != SELF.DBA2,
																			hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																						+TRIM(SELF.std_license_type,LEFT,RIGHT)
																						+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																						+TRIM(TrimNAME_OFFICE,LEFT,RIGHT)
																						+TRIM(TrimAddress1,LEFT,RIGHT)
																						+TRIM(TrimCity,LEFT,RIGHT)
																						+TRIM(pInput.ZIP)),0);


	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_FIRST,LEFT,RIGHT)
																			+TRIM(SELF.NAME_LAST,LEFT,RIGHT)
																			+TRIM(TrimAddress1,LEFT,RIGHT)
																			+TRIM(TrimCity,LEFT,RIGHT)
																			+TRIM(pInput.ZIP));
		
		SELF.PCMC_SLPK			:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(clnFilterRec,xformToCommon(LEFT));

	// Populate STD_STATUS_CD field via translation on statu field
	maribase_plus_dbas 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic, cmvTransLkp,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTransLkp,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																			
	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(6500)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
			SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;


	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := TRANSFORM
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
														REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
															OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
												
														REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
															OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																									Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:= StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		SELF.NAME_OFFICE			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF := L;
	END;
	ds_map_base 				:= PROJECT(FilteredRecs, xTransToBase(LEFT));

	//Remove duplicated records. Because the input data are from 2 files, there are dup records.
	//Rollup the data from residential licensee files (email address) 3/26/2013
	ds_map_sorted				:= SORT(ds_map_base, cmc_slpk, name_office);
	Prof_License_Mari.layout_base_in tr_rollup(ds_map_sorted L, ds_map_sorted R) := TRANSFORM
		SELF.EMAIL 						:= R.EMAIL;
		SELF 									:= L;
	END;
	ds_map_final				:= ROLLUP(ds_map_sorted, tr_rollup(LEFT,RIGHT), RECORD, EXCEPT name_dba_prefx,
																																							EXCEPT name_dba,
																																							EXCEPT name_dba_sufx,
																																							EXCEPT dba_flag,
																																							EXCEPT name_office,
																																							EXCEPT office_parse, 
																																							EXCEPT name_dba_orig,
																																							EXCEPT name_mari_org,
																																							EXCEPT name_mari_dba,
																																							EXCEPT phn_mari_1, 
																																							EXCEPT phn_phone_1, 
																																							EXCEPT email);
	
	d_final 						:= OUTPUT(ds_map_final, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
	add_super           := Prof_License_Mari.fAddNewUpdate(ds_map_final(NAME_ORG_ORIG != ''));				
	move_to_used 				:= Prof_License_Mari.func_move_file.MyMoveFile(code, 'persons','using','used');
																	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oRes, Ocmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;