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
	
	
//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC|^.* LLC\\.$|,LLC|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
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
  	AddrPattern   :=	'( ST$| STE$| STREET| RD$| DR$| DR\\.$| DRIVE| ROUTE| ROAD|SUITE|AVENUE|AVE$|LANE|'+
		                     ' CT$| BLDG| BLVD|^BLDG,|BOULEVARD| FL$| MAINSTREET| PLACE| PKWY| PARK| BLD| CENTRE)';
 
   website_pattern := '(HTTP://|)(WWW\\.)?([^\\.]+)\\.(\\w{2}|(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO))$';

   two_name_cities   := ['GRAND JUNCTION', 'CASTLE ROCK','LONE TREE'];

   DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';

   C_O_Ind := '(C/O |ATTN: |ATTN )';

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
			TrimFName	   	:= StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.FIRST_NAME),'="');
			TrimMName     := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.MIDDLE_NAME),'="');
			TrimLName	   	:= StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.LAST_NAME),'="');
			TrimAttention := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.ATTENTION),'="');
			TrimSuffix    := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.SUFFIX),'="');
		  TrimCompany_1	:= StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.ENTITY_NAME),'="');
		  TrimAddress1  := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.ADDRESS),'="');
    	TrimAddress2  := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.ADDRESS_2),'="');	
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
			SELF.NAME_ORG_ORIG:= ut.CleanSpacesAndUpper(TrimFName + ' ' + TrimMName + ' ' + TrimLName); 
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
			SELF.Name_Contact_Last	 := cleanContactName[46..65];
			SELF.Name_Contact_Sufx	 := cleanContactName[66..70];	
				
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
			TrimSLNM   := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.REGISTRATION_NUMBER),'="');
			SELF.LICENSE_NBR	   	:= MAP(SELF.STD_LICENSE_TYPE = 'MLO' AND REGEXFIND('[0-9]', pInput.REGISTRATION_NUMBER[1..3])=>'LMB'+ TrimSLNM,
                                   SELF.STD_LICENSE_TYPE = 'MLO' AND REGEXFIND('LMB', pInput.REGISTRATION_NUMBER[1..3]) => TrimSLNM,
																   '');
			
			//Reformatting date from MM/DD/YYYY to YYYYMMDD	
			SELF.CURR_ISSUE_DTE     := '17530101';
			SELF.ORIG_ISSUE_DTE	:= IF(TRIM(pInput.FIRST_ISSUANCE_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.FIRST_ISSUANCE_DATE));
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
			trimState     := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.state),'="');
			trimZip       := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.POSTAL_CODE),'="');
			careof_ind    := 'C/O ([0-9A-Za-z\\s][^\\,]+)\\,\\s([0-9A-Za-z \\s \\.]+)$';
			//Extract DBA Name from Address
			
			tmpDBA1       			:= IF(REGEXFIND(DBA_Ind, tmpAddr1),REGEXFIND('(^.*) DBA (.*)$',tmpAddr1,3),'');
																		
			clnAddress					:= IF(REGEXFIND(DBA_Ind, trimAddress),REGEXFIND(DBA_Ind, trimAddress,2),trimAddress);
																	
			
			tmpNameContact1			:= MAP(REGEXFIND(careof_ind, clnAddress) =>  REGEXFIND(careof_ind,clnAddress,1),
																	 REGEXFIND(website_pattern, clnAddress) => clnAddress,
																	 REGEXFIND('(CORP DRIVE)', clnAddress) => '',
																		Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(clnAddress, CoPattern));
														
    //Remove DBA Name	
		TrimCompany           := MAP(TrimCompany_1 = '.' => '',
		                             TrimCompany_1 = 'INACTIVE' => '',
																 TrimCompany_1 = 'N/A' => '',
																 TrimCompany_1 = '' AND Prof_License_Mari.func_is_company(trimAddress1) AND NOT REGEXFIND(AddrPattern,trimAddress1)=> trimAddress1,
																 TrimCompany_1 = '' AND REGEXFIND(CoPattern,trimAddress1) AND NOT REGEXFIND(AddrPattern,trimAddress1)=> trimAddress1,
																 TrimCompany_1 = '' AND Prof_License_Mari.func_is_company(trimAddress2) AND NOT REGEXFIND(AddrPattern,trimAddress2)=> trimAddress2,
																 TrimCompany_1 = '' AND REGEXFIND(CoPattern,trimAddress2) AND NOT REGEXFIND(AddrPattern,trimAddress2)=> trimAddress2,
	                               TrimCompany_1 <> '' AND TrimCompany_1 <> '.' => TrimCompany_1, 
																 prepCompany);	
																 
 	tmpCompany       := IF(Prof_License_Mari.func_is_address(TrimCompany),'',TrimCompany);	
		tmpNameOffice				:= StringLib.StringFindReplace(tmpCompany,'(DBA ', ' DBA ');
		tmpNAME_DBA						:= IF(REGEXFIND('( DBA | D/B/A | DBA: |(DBA)| A/K/A | AKA )',tmpNameOffice), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOffice),
																				'');
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA				  := MAP(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
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
             																REGEXFIND(AddrPattern, tmpNameContact1) => '',
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
		
	clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddr1, RemovePattern);
	clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddr2, RemovePattern); 
 
	temp_preaddr1 		:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); //Concat addr1 AND addr2 for cleaning
	temp_preaddr2 		:= StringLib.StringCleanSpaces(trimCity+' '+ trimState +' '+ trimZip); //Concat city, state, zipe for cleaning
	clnAddrAddr1		  := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' AND 'attn' from address
	tmpADDR_ADDR1_1		:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1		:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN AND C/O in address
	
	 	GoodADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		 GoodADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
			
		  SELF.ADDR_ADDR1_1		:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR1_1,GoodADDR_ADDR2_1);
			SELF.ADDR_ADDR2_1		:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR2_1,'');
			SELF.ADDR_ADDR3_1 	:= '';
			SELF.ADDR_ADDR4_1 	:= '';
			SELF.ADDR_CITY_1 		:= trimCity;
			SELF.ADDR_STATE_1		:= trimState;
			SELF.ADDR_CNTY_1    := ut.CleanSpacesAndUpper(pInput.COUNTY) ;
		  			
			tmpZIPCODE          := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', trimZip, 0);	
			SELF.ADDR_ZIP5_1		:= tmpZIPCODE[1..5];
			SELF.ADDR_ZIP4_1		:= tmpZIPCODE[7..10];
			
			// standardize phone numbers to 10 digits
			TrimPhone           := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.phone_number),'="');
			cleanPhone          := ut.CleanPhone(TrimPhone);
			SELF.PHN_PHONE_1    := cleanPhone;
			SELF.PHN_MARI_1     := cleanPhone;	
		  
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
																			+ TRIM(trimState, LEFT,RIGHT)+ ','
																			+	TRIM(trimZip, LEFT,RIGHT)
																			);
																			
			SELF.NMLS_ID    := (UNSIGNED8)StringLib.StringFilterout(ut.CleanSpacesAndUpper(pInput.NMLS_ID),'="');
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