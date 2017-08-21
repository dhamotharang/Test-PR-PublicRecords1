//********************************************************************************
// Converting West Virginia Real Estate Appr Lic & Cert Board Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
//********************************************************************************

IMPORT Prof_License, Prof_License_Mari, Address, Ut, NID, Lib_FileServices, lib_stringlib;

EXPORT map_WVS0816_conversion(STRING pVersion) := FUNCTION

	code 								:= 'WVS0816';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';
	//Dataset reference files for lookup joins
	cmvTransLkp					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	//Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');
																  );

	//The output of acrobat conversion 
	file_raw						:= Prof_License_Mari.file_WVS0816;
	oRAW								:= OUTPUT(file_raw);

	//concat all columns
	layout_concat := RECORD
		STRING all_columns;
		STRING temp1;
		STRING temp2;
		STRING temp3;
		STRING temp4;
		STRING temp5;
		STRING county;
	END;

	layout_concat concatAllColumns(file_raw L) := TRANSFORM
		temp := //TRIM(REGEXREPLACE('[ ]+',L.COL_A,' '),LEFT,RIGHT)+'|'+
		        TRIM(L.COL_A,LEFT,RIGHT)+'|'+
		        TRIM(L.COL_B,LEFT,RIGHT)+'|'+
						//TRIM(REGEXREPLACE('[ ]+',L.COL_C,' '),LEFT,RIGHT)+'|'+
						//TRIM(REGEXREPLACE('[ ]+',L.COL_D,' '),LEFT,RIGHT)+'|'+
		        TRIM(L.COL_C,LEFT,RIGHT)+'|'+
		        TRIM(L.COL_D,LEFT,RIGHT)+'|'+
						TRIM(L.COL_E,LEFT,RIGHT)+'|'+TRIM(L.COL_F,LEFT,RIGHT)+'|'+TRIM(L.COL_G,LEFT,RIGHT)+'|'+TRIM(L.COL_H,LEFT,RIGHT)+'|'+
						TRIM(L.COL_I,LEFT,RIGHT)+'|'+
						//TRIM(REGEXREPLACE('[ ]+',L.COL_J,' '),LEFT,RIGHT)+'|'+
		        TRIM(L.COL_J,LEFT,RIGHT)+'|'+
						TRIM(L.COL_K,LEFT,RIGHT)+'|'+TRIM(L.COL_L,LEFT,RIGHT)+'|'+
						TRIM(L.COL_M,LEFT,RIGHT)+'|'+TRIM(L.COL_N,LEFT,RIGHT)+'|'+TRIM(L.COL_O,LEFT,RIGHT)+'|'+TRIM(L.COL_P,LEFT,RIGHT)+'|'+
						TRIM(L.COL_Q,LEFT,RIGHT)+'|'+TRIM(L.COL_R,LEFT,RIGHT)+'|'+TRIM(L.COL_S,LEFT,RIGHT)+'|'+TRIM(L.COL_T,LEFT,RIGHT)+'|'+
						TRIM(L.COL_U,LEFT,RIGHT)+'|'+TRIM(L.COL_V,LEFT,RIGHT)+'|'+TRIM(L.COL_W,LEFT,RIGHT)+'|'+TRIM(L.COL_X,LEFT,RIGHT)+'|'+
						TRIM(L.COL_Y,LEFT,RIGHT);
		SELF.temp1 := Prof_License_Mari.mod_clean_name_addr.TrimUpper(temp);			
		//remove extra columns
		SELF.temp2 := REGEXREPLACE('(\\|+)', SELF.temp1, '|');
		//remove trailing |
		SELF.temp3 := REGEXREPLACE('\\|$', SELF.temp2, '');
		//Replace 2 and more spaces by |. This should convert lines like SMITH, JANE R.   2000 MAIN ... to SMITH, JANE R.|2000 MAIN..
		SELF.temp4 := REGEXREPLACE('[ ]{4,}', SELF.temp3, '|');
		SELF.temp5 := REGEXREPLACE('[ ]{2,}',SELF.temp4,' ');
		SELF.all_columns := IF(REGEXFIND('CERT NO',SELF.temp5),'',SELF.temp5);
		SELF.county := IF(REGEXFIND('\\|', SELF.temp5), '', SELF.temp5);
		//SELF := [];
	END;
	file_concat := PROJECT(file_raw, concatAllColumns(LEFT));

	oFConcat := OUTPUT(file_concat);
	oOdd     := OUTPUT(file_concat(all_columns<>''));
	
	//Populate county
	layout_concat populateCounty(layout_concat L, layout_concat R) := TRANSFORM
		temp_county := MAP(L.all_columns='' => R.county,
											 R.all_columns<>'' AND NOT REGEXFIND('\\|', R.all_columns) => R.county,
											 L.county);
		SELF.county := IF(REGEXFIND('Z[ ]+-[ ]+OTHER',temp_county), '', temp_county);									 
		SELF := R;
	END;
	file_county  := ITERATE(file_concat(all_columns<>''), populateCounty(LEFT, RIGHT));
	ofile_county := OUTPUT(file_county,,NAMED('ofile_county'));
	
	//format the the input file
	//layout_inf formatData(layout_concat L) := TRANSFORM - used for debug
	Prof_License_Mari.layout_WVS0816.LAYOUT_DATA  formatData(layout_concat L) := TRANSFORM
		record_pattern 	:= '^(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)\\|(.*)$';
		SELF.COUNTY			:= L.county;
		SELF.NAME				:= TRIM(REGEXFIND(record_pattern, L.all_columns, 1), LEFT, RIGHT);
		SELF.ADDRESS		:= TRIM(REGEXFIND(record_pattern, L.all_columns, 2), LEFT, RIGHT);
		SELF.CITY				:= TRIM(REGEXFIND(record_pattern, L.all_columns, 3), LEFT, RIGHT);
		SELF.ST					:= TRIM(REGEXFIND(record_pattern, L.all_columns, 4), LEFT, RIGHT);
		SELF.ZIP				:= TRIM(REGEXFIND(record_pattern, L.all_columns, 5), LEFT, RIGHT);
		SELF.PHONE			:= TRIM(REGEXFIND(record_pattern, L.all_columns, 6), LEFT, RIGHT);
		SELF.LIC_TYPE		:= TRIM(REGEXFIND(record_pattern, L.all_columns, 7), LEFT, RIGHT);
		SELF.LIC_NO			:= TRIM(REGEXFIND(record_pattern, L.all_columns, 8), LEFT, RIGHT);	
		SELF						:= L;
	END;

	infile := PROJECT(file_county(REGEXFIND('\\|', all_columns)), formatData(LEFT));
	oAPR   := OUTPUT(infile);	
	
	//Filtering out "BAD" records per requirements
	GoodFilterRec	 			:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(NAME)) AND
																LIC_NO<>'');
  ut.CleanFields(GoodFilterRec,clnGoodFilterRec);

	//Map Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(Prof_License_Mari.layout_WVS0816.LAYOUT_DATA pInput) := TRANSFORM

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
	
 		TrimCounty						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.COUNTY);
 		TrimNAME_FULL					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.NAME);
		TrimAddress1 					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS);
		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY);
		TrimState							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ST);
		TrimZip								:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP);
		TrimPhone							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.PHONE);
		TrimLicType	 					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_TYPE);
		TrimLicNo		 					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_NO);
    //SuffixName Pattern
		SuffixPattern         := ' JR.| SR.| JR | SR | III| II | VI | IV ';
    tempSufx              := IF(REGEXFIND(SuffixPattern,TrimNAME_FULL),REGEXFIND(SuffixPattern,TrimNAME_FULL,0),'');
    tempNAME_FULL         := IF(REGEXFIND(SuffixPattern,TrimName_FULL),REGEXREPLACE(SuffixPattern,TrimNAME_FULL,''),TrimNAME_FULL);
		// Individual Name Parsing
		ParsedName  					:= NID.CleanPerson73(tempNAME_FULL);
		
		FirstName 						:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   						:= TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  						:= TRIM(ParsedName[46..65],LEFT,RIGHT); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
											
		SELF.NAME_ORG		    	:= StringLib.StringCleanSpaces(LastName +' '+ FirstName);
		SELF.DBA_FLAG		    	:= 0;
		SELF.NAME_FIRST		    := FirstName;
		SELF.NAME_MID					:= MidName;								
		SELF.NAME_LAST		    := LastName;
		SELF.NAME_SUFX				:= IF(tempSufx !='',TRIM(tempSufx,LEFT,RIGHT),Suffix);
	  									
		// License Information
		SELF.LICENSE_NBR	    := TrimLicNo;
		SELF.RAW_LICENSE_TYPE	:= TrimLicType;
		SELF.STD_LICENSE_TYPE := trim(SELF.RAW_LICENSE_TYPE,LEFT,RIGHT);
		
		SELF.RAW_LICENSE_STATUS := '';
		SELF.STD_LICENSE_STATUS := 'A';
		   		   
	//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';	

		//Per West Virginia Appraiser website, all real estate appraiser licenses in WV expire September 30th each year.
		this_year 						:= ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4]);
		next_year 						:= ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4]) + 1;
		SELF.EXPIRE_DTE				:= IF(pVersion[5..6]>'09',next_year+'0930',this_year + '0930');
			
		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := TrimNAME_FULL;
		SELF.NAME_FORMAT			:= 'L';
		
		// Parse Out Address Information **([-+]?** Parsing Prblm)
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimCity + pInput.ZIP) != '','B','');

		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

		tmpZip	              := MAP(LENGTH(TrimZip)=3 => '00'+TrimZip,
		                             LENGTH(TrimZip)=4 => '0'+TrimZip,
																 TrimZip);		  		
	  //Remve contact/company name
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

		SELF.ADDR_CNTY_1			:= IF(REGEXFIND('Z - OTHER', TrimCounty), ' ', TrimCounty);
		
		SELF.PHN_MARI_1				:= TrimPhone;
		SELF.PHN_PHONE_1			:= StringLib.StringFilter(TrimPhone,'0123456789');
		
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= IF(SELF.TYPE_CD = 'MD','IN', '');
			
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK         := HASH64(TRIM(SELF.LICENSE_NBR,LEFT,RIGHT) 
																		+TRIM(SELF.STD_LICENSE_TYPE,LEFT,RIGHT)
																		+TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																		+TRIM(TRIMADDRESS1,LEFT,RIGHT)
																		+TRIM(pInput.CITY,LEFT,RIGHT)
																		+TRIM(PINPUT.ZIP,LEFT,RIGHT));
		SELF.PCMC_SLPK				:= 0;
		SELF.PROVNOTE_3 	    := '[LICENSE_STATUS ASSIGNED]';
			
		SELF := [];	
		   
	END;
	inFileLic	:= PROJECT(clnGoodFilterRec,xformToCommon(LEFT));

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base 	trans_lic_type(inFileLic L, cmvTransLkp R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(inFileLic, cmvTransLkp,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	d_final := OUTPUT(ds_map_lic_trans,, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
	
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));	


	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');
	                        );
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oRAW, oFConcat, oOdd, ofile_county, oAPR, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;