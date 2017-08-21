	import HealthCareProvider, HealthCareFacility;
EXPORT HeaderPopulationStats (DATASET (HealthCareFacility.Layout_HealthProvider.HealthCareProvider_Header) Header_DS = HealthCareProvider.Files.Provider_Header_DS) := FUNCTION

	STATS_REC := RECORD
			Header_DS.SRC;
			RID_COUNT												:= COUNT(GROUP, Header_Ds.RID > 0); 
			LNPID_COUNT											:= COUNT(GROUP, Header_Ds.LNPID > 0); 
			DID_COUNT												:= COUNT(GROUP, Header_Ds.DID > 0);
			BDID_COUNT											:= COUNT(GROUP, Header_Ds.BDID > 0);
			DOTID_COUNT											:= COUNT(GROUP, Header_Ds.DOTID > 0);
			EMPID_COUNT											:= COUNT(GROUP, Header_Ds.EMPID > 0);
			POWID_COUNT											:= COUNT(GROUP, Header_Ds.POWID > 0); 
			PROXID_COUNT										:= COUNT(GROUP, Header_Ds.PROXID > 0); 
			SELEID_COUNT										:= COUNT(GROUP, Header_Ds.SELEID > 0);
			ORGID_COUNT											:= COUNT(GROUP, Header_Ds.ORGID > 0);
			ULTID_COUNT											:= COUNT(GROUP, Header_Ds.ULTID > 0);

			SRC_COUNT												:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SRC)) > 0);
			SOURCE_RID_COUNT								:= COUNT(GROUP, Header_Ds.SOURCE_RID > 0); 
			DT_FIRST_SEEN_COUNT							:= COUNT(GROUP, Header_Ds.DT_FIRST_SEEN > 0);
			DT_LAST_SEEN_COUNT							:= COUNT(GROUP, Header_Ds.DT_LAST_SEEN > 0); 
			DT_VENDOR_FIRST_REPORTED_COUNT	:= COUNT(GROUP, Header_Ds.DT_VENDOR_FIRST_REPORTED > 0); 
			DT_VENDOR_LAST_REPORTED_COUNT		:= COUNT(GROUP, Header_Ds.DT_VENDOR_LAST_REPORTED > 0); 
			DT_LIC_BEGIN_COUNT							:= COUNT(GROUP, Header_Ds.DT_LIC_BEGIN > 0); 
			DT_LIC_EXPIRATION_COUNT					:= COUNT(GROUP, Header_Ds.DT_LIC_EXPIRATION > 0); 
			DT_DEA_EXPIRATION_COUNT					:= COUNT(GROUP, Header_Ds.DT_DEA_EXPIRATION > 0); 
			DT_NPI_DEACT_COUNT							:= COUNT(GROUP, Header_Ds.DT_NPI_DEACT > 0);
			DT_ADDRESS_VERIFIED_COUNT				:= COUNT(GROUP, Header_Ds.DT_ADDRESS_VERIFIED > 0);
			DT_BUS_INCORPORATED_COUNT				:= COUNT(GROUP, Header_Ds.DT_BUS_INCORPORATED > 0);
			
			SUPPRESS_ADDRESS_COUNT					:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SUPPRESS_ADDRESS)) > 0); 

			ENTITY_TYPE_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.ENTITY_TYPE)) > 0); 
			IS_STATE_SANCTION_COUNT					:= COUNT(GROUP, Header_Ds.IS_STATE_SANCTION = TRUE); 
			IS_OIG_SANCTION_COUNT						:= COUNT(GROUP, Header_Ds.IS_OIG_SANCTION = TRUE); 
			IS_OPM_SANCTION_COUNT						:= COUNT(GROUP, Header_Ds.IS_OPM_SANCTION = TRUE); 
			
			IS_PUBLIC_PRIVATE_COMP_COUNT		:= COUNT(GROUP, Header_Ds.IS_PUBLIC_PRIVATE_COMP = TRUE); 
			IS_PROFIT_NONPROFIT_COMP_COUNT	:= COUNT(GROUP, Header_Ds.IS_PROFIT_NONPROFIT_COMP = TRUE); 						

			SSN_COUNT												:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SSN)) > 0); 
			CNSMR_SSN_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNSMR_SSN)) > 0); 
			DOB_COUNT												:= COUNT(GROUP, Header_Ds.DOB > 0); 
			CNSMR_DOB_COUNT									:= COUNT(GROUP, Header_Ds.CNSMR_DOB > 0); 
			PHONE_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.PHONE)) > 0);
			FAX_COUNT												:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.FAX)) > 0);
			
			LIC_NBR_COUNT										:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_NBR)) > 0); 
			C_LIC_NBR_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.C_LIC_NBR)) > 0); 
			LIC_STATE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_STATE)) > 0);
			LIC_TYPE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_TYPE)) > 0);
			LIC_STATUS_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_STATUS)) > 0);

			TITLE_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.TITLE)) > 0);
			FNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.FNAME)) > 0);
			MNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.MNAME)) > 0);
			LNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LNAME)) > 0);
			SNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SNAME)) > 0);
			CNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNAME)) > 0);
			CNP_NAME_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNP_NAME)) > 0);
			CNP_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNP_NUMBER)) > 0);
			CNP_STORE_NUMBER_COUNT					:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNP_STORE_NUMBER)) > 0);
			CNP_BTYPE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNP_BTYPE)) > 0);
			CNP_LOWV_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNP_LOWV)) > 0);

			SIC_CODE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SIC_CODE)) > 0);
			GENDER_COUNT										:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.GENDER)) > 0); 
			DERIVED_GENDER_COUNT						:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.DERIVED_GENDER)) > 0);

			ADDRESS_ID_COUNT								:= COUNT(GROUP, Header_Ds.ADDRESS_ID > 0);
			ADDRESS_CLASSIFICATION_COUNT		:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.ADDRESS_CLASSIFICATION)) > 0);

			PRIM_RANGE_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.PRIM_RANGE)) > 0);
			PRIM_NAME_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.PRIM_NAME)) > 0);
			SEC_RANGE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SEC_RANGE)) > 0);
			V_CITY_NAME_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.V_CITY_NAME)) > 0); 
			ST_COUNT												:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.ST)) > 0);
			ZIP_COUNT												:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.ZIP)) > 0);

			DEATH_IND_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.DEATH_IND)) > 0); 
			DOD_COUNT												:= COUNT(GROUP, Header_Ds.DOD > 0); 

			TAX_ID_COUNT										:= COUNT(GROUP, Header_Ds.TAX_ID > 0); 
			BILLING_TAX_ID_COUNT						:= COUNT(GROUP, Header_Ds.BILLING_TAX_ID > 0); 			
			FEIN_COUNT											:= COUNT(GROUP, Header_Ds.FEIN > 0);
			DERIVED_FEIN_COUNT							:= COUNT(GROUP, Header_Ds.DERIVED_FEIN > 0);
			UPIN_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.UPIN)) > 0);
			NPI_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.NPI_NUMBER)) > 0); 
			BILLING_NPI_NUMBER_COUNT				:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.BILLING_NPI_NUMBER)) > 0); 
			DEA_BUS_ACT_IND_COUNT						:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.DEA_BUS_ACT_IND)) > 0); 			
			DEA_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.DEA_NUMBER)) > 0); 
			CLIA_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CLIA_NUMBER)) > 0);
			TAXONOMY_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.TAXONOMY)) > 0);
			MEDICARE_FACILITY_COUNT					:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.MEDICARE_FACILITY_NUMBER)) > 0);
			MEDICAID_NUMBER_COUNT						:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.MEDICAID_NUMBER)) > 0);			
			NCPDP_NUMBER_COUNT							:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.NCPDP_NUMBER)) > 0);			
			SPECIALITY_CODE_COUNT						:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SPECIALITY_CODE)) > 0);			
			PROVIDER_STATUS_COUNT						:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.PROVIDER_STATUS)) > 0);			
			VENDOR_ID_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.VENDOR_ID)) > 0); 
	END;
	
	SRC_Stats					   := TABLE (Header_DS,STATS_REC,SRC,FEW);

	HealthCareProviderHeader_Reports.Layouts.Header_Report_Count	xft (HealthCareProviderHeader_Reports.Layouts.Header_Report_Count L, HealthCareProviderHeader_Reports.Layouts.Header_Report_Count R) := TRANSFORM
			SELF.RID_COUNT											:= L.RID_COUNT + R.RID_COUNT;
			SELF.LNPID_COUNT										:= L.LNPID_COUNT + R.LNPID_COUNT;
			SELF.DID_COUNT											:= L.DID_COUNT + R.DID_COUNT;
			SELF.BDID_COUNT											:= L.BDID_COUNT + R.BDID_COUNT;
			SELF.DOTID_COUNT										:= L.DOTID_COUNT + R.DOTID_COUNT;
			SELF.EMPID_COUNT										:= L.EMPID_COUNT + R.EMPID_COUNT;
			SELF.POWID_COUNT										:= L.POWID_COUNT + R.POWID_COUNT;
			SELF.PROXID_COUNT										:= L.PROXID_COUNT + R.PROXID_COUNT;
			SELF.SELEID_COUNT										:= L.SELEID_COUNT + R.SELEID_COUNT;
			SELF.ORGID_COUNT										:= L.ORGID_COUNT + R.ORGID_COUNT;
			SELF.ULTID_COUNT										:= L.ULTID_COUNT + R.ULTID_COUNT;

			SELF.SRC_COUNT											:= L.SRC_COUNT + R.SRC_COUNT;
			SELF.SOURCE_RID_COUNT								:= L.SOURCE_RID_COUNT + R.SOURCE_RID_COUNT;
			SELF.DT_FIRST_SEEN_COUNT						:= L.DT_FIRST_SEEN_COUNT + R.DT_FIRST_SEEN_COUNT;
			SELF.DT_LAST_SEEN_COUNT							:= L.DT_LAST_SEEN_COUNT + R.DT_LAST_SEEN_COUNT;
			SELF.DT_VENDOR_FIRST_REPORTED_COUNT	:= L.DT_VENDOR_FIRST_REPORTED_COUNT + R.DT_VENDOR_FIRST_REPORTED_COUNT;
			SELF.DT_VENDOR_LAST_REPORTED_COUNT	:= L.DT_VENDOR_LAST_REPORTED_COUNT + R.DT_VENDOR_LAST_REPORTED_COUNT;
			SELF.DT_LIC_BEGIN_COUNT							:= L.DT_LIC_BEGIN_COUNT + R.DT_LIC_BEGIN_COUNT;
			SELF.DT_LIC_EXPIRATION_COUNT				:= L.DT_LIC_EXPIRATION_COUNT + R.DT_LIC_EXPIRATION_COUNT;
			SELF.DT_DEA_EXPIRATION_COUNT				:= L.DT_DEA_EXPIRATION_COUNT + R.DT_DEA_EXPIRATION_COUNT;
			SELF.DT_NPI_DEACT_COUNT							:= L.DT_NPI_DEACT_COUNT + R.DT_NPI_DEACT_COUNT;
			SELF.DT_ADDRESS_VERIFIED_COUNT			:= L.DT_ADDRESS_VERIFIED_COUNT + R.DT_ADDRESS_VERIFIED_COUNT;			
			SELF.DT_BUS_INCORPORATED_COUNT			:= L.DT_BUS_INCORPORATED_COUNT + R.DT_BUS_INCORPORATED_COUNT;			
			
			SELF.SUPPRESS_ADDRESS_COUNT					:= L.SUPPRESS_ADDRESS_COUNT + R.SUPPRESS_ADDRESS_COUNT;

			SELF.ENTITY_TYPE_COUNT							:= L.ENTITY_TYPE_COUNT + R.ENTITY_TYPE_COUNT;
			SELF.IS_STATE_SANCTION_COUNT				:= L.IS_STATE_SANCTION_COUNT + R.IS_STATE_SANCTION_COUNT;
			SELF.IS_OIG_SANCTION_COUNT					:= L.IS_OIG_SANCTION_COUNT + R.IS_OIG_SANCTION_COUNT;
			SELF.IS_OPM_SANCTION_COUNT					:= L.IS_OPM_SANCTION_COUNT + R.IS_OPM_SANCTION_COUNT;

			SELF.IS_PUBLIC_PRIVATE_COMP_COUNT		:= L.IS_PUBLIC_PRIVATE_COMP_COUNT + R.IS_PUBLIC_PRIVATE_COMP_COUNT;
			SELF.IS_PROFIT_NONPROFIT_COMP_COUNT	:= L.IS_PROFIT_NONPROFIT_COMP_COUNT + R.IS_PROFIT_NONPROFIT_COMP_COUNT;
			
			SELF.SSN_COUNT											:= L.SSN_COUNT + R.SSN_COUNT;
			SELF.CNSMR_SSN_COUNT								:= L.CNSMR_SSN_COUNT + R.CNSMR_SSN_COUNT;
			SELF.DOB_COUNT											:= L.DOB_COUNT + R.DOB_COUNT;
			SELF.CNSMR_DOB_COUNT								:= L.CNSMR_DOB_COUNT + R.CNSMR_DOB_COUNT;
			SELF.PHONE_COUNT										:= L.PHONE_COUNT + R.PHONE_COUNT;
			SELF.FAX_COUNT											:= L.FAX_COUNT + R.FAX_COUNT;

			SELF.LIC_NBR_COUNT									:= L.LIC_NBR_COUNT + R.LIC_NBR_COUNT;
			SELF.C_LIC_NBR_COUNT								:= L.C_LIC_NBR_COUNT + R.C_LIC_NBR_COUNT;
			SELF.LIC_STATE_COUNT								:= L.LIC_STATE_COUNT + R.LIC_STATE_COUNT;
			SELF.LIC_TYPE_COUNT									:= L.LIC_TYPE_COUNT + R.LIC_TYPE_COUNT;
			SELF.LIC_STATUS_COUNT								:= L.LIC_STATUS_COUNT + R.LIC_STATUS_COUNT;

			SELF.TITLE_COUNT										:= L.TITLE_COUNT + R.TITLE_COUNT;
			SELF.FNAME_COUNT										:= L.FNAME_COUNT + R.FNAME_COUNT;
			SELF.MNAME_COUNT										:= L.MNAME_COUNT + R.MNAME_COUNT;
			SELF.LNAME_COUNT										:= L.LNAME_COUNT + R.LNAME_COUNT;
			SELF.SNAME_COUNT										:= L.SNAME_COUNT + R.SNAME_COUNT;
			SELF.CNAME_COUNT										:= L.CNAME_COUNT + R.CNAME_COUNT;
			SELF.CNP_NAME_COUNT									:= L.CNP_NAME_COUNT + R.CNP_NAME_COUNT;
			SELF.CNP_NUMBER_COUNT								:= L.CNP_NUMBER_COUNT + R.CNP_NUMBER_COUNT;
			SELF.CNP_STORE_NUMBER_COUNT					:= L.CNP_STORE_NUMBER_COUNT + R.CNP_STORE_NUMBER_COUNT;
			SELF.CNP_BTYPE_COUNT								:= L.CNP_BTYPE_COUNT + R.CNP_BTYPE_COUNT;
			SELF.CNP_LOWV_COUNT									:= L.CNP_LOWV_COUNT + R.CNP_LOWV_COUNT;

			SELF.SIC_CODE_COUNT									:= L.SIC_CODE_COUNT + R.SIC_CODE_COUNT;
			SELF.GENDER_COUNT										:= L.GENDER_COUNT + R.GENDER_COUNT;
			SELF.DERIVED_GENDER_COUNT						:= L.DERIVED_GENDER_COUNT + R.DERIVED_GENDER_COUNT;

			SELF.ADDRESS_ID_COUNT								:= L.ADDRESS_ID_COUNT + R.ADDRESS_ID_COUNT;
			SELF.ADDRESS_CLASSIFICATION_COUNT		:= L.ADDRESS_CLASSIFICATION_COUNT + R.ADDRESS_CLASSIFICATION_COUNT;

			SELF.PRIM_RANGE_COUNT								:= L.PRIM_RANGE_COUNT + R.PRIM_RANGE_COUNT;
			SELF.PRIM_NAME_COUNT								:= L.PRIM_NAME_COUNT + R.PRIM_NAME_COUNT;
			SELF.SEC_RANGE_COUNT								:= L.SEC_RANGE_COUNT + R.SEC_RANGE_COUNT;
			SELF.V_CITY_NAME_COUNT							:= L.V_CITY_NAME_COUNT + R.V_CITY_NAME_COUNT;
			SELF.ST_COUNT												:= L.ST_COUNT + R.ST_COUNT;
			SELF.ZIP_COUNT											:= L.ZIP_COUNT + R.ZIP_COUNT;

			SELF.DEATH_IND_COUNT								:= L.DEATH_IND_COUNT + R.DEATH_IND_COUNT;
			SELF.DOD_COUNT											:= L.DOD_COUNT + R.DOD_COUNT;

			SELF.TAX_ID_COUNT										:= L.TAX_ID_COUNT + R.TAX_ID_COUNT;
			SELF.BILLING_TAX_ID_COUNT						:= L.BILLING_TAX_ID_COUNT + R.BILLING_TAX_ID_COUNT;
			SELF.FEIN_COUNT											:= L.FEIN_COUNT + R.FEIN_COUNT;
			SELF.DERIVED_FEIN_COUNT							:= L.DERIVED_FEIN_COUNT + R.DERIVED_FEIN_COUNT;
			SELF.UPIN_COUNT											:= L.UPIN_COUNT + R.UPIN_COUNT;
			SELF.NPI_NUMBER_COUNT								:= L.NPI_NUMBER_COUNT + R.NPI_NUMBER_COUNT;
			SELF.BILLING_NPI_NUMBER_COUNT				:= L.BILLING_NPI_NUMBER_COUNT + R.BILLING_NPI_NUMBER_COUNT;
			SELF.DEA_BUS_ACT_IND_COUNT					:= L.DEA_BUS_ACT_IND_COUNT + R.DEA_BUS_ACT_IND_COUNT;			
			SELF.DEA_NUMBER_COUNT								:= L.DEA_NUMBER_COUNT + R.DEA_NUMBER_COUNT;
			SELF.CLIA_NUMBER_COUNT							:= L.CLIA_NUMBER_COUNT + R.CLIA_NUMBER_COUNT;
			SELF.TAXONOMY_COUNT									:= L.TAXONOMY_COUNT + R.TAXONOMY_COUNT;
			SELF.MEDICARE_FACILITY_COUNT				:= L.MEDICARE_FACILITY_COUNT + R.MEDICARE_FACILITY_COUNT;
			SELF.MEDICAID_NUMBER_COUNT					:= L.MEDICAID_NUMBER_COUNT + R.MEDICAID_NUMBER_COUNT;
			SELF.NCPDP_NUMBER_COUNT							:= L.NCPDP_NUMBER_COUNT + R.NCPDP_NUMBER_COUNT;
			SELF.SPECIALITY_CODE_COUNT					:= L.SPECIALITY_CODE_COUNT + R.SPECIALITY_CODE_COUNT;
			SELF.PROVIDER_STATUS_COUNT					:= L.PROVIDER_STATUS_COUNT + R.PROVIDER_STATUS_COUNT;			
			SELF.VENDOR_ID_COUNT								:= L.VENDOR_ID_COUNT + R.VENDOR_ID_COUNT;
			SELF.SRC														:= 'ALL';
	END;

	Sum_Stats					  := AGGREGATE (PROJECT (SRC_Stats,TRANSFORM(HealthCareProviderHeader_Reports.Layouts.Header_Report_Count, SELF.SRC := 'AL'; SELF := LEFT;)),HealthCareProviderHeader_Reports.Layouts.Header_Report_Count,xft (LEFT,RIGHT), LEFT.SRC, FEW);
	
	ALL_Stats						:= OUTPUT (Sum_Stats,NAMED('Population_Stats_Report'));
		
	IP_Population_Stats := OUTPUT (SRC_Stats(SRC = '64'),NAMED('Enclarity_Population_Stats_Report'));
	SJ_Population_Stats := OUTPUT (SRC_Stats(SRC = 'SJ'),NAMED('AMS_Population_Stats_Report'));
	NP_Population_Stats := OUTPUT (SRC_Stats(SRC = 'NP'),NAMED('NPPES_Population_Stats_Report'));
	DA_Population_Stats := OUTPUT (SRC_Stats(SRC = 'DA'),NAMED('DEA_Population_Stats_Report'));
	PL_Population_Stats := OUTPUT (SRC_Stats(SRC = 'PL'),NAMED('Professional_License_Population_Stats_Report'));
	CL_Population_Stats := OUTPUT (SRC_Stats(SRC = 'QR'),NAMED('CLIA_Population_Stats_Report'));
	NC_Population_Stats := OUTPUT (SRC_Stats(SRC = 'J2'),NAMED('NCPDP_Population_Stats_Report'));
	
	Population_Stats := PARALLEL (ALL_Stats,IP_Population_Stats,SJ_Population_Stats,NP_Population_Stats,DA_Population_Stats,PL_Population_Stats,CL_Population_Stats,NC_Population_Stats);
	
	HealthCareProviderHeader_Reports.Layouts.Header_Report_PERCENT getPercent (HealthCareProviderHeader_Reports.Layouts.Header_Report_Count L) := TRANSFORM
			SELF.RID_COUNT											:= L.RID_COUNT * 100 / L.RID_COUNT;
			SELF.LNPID_COUNT										:= L.LNPID_COUNT * 100 / L.RID_COUNT;
			SELF.DID_COUNT											:= L.DID_COUNT * 100 / L.RID_COUNT;
			SELF.BDID_COUNT											:= L.BDID_COUNT * 100 / L.RID_COUNT;
			SELF.DOTID_COUNT										:= L.DOTID_COUNT * 100 / L.RID_COUNT;
			SELF.EMPID_COUNT										:= L.EMPID_COUNT * 100 / L.RID_COUNT;
			SELF.POWID_COUNT										:= L.POWID_COUNT * 100 / L.RID_COUNT;
			SELF.PROXID_COUNT										:= L.PROXID_COUNT * 100 / L.RID_COUNT;
			SELF.SELEID_COUNT										:= L.SELEID_COUNT * 100 / L.RID_COUNT;
			SELF.ORGID_COUNT										:= L.ORGID_COUNT * 100 / L.RID_COUNT;
			SELF.ULTID_COUNT										:= L.ULTID_COUNT * 100 / L.RID_COUNT;

			SELF.SRC_COUNT											:= L.SRC_COUNT * 100 / L.RID_COUNT;
			SELF.SOURCE_RID_COUNT								:= L.SOURCE_RID_COUNT * 100 / L.RID_COUNT;
			SELF.DT_FIRST_SEEN_COUNT						:= L.DT_FIRST_SEEN_COUNT * 100 / L.RID_COUNT;
			SELF.DT_LAST_SEEN_COUNT							:= L.DT_LAST_SEEN_COUNT * 100 / L.RID_COUNT;
			SELF.DT_VENDOR_FIRST_REPORTED_COUNT	:= L.DT_VENDOR_FIRST_REPORTED_COUNT * 100 / L.RID_COUNT;
			SELF.DT_VENDOR_LAST_REPORTED_COUNT	:= L.DT_VENDOR_LAST_REPORTED_COUNT * 100 / L.RID_COUNT;
			SELF.DT_LIC_BEGIN_COUNT							:= L.DT_LIC_BEGIN_COUNT * 100 / L.RID_COUNT;			
			SELF.DT_LIC_EXPIRATION_COUNT				:= L.DT_LIC_EXPIRATION_COUNT * 100 / L.RID_COUNT;
			SELF.DT_DEA_EXPIRATION_COUNT				:= L.DT_DEA_EXPIRATION_COUNT * 100 / L.RID_COUNT;
			SELF.DT_NPI_DEACT_COUNT							:= L.DT_NPI_DEACT_COUNT * 100 / L.RID_COUNT;
			SELF.DT_ADDRESS_VERIFIED_COUNT			:= L.DT_ADDRESS_VERIFIED_COUNT * 100 / L.RID_COUNT;
			SELF.DT_BUS_INCORPORATED_COUNT			:= L.DT_BUS_INCORPORATED_COUNT * 100 / L.RID_COUNT;

			SELF.SUPPRESS_ADDRESS_COUNT					:= L.SUPPRESS_ADDRESS_COUNT * 100 / L.RID_COUNT;

			SELF.ENTITY_TYPE_COUNT							:= L.ENTITY_TYPE_COUNT * 100 / L.RID_COUNT;
			SELF.IS_STATE_SANCTION_COUNT				:= L.IS_STATE_SANCTION_COUNT * 100 / L.RID_COUNT;
			SELF.IS_OIG_SANCTION_COUNT					:= L.IS_OIG_SANCTION_COUNT * 100 / L.RID_COUNT;
			SELF.IS_OPM_SANCTION_COUNT					:= L.IS_OPM_SANCTION_COUNT * 100 / L.RID_COUNT;
			
			SELF.IS_PUBLIC_PRIVATE_COMP_COUNT		:= L.IS_PUBLIC_PRIVATE_COMP_COUNT * 100 / L.RID_COUNT;
			SELF.IS_PROFIT_NONPROFIT_COMP_COUNT	:= L.IS_PROFIT_NONPROFIT_COMP_COUNT * 100 / L.RID_COUNT;

			SELF.SSN_COUNT											:= L.SSN_COUNT * 100 / L.RID_COUNT;;
			SELF.CNSMR_SSN_COUNT								:= L.CNSMR_SSN_COUNT * 100 / L.RID_COUNT;;
			SELF.DOB_COUNT											:= L.DOB_COUNT * 100 / L.RID_COUNT;
			SELF.CNSMR_DOB_COUNT								:= L.CNSMR_DOB_COUNT * 100 / L.RID_COUNT;
			SELF.PHONE_COUNT										:= L.PHONE_COUNT * 100 / L.RID_COUNT;
			SELF.FAX_COUNT											:= L.FAX_COUNT * 100 / L.RID_COUNT;

			SELF.LIC_NBR_COUNT									:= L.LIC_NBR_COUNT * 100 / L.RID_COUNT;
			SELF.C_LIC_NBR_COUNT								:= L.C_LIC_NBR_COUNT * 100 / L.RID_COUNT;
			SELF.LIC_STATE_COUNT								:= L.LIC_STATE_COUNT * 100 / L.RID_COUNT;
			SELF.LIC_TYPE_COUNT									:= L.LIC_TYPE_COUNT * 100 / L.RID_COUNT;
			SELF.LIC_STATUS_COUNT								:= L.LIC_STATUS_COUNT * 100 / L.RID_COUNT;

			SELF.TITLE_COUNT										:= L.TITLE_COUNT * 100 / L.RID_COUNT;
			SELF.FNAME_COUNT										:= L.FNAME_COUNT * 100 / L.RID_COUNT;
			SELF.MNAME_COUNT										:= L.MNAME_COUNT * 100 / L.RID_COUNT;
			SELF.LNAME_COUNT										:= L.LNAME_COUNT * 100 / L.RID_COUNT;
			SELF.SNAME_COUNT										:= L.SNAME_COUNT * 100 / L.RID_COUNT;
			SELF.CNAME_COUNT										:= L.CNAME_COUNT * 100 / L.RID_COUNT;
			SELF.CNP_NAME_COUNT									:= L.CNP_NAME_COUNT * 100 / L.RID_COUNT;
			SELF.CNP_NUMBER_COUNT								:= L.CNP_NUMBER_COUNT * 100 / L.RID_COUNT;
			SELF.CNP_STORE_NUMBER_COUNT					:= L.CNP_STORE_NUMBER_COUNT * 100 / L.RID_COUNT;
			SELF.CNP_BTYPE_COUNT								:= L.CNP_BTYPE_COUNT * 100 / L.RID_COUNT;
			SELF.CNP_LOWV_COUNT									:= L.CNP_LOWV_COUNT * 100 / L.RID_COUNT;

			SELF.SIC_CODE_COUNT									:= L.SIC_CODE_COUNT * 100 / L.RID_COUNT;
			SELF.GENDER_COUNT										:= L.GENDER_COUNT * 100 / L.RID_COUNT;
			SELF.DERIVED_GENDER_COUNT						:= L.DERIVED_GENDER_COUNT * 100 / L.RID_COUNT;

			SELF.ADDRESS_ID_COUNT								:= L.ADDRESS_ID_COUNT * 100 / L.RID_COUNT;
			SELF.ADDRESS_CLASSIFICATION_COUNT		:= L.ADDRESS_CLASSIFICATION_COUNT * 100 / L.RID_COUNT;

			SELF.PRIM_RANGE_COUNT								:= L.PRIM_RANGE_COUNT * 100 / L.RID_COUNT;
			SELF.PRIM_NAME_COUNT								:= L.PRIM_NAME_COUNT * 100 / L.RID_COUNT;
			SELF.SEC_RANGE_COUNT								:= L.SEC_RANGE_COUNT * 100 / L.RID_COUNT;
			SELF.V_CITY_NAME_COUNT							:= L.V_CITY_NAME_COUNT * 100 / L.RID_COUNT;
			SELF.ST_COUNT												:= L.ST_COUNT * 100 / L.RID_COUNT;
			SELF.ZIP_COUNT											:= L.ZIP_COUNT * 100 / L.RID_COUNT;

			SELF.DEATH_IND_COUNT								:= L.DEATH_IND_COUNT * 100 / L.RID_COUNT;
			SELF.DOD_COUNT											:= L.DOD_COUNT * 100 / L.RID_COUNT;

			SELF.TAX_ID_COUNT										:= L.TAX_ID_COUNT * 100 / L.RID_COUNT;
			SELF.BILLING_TAX_ID_COUNT						:= L.BILLING_TAX_ID_COUNT * 100 / L.RID_COUNT;
			SELF.FEIN_COUNT											:= L.FEIN_COUNT * 100 / L.RID_COUNT;
			SELF.DERIVED_FEIN_COUNT							:= L.DERIVED_FEIN_COUNT * 100 / L.RID_COUNT;
			SELF.UPIN_COUNT											:= L.UPIN_COUNT * 100 / L.RID_COUNT;
			SELF.NPI_NUMBER_COUNT								:= L.NPI_NUMBER_COUNT * 100 / L.RID_COUNT;
			SELF.BILLING_NPI_NUMBER_COUNT				:= L.BILLING_NPI_NUMBER_COUNT * 100 / L.RID_COUNT;
			SELF.DEA_BUS_ACT_IND_COUNT					:= L.DEA_BUS_ACT_IND_COUNT * 100 / L.RID_COUNT;			
			SELF.DEA_NUMBER_COUNT								:= L.DEA_NUMBER_COUNT * 100 / L.RID_COUNT;
			SELF.CLIA_NUMBER_COUNT							:= L.CLIA_NUMBER_COUNT * 100 / L.RID_COUNT;
			SELF.TAXONOMY_COUNT									:= L.TAXONOMY_COUNT * 100 / L.RID_COUNT;
			SELF.MEDICARE_FACILITY_COUNT				:= L.MEDICARE_FACILITY_COUNT * 100 / L.RID_COUNT;
			SELF.MEDICAID_NUMBER_COUNT					:= L.MEDICAID_NUMBER_COUNT * 100 / L.RID_COUNT;			
			SELF.NCPDP_NUMBER_COUNT							:= L.NCPDP_NUMBER_COUNT * 100 / L.RID_COUNT;			
			SELF.SPECIALITY_CODE_COUNT					:= L.SPECIALITY_CODE_COUNT * 100 / L.RID_COUNT;			
			SELF.PROVIDER_STATUS_COUNT					:= L.PROVIDER_STATUS_COUNT * 100 / L.RID_COUNT;			
			SELF.VENDOR_ID_COUNT								:= L.VENDOR_ID_COUNT * 100 / L.RID_COUNT;
			SELF.SRC														:= L.SRC;
	END;

	Header_Count_PER 		:= PROJECT (SRC_Stats,getPercent (LEFT));
	EN_Header_Count_PER := PROJECT (SRC_Stats(SRC = '64'),getPercent (LEFT));
	SJ_Header_Count_PER := PROJECT (SRC_Stats(SRC = 'SJ'),getPercent (LEFT));
	NP_Header_Count_PER := PROJECT (SRC_Stats(SRC = 'NP'),getPercent (LEFT));
	DA_Header_Count_PER := PROJECT (SRC_Stats(SRC = 'DA'),getPercent (LEFT));
	PL_Header_Count_PER := PROJECT (SRC_Stats(SRC = 'PL'),getPercent (LEFT));
	CL_Header_Count_PER := PROJECT (SRC_Stats(SRC = 'QR'),getPercent (LEFT));
	NC_Header_Count_PER := PROJECT (SRC_Stats(SRC = 'J2'),getPercent (LEFT));
	
	Percent_Stats 	 := OUTPUT (Header_Count_Per,NAMED('Population_Percent'));
	IP_Percent_Stats := OUTPUT (EN_Header_Count_PER,NAMED('Enclarity_Population_Percent'));
	SJ_Percent_Stats := OUTPUT (SJ_Header_Count_PER,NAMED('AMS_Population_Percent'));
	NP_Percent_Stats := OUTPUT (NP_Header_Count_PER,NAMED('NPPES_Population_Percent'));
	DA_Percent_Stats := OUTPUT (DA_Header_Count_PER,NAMED('DEA_Population_Percent'));
	PL_Percent_Stats := OUTPUT (PL_Header_Count_PER,NAMED('Professional_License_Population_Percent'));
	CL_Percent_Stats := OUTPUT (CL_Header_Count_PER,NAMED('CLIA_Population_Percent'));
	NC_Percent_Stats := OUTPUT (NC_Header_Count_PER,NAMED('NCPDP_Population_Percent'));
	
	Percent := PARALLEL (Percent_Stats,IP_Percent_Stats,SJ_Percent_Stats,NP_Percent_Stats,DA_Percent_Stats,PL_Percent_Stats,CL_Percent_Stats,NC_Percent_Stats);
	
	RETURN SEQUENTIAL (Population_Stats,Percent);
END;