/* Converting Pennsylvania, Commonwealth of  - Prof License/Mulitple Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
#workunit('name','Prof License MARI- PAS0868')
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard,STD;

EXPORT map_PAS0868_conversion(STRING pVersion) := FUNCTION

	code 										:= 'PAS0868';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','sprayed','using');
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_1','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_2','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_3','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_1','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_2','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_3','sprayed','using');	
																			);
	
	active									:= PROJECT(Prof_License_Mari.files_PAS0868.active,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive								:= PROJECT(Prof_License_Mari.files_PAS0868.inactive,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	active_1								:= PROJECT(Prof_License_Mari.files_PAS0868.active_1,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive_1							:= PROJECT(Prof_License_Mari.files_PAS0868.inactive_1,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	active_2								:= PROJECT(Prof_License_Mari.files_PAS0868.active_2,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive_2							:= PROJECT(Prof_License_Mari.files_PAS0868.inactive_2,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																											SELF := []));
	active_3								:= PROJECT(Prof_License_Mari.files_PAS0868.active_3,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive_3							:= PROJECT(Prof_License_Mari.files_PAS0868.inactive_3,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));										
									
	FullFile 								:= active + inactive + active_1 + inactive_1 + active_2 + inactive_2 + active_3 + inactive_3;  // + inactive_4;
	oact    := OUTPUT(active);
	oinact  := OUTPUT(inactive);
	oact1   := OUTPUT(active_1);
	oinact1 := OUTPUT(inactive_1);
	oact2   := OUTPUT(active_2);
	oinact2 := OUTPUT(inactive_2);
	oact3   := OUTPUT(active_3);
	oinact3 := OUTPUT(inactive_3);
	ofull   := OUTPUT(FullFile);
	DBA_Ind 								:= '( DBA |D/B/A |/DBA | A/K/A | AKA )';
  Sufx_Pattern := 				'(^SR | SR.| SR|^JR | JR | JR$|^JR$| III| II| IV| VI | VII)';		
	
STRING reformat_fullname(STRING name) := FUNCTION
suffix_ind := '^(.*)(,JR|,SR|,II|,III|,IV|,V) (.*)$';
	f := IF(REGEXFIND(suffix_ind, name), REGEXFIND(suffix_ind, name,1,NOCASE),'');
	s := IF(REGEXFIND(suffix_ind, name), REGEXFIND(suffix_ind, name,2,NOCASE),'');
	l := IF(REGEXFIND(suffix_ind, name), REGEXFIND(suffix_ind, name,3,NOCASE),'');
reformat_name := StringLib.StringCleanSpaces(f + ' '+l + s);
RETURN reformat_name;
END; 

	//Filtering out BAD RECORDS
	ut.CleanFields(FullFile, ClnUnprintable);
	FilterBlankLic					:= ClnUnprintable(RECORD_NUM != '');
	FilterBadName						:= FilterBlankLic(StringLib.StringToUpperCase(LAST_NAME[1..5]) != 'ERROR' AND TRIM(LAST_NAME+FIRST_NAME+ORG_NAME+FULL_NAME)!='');
	GoodNameRec 						:= FilterBadName(NOT REGEXFIND('(ENTERED IN ERROR|IN ERROR|INPUT ERROR|ERROR|REQUIRED C E COURSE)', StringLib.StringToUpperCase(TRIM(ORG_NAME,LEFT,RIGHT))));
	oFile										:= OUTPUT(SAMPLE(GoodNameRec, 4000,1));
	
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(GoodNameRec pInput) := TRANSFORM
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
		tmp_RECORD_num				:= ut.CleanSpacesAndUpper(REGEXREPLACE('"',pInput.RECORD_NUM, ''));
		SELF.LICENSE_NBR	  	:= tmp_RECORD_num;
		SELF.RAW_LICENSE_TYPE	:= '';
		id 										:= pInput.ID;
		typ 									:= pInput.TYP;
		stat 									:= pInput.STATUS;
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(stat)[1..1];
		SELF.STD_LICENSE_TYPE := MAP(id='900' AND typ='12001' => 'CRA',
																 id='900' AND typ='12005' => 'CGA',
																 id='900' AND typ='12010' => 'CPE',
																 id='900' AND typ='12030' => 'CBA',
																 id='1200' AND typ='12001' => 'ABS',
																 id='1200' AND typ='12150' => 'BO',
																 id='1200' AND typ='12190' => 'BSPS',
																 id='1200' AND typ='12200' => 'BCLLCP',
																 id='1200' AND typ='12270' => 'RESS',
																 id='1200' AND typ='12310' => 'BMLS',
																 '');
		SELF.PROVNOTE_3 	    := '{LICENSE TYPE ASSIGNED}';	
		SELF.TYPE_CD					:= MAP(SELF.STD_LICENSE_TYPE IN ['BO','BCLLCP'] AND pInput.ORG_NAME != '' => 'GR',
		                             SELF.STD_LICENSE_TYPE IN ['CRA','CGA','CPE','CBA','ABS','RESS','BMLS'] AND pInput.LAST_NAME != ''=> 'MD',
		                             SELF.STD_LICENSE_TYPE IN ['CRA','CGA','CPE','CBA','ABS','RESS','BMLS'] AND pInput.LAST_NAME = '' AND TRIM(SELF.RAW_LICENSE_STATUS)='I' => 'MD',
											           SELF.STD_LICENSE_TYPE IN ['BSPS'] AND pInput.FULL_NAME!=''=> 'MD',
																 '');
																									
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
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.ORG_NAME);
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
		TrimAddress3					:= ut.CleanSpacesAndUpper(pInput.ADDRESS3);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY_1);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		TrimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);	
	
	//Remove suffix if it is broker or office
		filterSuffix					:= IF(TrimNAME_SUFX IN ['BROKER', 'OFFICER','PARTNER'], '', TrimNAME_SUFX);
		temp_Suffix 					:= IF(STD.Str.Find(filterSuffix, ' ',1) > 0,TRIM(filterSuffix[1..STD.Str.Find(filterSuffix, ' ', 1) -1], right),filterSuffix);
		temp_credential 			:= IF(TrimNAME_SUFX IN ['BROKER', 'OFFICER','PARTNER'], TrimNAME_SUFX, TRIM(filterSuffix[LENGTH(temp_suffix)+1..],LEFT,RIGHT));
		
		//Clean name
		prepFullName          := IF(REGEXFIND('^(.*)(,JR| JR |,SR| SR |,II|,III|,IV|,V) (.*)$', TrimNAME_FULL), reformat_fullname(TrimNAME_FULL),TrimNAME_FULL);
		FullName							:= IF(TrimNAME_FULL<>'',
		                            prepFullName,
		                            StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_MID + ' ' + TrimNAME_LAST + ' ' + temp_Suffix)
																);
																
		clnFullName						:= REGEXREPLACE('\'',FullName,'');
		removeSufx            := IF(REGEXFIND(Sufx_pattern,clnFullName),REGEXREPLACE(Sufx_pattern,clnFullName,''),clnFullName);

		//Clean names 
		//Clean Parsed Name
		TmpNAME_LAST			:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_LAST),REGEXREPLACE(Sufx_Pattern,TrimNAME_LAST,''),TrimNAME_LAST);
		TmpNAME_FIRST 		:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_FIRST),REGEXREPLACE(Sufx_Pattern,TrimNAME_FIRST,''),TrimNAME_FIRST);
		TmpNAME_MID 			:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_MID),REGEXREPLACE(Sufx_Pattern,TrimNAME_MID,''),TrimNAME_MID);

		TmpSuffix         := MAP(REGEXFIND(Sufx_Pattern,TrimNAME_LAST)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_LAST,0),LEFT,RIGHT),
			                         REGEXFIND(Sufx_Pattern,TrimNAME_MID)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_MID,0),LEFT,RIGHT),
			                         REGEXFIND(Sufx_Pattern,TrimNAME_FIRST)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_FIRST,0),LEFT,RIGHT),
															 REGEXFIND(Sufx_Pattern,TrimNAME_FULL)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_FULL,0),LEFT,RIGHT),
			                         TrimNAME_SUFX);	
		
		tempFNick := Prof_License_Mari.fGetNickname(TmpNAME_FIRST,'nick');
		tempMNick	:= Prof_License_Mari.fGetNickname(TmpNAME_MID,'nick');
		tempLNick	:= Prof_License_Mari.fGetNickname(TmpNAME_LAST,'nick');
		
		stripNickFName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TmpNAME_FIRST,'strip_nick'));
		stripNickMName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TmpNAME_MID,'strip_nick'));
		stripNickLName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TmpNAME_LAST,'strip_nick'));
		
		GoodFirstName		:= IF(tempFNick != '',stripNickFName,TmpNAME_FIRST);
		GoodMidName			:= IF(tempMNick != '',stripNickMName,TmpNAME_MID);
		GoodLastName		:= IF(tempLNick != '',stripNickLName,TmpNAME_LAST);
		
		tempNick 							:= Prof_License_Mari.fGetNickname(removeSufx,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(removeSufx,'strip_nick');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		initParsedName				:= MAP(TRIM(SELF.TYPE_CD)='MD' AND TrimNAME_FIRST<>'' AND TrimNAME_LAST<>''
		                               => Prof_License_Mari.fnCleanNames.easyClean(TrimNAME_FIRST,TrimNAME_MID,TrimNAME_LAST,temp_Suffix),
																 TRIM(SELF.TYPE_CD)='MD' AND TrimNAME_LAST='' AND	removeSufx<>''
																   => Address.CleanPersonFML73(stripNickName),
																 ''); 
		ParsedName 					:= IF(LENGTH(TRIM(initParsedName[46..65],LEFT,RIGHT)) = 1, Prof_License_Mari.mod_clean_name_addr.cleanFMLName(stripNickName),
															initParsedName);														 
		FirstName 						:= IF(GoodFirstName <> '', GoodFirstName,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[6..25],LEFT,RIGHT),''));
		MidName   						:= IF(GoodMidName = temp_Suffix OR GoodMidName = TRIM(ParsedName[66..70],LEFT,RIGHT), '',
															IF(GoodMidName <> '', GoodMidName,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[26..45],LEFT,RIGHT),'')));	
		LastName  						:= IF(GoodLastName <> '', GoodLastName,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[46..65],LEFT,RIGHT),'')); 
		Suffix	  						:= IF(TmpSuffix <> '', TmpSuffix,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[66..70],LEFT,RIGHT),''));
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);	
		SELF.CREDENTIAL       := temp_credential;

		//Clean Org Name for GR
		prep0Name_ORG					:= StringLib.StringFindReplace(TrimNAME_ORG,'"','');
		prep1Name_ORG					:= StringLib.StringFindReplace(prep0Name_ORG,'% ',' PERCENT ');
		prepNAME_ORG					:= MAP(StringLib.Stringfind(prep1Name_ORG,' T/A ',1) > 0
																	=> StringLib.StringFindReplace(prep1Name_ORG,' T/A ',' DBA '),
																 REGEXFIND('(^AKA )', prep1Name_ORG)
																  => REGEXREPLACE('(^AKA )', prep1Name_ORG, ''),
																 REGEXFIND('(^ATTN - )', prep1Name_ORG)
																  => REGEXREPLACE('(ATTN - )', prep1Name_ORG, ''),
																 prep1Name_ORG='INACTIVE' => '',	
																prep1Name_ORG);
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
																	REGEXREPLACE('\'',ConcatNAME_FULL,''),
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
		SELF.NAME_ORG_SUFX	  := IF(SELF.TYPE_CD = 'MD',
		                            '',
																Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)));		
		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := MAP(SELF.TYPE_CD = 'MD' AND TrimNAME_FULL <> '' => TrimNAME_FULL,
																 SELF.TYPE_CD = 'MD' AND TrimNAME_FULL = '' => clnFullName,
															       TrimNAME_ORG);
		SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG_ORIG<>'','F','');

		// Prepping Address Fields for Parsing
		temp_preaddr1				:= StringLib.StringCleanSpaces(
															  REGEXREPLACE('(^C/O )',TrimAddress1,'') +' '+
																REGEXREPLACE('(^C/O )',TrimAddress2,'') +' '+
																REGEXREPLACE('(^C/O )',TrimAddress3,''));
		tmpGetDBAName				:= MAP(Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1)<>'' AND
															 NOT REGEXFIND('(^C/O [0-9]+ .* HIGHWAY$)',TrimAddress1)
																=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
															 Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2)<>'' AND
															 NOT REGEXFIND('(^C/O [0-9]+ .* HIGHWAY$)',TrimAddress2)
																=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2),
															 Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress3)<>'' AND
															 NOT REGEXFIND('(^C/O [0-9]+ .* HIGHWAY$)',TrimAddress3)
																=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress3),
															 '');	
		clnGetDBAName				:= MAP(REGEXFIND('([0-9]+) .* (LANE|STREET|DRIVE|AVENUE|SQUARE)',	tmpGetDBAName) => '',
		                           REGEXFIND('PO BOX',	tmpGetDBAName) => '',
															 REGEXFIND('ATTN ',temp_preaddr1) => '',
															 tmpGetDBAName);
		tmpGetCorpName			:= MAP(REGEXFIND('360 REALTY SOLUTIONS INC',temp_preaddr1)
															  => '360 REALTY SOLUTIONS INC',
															 REGEXFIND('100 REFERRAL COMPANY',temp_preaddr1)
															  => '100 REFERRAL COMPANY',
															 REGEXFIND('CENTURY 21 ABSOLUTE REALTY',temp_preaddr1)
															  => 'CENTURY 21 ABSOLUTE REALTY',
															 REGEXFIND('ONE80 REAL ESTATE SERVICES LLC',temp_preaddr1)
															  => 'ONE80 REAL ESTATE SERVICES LLC',	
															 Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_preaddr1)<>''
																=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_preaddr1),
															 Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddress1)<>'' AND
															 NOT REGEXFIND('(^[0-9]+ )',TrimAddress1) AND
															 NOT REGEXFIND('(^[C/O |DBA |AKA])',TrimAddress1) AND
															 NOT REGEXFIND('LANE|STREET|DRIVE|AVENUE|SQUARE|PLAZA',TrimAddress1)
																=> Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddress1),
															 Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddress2)<>'' AND
															 NOT REGEXFIND('(^[0-9]+ )',TrimAddress2) AND
															 NOT REGEXFIND('(^#[0-9]+ )',TrimAddress2) AND
															 NOT REGEXFIND('(^[C/O |DBA |AKA])',TrimAddress2)
																=> Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddress2),
															 '');
		clnGetCorpName			:= MAP(REGEXFIND('([0-9]+) .* (LANE|STREET|DRIVE|AVENUE|SQUARE)',	tmpGetCorpName) => '',
		                           REGEXFIND('PO BOX',	tmpGetCorpName) => '',
															 REGEXFIND('ATTN ',temp_preaddr1) => '',
															 tmpGetCorpName);
		tmpGetContactName		:= IF(REGEXFIND('PO BOX ', tmpGetDBAName),
		                          '',
		                          Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpGetDBAName));
		clnGetContactName		:= MAP(REGEXFIND('ATTN ',temp_preaddr1)  => tmpGetDBAName,
															 tmpGetContactName);

		temp_preaddr1_rm_dba 	:= TRIM(IF(tmpGetDBAName<>'',REGEXREPLACE(tmpGetDBAName,temp_preaddr1,''),temp_preaddr1),LEFT,RIGHT);
		temp_preaddr1_rm_corp := TRIM(IF(tmpGetCorpName<>'',REGEXREPLACE(tmpGetCorpName,temp_preaddr1_rm_dba,''),temp_preaddr1_rm_dba),LEFT,RIGHT);
		temp_preaddr1_rm_contact := IF(tmpGetContactName<>'',REGEXREPLACE(tmpGetContactName,temp_preaddr1_rm_corp,''),temp_preaddr1_rm_corp);
		temp_preaddr1_rm_misc := REGEXREPLACE('(CENTURY 21[A-Z&\\- ]+ [INC|COMPANY])', temp_preaddr1_rm_contact, '');
		temp_preaddr1_rm_misc1:= REGEXREPLACE('(^.* INC$|^.* INC\\.$|^.* INC\\.? )', temp_preaddr1_rm_misc, '');
		cln_preaddr1					:= StringLib.StringCleanSpaces(REGEXREPLACE('(DBA |C/O |ATTN -)', temp_preaddr1_rm_misc1, ''));
		cln_preaddr2	 				:= StringLib.StringCleanSpaces(
		                           IF(TrimCity='*','',TrimCity) + ' ' +
															 IF(TrimState='NA','',TrimState) +' ' + 
															 IF(TrimZip='0','',TrimZip)
															 ); 

		clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(cln_preaddr1,cln_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(tmpADDR_ADDR1_1);	
		SELF.ADDR_ADDR2_1		:= StringLib.StringCleanSpaces(tmpADDR_ADDR2_1); 
		SELF.ADDR_CITY_1		:= IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),IF(TrimCity='*','',TrimCity));
		SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),IF(TrimState='NA','',TrimState));
		SELF.ADDR_ZIP5_1		:= IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),IF(TrimZip='0','',TrimZip));
		SELF.ADDR_ZIP4_1		:= clnAddrAddr1[122..125];
		ParseContact				:= IF(clnGetContactName<>'', Address.CleanPersonFML73(clnGetContactName), '');																				
		
		//Identifying Office and DBA NAMES
		prepNAME_OFFICE 			:= MAP(StdNAME_ORG<>'' => StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_ORG,'/',' ')),
																 clnGetCorpName<>'' => clnGetCorpName,
		                             clnGetDBAName<>'' => clnGetDBAName,
																 '');
		SELF.NAME_OFFICE			:= MAP(TRIM(SELF.NAME_ORG_ORIG,all)=TRIM(prepNAME_OFFICE,all) => '', 
		                             TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,all)=TRIM(prepNAME_OFFICE,all) => '', 
																 TRIM(SELF.NAME_ORG,all)=TRIM(prepNAME_OFFICE,all) => '', 
																 TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,all)=TRIM(prepNAME_OFFICE,all) => '', 
																 prepNAME_OFFICE);
		
		comp_names 						:= '(REMAX|USA 4%|REAL EST|ASSOC|AGCY| CO$)';												 
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ',
																IF(prof_license_mari.func_is_company(SELF.NAME_OFFICE) OR
																	 REGEXFIND(comp_names,TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)),
																	 'GR',
																	 'MD'),
																'');
		
		getNAME_DBA						:= MAP(getDBA_ORG<>'' => getDBA_ORG,
		                             clnGetDBAName<>'' AND clnGetDBAName<>prepNAME_OFFICE => clnGetDBAName,
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
		SELF.NAME_CONTACT_LAST	:= IF(clnGetCorpName<>'' AND SELF.NAME_OFFICE<>'' AND
		                              NOT REGEXFIND(clnGetCorpName, SELF.NAME_OFFICE, NOCASE),
		                              clnGetCorpName,
		                              TRIM(ParseContact[46..65],LEFT,RIGHT));
			
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
	
	inFileLic	:= PROJECT(GoodNameRec,xformToCommon(left));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_prof_cd					:= JOIN(inFileLic, Cmvtranslation,
																	LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																	trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base 	trans_lic_status(ds_map_prof_cd L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
																
		SELF := L;
	END;

	ds_map_lic_trans 				:= JOIN(ds_map_prof_cd, Cmvtranslation,
																	TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
																	AND RIGHT.fld_name='LIC_STATUS' ,
																	trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
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
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_1','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_2','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_3','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_1','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_2','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_3','using','used');	
																			);

	notify_missing_codes 		:= Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address 	:= Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;	