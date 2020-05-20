/* Converting Idaho Real Estate Commission Agents /Multiple Professions Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
//Source file location - \\Tapeload02b\k\professional_licenses\mari\id\idaho_real_estate_professionals_(en)
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, NID, STD;
	
EXPORT map_IDS0827_conversion(STRING pVersion) := FUNCTION

	code 								:= 'IDS0827';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								

	//Dataset reference files for lookup joins
	Cmvtranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(Cmvtranslation);
	Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';

	AddrExceptions := '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
										'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS|DRAWER|ESTATES| HTL|RANCH|RESORT|POINT|HIGHWAY|LODGE|CAFE|'+
										'WEST ADDISON|CORNER MAIN|DIAMONDS ST)';

	invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN)';
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	GR_Ind	:= ['BO','CO','CL','LC','LP','NO','PA','PR','PT'];
	MD_Ind	:= ['AABL ','AB','BK','ABL','ASL','CB','DB','ISL','LB ','SP','IBL','MA','MB','MS','BR','TS'];
	
	
date_ind := '^([A-Z][^\\,]+)\\,\\s([0-9]+){0,2}\\s([0-9]+){1,4}';

//Incoming dates: March, 15 2001 00:00:00
convertFullDate(STRING date) := FUNCTION
SHARED fmt := '^([A-Z][^\\,]+)\\,\\s([0-9]+){0,2}\\s([0-9]+){1,4}';

m := REGEXFIND(fmt,date,1);
d	:= REGEXFIND(fmt,date,2);
y	:= REGEXFIND(fmt,date,3);

STRING2 month := CASE(m[1..3], 
										'JAN' => '01',
										'FEB' => '02',
										'MAR' => '03',
										'APR' => '04',
										'MAY' => '05',
										'JUN' => '06',
										'JUL' => '07',
										'AUG' => '08',
										'SEP' => '09',
										'OCT' => '10',
										'NOV' => '11',
										'DEC' => '12',
										'00'
										);
STRING2	day:= IF(LENGTH(TRIM(d)) =1,'0'+ d, d);									
STRING4	year := y;

RETURN (STRING)(year + month + day);
END;


	inFile_rel 					:= Prof_License_Mari.files_IDS0827.file_rel;
	oRel								:= OUTPUT(inFile_rel);
	
	//Filtering out BAD RECORDS
	GoodFilterRec := inFile_rel(TRIM(LAST_NAME + FIRST_NAME + COMPANY_NAME) <> '' AND NOT REGEXFIND('(TEST CO)',COMPANY_NAME,NOCASE));
	
	GoodLicRec		:= GoodFilterRec(TRIM(StringLib.StringToUpperCase(LICENSE_NUM)) <> 'UNLICENSED' AND 
	                               TRIM(StringLib.StringToUpperCase(LICENSE_NUM)) <> '' AND
	                               TRIM(StringLib.StringToUpperCase(LIC_STATUS))  <> 'UNLICENSED') ;                                        
	GoodNameRec   := GoodLicRec(NOT REGEXFIND('(TEST-RECORD|TESTER)',StringLib.StringToUpperCase(LAST_NAME)));
	GoodNameRec2  := GoodNameRec(NOT REGEXFIND('(TEST)',StringLib.StringToUpperCase(LAST_NAME))
																				AND NOT REGEXFIND('(TWO)',StringLib.StringToUpperCase(FIRST_NAME)));
	GoodValidRec	:= GoodNameRec2(NOT REGEXFIND('(JOANNA ITS ME TESTER|TEST COMPANY 22|TEST CO 22|TEST COMPANY-PR109|'+
																												'TEST CO-PR109|IREC TEST|TEST RECORD)',StringLib.StringToUpperCase(COMPANY_NAME)));

	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in xformToCommon(Prof_License_Mari.layouts_IDS0827.Common pInput) := TRANSFORM

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
		
		//Standardize Fields
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);		
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.COMPANY_NAME);
		TrimNAME_DBA					:= ut.CleanSpacesAndUpper(pInput.COMPANY_DBA_NAME);
		
		TrimLIC_TYPE 					:= ut.CleanSpacesAndUpper(pInput.LICENSE_NUM[1..2]);
		TrimLIC_STATUS 				:= ut.CleanSpacesAndUpper(pInput.LIC_STATUS);
		TrimBusAddrFull				:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS_FULL);
		TrimBusAddress1 			:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS1);
		TrimBusCity 					:= ut.CleanSpacesAndUpper(pInput.BUS_CITY);
		TrimMailAddressFull		:= ut.CleanSpacesAndUpper(pInput.MAIL_ADDRESS_FULL);
		TrimMailAddress1 			:= ut.CleanSpacesAndUpper(pInput.MAIL_ADDRESS1);
		TrimMailCity 					:= ut.CleanSpacesAndUpper(pInput.MAIL_CITY);
		TrimContact 					:= ut.CleanSpacesAndUpper(pInput.BROKER_NAME);
		TrimTransCode					:= ut.CleanSpacesAndUpper(pInput.TRANS_CODE);
		TrimNAME_OFFICE				:= IF(TrimLIC_TYPE in MD_Ind, ut.CleanSpacesAndUpper(pInput.COMPANY_NAME),'');
		
		TrimTransDate						:= ut.CleanSpacesAndUpper(pInput.TRANS_DATE);
		TrimExpDate						:= ut.CleanSpacesAndUpper(pInput.EXP_DATE);
		TrimIssDate						:= ut.CleanSpacesAndUpper(pInput.ORIGINAL_ISSUE_DATE);
		
			//Reformatting date to YYYYMMDD
		tmpTranDte						:= IF(TrimTransDate = 'UNKNOWN','',
																IF(LENGTH(TrimTransDate) < 9 AND TrimTransDate != '', '0'+TrimTransDate,
																	// regexreplace('00:00:00',TrimTransDate,'')
																	TrimTransDate));
		tmpExpDte 						:= IF(TrimExpDate = 'UNKNOWN','',
																IF(LENGTH(TrimExpDate) < 9 AND TrimExpDate != '', '0'+TrimExpDate,
																	// regexreplace('00:00:00',TrimExpDate,'')
																	TrimExpDate));
		tmpIssDte 						:= IF(TrimIssDate = 'UNKNOWN','',
																IF(LENGTH(TrimIssDate) < 9 AND TrimIssDate != '', '0'+TrimIssDate,
																	 // regexreplace('00:00:00',TrimIssDate,'')
																	 TrimIssDate));
		SELF.ORIG_ISSUE_DTE		:= MAP(StringLib.StringToUppercase(tmpIssDte) = '' => '17530101', 
																 tmpIssDte = '' => '17530101',
																 REGEXFIND(date_ind, tmpIssDte) => convertFullDate(tmpIssDte),
																 (STRING)Prof_License_Mari.DateCleaner.FromDDMMMYY(StringLib.StringToUppercase(tmpIssDte)));
																					 
		SELF.EXPIRE_DTE				:= MAP(StringLib.StringToUppercase(tmpExpDte) = '' => '17530101',
																 tmpExpDte = '' => '17530101',
																 REGEXFIND(date_ind, tmpExpDte) => convertFullDate(tmpExpDte),
																 (STRING)Prof_License_Mari.DateCleaner.FromDDMMMYY(StringLib.StringToUppercase(tmpExpDte)));
		SELF.CURR_ISSUE_DTE		:= '17530101';

		
		//If the transaction code contains license renewal
		SELF.RENEWAL_DTE			:= IF(REGEXFIND(date_ind, tmpTranDte), convertFullDate(tmpTranDte),
																IF(REGEXFIND('LICENSE RENEWAL',TrimTransCode),
																	(STRING8)Prof_License_Mari.DateCleaner.FromDDMMMYY(StringLib.StringToUppercase(tmpTranDte)),
																	''));
		SELF.ACTIVE_FLAG			:= '';
			
		// License Information
		SELF.LICENSE_NBR	  	:= IF(pInput.LICENSE_NUM = '','NR', ut.CleanSpacesAndUpper(pInput.LICENSE_NUM));
		SELF.OFF_LICENSE_NBR	:= '';
		SELF.STD_PROF_CD		  := IF(TrimLIC_TYPE = '','RLE','');
		SELF.TYPE_CD					:= IF(TrimLIC_TYPE in MD_Ind,'MD',
																IF(TrimLIC_TYPE in GR_Ind,'GR',''));
		
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		SELF.STD_LICENSE_TYPE := CASE(TRIM(SELF.RAW_LICENSE_TYPE),
																	'BO' => 'BRO',
																	'BR' => 'BRK',
																	SELF.RAW_LICENSE_TYPE);

		SELF.RAW_LICENSE_STATUS := TrimLIC_STATUS;
		SELF.STD_LICENSE_STATUS := IF(SELF.RAW_LICENSE_STATUS = '',
																		IF(TRIM(SELF.EXPIRE_DTE)<pVersion,'I','A'),
																		'');
																
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
		clnNAME_ORG						:= REGEXREPLACE('(^DBA )', TrimNAME_ORG,'');
		prepNAME_ORG					:= IF(StringLib.Stringfind(clnNAME_ORG,' T/A ',1) > 0, 
		                            StringLib.StringFindReplace(clnNAME_ORG,' T/A ',' D/B/A '),
																clnNAME_ORG);
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
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
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD',
																	IF(LENGTH(TRIM(ConcatNAME_FULL)) = 0 AND CleanNAME_ORG != '',
																				CleanNAME_ORG, ConcatNAME_FULL),
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
		SELF.NAME_ORG_SUFX	  := IF(SELF.TYPE_CD <> 'MD',Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)),'');		
		SELF.NAME_FIRST		   	:= GoodFirstName;
		SELF.NAME_MID					:= GoodMidName;
		SELF.NAME_LAST		   	:= GoodLastName;
		SELF.NAME_NICK				:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																 tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																 '');
		SELF.PROV_STAT				:= IF(SELF.RAW_LICENSE_STATUS = 'DECEASED','D',
																	IF(SELF.RAW_LICENSE_STATUS = 'RETIRED','R',''));
			
		//Identifying DBA NAMES
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(TrimNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ',' DBA '),
																 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
																 StringLIb.stringfind(TrimLIC_STATUS,'INACTIVE',1) > 0 => '',
																 TrimNAME_OFFICE);

		getNAME_DBA						:= MAP(TrimNAME_DBA != '' => TrimNAME_DBA,
																 REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 '');
																																				
		StdNAME_DBA 					:= IF(REGEXFIND('(^COMPANY)', getNAME_DBA), getNAME_DBA,Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA));
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
 																 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) 
																		=> Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),										
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) 
																    => StdNAME_DBA,
																Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:= StringLib.StringCleanSpaces(CleanNAME_DBA);
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);

		//Identifying Contact Info		
		prepBusAddress1 			:= IF(NOT REGEXFIND(invalid_addr,TrimBusAddress1),TrimBusAddress1,'');
		prepMailAddress1 			:= IF(NOT REGEXFIND(invalid_addr,TrimMailAddress1),TrimMailAddress1,'');
		ParseContact					:= IF(TrimContact != '', Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TrimContact),'');
																																																					
		SELF.NAME_CONTACT_FIRST:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID	:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
			
																																							
		//Identify Business Names	from Address Fields
		addrOFFICE						:= MAP(NOT StringLib.stringfind(TRIM(prepBusAddress1),' ',1) > 0 => prepBusAddress1,
																 REGEXFIND(BusExceptions,prepBusAddress1)AND NOT REGEXFIND(C_O_Ind,prepBusAddress1) 
																 AND NOT REGEXFIND(DBA_Ind,prepBusAddress1) => prepBusAddress1,													
																 NOT REGEXFIND('[0-9]', prepBusAddress1) AND NOT REGEXFIND(AddrExceptions,TrimBusAddress1)
																 AND NOT REGEXFIND(C_O_Ind,prepBusAddress1) AND NOT REGEXFIND(DBA_Ind,TrimBusAddress1) => prepBusAddress1,
																 '');
																														
			getContactOFFICE 		:= IF(addrOFFICE != '', addrOFFICE,'');
									
			//Prepping OFFICE NAMES												
			rmvOfficeDBA 				:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																	prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																														prepNAME_OFFICE);
							
			getNAME_OFFICE 			:= IF(getContactOFFICE != '' AND rmvOfficeDBA = '',getContactOFFICE,rmvOfficeDBA);																			
			StdNAME_OFFICE			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);														
			CleanNAME_OFFICE 		:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
															IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																		Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
			
		
		  SELF.NAME_OFFICE      := MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
		                               TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST, ALL) => '',
																   TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST, ALL) => '',
																   StringLib.StringCleanSpaces(CleanNAME_OFFICE));			
			
			// SELF.NAME_OFFICE	  :=	StringLib.StringCleanSpaces(CleanNAME_OFFICE);
			SELF.OFFICE_PARSE		:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																		IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																								''));
		//Populating MARI Name Fields
			SELF.NAME_ORG_ORIG	:= IF(SELF.type_cd = 'MD',
																IF(LENGTH(TRIM(ConcatNAME_FULL)) = 0 AND TrimNAME_ORG != '',
																		TrimNAME_ORG,
																			StringLib.StringCleanSpaces(TrimNAME_LAST+', '+TrimNAME_FIRST + ' '+TrimNAME_MID)),
																	TrimNAME_ORG);
			SELF.NAME_FORMAT    := IF(SELF.TYPE_CD = 'MD','L','F');
													
			SELF.NAME_DBA_ORIG	:= TrimNAME_DBA;
			SELF.NAME_MARI_ORG	:= IF(SELF.type_cd = 'MD',SELF.NAME_OFFICE,
															  IF(SELF.type_cd = 'GR',StdNAME_ORG,''));
			SELF.NAME_MARI_DBA	:= StdNAME_DBA;

//Obtain "Good" Address data
// stripping needless punctuation
      tempBus := IF(STD.Str.Find(TrimBusAddrFull, ',',5) > 0,
									TRIM(TrimBusAddrFull[1..STD.Str.Find(TrimBusAddrFull, ',', 4) -1], RIGHT),
							  IF(STD.Str.Find(TrimBusAddrFull, ',',4) < 1, TrimBusAddrFull,		
									TRIM(TrimBusAddrFull[1..STD.Str.Find(TrimBusAddrFull, ',', 3) -1], RIGHT))
									);
										
			tempBusaddr2						:= IF(tempBus = '', StringLib.StringFilterOut(TrimBusAddrFull, '.'), StringLib.StringFilterOut(tempBus, '.'));
			space_char              := ' ';
			comma_char							:= ',';
					 
// moving city, state, AND zip to their respective fields
//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
			tempBuszip             := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', TRIM(tempBusaddr2,LEFT,RIGHT), 0);	
			tempBusaddr4           := tempBusaddr2[..(LENGTH(tempBusaddr2)-LENGTH(tempBuszip))];
			reverse_addr_bus       := TRIM(stringlib.stringreverse(tempBusaddr4),LEFT,RIGHT);
			reverse_state_bus      := reverse_addr_bus[..stringlib.stringfind(reverse_addr_bus,space_char,1)-1];
			reverse_addr2_bus      := TRIM(reverse_addr_bus[stringlib.stringfind(reverse_addr_bus,space_char,1)..],LEFT,RIGHT);
			temp_final_addr_bus         := stringlib.stringreverse(reverse_addr2_bus);
			
			final_bus							:= TRIM(reverse_addr2_bus[stringlib.stringfind(reverse_addr2_bus,comma_char,2)..],LEFT,RIGHT);
			tempcity_bua					:= TRIM(temp_final_addr_bus[LENGTH(stringlib.stringreverse(final_bus))..]);


			getGoodAddr1				:= MAP(REGEXFIND(DBA_Ind,prepBusAddress1) => '',
																 addrOFFICE != '' AND prepBusAddress1 != '' => '',
																 prepBusAddress1);
																 
			SELF.ADDR_BUS_IND		:= IF(TRIM(TrimBusAddress1 +TrimBusCity+ pInput.BUS_Zip) != '','B',
																IF(LENGTH(TrimBusAddrFull) > 2 , 'B',''));																						
			SELF.ADDR_ADDR1_1		:= stringlib.stringreverse(final_bus);
			SELF.ADDR_ADDR2_1		:= getGoodAddr1;
			SELF.ADDR_ADDR3_1		:= '';
			SELF.ADDR_CITY_1		:= IF(TrimBusCity != '', TrimBusCity, stringLib.StringFilterOut(tempcity_bua,','));								
			SELF.ADDR_STATE_1   := IF(pInput.BUS_STATE != '', pInput.BUS_STATE, stringlib.stringreverse(reverse_state_bus));
																
			ParsedBusZIP       	:= IF(pInput.BUS_ZIP != '',REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.BUS_ZIP, 0), tempBuszip);
			SELF.ADDR_ZIP5_1		:= ParsedBusZIP[1..5];
			SELF.ADDR_ZIP4_1		:= ParsedBusZIP[7..10];
			
			SELF.PHN_MARI_1			:= TRIM(pInput.PHONE,LEFT,RIGHT);
			SELF.PHN_MARI_FAX_1	:= TRIM(pInput.FAX,LEFT,RIGHT);
			SELF.PHN_PHONE_1		:= StringLib.StringFilter(pInput.PHONE,'0123456789');
			SELF.PHN_FAX_1			:= StringLib.StringFilter(pInput.FAX,'0123456789');


//Obtain "Good" Address data
	   tempMail := IF(STD.Str.Find(TrimMailAddressFull, ',',5) > 0,
								  	TRIM(TrimMailAddressFull[1..STD.Str.Find(TrimMailAddressFull, ',', 4) -1], RIGHT),
									IF(STD.Str.Find(TrimMailAddressFull, ',',4) < 1, TrimMailAddressFull,		
								  	TRIM(TrimMailAddressFull[1..STD.Str.Find(TrimMailAddressFull, ',', 3) -1], RIGHT))
									);
									
			tempMailaddr2						:= IF(tempMail = '', StringLib.StringFilterOut(TrimMailAddressFull, '.'), StringLib.StringFilterOut(tempMail, '.'));
			
// moving city, state, AND zip to their respective fields
//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
			tempMailzip             := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', TRIM(tempMailaddr2,LEFT,RIGHT), 0);	
			tempMailaddr4           := tempMailaddr2[..(LENGTH(tempMailaddr2)-LENGTH(tempMailzip))];
			reverse_addr_Mail       := TRIM(stringlib.stringreverse(tempMailaddr4),LEFT,RIGHT);
			reverse_state_Mail      := reverse_addr_Mail[..stringlib.stringfind(reverse_addr_Mail,space_char,1)-1];
			reverse_addr2_Mail      := TRIM(reverse_addr_Mail[stringlib.stringfind(reverse_addr_Mail,space_char,1)..],LEFT,RIGHT);
			temp_final_addr_Mail    := stringlib.stringreverse(reverse_addr2_Mail);
			final_mail							:= TRIM(reverse_addr2_Mail[stringlib.stringfind(reverse_addr2_Mail,comma_char,2)..],LEFT,RIGHT);
			tempcity_Mail						:= TRIM(temp_final_addr_Mail[LENGTH(stringlib.stringreverse(final_mail))..]);


			SELF.ADDR_MAIL_IND	:= IF(TRIM(TrimMailAddress1 +TrimMailCity+ pInput.MAIL_ZIP) != '','M',
																IF(LENGTH(TrimMailAddressFull) > 2 ,'M',''));		
			SELF.ADDR_ADDR1_2		:= stringlib.stringreverse(final_mail);
			SELF.ADDR_ADDR2_2		:= TrimMailAddress1;
			SELF.ADDR_ADDR3_2		:= '';
			SELF.ADDR_CITY_2		:= IF(TrimMailCity != '', TrimMailCity,StringLib.StringFilterOut(tempcity_Mail,','));
			SELF.ADDR_STATE_2		:= IF(pInput.MAIL_STATE != '', pInput.MAIL_STATE, stringlib.stringreverse(reverse_state_Mail));
			ParsedMailZIP       := IF(pInput.MAIL_ZIP != '', REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.MAIL_ZIP, 0), tempMailzip);
			SELF.ADDR_ZIP5_2		:= ParsedMailZIP[1..5];
			SELF.ADDR_ZIP4_2		:= ParsedMailZIP[7..10];
			SELF.URL						:= ut.CleanSpacesAndUpper(pInput.WEBSITE);
			SELF.DISP_TYPE_CD   := IF(SELF.RAW_LICENSE_STATUS IN ['REVOKED','SUSPENDED','TERMINATED'],'Q','');
			SELF.OOC_IND_1			:= 0;    
			SELF.OOC_IND_2			:= 0;


		//Expected codes [CO,BR,IN], Set during business/individual filter
			SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO','');		

		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
			SELF.CMC_SLPK       := hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																				+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																				+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																				+TRIM(SELF.NAME_FIRST,LEFT,RIGHT) + ','
																				+TRIM(SELF.NAME_LAST,LEFT,RIGHT) + ','
																				+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																				+IF(TrimBusAddress1 != '',TRIM(TrimBusAddress1,LEFT,RIGHT), TRIM(TrimBusAddrFull,LEFT,RIGHT) + ','
																				+IF(TrimBusCity != '',TRIM(TrimBusCity,LEFT,RIGHT),'') + ','
																				+IF(pInput.BUS_ZIP != '',TRIM(pInput.BUS_ZIP),'')
																				));
			
			//store transaction code AND date in provnote_2
			SELF.PROVNOTE_2			:= TRIM(IF(TrimTransCode<>'','TRANS CODE:'+TrimTransCode+'.','') +
			                            IF(TRIM(pInput.TRANS_DATE)<>'','TRANS DATE:'+TRIM(pInput.TRANS_DATE),''),LEFT,RIGHT);
			SELF.PROVNOTE_3 		:= IF(SELF.RAW_LICENSE_STATUS = '','{LIC_STATUS ASSIGNED}',''); 
			SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(GoodValidRec,xformToCommon(LEFT));

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layout_base_in trans_lic_status(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in 	trans_lic_type(ds_map_status_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := IF(l.std_prof_cd = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
															L.STD_PROF_CD);
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_status_trans, Cmvtranslation,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup  := ds_map_source_desc(type_cd  = 'GR' AND name_org != '' AND addr_addr1_1 != '' AND addr_city_1 != '');
	company_only_lookup  := ds_map_lic_trans(type_cd  = 'GR' AND name_org != '' AND addr_addr1_1 != '' AND addr_city_1 != '');


	//Prof_License_Mari.layouts_reference.MARIBASE 	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := TRANSFORM
	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	//ds_map_affil_md := JOIN(ds_map_source_desc, company_only_lookup,
	ds_map_affil_md := JOIN(ds_map_lic_trans, company_only_lookup,
							LEFT.NAME_OFFICE = StringLib.StringCleanSpaces(RIGHT.NAME_ORG+' '+RIGHT.NAME_ORG_SUFX)
							AND LEFT.ADDR_ADDR1_1 = RIGHT.ADDR_ADDR1_1
							AND LEFT.ADDR_CITY_1 = RIGHT.ADDR_CITY_1
							AND LEFT.TYPE_CD ='MD',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOCAL);



	Prof_License_Mari.layout_base_in xTransPROVNOTE(ds_map_affil_md L) := TRANSFORM
		SELF.PROVNOTE_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + Comments,
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => Comments,
																				L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil_md, xTransPROVNOTE(LEFT));

	// TRANSFORM expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(OutRecs L) := TRANSFORM
		SELF.NAME_DBA					:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_DBA,'/',' '));
		SELF.NAME_OFFICE			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF.ADDR_ADDR1_2			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_2));
		SELF := L;
	END;

	ds_map_base 				:= PROJECT(OutRecs, xTransToBase(LEFT));

	d_final 						:= OUTPUT(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	remove_logical 			:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));		

	move_to_used				:= Prof_License_Mari.func_move_file.MyMoveFile(code, 'rel','using','used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCMV, oREL, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	

END;