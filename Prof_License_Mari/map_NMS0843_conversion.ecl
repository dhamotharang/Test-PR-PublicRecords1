/* Converting New Mexico Real Estate Appraisers Board / Real Estate Appraisers Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib,STD;

EXPORT map_NMS0843_conversion(STRING pVersion) := FUNCTION
 #workunit('name',' Yogurt:Prof License MARI - NMS0843 Build     ' + pVersion);

	code 								:= 'NMS0843';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Reference Files for lookup joins
	cmvTransLkp	 := Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	ocmvTransLkp := OUTPUT(cmvTransLkp);
	//Locally used constants
	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';
	AddrExceptions:= '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
										'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS|DRAWER)';
	invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|ADDRESS NOT ON FILE)';
	C_O_Ind      := '(C/O |ATTN: |ATTN )';
	DBA_Ind      := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
											
  SUFFIX_PATTERN  := '( JR.$| JR$| SR.$| SR$| III$| II$| IV$)';
	
	CoPattern	   := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|ADVANTAGE .*$|^.*APPRAISAL$|^.*APPRAISALS$|NMTRD$|^NMTRD$|' +
									'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|APPRAISAL$|THORNTON$|^THORNTON$' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$|^ATTN:.*$' +
									'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
									'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* BUILDING$|^.* OFFICE$' +
									')';	
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
												'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
												'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
												'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
												'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|ADVANTAGE APPRAISAL$|THORNTON|' +
												'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|NMTRD$|^NMTRD$|' +
												'^.* BUILDING$|^.* LAKE RESORT$|ADDRESS NOT ON FILE|EXEMPT STATUS' +
												')';




	PATTERN_COMMENT := '(STATE OF NEW MEXICO|REGULATION AND LICENSING|ACTIVE LICENSE INFORMATION|PROFESSION:|' +
	                    'LICENSE NO|LICENSE TYPE|TOTAL LICENSE|PRINTED:)';

	//Move to using
	move_to_using		:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed','using');	
												 );
												 
	appr            := Prof_License_Mari.files_NMS0843.appr;
	oAppr           := OUTPUT(appr);
	
	//Filtering out BAD RECORDS
	GoodFilterRec 	:= appr(SLNUM <> ' ' AND
														NOT REGEXFIND('(LICENSE #|LICENSE_NO|LICENSE NO|SLNUM|TOTAL LICENSES|PRINTED)',StringLib.StringToUpperCase(SLNUM)));
 	ut.CleanFields(GoodFilterRec, ClnRec);
																		
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in 		xformToCommon(Prof_License_Mari.layout_NMS0843.common pInput) := TRANSFORM
	
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
		SELF.LICENSE_STATE	 	:= src_st;
			
  	//Standardize Fields
  	TrimNAME_PREFX    := IF(pInput.PNAME != '',ut.CleanSpacesAndUpper(pInput.PNAME),'');
  	TrimNAME_FIRST		:= ut.CleanSpacesAndUpper(pInput.FNAME);
 	  TrimNAME_MID 		  := ut.CleanSpacesAndUpper(pInput.MNAME);
  	TrimNAME_LAST		  := ut.CleanSpacesAndUpper(pInput.LNAME);
	 	TrimNAME_FULL     := ut.CleanSpacesAndUpper(pInput.FULL_NAME);
 		TrimAddress				:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
    TrimCity          := ut.CleanSpacesAndUpper(pInput.CITY_1);
	  TrimState         := ut.CleanSpacesAndUpper(pInput.STATE_1);
	  TrimZip           := TRIM(pInput.Zip);

	  tempFullName					:= IF(trimNAME_FULL <>'', TRIM(trimNAME_FULL,LEFT,RIGHT),
																stringlib.stringcleanspaces(TrimNAME_FIRST+' '+TrimNAME_MID+' '+TrimNAME_LAST));	
		tempFNick							:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		tempLNick							:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');
		tempMNick							:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');
		tempFullNick          := Prof_License_Mari.fGetNickname(TrimNAME_FULL,'nick');
			
		removeFNick						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick');
		removeMNick						:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick');
		removeFullNick        := Prof_License_Mari.fGetNickname(TrimNAME_Full,'strip_nick');

		stripNickFName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));			stripNickLName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
		stripNickMName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick));
		stripNickFullName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFullNick));
			
		TmpNAME_FULL     := REGEXREPLACE(SUFFIX_PATTERN, stripNickFullName,'');
		TmpSufx          := REGEXFIND(SUFFIX_PATTERN, stripNickFullName,0);
			
		GoodFullName					:= IF(TmpSufx != '',TmpNAME_FULL,stripNickFullName);
		ParsedName						:= Prof_License_Mari.mod_clean_name_addr.cleanFMLName(GoodFullName);
				
		GoodFirstName					:= MAP(TrimNAME_LAST != '' AND tempFNick != ''=> stripNickFName,
			                           TrimNAME_LAST != '' AND tempFNick = ''=> TrimNAME_FIRST,
																 REGEXFIND('FREDRICK ZANE CHURCH',TrimName_Full) => 'FREDRICK',
																 TRIM(ParsedName[6..25],LEFT,RIGHT));
		GoodMidName   				:= MAP(TrimNAME_LAST != '' AND tempMNick != ''=> stripNickMName,
                                 TrimNAME_MID != '' AND tempMNick = ''=> TrimNAME_Mid,	
																 REGEXFIND('FREDRICK ZANE CHURCH',TrimName_Full) => 'ZANE',
																 TRIM(ParsedName[26..45],LEFT,RIGHT));													 
		GoodLastName					:= MAP(TrimNAME_LAST != '' AND tempLNick != ''=>stripNickLName,
			                           TrimNAME_LAST != '' AND tempFNick = ''=>TrimNAME_LAST,
																 REGEXFIND('FREDRICK ZANE CHURCH',TrimName_Full) => 'CHURCH',
																 TRIM(ParsedName[46..65],LEFT,RIGHT));	
																 
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName);

		SELF.NAME_ORG_PREFX		:= '';
		SELF.NAME_ORG		 			:= ConcatNAME_FULL;			
		SELF.NAME_ORG_SUFX	  := '';
		SELF.NAME_FIRST		   	:= GoodFirstName;
		SELF.NAME_MID					:= Stringlib.stringFilterOut(GoodMidName,'.');
		SELF.NAME_LAST		   	:= GoodLastName;
		SELF.NAME_NICK				:= MAP(TrimNAME_LAST != '' AND tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 TrimNAME_LAST != '' AND tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																 TrimNAME_LAST != '' AND tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																 TrimNAME_LAST = '' AND tempFullNick ='' => StringLib.StringCleanSpaces(tempFullNick),
																 '');
		SELF.NAME_SUFX        := TRIM(TmpSufx,LEFT,RIGHT);	
		
		// License Information
		SELF.LICENSE_NBR	  	:= ut.CleanSpacesAndUpper(pInput.SLNUM);
		TrimLIC_TYPE          := ut.CleanSpacesAndUpper(pInput.LIC);		
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		SELF.STD_LICENSE_TYPE := CASE(TrimLIC_TYPE,
																	'APPRENTICE APPRAISER' => 'AA',
																	'GENERAL CERTIFIED APPRAISER' => 'GCA',
																	'LICENSED APPRAISER' => 'LA',
																	'RESIDENTIAL CERTIFIED APPRAISER' => 'RCA',
																	'TEMPORARY PRACTICE PERMIT' => 'TPP',
																	'TRAINEE APPRAISER'	=> 'TA',
																	'TRAINEE  APPRAISER' => 'TA','');
		SELF.RAW_LICENSE_STATUS:= IF(ut.CleanSpacesAndUpper(pInput.LICSTAT)='REVOKED',
															   'REVOCATION',
															   ut.CleanSpacesAndUpper(pInput.LICSTAT));
			
		//Reformatting date to YYYYMMDD. Use fmt_dateMMDDYYYY
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUEDT != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUEDT),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPDT),'17530101');

//Parsing Full Address
		TempAddress1	:= if(STD.Str.Find(TrimAddress,';',2) > 0, TrimAddress[..STD.Str.Find(TrimAddress,';',2)-1],
												TrimAddress[..STD.Str.Find(TrimAddress,';',1)-1]);
		
		TempAddress2 	:= STD.Str.CleanSpaces(TrimAddress[length(TempAddress1)+2..]);
		
    replAddress_colon		:= 	STD.Str.FindReplace(TempAddress1,';',',');	
		
    prepAddress1 					:= IF(NOT REGEXFIND(invalid_addr,replAddress_colon), replAddress_colon, '');		
		
//Identifying Contact Info				
		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,prepAddress1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1),
		                             REGEXFIND('HIX APPRAISAL SERVICE',prepAddress1) => 'HIX APPRAISAL SERVICE',
																 '');
		
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																	Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																	REGEXFIND(BusExceptions,tmpAddr1Contact) => '',
																	Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																													tmpAddr1Contact);
		
		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact)
																				AND NOT REGEXFIND(BusExceptions,prepAddr1Contact) => '',
																 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																											Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																														'');

//Identifying BUSINESS NAME(s) from CONTACT NAME(s)
		contact1OFFICE				:= MAP(REGEXFIND(DBA_Ind,tmpAddr1Contact) => '',
																 StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => tmpAddr1Contact,
																 tmpAddr1Contact != '' AND Prof_License_MARI.func_is_company(tmpAddr1Contact)
																				AND NOT REGEXFIND(AddrExceptions,tmpAddr1Contact) => tmpAddr1Contact,
																 REGEXFIND(BusExceptions,tmpAddr1Contact) => tmpAddr1Contact, 
																 '');
																																								
//Identify Business Names from Address Fields
		addrOFFICE						:= MAP(ParseContact != '' => '',
																 contact1OFFICE != '' => '',
																 NOT StringLib.stringfind(TRIM(prepAddress1),' ',1) > 0 => prepAddress1,
																 REGEXFIND(BusExceptions,prepAddress1)AND NOT REGEXFIND(C_O_Ind,prepAddress1) 
																		AND NOT REGEXFIND(DBA_Ind,prepAddress1) => prepAddress1,
																 NOT REGEXFIND('[0-9]', prepAddress1) AND NOT REGEXFIND(AddrExceptions,TrimAddress)
																 AND NOT REGEXFIND(C_O_Ind,prepAddress1) AND NOT REGEXFIND(DBA_Ind,TrimAddress) => prepAddress1,
																 '');
		
//Parsed Address field		
		TmpAddress1_1         := IF(REGEXFIND('(.*),(.*)',prepAddress1),REGEXFIND('(.*),(.*)',prepAddress1,1),prepAddress1);
		TmpAddress1_2         := IF(REGEXFIND('(.*),(.*)',prepAddress1),REGEXFIND('(.*),(.*)',prepAddress1,2),'');
		
//Retrieve Business Names from Address fields
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TmpAddress1_1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TmpAddress1_2, CoPattern);
																													
		getContactOFFICE 			:= MAP(contact1OFFICE != '' => contact1OFFICE,
															   addrOFFICE != '' => addrOFFICE,
																 tmpNameContact1 != '' => tmpNameContact1,
																 tmpNameContact2);
		
//Some records have office_name and address1 on the same line
		tmpOfficeName					:= MAP(REGEXFIND('PO',getContactOFFICE)
																	=> TRIM(REGEXFIND('([A-Za-z@#%&\\- ]+)PO',getContactOFFICE,1),LEFT,RIGHT),
																 REGEXFIND('[0-9]+',getContactOFFICE)
																	=> TRIM(REGEXFIND('([A-Za-z@#%&\\- ]+)[0-9]+',getContactOFFICE,1),LEFT,RIGHT),
																 getContactOFFICE);
		getNAME_OFFICE 				:=  tmpOfficeName;
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE	    :=	StringLib.StringCleanSpaces(CleanNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := StringLib.StringCleanSpaces(tempFullName);
		SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;														

		
    SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress + TrimCity + TrimState + TrimZip,LEFT,RIGHT) != ' ','B',' ');
		
		
//Additional Address Preparation
    Cln_Address1_1        := MAP(REGEXFIND('P.O. BOX',TmpAddress1_1)=>REGEXREPLACE('P.O. BOX',TmpAddress1_1,'PO BOX'),
		                             REGEXFIND('(.*)(UNIT .*|SUITE .*)',TmpAddress1_1) AND TmpAddress1_2 = ''=>REGEXFIND('(.*)(UNIT .*|SUITE .*)',TmpAddress1_1,1),
																 REGEXFIND(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),TmpAddress1_1) => REGEXREPLACE(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),TmpAddress1_1,''),
																 TmpAddress1_1);	
																 
		Cln_Address1_2        := MAP(REGEXFIND('(.*)(UNIT .*|SUITE .*)',TmpAddress1_1) AND TmpAddress1_2 = ''=>REGEXFIND('(.*)(UNIT .*|SUITE .*)',TmpAddress1_1,2),
		                             REGEXFIND(RemovePattern,TmpAddress1_2) => '',
																 REGEXFIND(SELF.name_office,TmpAddress1_2) => REGEXREPLACE(SELF.name_office,TmpAddress1_2,''),
																 TmpAddress1_2);	

		GoodAddress2          := REGEXREPLACE('SUITE ',Cln_Address1_2,'STE ');
		
		SELF.ADDR_ADDR1_1			:= TRIM(Cln_Address1_1,LEFT,RIGHT);
		SELF.ADDR_ADDR2_1			:= TRIM(GoodAddress2,LEFT,RIGHT); 
		
		clnAddrAddr						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(replAddress_colon, TempAddress2);														 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr[65..89],LEFT,RIGHT);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr[115..116],LEFT,RIGHT);
   	SELF.ADDR_ZIP5_1		  := TRIM(clnAddrAddr[117..121],LEFT,RIGHT);		
    SELF.ADDR_CNTY_1			:= IF(pInput.COUNTY != '',ut.CleanSpacesAndUpper(pInput.COUNTY),'');
		
    //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
    SELF.EMAIL  	        := IF(pInput.EMAIL != '',ut.CleanSpacesAndUpper(pInput.EMAIL),'');
		
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		
		SELF.PROVNOTE_1 := '';
		SELF.PROVNOTE_2 := '';
		SELF.PROVNOTE_3	:= '';
																		
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															   SELF.TYPE_CD = 'GR' => 'CO',
																 '');		
		SELF.MLTRECKEY				:= 0;

		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																			+TRIM(TrimAddress,LEFT,RIGHT)
																			+TRIM(TrimCity,LEFT,RIGHT)
																			+TRIM(TrimZip));
			
			SELF.PCMC_SLPK			:= 0;
			SELF 								:= [];	
				 
	END;
	inFileLic	:= PROJECT(ClnRec,xformToCommon(LEFT));

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layout_base_in 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
		//patch. remove it once SURRENDERED is defined.																	
		SELF.STD_LICENSE_STATUS :=  IF(L.RAW_LICENSE_STATUS = 'SURRENDERED',
																	'U',
																	StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)));
																
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic, cmvTransLkp,
							TRIM(LEFT.std_source_upd,LEFT,RIGHT)= TRIM(RIGHT.source_upd,LEFT,RIGHT)
							AND TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTransLkp,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																
	// Adding to Superfile
	d_final 						:= OUTPUT(ds_map_lic_trans, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			


	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));				

	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using','used')	
												 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);	
	RETURN SEQUENTIAL(ocmvTransLkp, move_to_using, oAppr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;