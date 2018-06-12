/* Converting Nebraska Appraiser Professional License File to MARI common layout
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib,std;

EXPORT map_NES0859_conversion(string pVersion) := FUNCTION
#workunit('name','Yogurt: map_NES0859_conversion');
	code 								:= 'NES0859';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	SrcCmvTrans					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(SrcCmvTrans);
	
	inFile							:= Prof_License_Mari.file_NES0859;
	oApr								:= OUTPUT(inFile);
	
	//Filtering out BAD RECORDS
	ValidRecs						:= inFile(ORG_NAME<>'');
  
	Sufx_Pattern := '(,SR\\.|,SR| SR\\.| SR|, JR|, JR\\.| JR\\.| JR| III| II| IV| VII)';	
	
	//Map Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(Prof_License_Mari.layout_NES0859.src pInput) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= pVersion;			//yyyymmdd
		SELF.LAST_UPD_DTE			:= pInput.ln_filedate;;	
		SELF.STAMP_DTE      	:= pInput.ln_filedate;;
		SELF.DATE_FIRST_SEEN	:= pVersion;
		SELF.DATE_LAST_SEEN		:= pVersion;
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		SELF.PROCESS_DATE			:= pVersion;

		SELF.TYPE_CD					:= 'MD'; 
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	  := src_st;

		trim_lic_type					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_TYPE);
		trim_full_name				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME);
		trim_office_name			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.OFFICENAME);
		trim_address					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1_1);
		trim_city							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY_1);
		trim_state						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE_1);
		trim_zip							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP);
		trim_telephone				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.TELE_1);
		trim_email						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.EMAIL_1);
			
	
		// Populate name fields. Reformat the full name into FML format because the name parser for FML works better.
		removeSufx            := IF(REGEXFIND(Sufx_Pattern,trim_full_name),REGEXREPLACE(Sufx_Pattern,trim_full_name,''),
		                            trim_full_name);
		TmpSuffix             := TRIM(REGEXFIND(Sufx_Pattern,trim_full_name,0),LEFT,RIGHT);	
		parsed_name						:= REGEXFIND('([A-Za-z\\.\\(\\) ]*)(,)[ ]([A-Za-z\\.\\(\\) ]+)',removeSufx,3) + ' ' + REGEXFIND('([A-Za-z\\.\\(\\) ]*)(,)[ ]([A-Za-z\\.\\(\\) ]+)',removeSufx,1);
		tempNick 							:= Prof_License_Mari.fGetNickname(parsed_name,'nick');
		//Removing NickName from Parsed First/Last Name fields
		removeNick						:= Prof_License_Mari.fGetNickname(parsed_name,'strip_nick');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));		
														
		GoodName							:= IF(tempNick != '',stripNickName,parsed_name);
		ParsedName 						:= Address.CleanPersonFML73(GoodName);																					
		FirstName 						:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   						:= TRIM(ParsedName[26..45]);	
		LastName  						:= TRIM(ParsedName[46..65]); 
		Suffix	  						:= IF(TmpSuffix != '',TmpSuffix,TRIM(ParsedName[66..70],LEFT,RIGHT));
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);		
		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_ORG_ORIG		:= trim_full_name;
		SELF.NAME_FORMAT			:= 'L';
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= ut.CleanSpacesAndUpper(Std.str.filterout(Suffix, ','));
		SELF.NAME_NICK				:= tempNick;	
			
		//Populate license information
		SELF.LICENSE_NBR			:= 'NR';							//license number is not available
		SELF.RAW_LICENSE_TYPE	:= trim_lic_type;
		SELF.STD_LICENSE_TYPE	:= trim_lic_type;
		
		SELF.RAW_LICENSE_STATUS := '';
		SELF.STD_LICENSE_STATUS	:= 'A';
		SELF.STD_STATUS_DESC	:= 'ACTIVE';
			
		//no license issue/expire dates are available
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.EXPIRE_DTE				:= '17530101';

		//Phone and email
		TrimPhone           := StringLib.StringFilter(trim_telephone,'0123456789');
		SELF.PHN_MARI_1			:= ut.CleanPhone(TrimPhone);
		SELF.PHN_PHONE_1    := ut.CleanPhone(TrimPhone);
		SELF.EMAIL					:= StringLib.StringToUpperCase(REGEXREPLACE('"',trim_email,''));

		//Extract company name out of address field
		COMPANY_PATTERN := '^(.*LLC,)';
		TempBusName					:=IF(REGEXFIND(COMPANY_PATTERN,trim_address),
														 REGEXFIND(COMPANY_PATTERN,trim_address,1),
														 '');
		StripAddress1				:= TRIM(IF(TRIM(TempBusName)<>'',REGEXREPLACE(TempBusName,trim_address,''),trim_address),LEFT,RIGHT);
		
		stdNAME_OFFICE		  := IF(trim_office_name<>'',
		                          StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(trim_office_name)),
															IF(TempBusName<>'',
															   StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(TempBusName)),
															   ''));
		dba_Pattern         := '( DBA |^DBA |D/B/A)';
		tempdba             := IF(REGEXFIND(dba_Pattern,stdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.GetDBAName(stdNAME_OFFICE),'');
		rmvdba              := IF(REGEXFIND(dba_Pattern,stdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.GetCorpName(stdNAME_OFFICE),stdNAME_OFFICE);														 
		SELF.NAME_OFFICE    := MAP(TRIM(rmvdba,ALL)= TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
		                           TRIM(rmvdba,ALL)= TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
															 TRIM(rmvdba,ALL)= TRIM(SELF.NAME_LAST + SELF.NAME_FIRST,ALL) => '',
															 rmvdba);		
															 
															 
		SELF.OFFICE_PARSE		:= IF(SELF.NAME_OFFICE<>'','GR','');	
		SELF.NAME_MARI_ORG	:= IF(TRIM(SELF.NAME_OFFICE)<>'',TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'');
		
		SELF.NAME_DBA       := tempdba;
		SELF.DBA_FLAG			  := IF(SELF.NAME_DBA != '',1,0);
		SELF.NAME_MARI_DBA	:= IF(SELF.name_dba != '',SELF.name_dba,' ');
		
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
	
	  //Extract company name
		clnAddress1						:= IF(TempBusName<>'','',trim_address);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trim_city + ' '+trim_state + ' ' + 
		                                                     IF(length(trim_zip)=4,'0'+trim_zip,trim_zip)); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trim_city);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trim_state);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),
		                            IF(LENGTH(trim_zip)=4,'0'+trim_zip,trim_zip));
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		SELF.ADDR_BUS_IND			:= IF(TRIM(temp_preaddr1+temp_preaddr2)<>'','B','');
		
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		SELF.AFFIL_TYPE_CD		:= 'IN';	  
		SELF.MLTRECKEY				:= 0;
		  
		  // Fields used to create unique key are: license number, license type, source update, name, address,dba 
		  // SELF.CMC_SLPK				:= 0;
			SELF.CMC_SLPK         	:= HASH64(TRIM(SELF.RAW_LICENSE_TYPE,LEFT,RIGHT)
																			+ TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)
																			+ TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
											                + TRIM(SELF.NAME_ORG,LEFT,RIGHT)
											                + TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																			+ TRIM(SELF.NAME_MARI_ORG,LEFT,RIGHT)
																			+ trim_address
																			+ trim_city
											                + trim_zip);
											 
			SELF.PROVNOTE_3 	   := '{LICENSE STATUS ASSIGNED}';    //std_license_status is always assigned to 'A'
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
	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);
	// Adding to Superfile
	d_final := output(StdLicType,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(StdLicType);
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'appr','using', 'used');
	                        );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCMV, oApr, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
END;
