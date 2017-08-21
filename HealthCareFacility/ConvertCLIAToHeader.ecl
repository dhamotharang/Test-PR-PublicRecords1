	import MDR, Address, ut, Enclarity, HealthCareProvider, CCLUE_Contribution;
EXPORT ConvertCLIAToHeader (DATASET (HealthCareFacility.Layouts.CLIA_REC) Infile = HealthCareFacility.Files.CLIA_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getFacilityInfo (HealthCareFacility.Layouts.CLIA_REC L, INTEGER C) := TRANSFORM, SKIP (C = 1 AND TRIM(L.Facility_name) = '' OR 
 																																																																													  C = 2 AND TRIM(L.Facility_name2) = '')
		SELF.RID													:=	0;
		SELF.LNPID												:=	0;
		SELF.DID													:=	L.DID;
		SELF.BDID													:=	L.BDID;

		SELF.DOTID												:= 	L.DOTID;
		SELF.EMPID												:= 	L.EMPID;
		SELF.POWID												:= 	L.POWID;
		SELF.PROXID												:= 	L.PROXID;
		SELF.SELEID												:=	L.SELEID;
		SELF.ORGID												:= 	L.ORGID;
		SELF.ULTID												:= 	L.ULTID;

		SELF.SRC													:=	MDR.SourceTools.src_CLIA;
		SELF.SOURCE_RID										:=	0;

		SELF.DT_FIRST_SEEN								:=	0;
		SELF.DT_LAST_SEEN									:=	0;
		SELF.DT_VENDOR_FIRST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_first_reported,8,1)),(INTEGER)L.dt_vendor_first_reported,0);
		SELF.DT_VENDOR_LAST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_last_reported,8,1)),(INTEGER)L.dt_vendor_last_reported,0);
		SELF.DT_LIC_BEGIN									:=	0;
		SELF.DT_LIC_EXPIRATION						:=	IF(HealthCareProvider.isValidDate(L.EXPIRATION_DATE),(INTEGER)L.EXPIRATION_DATE,0);
		SELF.DT_DEA_EXPIRATION						:=	0;
		SELF.DT_NPI_DEACT									:=	0;
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		SELF.DT_BUS_INCORPORATED					:= 	0;
		
		SELF.CLEAVEPENALTY								:=	0;
		
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
		SELF.CNSMR_SSN										:=	'';
		SELF.DOB													:=	0;
		SELF.CNSMR_DOB										:=	0;
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.Facility_Phone);
		SELF.FAX													:=	'';
		
		SELF.LIC_NBR											:=	'';
		SELF.C_LIC_NBR										:=	'';
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		SELF.LIC_STATUS										:=	'';
		
		SELF.TITLE												:=	'';
		SELF.FNAME												:=	'';
		SELF.MNAME												:=	'';
		SELF.LNAME												:=	'';
		SELF.SNAME												:=	'';
		SELF.SIC_CODE											:=	'';
		// SELF.CNAME												:=	IF (C = 1, HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Facility_Name)),
																										 // HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Facility_Name2)));
		// SELF.CNAME												:=	IF (C = 1, HealthCareFacility.FacilityNameCleaner.fnCleanAsConfigured(L.Facility_Name),
																										 // HealthCareFacility.FacilityNameCleaner.fnCleanAsConfigured(L.Facility_Name2));
		SELF.CNAME												:=	IF (C = 1, L.Facility_Name, L.Facility_Name2);
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
		SELF.ADDRESS_ID										:=	L.ace_aid;
		SELF.ADDRESS_CLASSIFICATION				:=	'';

		SELF.PRIM_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.prim_range)); 
		SELF.PREDIR												:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.predir));		
		SELF.PRIM_NAME										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.prim_name));
		SELF.ADDR_SUFFIX									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.addr_suffix));
		SELF.POSTDIR											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.postdir));		
		SELF.UNIT_DESIG										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.unit_desig));
		SELF.SEC_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.sec_range));
		SELF.P_CITY_NAME									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.p_city_name));
		SELF.V_CITY_NAME									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.v_city_name));
		SELF.ST														:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.st));		
		SELF.ZIP													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.zip));		
		SELF.ZIP4													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.zip4));		
		SELF.CART													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.cart));		
		SELF.CR_SORT_SZ										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.cr_sort_sz));
		SELF.LOT													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.lot));		
		SELF.LOT_ORDER										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.lot_order));
		SELF.DBPC													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.dbpc));		
		SELF.CHK_DIGIT										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.chk_digit));
		SELF.REC_TYPE											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.rec_type));
		SELF.FIPS_STATE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.Fips_State));		
		SELF.FIPS_COUNTY									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.FIPS_county));		
		SELF.GEO_LAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.geo_lat));	
		SELF.GEO_LONG											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.geo_long));
		SELF.MSA													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.msa));		
		SELF.GEO_BLK											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.geo_blk));
		SELF.GEO_MATCH										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.geo_match));
		SELF.ERR_STAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Clean_Company_Address.err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	0;
		SELF.FEIN													:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	'';
		SELF.CLIA_NUMBER									:=	L.CLIA_NUMBER;
		SELF.TAXONOMY											:=	'';
		SELF.TAXONOMY_CODE								:=	'';
		SELF.MEDICARE_FACILITY_NUMBER			:=	'';
		SELF.MEDICAID_NUMBER							:=	'';
		SELF.NCPDP_NUMBER									:=	'';
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.Clia_Number;
		SELF															:= [];
	END;

	Provider_DS := NORMALIZE (Infile,2,getFacilityInfo (LEFT,COUNTER));

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));

	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,SOURCE_RID,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,	VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,LOCAL);
	
	RETURN DE_Provider_DS (TRIM(CNAME) <> '' AND (INTEGER)TRIM(zip) > 0 AND TRIM(PRIM_NAME) <> '');
END;