/* Converting Pennsylvania, Commonwealth of  - Prof License/Mulitple Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
#workunit('name','Prof License MARI- PAS0868')
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard,STD;

EXPORT map_PAS0868_conversion(STRING pVersion) := FUNCTION

	code 										:= 'PAS0868';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= output(Cmvtranslation);
	
	//Move to using
	move_to_using						:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','sprayed','using');
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_1','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_2','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_3','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_1','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_2','sprayed','using');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_3','sprayed','using');	
																			//Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_4','sprayed','using');	
																			);
	
	active									:= project(Prof_License_Mari.files_PAS0868.active,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive								:= project(Prof_License_Mari.files_PAS0868.inactive,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	active_1								:= project(Prof_License_Mari.files_PAS0868.active_1,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive_1							:= project(Prof_License_Mari.files_PAS0868.inactive_1,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	active_2								:= project(Prof_License_Mari.files_PAS0868.active_2,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive_2							:= project(Prof_License_Mari.files_PAS0868.inactive_2,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																											SELF := []));
	active_3								:= project(Prof_License_Mari.files_PAS0868.active_3,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));
	inactive_3							:= project(Prof_License_Mari.files_PAS0868.inactive_3,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										 SELF := LEFT;
																																										 SELF := []));										
	 // inactive_4							:= project(Prof_License_Mari.files_PAS0868.inactive_4,TRANSFORM(Prof_License_Mari.layout_PAS0868.common,
																																										  // SELF := LEFT;
																																										  // SELF := []));										
	FullFile 								:= active + inactive + active_1 + inactive_1 + active_2 + inactive_2 + active_3 + inactive_3;  // + inactive_4;
	oact := output(active);
	oinact := output(inactive);
	oact1 := output(active_1);
	oinact1 := output(inactive_1);
	oact2 := output(active_2);
	oinact2 := output(inactive_2);
	oact3 := output(active_3);
	oinact3 := output(inactive_3);
	ofull := output(FullFile);
	DBA_Ind 								:= '( DBA |D/B/A |/DBA | A/K/A | AKA )';


STRING reformat_fullname(string name) := FUNCTION
suffix_ind := '^(.*)(,JR|,SR|,II|,III|,IV|,V) (.*)$';
	f := if(regexfind(suffix_ind, name), regexfind(suffix_ind, name,1,NOCASE),'');
	s := if(regexfind(suffix_ind, name), regexfind(suffix_ind, name,2,NOCASE),'');
	l := if(regexfind(suffix_ind, name), regexfind(suffix_ind, name,3,NOCASE),'');
reformat_name := StringLib.StringCleanSpaces(f + ' '+l + s);
return reformat_name;
END; 


	//Filtering out BAD RECORDS
	ut.CleanFields(FullFile, ClnUnprintable);
	FilterBlankLic					:= ClnUnprintable(RECORD_NUM != '');
	FilterBadName						:= FilterBlankLic(StringLib.StringToUpperCase(LAST_NAME[1..5]) != 'ERROR' AND TRIM(LAST_NAME+FIRST_NAME+ORG_NAME+FULL_NAME)!='');
	GoodNameRec 						:= FilterBadName(NOT REGEXFIND('(ENTERED IN ERROR|IN ERROR|INPUT ERROR|ERROR|REQUIRED C E COURSE)', StringLib.StringToUpperCase(trim(ORG_NAME,left,right))));
	oFile										:= output(sample(GoodNameRec, 4000,1));
	
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
		self.LICENSE_STATE	 	:= code[1..2];

		//Get license number, license status, and license type
		tmp_record_num				:= ut.fnTrim2Upper(REGEXREPLACE('"',pInput.RECORD_NUM, ''));
		self.LICENSE_NBR	  	:= tmp_record_num;
		// record_type						:= REGEXFIND('(^[A-Z]+)[0-9]+', tmp_record_num, 1);
		// self.RAW_LICENSE_TYPE	:= record_type;
		
		self.RAW_LICENSE_TYPE	:= '';
		//Certified Real Estate Appraisers Board (id 900)
		//(12001) Certified Residential Appraiser, 
		//(12005) Certified General Appraiser, 
		//(12010) Certified Pennsylvania Evaluator, 
		//(12030) Certified Broker Appraiser
		//Real Estate Commission (id 1200)
		//(12001) Associate Broker-Standard, 
		//(12150) Branch Office, 
		//(12190) Broker (Sole-Proprietor)-Standard, 
		//(12200) Broker (Corp LLC Partner)-Standard, 
		//(12270) Real Estate Salesperson-Standard, 
		//(12310) Broker Multi-Licensee-Standard
		id 										:= pInput.ID;
		typ 									:= pInput.TYP;
		stat 									:= pInput.STATUS;
		self.RAW_LICENSE_STATUS := ut.fnTrim2Upper(stat)[1..1];
		self.STD_LICENSE_TYPE := MAP(id='900' and typ='12001' => 'CRA',
																 id='900' and typ='12005' => 'CGA',
																 id='900' and typ='12010' => 'CPE',
																 id='900' and typ='12030' => 'CBA',
																 id='1200' and typ='12001' => 'ABS',
																 id='1200' and typ='12150' => 'BO',
																 id='1200' and typ='12190' => 'BSPS',
																 id='1200' and typ='12200' => 'BCLLCP',
																 id='1200' and typ='12270' => 'RESS',
																 id='1200' and typ='12310' => 'BMLS',
																 '');
		SELF.PROVNOTE_3 	    := '{LICENSE TYPE ASSIGNED}';	
		self.TYPE_CD					:= MAP(//pInput.LAST_NAME != '' AND pInput.ORG_NAME = ''=> 'MD',
																 //pInput.FULL_NAME != '' AND pInput.ORG_NAME = ''=> 'MD',
																 //pInput.LAST_NAME != '' AND Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME) = 'INACTIVE'=> 'MD',
																 //pInput.LAST_NAME = '' and pInput.FULL_NAME='' AND pInput.ORG_NAME != '' => 'GR',
																 //pInput.ORG_NAME != '' => 'GR',
		                             self.STD_LICENSE_TYPE IN ['BO','BCLLCP'] AND pInput.ORG_NAME != '' => 'GR',
		                             self.STD_LICENSE_TYPE IN ['CRA','CGA','CPE','CBA','ABS','RESS','BMLS'] AND pInput.LAST_NAME != ''=> 'MD',
		                             self.STD_LICENSE_TYPE IN ['CRA','CGA','CPE','CBA','ABS','RESS','BMLS'] AND pInput.LAST_NAME = '' AND TRIM(self.RAW_LICENSE_STATUS)='I' => 'MD',
											           self.STD_LICENSE_TYPE IN ['BSPS'] AND pInput.FULL_NAME!=''=> 'MD',
																 '');
																									
		//Reformatting date to YYYYMMDD
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUE_DATE);
		self.EXPIRE_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXP_DATE);
			
		//Process names and address
		TrimNAME_FIRST 				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.MIDDLE_NAME);
		TrimNAME_LAST 				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LAST_NAME);
		TrimNAME_SUFX 				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SUFFIX);
		TrimNAME_FULL					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.FULL_NAME);
		TrimNAME_ORG					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME);
		TrimAddress1					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1);
		TrimAddress2					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS2);
		TrimAddress3					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS3);
		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY_1);
		TrimState							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE);
		TrimZip								:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP);	
	
	//Remove suffix if it is broker or office
		filterSuffix					:= IF(TrimNAME_SUFX IN ['BROKER', 'OFFICER'], '', TrimNAME_SUFX);
		temp_Suffix 					:= IF(STD.Str.Find(filterSuffix, ' ',1) > 0,trim(filterSuffix[1..STD.Str.Find(filterSuffix, ' ', 1) -1], right),filterSuffix);
		temp_credential 			:= IF(TrimNAME_SUFX IN ['BROKER', 'OFFICER'], TrimNAME_SUFX, TRIM(filterSuffix[LENGTH(temp_suffix)+1..],LEFT,RIGHT));
		
		//Clean name
		prepFullName := if(regexfind('^(.*)(,JR|,SR|,II|,III|,IV|,V) (.*)$', TrimNAME_FULL), reformat_fullname(TrimNAME_FULL),TrimNAME_FULL);
		FullName							:= IF(TrimNAME_FULL<>'',
		                            prepFullName,
		                            StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_MID + ' ' + TrimNAME_LAST + ' ' + temp_Suffix)
																);
		clnFullName						:= REGEXREPLACE('\'',FullName,'');
		
		//Clean names 
		//Clean Parsed Name
		tempFNick := Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		tempMNick	:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');
		tempLNick	:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');
		
		stripNickFName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick'));
		stripNickMName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick'));
		stripNickLName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick'));
		
		GoodFirstName		:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		GoodMidName			:= IF(tempMNick != '',stripNickMName,TrimNAME_MID);
		GoodLastName		:= IF(tempLNick != '',stripNickLName,TrimNAME_LAST);
		
		
		tempNick 							:= Prof_License_Mari.fGetNickname(clnFullName,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(clnFullName,'strip_nick');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		initParsedName				:= MAP(TRIM(self.TYPE_CD)='MD' AND TrimNAME_FIRST<>'' AND TrimNAME_LAST<>''
		                               => Prof_License_Mari.fnCleanNames.easyClean(TrimNAME_FIRST,TrimNAME_MID,TrimNAME_LAST,temp_Suffix),
																 TRIM(self.TYPE_CD)='MD' AND TrimNAME_LAST='' AND	clnFullName<>''
																   => Address.CleanPersonFML73(stripNickName),
																 ''); ;
		ParsedName 					:= IF(LENGTH(TRIM(initParsedName[46..65],left,right)) = 1, Prof_License_Mari.mod_clean_name_addr.cleanFMLName(stripNickName),
															initParsedName);														 
		FirstName 						:= IF(GoodFirstName <> '', GoodFirstName,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[6..25],left,right),''));
		MidName   						:= IF(GoodMidName = temp_Suffix OR GoodMidName = TRIM(ParsedName[66..70],left,right), '',
															IF(GoodMidName <> '', GoodMidName,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[26..45],left,right),'')));	
		LastName  						:= IF(GoodLastName <> '', GoodLastName,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[46..65],left,right),'')); 
		Suffix	  						:= IF(temp_Suffix <> '', temp_Suffix,
																IF(SELF.TYPE_CD = 'MD' AND ParsedName != '', TRIM(ParsedName[66..70],left,right),''));
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);
		self.NAME_FIRST		   	:= FirstName;
		self.NAME_MID					:= MidName;							
		self.NAME_LAST		   	:= LastName;
		self.NAME_SUFX				:= Suffix;
		self.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);	
		self.CREDENTIAL       := temp_credential;

		
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
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
																 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) 
																   => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
																 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) 
																	 => StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		self.NAME_ORG_PREFX		:= IF(self.TYPE_CD = 'MD','',
																Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG)); 
		self.NAME_ORG		    	:= IF(self.TYPE_CD = 'MD',
																	REGEXREPLACE('\'',ConcatNAME_FULL,''),
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
		self.NAME_ORG_SUFX	  := IF(self.TYPE_CD = 'MD',
		                            '',
																Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)));		
		//Populating MARI Name Fields
		self.NAME_ORG_ORIG	  := MAP(self.TYPE_CD = 'MD' and TrimNAME_FULL <> '' => TrimNAME_FULL,
																 self.TYPE_CD = 'MD' and TrimNAME_FULL = '' => clnFullName,
															       TrimNAME_ORG);
		self.NAME_FORMAT			:= IF(self.NAME_ORG_ORIG<>'','F','');

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
															 Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_preaddr1)<>''
																=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_preaddr1),
															 Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddress1)<>'' AND
															 NOT REGEXFIND('(^[0-9]+ )',TrimAddress1) AND
															 NOT REGEXFIND('(^[C/O |DBA |AKA])',TrimAddress1)
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
		temp_preaddr1_rm_misc1:= REGEXREPLACE('(KORMAN RES PROPERTIES INC)', temp_preaddr1_rm_misc, '');
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
		SELF.NAME_OFFICE			:= IF(TRIM(SELF.NAME_ORG_ORIG)=TRIM(prepNAME_OFFICE), '', prepNAME_OFFICE);
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
		self.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:=  StringLib.StringFindReplace(StdNAME_DBA,'/',' ');
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);

		self.NAME_DBA_ORIG	  := IF(self.NAME_DBA<>'',getNAME_DBA,'');
		self.NAME_MARI_ORG	  := IF(self.TYPE_CD = 'MD',self.NAME_OFFICE,StdNAME_ORG);
		self.NAME_MARI_DBA	  := IF(self.NAME_DBA<>'',StdNAME_DBA,'');
																					
		self.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2 + TrimCity + pInput.ZIP) != '','B','');

		self.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],left,right);
		self.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],left,right);  
		self.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],left,right);  
		self.NAME_CONTACT_LAST	:= IF(clnGetCorpName<>'' AND self.NAME_OFFICE<>'' AND
		                              NOT REGEXFIND(clnGetCorpName, self.NAME_OFFICE, NOCASE),
		                              clnGetCorpName,
		                              TRIM(ParseContact[46..65],left,right));

					
		//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD		:= MAP(self.TYPE_CD = 'MD' => 'IN',
																 self.TYPE_CD = 'GR' AND self.STD_LICENSE_TYPE[1..2] ='BO' => 'BR',
																 self.TYPE_CD = 'GR' => 'CO',
																 '');		

		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       	:= hash64(trim(self.license_nbr,left,right) 
																				+trim(self.std_license_type,left,right)
																				+TrimName_Org
																				+FullName
																				+TrimAddress1
																				+TrimAddress2
																				+TrimAddress3
																				+TrimCity
																				+TrimZip);
																									 
		self.PCMC_SLPK			:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= project(GoodNameRec,xformToCommon(left));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(inFileLic L, Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
	end;

	ds_map_prof_cd					:= join(inFileLic, Cmvtranslation,
																	left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(trim(left.STD_LICENSE_TYPE,left,right))=trim(right.fld_value,left,right),
																	trans_lic_type(left,right),left outer,lookup);

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base 	trans_lic_status(ds_map_prof_cd L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(trim(R.DM_VALUE1,left,right));
																
		self := L;
	end;

	ds_map_lic_trans 				:= JOIN(ds_map_prof_cd, Cmvtranslation,
																	TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
																	AND right.fld_name='LIC_STATUS' ,
																	trans_lic_status(left,right),left outer,lookup);


	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

	//maribase_plus_dbas 	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	//ds_map_affil := join(ds_map_source_desc, company_only_lookup,
	ds_map_affil := join(dedup(sort(distribute(ds_map_lic_trans,hash(name_org_orig,CMC_SLPK)),name_org_orig,CMC_SLPK,local),record,local), 
											 sort(distribute(company_only_lookup,hash(name_org_orig,CMC_SLPK)),name_org_orig,CMC_SLPK,local),
												TRIM(left.name_org_orig[1..50],left,right)	= TRIM(right.name_org_orig[1..50],left,right)
												AND left.AFFIL_TYPE_CD = 'BR',
												assign_pcmcslpk(left,right),left outer,lookup);																		

	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);


	d_final 								:= output(ds_map_affil, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

//BUG 180478
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil(NAME_ORG_ORIG != ''));
	// add_super 							:= sequential(fileservices.startsuperfiletransaction(),
																				// fileservices.addsuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				// fileservices.finishsuperfiletransaction()
																				// );

	move_to_used						:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','using','used');
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_1','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_2','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_3','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_1','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_2','using','used');	
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_3','using','used');	
																			//Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_4','using','used');	
																			);

	notify_missing_codes 		:= Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address 	:= Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
	
END;	

