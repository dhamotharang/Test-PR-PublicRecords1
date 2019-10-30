//************************************************************************************************************* */	
//  The purpose of this development is take the Department of Housing and Urban Development raw files and convert 
//   to a common professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_USS0645_conversion(STRING pVersion) := FUNCTION

	code 										:= 'USS0645';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	IPpattern								:= '^(.*)(\\.COM[,]* |\\.NET |\\.ORG |\\.GOV |\\.EDU |\\.MIL |\\.INT )(.*)';
	#workunit('name','Yogurt:Prof License MARI- '+code + ' ' +pVersion);

	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
																			
	lender_file			:= Prof_License_Mari.file_USS0645.lender;
	branch_file     := Prof_License_Mari.file_USS0645.branch;
	inFile          := lender_file + branch_file;
	// inFile       := file + branch_file;
	ut.CleanFields(inFile, ClninFile);
	oFile := output(ClninFile);
	
  fn_format_license(STRING slnum) := FUNCTION
  fmt_license 		:= CASE(LENGTH(TRIM(slnum,ALL)),
												1	=>'000000000'+TRIM(slnum,ALL),
												2 =>'00000000'+TRIM(slnum,ALL),
												3 =>'0000000'+TRIM(slnum,ALL),
												4 =>'000000'+TRIM(slnum,ALL),
												5 =>'00000'+TRIM(slnum,ALL),
												6 =>'0000'+TRIM(slnum,ALL),
												7 =>'000'+TRIM(slnum,ALL),
												8 =>'00'+TRIM(slnum,ALL),
												9 =>'0'+TRIM(slnum,ALL),
											 10 => TRIM(slnum,ALL),
											 TRIM(slnum,ALL));								 
  RETURN fmt_license;
	END;
	
	
  ValidInFile   := PROJECT(inFile, TRANSFORM(Prof_License_Mari.layout_USS0645.COMMON,
																									SELF.slnum := fn_format_license(LEFT.slnum); 
																									SELF := LEFT;
																									));
	
	Prof_License_Mari.layout_USS0645.COMMON assign_branch_flag(inFile L, lender_file R) := TRANSFORM
		SELF.BRANCH_FLAG := IF(fn_format_license(TRIM(L.SLNUM,ALL)) = fn_format_license(TRIM(R.SLNUM,ALL)) 
		                            /*AND TRIM(ut.CleanSpacesAndUpper(L.STREET_ADDR1 + L.STREET_ADDR2),ALL)[1..15] = TRIM(ut.CleanSpacesAndUpper(R.STREET_ADDR1+R.STREET_ADDR2),ALL)[1..15]
																AND TRIM(ut.CleanSpacesAndUpper(L.CITY + L.ZIP)) = TRIM(ut.CleanSpacesAndUpper(R.CITY+R.ZIP))*/, 'N', 'Y');
		SELF := L;
	END;
	/*
	j1_main :=  JOIN(SORT(DISTRIBUTE(inFile, HASH(slnum)), slnum,LOCAL), 
											SORT(DISTRIBUTE(lender_file, HASH(slnum)), slnum,LOCAL),
                          fn_format_license(TRIM(LEFT.SLNUM)) =  fn_format_license(TRIM(RIGHT.SLNUM))
                          AND TRIM(ut.CleanSpacesAndUpper(LEFT.STREET_ADDR1 + LEFT.STREET_ADDR2),ALL)[1..15] = TRIM(ut.CleanSpacesAndUpper(RIGHT.STREET_ADDR1+RIGHT.STREET_ADDR2),ALL)[1..15]
													AND TRIM(ut.CleanSpacesAndUpper(LEFT.CITY + LEFT.ZIP)) = TRIM(ut.CleanSpacesAndUpper(RIGHT.CITY+RIGHT.ZIP)), 
												  assign_branch_flag(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);	
		*/											
	//Filtering out BAD RECORDS
	GoodFilterRec	:= ValidInFile(TRIM(INSTIT_NAME) <> '' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(INSTIT_NAME)));
	
	maribase_plus_dbas := RECORD,MAXLENGTH(7000)
		Prof_License_Mari.layout_base_in;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;
	//Real Estate License to common MARIBASE layout
	maribase_plus_dbas	transformToCommon(RECORDOF(GoodFilterRec) pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
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
		SELF.TYPE_CD					:= 'GR';

		//License number and status are not provided
		SELF.LICENSE_NBR		:= pInput.SLNUM[1..5] + '-' + pInput.SLNUM[6..9] + '-' + pInput.SLNUM[10];
		SELF.RAW_LICENSE_STATUS := 'ACTIVE';
		SELF.STD_LICENSE_STATUS := 'A';

		// SELF.PROVNOTE_3				:='{LICENSE STATUS ASSIGNED}';

		// initialize raw_license_type from raw data
		tempRawLicType				:= ut.CleanSpacesAndUpper(pInput.MORTG_TYPE);
		SELF.RAW_LICENSE_TYPE := tempRawLicType;
		SELF.STD_LICENSE_TYPE := CASE(tempRawLicType,
		                              'GOVERNMENT (FEDERAL, STATE, OR MUNICIPAL AGENCY)' => '1A',
																	'1-GOVERNMENT (F, S OR MA)'                        => '1A',
																	'SUPERVISED INSTITUTION'                           => '2A',
																	'2-SUPERVISED INSTITUTION'                         => '2A',
																	'NON-SUPERVISED INSTITUTION'                       => '3',
																	'3-NON-SUPERVISED INSTITUTION'                     => '3',
																	'INVESTING-CHARITABLE/NON-PROFIT ORGANIZATION'     => '5',
																	'INVESTING CHARITABLE/NON-PROFIT ORGANIZATION'     => '5',                                                       
																	'5-INVEST-CHARITABLE/NON-PROFIT'                   => '5',
																	''
		                             );
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.APPROVAL_DT<>'',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.APPROVAL_DT),'17530101');
		SELF.EXPIRE_DTE				:= '17530101';
		
		//Assign EIN and lender ID
		SELF.SSN_TAXID_1			:= IF(pInput.FED_TAX_ID<>'',StringLib.StringFilterOut(pInput.FED_TAX_ID,'-'),''),
		SELF.TAX_TYPE_1				:= IF(SELF.SSN_TAXID_1<>'','E','');
	
		//Get name and address
		trimNameOrg						:= ut.CleanSpacesAndUpper(pInput.INSTIT_NAME);
		trimNameDba						:= ut.CleanSpacesAndUpper(pInput.DBA_NAME);
		trimAddress1					:= ut.CleanSpacesAndUpper(pInput.STREET_ADDR1);
		trimCity							:= ut.CleanSpacesAndUpper(pInput.CITY);
		trimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		trimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);

		//Clean corporation name
		fixname								:= MAP(REGEXFIND('RE/MAX ',trimNameOrg) = TRUE => REGEXREPLACE('/',trimNameOrg,' '),
															 REGEXFIND('THE-',trimNameOrg) = TRUE => REGEXREPLACE('THE-',trimNameOrg,'THE '),
															 trimNameOrg);
		DBApattern						:= '^(.*)( DBA|D/B/A |D B A |AND/OR | \\(DBA\\) |/)(.*)';
		getCorpOnly						:= IF(REGEXFIND(DBApattern, fixname), REGEXFIND(DBApattern,fixname,1)
																,StringLib.StringCleanSpaces(fixname));		 //get names without DBA names 
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getCorpOnly); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
		SELF.NAME_ORG					:= IF(REGEXFIND(IPpattern,getCorpOnly),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')));  //Without punct. and Sufx removed
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		SELF.NAME_ORG_ORIG		:= IF(SELF.NAME_ORG != '',TrimNameOrg,'');
		SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG != '','F','');
		SELF.NAME_MARI_ORG		:= IF(SELF.NAME_ORG != '',tmpNameOrg,'');

		//Clean address
		clnAddrAddr						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(TrimAddress1,TRIM(TrimCity+' '+TrimState+' '+TrimZip,LEFT,RIGHT));
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT);
		SELF.ADDR_ADDR2_1			:= TRIM(tmpADDR_ADDR1_2,LEFT,RIGHT); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr[122..125];
	  SELF.ADDR_BUS_IND			:= IF(clnAddrAddr!='','B','');
	
		//Clean phone and remove non-numerics
		TrimPhone							:= TRIM(StringLib.StringFilter(pInput.PHONE_NBR,'0123456789'))[1..10];
		SELF.PHN_MARI_1				:= IF(TrimPhone IN ['0000000000','1111111111'],'',TrimPhone);
		SELF.PHN_PHONE_1			:= IF(TrimPhone IN ['0000000000','1111111111'],'',TrimPhone);
		TrimFax								:= TRIM(StringLib.StringFilter(pInput.FAX_NBR,'0123456789'));
		SELF.PHN_MARI_FAX_1		:= IF(TrimFax IN ['0000000000','1111111111'],'',TRIM(TrimFax,ALL));
		SELF.PHN_FAX_1				:= IF(TrimFax IN ['0000000000','1111111111'],'',TrimFax);

		SELF.EMAIL						:= StringLib.StringToUpperCase(TRIM(pInput.EMAIL,LEFT,RIGHT));
	

		DBAOnly								:= IF(REGEXFIND(DBApattern, fixname), REGEXFIND(DBApattern,fixname,3),'');
		PreDBAName						:= TRIM(REGEXREPLACE('(^DBA |^D/B/A |^N/A)', TrimNameDba, ''));
		//Fix typo
		FixDbaName						:= REGEXREPLACE('(H[ ]+TTP)', PreDBAName, 'HTTP');
		Fix1DbaName						:= REGEXREPLACE('(^HTTP://)', FixDbaName, 'HTTPPP');
		Fix2DbaName						:= REGEXREPLACE('(\\.COM/$)', Fix1DbaName, '.COM');

		ClnNameDBA						:= IF(REGEXFIND('(RE/MAX |M/I |EQUITY/FLORIDA)',Fix2DbaName),
		                            REGEXREPLACE('/',Fix2DbaName,' '),
		                            Fix2DbaName);
		prepDBA								:= IF(REGEXFIND(DBApattern,ClnNameDBA) AND NOT REGEXFIND('(^HTTP)',ClnNameDBA),
																REGEXREPLACE('(DBA|D/B/A |D B A |AND/OR |/)',ClnNameDBA, ' / '),ClnNameDBA);
		ClnSpaceDBA						:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepDBA));
		tmpDBA								:= IF(DBAOnly != '' AND NOT REGEXFIND(TRIM(DBAOnly,LEFT,RIGHT),ClnSpaceDBA), DBAOnly,'');		
		
		temp_DBA1							:=  MAP(tmpDBA != '' => tmpDBA,
																StringLib.stringfind(ClnSpaceDBA,'/',1) = 0	=> ClnSpaceDBA,
																StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',ClnSpaceDBA,2),
																StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,1),
																StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,1),
																StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',ClnSpaceDBA,1),
																StringLib.stringfind(ClnSpaceDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',ClnSpaceDBA,1),ClnSpaceDBA);
				
		temp_dba2							:= MAP(tmpDBA != '' AND StringLib.stringfind(ClnSpaceDBA,'/',1) = 0	=> ClnSpaceDBA,
																StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,2),
																StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,2),
																StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',ClnSpaceDBA,2),
																StringLib.stringfind(ClnSpaceDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',ClnSpaceDBA,2),' ');
											
		temp_dba3 							:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
																StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
																StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 =>
																REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',ClnSpaceDBA,3),'');
								
		temp_dba4 							:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
																StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
																StringLib.stringfind(ClnSpaceDBA,'/',3) > 0  
																AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',ClnSpaceDBA)
																=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',ClnSpaceDBA,4),										
																StringLib.stringfind(ClnSpaceDBA,'/',3) > 0 
																AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',ClnSpaceDBA)									   
																=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',ClnSpaceDBA,4),
																'');
								
		temp_dba5 						:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,4),
																StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
																REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,4),
																StringLib.stringfind(ClnSpaceDBA,'/',4) > 0 
																AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',ClnSpaceDBA)
																=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',ClnSpaceDBA,5), 										
																StringLib.stringfind(ClnSpaceDBA,'/',4) > 0 
																AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',ClnSpaceDBA)
																=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',ClnSpaceDBA,5),
																'');
		//remove the 1st DBA if it is the same as corp name
		tmpDba1Name						:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba1)));
		fixDba1Name						:= REGEXREPLACE('(ONE[ ]+N[ ]+A)',tmpDba1Name,'ONE NA');
		DbaSameAsOrg					:= IF(TRIM(fixDba1Name)=TRIM(TRIM(SELF.NAME_ORG_PREFX)+' '+TRIM(SELF.NAME_ORG)+' '+TRIM(SELF.NAME_ORG_SUFX),LEFT,RIGHT),TRUE,FALSE);
		SELF.dba1							:= IF(DbaSameAsOrg,temp_dba2,temp_dba1);
		SELF.dba2							:= IF(DbaSameAsOrg,temp_dba3,temp_dba2);
		SELF.dba3							:= IF(DbaSameAsOrg,temp_dba4,temp_dba3);
		SELF.dba4							:= IF(DbaSameAsOrg,temp_dba5,temp_dba4);
		SELF.dba5							:= IF(DbaSameAsOrg,'',temp_dba5);
		
		SELF.ADDL_LICENSE_SPEC:= ut.CleanSpacesAndUpper(pInput.INS_TYPE);		
		TempBUSINESS_TYPE     := IF(REGEXFIND('([0-9][-]+)(.*)',pInput.INSTIT_TYPE),REGEXFIND('([0-9][-]+)(.*)',pInput.INSTIT_TYPE,2),pInput.INSTIT_TYPE);
		SELF.BUSINESS_TYPE    := ut.CleanSpacesAndUpper(TempBUSINESS_TYPE);
		//Service orig code/type
		SELF.PROVNOTE_2       := IF(pInput.INSTIT_INSU_TYPE <> '','INSTITUTE INSURANCE TYPE: '+ut.CleanSpacesAndUpper(pInput.INSTIT_INSU_TYPE),'');
    SELF.PROVNOTE_3       := IF(pInput.INSTIT_SEGMENT <> '','INSTITUTE SEGMENT: ' + ut.CleanSpacesAndUpper(pInput.INSTIT_SEGMENT),'');
		
		//Home office is the main office. Use it to determine if an office is CO or BR
		SELF.AFFIL_TYPE_CD		:= CASE(ut.CleanSpacesAndUpper(pInput.BRANCH_FLAG),
		                              'Y' => 'BR',
																	'N' => 'CO',
																	'');

		/* fields used to create mltreckey key are:
			license number
			license type
			source update
			name
			address_1
		*/
		mltreckeyHash 				:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(pInput.MORTG_TYPE,LEFT,RIGHT)
																		+TRIM(pInput.INSTIT_TYPE,LEFT,RIGHT)
																		+TRIM(src_cd,LEFT,RIGHT)
																		+TrimNameOrg
																		+ut.CleanSpacesAndUpper(ClnSpaceDBA)
																		+TrimAddress1
																		+TrimCity
																		+TrimState
																		+TrimZip);
		SELF.MLTRECKEY := IF(SELF.dba2 != ' ',mltreckeyHash, 0);
		/*fields used to create cmc_slpk unique key are :
			license number
			office license number
			license type
			source update
			standard name_org w/o DBA
			raw address
		*/	
		SELF.CMC_SLPK     		:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																		+TrimAddress1
																		+TrimCity
																		+TrimState
																		+TrimZip);
			
		SELF := [];
		
	END;

	ds_map := PROJECT(GoodFilterRec, transformToCommon(LEFT));
  ds_dedup_map := DEDUP(ds_map,EXCEPT addr_zip4_1, cmc_slpk,ALL,LOCAL);

	
	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas 	trans_lic_type(ds_dedup_map L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1));														
		SELF := L;
	END;

	//BUG 182801 - raw license type is license description now. Use std_license_type for the join criteria
	ds_map_lic_trans := JOIN(ds_dedup_map, Cmvtranslation,
													TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
													AND RIGHT.fld_name='LIC_TYPE' 
													AND RIGHT.dm_name1 = 'PROFCODE',
													trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	
	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(6800)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
		 SELF := L;
		 SELF.TMP_DBA		:= CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,5,NormIT(LEFT,COUNTER)),ALL,RECORD);
	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := TRANSFORM
	
		fixDBA								:= IF(TRIM(L.TMP_DBA)='M I FINANCIAL CORP','M/I FINANCIAL CORP',TRIM(L.TMP_DBA));
		fix1DBA								:= REGEXREPLACE('(^HTTPPP)',fixDBA,'HTTP://');
		StdNAME_DBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(fix1DBA);
		DBA_SUFX							:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);		   
		ClnDBA				 				:= IF(REGEXFIND(IPpattern,L.TMP_DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')));
		//put : back into http//
		Cln1DBA								:= REGEXREPLACE('(^HTTP//)',ClnDBA,'HTTP://');
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
		SELF.NAME_DBA					:= IF(TRIM(StdNAME_DBA,LEFT,RIGHT) != TRIM(L.NAME_MARI_ORG,LEFT,RIGHT), Cln1DBA,'');
		SELF.DBA_FLAG       	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: FALSE
		SELF.NAME_DBA_SUFX		:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',DBA_SUFX,'')),''); 
		SELF.NAME_MARI_DBA		:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',TRIM(StdNAME_DBA,LEFT,RIGHT),'');
		SELF.NAME_DBA_ORIG		:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',TRIM(fix1DBA,LEFT,RIGHT),'');
		SELF.MLTRECKEY 				:= IF(TRIM(SELF.NAME_DBA,LEFT,RIGHT) = '',0,L.MLTRECKEY);
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	//Perform affiliation lookup for affil_type_cd = 'BR'
	Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := IF(TRIM(L.affil_type_cd,LEFT,RIGHT) = 'BR',R.cmc_slpk,L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil := JOIN(SORT(DISTRIBUTE(ds_map_base,HASH(license_nbr)),license_nbr,LOCAL),
	                     SORT(DISTRIBUTE(company_only_lookup,HASH(license_nbr)),license_nbr,LOCAL),
											 TRIM(LEFT.NAME_ORG[1..50],LEFT,RIGHT)	= TRIM(RIGHT.NAME_ORG[1..50],LEFT,RIGHT)
											 AND TRIM(LEFT.LICENSE_NBR[1..10],LEFT,RIGHT) = TRIM(RIGHT.LICENSE_NBR[1..10],LEFT,RIGHT)
											 AND LEFT.affil_type_cd = 'BR',
											 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);
												

	// Adding to Superfile
  ds_map_deduped 			:= DEDUP(ds_map_affil,RECORD,ALL,LOCAL);

	d_final 						:= OUTPUT(ds_map_deduped, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);		
	
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil);

	move_to_used := parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'lender', 'using', 'used'),
	                         Prof_License_Mari.func_move_file.MyMoveFile(code, 'branch', 'using', 'used'));

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation,oFile, d_final,add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

