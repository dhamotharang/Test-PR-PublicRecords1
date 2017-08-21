import MDR;
EXPORT ConvertProfLICtoHeader (DATASET (Layouts.PROF_LIC) Infile) := FUNCTION

	SET_LIC_TYPE := SET (HealthCareProvider.Files.LIC_TYPE_DS, LIC_TYPE);
	
	Filter_Non_Providers := INFILE (TRIM (category1) IN ['DENTAL','MEDICAL','MEDICINE','NURSING','NURSING HOME','VETERINARY'] OR 
																  TRIM (license_type) IN SET_LIC_TYPE OR
																	TRIM (profession_or_board) IN ['RADIOLOGY','CHIROPRACTORS','HEALTH','DENTAL BOARD OF CALIFORNIA','MEDICAL','NURSING BOARD','DENTISTRY','DENTAL HYGIENE',
																																 'OPTOMETRY','DIETITIAN','MEDICINE','NURSING BOARD','PHARMACY']);
	
	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (Layouts.PROF_LIC L, INTEGER C) := TRANSFORM,SKIP((C = 1 AND TRIM(L.orig_license_number) = '') OR (C = 2 AND TRIM(L.license_number) = '') OR (C = 3 AND TRIM(L.previous_license_number) = '')) 
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

		SELF.SRC													:=	MDR.SourceTools.src_Professional_License;
		SELF.SOURCE_RID										:=	L.source_rec_id;

		SELF.DT_FIRST_SEEN								:=	IF(HealthCareProvider.isValidDate(L.date_first_seen),(INTEGER)L.date_first_seen,0);
		SELF.DT_LAST_SEEN									:=	IF(HealthCareProvider.isValidDate(L.date_last_seen),(INTEGER)L.date_last_seen,0);
		SELF.DT_VENDOR_FIRST_REPORTED			:=	0;
		SELF.DT_VENDOR_LAST_REPORTED			:=	0;
		SELF.DT_LIC_BEGIN									:=	IF(HealthCareProvider.isValidDate(L.issue_date),(INTEGER)L.issue_date,0);
		SELF.DT_LIC_EXPIRATION						:=	IF(HealthCareProvider.isValidDate(L.expiration_date),(INTEGER)L.expiration_date,0);
		SELF.DT_DEA_EXPIRATION						:=	0;
		SELF.DT_NPI_DEACT									:=	0;
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		SELF.DT_BUS_INCORPORATED					:=	0;
		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';
		
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
		SELF.CNSMR_SSN										:=	IF(HealthCareProvider.isValidSSN(L.BEST_SSN),L.BEST_SSN,'');
		SELF.DOB													:=	IF (isValidDOB(L.DOB),(INTEGER)L.DOB,0);
		SELF.CNSMR_DOB										:=	0;
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.Phone);
		SELF.FAX													:=	HealthCareProvider.Clean_Phone(l.misc_fax);
		License_NO												:=	IF (TRIM (L.license_number) <> '',L.license_number,L.orig_license_number);
		LIC_NO														:=	MAP (C = 1 => License_NO , C = 2 => License_NO, L.previous_license_number);
		LIC_NBR														:=	IF (LIC_NO IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NO);
		SELF.LIC_NBR											:=	LIC_NBR;
		C_LIC_NBR													:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(CleanData.DL_No,stringLib.stringToUpperCase(LIC_NBR),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.C_LIC_NBR										:=	Clean_License (C_LIC_NBR);
		SELF.LIC_STATE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.source_st));
		SELF.LIC_TYPE											:=	MAP (C = 1 => L.license_type, C = 2 => L.license_type, L.previous_license_type);
		SELF.LIC_STATUS										:=	L.STATUS;
		
		SELF.TITLE												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.title)),' ')),LEFT,RIGHT);
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.fname)),' ')),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.mname)),' ')),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.lname)),' ')),LEFT,RIGHT);
		SELF.SNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.name_suffix)),' ')),LEFT,RIGHT);	
		SELF.SIC_CODE											:=	'';
		SELF.CNAME												:=	'';
		SELF.CNP_NAMEID										:=	0;
		SELF.CNP_NAME											:=	'';
		SELF.CNP_NUMBER										:=	'';	
		SELF.CNP_STORE_NUMBER							:=	'';
		SELF.CNP_BTYPE										:=	'';		
		SELF.CNP_LOWV											:=	'';
		SELF.CNP_TRANSLATED							 	:= false;
		SELF.CNP_CLASSID 									:= 0;
		
		GENDER														:=	MAP (L.sex = 'MALE' => 'M', L.sex = 'FEMALE' => 'F', '');
		SELF.GENDER												:=	stringLib.stringToUpperCase(GENDER);
		SELF.DERIVED_GENDER								:=	'';
		SELF.ADDRESS_ID										:=	L.aceaid;
		SELF.ADDRESS_CLASSIFICATION				:=	'';
		
		SELF.PRIM_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.prim_range)); 
		SELF.PREDIR												:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.predir));		
		SELF.PRIM_NAME										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.prim_name));
		SELF.ADDR_SUFFIX									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.suffix));
		SELF.POSTDIR											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.postdir));		
		SELF.UNIT_DESIG										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.unit_desig));
		SELF.SEC_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.sec_range));
		SELF.P_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.p_city_name));
		SELF.V_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.v_city_name));
		SELF.ST														:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.st));		
		SELF.ZIP													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.zip));		
		SELF.ZIP4													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.zip4));		
		SELF.CART													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.cart));		
		SELF.CR_SORT_SZ										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.cr_sort_sz));
		SELF.LOT													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.lot));		
		SELF.LOT_ORDER										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.lot_order));
		SELF.DBPC													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.dpbc));		
		SELF.CHK_DIGIT										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.chk_digit));
		SELF.REC_TYPE											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.record_type));
		SELF.FIPS_STATE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.ace_fips_st));
		SELF.FIPS_COUNTY									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.county));
		SELF.GEO_LAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.geo_lat));	
		SELF.GEO_LONG											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.geo_long));
		SELF.MSA													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.msa));		
		SELF.GEO_BLK											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.geo_blk));
		SELF.GEO_MATCH										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.geo_match));
		SELF.ERR_STAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	0;
		SELF.BILLING_TAX_ID								:=	0;
		SELF.FEIN													:=	0;
		SELF.DERIVED_FEIN									:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.BILLING_NPI_NUMBER										:=	'';
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	'';
		SELF.CLIA_NUMBER									:=	'';
		SELF.TAXONOMY											:=	'';
		SELF.TAXONOMY_CODE								:=	'';
		SELF.MEDICARE_FACILITY_NUMBER			:=	'';
		SELF.MEDICAID_NUMBER							:=	'';
		SELF.NCPDP_NUMBER									:=	'';
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.prolic_key;
		SELF.CleavePenalty								:=	0;
	END;

	Provider_DS := NORMALIZE (Filter_Non_Providers,3,getProviderInfo (LEFT,COUNTER)) (TRIM(LNAME) <> '' AND TRIM(FNAME) <> '' AND TRIM(ZIP) <> '' AND TRIM(PRIM_NAME) <> '');

	Filter_State := Provider_DS (ST IN HealthCareProvider.Constants.Prof_LIC_ST OR LIC_STATE IN HealthCareProvider.Constants.Prof_LIC_ST);
	
	D_Provider_DS := DISTRIBUTE (Filter_State,HASH32(VENDOR_ID));
	
	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,LNAME,FNAME,MNAME,SNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,LIC_NBR,-DT_LIC_EXPIRATION,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,LNAME,FNAME,MNAME,SNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,LIC_NBR,LOCAL);
	
	Filter_Data :=	DE_Provider_DS (TRIM(Lname) <> '' and TRIM(FNAME) <> '' and (INTEGER)TRIM(zip) > 0 and TRIM(PRIM_NAME) <> '');
	
	Filter_Bad_Data :=	Filter_Data (~((FNAME IN  ['KAISER','EYE','PERMANENETE','PERMANTENE','PERMENENTE','EYE','PERMANETE','SOUTHERN','VOID','NEURO','SPINE','CARE','INTERMED','ORTHOPADIC','PEDS'] OR
																	 LNAME IN  ['PERMANENTE','MASS','PERMANENTE','PERMANENTE','PREMANENTE','PERMANENTE','PERMANENTE','PERMANENTE','PERMANENTE','KEISER','PERMANENTE','PERMANENTE','PERMANENTE','GROUP','VOID','SPINE','CARE'])));
	
	RETURN Filter_Bad_Data;
END;