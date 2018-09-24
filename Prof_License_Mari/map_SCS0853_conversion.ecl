//******************************************************************************************
//Converting South Carolina Real Estate Appraisers Board Real Estate Appraisers License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
//******************************************************************************************
#workunit('name','Prof License MARI- SCS0853');

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard, NID;

EXPORT map_SCS0853_conversion(STRING pVersion) := FUNCTION

	code 										:= 'SCS0853';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	AddrExceptions := '(DRIVE|CENTER|BUILDING)';
	CompNames  := '(DEVELOPMENT*|COMPANY|COMPANIES|^THE |^.* LLC)';
	C_O_Ind    := '(C/O |C/O:|ATTN:|ATTN: |ATTN|ATTENTION:|ATT:|CO/)';
	AddressSet := '(SUITE|DRIVE| DR$| ROAD| RD$|BLVD| STREET$| ST$|APT |APT.| AVE | AVE$| AVENUE| COURT| LANE| PLACE | PLACE$| SUITE| PL$| PL.| WAY$| TER$|' +
                'CIRCLE$| ISLE | PARKWAY| PIKE|PO BOX|LN$| NW$| NE$| CT$| CT.| DR.|CENTURY 21| HIGHWAY| NW$)';

	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed','using');
																			);	
	//Clean Input File																		
	inFile 									:= Prof_License_Mari.file_SCS0853;
	ut.CleanFields(inFile, ClnUnprintable);
	oFile										:= OUTPUT(ClnUnprintable);
	
	//Filtering out BAD RECORDS
	NonBlankName 						:= ClnUnprintable(TRIM(OFFICENAME+SLNUM+LAST_NAME+FULL_NAME) != '');
	GoodNameRec							:= NonBlankName(OFFICENAME<>'NAME' AND NOT REGEXFIND('(TESTPERSON)', FIRST_NAME+' '+LAST_NAME, NOCASE));
	
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base			xformToCommon(GoodNameRec pInput) := TRANSFORM
	
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

		//Process names and address
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		TrimNAME_PREFX        := ut.CleanSpacesAndUpper(pInput.TITLE);
		TrimLic_Type					:= ut.CleanSpacesAndUpper(pInput.LICENSE_DESC);
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.FULL_NAME);
		TrimNAME_OFFICE 			:= ut.CleanSpacesAndUpper(pInput.OFFICENAME);

		TrimAddress1_1				:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS_1);
		TrimAddress1_2				:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS_2);
		TrimCity1							:= ut.CleanSpacesAndUpper(pInput.BUS_CITY);
		TrimState1						:= ut.CleanSpacesAndUpper(pInput.BUS_STATE);
		TrimZip1							:= ut.CleanSpacesAndUpper(pInput.BUS_ZIP);	
		TrimAddress2_1				:= ut.CleanSpacesAndUpper(pInput.MAIN_ADDRESS_1);
		TrimAddress2_2				:= ut.CleanSpacesAndUpper(pInput.MAIN_ADDRESS_2);
		TrimCity2							:= ut.CleanSpacesAndUpper(pInput.MAIN_CITY);
		TrimState2						:= ut.CleanSpacesAndUpper(pInput.MAIN_STATE);
		TrimZip2							:= ut.CleanSpacesAndUpper(pInput.MAIN_ZIP);	
		Trim_SLNUM						:= ut.CleanSpacesAndUpper(pInput.SLNUM);
		
		// License Information - SC license search website shows license # without prefix, thus not included here either.
		//Used by 20150121												 
		SELF.LICENSE_NBR	  	:= IF(REGEXFIND('^([0-9]+)', Trim_SLNUM), Trim_SLNUM,
																REGEXFIND('[A-Z]+ \\.([0-9]+)[ ]*([A-Z]+$)',Trim_SLNUM,1)
																);
		
		SELF.RAW_LICENSE_TYPE	:= IF(pInput.SUB_CAT <> '',ut.CleanSpacesAndUpper(pInput.SUB_CAT),TrimLic_Type);
		
		//Uncomment for 20140410
		SELF.STD_LICENSE_TYPE := IF(LENGTH(TRIM(SELF.raw_license_type)) > 4,
																		CASE(TRIM(TrimLic_Type),
																							'APPRENTICE APPRAISER'													=>'A',
																							'CERTIFIED GENERAL APPRAISER'										=>'CG',
																							'CERTIFIED GENERAL MASS APPRAISER'							=>'CGM',
																							'CERTIFIED RESIDENTIAL APPRAISER'             	=>'CR',
                                            	'CERTIFIED RESIDENTIAL MASS APPRAISER'					=>'CRM',
																							'INACTIVE APPRENTICE APPRAISER'									=>'IA',
																							'INACTIVE CERTIFIED GENERAL APPRAISER'					=>'ICG',
																							'INACTIVE CERTIFIED RESIDENTIAL'								=>'ICR',
																							'INACTIVE CERTIFIED RESIDENTIAL APPRAISER'			=>'ICR',
																							'INACTIVE LICENSED APPRAISER'										=>'IL',
																							'INACTIVE LICENSED MASS APPRAISER'							=>'ILM',
																							'LICENSED APPRAISER'														=>'L',
																							'LICENSED MASS APPRAISER'												=>'LM',
																							'INACTIVE CERTIFIED GENERAL MASS APPRAISER'			=>'ICGM', 
																							'INACTIVE CERTIFIED RESIDENTIAL MASS APPRAISER'	=>'ICRM',
																							'TEMPORARY PERMIT'                              =>'TP',
																					''),
																					SELF.raw_license_type
																					);

		//Reformatting date to YYYYMMDD
	  tempCurrIssue 				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(pInput.CURISSUEDT));
		tmpExpireDate					:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPDT);
		tmpFirstIssueDate			:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUEDT);
		
		SELF.CURR_ISSUE_DTE		:= IF(tempCurrIssue != '', tempCurrIssue,'17530101');
		SELF.ORIG_ISSUE_DTE		:= IF(tmpFirstIssueDate != '',tmpFirstIssueDate,'17530101');
		SELF.EXPIRE_DTE				:= IF(tmpExpireDate != '',tmpExpireDate,'17530101');
		SELF.RENEWAL_DTE			:= '';
		SELF.ACTIVE_FLAG			:= '';
		
		//License status
		set_active_status 		:= ['A','CG','CGM','CR','CRM','L','LM'];
		set_inactive_status 	:= ['IA','ICG','ICGM','ICR','ICRM','IL','ILM'];  
		//uncomment for 20130307, 20130509, 20130606-20140718
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.STATUS);
		tmpLicenseStatus 			:= IF(pInput.EXPDT != '' AND tmpExpireDate>pVersion AND TRIM(SELF.RAW_LICENSE_TYPE) in set_active_status,
		                            'ACTIVE',
																'INACTIVE');																																	
		SELF.STD_LICENSE_STATUS := IF(TRIM(SELF.RAW_LICENSE_STATUS) = '',
																		CASE(tmpLicenseStatus,
																					'ACTIVE' => 'A',
																					'INACTIVE' => 'I',
																								''),
																								'');		
		SELF.PROVNOTE_3				:= IF(SELF.RAW_LICENSE_STATUS = '' AND SELF.STD_LICENSE_STATUS<>'','{LICENSE STATUS ASSIGNED}','');	
	
		//Clean name - use first, middle, last if present, otherwise use full name.
		ConcatFML				 			:= StringLib.StringCleanSpaces(TrimNAME_FIRST +' '+TrimNAME_MID + ' '+TrimNAME_LAST);
		tmpFullName						:= IF(ConcatFML<>'',ConcatFML,TrimNAME_ORG);
		tempNick 							:= Prof_License_Mari.fGetNickname(tmpFullName,'nick');
		stripNickName 				:= Prof_License_Mari.fGetNickname(tmpFullName,'strip_nick');
		GoodName							:= IF(tempNick != '',stripNickName,tmpFullName);
		ParsedName						:= Prof_License_Mari.mod_clean_name_addr.cleanFMLName(GoodName);		
		re_ParsedName         := IF(LENGTH(TRIM(ParsedName[46..65]))<2 and Address.CleanPersonFML73(GoodName) <> '',Address.CleanPersonFML73(GoodName),ParsedName);		
			
		FirstName 						:= IF(re_ParsedName <> '',TRIM(re_ParsedName[6..25],LEFT,RIGHT),TrimNAME_FIRST);
		MidName   						:= IF(re_ParsedName <> '',TRIM(re_ParsedName[26..45],LEFT,RIGHT),TrimNAME_MID);	
		LastName  						:= IF(re_ParsedName <> '',TRIM(re_ParsedName[46..65],LEFT,RIGHT), TrimNAME_LAST); 
		Suffix	  						:= TRIM(re_ParsedName[66..70],LEFT,RIGHT);
		
		GoodFirstName 				:= IF(re_ParsedName <> '' /*AND tmpFullName[1] = FirstName[1]*/,FirstName,TrimNAME_FIRST);
		GoodMidName   				:= IF(re_ParsedName <> '' /*AND tmpFullName[1] = FirstName[1]*/,MidName,TrimNAME_MID);	
		GoodLastName  				:= IF(re_ParsedName <> '' /*AND tmpFullName[1] = FirstName[1]*/,LastName,TrimNAME_LAST); 
		
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName);
		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_PREFX       := TrimNAME_PREFX;
		SELF.NAME_FIRST		   	:= GoodFirstName;
		SELF.NAME_MID					:= GoodMidName;							
		SELF.NAME_LAST		   	:= GoodLastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);
		
		//Identifying DBA and Office NAMES
		
		ParsedDbaName 				:= Prof_License_Mari.fnCleanNames.ExtractCleanDBA(TrimNAME_OFFICE, TrimNAME_ORG);
		
		tmpNAME_DBA						:= IF(REGEXFIND('( DBA | D/B/A | DBA: |(DBA)| A/K/A | AKA|C/O )',TrimAddress1_1), Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1_1),
																				'');
    StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
    Tmp_DBA_SUFFIX				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);		
		CleanNAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA);
		Tmp_DBA_PREFX 	      := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		
		SELF.NAME_DBA_PREFX	  := IF(Tmp_DBA_PREFX != '', Tmp_DBA_PREFX,TRIM(ParsedDbaName[1..20],LEFT,RIGHT));
		SELF.NAME_DBA					:= IF(StdNAME_DBA != '', StdNAME_DBA,TRIM(ParsedDbaName[41..140],LEFT,RIGHT));
		SELF.NAME_DBA_SUFX	  := IF(Tmp_DBA_SUFFIX != '',Tmp_DBA_SUFFIX,TRIM(ParsedDbaName[21..40],LEFT,RIGHT)); 
		SELF.NAME_MARI_DBA	  := IF(StdNAME_DBA != '',StdNAME_DBA,TRIM(ParsedDbaName[141..240],LEFT,RIGHT));
		SELF.NAME_DBA_ORIG	  := TRIM(ParsedDbaName[141..240],LEFT,RIGHT);
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
	  
		TempNAME_OFFICE       := IF(func_is_address(TrimNAME_OFFICE)= TRUE,'',TrimNAME_OFFICE);
		
		getOFFICE_NAME				:= MAP(REGEXFIND(C_O_Ind, TrimAddress1_1) AND NOT REGEXFIND(AddressSet, TrimAddress1_1)=> TrimAddress1_1,
		                             REGEXFIND(C_O_Ind, TrimAddress1_2) AND NOT REGEXFIND(AddressSet, TrimAddress1_2)=> TrimAddress1_2,
																 REGEXFIND(CompNames, TrimAddress1_1) AND NOT REGEXFIND(AddressSet, TrimAddress1_1)=> TrimAddress1_1,
																 REGEXFIND(CompNames, TrimAddress1_2) AND NOT REGEXFIND(AddressSet, TrimAddress1_2)=> TrimAddress1_2,
																 NOT REGEXFIND('[0-9]',TrimAddress1_1) AND NOT REGEXFIND(AddressSet,TrimAddress1_1) AND TrimAddress1_1 <>'' => TrimAddress1_1,																 
																 TempNAME_OFFICE);
																 
		ParsedOfficeName 			:= Prof_License_Mari.fnCleanNames.ExtractCleanOfficeName(getOFFICE_NAME, '');
		TmpNAME_OFFICE  	    := TRIM(ParsedOfficeName[3..102], LEFT, RIGHT);
		
		
		SELF.NAME_OFFICE      := MAP(TRIM(TmpNAME_OFFICE,ALL) = TRIM(ConcatNAME_FULL,ALL) => '',
		                             TRIM(TmpNAME_OFFICE,ALL) = TRIM(tmpFullName,ALL) => '',
																 TRIM(TmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST, ALL) => '',
																 TmpNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '',TRIM(ParsedOfficeName[1..2], LEFT, RIGHT),'');
				
		//Populating MARI Name Fields
		SELF.NAME_FORMAT			:= IF(tmpFullName<>'','F','');
		SELF.NAME_ORG_ORIG	  := tmpFullName;
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;
		SELF.PHN_MARI_1				:= ut.CleanPhone(pInput.BUS_PHONE)[1..10];
		SELF.PHN_PHONE_1    	:= ut.CleanPhone(pInput.BUS_PHONE)[1..10];
	
		//Populating Address fields		
		TempAddress1_1        := IF(TrimNAME_OFFICE<>'' and Prof_License_Mari.func_is_address(TrimNAME_OFFICE)= TRUE,TrimNAME_OFFICE,TrimAddress1_1);
		TempAddress1_2        := IF(TrimNAME_OFFICE <> '' and Prof_License_Mari.func_is_address(TrimNAME_OFFICE)= TRUE,TrimAddress1_1,TrimAddress1_2);
		preAddress1_1					:= TRIM(REGEXREPLACE(CompNames,TempAddress1_1,'') + ' ' + REGEXREPLACE(CompNames,TempAddress1_2,''));
		preAddress1_2					:= TrimCity1 + ' ' + TrimState1 + ' ' + TrimZip1;		
		preAddress2_1					:= TrimAddress2_1 + ' ' + TrimAddress2_2;
		preAddress2_2					:= TrimCity2 + ' ' + TrimState2 + ' ' + TrimZip2;

		tmpAddress1_1					:= IF(TRIM(preAddress1_1+preAddress1_2)='',preAddress2_1,preAddress1_1);
		tmpAddress1_2					:= IF(TRIM(preAddress1_1+preAddress1_2)='',preAddress2_2,preAddress1_2);
		tmpAddress2_1					:= IF(tmpAddress1_1=preAddress2_1,'',preAddress2_1);
		tmpAddress2_2					:= IF(tmpAddress1_2=preAddress2_2,'',preAddress2_2);
		
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(tmpAddress1_1,tmpAddress1_2);
		clnAddrAddr2					:= IF(StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(tmpAddress1_1+tmpAddress1_2))<>
		                            StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(tmpAddress2_1+tmpAddress2_2)),
		                            Prof_License_Mari.mod_clean_name_addr.cleanAddress(tmpAddress2_1,tmpAddress2_2),
																'');
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT);
		SELF.ADDR_ADDR2_1			:= TRIM(tmpADDR_ADDR1_2,LEFT,RIGHT); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr1[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr1[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];
		SELF.ADDR_CNTY_1			:= ut.CleanSpacesAndUpper(pInput.BUS_COUNTY);
	  SELF.ADDR_BUS_IND			:= IF(clnAddrAddr1!='','B','');

		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_2				:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_2			:= TRIM(tmpADDR_ADDR2_1,LEFT,RIGHT);
		SELF.ADDR_ADDR2_2			:= TRIM(tmpADDR_ADDR2_2,LEFT,RIGHT); 
		SELF.ADDR_CITY_2			:= TRIM(clnAddrAddr2[65..89]);
		SELF.ADDR_STATE_2			:= TRIM(clnAddrAddr2[115..116]);
   	SELF.ADDR_ZIP5_2			:= TRIM(clnAddrAddr2[117..121]);
   	SELF.ADDR_ZIP4_2			:= clnAddrAddr2[122..125];
	  SELF.ADDR_MAIL_IND		:= IF(clnAddrAddr2!='','M','');
					  
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO',
																 '');		

		SELF.MLTRECKEY			:= 0;
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT) + ','
																			+TrimAddress1_1 + ','
																			+TrimCity1 + ','
																			+TrimZip1);
																								   
		SELF.PCMC_SLPK			:= 0;
		SELF := [];	
		   
	END;
	
	inFileLic	:= PROJECT(GoodNameRec,xformToCommon(LEFT));

// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layouts.base trans_lic_status(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := IF(L.STD_LICENSE_STATUS = '',R.DM_VALUE1, L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(inFileLic, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
								AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);
								
	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := IF(L.STD_PROF_CD = '' AND L.STD_LICENSE_TYPE = 'ICRM','APR',
															StringLib.stringtouppercase(TRIM(R.DM_VALUE1)));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	remove_logical 					:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	// Adding to Superfile
	d_final := OUTPUT(ds_map_lic_trans, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));


	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used');

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;