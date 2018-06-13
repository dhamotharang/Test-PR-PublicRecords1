//**************************************************************************************************************/
//  The purpose of this development is take Kansas Real Estate Professional License raw files AND convert them to a common
//  professional license (BASE) layout to be used for MARI AND PL_BASE development.
//	07/2/2015 T.George - New Development
//************************************************************************************************************* */	
IMPORT Prof_License,Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, STD, NID;

EXPORT map_KSS0903_conversion(STRING pVersion) := FUNCTION

	code 		:= 'KSS0903';
	src_cd	:= 'S0903';
	src_st	:= 'KS';	//License state
	
	// Reference Files
	cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
	OCmv  := OUTPUT(cmvTransLkp);
	
	// Filter records w/o ORG_NAME being NOT populated
	ValidRLEFile	:= Prof_License_Mari.file_KSS0903.rle;
  oRle	:= OUTPUT(ValidRleFile);
	
	
C_O_Ind := '(C/O |ATTN: |ATTN )';
DBA_Ind := '( DBA |D/B/A | DBA:|/DBA | A/K/A | AKA )';

CoPattern	        := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.*NET$|^%.*$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
									'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$|^ATTN:.*$' +
									'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
									'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* BUILDING$|^.* OFFICE$' +
									')';
RemovePattern	    := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.*NET$|^%.*$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
											'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
											'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^C/O.*$|^ATTN.*$|' +
											'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES' +
											'^.* REALTORS$|^.* PROPERTIES$|^ATTN:.*$|^UNKNOWN$|^#N/A$' +
											')';
Sufx_Pattern      := '( SR.| SR | SR$|^SR$| JR.| JR |^JR$| JR$| III| II| IV | VI | VII)';
FilterNullRecord	:= ValidRLEFile(NOT REGEXFIND('[\\x00-\\x1F\\x7F]', TRIM(last_name)) and StringLib.StringCleanSpaces(FullName + EMAIL + LICENSE_NUMBER + COMPANY_NAME + ADDRESS + CITY + STATE) <> '');
ut.CleanFields(FilterNullRecord, ClnFilterNullRecord);
O_Filter          := OUTPUT(ClnFilterNullRecord);

Prof_License_Mari.layouts.base	TRANSFORMToCommon(layout_KSS0903.common pInput) := TRANSFORM
			SELF.PRIMARY_KEY			:= 0;
			SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
			SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
			SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd
      
			SELF.STD_SOURCE_UPD		:= src_cd;
			SELF.TYPE_CD					:= 'MD';
			SELF.STD_SOURCE_DESC	:= ' ';
			SELF.STD_PROF_CD		  := ' ';
			SELF.STD_PROF_DESC		:= ' ';
			
			SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
			SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
			
			//License Information 
			tmpLicenseNbr := IF(LENGTH(TRIM(pInput.LICENSE_NUMBER)) < 8, (STRING)INTFORMAT((UNSIGNED)pInput.LICENSE_NUMBER,8,1), pInput.LICENSE_NUMBER);
			tmpCmpnyNbr	  := IF(LENGTH(TRIM(pInput.COMPANY_LICENSE_NUMBER)) < 8, (STRING)INTFORMAT((UNSIGNED)pInput.COMPANY_LICENSE_NUMBER,8,1), pInput.COMPANY_LICENSE_NUMBER);
			TrimLicenseType := ut.CleanSpacesAndUpper(pInput.LICENSE_TYPE);
			TmpLicenseType  := MAP(TrimLicenseType = 'SALESPERSON'=>'SP',
			                       TrimLicenseType = 'BROKER'=>'BR',
														 TrimLicenseType = 'TEMP SALESPERSON'=>'TS',
														 '');
			SELF.LICENSE_NBR				:= IF(pInput.LICENSE_NUMBER != '',TmpLicenseType+tmpLicenseNbr,'NR');
			SELF.OFF_LICENSE_NBR		:= IF(pInput.COMPANY_LICENSE_NUMBER != 'NULL', tmpCmpnyNbr,'');
			SELF.OFF_LICENSE_NBR_TYPE := IF(SELF.OFF_LICENSE_NBR != '', 'COMPANY NUMBER','');
			SELF.LICENSE_STATE			:= src_st;
			SELF.RAW_LICENSE_TYPE		:= TmpLicenseType;
			SELF.STD_LICENSE_TYPE		:= TmpLicenseType; 	
			SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(pinput.LICENSE_STATUS);
			SELF.STD_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(pInput.STATUS_CODE);
			
			//Reformatting date from MM/DD/YYYY to YYYYMMDD
			SELF.CURR_ISSUE_DTE			:= '17530101';
			prep_ORIG_ISSUE_DATE    := IF(pInput.Orig_ISSUE_DATE<>'',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.Orig_ISSUE_DATE),'');
			SELF.ORIG_ISSUE_DTE	  	:= IF(STD.Str.Find(prep_ORIG_ISSUE_DATE, '/', 1) > 0,Prof_License_Mari.DateCleaner.ToYYYYMMDD(TRIM(prep_ORIG_ISSUE_DATE)),
																		IF(prep_ORIG_ISSUE_DATE = '', '17530101', STD.Str.FilterOut(prep_ORIG_ISSUE_DATE,'#')));
      prep_EXPIRE_DTE         := IF(pInput.EXPIRATION_DATE<>'',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPIRATION_DATE),'');			
			SELF.EXPIRE_DTE					:= IF(STD.Str.Find(prep_EXPIRE_DTE, '/', 1) > 0,Prof_License_Mari.DateCleaner.ToYYYYMMDD(TRIM(prep_EXPIRE_DTE)),
																		IF(prep_EXPIRE_DTE = '','17530101', STD.Str.FilterOut(prep_EXPIRE_DTE,'#')));
			prep_RENEW_DTE          := IF(pInput.LAST_RENEW_DATE<>'',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.LAST_RENEW_DATE),'');																	
			SELF.RENEWAL_DTE				:= IF(STD.Str.Find(prep_RENEW_DTE, '/', 1) > 0, Prof_License_Mari.DateCleaner.ToYYYYMMDD(TRIM(prep_RENEW_DTE)),
																		IF(prep_RENEW_DTE = '','17530101',STD.Str.FilterOut(prep_RENEW_DTE,'#')));
	
			// If individual AND NOT identified as a corporation names, parse into (FMLS) fmt
			TrimNAME_LAST			:= IF(pInput.LAST_NAME = 'NULL','',ut.CleanSpacesAndUpper(pInput.LAST_NAME));
			TmpNAME_LAST			:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_LAST),REGEXREPLACE(Sufx_Pattern,TrimNAME_LAST,''),TrimNAME_LAST);
		
			TrimNAME_FIRST		:= IF(pInput.FIRST_NAME = 'NULL','',ut.CleanSpacesAndUpper(pInput.FIRST_NAME));
			TmpNAME_FIRST 		:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_FIRST),REGEXREPLACE(Sufx_Pattern,TrimNAME_FIRST,''),TrimNAME_FIRST);

			TrimNAME_MID			:= IF(pInput.MIDDLE_NAME = 'NULL','',ut.CleanSpacesAndUpper(pInput.MIDDLE_NAME));
			TmpNAME_MID 			:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_MID),REGEXREPLACE(Sufx_Pattern,TrimNAME_MID,''),TrimNAME_MID);

			TrimNAME_FULL     := ut.CleanSpacesAndUpper(pInput.FULLNAME);
			TmpNAME_FULL 			:= IF(REGEXFIND(Sufx_Pattern,TrimNAME_FULL),REGEXREPLACE(Sufx_Pattern,TrimNAME_FULL,''),TrimNAME_FULL);
			
			TrimNAME_SUFX			:= IF(pInput.SUFFIX = 'NULL','',ut.CleanSpacesAndUpper(pInput.SUFFIX));
			TmpSuffix         := MAP(REGEXFIND(Sufx_Pattern,TrimNAME_LAST)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_LAST,0),LEFT,RIGHT),
			                         REGEXFIND(Sufx_Pattern,TrimNAME_MID)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_MID,0),LEFT,RIGHT),
			                         REGEXFIND(Sufx_Pattern,TrimNAME_FIRST)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_FIRST,0),LEFT,RIGHT),
															 REGEXFIND(Sufx_Pattern,TrimNAME_FULL)=>TRIM(REGEXFIND(Sufx_Pattern,TrimNAME_FULL,0),LEFT,RIGHT),
			                         TrimNAME_SUFX);

			TrimNAME_BUS			:= IF(pInput.COMPANY_NAME = 'NULL','',ut.CleanSpacesAndUpper(pInput.COMPANY_NAME));
			
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

			SELF.NAME_ORG_PREFX		:= '';
			SELF.NAME_ORG		 			:= ConcatNAME_FULL;
			SELF.NAME_ORG_SUFX	  := '';
			SELF.NAME_FIRST		   	:= GoodFirstName;
			SELF.NAME_MID					:= Stringlib.stringFilterOut(GoodMidName,'.');
			SELF.NAME_LAST		   	:= GoodLastName;
			SELF.NAME_NICK				:= MAP(TmpNAME_LAST != '' AND tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																   TmpNAME_LAST != '' AND tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																   TmpNAME_LAST != '' AND tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																   TmpNAME_FULL != '' AND tempFullNick != '' => StringLib.StringCleanSpaces(tempFullNick),
																   '');
			SELF.NAME_SUFX				:= TRIM(TmpSuffix,LEFT,RIGHT);
				
			//Remove DBA Name																 
			getNAME_DBA						:= IF(REGEXFIND(DBA_Ind,TrimNAME_BUS),Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_BUS),''); 
			StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
			CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
															
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
			SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
			SELF.NAME_DBA					:= StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
			SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
			SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
	
			//Prepping OFFICE NAMES
			rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,TrimNAME_BUS) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimNAME_BUS),
																TrimNAME_BUS[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimNAME_BUS),
																REGEXFIND(C_O_Ind,TrimNAME_BUS)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimNAME_BUS),
																																		TrimNAME_BUS);
																					
			StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
			CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																			Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
			GoodName_OFFICE       := MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
			                             TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																	 TRIM(CleanNAME_OFFICE,ALL) = TRIM(TrimNAME_FULL,ALL) => '',
																	 TRIM(CleanNAME_OFFICE) = 'NULL' => '',
																	 CleanNAME_OFFICE);
			
			SELF.NAME_OFFICE		  := StringLib.StringCleanSpaces(GoodNAME_OFFICE);
			SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																	   ''));
			SELF.NAME_FORMAT				:= 'L';
			SELF.NAME_ORG_ORIG			:= IF(TrimNAME_LAST <> '',StringLib.StringCleanSpaces(TRIM(TRIM('',LEFT,RIGHT) + IF(TrimNAME_LAST <> '',TrimNAME_LAST,''),LEFT)
																																	+ IF(TrimNAME_SUFX <> '',' ' + TrimNAME_SUFX + ', ', ', ')
																																	+ TRIM(TRIM('',LEFT,RIGHT) + IF(TrimNAME_FIRST <> '',TrimNAME_FIRST + ' ',''),LEFT)
																																	+ TRIM(TRIM('',LEFT,RIGHT) + IF(TrimNAME_MID <> '',TrimNAME_MID,''),LEFT)), 
																																	TrimNAME_FULL);
	
					
			SELF.NAME_DBA_ORIG			:= '';
			SELF.NAME_MARI_ORG			:= SELF.NAME_OFFICE;
			SELF.NAME_MARI_DBA			:= StdNAME_DBA;
			SELF.PHN_MARI_1        	:= ut.CleanPhone(pInput.BUSINESS_PHONE);
			SELF.PHN_MARI_FAX_1			:= ut.CleanPhone(pInput.BUSINESS_FAX);
			SELF.PHN_PHONE_1				:= ut.CleanPhone(pInput.BUSINESS_PHONE);
		  SELF.PHN_FAX_1					:= ut.CleanPhone(pInput.BUSINESS_FAX);
			
	  //Use address cleaner to clean address			
		TrimAddress1 	:= IF(TRIM(pInput.ADDRESS) = 'NULL','',ut.CleanSpacesAndUpper(pInput.ADDRESS));
		TrimCity			:= IF(TRIM(pInput.CITY) = 'NULL', '', ut.CleanSpacesAndUpper(pInput.CITY));
		TrimZIP       := StringLib.StringFilter(pInput.ZIP,'0123456789');
					
	  prepAddress1 := IF(TrimCity != '' AND TRIM(TrimAddress1[1..STD.Str.Find(TrimAddress1, ',', 1) -1], RIGHT) = TrimCity, '', TrimAddress1);
		prepAddress2 := IF(TrimCity != '' AND TRIM(prepAddress1[1..STD.Str.Find(prepAddress1, ' ', 1) -1], RIGHT) = TrimCity, '', prepAddress1);
		prepAddress3 := IF(STD.Str.Find(prepAddress2, 'UNKNOWN', 1) = 1, '', prepAddress2);
		repl_Nonprnt := REGEXREPLACE('[\\x00-\\x1F\\x7F]', prepAddress3, ';');
		tmpAddress1	 := MAP(REGEXFIND('(.*);;(.*)$', repl_Nonprnt)=> REGEXFIND('(.*);;(.*)$', repl_Nonprnt,1),
											  REGEXFIND('(.*);(.*)$', repl_Nonprnt)=> REGEXFIND('(.*);(.*)$', repl_Nonprnt,1),
											  REGEXFIND('(.*)[|](.*)$', repl_Nonprnt)=> REGEXFIND('(.*)[|](.*)$', repl_Nonprnt,1),
												prepAddress3);	
		tmpAddress2	 := MAP(REGEXFIND('(.*);;(.*)$', repl_Nonprnt)=> REGEXFIND('(.*);;(.*)$', repl_Nonprnt,2),
												REGEXFIND('(.*);(.*)$', repl_Nonprnt)=> REGEXFIND('(.*);(.*)$', repl_Nonprnt,2),
                        REGEXFIND('(.*)[|](.*)$', repl_Nonprnt)=> REGEXFIND('(.*)[|](.*)$', repl_Nonprnt,2),												 
												  '');											
		tmpNameContact1		:= IF(REGEXFIND('^(C/O (35 .*|EL TOVAR HOTEL|GENERAL DELIVERY)+).*$',tmpAddress1), '', 
															Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(tmpAddress1, CoPattern));
		clnAddress1				:= IF(REGEXFIND('^(C/O (35 .*|EL TOVAR HOTEL|GENERAL DELIVERY)+).*$',tmpAddress1), tmpAddress1[5..], 
													  	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(tmpAddress1, RemovePattern));
															                                                                         
			// final field assignment for city, state, AND zip
			SELF.ADDR_BUS_IND		:= IF(TRIM(clnAddress1+TrimCity+trimZIP) != '','B','');
			SELF.ADDR_ADDR1_1		:= IF(clnAddress1 <> '',clnAddress1, tmpAddress2);		
			tmpAddress3 := IF(tmpAddress2 NOT IN ['07/10/1949','NONE'],tmpAddress2,''); 
			SELF.ADDR_ADDR2_1		:= IF(clnAddress1 <> '',tmpAddress3,'');
			SELF.ADDR_ADDR3_1		:= '';
			SELF.ADDR_ADDR4_1		:= '';
			SELF.ADDR_CITY_1		:= TrimCity;
			SELF.ADDR_STATE_1		:= IF(TRIM(pInput.STATE) = 'NULL', '', ut.CleanSpacesAndUpper(pInput.STATE));
		
			TmpZIP              := MAP(LENGTH(TRIM(TrimZIP))=3 => '00'+TRIM(TrimZIP),
																 LENGTH(TRIM(TrimZIP))=4 => '0'+TRIM(TrimZIP),
																 TRIM(TrimZIP));
			SELF.ADDR_ZIP5_1		:= TmpZIP[1..5];
			SELF.ADDR_ZIP4_1		:= TmpZIP[7..10];
			SELF.EMAIL					:= IF(TRIM(pInput.EMAIL) = 'NULL','',ut.CleanSpacesAndUpper(pInput.EMAIL));
			
			parseContact 	:= Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tmpNameContact1);
			SELF.NAME_CONTACT_FIRST	:= TRIM(parseContact[6..25],LEFT,RIGHT);
			SELF.NAME_CONTACT_MID		:= TRIM(parseContact[26..45],LEFT,RIGHT);
			SELF.NAME_CONTACT_LAST	:= TRIM(parseContact[46..65],LEFT,RIGHT);
			SELF.NAME_CONTACT_SUFX	:= TRIM(parseContact[66..70],LEFT,RIGHT);
			
			SELF.ORIGIN_CD      := CASE(ut.CleanSpacesAndUpper(pInput.LIC_ORIGIN_CODE),
																	'EXAM' 					=> 	'E',
																	'OTHER' 				=>	'O',
																	'RECIPROCITY'		=>	'R',
																	'ENDORSEMENT' 	=>	'D',
																	'GRANDFATHERED'	=>	'G',
																	'ORIGINAL'			=>	'L',
																	'WAIVER'				=>	'W',
																	'SCHOOLING'			=>	'S',
																	'UNKNOWN'				=>	'U',
																	'');
						
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD	:= 'IN';  
					
			/* fields used to create mltrec_key unique record split dba key are :
					 TRANSFORMed license number
					 standardized license type
					 standardized source update
					 raw name containing dba name(s)
					 raw address
			*/
			SELF.mltreckey		:= 0;
					 
				/* fields used to create cmc_slpk unique key are :
					license number
					license type
					source update
					name
					address */
			//Use hash64 instead of hash32 to avoid dup keys		 
			SELF.cmc_slpk    	:= HASH64(TRIM(SELF.license_nbr) + ','
																	+ TRIM(SELF.std_license_type) + ','
																	+ TRIM(SELF.std_source_upd) + ','
																	+ TRIM(SELF.name_org) + ','
																	+ TrimADDRESS1 +','
																	+	TrimCITY + ','
																	+ TrimZIP
																	);
			SELF.PROVNOTE_1				:= '';
			SELF.PROVNOTE_2				:= IF(pInput.BRKR_ORIGIN_CODE != '', 'BROKER_ORIGIN_CODE: '+pInput.BRKR_ORIGIN_CODE,'');
			SELF.PROVNOTE_3 	    := '';	
			SELF.PREV_PRIMARY_KEY	:= 0;
			SELF.PREV_MLTRECKEY		:= 0;
			SELF.PREV_CMC_SLPK		:= 0;
			SELF.PREV_PCMC_SLPK		:= 0;
			SELF.CONT_EDUCATION_ERND	:= IF(TRIM(pInput.SUM_OF_HOURS) = '0' OR TRIM(pInput.SUM_OF_HOURS) = 'NULL','',pInput.SUM_OF_HOURS);
			SELF.CONT_EDUCATION_REQ		:= '';
			SELF.CONT_EDUCATION_TERM	:= '';
			SELF := [];		   		   			
	END;

	ds_map := PROJECT(ClnFilterNullRecord, TRANSFORMToCommon(LEFT));

// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
Prof_License_Mari.layouts.base 	trans_lic_status(ds_map L, cmvTransLkp R) := TRANSFORM
	SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
	SELF := L;
END;

ds_map_stat_trans := JOIN(ds_map, cmvTransLkp,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
	    					AND RIGHT.fld_name='LIC_STATUS',
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
O_ds1 := OUTPUT(ds_map_stat_trans);
	
// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_stat_trans L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

  ds_map_lic_prof := JOIN(ds_map_stat_trans, cmvTransLkp,
												TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
												AND RIGHT.fld_name='LIC_TYPE' 
												AND RIGHT.dm_name1 = 'PROFCODE',
												trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  O_ds2   := OUTPUT(ds_map_lic_prof);
  //Adding to Superfile
	d_final := OUTPUT(ds_map_lic_prof , ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
	
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_prof(NAME_ORG_ORIG != ''));
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle', 'using', 'used');
	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oRLE, OCmv, O_Filter,O_ds1, O_ds2, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;