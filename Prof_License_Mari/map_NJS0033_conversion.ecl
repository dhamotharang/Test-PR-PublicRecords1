/* Converting New Jersey Department of Law and Public Safety / Multiple Professions Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

STRING extractCompanyName(STRING addr) := FUNCTION
	TrimAddr := ut.CleanSpacesAndUpper(addr);
	company_name := MAP(REGEXFIND('(RODNEY KIRKLAND)',TrimAddr) => '',
									REGEXFIND('(BLDG|BLDG|PARK|APARTMENT|UNIT|APT)[\\.]* [0-9]+',TrimAddr) => '',
									Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddr)<>''
										=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddr),
									REGEXFIND('( INC\\.$| SERVICES$|  SERVICE$|CCIM.*ALC$|PRICEWATERHOUSE COOPERS| ADVISORS$| LLC$)',TrimAddr)
										=> TrimAddr,
									Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddr)<>'' AND
									NOT Prof_License_Mari.func_is_address_v2(TrimAddr) AND
									NOT REGEXFIND('(^[0-9]+ ).*(AVE | AVENUE| HIGHWAY| CENTER| FREEWAY| BLVD| REACH|HWY| FAIRWAY| STREET| BL| PARKWAY).*',TrimAddr) AND
									NOT REGEXFIND('( CENTER$| DEPT$| DEPARTMENT$| FLOOR$| FLOORS$| BUILDING$| PLAZA | PLAZA$| DR$)',TrimAddr)
										=> Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddr),
									'');
	fix_company_name := IF(REGEXFIND('(^C/O |^C/0 |^DBA |^DBA/|D/B/A )', company_name),REGEXREPLACE('(^C/O |^C/0 |^DBA |D/B/A )',company_name,''),company_name);										
	RETURN TRIM(fix_company_name,LEFT,RIGHT);
END;

STRING extractDbaName(STRING addr) := FUNCTION
	TrimAddr := ut.CleanSpacesAndUpper(addr);
	dba_name := MAP(REGEXFIND('(BLDG|BLDG|PARK|APARTMENT|UNIT|APT)[\\.]* [0-9]+',TrimAddr) => '',
									Prof_License_Mari.mod_clean_name_addr.GetDbaName(TrimAddr)<>'' AND NOT REGEXFIND('([0-9]+.*ROAD)',TrimAddr)
										=> Prof_License_Mari.mod_clean_name_addr.GetDbaName(TrimAddr),
									REGEXFIND('( INC\\.$| SERVICES$|  SERVICE$|CCIM.*ALC$|PRICEWATERHOUSE COOPERS| ADVISORS$| LLC$)',TrimAddr)
										=> TrimAddr,
									Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddr)<>'' AND
									NOT Prof_License_Mari.func_is_address_v2(TrimAddr) AND
									NOT REGEXFIND('(^[0-9]+ ).*(AVE | AVENUE| HIGHWAY| CENTER| FREEWAY| BLVD| REACH|HWY| FAIRWAY| STREET| BL| PARKWAY).*',TrimAddr) AND
									NOT REGEXFIND('( CENTER$| DEPT$| DEPARTMENT$| FLOOR$| FLOORS$| BUILDING$| PLAZA | PLAZA$| DR$)',TrimAddr)
										=> Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimAddr),
									'');
	fix_dba_name := IF(REGEXFIND('(^C/O |^C/0 |^DBA |^DBA/|D/B/A )', dba_name),REGEXREPLACE('(^C/O |^C/0 |^DBA |^DBA/|D/B/A )',dba_name,''),dba_name);										
	RETURN TRIM(fix_dba_name,LEFT,RIGHT);
END;

STRING extractPersonName(STRING addr, STRING company, STRING dba) := FUNCTION
	TrimAddr := ut.CleanSpacesAndUpper(addr);
	rmCompanyName := REGEXREPLACE('('+TRIM(company)+'|'+TRIM(dba)+')', TrimAddr, '');
	person_name := IF(Address.Persons.IsLikelyName(rmCompanyName) AND 
										NOT REGEXFIND('(^P[ ]*O[ ]+BOX|^[0-9]+ |RIVER ROAD|AM LANDMARK| INNC$| ROAD$|APT | APT| SUITE|SUITE | DR$| DRIVE$| HILL$| GROVE$| LAW$|DIX HILLS)',rmCompanyName,NOCASE),
										rmCompanyName,
										IF(REGEXFIND('(RODNEY KIRKLAND)',rmCompanyName),'RODNEY KIRKLAND',''));
	RETURN person_name;
END;


EXPORT map_NJS0033_conversion(STRING pVersion) := FUNCTION
	code 								:= 'NJS0033';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';
  #workunit('name','Yogurt: Prof License MARI - ' + code);	
	
	//NJ appraiser input file
	apr									:= Prof_License_Mari.files_NJS0033.apr(REGEXFIND('Real Estate Appraisers',PROF_ID,NOCASE));

	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvTranslation			:= OUTPUT(ds_Cmvtranslation);						

	//Filtering out BAD RECORDS
	ValidRec			 			:= apr(TRIM(FIRST_NAME+MID_NAME+LAST_NAME+ORGNAME+ADDRESS1_1) <> '');
	GoodFilterRec 			:= ValidRec(NOT REGEXFIND('(ERROR|TEST|DELETE)',FIRST_NAME+MID_NAME+LAST_NAME+ORGNAME,NOCASE));
	GoodLicRec					:= GoodFilterRec(NOT REGEXFIND('(TEST RECORD|TEST STREET)',StringLib.StringToUpperCase(ADDRESS1_1))); 
  ut.CleanFields(GoodLicRec, ClnLicRec);
  oFile								:= OUTPUT(ClnLicRec);
	
	//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* LLC|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
										'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
										'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
										'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
										'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
										')';
					 
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* LLC|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
													'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
													'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
													'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
													'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
													'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
													'^.* BUILDING$|^.* LAKE RESORT$|T/A|APPRAISAL DEPARTMENT$|APPRAISAL DEPT$' +
													')';		
													
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(Prof_License_Mari.layout_NJS0033.common pInput) := TRANSFORM
	 	SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE		:= src_st;
		SELF.TYPE_CD						:= 'MD';			//only appraiser's licenses are available.

		//Standardize Fields
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.ORGNAME);
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID					:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);		
		TrimNAME_SUFX					:= ut.CleanSpacesAndUpper(pInput.CRED_SUFX);
		TrimLIC_TYPE 					:= ut.CleanSpacesAndUpper(pInput.LICTYPE);
		TrimLIC_STATUS 				:= ut.CleanSpacesAndUpper(pInput.LICSTAT);
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
		TrimAddress2 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
		TrimAddress3 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS3_1);
		TrimAddress4 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS4_1);
		TrimCity 							:= ut.CleanSpacesAndUpper(pInput.CITY_1);
		TrimCnty 							:= ut.CleanSpacesAndUpper(pInput.COUNTY);	
		
		// License Information
		SELF.LICENSE_NBR	  	:= IF(pInput.SLNUM = '', 'NR',ut.CleanSpacesAndUpper(pInput.SLNUM));
		SELF.OFF_LICENSE_NBR	:= '';
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		SELF.STD_LICENSE_TYPE := MAP(TRIMLIC_TYPE='TRAINEE PERMIT' => '4201',
																 TRIMLIC_TYPE='LICENSED RESIDENTIAL APPRAISER' => '4202',
																 TRIMLIC_TYPE='CERTIFIED GENERAL APPRAISER' => '4204',
																 TRIMLIC_TYPE='APPROVED INSTRUCTOR' => '4206',
																 TRIMLIC_TYPE='TEMPORARY PRACTICE PERMIT' => '4205',
																 TRIMLIC_TYPE='CERT RESIDENTIAL APPRAISER' => '4203',
																 '');
	  SELF.RAW_LICENSE_STATUS := TrimLIC_STATUS;
		SELF.STD_LICENSE_STATUS := CASE(SELF.RAW_LICENSE_STATUS,
																		'ACTIVE NON-RENEWABLE' => 'A',                              
																		'INACTIVE-PAID' => 'I',
																		'WITHDRAWN' => 'I',
																				'');
																					
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= IF(pInput.CURISSUEDT != '',
		                            Prof_License_Mari.DateCleaner.ToYYYYMMDD(TRIM(pInput.CURISSUEDT)),
																'17530101');
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUEDT != '',
		                            Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUEDT),
																'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '',
		                            Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPDT),
																'17530101');
		
		//Clean individual name. Orgname is the concat of first_name, mid_name, last_name, and cred_sufx
		//Some old code that handles DBA/AKA in orgname/last name have been deleted because these fields contain only person names
		tempNick 							:= Prof_License_Mari.fGetNickname(TrimNAME_ORG,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(TrimNAME_ORG,'strip_nick');
		
		tempFNick							:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		removeFNick						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		
		tempMNick							:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');
		removeMNick						:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick');
		
		tempLNick							:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick');
		
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		stripNickFName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));
		stripNickMName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick));
		stripNickLName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
		
		ParsedName 						:= MAP(TRIM(SELF.TYPE_CD)='MD' AND TrimNAME_FIRST<>'' AND TrimNAME_LAST<>''
		                               => Prof_License_Mari.fnCleanNames.easyClean(TrimNAME_FIRST,TrimNAME_MID,TrimNAME_LAST,TrimNAME_SUFX),
																 TRIM(SELF.TYPE_CD)='MD' AND TrimNAME_LAST='' AND	TrimNAME_ORG<>''
																   => Address.CleanPersonFML73(stripNickName),
																 '');
		FirstName 						:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   						:= TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  						:= TRIM(ParsedName[46..65],LEFT,RIGHT); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);
		SELF.NAME_FIRST		   	:= IF(ParsedName = '', stripNickFName,FirstName);
		SELF.NAME_MID					:= IF(ParsedName = '', stripNickMName,MidName);							
		SELF.NAME_LAST		   	:= IF(ParsedName = '', stripNickLName,LastName);
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);	

		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD ='MD',
																		IF(ParsedName = '', StringLib.StringCleanSpaces(stripNickLName +' '+stripNickFName),
																				StringLib.StringCleanSpaces(LastName +' '+FirstName)),
																				'');
		SELF.NAME_ORG_ORIG	  := IF(TRIM(SELF.NAME_ORG)<>'',TrimNAME_ORG,'');
		SELF.NAME_FORMAT			:= IF(TRIM(SELF.NAME_ORG_ORIG)<>'','F','');

		//Get person and company name from address lines
		//**********************************************
		temp_address_123			:= TRIM(TrimAddress1+', '+TrimAddress2+', '+ TrimAddress3);
		company_1							:= extractCompanyName(TrimAddress1);
		company_2 						:= extractCompanyName(TrimAddress2);
		company_3 						:= extractCompanyName(TrimAddress3);
		v_company_1						:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern);
		dba_1 						    := extractDbaName(TrimAddress1);
		dba_2 						    := extractDbaName(TrimAddress2);
		dba_3 						    := extractDbaName(TrimAddress3);
		person_1 				     	:= extractPersonName(TrimAddress1,company_1,dba_1);
		person_2 				     	:= extractPersonName(TrimAddress2,company_2,dba_2);
		person_3 				     	:= extractPersonName(TrimAddress3,company_3,dba_3);
    
		temp_company 					:= MAP(company_1<>'' AND NOT REGEXFIND('(^[0-9]+ )',company_1) => company_1,
																 company_1='' AND company_2<>'' AND NOT REGEXFIND('(^[0-9]+ )',company_2) => company_2,
																 company_1='' AND company_2='' AND company_3<>'' AND NOT REGEXFIND('(^[0-9]+ )',company_3) => company_3,
																 TRIM(company_1+company_2+company_3)='' AND dba_1<>'' AND NOT REGEXFIND('(^[0-9]+ )',dba_1) => dba_1,
																 TRIM(company_1+company_2+company_3+dba_1)='' AND dba_2<>'' AND NOT REGEXFIND('(^[0-9]+ )',dba_2) => dba_2,
																 TRIM(company_1+company_2+company_3+dba_1+dba_2)='' AND dba_3<>'' AND NOT REGEXFIND('(^[0-9]+ )',dba_3) => dba_3,
																 v_company_1 <> '' => v_company_1,																 
																 '');
		temp_dba 							:= MAP(temp_company<>'' AND TRIM(company_2)<>'' AND TRIM(temp_company)<>TRIM(company_2) => company_2,
																 temp_company<>'' AND TRIM(company_3)<>'' AND TRIM(temp_company)<>TRIM(company_3) => company_3,
																 temp_company<>'' AND TRIM(dba_1)<>'' AND TRIM(temp_company)<>TRIM(dba_1) => dba_1,
																 temp_company<>'' AND TRIM(dba_2)<>'' AND TRIM(temp_company)<>TRIM(dba_2) => dba_2,
																 temp_company<>'' AND TRIM(dba_3)<>'' AND TRIM(temp_company)<>TRIM(dba_3) => dba_3,
																 '');
		temp_person 					:= MAP(person_1<>'' => person_1,
																 person_2<>'' => person_2,
																 person_3<>'' => person_3,
																 '');

		//Clean address
		preAddr1 							:= StringLib.StringCleanSpaces(REGEXREPLACE('('+TRIM(temp_company)+'|'+TRIM(temp_dba)+'|'+TRIM(temp_person)+'|C/O |DBA |AKA |D/B/A |A/K/A )', temp_address_123, '')); 
		fixAddr1 							:= IF(REGEXFIND('(^PMB )[0-9]+',preAddr1,NOCASE),REGEXREPLACE('(^PMB )',preAddr1,'PO BOX '),
																					Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(preAddr1, RemovePattern));
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(fixAddr1,TrimAddress4); //Address cleaner to remove 'c/o' AND 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(tmpADDR_ADDR1_1);	
		SELF.ADDR_ADDR2_1			:= StringLib.StringCleanSpaces(tmpADDR_ADDR2_1); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr1[115..116]);
		SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr1[117..121]);
		SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];
		SELF.ADDR_BUS_IND			:= IF(TRIM(clnAddrAddr1)='','','B');
		SELF.ADDR_CNTY_1			:= TrimCnty;
		SELF.ADDR_CNTRY_1			:= CASE(Trim(ut.CleanSpacesAndUpper(pInput.COUNTRY),LEFT,right),
		                              '1' => 'UNITED STATES',
																	'UNITED STATES' => 'UNITED STATES',
																	''); 
		SELF.PHN_MARI_1       := ut.CleanPhone(pInput.PHONE);															
		SELF.PHN_PHONE_1      := ut.CleanPhone(pInput.PHONE);	
		SELF.EMAIL            := StringLib.StringToUpperCase(TRIM(pInput.EMAIL,LEFT,RIGHT));

		//Populate office name using temp_company extracted from address fields
		stdNameOffice					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_company);
		stripNameOffice				:= Prof_License_Mari.mod_clean_name_addr.strippunctName(stdNameOffice);
		SELF.NAME_OFFICE			:= if(stripNameOffice[1..3] = 'DBA','',
																IF(TRIM(stripNameOffice)<>'', StringLib.StringCleanSpaces(stripNameOffice), 
																''));
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ','GR','');
		SELF.NAME_MARI_ORG	  := IF(SELF.TYPE_CD = 'MD' AND TRIM(SELF.NAME_OFFICE)<>'',SELF.NAME_OFFICE,'');

		//Populate dba name using temp_dba extacted from address fields
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_DBA,'/',' '));
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		SELF.NAME_DBA_ORIG	  := '';
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA<>'',StdNAME_DBA,'');
		
		//Populate contact name using temp_person extracted from address field
		ParseContact					:= IF(temp_person<>'', Address.CleanPersonFML73(temp_person), '');																				
		temp_name_contact_first	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		temp_name_contact_last:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_FIRST	:= IF(TRIM(temp_name_contact_first)=TRIM(SELF.NAME_FIRST) AND TRIM(temp_name_contact_last)=TRIM(SELF.NAME_LAST),'',temp_name_contact_first);
		SELF.NAME_CONTACT_MID	:= IF(TRIM(temp_name_contact_first)=TRIM(SELF.NAME_FIRST) AND TRIM(temp_name_contact_last)=TRIM(SELF.NAME_LAST),'',TRIM(ParseContact[26..45],LEFT,RIGHT));  
		SELF.NAME_CONTACT_SUFX:= IF(TRIM(temp_name_contact_first)=TRIM(SELF.NAME_FIRST) AND TRIM(temp_name_contact_last)=TRIM(SELF.NAME_LAST),'',TRIM(ParseContact[66..70],LEFT,RIGHT));  
		SELF.NAME_CONTACT_LAST:= IF(TRIM(temp_name_contact_first)=TRIM(SELF.NAME_FIRST) AND TRIM(temp_name_contact_last)=TRIM(SELF.NAME_LAST),'',temp_name_contact_last);
		
		SELF.PROV_STAT				:= IF(SELF.RAW_LICENSE_STATUS = 'DECEASED','D',
																IF(SELF.RAW_LICENSE_STATUS IN ['RETIRED','RETIRED PAPER'],'R',''));
		
		SELF.ORIGIN_CD 				:= CASE(StringLib.stringtouppercase(pInput.ORIGINCODE),
																	'APPLICATION' => 'O',
																	'APPLICATION-BSW' => 'O',
																	'APPLICATION - LIVE SCAN' => 'O',
																	'APPLICATION-RELATED BA/BSW-NON-CSWE' => 'O',
																	'APPRENTICESHIP' => 'O',
																	'ARCHIVE RECORD' => 'O',
																	'EDUCATION' => 'O',
																	'ENDORSEMENT' => 'D',  
																	'EXAM' => 'E',
																	'EXAM (OS/OC)' => 'E',
																	'EXAM (OS/OC) W/TP' => 'E',
																	'EXAM APPLICATION' => 'O',
																	'EXAM APPLICATION (OS/OC)' => 'O',
																	'EXAMINATION' => 'E',
																	'EXAMINATION APPLICATION' => 'O',
																	'EXAMINATION APPLICATION (OS/OC)' => 'O',
																	'EXAMINATION-IDP' => 'E',
																	'EXAMINATION FROM TEMP/TRAINING' => 'E',
																	'EXAMINATION W/ TP' => 'E',
																	'EXAMINATION (OS/OC) W/TP' => 'E',
																	'FLEX EXAM' => 'E',
																	'GRANDFATHERED' => 'G',
																	'LIVE SCAN' => 'O',
																	'NATIONAL EXAM' => 'E',
																	'ORIGINAL'=> 'L',
																	'OTHER' => 'O',
																	'PRACTICAL' => 'O',                          
																	'JURISPRUDENCE' => 'O',                      
																	'RECIPROCITY' => 'R',
																	'RECIPROCITY/COMITY' => 'R',
																	'RECIPROCITY-NCARB' => 'R',
																	'SPECIAL EXAM' => 'E',
																	'TEMPORARY LICENSE' => 'O',
																	'TEMPORARY PERMIT' => 'O',												
																	'TRANSFER OF GRADES' => 'O',                 
																	'THREE YEAR TP' => 'O',                      
																	'WAIVER' => 'W', 
																	'UNKNOWN' => ' ',
																			ut.CleanSpacesAndUpper(pInput.PROF_ID));
		SELF.ORIGIN_CD_DESC		:= CASE(SELF.ORIGIN_CD,
																	'D' => 'ENDORESEMENT',
																	'E' => 'EXAM',
																	'G' => 'GRANDFATHERED',
																	'L' => 'ORIGINAL',
																	'O' => 'OTHER',
																	'W' => 'WAIVER',
																	'R' => 'RECIPROCITY/COMITY',
																				'');

		SELF.DISP_TYPE_CD     := MAP(SELF.RAW_LICENSE_STATUS = 'ADMINISTRATIVE SUSPENSION' => 'Q',
																 SELF.RAW_LICENSE_STATUS = 'REVOKED' => 'R',
																 SELF.RAW_LICENSE_STATUS = 'SUSPENDED' => 'Q',
																 SELF.RAW_LICENSE_STATUS = 'VOLUNTARY SURRENDER' => 'V','');
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
	
	  //store is_orgniz in provnote
	  SELF.PROVNOTE_2					:= 'IS_ORGANIZ='+ut.CleanSpacesAndUpper(pInput.IS_ORGANIZ);
	
	  //Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		
	
	/* fields used to create mltrec_key unique record split dba key are :
			   transformed license number,standardized license type,standardized source update, raw name containing dba name(s),raw address
	*/
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																			+TRIM(TrimAddress1,LEFT,RIGHT)
																			+TRIM(TrimAddress2,LEFT,RIGHT)
																			+TRIM(TrimAddress3,LEFT,RIGHT)
																			+TRIM(TrimAddress4,LEFT,RIGHT));
																			

		SELF := [];	
		   
	END;
	inFileLic	:= PROJECT(ClnLicRec,xformToCommon(LEFT));

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base trans_lic_status(inFileLic L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic, ds_Cmvtranslation,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_status_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;
	
	ds_map_lic_trans := JOIN(ds_map_status_trans, ds_Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);

	remove_logical 					:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	d_final 								:= OUTPUT(ds_map_lic_trans, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));

	move_to_used						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using','used');
																			);
	notify_missing_codes 		:= Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address 	:= Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation,oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);	
END;	

