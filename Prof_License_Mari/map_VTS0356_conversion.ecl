IMPORT ut, Prof_License_Mari, lib_stringlib, Lib_FileServices, Address, Std, NID;

EXPORT  map_VTS0356_conversion(STRING pVersion) := FUNCTION
#workunit('name','Prof License MARI- VTS0356 ' + pVersion);
	
code 		:= 'VTS0356';  	
src_cd	:= 'S0356';
license_state := 'VT';


inFile		:= Prof_License_Mari.file_VTS0356;
ut.CleanFields(inFile,ClnFile);
OFile := OUTPUT(Clnfile);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = src_cd); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
OCmvLkp := OUTPUT(CHOOSEN(cmvTransLkp,200));

//Filtering out BAD RECORDS
FilterTestRecs := ClnFile(TRIM(NAME_LAST) <> 'TESTING' OR NOT Std.Str.Find(NAME_BUSINESS, 'TESTING', 1) = 0); 
NonBlankName 	 := FilterTestRecs(TRIM(NAME_LAST,LEFT,RIGHT)+TRIM(NAME_FIRST,LEFT,RIGHT)+TRIM(NAME_BUSINESS,LEFT,RIGHT) <> ''); 
GoodRecs       := DEDUP(NonBlankName,ALL,RECORD);

NameFormat  := '^([a-zA-Z]+([\'\\-][a-zA-Z ])?,[ ](([A-Za-z\\.]+)[ ][A-Za-z\\.]{1})*)';
AddressIdent:= '^(([0-9]\\d{1,6} [A-Za-z ]+)+)|^((RD|RR)\\x20*\\d+){1,6}$';

business_exempt := '(^ONE |TWO |THREE |FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|TERRACE|PLAZZA|GENERAL DELIVERY| AT |FARM| MALL|'+
										 'MARKETPLACE|CORNERS| LAKE|FPOAA|^USS|RESORT|AREA|LODGE|VILLAGE| INN|BLDG|ROAD|CORNER OF|STREETS)';
										 
										 
BranchIdent	:= '(BR OFF$| BRANCH|BRCH|INCOFFICE| BRANC| BRAN$| BRA$| BR$)';
BusExceptions := '(CENTURY 21|BUILDING INSIGHT LLC|RE/MAX|BUILDING CO.|CAPTIAL |KERSTEN| FOREST SERVICE |UNITED |SVCS|APPRAISAL|'+
										'BROKER|REAL ESTATE|REALTY|PIERRE|PIERCE|ASSOC|IRELAND| CORP| LLC$| INC.$| INC$|\\;|STOCKING| LTD|REAL ESTAE|'+
										'MANAGEMENT|SERVICE|PROPERT|GROUP|COMPANY|INCORPORATE|AGENCY|ENTERPRISE|PARTNER|BKRS|REALTOR|^BOARD)';

C_O_Ind := '(C/O |C/0 |ATTN:|ATTN|ATTENTION:|ATT:)';
DBA_Ind := '( DBA|D/B/A | D/B/A|/DBA | A/K/A | AKA |T/A | DBA )';
invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|TBD|NOT CURRENTLY)';
BrComnt	:= 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
INComnt	:= 'BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
Sufx_Pattern      := '( SR.| SR| JR.| JR| III| II| IV| VII| VI)';
CoPattern		  	:= '(^.* LLC[.]?$|^.* LLC\\.$|^.* INC[.]?$|^.* INC |^.* LTD|^.* COMPANY |^.* CORP[.]?$|^.* CORPPORATION$|^.*APPRAISAL[S]?$|' +
                      '^CO .*$|^C/O .*$|^C/0.*$|^ATTN.*$|^ATTENTION.*$|^ATT:.*$| DBA.*$|D/B/A.*$|/DBA .*$|A/K/A .*$| AKA .*$|T/A .*$|' +
											'^.* APPR\\.$|^.* SERVICE[S]?$|^.* GROUP$|^.* APPRAISAL .*$|^.* FINANCIAL$|^.* BRANCH OFFICE$|^.*BROKER$|' +
											'^.* APPRAISAL SV[C|S]$|^.* LTD[.]$|^APPRAISAL.*$|^COLDWELL BANKER.*$|^BERKLEY & VELLER.*$|^.*ASSOCIATE[S]?$|' +
											'^.* REALTY |^.* REAL ESTATE.*$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES$|' +
											'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* AGENCY$|^.* PARTNER[S]?$|^.* PROPERTIES$|' +
											'^.* BUILDING$|^.* LAKE RESORT$|^.* AM$|^N/A$|^NONE$|^NO VALID .*$|^SAME$|^UNKNOWN$|^TBD$|^NOT CURRENTLY$|' +
											'^CAMPBELL\\, THOMAS$|^REDPATH\\, EDWARD LONG|^BOARD .*$|^CRAWFORD\\, ODETTE T[.]?|^.* RESOURCES$|^.*HOSPITALITY$|'+
											'^ROWE\\, FRED H.*$|^TD BANK.*$'+
											')';
									
RemovePattern	   := '(^.* LLC[.]?$|^.* LLC\\.$|^.* INC[.]?$|^.* INC |^.* COMPANY.*$|^.* CORP[.]?$|^.* CORPPORATION$|^.*APPRAISAL[S]?$|' +
                      '^CO .*$|^C/O .*$|^C/0.*$|^ATTN.*$|^ATTENTION.*$|^ATT:.*$| DBA.*$|D/B/A.*$|/DBA .*$|A/K/A .*$| AKA .*$|T/A .*$|' +
											'^.* APPR\\.$|^.* SERVICE[S]?$|^.* GROUP$|^.* APPRAISAL .*$|^.* FINANCIAL$|^.* BRANCH OFFICE$|^.*BROKER$|' +
											'^.* APPRAISAL SV[C|S]$|^.* LTD[.]$|^APPRAISAL.*$|^COLDWELL BANKER.*$|^BERKLEY & VELLER.*$|^.*ASSOCIATE[S]?$|' +
											'^.* REALTY$|^.* REAL ESTATE.*$|^.* REAL ESTATE CO$|^.* MANAGEMENT .*$|^.* MGMT$|^.* COMPANIES$|' +
											'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* AGENCY$|^.* PARTNER[S]?$|^.* PROPERTIES$|' +
											'^.* BUILDING$|^.* LAKE RESORT$|^.* AM$|^N/A$|^NONE$|^NO VALID .*$|^SAME$|^UNKNOWN$|^TBD$|^NOT CURRENTLY$|' +
											'^CAMPBELL\\, THOMAS$|^REDPATH\\, EDWARD LONG|^BOARD .*$|^CRAWFORD\\, ODETTE T[.]?|^.* RESOURCES$|^.*HOSPITALITY$|'+
											'^ROWE\\, FRED H.*$|^TD BANK.*$'+
											')';
Addr_Pattern     := '(STREET| ST$|ROAD|DRIVE|PO BOX| RD$| DR | APT| AVE| AVENUE|ROUTE|SUITE| STE |HWY|BLVD|BLDG|PKWY| PARKWAY$| LANE$|WAY$)';	
		
//VT Real Estate License to common MARIBASE layout
Prof_License_Mari.layouts.base		xformToCommon(Prof_License_Mari.layout_VTS0356.common pInput) 
    := 
	  TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= pVersion;
		SELF.DATE_LAST_SEEN		:= pVersion;
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	 := pInput.ln_filedate;
		SELF.CREATE_DTE			 	:= pVersion; 
		SELF.PROCESS_DATE			:= pVersion;
		SELF.LAST_UPD_DTE			:= pInput.ln_filedate;
		SELF.STAMP_DTE		  		:= pInput.ln_filedate; 
		SELF.STD_PROF_CD		   	:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		 := src_cd;
		SELF.STD_SOURCE_DESC  := '';
		
		TrimNAME_Bus		 := ut.CleanSpacesAndUpper(pInput.NAME_BUSINESS);
		TrimNAME_Last		:= ut.CleanSpacesAndUpper(pInput.NAME_LAST);
		TmpNAME_LAST	  := IF(REGEXFIND(Sufx_Pattern,TrimNAME_LAST),REGEXREPLACE(Sufx_Pattern,TrimNAME_LAST,''),TrimNAME_LAST);
		TmpSuffix_Last  := TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_LAST,0),LEFT,RIGHT);		
		TrimNAME_First	:= ut.CleanSpacesAndUpper(pInput.NAME_FIRST);
		TrimNAME_Mid    := ut.CleanSpacesAndUpper(pInput.NAME_MID);
		TrimAddress1	  := ut.CleanSpacesAndUpper(pInput.ADDR_ADDR1);
		TrimAddress2		:= ut.CleanSpacesAndUpper(pInput.ADDR_ADDR2);
		TrimLicType			:= ut.CleanSpacesAndUpper(pInput.LICENSE_NBR);			
		TrimStatus	 		:= ut.CleanSpacesAndUpper(pInput.STATUS);  
		TrimCity				  := ut.CleanSpacesAndUpper(pInput.ADDR_CITY);
		TrimOffice    := ut.CleanSpacesAndUpper(pInput.EMPLOYER);
		
		tmpLICTYPE    	:= MAP(REGEXFIND('[0-9]+.[0-9]+\\-[TR]',TrimLicType)  => pInput.LICENSE_NBR[1..3] + pInput.LICENSE_NBR[13..14],
													 REGEXFIND('[0-9]+.[0-9]+\\-[BR]',TrimLicType)  => pInput.LICENSE_NBR[1..3] + pInput.LICENSE_NBR[13],
								           REGEXFIND('[0-9]+.[0-9]+\\-[SO]',TrimLicType)  => pInput.LICENSE_NBR[1..3] + pInput.LICENSE_NBR[13],
													 REGEXFIND('[0-9]+.[0-9]+\\-[MA]',TrimLicType)  => pInput.LICENSE_NBR[1..3], 
																										pInput.LICENSE_NBR[1..3]);
		newLICTYPE   	  := IF(tmpLICTYPE = '083' AND REGEXFIND(BranchIdent,TrimNAME_Bus),pInput.LICENSE_NBR[1..3] + 'B', TRIM(tmpLICTYPE,LEFT,RIGHT));
		SELF.TYPE_CD		:= IF(newLICTYPE[1..3] in ['083','077'], 'GR','MD'); 			
	
	// License Information
		SELF.LICENSE_NBR	    	:= pInput.LICENSE_NBR[1..16];
		SELF.LICENSE_STATE	  	:= license_state;
	  SELF.RAW_LICENSE_TYPE		 := '';
	  SELF.STD_LICENSE_TYPE   := newLICTYPE;
		SELF.RAW_LICENSE_STATUS := MAP(REGEXFIND('(DECEASE)',TrimAddress1) => 'D',
																	 REGEXFIND('(DIED)',TrimAddress1) => 'D',
																	 REGEXFIND('(RETIRED)',TrimAddress1) => 'R',
																	 REGEXFIND('(SUSPENSION)',TrimAddress1) => 'S',  
																	 REGEXFIND('(INACTIVE)',TrimAddress1) => 'I',
																	 REGEXFIND('(DECEASE)',TrimAddress2) => 'D',
																	 REGEXFIND('(DIED)',TrimAddress2) => 'D',
																	 REGEXFIND('(INACTIVE)',TrimAddress2) => 'I',
																	 REGEXFIND('(RETIRED)',TrimAddress2) => 'R',
																	 REGEXFIND('(SUSPENSION)',TrimAddress2) => 'S',
																	 REGEXFIND('ACTIVE-INRENEWAL',TrimStatus) => 'ACTIVE IN RENEWAL',
																	 TrimStatus);
																	 
	 //Reformatting date to YYYYMMDD
    SELF.CURR_ISSUE_DTE		:= IF(pInput.EFFECTIVE_DTE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EFFECTIVE_DTE),'17530101');
		TrimOrigDte		:= IF(pInput.ISSUE_DTE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUE_DTE),'17530101');
    SELF.ORIG_ISSUE_DTE := IF(TrimOrigDte = '0   0000','17530101',TrimOrigDte);
		SELF.EXPIRE_DTE				:= IF(pInput.EXPIRE_DTE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPIRE_DTE),'17530101');
		SELF.RENEWAL_DTE			:= '';
		
	  prepNAME_LAST   := MAP(StringLib.stringfind(TmpName_Last,'/',1)> 0 => StringLib.StringFindReplace(TmpName_Last,'/',' '),
												   REGEXFIND('^[A-Z]{1}(-[A-Za-z ]+)',TmpName_Last) => StringLib.StringFindReplace(TmpName_Last,'-',' '),
															TmpName_Last);
		ParsedNAME_Full	:= IF(SELF.type_cd = 'GR' AND TrimName_BUS = '', TrimNAME_First + ' '+ TmpName_Last,
														prepNAME_LAST + ' '+ TrimNAME_First + ' ' + TrimNAME_Mid);
		
		//Prep Corporation Names
		rmvDBA_1       := IF(REGEXFIND(DBA_Ind, TrimName_Bus), Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimName_Bus),TrimNAME_Bus);
		prepName_Bus   := STD.Str.FindReplace(rmvDBA_1,',LLC',', LLC');
		prepNAME_FULL  := STD.Str.FindReplace(prepName_Bus,'/',' ');
		StdNAME_FULL	 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_FULL);
		CleanNAME_FULL := MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_FULL) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_FULL),
		                        StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_FULL))
																								);		
		SELF.NAME_ORG_PREFX := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_FULL); 
		SELF.NAME_ORG		    := IF(CleanNAME_FULL <> '',CleanNAME_FULL, StringLib.StringCleanSpaces(prepNAME_LAST + ' '+ TrimNAME_First));
		SELF.NAME_ORG_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_FULL));
		SELF.STORE_NBR		   := '';
		
    //Determine DBA Name
		StripBranch_FULL := Prof_License_Mari.mod_clean_name_addr.stripBranch(prepNAME_FULL);
		
		getNAME_DBA   := MAP(REGEXFIND(DBA_Ind, TrimName_Bus)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimName_Bus),
											          	 REGEXFIND(DBA_Ind,TrimAddress1)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
																	      REGEXFIND(DBA_Ind,TrimOffice)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimOffice),
												           '');
		StdNAME_DBA	  := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
													OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
													OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   	Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
		SELF.NAME_DBA				:= CleanNAME_DBA;
	  SELF.NAME_DBA_SUFX	:= IF(SELF.TYPE_CD = 'GR',
																Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)),
																		'');
		SELF.DBA_FLAG		    := IF(SELF.NAME_DBA != '',1,0);
		
		//Use address cleaner to clean address
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress2, CoPattern);	
    	
		TmpAddress1           := MAP(Prof_License_Mari.func_is_company(TrimAddress1)= TRUE AND Prof_License_Mari.func_is_address(TrimAddress1) = FALSE => '',
		                             // Prof_License_Mari.func_is_address(TrimAddress1) = FALSE => '',
																 NOT REGEXFIND('[0-9]',TrimAddress1) AND NOT REGEXFIND(Addr_Pattern, TrimAddress1) => '',
																 REGEXFIND('P.O. BOX',TrimAddress1)=>REGEXREPLACE('P.O. BOX',TrimAddress1,'PO BOX'),
																 StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern)));
		TmpAddress2           := MAP(Prof_License_Mari.func_is_company(TrimAddress2)= TRUE AND Prof_License_Mari.func_is_address(TrimAddress2) = FALSE => '',
																 REGEXFIND('REQUESTED TO BE',TrimAddress2) => '',
																 REGEXFIND('P.O. BOX',TrimAddress2) => REGEXREPLACE('P.O. BOX',TrimAddress2,'PO BOX'),
		                             StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress2, RemovePattern)));

   temp_preaddr1         := MAP(REGEXFIND('(.*)(UNIT .*|SUITE .*|APT .*|PO BOX .*)',TmpAddress1) AND TmpAddress2 = ''=>REGEXFIND('(.*)(UNIT .*|SUITE .*|APT .*|PO BOX .*)',TmpAddress1,1),
															   REGEXFIND('(^PO BOX [0-9])[ ](.*)',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(^PO BOX [0-9])[ ](.*)',TmpAddress1,2),
															   REGEXFIND('(^PO BOX [0-9])[,](.*)',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(^PO BOX [0-9])[,](.*)',TmpAddress1,2),
		                REGEXFIND('(.*)[ ](PO BOX [0-9])',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(.*)[ ](PO BOX [0-9])',TmpAddress1,1),		
															   REGEXFIND('(.*)[,](PO BOX [0-9])',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(.*)[ ](PO BOX [0-9])',TmpAddress1,1),																		   
																 TmpAddress1);
		temp_preaddr2         := MAP(REGEXFIND('(.*)(UNIT .*|SUITE .*|APT .*|PO BOX.*)',TmpAddress1) AND TmpAddress2 = ''=>REGEXFIND('(.*)(UNIT .*|SUITE .*|APT .*|PO BOX .*)',TmpAddress1,2),
		                 REGEXFIND('(^PO BOX [0-9])[ ](.*)',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(^PO BOX [0-9])[ ](.*)',TmpAddress1,1),		
												  		   REGEXFIND('(^PO BOX [0-9])[,](.*)',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(^PO BOX [0-9])[,](.*)',TmpAddress1,1),
		                 REGEXFIND('(.*)[ ](PO BOX [0-9])',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(.*)[ ](PO BOX [0-9])',TmpAddress1,2),		
															    REGEXFIND('(.*)[,](PO BOX [0-9])',TmpAddress1) AND TmpAddress2 = '' => REGEXFIND('(.*)[,](PO BOX [0-9])',TmpAddress1,2),																 
															    TmpAddress2);														 


		tempaddress1 	:= IF(REGEXFIND(DBA_Ind,temp_preaddr1),'',StringLib.StringCleanSpaces(temp_preaddr1)); 
		tempaddress2 	:= IF(REGEXFIND(DBA_Ind,temp_preaddr2),'',StringLib.StringCleanSpaces(temp_preaddr2)); 	
		
		clnAddress1   := REGEXREPLACE(',$',tempaddress1,'');
		clnAddress2   := REGEXREPLACE(',$',tempaddress2,'');
		
	 strip_CareOf1 := MAP(REGEXFIND(C_O_Ind,tmpNameContact1)=> '',
		                     REGEXFIND(DBA_Ind,tmpNameContact1)=> '',
																	 tmpNameContact1); 
		strip_CareOf2 := MAP(REGEXFIND(C_O_Ind,tmpNameContact2)=> '',
		                     REGEXFIND(DBA_Ind,tmpNameContact2)=> '',
		                               tmpNameContact2); 
		rmvDBA_2      := IF(REGEXFIND(DBA_Ind, TrimOffice), Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimOffice),TrimOffice);
		
												 
	// IF NAME_FULL contains individual name, parse out name
	 tmpIndName		:= MAP(SELF.TYPE_CD = 'MD' AND NOT Prof_License_Mari.func_is_company(ParsedName_Full) => ParsedNAME_FULL,
											 REGEXFIND('(, REAL ESTATE BROKER|REAL ESTATE BROKER|, BROKER|BROKER )', TrimNAME_Bus) => REGEXREPLACE('(, REAL ESTATE BROKER|REAL ESTATE BROKER|, BROKER|BROKER )', TrimNAME_Bus,''),
		                   REGEXFIND('(\\&|\\;| AND | THE$|INCOPORATED|CO.|ASSOC|CORP| LLC$|,LLC$)',TrimNAME_Bus) => '',
											 NOT Prof_License_Mari.func_is_company(TrimNAME_Bus) => TrimNAME_Bus,
											 '' );
												
		tempFullNick          := Prof_License_Mari.fGetNickname(tmpIndName,'nick');	
		removeFullNick        := Prof_License_Mari.fGetNickname(tmpIndName,'strip_nick');
		stripNickFullName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFullNick));
		removeSufxName  			:= IF(REGEXFIND(Sufx_Pattern,stripNickFullName),REGEXREPLACE(Sufx_Pattern,stripNickFullName,''),stripNickFullName);
		TmpSuffix             := TRIM(REGEXFIND(Sufx_Pattern,removeSufxName,0),LEFT,RIGHT);
		GoodFullName					:= IF(TmpSuffix != '',removeSufxName,stripNickFullName);
		
	  ParsedName		:= MAP(GoodFullName != '' AND Prof_License_Mari.func_is_company(GoodFullName) => '',
											   GoodFullName != '' AND REGEXFIND(NameFormat,GoodFullName) =>  Address.CleanPersonLFM73(GoodFullName),
												 GoodFullName != '' AND newLICTYPE[1..3] != '083' => Address.CleanPersonLFM73(GoodFullName),
																			Address.CleanPersonFML73(GoodFullName));
	 	re_ParsedName := IF(LENGTH(TRIM(ParsedName[6..25]))<2 OR LENGTH(TRIM(ParsedName[46..65]))<2,NID.CleanPerson73(GoodFullName),ParsedName);		
	
		
	  SELF.NAME_FIRST	  := TRIM(re_ParsedName[6..25],LEFT,RIGHT);
	  SELF.NAME_MID			:= TRIM(re_ParsedName[26..45],LEFT,RIGHT);
	  SELF.NAME_LAST		:= TRIM(re_ParsedName[46..65],LEFT,RIGHT); 
	  SELF.NAME_SUFX		:= MAP(TmpSuffix_Last!= '' => TmpSuffix_last,
	                         TmpSuffix!= '' => TmpSuffix,
														            TRIM(re_ParsedName[66..70],LEFT,RIGHT));
	  SELF.CREDENTIAL		:= IF(newLICTYPE[1..3] = '083' AND REGEXFIND('(, BROKER|BROKER |, REAL ESTATE BROKER|REAL ESTATE BROKER)',StdNAME_FULL),'BROKER','');
		SELF.PROV_STAT		:= MAP(SELF.RAW_LICENSE_STATUS = 'DECEASED' => 'D',
		                         SELF.RAW_LICENSE_STATUS = 'INACTIVE - DECEASED' => 'D',
														 SELF.RAW_LICENSE_STATUS = 'EXPIRED - DECEASED' => 'D',
														 SELF.RAW_LICENSE_STATUS = 'D' => 'D',
														 SELF.RAW_LICENSE_STATUS = 'RETIRED' => 'R',
														 '');   		   
		StdName_Off   := MAP(strip_CareOf1 != '' => Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(strip_CareOf1)),
												           strip_CareOf2 != '' => Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(strip_CareOf2)),
												           Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_2));
		GoodNameOffice := MAP(REGEXFIND('(&)',StdName_Off) AND REGEXFIND(business_exempt, StdName_Off) AND NOT REGEXFIND(BusExceptions, StdName_Off)=> '',
										      REGEXFIND(business_exempt, StdName_Off) AND NOT REGEXFIND(BusExceptions, StdName_Off) AND NOT REGEXFIND(NameFormat,StdName_Off)
												  AND NOT REGEXFIND('[0-9]',StdName_Off) => '',
											    StringLib.StringFilterOut(StdName_Off, '"'));	
																	 
		SELF.NAME_OFFICE	  :=	MAP(TRIM(GoodNameOffice,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST,ALL) => '',
		                            TRIM(GoodNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
		                            TRIM(GoodNameOffice,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST + SELF.NAME_MID,ALL) => '',
																TRIM(GoodNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																TRIM(GoodNameOffice,ALL) = TRIM(SELF.NAME_ORG + SELF.NAME_ORG_SUFX,ALL) => '',
																StringLib.StringCleanSpaces(GoodNameOffice));																 
																 
		SELF.OFFICE_PARSE	    := MAP(SELF.NAME_OFFICE != ''  
																               AND (Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)
																               OR REGEXFIND('(CORP| CO$)',SELF.NAME_OFFICE)) =>'GR',
																               SELF.NAME_OFFICE != ''  AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'MD',
																          					'');						 
						 
   //Populating MARI Name Fields
    SELF.NAME_FORMAT				:= MAP(SELF.type_cd = 'GR' => 'F',
																	 SELF.TYPE_CD = 'MD' AND ParsedNAME_Full = '' => 'F',
																	 TmpName_Last = '' AND TrimNAME_Bus = '' => 'F',
																   'L'); 
    SELF.NAME_ORG_ORIG	    := MAP(ParsedNAME_Full = '' => TrimNAME_Bus,
																   SELF.type_cd = 'GR' AND TrimNAME_BUS = '' =>  TrimNAME_First + ' ' + TrimNAME_Last,
																   TrimNAME_Bus != '' => TrimNAME_BUS, 
																			TrimName_Last + ' ' + TrimName_First + ' ' + TrimName_Mid);
	  SELF.NAME_DBA_ORIG	    := ''; 
	  getNAME_MARI_ORG        := MAP(newLICTYPE[1..3] = '077' AND SELF.TYPE_CD ='GR' => StdNAME_FULL,
													         newLICTYPE[1..3] = '083' => StdNAME_FULL,
													         SELF.NAME_OFFICE != '' => SELF.NAME_OFFICE,
													         '');
	  SELF.NAME_MARI_ORG	    := StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(
																								Prof_License_Mari.mod_clean_name_addr.stripBranch(getNAME_MARI_ORG)));
	  SELF.NAME_MARI_DBA	    := StdNAME_DBA;													

			
		SELF.ADDR_BUS_IND		:= IF(TRIM(clnAddress1 + clnAddress2 + TrimCity + pInput.ADDR_ZIP) != '','B','');
		SELF.ADDR_ADDR1_1  	:= IF(clnAddress1 != '',clnAddress1,clnAddress2);
		SELF.ADDR_ADDR2_1  	:= IF(clnAddress1 != '',clnAddress2,'');		
				
		SELF.ADDR_ADDR3_1		:= '';
		SELF.ADDR_ADDR4_1		:= '';
		SELF.ADDR_CITY_1		:= IF(REGEXFIND('(PERSON NOT |..SEE |FILE NO.)',TrimCity),'',TrimCity);
		SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.ADDR_ST);
		SELF.ADDR_CNTRY_1		:= ut.CleanSpacesAndUpper(pInput.COUNTRY);
		
		ParsedZIP           := IF(Stringlib.Stringfind(TrimCity,'PERSON NOT',1)> 0,'',REGEXFIND('[0-9]{5}(-[0-9]{4})?', pInput.ADDR_ZIP, 0));
		SELF.ADDR_ZIP5_1		:= ParsedZIP[1..5];
		SELF.ADDR_ZIP4_1		:= IF(ParsedZIP[7..10] = '0000','',ParsedZIP[7..10]);
		SELF.OOC_IND_1			:= 0;    
		SELF.OOC_IND_2			:= 0;
	    
		SELF.ADDR_ADDR1_2	  := IF(REGEXFIND('^(DECEASED |DECEASED PER SON|DIED ([0-9/-\\/ ]+))',TrimAddress1), TrimAddress1,
															IF(REGEXFIND('^(DECEASED |DECEASED PER SON|DIED ([0-9/-\\/ ]+))',TrimAddress2), TrimAddress2,''));
		SELF.ADDR_ADDR2_2		:= '';
	 
	 //IF Address1 field contain C/O information 
	  prepContactName		  := StringLib.StringFindReplace(TrimAddress1,'C/0','C/O');
	  tmpContactName			:= MAP(REGEXFIND(C_O_Ind,prepContactName) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepContactName),
															 REGEXFIND(C_O_Ind,TrimAddress2) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2),
															 ut.CleanSpacesAndUpper(pInput.Supervisor));
																					
												  
		stripContactName	:= REGEXREPLACE('(REAL ESTATE BROKER|BROKER)',tmpContactName,'');
		ParseContact			:= IF(stripContactName != '' AND NOT Prof_License_Mari.func_is_company(stripContactName),
																		Address.CleanPersonFML73(stripContactName),'');
		SELF.NAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);  
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST	:= IF(Prof_License_Mari.func_is_company(stripContactName),stripContactName,
																		TRIM(ParseContact[46..65],LEFT,RIGHT));  
		SELF.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
		SELF.NAME_CONTACT_NICK	:= '';
		SELF.NAME_CONTACT_TTL		:= IF(StringLib.stringfind(tmpContactName,'BROKER',1) > 0,'BROKER','');
			
    //Expected codes [CO,BR,IN], Set during business/individual filter
	  SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.std_license_type = '083' => 'CO',
																 SELF.std_license_type = '083B' => 'BR',
																 SELF.std_license_type = '083S' AND NOT REGEXFIND('(REAL ESTATE|REALTY|ASSOCIATE|PARTNER)',TrimName_Bus) => 'IN',
																 SELF.std_license_type = '077' => 'CO',
																 SELF.std_license_type = '077B' => 'BR',
																 'CO');
			
    // Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK         	:= 	HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																      +TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																	    +TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																			+TrimNAME_Bus + ','
 																	    +TrimNAME_First + ','
																			+TrimNAME_Last+ ','
																			+TrimAddress1+ ','
																			+TrimAddress2+ ','
																			+TRIM(pInput.ADDR_ZIP,LEFT,RIGHT)  + ','
																			+TRIM(pInput.Supervisor,LEFT,RIGHT));
																
																		   
		SELF.PCMC_SLPK		:= 0;
		SELF.PROVNOTE_1		:= '';
		SELF.PROVNOTE_2		:= ''; 	
		SELF.PROVNOTE_3		:= IF(pInput.Supervisor != '', 'SUPERVISOR: ' +ut.CleanSpacesAndUpper(pInput.Supervisor),'');
		SELF.ADDL_LICENSE_SPEC := 	ut.CleanSpacesAndUpper(pInput.ENDORSEMENT);
		SELF := [];	
		   
END;
inFileLic	:= DEDUP(SORT(PROJECT(GoodRecs, xformToCommon(LEFT)),cmc_slpk,LOCAL), RECORD,ALL);

// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
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
																		
//Populate PROV_STAT
Prof_License_Mari.layouts.base 	trans_prov_stat(ds_map_lic_trans L, cmvTransLkp R) := TRANSFORM
	SELF.PROV_STAT := IF(L.PROV_STAT != '',L.PROV_STAT,R.DM_VALUE2);
	SELF := L;
END;

ds_map_prov_trans := JOIN(ds_map_lic_trans, cmvTransLkp,
						TRIM(LEFT.std_license_status,LEFT,RIGHT)= TRIM(RIGHT.dm_value1,LEFT,RIGHT)
						AND RIGHT.dm_name1 = 'LIC_STATUS'
						AND RIGHT.dm_name2='PROVSTAT', 
						Trans_prov_stat(LEFT,RIGHT),LEFT OUTER,LOOKUP);


//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_prov_trans(affil_type_cd='CO');
company_only_lookup_gr := ds_map_prov_trans(type_cd ='GR' AND NAME_MARI_ORG != '');

Prof_License_Mari.layouts.base 	assign_pcmcslpk_br(ds_map_prov_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil_br := JOIN(ds_map_prov_trans, company_only_lookup,
						TRIM(LEFT.NAME_ORG[1..40],LEFT,RIGHT) = TRIM(RIGHT.NAME_ORG[1..40],LEFT,RIGHT)
						AND LEFT.AFFIL_TYPE_CD = 'BR',
						assign_pcmcslpk_br(LEFT,RIGHT),LEFT OUTER,LOCAL,LOOKUP);	
						
Prof_License_Mari.layouts.base 	assign_pcmcslpk_gr(ds_map_affil_br L, company_only_lookup_gr R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;
ds_map_affil_gr := JOIN(ds_map_affil_br, company_only_lookup_gr,
						TRIM(LEFT.NAME_OFFICE,LEFT,RIGHT) = TRIM(RIGHT.NAME_MARI_ORG,LEFT,RIGHT)
						AND LEFT.STD_LICENSE_TYPE IN ['081','082'],
						assign_pcmcslpk_gr(LEFT,RIGHT),LEFT OUTER,LOCAL);	

Prof_License_Mari.layouts.base  xTransPROVNOTE(ds_map_affil_gr L) := TRANSFORM
	SELF.PROVNOTE_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + BrComnt,
												 L.provnote_1 != '' AND L.pcmc_slpk = 0 
												 AND L.affil_type_cd = 'IN' AND REGEXFIND(BranchIdent,TRIM(L.name_mari_org,LEFT,RIGHT)) => TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + INComnt,
						
												 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => BrComnt,
												 L.provnote_1 = '' AND L.pcmc_slpk = 0 
												 AND L.affil_type_cd = 'IN' AND REGEXFIND(BranchIdent,TRIM(L.name_mari_org,LEFT,RIGHT))=> INComnt,
																			L.PROVNOTE_1);

	SELF := L;
END;

OutRecs := PROJECT(ds_map_affil_gr, xTransPROVNOTE(LEFT));

// Transform expanded dataset to MARIBASE layout
Prof_License_Mari.layouts.base xTransToBase(OutRecs L) := TRANSFORM
	SELF.NAME_ORG_PREFX	:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(L.NAME_ORG_PREFX)); 
	SELF.NAME_DBA 			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_DBA,'/',' '));
	SELF := L;
END;

ds_map_base := PROJECT(OutRecs, xTransToBase(LEFT));


// Adding to Superfile
d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));		

move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license', 'using', 'used');

notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

RETURN SEQUENTIAL(OFile, OCmvLkp, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;