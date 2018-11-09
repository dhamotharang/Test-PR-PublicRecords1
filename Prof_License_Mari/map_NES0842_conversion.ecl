//************************************************************************************************************* */	
//  The purpose of this development is take NE Real Estate License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_NES0842_conversion(STRING pVersion) := FUNCTION

	code 								:= 'NES0842';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//NE input file
	ds_NE_RealEstate		:= Prof_License_Mari.file_NES0842;
	oFile								:= OUTPUT(ds_NE_RealEstate);
	
	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(ds_Cmvtranslation);
	
	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';
  SUFFIX_PATTERN  := '(, JR$|, JR.$| JR,|, SR$|, SR.$|, III$|, II$|, IV$|, V$)';
	
	CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.*L\\.L\\.C|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC |^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';
	C_O_Ind := '(ATTN: |ATTN |ATTENTION:|ATTENTION)';
	
	//Remove bad records before processing
	ValidNEFile	:= ds_NE_RealEstate(TRIM(NAME) <> ' ' AND NOT REGEXFIND('^[0-9]',NAME));
	ut.CleanFields(ValidNEFile,ClnInFile);
	
	Prof_License_Mari.layouts.base	transformToCommon(Prof_License_Mari.layout_NES0842.common L) := TRANSFORM
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= L.ln_filedate;							//it was set to process_date before
		SELF.STAMP_DTE      	:= L.ln_filedate;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE		:= src_st;

		//NE Real Estate layout to Common
		SELF.TYPE_CD					:= 'MD';

		//Process label 1 data
		trimLabel 						:= ut.CleanSpacesAndUpper(L.LABEL2);
		//Get employing broker's office names
    searchpattern1 	:= '^(.*)\\|(.*)\\|(.*)$';
    searchpattern2 	:= '^(.*)\\|(.*)\\|(.*)\\|(.*)$';
    searchpattern3	:= '^(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)$';

    //parsing individual name
    vline1 := MAP(REGEXFIND(searchpattern3, trimLabel)	=>  REGEXFIND(searchpattern3, trimLabel,1),
	 					      REGEXFIND(searchpattern2,trimLabel)		=>  REGEXFIND(searchpattern2, trimLabel,1),	
							    REGEXFIND(searchpattern1,trimLabel,1));
    //parsing office name																															
    vline2 := MAP(REGEXFIND(searchpattern3, trimLabel) 	=>  REGEXFIND(searchpattern3, trimLabel,2),
							    REGEXFIND(searchpattern2,trimLabel)		=>  REGEXFIND(searchpattern2, trimLabel,2), 
							    '');
					
    //parsing 2nd office name																						
    vline3 := MAP(REGEXFIND(searchpattern3, trimLabel)	=>  REGEXFIND(searchpattern3, trimLabel,3),
							    '');
						
    //address																						
    vline4 := MAP(REGEXFIND(searchpattern3, trimLabel)	=>  REGEXFIND(searchpattern3, trimLabel,4),
							    REGEXFIND(searchpattern2,trimLabel)		=>  REGEXFIND(searchpattern2, trimLabel,3), 
							    REGEXFIND(searchpattern1, trimLabel,2));
    //state, zip																																	
    vline5 := MAP(REGEXFIND(searchpattern3, trimLabel)	=>  REGEXFIND(searchpattern3, trimLabel,5),
							    REGEXFIND(searchpattern2, trimLabel)	=>  REGEXFIND(searchpattern2, trimLabel,4), 
							    REGEXFIND(searchpattern1, trimLabel,3));

		tmpLabelOfficeName		:= MAP(vline2<>'' AND NOT Prof_License_Mari.func_is_address(vline2) => vline2,
		                             vline2<>'' AND REGEXFIND(CoPattern, vline2) => vline2,
																 '');
		tmpLabelOfficeName2		:= MAP(vline3<>'' AND NOT Prof_License_Mari.func_is_address(vline3) => vline3,
																 vline3<>'' AND REGEXFIND(CoPattern, vline3) => vline3,
																 '');
																
		/*Remove nickname and concat name to be used for name parser.
		Parse name using F M. and L, Sx. pattern for names that do not clean*/
		UpperName							:= ut.CleanSpacesAndUpper(L.NAME);		//NAME format - LAST, FIRST MIDDLE, SUFFIX
		FixName								:= IF(REGEXFIND('\'(.*)\'',UpperName),REGEXREPLACE('\'',UpperName,'"'),UpperName);

		//Extrace nick name
		tmpNick_Name					:= Prof_License_Mari.fGetNickname(FixName,'nick');
		rmv_NickName					:= Prof_License_Mari.fGetNickname(FixName,'strip_nick');
    
		rmvSufxName           := REGEXREPLACE(SUFFIX_PATTERN,rmv_NickName,',');
		tmp_Suffix						:= REGEXREPLACE(',',REGEXFIND(SUFFIX_PATTERN,rmv_NickName,0),'');
		ClnNameFull						:= Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TRIM(rmvSufxName));
		//Parse name
		tmpLNameLen						:= LENGTH(TRIM(ClnNameFull[46..65],LEFT,RIGHT));
		tmpLastName						:= IF(tmpLNameLen<2,
																REGEXFIND('([^,]+),[ ]+([^ ]+)[ ]*([^ ]*)',FixName,1),
																TRIM(ClnNameFull[46..65],LEFT,RIGHT)
																);
		tmpFirstName					:= IF(tmpLNameLen<2,
																REGEXFIND('([^,]+),[ ]+([^ ]+)[ ]*([^ ]*)',FixName,2),
																TRIM(ClnNameFull[6..25],LEFT,RIGHT)
																);
		tmpMidName						:= IF(tmpLNameLen<2,
																REGEXFIND('([^,]+),[ ]+([^ ]+)[ ]*([^ ]*)',FixName,3),
																TRIM(ClnNameFull[26..45],LEFT,RIGHT)
																);
		LFMname								:= tmpLastName+' '+tmpFirstName;
		FixBlankName					:= IF(TRIM(LFMname,LEFT,RIGHT) = ' ',rmv_NickName,LFMname);
		SELF.NAME_ORG					:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(FixBlankName));
		
		SELF.NAME_FIRST				:= tmpFirstName;
		SELF.NAME_MID					:= TRIM(REGEXREPLACE(',',tmpMidName,''),LEFT,RIGHT);
		SELF.NAME_LAST				:= tmpLastName;

		SELF.NAME_SUFX				:= ut.CleanSpacesAndUpper(tmp_Suffix);
		SELF.NAME_NICK				:= TRIM(tmpNick_Name,LEFT,RIGHT);
		SELF.LICENSE_NBR			:= 'NR';  //No license number info
		
		//Mapping is based on the historical data
		tmpLicStatus            := ut.CleanSpacesAndUpper(L.LICSTAT);
		tmplicStatusDesc		  	:= ut.CleanSpacesAndUpper(L.STATUS_DESC);
		SELF.RAW_LICENSE_STATUS := IF(tmplicStatusDesc != '',tmplicStatusDesc, tmpLicStatus);
																	
	  tmpLicType            := ut.CleanSpacesAndUpper(L.LIC_TYPE);
	  tmpLicTypeDesc				:= ut.CleanSpacesAndUpper(L.LICTYPE_DESC);
		SELF.RAW_LICENSE_TYPE := IF(tmpLicTypeDesc != '', tmpLicTypeDesc,tmpLicType);
		
		SELF.STD_LICENSE_TYPE := MAP(stringlib.stringfind(TRIM(SELF.raw_license_type),'BROKER',1) = 1 => '100',
																 stringlib.stringfind(TRIM(SELF.raw_license_type),'SALESPERSON',1) = 1 => '300',
																 stringlib.stringfind(TRIM(SELF.raw_license_type),'RECIPROCAL BROKER',1) = 1 => '500',
																 stringlib.stringfind(TRIM(SELF.raw_license_type),'RECIPROCAL SALESPERSON',1) = 1 =>'700',
																 stringlib.stringfind(TRIM(SELF.raw_license_type),'BRANCH',1) = 1 => '800',
																 tmpLicType
																 );
	
	/*Default issue date is 17530101
According to the Nebraska Real Estate Commission website, all real estate licenses must be renewed once every two years.
license expires on 1231 of the next year, unless it is issued after Nov 30.
*/
		
		SELF.CURR_ISSUE_DTE		:= IF(L.CURISSUEDT = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(TRIM(L.CURISSUEDT)));
		SELF.ORIG_ISSUE_DTE		:= '17530101';

 	next_year 					  	:= ((INTEGER2) SELF.CURR_ISSUE_DTE[1..4])+1;
 	next_2_year 						:= ((INTEGER2) SELF.CURR_ISSUE_DTE[1..4])+2;
	 SELF.EXPIRE_DTE			:= map(SELF.CURR_ISSUE_DTE[5..8] < '1201' => (STRING4)next_year +'1231',
															         	  SELF.CURR_ISSUE_DTE[5..8] >= '1201' => (STRING4)next_2_year+'1231',
																				       '17530101');
																							
		SELF.ADDR_BUS_IND			:= IF(StringLib.StringCleanSpaces(TRIM(L.ADDRESS1)+TRIM(L.ADDRESS2)) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= TRIM(UpperName,LEFT,RIGHT);
		SELF.NAME_FORMAT			:= 'L';
	
		//Identify officename in address and clean up address
		UpperAddr1						:= ut.CleanSpacesAndUpper(REGEXREPLACE('\'',L.ADDRESS1,''));
		UpperAddr2						:= ut.CleanSpacesAndUpper(REGEXREPLACE('\'',L.ADDRESS2,''));
		Addr2InAddr1					:= IF(UpperAddr2 = ' ' AND StringLib.stringfind(UpperAddr1,'(',1) >0 
																AND REGEXFIND('^([A-Za-z0-9 ][^\\(]+)[\\(]([A-Za-z0-9 ][^\\)]+)[\\)]',UpperAddr1),
																REGEXFIND('^([A-Za-z0-9 ][^\\(]+)[\\(]([A-Za-z0-9 ][^\\)]+)[\\)]',UpperAddr1,2),' ');
		RmvAddr2InAddr1				:= IF(Addr2InAddr1 != ' ',REGEXREPLACE(Addr2InAddr1,UpperAddr1,''), UpperAddr1);
		temp_addr1_1  				:= StringLib.StringFindReplace(RmvAddr2InAddr1,'(','');
		temp_addr1_2  				:= StringLib.StringFindReplace(temp_addr1_1,')','');
		temp_addr1_3  				:= StringLib.StringFindReplace(temp_addr1_2,'*','');
		
		OfficeName						:= MAP(tmpLabelOfficeName<>''
																   => tmpLabelOfficeName,
																	tmpLabelOfficeName='' AND tmpLabelOfficeName2<>''
																   => tmpLabelOfficeName2,
																 UpperAddr2 != ' ' AND 
		                             NOT REGEXFIND('([0-9]+|#|P[ ]*O |P[.]*O[.]*|BOX |RR |RT |NUMBER [0-9]+|ATTN|.* PLAZA$)',temp_addr1_3)
																   => temp_addr1_3,
																 '');
		//Use address cleaner to clean address
		trimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS1);
		trimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS2);
			
		//Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.CITY+' '+L.STATE +' '+L.ZIP); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.STATE));
		tmpZip          		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(L.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP5_1		  := IF(LENGTH(TRIM(tmpZip,LEFT,RIGHT)) = 4,'0'+TRIM(tmpZip[1..5],LEFT,RIGHT),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

	  //Store ZIP2
		tmpZip2								:= StringLib.StringFindReplace(TRIM(L.ZIP2,LEFT,RIGHT),'-','');
		SELF.ADDR_ZIP5_2			:= IF(LENGTH(TRIM(tmpZip2,LEFT,RIGHT)) = 4,'0'+TRIM(tmpZip2[1..5],LEFT,RIGHT),tmpZip2[1..5]);
		SELF.ADDR_ZIP4_2			:= IF(TRIM(tmpZip2[6..9],LEFT,RIGHT) = '0000','',TRIM(tmpZip2[6..9],LEFT,RIGHT));
																 
		ClnBadOffice					:= IF(REGEXFIND('( STE | BLD | HWY)',OfficeName),'',OfficeName);
		CleanOffice           := MAP(REGEXFIND('(ATTENTION:|ATTENTION)',ClnBadOffice) => '',
																 REGEXFIND('(^C/O )',ClnBadOffice) => REGEXREPLACE('(^C/O )',ClnBadOffice,''),
		                             stringlib.stringfilterout(ClnBadOffice,'//.'));
		stdOfficeName					:= stringlib.stringfilterout(ut.CleanSpacesAndUpper(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(CleanOffice)),'//*');
		SELF.NAME_OFFICE			:= IF(REGEXFIND(IPpattern,ClnBadOffice),ClnBadOffice,REGEXREPLACE(' COMPANY',stdOfficeName,' CO'));
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ','GR','');
		SELF.NAME_MARI_ORG		:= IF(TRIM(SELF.TYPE_CD)='MD',TRIM(SELF.NAME_OFFICE), TRIM(rmv_NickName,LEFT,RIGHT));
		clnLabelOfficeName2   := REGEXREPLACE('(ATTENTION:|ATTENTION)',tmpLabelOfficeName2,'');
    SELF.PROVNOTE_2       := IF(TRIM(tmpLabelOfficeName2,LEFT,RIGHT) <> '' AND SELF.NAME_OFFICE <>'','ADDL OFFICE NAME: '+ stringlib.stringfilterout(clnLabelOfficeName2,'//*'),'');

		//Populate contact information
		tmpAddr1Contact				:= IF(REGEXFIND(C_O_Ind,trimAddress1), Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress1),'');
																																							
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact) => '',
																 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																 Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																 '');
																 																 
		SELF.NAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);														 
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST 	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX 	:= TRIM(ParseContact[66..70],LEFT,RIGHT); 
														
	  // fields used to create mltreckey key are:
	  // license number
	  // license type
	  // source update
	  // name
	  // address_1
	  // dba
	  // officename
		SELF.mltreckey 			:= 0; //This file doesn't have multiple DBA's
	
		// fields used to create cmc_slpk unique key are :
		// license number -- this file doesn't have a license number
		// license type
		// source update
		// standard name_org
		// raw address 	
		SELF.CMC_SLPK     		:= HASH64(TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																		+TRIM(L.NAME,LEFT,RIGHT)				//Needed for those records that have the same first and last, but different middle names
																		+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
																		+TRIM(SELF.ADDR_ADDR2_1,LEFT,RIGHT)
																		+TRIM(L.CITY,LEFT,RIGHT)
																		+TRIM(L.STATE,LEFT,RIGHT)
																		+TRIM(L.ZIP,LEFT,RIGHT));
		
		SELF := [];
	END;

	ds_map_addr2 := PROJECT(ClnInFile, transformToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_addr2 L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_addr2, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	// look up standard license status 
	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;
	
	ds_map_status_trans := JOIN(ds_map_lic_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
	// populate disp_type code field via translation on license status field
	Prof_License_Mari.layouts.base trans_disp_type(ds_map_status_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.DISP_TYPE_CD := R.DM_VALUE2;
		SELF := L;
	END;

	ds_map_disp_trans 	:= JOIN(ds_map_status_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_disp_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	d_final 						:= OUTPUT(ds_map_disp_trans, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
			
	add_super 					:= Prof_License_Mari.fAddNewUpdate(ds_map_disp_trans);																		
	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');	
																	);
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCMV, oFile, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;