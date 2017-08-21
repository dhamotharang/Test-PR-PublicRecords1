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
	Prof_License_Mari.layouts.base	transformToCommon(Prof_License_Mari.layout_DES0846 L) := TRANSFORM
	
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
		TrimLicenseType				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.LIC);
		SELF.RAW_LICENSE_TYPE	:= TrimLicenseType;
 		SELF.STD_LICENSE_TYPE	:= map(StringLib.StringFind(TrimLicenseType,'CERTIFIED GENERAL REAL PROPERTY APPRAISE',1)= 1 => 'CGRPA',
   														StringLib.StringFind(TrimLicenseType,'CERTIFIED RESIDENTIAL REAL PROPERTY APPR',1)= 1 => 'CGRPA',
   														StringLib.StringFind(TrimLicenseType,'LICENSED REAL PROPERTY APPRAISER',1)= 1 => 'LRPA',
   														StringLib.StringFind(TrimLicenseType,'NONRESIDENT BROKER',1)= 1 => 'NB',
   														StringLib.StringFind(TrimLicenseType,'NONRESIDENT SALESPERSON',1)= 1 => 'NS',
   														StringLib.StringFind(TrimLicenseType,'RESIDENT BROKER',1)= 1 => 'RB',
   														/*In new input files, all brokers have license numbers starting with RB 1/25/13*/
   														StringLib.StringFind(TrimLicenseType,'BROKER',1)= 1 => 'RB',
   														// /*This is new in new input files 1/25/13*/
   														StringLib.StringFind(TrimLicenseType,'ASSOCIATE BROKER',1)= 1 => 'RA',
   														StringLib.StringFind(TrimLicenseType,'RESIDENT SALESPERSON',1)= 1 => 'RS',
   														/*In new input files, all salespersons have license numbers starting with RS 1/25/13*/
   														StringLib.StringFind(TrimLicenseType,'SALESPERSON',1)= 1 => 'RS',
   														StringLib.StringFind(TrimLicenseType,'APPRAISER TRAINEE',1)= 1 => 'AT',
   														StringLib.StringFind(TrimLicenseType,'BRANCH OFFICE PERMIT',1)= 1 => 'BOP',
   														StringLib.StringFind(TrimLicenseType,'MAIN OFFICE PERMIT',1)= 1 => 'MOP',
   														StringLib.StringFind(TrimLicenseType,'INACTIVE NONRESIDENT BROKER',1)= 1 => 'INB',
   														StringLib.StringFind(TrimLicenseType,'INACTIVE NONRESIDENT SALESPERSON',1)= 1 => 'INS',
   														StringLib.StringFind(TrimLicenseType,'INACTIVE RESIDENT BROKER',1)= 1 => 'IRB',
   														StringLib.StringFind(TrimLicenseType,'INACTIVE RESIDENT SALESPERSON',1)= 1 => 'IRS',
   														StringLib.StringFind(TrimLicenseType,'TEMPORARY PRACTICE PERMIT',1)= 1 => 'TPP',
   														/*New type since 20130702*/
   														StringLib.StringFind(TrimLicenseType,'CERTIFIED ASSESSOR',1)= 1 => 'CA',
   														/*New type  20140811*/
    													StringLib.StringFind(TrimLicenseType,'APPRAISAL MANAGEMENT COMPANY',1)= 1 => 'AMC',
  														' ');

														
		SELF.TYPE_CD					:= IF(SELF.STD_LICENSE_TYPE IN ['BOP','MOP','AMC'],'GR','MD');
		
		//Clean and parse Org_name
		ClnNameFull						:= IF(TrimLicenseType = 'BRANCH OFFICE PERMIT' OR TrimLicenseType = 'MAIN OFFICE PERMIT',
														' ',Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TRIM(L.ORG_NAME,LEFT,RIGHT)));
		trim_org_name					:= if(ClnNameFull = ' ',
														StringLib.StringToUpperCase(TRIM(L.ORG_NAME,left,right)),' ');
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(trim_org_name); //business name with standard corp abbr.
		getCorpOnly						:= IF(REGEXFIND(DBApattern, tmpNameOrg), Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
														,tmpNameOrg);		 //get names without DBA names
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly);
		//Need to remove leading and trailing /
		name_org_prep					:= IF(ClnNameFull = ' ',Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO'))
															,StringLib.StringToUpperCase(TRIM(ClnNameFull[46..65],LEFT,RIGHT)+' '+TRIM(ClnNameFull[6..25],LEFT,RIGHT)));  //Without punct. and Sufx removed
		self.NAME_ORG					:= TRIM(REGEXREPLACE('/$',name_org_prep,''),LEFT,RIGHT);
		//Without punct. and Sufx removed
		self.NAME_ORG_SUFX 		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		
		//get names with DBA prefix
		temp_dba_name					:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOrg);
		clnDBA_name						:= regexreplace(DBApattern,StringLib.StringToUpperCase(temp_dba_name),'');
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(clnDBA_name);
		self.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(clnDBA_name); //split corporation prefix from name
		self.NAME_DBA					:= REGEXREPLACE(' COMPANY',clnDBA_name,' CO');
		self.NAME_DBA_SUFX		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		self.DBA_FLAG					:= IF(trim(self.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		
		self.NAME_FIRST				:= if(StringLib.StringToUpperCase(ClnNameFull[6..25]) != ' ',
																StringLib.StringToUpperCase(ClnNameFull[6..25]),
																//'');  //for build 20121207 and before
																Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.FIRST_NAME));
		self.NAME_MID					:= if(StringLib.StringToUpperCase(ClnNameFull[26..45]) != ' ',
																StringLib.StringToUpperCase(ClnNameFull[26..45]),
																//'');  //for build 20121207 and before
																Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.MIDDLE_NAME));
		self.NAME_LAST				:= if(StringLib.StringToUpperCase(ClnNameFull[46..65]) != ' ' AND
																LENGTH(TRIM(ClnNameFull[46..65]))<>1,
																StringLib.StringToUpperCase(ClnNameFull[46..65]),
																//'');  //for build 20121207 and before
																Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.LAST_NAME));
		self.NAME_SUFX				:= StringLib.StringToUpperCase(ClnNameFull[66..70]);
		
		self.LICENSE_NBR			:= StringLib.StringToUpperCase(TRIM(L.SLNUM,LEFT,RIGHT));
		self.LICENSE_STATE		:= src_st;
		self.RAW_LICENSE_STATUS	:= TRIM(StringLib.StringToUpperCase(L.LIC_STAT),LEFT,RIGHT);
		self.STD_LICENSE_STATUS	:= ' ';
		
	//Default issue date is 17530101
 		SELF.CURR_ISSUE_DTE		:= '17530101';

		SELF.ORIG_ISSUE_DTE		:= IF(L.ISSUEDT = ' ','17530101',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.ISSUEDT));

		SELF.EXPIRE_DTE					:= IF(L.EXPDT = ' ','17530101',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.EXPDT));
		self.NAME_ORG_ORIG		:= StringLib.StringToUpperCase(TRIM(L.ORG_NAME,LEFT,RIGHT));
		SELF.NAME_FORMAT			:= IF(ClnNameFull<>'','L','F');

		self.NAME_DBA_ORIG		:= IF(self.NAME_DBA != ' ',self.NAME_DBA,' ');
 		SELF.NAME_MARI_ORG		:= IF(getCorpOnly != ' ',
   																//getCorpOnly, Need to clean up the ending / 1/28/13 Cathy Tio
   																TRIM(REGEXREPLACE('/$',getCorpOnly,''),LEFT,RIGHT),
   																' ');

		self.NAME_MARI_DBA	  := IF(self.NAME_DBA != ' ',self.NAME_DBA_ORIG,' ');
		
		self.ADDR_CITY_1		  := StringLib.StringToUpperCase(TRIM(L.CITY_1,LEFT,RIGHT));
		self.ADDR_STATE_1			:= StringLib.StringToUpperCase(TRIM(L.STATE_1,LEFT,RIGHT));
		self.ADDR_ZIP5_1		  := IF(length(TRIM(L.ZIP))=4,'0'+TRIM(L.ZIP,left,right)[1..5],TRIM(L.ZIP,left,right)[1..5]);
		self.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,left,right)[7..11],
																 TRIM(L.ZIP,left,right)[6..10]);
		self.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT));

		self.ADDR_BUS_IND			:= IF(TRIM(L.CITY_1+L.STATE_1+L.ZIP)<>'','B','');
		SELF.ADDR_CNTRY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTRY_1,LEFT,RIGHT));
		SELF.OOC_IND_1				:= IF(TRIM(SELF.ADDR_CNTRY_1,LEFT,RIGHT)='UNITED STATES',0,1);

		//Street address left out of cmc_slpk because state only provides city/state
		self.cmc_slpk  				:= hash64(trim(self.license_nbr,left,right) 
																		+IF(self.std_license_type<>'',trim(self.std_license_type,left,right),trim(self.raw_license_type,left,right))
																		+trim(self.std_source_upd,left,right)
												 						+trim(self.NAME_ORG_ORIG,left,right)
												 						+trim(self.ADDR_CITY_1,left,right)
												 						+trim(self.ADDR_STATE_1,left,right)
												 						+trim(self.ADDR_ZIP5_1,left,right));
											 
		SELF		 							:= [];		   		   
	END;

	ds_map := project(ValidDEFile, transformToCommon(LEFT));

	// populate std_license_status field via translation on raw_license_status field
	Prof_License_Mari.layouts.base trans_lic_status(ds_map L, cmvtranslation R) := transform
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans 			:= JOIN(ds_map, cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, cmvtranslation R) := transform
		SELF.STD_LICENSE_TYPE := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lictype_trans 		:= JOIN(ds_map_stat_trans, cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND 
																StringLib.StringToUpperCase(TRIM(LEFT.raw_license_type[1..40],LEFT,RIGHT))=TRIM(RIGHT.fld_value[1..40],LEFT,RIGHT),
																trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_prof_cd(ds_map_lictype_trans L, cmvtranslation R) := transform
		SELF.STD_PROF_CD := IF(L.STD_LICENSE_TYPE = 'MOP','RLE',R.DM_VALUE1);
		SELF := L;
	END;

	ds_map_lic_trans 				:= JOIN(ds_map_lictype_trans, cmvtranslation,
																	LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																	trans_prof_cd(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	d_final := output(ds_map_lic_trans, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);
		
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans);
	
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 're', 'using', 'used')
														);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oREFile, oApprFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

