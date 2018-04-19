IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;
EXPORT map_SDS0844_conversion(STRING pVersion) := FUNCTION

	code 										:= 'SDS0844';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	C_O_Ind 								:= '(C/O |ATTN: |ATTN )';
	DBA_Ind 								:= '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);

	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','sprayed','using');
																			);
																			
	inFile 									:= Prof_License_Mari.file_SDS0844;
	//Filtering out BAD RECORDS
	ut.CleanFields(inFile, ClnUnprintable);
	GoodNameRec							:= ClnUnprintable(TRIM(LAST_NAME + FIRST_NAME + MID_NAME) != '');
	GoodTypeRec 						:= GoodNameRec(NOT REGEXFIND(Prof_License_Mari.filters.BadTypeFilter, StringLib.StringToUpperCase(LIC_TYPE)));
	oFile										:= OUTPUT(SAMPLE(GoodNameRec, 2,1));
																			
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base		xformToCommon(Prof_License_Mari.layout_SDS0844.raw pInput) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.TYPE_CD					:= 'MD';
		SELF.STD_PROF_CD			:= ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE		:= code[1..2];
			
		//Standardize Fields
		TrimNAME_TTL					:= ut.CleanSpacesAndUpper(pInput.TITLE);
		TrimNAME_LAST 				:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID					:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_OFFICE 			:= ut.CleanSpacesAndUpper(pInput.OFFICENAME);
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		TrimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);

		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.EXPIRE_DTE				:= IF(pInput.RENEWAL != '',StringLib.StringCleanSpaces(TRIM(pInput.RENEWAL,ALL) + '1130'),'17530101');
		SELF.RENEWAL_DTE			:= TRIM(pInput.RENEWAL,ALL) + '1201';
		
		// License Information
		SELF.LICENSE_NBR	  	:= ut.CleanSpacesAndUpper(pInput.SLNUM);
		SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);
		SELF.STD_LICENSE_TYPE	:= '';
		SELF.RAW_LICENSE_STATUS := '';
		SELF.STD_LICENSE_STATUS := IF(SELF.EXPIRE_DTE>pVersion,'A','I');	
		SELF.PROVNOTE_3				:= '{LICENSE STATUS ASSIGNED}';
																				 
		//Clean name
		FullName							:= StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_MID + ' ' + TrimNAME_LAST);
		tempNick 							:= Prof_License_Mari.fGetNickname(FullName,'nick');
		ParsedName 						:= Prof_License_Mari.fnCleanNames.easyClean(TrimNAME_FIRST,TrimNAME_MID,TrimNAME_LAST,'');
		FirstName 						:= IF(ParsedName <> '',TRIM(ParsedName[6..25],LEFT,RIGHT),TrimNAME_FIRST);
		MidName   						:= IF(ParsedName <> '',TRIM(ParsedName[26..45],LEFT,RIGHT),TrimNAME_MID);	
		LastName  						:= IF(ParsedName <> '',TRIM(ParsedName[46..65],LEFT,RIGHT),TrimNAME_LAST); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);

		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);	

		SELF.NAME_ORG		    	:= ConcatNAME_FULL;

		prepNAME_OFFICE 			:= MAP(TrimNAME_OFFICE[1..6] = 'D/B/A ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ','DBA '),
													       TrimNAME_OFFICE[1..4] = 'DBA/' => StringLib.StringFindReplace(TrimNAME_OFFICE,'DBA/','DBA '),
													       StringLib.StringFind(TrimNAME_OFFICE,'D/B/A, A/K/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A, A/K/A ','DBA '),
													       TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
													       REGEXFIND('(SELF EMPLOYED|NO LICENSE RETURNED|STILL HAS LICENSE|LICENSEE PASSED AWAY|NONE)',TrimNAME_OFFICE) => '',
													       REGEXFIND('^[0-9]',TrimNAME_OFFICE) AND Prof_License_Mari.func_is_address(TrimNAME_OFFICE)
															   AND REGEXFIND('(AVENUE)',TrimNAME_OFFICE) => '',
																												TrimNAME_OFFICE);
	
		//Identifying DBA NAMES
		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
														 		 '');
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   						 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA)
																 );
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		SELF.NAME_DBA_ORIG		:= IF(SELF.NAME_DBA != '',TRIM(getNAME_DBA,LEFT,RIGHT),'');
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA !='',TRIM(getNAME_DBA),'');
	  
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																 prepNAME_OFFICE);
																					
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(\\.COM|\\.NET|\\.ORG)',StdNAME_OFFICE),
		                            Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
		
		SELF.NAME_OFFICE	    := MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST,ALL) => '',
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG) => '',
 		                             StringLib.StringCleanSpaces(CleanNAME_OFFICE));
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),
		                            'GR',
																IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),
																   'MD',
																	 ''));
																											
		//Populating MARI Name Fields
		SELF.NAME_FORMAT			:= IF(FullName<>'','F','');
		SELF.NAME_ORG_ORIG	  := FullName;
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;
		
		//Clean Address
		temp_preaddr1				:= StringLib.StringCleanSpaces(TrimAddress1);
		tmpGetDBAName				:= IF(Prof_License_Mari.mod_clean_name_addr.GetDBAName(temp_preaddr1)<>''
															,Prof_License_Mari.mod_clean_name_addr.GetDBAName(temp_preaddr1),
															'');
		clnGetDBAName				:= MAP(REGEXFIND('([0-9]+) .* (LANE|STREET|DRIVE|AVENUE|SQUARE)',	tmpGetDBAName) => '',
		                           REGEXFIND('PO BOX',	tmpGetDBAName) => '',
															 REGEXFIND('ATTN ',temp_preaddr1) => '',
															 tmpGetDBAName);
		tmpGetCorpName			:= IF(Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_preaddr1)<>'',
															Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_preaddr1),
															'');
		clnGetCorpName			:= MAP(REGEXFIND('([0-9]+) .* (LANE|STREET|DRIVE|AVENUE|SQUARE)',	tmpGetCorpName) => '',
		                           REGEXFIND('PO BOX',	tmpGetCorpName) => '',
															 REGEXFIND('ATTN ',temp_preaddr1) => '',
															 tmpGetCorpName);
		tmpGetContactName		:= IF(REGEXFIND('PO BOX ', tmpGetDBAName),
		                          '',
		                          Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpGetDBAName));
		clnGetContactName		:= MAP(REGEXFIND('ATTN ',temp_preaddr1)  => tmpGetDBAName,
															 tmpGetContactName);
									 
		temp_preaddr1_rm_dba 	:= IF(tmpGetDBAName<>'',REGEXREPLACE(tmpGetDBAName,temp_preaddr1,''),temp_preaddr1);
		temp_preaddr1_rm_corp := IF(tmpGetCorpName<>'',REGEXREPLACE(tmpGetCorpName,temp_preaddr1_rm_dba,''),temp_preaddr1_rm_dba);
		temp_preaddr1_rm_contact := IF(tmpGetContactName<>'',REGEXREPLACE(tmpGetContactName,temp_preaddr1_rm_corp,''),temp_preaddr1_rm_corp);
		temp_preaddr1_rm_misc := REGEXREPLACE('(CENTURY 21[A-Z&\\- ]+ [INC|COMPANY])', temp_preaddr1_rm_contact, '');
		temp_preaddr1_rm_misc1:= REGEXREPLACE('(KORMAN RES PROPERTIES INC)', temp_preaddr1_rm_misc, '');
		cln_preaddr1					:= StringLib.StringCleanSpaces(REGEXREPLACE('(DBA |C/O |ATTN -)', temp_preaddr1_rm_misc1, ''));
		cln_preaddr2	 				:= StringLib.StringCleanSpaces(TrimCity + ' ' +TrimState +' ' + TrimZip);

		clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(cln_preaddr1,cln_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(tmpADDR_ADDR1_1);	
		SELF.ADDR_ADDR2_1		:= StringLib.StringCleanSpaces(tmpADDR_ADDR2_1); 
		SELF.ADDR_CITY_1		:= IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		:= IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),
														  IF(TrimZip<>'0',TrimZip,''));
		SELF.ADDR_ZIP4_1		:= clnAddrAddr1[122..125];	
		SELF.EMAIL					:= ut.CleanSpacesAndUpper(pInput.EMAIL);

		ParseContact				:= IF(clnGetContactName<>'', Address.CleanPersonFML73(clnGetContactName), '');																				
		
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
			
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO','');		
																 
		SELF.MLTRECKEY				:= 0;
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																				+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																				+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																				+TRIM(SELF.NAME_ORG,LEFT,RIGHT) + ','
																				+	TrimNAME_OFFICE
																				+ TrimAddress1
																				+ TrimCity
																				+ TrimZip);
																										 			
			SELF := [];	
	END;

	inFileLic	:= PROJECT(GoodTypeRec,xformToCommon(LEFT));
	
	// Populate STD_LICENSE_TYPE field via translation on statu field
	Prof_License_Mari.layouts.base 	trans_std_lic(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_TYPE := IF(R.DM_VALUE2 = '','BROKER', StringLib.stringtouppercase(TRIM(R.DM_VALUE2,LEFT,RIGHT)));
		SELF := L;
	END;
	ds_map_std_lic := JOIN(inFileLic, Cmvtranslation,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE'
							AND RIGHT.dm_name2 = 'LIC_TYPE',
							trans_std_lic(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_std_lic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1));											
		SELF := L;
	END;
	ds_map_lic_trans := JOIN(ds_map_std_lic, Cmvtranslation,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	remove_logical 					:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);
	d_final 								:= OUTPUT(ds_map_lic_trans, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));

	move_to_used						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','using','used');
																			);
	notify_missing_codes 		:= Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address 	:= Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
																		Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;