/* Converting Pennsylvania, Commonwealth of  - Prof License/Mulitple Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
#workunit('name','Prof License MARI- PAS0868')
IMPORT Prof_License, Prof_License_Mari, Address, Ut, NID, Lib_FileServices, lib_stringlib, standard,STD;

EXPORT map_PAS0868_conversion(STRING pVersion) := FUNCTION
	code 										:= 'PAS0868';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	active									:= Prof_License_Mari.files_PAS0868.active;
	inactive1								:= Prof_License_Mari.files_PAS0868.inactive_1;
  inactive2								:= Prof_License_Mari.files_PAS0868.inactive_2;
	inactive3								:= Prof_License_Mari.files_PAS0868.inactive_3;
	inactive4								:= Prof_License_Mari.files_PAS0868.inactive_4;
	
	FullFile 								:= active + inactive1 + inactive2 + inactive3 + inactive4; 
	oact    := OUTPUT(active);
	// oinact  := OUTPUT(inactive);
  Sufx_Pattern    := '( SR.| SR | SR$|^SR$| JR.| JR | JR$|^JR$| III| II| IV |IV$| VI | VII)';
	DBA_Ind 				:= '( DBA |D/B/A |/DBA | A/K/A |C/O |ATTN: |ATTN )';
	
	// Remove Company name from address
	CompanyPattern	:= '(^.* LLC |^.* INC |^.* INC\\./|^.* COMPANY |^.* CO |^.* CORP |^.*APPRAISALS |^.* GROUP |' +
					 '^.* PARTNERSHIP |^.* REALTY |^.* SVCS|^.*REMAX |^.*USA 4%|^.*REAL EST|^.* ASSOC|^.* AGCY|^.* CO$' +
					 ')';
					 
	RemovePattern	:= '(^.* INC$|^.* LLC$|^.* INC$|^.* ,INC$|^.* INC\\.$|^.* LLP$|^.* LTD$|^.* COMPANY$|^.* CORP$|^.* CORPORATION$|^.* CO$|'+
					 '^.* ASSOCIATES$|^.* AGENCY$|^.* ASSOCS$|^.*APPRAISAL$|^.*APPRAISALS$|^.* ADVISORS$|^.* REALTY$|^.* REALTORS$|^.* REAL ESTATE$|^.* GROUP$|^.* PARTNERS$|' +
					 '^.* FOX AND ROACH$|^.* SERVICES$|^.* SERVICE$|^.* CENTURY 21$|^.* PROPERTIES$|^.* PREFERRED$|^.* \\.COM$|^.* MANAGEMENT$|^.*TWO NESHAMINY INTERPLEX$'+
					 '^.* NET$|^.* APPR\\.$|^.* APPRAISAL SERVICE|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.*APRPAISAL NETWORK|^.*APPRAISALS|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.*REALTY SEVICES|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$|^ATTN:.*$' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|^.* AND .*$|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* BUILDING$|^.* OFFICE$' +
					 ')';		
	addr_pattern  := '( STREET| ROAD| DRIVE| HIGHWAY| PO BOX| PO.BOX| SUITE)';								

	//Filtering out BAD RECORDS
	ut.CleanFields(FullFile, ClnUnprintable);
	FilterBlankLic					:= ClnUnprintable(RECORD_NUM != '');
	FilterBadName						:= FilterBlankLic(StringLib.StringCleanSpaces(LAST_NAME[1..5]) != 'ERROR' AND StringLib.StringCleanSpaces(LAST_NAME+FIRST_NAME+FULL_NAME)!='');
	GoodNameRec 						:= FilterBadName(NOT REGEXFIND('(ENTERED IN ERROR|IN ERROR|INPUT ERROR|ERROR|REQUIRED C E COURSE)', StringLib.StringToUpperCase(TRIM(FULL_NAME,LEFT,RIGHT))));
	oFile										:= OUTPUT(SAMPLE(GoodNameRec, 4000,1));
	
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in xformToCommon(GoodNameRec pInput) := TRANSFORM
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
	SELF.LICENSE_STATE	 	:= code[1..2];
	
	//Get license number, license status, and license type
	tmp_RECORD_num				:= ut.CleanSpacesAndUpper(pInput.RECORD_NUM);
	SELF.LICENSE_NBR	  	:= tmp_RECORD_num;
	stat 									:= pInput.STATUS;
	SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(stat)[1..1];
	SELF.RAW_LICENSE_TYPE	:= '';
	trimLic_Type          := TRIM(IF(REGEXFIND('^([A-z]+)([0-9]+)',tmp_RECORD_num),REGEXFIND('^([A-z]+)([0-9]+)',tmp_RECORD_num,1),''));
	SELF.STD_LICENSE_type := IF(trimLic_Type != '', trimLic_Type, 'TA');
	SELF.STD_LICENSE_desc := MAP(trimLic_Type='AB' => 'ASSOCIATE BROKER(AB)-STANDARD',
															 trimLic_Type='ABR'  => 'ASSOCIATE BROKER (AB)-RECIPROCAL',
															 trimLic_Type='BE'  => 'BROKER EXAM (BE)',
															 trimLic_Type='RMR'  => 'BROKER MULTI-LICENSEE-RECIPROCAL',
															 trimLic_Type='RM'  => 'BROKER MULTI-LICENSEE-STANDARD',
															 trimLic_Type='RCR'  => 'BUILDER OWNER SALESPERSON-RECIPROCAL',
															 trimLic_Type='RC'  => 'BUILDER OWNER SALESPERSON-STANDARD',
															 trimLic_Type='MS'  => 'CAMPGROUND MEMBERSHIP SALESPERSON-STD',
															 trimLic_Type='AL'  => 'CEMETERY ASSOCIATE BROKER-STANDARD',
															 trimLic_Type='LM'  => 'CEMETERY BROKER OF RECORD-STANDARD',
															 trimLic_Type='LS'  => 'CEMETERY SALESPERSON-STANDARD',
															 trimLic_Type='MR'  => 'MANAGER OF RECORD-STANDARD',
															 trimLic_Type='CR'  => 'REAL ESTATE COURSE',
															 trimLic_Type='RI'  => 'REAL ESTATE INSTRUCTOR',
															 trimLic_Type='RS'  => 'REAL ESTATE SALESPERSON-RECIPROCAL',
															 trimLic_Type='RR'  => 'RENTAL LISTING REFERRAL AGENT (SR)-STD',
															 trimLic_Type='SR'  => 'RENTAL LISTING REFERRAL AGENT (SR)-STD',
															 trimLic_Type='TS'  => 'TIME SHARE SALESPERSON-STANDARD',
															 trimLic_Type='AZ'  => 'ASSISTANTS',
															 trimLic_Type='BA'  => 'CERTIFIED BROKER APPRAISER',
															 trimLic_Type='AV'  => 'CERTIFIED PENNSYLVANIA EVALUATOR',
															 trimLic_Type='RL'  => 'CERTIFIED RESIDENTIAL APPRAISER',
															 trimLic_Type='LAT'  => 'LICENSED APPRAISER TRAINEE',
															 trimLic_Type='SB'   => 'BROKER (SOLE PROPRIETOR)-STANDARD',
															 trimLic_Type='RB'   => 'BROKER (SOLE PROPRIETOR)-STANDARD',
															 trimLic_Type='NB'   => 'BROKER (SOLE PROPRIETOR)-STANDARD',
															 trimLic_Type='RO'   => 'BRANCH OFFICE',
															 trimLic_Type='GA'   => 'CERTIFIED GENERAL APPRAISER',
															 trimLic_Type='RSR'   => 'REAL ESTATE SALESPERSON-RECIPROCAL',
															 trimLic_Type='RE'   => 'REAL ESTATE EDUCATION PROVIDER (RE)',
															 trimLic_Type='SBR'   => 'BROKER (SOLE PROPRIETOR)-RECIPROCAL',
															 trimLic_Type='CRCE'  => 'EDUCATION PROVIDER',
															 trimLic_Type='OL'    => 'PROMOTIONAL PROPERTY',
															 trimLic_Type='TA'    =>'TEMPORARY AUTHORITY TO PRACTICE',
															 '');
															 
	// SELF.STD_LICENSE_type := IF(trimLic_Type != '', trimLic_Type, '');															 
	SELF.TYPE_CD					:= MAP(SELF.STD_LICENSE_TYPE IN ['RO','RB','NB','CR','RE','RR','TA'] AND pInput.ORG_NAME != '' => 'GR',
															 SELF.STD_LICENSE_TYPE IN ['RO','RB','NB','CR','RE','RR','TA'] AND pInput.First_Name = '' and pInput.Last_Name != '' => 'GR',		                             
															 SELF.STD_LICENSE_TYPE IN ['RO','RB','NB','CR','RE','RR','TA'] AND pInput.Last_Name = '' and pInput.Full_Name != ''=> 'GR',																
															 'MD');

	//Reformatting date to YYYYMMDD
	SELF.CURR_ISSUE_DTE		:= '17530101';
	SELF.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUE_DATE);
	SELF.EXPIRE_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXP_DATE);
				
	//Process names and address 
	TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
	TrimNAME_MID 					:= ut.CleanSpacesAndUpper(pInput.MIDDLE_NAME);
	TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
	TrimNAME_SUFX 				:= ut.CleanSpacesAndUpper(pInput.SUFFIX);
	TrimNAME_FULL					:= ut.CleanSpacesAndUpper(pInput.FULL_NAME);
	TempNAME_FULL         := IF(TrimNAME_FULL IN ['BROKER', 'OFFICER','PARTNER'], '', TrimNAME_FULL);
	TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.ORG_NAME);
	TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
	TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
	TrimAddress3					:= ut.CleanSpacesAndUpper(pInput.ADDRESS3);
	TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY_1);
	TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
	TrimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);				
	
	// If individual AND NOT identified as a corporation names, parse into (FMLS) fmt
	TmpNAME_LAST		:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_LAST),REGEXREPLACE(Sufx_Pattern,TrimNAME_LAST,''),TrimNAME_LAST);
	TmpNAME_FIRST 	:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_FIRST),REGEXREPLACE(Sufx_Pattern,TrimNAME_FIRST,''),TrimNAME_FIRST);
	TmpNAME_MID 		:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_MID),REGEXREPLACE(Sufx_Pattern,TrimNAME_MID,''),TrimNAME_MID);
	TmpNAME_FULL 		:= IF(REGEXFIND(Sufx_Pattern,TempNAME_FULL),REGEXREPLACE(Sufx_Pattern,TempNAME_FULL,''),TempNAME_FULL);
	filterSuffix					:= IF(TrimNAME_SUFX IN ['BROKER', 'OFFICER','PARTNER'], '', TrimNAME_SUFX);
	temp_Suffix 					:= IF(STD.Str.Find(filterSuffix, ' ',1) > 0,TRIM(filterSuffix[1..STD.Str.Find(filterSuffix, ' ', 1) -1], right),filterSuffix);
	temp_credential 			:= IF(TrimNAME_SUFX IN ['BROKER', 'OFFICER','PARTNER'], TrimNAME_SUFX, TRIM(filterSuffix[LENGTH(temp_suffix)+1..],LEFT,RIGHT));
	
	
	TmpSuffix       := MAP(REGEXFIND(Sufx_Pattern,TrimNAME_LAST)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_LAST,0),LEFT,RIGHT),
												 REGEXFIND(Sufx_Pattern,TrimNAME_MID)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_MID,0),LEFT,RIGHT),
												 REGEXFIND(Sufx_Pattern,TrimNAME_FIRST)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_FIRST,0),LEFT,RIGHT),
												 REGEXFIND(Sufx_Pattern,TempNAME_FULL)=>TRIM(REGEXFIND(Sufx_Pattern,TempNAME_FULL,0),LEFT,RIGHT),
												 temp_Suffix);
												 
	FullName				:= IF(TmpNAME_FULL<>'',TmpNAME_FULL,
												StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_MID + ' ' + TrimNAME_LAST + ' ' + TmpSuffix)
												);
	TrimNAME_BUS		:= IF(pInput.ORG_NAME = 'NULL','',ut.CleanSpacesAndUpper(pInput.ORG_NAME));
	
	// Identify NICKNAME IN the various format 
	tempFNick							:= Prof_License_Mari.fGetNickname(TmpNAME_FIRST,'nick');
	tempLNick							:= Prof_License_Mari.fGetNickname(TmpNAME_LAST,'nick');
	tempMNick							:= Prof_License_Mari.fGetNickname(TmpNAME_MID,'nick');
	tempFullNick          := Prof_License_Mari.fGetNickname(TmpNAME_FULL,'nick');
	
	removeFNick						:= Prof_License_Mari.fGetNickname(TmpNAME_FIRST,'strip_nick');
	removeLNick						:= Prof_License_Mari.fGetNickname(TmpNAME_LAST,'strip_nick');
	removeMNick						:= Prof_License_Mari.fGetNickname(TmpNAME_MID,'strip_nick');
	removeFullNick        := Prof_License_Mari.fGetNickname(TmpNAME_FULL,'strip_nick');

	stripNickFName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));
	stripNickLName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
	stripNickMName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick));
	stripNickFullName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFullNick));
	
	GoodFullName					:= IF(tempFullNick != '',stripNickFullName,TmpNAME_FULL);
	ParsedName						:= Prof_License_Mari.mod_clean_name_addr.cleanLFMName(GoodFullName);			
	re_ParsedName         := IF(LENGTH(TRIM(ParsedName[46..65]))<2 and NID.CleanPerson73(GoodFullName) <> '',NID.CleanPerson73(GoodFullName),ParsedName);		
					
	GoodFirstName					:= IF(TmpNAME_LAST != '' AND tempFNick != '',stripNickFName,
														 IF(TmpNAME_LAST != '' AND tempFNick = '',TmpNAME_FIRST,
														 TRIM(re_ParsedName[6..25],LEFT,RIGHT)));
	GoodMidName   				:= IF(TmpNAME_LAST != '' AND tempMNick != '',stripNickMName,
														 IF(TmpNAME_MID != '' AND tempMNick = '',TmpNAME_MID,			                           
														 TRIM(re_ParsedName[26..45],LEFT,RIGHT)));													 
	GoodLastName					:= IF(TmpNAME_LAST != '' AND tempLNick != '',stripNickLName,
														 IF(TmpNAME_LAST != '' AND tempLNick = '',TmpNAME_LAST,
														 TRIM(re_ParsedName[46..65],LEFT,RIGHT)));		
	ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName);

	SELF.NAME_FIRST		   	:= IF(SELF.type_cd = 'MD',GoodFirstName,'');
	SELF.NAME_MID					:= IF(SELF.type_cd = 'MD',GoodMidName,'');
	SELF.NAME_LAST		   	:= IF(SELF.type_cd = 'MD',GoodLastName,'');
	SELF.NAME_NICK				:= MAP(SELF.type_cd = 'MD'and TmpNAME_LAST != '' AND tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
															 SELF.type_cd = 'MD'and TmpNAME_LAST != '' AND tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
															 SELF.type_cd = 'MD'and TmpNAME_LAST != '' AND tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
															 SELF.type_cd = 'MD'and TmpNAME_FULL != '' AND tempFullNick != '' => StringLib.StringCleanSpaces(tempFullNick),
															 '');
	SELF.NAME_SUFX				:= IF(SELF.type_cd = 'MD',TRIM(TmpSuffix,LEFT,RIGHT),'');
	SELF.CREDENTIAL       := temp_credential;
	
	//Clean Org Name for GR
	prepNAME_ORG					:= MAP(TrimNAME_LAST <> '' and TrimNAME_FIRST + TrimNAME_MID = '' => TrimNAME_LAST,
															 SELF.type_cd = 'GR' and TrimNAME_FULL <> '' => TrimNAME_FULL,
															 TrimNAME_ORG);
	getDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),
															Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
															'');			
	rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),
															Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
															prepNAME_ORG);
															
	StdNAME_ORG      			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG);
	CleanNAME_ORG					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) 
																 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
															 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) 
																 => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
															 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) 
																 => StdNAME_ORG,
															 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
	
	SELF.NAME_ORG_PREFX		:= IF(SELF.TYPE_CD = 'MD','',
															Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG)); 
	SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD',
																ConcatNAME_FULL,
																StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
	SELF.NAME_ORG_SUFX	  := IF(SELF.TYPE_CD = 'MD',
															'',
															Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)));		
	//Populating MARI Name Fields
	SELF.NAME_ORG_ORIG	  := MAP(SELF.TYPE_CD = 'MD' AND TrimNAME_FULL <> '' => TrimNAME_FULL,
															 SELF.TYPE_CD = 'MD' AND TrimNAME_FULL = '' => FullName,
																	 TrimNAME_ORG);
	SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG_ORIG<>'','F','');
	

	// Prepping Address Fields for Parsing
	addr_ind  := '(^.* CENTRE|^.* STREET|^.* SQUARE)';
	tmpAddr1   := IF(Prof_License_Mari.func_is_company(TrimAddress1) = True and Prof_License_Mari.func_is_address(TrimAddress1) = False
									 and not REGEXFIND(addr_ind,TrimAddress1),
									 '',TrimAddress1);
	tmpAddr2   := IF(Prof_License_Mari.func_is_company(TrimAddress2) = True and Prof_License_Mari.func_is_address(TrimAddress2) = False
									 and not REGEXFIND(addr_ind,TrimAddress2),
									 '',TrimAddress2);
	tmpAddr3   := IF(Prof_License_Mari.func_is_company(TrimAddress3) = True and Prof_License_Mari.func_is_address(TrimAddress3) = False
									 and not REGEXFIND(addr_ind,TrimAddress3),		                 
									 '',TrimAddress3);	 
 
	prepAddr1  := Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(tmpAddr1, RemovePattern);
	prepAddr2  := Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(tmpAddr2, RemovePattern);
	prepAddr3  := Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(tmpAddr3, RemovePattern);
 
	// Remove company name from address
	prepClnAddr1 := REGEXREPLACE(CompanyPattern,prepAddr1,'');	
	prepClnAddr2 := REGEXREPLACE(CompanyPattern,prepAddr2,'');	
	prepClnAddr3 := REGEXREPLACE(CompanyPattern,prepAddr3,'');	
		
	clnAddress1			:= StringLib.StringCleanSpaces(prepClnAddr1 + ' ' + prepClnAddr2 + ' ' + prepClnAddr3);	
	clnAddress2	 		:= StringLib.StringCleanSpaces(
											 IF(TrimCity='*','',TrimCity) + ' ' +
											 IF(TrimState='NA','',TrimState) +' ' + 
											 IF(TrimZip='0','',TrimZip)
											 ); 
	extractOfficeName1     := IF(Prof_License_Mari.func_is_company(TrimAddress1) = True and Prof_License_Mari.func_is_address(TrimAddress1) = False
															 and not REGEXFIND(addr_ind,TrimAddress1),TrimAddress1,
															 Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1,CompanyPattern));									 
	extractOfficeName2     := IF(Prof_License_Mari.func_is_company(TrimAddress2) = True and Prof_License_Mari.func_is_address(TrimAddress2) = False
															 and not REGEXFIND(addr_ind,TrimAddress2),TrimAddress2,
															 Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress2,CompanyPattern));									 
	extractOfficeName3     := IF(Prof_License_Mari.func_is_company(TrimAddress3) = True and Prof_License_Mari.func_is_address(TrimAddress3) = False
															 and not REGEXFIND(addr_ind,TrimAddress3),TrimAddress3,
															 Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress3,CompanyPattern));									 
					
	clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(clnAddress1,clnAddress2); //Address cleaner to remove 'c/o' and 'attn' from address
	tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address  
	SELF.ADDR_ADDR1_1		:= IF(StringLib.StringCleanSpaces(tmpADDR_ADDR1_1) <> '', StringLib.StringCleanSpaces(tmpADDR_ADDR1_1), StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
	SELF.ADDR_ADDR2_1		:= IF(StringLib.StringCleanSpaces(tmpADDR_ADDR1_1) <> '', StringLib.StringCleanSpaces(tmpADDR_ADDR2_1), ''); 
	SELF.ADDR_CITY_1		:= IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),IF(TrimCity='*','',TrimCity));
	SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),IF(TrimState='NA','',TrimState));
	SELF.ADDR_ZIP5_1		:= IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),IF(TrimZip='0','',TrimZip));
	SELF.ADDR_ZIP4_1		:= clnAddrAddr1[122..125];
	
	// Get DBA name from address
	tmpGetDBAName				:= MAP(Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1)<>''
															=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
														 Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2)<>''
															=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2),
														 Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress3)<>''
															=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress3),
														 '');	
	clnGetDBAName				:= MAP(REGEXFIND('([0-9]+) .* (LANE|STREET|DRIVE|AVENUE|SQUARE)',	tmpGetDBAName) => '',
														 REGEXFIND('PO BOX',	tmpGetDBAName) => '',
														 tmpGetDBAName);
														 
	// Get office name from address 													 
	tmpGetContactName		:= IF(REGEXFIND('PO BOX ', tmpGetDBAName),
														'',
														Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpGetDBAName));
	clnGetContactName		:= MAP(REGEXFIND('ATTN ',tmpGetContactName)  => tmpGetDBAName,
														 tmpGetContactName);
														 
	ParseContact				:= IF(clnGetContactName<>'', Address.CleanPersonFML73(clnGetContactName), '');																				
	
	//Identifying Office and DBA NAMES
	prepNAME_OFFICE 		:= MAP(extractOfficeName1<>'' => extractOfficeName1,
	                           extractOfficeName2<>'' => extractOfficeName2,
														 extractOfficeName3<>'' => extractOfficeName3,
	                           StringLib.StringFindReplace(TrimNAME_ORG,'"',''));	
												 
	
	clnNAME_OFFICE      := MAP(StringLib.Stringfind(prepNAME_OFFICE,' T/A ',1) > 0
														=> StringLib.StringFindReplace(prepNAME_OFFICE,' T/A ',' DBA '),
													 REGEXFIND('(^AKA )', prepNAME_OFFICE)
														=> REGEXREPLACE('(^AKA )', prepNAME_OFFICE, ''),
													 REGEXFIND('(^ATTN - )', prepNAME_OFFICE)
														=> REGEXREPLACE('(ATTN - )', prepNAME_OFFICE, ''),
													 prepNAME_OFFICE='INACTIVE' => '',	 
													 REGEXFIND(addr_pattern, prepNAME_OFFICE) => '',
													 prepNAME_OFFICE);	
	
	rmvdba              := IF(REGEXFIND(DBA_Ind,clnNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.GetCorpName(clnNAME_OFFICE),clnNAME_OFFICE);													 
	stdNAME_OFFICE		  := IF(rmvdba<>'',
														StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvdba)),'');

	SELF.NAME_OFFICE		:= MAP(TRIM(SELF.NAME_ORG_ORIG,ALL)=TRIM(stdNAME_OFFICE,ALL) => '', 
															 TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL)=TRIM(stdNAME_OFFICE,ALL) => '', 
															 TRIM(SELF.NAME_ORG,ALL)=TRIM(stdNAME_OFFICE,ALL) => '', 
															 TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL)=TRIM(stdNAME_OFFICE,ALL) => '', 
															 stdNAME_OFFICE);
	
  SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ',
															IF(prof_license_mari.func_is_company(SELF.NAME_OFFICE) OR
																 REGEXFIND(CompanyPattern,TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)),
																 'GR',
																 'MD'),
															'');
	
	getNAME_DBA						:= MAP(getDBA_ORG<>'' => getDBA_ORG,
															 clnGetDBAName<>'' AND clnGetDBAName<>clnNAME_OFFICE => clnGetDBAName,
															 '');
																																						
	StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
	SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
	SELF.NAME_DBA					:=  StringLib.StringFindReplace(StdNAME_DBA,'/',' ');
	SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
	SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);

	SELF.NAME_DBA_ORIG	  := IF(SELF.NAME_DBA<>'',getNAME_DBA,'');
	SELF.NAME_MARI_ORG	  := IF(SELF.TYPE_CD = 'MD',SELF.NAME_OFFICE,StdNAME_ORG);
	SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA<>'',StdNAME_DBA,'');
																				
	SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2 + TrimCity + pInput.ZIP) != '','B','');

	SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
	SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
	SELF.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
	SELF.NAME_CONTACT_LAST	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		
	//Expected codes [CO,BR,IN], Set during business/individual filter
	SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' AND SELF.STD_LICENSE_TYPE[1..2] ='BO' => 'BR',
															 SELF.TYPE_CD = 'GR' => 'CO',
															 '');		

	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
	SELF.CMC_SLPK       	:= hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TrimName_Org
																			+FullName
																			+TrimAddress1
																			+TrimAddress2
																			+TrimAddress3
																			+TrimCity
																			+TrimZip);
		
	SELF.PCMC_SLPK			:= 0;
	SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(GoodNameRec,xformToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_prof_cd					:= JOIN(inFileLic, Cmvtranslation,
																	LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																	trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layout_base_in 	trans_lic_status(ds_map_prof_cd L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
																
		SELF := L;
	END;

	ds_map_lic_trans 				:= JOIN(ds_map_prof_cd, Cmvtranslation,
																	TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
																	AND RIGHT.fld_name='LIC_STATUS' ,
																	trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(DEDUP(SORT(DISTRIBUTE(ds_map_lic_trans,HASH(name_org_orig,CMC_SLPK)),name_org_orig,CMC_SLPK,LOCAL),RECORD,LOCAL), 
											 SORT(DISTRIBUTE(company_only_lookup,HASH(name_org_orig,CMC_SLPK)),name_org_orig,CMC_SLPK,LOCAL),
											 TRIM(LEFT.name_org_orig[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org_orig[1..50],LEFT,RIGHT)
											 AND LEFT.AFFIL_TYPE_CD = 'BR',
											 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	remove_logical 					:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);


	d_final 								:= OUTPUT(ds_map_affil, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil(NAME_ORG_ORIG != ''));

	move_to_used						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','using','used');
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive1','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive2','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive3','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive4','using','used');	
																			);

	notify_missing_codes 		:= Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address 	:= Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;	