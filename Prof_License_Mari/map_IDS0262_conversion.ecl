//************************************************************************************************************* */	
//  The purpose of this development is take ID Mortgage Arppraisers raw file and convert it to a 
//  common professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_IDS0262_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'IDS0262';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move input file from sprayed to using
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'sprayed', 'using');

	//ID input file
	ds_ID_appraiser	:= Prof_License_Mari.file_IDS0262.apr;
	oApr						:= OUTPUT(ds_ID_appraiser);
	
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Pattern for DBA
	DBApattern	:= '^(.*)( DBA |D/B/A |C/O |D B A |AKA | DBA| \\(DBA\\))(.*)';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';

  MD_Ind := ['AT','CGA','CRA','LRA','TCGA','TCRA'];
  GR_Ind := ['AMC', 'AMCF'];	
	
	//Remove bad records before processing
	ValidAppraiser	:= ds_ID_appraiser(TRIM(SORT_NAME) != ' ' AND LIC_NO!= ' '
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(SORT_NAME)));

	//ID Mortgage Brokers layout to Common
	Prof_License_Mari.layout_base_in	transformToCommon(Prof_License_Mari.layout_IDS0262 L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';
		
		SELF.LICENSE_NBR		:= StringLib.StringToUpperCase(TRIM(L.LIC_NO,LEFT,RIGHT));
		SELF.LICENSE_STATE	:= 'ID';
		SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(L.LIC_DESC);
		SELF.STD_LICENSE_TYPE	:= MAP(StringLib.StringFind(TRIM(L.LIC_DESC),'APPRAISER TRAINEE',1)= 1 => 'AT',
														     StringLib.StringFind(TRIM(L.LIC_DESC),'CERTIFIED GENERAL APPRAISER',1)= 1 => 'CGA',
														     StringLib.StringFind(TRIM(L.LIC_DESC),'CERTIFIED RESIDENTIAL APPRAISER',1)= 1 => 'CRA',
														     StringLib.StringFind(TRIM(L.LIC_DESC),'LICENSED RESIDENTIAL APPRAISER' ,1)= 1 => 'LRA',
														     StringLib.StringFind(TRIM(L.LIC_DESC),'TEMPORARY CERTIFIED GENERAL APPRAISER',1)= 1 => 'TCGA',
														     StringLib.StringFind(TRIM(L.LIC_DESC),'TEMPORARY CERTIFIED RESIDENTIAL APPRAISER',1)= 1 => 'TCRA',
														     StringLib.StringFind(TRIM(L.LIC_DESC),'APPRAISAL MANAGEMENT COMPANY',1)= 1 => 'AMC',
																 StringLib.StringFind(TRIM(L.LIC_DESC),'FEDERALLY REGULATED APPRAISAL MANAGEMENT COMPANY',1)= 1 => 'AMCF',
														     ' '); 	
		SELF.TYPE_CD					:= IF(SELF.STD_LICENSE_TYPE in GR_Ind, 'GR',
		                           IF(SELF.STD_LICENSE_TYPE in MD_Ind, 'MD',
															    ''));

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		//Parse sortname field
		cln_sortname		:= Prof_License_Mari.mod_clean_name_addr.cleanLFMName(L.SORT_NAME); //parse full name in L,FM format
		officenameOnly	:= IF(REGEXFIND(DBApattern, L.BUS_NAME), Prof_License_Mari.mod_clean_name_addr.GetCorpName(L.BUS_NAME)
														,ut.CleanSpacesAndUpper(L.BUS_NAME));		 //get names without DBA names
														
		std_officename	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(officenameOnly);
		
		SELF.NAME_ORG_PREFX	:= IF(SELF.type_cd = 'GR',Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(officenameOnly),'');
		SELF.NAME_ORG		    := IF(SELF.type_cd = 'MD',StringLib.StringCleanSpaces(cln_sortname[46..65]+' '+cln_sortname[6..25]),
		                          IF(SELF.type_cd = 'GR',Prof_License_Mari.mod_clean_name_addr.cleanFName(std_officename)
															   ,''));
  	tmpNameOrgSufx		  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(officenameOnly);
		SELF.NAME_ORG_SUFX 	:= IF(SELF.type_cd = 'GR',ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, '')),'');
				
		//get names with DBA prefix
		temp_dba_name				:= IF(REGEXFIND(DBApattern, L.BUS_NAME),Prof_License_Mari.mod_clean_name_addr.GetDBAName(L.BUS_NAME),' ');
		clnDBA_name					:= regexreplace(DBApattern,StringLib.StringToUpperCase(temp_dba_name),'');
		tmpNameDBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
		tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		SELF.NAME_DBA				:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG				:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		
		//clean Individual names
		SELF.NAME_FIRST			:= ut.CleanSpacesAndUpper(cln_sortname[6..25]);
		SELF.NAME_MID				:= ut.CleanSpacesAndUpper(cln_sortname[26..45]);
		SELF.NAME_LAST			:= ut.CleanSpacesAndUpper(cln_sortname[46..65]);	
		SELF.NAME_SUFX			:= ut.CleanSpacesAndUpper(cln_sortname[66..70]);
	

		//Clean dates from M/D/YYYY format to YYYYMMDD
		// Use default date of 17530101 for blank dates
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(L.ISSUED<>' ',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.ISSUED),
																'17530101');
		SELF.EXPIRE_DTE			  := IF(L.EXPIRES<>' ',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.EXPIRES),
																'17530101');

		SELF.RAW_LICENSE_STATUS := 	ut.CleanSpacesAndUpper(L.STATUS);
	
		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= IF(TRIM(L.SORT_NAME,LEFT,RIGHT) != ' ',StringLib.StringToUpperCase(TRIM(L.SORT_NAME,LEFT,RIGHT)),' ');
		SELF.NAME_FORMAT			:= 'L';
		SELF.NAME_MARI_ORG		:= std_officename;
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',clnDBA_name,' ');
		clnPhone							:= StringLib.StringCleanSpaces(L.PHONE);
		SELF.PHN_MARI_1				:= L.PHONE;

		RemovePattern         := '(^C/O | INC$| LLC$)';
		TrimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS1);
		TrimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS2); 
		TrimCity              := ut.CleanSpacesAndUpper(L.CITY); 
		TrimState             := ut.CleanSpacesAndUpper(L.STATE); 
		tmpZip	              := MAP(LENGTH(TRIM(L.POSTALCODE))=3 => '00'+TRIM(L.POSTALCODE),
		                             LENGTH(TRIM(L.POSTALCODE))=4 => '0'+TRIM(L.POSTALCODE),
						                     TRIM(L.POSTALCODE));
		//	Indicates whether address_1 is an address or business name	
		IsAddr								:= IF(REGEXFIND('^[0-9]+',L.ADDRESS1)
														    OR REGEXFIND('P[\\.]?[ ]?O[\\.]? BOX', L.ADDRESS1)
														    OR REGEXFIND('PO ', L.ADDRESS1)
														    OR REGEXFIND('BOX ', L.ADDRESS1)
														    OR REGEXFIND('( REGION | RD | AIRPORT | HWY |PMB | BLD | BLVD$| STREET$)', TRIM(L.ADDRESS1,LEFT,RIGHT)),
														    TRUE,
														    FALSE);
		tmpOfficeName					:= MAP(TRIM(L.ADDRESS2) != ' ' AND IsAddr != true => L.ADDRESS1,
														     REGEXFIND('(^C/O | INC$| LLC$)',TRIM(L.ADDRESS1)) => L.ADDRESS1,
																 REGEXFIND('(^C/O | INC$| LLC$)',TRIM(L.ADDRESS2)) => L.ADDRESS2,
		                             ''); //Get contact name from address

		prepAddr_Line_1				:= TrimAddress1 + ' ' + TrimAddress2;
		prepAddr_Line_1_1			:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddr_Line_1, RemovePattern);
		prepAddr_Line_2				:= TrimCity + ' ' + TrimState + ' ' + TmpZip;
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1_1,prepAddr_Line_2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1 			:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN AND C/O in address

		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != '' AND tmpADDR_ADDR2_1 != '' => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''  => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact!='' => '',
																 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR2_1)=TRIM(tmpADDR_ADDR1_1) => '',
																 StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 

															 
																 
		// SELF.ADDR_ADDR1_1			:= IF(tmpOfficeName = ' ',StringLib.StringToUpperCase(TRIM(L.ADDRESS1,LEFT,RIGHT)),
																// StringLib.StringToUpperCase(TRIM(L.ADDRESS2,LEFT,RIGHT)));
		// SELF.ADDR_ADDR2_1			:= IF(tmpOfficeName != ' ',' ',StringLib.StringToUpperCase(TRIM(L.ADDRESS2,LEFT,RIGHT)));
		
		SELF.ADDR_CITY_1		  := StringLib.StringToUpperCase(TRIM(L.CITY));
		SELF.ADDR_STATE_1			:= StringLib.StringToUpperCase(TRIM(L.STATE));

		SELF.ADDR_ZIP5_1		  := tmpZip[1..5];
		SELF.ADDR_ZIP4_1		  := IF(StringLib.StringFind(tmpZip,'-',1)>0,tmpZip[7..11],
				                       tmpZip[6..10]);
		SELF.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT));
		strippedClnPhone			:= StringLib.StringFilter(clnPhone,'0123456789');
		SELF.PHN_PHONE_1			:= IF(TRIM(L.PHONE,LEFT,RIGHT) != ' ' AND NOT REGEXFIND('(^[0]+$)',strippedClnPhone),strippedClnPhone,' ');
	
		//If name is in address1 field, move to office_name else use bus_name
		clnOfficeName					:= IF(REGEXFIND('C/O ', tmpOfficeName), REGEXREPLACE('C/O ', tmpOfficeName,''), tmpOfficeName);
		SELF.NAME_OFFICE			:= MAP(TRIM(std_officename) != '' AND SELF.TYPE_CD = 'MD'
																		=> Prof_License_Mari.mod_clean_name_addr.strippunctName(std_officename),
																TRIM(std_officename)='' AND clnOfficeName!=' '
																    => StringLib.StringToUpperCase(TRIM(clnOfficeName,LEFT,RIGHT)),
																'');
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ','GR',' ');
		
		SELF.ORIGIN_CD				:= MAP(StringLib.StringFind(StringLib.StringToUpperCase(TRIM(L.LICENSED_BY,LEFT,RIGHT)),'APPLICATN',1)= 1 => 'O',
																StringLib.StringFind(StringLib.StringToUpperCase(TRIM(L.LICENSED_BY,LEFT,RIGHT)),'ENDORSEMT',1)= 1 => 'D',
																StringLib.StringFind(StringLib.StringToUpperCase(TRIM(L.LICENSED_BY,LEFT,RIGHT)),'EXAM',1)= 1 => 'E',
																StringLib.StringFind(StringLib.StringToUpperCase(TRIM(L.LICENSED_BY,LEFT,RIGHT)),'RCPRCTY',1)= 1 => 'R',
																StringLib.StringFind(StringLib.StringToUpperCase(TRIM(L.LICENSED_BY,LEFT,RIGHT)),'EXAMUPGRD',1)= 1 => 'E',' ');

		//fields used to create mltrec_key are :
		//license number
		//office license number
		//license type
		//source update
		//raw name including DBA's
		//raw address
		SELF.MLTRECKEY				:= 0; //this dataset doesn't have multiple DBA's.
	
		//fields used to create cmc_slpk unique key are :
		//license number
		//office license number
		//license type
		//source update
		//standard name_org w/o DBA
		//raw address
		//Use hash64 to avoid dup keys
		SELF.CMC_SLPK     		:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																		+TRIM(L.ADDRESS1,LEFT,RIGHT)
																		+TRIM(L.ADDRESS2,LEFT,RIGHT)
																		+TRIM(L.CITY,LEFT,RIGHT)
																		+TRIM(L.STATE,LEFT,RIGHT)
																		+TRIM(L.POSTALCODE,LEFT,RIGHT));
	
		SELF := [];
	END;

	ds_map := PROJECT(ValidAppraiser, transformToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, Cmvtranslation,
													LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
													trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
 
	// look up standard license status
	Prof_License_Mari.layout_base_in trans_status_trans(ds_map_lic_trans L, Cmvtranslation R) := transform
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  
	d_final := output(ds_map_status_trans, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
		
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_status_trans);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used');
	
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	

	RETURN SEQUENTIAL(move_to_using, oApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;