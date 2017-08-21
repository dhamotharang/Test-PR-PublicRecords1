import HealthCareProvider;
EXPORT HeaderPopulationStatsByState (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Header_DS) := FUNCTION

	STATS_REC := RECORD
			Header_DS.ST;
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
			DT_LIC_EXPIRATION_COUNT					:= COUNT(GROUP, Header_Ds.DT_LIC_EXPIRATION > 0); 
			DT_DEA_EXPIRATION_COUNT					:= COUNT(GROUP, Header_Ds.DT_DEA_EXPIRATION > 0); 

			SUPPRESS_ADDRESS_COUNT					:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SUPPRESS_ADDRESS)) > 0); 

			SSN_COUNT												:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SSN)) > 0); 
			DOB_COUNT												:= COUNT(GROUP, Header_Ds.DOB > 0); 
			PHONE_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.PHONE)) > 0);

			LIC_NBR_COUNT										:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_NBR)) > 0); 
			LIC_STATE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_STATE)) > 0);
			LIC_TYPE_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LIC_TYPE)) > 0);

			TITLE_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.TITLE)) > 0);
			FNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.FNAME)) > 0);
			MNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.MNAME)) > 0);
			LNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.LNAME)) > 0);
			SNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.SNAME)) > 0);
			CNAME_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CNAME)) > 0);

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
			FEIN_COUNT											:= COUNT(GROUP, Header_Ds.FEIN > 0);
			UPIN_COUNT											:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.UPIN)) > 0);
			NPI_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.NPI_NUMBER)) > 0); 
			DEA_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.DEA_NUMBER)) > 0); 
			CLIA_NUMBER_COUNT								:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.CLIA_NUMBER)) > 0);
			VENDOR_ID_COUNT									:= COUNT(GROUP, LENGTH(TRIM(Header_Ds.VENDOR_ID)) > 0); 
	END;
	
	SRC_Stats					   := TABLE (Header_DS,STATS_REC,ST,FEW);

	Population_Stats 		:= OUTPUT (SORT(SRC_Stats,ST),NAMED('Population_Stats_Report_By_State'));
	
	RETURN SEQUENTIAL (Population_Stats);
END;