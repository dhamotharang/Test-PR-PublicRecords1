//************************************************************************************************************* */	
//  The purpose of this development is take DE Real Estate and Appraisers License raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
//************************************************************************************************************* */	
//  The purpose of this development is take DE Real Estate and Appraisers License raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//**************************************************************************************************************/
//File Location - \\Tapeload02b\k\professional_licenses\mari\de\delaware_real_estate_professionals_(en)	
//                \\Tapeload02b\k\professional_licenses\mari\de\delaware_real_estate_appraisers_(en)
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_DES0846_conversion(STRING pVersion) := FUNCTION

	code 								:= 'DES0846';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV						:= OUTPUT(cmvtranslation);
	
	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |/ DBA | DBA/|AKA |T/A )(.*)';
	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';

	//Move input file from sprayed to using
	move_to_using := PARALLEL(
										Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'sprayed', 'using');
										Prof_License_Mari.func_move_file.MyMoveFile(code, 're', 'sprayed', 'using');
										);

	//DE input file
	oREFile 			:= OUTPUT(Prof_License_Mari.files_DES0846.professionals);
	oApprFile 		:= OUTPUT(Prof_License_Mari.files_DES0846.appraisers);
	
	ds_DE_RealEstate		:= Prof_License_Mari.files_DES0846.appraisers + Prof_License_Mari.files_DES0846.professionals;
	//Remove bad records before processing
	ValidDEFile		:= ds_DE_RealEstate(ORG_NAME <> '' AND LIC <> '' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));


	//DE Real Estate layout to Common
	Prof_License_Mari.layout_base_in	transformToCommon(Prof_License_Mari.layout_DES0846 L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		                                                                                   
		//map license type to be used as reference for name and type_cd logic
		//raw_license_type should be what is in the input file. Cathy Tio 1/25/13
		TrimLicenseType				:= ut.CleanSpacesAndUpper(L.LIC);
		SELF.RAW_LICENSE_TYPE	:= TrimLicenseType;
 		SELF.STD_LICENSE_TYPE	:= MAP(TrimLicenseType='CERTIFIED GENERAL REAL PROPERTY APPRAISE' => 'CGRPA',
   														TrimLicenseType='CERTIFIED RESIDENTIAL REAL PROPERTY APPR' => 'CGRPA',
															TrimLicenseType='CERT. RESIDENTIAL REAL PROPERTY APPR' => 'CGRPA',
   														TrimLicenseType='LICENSED REAL PROPERTY APPRAISER' => 'LRPA',
   														TrimLicenseType='NONRESIDENT BROKER' => 'NB',
   														TrimLicenseType='NONRESIDENT SALESPERSON' => 'NS',
   														TrimLicenseType='RESIDENT BROKER' => 'RB',
   														/*In new input files, all brokers have license numbers starting with RB 1/25/13*/
   														TrimLicenseType='BROKER' => 'RB',
   														// /*This is new in new input files 1/25/13*/
   														TrimLicenseType='ASSOCIATE BROKER' => 'RA',
   														TrimLicenseType='RESIDENT SALESPERSON' => 'RS',
   														/*In new input files, all salespersons have license numbers starting with RS 1/25/13*/
   														TrimLicenseType='SALESPERSON' => 'RS',
   													  TrimLicenseType='APPRAISER TRAINEE' => 'AT',
   														TrimLicenseType='BRANCH OFFICE PERMIT' => 'BOP',
   														TrimLicenseType='MAIN OFFICE PERMIT' => 'MOP',
   														TrimLicenseType='INACTIVE NONRESIDENT BROKER' => 'INB',
   														TrimLicenseType='INACTIVE NONRESIDENT SALESPERSON' => 'INS',
   														TrimLicenseType='INACTIVE RESIDENT BROKER' => 'IRB',
   														TrimLicenseType='INACTIVE RESIDENT SALESPERSON' => 'IRS',
   														TrimLicenseType='TEMPORARY PRACTICE PERMIT' => 'TPP',
															TrimLicenseType='REAL ESTATE INSTRUCTOR' => 'RT',
   														/*New type since 20130702*/
   														TrimLicenseType='CERTIFIED ASSESSOR' => 'CA',
   														/*New type  20140811*/
    													TrimLicenseType='APPRAISAL MANAGEMENT COMPANY' => 'AMC',
  														' ');

														
		SELF.TYPE_CD					:= IF(SELF.STD_LICENSE_TYPE IN ['BOP','MOP','AMC'],'GR','MD');
		
		//Clean and parse Org_name
		ClnNameFull						:= IF(TrimLicenseType = 'BRANCH OFFICE PERMIT' OR TrimLicenseType = 'MAIN OFFICE PERMIT',
														' ',Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TRIM(L.ORG_NAME,LEFT,RIGHT)));
		trim_org_name					:= IF(ClnNameFull = ' ',
														StringLib.StringToUpperCase(TRIM(L.ORG_NAME,LEFT,RIGHT)),' ');
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(trim_org_name); //business name with standard corp abbr.
		getCorpOnly						:= IF(REGEXFIND(DBApattern, tmpNameOrg), Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
														,tmpNameOrg);		 //get names without DBA names
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly);
		//Need to remove leading and trailing /
		name_org_prep					:= IF(ClnNameFull = ' ',Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO'))
															,StringLib.StringToUpperCase(TRIM(ClnNameFull[46..65],LEFT,RIGHT)+' '+TRIM(ClnNameFull[6..25],LEFT,RIGHT)));  //Without punct. and Sufx removed
		SELF.NAME_ORG					:= TRIM(REGEXREPLACE('/$',name_org_prep,''),LEFT,RIGHT);
		//Without punct. and Sufx removed
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		
		//get names with DBA prefix
		temp_dba_name					:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOrg);
		clnDBA_name						:= REGEXREPLACE(DBApattern,StringLib.StringToUpperCase(temp_dba_name),'');
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(clnDBA_name);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(clnDBA_name); //split corporation prefix from name
		SELF.NAME_DBA					:= REGEXREPLACE(' COMPANY',clnDBA_name,' CO');
		SELF.NAME_DBA_SUFX		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		
		// SELF.NAME_FIRST				:= IF(StringLib.StringToUpperCase(ClnNameFull[6..25]) != ' ',
																// StringLib.StringToUpperCase(ClnNameFull[6..25]),
																// '');  //for build 20121207 and before
																// ut.CleanSpacesAndUpper(L.FIRST_NAME));
		// SELF.NAME_MID					:= IF(StringLib.StringToUpperCase(ClnNameFull[26..45]) != ' ',
																// StringLib.StringToUpperCase(ClnNameFull[26..45]),
																// '');  //for build 20121207 and before
																// ut.CleanSpacesAndUpper(L.MIDDLE_NAME));
		// SELF.NAME_LAST				:= IF(StringLib.StringToUpperCase(ClnNameFull[46..65]) != ' ' AND
																// LENGTH(TRIM(ClnNameFull[46..65]))<>1,
																// StringLib.StringToUpperCase(ClnNameFull[46..65]),
																// '');  //for build 20121207 and before
																// ut.CleanSpacesAndUpper(L.LAST_NAME));
		// SELF.NAME_SUFX				:= StringLib.StringToUpperCase(ClnNameFull[66..70]);
		
		SELF.LICENSE_NBR			:= StringLib.StringToUpperCase(TRIM(L.SLNUM,LEFT,RIGHT));
		SELF.LICENSE_STATE		:= src_st;
		SELF.RAW_LICENSE_STATUS	:= TRIM(StringLib.StringToUpperCase(L.LIC_STAT),LEFT,RIGHT);
		SELF.STD_LICENSE_STATUS	:= ' ';
		
	//Default issue date is 17530101
 		SELF.CURR_ISSUE_DTE		:= '17530101';

		// SELF.ORIG_ISSUE_DTE		:= IF(L.ISSUEDT = ' ','17530101',
																// Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.ISSUEDT));
																
		tmpOrigIssueDate 						:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.ISSUEDT);
		SELF.ORIG_ISSUE_DTE					:= IF(tmpOrigIssueDate < '20000101','20' + tmpOrigIssueDate[3..],tmpOrigIssueDate);
																
		tmpExpireDate 						:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.EXPDT);
		SELF.EXPIRE_DTE 					:= IF(tmpExpireDate < '20000101','20' + tmpExpireDate[3..],tmpExpireDate);

		// SELF.EXPIRE_DTE					:= IF(L.EXPDT = ' ','17530101',
																// Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.EXPDT));
																
		SELF.NAME_ORG_ORIG		:= StringLib.StringToUpperCase(TRIM(L.ORG_NAME,LEFT,RIGHT));
		SELF.NAME_FORMAT			:= IF(ClnNameFull<>'','L','F');

		SELF.NAME_DBA_ORIG		:= IF(SELF.NAME_DBA != ' ',SELF.NAME_DBA,' ');
 		SELF.NAME_MARI_ORG		:= IF(getCorpOnly != ' ',
   																//getCorpOnly, Need to clean up the ending / 1/28/13 Cathy Tio
   																TRIM(REGEXREPLACE('/$',getCorpOnly,''),LEFT,RIGHT),
   																' ');

		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',SELF.NAME_DBA_ORIG,' ');
		
		SELF.ADDR_CITY_1		  := StringLib.StringToUpperCase(TRIM(L.CITY_1,LEFT,RIGHT));
		SELF.ADDR_STATE_1			:= StringLib.StringToUpperCase(TRIM(L.STATE_1,LEFT,RIGHT));
		SELF.ADDR_ZIP5_1		  := IF(LENGTH(TRIM(L.ZIP))=4,'0'+TRIM(L.ZIP,LEFT,RIGHT)[1..5],TRIM(L.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,LEFT,RIGHT)[7..11],
																 TRIM(L.ZIP,LEFT,RIGHT)[6..10]);
		// SELF.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT));

		SELF.ADDR_BUS_IND			:= IF(TRIM(L.CITY_1+L.STATE_1+L.ZIP)<>'','B','');
		SELF.ADDR_CNTRY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTRY_1,LEFT,RIGHT));
		SELF.OOC_IND_1				:= IF(TRIM(SELF.ADDR_CNTRY_1,LEFT,RIGHT)='UNITED STATES',0,1);

		//Street address left out of cmc_slpk because state only provides city/state
		SELF.cmc_slpk  				:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+IF(SELF.std_license_type<>'',TRIM(SELF.std_license_type,LEFT,RIGHT),TRIM(SELF.raw_license_type,LEFT,RIGHT))
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
												 						+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
												 						+TRIM(SELF.ADDR_CITY_1,LEFT,RIGHT)
												 						+TRIM(SELF.ADDR_STATE_1,LEFT,RIGHT)
												 						+TRIM(SELF.ADDR_ZIP5_1,LEFT,RIGHT));
											 
		SELF		 							:= [];		   		   
	END;

	ds_map := project(ValidDEFile, transformToCommon(LEFT));

	// populate std_license_status field via translation on raw_license_status field
	Prof_License_Mari.layout_base_in trans_lic_status(ds_map L, cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans 			:= JOIN(ds_map, cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map L, cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_TYPE := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lictype_trans 		:= JOIN(ds_map_stat_trans, cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND 
																StringLib.StringToUpperCase(TRIM(LEFT.raw_license_type[1..40],LEFT,RIGHT))=TRIM(RIGHT.fld_value[1..40],LEFT,RIGHT),
																trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_prof_cd(ds_map_lictype_trans L, cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := IF(L.STD_LICENSE_TYPE = 'MOP','RLE',R.DM_VALUE1);
		SELF := L;
	END;

	ds_map_lic_trans 				:= JOIN(ds_map_lictype_trans, cmvtranslation,
																	LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																	trans_prof_cd(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	remove_logical 					:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	d_final := OUTPUT(ds_map_lic_trans, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);
		

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans);
	
	move_to_used := PARALLEL(
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 're', 'using', 'used')
														);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oREFile, oApprFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

