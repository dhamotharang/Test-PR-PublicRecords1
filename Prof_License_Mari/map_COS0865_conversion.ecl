//************************************************************************************************************* */	
//  The purpose of this development is take Colorado Professional License raw files and convert them to a common
//  professional license (BASE) layout to be used for MARI and PL_BASE development.
//	05/08/2015 T.George - Layout Change
//************************************************************************************************************* */	

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, STD;

EXPORT map_COS0865_conversion(STRING pVersion) := FUNCTION

	code 		:= 'COS0865';
	src_cd	:= 'S0865';
	src_st	:= 'CO';	//License state

	// all input file
	active   := prof_license_mari.file_COS0865.active;
	inactive := prof_license_mari.file_COS0865.inactive;		
	
	// Reference Files
	SrcCmvTrans	:= prof_license_mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
	OCmv        := OUTPUT(SrcCmvTrans);

	SrcCmvStatus := prof_license_mari.files_References.MARIcmvlicstatus;
	

//***********Combine files into one common layout******************
	// active to common
	Prof_License_Mari.layout_COS0865.common map_active(Prof_License_Mari.layout_COS0865.active L) := TRANSFORM
    SELF.ln_filedate := pVersion;		
		SELF  := L;
		SELF  := [];
	END;

	activeCommon	:= PROJECT(active, map_active(LEFT));

	//Remove bad records before processing
	ValidActive	:= activeCommon(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
	                    AND TRIM(REGISTRATION_NUMBER,LEFT,RIGHT) <>''
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));
											
	//inactive to common
		Prof_License_Mari.layout_COS0865.common map_inactive(Prof_License_Mari.layout_COS0865.inactive L) := TRANSFORM
    SELF.ln_filedate := pVersion;		
		SELF	:= L;
		SELF  := [];
	END;

	inactiveCommon	:= PROJECT(inactive, map_inactive(LEFT));

	//Remove bad records before processing
	ValidInactive	:= inactiveCommon(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
	                    AND TRIM(REGISTRATION_NUMBER,LEFT,RIGHT) <>''
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));
				
	ValidMTGFile	:= ValidActive + ValidInactive;
	oMtg	:= OUTPUT(ValidMTGFile);

  ut.CleanFields(ValidMTGFile,clnValidMTGFile);

//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^.* CORP |^DHI MORTGAGE |' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^C/O .*$|^ATTN.*$|^.* LENDING|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.*MORTGAGE REAL ESTATE SERVICES|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION|^.* MORTGAGE$|' +
					 '^.* LOANS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|LEGAL DEPARTMENT' +
					 ')';
		RemovePattern	  := '(^.* LLC|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^.* CORP |^DHI MORTGAGE |' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|^.* LENDING|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION|' +
					 '^.* LOANS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|LEGAL DEPARTMENT|' +
					 'LINE 1|LINE 2|LEGAL DEPT\\.|SALES OFFICE|BUSINESS OFFICE|^.* MORTGAGE$' +
					 ')';
 
  	AddrPattern   :=	'(^.*ST$|^.*STE$|^.*STREET|^.*RD$|^.*DR$|^.*DRIVE|^.*ROUTE|^.*ROAD|^.*SUITE|^.*AVENUE|^.*AVE$|^.*LANE|^.*CT$|^.*BLVD|^.*BOULEVARD|^.*MAINSTREET|^.*PLACE|^.*PKWY|^.* PARK|^.* BLD|^.* CENTRE)';

    website_pattern := '(HTTP://|)(WWW\\.)?([^\\.]+)\\.(\\w{2}|(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO))$';

    two_name_cities   := ['GRAND JUNCTION', 'CASTLE ROCK','LONE TREE'];

    DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';

    C_O_Ind := '(C/O |ATTN: |ATTN )';

//mortgage and lenders to MARIBASE layout
 Prof_License_Mari.layouts.base	transformToCommon(Prof_License_Mari.Layout_COS0865.common pInput) 
    := 
	   TRANSFORM
			SELF.PRIMARY_KEY	    := 0;  //Generate sequence number (not yet initiated)
			SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
			SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
			SELF.CREATE_DTE      	:= thorlib.wuid()[2..9];
			SELF.LAST_UPD_DTE    	:= pInput.ln_filedate;
			SELF.STAMP_DTE      	:= pInput.ln_filedate;
			SELF.STD_SOURCE_UPD		:= src_cd;
			SELF.LICENSE_STATE		:= src_st;
			SELF.TYPE_CD		 			:= 'MD';
			SELF.STD_SOURCE_DESC	:= '';
			SELF.STD_PROF_CD		  := '';
			SELF.STD_PROF_DESC		:= '';
																		 
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
			TrimFName	  	:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
			TrimMName     := ut.CleanSpacesAndUpper(pInput.MIDDLE_NAME);
			TrimLName	  	:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
			TrimAttention := ut.CleanSpacesAndUpper(pInput.ATTENTION);
			TrimSuffix    := ut.CleanSpacesAndUpper(pInput.SUFFIX);
		  TrimCompany_1	:= ut.CleanSpacesAndUpper(pInput.ENTITY_NAME);
		  TrimAddress1  := ut.CleanSpacesAndUpper(pInput.ADDRESS);
  		TrimAddress2  := ut.CleanSpacesAndUpper(pInput.ADDRESS_2);	
			TrimSubCategory := ut.CleanSpacesAndUpper(pInput.REGISTRATION_SUB_TYPE);
  
	//Parsing Attention
		  prepAddress   := IF(Prof_License_Mari.func_is_address(TrimAttention), TrimAttention,'');

			prepCompany   := IF(Prof_License_Mari.func_is_company(TrimAttention) AND NOT Prof_License_Mari.func_is_address(TrimAttention), TrimAttention
			                    ,'');
			
			prepName      := MAP(REGEXFIND('[0-9]', TrimAttention) => '',
													 REGEXFIND(TrimLName, TrimAttention) AND REGEXFIND(TrimFName, TrimAttention) => '',
													 REGEXFIND('NewDay USA', TrimAttention) => '',
													 REGEXFIND(TrimAttention, TrimCompany_1) => '',
 													 Prof_License_Mari.func_is_company(TrimAttention) => '',
													 Prof_License_Mari.func_is_address(TrimAttention) => '',
													 TrimAttention);

		// Identify NICKNAME in the various format 
		  tempFNick := Prof_License_Mari.fGetNickname(TrimFName, 'nick');
			tempMNick := Prof_License_Mari.fGetNickname(TrimMName, 'nick');
			tempLNick	:= Prof_License_Mari.fGetNickname(TrimLName, 'nick');
			
			//Removing NickName from Parsed First/Last Name fields
			removeFNick			:= Prof_License_Mari.fGetNickname(TrimFName, 'strip_nick');
			removeMNick			:= Prof_License_Mari.fGetNickname(TrimMName, 'strip_nick');
			removeLNick			:= Prof_License_Mari.fGetNickname(TrimLName, 'strip_nick');
			
			cleanFNAME		  := Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick);
			cleanMNAME		  := Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick);
			cleanLNAME		  := Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick);
		
		  tmpSuffix         := MAP(cleanMNAME = 'III'=> 'III',
															 cleanMNAME = 'IV'=> 'IV',
															 cleanMNAME = 'SR'=> 'SR',
															 cleanMNAME = 'JR'=> 'JR',
															 REGEXFIND('^(.*) (III)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (III)(\\.?)$',cleanMNAME,2),
															 REGEXFIND('^(.*) (II)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (II)(\\.?)$',cleanMNAME,2),
															 REGEXFIND('^(.*) (IV)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (IV)(\\.?)$',cleanMNAME,2),
															 REGEXFIND('^(.*) (SR)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (SR)(\\.?)$',cleanMNAME,2),
															 REGEXFIND('^(.*) (JR)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (JR)(\\.?)$',cleanMNAME,2),
															 REGEXFIND('^(.*) (III)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (III)(\\.?)$',cleanLNAME,2),
															 REGEXFIND('^(.*) (II)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (II)(\\.?)$',cleanLNAME,2),
															 REGEXFIND('^(.*) (IV)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (IV)(\\.?)$',cleanLNAME,2),
															 REGEXFIND('^(.*) (SR)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (SR)(\\.?)$',cleanLNAME,2),
															 REGEXFIND('^(.*) (JR)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (JR)(\\.?)$',cleanLNAME,2),															 
															 TrimSuffix);
			GoodMNAME         := MAP(cleanMNAME = 'III'=> '',
															 cleanMNAME = 'IV'=> '',
															 cleanMNAME = 'SR'=> '',
															 cleanMNAME = 'JR'=> '',
															 REGEXFIND('^(.*) (III)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (III)(\\.?)$',cleanMNAME,1),
															 REGEXFIND('^(.*) (II)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (II)(\\.?)$',cleanMNAME,1),
															 REGEXFIND('^(.*) (IV)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (IV)(\\.?)$',cleanMNAME,1),
															 REGEXFIND('^(.*) (SR)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (SR)(\\.?)$',cleanMNAME,1),
															 REGEXFIND('^(.*) (JR)(\\.?)$',cleanMNAME) => REGEXFIND('^(.*) (JR)(\\.?)$',cleanMNAME,1),
															 cleanMNAME);	
															 
			GoodLNAME         := MAP(REGEXFIND('^(.*) (III)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (III)(\\.?)$',cleanLNAME,1),
			                         REGEXFIND('^(.*) (II)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (II)(\\.?)$',cleanLNAME,1),
															 REGEXFIND('^(.*) (IV)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (IV)(\\.?)$',cleanLNAME,1),
															 REGEXFIND('^(.*) (SR)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (SR)(\\.?)$',cleanLNAME,1),
															 REGEXFIND('^(.*) (JR)(\\.?)$',cleanLNAME) => REGEXFIND('^(.*) (JR)(\\.?)$',cleanLNAME,1),
															 cleanlNAME);																 
												 
			SELF.NAME_ORG			:= StringLib.StringCleanSpaces(GoodLNAME+ ' ' +cleanFNAME); 
			SELF.NAME_ORG_ORIG:= ut.CleanSpacesAndUpper(pInput.First_Name + ' ' + pInput.Middle_Name + ' ' + pInput.Last_Name); 
			SELF.NAME_FIRST 	:= cleanFNAME;
			SELF.NAME_MID  	  := GoodMNAME;
			SELF.NAME_LAST  	:= GoodLNAME;
			SELF.NAME_SUFX    := tmpSuffix;
      SELF.NAME_FORMAT	:= 'F';	
			
			stripNick				  := MAP(StringLib.stringfind(tempLNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempLNick,''),
			                         tempFNick !='' => tempFNick,
															 tempMNick !='' => tempMNick,
															 tempLNick !='' => tempLNick,
															 '');
			SELF.NAME_NICK	  := StringLib.StringCleanSpaces(stripNick);

			// Parsing Contact Name
		  cleanContactName  := Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepName);
			SELF.Name_Contact_First := cleanContactName[6..25];
			SELF.Name_Contact_Mid	 	:= cleanContactName[26..45];
			SELF.Name_Contact_Last	:= cleanContactName[46..65];
			SELF.Name_Contact_Sufx	:= cleanContactName[66..70];	
				
			SELF.RAW_LICENSE_TYPE 	:= ut.CleanSpacesAndUpper(pInput.REGISTRATION_TYPE);
			SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.STATUS);
           
		   // map raw license type to standard license type before profcode translations
		   // Change mapping because mapping previous mapping was truncating words
			SELF.STD_LICENSE_TYPE := MAP(ut.CleanSpacesAndUpper(pInput.REGISTRATION_TYPE) = 'MORTGAGE BROKER LICENSE' => 'MB',
			                             ut.CleanSpacesAndUpper(pInput.REGISTRATION_TYPE) = 'TEMPORARY MORTGAGE BROKER LICENSE' => 'TMB',
																	 ut.CleanSpacesAndUpper(pInput.REGISTRATION_TYPE) = 'MORTGAGE LOAN ORIGINATOR LICENSE' => 'MLO',
																	 ut.CleanSpacesAndUpper(pInput.REGISTRATION_TYPE) = 'TEMPORARY MORTGAGE LOAN ORIGINATOR LICENSE' => 'TMLO',
                                   pInput.REGISTRATION_TYPE IN ['MB','TMB','MLO','TMLO']	=> ut.CleanSpacesAndUpper(pInput.REGISTRATION_TYPE),																 
																	 ''); 
			SELF.LICENSE_NBR	   	:= MAP(SELF.STD_LICENSE_TYPE = 'MLO' AND REGEXFIND('[0-9]', pInput.REGISTRATION_NUMBER[1..3])=>'LMB'+ ut.CleanSpacesAndUpper(pInput.REGISTRATION_NUMBER),
                                   SELF.STD_LICENSE_TYPE = 'MLO' AND REGEXFIND('LMB', pInput.REGISTRATION_NUMBER[1..3]) => ut.CleanSpacesAndUpper(pInput.REGISTRATION_NUMBER),
																   '');
			
			//Reformatting date from MM/DD/YYYY to YYYYMMDD	
			SELF.CURR_ISSUE_DTE     := '17530101';
			SELF.ORIG_ISSUE_DTE			:= IF(TRIM(pInput.FIRST_ISSUANCE_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.FIRST_ISSUANCE_DATE));
			SELF.EXPIRE_DTE					:= IF(TRIM(pInput.EXPIRATION_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPIRATION_DATE));	
			SELF.RENEWAL_DTE				:= IF(TRIM(pInput.LAST_RENEWED_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.LAST_RENEWED_DATE));
			
			//Extract company name
			TrimAddr1           := IF(REGEXFIND(CoPattern,trimAddress1),'',trimAddress1);
			TrimAddr2           := IF(REGEXFIND(CoPattern,trimAddress2),'',trimAddress2);
			trimAddrAddr        := ut.CleanSpacesAndUpper(trimAddr1 + ' ' + trimAddr2);
			trimAddress         := MAP(trimAddrAddr <> '' AND trimAddrAddr <> 'XXX'=> trimAddrAddr,
			                           trimAddrAddr = 'XXX'=> '',
			                           prepAddress);
															 
			mail_ind            := '^(.*)MAILING(.*)$';
			tmpAddr1	         	:= IF(REGEXFIND(mail_ind, trimAddress), REGEXFIND(mail_ind, trimAddress,1), trimAddress);
			trimCity						:= ut.CleanSpacesAndUpper(pInput.city);
			careof_ind := 'C/O ([0-9A-Za-z\\s][^\\,]+)\\,\\s([0-9A-Za-z \\s \\.]+)$';
			//Extract DBA Name from Address
			
			tmpDBA1       			:= IF(REGEXFIND(DBA_Ind, tmpAddr1),REGEXFIND('(^.*) DBA (.*)$',tmpAddr1,3),'');
																		
			clnAddress1					:= IF(REGEXFIND(DBA_Ind, trimAddress),REGEXFIND(DBA_Ind, trimAddress,2),trimAddress);
																	
			
			tmpNameContact1			:= MAP(REGEXFIND(careof_ind, clnAddress1) =>  REGEXFIND(careof_ind,clnAddress1,1),
																	 REGEXFIND(website_pattern, clnAddress1) => clnAddress1,
																	 REGEXFIND('(CORP DRIVE)', clnAddress1) => '',
																		Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(clnAddress1, CoPattern));
																		
			tmpAddress1					:= MAP(REGEXFIND(careof_ind, trimAddress) =>  REGEXFIND(careof_ind, clnAddress1,2),
			                            REGEXFIND(website_pattern, clnAddress1) => '',
																	REGEXFIND('(CORP DRIVE)', clnAddress1) => clnAddress1,
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(clnAddress1, RemovePattern));
			
			//Correct Addrss after Removal of Business Name
			exclude_addr     := ['NONE','N/A','TBD','XX','ZZ','NOT WORKING','NA','LOOKING FOR EMPLOYMENT'];
			prepAddr         := IF(tmpAddress1 IN exclude_addr, '', 
															IF(REGEXFIND('[0-9]', trimCity), trimCity,
																	tmpAddress1));
																	
			prepAddr_2       := MAP(REGEXFIND('^([0-9]+)$', TRIM(prepAddr)) => '',
										  		prepAddr[1] = ',' => prepAddr[2..],
										  		STD.Str.Find(TRIM(prepAddr), '/PO ', 1) > 0 => REGEXFIND('^(.*)/(.*)$', TRIM(prepAddr),1),
											  	prepAddr);
											 	
			prepCity	       :=  IF(REGEXFIND('[0-9]', TrimCity),'',
											    	IF(trimCity IN exclude_addr,'',
														 IF(trimCity = 'XXX', '',TrimCity)));
			
    //Remove DBA Name	
		TrimCompany           := MAP(TrimCompany_1 = '.' => '',
		                             TrimCompany_1 = 'INACTIVE' => '',
																 TrimCompany_1 = 'N/A' => '',
																 TrimCompany_1 = '' AND Prof_License_Mari.func_is_company(trimAddress1) AND NOT REGEXFIND(AddrPattern,trimAddress1)=> trimAddress1,
																 TrimCompany_1 = '' AND Prof_License_Mari.func_is_company(trimAddress2) AND NOT REGEXFIND(AddrPattern,trimAddress2)=> trimAddress2,
	                               TrimCompany_1 <> '' AND TrimCompany_1 <> '.' => TrimCompany_1, 
																 prepCompany);	
 		tmpCompany            := IF(Prof_License_Mari.func_is_address(TrimCompany),'',TrimCompany);	
		tmpNameOffice					:= StringLib.StringFindReplace(tmpCompany,'(DBA ', ' DBA ');
		tmpNAME_DBA						:= IF(REGEXFIND('( DBA | D/B/A | DBA: |(DBA)| A/K/A | AKA )',tmpNameOffice), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOffice),
																				'');
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA					:= MAP(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	tmpDBA1 <> ''=> tmpDBA1,
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																								Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));

		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		SELF.NAME_MARI_DBA	  := tmpNAME_DBA;
		SELF.NAME_DBA					:= CleanNAME_DBA;
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA); 
		SELF.DBA_FLAG		    	:= If(SELF.NAME_DBA != '',1,0);
			
			// Identifying OFFICE NAME

	  	preNAME_OFFICE 			:= MAP(REGEXFIND('( DBA | D/B/A |(DBA)|/DBA| DBA:|^DBA |^DBA:|^AKA|D.B.A.)',tmpNameOffice)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOffice),
																	REGEXFIND('C/O ',tmpNameOffice[1..4])=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOffice),
																	tmpNameOffice = '' AND tmpNameOffice[1..4]='C/O '=>  tmpNameOffice[5..],
																	tmpNameOffice = '' AND tmpNameOffice[1..4]='DBA '=> '',																
																	tmpNameOffice = '' AND tmpNameOffice <> '' => tmpNameOffice,
																	tmpNameOffice);
	  	tmpNAME_OFFICE			:= MAP(preNAME_OFFICE[1..4]='DBA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE[1..4]='AKA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE);
			clnOfficeName				:= IF(REGEXFIND('(.COM|.NET|.ORG)',tmpNAME_OFFICE),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNAME_OFFICE),
		                            tmpNAME_OFFICE);
																
		  SELF.NAME_OFFICE		:= MAP(REGEXFIND('(LEGAL DEPARTMENT)', tmpNameContact1) => '',
			                           clnOfficeName = 'NA' => '',
																 clnOfficeName = 'NONE' => '',
																 TRIM(clnOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL) + TRIM(SELF.NAME_LAST,ALL) => '',
																 TRIM(clnOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL) + TRIM(SELF.NAME_MID,ALL) + TRIM(SELF.NAME_LAST,ALL) => '',
			                           clnOfficeName <> '' => clnOfficeName,
			                           tmpNameContact1);
			SELF.OFFICE_PARSE		:= MAP(SELF.NAME_OFFICE = '' => '',
														 		 SELF.NAME_OFFICE != '' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
																 SELF.NAME_OFFICE <> '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)=> 'GR',
																 SELF.NAME_OFFICE != '' AND REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',SELF.NAME_OFFICE) => 'GR', 
																 SELF.NAME_OFFICE != '' AND REGEXFIND(CoPattern,SELF.NAME_OFFICE)=>'GR','MD');
							
			SELF.NAME_MARI_ORG	:= MAP(SELF.TYPE_CD ='GR' => SELF.NAME_ORG,
				                         SELF.TYPE_CD ='MD' => SELF.NAME_OFFICE,''); 

      // Address fields is could be populated with address1, address2, address3 separated by variations of comma(s), and semi-colon(s)
			SELF.ADDR_BUS_IND 	:= IF(TRIM(trimAddress + trimCity + pInput.postal_code) != '','B','');							 
		
  		// Populating Business Address field(s)
		  Bus_zip_ind  := '[0-9]{5,}(-[0-9]{4})?$';
			tempBus_addr := IF(REGEXFIND(Bus_zip_ind, TRIM(prepAddr_2)) AND not REGEXFIND('(^PO BOX|^P\\.O\\. BOX|P O )', TRIM(prepAddr_2)), prepAddr_2,'');
			
			// stripping needless punctuation
			tempBus_addr1								:= StringLib.StringFilterOut(TRIM(tempBus_addr), ')');
			tempBus_addr2								:= StringLib.StringFilterOut(tempBus_addr1, '.');
			tempBus_addr_comma					:= StringLib.StringFilterOut(tempBus_addr2, ',');
			tempBus_addr_dash						:= StringLib.StringFilterOut(tempBus_addr_comma, '-');
			space_char              		:= ' ';
					 
			// moving city, state, and zip to their respective fields
			//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
			tempBus_zip                := REGEXFIND(Bus_zip_ind, TRIM(tempBus_addr_dash,LEFT,RIGHT), 0);	
			tempBus_addr4              := tempBus_addr_dash[..(LENGTH(tempBus_addr_dash)-LENGTH(tempBus_zip))];
			reverse_Busaddr            := TRIM(stringlib.stringreverse(tempBus_addr4),LEFT,RIGHT);
			reverse_Busstate           := reverse_Busaddr[..stringlib.stringfind(reverse_Busaddr,space_char,1)-1];
			reverse_Busaddr2           := TRIM(reverse_Busaddr[stringlib.stringfind(reverse_Busaddr,space_char,1)..],LEFT,RIGHT);
			temp_two_name_bus          := stringlib.stringreverse(reverse_Busaddr2[..stringlib.stringfind(reverse_Busaddr2,space_char,2)-1]);
			temp_one_name_bus          := stringlib.stringreverse(reverse_Busaddr2[..stringlib.stringfind(reverse_Busaddr2,space_char,1)-1]);
			tempBus_city               := IF(temp_two_name_bus IN two_name_cities, temp_two_name_bus, temp_one_name_bus);
			temp_final_Busaddr         := stringlib.stringreverse(reverse_Busaddr2);
			final_Busaddr              := temp_final_Busaddr[..LENGTH(TRIM(temp_final_Busaddr,LEFT,RIGHT))-LENGTH(TRIM(tempBus_city,LEFT,RIGHT))];
      
			

      slash := '^(.*)/ (.*)$';
			comma := '^(.*),(.*)$';
			long_address := '(^16425 N Pima Rd |^McDowell Mountain Business Park\\,? Bld A\\,?\\.? |312 S Fiddler\'s Green Cir |One University Place)([0-9A-Za-z \\,\\.]+)$';
			final_BusAddr_2 := MAP(final_Busaddr != '' => final_Busaddr,
														 final_Busaddr = '' AND REGEXFIND(slash, TRIM(prepAddr_2)) => REGEXFIND(slash, TRIM(prepAddr_2),1),
														 final_Busaddr = '' AND length(TRIM(prepAddr_2)) > 45 AND REGEXFIND(StringLib.StringToUppercase(long_address), prepAddr_2) => REGEXFIND(StringLib.StringToUppercase(long_address), prepAddr_2,1),
														 final_Busaddr = '' AND REGEXFIND(comma, TRIM(prepAddr_2)) => REGEXFIND(comma, TRIM(prepAddr_2),1),
														 StringLib.StringCleanSpaces(prepAddr_2)
													 	 );
			 													
	
			final_BusAddr_3 := MAP(STD.Str.Find(prepAddr, '/PO ', 1) >0 => REGEXFIND('^(.*)/(.*)$', TRIM(prepAddr),2),
														 final_Busaddr = '' AND REGEXFIND(slash, TRIM(prepAddr_2)) => REGEXFIND(slash, TRIM(prepAddr_2),2),
			                       final_Busaddr = '' AND length(TRIM(prepAddr_2)) > 45 AND REGEXFIND(StringLib.StringToUppercase(long_address), prepAddr_2) => REGEXFIND(StringLib.StringToUppercase(long_address), prepAddr_2,2),
														 final_Busaddr = '' AND REGEXFIND(comma, TRIM(prepAddr_2)) => REGEXFIND(comma, TRIM(prepAddr_2),2),
														 '');
																 
		  SELF.ADDR_ADDR1_1		:= TRIM(final_BusAddr_2,LEFT,RIGHT);
			SELF.ADDR_ADDR2_1		:= IF(final_BusAddr_3[1] = ',', TRIM(final_BusAddr_3[2..],LEFT,RIGHT),TRIM(final_BusAddr_3,LEFT,RIGHT));
			SELF.ADDR_ADDR3_1 	:= '';
			SELF.ADDR_ADDR4_1 	:= '';
			SELF.ADDR_CITY_1		:= prepCity;
			SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.STATE);
			SELF.ADDR_CNTY_1    := ut.CleanSpacesAndUpper(pInput.COUNTY);
		  
			tmpZIPCODE          := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', TRIM(pInput.postal_code,LEFT,RIGHT), 0);	
			SELF.ADDR_ZIP5_1		:= tmpZIPCODE[1..5];
			SELF.ADDR_ZIP4_1		:= IF(pInput.ZIP4<> '',pInput.ZIP4,tmpZIPCODE[7..10]);
			
			// standardize phone numbers to 10 digits
			cleanPhone          := ut.CleanPhone(pInput.phone_number);
			SELF.PHN_PHONE_1    := cleanPhone;
			SELF.PHN_MARI_1     := cleanPhone;	
		  
			
			//Populating Mailing Address fields
			tempMail_addr := IF(REGEXFIND(mail_ind, trimAddress), REGEXFIND(mail_ind, trimAddress, 2),'');

			// stripping needless punctuation
			tempaddr1								:= StringLib.StringFilterOut(TRIM(tempMail_addr), ')');
			tempaddr2								:= StringLib.StringFilterOut(tempaddr1, '.');
			tempaddr_comma					:= StringLib.StringFilterOut(tempaddr2, ',');
			tempaddr_dash						:= StringLib.StringFilterOut(tempaddr_comma, '-');
					 
			// moving city, state, and zip to their respective fields
			//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
			tempzip                 := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', TRIM(tempaddr_dash,LEFT,RIGHT), 0);	
			tempaddr4               := tempaddr_dash[..(LENGTH(tempaddr_dash)-LENGTH(tempzip))];
			reverse_addr            := TRIM(stringlib.stringreverse(tempaddr4),LEFT,RIGHT);
			reverse_state           := reverse_addr[..stringlib.stringfind(reverse_addr,space_char,1)-1];
			reverse_addr2           := TRIM(reverse_addr[stringlib.stringfind(reverse_addr,space_char,1)..],LEFT,RIGHT);
			temp_one_name           := stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,1)-1]);
			tempcity                := temp_one_name;
			temp_final_addr         := stringlib.stringreverse(reverse_addr2);
			final_addr              := temp_final_addr[..LENGTH(TRIM(temp_final_addr,LEFT,RIGHT))-LENGTH(TRIM(tempcity,LEFT,RIGHT))];

					 
			// final field assignment for city, state, and zip
			SELF.ADDR_MAIL_IND	:= IF(tempMail_addr != '','M','');
			SELF.ADDR_ADDR1_2		:= final_addr;
			SELF.ADDR_ADDR2_2		:= '';
			SELF.ADDR_ADDR3_2		:= '';
			SELF.ADDR_ADDR4_2		:= '';
			SELF.ADDR_CITY_2		:= tempcity;
			SELF.ADDR_STATE_2		:= stringlib.stringreverse(reverse_state);
			SELF.ADDR_ZIP5_2		:= tempzip[1..5];
			SELF.ADDR_ZIP4_2		:= tempzip[7..10];
		
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD		:= IF(SELF.type_cd = 'MD', 'IN',
																	IF(SELF.type_cd = 'GR', 'CO',
																	''));  	 
			
			 /* fields used to create mltrec_key unique record split dba key are :
			   transformed license number
			   standardized license type
			   standardized source update
			   raw name containing dba name(s)
			   raw address
			*/
			SELF.mltreckey		:= 0;
			
		   /* fields used to create unique key are:
		    license number
			  license type
			  source update
			  name
			  address
		 */
			SELF.cmc_slpk         := HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																			+ TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																			+ TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																			+ TRIM(SELF.name_org,LEFT,RIGHT) + ','
																			+ TRIM(trimAddress ,LEFT,RIGHT) + ','
																			+ TRIM(trimCity, LEFT,RIGHT) + ','
																			+ ut.CleanSpacesAndUpper(pInput.state)+ ','
																			+	ut.CleanSpacesAndUpper(pInput.postal_code)
																			);
																			
			SELF.NMLS_ID    := pInput.NMLS_ID;
			SELF.PROVNOTE_1 := TrimSubCategory;		
			SELF := [];		   		   
END;

ds_map   := PROJECT(clnValidMTGFile, transformToCommon(LEFT));

// Populate std_license_status field via translation
 Prof_License_Mari.layouts.base 		trans_lic_status(ds_map L, SrcCmvTrans R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
END;

ds_map_stat_trans := JOIN(ds_map, SrcCmvTrans,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
	    					AND RIGHT.fld_name='LIC_STATUS',
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

// Populate STD_PROF_CD field via translation on license type field
 Prof_License_Mari.layouts.base 		trans_lic_type(ds_map_stat_trans L, SrcCmvTrans R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_stat_trans, SrcCmvTrans,
						TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_TYPE' 
						AND RIGHT.dm_name1 = 'PROFCODE',
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
															
//Perform LOOKUP to assign pcmcslpk of child to cmcslpk of parent
 company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

 Prof_License_Mari.layouts.base 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
						TRIM(LEFT.name_org[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org[1..50],LEFT,RIGHT)
						AND LEFT.AFFIL_TYPE_CD = 'BR',
						assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		


 Prof_License_Mari.layouts.base 	xTransPROVNOTE(ds_map_affil L) := TRANSFORM
	SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
							TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
						   L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
							'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

	SELF := L;
END;

  ds_map_base := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

																
  //Adding to Superfile		
	d_final := OUTPUT(ds_map_base , ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
	
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active', 'using', 'used'),
													 Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','using','used')											
													 );
	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oMtg, OCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);	
END;