import MDR;
EXPORT ConvertAMStoHeader (DATASET (Layouts.AMS_DID) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (Layouts.AMS_DID L) := TRANSFORM 
		SELF.RID													:=	0;
		SELF.LNPID												:=	0;
		SELF.DID													:=	(INTEGER)L.DID;
		SELF.BDID													:=	(INTEGER)L.bdid;

		SELF.DOTID												:= 	0;
		SELF.EMPID												:= 	0;
		SELF.POWID												:= 	0;
		SELF.PROXID												:= 	0;
		SELF.SELEID												:=	0;
		SELF.ORGID												:= 	0;
		SELF.ULTID												:= 	0;

		SELF.SRC													:=	MDR.SourceTools.src_AMS;
		SELF.SOURCE_RID										:=	L.SOURCE_REC_ID;
		
		SELF.CLEAVEPENALTY								:=	0;
		
		SELF.DT_FIRST_SEEN								:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_first_seen,8,1)),(INTEGER)L.dt_first_seen,0);
		SELF.DT_LAST_SEEN									:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_last_seen,8,1)),(INTEGER)L.dt_last_seen,0);
		SELF.DT_VENDOR_FIRST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_first_reported,8,1)),(INTEGER)L.dt_vendor_first_reported,0);
		SELF.DT_VENDOR_LAST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_last_reported,8,1)),(INTEGER)L.dt_vendor_last_reported,0);
		SELF.DT_LIC_BEGIN									:=	0;
		SELF.DT_LIC_EXPIRATION						:=	0;
		SELF.DT_DEA_EXPIRATION						:=	IF(HealthCareProvider.isValidDate(L.rawaddressfields.exp_date),(INTEGER)L.rawaddressfields.exp_date,0);
		SELF.DT_NPI_DEACT									:=	0;
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		SELF.DT_BUS_INCORPORATED					:=	0;

		
		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	IF (L.rawaddressfields.gold_record_flag = 'Y','1','2');

		SELF.ENTITY_TYPE									:=	'';
		
		SELF.DID_FLAG											:=	'';						
		SELF.SSN_FLAG											:=	'';	
		SELF.CNSMR_SSN_FLAG								:=	'';
		SELF.DOB_FLAG											:=	'';
		SELF.CNSMR_DOB_FLAG								:=	'';
		SELF.LIC_NBR_FLAG									:=	'';   		
		SELF.C_LIC_NBR_FLAG								:=	'';   
		SELF.FNAME_FLAG										:=	'';		
		SELF.MNAME_FLAG										:=	'';		
		SELF.LNAME_FLAG										:=	'';		
		SELF.CNAME_FLAG										:=	'';		
		SELF.CNP_NAME_FLAG								:=	'';		
		SELF.ADDR_FLAG										:=	'';		
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.BILLING_TAX_ID_FLAG					:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.DERIVED_FEIN_FLAG						:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.BILLING_NPI_NUMBER_FLAG			:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	'';		
		SELF.FAX_FLAG											:=	'';		
		SELF.CLIA_NUMBER_FLAG							:=	'';
		SELF.TAXONOMY_FLAG								:=	'';
		SELF.MEDICARE_FACILITY_NUMBER_FLAG:=	'';
		SELF.MEDICAID_NUMBER_FLAG					:=	'';
		SELF.NCPDP_NUMBER_FLAG						:=	'';
		
		SELF.IS_STATE_SANCTION						:=	FALSE;
		SELF.IS_OIG_SANCTION							:=	FALSE;
		SELF.IS_OPM_SANCTION							:=	FALSE;
		
		SELF.IS_PUBLIC_PRIVATE_COMP				:=	FALSE;
		SELF.IS_PROFIT_NONPROFIT_COMP			:=	FALSE;
		
		SELF.SUPPRESS_ADDRESS							:=	'';
		
		SELF.SSN													:=	'';
		SELF.CNSMR_SSN										:=	'';
		SELF.DOB													:=	IF (isValidDOB(L.rawdemographicsfields.dob_date),(INTEGER)L.rawdemographicsfields.dob_date,0);
		SELF.CNSMR_DOB										:=	0;
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.clean_phones.phone);
		SELF.FAX													:=	'';

		SELF.LIC_NBR											:=	'';
		SELF.C_LIC_NBR										:=	'';
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		SELF.LIC_STATUS										:=	'';

		isCleaned													:=	L.clean_name.fname <> '' AND L.clean_name.lname <> '';
		TITLE															:=	IF (isCleaned,L.clean_name.title,'');
		FNAME															:=	IF (isCleaned,L.clean_name.fname,l.rawdemographicsfields.first_name);
		MNAME															:=	IF (isCleaned,L.clean_name.mname,l.rawdemographicsfields.middle_name);
		LNAME															:=	IF (isCleaned,L.clean_name.lname,l.rawdemographicsfields.last_name);
		SNAME															:=	IF (isCleaned,L.clean_name.name_suffix,l.rawdemographicsfields.suffix_name);

		SELF.TITLE												:=	TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(title)),' '))),LEFT,RIGHT);
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(fname)),' '))),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(mname)),' '))),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(lname)),' '))),LEFT,RIGHT);	 
		SUFFIX_NAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(sname)),' '))),LEFT,RIGHT);
		SELF.SNAME												:=	IF (SELF.MNAME = SUFFIX_NAME,'',SUFFIX_NAME);
		SELF.CNAME												:=	'';
		SELF.CNP_NAMEID										:=	0;
		SELF.CNP_NAME											:=	'';
		SELF.CNP_NUMBER										:=	'';	
		SELF.CNP_STORE_NUMBER							:=	'';
		SELF.CNP_BTYPE										:=	'';		
		SELF.CNP_LOWV											:=	'';
		SELF.CNP_TRANSLATED							 	:= false;
		SELF.CNP_CLASSID 									:= 0;
		
		SELF.SIC_CODE											:=	'';
		GENDER														:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.rawdemographicsfields.gen_cd));
		SELF.GENDER												:=	IF (GENDER IN ['M','F'],GENDER,'');
		
		SELF.DERIVED_GENDER								:=	'';

		SELF.ADDRESS_ID										:=	L.rawaddressfields.ace_aid;
		SELF.ADDRESS_CLASSIFICATION				:=	'';

		SELF.PRIM_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.prim_range)); 
		SELF.PREDIR												:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.predir));		
		SELF.PRIM_NAME										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.prim_name));
		SELF.ADDR_SUFFIX									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.addr_suffix));
		SELF.POSTDIR											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.postdir));		
		SELF.UNIT_DESIG										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.unit_desig));
		SELF.SEC_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.sec_range));
		SELF.P_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.p_city_name));
		SELF.V_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.v_city_name));
		SELF.ST														:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.st));		
		SELF.ZIP													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.zip));		
		SELF.ZIP4													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.zip4));		
		SELF.CART													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.cart));		
		SELF.CR_SORT_SZ										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.cr_sort_sz));
		SELF.LOT													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.lot));		
		SELF.LOT_ORDER										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.lot_order));
		SELF.DBPC													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.dbpc));		
		SELF.CHK_DIGIT										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.chk_digit));
		SELF.REC_TYPE											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.rec_type));
		SELF.FIPS_STATE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.fips_state));
		SELF.FIPS_COUNTY									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.fips_county));
		SELF.GEO_LAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.geo_lat));	
		SELF.GEO_LONG											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.geo_long));
		SELF.MSA													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.msa));		
		SELF.GEO_BLK											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.geo_blk));
		SELF.GEO_MATCH										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.geo_match));
		SELF.ERR_STAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.clean_company_address.err_stat));

		SELF.DEATH_IND										:=	IF (L.rawdemographicsfields.status = 'D','Y','');
		SELF.DOD													:=	0; 
		
		SELF.TAX_ID												:=	(INTEGER)L.rawdemographicsfields.tax_id;
		SELF.BILLING_TAX_ID								:=	(INTEGER)L.rawdemographicsfields.tax_id;
		SELF.FEIN													:=	0;
		SELF.DERIVED_FEIN									:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.BILLING_NPI_NUMBER						:=	'';
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	L.rawaddressfields.dea_num;
		SELF.CLIA_NUMBER									:=	'';
		SELF.TAXONOMY											:=	'';
		SELF.TAXONOMY_CODE								:=	'';
		SELF.MEDICARE_FACILITY_NUMBER			:=	'';
		SELF.MEDICAID_NUMBER							:=	'';
		SELF.NCPDP_NUMBER									:=	'';
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.ams_id;
	END;

	Provider_DS := PROJECT (Infile (RECORD_TYPE = 'C'),getProviderInfo (LEFT)) (TRIM(LNAME) <> '' AND TRIM(FNAME) <> '' AND TRIM(ZIP) <> '' AND TRIM(PRIM_NAME) <> '');

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));
	
	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,FNAME,MNAME,LNAME,SNAME,DOB,PHONE,GENDER,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,DEA_NUMBER,-DT_LAST_SEEN,-DT_VENDOR_LAST_REPORTED,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,FNAME,MNAME,LNAME,SNAME,DOB,PHONE,GENDER,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,DEA_NUMBER,LOCAL);
	
	LIC_DS	:=	DISTRIBUTE (HealthCareProvider.files.AMS_LIC_DS(RECORD_TYPE = 'C'),HASH32(AMS_ID));

	S_LIC_DS	:=	DEDUP(SORT (LIC_DS,AMS_ID,RAWFIELDS.ST_LIC_NUM, RAWFIELDS.ST_LIC_STATE, RAWFIELDS.ST_LIC_TYPE,LOCAL),AMS_ID,RAWFIELDS.ST_LIC_NUM, RAWFIELDS.ST_LIC_STATE, RAWFIELDS.ST_LIC_TYPE,LOCAL);

	ADD_LIC_DS	:=	JOIN (DE_Provider_DS,S_LIC_DS,LEFT.VENDOR_ID = RIGHT.AMS_ID, // AND LEFT.ST = RIGHT.RAWFIELDS.ST_LIC_STATE, 
													TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
													SELF.DT_LIC_EXPIRATION	:=	IF (HealthCareProvider.isValidDate(RIGHT.RAWFIELDS.ST_LIC_EXP_DATE),(INTEGER)RIGHT.RAWFIELDS.ST_LIC_EXP_DATE,0);
													SELF.LIC_NBR := RIGHT.RAWFIELDS.ST_LIC_NUM;		
													C_LIC_NBR				:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(CleanData.DL_No,stringLib.stringToUpperCase(RIGHT.RAWFIELDS.ST_LIC_NUM),''),LEFT,RIGHT)),''),LEFT,RIGHT);
													SELF.C_LIC_NBR	:=	Clean_License (C_LIC_NBR);
													SELF.LIC_STATE 	:= RIGHT.RAWFIELDS.ST_LIC_STATE; SELF.LIC_TYPE := RIGHT.RAWFIELDS.ST_LIC_DEGREE; SELF := LEFT;), LEFT OUTER, LOCAL);
	
	NPI_DS	:=	DISTRIBUTE (HealthCareProvider.files.AMS_NPI_DS(RECORD_TYPE = 'C'),HASH32(AMS_ID)) (src_cd_desc = 'NPI');
	D_ADD_LIC_DS	:=	DISTRIBUTE (ADD_LIC_DS,HASH32(VENDOR_ID));
	
	S_NPI_DS	:=	DEDUP(SORT (NPI_DS(RAWFIELDS.INDY_ID <> ''),AMS_ID,RAWFIELDS.INDY_ID, LOCAL),AMS_ID,RAWFIELDS.INDY_ID,LOCAL);

	NPI_REC := RECORD
		STRING8 AMS_ID;
		STRING10	NPI;
	END;
	
	NPI_DSN	:= PROJECT (S_NPI_DS,TRANSFORM(NPI_REC, SELF.NPI := LEFT.RAWFIELDS.INDY_ID; SELF := LEFT;));

	T_NPI	:=	TABLE (NPI_DSN,{AMS_ID, NPI, CNT := COUNT(GROUP)},AMS_ID,MERGE);

	Good_NPI := PROJECT (T_NPI(CNT = 1),TRANSFORM(NPI_REC, SELF := LEFT;));

	ADD_NPI_DS	:=	JOIN (D_ADD_LIC_DS,GOOD_NPI,LEFT.VENDOR_ID = RIGHT.AMS_ID, 
													TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.NPI_NUMBER := RIGHT.NPI; SELF := LEFT;), LEFT OUTER,LOCAL);

	Minimum_Data := ADD_NPI_DS(TRIM(Lname) <> '' and TRIM(FNAME) <> '' and (INTEGER)TRIM(zip) > 0 and TRIM(PRIM_NAME) <> '');
	
	Remove_Duplicates := PROJECT (Minimum_Data,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
		SELF.LNPID := HASH64(LEFT.DID + LEFT.DOB + 
												LEFT.PHONE + LEFT.FNAME + LEFT.MNAME + LEFT.LNAME + LEFT.SNAME + LEFT.GENDER + LEFT.PRIM_RANGE + LEFT.PRIM_NAME + LEFT.SEC_RANGE + LEFT.V_CITY_NAME + LEFT.ST + LEFT.ZIP +
												LEFT.DEATH_IND + LEFT.TAX_ID + LEFT.DEA_NUMBER + LEFT.VENDOR_ID + LEFT.LIC_NBR + LEFT.C_LIC_NBR + LEFT.LIC_STATE + LEFT.LIC_TYPE + LEFT.NPI_NUMBER);

		SELF := LEFT;));

	AMS_Provider_DS := PROJECT(DEDUP(SORT (DISTRIBUTE(Remove_Duplicates,HASH32(LNPID)),LNPID,-DT_LIC_EXPIRATION,-DT_DEA_EXPIRATION,-DT_VENDOR_LAST_REPORTED,-DT_LAST_SEEN,LOCAL),LNPID,LOCAL),TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.LNPID := 0; SELF.CONSUMER_DISCLOSURE := ''; SELF := LEFT;));
	// output (Provider_DS,named('Provider_DS'));
	// output (ADD_LIC_DS,named('ADD_LIC_DS'));
	// output (ADD_NPI_DS,named('ADD_NPI_DS'));
	// output (Remove_Duplicates,named('Remove_Duplicates'));
	// output (AMS_Provider_DS,named('AMS_Provider_DS'));
	RETURN AMS_Provider_DS ;
END;