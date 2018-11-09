/*2018-01-12T19:35:21Z (xsheng_prod)
C:\Users\shenxi01\AppData\Roaming\HPCC Systems\eclide\xsheng_prod\New_Dataland\Prof_License_Mari\map_IAS0826_conversion\2018-01-12T19_35_21Z.ecl
*/
// Purpose : map IAS0826 / Iowa Real Estate Commission & Appraisal / Real Estate Appraisers raw data to common layout for MARI and PL use
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_IAS0826_conversion(STRING pVersion) := FUNCTION
#workunit('name','IAS0826 Conversion ' + pVersion);

	code 								:= 'IAS0826';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';


	//Pattern for Internet companies
 IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';
 
 //Pattern for Suffix Name
 SUFFIX_PATTERN  := '( JR.$| JR$| JR | SR.$| SR$| SR | III$| III | II$| IV$)';	
			
	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |D B A |D/B/A )(.*)';	
	
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	county_names    := Prof_License_Mari.files_References.county_names(SOURCE_UPD =src_cd);
  O_Cmvtrans      := OUTPUT(Cmvtranslation);
	
	//Move data from sprayed to using directory
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');	
	
	//input files.
	apr       := Prof_License_Mari.file_IAS0826;

	//Remove bad records before processing
	ValidFile	:= apr(TRIM(Full_name,LEFT,RIGHT) != ' ');
  oValidFile:= OUTPUT(ValidFile);
	ut.CleanFields(ValidFile,clnValidFile);

	Prof_License_Mari.layouts.base	transformToCommon2014(clnValidFile pInput) := TRANSFORM
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pInput.LN_FILEDATE;		//it was set to process_date before
		SELF.STAMP_DTE				:= pInput.LN_FILEDATE; 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.LN_FILEDATE;
		SELF.DATE_VENDOR_LAST_REPORTED	 := pInput.LN_FILEDATE;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		tempLicNum           := ut.CleanSpacesAndUpper(pInput.SLNM);
		SELF.LICENSE_NBR     := tempLicNum;
		SELF.LICENSE_STATE		 := src_st;
	
		
		SELF.PROVNOTE_3				:= IF(pInput.LIC_STATUS = '','{LICENSE STATUS ASSIGNED}','');
		SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(pInput.LIC_STATUS);
		// SELF.STD_LICENSE_STATUS	:= MAP(SELF.RAW_LICENSE_STATUS = 'ACTIVE' => 'A',
		                               // SELF.RAW_LICENSE_STATUS = 'INACTIVE' => 'I',SELF.RAW_LICENSE_STATUS);
																	 
		tempIssueDt         	:= prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.issue_date);
		SELF.ORIG_ISSUE_DTE		:= (STRING) tempIssueDt;
		//input date format YYYY-MM-DD	
		SELF.EXPIRE_DTE		   	:= IF(pInput.exp_date='','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.exp_date));
		tempCurIssueDt      	:= prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.effective_date);
		SELF.CURR_ISSUE_DTE 	:= (STRING) tempCurIssueDt;

		
		// derive raw_license_type from license number
		tempRawType 					:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);									 
		SELF.RAW_LICENSE_TYPE := TempRawType;
																																				
		// map raw license type to standard license type before profcode translations														
		tempStdLicType 				:= MAP(tempRawType = 'ASSOCIATE GENERAL APPRAISER' => 'AG',
		             tempRawType = 'ASSOCIATE RESIDENTIAL APPRAISER' => 'AR',
															tempRawType = 'CERTIFIED GENERAL APPRAISER' => 'CG',
															tempRawType = 'CERTIFIED RESIDENTIAL APPRAISER' => 'CR',
															tempRawType = 'APPRAISAL MANAGEMENT COMPANY REGISTRATION' => 'AMC',	
															tempRawType);														

		SELF.STD_LICENSE_TYPE := tempStdLicType;
			
		GR_Ind := ['AMC','F'];	
		
		// assigning type code based on license type
		tempTypeCd		  			:= IF(tempStdLicType in GR_Ind,'GR','MD');
		SELF.TYPE_CD      		:= tempTypeCd;
		tempMariParse     		:= tempTypeCd;
		mariParse         		:= MAP(tempTypeCd = 'MD' => 'MD',tempTypeCd = 'GR' => 'GR',' ');
																				
		//Clean names
  TrimFullName  := REGEXREPLACE('&#039;',ut.CleanSpacesAndUpper(pInput.FULL_NAME),'\'');

		tempFullNick     := Prof_License_Mari.fGetNickname(TrimFullName,'nick');
	
		removeFullNick        := Prof_License_Mari.fGetNickname(TrimFullName,'strip_nick');
  stripNickFullName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFullNick));
			
		TmpNAME_FULL     := REGEXREPLACE(SUFFIX_PATTERN, stripNickFullName,'');
		TmpSufx          := REGEXFIND(SUFFIX_PATTERN, stripNickFullName,0);
			
		GoodFullName				:= IF(TmpSufx != '',TmpNAME_FULL,stripNickFullName);
		ParsedName						:= Prof_License_Mari.mod_clean_name_addr.cleanFMLName(GoodFullName);
				
		GoodFirstName			:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		GoodMidName   		:= TRIM(ParsedName[26..45],LEFT,RIGHT);													 
		GoodLastName				:= TRIM(ParsedName[46..65],LEFT,RIGHT);	
																 
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName);
  
	 rmvDBA_org   				:= IF(SELF.TYPE_CD = 'GR' and REGEXFIND(DBApattern,TrimFullName),REGEXFIND(DBApattern,TrimFullName,1),TrimFullName);
	 StdNAME_ORG 					:= IF(SELF.TYPE_CD = 'GR',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_org),rmvDBA_org);

		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
		SELF.NAME_ORG				   	:= IF(SELF.TYPE_CD = 'MD' and ConcatNAME_FULL <> ' ', ConcatNAME_FULL,
		                           Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_ORG,' CO')));
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
		SELF.NAME_ORG_ORIG   := TrimFullName;
		SELF.NAME_FIRST	 	:= IF(mariParse = 'MD',GoodFirstName,'');
		SELF.NAME_MID			 	:= IF(mariParse = 'MD',Stringlib.stringFilterOut(GoodMidName,'.'),'');
		SELF.NAME_LAST		  := IF(mariParse = 'MD',GoodLastName,'');
		SELF.NAME_NICK				:= IF(mariParse = 'MD',StringLib.StringCleanSpaces(tempFullNick),'');
		SELF.NAME_SUFX    := IF(mariParse = 'MD',TRIM(TmpSufx,LEFT,RIGHT),'');			
		SELF.NAME_FORMAT  := 'F';
				

		// assign officename and office parse field : GR if company, MD if individual 
		TrimOffice         := ut.CleanSpacesAndUpper(pInput.FIRM_NAME);
		IsCompany          := IF(Prof_License_Mari.func_is_address(TrimOffice) = true,'',TrimOffice);
		IsAddress          := IF(Prof_License_Mari.func_is_address(TrimOffice) = true and Prof_License_Mari.func_is_company(TrimOffice) = false,TrimOffice,'');

		OffieName         	:= IF(Prof_License_Mari.mod_clean_name_addr.GetCorpName(IsCompany)<>'',
		               TRIM(Prof_License_Mari.mod_clean_name_addr.GetCorpName(IsCompany),LEFT,RIGHT),
															 	TRIM(IsCompany,LEFT,RIGHT));
																
																
		SELF.NAME_OFFICE    	:= MAP(tempTypeCd = 'MD' AND REGEXFIND(TRIM(SELF.NAME_ORG,LEFT,RIGHT), OffieName)=> '', 
		               TRIM(OffieName,ALL) = 'N/A' => '',
		               TRIM(OffieName,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(OffieName,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) =>'', 
																 TRIM(OffieName,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(OffieName,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(OffieName,ALL) = TRIM(REGEXREPLACE(',',SELF.NAME_ORG_ORIG,' '),ALL) => '',
																 OffieName);													
		SELF.OFFICE_PARSE   := IF(SELF.NAME_OFFICE != '',
		                          IF(Prof_License_Mari.func_is_company(OffieName),'GR','MD'),'');													

		SELF.NAME_MARI_ORG		:= IF(mariParse = 'GR' ,StdNAME_ORG, IF(SELF.NAME_OFFICE != '',SELF.NAME_OFFICE,'')); //only business names
						
		//Get DBA name		
		DBANameOnly						:= IF(REGEXFIND(DBApattern,TrimFullName),REGEXFIND(DBApattern,TrimFullName,3),'');
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(DBANameOnly); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		SELF.NAME_DBA					:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
															  Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false				
		SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(tmpNameDBA);
		
   //Parsing address
	 	trimAddress          := ut.CleanSpacesAndUpper(pInput.ADDR_LINE1);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= IF(IsAddress <> '',IsAddress + ' ','') + StringLib.StringCleanSpaces(trimAddress); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.CITY+' '+pInput.STATE +' '+pInput.ZIP); 
		clnAddrAddr1				 	:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																           StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		 := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(pInput.CITY));
		SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE));
		SELF.ADDR_ZIP5_1		 := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		 := clnAddrAddr1[122..125];

		SELF.ADDR_CNTY_1   := ut.CleanSpacesAndUpper(pInput.COUNTY);
		SELF.ADDR_CNTRY_1  := ut.CleanSpacesAndUpper(pInput.COUNTRY);

		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	:= IF(TRIM(pInput.ADDR_LINE1 + pInput.CITY + pInput.STATE + pInput.ZIP,LEFT,RIGHT) != '','B','');

		//populate phone field
		SELF.PHN_PHONE_1    := IF(ut.CleanSpacesAndUpper(pInput.PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.PHONE,'0123456789'));
		SELF.PHN_MARI_1     := IF(ut.CleanSpacesAndUpper(pInput.PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.PHONE,'0123456789'));
		//populate fax field
		SELF.PHN_FAX_1      := IF(ut.CleanSpacesAndUpper(pInput.FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.FAX,'0123456789'));
		SELF.PHN_MARI_FAX_1 := IF(ut.CleanSpacesAndUpper(pInput.FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.FAX,'0123456789'));

		SELF.ORIGIN_CD				:= CASE(ut.CleanSpacesAndUpper(pInput.LICENSE_METHOD),
																	'EXAM' 	=> 	'E',
																	'RECIPROCITY'		=>	'R',
																	'UNDEFINED'  => 'U',
																	'UNKNOWN'  => 'U',  // NEW CODES   
																	'RULE 5.3'  => '5',
																	'APPLICATN' => 'O',
																	'RCPRCTY'   => 'R',
																	'CREDENTIAL' => 'C',
																	'TESTING'  => 'O',
																	'OTHER'    => 'O',
																	'ORIGINAL' => 'L', 
                 'WAIVER' => 'W', 
																	'');		
   
	 //fields used to create unique key are: license number, license type, source update, name, address, office name
	 //Use HASH64 instead of hash32 to avoid dup keys
	 
		SELF.cmc_slpk         := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +TRIM(SELF.NAME_ORG)
														 +TRIM(pInput.ADDR_LINE1)
														 +TRIM(pInput.ZIP)
														 // +TRIM(DBANameOnly,LEFT,RIGHT)
														 +TRIM(OffieName,LEFT,RIGHT)
														 );
								
																	
		SELF	:= pInput;
		SELF  := [];		   		   
		
	END;

	ds_map := PROJECT(clnValidFile, transformToCommon2014(LEFT));
	// Clean-up Fields
	Prof_License_Mari.layouts.base	transformClean(ds_map pInput) := TRANSFORM
			SELF.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '#'),	
																																						 pInput.ADDR_ADDR1_1);
			SELF.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '#'),	
																																						 pInput.ADDR_ADDR2_1);	
			SELF.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '#'),	
																																						 pInput.ADDR_ADDR3_1);			
			SELF := pInput;
	END;
	ds_map_clean := PROJECT(ds_map , transformClean(LEFT));						   

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layouts.base trans_lic_status(ds_map_clean L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := IF(L.STD_LICENSE_STATUS = '',R.DM_VALUE1,L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_base := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																	
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
							TRIM(LEFT.name_org[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org[1..50],LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);						

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);


	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));		

	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmvtrans, move_to_using,oValidFile, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;