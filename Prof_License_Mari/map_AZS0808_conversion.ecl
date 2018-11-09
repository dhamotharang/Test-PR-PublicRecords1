IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_AZS0808_conversion(STRING pVersion) := FUNCTION

	code 								:= 'AZS0808';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	SrcCmvTrans				:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV							:= OUTPUT(SrcCmvTrans);
	
	move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');
	                        );
	ut.CleanFields(Prof_License_Mari.file_AZS0808, inFile);
	oApr		:= OUTPUT(inFile);
	
	//Filtering out BAD RECORDS
	ValidRecs	:= inFile(NAME_LAST != '' AND TRIM(NAME_LAST) != 'X' AND LICENSE_NBR != '' AND LICENSE_NBR != 'PENDING' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(NAME_LAST)));
	cnt_valid_rec := COUNT(ValidRecs);
	
	//Map Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(Prof_License_Mari.layout_AZS0808 pInput) := TRANSFORM

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

		SELF.TYPE_CD					:= 'MD'; 
			
		trimNAME_LAST					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.NAME_LAST);
		//Some of the first names have partial nick name. Remove it.
		prepNAME_FIRST				:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.NAME_FIRST);
		trimNAME_FIRST				:= MAP(REGEXFIND('^([^\\(]+)\\([^\\)]*\\)', prepNAME_FIRST) => prepNAME_FIRST,
																 REGEXFIND('\\(', prepNAME_FIRST) AND NOT REGEXFIND('\\)',prepNAME_FIRST)
																		=> REGEXFIND('^([^\\(]+)\\(',prepNAME_FIRST,1),
																 prepNAME_FIRST);			 	
	
		// Identify NICKNAME in the various format 
		tempFNick 						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		tempLNick							:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'nick');
		
		//Removing NickName from Parsed First/Last Name fields
		removeFNick						:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(TrimNAME_LAST,'strip_nick');

		stripNickFName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick));
		stripNickLName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick));
		
		GoodFirstName					:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		GoodLastName					:= IF(tempLNick != '',stripNickLName,TrimNAME_LAST);
		ParsedName 						:= Address.CleanPersonFML73(GoodFirstName +' '+GoodLastName);
																						
		FirstName 						:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		//Sometimes, the parser takes middle name for the last name when the last name contains known words.
		//For example Briefer, Capitain, Homes, Law
		MidName   						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))=1,
																TRIM(ParsedName[46..65],LEFT,RIGHT),
																IF(LENGTH(FirstName)=1 AND (trimNAME_LAST='BEDELL' OR trimNAME_LAST='COX'),
																   TRIM(REGEXREPLACE('^'+FirstName+'.',GoodFirstName,''),LEFT,RIGHT),
																   TRIM(ParsedName[26..45],LEFT,RIGHT)));	
		LastName  						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))<2 OR trimNAME_LAST='BEDELL' OR
		                            (LENGTH(FirstName)=1  AND trimNAME_LAST='COX'),
																trimNAME_LAST,
																TRIM(ParsedName[46..65],LEFT,RIGHT)); 
		Suffix	  						:= IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))<2,
																'',
																TRIM(ParsedName[66..70],LEFT,RIGHT));
		ConcatNAME_FULL 			:= 	StringLib.StringCleanSpaces(LastName +' '+FirstName);
		
		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_ORG_ORIG		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.NAME_FIRST) +
		                                                     ' ' +
																												 Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.NAME_LAST));
		SELF.NAME_FORMAT			:= 'F';
		
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																 '');	
		SELF.LICENSE_NBR	    := pInput.LICENSE_NBR;
			
		TrimLicType						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LICENSE);
		SELF.RAW_LICENSE_TYPE	:= TrimLicType;
			
		StripLicType  				:= StringLib.StringCleanSpaces(
		                                  Prof_License_Mari.mod_clean_name_addr.strippunctName(TrimLicType));
		SELF.STD_LICENSE_TYPE := MAP(StripLicType = 'CERT GENERAL' => 'CGA',
																 StripLicType = 'CERT GENERLA' => 'CRA',
																 StripLicType = 'CERT RESIDENTIAL' => 'CRA',
																 StripLicType = 'CERT RESIDENTAIL' => 'CRA',
																 StripLicType	= 'CERT RESIDENITAL' => 'CRA',
																 StripLicType = 'LICENSED' => 'LA',
																 StripLicType = 'LICENESED' => 'LA',
																 StripLicType[1..15] = 'TEMPCERTGENERAL' => 'TCGA',
																 StripLicType[1..14] = 'TEMPCERGENERAL'  => 'TCGA',
																 StripLicType = 'TEMPLICENSED' => 'TLA',
																 StripLicType = 'PROPERTY TAX AGENT' => 'PTA',
																 StripLicType = 'AMC' => 'AMC',			//new license type AMC - Appraisal Management Company 10/4/13
																 StripLicType = 'PENDING AMC' => 'PAMC',		//new license type 10/4/13
																 StripLicType = 'APPR TRAINEE' => 'T',			//New license type 1/2015          
																 StripLicType = 'TRAINEE APPRAISER' => 'T',			//New license type 1/2016 
																 StripLicType = 'DS SUPERVISOR' => 'DS', 		//New license type 1/2015                                                                                      
																 StripLicType = 'DS SUPERVISORY' => 'DS', 	//New license type 1/2015                                                                                      
																 '');
		SELF.RAW_LICENSE_STATUS := '';
		SELF.STD_LICENSE_STATUS	:= 'A';
		SELF.STD_STATUS_DESC	:= 'ACTIVE';
			
		//Reformatting date from MM/DD/YYYY to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		tmp_ORIG_ISSUE_DTE		:= IF(pInput.ISSUE_DTE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUE_DTE),'17530101');
		//Fix a typo from the input file 1/24/14
		SELF.ORIG_ISSUE_DTE		:= IF(REGEXFIND('^[0-9]{8}$',tmp_ORIG_ISSUE_DTE),
		                            IF(tmp_ORIG_ISSUE_DTE[1..4]='3013','2013'	+tmp_ORIG_ISSUE_DTE[5..8],	tmp_ORIG_ISSUE_DTE),
																'17530101');
		tmp_EXPIRE_DTE			:= IF(pInput.EXPIRE_DTE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPIRE_DTE),'17530101');
		SELF.EXPIRE_DTE			:= IF(REGEXFIND('^[0-9]{8}$',tmp_EXPIRE_DTE),tmp_EXPIRE_DTE,'17530101');
		SELF.ADDR_BUS_IND		:= IF(TRIM(pInput.ADDR_ADDRESS1 + pInput.ADDR_CITY + pInput.ADDR_ZIP) != '','B','');
		TrimPhone           := TRIM(StringLib.StringFilter(pInput.PHONE,'0123456789'),LEFT,RIGHT);
		SELF.PHN_MARI_1			:= ut.CleanPhone(TrimPhone);
		SELF.PHN_PHONE_1    := ut.CleanPhone(TrimPhone);
	
		//Extract company name out of address field
		COMPANY_PATTERN := '^(.*LLC,)';
		TrimAddress1				:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDR_ADDRESS1);
		TempBusNameFlag			:= IF(REGEXFIND(COMPANY_PATTERN,TrimAddress1),'YES','NO');
		TempBusName					:= IF(REGEXFIND(COMPANY_PATTERN,TrimAddress1),
														 REGEXFIND(COMPANY_PATTERN,TrimAddress1,1),
														 ' ');
		StripAddress1				:= TRIM(IF(TRIM(TempBusName)<>'',REGEXREPLACE(TempBusName,TrimAddress1,''),TrimAddress1),LEFT,RIGHT);
		
		SELF.NAME_OFFICE		:= IF(TempBusName<>' ',
															StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(TempBusName)),
															' ');
		SELF.OFFICE_PARSE		:= IF(SELF.NAME_OFFICE<>' ','GR',' ');
		
		SELF.NAME_MARI_ORG	:= IF(TRIM(SELF.TYPE_CD,LEFT,RIGHT)='MD',TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'');
		
		//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';

  	TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDR_CITY);
   	TrimState							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDR_STATE);
 		tmpZip	        			:= MAP(LENGTH(TRIM(pInput.ADDR_ZIP))=3 => '00'+TRIM(pInput.ADDR_ZIP),
		                             LENGTH(TRIM(pInput.ADDR_ZIP))=4 => '0'+TRIM(pInput.ADDR_ZIP),
																 TRIM(pInput.ADDR_ZIP));
		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
	
		SELF.ADDR_CNTY_1		:= pInput.ADDR_COUNTY;	
		SELF.OOC_IND_1			:= 0;    
		SELF.OOC_IND_2			:= 0;
		SELF.AFFIL_TYPE_CD		:= 'IN';
		  
		//fields used to create mltrec_key unique record split dba key are :
		// transformed license number
		// standardized license type
		// standardized source update
		// raw name containing dba name(s)
		// raw address

		SELF.MLTRECKEY				:= 0;
		  
		  // Fields used to create unique key are: license number, license type, source update, name, address,dba 
		  // SELF.CMC_SLPK				:= 0;
			SELF.CMC_SLPK         	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
											 +TRIM(SELF.std_license_type,LEFT,RIGHT)
											 +TRIM(SELF.std_source_upd,LEFT,RIGHT)
											 //Use SELF.name_org_orig instead of SELF.name_org. BIG # 124107
											 +TRIM(SELF.name_org_orig,LEFT,RIGHT)
											 // +Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.NAME_FIRST)
											 // +Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.NAME_LAST)
											 +Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDR_ADDRESS1)
											 +Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDR_CITY)
											 +TRIM(pInput.ADDR_ZIP,LEFT,RIGHT));
											 
			SELF.PROVNOTE_3 	    := '{LIC_STATUS ASSIGNED}';    //std_license_status is always assigned to 'A' 10/4/13
			SELF := [];		
		   
	END;
			
	inFileLic := PROJECT(ValidRecs, xformToCommon(left));	

	// Translating Raw codes to standardized status/license codes
	Prof_License_Mari.layouts.base	doTypeJoin(inFileLic L, SrcCmvTrans R) := TRANSFORM
	  	SELF.STD_PROF_CD	:= R.DM_VALUE1;
	  	SELF := L;
	END;

	StdLicType		:= JOIN(inFileLic, SrcCmvTrans,
												TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT) = TRIM(RIGHT.FLD_VALUE,LEFT,RIGHT) 
												AND RIGHT.FLD_NAME='LIC_TYPE' 
												AND RIGHT.DM_NAME1 = 'PROFCODE',
											  doTypeJoin(LEFT,RIGHT), LEFT OUTER, LOOKUP);

	// Adding to Superfile
	d_final := OUTPUT(StdLicType,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(StdLicType(NAME_ORG_ORIG != ''));
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');
	                        );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oApr, cnt_valid_rec, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
END;
