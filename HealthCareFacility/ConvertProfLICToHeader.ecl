import MDR, HealthCareProvider, CCLUE_Contribution;
EXPORT ConvertProfLICtoHeader (DATASET (HealthCareProvider.Layouts.PROF_LIC) Infile = HealthCareFacility.Files.PROF_LIC_DS) := FUNCTION

	SET_LIC_TYPE := SET (HealthCareProvider.Files.LIC_TYPE_DS, LIC_TYPE);
	Remove_Provider			 :=	INFILE (LENGTH(TRIM(orig_name)) = 0);
	Filter_Non_Providers := Remove_Provider (TRIM (category1) IN ['DENTAL','MEDICAL','MEDICINE','NURSING','NURSING HOME','VETERINARY'] OR 
																					 TRIM (license_type) IN SET_LIC_TYPE OR
																					 TRIM (profession_or_board) IN ['RADIOLOGY','CHIROPRACTORS','HEALTH','DENTAL BOARD OF CALIFORNIA','MEDICAL','NURSING BOARD','DENTISTRY','DENTAL HYGIENE',
																																					'OPTOMETRY','DIETITIAN','MEDICINE','NURSING BOARD','PHARMACY']);
	
	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (HealthCareProvider.Layouts.PROF_LIC L, INTEGER C) := TRANSFORM,SKIP((C = 1 AND TRIM(L.orig_license_number) = '') OR (C = 2 AND TRIM(L.license_number) = '') OR (C = 3 AND TRIM(L.previous_license_number) = '') OR LENGTH(TRIM(L.Company_Name)) = 0 OR LENGTH(TRIM(L.PRIM_NAME)) = 0 OR LENGTH(TRIM(L.ZIP)) = 0) 
		SELF.RID													:=	0;
		SELF.LNPID												:=	0;
		SELF.DID													:=	(INTEGER)L.DID;
		SELF.BDID													:=	(INTEGER)L.bdid;

		SELF.DOTID												:= 	L.DOTID;
		SELF.EMPID												:= 	L.EMPID;
		SELF.POWID												:= 	L.POWID;
		SELF.PROXID												:= 	L.PROXID;
		SELF.SELEID												:=	L.SELEID;
		SELF.ORGID												:= 	L.ORGID;
		SELF.ULTID												:= 	L.ULTID;

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

		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';
		SELF.DID_FLAG											:=	'';						
		SELF.SSN_FLAG											:=	'';		
		SELF.DOB_FLAG											:=	'';		
		SELF.C_LIC_NBR_FLAG								:=	'';   
		SELF.FNAME_FLAG										:=	'';		
		SELF.MNAME_FLAG										:=	'';		
		SELF.LNAME_FLAG										:=	'';		
		SELF.CNAME_FLAG										:=	'';				
		SELF.ADDR_FLAG										:=	'';		
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	'';		
		SELF.FAX_FLAG											:=	'';		
		SELF.CLIA_NUMBER_FLAG							:=	'';
		SELF.TAXONOMY_FLAG								:=	'';
		
		SELF.SUPPRESS_ADDRESS							:=	'';

		SELF.SSN													:=	'';
		SELF.DOB													:=	0;
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.Phone);
		SELF.FAX													:=	HealthCareProvider.Clean_Phone(l.misc_fax);
		License_NO												:=	IF (TRIM (L.license_number) <> '',L.license_number,L.orig_license_number);
		LIC_NO														:=	MAP (C = 1 => License_NO , C = 2 => License_NO, L.previous_license_number);
		LIC_NBR														:=	IF (LIC_NO IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NO);
		SELF.LIC_NBR											:=	LIC_NBR;
		C_LIC_NBR													:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(LIC_NBR),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.C_LIC_NBR										:=	HealthCareProvider.Clean_License (C_LIC_NBR);
		LIC_STATE													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.source_st));
		SELF.LIC_STATE										:=	IF (LENGTH(TRIM(LIC_STATE)) = 2,LIC_STATE,'');
		SELF.LIC_TYPE											:=	MAP (C = 1 => L.license_type, C = 2 => L.license_type, L.previous_license_type);
		SELF.LIC_STATUS										:=	L.STATUS;
		
		SELF.TITLE												:=	L.TITLE;
		SELF.FNAME												:=	L.FNAME;
		SELF.MNAME												:=	L.MNAME;
		SELF.LNAME												:=	L.LNAME;
		SELF.SNAME												:=	L.NAME_SUFFIX;
		SELF.SIC_CODE											:=	'';
		SELF.CNAME												:=	L.Company_Name; //HealthCareFacility.FacilityNameCleaner.fnCleanAsConfigured(L.Company_Name);
		SELF.CNP_NAMEID										:=	0;
		SELF.CNP_NAME											:=	'';
		SELF.CNP_NUMBER										:=	'';	
		SELF.CNP_STORE_NUMBER							:=	'';
		SELF.CNP_BTYPE										:=	'';		
		SELF.CNP_LOWV											:=	'';
		SELF.CNP_TRANSLATED							 	:= false;
		SELF.CNP_CLASSID 									:= 0;

		SELF.GENDER												:=	'';
		SELF.DERIVED_GENDER								:=	'';
		SELF.ADDRESS_ID										:=	L.aceaid;
		SELF.ADDRESS_CLASSIFICATION				:=	'';
		
		SELF.PRIM_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prim_range)); 
		SELF.PREDIR												:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.predir));		
		SELF.PRIM_NAME										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prim_name));
		SELF.ADDR_SUFFIX									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.suffix));
		SELF.POSTDIR											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.postdir));		
		SELF.UNIT_DESIG										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.unit_desig));
		SELF.SEC_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.sec_range));
		SELF.P_CITY_NAME									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.p_city_name));
		SELF.V_CITY_NAME									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.v_city_name));
		SELF.ST														:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.st));		
		SELF.ZIP													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.zip));		
		SELF.ZIP4													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.zip4));		
		SELF.CART													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.cart));		
		SELF.CR_SORT_SZ										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.cr_sort_sz));
		SELF.LOT													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.lot));		
		SELF.LOT_ORDER										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.lot_order));
		SELF.DBPC													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.dpbc));		
		SELF.CHK_DIGIT										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.chk_digit));
		SELF.REC_TYPE											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.record_type));
		SELF.FIPS_STATE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.ace_fips_st));
		SELF.FIPS_COUNTY									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.county));
		SELF.GEO_LAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_lat));	
		SELF.GEO_LONG											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_long));
		SELF.MSA													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.msa));		
		SELF.GEO_BLK											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_blk));
		SELF.GEO_MATCH										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_match));
		SELF.ERR_STAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	0;
		SELF.FEIN													:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	'';
		SELF.CLIA_NUMBER									:=	'';
		SELF.TAXONOMY											:=	'';
		SELF.TAXONOMY_CODE								:=	'';
		SELF.MEDICARE_FACILITY_NUMBER			:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.prolic_key;
		SELF.CleavePenalty								:=	0;
		SELF															:=	[];
	END;

	Provider_DS := NORMALIZE (Filter_Non_Providers(business_flag = 'Y'),3,getProviderInfo (LEFT,COUNTER)) (TRIM(CNAME) <> '' AND TRIM(ZIP) <> '' AND TRIM(PRIM_NAME) <> '');

	Filter_State := Provider_DS (ST IN HealthCareProvider.Constants.Prof_LIC_ST OR LIC_STATE IN HealthCareProvider.Constants.Prof_LIC_ST);
	
	D_Provider_DS := DISTRIBUTE (Filter_State,HASH32(VENDOR_ID));
	
	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,LIC_NBR,-DT_LIC_EXPIRATION,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,LIC_NBR,LOCAL);
	
	Filter_Data :=	DE_Provider_DS (TRIM(CName) <> '' and (INTEGER)TRIM(zip) > 0 and TRIM(PRIM_NAME) <> '');
	
	RETURN Filter_Data;
END;