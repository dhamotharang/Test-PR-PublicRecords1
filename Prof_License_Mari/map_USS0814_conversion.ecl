/* Converting Asc National Registry Real Estate Appraisers Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND*/
//Input file location: \\Tapeload02b\k\professional_licenses\mari\national\real_estate_appraisers_(en)
#workunit('name','Yogurt: map_USS0814_conversion'); 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, STD;

EXPORT map_USS0814_conversion(STRING pVersion) := FUNCTION

	code 								:= 'USS0814';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'asc','sprayed','using');	);

	inFile						:= Prof_License_Mari.files_USS0814.asc;
	oAPR								:= OUTPUT(CHOOSEN(inFile, 300));
	
	//Reference Files for lookup joins
	cmvTransLkp					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	Ocmv                := OUTPUT(cmvTransLkp);

	Comments 						:= 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

	//Filtering out BAD RECORDS
	NonBlankName 				:= inFile(TRIM(LNAME+FNAME+MNAME+COMPANY,LEFT,RIGHT) <> ''/* AND TRIM(LIC_TYPE,LEFT,RIGHT) <> ''*/); 
	GoodLicenseRec			:= NonBlankName(NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUpperCase(LIC_NUMR)));
	ut.CleanFields(GoodLicenseRec,GoodFilterRec);
	
	// Valid State List
	//valid_states := ['DC','OK','TX','KS','MT','ND','NH','WA'];

	//Invalid Name
	invalid_names 			:= '(RETIRED |SAME AS |SAME|UPGRD |REVOKED |TEMP ADD|COMPLS |SURRENDERED |DECEASED |2-YR SUSP | CASE |1ST LIC | REINS|'+
												 'N/A|---|NONE INDICATED|SELF-EMPLOYED|UNDECIDED|EXPIRED |EXP | PENDING |CASE |GENERAL DELIVERY)';																					

	corp_ind 						:= '(REALTY|APPRAISAL|REAL ESTATE|SERVICE| ASSO|ASSOCIATE| BANK & TRUST|CENTURY 21| SVC|APPR| ASSOC| LLC|ASSESSOR | BANK )';

	displinary_action 	:= '(REVOKED |SURRENDERED |2-YR SUSP | REINS|PENDING )';
	// Remove Company name from address
	RemovePattern	      := '(^.* LLC$|^.* LLC\\.$|^.*LLC.*$|^.* INC$|^.*INC|^.* ,INC|^.* INC\\.$|^.* LLP|^.* COMPANY|^.* CORP$|^.*CORP.*$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* APPRAISAL SERVICE|^.*APPRAISALS|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* ASSOC$|^.* CONSULTING$|' +
					 'RV PARK|SEE DCRA MANAGER FOR ANY REQUEST 7506|RECEIVED NONSUFFICIENT FUN|^.* OFFICE$|^N/I|^N/A|^N/L|' +
					 'WORLD SAVINGS|^.* & CO$|^YAKIMA FEDERAL .*$|^WWW.*NET$|^WASHINGTON MUTUAL.*$|^.* SVCE$|' +
					 '^.* CORPORATION$|^.* GROUP$|^.* COMMUNITY BANK$|^US DEPARTMENT OF .*$|^US DEPT OF .*$|^US ARMY .*$|' +
					 '^.* ASSOCIATE$|^.* GRP$|^WRONSKY GIBBONS .*$|^.* MORTGAGE$|^.* REALTOR$|^.* SVCES$|^OFFICE OF .*$|' +
					 '^WACHOVIA MORTGAGE.*$|^.* RESEARCH$|^.* APPRAISING$|^.* APPRAISER$|^.* VALUATION$|^.* VALUATIONS$|' +                             
					 '^.* DBA$|^.* SVCES,INC|^.* DBA .*$|^.* CORP\\.$|^.* COMPANY P[ ]*C$|^.* GROUP, LLC |^.* LTD$|^.* OFFICE$|' +
					 '^NONE INDICATED$|^NOT INDICATED$|^NI$|^PPC$|^.* TRANSPORTATION$|^.* DEPT OF ASSESSMENT|^DEPT OF .*$|' +
					 '^SEE .* OR .*$|^THE SUMMIT BUILDING |^THE SIGNAL GROUP |$MISSION PATIO,|LYNN STROBEL|^D. M. CLARK & ASSOCIATES$|^US APPRAISAL INC|' +
					 'VICTORIA XING|' +
					 '^INACTIVE - NONRENEW .*$|HOME STREET BANK|DR A H MCCOY|^ASSESSMENT DEPT' +
					 ')';
	CoPattern	   := '(^.* LLC$|^.* LLC\\.$|^.* LLP|^.* LLP$|^.* INC$|^.* INC\\.$|^.*INC|^.*NET$|^%.*$|^.* COMPANY|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
									'^.* APPR\\.$|^.*APPRAISALS$|^.* APPRAISAL SERVICE|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.*APRPAISAL NETWORK|^.*APPRAISALS|^.* FINANCIAL$|' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.*REALTY SEVICES|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$|^ATTN:.*$' +
									'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
									'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* BUILDING$|^.* OFFICE$' +
									'^D.M.CLARK & ASSOCIATES$' +
									')';		

  Office_Pattern   :=  '(^.* AP$|^.* APP$|^.* GP$|^.* REAL |^.* SVC|^.* SRCV|SWICE$|APPRAISAL|APPARAISAL|APPPRAISALS|APPAISAL|ARRPAISALS|PARTNER|ENTERPRISE|'+
							   'FARMS$|QUALITY|MANAGEM|AGRICULTURAL|ANALYTICS|DIVERSIFIED|HOLDINGS| AND |TEST RECORD|EXCHANGE|^.*DESIGN|^.*FORESTRY|WORLDWIDE|MORT$|'+
								 'ADVISOR|CERTIFIED| R E$|^.* IFA$|^.* SRA |^.* SRA$|^.* REA$|DEPROSPERIS|^.* MAI|^.* CCIM|INCRP|CONSULTANT|^.*AGENCY|^.*AGENCIES|'+
								 '^.* REAL$| MSA |CPCU|INDEPENDENT| CREA$|ESTATE|JTC|^.* RE$|^.* LRA$|APRAISER|^.* ASA$|^.* I F A$|^.* PE$|^.*AUCTIONEER|^.*COPELAND|'+
								 'REALTO|^.* P C$|^.* SRPA$|^.* SCRREA$|^.* SOLE |^.*REAL$|^.*APRAISALS$|^.* CONSULT$|^.*CERTIF$|REALTOR|^.*&|^.*COMPNAY|^.*COMP$|'+
								 'A K A |^.* ARA$|^.*PROFESSION| SEE NO|^.*R E A|^.* SERV$|^.*AICP$|^.* CGA$|^.*ASOCIADOS$|COACHING|^.* LREA$|^.*PCV MURCOR|'+
								 'RESIDENT|^.* OWNER$|^.* RESI$|^.*CRREA$|^.*SRVC$| APRAISAL|^.* MSA$|^.*C M R A|USDA|^.* PC$|^.* ENTEPRISES|^.*HUD FHA|'+
								 'SENIOR SAMARITANS|GOLF CATALYST|APPRAISE|^THE | CO$| BANK|^.*WORKS|^.*SALE|^.*GROUP|^.*COMPA|'+
								 '^.*ESTES$|^.*NEW YORK|^.* RISK|^.*VALUE|^.*ACQUISITION|^.*TAX |^.*PRODUCT|^.*HOME' +
								 ')';									

	//Pattern for DBA
	DBApattern				:= '^(.*)(DBA |(DBA)|D B A |D/B/A |T/A | / )(.*)';

	//ASC National Registry to common MARIBASE layout
	Prof_License_Mari.layouts.base 		xformToCommon(Prof_License_Mari.layout_USS0814 pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;

		SELF.TYPE_CD					:= 'MD';
			
		// License Information
		SELF.LICENSE_NBR	  	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_NUMR);
		SELF.OFF_LICENSE_NBR	:= '';
		SELF.LICENSE_STATE	 	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ST_ABBR);
			
		TrimLicenseType 			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_TYPE);
		SELF.RAW_LICENSE_TYPE	:= TrimLicenseType;
			
		TrimStatus 						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATUS);
		TrimAQB 							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.AQB_COMPLIANT);
		TrimAQBValid					:= IF(REGEXFIND('([0-9]+)',TrimAQB),'UNKNOWN',TrimAQB);					//digit is not a valid compliance status, treat is as blank
		tmpStatus 						:= IF(TrimAQBValid != '',TrimStatus+' AQB COMPLIANCE-'+ TrimAQBValid,TrimStatus);
		SELF.RAW_LICENSE_STATUS := tmpStatus;
																			
		//Standardize Fields
		TrimLName							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LNAME);
		TrimFName							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.FNAME);
		TrimMNAME					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.MNAME);
		TrimNAME_SUFX					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.NAME_SUFFIX);
		TrimNAME_OFFICE 			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(StringLib.StringFilterOut(pInput.COMPANY, '='));
		TrimAddress1 					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STREET);
		TrimCity							:= IF(REGEXFIND('(^NI|NONE INDICATED|N/|\\.)',pInput.CITY, NOCASE),
		                            '',
		                            Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY));
		TrimState							:= IF(REGEXFIND('(^NI|^NO|N/|\\.)',pInput.STATE),
		                            '',
		                            Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE));
		TrimZIP 							:= IF(REGEXFIND('(NI|NONE|N/|^0$|\\.)',TRIM(pInput.ZIP),NOCASE),
		                            '',
		                            Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP));

		//Clean up suffix from suffix and last name
		tmpSuffixName					:= MAP(TrimNAME_SUFX<>''=>TrimNAME_SUFX,
																 REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimLName) 
																     => REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimLName,2),
																 REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimFName) 
																     => REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimFName,2),
																 REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimMName) 
																     => REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimMName,2),		 
																'');
		rmSufxLName						:= IF(REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimLName),
		                            REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimLName,1),
																TrimLName
																);
		rmEndingQuote					:= IF(REGEXFIND('^(.*)\'$', rmSufxLName), REGEXFIND('^(.*)\'$', rmSufxLName, 1), rmSufxLName);	
		
		rmSufxFName						:= IF(REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimFName),
		                            REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimFName,1),
																TrimFName
																);		
		rmSufxMName						:= IF(REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimMName),
		                            REGEXFIND('^(.*)(,JR| JR|,SR| SR|,III| III|,II| II|,IV| IV)[\\.]*$',TrimMName,1),
																TrimMName
																);														
		
		tempFNick							:= Prof_License_Mari.fGetNickname(rmSufxFName,'nick');
		removeFNick						:= Prof_License_Mari.fGetNickname(rmSufxFName,'strip_nick');
		cleanFNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick);
		//Special handling for Nick name in this source - First Name A/K/A Nick Name
		tempFNick1						:= MAP(REGEXFIND(' A/K/A ', cleanFNAME) => REGEXFIND(' A/K/A (.*)$',cleanFNAME,1),
		                             REGEXFIND('\'',  tempFNick) => REGEXREPLACE('\'',tempFNick,''),
																 tempFNick);
		cleanFNAME1						:= IF(REGEXFIND(' A/K/A ', cleanFNAME),REGEXFIND('^(.*) A/K/A ',cleanFNAME,1),cleanFNAME);
		tempLNick							:= Prof_License_Mari.fGetNickname(rmEndingQuote,'nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(rmEndingQuote,'strip_nick');
		cleanLNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick);
										
		SELF.NAME_ORG_PREFX		:= ''; 
		SELF.NAME_ORG		    	:= StringLib.StringCleanSpaces(
																Prof_License_Mari.mod_clean_name_addr.stripPunctName(cleanLNAME + ' ' + cleanFNAME1)
																);
		
		SELF.NAME_ORG_SUFX	  := '';
		SELF.STORE_NBR		    := '';
		SELF.NAME_FIRST		   	:= cleanFNAME1;
		SELF.NAME_MID					:= rmSufxMName;								
		SELF.NAME_LAST		   	:= cleanLNAME;
		SELF.NAME_SUFX				:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(tmpSuffixName);
		
		stripNick							:= IF(tempLNick != '',tempLNick,tempFNick1);
		stripNick1						:= IF(REGEXFIND('AKA (.*)$',stripNick),REGEXFIND('AKA (.*)$',stripNick,1),stripNick);
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(stripNick1);
		SELF.PROV_STAT				:= IF(StringLib.stringfind(TrimAddress1,'DECEASE',1) > 0 OR StringLib.stringfind(TrimNAME_OFFICE,'DECEASE',1) > 0, 'D',
																IF(StringLib.stringfind(TrimAddress1,'RETIRED',1) > 0 OR StringLib.stringfind(TrimNAME_OFFICE,'RETIRED',1) > 0, 'R',
																	''));
		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := StringLib.StringCleanSpaces(TrimFName + ' '+ TrimMNAME+ ' '+ TrimLName + ' ' + TrimNAME_SUFX);
		SELF.NAME_FORMAT    	:= 'F';
		
  	//Identifying DBA NAMES
		FixNameOffice					:= StringLib.StringFindReplace(TrimNAME_OFFICE,'(DBA ', ' DBA ');
		tmpNAME_DBA						:= IF( REGEXFIND('( DBA | D/B/A | DBA: |(DBA)| A/K/A | AKA )',FixNameOffice), Prof_License_Mari.mod_clean_name_addr.GetDBAName(FixNameOffice),
																IF( REGEXFIND('( DBA | D/B/A |^DBA| A/K/A | AKA )',TrimAddress1), Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
																				''));
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA					:= MAP( StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																								Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		SELF.NAME_DBA					:= CleanNAME_DBA;
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA); 
		SELF.DBA_FLAG		    	:= If(SELF.NAME_DBA != '',1,0);
	  TrimAddress2          := Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpOfficeNameAddr			:= MAP(REGEXFIND('^P[\\.]*[ ]*O[\\.]*[ ]*[B]*[O]*[X]*[ ]*[0-9]+ (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^P[\\.]*[ ]*O[\\.]*[ ]*[B]*[O]*[X]*[ ]*[0-9]+ (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
                                  REGEXFIND(' P[\\.]*[ ]*O[\\.]*[ ]*[B]*[O]*[X]*[ ]*[0-9]+ (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND(' P[\\.]*[ ]*O[\\.]*[ ]*[B]*[O]*[X]*[ ]*[0-9]+ (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND(' #[ ]*[0-9]+(.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND(' #[ ]*[0-9]+(.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND(' SUITE[ ]*[0-9]+ (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND(' SUITE[ ]*[0-9]+ (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('#[0-9]+(.* COMPANY)$',TrimAddress2)
																	  => REGEXFIND('#[0-9]+(.* COMPANY)$',TrimAddress2,1),
																	REGEXFIND('^([A-Z]+.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^([A-Z]+.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^([A-Z]+.* [I|L][N|L]C[\\.]*) [0-9]+',TrimAddress2)
																	  => REGEXFIND('^([A-Z]+.* [I|L][N|L]C[\\.]*) [0-9]+',TrimAddress2,1),
																	REGEXFIND('^([A-Z]+.* COMPANY) [0-9]+',TrimAddress2)
																	  => REGEXFIND('^([A-Z]+.* COMPANY) [0-9]+',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* AVENU[E]?[,]*[ ]*(.*[ |,][I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* AVENU[E]?[,]*[ ]*(.*[ |,][I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* FLOOR 2ND (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* FLOOR 2ND (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* FLOOR (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* FLOOR (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),												
																	REGEXFIND('^[0-9]+.* FL$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* FL$',TrimAddress2,1),																		
																	REGEXFIND('^[0-9]+.* LANE (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* LANE (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* BLVD (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* BLVD (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* COURT (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* COURT (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* DRIVE (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* DRIVE (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* PLACE (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* PLACE (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* R[O]*[A]*D[\\.]* (.* INC[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* R[O]*[A]*D[\\.]* (.* INC[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* SOUTH (.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* SOUTH (.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* ST[R]*[E]*[E]*[T]*[\\.]*[,]*[ ]*[N|S]*[\\.]?[W|E]?[\\.]?[ ]+(.* [I|L][N|L]C[\\.]*)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* ST[R]*[E]*[E]*[T]*[\\.]*[,]*[ ]*[N|S]*[\\.]?[W|E]*[\\.]?[ ]+(.* [I|L][N|L]C[\\.]*)$',TrimAddress2,1),
																	REGEXFIND('^[0-9]+.* ST[R]*[E]*[E]*[T]*[\\.]*[,]*[ ]*[N|S]*[\\.]?[W|E]*[\\.]?[ ]+(.* COMPANY)$',TrimAddress2)
																	  => REGEXFIND('^[0-9]+.* ST[R]*[E]*[E]*[T]*[\\.]*[,]*[ ]*[N|S]*[\\.]?[W|E]*[\\.]?[ ]+(.* COMPANY)$',TrimAddress2,1),
																	REGEXFIND('^(.* [I|L][N|L]C[\\.]*) P[\\.]*[ ]*O[\\.]*[ ]*[B]*[O]*[X]*[ ]*',TrimAddress2)
																	  => REGEXFIND('^(.* [I|L][N|L]C[\\.]*) P[\\.]*[ ]*O[\\.]*[ ]*[B]*[O]*[X]*[ ]*',TrimAddress2,1),
																	REGEXFIND('^(.* [I|L][N|L]C[\\.]*) ONE',TrimAddress2)
																	  => REGEXFIND('^(.* [I|L][N|L]C[\\.]*) ONE',TrimAddress2,1),
																	StringLib.StringFind(TrimAddress2,'CORNERSTONE APPRAISAL, INC',1) > 0
																	  => 'CORNERSTONE APPRAISAL, INC.',
																	REGEXFIND('WM  CALOMIRIS CO',TrimAddress2)
																	  => 'WM  CALOMIRIS CO',
																	REGEXFIND('^(ONE .* CTR)$',TrimAddress2)
																	  => '',
																	REGEXFIND('^(ONE .* FL)$',TrimAddress2)
																	  => '',
																	REGEXFIND('^(TWO .* CTR)$',TrimAddress2)
																	  => '',
																	REGEXFIND('^(NORTH WEST CORNER .*)',TrimAddress2)
																	  => '',
																	REGEXFIND('^([A-Z ]+ COMPANY)$',TrimAddress2)
																	  => REGEXFIND('^([A-Z ]+ COMPANY)$',TrimAddress2,1),
																	Prof_License_Mari.func_is_company(TrimAddress2) AND NOT Prof_License_Mari.func_is_address(TrimAddress2)
																	  => TrimAddress2,
																	'');	
	// Remove DBA/Address/Invalid data
		preNAME_OFFICE 			:= MAP(REGEXFIND('( DBA | D/B/A |(DBA)|/DBA| DBA:|^DBA |^DBA:|^AKA )',FixNameOffice)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(FixNameOffice),
																	REGEXFIND('( DBA | D/B/A |/DBA)',tmpOfficeNameAddr)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpOfficeNameAddr),
																	REGEXFIND('C/O ',FixNameOffice[1..4])=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(FixNameOffice),
																	TrimNAME_OFFICE = '' AND tmpOfficeNameAddr[1..4]='C/O '=>  tmpOfficeNameAddr[5..],
																	TrimNAME_OFFICE = '' AND tmpOfficeNameAddr[1..4]='DBA '=> '',
																	StringLib.stringfind(TrimNAME_OFFICE,'FX ',1) >0 => StringLib.stringfindreplace(FixNameOffice,'FX ',';FX '),
																	StringLib.stringfind(TrimNAME_OFFICE,'EXT ',1) >0 => StringLib.stringfindreplace(FixNameOffice,'EXT ',';EXT '),																
																	FixNameOffice='' AND tmpOfficeNameAddr<>'' => tmpOfficeNameAddr,
																	FixNameOffice);
		tmpNAME_OFFICE				:= MAP(preNAME_OFFICE[1..4]='DBA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE[1..4]='AKA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE);
	
		validNAME_OFFICE1			:= IF(REGEXFIND('_DBA$',tmpNAME_OFFICE),REGEXREPLACE(tmpNAME_OFFICE,'_DBA$',''),tmpNAME_OFFICE);	
		validNAME_OFFICE 			:= IF(REGEXFIND(invalid_names,validNAME_OFFICE1)AND NOT REGEXFIND(corp_ind,validNAME_OFFICE1),'',validNAME_OFFICE1);	
																													
		fxNAME_OFFICE 				:= MAP(REGEXFIND('^([A-Za-z][^\\;]+);(FX [0-9][-\\]?[0-9]+)',validNAME_OFFICE) => REGEXFIND('^([A-Za-z ][^\\;]+);(FX [0-9]?[-\\]?[0-9]+)',validNAME_OFFICE,1),
																 REGEXFIND('^(;FX [0-9]?[-\\]?[0-9]+)',validNAME_OFFICE) => '',
																 REGEXFIND('^([A-Za-z ][^\\;]+);(FX [0-9]+)',validNAME_OFFICE) => REGEXFIND('^([A-Za-z ][^\\;]+);(FX [0-9]+)',validNAME_OFFICE,1),
																 REGEXFIND('^([A-Za-z ][^\\;]+);(EXT [0-9]+)',validNAME_OFFICE) =>  REGEXFIND('^([A-Za-z ][^\\;]+);(EXT [0-9]+)',validNAME_OFFICE,1),
																 REGEXFIND('^(;EXT [0-9]+)',validNAME_OFFICE) => '',	
																 REGEXFIND('^([A-Za-z][^\\;]+);(FX SAME)',validNAME_OFFICE) =>  REGEXFIND('^([A-Za-z][^\\;]+);(FX SAME)',validNAME_OFFICE,1),
																 StringLib.stringfind(validNAME_OFFICE,' FAX ',1) > 0 => StringLib.stringfindreplace(validNAME_OFFICE,'FAX ',';'),
																 StringLib.stringfind(validNAME_OFFICE,' CELL ',1) > 0 => StringLib.stringfindreplace(validNAME_OFFICE,'CELL ',';'),
																 REGEXFIND('(.*) DBA$',validNAME_OFFICE) => REGEXFIND('(.*) DBA$',validNAME_OFFICE,1),	
																 validNAME_OFFICE);
																	
		removeOfficeAddr			:= MAP(REGEXFIND('^[0-9]',fxNAME_OFFICE) and NOT REGEXFIND(corp_ind,fxNAME_OFFICE)
																	and NOT REGEXFIND(invalid_names,fxNAME_OFFICE) => '',
				
																	REGEXFIND('[0-9]',fxNAME_OFFICE) AND prof_license_mari.func_is_address(fxNAME_OFFICE)
																	and not prof_license_mari.func_is_company(fxNAME_OFFICE)
																	and not REGEXFIND(corp_ind,fxNAME_OFFICE) => '',
																	REGEXFIND('(PLAZA STE |BUILDING | DOT DIST )',fxNAME_OFFICE) => '',
																						fxNAME_OFFICE);
													 
		removeOfficePhn 			:= MAP(REGEXFIND('^([A-Za-z \\-\\/\\&]+)[ ]([0-9]{3,}[\\-]?[0-9]{1,})',removeOfficeAddr)=> REGEXFIND('^([A-Za-z \\-\\/\\&]+)[ ]([0-9]{1,}[\\-]?[0-9]{1,})',removeOfficeAddr,1),
																 REGEXFIND('^([A-Za-z \\-\\/\\&][^\\;]+);([0-9]{3,}[\\-]?[0-9]+)*.',removeOfficeAddr) => REGEXFIND('^([A-Za-z \\-\\/\\&][^\\;]+);([0-9]{3,}[\\-]?[0-9]+)*.',removeOfficeAddr,1),
																 REGEXFIND('^([A-Za-z \\-\\/\\&\\,]+)[ ]([0-9]{3,}[ ][0-9]{3,}[\\-]?[0-9]+)',removeOfficeAddr)=> REGEXFIND('^([A-Za-z \\-\\/\\&\\,]+)[ ]([0-9]{3,}[ ][0-9]{3,}[\\-]?[0-9]+)',removeOfficeAddr,1),
																 REGEXFIND('^([A-Za-z \\-\\/\\&\\,]+)[ ]([0-9]{3,})',removeOfficeAddr) => REGEXFIND('^([A-Za-z \\-\\/\\&\\,]+)[ ]([0-9]{3,})',removeOfficeAddr,1),
																																				removeOfficeAddr);
	
	  prepADDR_OFFICE 			:= MAP(tmpOfficeNameAddr[1..4]='DBA '
											             => '',
																 REGEXFIND('^([a-zA-z\\s]{2,})',tmpOfficeNameAddr) AND NOT REGEXFIND('[0-9]',tmpOfficeNameAddr)
																 AND NOT prof_license_mari.func_is_address(tmpOfficeNameAddr)
																 AND NOT REGEXFIND('( CENTER| PLAZA | BUILDING| LN|SQUARE|RV PARK)',tmpOfficeNameAddr)
																   => tmpOfficeNameAddr,
																 '');
															
		GoodNAME_OFFICE 			:= IF(removeOfficePhn != '', removeOfficePhn,prepADDR_OFFICE);
		slashNAME_OFFICE 			:= StringLib.stringfindreplace(GoodNAME_OFFICE,'/',' '); 
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(slashNAME_OFFICE);
		CleanNAME_OFFICE 			:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE)
		                               => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																 TRIM(StdNAME_OFFICE,LEFT,RIGHT)='-' 
																   => '',	
																 TRIM(StdNAME_OFFICE,LEFT,RIGHT)='NONE INDICATED' 
																   => '',	
																 TRIM(StdNAME_OFFICE,LEFT,RIGHT)='SELF EMPLOYED'
																   => '',
																 Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StringLib.StringCleanSpaces(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE			:= MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.name_first + SELF.name_mid + SELF.name_last + SELF.name_sufx,ALL) => '',
		                             TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.name_last + SELF.name_first + SELF.name_mid + SELF.name_sufx,ALL) => '',
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.name_first + SELF.name_mid + SELF.name_last,ALL) => '',
                                 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.name_first + SELF.name_last,ALL) => '', 	
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.name_last + SELF.name_first,ALL) => '',
																 STD.Str.FilterOut(CleanNAME_OFFICE,'.') = STD.Str.FilterOut(SELF.name_org_orig,'.') => '',
																 REGEXFIND(SELF.name_last,CleanNAME_OFFICE) AND REGEXFIND(SELF.name_first,CleanNAME_OFFICE)=> '',														 
																 TRIM(CleanNAME_OFFICE,LEFT,RIGHT));	

		SELF.OFFICE_PARSE			:= MAP(SELF.NAME_OFFICE = ''  => '',
		                             SELF.NAME_OFFICE != '' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 
																						AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'GR',
																 SELF.NAME_OFFICE != '' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 
																						AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
																 SELF.NAME_OFFICE != '' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
																 SELF.NAME_OFFICE != '' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
																 SELF.NAME_OFFICE != '' AND REGEXFIND(Office_Pattern,TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)) => 'GR',
																 SELF.NAME_OFFICE != '' AND REGEXFIND('[0-9/]',SELF.NAME_OFFICE) => 'GR',
																 SELF.NAME_OFFICE != '' AND REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',SELF.NAME_OFFICE) => 'GR', 
																 'MD');
				 
		//Reformatting date to YYYYMMDD
		xformIssDate 					:= Prof_License_Mari.DateCleaner.norm_date3(pInput.ISSUE_DATE);
		xformExpDate 					:= Prof_License_Mari.DateCleaner.norm_date3(pInput.EXP_DATE);
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUE_DATE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(xformIssDate),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXP_DATE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(xformExpDate),'17530101');
		//SELF.RENEWAL_DTE			:= '';
			
/* 		SELF.NAME_DBA_ORIG	  := IF(REGEXFIND('( DBA | D/B/A |^DBA )',TrimNAME_OFFICE),TrimNAME_OFFICE,
   																IF(REGEXFIND('( DBA | D/B/A )',TrimAddress1),TrimAddress1,'')); 
*/
		SELF.NAME_DBA_ORIG		:= IF(TRIM(SELF.NAME_DBA)<>'',tmpNAME_DBA,'');
		SELF.NAME_MARI_ORG	  := IF(SELF.office_parse = 'GR',CleanNAME_OFFICE,'');
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
		
		tmpPHONE              := ut.CleanPhone(pInput.PHONE);
		SELF.PHN_MARI_1				:= MAP(tmpPHONE = '(NULL)'=> '',
																 tmpPHONE = '0000000000' => '',
																 tmpPHONE);
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimCITY + pInput.ZIP) != '','B','');
										
		//Use address cleaner to clean address
                      
		tmpZip	              := MAP(LENGTH(TRIM(TrimZip))=3 => '00'+TrimZip,
		                             LENGTH(TrimZip)=4 => '0'+TrimZip,
																 TrimZip);
		  		
	  //Extract company name
															 
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern);
		clnAddress1_1					:= MAP(REGEXFIND('C/O$', clnAddress1) => REGEXREPLACE('C/O$',clnAddress1,''),
		                             StringLib.StringFind(clnAddress1,'NONSUFFICIENT FUNDS',1) > 0 => '',
																 clnAddress1);
		clnAddress1_2					:= MAP(REGEXFIND('(C/O |DBA|D/B/A)',clnAddress1_1) AND NOT REGEXFIND('RV PARK',clnAddress1_1) => '',
   																 REGEXFIND('^([a-zA-z\\s]{2,})',clnAddress1_1) AND NOT REGEXFIND('[0-9]',clnAddress1_1)
   																 AND NOT prof_license_mari.func_is_address(clnAddress1_1)
   																 AND NOT REGEXFIND('( CENTER| PLAZA| BUILDING| LN|SQUARE|RV PARK)',clnAddress1_1)=> '',
   																 REGEXFIND('SEE DCRA MANAGER FOR ANY REQUEST 7506',clnAddress1_1) => '',
   																 REGEXFIND('RECEIVED NONSUFFICIENT FUN',clnAddress1_1) => '',
   																 REGEXFIND('SEE DCRA MANAGER FOR ANY REQUEST 7506',clnAddress1_1) => '',
   																 REGEXFIND('RECEIVED NONSUFFICIENT FUN',clnAddress1_1) => '',
   																 clnAddress1[1..3]='N/I' OR clnAddress1_1[1..3]='N/A' OR clnAddress1_1[1..3]='N/L'=> '',
   																 StringLib.StringFind(clnAddress1_1,'P-.O.',1)>0 => StringLib.StringFindReplace(clnAddress1_1,'P-.O.','P.O.'),
   																 StringLib.StringFind(clnAddress1_1,'P. 0.',1)>0 => StringLib.StringFindReplace(clnAddress1_1,'P. 0.','PO'),
   																 clnAddress1_1);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1_2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != ''
		                               => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1='' 
		                               => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact!='' OR tmpADDR_ADDR1_1='','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_CNTY_1			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.COUNTY);
		SELF.PHN_PHONE_1			:= SELF.PHN_MARI_1;
	
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		
		TrimDispAction 				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.DISCIPLINARY_ACTION);
		SELF.DISP_TYPE_CD			:= MAP(TrimDispAction = 'VOLUNTARY SURRENDER' => 'V',
																	TrimDispAction = 'SUSPENSION' => 'D',
																	TrimDispAction = 'REVOCATION' => 'R',
																	REGEXFIND(displinary_action,TrimNAME_OFFICE)=>'Q',
																				'');

		SELF.DISP_TYPE_DESC		:= CASE(SELF.DISP_TYPE_CD,
																'C' =>  'CHARGES FILED',
																'D' =>  'DISCIPLINARY ACTION',
																'L' =>  'LETTER OF REPRIMAND',
																'O' => 	'PRIOR DISCIPLINE ACTION',
																'P' => 	'PROBATION',
																'Q' => 	'POSSIBLE DISCIPLINARY ACTION',
																'R' => 	'REVOKED',
																'V' => 	'VOLUNTARY SURRENDER TO AVOID FURTHER DISCIPLINARY ACTION',
																				'');

		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.type_cd  = 'MD' => 'IN',
															 SELF.type_cd  = 'GR' => 'CO','');

		SELF.MLTRECKEY				:= 0;
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			//+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.RAW_LICENSE_TYPE,LEFT,RIGHT)
																			+TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																			+TRIM(SELF.NAME_DBA_ORIG,LEFT,RIGHT)
																			+TRIM(SELF.DISP_TYPE_CD,LEFT,RIGHT)    //There are records with same info but differnt disciplinary actions
//																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STREET)
//																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY)
//																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP));
			                                +TRIM(SELF.ADDR_ADDR1_1)
			                                +TRIM(SELF.ADDR_ADDR2_1)
			                                +TRIM(SELF.ADDR_CITY_1)
																			+TRIM(SELF.ADDR_ZIP5_1));
																									 
																									
		SELF.PCMC_SLPK				:= 0;
		
		violation_data 				:= MAP(TrimDispAction!= '' => TrimDispAction,
																 REGEXFIND(displinary_action,TrimNAME_OFFICE) => StringLib.StringCleanSpaces(TrimNAME_OFFICE),
																 REGEXFIND('INACTIVE NONRENEW',TrimAddress1) => StringLib.StringCleanSpaces(TrimAddress1),
																 '');
		fmt_viol_data  				:= IF(StringLib.Stringfind(violation_data,' CASE',1) >0
																and not StringLib.stringfind(violation_data,', CASE',1) > 0,StringLib.stringfindreplace(violation_data,' CASE',', CASE'),violation_data);
		SELF.VIOL_DESC				:= MAP(REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9]+)',fmt_viol_data)=> REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9]+)',fmt_viol_data,1),
																 REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data) =>
																					REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data,1),
																 REGEXFIND('^([0-9A-Za-z\\-][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data) =>		
																					REGEXFIND('^([0-9A-Za-z\\-][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data,1),
																										fmt_viol_data);
		
		getViolDate						:= MAP(REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data) =>
																 REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data,2),
															   REGEXFIND('^([0-9A-Za-z\\-][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data) =>		
																 REGEXFIND('^([0-9A-Za-z\\-][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data,2),
															   REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9]+)',fmt_viol_data)=> REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9]+)',fmt_viol_data,2),
															   REGEXFIND('REV ([0-9]/[0-9]{2}) ',fmt_viol_data)=> REGEXFIND('REV ([0-9]/[0-9]{2}) ',fmt_viol_data,1),
																 REGEXFIND('NONRENEW ([0-9]+/[0-9]{2})',TrimAddress1) => REGEXFIND('NONRENEW ([0-9]+/[0-9]{2})',fmt_viol_data,1),
																						'');
																			
		fmtViolDate 					:= MAP(TRIM(getViolDate) = '' => '',
																Length(TRIM(getViolDate)) >= 6 => Prof_License_Mari.DateCleaner.fix_date(getViolDate,'/'),
																				Prof_License_Mari.DateCleaner.fix_date_yr(getViolDate,'/'));
													
		
		SELF.VIOL_DTE					:= MAP(fmtViolDate = '00000000' => ' ',
																 fmtViolDate != '' and Length(TRIM(fmtViolDate,LEFT,RIGHT)) = 10 => Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(fmtViolDate),
																 fmtViolDate != '' and Length(TRIM(fmtViolDate,LEFT,RIGHT)) < 10 =>	fmtViolDate[4..7]+fmtViolDate[1..2]+'00',
																	' ');
																				
																				
		SELF.VIOL_CASE_NBR		:= MAP(REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data) =>
																				REGEXFIND('^([A-Za-z][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data,3),
															 REGEXFIND('^([0-9A-Za-z\\-][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data) =>		
																				REGEXFIND('^([0-9A-Za-z\\-][^0-9]+)([0-9][\\/][0-9][\\/]?[0-9]?[^\\,]+),[ ](CASE [\\#]?[0-9]{1,}[\\-]?[0-9]{1,})',fmt_viol_data,3),
																							'');
		SELF.VIOL_EFF_DTE			:= '';
			
		SELF 									:= [];	
				 
	END;
	
	inFileLic	:= project(GoodFilterRec,xformToCommon(LEFT));

	//Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	 ds_map_status_trans := JOIN(inFileLic, cmvTransLkp,
							 TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							 AND RIGHT.fld_name='LIC_STATUS' ,
							 trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);



	// Populate STD_LICENSE_TYPE field via translation on license type field
	Prof_License_Mari.layouts.base 	trans_lic_type1(ds_map_status_trans L, cmvTransLkp R) := TRANSFORM
		SELF.STD_LICENSE_TYPE := R.DM_VALUE1;
		SELF := L;
	END;


	//ds_map_lic_trans := JOIN(inFileLic, cmvTransLkp,
	ds_map_lic_trans1 := JOIN(ds_map_status_trans, cmvTransLkp,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'LIC_TYPE',
							trans_lic_type1(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																			
	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base 	trans_lic_type2(ds_map_lic_trans1 L, cmvTransLkp R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_lic_trans1, cmvTransLkp,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type2(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																			

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(ds_map_lic_trans L) := TRANSFORM
		tmpAddr1_1 := StringLib.Stringfindreplace(L.ADDR_ADDR1_1,'C/O ',' ');
		SELF.ADDR_ADDR1_1		:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(tmpAddr1_1);
		SELF.ADDR_ADDR2_1		:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1);
		SELF := L;
	END;

	ds_map_base 				:= PROJECT(ds_map_lic_trans, xTransToBase(LEFT));
	
	//dedup to remove dup records
	ds_map_base_dedup		:= DEDUP(SORT(ds_map_base, cmc_slpk), RECORD);
	
	d_final 						:= OUTPUT(ds_map_base_dedup, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base_dedup);
	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'asc','using','used');	

																	);

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oAPR, Ocmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;