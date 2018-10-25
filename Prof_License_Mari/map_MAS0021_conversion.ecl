/* Converting Massachussets Real Estate Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, STD, lib_stringlib;

EXPORT map_MAS0021_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt: Prof License MARI - MAS0021 ' + pVersion);

	code 								:= 'MAS0021';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	Cmvtranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	OCmv								:= OUTPUT(CHOOSEN(Cmvtranslation,500));
	C_O_Ind 						:= '(C/O |ATTN:|ATTN|ATTENTION:|ATT:)';
	COMPANY_IND					:= '( CO\\.| INC\\.|^INC[\\.]?$| INC$|^INC$| INCORP|CORPORATION|^CORP| CORP$|L\\.L\\.C|'+
	                       'L\\.P\\.|^LLC$| LLC$|LLLC|^LLP$|^LLP | LLP$|^LTD$|^LTD | LTD$|P\\.C\\.| & )';
	DBA_Ind 						:= '(^DBA | DBA | DBA|D/B/A|A/K/A|^AKA| AKA )';
  SufxPattern         := '(^JR |^SR |^II |^III |^IV |^VI | JR. | JR| SR. | SR| III | II | IV | VI | JR$| SR$| III$| II$| IV$| VI$)';	
	
	AddrExceptions 			:= '(PLAZA| PLZ|^BLDG |^BLGD | BLDG|BLDING|BUILDING | BLD |APARTMENT|ONE | AVE |AVENUE| AV |^AVE | TOWER| BLVD|GENERAL DELIVERY| ESTS|'+
												'ROAD|^R D | AND MAIN\\>| & MAIN\\>|^THREE |^THIRD |THOUSAND|^FOUR|^SIX |^SIXTH |^ELEVENTH|^FIFTH|^FIVE|^NINTH |^EIGHTH |^SEVENTH |^TENTH |^TWELFTH|^TWELVETH|RIVERWALK|'+
												' ALLEY|SECOND|FLOOR|PAVILION|PAVILLION| RD|TOWN$|LEVEL|LOWR LL|CREEK|ROUTE|^RTE|CENTRE| CTR\\>| CT\\>| DR\\>| PARK|DRIVE| SQUARE| SQ\\>| WAY|LOCATION|^UNIT |UNIT |'+
												'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND| MALL| VILLA$|P M B|PMB | LODGE|^BOOTH |ACRES|AIRPORT|'+
												'UPPER|TRACE|#|LANE|LAGOONS|PENTHOUSE |POST OFFICE|^POST| STS\\>| AVES\\>| ST\\>|STREET|FRONT|FAIR GROUNDS|FAIRGROUNDS|BETWEEN|'+
												'APT.|APT |APT[.] |APT$|APARTMENT |P O |PO |POB |PO DRAWER|P O DRAWER|^DRAWER |BOX |BOX|ROOM |^RT | RT |HIGHWAY|HWY|RIDGE| PL\\>|'+
												'EXPRESSWAY| STE |^STE |^SUIT |STE |SUITE|SU | PKWY|CROSSING|CORNER OF|& MAINLAND| AT MAIN|MAIN AND|MAIN &|^HCR|MAIL STOP| LN\\>| MANOR\\>| MNR\\>| TPKE\\>|'+
												'METROPLEX|PARKWAY|^COURT |^PH |^RM | RM\\>|^ROOM |LBBY|^SPC |BSMT|OFC|TRLR|^LOT | LOT\\>|^FL | CENTER WEST| TERRACE\\>| TRAIL\\>| TR\\>| TRL\\>|'+
												'STUDIO|MARKETPLACE| COMMONS\\>|CORPORATE CENTER|COMMERCE CENTER|EXECUTIVE CENTER|PROFESSIONAL CEN|SHOPPING|SHOPPING CTR|CITY CENTER|SUBDIVISION|'+
												'SHOPPING CENTER|BUSINESS OFFICE|SHOP COMPLEX|NAVAL STATION|NAVAL AIR STATION|AIR FORCE BASE|PROFESSIONAL COMPLEX|VETERANS HOME|MARINA|RESIDENTIAL|'+
												'METROPOLITAN|^LAKE | LAKE\\>| TWP|CONDO|COTTAGE|RESORT|HALF DAY|FREEWAY| CIRCLE\\>| CIR\\>|HARBOR|^NORTHERN|^NORTH| COVE\\>|ARENA|CAFE|AISLE|' +
												'PATH\\>|BALLON HALL| FLR$| FL$|[0-9]+[\\-]+[0-9]+|^FL-[0-9]+|[0-9]+ F$|INC\\.$|WALDEN COUNTY)'; 
	
	RemovePattern	      := '(^INC D/B/A.*$|^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					               '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					               '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					               '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					               '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ESTATE$|^REAL EST$|^.* GROUP$|' +
					               '^LLC$|^NEW ENGLAND$|^DBA .*$|^AL ESTATE$|^D/B/A.*$|^COMPANY$|INVESTMENT BROKERAGE|REALTY ANDOVER|' +
					               '^PROMOTIONS$|^PROPERTIES$|^PROPERTIES ADVANTAGE$|^PROPERTY EVENTS$|^REALTY$|^REALTORS$|^REALTS$|^REALTORS/.*$|' +
					               '^REALTY/|^VENTURES$|^TES$|^SPECIALISTS$|^SOTHEBY\'S INTERNATIONAL|^.* REEAL ESTATE$|^REAL ESTATE$|' +
					               '^REALTY-FRANKLIN$|^REALTY TEAM$|^REALTY NORTH CENTRAL$|^REALTY GREAT WORCESTER$|^DUPL\\.LIC\\..*$|' +
					               '^REALTY [A-Z ]$|^L ESTATE .*$|^FRANKLIN STREET ASSOC$|^DE$|' +
					               '^.* BUILDING$|^.* LAKE RESORT$|^NRMANDY HESPERUS$|JULIE KRASKER|D/B/A .*$|^INC$|^INC\\.$|^KNOLLWIND$|^HAMMOND RESIDENTIAL$|' +
					               '^HOME BUILDER$|^LANDVEST$|^GRUBB.*ELLIS\\.$|^GROUP$|^GENERAL DELIVERY$|^GARDENS$|^[A-Z ] ASSOC$|' +
					               '^F/K/A.*$|^ALLOWANCE PROJECT$|^ET$|^ESTATE ASSOCIATES$|^DISCOUNTERS$|^WALDEN COUNTY$|^COM$|^COMMONWEALTH$|' +
					               '^CHOICE$|^CENTER$|^CAPE COD$|^C$|^BROKER OF RECORD$|^INACTIVE.*$|BISHOPS RISE$|BERKSHIRES|^ASSOCIATES$|^AND ASSOCIATES$|' +
					               '^ANDERSON .* KREIGER$|^ADVISORS$|^OFF\\. COUNSEL$|^BOSTON WEST$' +
					               ')';
	
	//Move input file from sprayed to using
	inFile	:= Prof_License_Mari.file_MAS0021;
	oRle		:= OUTPUT(inFile);
	oInFile := OUTPUT(COUNT(inFile));

	//Filtering out BAD RECORDS
	NoBlankRec	  := inFile(TRIM(LAST_NAME,LEFT,RIGHT)+TRIM(ORGNAME,LEFT,RIGHT) <> ''); 
	GoodNameRec	 	:= NoBlankRec(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));
	GoodAddrRec	 	:= GoodNameRec(NOT REGEXFIND(Prof_License_Mari.filters.BadAddrFilter, StringLib.StringToUpperCase(ADDRESS1_1)));
	GoodFilterRec	:= GoodAddrRec(NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUpperCase(SLNUM)));
  oGoodFilterRec:= OUTPUT(COUNT(GoodFilterRec));	
	ut.CleanFields(GoodFilterRec,clnGoodFilterRec);
	
	//Map Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(layout_MAS0021.common pInput) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	  := src_st;
			
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.ORGNAME);
		TrimNAME_Last				 	:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
    TempNAME_Last         := IF(REGEXFIND(SufxPattern,TrimName_Last),TRIM(REGEXREPLACE(SufxPattern,TrimName_Last,''),LEFT,RIGHT),
		                             TrimName_Last);			
		TrimNAME_First				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TempNAME_First        := IF(REGEXFIND(SufxPattern,TrimName_First),TRIM(REGEXREPLACE(SufxPattern,TrimName_First,''),LEFT,RIGHT),
		                             TrimName_First);																
		TrimNAME_Mid					:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_Sufx					:= ut.CleanSpacesAndUpper(pInput.NAME_SUFX);
		TmpSufx               := MAP(TrimName_SUFX != '' => TrimNAME_SUFX,
		                             REGEXFIND(SufxPattern,TrimName_First) => TRIM(REGEXFIND(SufxPattern,TrimName_First,0),LEFT,RIGHT),
																 REGEXFIND(SufxPattern,TrimName_Last) => TRIM(REGEXFIND(SufxPattern,TrimName_Last,0),LEFT,RIGHT),
																 '');				
		TrimAddress1	 				:= REGEXREPLACE('NULL',ut.CleanSpacesAndUpper(pInput.ADDRESS1_1),'');
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY_1);
		TrimLicType						:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);			
		TrimTypeClass					:= ut.CleanSpacesAndUpper(pInput.TYPE_CLASS);

		TrimStatus	 					:= ut.CleanSpacesAndUpper(pInput.LICSTAT_DS);
		TrimStatusDesc  			:= ut.CleanSpacesAndUpper(pInput.Filler);
    clnNull_Status				:= REGEXREPLACE('[\\x00-\\x1F]', TrimStatus, '');

		TempLicenseNbr        := IF(STD.Str.Find(pInput.SLNUM,'-',1)>0,TRIM(pInput.SLNUM[1..STD.Str.Find(pInput.SLNUM, '-', 1) -1], right),pInput.SLNUM);
    reformat_LicenseNbr   := INTFORMAT((INTEGER)tempLicenseNbr,9,1);
		goodLicenseNbr        := (STRING) reformat_LicenseNbr;
		SELF.LICENSE_NBR      := IF(goodLicenseNbr <> '000000000',goodLicenseNbr,'NR');	
		TmpLicenseType        := pInput.SLNUM[STD.Str.Find(pInput.SLNUM, '-', 1)..];
		
		SELF.RAW_LICENSE_TYPE	:= StringLib.StringCleanSpaces(STD.Str.FindReplace(TmpLicenseType,'-',''));
		SELF.STD_LICENSE_TYPE   := SELF.RAW_LICENSE_TYPE;
		SELF.RAW_LICENSE_STATUS := MAP(TRIM(TrimStatus,LEFT,RIGHT) = 'CURRENT. THE LICENSE IS WITHIN ITS RENEWAL PERIOD' =>'CURRENT.  THE LICENSE IS WITHIN ITS RENEWAL PERIOD',
                                   STD.Str.Find(TrimStatus,'INACTIVE REAL ESTATE BROKER OR SALESPERSON. INACTIVE LICENSE RENEWAL',1)>0 => 'INACTIVE REAL ESTATE BROKER OR SALESPERSON.  INACTIVE LICENSE RENEWAL',
																	 TRIM(TrimStatus,LEFT,RIGHT) = 'INACTIVE REAL ESTATE BROKER OR SALESPERSON. INACTIVE LICENSE RENEWAL PERIOD' => 'INACTIVE REAL ESTATE BROKER OR SALESPERSON.  INACTIVE LICENSE RENEWAL',
                                   TRIM(TrimStatus,LEFT,RIGHT) = 'INACTIVE REAL ESTATE BROKER OR SALESPERSON. INACTIVE LICENSE TO BE PRINTED.' => 'INACTIVE REAL ESTATE BROKER OR SALESPERSON.  INACTIVE LICENSE TO BE PR',        
																	 TRIM(TrimStatus,LEFT,RIGHT) = 'CURRENT. LICENSE SCHEDULED TO BE PRINTED' =>'CURRENT.  LICENSE SCHEDULED TO BE PRINTED',
																	 TRIM(TrimStatus,LEFT,RIGHT) = 'CURRENT. RENEWAL APPLICATION BEING PROCESSED' =>'CURRENT.  RENEWAL APPLICATION BEING PROCESSED',
                                   TRIM(TrimStatus,LEFT,RIGHT) = 'CURRENT. ON ACTIVE MILITARY DUTY ' =>'CURRENT.  ON ACTIVE MILITARY DUTY ',
																	 TRIM(TrimStatus,LEFT,RIGHT));
																	 

		setType_CD 						:= IF(TrimLicType = 'RE' AND SELF.RAW_LICENSE_TYPE in ['REC','REPG','RELC','RELP','REPL','REPC','RERP','RESC'],'GR','MD');
		SELF.TYPE_CD					:= setType_CD;		
		//Some of the license type is too long and get truncated.
		//INACTIVE REAL ESTATE LICENSE R => INACTIVE REAL ESTATE LICENSE RENEWAL PERIOD    
		//INACTIVE REAL ESTATE LICENSE T => INACTIVE REAL ESTATE LICENSE TO BE PRINTED        
    SELF.PROVNOTE_3       := 'THE ORIGINAL LICENSE NUMBER:' + UT.CleanSpacesAndUpper(pInput.SLNUM);
		SELF.CURR_ISSUE_DTE		:= '17530101';	

		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUEDT != '',(STRING)Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUEDT),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '',(STRING)Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPDT),'17530101');
			
		//Prep Corporation Names
		ParsedNAME_Full	:= StringLib.StringCleanSpaces(TrimNAME_LAST + ' ' +TempNAME_First);
		prepNAME_FULL	  := MAP(StringLib.stringfind(TrimNAME_ORG,'/',1)> 0 AND NOT StringLib.stringfind(TrimNAME_ORG,'D/B/A',1)> 0 
																=> StringLib.StringFindReplace(TrimNAME_ORG,'/',' '),
												 setType_CD = 'GR' AND TrimAddress1 != '' AND StringLib.Stringfind(TrimAddress1,' ',1) = 0 => StringLib.StringCleanSpaces(TrimNAME_ORG+ ' '+ TrimAddress1),
												 REGEXFIND(dba_ind,TrimNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimNAME_ORG),
												 TrimNAME_ORG);
													
		StdNAME_FULL	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_FULL);
		CleanNAME_FULL := MAP(REGEXFIND('(([A-Za-z ]+)([\\(]THE[\\)]$)+)',StdNAME_FULL) => REGEXFIND('(([A-Za-z ]+)([\\(]THE[\\)]$)+)',StdNAME_FULL,2), 	
												 REGEXFIND('(.COM|.NET|.ORG)',StdNAME_FULL) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_FULL),
												 REGEXFIND('(%)',StdNAME_FULL) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_FULL,1),
												 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_FULL,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_FULL,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_FULL),
											
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_FULL,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_FULL,LEFT,RIGHT)) => StdNAME_FULL,
													REGEXFIND('^([A-Za-z \\.]*)(INC|THE)([A-Za-z ]*)',TRIM(StdNAME_FULL,LEFT,RIGHT))
																		AND NOT REGEXFIND('( INC$| THE$)',TRIM(StdNAME_FULL,LEFT,RIGHT))=> StdNAME_FULL,													
																								Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_FULL));		
	
		SELF.NAME_ORG_PREFX := StringLib.StringCleanSpaces(
		                          Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_FULL));

		SELF.NAME_FIRST			:= IF(SELF.type_cd = 'MD', TempNAME_First,'');
		SELF.NAME_MID				:= IF(SELF.type_cd = 'MD', TrimNAME_Mid,'');
		SELF.NAME_LAST			:= IF(SELF.type_cd = 'MD', TempNAME_Last,'');
		SELF.NAME_SUFX			:= IF(SELF.type_cd = 'MD', TmpSufx,'');
		SELF.NAME_ORG		    := MAP(SELF.TYPE_CD = 'MD' AND TrimName_Last + TrimName_First != '' => StringLib.StringCleanSpaces(StringLib.StringFilterOut(ParsedNAME_Full,',')),
		                           SELF.TYPE_CD = 'MD' AND TrimName_Last + TrimName_First = '' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdName_Full),
																						Prof_License_Mari.mod_clean_name_addr.cleanFName(StdName_Full));
		SELF.NAME_ORG_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_FULL));
		SELF.STORE_NBR		  := '';
		
		prepAddress1 := MAP(StringLib.StringFind(TrimAddress1,'DBA/',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'DBA/','DBA '),
												StringLib.StringFind(TrimAddress1,'D/B/A/',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'D/B/A/','D/B/A '),
												StringLib.StringFind(TrimAddress1,'D/B/A:',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'D/B/A:','D/B/A '),
												StringLib.StringFind(TrimAddress1,'D/B/A\'S ',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'D/B/A\'S ','D/B/A '),
												StringLib.StringFind(TrimAddress1,'D/B/ ',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'D/B/ ','D/B/A '),
												StringLib.StringFind(TrimAddress1,'D.B.A. ',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'D.B.A. ','D/B/A '),
												StringLib.StringFind(TrimAddress1,'DBA :',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'DBA :','DBA '),
												StringLib.StringFind(TrimAddress1,'DBA /',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'DBA /','DBA '),
												StringLib.StringFind(TrimAddress1,'F/K/A/',1) > 0 => StringLib.StringFindReplace(TrimAddress1,'F/K/A/','A/K/A '),
																									TrimAddress1);

		prepAddress2 := MAP(StringLib.StringFind(TrimAddress2,'DBA/',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'DBA/','DBA '),
												StringLib.StringFind(TrimAddress2,'D/B/A/',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'D/B/A/','D/B/A '),
												StringLib.StringFind(TrimAddress2,'D/B/A:',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'D/B/A:','D/B/A '),
												StringLib.StringFind(TrimAddress2,'D/B/A\'S ',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'D/B/A\'S ','D/B/A '),
												StringLib.StringFind(TrimAddress2,'D/B/ ',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'D/B/ ','D/B/A '),
												StringLib.StringFind(TrimAddress2,'D.B.A ',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'D.B.A. ','D/B/A '),
												StringLib.StringFind(TrimAddress2,'DBA :',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'DBA :','DBA '),
												StringLib.StringFind(TrimAddress2,'DBA /',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'DBA /','DBA '),
												StringLib.StringFind(TrimAddress2,'F/K/A/',1) > 0 => StringLib.StringFindReplace(TrimAddress2,'F/K/A/','A/K/A '),
																									TrimAddress2);
		// Business Logic for Populating Address Fields
		tmpAddr1		:= MAP(REGEXFIND(Prof_License_Mari.filters.BlankOutAddr,prepAddress1) => '',
										 Prof_License_Mari.BogusAddress(prepAddress1) => '',
										 LENGTH(prepAddress1) = 1 => '',
										 TrimNAME_ORG = TrimAddress1 => '',
										 REGEXFIND(DBA_Ind,prepAddress1) => '',
										 REGEXFIND(C_O_Ind,prepAddress1) AND NOT REGEXFIND('(C/O (35|PO |RKF.*$|.* CR$|.* STREET$)+)',prepAddress1)=> '',					
										 REGEXFIND(C_O_Ind,prepAddress1) AND REGEXFIND('(C/O (35|PO |RKF.*$|.* CR$|.* STREET$)+)',prepAddress1)=> REGEXFIND('^C/O (.*)$', prepAddress1,2),				
										 prepAddress2='INC' OR prepAddress2='LLC' OR prepAddress2='COMPANY' => '',
											 REGEXFIND('( LLC$| INC$| COMPANY$| CORP$)',prepAddress1) => '',
										 prepAddress1);
		tmpAddr2		:= MAP(REGEXFIND(Prof_License_Mari.filters.BlankOutAddr,prepAddress2) => '',
											 Prof_License_Mari.BogusAddress(prepAddress2) => '',
											 LENGTH(prepAddress2) = 1 => '',
											 TrimNAME_ORG = TrimAddress2 => '',
											 REGEXFIND(DBA_Ind,prepAddress1) AND NOT REGEXFIND('[0-9]',prepAddress2) => '',
											 REGEXFIND(DBA_Ind,prepAddress2) => '',
											 REGEXFIND(C_O_Ind,prepAddress2) AND NOT REGEXFIND('(C/O (PO |RKF.*$|.* CR$|.* STREET$)+)',prepAddress2)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepAddress2),
										   REGEXFIND(C_O_Ind,prepAddress2) AND REGEXFIND('(C/O (PO |RKF.*$|.* CR$|.* STREET$)+)',prepAddress2)=> REGEXFIND('^C/O (.*)$', prepAddress1,2),				
										   prepAddress2='INC' OR prepAddress2='LLC' OR prepAddress2='COMPANY' => '',
											 REGEXFIND('( LLC$| INC$| COMPANY$| CORP$)',prepAddress2) => '',
											 prepAddress2);
		tmpCity	:= MAP(Prof_License_Mari.BogusAddress(TrimCity) => '',
									 REGEXFIND(DBA_Ind,prepAddress2) 
														AND TRIM(TrimCity) IN ['ADVANTAGE','DOHERTY RELTRS','EXP BROKER','REAL ESTATE','REALTY','STREET ASSOCIA','REALTORS','ERCIAL REAL ES','L.L.P.','OF CAPE COD'] 
																=> ' ',TrimCity);																		
		getNAME_DBA := MAP(REGEXFIND(DBA_Ind,TrimNAME_ORG) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_ORG),
											 REGEXFIND(DBA_Ind,prepAddress1) AND TrimCity IN ['INC.','LLC','LTD.'] => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1 +' '+ TrimCity),
											 REGEXFIND(DBA_Ind,prepAddress1) AND NOT REGEXFIND('[0-9]',prepAddress2) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1 +' '+prepAddress2),
											 REGEXFIND(DBA_Ind,prepAddress1) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1),
											 REGEXFIND(DBA_Ind,prepAddress2) AND TRIM(TrimCity) IN ['ADVANTAGE','DOHERTY RELTRS','EXP BROKER','REAL ESTATE','REALTY','STREET ASSOCIA','REALTORS','ERCIAL REAL ES','L.L.P.','OF CAPE COD','ASSOCIATES'] 
																=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress2+' '+TrimCity),
											 REGEXFIND(DBA_Ind,prepAddress2) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress2),
													'');
		stripDBA    := IF(StringLib.stringfind(getNAME_DBA,'/',1)> 0 AND NOT StringLib.stringfind(getNAME_DBA,'D/B/A',1)> 0, 
																StringLib.StringFindReplace(getNAME_DBA,'/',' '),getNAME_DBA);												
		StdNAME_DBA	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(stripDBA);
		preCleanDBA	:= MAP(REGEXFIND('COUNTRYSI DE',	StdNAME_DBA) => REGEXREPLACE('COUNTRYSI DE',	StdNAME_DBA,'COUNTRYSIDE'),
		                         REGEXFIND('\\. COM', StdNAME_DBA) => REGEXREPLACE('\\. COM', StdNAME_DBA,'.COM'),
														 StdNAME_DBA); 
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(preCleanDBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(preCleanDBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(preCleanDBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(preCleanDBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(preCleanDBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => preCleanDBA,
																								Prof_License_Mari.mod_clean_name_addr.cleanFName(preCleanDBA));
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
		SELF.NAME_DBA 			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_DBA,'/',' '));

		SELF.NAME_DBA_SUFX	:= IF(SELF.TYPE_CD = 'GR',
																Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)),
																		'');
		SELF.DBA_FLAG		    := IF(SELF.NAME_DBA != '',1,0);
		
		// Logic to handle NAMES in ADDRESS fields 
		getNAME_OFFICE	:= MAP(REGEXFIND(C_O_Ind,TrimNAME_ORG) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_ORG),
												   REGEXFIND(C_O_Ind,prepAddress1) AND NOT REGEXFIND('(C/O (35|PO |RKF.*$|.* CR$|.* STREET$)+)',prepAddress1) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress1),
													 REGEXFIND(C_O_Ind,prepAddress2) AND NOT REGEXFIND('(C/O (35|PO |RKF.*$|.* CR$|.* STREET$)+)',prepAddress2) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddress2),
													 REGEXFIND('( INC$| LLC$| CORP$| COMPANY$)',prepAddress1) => prepAddress1,
													 REGEXFIND('(^INC$|^LLC$|^CORP$|^COMPANY$)',prepAddress2) => prepAddress1+' '+prepAddress2,
													 REGEXFIND('( INC$| LLC$| CORP$| COMPANY$)',prepAddress2) => prepAddress2,
														'');
		prepNAME_Off := IF(setType_CD = 'MD' AND getNAME_OFFICE = '' 
												AND NOT REGEXFIND('([0-9])',tmpAddr1) AND tmpAddr1 != ''
												AND Prof_License_Mari.func_is_company(tmpAddr1) AND NOT REGEXFIND(AddrExceptions,tmpAddr1),
															tmpAddr1,getNAME_OFFICE);
																							
		StdName_Off   				:= IF(REGEXFIND('(.COM|.NET|.ORG)',prepNAME_OFF), Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_OFF),
																Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_Off)));
		ClnName_Off						:= IF(REGEXFIND('(^DBA |^D/B/A |^D/B/A:|^D/B/A/)',StdName_Off),
		                            '', StdName_Off);
		ClnNameOffice2				:= MAP(REGEXFIND('106 .* DR',ClnName_Off) => '',
		                             REGEXFIND('STREET$| ST$|ROAD$| RD$|DRIVE$| DR$|',TRIM(ClnName_Off)) => '',
		                             REGEXFIND(' STE 100',ClnName_Off) => REGEXREPLACE(' STE 100',ClnName_Off,''),
																 ClnName_Off);
		tmpNAME_OFFICE				:= StringLib.StringCleanSpaces(
		                            IF(SELF.type_cd = 'MD' AND TrimNAME_ORG != '' AND NOT REGEXFIND(dba_ind,TrimNAME_ORG)
																 	 AND NOT REGEXFIND(c_o_ind,TrimNAME_ORG),TrimNAME_ORG,ClnNameOffice2)); 														 
		SELF.NAME_OFFICE	    := MAP(tmpNAME_OFFICE = '.'=>'',
	                        	     Prof_License_Mari.func_is_address(tmpNAME_OFFICE) = TRUE => '',															 
		                             TRIM(tmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(tmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																 TRIM(tmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(tmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG_PREFX + SELF.NAME_ORG + SELF.NAME_ORG_SUFX,ALL) => '',
																 tmpNAME_OFFICE);
		SELF.OFFICE_PARSE	    := MAP(SELF.NAME_OFFICE != ''  
																 AND (Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)
																 OR REGEXFIND('(CORP| CO$)',SELF.NAME_OFFICE)) =>'GR',
																 SELF.NAME_OFFICE != ''  AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'MD',
																														'');

							 
		//Populating MARI Name Fields
		SELF.NAME_FORMAT		:= IF(SELF.TYPE_CD = 'MD','L','F');
		fmtNAME_ORG					:= StringLib.StringCleanSpaces(TrimNAME_LAST+
		                                                      IF(TmpSufx<>'',' '+TmpSufx+', ',', ') +
																													TempNAME_First+' '+TrimNAME_MID);
		SELF.NAME_ORG_ORIG		:= IF(SELF.type_cd = 'GR', TrimNAME_ORG, fmtNAME_ORG);
		SELF.NAME_DBA_ORIG		:= '';

		SELF.NAME_MARI_ORG		:= IF(SELF.type_cd = 'GR',StdNAME_FULL,SELF.NAME_OFFICE);
		SELF.NAME_MARI_DBA		:= StdNAME_DBA;													
															
		getAddr1 							:= IF(setType_CD = 'MD' AND getNAME_OFFICE = '' AND NOT REGEXFIND('([0-9])',tmpAddr1) AND tmpAddr1 != ''
																AND Prof_License_Mari.func_is_company(tmpAddr1) AND NOT REGEXFIND(AddrExceptions,tmpAddr1),'',
																IF(setType_CD = 'GR' AND TrimAddress1 != '' AND StringLib.Stringfind(TrimAddress1,' ',1) = 0,'',
																	 tmpAddr1));
		SELF.ADDR_BUS_IND			:= IF(TRIM(getAddr1 + tmpAddr2 + TrimCity + pInput.ZIPCODE) != '','B','');

		//Use address cleaner to clean address
		trimState							:= ut.CleanSpacesAndUpper(pInput.STATE_1);
		tmpZip	            	:= MAP(LENGTH(TRIM(pInput.ZIPCODE))=3 => '00'+TRIM(pInput.ZIPCODE),
																 LENGTH(TRIM(pInput.ZIPCODE))=4 => '0'+TRIM(pInput.ZIPCODE),
																 TRIM(pInput.ZIPCODE));
  		
	  //Extract company name
		trmAddress1						:= IF(REGEXFIND('(C/O (35|PO |RKF.*$|.* CR$|.* STREET$|.* DR$)+)', TrimAddress1),REGEXREPLACE('(C/O )',TrimAddress1,''),TrimAddress1);
		trmAddress2						:= IF(REGEXFIND('C/O GALAXY DEV STE 100',TrimAddress2),'C/O GALAXY DEV',TrimAddress2);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trmAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trmAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2);
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+trimState+' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address

	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '' => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
		                             tmpADDR_ADDR1_1='' => tmpADDR_ADDR2_1,
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact != '' => '',
		                             tmpADDR_ADDR1_1='' => '',
		                             StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;

				
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																	 SELF.TYPE_CD = 'GR' => 'CO',
																		'');
				
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK         :=  HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																		+TRIM(TrimAddress1,LEFT,RIGHT)
																		+TRIM(TrimAddress2,LEFT,RIGHT)
																		+TRIM(pInput.ZIPCODE,LEFT,RIGHT));
																				 
		SELF.PCMC_SLPK		:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(clnGoodFilterRec,xformToCommon(LEFT));
										
	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layouts.base trans_lic_status(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	END;

	ds_map_stat_trans := JOIN(inFileLic, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
 	Prof_License_Mari.layouts.base trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
   		SELF.STD_PROF_CD := R.DM_VALUE1;
   		SELF := L;
   	END;
   
   	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
   							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
   							AND RIGHT.fld_name='LIC_TYPE' 
   							AND RIGHT.dm_name1 = 'PROFCODE',
   							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
   																		

	d_final := OUTPUT(ds_map_lic_trans,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));

	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using', 'used');
	                        );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL( OCmv, oRle,oInFile,oGoodFilterRec,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;
		