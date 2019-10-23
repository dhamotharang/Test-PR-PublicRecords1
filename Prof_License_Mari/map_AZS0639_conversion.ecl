//************************************************************************************************************* */	
//  The purpose of this development is take Arizona State Banking Department raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */
IMPORT Prof_License, Prof_License_Mari, Address, Lib_FileServices, lib_stringlib, ut;
#workunit('name','MARI- AZS0639');

EXPORT map_AZS0639_conversion(STRING pVersion) := FUNCTION

	code 								:= 'AZS0639';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV						:= OUTPUT(Cmvtranslation);

	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'bk','sprayed','using');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'cbk','sprayed','using');
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'ea','sprayed','using');
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'mb','sprayed','using');
												 );

	//AZ input files
	ds_mtg_banker	:= Prof_License_Mari.files_AZS0639.mtg_banker;
	oMTGBANKER		:= OUTPUT(ds_mtg_banker);
	ds_com_banker	:= Prof_License_Mari.files_AZS0639.com_banker;
	oCOMBANKER		:= OUTPUT(ds_com_banker);
	ds_escrow_agt	:= Prof_License_Mari.files_AZS0639.escrow_agt;
	oESAGENT			:= OUTPUT(ds_escrow_agt);
	ds_mtg_broker	:= Prof_License_Mari.files_AZS0639.mtg_broker;
	oMTGBRKR			:= OUTPUT(ds_mtg_broker);

	//Remove bad records before processing
	ValidMtgBanker	:= ds_mtg_banker(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMPANY)));
	ValidCompBanker	:= ds_com_banker(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMPANY)));
	ValidEscrowAgt	:= ds_escrow_agt(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMPANY)));
	ValidMtgBroker	:= ds_mtg_broker(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMPANY)));

	//Pattern for colon in date
	Colonpattern	:= '^(.*)(:)(.*)';

	//Pattern for license renewal
	Renewpattern	:= '^(RENEWING...)(.*)';

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';
	 
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	
  //Pattern for DBA
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	
	
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
					 
	//Raw layout with lic_type added based on raw file
	layout_AZ_LicType	:= RECORD  
		Prof_License_Mari.layout_AZS0639.Mtg_Broker;
		STRING10  LICENSE_TYPE;
	END;

	//Mortgage Banker License Type
	layout_AZ_LicType trans_bk_license_type(ValidMtgBanker L) := TRANSFORM
			SELF.LICENSE_TYPE := 'MBNK';
			SELF	:= L;
	END;

	ds_trans_bk_type	:= PROJECT(ValidMtgBanker,trans_bk_license_type(LEFT));

	//Commercial Banker License Type
	layout_AZ_LicType trans_cb_license_type(ValidCompBanker L) := TRANSFORM
			SELF.LICENSE_TYPE := 'CMBNK';
			SELF	:= L;
	END;

	ds_trans_cb_type	:= PROJECT(ValidCompBanker,trans_cb_license_type(LEFT));

	//Escrow Agent License Type
	layout_AZ_LicType trans_ea_license_type(ValidEscrowAgt L) := TRANSFORM
			SELF.LICENSE_TYPE := 'EA';
			SELF.CONTACT	:= '';
			SELF	:= L;
	END;

	ds_trans_ea_type	:= PROJECT(ValidEscrowAgt,trans_ea_license_type(LEFT));

	//Mortgage Broker License Type
	layout_AZ_LicType trans_mb_license_type(ValidMtgBroker L) := TRANSFORM
			SELF.LICENSE_TYPE := 'MBKR';
			SELF	:= L;
	END;

	ds_trans_mb_type	:= PROJECT(ValidMtgBroker,trans_mb_license_type(LEFT));

	ds_trans_all_type_1	:= ds_trans_bk_type + ds_trans_cb_type + ds_trans_ea_type + ds_trans_mb_type;
	ds_trans_all_type	:= ds_trans_all_type_1(NOT REGEXFIND('TEST COMPANY', COMPANY, NOCASE));      //exclude test records

	//AZ Banking and Mortgage layout to Common - Company
	Prof_License_Mari.layout_base_in transBankCompanyToCommon(layout_AZ_LicType L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= src_st;
		SELF.TYPE_CD					:= 'GR';

		SELF.RAW_LICENSE_TYPE	:= StringLib.StringToUpperCase(TRIM(L.LICENSE_TYPE,LEFT,RIGHT));
		SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;

		SELF.LICENSE_NBR			:= StringLib.StringToUpperCase(TRIM(REGEXREPLACE('^0+',L.LIC_NUM,''),LEFT,RIGHT));
	
		temp_org_name 				:= IF(TRIM(L.BRANCH_NAME,LEFT,RIGHT) = ' ',
																TRIM(StringLib.stringtouppercase(L.COMPANY),LEFT,RIGHT),
																' ');
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('(/|\\{|\\})',temp_org_name,' ')); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg); //split corporation suffix from name
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(TRIM(tmpNameOrg,LEFT,RIGHT)); //split corporation prefix from name
		SELF.NAME_ORG					:= IF(REGEXFIND(IPpattern,temp_org_name),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO'))); //Without punct. and Sufx removed
		//name format of NAME_ORG
		SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG<>'','F','');;
		
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		SELF.NAME_ORG_ORIG		:= IF(TRIM(L.BRANCH_NAME,LEFT,RIGHT) = ' ',
																TRIM(StringLib.stringtouppercase(L.COMPANY),LEFT,RIGHT),
																' ');
		SELF.NAME_MARI_ORG		:= IF(SELF.type_cd='GR',SELF.NAME_ORG_ORIG,' ');
		
		temp_dba_name					:= ut.CleanSpacesAndUpper(L.DBA_NAME);
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('(/|\\{|\\}|DBA/)',temp_dba_name,' ')); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA); //split corporation suffix from name
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(TRIM(tmpNameDBA,LEFT,RIGHT)); //split corporation prefix from name
		SELF.NAME_DBA					:= IF(REGEXFIND(IPpattern,temp_dba_name),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= If(TRIM(SELF.NAME_DBA,LEFT,RIGHT) != '',1,0); //1=TRUE, 0=FALSE
		SELF.NAME_DBA_ORIG		:= IF(TRIM(L.DBA_NAME,LEFT,RIGHT) != ' ',
																TRIM(StringLib.stringtouppercase(L.DBA_NAME),LEFT,RIGHT),
																' ');
		SELF.NAME_MARI_DBA	  := IF(SELF.type_cd='GR',SELF.NAME_DBA_ORIG,' ');
		
		SELF.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.START_DATE);		//MM/DD/YYYY -> YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';										//It is not available in the vendor input file.
		SELF.EXPIRE_DTE				:= IF(REGEXFIND('RENEWING...',StringLib.StringToUpperCase(L.EXPIRATION_DATE)),
																'17530101',
																Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.EXPIRATION_DATE));
		SELF.STD_LICENSE_STATUS	:= IF(REGEXFIND('RENEWING...',StringLib.StringToUpperCase(L.EXPIRATION_DATE)), '101','A');
	
		full_address					:= StringLib.StringToUpperCase(TRIM(L.ADDRESS_1,LEFT,RIGHT)+' '+TRIM(L.ADDRESS_2,LEFT,RIGHT));
		SELF.ADDR_BUS_IND			:= IF(TRIM(full_address,LEFT,RIGHT) != ' ','B',' ');
		TrimPhone             := IF(TRIM(L.PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.PHONE,'0123456789'),' ');
		SELF.PHN_MARI_1				:= ut.CleanPhone(TrimPhone);					//Phone # before running through our cleansing process
		SELF.PHN_PHONE_1			:= ut.CleanPhone(TrimPhone);

// use address cleaner  to clean address
    tempAddr_Addr1_1			:= IF(TRIM(L.ADDRESS_1,LEFT,RIGHT)=' ',
																ut.CleanSpacesAndUpper(L.ADDRESS_2),
																ut.CleanSpacesAndUpper(L.ADDRESS_1));

		tempAddr_Addr2_1			:= IF(TRIM(tempAddr_Addr1_1)=ut.CleanSpacesAndUpper(L.ADDRESS_2),
																' ',
																ut.CleanSpacesAndUpper(L.ADDRESS_2));
		
		
		prepAddr_Line_11			:= tempAddr_Addr1_1 + ' ' + tempAddr_Addr2_1;
		prepAddr_Line_21			:= ut.CleanSpacesAndUpper(L.City) + ' ' +
		                         ut.CleanSpacesAndUpper(L.ST) + ' ' +
														 ut.CleanSpacesAndUpper(L.Zip_Code);
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_11,prepAddr_Line_21);
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact1			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact1 != '' and tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact1!='' => '',
																 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR1_1)=TRIM(tmpADDR_ADDR2_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr1[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr1[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];

		//Populate contact information
		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,prepAddr_Line_11) => 
		                               Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepAddr_Line_11),
																 REGEXFIND(DBA_Ind,prepAddr_Line_11) => '','');
																																							
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact) => '',
																 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																 Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																 '');
																 																 
		prepNAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);														 
		prepNAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		prepNAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		prepNAME_CONTACT_LAST 	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		prepNAME_CONTACT_SUFX 	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  						
		
		ContactName						:= ut.CleanSpacesAndUpper(L.CONTACT);
		tmpNick_Name					:= Prof_License_Mari.fGetNickname(ContactName,'nick');
		rmv_NickName					:= Prof_License_Mari.fGetNickname(ContactName,'strip_nick');
		ParsedName						:= Address.CleanPersonFML73(StringLib.StringCleanSpaces(rmv_NickName));
		
		SELF.NAME_CONTACT_PREFX:= IF(ContactName<>'',TRIM(ParsedName[1..5],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_PREFX <> '', prepNAME_CONTACT_PREFX,' '));
		SELF.NAME_CONTACT_FIRST:= IF(ContactName<>'',TRIM(ParsedName[6..25],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_FIRST <> '', prepNAME_CONTACT_FIRST,' '));
		SELF.NAME_CONTACT_MID	 := IF(ContactName<>'',TRIM(ParsedName[26..45],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_MID <> '', prepNAME_CONTACT_MID,' '));
		SELF.NAME_CONTACT_LAST := IF(ContactName<>'',TRIM(ParsedName[46..65],LEFT,RIGHT),
                              	 IF(prepNAME_CONTACT_LAST <> '', prepNAME_CONTACT_LAST,' '));
		SELF.NAME_CONTACT_SUFX := IF(ContactName<>'',TRIM(ParsedName[66..70],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_SUFX <> '', prepNAME_CONTACT_SUFX,' '));
		SELF.NAME_CONTACT_NICK := IF(tmpNick_Name<>'',tmpNick_Name,' ');														 

		
		//Expected codes [CO,BR,IN]
		SELF.AFFIL_TYPE_CD		:= 'CO';
		SELF.PROVNOTE_3 	    := IF(SELF.STD_LICENSE_STATUS = 'A','[LICENSE_STATUS ASSIGNED]',' ');
		
		SELF.MLTRECKEY				:= 0;
		
		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// name
		// address
		// dba	
		SELF.CMC_SLPK     		:= HASH64(TRIM(L.LIC_NUM,LEFT,RIGHT)
																//+TRIM(SELF.OFF_LICENSE_NBR,LEFT,RIGHT)
																+TRIM(L.LICENSE_TYPE,LEFT,RIGHT)
																+TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
																+TRIM(L.COMPANY,LEFT,RIGHT)
																+TRIM(L.ADDRESS_1,LEFT,RIGHT)
																+TRIM(L.CITY,LEFT,RIGHT)
																+TRIM(L.ST,LEFT,RIGHT)
																+TRIM(L.ZIP_CODE,LEFT,RIGHT));
		SELF := [];
	
	END;

	ds_trans_BankCompany	:= PROJECT(ds_trans_all_type(BRANCH_NAME = ' '),transBankCompanyToCommon(LEFT));

	//AZ Banking and Mortgage layout to Common - Branch
	Prof_License_Mari.layout_base_in transBankBranchToCommon(layout_AZ_LicType L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= src_st;
		SELF.TYPE_CD					:= 'GR';

		SELF.RAW_LICENSE_TYPE	:= StringLib.StringToUpperCase(TRIM(L.LICENSE_TYPE,LEFT,RIGHT));
		SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;
		
	
		temp_org_name 				:= IF(TRIM(L.BRANCH_NAME,LEFT,RIGHT) != '',
															  ut.CleanSpacesAndUpper(L.BRANCH_NAME),
																'');
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('(/|\\{|\\})',temp_org_name,' ')); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(TRIM(tmpNameOrg,LEFT,RIGHT)); //split corporation prefix from name
		SELF.NAME_ORG					:= IF(REGEXFIND(IPpattern,temp_org_name),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO'))); //Without punct. and Sufx removed
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		SELF.NAME_ORG_ORIG		:= IF(TRIM(L.BRANCH_NAME,LEFT,RIGHT) != ' '
																,TRIM(StringLib.stringtouppercase(L.BRANCH_NAME),LEFT,RIGHT), ' ');
		SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG<>'','F','');
		SELF.NAME_MARI_ORG		:= IF(SELF.type_cd='GR',SELF.NAME_ORG_ORIG,' ');

		temp_office_name			:= IF(TRIM(L.BRANCH_NAME,LEFT,RIGHT) != ' ',
															  ut.CleanSpacesAndUpper(L.COMPANY),
																'');
		stdOfficeName					:= MAP(REGEXFIND('L\\.L\\.C\\.',temp_office_name) => REGEXREPLACE('L\\.L\\.C\\.',temp_office_name,'LLC'),
		                             REGEXFIND('L\\.P\\.',temp_office_name) => REGEXREPLACE('L\\.P\\.',temp_office_name,'LP'),
		                             REGEXFIND('INC\\.',temp_office_name) => REGEXREPLACE('INC\\.',temp_office_name,'INC'),
		                             REGEXFIND('CORP\\.',temp_office_name) => REGEXREPLACE('CORP\\.',temp_office_name,'CORP'),
																 temp_office_name);
		SELF.NAME_OFFICE			:= IF(temp_office_name<>'',
		                            StringLib.StringCleanSpaces(REGEXREPLACE('(,|\\(|\\)|\\{|\\})',stdOfficeName,' ')),
																'');
		
		temp_dba_name					:= TRIM(StringLib.stringtouppercase(L.DBA_NAME),LEFT,RIGHT);
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('(/|\\{|\\}|DBA/)',temp_dba_name,' ')); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(TRIM(tmpNameDBA,LEFT,RIGHT)); //split corporation prefix from name
		SELF.NAME_DBA					:= IF(REGEXFIND(IPpattern,temp_dba_name),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= If(TRIM(SELF.NAME_DBA,LEFT,RIGHT) != '',1,0); //1=TRUE, 0=FALSE
		SELF.NAME_DBA_ORIG		:= IF(TRIM(L.DBA_NAME,LEFT,RIGHT) != ' '
																,TRIM(StringLib.stringtouppercase(L.DBA_NAME),LEFT,RIGHT), ' ');
		SELF.NAME_MARI_DBA	  := IF(SELF.type_cd='GR',SELF.NAME_DBA_ORIG,' ');

	  //For branch offices, use the branch # as the license # and HQ license # as the office license #
		SELF.LICENSE_NBR			:= IF(SELF.NAME_ORG != ' ',StringLib.StringToUpperCase(TRIM(REGEXREPLACE('^0+',L.BR_NUM,''),LEFT,RIGHT)),' ');
		SELF.OFF_LICENSE_NBR	:= IF(SELF.NAME_ORG != ' ',StringLib.StringToUpperCase(TRIM(REGEXREPLACE('^0+',L.LIC_NUM,''),LEFT,RIGHT)),' ');
		
		SELF.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.START_DATE);		//MM/DD/YYYY -> YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';										//It is not available in the vendor input file.
		SELF.EXPIRE_DTE				:= IF(REGEXFIND('RENEWING...',StringLib.StringToUpperCase(L.EXPIRATION_DATE)),
																'17530101',
																Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.EXPIRATION_DATE));
		SELF.STD_LICENSE_STATUS	:= IF(SELF.EXPIRE_DTE = '17530101', '101','A');
		
		full_address					:= StringLib.StringToUpperCase(TRIM(L.ADDRESS_1,LEFT,RIGHT)+' '+TRIM(L.ADDRESS_2,LEFT,RIGHT));
		SELF.ADDR_BUS_IND			:= IF(TRIM(full_address,LEFT,RIGHT) != ' ','B',' ');


		SELF.PHN_MARI_1				:= TRIM(L.PHONE,LEFT,RIGHT);					//Phone # before running through our cleansing process
		SELF.PHN_PHONE_1			:= IF(TRIM(L.PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.PHONE,'0123456789'),' ');
		
		//Use address cleaner to clean address


		tmpZip	              := MAP(LENGTH(TRIM(L.ZIP_CODE))=3 => '00'+TRIM(L.ZIP_CODE),
		                             LENGTH(TRIM(L.ZIP_CODE))=4 => '0'+TRIM(L.ZIP_CODE),
																 TRIM(L.ZIP_CODE));
		
		trimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS_1);
	  trimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS_2);
   	trimCity		  				:= ut.CleanSpacesAndUpper(L.CITY);
   	trimState							:= ut.CleanSpacesAndUpper(L.ST);
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trimCity+' '+trimState +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
																 
		//Populate contact information

		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,temp_preaddr1) => 
		                               Prof_License_Mari.mod_clean_name_addr.GetDBAName(temp_preaddr1),
																 REGEXFIND(DBA_Ind,temp_preaddr1) => '','');
																																							
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact) => '',
																 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																 Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																 '');
		prepNAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);														 
		prepNAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		prepNAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		prepNAME_CONTACT_LAST 	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		prepNAME_CONTACT_SUFX 	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  						
		
		ContactName						:= ut.CleanSpacesAndUpper(L.CONTACT);
		tmpNick_Name					:= Prof_License_Mari.fGetNickname(ContactName,'nick');
		rmv_NickName					:= Prof_License_Mari.fGetNickname(ContactName,'strip_nick');
		ParsedName						:= Address.CleanPersonFML73(StringLib.StringCleanSpaces(rmv_NickName));
		SELF.NAME_CONTACT_PREFX:= IF(ContactName<>'',TRIM(ParsedName[1..5],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_PREFX <> '', prepNAME_CONTACT_PREFX,' '));
		SELF.NAME_CONTACT_FIRST:= IF(ContactName<>'',TRIM(ParsedName[6..25],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_FIRST <> '', prepNAME_CONTACT_FIRST,' '));
		SELF.NAME_CONTACT_MID	 := IF(ContactName<>'',TRIM(ParsedName[26..45],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_MID <> '', prepNAME_CONTACT_MID,' '));
		SELF.NAME_CONTACT_LAST := IF(ContactName<>'',TRIM(ParsedName[46..65],LEFT,RIGHT),
                              	 IF(prepNAME_CONTACT_LAST <> '', prepNAME_CONTACT_LAST,' '));
		SELF.NAME_CONTACT_SUFX := IF(ContactName<>'',TRIM(ParsedName[66..70],LEFT,RIGHT),
		                             IF(prepNAME_CONTACT_SUFX <> '', prepNAME_CONTACT_SUFX,' '));
		SELF.NAME_CONTACT_NICK := IF(tmpNick_Name<>'',tmpNick_Name,' ');

		//Expected codes [CO,BR,IN]
		SELF.AFFIL_TYPE_CD		:= 'BR';
		SELF.PROVNOTE_3 	    := IF(SELF.STD_LICENSE_STATUS = 'A','[LICENSE_STATUS ASSIGNED]',' ');
		
		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// name
		// address
		// dba 
		SELF.CMC_SLPK     := HASH64(TRIM(L.BR_NUM,LEFT,RIGHT)
																+TRIM(L.LIC_NUM,LEFT,RIGHT)
																+TRIM(L.LICENSE_TYPE,LEFT,RIGHT)
																+TRIM(SELF.STD_SOURCE_UPD,LEFT,RIGHT)
																+TRIM(L.BRANCH_NAME,LEFT,RIGHT)
																+TRIM(L.ADDRESS_1,LEFT,RIGHT)
																+TRIM(L.CITY,LEFT,RIGHT)
																+TRIM(L.ST,LEFT,RIGHT)
																+TRIM(L.ZIP_CODE,LEFT,RIGHT));
		SELF := [];
		
	END;

	ds_trans_BankBranch	:= PROJECT(ds_trans_all_type(BRANCH_NAME != ' '),transBankBranchToCommon(LEFT));
	ds_trans_BankAll	  := ds_trans_BankCompany + ds_trans_BankBranch;

	// company only table for affiliation code
	company_only_lookup := ds_trans_BankAll(ds_trans_BankAll.affil_type_cd='CO');

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_trans_BankAll L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_trans_BankAll, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_type,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
													
	//perform lookup to join children to parents and assign cmc_slpk field value of parent to pcmc_slpk field of child  
	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		//SELF.off_license_nbr := ' ';
		SELF := L;
	END;

	ds_map_affil 				:= JOIN(ds_map_lic_trans, company_only_lookup,
															TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)
															AND LEFT.affil_type_cd != 'CO',
															assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
	
	ds_map_disted				:= DISTRIBUTE(ds_map_affil,HASH(name_org,license_nbr,std_license_type,addr_addr1_1));
	ds_map_sorted				:= SORT(ds_map_disted,RECORD,LOCAL);
  ds_map_deduped 			:= DEDUP(ds_map_sorted,RECORD,ALL,LOCAL);

	d_final 						:= output(ds_map_deduped, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_deduped(NAME_ORG_ORIG != ''));

	move_to_used				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'bk','using','used');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'cbk','using','used');
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'ea','using','used');
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'mb','using','used');
												 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oMTGBANKER, oCOMBANKER, oESAGENT, oMTGBRKR, d_final, 
	                  add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;