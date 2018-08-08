//  The purpose of this development is take KansasProfessional License raw files and convert them to a common
//  professional license (BASE) layout to be used for MARI and PL_BASE development.
//	05/05/2015 T.George - New Development
//************************************************************************************************************* */	

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_KSS0902_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt: map_KSS0902_conversion');
	code 		:= 'KSS0902';
	src_cd	:= 'S0902';
	src_st	:= 'KS';	//License state

	//Move file(s) from ::sprayed:: to ::using::
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'sprayed', 'using');

	// Filter records w/o ORG_NAME being not populated
	ValidAprFile	:= Prof_License_Mari.file_KSS0902.apr(ORG_NAME != '' AND 
																									        NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUppercase(TRIM(ORG_NAME,LEFT,RIGHT))));

  oApr	:= OUTPUT(ValidAprFile);
	
	// Reference Files
	cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
	OCmv := output(cmvTransLkp);
	

	maribase_plus_dbas := record, maxsize(5000)
		Prof_License_Mari.layouts.base;
		string60 dba1;
		string60 dba2;
		string60 dba3;
		string60 dba4;
		string60 dba5;
		string60 dba6;
	end;

	//AR S0824
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.layout_kss0902 pInput) := TRANSFORM

			SELF.PRIMARY_KEY			:= 0;
			SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
			SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
			SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

			SELF.STD_SOURCE_UPD		:= src_cd;
			SELF.TYPE_CD					:= 'MD';
			SELF.STD_SOURCE_DESC	:= ' ';
			SELF.STD_PROF_CD		  := ' ';
			SELF.STD_PROF_DESC		:= ' ';
			
			//Added based on the implementation from AKS0376
			SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
			SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

			// If individual and not identified as a corporation names, parse into (FMLS) fmt
			TrimNAME_ORG			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME);
			clnParseName			:= IF(StringLib.stringfind(TRIM(TrimNAME_ORG,LEFT,RIGHT),' ',1)<1, ' ',Prof_License_Mari.mod_clean_name_addr.cleanFMLName(TrimNAME_ORG));					
			title		:= TRIM(clnParseName[1..5],LEFT,RIGHT);
			fname		:= TRIM(clnParseName[6..25],LEFT,RIGHT);
			mname		:= TRIM(clnParseName[26..45],LEFT,RIGHT);
			lname		:= TRIM(clnParseName[46..65],LEFT,RIGHT);
			suffix	:= TRIM(clnParseName[66..70],LEFT,RIGHT);
			
			SELF.NAME_ORG		  := StringLib.StringCleanSpaces(lname + ' '+fname);
			SELF.NAME_OFFICE	:= '';	
			SELF.OFFICE_PARSE	:= '';
			SELF.NAME_PREFX		:= title;
			SELF.NAME_FIRST		:= fname;
			SELF.NAME_MID			:= mname;
			SELF.NAME_LAST		:= lname;
			SELF.NAME_SUFX		:= suffix;
					 
			SELF.LICENSE_NBR	:= 'NR';
			SELF.LICENSE_STATE:= src_st;
		
			SELF.RAW_LICENSE_TYPE		:= StringLib.StringToUpperCase(pInput.LICENSE_TYPE);
			SELF.STD_LICENSE_TYPE		:= StringLib.StringToUpperCase(pInput.LICENSE_TYPE); 	
				 
			//Reformatting date from MM/DD/YYYY to YYYYMMDD
			SELF.ORIG_ISSUE_DTE	  	:= '17530101';
			SELF.CURR_ISSUE_DTE			:= '17530101';
			SELF.EXPIRE_DTE					:= Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPIRATION_DATE);	 
					 
			// assigned based on expiration date
			SELF.STD_LICENSE_STATUS	:= IF(SELF.expire_dte > SELF.process_date, 'A','I');
			SELF.NAME_FORMAT				:= 'F';
			SELF.NAME_ORG_ORIG			:= TrimNAME_ORG;
			SELF.NAME_DBA_ORIG			:= '';
			SELF.NAME_MARI_ORG			:= '';
			SELF.NAME_MARI_DBA			:= '';
			SELF.PHN_MARI_1        	:= ut.CleanPhone(pInput.BUSINESS_PHONE);
					 
			// moving city, state, and zip to their respective fields
			//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
			tempaddr								:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.BUSINESS_ADDRESS);
			tempaddr1								:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.BUSINESS_CITY_ST_ZIP);
			tempaddr2								:= StringLib.StringFilterOut(tempaddr1, '.');
			tempzip                 := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', TRIM(tempaddr2,left,right), 0);	
			tempaddr4               := tempaddr2[..(LENGTH(tempaddr2)-LENGTH(tempzip))];
			tempcity								:= REGEXFIND('([A-Za-z\'][^\\,]+)\\,\\s([A-Za-z]{2})$', TRIM(tempaddr4,left,right), 1);
			tempst									:= REGEXFIND('([A-Za-z\'][^\\,]+)\\,\\s([A-Za-z]{2})$', TRIM(tempaddr4,left,right), 2);
					 
					 
			// final field assignment for city, state, and zip
			SELF.ADDR_BUS_IND		:= IF(tempaddr != ' ','B',' ');
			SELF.ADDR_ADDR1_1		:= tempaddr;
			SELF.ADDR_ADDR2_1		:= '';
			SELF.ADDR_CITY_1		:= tempcity;
			SELF.ADDR_STATE_1		:= tempst;
			SELF.ADDR_ZIP5_1		:= tempzip[1..5];
			SELF.ADDR_ZIP4_1		:= tempzip[7..10];
			SELF.PHN_PHONE_1		:= SELF.PHN_MARI_1;
			SELF.ADDR_CNTY_1   	:= '';
				
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD	:= 'IN';  
					
			/* fields used to create mltrec_key unique record split dba key are :
					 transformed license number
					 standardized license type
					 standardized source update
					 raw name containing dba name(s)
					 raw address
			*/
			SELF.mltreckey		:= 0;
					 
				/* fields used to create cmc_slpk unique key are :
					license number
					license type
					source update
					name
					address */
			//Use hash64 instead of hash32 to avoid dup keys		 
			SELF.cmc_slpk    	:= HASH64(trim(SELF.license_nbr) + ','
																	+ TRIM(SELF.std_license_type) + ','
																	+ TRIM(SELF.std_source_upd) + ','
																	+ TRIM(SELF.name_org) + ','
																	+ Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.business_address) +','
																	+ Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.BUSINESS_CITY_ST_ZIP)
																	);
			SELF.PROVNOTE_2				:= '';
			SELF.PROVNOTE_3 	    := '[LICENSE_STATUS ASSIGNED]';	
			SELF.PREV_PRIMARY_KEY	:= 0;
			SELF.PREV_MLTRECKEY		:= 0;
			SELF.PREV_CMC_SLPK		:= 0;
			SELF.PREV_PCMC_SLPK		:= 0;
			SELF.CONT_EDUCATION_ERND	:= '';
			SELF.CONT_EDUCATION_REQ		:= '';
			SELF.CONT_EDUCATION_TERM	:= '';
			SELF := [];		   		   
			
	END;

	ds_map := PROJECT(ValidAprFile, transformToCommon(LEFT));
	
	
	// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(ds_map L, cmvTransLkp R) := transform
	self.STD_PROF_CD := R.DM_VALUE1;
	self := L;
end;

ds_map_lic_prof := JOIN(ds_map, cmvTransLkp,
												TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
												AND right.fld_name='LIC_TYPE' 
												AND right.dm_name1 = 'PROFCODE',
												trans_lic_type(left,right),left outer,lookup);

																		
company_only_lookup := ds_map_lic_prof(affil_type_cd='CO');																		
																			
	//maribase_plus_dbas 		assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	maribase_plus_dbas 		assign_pcmcslpk(ds_map_lic_prof L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_prof, company_only_lookup,
								  TRIM(LEFT.license_nbr[..StringLib.stringfind(LEFT.license_nbr,'.',1)-1],LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT),
									assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
						
						
	maribase_plus_dbas	 xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
											TRIM(L.provnote_1,left,right)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
													 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
													 'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;
	ds_map_assign := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));


	// Normalized DBA records
	maribase_plus_tmp := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_plus_tmp	NormIT(ds_map_assign L, INTEGER C) := TRANSFORM
			SELF := L;
			SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5, L.DBA6);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_assign,6,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = ' ' AND DBA1 = ' ' AND DBA2 = ' ' 
					AND DBA3 =  '' AND DBA4 = ' ' AND DBA5 = ' ', DBA6 = ' ');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	AllRecs  := DBARecs + NoDBARecs;

	// transform expanded dataset to MARIBASE layout
	Prof_License_Mari.layouts.base trans_to_base(AllRecs L) := transform
		SELF := L;
	END;

	ds_map_base := project(AllRecs, trans_to_base(LEFT));

	// output(ds_map_base);

	//Adding to Superfile
		
	d_final := output(ds_map_base , ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
	
	//BUG 180478
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used');
	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oApr, OCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;