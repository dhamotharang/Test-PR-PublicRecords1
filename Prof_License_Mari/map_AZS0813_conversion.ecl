//************************************************************************************************************* */	
//  The purpose of this development is take AZ Real Estate Company and Broker raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	

import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_AZS0813_conversion(string pVersion) := function

	code 								:= 'AZS0813';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								

	//Move file(s) from ::sprayed:: to ::using::
	move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'entities', 'sprayed', 'using'),
												 Prof_License_Mari.func_move_file.MyMoveFile(code, 'individuals', 'sprayed', 'using')
												 );

	//IN_Lic_types := ['Q','A','S','T','Y','Z'];

	//AZ input files
	ds_AZ_Company	:= Prof_License_Mari.files_AZS0813.RealEstate_company;
	ds_AZ_Broker	:= Prof_License_Mari.files_AZS0813.RealEstate_broker;
	oCompany			:= OUTPUT(ds_AZ_Company);
	oBroker				:= OUTPUT(ds_AZ_Broker);
	
	//Remove bad records before processing
	ValidCompFile	:= ds_AZ_Company(LEGAL_NAME <> '' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LEGAL_NAME)));
	ValidBrkrFile	:= ds_AZ_Broker(TRIM(LAST_NAME,LEFT,RIGHT)+TRIM(FIRST_NAME,LEFT,RIGHT) <> '' 
										AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME))
										AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME)));

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O )(.*)';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//AZ Real Estate Company layout to Common
	Prof_License_Mari.layout_base_in	transformCompToCommon(Prof_License_Mari.layout_AZS0813.entity L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.STAMP_DTE				:= pVersion; 					 	 //yyyymmdd
    SELF.LAST_UPD_DTE			:= pVersion;
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';
		
		//Added based on the implementation from AKS0376
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE		:= thorlib.wuid()[2..9];

		//12/11/12 Cathy Tio - modified based on Terri's comments
		//remove double quote if it exists
		// tmpLastUpdDte			:= Prof_License_Mari.mod_clean_name_addr.stripPunctName(trim(L.LAST_MODIFIED));
		//prep_last_upd_dte := IF(tmpLastUpdDte<>'',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(tmpLastUpdDte),'17530101');
		// prep_last_upd_dte := IF(LENGTH(tmpLastUpdDte)=1,'17530101',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(tmpLastUpdDte));
		// SELF.LAST_UPD_DTE := prep_last_upd_dte;		
		

		self.TYPE_CD			:= 'GR';
		tmpNameOrg				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.LEGAL_NAME); //business name with standard corp abbr.
		clnNameOrg				:= StringLib.StringFindReplace(tmpNameOrg, '/',' ');
		tmpNameOrgSufx		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);
		self.NAME_ORG			:= IF(REGEXFIND(IPpattern,tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',clnNameOrg,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',clnNameOrg,' CO'))); //Without punct. and Sufx removed
		
		self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
		self.NAME_ORG_SUFX 	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		
		tmpNameDBA				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA); //business name with standard corp abbr.
		clnNameDBA				:= StringLib.StringFindReplace(tmpNameDBA, '/',' ');
		tmpNameDBASufx		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		self.NAME_DBA			:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',clnNameDBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',clnNameDBA,' CO')));
		self.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		self.DBA_FLAG				:= If(trim(self.NAME_DBA,left,right) != '',1,0); //1=TRUE, 0=FALSE
		self.LICENSE_NBR		:= StringLib.StringToUpperCase(TRIM(L.LIC_NUMBER,LEFT,RIGHT));
	
 	 //Assign designated broker license number to office license number 7/18/13
		//Keep this logic to be consistant w/ Reston and this field is also used for linking CO w/ BR
 		self.OFF_LICENSE_NBR	:= IF(TRIM(L.BROKER_LIC_NUMBER,LEFT,RIGHT)<>'',
   		                            StringLib.StringToUpperCase(TRIM(L.BROKER_LIC_NUMBER,LEFT,RIGHT)),
   																'');
		SELF.OFF_LICENSE_NBR_TYPE := IF(SELF.OFF_LICENSE_NBR<>'','DESIGNATED BROKER','');
   	// SELF.PROVNOTE_3				:= IF(TRIM(L.BROKER_LIC_NUMBER,LEFT,RIGHT)<>'',
   		                            // '{OFFICE LICENSE NBR ASSIGNED}',
   																// '');
	
		self.LICENSE_STATE		:= src_st;
		temp_raw_license_type	:= TRIM(StringLib.StringToUpperCase(L.LIC_CATEGORY),LEFT,RIGHT)
																+' '+ TRIM(StringLib.StringToUpperCase(L.LIC_TYPE),LEFT,RIGHT); 
		self.RAW_LICENSE_TYPE	:= REGEXREPLACE(',',temp_raw_license_type,'');
		self.STD_LICENSE_TYPE	:= map(StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE ASSOCIATE BROKER',1)= 1 => 'RAB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE ASSOCIATE BROKER PC',1)= 1 => 'RABPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE ASSOCIATE BROKER PLC',1)= 1 => 'RABPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH CORPORATION',1)= 1 => 'RBC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH LIABILITY',1)= 1 => 'RBL',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH PARTNERSHIP',1)= 1 => 'RBP',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH SELF EMPLOYED',1)= 1 => 'RBSE',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER',1)= 1 => 'RB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER MANAGER SALESPERSON PLC',1)= 1 => 'RBMSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER SALESPERSON',1)= 1 => 'RBS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER SALESPERSON PC',1)= 1 => 'RBSPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE CORPORATION',1)= 1 => 'RCC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE DESIGNATED BROKER',1)= 1 => 'RDB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE DESIGNATED BROKER PC',1)= 1 => 'RDBPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE DESIGNATED BROKER PLC',1)= 1 => 'RDBPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE LIMITED LIABILITY',1)= 1 => 'RLLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER ASSOC BROKER PLC',1)= 1 => 'RMABPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER ASSOCIATE BROKER',1)= 1 => 'RMAB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER ASSOCIATE BROKER PC',1)= 1 => 'RMABPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER SALESPERSON',1)= 1 => 'RMS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER SALESPERSON PC',1)= 1 => 'RMSPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER SALESPERSON PLC',1)= 1 => 'RMSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE PARTNERSHIP',1)= 1 => 'RPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SALESPERSON',1)= 1 => 'RS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SALESPERSON PC',1)= 1 => 'RSPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SALESPERSON PLC',1)= 1 => 'RSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SELF EMPLOYED BROKER',1)= 1 => 'RSEBC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'TEMPORARY REAL ESTATE SELF EMPLOYED BROKER',1)= 1 => 'TRSEBC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SELF EMPLOYED BROKER PC',1)= 1 => 'RSEBPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SELF EMPLOYED BROKER PLC',1)= 1 => 'RSEBPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER MANAGER SALESPERSON',1)= 1 => 'RBMS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER SALESPERSON PLC',1)= 1 => 'RBSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE TEMPORARY BROKER',1)= 1 => 'RTB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE UNLICENSED',1)= 1 => 'RU',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'CEMETARY DESIGNATED BROKER',1)= 1 => 'CDB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'CEMETARY CANDIDATE',1)= 1 => 'CCB','RB');
		self.RAW_LICENSE_STATUS	:= TRIM(StringLib.StringToUpperCase(L.LIC_STATUS),LEFT,RIGHT);
		self.STD_LICENSE_STATUS	:= ' ';
		//Default issue date is 17530101
		self.CURR_ISSUE_DTE		:= '17530101';
		//12/11/12 Cathy Tio - modified based on Terri's comments												
		prep_orig_issue_dte 	:= Prof_License_Mari.DateCleaner.norm_date2(trim(L.ORIGINAL_DATE));
		self.ORIG_ISSUE_DTE	  := IF(prep_orig_issue_dte = '', '17530101',ut.date_slashed_MMDDYYYY_to_YYYYMMDD(prep_orig_issue_dte));		

		//12/11/12 Cathy Tio - modified based on Terri's comments												
		prep_expire_dte 			:= Prof_License_Mari.DateCleaner.norm_date2(trim(L.EXPIRE_DATE));
		cleanExpireDte				:= IF(prep_expire_dte=' ', 
																'17530101',
																ut.date_slashed_MMDDYYYY_to_YYYYMMDD(prep_expire_dte));
		self.EXPIRE_DTE			  := IF(cleanExpireDte='', '17530101', cleanExpireDte);
														
		self.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1,LEFT,RIGHT) != ' ','B',' ');
		self.NAME_ORG_ORIG		:= TRIM(StringLib.StringToUpperCase(L.LEGAL_NAME));
		//Populate NAME_FORMAT BUG # 124107 - name_format specifies the format of name_org_orig
		SELF.NAME_FORMAT			:= 'F';

		self.NAME_DBA_ORIG		:= IF(TRIM(L.DBA,LEFT,RIGHT) != ' ',TRIM(StringLib.StringToUpperCase(L.DBA)), ' ');
		self.NAME_MARI_ORG		:= IF(self.type_cd='GR',self.NAME_ORG_ORIG,' ');
		self.NAME_MARI_DBA	  := IF(self.type_cd='GR',self.NAME_DBA_ORIG,' ');
		self.PHN_MARI_1				:= IF(TRIM(L.PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.PHONE,'0123456789'),' ');
		self.PHN_MARI_FAX_1		:= IF(TRIM(L.FAX,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.FAX,'0123456789'),' ');
	
		//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$' +
					 ')';
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|' +
					 'LINE 1|LINE 2|LEGAL DEPT\\.|SALES OFFICE|BUSINESS OFFICE' +
					 ')';

		trimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS1);
	  trimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS2);
  		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);
		//Store the names in address field in provnote_2
		SELF.PROVNOTE_2				:= MAP(tmpNameContact1<>''  AND NOT REGEXFIND('SALES OFFICE',tmpNameContact1)
		                               => 'CONTACT INFO FROM ADDR:' + REGEXREPLACE('(^CO |^ATTN: )',tmpNameContact1,''),
		                             tmpNameContact2<>''  AND NOT REGEXFIND('SALES OFFICE',tmpNameContact2)
		                               => 'CONTACT INFO FROM ADDR:' + REGEXREPLACE('(^CO |^ATTN: )',tmpNameContact2,''),
																 '');
     
		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.CITY+' '+L.STATE +' '+L.ZIP); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(L.ZIP,left,right)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		//self.provnote_1 := trimAddress1+'|'+trimAddress2+'|'+trim(self.ADDR_ADDR1_1)+'|'+self.ADDR_ADDR2_1;

		self.PHN_PHONE_1			:= IF(TRIM(L.PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.PHONE,'0123456789'),' ');
		self.PHN_FAX_1				:= IF(TRIM(L.FAX,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.FAX,'0123456789'),' ');
		self.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT));

		//Store the names in address field in name_office
		SELF.NAME_OFFICE			:= MAP(REGEXFIND('ABBA REAL EATATE', L.ADDRESS1, NOCASE)
																		=> 'ABBA REAL EATATE',
																 REGEXFIND('LEGACY PARTNERS RESIDENTIAL INC.', L.ADDRESS1, NOCASE)
																		=> 'LEGACY PARTNERS RESIDENTIAL INC.',
																 //ut.CleanSpacesAndUpper(L.ADDRESS2)='C/O TERRAMOR PROPERTIES'
																 //		=> 'TERRAMOR PROPERTIES',
																 REGEXFIND('C/O TERRAMOR PROPERTIES', L.ADDRESS2, NOCASE)
																		=> 'TERRAMOR PROPERTIES',
																 REGEXFIND('C/O NATIONAL PROPERTY SERVICES', L.ADDRESS2, NOCASE)
																		=> 'NATIONAL PROPERTY SERVICES',
																'');

		SELF.NAME_CONTACT_FIRST := IF(REGEXFIND('C/O RICHARD BRANDT',L.ADDRESS2,NOCASE),'RICHARD','');
		SELF.NAME_CONTACT_LAST  := IF(REGEXFIND('C/O RICHARD BRANDT',L.ADDRESS2,NOCASE),'BRANDT','');
		
		//Expected codes [CO,BR,IN]
		self.AFFIL_TYPE_CD		:= IF(REGEXFIND('^BRANCH(.*)',StringLib.StringToUpperCase(L.LIC_TYPE)),'BR','CO');
		
		/* fields used to create mltrec_key unique record split dba key are :
		transformed license number
		standardized license type
		standardized source update
		raw name containing dba name(s)
		raw address
		*/
		self.MLTRECKEY				:= 0;

		/* fields used to create cmc_slpk unique key are :
		license number
		office license number
		license type
		source update
		name
		address
		dba */	
		//Use hash64 instead of hash32 to avoid dup keys
		//Use Name_org_orig instead of name_org
		self.CMC_SLPK         := HASH64(TRIM(self.license_nbr,left,right)
															+ TRIM(self.std_license_type,left,right)
															+ TRIM(self.std_source_upd,left,right)
															+ TRIM(L.ADDRESS1,left,right)
															+ TRIM(L.ADDRESS2,left,right)
															+ TRIM(self.addr_city_1,left,right)
															+ TRIM(self.addr_state_1,left,right)
															+ TRIM(self.addr_zip5_1,left,right)
															+ TRIM(self.NAME_ORG_ORIG,left,right));
		
		
		SELF.PROVNOTE_3			:= IF(L.LAST_MODIFIED <> '', 'LAST MODIFIED: ' + stringlib.stringfilterout(L.LAST_MODIFIED,'"'),'');
		SELF := [];
	END;

	ds_map_company := project(ValidCompFile, transformCompToCommon(left));

	// company only table for affiliation code
	company_only_lookup := ds_map_company(ds_map_company.affil_type_cd='CO');

	//perform lookup to join children to parents and assign cmc_slpk field value of parent to pcmc_slpk field of child  
	Prof_License_Mari.layout_base_in assign_pcmcslpk_co(ds_map_company L, company_only_lookup R) := transform


		self.pcmc_slpk := R.cmc_slpk;
		self.provnote_1 := map(L.provnote_1 != '' and self.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => trim(L.provnote_1,left,right)+' | '+'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
													 L.provnote_1 = '' and self.pcmc_slpk = 0 and L.affil_type_cd = 'BR' =>	'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
													 '');
		self := L;
	end;

	ds_map_affil_co := join(ds_map_company, company_only_lookup,
														trim(left.NAME_ORG,left,right)	= trim(right.NAME_ORG,left,right)
														and left.affil_type_cd != 'CO',
																		assign_pcmcslpk_co(left,right),left outer,lookup);	

	//AZ Real Estate brokers layout to Common
	Prof_License_Mari.layout_base_in	transformBrokerToCommon(Prof_License_Mari.layout_AZS0813.individual L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.STAMP_DTE				:= pVersion; 					 	 //yyyymmdd
    self.LAST_UPD_DTE			:= pVersion;
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';
		
		//Added based on the implementation from AKS0376
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE		:= thorlib.wuid()[2..9];
		self.TYPE_CD			:= 'MD';


		cln_lic_nbr				:= REGEXREPLACE('\\*',L.LIC_NUMBER,'');
		self.LICENSE_NBR	:= StringLib.StringToUpperCase(TRIM(cln_lic_nbr,LEFT,RIGHT));
		self.OFF_LICENSE_NBR	:= StringLib.StringToUpperCase(TRIM(L.EMPLOYER_LIC_NUMBER,LEFT,RIGHT));
		self.LICENSE_STATE		:= src_st;
		temp_raw_license_type	:= IF(TRIM(L.EMPLOYMENT_TYPE) = ' ',TRIM(StringLib.StringToUpperCase(L.LIC_CATEGORY),LEFT,RIGHT)
																+' '+ TRIM(StringLib.StringToUpperCase(L.LIC_TYPE),LEFT,RIGHT)
																,TRIM(StringLib.StringToUpperCase(L.LIC_CATEGORY),LEFT,RIGHT)+ ' '+TRIM(StringLib.StringToUpperCase(L.EMPLOYMENT_TYPE),LEFT,RIGHT)); 
		self.RAW_LICENSE_TYPE	:= REGEXREPLACE(',',temp_raw_license_type,'');
		self.STD_LICENSE_TYPE	:= map(StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE ASSOCIATE BROKER',1)= 1 => 'RAB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE ASSOCIATE BROKER PC',1)= 1 => 'RABPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE ASSOCIATE BROKER PLC',1)= 1 => 'RABPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH CORPORATION',1)= 1 => 'RBC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH LIABILITY',1)= 1 => 'RBL',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH PARTNERSHIP',1)= 1 => 'RBP',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BRANCH SELF EMPLOYED',1)= 1 => 'RBSE',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER',1)= 1 => 'RB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER MANAGER SALESPERSON PLC',1)= 1 => 'RBMSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER SALESPERSON',1)= 1 => 'RBS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER SALESPERSON PC',1)= 1 => 'RBSPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE CORPORATION',1)= 1 => 'RCC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE DESIGNATED BROKER',1)= 1 => 'RDB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE DESIGNATED BROKER PC',1)= 1 => 'RDBPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE DESIGNATED BROKER PLC',1)= 1 => 'RDBPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE LIMITED LIABILITY',1)= 1 => 'RLLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER ASSOC BROKER PLC',1)= 1 => 'RMABPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER ASSOCIATE BROKER',1)= 1 => 'RMAB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER ASSOCIATE BROKER PC',1)= 1 => 'RMABPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER SALESPERSON',1)= 1 => 'RMS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER SALESPERSON PC',1)= 1 => 'RMSPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE MANAGER SALESPERSON PLC',1)= 1 => 'RMSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE PARTNERSHIP',1)= 1 => 'RPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SALESPERSON',1)= 1 => 'RS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SALESPERSON PC',1)= 1 => 'RSPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SALESPERSON PLC',1)= 1 => 'RSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SELF EMPLOYED BROKER',1)= 1 => 'RSEB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'TEMPORARY REAL ESTATE SELF EMPLOYED BROKER',1)= 1 => 'TRSEBC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SELF EMPLOYED BROKER PC',1)= 1 => 'RSEBPC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE SELF EMPLOYED BROKER PLC',1)= 1 => 'RSEBPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER MANAGER SALESPERSON',1)= 1 => 'RBMS',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE BROKER SALESPERSON PLC',1)= 1 => 'RBSPLC',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE TEMPORARY BROKER',1)= 1 => 'RTB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'REAL ESTATE UNLICENSED',1)= 1 => 'RU',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'CEMETARY DESIGNATED BROKER',1)= 1 => 'CDB',
																	StringLib.StringFind(self.RAW_LICENSE_TYPE,'CEMETARY CANDIDATE',1)= 1 => 'CCB','RB');
		self.RAW_LICENSE_STATUS	:= TRIM(StringLib.StringToUpperCase(L.LIC_STATUS),LEFT,RIGHT);
		//Default issue date is 17530101
		//Change the following code per Terri's review comment
		self.CURR_ISSUE_DTE		:= '17530101';
		//12/11/12 Cathy Tio - modified based on Terri's comments												
		prep_orig_issue_dte 	:= Prof_License_Mari.DateCleaner.norm_date2(trim(L.ORIGINAL_DATE));
		self.ORIG_ISSUE_DTE		:= IF(prep_orig_issue_dte='  /  /  ',
															  '17530101',
																ut.date_slashed_MMDDYYYY_to_YYYYMMDD(prep_orig_issue_dte));		
																
		//12/11/12 Cathy Tio - modified based on Terri's comments												
		prep_expire_dte 			:= Prof_License_Mari.DateCleaner.norm_date2(trim(L.EXPIRE_DATE));
		cleanExpireDte				:= IF(prep_expire_dte = '  /  /  ', '17530101',ut.date_slashed_MMDDYYYY_to_YYYYMMDD(prep_expire_dte));		
		self.EXPIRE_DTE				:= IF(cleanExpireDte='', '17530101',cleanExpireDte);		
		
		//Name Parsing
		tempFirstName			:= TRIM(REGEXREPLACE('""',REGEXREPLACE('\'\'',L.FIRST_NAME,'"'),''));
		tempFNick 				:= Prof_License_Mari.fGetNickname(REGEXREPLACE('\'',tempFirstName,'"'),'nick');	
		stripNickFName		:= Prof_License_Mari.fGetNickname(REGEXREPLACE('\'',tempFirstName,'"'),'strip_nick');
		tempMidName				:= TRIM(REGEXREPLACE('""',L.MIDDLE_NAME,''));
		tempMNick 				:= Prof_License_Mari.fGetNickname(REGEXREPLACE('\'',tempMidName,'"'),'nick');	
		stripNickMName		:= Prof_License_Mari.fGetNickname(REGEXREPLACE('\'',tempMidName,'"'),'strip_nick');
		tempLName					:= StringLib.StringCleanSpaces(REGEXREPLACE('(""|,)',REGEXREPLACE('\'\'',L.LAST_NAME,'"'),' '));
		tempLastName			:= IF(REGEXFIND('(.*) (SR|JR|II|III|IV)(\\.?)$',tempLName,NOCASE),
														REGEXFIND('(.*) (SR|JR|II|III|IV)(\\.?)$',tempLName,1,NOCASE),
														tempLName);
		tempSufxName			:= IF(REGEXFIND('(.*) (SR|JR|II|III|IV)(\\.?)$',tempLName,NOCASE),
														REGEXFIND('(.*) (SR|JR|II|III|IV)(\\.?)$',tempLName,2,NOCASE),
														'');
							
 		self.NAME_FIRST		:= ut.CleanSpacesAndUpper(stripNickFName);
		self.NAME_MID			:= ut.CleanSpacesAndUpper(stripNickMName);
		self.NAME_LAST		:= ut.CleanSpacesAndUpper(tempLastName);
		SELF.NAME_NICK 		:= MAP(tempFNick<>'' => ut.CleanSpacesAndUpper(REGEXREPLACE('\\.',tempFNick,'')),
		                         tempFNick<>'' => ut.CleanSpacesAndUpper(REGEXREPLACE('\\.',tempMNick,'')),
														 '');
		SELF.NAME_SUFX		:= tempSufxName;
		
		self.NAME_ORG		  := IF(self.NAME_LAST+ self.NAME_FIRST!=' ',
														self.NAME_LAST+' '+ self.NAME_FIRST,
													  ' ');
		self.NAME_ORG_ORIG		:= TRIM(tempLName + ', ' + tempFirstName + ' ' + tempMidName);												
		
		self.NAME_DBA			:= IF(TRIM(L.LAST_NAME) != ' ' AND TRIM(L.EMPLOYER_DBA) != ' '
													, StringLib.StringToUpperCase(TRIM(L.EMPLOYER_DBA,LEFT,RIGHT)), ' ');
		self.DBA_FLAG			:= If(trim(self.NAME_DBA,left,right) != '',1,0); //1=TRUE, 0=FALSE
		
		//Clean Office Name
		tmpNameOffice					:= ut.CleanSpacesAndUpper(L.EMPLOYER_LEGAL_NAME);
		prepNameOffice				:= Prof_License_mari.mod_clean_name_addr.strippunctName(tmpNameOffice);
		clnNameOffice					:= StringLib.StringCleanSpaces(prepNameOffice);
		self.NAME_OFFICE			:= MAP(REGEXFIND('^C/O TERRAMOR PROPERTIES$', L.MAILING_ADDRESS2, NOCASE)
																	 => 'TERRAMOR PROPERTIES',
																 REGEXFIND('^C/O NATIONAL PROPERTY SERVICES$', L.MAILING_ADDRESS2, NOCASE)
																	 => 'NATIONAL PROPERTY SERVICES',
																 TRIM(clnNameOffice,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) =>'', 
																 TRIM(clnNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(clnNameOffice,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(clnNameOffice,ALL) = TRIM(REGEXREPLACE(',',SELF.NAME_ORG_ORIG,' '),ALL) => '',
																 clnNameOffice);			
		self.OFFICE_PARSE	:= MAP(SELF.NAME_OFFICE != ''  
												 AND (Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)
												 OR REGEXFIND('(CORP| CO$)',SELF.NAME_OFFICE)) =>'GR',
												 SELF.NAME_OFFICE != ''  AND 
												 NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'MD',
												 '');
												 
		
		self.ADDR_BUS_IND			:= IF(TRIM(L.MAILING_ADDRESS1,LEFT,RIGHT) != ' ','B',' ');

		//Populate NAME_FORMAT BUG # 124107
		SELF.NAME_FORMAT			:= 'L';
		
		self.NAME_DBA_ORIG		:= IF(TRIM(L.EMPLOYER_DBA,LEFT,RIGHT) != ' ',self.NAME_DBA, ' ');
		self.NAME_MARI_ORG		:= MAP(self.type_cd='GR' => self.name_org,
																 self.type_cd='MD' => TRIM(self.NAME_OFFICE,LEFT,RIGHT),  //Set NAME_MARI_ORG to office_name if type_cd is MD per BUG# 124701
		                             '');
		self.NAME_MARI_DBA	  := IF(self.type_cd='GR',self.name_dba,' ');
		self.PHN_MARI_1				:= IF(TRIM(L.EMPLOYER_PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.EMPLOYER_PHONE,'0123456789'),' ');
		self.PHN_MARI_FAX_1		:= IF(TRIM(L.EMPLOYER_FAX,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.EMPLOYER_FAX,'0123456789'),' ');

		//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$' +
					 ')';
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|' +
					 'LINE 1|LINE 2|LEGAL DEPT\\.|SALES OFFICE|BUSINESS OFFICE' +
					 ')';

		trimAddress1          := ut.CleanSpacesAndUpper(L.MAILING_ADDRESS1);
	  trimAddress2          := ut.CleanSpacesAndUpper(L.MAILING_ADDRESS2);
  		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);
		//Store the names in address field in provnote_2
		SELF.PROVNOTE_2				:= MAP(tmpNameContact1<>''  AND NOT REGEXFIND('SALES OFFICE',tmpNameContact1)
		                               => 'CONTACT INFO FROM ADDR:' + REGEXREPLACE('(^CO |^ATTN: )',tmpNameContact1,''),
		                             tmpNameContact2<>''  AND NOT REGEXFIND('SALES OFFICE',tmpNameContact2)
		                               => 'CONTACT INFO FROM ADDR:' + REGEXREPLACE('(^CO |^ATTN: )',tmpNameContact2,''),
																 '');

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.MAILING_CITY+' '+L.MAILING_STATE +' '+L.MAILING_ZIP); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.MAILING_CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.MAILING_STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(L.MAILING_ZIP,left,right)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		//self.provnote_1 := trimAddress1+'|'+trimAddress2+'|'+trim(self.ADDR_ADDR1_1)+'|'+self.ADDR_ADDR2_1;

		self.PHN_PHONE_1			:= IF(TRIM(L.EMPLOYER_PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.EMPLOYER_PHONE,'0123456789'),' ');
		self.PHN_FAX_1				:= IF(TRIM(L.EMPLOYER_FAX,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.EMPLOYER_FAX,'0123456789'),' ');
		self.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY,LEFT,RIGHT));
		
	//Expected codes [CO,BR,IN]
		self.AFFIL_TYPE_CD		:= IF(self.TYPE_CD = 'MD','IN','CO');
		

		SELF.NAME_CONTACT_FIRST := IF(REGEXFIND('C/O RICHARD BRANDT',L.MAILING_ADDRESS2,NOCASE),'RICHARD','');
		SELF.NAME_CONTACT_LAST  := IF(REGEXFIND('C/O RICHARD BRANDT',L.MAILING_ADDRESS2,NOCASE),'BRANDT','');

		
		
		/* fields used to create cmc_slpk unique key are :
		license number
		office license number
		license type
		source update
		name
		address
		dba */	
		self.CMC_SLPK       	:= HASH64(TRIM(self.license_nbr,left,right)
															+ TRIM(self.std_license_type,left,right)
															+ TRIM(self.std_source_upd,left,right)
															+ TRIM(L.MAILING_ADDRESS1,left,right)
															+ TRIM(L.MAILING_ADDRESS2,left,right)
															+ TRIM(self.addr_city_1,left,right)
															+ TRIM(self.addr_state_1,left,right)
															+ TRIM(self.addr_zip5_1,left,right)
															+ TRIM(self.NAME_ORG_ORIG,left,right)
															+ TRIM(L.last_name,left,right)
															+ TRIM(L.first_name,left,right)
															+ TRIM(L.EMPLOYER_LIC_NUMBER,RIGHT,LEFT));  //Added per BUG 124701
		
		SELF.PROVNOTE_3			:= IF(L.LAST_MODIFIED <> '', 'LAST MODIFIED: ' + stringlib.stringfilterout(L.LAST_MODIFIED,'"'),'');
		SELF := [];
	END;

	ds_map_brokers := project(ValidBrkrFile, transformBrokerToCommon(left));

	ds_map	:= ds_map_affil_co + ds_map_brokers;

	//remove dup records
	ds_map_deduped := dedup(sort(distribute(ds_map,hash(cmc_slpk,name_org,license_nbr,std_license_type,addr_addr1_1)),record,local),record,all,local);

	// populate std_license_status field via translation on raw_license_status field
	Prof_License_Mari.layout_base_in trans_lic_status(ds_map_deduped L, ds_Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_stat_trans := join(ds_map_deduped, ds_Cmvtranslation,
														left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(trim(left.raw_license_status,left,right))=trim(right.fld_value,left,right),
														trans_lic_status(left,right),left outer,lookup);

	// populate prof code field via translation on license type field
	//Prof_License_Mari.layouts_reference.MARIBASE trans_lic_type(ds_map L, ds_Cmvtranslation R) := transform
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map_stat_trans L, ds_Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
	end;

	ds_map_lic_trans := join(ds_map_stat_trans, ds_Cmvtranslation,
													 left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(trim(left.STD_LICENSE_TYPE,left,right))=trim(right.fld_value,left,right),
													 trans_lic_type(left,right),left outer,lookup);

	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := transform
		self.pcmc_slpk := IF(L.affil_type_cd = 'IN',R.cmc_slpk,L.pcmc_slpk);
		self := L;
	end;

	//12/11/12 Cathy Tio - change he record set from ds_map_src_desc to ds_map_lic_trans
	//ds_map_affil := join(ds_map_src_desc, company_only_lookup,
	ds_map_affil := join(ds_map_lic_trans, company_only_lookup,
															trim(left.off_license_nbr,left,right)	= trim(right.license_nbr,left,right)																	
															and left.affil_type_cd != 'CO'
															and left.affil_type_cd != 'BR',
																			assign_pcmcslpk(left,right),left outer,lookup);

	d_final := output(ds_map_affil, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);
			
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile(mari_dest+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil(NAME_ORG_ORIG != ''));
	
	//Move file(s) from ::using:: to ::used::
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'entities', 'using', 'used'),
													 Prof_License_Mari.func_move_file.MyMoveFile(code, 'individuals', 'using', 'used')
													 );

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCompany, oBroker, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

