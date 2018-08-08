//************************************************************************************************************* */	
//  The purpose of this development is take NH Real Estate License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */	
#workunit('name','Yogurt: map_NHS0856_conversion');
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, std;

EXPORT map_NHS0856_conversion(STRING pVersion) := FUNCTION

	code 								:= 'NHS0856';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move to using
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed','using');	
												 );
	//NH input file
	//Per Vendor- Inacive records can not be used
	ds_NH_RealEstate		:= Prof_License_Mari.file_NHS0856(LICSTAT not in  ['INACTIVE','Inactive', 'inactive']);
	oRE									:= OUTPUT(ds_NH_RealEstate);

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA IN NH AS|DBA IN NH |DBA |D B A |D/B/A )(.*)';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';

	//Remove bad records before processing
	ValidNHFile	:= ds_NH_RealEstate(TRIM(LAST_NAME,LEFT,RIGHT)<>'' AND NOT REGEXFIND('INACTIVE',LAST_NAME,NOCASE));

//NH Appraisal layout to Common
Prof_License_Mari.layouts.base	transformToCommon(Prof_License_Mari.layout_NHS0856 L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;

		//NH Real Estate layout to Common
		SELF.TYPE_CD					:= 'MD';
	
		//Clean Individual name for name_org field
		vFirstName 	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FIRST_NAME);
		vMidName		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.MID_NAME);
		vLastName		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.LAST_NAME);
		vNameOffice	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.OfficeName);
		FullName		:= std.str.CleanSpaces(vLastName+' '+vFirstName);
		
		SELF.NAME_ORG					:= FullName;
		SELF.NAME_FIRST				:= vFirstName;
		SELF.NAME_MID					:= vMidName;
		SELF.NAME_LAST				:= vLastName;
	
		//Clean Office name to remove DBA
		ClnOffice							:= IF(REGEXFIND('/',L.OfficeName),REGEXREPLACE('/',L.OfficeName,' '),vNameOffice);
		OfficeNameOnly				:= IF(REGEXFIND(DBApattern,ClnOffice),REGEXFIND(DBApattern,ClnOffice,1),ClnOffice);
		stdOfficeName					:= if(std.str.find(OfficeNameOnly, '.COM',1)> 0, mod_clean_name_addr.cleanInternetName(ClnOffice),
																		Prof_License_Mari.mod_clean_name_addr.strippunctName(
																																Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(OfficeNameOnly)));
		GoodNAME_OFFICE			  := IF(REGEXFIND(IPpattern,OfficeNameOnly),OfficeNameOnly,REGEXREPLACE(' COMPANY',stdOfficeName,' CO'));
		
		//Blank Out NAME_OFFICE when Individual Names matches OfficeName
		v_FullName_fml		:= std.str.cleanspaces(vFirstName + ' '+vMidName+' '+vLastName);
		v_SlimNameOffice	:= std.str.cleanspaces(L.OfficeName[..length(v_FullName_fml)]);
		self.NAME_OFFICE	:= if(NOT REGEXFIND('[A-Z|a-z]',GoodNAME_OFFICE), '',
														if(GoodNAME_OFFICE = std.str.cleanspaces(FullName + ' '+vMidName), '',
															if(v_FullName_fml = v_SlimNameOffice
																	and length(v_FullName_fml) = length(trim(vNameOffice)), '', 
																			if(v_FullName_fml = v_SlimNameOffice and 
																				(std.str.find(vNameOffice, ', JR',1) >0 or
																				 std.str.find(vNameOffice, ', SR',1) >0 or
																				 std.str.find(vNameOffice, ', III',1) >0 or
																				 std.str.find(vNameOffice, ', IV',1) >0 or
																				 std.str.find(vNameOffice, ', II',1) >0 or
																				 std.str.find(vNameOffice, ', V',1) >0 or
																				 std.str.find(vNameOffice, ', II',1) >0 
																				 ),'',
																					std.str.CleanSpaces(GoodNAME_OFFICE)))));

		
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE!='',
		                            IF(Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR','MD'),
																'');
		
		//Get DBA name from Office Name field
		DBANameOnly						:= IF(REGEXFIND(DBApattern,ClnOffice),REGEXFIND(DBApattern,ClnOffice,3),'');
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(DBANameOnly); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		SELF.NAME_DBA					:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
															  Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		
		tempLicenseNbr				:= MAP(LENGTH(TRIM(L.SLNUM,LEFT,RIGHT)) = 1 => '00000'+TRIM(L.SLNUM,LEFT,RIGHT),
																 LENGTH(TRIM(L.SLNUM,LEFT,RIGHT)) = 2 => '0000'+TRIM(L.SLNUM,LEFT,RIGHT),
																 LENGTH(TRIM(L.SLNUM,LEFT,RIGHT)) = 3 => '000'+TRIM(L.SLNUM,LEFT,RIGHT),
																 LENGTH(TRIM(L.SLNUM,LEFT,RIGHT)) = 4 => '00'+TRIM(L.SLNUM,LEFT,RIGHT),
																 LENGTH(TRIM(L.SLNUM,LEFT,RIGHT)) = 5 => '0'+TRIM(L.SLNUM,LEFT,RIGHT),TRIM(L.SLNUM,LEFT,RIGHT));
		SELF.LICENSE_NBR			:= IF(tempLicenseNbr = '','NR',tempLicenseNbr);
		SELF.LICENSE_STATE		:= src_st;
		
		tempRawLicType				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.LICTYPE);
		SELF.RAW_LICENSE_TYPE	:= tempRawLicType;
		tempStdLicType				:= MAP(std.str.find(TRIM(tempRawLicType,LEFT,RIGHT),'ASSOCIATE BROKER',1)= 1 => 'AB',
																	std.str.find(TRIM(tempRawLicType,LEFT,RIGHT),'MANAGING BROKER',1)= 1 => 'MB',
																	std.str.find(TRIM(tempRawLicType,LEFT,RIGHT),'PRINCIPAL BROKER',1)= 1 => 'PB',
																	std.str.find(TRIM(tempRawLicType,LEFT,RIGHT),'SALESPERSON',1)= 1 => 'S',
																	std.str.find(TRIM(tempRawLicType,LEFT,RIGHT),'TEMPORARY MANAGING BROKER',1)= 1 => 'TMB',
																	std.str.find(TRIM(tempRawLicType,LEFT,RIGHT),'TEMPORARY PRINCIPAL BROKER',1)= 1 => 'TPB',' ');
		SELF.STD_LICENSE_TYPE	:= tempStdLicType;
		
		SELF.RAW_LICENSE_STATUS	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.LICSTAT);
		
		// Use default date of 17530101 for blank dates.
		SELF.CURR_ISSUE_DTE		:= '17530101';
		temp_issue_yr					:= REGEXFIND(Datepattern,L.ISSUEDT,3);
		temp_issue_mon				:= REGEXFIND(Datepattern,L.ISSUEDT,1);
		temp_issue_day				:= REGEXFIND(Datepattern,L.ISSUEDT,2);
		pad_issue_mon					:= IF(LENGTH(temp_issue_mon) < 2, '0'+temp_issue_mon, temp_issue_mon);
		pad_issue_day					:= IF(LENGTH(temp_issue_day) < 2, '0'+temp_issue_day, temp_issue_day);
		SELF.ORIG_ISSUE_DTE		:= IF(L.ISSUEDT = ' ','17530101'
																,TRIM(temp_issue_yr,LEFT,RIGHT) + TRIM(pad_issue_mon,LEFT,RIGHT) + TRIM(pad_issue_day,LEFT,RIGHT));
		temp_expire_yr				:= REGEXFIND(Datepattern,L.EXPDT,3);
		temp_expire_mon				:= REGEXFIND(Datepattern,L.EXPDT,1);
		temp_expire_day				:= REGEXFIND(Datepattern,L.EXPDT,2);
		pad_expire_mon				:= IF(LENGTH(temp_expire_mon) < 2, '0'+temp_expire_mon, temp_expire_mon);
		pad_expire_day				:= IF(LENGTH(temp_expire_day) < 2, '0'+temp_expire_day, temp_expire_day);
		SELF.EXPIRE_DTE				:= IF(L.EXPDT = ' ','17530101'
																,TRIM(temp_expire_yr,LEFT,RIGHT) + TRIM(pad_expire_mon,LEFT,RIGHT) + TRIM(pad_expire_day,LEFT,RIGHT));
																
		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= STD.Str.ToUpperCase(std.str.Cleanspaces(L.LAST_NAME+' '+L.FIRST_NAME+' '+L.MID_NAME));
		SELF.NAME_FORMAT			:= 'L';
		SELF.NAME_MARI_ORG		:= IF(SELF.OFFICE_PARSE = 'GR',SELF.NAME_OFFICE,'');
		SELF.NAME_MARI_DBA		:= IF(REGEXFIND(IPpattern,tmpNameDBA),std.str.Cleanspaces(tmpNameDBA),
																std.str.Cleanspaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(tmpNameDBA)));	

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
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

		tmpZip	            	:= MAP(LENGTH(TRIM(L.ZIP))=3 => '00'+TRIM(L.ZIP),
		                             LENGTH(TRIM(L.ZIP))=4 => '0'+TRIM(L.ZIP),
						                     TRIM(L.Zip));
		
		trimAddress1          := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS1);
	  trimAddress2          := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS2);
  		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= std.str.Cleanspaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= std.str.Cleanspaces(L.CITY+' '+L.STATE +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',std.str.Cleanspaces(tmpADDR_ADDR2_1),
																std.str.Cleanspaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',std.str.Cleanspaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		//Clean phone and remove non-numerics
		SELF.mltreckey				:= 0; //This file doesn't have multiple DBA's
				
		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// standard name_org w/o DBA
		// raw address 	
		SELF.CMC_SLPK     		:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																		+TRIM(trimAddress1,LEFT,RIGHT)
																		+TRIM(trimAddress2,LEFT,RIGHT)
																		+TRIM(L.CITY,LEFT,RIGHT)
																		+TRIM(L.STATE,LEFT,RIGHT)
																		+TRIM(L.ZIP,LEFT,RIGHT));		
		SELF := [];
	
	END;

	ds_map := PROJECT(ValidNHFile, transformToCommon(left));
	
	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND STD.Str.ToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	
	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND STD.Str.ToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
	d_final 						:= OUTPUT(ds_map_status_trans, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);						
	add_super 					:= Prof_License_Mari.fAddNewUpdate(ds_map_status_trans);
	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');	
																	);
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);


END;
