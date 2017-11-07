/* Converting Wisconsin Dept of Regulation and Licensing Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT ut
		 ,Prof_License_Mari
		 ,lib_stringlib
		 ,Lib_FileServices
		 ,Address
		 ;

EXPORT  map_WIS0854_conversion(STRING pVersion) := FUNCTION
#workunit('name','Prof License MARI- WIS0854 ' + pVersion);	
	
code 		:= 'WIS0854';  
src_cd	:= 'S0854';
src_st	:= 'WI';	//License state

inFile := Prof_License_Mari.files_WIS0854;
oFile  := OUTPUT(Prof_License_Mari.files_WIS0854);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0854');
ocmvTranLkp := OUTPUT(cmvTransLkp);

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
IND_TYPE := ['4 ','9 ','10','90','93','94'];
BUS_TYPE := ['91'];

AddrExceptions := '(CENTURY 21|BUILDING INSIGHT LLC|RE/MAX|RE MAX|COST CUTTERS|APPRAISAL| INC |AF MALMQUIST|WRA|REAL ESTATE)';
BusException := '(BUILDING|HOUSES|CORNER |MAIN | RR |CTRY CLUB|COUNTY|MOTEL|PLANTATION)'; 
C_O_Ind := '(C/O |ATTN:|ATTN|ATTENTION:|ATT:|%)';
DBA_Ind := '( DBA|D/B/A | D/B/A|/DBA | A/K/A | AKA |T/A | DBA )';
invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|TBD|NOT CURRENTLY)';

quote_pattern	:= '^(.*)\\"(.*)\\"(.*)$';
paren_pattern := '^(.*)\\((.*)\\)(.*)$';
dbl_quote_pattern := '^(.*)\\"\\"(.*)\\"\\"(.*)$';
CO_pattern := '^(.*)(C/O |%| C/0| ATTN: |ATTN  )(.*)$';

CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* LLC |^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.* CORP |^.*APPRAISAL$|^.*APPRAISALS$|' +
									'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$|^ATTN:.*$' +
									'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
									'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* BUILDING$|^.* OFFICE$' +
									')';
									
RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* LLC |^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.* CORP |^.*APPRAISAL$|^.*APPRAISALS$|' +
											'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
											'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^C/O.*$|^ATTN.*$|' +
											'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES' +
											'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATTN:.*$|' +
											'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
											'^.* BUILDING$|^.* LAKE RESORT$|^ATT:.*$|^.* AM$' +
											')';
	
	
	ValidFile	:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUpperCase(LIC_NUMR)) 
	                    AND StringLib.StringToUpperCase(LIC_NUMR) != '');
  oValidFile := output(ValidFile);
  ut.CleanFields(ValidFile, clnFile);	

Layout_Vehicle_Ref := RECORD
  STRING    CREDENTIAL_LICENSE_NBR;
	STRING	  CUST_ID;
	STRING    DOR_TITLE_NUMBER;
	STRING    COUNTY;
	STRING    VEHICLE_ID;
	STRING    MAKE;
	STRING    YEAR;
	STRING    VEHICLE_LENGTH;
	STRING    VEHICLE_WIDTH;
	STRING    OWNER;
	STRING    LEIN_HOLDER;
	STRING    LEIN_HOLDER_ADDRESS;
	STRING    LAST_ACTION;
	STRING    LAST_ACTION_DATE;
END;

  ds_Vehicle    := PROJECT(clnFile,TRANSFORM(Layout_Vehicle_Ref, SELF.CREDENTIAL_LICENSE_NBR := TRIM(LEFT.LIC_NUMR + '-' + LEFT.LIC_TYPE,ALL), SELF := LEFT; SELF :=[]));
  
	REF_Vehicle   := OUTPUT(ds_Vehicle, ,'~thor_data400::in::proflic_mari::WIS0854::Vehicle_ref',OVERWRITE);	
	REF_Vehicle_Blank := OUTPUT('NO VEHICLE INFOMATION RECEIVED');
  oREF_Vehicle  := IF(COUNT(ds_Vehicle(CUST_ID + DOR_TITLE_NUMBER + COUNTY + VEHICLE_ID + MAKE + YEAR + VEHICLE_LENGTH + VEHICLE_WIDTH +
	                          OWNER + LEIN_HOLDER + LEIN_HOLDER_ADDRESS + LAST_ACTION + LAST_ACTION_DATE !=''))>0,REF_Vehicle,
	                    REF_Vehicle_Blank);

//WI Licensing to common MARIBASE layout
Prof_License_Mari.layouts.base	xformToCommon(Prof_License_Mari.layout_WIS0854.src pInput) 
	:= 
	 TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= pVersion;
		SELF.DATE_LAST_SEEN		:= pVersion;
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		SELF.CREATE_DTE				:= pVersion; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= pInput.ln_filedate;
		SELF.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';
		SELF.TYPE_CD					:= MAP(pInput.LIC_TYPE[1..2] IN IND_TYPE => 'MD',
																 pInput.LIC_TYPE[1..2] IN BUS_TYPE => 'GR','');
				
		TrimFullName    := ut.CleanSpacesAndUpper(pInput.FULL_NAME);
		TrimLicType			:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);
		TrimStatus			:= ut.CleanSpacesAndUpper(pInput.LIC_STATUS);
		TrimAddress1 		:= ut.CleanSpacesAndUpper(pInput.ADDRESS);
		TrimCity				:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimName_Contact:= ut.CleanSpacesAndUpper(pInput.CONTACT);
		
		// Identify NICKNAME in the various format 
		BusinessPattern  := '(SERVICE|REALTY)'; 
		getNAME_FULL  := IF(TrimLicType[1..2] IN IND_TYPE AND NOT REGEXFIND(BusinessPattern,TrimFullName),REGEXREPLACE(',$',TrimFullName,''),'');
	 	// Identify NICKNAME in the various format 
		tempNick      := Prof_License_Mari.fGetNickname(getNAME_FULL,'nick');
		stripNickName	:= Prof_License_Mari.fGetNickname(getNAME_FULL,'strip_nick');
		GoodFullName	:= IF(tempNick != '',stripNickName,getNAME_FULL);
		
		SuffixPattern         := '(JR\\.|SR\\.| JR$| JR | SR$| SR | III| II| IV$| IV | IV| VII$| VII | VI$| VI )';
		removesuffix          := REGEXREPLACE(SuffixPattern,GoodFullName,'');
		TmpSuffix1            := TRIM(REGEXFIND(SuffixPattern,GoodFullName,0),LEFT,RIGHT);															
		
		ClnLFMName						:= Prof_License_Mari.mod_clean_name_addr.cleanLFMName(removeSuffix);																
																	
		GoodNAME_FIRST := MAP(REGEXFIND('(.*),(.*),([A-Za-z ]*)',removeSuffix) => REGEXFIND('(.*),(.*),([A-Za-z ]*)',removeSuffix,2),
		                      REGEXFIND('(.*),([A-Za-z ]*)',removeSuffix) => REGEXFIND('(.*),([A-Za-z ]*)',removeSuffix,2),
													           ClnLFMName<>'' => TRIM(ClnLFMName[6..25],LEFT,RIGHT),
												            '');
		GoodNAME_MID   := MAP(REGEXFIND('(.*),(.*),([A-Za-z ]*)',removeSuffix)=>REGEXFIND('(.*),(.*),([A-Za-z ]*)',removeSuffix,3),
		                      REGEXFIND('(.*),([A-Za-z ]*)',removeSuffix) => '',
		                      ClnLFMName<>'' => TRIM(ClnLFMName[26..45],LEFT,RIGHT),
		                      '');
		TempNAME_LAST  := MAP(REGEXFIND('(.*),(.*),([A-Za-z ]*)',removeSuffix) => REGEXFIND('(.*),(.*),([A-Za-z ]*)',removeSuffix,1),
		                      REGEXFIND('(.*),([A-Za-z ]*)',removeSuffix) => REGEXFIND('(.*),([A-Za-z ]*)',removeSuffix,1),
												            ClnLFMName<>''=> TRIM(ClnLFMName[46..65],LEFT,RIGHT),
												            '');
		GoodNAME_LAST  := REGEXREPLACE(',',REGEXREPLACE(SuffixPattern,TempNAME_LAST,''),'');		
		

		TmpSuffix2     := TRIM(REGEXFIND(SuffixPattern,TempNAME_LAST,0),LEFT,RIGHT);		
		GoodNAME_SUFX  := MAP(TmpSuffix1 <> '' => TmpSuffix1,
		                      TmpSuffix2 <> '' => TmpSuffix2,
		                      '');

		Suffix	  := GoodNAME_SUFX;
		ConcatNAME_FULL := 	StringLib.StringCleanSpaces(GoodNAME_LAST +' '+	GoodNAME_FIRST);
		
		StdNAME_ORG := IF(TrimLicType[1..2] IN BUS_TYPE or Prof_License_Mari.func_is_company(TrimFullName) = true,
		                  Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimFullName),'');
		tmpNAME_ORG := MAP(REGEXFIND(DBA_Ind,StdNAME_ORG)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(StdNAME_ORG),
											 StringLib.stringfind(StdNAME_ORG, '/',1) > 0 => StringLib.StringFindReplace(StdNAME_ORG,'/',' '),
																StdNAME_ORG);
																																											
		CleanNAME_ORG	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',tmpNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNAME_ORG),
												         REGEXFIND('(%)',tmpNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',tmpNAME_ORG,1),
																 REGEXFIND('(^THE)([A-Za-z ]*)(CORP)[ ](INC)',TRIM(tmpNAME_ORG,LEFT,RIGHT)) 
													          OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(tmpNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(tmpNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(tmpNAME_ORG),
																 REGEXFIND('(^THE)([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(tmpNAME_ORG,LEFT,RIGHT))
																    OR REGEXFIND('(^THE)([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(tmpNAME_ORG,LEFT,RIGHT)) => REGEXREPLACE('^THE',tmpNAME_ORG,''),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(tmpNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(tmpNAME_ORG,LEFT,RIGHT)) => tmpNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(tmpNAME_ORG));																																	
																																																																																		
		SELF.NAME_ORG_PREFX		:= IF(SELF.TYPE_CD = 'GR',Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNAME_ORG),''); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD' and ConcatName_FULL != '', ConcatNAME_FULL,
																					StringLib.StringCleanSpaces(CleanNAME_ORG));
		SELF.NAME_ORG_SUFX	  := IF(SELF.TYPE_CD = 'GR',Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNAME_ORG),'');
	
		tmpNAME_DBA		:= IF(TrimLicType[1..2] IN BUS_TYPE AND REGEXFIND('( DBA | D/B/A )',StdNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(StdNAME_ORG),'');
		prepNAME_DBA	:= IF(StringLib.stringfind(tmpNAME_DBA,'/',1) > 0, StringLib.StringFindReplace(tmpNAME_DBA,'/',' '),tmpNAME_DBA);										
		StdNAME_DBA		:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_DBA);
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		SELF.NAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.strippunctName(StdNAME_DBA);
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		SELF.NAME_FIRST		    := IF(SELF.TYPE_CD != 'GR',TRIM(GoodNAME_FIRST,LEFT,RIGHT),'');
		SELF.NAME_MID					:= IF(SELF.TYPE_CD != 'GR',TRIM(GoodNAME_MID,LEFT,RIGHT),'');								
		SELF.NAME_LAST		    := IF(SELF.TYPE_CD != 'GR',TRIM(GoodNAME_LAST,LEFT,RIGHT),'');
		SELF.NAME_SUFX				:= TRIM(GoodNAME_SUFX,LEFT,RIGHT);
		SELF.NAME_NICK        := IF(tempNick !='', StringLib.StringCleanSpaces(tempNick),'');														 
		SELF.GENDER						:= ut.CleanSpacesAndUpper(pInput.GENDER); 
							   											
	  // License Information
		SELF.LICENSE_NBR	    := IF(pInput.LIC_NUMR != '',TRIM(pInput.LIC_NUMR,LEFT,RIGHT),'NR');
		SELF.LICENSE_STATE	  := 'WI';
		SELF.RAW_LICENSE_TYPE	:= TrimLicType;
		SELF.STD_LICENSE_TYPE := SELF.RAW_LICENSE_TYPE;
		SELF.RAW_LICENSE_STATUS := IF(TrimStatus[1..7] = 'CURRENT','CURRENT',
																	IF(TrimStatus[1..11]= 'NOT CURRENT','NOT CURRENT',TrimStatus));
		SELF.STD_LICENSE_STATUS := '';
		   		   
  	//Reformatting date to YYYYMMDD
	  //Known Bad Dates: 12/31/1298, 1/1/0001  
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.GRANTED_DATE != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.GRANTED_DATE),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPIRE_DATE != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPIRE_DATE),'17530101');
		
	//Business Rules to stripping Contact/Office Info	
	//Use address cleaner to clean address
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern);
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 		

		prepAddr := MAP(StringLib.Stringfind(TrimAddress1, '% CVTC HWY 64 - 70 EAST',1) > 0
											=> StringLib.StringFindReplace(TrimAddress1,'% CVTC HWY 64 - 70 EAST','% CVTC HWY 64, 70 EAST'),
										StringLib.stringfind(TrimAddress1,'% ',1)> 0 AND TrimAddress1[1] != '%'=> 
												StringLib.StringFindReplace(TrimAddress1,'% ','C/O '),
										TrimAddress1[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimAddress1,'C/O ','%'),
																TrimAddress1);
		
		getOffice_Addr 	:= IF(prepAddr != '' AND Prof_License_Mari.func_is_company(prepAddr) 
															AND NOT Prof_License_Mari.func_is_address(prepAddr)
															AND NOT REGEXFIND(BusException, prepAddr),prepAddr,
													IF(tmpNameContact1 != '', tmpNameContact1, ''));
															
		prepOfficeName1 	:= MAP(TrimName_Contact = TrimAddress1 => '',
													REGEXFIND('(ATTN |ATTN: )',TrimName_Contact)=> '',
													TrimName_Contact[1..4] in ['C/O ','DBA '] => TrimNAME_CONTACT[5..],
													TrimNAME_CONTACT[1] = '% ' => TrimNAME_CONTACT[2..],
													TrimNAME_CONTACT[1..11] = prepAddr[1..11] => '', TrimNAME_CONTACT); 

		prepOfficeName2 	:= MAP(REGEXFIND(' C/O ',prepOfficeName1)  => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepOfficeName1),		
														 REGEXFIND('^([\\%]([A-Za-z ][^\\-]+))-([0-9A-Za-z \\#]+)$',prepAddr)
															AND prepAddr[1] = '%'  => REGEXFIND('^([\\%]([A-Za-z ][^\\-]+))-([0-9A-Za-z \\#]+)$',prepAddr,2),
															getOffice_Addr != '' => getOffice_Addr,
															prepOfficeName1);
																														
		getContactName		:= IF(Prof_License_Mari.func_is_address(prepOfficeName2) AND NOT REGEXFIND(AddrExceptions,prepOfficeName2) 
													AND  Prof_License_Mari.mod_clean_name_addr.IsCompanyName(prepOfficeName2) = '', '',
														prepOfficeName2);
																				 
		tempNAME_OFFICE	:= IF(StringLib.stringfind(getContactName,'/',1) >0,StringLib.StringFindReplace(getContactName,'/',' '),
														IF(REGEXFIND('^[0-9]', TRIM(getContactName)) AND NOT REGEXFIND(AddrExceptions,getContactName),'',
																getContactName));
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tempNAME_OFFICE);
		SELF.NAME_OFFICE	   	:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(StdNAME_OFFICE));
		SELF.OFFICE_PARSE	    := MAP(SELF.NAME_OFFICE != ''  AND (Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)
																		OR REGEXFIND('(CORP| CO$)',SELF.NAME_OFFICE)) =>'GR',
																 SELF.NAME_OFFICE != ''  AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'MD',
																             								'');
		//Populating MARI Name Fields
		SELF.NAME_FORMAT			:= IF(SELF.TYPE_CD = 'MD','L','F');
		SELF.NAME_ORG_ORIG	  := TrimFullName;																			
		SELF.NAME_DBA_ORIG	  := ''; 
		SELF.NAME_MARI_ORG		:= IF(SELF.TYPE_CD = 'GR',StringLib.StringCleanSpaces(tmpNAME_ORG),'');//only business names															 
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;

		//Prepping Address field 
		tmpAddr := MAP(StringLib.Stringfind(prepAddr,'%',1) > 0 AND NOT StringLib.Stringfind(prepAddr,'-',1) > 0  => prepAddr,
		               prepAddr[1] = '%' AND REGEXFIND('^([\\%]([A-Za-z ][^\\-]+))-([0-9A-Za-z \\#]+)$',prepAddr) 
												=> REGEXFIND('^([\\%]([A-Za-z ][^\\-]+))-([0-9A-Za-z \\#]+)$',prepAddr,3),
										REGEXFIND(CO_pattern,prepAddr) => REGEXFIND(CO_pattern,prepAddr,1),
										clnAddress1 != '' => temp_preaddr1,
									 					   prepAddr);
		
		prepAddr_Line_1		  	:= tmpAddr;
		prepAddr_Line_2 			:= ut.CleanSpacesAndUpper(pInput.City) + ' ' +
		                         ut.CleanSpacesAndUpper(pInput.State) + ' ' +
														 ut.CleanSpacesAndUpper(pInput.Zip5);
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1,prepAddr_Line_2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);		
		clnAddr1              := StringLib.StringCleanSpaces(StringLib.StringFilterOut(tmpADDR_ADDR1_1, '%'));
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + pInput.CITY + pInput.ZIP5) != '','B','');
		SELF.ADDR_ADDR1_1			:= MAP(getOffice_Addr = '' AND TRIM(clnAddr1,LEFT,RIGHT) != '' => clnAddr1,
		                             getOffice_Addr != '' => tmpADDR_ADDR2_1,
		                             TRIM(clnAddr1,LEFT,RIGHT) = '' => tmpADDR_ADDR2_1,
																 '');
		SELF.ADDR_ADDR2_1 		:= IF(getOffice_Addr = '' AND TRIM(clnAddr1,LEFT,RIGHT) != '', tmpADDR_ADDR2_1,'');
		
		
		SELF.ADDR_ADDR3_1 		:= '';
		SELF.ADDR_ADDR4_1			:= '';
		SELF.ADDR_CITY_1		:= TrimCity;
		SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.STATE);
		SELF.ADDR_ZIP5_1		:= pInput.ZIP5;
		SELF.ADDR_ZIP4_1		:= '';
		SELF.ADDR_CNTRY_1		:= ut.CleanSpacesAndUpper(pInput.COUNTRY);
		SELF.PHN_MARI_1		  := ut.CleanPhone(pInput.Phone);
		SELF.PHN_PHONE_1	  := ut.CleanPhone(pInput.Phone);
		SELF.EMAIL          := TRIM(pInput.EMAIL,LEFT,RIGHT);
		SELF.OOC_IND_1			:= 0;    
		SELF.OOC_IND_2			:= 0;
		SELF.CONT_EDUCATION_ERND := TRIM(pInput.CE_ACC,LEFT,RIGHT);
	  SELF.CONT_EDUCATION_TERM := TRIM(pInput.CE_TO_RENEW,LEFT,RIGHT);
		
		getContact := MAP(StringLib.stringfind(TrimNAME_CONTACT[1..6],'ATTN: ',1) > 0 => StringLib.StringFindReplace(TrimNAME_CONTACT,'ATTN: ',''),
											StringLib.stringfind(TrimNAME_CONTACT[1..5],'ATTN ',1) > 0 => StringLib.StringFindReplace(TrimNAME_CONTACT,'ATTN ',''),
											REGEXFIND(' C/O ',TrimNAME_CONTACT) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_CONTACT),		
										  REGEXFIND('C/O',prepAddr) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddr),
													 ''); 
		ParseContact			:= IF(getContact != '' AND NOT Prof_License_Mari.func_is_company(getContact)
															AND NOT REGEXFIND(AddrExceptions,getContact),Address.CleanPersonFML73(getContact),'');
		SELF.NAME_CONTACT_PREFX	:= '';
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);  
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST	:= TRIM(ParseContact[46..65],LEFT,RIGHT);  
		SELF.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
		SELF.NAME_CONTACT_NICK	:= '';
	
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
									               SELF.TYPE_CD = 'GR' => 'CO','');
			
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK         	:= HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																			+TRIM(TrimAddress1,LEFT,RIGHT)
																			+TRIM(TrimCity,LEFT,RIGHT)
																			+TRIM(pInput.ZIP5,LEFT,RIGHT));
																								   																						  
		SELF.PCMC_SLPK		:= 0;
							 
		SELF.PROVNOTE_1		:= 'CREDENTIAL/LICENSE NUMBER FORMAT: '+ TRIM(SELF.LICENSE_NBR + '-' + SELF.STD_LICENSE_TYPE,ALL) +
		                     IF(pInput.NUMBER_OF_SITES != '','MULTI_STATE: ' + pInput.NUMBER_OF_SITES,'');		
	  										 
		SELF.PROVNOTE_2 	:= IF(pInput.CE_STILL_NEEDED!= '',ut.CleanSpacesAndUpper(pInput.CE_STILL_NEEDED ),'') + 
		                     IF(pInput.CE_NEEDED_BY!= '' ,ut.CleanSpacesAndUpper(pInput.CE_NEEDED_BY),'');
		
		TrimSpec          := ut.CleanSpacesAndUpper(pInput.SPEC_CODE);
		SELF.ADDL_LICENSE_SPEC := MAP(TrimSpec = '551' => 'ELIGIBLE TO APPRAISE FEDERALLY RELATED TRANSACTIONS IS AQB COMPLIANT',
		                              TrimSpec = '550' => 'INELIGIBLE TO APPRAISE FEDERALLY RELATED TRANSACTIONS IS NOT AQB COMPLIANT',
																	TrimSpec = '1' => 'ALLERGY - IMMUNOLOGY',
																	TrimSpec);
		TrimRace          := ut.CleanSpacesAndUpper(pInput.ETHNIC_ORIGIN);
		SELF.RACE_CD			:= MAP(TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'WHITE'=> 'W',
                       		   TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'BLACK'=> 'B',
														 TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'ASIAN'=> 'AP',
														 TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'HISPA'=> 'H',
														 TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'AMERI'=> 'A',
														 TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'OTHER'=> 'O',
		                         TRIM(TrimRace,LEFT,RIGHT)[1..5] = 'UNKNO'=> 'U',
														 TrimRace);
														 
		SELF.STD_RACE_CD	:= CASE(SELF.RACE_CD,
															'W'  => 'WHT',
															'B'  => 'BLK',
															'AP' => 'API',
															'H'  => 'HISP',
															'A'  => 'API',
															'O'  => 'OTH',
															'U'  => 'UNK',SELF.RACE_CD);
		SELF := [];	
		   
END;
inFileLic	  := PROJECT(clnFile,xformToCommon(LEFT));

// Populate STD_LICENSE_TYPE field via translation on RAW_LICENSE_STATUS field
Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
	SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
	SELF := L;
END;

ds_map_stat_trans := JOIN(inFileLic, cmvTransLkp,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
	    					   AND RIGHT.fld_name='LIC_STATUS',
							     trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_stat_trans L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_stat_trans, cmvTransLkp,
						TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_TYPE' 
						AND RIGHT.dm_name1 = 'PROFCODE',
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_lic_trans(affil_type_cd= 'CO');

Prof_License_Mari.layouts.base 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;
ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
										StringLib.StringFilterOut(LEFT.NAME_MARI_ORG,' ') = StringLib.StringFilterOut(RIGHT.NAME_MARI_ORG,' ')
										AND LEFT.affil_type_cd = 'IN',
										assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER);	

Prof_License_Mari.layouts.base  xTransPROVNOTE(ds_map_affil L) := TRANSFORM
	SELF.PROVNOTE_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + Comments,
												 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => Comments,
						  												       L.PROVNOTE_1);

	SELF := L;
END;

OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

// Adding to Superfile
d_final := OUTPUT(OutRecs, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(OutRecs(NAME_ORG_ORIG != ''));

move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','using', 'used'));	

notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

RETURN SEQUENTIAL(oFile, ocmvTranLkp,oREF_Vehicle, oValidFile, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;