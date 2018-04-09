//************************************************************************************************************* */	
//  The purpose of this development is take CO Uniform Consumer raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI, SCANK, and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_COS0632_conversion(STRING pVersion) := FUNCTION

	code 								:= 'COS0632';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								

	ds_CO_uccc					:= Prof_License_Mari.file_COS0632;
	oUccc								:= OUTPUT(ds_CO_uccc);
	
	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD=src_cd);
	oCmv								:= OUTPUT(ds_Cmvtranslation);

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';

	pre_clean_uccc			:= ds_CO_uccc(NOT REGEXFIND('(^ORIGINAL[ ]+CANCEL)',ORG_NAME,NOCASE)
	                                  AND NOT REGEXFIND('BUSINESS/TRADE NAME',ORG_NAME,NOCASE)
	                                  AND TRIM(ADDRESS1_1+LIC_NUMBER+LIC_BRANCH+ORIG_LIC_DATE+STATUS+CANCEL_DATE+ACTION,LEFT,RIGHT)<>'');
	
	//Merge split lines
	Prof_License_Mari.layout_COS0632.src mergeLines(pre_clean_uccc L, pre_clean_uccc R) :=TRANSFORM
		temp_addr 			:= TRIM(R.ORG_NAME)+', '+TRIM(R.ADDRESS1_1);
		pre_addr1				:= IF(REGEXFIND('\n', temp_addr),
		                      TRIM(L.ADDRESS1_1)+ ' ' + REGEXREPLACE('\n', temp_addr,' '),
													TRIM(L.ADDRESS1_1)+' '+TRIM(R.ORG_NAME)+', '+TRIM(R.ADDRESS1_1));
		SELF.ADDRESS1_1	:= REGEXREPLACE('"', pre_addr1, '');
		SELF.ORG_NAME		:= L.ORG_NAME;
		SELF						:= R;
	END;
	
	clean_uccc_1 := ROLLUP(pre_clean_uccc,
	                     LEFT.LIC_NUMBER='' AND LEFT.ORIG_LIC_DATE='' AND LEFT.STATUS='' AND 
											 REGEXFIND('(^[A-Z]{2} )',RIGHT.ADDRESS1_1),
											 mergeLines(LEFT,RIGHT));
	
	//Clean up non printable characters
	ut.CleanFields(clean_uccc_1,clean_uccc_2);

	layout_src_addr := RECORD
	  Prof_License_Mari.layout_COS0632.src;
		STRING50	ADDR_ADDR1_1;
		STRING50	ADDR_ADDR2_1;
		STRING25	ADDR_CITY_1;
		STRING2		ADDR_STATE_1;
		STRING5		ADDR_ZIP5_1;
		STRING4		ADDR_ZIP4_1;
		STRING1		ADDR_BUS_IND;
		UNSIGNED1	OOC_IND_1;
		STRING80  NAME_OFFICE;
		STRING2   OFFICE_PARSE;
	END;
	
	//Reformat and clean addresses
	layout_src_addr reformatAddress(clean_uccc_2 L) := TRANSFORM
	  
		address1_1					:= ut.CleanSpacesAndUpper(L.ADDRESS1_1);
		
		//Determine if it is a foreign address
		SELF.OOC_IND_1			:= MAP(REGEXFIND('[ |\\,|\\.|^]WINNIPEG[ |\\,|\\.|$]',address1_1) => 1,
		                           REGEXFIND('[ |\\,|\\.|^]URUGUAY[ |\\,|\\.|$]',address1_1) => 1,
															 REGEXFIND('[ |\\,|\\.|^]BANGALORE[ |\\,|\\.|$]',address1_1) => 1,
															 REGEXFIND('[ |\\,|\\.|^]MUMBAI[ |\\,|\\.|$]',address1_1) => 1,
															 REGEXFIND('[ |\\,|\\.|^]PHILIPPINES[ |\\,|\\.|$]',address1_1) => 1,
															 REGEXFIND('[ |\\,|\\.|^]MAHARASHTRA[ |\\,|\\.|$]',address1_1) => 1,
															 REGEXFIND('[ |\\,|\\.|^]SHOLINGANALLUR[ |\\,|\\.|$]',address1_1) => 1,
															 0);
															 
		temp_zip						:= IF(address1_1 != '',TRIM(REGEXFIND('[0-9]{4,}([[ ]*[-]?[ ]*[0-9]{4})?$', address1_1, 0)),'');
		temp_addr_city_st		:= TRIM(REGEXREPLACE(temp_zip+'$',address1_1,''),LEFT,RIGHT);															
		tempstate						:= IF(temp_addr_city_st<>'',
		                          TRIM(REGEXFIND(',[ ]?([A-Z]{2})$', temp_addr_city_st, 1),LEFT,RIGHT),
															'');
		temp_addr_city			:= TRIM(REGEXREPLACE(tempstate+'$', temp_addr_city_st,''),LEFT,RIGHT);															
		temp_three_name     := TRIM(REGEXFIND('([ ]*[A-Z\\.\\-]{2,} [A-Z\\.\\-]{2,} [A-Z\\.\\-]{2,}),$', temp_addr_city, 1),LEFT,RIGHT);
		temp_two_name     	:= TRIM(REGEXFIND('([ ]*[A-Z\\.\\-]{2,} [A-Z\\.\\-]{2,}),$', temp_addr_city, 1),LEFT,RIGHT);
		temp_one_name     	:= TRIM(REGEXFIND('([ ]*[A-Z\\.\\-]{2,}),$', temp_addr_city, 1),LEFT,RIGHT);
		city_names					:= ['SOUTH COAST METRO','DORAL','ST LUIS OBISPO','HANOVER TOWNSHIP' //valid cities not defined in ut
		                        ,'KAILUA-KONA','FOXBOROUGH','LICOLN'] + 
		                       ['AHWAUTUKEE','WITCHITA','SOUTH ODGEN','ALTAMONTE','NOBESVILLE'	//mis-spelled city names
													  ,'CASTLEROCK','CHAROLOTTE','SACREMENTO','VORHEES','SUMMERLIN','TEVOSE','REUNION','FRAISER'];
		tempcity            := MAP(Address.IsCityName(temp_three_name) OR temp_three_name IN city_names => temp_three_name,
															 Address.IsCityName(temp_two_name) OR temp_two_name IN city_names 					=> temp_two_name, 
															 Address.IsCityName(temp_one_name) OR temp_one_name IN city_names   				=> temp_one_name,
															 '');
		temp_addr						:= REGEXREPLACE(',$',TRIM(REGEXREPLACE(TRIM(tempcity)+'[ ]*,$', temp_addr_city,''),LEFT,RIGHT),'');
		address							:= TRIM(REGEXREPLACE('C/O.*$',temp_addr,''),LEFT,RIGHT);
		citystatezip				:= tempcity + ', ' + tempstate + ' ' + temp_zip;
		clnAddress					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(address,citystatezip);
		
		tmpADDR_ADDR1_1			:= StringLib.StringCleanSpaces(TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)
		                        +' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT));																	
	  tmpADDR_ADDR2_1			:= StringLib.StringCleanSpaces(TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT));

		SELF.ADDR_ADDR1_1		:= IF(SELF.OOC_IND_1=1,REGEXFIND('(^.{30,45})[ |,](.*$)',address1_1,1),tmpADDR_ADDR1_1);
		SELF.ADDR_ADDR2_1		:= IF(SELF.OOC_IND_1=1,REGEXFIND('(^.{30,45})[ |,](.*$)',address1_1,2),tmpADDR_ADDR2_1); 
		SELF.ADDR_CITY_1		:= IF(SELF.OOC_IND_1=1,'',
		                          IF(TRIM(clnAddress[65..89])='',tempcity,TRIM(clnAddress[65..89])));
		SELF.ADDR_STATE_1		:= IF(SELF.OOC_IND_1=1,'',
		                          IF(TRIM(clnAddress[115..116])='',tempstate,TRIM(clnAddress[115..116])));
		SELF.ADDR_ZIP5_1		:= IF(SELF.OOC_IND_1=1,'',
		                          IF(TRIM(clnAddress[117..121])='',temp_zip,TRIM(clnAddress[117..121])));
		SELF.ADDR_ZIP4_1		:= IF(SELF.OOC_IND_1=1,'',TRIM(clnAddress[122..125]));
		SELF.ADDR_BUS_IND		:= IF(address1_1<>'','B','');
		
				//Extract Office name from address
		TmpOffice  := IF(regexfind('C/O.*$',temp_addr),regexfind('^.(.*) C/O (.*)',temp_addr,2),'');
		SELF.NAME_OFFICE := TRIM(TmpOffice,LEFT,RIGHT);
		tempOffParse     := MAP(prof_license_mari.func_is_company(TmpOffice)= TRUE AND TmpOffice != ' '=> 'GR',
											 		  prof_license_mari.func_is_company(TmpOffice)= FALSE AND TmpOffice != ' ' => 'MD',
														'');
		SELF.OFFICE_PARSE:= tempOffParse; 		
		SELF						 := L;
	END;

	clean_uccc_3 := PROJECT(clean_uccc_2, reformatAddress(LEFT));                
	oUccc3 := OUTPUT(clean_uccc_3);
	
	maribase_plus_dbas := RECORD,MAXLENGTH(5500)
		Prof_License_Mari.layouts.base;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	//CO Mortgage Lenders layout to Common
	maribase_plus_dbas transformToCommon(layout_src_addr L) :=TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= L.ln_filedate;
		SELF.STAMP_DTE      	:= L.ln_filedate;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.TYPE_CD					:= 'GR';

		SELF.LICENSE_NBR			:= ut.CleanSpacesAndUpper(L.LIC_NUMBER);
		SELF.LICENSE_STATE		:= src_st;
		
		//Clean and parse Org_name
		TrimOrgName						:= ut.CleanSpacesAndUpper(L.ORG_NAME);
		fixname								:= IF(REGEXFIND(' CASH/PAYDAY ',L.ORG_NAME),REGEXREPLACE(' CASH/PAYDAY ',L.ORG_NAME,' CASH PAYDAY '),TrimOrgName);
		fixname1							:= IF(REGEXFIND(' CASHED[ ]?+[ ]?PAYDAY ',fixname),REGEXREPLACE(' CASHED[ ]?+[ ]?PAYDAY ',fixname,' CASHED PAYDAY '),fixname);
		fixname2							:= IF(REGEXFIND(' DBA$',fixname1),REGEXREPLACE(' DBA$',fixname1,''),fixname1);
		std_org_name					:= IF(REGEXFIND('( DBA DBA | D/B/A | DBA |, |; )',fixname2),REGEXREPLACE('( DBA DBA | D/B/A | DBA |, |; )',fixname2,' / '),fixname2);
		slashchar 						:= StringLib.stringfind(std_org_name,'/',1);
		getCorpOnly						:= IF(REGEXFIND('/', std_org_name),std_org_name[..slashchar-1],std_org_name);		 //get names without DBA names
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getCorpOnly); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
		SELF.NAME_ORG					:= IF(REGEXFIND('.COM',getCorpOnly),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')));  //Without punct. and Sufx removed
		SELF.NAME_ORG_SUFX 		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		
	  // Identified DBA names
		SELF.NAME_ORG_ORIG		:= TrimOrgName;
		SELF.NAME_OFFICE      := L.NAME_OFFICE;
		SELF.NAME_MARI_ORG		:= IF(SELF.NAME_ORG != '',getCorpOnly,SELF.NAME_OFFICE);
		SELF.NAME_FORMAT			:= 'F';
	
	  // Identified DBA names
		temp_dba  						:= REGEXFIND('^([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)',std_org_name,2);		
		SELF.dba1							:= temp_dba;
		SELF.dba2							:= REGEXFIND('^([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)',std_org_name,3);
		SELF.dba3							:= REGEXFIND('^([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)',std_org_name,4);
		SELF.dba4							:= REGEXFIND('^([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)',std_org_name,5);
		SELF.dba5							:= REGEXFIND('^([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)[\\/] ([A-Za-z0-9\\$][^\\/]+)',std_org_name,6);

		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(temp_dba);										
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(temp_dba); //split corporation prefix from name
		SELF.NAME_DBA					:= IF(REGEXFIND('.COM',tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',temp_dba,' CO')),
														    Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',temp_dba,' CO')));
		SELF.NAME_DBA_SUFX		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		SELF.NAME_DBA_ORIG		:= IF(SELF.NAME_DBA = '','',std_org_name[slashchar+1..]);		 //get names without DBA names
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != '',temp_dba,'');
		
		
		//All records from website are Supervised Lender Licenses. Replace license_type with 'SL'	
		SELF.STD_LICENSE_TYPE	:= 'SL';
		SELF.PROVNOTE_3 	    := '{LICENSE TYPE ASSIGNED}';	

		/*Clean dates from MM/DD/YYYY format to YYYYMMDD
		Use default date of 17530101 for blank dates*/
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(L.ORIG_LIC_DATE) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.ORIG_LIC_DATE));
		//Renewal is 03/01 + next year
		next_year 						:= ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
		curr_year 						:= StringLib.GetDateYYYYMMDD()[1..4];
		SELF.RENEWAL_DTE			:= IF(SELF.ORIG_ISSUE_DTE='17530101' OR ut.CleanSpacesAndUpper(L.STATUS)<>'A',
		                            '17530101',
		                            IF(SELF.ORIG_ISSUE_DTE[5..6] < '03',curr_year+'0301',next_year+'0301'));
		SELF.EXPIRE_DTE				:= IF(ut.CleanSpacesAndUpper(L.CANCEL_DATE)<>'ACTIVE',
		                            Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.CANCEL_DATE),
																TRIM(SELF.RENEWAL_DTE));

		//License status and displinary description and actions
		SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.STATUS);
		SELF.DISP_TYPE_CD			:= IF(TRIM(SELF.RAW_LICENSE_STATUS)='R',TRIM(SELF.RAW_LICENSE_STATUS),'');
		SELF.DISPLINARY_ACTION:= IF (ut.CleanSpacesAndUpper(L.ACTION)='YES',
		                             'THERE MAY BE ONE OR MORE LETTERS OF ADMONITION, PROBATION, SUSPENSION OF THE LICENSE, ' +
																 'OR A JUDGMENT, ORDER, OR VOLUNTARY SETTLEMENT OR STIPULATION, INCLUDING PAYMENTS (FINES, ' +
                                 'PENALTIES, CONSUMER REFUNDS, OR OTHER MONETARY PAYMENTS.). ' +
																 'ACTIONS AND SETTLEMENTS ARE MATTERS OF PUBLIC RECORD ALTHOUGH RESEARCH, COPYING, ' +
																 'AND MAILING COSTS MAY APPLY. CONTACT COLORADO DEPARTMENT OF LAW CONSUMER ' +
																 'PROTECTION SECTION, UNIFORM CONSUMER CREDIT CODEFOR MORE INFORMATION.',
																 '');
	
		SELF.AFFIL_TYPE_CD		:= IF(L.LIC_BRANCH != '', 'BR','CO');
		
		TrimStore_Nbr	  			:= ut.CleanSpacesAndUpper(L.LIC_BRANCH);		
		SELF.STORE_NBR        := MAP(LENGTH(TRIM(TrimStore_Nbr))=1 => '00'+TRIM(TrimStore_Nbr),
		                             LENGTH(TRIM(TrimStore_Nbr))=2 => '0'+TRIM(TrimStore_Nbr),
																 TRIM(TrimStore_Nbr));
		

		//Copy address information from input file
		SELF									:= L;
		
		/* fields used to create mltrec_key are :
		license number
		office license number
		license type
		source update
		raw name including DBA's
		raw address */
		SELF.MLTRECKEY	:= 	 IF(SELF.DBA2 != ' ' AND TRIM(SELF.DBA1,LEFT,RIGHT) <> TRIM(SELF.DBA2,LEFT,RIGHT)
													,HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
															+TRIM(SELF.std_license_type,LEFT,RIGHT)
															+TRIM(SELF.std_source_upd,LEFT,RIGHT)
															+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
															+TRIM(SELF.dba1,LEFT,RIGHT)
															+TRIM(SELF.dba2,LEFT,RIGHT)
															+TRIM(SELF.dba3,LEFT,RIGHT)
															+TRIM(SELF.dba4,LEFT,RIGHT)
															+TRIM(SELF.dba5,LEFT,RIGHT)
															+TRIM(L.ADDRESS1_1,LEFT,RIGHT)),0);

		/* fields used to create cmc_slpk unique key are :
		license number
		office license number
		license type
		source update
		standard name_org w/o DBA
		raw address */
		SELF.cmc_slpk  			:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
												 +TRIM(SELF.std_license_type,LEFT,RIGHT)
												 +TRIM(SELF.std_source_upd,LEFT,RIGHT)
												 +TRIM(SELF.NAME_ORG,LEFT,RIGHT)
												 +TRIM(L.ADDRESS1_1,LEFT,RIGHT));							 
		SELF := [];		   		   
	END;

	ds_map := PROJECT(clean_uccc_3, transformToCommon(LEFT));

	// Populate std_license_status field via translation
	maribase_plus_dbas trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// populate prof code field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																																																									
	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) :=TRANSFORM
			SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,5,NormIT(LEFT, COUNTER)),ALL, RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' AND DBA2 = '' 
					AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
		StdDBASufx				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);	
		TrimDBASufx				:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',StdDBASufx) => StringLib.StringFindReplace(StdDBASufx,'CO',''),
													NOT REGEXFIND('([Cc][Oo][\\.]?)$',StdDBASufx) AND NOT REGEXFIND('.COM',StdDBASufx) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdDBASufx),
													NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) AND REGEXFIND('.COM',StdDBASufx) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdDBASufx),
													'');
		DBA_SUFX					:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdDBASufx);						   
		SELF.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.');
		SELF.NAME_DBA_ORIG	:= TRIM(StdDBASufx,LEFT,RIGHT);
		SELF.NAME_MARI_DBA	:= TRIM(L.TMP_DBA,LEFT,RIGHT); 
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) :=TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
							TRIM(LEFT.name_org[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org[1..50],LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																	


	remove_logical 					:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	d_final := OUTPUT(ds_map_affil(license_nbr<>''), ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
  add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil(license_nbr<>''));
	
	move_to_used 				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'uccc','using','used');	
																	);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmv, oUccc3, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

 END;