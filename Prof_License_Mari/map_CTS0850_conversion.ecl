//********************************************************************************
// Converting Connecticut Dept of Consumer Protection / Multiple Licenses/Real Estate Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
//Source file location: \\Tapeload02b\k\professional_licenses\mari\ct\connecticut_real_estate_professionals_(en)
//********************************************************************************
IMPORT ut,Address,Prof_License_Mari,lib_stringlib,Lib_FileServices;

EXPORT map_CTS0850_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'CTS0850';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//CT input files
	move_to_using 			:= PARALLEL(
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'general_apprs', 'sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'residential_apprs', 'sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'mobile_parks', 'sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'provisional_apprs', 'sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'brokers', 'sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'salespersons', 'sprayed', 'using');
														);
														
	brokers  := Prof_License_Mari.files_CTS0850.brokers;
	oBrokers := OUTPUT(brokers);
	provisional_apprs:= Prof_License_Mari.files_CTS0850.provisional_apprs;
	oPApprs  := OUTPUT(provisional_apprs);
	appraisers:= Prof_License_Mari.files_CTS0850.appraisers;
	oApprs   := OUTPUT(appraisers);
	mobilehome_parks:= Prof_License_Mari.files_CTS0850.mobilehome_parks;
	oMobileParks := OUTPUT(mobilehome_parks);

	rLayout_License	:= RECORD, maxsize(5000)
		Prof_License_Mari.layout_CTS0850.layout_salesperson;
		STRING  BUSINESS_NAME;
	END;

	FileBRK  := PROJECT(brokers,TRANSFORM(rLayout_License, SELF := LEFT;	SELF := []));
	FilePAPR := PROJECT(provisional_apprs,TRANSFORM(rLayout_License, SELF := LEFT; SELF := []));
	FileAPR  := PROJECT(appraisers,TRANSFORM(rLayout_License, SELF := LEFT; SELF := []));
	FileMHP  := PROJECT(mobilehome_parks,TRANSFORM(rLayout_License, SELF := LEFT; SELF := []));
	inFileComb := FileBRK + FilePAPR + FileAPR + FileMHP;

	Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';

	AddrExceptions := '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE|THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
										'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS|DRAWER|ESTATES| HTL|RANCH|RESORT|POINT|HIGHWAY|LODGE|CAFE|'+
										'WEST ADDISON|CORNER MAIN|DIAMONDS ST| TPKE|MAIN ST| DR| CIRCLE| COTTAGE|PINE ST|HEALTH CENTER)';
  Sufx_Pattern := '( SR.| SR| JR.| JR| III| II| IV| VII| VI)';
	invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|NOT ON FILE)';
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';

	//Filtering out BAD RECORDS
	GoodFilterRec 	:= inFileComb(StringLib.StringCleanSpaces(LAST_NAME + FIRST_NAME + BUSINESS_NAME) <> '');
  ut.CleanFields(GoodFilterRec,clnGoodFilterRec);
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in xformToCommon(rLayout_License pInput) := TRANSFORM

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
		
		//Standardize Fields
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);		
		TmpNAME_LAST	        := IF(REGEXFIND(Sufx_Pattern,TrimNAME_LAST),REGEXREPLACE(Sufx_Pattern,TrimNAME_LAST,''),
		                             TrimNAME_LAST);
		TmpSuffix_Last        := TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_LAST,0),LEFT,RIGHT);				
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.BUSINESS_NAME);
		TrimLIC_TYPE 					:= ut.CleanSpacesAndUpper(pInput.LIC_NUMBER[1..3]);
		TrimLIC_STATUS 				:= ut.CleanSpacesAndUpper(pInput.LIC_STATUS);
		TrimAddress1 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS);
		TrimCity 							:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState 						:= ut.CleanSpacesAndUpper(pInput.STATE);
		TrimZIP 							:= MAP(pInput.STATE IN ['CT','NH','RI','VT','NJ','MA','ME'] AND LENGTH(TRIM(pInput.ZIP,LEFT,RIGHT))=4
		                               => '0'+pInput.ZIP,
																 pInput.STATE IN ['CT','NH','RI','VT','NJ','MA','ME'] AND LENGTH(TRIM(pInput.ZIP,LEFT,RIGHT))=3
		                               => '00'+pInput.ZIP,
															 pInput.ZIP);													
		TrimNAME_OFFICE 			:= ut.CleanSpacesAndUpper(pInput.SUPERVISOR);

		// License Information
		SELF.TYPE_CD					:= MAP(TrimNAME_LAST != '' AND TrimNAME_ORG = '' => 'MD',
																 TrimNAME_ORG != '' AND TrimNAME_LAST = '' => 'GR',
																 TrimNAME_LAST != '' AND TrimNAME_ORG != '' => 'MD',
													 			 '');		
		SELF.LICENSE_NBR	  	:= ut.CleanSpacesAndUpper(pInput.LIC_NUMBER);
		SELF.OFF_LICENSE_NBR	:= ut.CleanSpacesAndUpper(pInput.SUPERVISOR_NUM);
		SELF.LICENSE_STATE	 	:= src_st;
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		SELF.STD_LICENSE_TYPE := MAP(SELF.TYPE_CD = 'GR' AND SELF.RAW_LICENSE_TYPE = 'REB' => 'REBC',
																 SELF.TYPE_CD = 'MD' AND SELF.RAW_LICENSE_TYPE = 'REB' => 'REB',
															   SELF.RAW_LICENSE_TYPE);
	  SELF.RAW_LICENSE_STATUS := TrimLIC_STATUS;				
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= IF(pInput.LIC_EFFECTIVE_DATE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.LIC_EFFECTIVE_DATE),'17530101');
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.EXPIRE_DTE				:= IF(pInput.LIC_EXPIRATION != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.LIC_EXPIRATION),'17530101');
		
		// Identify NICKNAME in the various format 
		tempFNick 						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		tempLNick							:= Prof_License_Mari.fGetNickname(TmpNAME_LAST,'nick');
		
		//Removing NickName from Parsed First/Last Name fields
		removeFNick						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(TmpNAME_LAST,'strip_nick');

		stripNickFName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));
		stripNickLName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
		
		GoodFirstName					:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		GoodLastName					:= IF(tempLNick != '',stripNickLName,TmpNAME_LAST);
		ParsedName 						:= Address.CleanPersonFML73(GoodFirstName + ' '+GoodLastName);
		FirstName 						:= IF(ParsedName[6..25]!= '',TRIM(ParsedName[6..25],LEFT,RIGHT),GoodFirstName);
		MidName   						:= TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  						:= IF(ParsedName[46..65]!= '',TRIM(ParsedName[46..65],LEFT,RIGHT),GoodLastName); 
		Suffix	  						:= IF(TmpSuffix_Last != '',TmpSuffix_Last,TRIM(ParsedName[66..70],LEFT,RIGHT));
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);

		//Corporation Names
		prepNAME_ORG					:= IF(TrimNAME_LAST = '' AND TrimNAME_ORG != '',TrimNAME_ORG,'');
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																prepNAME_ORG);		
		StdNAME_ORG 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG);
		CleanNAME_ORG					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
																 REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
																 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														     OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
									   						 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD',ConcatNAME_FULL,
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));															
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));		
		SELF.NAME_FIRST		   	:= GoodFirstName;
		SELF.NAME_MID					:= MidName;
		SELF.NAME_LAST		   	:= GoodLastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),'');
		
		//Identifying DBA NAMES
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(TrimNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ',' DBA '),
																 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
																 TrimNAME_LAST != '' AND TrimNAME_ORG != '' => TrimNAME_ORG,
																 TrimNAME_OFFICE);

		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 REGEXFIND(DBA_Ind,TrimAddress1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																									 													'');
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   						 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));

//Identifying Contact Info		
		prepAddress1 					:= MAP(REGEXFIND(' LLC$',TrimAddress1) => '',
																 NOT REGEXFIND(invalid_addr,TrimAddress1)=> TrimAddress1,
																 '');											  
																	
		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,prepAddress1) => 
		                               Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1),
																 REGEXFIND(DBA_Ind,prepAddress1) => '','');
																																							
	
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 REGEXFIND(BusExceptions,tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
                                 REGEXFIND(' USA$',tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																													'');
		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact)
																 AND NOT REGEXFIND(BusExceptions,prepAddr1Contact) => '',
																 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																 Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																 '');
 
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  

		//Identifying BUSINESS NAME(s) from CONTACT NAME(s)
		contact1OFFICE					:= MAP(REGEXFIND(DBA_Ind,tmpAddr1Contact) => '',
																	 StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => tmpAddr1Contact,
																	 tmpAddr1Contact != '' AND Prof_License_MARI.func_is_company(tmpAddr1Contact)
																	 AND NOT REGEXFIND(AddrExceptions,tmpAddr1Contact) => tmpAddr1Contact,
																	 tmpAddr1Contact != '' AND REGEXFIND(' USA$', tmpAddr1Contact) => tmpAddr1Contact,
																	 REGEXFIND(BusExceptions,tmpAddr1Contact) => tmpAddr1Contact, 
																	 '');
																																							
		//Identify Business Names	from Address Fields
		addrOFFICE						:= MAP(ParseContact != '' => '',
																 contact1OFFICE != '' => '',
																 //mobile home park records should have name_office set to blank
																 //since these records do not have individual names
																 SELF.RAW_LICENSE_TYPE='MHP' =>'',
																 REGEXFIND('^[0-9]+ .* DR[I]?[V]?[E]?', prepAddress1) => '',
																 REGEXFIND('^[0-9]+ .* L[A]?N[E]?', prepAddress1) => '',
																 REGEXFIND('^[0-9]+ .* ST[R]?[E]?[E]?[T]?', prepAddress1) => '',
																 REGEXFIND('^COBBLE COURT$', TRIM(prepAddress1,LEFT,RIGHT)) => '',
																 REGEXFIND('^[0-9]+$', TRIM(prepAddress1,LEFT,RIGHT)) => '',
																 StringLib.stringfind(TRIM(prepAddress1),' ',1)=0 => prepAddress1,
																 REGEXFIND(BusExceptions,prepAddress1)AND NOT REGEXFIND(C_O_Ind,prepAddress1) 
																 AND NOT REGEXFIND(DBA_Ind,prepAddress1) => prepAddress1,
																 NOT REGEXFIND('[0-9]', prepAddress1) AND NOT REGEXFIND(AddrExceptions,TrimAddress1)
																 AND NOT REGEXFIND(C_O_Ind,prepAddress1) AND NOT REGEXFIND(DBA_Ind,TrimAddress1)
																 AND NOT REGEXFIND('(THE HOVEL|ON THE GREEN|CEDAR HILL|SNUG HARBOR|RAM ISLAND|'+
																 'NORTHFIELD GREEN CONDOMINIUMS|GRIDLEY HOUSE)',prepAddress1)=> prepAddress1,
																 '');
																													
		getContactOFFICE 			:= MAP(contact1OFFICE != '' => contact1OFFICE,
																 addrOFFICE != '' => addrOFFICE,
																 '');
								
		//Prepping OFFICE NAMES												
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 prepNAME_OFFICE);
						
		getNAME_OFFICE   := IF(getContactOFFICE != '' AND rmvOfficeDBA = '',getContactOFFICE,rmvOfficeDBA);																			
		StdNAME_OFFICE	 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);														
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
														IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		// SELF.NAME_OFFICE	    :=	StringLib.StringCleanSpaces(CleanNAME_OFFICE);
																	
		SELF.NAME_OFFICE      := MAP(StringLib.StringFind(CleanNAME_OFFICE, 'DBA',1) > 0=>TRIM(REGEXFIND('^(.*)DBA(.*)',CleanNAME_OFFICE,1),LEFT,RIGHT),
		                           TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID +SELF.NAME_LAST,ALL)=> '',
														               TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL)=> '',
													                CleanNAME_OFFICE);
		
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
		
		//Populate DBA name
		clnName_DBA						:= StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA					:= IF(clnName_DBA=TRIM(SELF.NAME_OFFICE),'',clnName_DBA);
		SELF.NAME_DBA_SUFX	  := IF(TRIM(SELF.NAME_DBA)!='',
		                            Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)),
																'');	
		SELF.NAME_DBA_PREFX	  := IF(TRIM(SELF.NAME_DBA)!='',
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA),
																'');
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		
	//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := IF(SELF.TYPE_CD = 'GR',TrimNAME_ORG,StringLib.StringCleanSpaces(TrimNAME_FIRST + ' '+TrimNAME_LAST));
		SELF.NAME_FORMAT			:= 'F';

		SELF.NAME_DBA_ORIG	  := IF(REGEXFIND(DBA_Ind,TrimNAME_OFFICE),TrimNAME_OFFICE,'');
		SELF.NAME_MARI_ORG	  := If(SELF.TYPE_CD = 'GR',StdNAME_ORG,SELF.NAME_OFFICE);
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;

	 //Obtain "Good" Address data
		getGoodAddr1	:= MAP(REGEXFIND(DBA_Ind,prepAddress1) => '',
												 tmpAddr1Contact != '' AND Prof_License_Mari.func_is_address(tmpAddr1Contact) => tmpAddr1Contact,
												 tmpAddr1Contact != ''  => '',
										     addrOFFICE != '' AND prepAddress1 != '' => '',
												  								prepAddress1);
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 +TrimCity+ pInput.Zip) != '','B','');	
		
		prepAddr_Line_1				:= getGoodAddr1;
		prepAddr_Line_2				:= TrimCity + ' ' + TrimState + ' ' + TrimZIP;
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1,prepAddr_Line_2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		
   	SELF.OOC_IND_1				:= IF(REGEXFIND(' BERMUDA',prepAddr_Line_2) OR REGEXFIND(' UK',prepAddr_Line_2),1,0);    
		SELF.ADDR_ADDR1_1			:= MAP(SELF.OOC_IND_1=1 AND tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1=''
		                               => StringLib.StringCleanSpaces(TrimCity+' '+TrimState+' '+TrimZIP),
		                             AddrWithContact != '' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(SELF.OOC_IND_1=1 AND (tmpADDR_ADDR1_1!='' OR tmpADDR_ADDR2_1!='')
		                               => StringLib.StringCleanSpaces(TrimCity+' '+TrimState+' '+TrimZIP),
																 AddrWithContact!='' => '',
																 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR2_1)= TRIM(tmpADDR_ADDR1_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= MAP(SELF.OOC_IND_1=1 => '',
		                             TRIM(clnAddress[65..89])='' => TrimCity,
																 TRIM(clnAddress[65..89]));
		SELF.ADDR_STATE_1			:= MAP(SELF.OOC_IND_1=1 => '',
		                             TRIM(clnAddress[115..116])='' => TrimState,
																 TRIM(clnAddress[115..116]));
   	SELF.ADDR_ZIP5_1			:= MAP(SELF.OOC_IND_1=1 => '',
		                             TRIM(clnAddress[117..121])='' => StringLib.StringFilter(TrimZIP,'0123456789'),
																 TRIM(clnAddress[117..121]));
   	SELF.ADDR_ZIP4_1			:= clnAddress[122..125];
																	
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		
	
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
	//Use hash64 instead of hash32 to avoid dup keys
		SELF.CMC_SLPK       := hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																			+TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)
																			+TRIM(TrimAddress1,LEFT,RIGHT)
																			+TRIM(TrimCity,LEFT,RIGHT)
																			+TRIM(pInput.ZIP));
		
		SELF.PCMC_SLPK			:= 0;
	SELF := [];	
		   
	END;
	
	inFileLic	:= PROJECT(clnGoodFilterRec,xformToCommon(LEFT));

	newFileLic:= inFileLic(NAME_ORG_ORIG != '');

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layout_base_in 	trans_lic_status(newFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_status_trans := JOIN(newFileLic, Cmvtranslation,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),left outer,lookup);

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in 	trans_lic_type(ds_map_status_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_status_trans, Cmvtranslation,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	//Prof_License_Mari.layout_base_in xTransToBase(newFileLic L) := transform
	Prof_License_Mari.layout_base_in xTransToBase(ds_map_lic_trans L) := TRANSFORM
		SELF.NAME_OFFICE			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA	  := StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1));
		SELF := L;
	END;

	ds_map_base := PROJECT(ds_map_lic_trans, xTransToBase(LEFT));


	// Adding to Superfile
	d_final := OUTPUT(ds_map_base, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);
	
	move_to_used := PARALLEL(		
		Prof_License_Mari.func_move_file.MyMoveFile(code, 'general_apprs', 'using', 'used');
		Prof_License_Mari.func_move_file.MyMoveFile(code, 'residential_apprs', 'using', 'used');
		Prof_License_Mari.func_move_file.MyMoveFile(code, 'mobile_parks', 'using', 'used');
		Prof_License_Mari.func_move_file.MyMoveFile(code, 'provisional_apprs', 'using', 'used');
		Prof_License_Mari.func_move_file.MyMoveFile(code, 'brokers', 'using', 'used');
		Prof_License_Mari.func_move_file.MyMoveFile(code, 'salespersons', 'using', 'used');
		);

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oBrokers, oPApprs, oApprs, oMobileParks,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;