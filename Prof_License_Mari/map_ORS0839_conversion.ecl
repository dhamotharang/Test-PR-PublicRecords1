/* Converting Oregon Real Estate Agency/Mulitple Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_ORS0839_conversion(STRING pVersion) := FUNCTION

	code 								:= 'ORS0839';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(Cmvtranslation);
	
	//string8 process_dte:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();
	//Move to using
	move_to_using				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'act_business','sprayed','using');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'all_individual','sprayed','using');	
																	);

	act_bususiness 			:= Prof_License_Mari.files_ORS0839.act_bususiness;
	oBUS								:= OUTPUT(act_bususiness);
	all_individual 			:= Prof_License_Mari.files_ORS0839.all_individual;
	oIND								:= OUTPUT(all_individual);

	rLayout_License	:= record, maxsize(5000)
		Prof_License_Mari.layout_ORS0839.individual;
		string20 PHONE;
		string30 LIC_TYPE;
		string20 LIC_ISSUE_DATE;
	END;

	file_bus := project(act_bususiness,TRANSFORM(rLayout_License,
																						SELF.LIC_STATUS := 'ACTIVE';
																						SELF.LIC_TYPE := 'COMPANY';
																						//SELF.LIC_TYPE := REGEXFIND('^([A-Z]+)\\.',LEFT.LIC_NUMBER,1);
																						SELF := LEFT;
																						SELF := []));
																						
	rLayout_License xformIndividual(all_individual pInput) := TRANSFORM
		tmpLicenseNum := pInput.LIC_NUMBER;
		tmpLicenseType := REGEXFIND('([^\\.]*)[\\.]{1}',tmpLicenseNum,1);
		SELF.LIC_TYPE := TRIM(tmpLicenseType,LEFT,RIGHT);
		SELF := pInput;
		SELF := [];
	END;
	
	file_ind := project(all_individual,xformIndividual(LEFT));
	
	inFile := file_bus(ORG_NAME!=' ') + file_ind(trim(LAST_NAME) != '');

	//Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|' +
										'REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS)';

	AddrExceptions := '(PLAZA|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY)';

	invalid_addr := '(N/A|NONE |NO VALID|SAME )';
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	quote_pattern	:= '^(.*)\\"(.*)\\"(.*)$';
	paren_pattern := '^(.*)\\((.*)\\)(.*)$';
	dbl_quote_pattern := '^(.*)\\"\\"(.*)\\"\\"(.*)$';

	//Filtering out BAD RECORDS
	FilterBlankLic	:= inFile(LIC_TYPE != '');
	// FilterBadName		:= FilterBlankLic(StringLib.StringToUpperCase(LAST_NAME[1..5]) != 'ERROR');
	// GoodNameRec 		:= FilterBadName(NOT REGEXFIND('(ENTERED IN ERROR|IN ERROR|INPUT ERROR|ERROR|REQUIRED C E COURSE)', StringLib.StringToUpperCase(trim(ORG_NAME,left,right))));
																		
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(rLayout_License pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		self.LICENSE_STATE	 	:= src_st;

		//Standardize Fields
		TrimNAME_LAST 				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LAST_NAME);
		TrimNAME_FIRST 				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.MID_NAME);
		//TrimNAME_ORG					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME);
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME);
		noquoteORG1      			:= stringlib.stringfindreplace(tmpNameOrg,'"','');
		TrimNAME_ORG      			:= stringlib.stringfindreplace(noquoteORG1,'\'','');

		TrimAddress1_prep			:= stringlib.stringfindreplace(Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1),'"','');
		TrimAddress1					:= IF(TrimAddress1_prep[1]='`' OR TrimAddress1_prep[1]='=',TrimAddress1_prep[2..],TrimAddress1_prep);
		TrimAddress2_prep			:= stringlib.stringfindreplace(Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS2),'"','');
		TrimAddress2					:= IF(TrimAddress2_prep[1]='`' OR TrimAddress2_prep[1]='=',TrimAddress2_prep[2..],TrimAddress2_prep);
		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY);
		TrimCnty							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.COUNTY);
		TrimLicType						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_TYPE);
			
		// License Information
		self.TYPE_CD					:= IF(pInput.LIC_TYPE = 'COMPANY','GR','MD');
		self.LICENSE_NBR	  	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_NUMBER);
		self.OFF_LICENSE_NBR	:= '';
		SELF.RAW_LICENSE_TYPE	:= REGEXFIND('^([A-Z]+)\\.',self.LICENSE_NBR,1);
		// self.STD_LICENSE_TYPE := CASE(self.RAW_LICENSE_TYPE,
																		// 'BROKER ' => 'B',
																		// 'BROKER-SOLE PRACTITIONER' => 'BSP',
																		// 'MCC - BROKER' => 'MCCB',
																		// 'MCC - SALESPERSON' => 'MCCS',
																		// 'PRINCIPAL BROKER' => 'PB',
																		// 'PROPERTY MANAGER' => 'PM',
																		// 'COMPANY' => 'C',
																		// 'TEMPORARY BROKER' => 'TB',
																				// '');
		//Vendor file does not provide license type anymore. It is derived from the license number for individual and assigned
		//as COMANY for company.
		
		SELF.STD_LICENSE_TYPE	:= CASE(TRIM(SELF.RAW_LICENSE_TYPE),
																	'COMPANY' => 'C',
																	//secondary_lic_type is no longer provided. Use the last character of the license number
																	//'MCC' => 'MCC' + Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SECONDARY_LIC_TYPE),
																	'MCC' => 'MCC' + REGEXFIND('.*-(.{1})$',TRIM(self.LICENSE_NBR),1),
																	'PBLN' => 'PB',
																	'PMLN' => 'PM',
																	TRIM(SELF.RAW_LICENSE_TYPE));
		
		SELF.RAW_LICENSE_STATUS := Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_STATUS);
				
		//Reformatting date to YYYYMMDD	
		issue_dte 						:= MAP(REGEXFIND('(N/A)',pInput.LIC_ISSUE_DATE) => '00000000',
																 REGEXFIND('(11111111|88888888)',pInput.LIC_ISSUE_DATE) => '00000000',
																 pInput.LIC_ISSUE_DATE = '' => '00000000',
																 Prof_License_Mari.DateCleaner.norm_date3(pInput.LIC_ISSUE_DATE));

		expire_dte 						:=  MAP(REGEXFIND('(N/A)',pInput.LIC_EXP_DATE) => '00000000',
																	REGEXFIND('(11111111|88888888)',pInput.LIC_EXP_DATE) => '00000000',
																	pInput.LIC_EXP_DATE = '' => '00000000',
																	Prof_License_Mari.DateCleaner.norm_date3(pInput.LIC_EXP_DATE));
		
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= IF(issue_dte != '00000000',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(issue_dte),'17530101');
		self.EXPIRE_DTE				:= IF(expire_dte NOT IN ['00000000','//'],Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(expire_dte),'17530101');
		
		// Identify NICKNAME in the various format 
		tempLNick							:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');
		stripNickLName				:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick');
		GoodLastName					:= IF(tempLNick != '',stripNickLName,TrimNAME_LAST);

		tempMNick							:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');
		stripNickMName				:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick');
		GoodMidName						:= IF(tempMNick != '',stripNickMName,TrimNAME_MID);

		tempFNick							:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		stripNickFName				:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		GoodFirstName					:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		
		ParsedName 						:= Address.CleanPersonFML73(GoodFirstName +' '+GoodMidName+ ' '+GoodLastName);
		//Use the first/middle/last name provided by vendor if name parser return a 1 character last name
		//FirstName 						:= TRIM(ParsedName[6..25],left,right);
		FirstName 						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))<2,TrimNAME_FIRST,TRIM(ParsedName[6..25],LEFT,RIGHT));
		//MidName   						:= TRIM(ParsedName[26..45],left,right);	
		MidName								:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))<2,TrimNAME_MID,TRIM(ParsedName[26..45],LEFT,RIGHT));
		//LastName  						:= TRIM(ParsedName[46..65],left,right); 
		LastName							:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))<2,TrimNAME_LAST,TRIM(ParsedName[46..65],LEFT,RIGHT));
		//Suffix	  						:= TRIM(ParsedName[66..70],left,right);
		Suffix	  						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))=0,' ',TRIM(ParsedName[66..70],left,right));
		ConcatNAME_FULL 			:= 	StringLib.StringCleanSpaces(LastName +' '+FirstName);
		
		// Corporation Names
		prepNAME_ORG 					:= IF(TrimLicType = 'COMPANY',TrimNAME_ORG,'');																			
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG) ,Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																IF(REGEXFIND(C_O_Ind,prepNAME_ORG),
																   Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																	 prepNAME_ORG)
																);
		StdNAME_ORG 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG);
		CleanNAME_ORG					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
															
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		self.NAME_ORG		    	:= IF(self.TYPE_CD = 'MD',ConcatNAME_FULL,
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
		self.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));		
		self.NAME_FIRST		   	:= IF(self.TYPE_CD = 'MD',FirstName, ' ');
		self.NAME_MID					:= IF(self.TYPE_CD = 'MD',MidName,' ');	 
		self.NAME_LAST				:= IF(self.TYPE_CD = 'MD',LastName,' ');	 
		self.NAME_SUFX				:= IF(self.TYPE_CD = 'MD',Suffix, ' ');
		self.NAME_NICK				:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																	tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																	tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),'');

		//Filtering out Individual/Business Names
		prepAddress1 					:= IF(NOT REGEXFIND(invalid_addr,TrimAddress1),TrimAddress1,'');
		prepAddress2 					:= IF(NOT REGEXFIND(invalid_addr,TrimAddress2),TrimAddress2,'');
		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,prepAddress1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1),
																 REGEXFIND(DBA_Ind,prepAddress1) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepAddress1),			
																 REGEXFIND('%',prepAddress1[1])=> StringLib.StringFilterOut(prepAddress1,'%'),
													 													 																						'');
		
		tmpAddr2Contact				:= MAP(REGEXFIND(C_O_Ind,prepAddress2)=>
																	Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress2),
																 REGEXFIND('%',prepAddress2[1])=> StringLib.StringFilterOut(prepAddress2,'%'),
																 '');
		
		//Identifying Contact Info		
		prepAddr1Contact 			:= MAP(Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 REGEXFIND(BusExceptions,tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
																												
		prepAddr2Contact 			:= MAP(Prof_License_Mari.func_is_address(tmpAddr2Contact) => '',
																 tmpAddr2Contact != '' => tmpAddr2Contact,
																 '');

		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact)
																 AND NOT REGEXFIND(BusExceptions,prepAddr1Contact) => '',
																 prepAddr1Contact != '' and NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																											Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																 prepAddr2Contact != '' AND Prof_License_Mari.func_is_company(prepAddr2Contact)
																					AND NOT REGEXFIND(BusExceptions,prepAddr2Contact) => '',										
																 prepAddr2Contact != '' and NOT Prof_License_Mari.func_is_company(prepAddr2Contact) =>
																											Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr2Contact),
												 				 '');
																 
		self.LICENSE_NBR_CONTACT:= '';											
		self.NAME_CONTACT_PREFX	:= '';
		self.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],left,right);
		self.NAME_CONTACT_MID	:= TRIM(ParseContact[26..45],left,right);  
		self.NAME_CONTACT_LAST:= TRIM(ParseContact[46..65],left,right);
		self.NAME_CONTACT_SUFX:= TRIM(ParseContact[66..70],left,right);  
		self.NAME_CONTACT_NICK:= '';
		self.NAME_CONTACT_TTL	:= '';

	//Identifying DBA NAMES
		getNAME_OFFICE 				:= IF(TrimLicType != 'COMPANY',TrimNAME_ORG,'');
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(getNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(getNAME_OFFICE,'D/B/A ',' DBA '),
																 getNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(getNAME_OFFICE,'C/O ',''),
																 getNAME_OFFICE);

		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 REGEXFIND(DBA_Ind,prepNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 StringLib.stringfind(TrimAddress1,' % ',1) > 0 => REGEXFIND('^([A-Za-z ][^\\%]+)[\\%][\\s]([A-Za-z ]+)',TrimAddress1,2),
																 REGEXFIND(DBA_Ind,TrimAddress1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
																 '');
																																						
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),				    
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   						 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);
	  		
    //Identifying BUSINESS NAME(s) from CONTACT NAME(s)
		contact1OFFICE				:= MAP(REGEXFIND(DBA_Ind,tmpAddr1Contact) => '',
																 StringLib.stringfind(trim(tmpAddr1Contact),' ',1) = 0 => tmpAddr1Contact,
																 tmpAddr1Contact != '' and Prof_License_MARI.func_is_company(tmpAddr1Contact) => tmpAddr1Contact,
																 REGEXFIND(BusExceptions,tmpAddr1Contact) => tmpAddr1Contact, 
																 '');
		contact2OFFICE				:= IF(tmpAddr2Contact != '' and Prof_License_MARI.func_is_company(tmpAddr2Contact),tmpAddr2Contact, 
															  IF(REGEXFIND(BusExceptions,tmpAddr2Contact),tmpAddr2Contact,'')); 
																																																																														
		//Identify Business Names	from Address Fields
		addrOFFICE						:= MAP(ParseContact != '' => '',
																 contact1OFFICE != '' => '',
																 //If address field has digits only, do not treat it as office name
																 REGEXFIND('^[0-9]+$',prepAddress1) => '',
																 NOT StringLib.stringfind(trim(prepAddress1),' ',1) > 0 => prepAddress1,
																 REGEXFIND(BusExceptions,prepAddress1)AND NOT REGEXFIND(C_O_Ind,prepAddress1) 
																		AND NOT REGEXFIND(DBA_Ind,prepAddress1) => prepAddress1,																
																	NOT REGEXFIND('[0-9]', prepAddress1) AND NOT REGEXFIND(AddrExceptions,TrimAddress1)
																				AND NOT REGEXFIND(C_O_Ind,prepAddress1) AND NOT REGEXFIND(DBA_Ind,TrimAddress1) => prepAddress1,
																 '');
																													
		getContactOFFICE 			:= MAP(contact1OFFICE != '' => contact1OFFICE,
																 addrOFFICE != '' => addrOFFICE,
																 contact2OFFICE != '' => contact2OFFICE,
																'');	
													
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 REGEXFIND(C_O_Ind,prepNAME_ORG)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
																 getContactOFFICE != '' and prepNAME_OFFICE = '' => getContactOFFICE,
																 prepNAME_OFFICE);
																					
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																	 Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		self.NAME_OFFICE	    := CleanNAME_OFFICE;
		self.OFFICE_PARSE			:= IF(self.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR',
																IF(self.NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(self.NAME_OFFICE),'MD',
																''));
			
	//Populating MARI Name Fields
		self.NAME_ORG_ORIG	  := IF(self.TYPE_CD = 'MD',
																			StringLib.StringCleanSpaces(TrimNAME_FIRST + ' '+TrimNAME_MID+ ' '+TrimNAME_LAST),
																			tmpNameOrg);
		SELF.NAME_FORMAT			:= 'F';
		
		self.NAME_DBA_ORIG	  := '';
		self.NAME_MARI_ORG	  := IF(self.TYPE_CD = 'MD',self.NAME_OFFICE,StdNAME_ORG);
		self.NAME_MARI_DBA	  := StdNAME_DBA;
	
		//Obtain "Good" Address data
/* 		getGoodAddr1					:= MAP(REGEXFIND(DBA_Ind,prepAddress1) => '',
   																 tmpAddr1Contact != '' and Prof_License_Mari.func_is_address(tmpAddr1Contact) => tmpAddr1Contact,
   																 tmpAddr1Contact != ''  => '',
   																 addrOFFICE != '' and prepAddress1 != '' => '',
   												  			 prepAddress1);
   												
   		getGoodAddr2					:= MAP(tmpAddr2Contact != '' and Prof_License_Mari.func_is_address(tmpAddr2Contact) => tmpAddr2Contact,
   																 tmpAddr2Contact != ''  => '',
   																 prepAddress2);
   		
   																						
   		newAddress1 					:= IF(getGoodAddr1 != '', getGoodAddr1,
   																IF(getGoodAddr1 = '' and getGoodAddr2 != '',getGoodAddr2,
   																																		getGoodAddr1));
   		newAddress2 					:= IF(getGoodAddr1 != '' and getGoodAddr2 != '',getGoodAddr2, 
   																IF(getGoodAddr1 = '' and getGoodAddr2 != '',
   																   '',
   																	 getGoodAddr2)
   																);
   																
   		self.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2 + TrimCity + pInput.ZIP) != '','B','');
   		self.ADDR_ADDR1_1			:= newAddress1;
   		self.ADDR_ADDR2_1			:= newAddress2;
   		//self.ADDR_ADDR3_1			:= TrimAddress1;
   		//self.ADDR_ADDR4_1			:= TrimAddress2;
   		self.ADDR_CITY_1			:= IF(StringLib.Stringfind(TrimCity,'NO CITY',1) > 0, '',TrimCity);
   		self.ADDR_STATE_1     := Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE);
   																	
   		ParsedZIP       			:= REGEXFIND('[0-9]{5}(-[0-9]{4})?', pInput.ZIP, 0);
   		self.ADDR_ZIP5_1			:= ParsedZIP[1..5];
   		self.ADDR_ZIP4_1			:= IF(ParsedZIP[7..10]='0000',' ',ParsedZIP[7..10]);
*/
		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^C/O[A-Z ]*|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES$|^.* SOLUTIONS$|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^N/A$' +
						 ')';

		tmpZip	 							:= MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
		                             LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
		
	  //Extract contact info in the address fields
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trimCity+' '+pInput.STATE +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		//self.provnote_1 := trimAddress1+'|'+trimAddress2;

		self.ADDR_CNTY_1			:= TrimCnty;
		
		SELF.PHN_MARI_1				:= TRIM(pInput.PHONE,LEFT,RIGHT);
		SELF.PHN_PHONE_1			:= TRIM(StringLib.StringFilter(self.PHN_MARI_1,'0123456789'),LEFT,RIGHT);
		self.OOC_IND_1				:= 0;    
		self.OOC_IND_2				:= 0;
		
		//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD		:= MAP(self.TYPE_CD = 'MD' => 'IN',
																 self.TYPE_CD = 'GR' => 'CO','');		

		self.MLTRECKEY 				:= 0;

		//Fields used to create unique key are: license number, license type, source update, name, address,dba 
/* 		self.CMC_SLPK       	:= hash64(trim(self.license_nbr,left,right) 
   																			+trim(self.std_license_type,left,right)
   																			+trim(self.std_source_upd,left,right)
   																			+trim(self.NAME_ORG,left,right)
   																			+trim(CleanNAME_OFFICE,left,right)
   																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(temp_address1)
   																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(temp_address2)
   																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY)
   																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP));
*/
		//concat these strings and remove null, \n, \r, and blank. These characters create different cmcslpk.
		tmpCmcSlpk						:= self.license_nbr
														 + self.std_license_type
														 + self.std_source_upd
														 + self.NAME_ORG
														 + CleanNAME_OFFICE
														 + Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1)
														 + Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS2)
														 + Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY)
														 + Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP);
		//tmpCmcSlpk_4 := regexreplace('('+x'00'+'|'+x'0a'+'|'+x'0d'+'|'+' '+')', tmpCmcSlpk,''); - this does not work. don't know why.
 		tmpCmcSlpk_1				:= regexreplace(x'00',tmpCmcSlpk,'');
   	tmpCmcSlpk_2				:= regexreplace(x'0a',tmpCmcSlpk_1,'');
   	tmpCmcSlpk_3				:= regexreplace(x'0d',tmpCmcSlpk_2,'');
   	tmpCmcSlpk_4					:= regexreplace(' ',tmpCmcSlpk_3,'');

		self.CMC_SLPK       	:= hash64(tmpCmcSlpk_4);

		self.PCMC_SLPK				:= 0;
		SELF 									:= [];	
		   
	END;
	
	inFileLic	:= project(FilterBlankLic,xformToCommon(left));


	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(trim(R.DM_VALUE1,left,right));
																
		self := L;
	end;

	ds_map_status_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_STATUS' ,
							trans_lic_status(left,right),left outer,lookup);

	// Populate STD_LICENSE_TYPE field via translation on statu field
	// Prof_License_Mari.layouts_reference.MARIBASE 	trans_std_lic(inFileLic L, Cmvtranslation R) := transform
		// self.STD_LICENSE_TYPE := StringLib.stringtouppercase(trim(R.DM_VALUE2,left,right)));
		// self := L;
	// end;

	// ds_map_std_lic := JOIN(inFileLic, Cmvtranslation,
							// TRIM(left.raw_license_type,left,right)= TRIM(right.fld_value,left,right)
							// AND right.fld_name='LIC_TYPE'
							// AND right.dm_name2 = 'LIC_TYPE',
							// trans_std_lic(left,right),left outer,lookup);

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_status_trans L, Cmvtranslation R) := transform
		self.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1,LEFT,RIGHT));
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_status_trans, Cmvtranslation,
							TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer,lookup);
																		
/*
// Populate prof code description
Prof_License_Mari.layouts_reference.MARIBASE  trans_prof_desc(ds_map_lic_trans L, LicProfLkp R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := JOIN(ds_map_lic_trans, LicProfLkp,
						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
						 trans_prof_desc(left,right),left outer,lookup);
																		

// Populate License Status Description field
Prof_License_Mari.layouts_reference.MARIBASE trans_status_desc(ds_map_prof_desc L, LicStatusLkp R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
  self := L;
end;

ds_map_status_desc := jOIN(ds_map_prof_desc, LicStatusLkp,
							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
							trans_status_desc(left,right),left outer,lookup);
																		
//Populate License Type Description field
Prof_License_Mari.layouts_reference.MARIBASE trans_type_desc(ds_map_status_desc L, LicTypeLkp R) := transform
  self.STD_LICENSE_DESC := IF(L.STD_LICENSE_DESC = '',StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right)),
																L.STD_LICENSE_DESC);
  self := L;
end;

ds_map_type_desc := JOIN(ds_map_status_desc, LicTypeLkp,
						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
						trans_type_desc(left,right),left outer,lookup);
						
					                                                                                       	
//Populate Source Description field
Prof_License_Mari.layouts_reference.MARIBASE 	trans_source_desc(ds_map_type_desc L, LicSrcLkp R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
  self := L;
end;

ds_map_source_desc := join(ds_map_type_desc, LicSrcLkp,
						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
						trans_source_desc(left,right),left outer,lookup);
*/

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	//Prof_License_Mari.layouts_reference.MARIBASE xTransToBase(ds_map_source_desc L) := transform
	Prof_License_Mari.layouts.base xTransToBase(ds_map_lic_trans L) := transform
		self.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, ' ');
		self.NAME_OFFICE		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		self.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		self.NAME_MARI_DBA	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
		self.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		self.ADDR_ADDR2_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1));
		
		self := L;
	end;

	//ds_map_base := PROJECT(ds_map_lic_trans, xTransToBase(left));

	//Remove dup record before processing
//	ds_map_base_deduped := DEDUP(SORT(ds_map_base,LICENSE_NBR),RECORD);

inFileLicDist	:= distribute(ds_map_lic_trans,hash(name_org,license_nbr,std_license_type,addr_addr1_1));
inFileLicSort	:= sort(inFileLicDist,name_org,license_nbr,std_license_type,addr_addr1_1,-expire_dte,-orig_issue_dte,local);
ds_map_base_deduped := dedup(inFileLicSort,name_org,license_nbr,std_license_type,addr_addr1_1,local);

	//Add to super files and clean up
	d_final 						:= output(ds_map_base_deduped, ,mari_dest+pVersion +'::'+src_cd,__compressed__,overwrite);			

//BUG 180478
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base_deduped(NAME_ORG_ORIG != ''));				
	// add_super 					:= sequential(fileservices.startsuperfiletransaction(),
																		// fileservices.addsuperfile(mari_dest+src_cd, mari_dest+pVersion+'::'+src_cd),
																		// fileservices.finishsuperfiletransaction()
																		// );
	move_to_used 				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'act_business','using','used');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'all_individual','using','used');	
																	);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oBUS, oIND, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);


END;

