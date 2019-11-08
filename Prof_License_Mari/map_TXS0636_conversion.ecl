/* Converting Texas Office of Consumer Credit Commissioner / Other Lenders // Professions Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard,STD;

EXPORT map_TXS0636_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt:Prof License MARI - TXS0636  ' + pVersion);
	code 								:= 'TXS0636';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation			:= OUTPUT(Cmvtranslation);
	 
	inFile  := Prof_License_Mari.file_TXS0636;
	oLender	:= OUTPUT(inFile);
	
	//Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions  := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS|'+
										'PALM HARBOR |SUNTRUST BANK|PIONEER BANK|LENDING\\>| FINANCE\\>|CORP\\>|BROKERS| HOME |EVOFI ONE|^AMERI|L.L.C.| LP\\>|LOANS|'+
										'.COM| L.C.|SOUTHWEST |HAMPTON COTTAGE|CORPORTION|CORPORAITON|CENTURA BANK|FIDELITY|EXCLUSIVE|PLC|ET AL|CO\\>|SFMC L P)';

	MiscExceptions := '(C.I.T. GROUP|C I T GROUP|CIT GROUP|ATM/|ATM /|ATM, |ATM |BRANCH|C.I.T. GROUP|T/S |D/FW |FLORES/ALVAREZ|A/T/S|I/C|LAND/HOME|'+
										'K/O |C/U$|NORTHLAND/MARQUETTE|A/R |BANK/|BANK /|S/W TAX|SW CON/|FCU/|/MORTGAGE|/ALBUQUERQUE|/ ALBUQUERQUE|'+
										'/TEXAS|/ PUEBLO| ALABAMA/|/CASINO|/SAN PEDRO|/ANTHONY,NM|MILLER/JOHNSTON INC|FIRST / CITY LOAN INC)';
	CoPattern	     :=	'(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.*L.P.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
										  '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^DELOITTE|' +
										  '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|LICENSING - LEGAL|' +
										  '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CP$|' +
									 	  '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.*CORPORATE LICENSING.*$|^.* MANAGER.*$' +
										  ')';
												
	RemovePattern	 := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
												'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
												'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^C/O .*$|^CO .*$|^ATTN: .*$|^ATTN.*$|^ATT: .*$| C/O .*$|' +
												'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CP$|' +
												'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^PENDING$|^.*INDIES$|^RAYMOND SAMBROTTO$|' +
												'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|^.* GENERAL DELIVERY|^.* VISTA VILLAGE$|^.* INDUSTRIAL ESTATES|' +
												' WELDIN BUILDING$|^.* LAKE RESORT$| ATTN:.*$|^ATTENTION.*$|^BANK ONE BLDG|^.* HIDDEN RIVER CORP PARK$|^.*CORPORATE LICENSING.*$|^.* MANAGER.*$' +
												')';
	//invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|TBD|NOT CURRENTLY)';
	C_O_Ind := '(C/O |ATTN:|ATTN |ATT: |ATTENTION )';
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	

	//Filtering out BAD RECORDS
	ut.CleanFields(inFile,inFile_clean);	
	FilterHeaderRec := inFile_clean(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LICENSEE)));
	FilterBlankRec	:= FilterHeaderRec(~(LICENSEE = '' AND LICENSEE_ADDL = ''));
	GoodFilterRec 	:= FilterBlankRec(NOT REGEXFIND('LIC #',StringLib.StringToUpperCase(LIC_NUMR)));

	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in xformToCommon(GoodFilterRec  pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;		//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= src_st;

		//Standardize Fields
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.LICENSEE);
		TrimNAME_ORG_Addl			:= ut.CleanSpacesAndUpper(pInput.LICENSEE_ADDL);
		TrimNAME_DBA					:= ut.CleanSpacesAndUpper(pInput.DBA_OPER_NAME);
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS);
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.ADDRESS_2);
		TrimCity			 				:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState             := ut.CleanSpacesAndUpper(pInput.STATE);
		TrimLIC_TYPE 					:= ut.CleanSpacesAndUpper(pInput.LICENSETYPE);
		TrimCNTY							:= ut.CleanSpacesAndUpper(pInput.COUNTY);
		
		//Master/Home Address
		TrimMastAddress1			:= ut.CleanSpacesAndUpper(pInput.MAST_ADDRESS);
		TrimMastAddress2			:= ut.CleanSpacesAndUpper(pInput.MAST_ADDRESS_2);
		TrimMastCity					:= ut.CleanSpacesAndUpper(pInput.MAST_CITY);
		TrimMaatCNTY					:= ut.CleanSpacesAndUpper(pInput.MAST_COUNTY);
				
		// License Information
		SELF.LICENSE_NBR	  	:= IF(pInput.LIC_NUMR != '',ut.CleanSpacesAndUpper(pInput.LIC_NUMR),'NR');
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		tmpLIC_TYPE						:= CASE(TrimLIC_TYPE,
																			'CONSUMER INSTALLMENT LOANS $520-13K' => 'CL$520-13K',
																			'HOME EQUITY LOANS' => 'HEL',
																			'SECONDARY MORTGAGES' => 'SM',
																			'UNSECURED LOANS UP TO $520' => 'UL$520',  
																			'REGULATED LOAN' => 'RGL',
																			'REGULATED LENDER' =>  'REGL',
																			'CREDIT ACCESS BUSINESS' => 'CAB',
																			'MOTOR VEHICLE SALES FINANCE' => 'MVR',
																			'PAWN SHOP' => 'PS','');
																			
		SELF.STD_LICENSE_TYPE := tmpLIC_TYPE;
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.STATUS);
		SELF.TYPE_CD					:= 'GR';
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		tmpIssueDate 					:= StringLib.StringFilterOut(TRIM(pInput.LICENSEDATE),' ');
		SELF.ORIG_ISSUE_DTE		:= IF(tmpIssueDate != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(tmpIssueDate),'17530101');
		SELF.EXPIRE_DTE				:= SELF.LAST_UPD_DTE[1..4] + '1231';
    SELF.RENEWAL_DTE			:= IF(TRIM(pInput.LAST_RENEWED_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.LAST_RENEWED_DATE));
				
		tempNAME_ORG := IF(TrimNAME_ORG != '', TrimNAME_ORG, TrimNAME_ORG_Addl);
		tempNick							:= Prof_License_Mari.fGetNickname(tempNAME_ORG,'nick');
		stripNickName					:= Prof_License_Mari.fGetNickname(tempNAME_ORG,'strip_nick');
		GoodName							:= IF(tempNick != '',stripNickName,tempNAME_ORG);
		
   //Prepping NAME_ORG Field		
    rmvDBA_ORG := IF(REGEXFIND(DBA_Ind,tempNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempNAME_ORG),
																tempNAME_ORG);		
		rmvOFF_ORG	:= IF(REGEXFIND(C_O_Ind,rmvDBA_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(rmvDBA_ORG),
																rmvDBA_ORG);	
		getNAME_ORG := IF(REGEXFIND('(INC)',tempNick),Prof_License_Mari.mod_clean_name_addr.strippunctName(rmvOFF_ORG),rmvOFF_ORG);
		
		ParsedName := MAP(tmpLIC_TYPE != '' AND StringLib.Stringfind(TRIM(getNAME_ORG,LEFT,RIGHT),' ',1) <= 0 => '',
											tmpLIC_TYPE != '' AND NOT Prof_License_Mari.func_is_company(getNAME_ORG) 
											AND NOT REGEXFIND(BusExceptions,getNAME_ORG)
											AND StringLib.Stringfind(getNAME_ORG,',',1) > 0 => Address.CleanPersonLFM73(GoodName),
													
											tmpLIC_TYPE != '' AND NOT Prof_License_Mari.func_is_company(getNAME_ORG) 
											AND NOT REGEXFIND(BusExceptions,getNAME_ORG)
											AND NOT StringLib.Stringfind(getNAME_ORG,',',1) > 0 => Address.CleanPersonFML73(GoodName),'');
													
		FirstName := TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   := TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  := TRIM(ParsedName[46..65],LEFT,RIGHT); 
		Suffix	  := TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL := 	StringLib.StringCleanSpaces(LastName +' '+FirstName);
														
    // Corporation Names
		tmpNAME_ORG := IF(StringLib.stringfind(getNAME_ORG,'/',1) > 0 AND NOT REGEXFIND(MiscExceptions,getNAME_ORG), REGEXFIND('^([0-9A-Za-z][^\\/]+)[\\/]',getNAME_ORG,1),getNAME_ORG);
		StdNAME_ORG := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TRIM(tmpNAME_ORG,LEFT,RIGHT));
		CleanNAME_ORG	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
												 REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
											
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																								Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(ParsedName != '',ConcatNAME_FULL,StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'()','')));
		tmpORG_SUFX           := IF(StringLib.Stringfind(tempNICK,'INC',1) > 0, tempNICK,
														Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)));
		SELF.NAME_ORG_SUFX	  := StringLib.StringFilterOut(tmpORG_SUFX,' ');		
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= IF(ParsedName != '' AND tempNick != '', StringLib.StringCleanSpaces(tempNick),'');
		SELF.PROV_STAT				:= MAP(SELF.RAW_LICENSE_STATUS = 'DECEASED' =>'D',
																 SELF.RAW_LICENSE_STATUS = 'RETIRED' =>'R','');
																 
		SELF.CREDENTIAL				:= tempNick;
		
		getORG_DBA  := IF(REGEXFIND(DBA_Ind,tempNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempNAME_ORG),'');
		getNAME_DBA := MAP(STD.Str.FilterOut(TrimNAME_ORG, '.,') = STD.Str.FilterOut(TrimNAME_DBA, '.,') =>'',
											 REGEXFIND('(CANCELLED |CLOSED |SEE MEMO)',TrimNAME_DBA)=> '',TrimNAME_DBA);
		
		tmpNAME_DBA := MAP(StringLib.stringfind(getNAME_DBA,'D/B/A ',1) > 0 => StringLib.stringfindreplace(getNAME_DBA,'D/B/A ','| '),
											 StringLib.stringfind(getNAME_DBA,'DBA ',1) > 0 => StringLib.stringfindreplace(getNAME_DBA,'DBA ','| '),
											 StringLib.stringfind(getNAME_DBA,'AND/OR',1) > 0 => StringLib.stringfindreplace(getNAME_DBA,'AND/OR','/ '),
																														getNAME_DBA);
		StdNAME_DBA := StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA));
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																								Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA							:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_DBA,'()',''));
		tmpDBASufx := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));
		SELF.NAME_DBA_SUFX	  		:= StringLib.StringFilterOut(tmpDBASufx,' '); 
		SELF.STORE_NBR_DBA				:= '';
		SELF.DBA_FLAG							:= IF(SELF.NAME_DBA != '',1,0);
		
		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := tempNAME_ORG;
		SELF.NAME_FORMAT 			:= IF(tmpLIC_TYPE != '' 
		                            AND NOT Prof_License_Mari.func_is_company(getNAME_ORG) 
											          AND NOT REGEXFIND(BusExceptions,getNAME_ORG)
											          AND StringLib.Stringfind(getNAME_ORG,',',1) > 0,
																'L',
											          'F');
		
		SELF.NAME_DBA_ORIG	  := TrimNAME_DBA;
		SELF.NAME_MARI_ORG	  := StdNAME_ORG;
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
		tmpPHN 								:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(pInput.PHONE);
		ClnPHN_MARI			    	:= TRIM(StringLib.StringFilter(tmpPHN,'0123456789'),LEFT,RIGHT);
		ClnPHN_PHONE   			  := TRIM(StringLib.StringFilter(tmpPHN,'0123456789'),LEFT,RIGHT);
		
		SELF.PHN_MARI_1				:= IF(ClnPHN_MARI <> '5555555555',ClnPHN_MARI,'');
		SELF.PHN_PHONE_1			:= IF(ClnPHN_PHONE <> '5555555555',ClnPHN_PHONE,'');
		
		tmpFAX 								:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(pInput.FAX_NUMBER);
		SELF.PHN_MARI_FAX_1		:= TRIM(StringLib.StringFilter(tmpFAX,'0123456789'),LEFT,RIGHT);
		SELF.PHN_FAX_1				:= TRIM(StringLib.StringFilter(tmpFAX,'0123456789'),LEFT,RIGHT);
		
		tmpPHN_MAST 					:= IF(TRIM(pInput.MASTER_PHONE) = 'NULL','',Prof_License_Mari.mod_clean_name_addr.strippunctMisc(pInput.MASTER_PHONE));
		tmpFAX_MAST 					:= IF(TRIM(pInput.MASTER_FAX) = 'NULL','',Prof_License_Mari.mod_clean_name_addr.strippunctMisc(pInput.MASTER_FAX));
		ClnPhn_Mast           := TRIM(StringLib.StringFilter(tmpPHN_MAST,'0123456789'),LEFT,RIGHT);
		ClnPhn_Mast_Fax       := TRIM(StringLib.StringFilter(tmpFAX_MAST,'0123456789'),LEFT,RIGHT);
		
		SELF.PHN_MARI_2			  := IF(ClnPhn_Mast <> '5555555555',ClnPhn_Mast,'');		
		SELF.PHN_MARI_FAX_2	  := IF(ClnPhn_Mast_Fax <> '5555555555',ClnPhn_Mast_Fax,'');
		SELF.PHN_PHONE_2		  := IF(ClnPhn_Mast <> '5555555555',ClnPhn_Mast,'');
		SELF.PHN_FAX_2			  := IF(ClnPhn_Mast_Fax <> '5555555555',ClnPhn_Mast_Fax,'');
		
		//Use address cleaner to clean address
		tmpZip	       				:= MAP(LENGTH(TRIM(pInput.ZIP_CODE))=3 => '00'+TRIM(pInput.ZIP_CODE),
		                             LENGTH(TRIM(pInput.ZIP_CODE))=4 => '0'+TRIM(pInput.ZIP_CODE),
																 TRIM(pInput.ZIP_CODE));
		
		care_of_ind := '^([0-9A-Z\\s]+)C/O (.*)$';
		tmpBusNameContact1		:= IF(REGEXFIND(care_of_ind,TrimAddress1),REGEXFIND(care_of_ind,TrimAddress1,2),
																Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern));
		tmpBusNameContact2		:= IF(REGEXFIND(care_of_ind,TrimAddress2),REGEXFIND(care_of_ind,TrimAddress2,2),
																Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress2, CoPattern));
																
		tmpBusNameMastContact1		:= IF(REGEXFIND(care_of_ind,TrimMastAddress1),REGEXFIND(care_of_ind,TrimMastAddress1,2),
																		IF(REGEXFIND('^(C/O([0-9A-Z\\s]+))$', TRIM(TrimMastAddress1)),'',
																		  Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimMastAddress1, CoPattern)));
		tmpBusNameMastContact2		:= IF(REGEXFIND(care_of_ind,TrimMastAddress2),REGEXFIND(care_of_ind,TrimMastAddress2,2),
																			IF(REGEXFIND('^(C/O([0-9A-Z\\s]+))$', TRIM(TrimMastAddress2)),'',
																				Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimMastAddress2, CoPattern)));
		
 		clnAddress1						:= IF(REGEXFIND(care_of_ind,TrimAddress1),REGEXFIND(care_of_ind,TrimAddress1,1),
																Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern));
		clnAddress2						:= IF(REGEXFIND(care_of_ind,TrimAddress2),REGEXFIND(care_of_ind,TrimAddress2,1),
																Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress2, RemovePattern));

		clnMastAddress1				:= IF(REGEXFIND(care_of_ind,TrimMastAddress1),REGEXFIND(care_of_ind,TrimMastAddress1,1),
																   IF(REGEXFIND('(^.*) (C/O |ATTENTION |ATTN )',TrimMastAddress1),REGEXFIND('(^.*) (C/O |ATTENTION |ATTN )',TrimMastAddress1,1), 
																      IF(REGEXFIND(C_O_Ind,TrimMastAddress1),'',TrimMastAddress1)));
		clnMastAddress2				:= IF(REGEXFIND(care_of_ind,TrimMastAddress2),REGEXFIND(care_of_ind,TrimMastAddress2,1),
																   IF(REGEXFIND('(^.*) (C/O |ATTENTION |ATTN )',TrimMastAddress1),REGEXFIND('(^.*) (C/O |ATTENTION |ATTN )',TrimMastAddress1,1), 
																	  	IF(REGEXFIND(C_O_Ind,TrimMastAddress2),'',TrimMastAddress2)));
    goodMastAddress1      := stringlib.stringfilterout(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(clnMastAddress1, RemovePattern),',$');
		goodMastAddress2      := stringlib.stringfilterout(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(clnMastAddress2, RemovePattern),',$');
 
    //*Care of NAMES in Address field
		addrOfficeName 	:= MAP( tmpBusNameContact1 != '' => tmpBusNameContact1,
														tmpBusNameContact2 != '' => tmpBusNameContact2,
														tmpBusNameMastContact1 != '' => tmpBusNameMastContact1,
														tmpBusNameMastContact2 != '' => tmpBusNameMastContact2,
																														'');
																														
		getNAME_OFFICE  := MAP(tempNAME_ORG = TrimNAME_ORG_Addl => '',
		                       TrimNAME_ORG_Addl != '' => TrimNAME_ORG_Addl, 
													 addrOfficeName = 'LICENSING - LEGAL' => '',
												   addrOfficeName[1..7] = 'LICENSE' => '',
													 addrOfficeName[1..6] = 'ATTN: ' => addrOfficeName[7..],
													 addrOfficeName[1..5] in ['ATT: ','ATTN '] => addrOfficeName[6..],
													 addrOfficeName[1..10]= 'ATTENTION ' => addrOfficeName[11..],
													 addrOfficeName[1..4] = 'C/O ' => addrOfficeName[5..],
													 Prof_License_Mari.func_is_address(addrOfficeName)=>'',
													 addrOfficeName);
												 
		StdNAME_OFFICE	 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);
													 
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
	  SELF.NAME_OFFICE	    := MAP(NOT REGEXFIND('[A-Za-z]',CleanNAME_OFFICE)=>'',
		                             CleanNAME_OFFICE = 'CORP LICENSING' => '',
		                             STD.str.CleanSpaces(CleanNAME_OFFICE)); 																	
		SELF.OFFICE_PARSE			:= MAP(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)=>'GR',
		                             SELF.NAME_OFFICE != '' AND REGEXFIND(CoPattern,SELF.NAME_OFFICE)=>'GR',
																 SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)=>'MD',
																 '');

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1 + ' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_BUS_IND			:= IF(TrimAddress1 + pInput.ZIP_CODE != '','B','');
		GoodADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
		                            IF(tmpADDR_ADDR1_1 = '', clnAddress1,
																		StringLib.StringCleanSpaces(tmpADDR_ADDR1_1)));	
		SELF.ADDR_ADDR1_1			:= IF(GoodADDR_ADDR1_1 <> '', GoodADDR_ADDR1_1,'');												
		GoodADDR_ADDR2_1			:= IF(AddrWithContact != '','',
																IF(tmpADDR_ADDR2_1 = '', clnAddress2,
																		StringLib.StringCleanSpaces(tmpADDR_ADDR2_1))); 
		SELF.ADDR_ADDR2_1		  := IF(GoodADDR_ADDR1_1 <> '' and GoodADDR_ADDR2_1 <> GoodADDR_ADDR1_1, GoodADDR_ADDR2_1,
		                            IF(GoodADDR_ADDR1_1 <> '' and GoodADDR_ADDR2_1 = GoodADDR_ADDR1_1, '',
																    GoodADDR_ADDR2_1));														
		SELF.ADDR_ADDR3_1			:= '';
		SELF.ADDR_ADDR4_1			:= '';
		SELF.ADDR_CITY_1		  := IF(TrimCity IN ['BANGALORE','PAMPANGA','PANAMA CITY'],
		                            TrimCity + ' ' + TRIM(TrimState),
		                            IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity));
		SELF.ADDR_STATE_1		  := IF(TrimCity IN ['BANGALORE','PAMPANGA','PANAMA CITY'],
		                            '',
		                            IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState));
		SELF.ADDR_ZIP5_1		  := IF(TrimCity IN ['BANGALORE','PAMPANGA','PANAMA CITY'],
		                            '',
		                            IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]));
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
   	SELF.ADDR_CNTY_1			:= TrimCNTY;
		SELF.OOC_IND_1				:= IF(TrimCity IN ['BANGALORE','PAMPANGA','PANAMA CITY'],1,0);
		
		SELF.ADDR_MAIL_IND		:= IF(TrimMastAddress1 + pInput.MAST_ZIP_CODE != '','H','');
		SELF.ADDR_ADDR1_2			:= IF(TRIM(goodMastAddress1) = '',goodMastAddress2,goodMastAddress1);
		SELF.ADDR_ADDR2_2			:= IF(goodMastAddress1 != '',goodMastAddress2,'');
		SELF.ADDR_ADDR3_2			:= '';
		SELF.ADDR_ADDR4_2			:= '';
		SELF.ADDR_CITY_2		  := TrimMastCity;
		SELF.ADDR_STATE_2		  := pInput.MAST_STATE;
	
  	//Master/Home Address--09/18/2015
	  tmpMastZip	       		:= MAP(LENGTH(TRIM(pInput.MAST_ZIP_CODE))=3 => '00'+TRIM(pInput.MAST_ZIP_CODE),
		                             LENGTH(TRIM(pInput.MAST_ZIP_CODE))=4 => '0'+TRIM(pInput.MAST_ZIP_CODE),
																 TRIM(pInput.MAST_ZIP_CODE));
		ParsedMailZIP       	:=  REGEXFIND('[0-9]{5}[\\-]?([0-9]{4})?$',TRIM(tmpMastZip), 0);
  	SELF.ADDR_ZIP5_2			:= ParsedMailZIP[1..5];
   	SELF.ADDR_ZIP4_2			:= IF(LENGTH(ParsedMailZIP) = 9, ParsedMailZIP[6..9],ParsedMailZIP[7..10]);
	 	SELF.ADDR_CNTY_2			:= TrimMaatCNTY;
		
		SELF.DISP_TYPE_CD     := MAP(SELF.RAW_LICENSE_STATUS = 'ADMINISTRATIVE SUSPENSION' => 'Q',
																 SELF.RAW_LICENSE_STATUS = 'REVOKED LICENSE' => 'R',
																 SELF.RAW_LICENSE_STATUS = 'SUSPENDED LICENSE' => 'Q',
																 SELF.RAW_LICENSE_STATUS = 'VOLUNTARY SURRENDER' => 'V',																 
																	'');
		SELF.DISP_TYPE_DESC	  := CASE(SELF.DISP_TYPE_CD,
																		'C' => 'CHARGES FILED',
																		'D' => 'DISCIPLINARY ACTION',
																		'L' => 'LETTER OF REPRIMAND',
																		'O' => 'PRIOR DISCIPLINE ACTION',
																		'P' => 'PROBATION',
																		'Q' => 'POSSIBLE DISCIPLINARY ACTION',
																		'R' => 'REVOKED',
																		'V' => 'VOLUNTARY SERRENDER TO AVOID FURTHER DISCIPLINARY ACTION',
																				'');
		//SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		
		//Populate contact information
		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,trimAddress1)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress1),
		                             REGEXFIND(C_O_Ind,trimAddress2)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress2),
																 REGEXFIND(C_O_Ind,TrimMastAddress1)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimMastAddress1),
																 REGEXFIND(C_O_Ind,TrimMastAddress2)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimMastAddress2),
																 '');
																																							
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 REGEXFIND(CoPattern,tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
		ParseContact					:= IF(prepAddr1Contact != '',Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),'');
						
																 																 
		SELF.NAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);														 
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST 	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX 	:= TRIM(ParseContact[66..70],LEFT,RIGHT); 	
			
															
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO','');		
		
		//Store master file number
		SELF.MISC_OTHER_ID		:= ut.CleanSpacesAndUpper(pInput.MAST_FILE_NUMR);
		SELF.misc_other_type	:= 'MAS_FIL_NR';
		
		//store cancel date
		tmpCancelDate					:= ut.CleanSpacesAndUpper(pInput.DATE_CANCELLED);
		SELF.provnote_2				:= TRIM(IF(REGEXFIND('[-09]+',tmpCancelDate),'DATE CANCELLED=' + tmpCancelDate+';','')
														     + IF(pInput.PRIM_BUS_TYPE != '', 'AUTH PRIM TYPE OF BUS=' + TRIM(pInput.PRIM_BUS_TYPE) +';',
																'')
																);

		//set std_license_status if raw_license_status is not set
		SELF.STD_LICENSE_STATUS := MAP(TRIM(SELF.RAW_LICENSE_STATUS)='' AND tmpCancelDate<>'' => '2',		//CANCELED
																	 TRIM(SELF.RAW_LICENSE_STATUS)='' AND TRIM(pInput.LN_FILEDATE)>TRIM(SELF.EXPIRE_DTE) => 'I',
																	 TRIM(SELF.RAW_LICENSE_STATUS)='' => 'A',
																	 '');
																	 
		SELF.PROVNOTE_1			:= '';
    SELF.PROVNOTE_3			:= IF(SELF.STD_LICENSE_STATUS<>'','{LICENSE STATUS ASSIGNED}','');
																	 
		SELF.mltreckey			:= 0;

		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																			+TRIM(TrimNAME_DBA,LEFT,RIGHT)
																			+TRIM(TrimAddress1,LEFT,RIGHT)
																			+TRIM(TrimCity,LEFT,RIGHT)
																			+TRIM(pInput.ZIP_CODE,LEFT,RIGHT));
																			
																									 
		SELF.PCMC_SLPK			:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(GoodFilterRec,xformToCommon(LEFT));
	inFileLic_dedup:= DEDUP(inFilelic,cmc_slpk);

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layout_base_in trans_lic_status(inFileLic_dedup L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic_dedup, Cmvtranslation,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS',
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
		
	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map_status_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_status_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
  

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(ds_map_lic_trans L) := TRANSFORM
		SELF.NAME_ORG 				:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_ORG,'/',' '));
		SELF.NAME_DBA					:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_DBA,'/',' '));
		SELF.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF := L;
	END;

	ds_map_base := PROJECT(ds_map_lic_trans, xTransToBase(LEFT));
  
	d_final 						:= OUTPUT(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);
	
	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'reg_lenders','using','used');	
																	);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, oLender,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

 END;
