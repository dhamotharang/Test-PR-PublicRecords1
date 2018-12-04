//************************************************************************************************************* */	
//  The purpose of this development is take KY Appraisers License raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_KYS0809_conversion(STRING pVersion) := FUNCTION

	code 										:= 'KYS0809';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	#workunit('name','Yogurt: Prof License MARI- '+code);
	AddrExceptions := '(DRIVE|CENTER|BUILDING)';
	Valid_License_Type := ['CG','CR','SL','SR'];
	//Credentials
	CredList	:= ['MAI','IFA','SRA'];
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed','using');
																			);	

	inFile 									:= Prof_License_Mari.file_KYS0809.apr;
	
	//Filtering out BAD RECORDS
	ValidMTGFile	          := inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUppercase(TRIM(SLNUM,LEFT,RIGHT))) 
	                                  AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUppercase(TRIM(FIRST_NAME,LEFT,RIGHT))));
	GoodNameRec							:= ValidMTGFile(TRIM(FIRST_NAME+LAST_NAME+OFFICENAME)<>'');
  ut.CleanFields(GoodNameRec, ClnNameRec);
	oFile										:= OUTPUT(ClnNameRec);
	
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(GoodNameRec pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];  //yyyymmdd
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

		//Standardize Fields
		TrimNAME_FIRST				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.FIRST_NAME);
		TrimNAME_LAST					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LAST_NAME);
		TrimNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.OFFICENAME);
		TrimAddress1					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1_1);
		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY_1);
		TrimState							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE_1);
		TrimZip								:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP);	
		TrimCounty						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.COUNTY);	

		//map license type to be used as reference for prof_cd logic
		SELF.RAW_LICENSE_TYPE	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LICTYPE);
		SELF.STD_LICENSE_TYPE	:= map(TRIM(SELF.RAW_LICENSE_TYPE)='ASSOCIATE' => 'A',
																 TRIM(SELF.RAW_LICENSE_TYPE)='CERTIFIED GENERAL' => 'CG',
																 TRIM(SELF.RAW_LICENSE_TYPE)='CERTIFIED RESIDENTIAL' => 'CR',
																 TRIM(SELF.RAW_LICENSE_TYPE)='LICENSED REAL PROPERTY' => 'LR',
																 TRIM(SELF.RAW_LICENSE_TYPE)='LICENSED REAL' => 'LR',
																 TRIM(SELF.RAW_LICENSE_TYPE)='PROPERTY' => 'LR',
																 TRIM(SELF.RAW_LICENSE_TYPE)='LICENSED RESIDENTIAL' => 'LR',
																 '');
		SELF.LICENSE_NBR			:= StringLib.StringToUpperCase(TRIM(pInput.SLNUM,LEFT,RIGHT));
		SELF.STD_LICENSE_STATUS	:= 'A'; //Per vendor, all licenses are active
		SELF.PROVNOTE_3				:= IF(SELF.STD_LICENSE_STATUS<>'','{LICENSE STATUS ASSIGNED}','');																			 

		//Clean individual name
		full_name							:= TrimNAME_FIRST + ' ' + TrimNAME_LAST;
		tempNick 							:= Prof_License_Mari.fGetNickname(full_name,'nick');
		stripNickName 				:= Prof_License_Mari.fGetNickname(full_name,'strip_nick');
		GoodName							:= IF(tempNick != '',stripNickName,full_name);
		ParsedName						:= Prof_License_Mari.fnCleanNames.easyClean(TrimNAME_FIRST,'',TrimNAME_LAST,'');
		FirstName 						:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   						:= TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  						:= TRIM(ParsedName[46..65],LEFT,RIGHT); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);
		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_FIRST		   	:= FirstName; 
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);
		SELF.NAME_ORG_ORIG	  := full_name;
		SELF.NAME_FORMAT			:= IF(full_name<>'','F','');
	
		//Identifying DBA and Office NAMES
		ParsedDbaName 				:= Prof_License_Mari.fnCleanNames.ExtractCleanDBA(TrimNAME_OFFICE, '');
		SELF.NAME_DBA_PREFX	  := TRIM(ParsedDbaName[1..20],LEFT,RIGHT);
		SELF.NAME_DBA					:= TRIM(ParsedDbaName[41..140],LEFT,RIGHT);
		SELF.NAME_DBA_SUFX	  := TRIM(ParsedDbaName[21..40],LEFT,RIGHT); 
		SELF.NAME_MARI_DBA	  := TRIM(ParsedDbaName[141..240],LEFT,RIGHT);
		SELF.NAME_DBA_ORIG	  := TRIM(ParsedDbaName[141..240],LEFT,RIGHT);
		SELF.DBA_FLAG		    	:= If(SELF.NAME_DBA != '',1,0);
	  
		ParsedOfficeName 			:= Prof_License_Mari.fnCleanNames.ExtractCleanOfficeName(TrimNAME_OFFICE, '');
		tmpNAME_OFFICE	      := TRIM(ParsedOfficeName[3..102], LEFT, RIGHT);
		SELF.NAME_OFFICE      := MAP(TRIM(tmpNAME_OFFICE,LEFT,RIGHT) IN ['N/A','NONE']=>'',
		                             TRIM(tmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																 TRIM(tmpNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '', 
														     tmpNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '',TRIM(ParsedOfficeName[1..2], LEFT, RIGHT),'');
				
		//Populating MARI Name Fields
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;
		SELF.PHN_MARI_1				:= IF(TRIM(pInput.TELE_1,LEFT,RIGHT) != '',StringLib.StringFilter(pInput.TELE_1,'0123456789'),'');
		SELF.PHN_PHONE_1    	:= IF(TRIM(pInput.TELE_1,LEFT,RIGHT) != '',StringLib.StringFilter(pInput.TELE_1,'0123456789'),'');;

		/*Default issue date is 17530101
		Expire date is 6/30 each year based on last update date*/
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		next_year := ((INTEGER2) SELF.LAST_UPD_DTE[1..4])+1;
		SELF.EXPIRE_DTE				:= map(SELF.LAST_UPD_DTE[5..8]< '0630' => SELF.LAST_UPD_DTE[1..4]+'0630',
																	SELF.LAST_UPD_DTE[5..8] > '0630' => (STRING4)next_year+'0630','17530101');
																
		// Prepping Address Fields for Parsing
		cln_preaddr1					:= StringLib.StringCleanSpaces(TrimAddress1);
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
		SELF.ADDR_CNTY_1			:= TrimCounty;
		SELF.ADDR_BUS_IND			:= IF(TRIM(clnAddrAddr1) != ' ','B',' ');

		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO',
																 '');		
	
		/* fields used to create mltrec_key are :
		license number
		office license number
		license type
		source update
		raw name including DBA's
		raw address */
		SELF.MLTRECKEY	:= 0;

		/* fields used to create cmc_slpk unique key are :
		license number
		office license number
		license type
		source update
		name
		address
		dba */	
		SELF.CMC_SLPK     :=  HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																+TRIM(SELF.std_license_type,LEFT,RIGHT)
																+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																+TrimNAME_FIRST
																+TrimNAME_LAST
																+TrimNAME_OFFICE
																+TrimAddress1
																+TrimCity
																+TrimZip);	
		SELF := [];
		
	END;

	ds_map := PROJECT(ClnNameRec, xformToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		

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
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;