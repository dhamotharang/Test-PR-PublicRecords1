/* Converting State of Rhode Island Dept of Business Regulation Mulitple Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, NID;

EXPORT map_RIS0811_conversion(STRING pVersion) := FUNCTION

	code 								:= 'RIS0811';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	Cmvtranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV 								:= OUTPUT(Cmvtranslation);
	AddrExceptions 			:= '(DRIVE|CENTER|BUILDING|CENTRE|PLANTATION|MAIN &|BUSINESS PARK| WAY|APTS|SQUARE|PLAZA|PLACE|TWO )';
	C_O_Ind 						:= '(C/O |ATTN: |ATTN )';
	DBA_Ind 						:= '(.DBA| DBA |D/B/A |/DBA | AKA)';
  Addr_Pattern        := '( AVENUE$| DRIVE$| STREET$| STE | RD$)';
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|,LLC$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|^.*DO NOT USE.*$' +
					 ')';

	move_to_using 			:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed', 'using');
																	);

	 inFile_APR := Prof_License_Mari.files_RIS0811.apr;
	 oAPR := OUTPUT(inFile_APR);

	inFile_RE						:= Prof_License_Mari.files_RIS0811.re;
	oRE := OUTPUT(inFile_RE);
	
	rLayout_License	:= RECORD, maxsize(5000)
   		Prof_License_Mari.layout_RIS0811.rBroker_sl;
			STRING BUS_PHONE;

   	END;


	outFile_APR := PROJECT(inFile_APR,TRANSFORM(rLayout_License,SELF := LEFT;SELF := []));
	outFile_RE  := PROJECT(inFile_RE,TRANSFORM(rLayout_License,SELF := LEFT;SELF := []));

	inFileComb  := outFile_APR + outFile_RE;

	//Filtering out BAD RECORDS
	GoodNameRec 	:= inFileComb(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(OFFICENAME))
															AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FULL_NAME))
															);
  ut.CleanFields(GoodNameRec,ClnNameRec);
 	//Map Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(rLayout_License pInput) := TRANSFORM

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
		
		//Standardize Fields
		TrimLicNum		 				:= ut.CleanSpacesAndUpper(pInput.LIC_NUM);
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.FULL_NAME);
		TrimNAME_OFFICE 			:= ut.CleanSpacesAndUpper(pInput.OFFICENAME);
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS_1);
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.ADDRESS_2);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY_1);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE_1);
		TrimZip								  := StringLib.StringFilterOut((ut.CleanSpacesAndUpper(pInput.ZIP_1)),'="');
				
    //Handling Business Names per License Type REE & REC
    CorpPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.* CORP\\.$|^.* CORP|\\.COM$|.NET$|.ORG$)';
		SELF.TYPE_CD					:= IF(TrimLicNum[1..3] = 'REE','GR',
																	IF(TrimLicNum[1..3] = 'REC' AND REGEXFIND(CorpPattern, TrimNAME_ORG),'GR',
																	'MD'));
		prepNAME_ORG					:= IF(SELF.type_cd = 'GR', TrimNAME_ORG,
		                             IF(SELF.type_cd = 'MD' AND TrimNAME_ORG = 'TEST ACCOUNT1', TrimNAME_ORG,''));
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																prepNAME_ORG);		
		StdNAME_ORG 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG);
		CleanNAME_ORG					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
												         REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		

		// Identify NICKNAME in the various format 
		tempNick 							:= IF(SELF.TYPE_CD = 'MD',Prof_License_Mari.fGetNickname(TrimNAME_ORG,'nick'),'');		
		//Removing NickName from Parsed First/Last Name fields
		removeNick						:= IF(SELF.TYPE_CD = 'MD',Prof_License_Mari.fGetNickname(TrimNAME_ORG,'strip_nick'),'');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		
		GoodIndvName					:= IF(tempNick != '',stripNickName,
																IF(SELF.TYPE_CD = 'MD',TrimNAME_ORG,''));
		InitParsedName 				:= IF(GoodIndvName != '', Address.CleanPersonFML73(GoodIndvName), '');
		lenLastName						:= LENGTH(TRIM(InitParsedName[46..65],LEFT,RIGHT));
		ParsedName						:= IF(lenLastName = 1, NID.CleanPerson73(GoodIndvName), InitParsedName);
		lenLastName_addl			:= LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT));
		FirstName 						:= IF(lenLastName_addl<>1,
		                            TRIM(ParsedName[6..25],LEFT,RIGHT),
																REGEXFIND('([A-Z]+) ([A-Z]{1}) ([A-Z]+)', GoodIndvName, 1));
		MidName   						:= IF(lenLastName_addl<>1, 
		                            TRIM(ParsedName[26..45],LEFT,RIGHT),
																REGEXFIND('([A-Z]+) ([A-Z]{1}) ([A-Z]+)', GoodIndvName, 2));
		LastName  						:= IF(lenLastName_addl<>1, 
		                            TRIM(ParsedName[46..65],LEFT,RIGHT),
																REGEXFIND('([A-Z]+) ([A-Z]{1}) ([A-Z]+)', GoodIndvName, 3));
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		
		ConcatNAME_FULL 			:= 	StringLib.StringCleanSpaces(LastName +' '+FirstName);
		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD' AND NOT REGEXFIND('TEST ACCOUNT1',TrimNAME_ORG),ConcatNAME_FULL, StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' '))); 
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));	
    SELF.NAME_ORG_ORIG	  := TrimNAME_ORG;																	
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= IF(tempNick<>'',StringLib.StringCleanSpaces(tempNick),'');	
		
		prepNAME_OFFICE 			:= MAP(TrimNAME_OFFICE[1..6] = 'D/B/A ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ','DBA '),
													 TrimNAME_OFFICE[1..4] = 'DBA/' => StringLib.StringFindReplace(TrimNAME_OFFICE,'DBA/','DBA '),
													 StringLib.StringFind(TrimNAME_OFFICE,'D/B/A, A/K/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A, A/K/A ','DBA '),
													 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
													 REGEXFIND('(SELF EMPLOYED|NO LICENSE RETURNED|STILL HAS LICENSE|LICENSEE PASSED AWAY)',TrimNAME_OFFICE) => '',
													 REGEXFIND('^[0-9]',TrimNAME_OFFICE) and Prof_License_Mari.func_is_address(TrimNAME_OFFICE)
															AND REGEXFIND(Addr_Pattern,TrimNAME_OFFICE) => '',
																												TrimNAME_OFFICE);
		//Identifying DBA NAMES
		getNAME_DBA	:= MAP(REGEXFIND(DBA_Ind,prepNAME_ORG) =>  Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
											 REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
											 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
														 													'');
																						
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
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
	  
		rmvOfficeDBA := MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																						prepNAME_OFFICE);
																					
		StdNAME_OFFICE	 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
														IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE	    :=	MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																  TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) =>'', 
																  TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																	TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
		                              CleanNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
		
 	  //Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		
    nextYear							:= (INTEGER) thorlib.wuid()[2..5] + 1;
		SELF.EXPIRE_DTE				:= IF(TrimLicNum[3] in ['C','S','B'], (STRING4)nextYear + '0430', '17530101');
	
	  // License Information
		SELF.LICENSE_NBR	  		:= IF(TrimLicNum != '',TrimLicNum,'NR');
		SELF.OFF_LICENSE_NBR		:= '';


		SELF.RAW_LICENSE_TYPE		:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);
		SELF.STD_LICENSE_TYPE		:= IF(TrimLicNum<>'', REGEXFIND('^([A-Z]+)\\.',TrimLicNum,1),'');
		
		SELF.RAW_LICENSE_STATUS := pInput.LIC_STATUS;
		SELF.STD_LICENSE_STATUS := SELF.RAW_LICENSE_STATUS[1];
																					
	  //Populating MARI Name Fields
		SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_MARI_ORG	  := IF(SELF.type_cd ='GR', StdNAME_ORG, SELF.NAME_OFFICE);
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
	  TrimPhone             := IF(TRIM(pInput.BUS_PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(pInput.BUS_PHONE,'0123456789'),' ');		
		SELF.PHN_MARI_1				:= ut.CleanPhone(TrimPhone);
		SELF.PHN_PHONE_1    	:= ut.CleanPhone(TrimPhone);

    //Populating Address fields		
	  SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimCity + TrimState + TrimZip) != '','B','');	

	  //Use address cleaner to clean address
		tmpZip	  						:= MAP(LENGTH(TrimZip)=3 => '00'+TrimZip,
		                      LENGTH(TrimZip)=4 => '0'+TrimZip,
																        TRIM(TrimZip) = '0' => '',
																        TrimZip);
																				
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != '' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		
		//Filtering out Business Names from Address fields			
		AddrBusContact	:= MAP(REGEXFIND(C_O_Ind,TrimAddress1) =>
																	Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
													 REGEXFIND(C_O_Ind,prepNAME_OFFICE) =>
																	Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),				
																																	'');
																	
		ParseContact	:= IF(AddrBusContact != '' AND NOT Prof_License_Mari.func_is_company(AddrBusContact), 
																				Address.CleanPersonFML73(AddrBusContact),'');
		SELF.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
			  
	  //Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		

		SELF.MLTRECKEY			:= 0;
  	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																			+ut.CleanSpacesAndUpper(pInput.ADDRESS_1)
																			+ut.CleanSpacesAndUpper(pInput.CITY_1)
																			+ut.CleanSpacesAndUpper(pInput.STATE_1)
																			+ut.CleanSpacesAndUpper(pInput.ZIP_1));
																								   
		SELF.PCMC_SLPK			:= 0;
		
		SELF := [];	
		   
	END;
	inFileLic	:= PROJECT(ClnNameRec,xformToCommon(LEFT));

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base 	trans_lic_type(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																			

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(ds_map_lic_trans L) := transform
		SELF.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, ' ');
		SELF.NAME_OFFICE		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
		SELF.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		
		SELF := L;
	END;

	ds_map_base := PROJECT(ds_map_lic_trans, xTransToBase(LEFT));

	// Adding to Superfile
	d_final 							:= OUTPUT(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));			

	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');
	                         Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using', 'used');
	                        );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oAPR, oRE,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;