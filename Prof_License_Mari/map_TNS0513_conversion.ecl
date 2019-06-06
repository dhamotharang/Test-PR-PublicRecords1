/* Converting Tennessee Reg Board and Commission Commerce & Ins Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT ut, Address, Prof_License_Mari,lib_stringlib,Lib_FileServices,STD ;


EXPORT  map_TNS0513_conversion(STRING pVersion) := FUNCTION

code 		:= 'TNS0513';
src_cd	:= code[3..7];
src_st	:= code[1..2];	//License state

infile := Prof_License_Mari.files_TNS0513;
oRel   := OUTPUT(infile);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
OCmv	 := OUTPUT(cmvTransLkp);

LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD =src_cd);

Comments:= 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

IndTYPE := ['1501','2501','1503','2509'];
BusTYPE	:= ['2507','2502'];
CoPattern   := '( INC| LLC|L.L.C.| LLP|,INC|,LLC|,LLP| COMPANY$| CORP$| REAL ESTATE$|RESORTS$|PROPERTIES$|CELEBRATION HOMES|WESTGATE MARKETING|SIGNATURE HOMES|FAST TRAIN HOLDINGS|WYNDHAM RESORTS|THE DREAM TEAM GREEN HILLS)';	

AddrExceptions := '(SUITE|PLAZA|TOWER |STREET|ROAD|HIGHWAY|STE |SQUARE |VILLAGE|CONDO|MAIN ST|AVENUE|CENTER)';
CityExceptions := '(BELGIUM|ITALY|GHANA|RIYADH|INDIES|CANADA|ONTARIO|APO )';										

//Filtering out BAD RECORDS
GoodNameRec 	:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, STD.Str.ToUpperCase(ORG_NAME)));
ut.CleanFields(GoodNameRec,clnGoodNameRec);
																			
//Real Estate License to common MARIBASE layout
Prof_License_Mari.layout_base_in			xformToCommon(Prof_License_Mari.layout_TNS0513.src pInput) 
	:= 
	 TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= pInput.LN_filedate;
		SELF.DATE_LAST_SEEN		:= pInput.LN_filedate;
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.LN_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.LN_filedate;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= pInput.LN_filedate;
		SELF.STAMP_DTE				:= pInput.LN_filedate; //yyyymmdd
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';
		SELF.TYPE_CD					:= MAP(pInput.PRO_CODE IN BusTYPE => 'GR',
																 pInput.PRO_CODE IN IndTYPE =>'MD',
																'');
		
		//Standardize Fields
		TrimNAME_ORG			:= ut.fnTrim2Upper(pInput.ORG_NAME);
		TrimAddress1 			:= ut.fnTrim2Upper(pInput.ADDRESS1_1);
		TrimAddress2 			:= ut.fnTrim2Upper(pInput.ADDRESS2_1);
		TrimNAME_CONTACT	:= ut.fnTrim2Upper(pInput.CONTACT);
		TrimCity					:= ut.fnTrim2Upper(pInput.CITY_1);
		
		// License Information
		SELF.LICENSE_NBR	  		:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(pInput.SLNUM);
		SELF.OFF_LICENSE_NBR		:= '';
		SELF.LICENSE_STATE	 		:= 'TN';
		SELF.RAW_LICENSE_TYPE		:= ut.fnTrim2Upper(pInput.RANK1);
		SELF.STD_LICENSE_TYPE		:= ut.fnTrim2Upper(pInput.RANK1);
		SELF.STD_LICENSE_DESC		:= '';
		SELF.RAW_LICENSE_STATUS := ut.fnTrim2Upper(pInput.Status_Desc);
		SELF.STD_LICENSE_STATUS := '';
		SELF.STD_STATUS_DESC		:= '';
		SELF.PROV_STAT					:= '';
																			 
		//Prep INDV/BUSINESS NAMES
		IndNAME_ORG := IF(pInput.PRO_CODE IN IndType,TrimNAME_ORG,'');
		
/* Remove AKA, Nickname */		
		removeAKAName	:= IF(REGEXFIND(' AKA ',IndNAME_ORG), 
												Prof_License_Mari.mod_clean_name_addr.GetCorpName(IndNAME_ORG),IndNAME_ORG);
		tmpNickname	:= IF(STD.Str.Find(removeAKAName ,'(',1)> 0 
												OR STD.Str.Find(removeAKAName,'"',1)> 0,removeAKAName,'');
												
		fixNickname := IF(STD.Str.Find(tmpNickname,'""',1) > 0,STD.Str.FindReplace(tmpNickname, '""','/'),
											IF(STD.Str.Find(tmpNickname,'" "',1) > 0,STD.Str.FindReplace(tmpNickname, '" "','/'),
																												tmpNickName));
		
		tempNick := Prof_License_Mari.fGetNickname(fixNickname,'nick');
		stripNickName := Prof_License_Mari.fGetNickname(fixNickname,'strip_nick');
		
		GoodIndvName	:= IF(tmpNickname != '',stripNickName,removeAKAName);
		ParsedName_init	:= Address.CleanPersonFML73(STD.Str.CleanSpaces(TRIM(GoodIndvName)));
	  ParsedName:= IF(LENGTH(TRIM(ParsedName_init[46..65])) <= 1 or TRIM(ParsedName_init[6..25]) = '',Prof_License_Mari.mod_clean_name_addr.cleanFMLName(STD.Str.CleanSpaces(TRIM(GoodIndvName))),	
											ParsedName_init);	
		FirstName := TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   := TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  := TRIM(ParsedName[46..65],LEFT,RIGHT); 
		Suffix	  := TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL := 	STD.Str.CleanSpaces(LastName +' '+Suffix+ ' '+FirstName);										
		
					
		BusNAME_ORG	 := IF(pInput.PRO_CODE IN BusType,TrimNAME_ORG,'');
		prepNAME_ORG := MAP(STD.Str.Find(BusNAME_ORG,'T/A',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'T/A',' DBA '),
		                   REGEXFIND('( DB$|/DB$)',BusNAME_ORG) =>   STD.Str.FindReplace(BusNAME_ORG,'DB', ' DBA'), 
											 REGEXFIND('(/DBA$)',BusNAME_ORG) =>   STD.Str.FindReplace(BusNAME_ORG,'/DBA', ' DBA'),
											 REGEXFIND('( D/B/$)',BusNAME_ORG) =>   STD.Str.FindReplace(BusNAME_ORG,' D/B/', ' DBA'), 
											 REGEXFIND('( D/$)',BusNAME_ORG) =>   STD.Str.FindReplace(BusNAME_ORG,' D/', ' DBA'), 
											 REGEXFIND('(/D$)',BusNAME_ORG) =>   STD.Str.FindReplace(BusNAME_ORG,'/D', ' DBA'), 
											 STD.Str.Find(BusNAME_ORG,'(DBA)',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'(DBA)',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'/DBA/',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'/DBA/',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'/ DBA/',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'/ DBA/',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'/DBA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'/DBA',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'D/BA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'D/BA',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'/D/B/A/',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'/D/B/A/',' DBA '),
											 STD.Str.Find(BusNAME_ORG,' D/B/A/',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,' D/B/A/',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'D/B/A',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'D/B/A',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'DBA/',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'DBA/',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'.DBA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'.DBA',' DBA '),
											 STD.Str.Find(BusNAME_ORG,',DBA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,',DBA',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'INCDBA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'INCDBA',' INC DBA '),
											 STD.Str.Find(BusNAME_ORG,'LLCDBA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'LLCDBA',' LLC DBA '),
											 STD.Str.Find(BusNAME_ORG,'LLC-DBA',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'LLC-DBA',' LLC DBA '),
											 STD.Str.Find(BusNAME_ORG,'D.B.A',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'D.B.A',' DBA '),
											 STD.Str.Find(BusNAME_ORG,'/A/K/A',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'/A/K/A',' A/K/A '),
											 STD.Str.Find(BusNAME_ORG,'/AKA/',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'/AKA/',' A/K/A '),
											 STD.Str.Find(BusNAME_ORG,'RE/MAX',1) > 0 => STD.Str.FindReplace(BusNAME_ORG,'RE/MAX','RE MAX'),
											 											 																	BusNAME_ORG);

		prepNAME_Contact := MAP(STD.Str.Find(TrimNAME_CONTACT,'T/A',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'T/A',' DBA '),
		                   REGEXFIND('( DB$|/DB$)',TrimNAME_CONTACT) =>   STD.Str.FindReplace(TrimNAME_CONTACT,'DB', ' DBA'), 
											 REGEXFIND('( D/B$)',TrimNAME_CONTACT) =>   STD.Str.FindReplace(TrimNAME_CONTACT,' D/B', ' DBA'), 
											 REGEXFIND('( D/B/$)',TrimNAME_CONTACT) =>   STD.Str.FindReplace(TrimNAME_CONTACT,' D/B/', ' DBA'), 
											 REGEXFIND('( D/$)',TrimNAME_CONTACT) =>   STD.Str.FindReplace(TrimNAME_CONTACT,' D/', ' DBA'), 
											 REGEXFIND('(/D$)',TrimNAME_CONTACT) =>   STD.Str.FindReplace(TrimNAME_CONTACT,'/D', ' DBA'), 
											 STD.Str.Find(TrimNAME_CONTACT,'(DBA)',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'(DBA)',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'/DBA/',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'/DBA/',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'/ DBA/',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'/ DBA/',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'/DBA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'/DBA',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'D/BA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'D/BA',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'/D/B/A/',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'/D/B/A/',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,' D/B/A/',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,' D/B/A/',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'D/B/A',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'D/B/A',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'DBA/',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'DBA/',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'.DBA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'.DBA',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,',DBA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,',DBA',' DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'INCDBA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'INCDBA',' INC DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'LLCDBA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'LLCDBA',' LLC DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'LLC-DBA',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'LLC-DBA',' LLC DBA '),
											 STD.Str.Find(TrimNAME_CONTACT,'/A/K/A',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'/A/K/A',' A/K/A '),
											 STD.Str.Find(TrimNAME_CONTACT,'/AKA/',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'/AKA/',' A/K/A '),
											 STD.Str.Find(TrimNAME_CONTACT,'RE/MAX',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'RE/MAX','RE MAX'),
											 STD.Str.Find(TrimNAME_CONTACT,'D.B.A.',1) > 0 => STD.Str.FindReplace(TrimNAME_CONTACT,'D.B.A.','DBA'),
											 											 																	TrimNAME_CONTACT);


    // Standardized Firm Names																																							
    std_CONTACT := MAP(REGEXFIND('( LL$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,' LL', ' LLC'),
											 REGEXFIND('( L$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,' L', ' LLC'),
											 REGEXFIND('( L.L.$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,' L.L.', ' LLC'),
											 REGEXFIND('(,L$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,',L', ' LLC'),
											 REGEXFIND('(,LL$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,',LL', ' LLC'),
											 REGEXFIND('( I$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,' I', ' INC'),
											 REGEXFIND('(,I$)',prepNAME_Contact) =>   STD.Str.FindReplace(prepNAME_Contact,',I', ' INC'),
											 
														prepNAME_Contact);
		
		tmpNAME_ORG	:= STD.Str.CleanSpaces(TRIM(prepNAME_ORG));															
		rmvDBA_ORG	:= IF(REGEXFIND('( DBA | A/K/A | DBA$|/DBA$|/ DBA$)',tmpNAME_ORG), 
												Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_ORG),tmpNAME_ORG);
																		
		// Blank Out Contact field if matches ORG_NAME field																
    tmpNAME_CONTACT	:= STD.Str.CleanSpaces(TRIM(std_CONTACT));
		stripORG := STD.Str.CleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(tmpNAME_ORG));
		stripContact := STD.Str.CleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(tmpNAME_CONTACT));
		
		blankOut_Contact := IF(tmpNAME_CONTACT != '' AND stripORG[1..20] != stripContact[1..20], tmpNAME_CONTACT,
														IF(tmpNAME_CONTACT != '' AND LENGTH(tmpNAME_CONTACT) = 1,'',''));
		rmvDBA_CONTACT	:= IF(REGEXFIND('( DBA | A/K/A | DBA$|/DBA$| / DBA$|^DBA )',STD.Str.CleanSpaces(blankOut_Contact)), 
												Prof_License_Mari.mod_clean_name_addr.GetCorpName(blankOut_Contact),blankOut_Contact);
    strip_end_dash  := IF(REGEXFIND('(/$)', TRIM(rmvDBA_CONTACT)),StringLib.StringFilterOut(rmvDBA_CONTACT,'/'),rmvDBA_CONTACT);												
    strip_dba       := IF(REGEXFIND('DBA',strip_end_dash),REGEXREPLACE('DBA',strip_end_dash,''),strip_end_dash);
														
		fixDBA_ORG	:= STD.Str.FindReplace(rmvDBA_ORG,'DBA','');									
		StdNAME_ORG	:=  Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(fixDBA_ORG);
												
		fixORG_SUFX	:= MAP(STD.Str.Find(StdNAME_ORG,',L.L.C.',1) > 0 => STD.Str.FindReplace(StdNAME_ORG,',L.L.C',', L.L.C.'),
											 STD.Str.Find(StdNAME_ORG,'.L.L.C.',1) > 0 => STD.Str.FindReplace(StdNAME_ORG,'.L.L.C','. L.L.C.'),
											 STD.Str.Find(StdNAME_ORG,',LLC',1) > 0 => STD.Str.FindReplace(StdNAME_ORG,',LLC',', LLC'),
											 STD.Str.Find(StdNAME_ORG,'.LLC',1) > 0 => STD.Str.FindReplace(StdNAME_ORG,'.LLC','. LLC'),
											 STD.Str.Find(StdNAME_ORG,'.INC',1) > 0 => STD.Str.FindReplace(StdNAME_ORG,'.INC','. INC'),
											 STD.Str.Find(StdNAME_ORG,',INC',1) > 0 => STD.Str.FindReplace(StdNAME_ORG,',INC',', INC'),
																															StdNAME_ORG);
											 
		// Clean/Standarcized ORG_NAME									 
		CleanNAME_ORG	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',fixORG_SUFX) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(fixORG_SUFX),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(fixORG_SUFX,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(fixORG_SUFX,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(fixORG_SUFX),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(fixORG_SUFX,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(fixORG_SUFX,LEFT,RIGHT)) => fixORG_SUFX,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(fixORG_SUFX));
				
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'GR',CleanNAME_ORG,
																IF(SELF.TYPE_CD = 'MD',ConcatNAME_FULL,''));
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(fixORG_SUFX));
	  SELF.STORE_NBR		    := '';
		SELF.NAME_PREFX				:= '';
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(tempNick);
		SELF.BIRTH_DTE				:= '';
		SELF.GENDER						:= '';
		
		//Identifying DBA NAMES
		tmpNAME_DBA	:= IF(REGEXFIND('( DBA | A/K/A )',tmpNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNAME_ORG),
											IF(REGEXFIND(' AKA ',IndNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(IndNAME_ORG),
												IF(REGEXFIND('( DBA | A/K/A |^DBA|^D.B.A.)',prepNAME_Contact), Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_Contact),
																'')));
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		blankOut_DBA := IF(LENGTH(TRIM(CleanNAME_DBA)) < 2, '', CleanNAME_DBA);																						
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(blankOut_DBA);  
		SELF.NAME_DBA					:=  IF(REGEXFIND('(RE/MAX)', TRIM(cleanNAME_DBA)), CleanNAME_DBA,STD.Str.FindReplace(blankOut_DBA,'/',' '));
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(blankOut_DBA));; 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
	  
    //Strip Contact Name from Address Fields
		tmpAddrContact	:= MAP(REGEXFIND('(C/O |ATTN: |ATTN | DBA )',TrimAddress1)=>
																	Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
													REGEXFIND('%',TrimAddress1)=> STD.Str.FilterOut(TrimAddress1,'%'),
																												'');
		
		prepAddrContact := MAP(Prof_License_Mari.func_is_address(tmpAddrContact) => '',
												   STD.Str.Find(TRIM(tmpAddrContact),' ',1) = 0 => '',
													 REGEXFIND('(RESORT|ET AL)',tmpAddrContact) => '',
																					tmpAddrContact);
		
		ParseContact := IF(prepAddrContact != '' AND NOT Prof_License_Mari.func_is_company(prepAddrContact)
																							,Address.CleanPersonFML73(prepAddrContact)
																							,'');
	
		SELF.LICENSE_NBR_CONTACT 	:= '';											
		SELF.NAME_CONTACT_PREFX		:= '';
		SELF.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
		SELF.NAME_CONTACT_NICK		:= '';
		SELF.NAME_CONTACT_TTL			:= '';
		
		// Clean Office Names From Address & Contact
		addrOFFICE	:= MAP(tmpAddrContact != '' AND Prof_License_Mari.func_is_company(tmpAddrContact)=> tmpAddrContact,
												NOT REGEXFIND('[0-9]',TrimAddress1) AND NOT REGEXFIND('(N/A|C/O |%|ATTN:|SAME|INVALID)',TrimAddress1)
												AND Prof_License_Mari.func_is_company(TrimAddress1)	AND NOT REGEXFIND(AddrExceptions,TrimAddress1)
												AND TrimAddress1 != '' => TrimAddress1,
																						'');
		prepNAME_OFFICE := IF(STD.Str.Find(addrOFFICE,'REGISTRATION',1) > 0, '',addrOFFICE);
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_OFFICE);														
		CleanNAME_OFFICE:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
    
		SELF.NAME_OFFICE 			:= IF(TrimNAME_CONTACT != '', StringLib.StringFilterOut(strip_dba,'*'),
																					 StringLib.StringCleanSpaces(CleanNAME_OFFICE));	
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) OR REGEXFIND(CoPattern,SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
		
	//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.Original_Date != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.Original_Date),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPDT),'17530101');
		SELF.RENEWAL_DTE			:= '';
		SELF.ACTIVE_FLAG			:= '';
			
	//Populating MARI Name Fields
		SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_ORG_ORIG	  := TrimNAME_ORG;
		SELF.NAME_DBA_ORIG	  := ''; 
		SELF.NAME_MARI_ORG	  := IF(SELF.TYPE_CD = 'GR',STD.Str.CleanSpaces(STD.Str.FindReplace(fixORG_SUFX,'/',' ')),
																	SELF.NAME_OFFICE);
		SELF.NAME_MARI_DBA	  := STD.Str.CleanSpaces(StdNAME_DBA);
		SELF.PHN_MARI_1				:= STD.Str.CleanSpaces(pInput.Area_Code + pInput.Phone);
		
	//Filtering out Business Names from Address fields
		prepAddress1	:= MAP(REGEXFIND('(N/A|INVALID|MOVED  TO|SAME)',TrimAddress1) => '',
		                     NOT REGEXFIND('[0-9A-Za-z]',TrimAddress1)=>'',
												 addrOFFICE != '' => '',
										  	 REGEXFIND('(C/O |ATTN: |ATTN | DBA |%)',TrimAddress1)=>'',
												 REGEXFIND(CoPattern,TrimAddress1) => '',
												 Prof_License_Mari.func_is_Company(TrimAddress1) AND NOT Prof_License_Mari.func_is_Address(TrimAddress1) => '',
																			TrimAddress1);
		prepAddress2	:= MAP(REGEXFIND('(C/O |ATTN: |ATTN | DBA |%|GREENSPOON)',TrimAddress2)=> '',
		                     NOT REGEXFIND('[0-9A-Za-z]',TrimAddress2)=>'',
												 REGEXFIND(CoPattern,TrimAddress2) => '',
												 Prof_License_Mari.func_is_Company(TrimAddress2) AND NOT Prof_License_Mari.func_is_Address(TrimAddress2) => '',
												 TrimAddress2);
																													
																
		tmpAddress1	:= MAP(REGEXFIND('(ROAD|LANE|DRIVE|STREET)',prepAddress2)
												AND NOT StringLib.stringfind(TRIM(prepAddress2),' ',1) > 0 =>
															StringLib.StringCleanSpaces(prepAddress1 + ' '+ prepAddress2),
												prepAddress1 != '' => prepAddress1,
																		prepAddress2);
																							
		tmpAddress2	:= MAP(REGEXFIND('(ROAD|LANE|DRIVE|STREET)',prepAddress2)
												AND NOT StringLib.stringfind(TRIM(prepAddress2),' ',1) > 0 => '',
											 prepAddress1 = ''=> '',
																		prepAddress2);
																
		flipAddress1	:= MAP(NOT REGEXFIND('[0-9]',tmpAddress1) AND REGEXFIND('^([A-Za-z ]+)([\\#\\-0-9 \\#\\-]+)',tmpAddress2)
																	=> tmpAddress1,
												 NOT REGEXFIND('[0-9]',tmpAddress1) AND Prof_License_Mari.func_is_address(tmpAddress2)
														and tmpAddress2 != '' => tmpAddress2,
												 REGEXFIND('^([A-Za-z ]+)([\\#\\-0-9 \\#\\-]+)',tmpAddress1) 
														AND NOT REGEXFIND('^([A-Za-z ]+)([\\#\\-0-9 \\#\\-]+)',tmpAddress2) 
														and tmpAddress2 != '' => tmpAddress2,
												 REGEXFIND('^([\\#0-9]+)',tmpAddress1) 
														AND NOT STD.Str.Find(TRIM(tmpAddress1),' ',1) > 0
														and Prof_License_Mari.func_is_address(tmpAddress2) => tmpAddress2,
																									tmpAddress1);
													
											
		flipAddress2	:= MAP(NOT REGEXFIND('[0-9]',tmpAddress1) AND REGEXFIND('^([A-Za-z ]+)([\\#\\-0-9 \\#\\-]+)',tmpAddress2)
																	=> tmpAddress2,
												 NOT REGEXFIND('[0-9]',tmpAddress1) AND Prof_License_Mari.func_is_address(tmpAddress2)
														AND tmpAddress2 != ''=> tmpAddress1,
												 REGEXFIND('^([A-Za-z ]+)([\\#\\-0-9 \\#\\-]+)',tmpAddress1) 
														AND NOT REGEXFIND('^([A-Za-z ]+)([\\#\\-0-9 \\#\\-]+)',tmpAddress2) 
														AND tmpAddress2 != '' => tmpAddress1,
												 REGEXFIND('^([\\#0-9]+)',tmpAddress1) 
																AND NOT STD.Str.Find(TRIM(tmpAddress1),' ',1) > 0
																AND Prof_License_Mari.func_is_address(tmpAddress2) => tmpAddress1,
																							tmpAddress2);
	
	  SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimCity + pInput.ZIP) != '','B','');	
		SELF.ADDR_ADDR1_1			:= flipAddress1;
		SELF.ADDR_ADDR2_1			:= flipAddress2; 
		SELF.ADDR_ADDR3_1			:= '';
		SELF.ADDR_ADDR4_1			:= '';
		SELF.ADDR_CITY_1			:= TrimCity;
		SELF.ADDR_STATE_1			:= ut.fnTrim2Upper(pInput.STATE_1);
		SELF.ADDR_ZIP5_1			:= IF(pInput.ZIP = '00000','',pInput.ZIP);
		SELF.ADDR_ZIP4_1			:= '';
		SELF.ADDR_CNTY_1			:= ut.fnTrim2Upper(pInput.County);
		SELF.PHN_PHONE_1			:= SELF.PHN_MARI_1;
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		SELF.EMAIL						:= ut.fnTrim2Upper(pInput.Email);
		
	  
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		

		SELF.MLTRECKEY			:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT) + ','
																			+TRIM(SELF.NAME_DBA,LEFT,RIGHT) + ','
																			+ut.fnTrim2Upper(pInput.Address1_1) + ','
																			+ut.fnTrim2Upper(pInput.Address2_1) + ','
																			+ut.fnTrim2Upper(pInput.CITY_1) + ','
																			+ut.fnTrim2Upper(pInput.ZIP));
																								   
		SELF.PCMC_SLPK			:= 0;
		SELF.PROVNOTE_1			:= '';
		SELF.PROVNOTE_2			:= '';
		SELF.PROVNOTE_3			:= '';
		SELF.ADDL_LICENSE_SPEC  := CASE(pInput.Pro_Code,
		                                '1501' => 'REAL ESTATE APPRAISER',	
																		'1503' => 'REAL ESTATE APPRAISER TEMPORARY PRACTICE',
																		'2501' => 'REAL ESTATE AGENT',
																		'2502' => 'REAL ESTATE FIRM',
																		'2507' => 'REAL ESTATE ACQUISITION AGENT REGISTRATION',
																		'2509' => 'REAL ESTATE ACQUISITION AGENT LICENSE','');
																		
		SELF := [];	
		   
END;
inFileLic	:= PROJECT(clnGoodNameRec,xformToCommon(LEFT));


//Populate STD_STATUS_CD field via translation on statu field
Prof_License_Mari.layout_base_in 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
	SELF.STD_LICENSE_STATUS :=  STD.Str.touppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
	SELF := L;
END;

ds_map_status_trans := JOIN(inFileLic, cmvTransLkp,
						TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_STATUS' ,
						trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);
						
// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layout_base_in 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := STD.Str.touppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTransLkp,
						TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_TYPE' 
						AND RIGHT.dm_name1 = 'PROFCODE',
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		


//***IN to CO Real Estate License Records
company_only_lookup := ds_map_lic_trans(affil_type_cd = 'CO' AND license_nbr_contact != '');
Prof_License_Mari.layout_base_in  	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
						LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR
						AND LEFT.LICENSE_NBR != '',
						assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOCAL);	


// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layout_base_in xTransToBase(ds_map_affil L) := transform
	SELF.NAME_ORG				:= STD.Str.CleanSpaces(STD.Str.FindReplace(L.NAME_ORG,'/',' '));
	SELF.NAME_ORG_SUFX 	:= IF(STD.Str.Find(L.NAME_ORG_SUFX,'/',1) > 0,STD.Str.FindReplace(L.NAME_ORG_SUFX,'/',' '), 
															Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.NAME_ORG_SUFX));
	SELF.NAME_DBA				:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.NAME_DBA);
	strip_MARI_ORG := STD.Str.FindReplace(L.NAME_MARI_ORG,'/',' ');
	SELF.NAME_MARI_ORG	:= STD.Str.CleanSpaces(STD.Str.FindReplace(strip_MARI_ORG,'%',' '));
	SELF := L;
END;

ds_map_base := PROJECT(ds_map_affil, xTransToBase(LEFT));

// Adding to Superfile
d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license', 'using', 'used');
	
	//Add notify_missing_codes to email the user if there is missing codes
notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion, Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion, Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	
RETURN SEQUENTIAL(oRel, OCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

// return sequential(d_final,add_super); 
END;


