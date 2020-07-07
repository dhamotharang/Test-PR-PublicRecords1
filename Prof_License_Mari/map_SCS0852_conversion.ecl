/* Converting South Carolina Real Estate Commission Real Estate License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
#WORKUNIT('name','Prof License MARI- SCS0852')
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_SCS0852_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt:Prof License MARI- SCS0852   ' + pVersion);
	code 										:= 'SCS0852';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	

	Comments 								:= 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions 					:= '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
														 'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS)';

	NoAddrConcatInd 				:= '(ONE |TWO |FOUR| RD/|STREET| DRIVE|BOX |AVENUE| AVE |PLAZA |THE |CENTER WEST|FOUNTAIN AV|- RECREATION BLDG|- RECREATION BUILDING|'+
														 'HILL ROAD|HAYWOOD ST|VILLA |PARKWAY| BUILDING| BLDG| - PRESIDENT)';											

	AddrExceptions					:= '(PLAZA|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
														 'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
														 ' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
														 'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK)';

	C_O_Ind 								:= '(C/O |ATTN: |ATTN )';
  //DBA Pattern
	DBApattern	:= '^(.*)(DBA - |/ DBA | DBA/|DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA| D/B/A|C/O |C/0 |ATTN:|ATT:|ATTN - |ATTN |ATTENTION |ATTENTION:|ATN:| AKA |^AKA | A/K/A | A/K/A|T/A )(.*)';
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','sprayed','using');
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','sprayed','using');	
																			);
	
	rle											:= Prof_License_Mari.files_SCS0852.active +
														 PROJECT(Prof_License_Mari.files_SCS0852.inactive,TRANSFORM(Prof_License_Mari.layout_SCS0852.rActiveAgent,
																																										 SELF := LEFT;
																																										 SELF := []));										

	//Filtering out BAD RECORDS
	ut.CleanFields(rle, ClnUnprintable);
	FilterBlankLic					:= ClnUnprintable(LIC_NUM != '' AND SUB_CATEGORY <> '' AND LIC_TYPE='REL');
	FilterBadName						:= FilterBlankLic(StringLib.StringToUpperCase(LAST_NAME[1..5]) NOT IN ['ERROR', 'LAST ']);
	GoodNameRec 						:= FilterBadName(NOT REGEXFIND('(ENTERED IN ERROR|IN ERROR|INPUT ERROR|ERROR|REQUIRED C E COURSE)', StringLib.StringToUpperCase(TRIM(OFFICE_NAME,LEFT,RIGHT))) 
	                                         AND TRIM(FIRST_NAME+MID_NAME+LAST_NAME+OFFICE_NAME)<>'');
	oFile										:= OUTPUT(SAMPLE(GoodNameRec, 40,1));
	
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in xformToCommon(GoodNameRec pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= code[1..2];
		SELF.TYPE_CD					:= 'MD';

		// License Information
		SELF.LICENSE_NBR	  	:= ut.CleanSpacesAndUpper(pInput.LIC_NUM);
		SELF.OFF_LICENSE_NBR	:= ut.CleanSpacesAndUpper(pInput.OFF_SLNUM);
		SELF.OFF_LICENSE_NBR_TYPE := IF(SELF.OFF_LICENSE_NBR<>'','OFFICE LICENSE NUMBER','');			//Review comment on Bug 160647
		SELF.PROVNOTE_2				:= IF(pInput.SUPCREDNUM<>'',
		                            'SUPERVISES CREDENTIAL NUMBER='+	ut.CleanSpacesAndUpper(pInput.SUPCREDNUM),
																'');											 
		//LICTYPE is stored in sub-category
		SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(pInput.SUB_CATEGORY);
		SELF.STD_LICENSE_TYPE := IF(SELF.RAW_LICENSE_TYPE = 'RE','REA',SELF.RAW_LICENSE_TYPE);
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.LICSTAT);
							
		//Reformatting date to YYYYMMDD
		tmp_curr_issue_dte		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EFFECTIVE_DATE);
		SELF.CURR_ISSUE_DTE		:= IF(tmp_curr_issue_dte[1..3]='301','201'+tmp_curr_issue_dte[4..],tmp_curr_issue_dte);
		tmp_orig_issue_dte		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.FIRST_ISSUE_DATE);
		SELF.ORIG_ISSUE_DTE		:= IF(tmp_orig_issue_dte[1..3]='301','201'+tmp_orig_issue_dte[4..],tmp_orig_issue_dte);
		tmp_expiration_dte		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPIRATION_DATE);
		SELF.EXPIRE_DTE				:= IF(tmp_expiration_dte[1..3]='301','201'+tmp_expiration_dte[4..],tmp_expiration_dte);
			
		//Process names and address
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		TrimNAME_OFFICE				:= ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(pInput.OFFICE_NAME));
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		TrimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);	
		TrimZip2							:= ut.CleanSpacesAndUpper(pInput.ZIP_MAIN);	
		TrimSupCredNum				:= ut.CleanSpacesAndUpper(pInput.SUPCREDNUM);	  //Supervising
		TrimSupdCredNum				:= ut.CleanSpacesAndUpper(pInput.OFF_SLNUM);			//Supervised by
		FullName							:= StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_MID + ' ' + TrimNAME_LAST);

		// Process names 
		tempNick 							:= Prof_License_Mari.fGetNickname(FullName,'nick');
		removeNick						:= Prof_License_Mari.fGetNickname(FullName,'strip_nick');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		ParsedName 						:= Address.CleanPersonFML73(stripNickName);		
		FirstName 						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))>1,TRIM(ParsedName[6..25],LEFT,RIGHT),TrimNAME_FIRST);
		MidName   						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))>1,TRIM(ParsedName[26..45],LEFT,RIGHT),TrimNAME_MID);;	
		LastName  						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))>1,TRIM(ParsedName[46..65],LEFT,RIGHT),TrimNAME_LAST);; 
		Suffix	  						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))>1,TRIM(ParsedName[66..70],LEFT,RIGHT),'');;
		//ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+Suffix+ ' '+FirstName);

		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);	
			
		SELF.NAME_ORG		    	:= LastName + ' ' + FirstName;
		SELF.NAME_ORG_ORIG	  := FullName;
		SELF.NAME_FORMAT			:= 'F';
			
		// Prepping Address Fields for Parsing
		cln_preaddr1					:= StringLib.StringCleanSpaces(TrimAddress1+' '+TrimAddress2);
		cln_preaddr2	 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+ TrimZip); 

		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(cln_preaddr1,cln_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(tmpADDR_ADDR1_1);	
		SELF.ADDR_ADDR2_1			:= StringLib.StringCleanSpaces(tmpADDR_ADDR2_1); 
		SELF.ADDR_CITY_1			:= IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1			:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1			:= IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TrimZip);
		SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];

		//New field zip_main. Store it in addr.._2
		TrimZip_p1						:= IF(REGEXFIND('-',TrimZip2),TRIM(REGEXFIND('([0-9]+)\\-([0-9]*)',TrimZip2,1)),TrimZip2);
		SELF.ADDR_ZIP5_2			:= IF(LENGTH(TrimZip_p1)=4, '0'+TrimZip_p1, TrimZip_p1);
		SELF.ADDR_ZIP4_2			:= REGEXFIND('([0-9]+)\\-([0-9]*)',TrimZip2,2);
				
		//Identifying Office and DBA NAMES
		getNAME_OFFICE				:= IF(REGEXFIND(DBAPattern,TrimNAME_OFFICE),Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimNAME_OFFICE),
		                            TrimNAME_OFFICE);
		getNAME_DBA						:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_OFFICE);

		//Clean DBA
		StdNAME_DBA      			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(\\.COM|\\.NET|\\.ORG)',StdNAME_DBA) 
																=> Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
															 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) 
																=> Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),									    
															 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
															 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) 
															  => StdNAME_DBA,
									   					 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= If(SELF.NAME_DBA != '',1,0);
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA<>'',getNAME_DBA,'');		//MARI_DBA-Original DBA name not standardized
		SELF.NAME_DBA_ORIG	  := IF(SELF.NAME_DBA<>'',getNAME_DBA,'');		//ORIG_DBA-Unstandardized DBA name
	  
		//Clean office name
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(\\.COM|\\.NET|\\.ORG)',StdNAME_OFFICE), 
															  Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
															  IF(REGEXFIND('(%)',StdNAME_OFFICE),
																 	 StdNAME_OFFICE,
																	 Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
				
		SELF.NAME_OFFICE	  	:= MAP(CleanNAME_OFFICE<>'' AND REGEXFIND(DBApattern,CleanNAME_OFFICE)=>StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.GetCorpName(CleanNAME_OFFICE)),
                                 CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.name_first,ALL) + TRIM(SELF.name_last,ALL)=>'', 															     
																 CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.name_last,ALL) + TRIM(SELF.name_first,ALL)=>'', 
																 CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.name_first,ALL) + TRIM(SELF.name_mid,ALL) + TRIM(SELF.name_last,ALL)=>'',
																 CleanNAME_OFFICE);		
																 
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),
																   'MD',
																	 ''));
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;
																					
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2 + TrimCity + pInput.ZIP) != '','B','');
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																			+TrimAddress1
																			+TrimAddress2
																			+TrimCity
																			+TrimZip);
																								   
		SELF.PCMC_SLPK			:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(GoodNameRec,xformToCommon(left));

	
	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := join(inFileLic, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layout_base_in trans_lic_status(ds_map_lic_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_lic_trans, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	remove_logical := SEQUENTIAL(fileservices.startsuperfiletransaction(),
														fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
														fileservices.finishsuperfiletransaction()
														);


	d_final := OUTPUT(ds_map_stat_trans, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_stat_trans(NAME_ORG_ORIG != ''));			


	move_to_used						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active','using','used');
																			Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive','using','used');	
																			);
	
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used/*, notify_missing_codes, notify_invalid_address*/);
	
END;	
