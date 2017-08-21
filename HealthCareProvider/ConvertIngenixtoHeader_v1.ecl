import MDR, CLUEAuto;
EXPORT ConvertIngenixtoHeader (DATASET (Layouts.INGENIX_DID) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (Layouts.INGENIX_DID L) := TRANSFORM 
		SELF.RID													:=	0;
		SELF.HCID													:=	0;
		SELF.DID													:=	(INTEGER)L.DID;
		SELF.BDID													:=	0;

		SELF.DOTID												:= 	0;
		SELF.EMPID												:= 	0;
		SELF.POWID												:= 	0;
		SELF.PROXID												:= 	0;
		SELF.SELEID												:=	0;
		SELF.ORGID												:= 	0;
		SELF.ULTID												:= 	0;

		SELF.SRC													:=	MDR.SourceTools.src_Ingenix_Sanctions;
		SELF.SOURCE_RID										:=	0;

		SELF.DT_FIRST_SEEN								:=	(INTEGER)L.dt_first_seen;
		SELF.DT_LAST_SEEN									:=	(INTEGER)L.dt_last_seen;
		SELF.DT_VENDOR_FIRST_REPORTED			:=	(INTEGER)L.dt_vendor_first_reported;
		SELF.DT_VENDOR_LAST_REPORTED			:=	(INTEGER)L.dt_vendor_last_reported;
		SELF.DT_LIC_EXPIRATION						:=	0;
		SELF.DT_DEA_EXPIRATION						:=	0;

		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';
		SELF.SSN_FLAG											:=	'';		
		SELF.DOB_FLAG											:=	'';		
		SELF.LIC_NBR_FLAG									:=	'';   
		SELF.FNAME_FLAG										:=	'';		
		SELF.MNAME_FLAG										:=	'';		
		SELF.LNAME_FLAG										:=	'';		
		SELF.ADDR_FLAG										:=	'';		
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	'';		
		SELF.CLIA_NUMBER_FLAG							:=	'';
		
		SELF.SUPPRESS_ADDRESS							:=	'';
		
		SELF.SSN													:=	'';
		SELF.DOB													:=	(INTEGER)L.birthdate;
		SELF.PHONE												:=	L.phonenumber;

		SELF.LIC_NBR											:=	'';
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		
		SELF.TITLE												:=	'';
		SELF.FNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.firstname)),' '),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.middlename)),' '),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.lastname)),' '),LEFT,RIGHT);	 
		SELF.SNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.suffix)),' '),LEFT,RIGHT);
		SELF.CNAME												:=	'';
		SELF.SIC_CODE											:=	'';
		GENDER														:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.gender));
		SELF.GENDER												:=	IF (GENDER IN ['M','F'],GENDER,'');
		SELF.DERIVED_GENDER								:=	'';

		SELF.ADDRESS_ID										:=	(INTEGER)L.addressid;
		SELF.ADDRESS_CLASSIFICATION				:=	'';
		
		SELF.PRIM_RANGE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_prim_range)); 
		SELF.PREDIR												:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_predir));		
		SELF.PRIM_NAME										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_prim_name));
		SELF.ADDR_SUFFIX									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_addr_suffix));
		SELF.POSTDIR											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_postdir));		
		SELF.UNIT_DESIG										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_unit_desig));
		SELF.SEC_RANGE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_sec_range));
		SELF.P_CITY_NAME									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_p_city_name));
		SELF.V_CITY_NAME									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_v_city_name));
		SELF.ST														:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_st));		
		SELF.ZIP													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_zip));		
		SELF.ZIP4													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_zip4));		
		SELF.CART													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_cart));		
		SELF.CR_SORT_SZ										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_cr_sort_sz));
		SELF.LOT													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_lot));		
		SELF.LOT_ORDER										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_lot_order));
		SELF.DBPC													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_dpbc));		
		SELF.CHK_DIGIT										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_chk_digit));
		SELF.REC_TYPE											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_record_type));
		SELF.FIPS_STATE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.prov_clean_ace_fips_st));
		SELF.FIPS_COUNTY									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.prov_clean_fipscounty));
		SELF.GEO_LAT											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_geo_lat));	
		SELF.GEO_LONG											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_geo_long));
		SELF.MSA													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_msa));		
		SELF.GEO_BLK											:=	'';
		SELF.GEO_MATCH										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_geo_match));
		SELF.ERR_STAT											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_err_stat));

		SELF.DEATH_IND										:=	IF (L.deceasedindicator <> '','Y','');
		SELF.DOD													:=	(INTEGER)L.deceaseddate;
		
		SELF.TAX_ID												:=	(INTEGER)L.taxid;
		SELF.FEIN													:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.DEA_NUMBER										:=	'';
		SELF.CLIA_NUMBER									:=	'';
		SELF.VENDOR_ID										:=	L.providerid;
	END;

	Provider_DS := PROJECT (Infile,getProviderInfo (LEFT));

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(Vendor_ID));
	
	S_Provider_DS	:=	DEDUP (SORT (D_Provider_DS,VENDOR_ID,LNAME,FNAME,MNAME,SNAME,GENDER,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,DOB,LOCAL),VENDOR_ID,LNAME,FNAME,MNAME,SNAME,GENDER,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,DOB,LOCAL);
	
	D_DEA_DS :=	DISTRIBUTE (HealthCareProvider.Files.DEA_DS,HASH32(PROVIDERID));
	
	S_DEA_DS := DEDUP (SORT (D_DEA_DS,PROVIDERID,DEANUMBER, -DT_VENDOR_LAST_REPORTED, LOCAL),PROVIDERID,DEANUMBER,LOCAL);
	
	ADD_DEA_NO	:=	JOIN (S_Provider_DS,S_DEA_DS,LEFT.VENDOR_ID = RIGHT.PROVIDERID,
												TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
												SELF.DEA_NUMBER := RIGHT.DEANUMBER; SELF.DT_DEA_EXPIRATION := LEFT.DT_VENDOR_LAST_REPORTED; SELF := LEFT;), LEFT OUTER, LOCAL);

	D_DEANO_DS	:=	DISTRIBUTE (ADD_DEA_NO,HASH32(VENDOR_ID));
	
	D_NPI_DS :=	DISTRIBUTE (HealthCareProvider.Files.NPI_DS,HASH32(PROVIDERID));
	
	S_NPI_DS := DEDUP (SORT (D_NPI_DS,PROVIDERID,NPI,LOCAL),PROVIDERID,NPI,LOCAL);
	
	ADD_NPI_NO	:=	JOIN (D_DEANO_DS,S_NPI_DS,LEFT.VENDOR_ID = RIGHT.PROVIDERID,
												TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.NPI_NUMBER := RIGHT.npi; SELF := LEFT;), LEFT OUTER, LOCAL);

	Clean_LIC_DS	:=	PROJECT (HealthCareProvider.Files.LIC_DS ,TRANSFORM(HealthCareProvider.Layouts.INGENIX_LIC, self.licensenumber := TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(CLUEAuto.Constants.DL_No,stringLib.stringToUpperCase(Left.licensenumber),''),LEFT,RIGHT)),''),LEFT,RIGHT); self := left;));
	
	D_LIC_DS	:=	DISTRIBUTE (Clean_LIC_DS,HASH32(PROVIDERID));

	S_LIC_DS := DEDUP (SORT	(D_LIC_DS,PROVIDERID,LICENSENUMBER,LICENSESTATE,TERMINATION_DATE,LOCAL),PROVIDERID,LICENSENUMBER,LICENSESTATE,LOCAL);
	
	D_ADD_NPI_DS := DISTRIBUTE (ADD_NPI_NO,HASH32(VENDOR_ID));

	ADD_LIC_DS := JOIN (D_ADD_NPI_DS,S_LIC_DS,LEFT.VENDOR_ID = RIGHT.providerid AND LEFT.ST = RIGHT.LICENSESTATE,
											TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.LIC_NBR := RIGHT.licensenumber; SELF.LIC_STATE := RIGHT.licensestate;  SELF := LEFT;), LEFT OUTER, LOCAL);

	D_UPIN_DS	:=	DISTRIBUTE (HealthCareProvider.Files.UPIN_DS,HASH32(PROVIDERID));

	S_UPIN_DS := DEDUP (SORT	(D_UPIN_DS,PROVIDERID,UPIN,LOCAL),PROVIDERID,UPIN,LOCAL);
	
	D_ADD_LIC_DS := DISTRIBUTE (ADD_LIC_DS,HASH32(VENDOR_ID));

	ADD_UPIN_DS := JOIN (D_ADD_LIC_DS,S_UPIN_DS,LEFT.VENDOR_ID = RIGHT.providerid,
											TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.UPIN := RIGHT.UPIN; SELF := LEFT;), LEFT OUTER, LOCAL);

	D_DS	:=	DISTRIBUTE (ADD_UPIN_DS,HASH32(VENDOR_ID));
	
	S_DS	:=	DEDUP (SORT (D_DS,VENDOR_ID,LNAME,FNAME,MNAME,SNAME,GENDER,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,DOB,LIC_NBR,LIC_STATE,UPIN,NPI_NUMBER,DEA_NUMBER,LOCAL),VENDOR_ID,LNAME,FNAME,MNAME,SNAME,GENDER,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,DOB,LIC_NBR,LIC_STATE,UPIN,NPI_NUMBER,DEA_NUMBER,LOCAL);
	OUTPUT (COUNT(Provider_DS),NAMED('RawProviderCount'));
	OUTPUT (COUNT(S_Provider_DS),NAMED('DedupedProviderCount'));	
	OUTPUT (COUNT(S_DEA_DS),NAMED('DEADatasetCount'));
	OUTPUT (COUNT(ADD_DEA_NO),NAMED('ADDDEADatasetCount'));	
	OUTPUT (COUNT(ADD_NPI_NO),NAMED('ADDNPIDatasetCount'));	
	OUTPUT (COUNT(ADD_LIC_DS),NAMED('ADDLICDatasetCount'));	
	OUTPUT (COUNT(ADD_UPIN_DS),NAMED('ADDUPINDatasetCount'));		
	OUTPUT (COUNT(S_DS),NAMED('FinalCount'));		
	OUTPUT (COUNT(DEDUP(SORT(S_DS,VENDOR_ID,LOCAL),VENDOR_ID,LOCAL)),NAMED('VendorIDCount'));		
	RETURN S_DS (Lname <> '' and FNAME <> '' and zip <> '' and PRIM_NAME <> '');
END;

