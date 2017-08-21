import MDR, Address, ut, Enclarity, HealthCareProvider, CCLUE_Contribution;
EXPORT ConvertEnclaritytoHeader (DATASET (HealthCareFacility.Layouts.Enclarity_REC) Infile = HealthCareFacility.Files.Enclarity_Fac_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getFacilityInfo (HealthCareFacility.Layouts.Enclarity_REC L) := TRANSFORM 
		SELF.RID													:=	0;
		SELF.LNPID												:=	0;
		SELF.DID													:=	0;
		SELF.BDID													:=	L.BDID;

		SELF.DOTID												:= 	L.DOTID;
		SELF.EMPID												:= 	L.EMPID;
		SELF.POWID												:= 	L.POWID;
		SELF.PROXID												:= 	L.PROXID;
		SELF.SELEID												:=	L.SELEID;
		SELF.ORGID												:= 	L.ORGID;
		SELF.ULTID												:= 	L.ULTID;

		SELF.SRC													:=	MDR.sourceTools.src_Enclarity;
		SELF.SOURCE_RID										:=	L.SOURCE_RID;
		SELF.CLEAVEPENALTY								:=	0;

		SELF.DT_FIRST_SEEN								:=	(integer)L.DT_FIRST_SEEN;
		SELF.DT_LAST_SEEN									:=	(integer)L.DT_LAST_SEEN;
		SELF.DT_VENDOR_FIRST_REPORTED			:=	(integer)L.DT_VENDOR_FIRST_REPORTED;
		SELF.DT_VENDOR_LAST_REPORTED			:=	(integer)L.DT_VENDOR_LAST_REPORTED;
		SELF.DT_LIC_BEGIN									:=	IF (HealthCareProvider.isValidDate(L.LIC_BEGIN_DATE),(INTEGER)L.LIC_BEGIN_DATE,0);
		SELF.DT_LIC_EXPIRATION						:=	IF (HealthCareProvider.isValidDate(L.LIC_END_DATE),(INTEGER)L.LIC_END_DATE,0);
		SELF.DT_DEA_EXPIRATION						:=	IF (HealthCareProvider.isValidDate(L.DEA_NUM_EXP),(INTEGER)L.DEA_NUM_EXP,0);
		SELF.DT_NPI_DEACT									:=	0;
		SELF.DT_ADDRESS_VERIFIED					:=	IF (HealthCareProvider.isValidDate(L.LAST_VERIFIED_DATE),(INTEGER)L.LAST_VERIFIED_DATE,0);
		
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
		SELF.ADDR_FLAG										:=	MAP (L.PV_ADDR_IND = 'Y' => 'G', 'L');
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	''; //MAP (R.prac1_phone_ind  = 'Y' and R.bill1_phone_ind = 'Y' => 'A', R.prac1_phone_ind  = 'Y' => 'P' , R.bill1_phone_ind = 'Y' => 'B','');
		SELF.FAX_FLAG											:=	''; //MAP (R.prac1_fax_ind  = 'Y' and R.bill1_fax_ind = 'Y' => 'A', R.prac1_fax_ind  = 'Y' => 'P' , R.bill1_fax_ind = 'Y' => 'B','');
		SELF.CLIA_NUMBER_FLAG							:=	'';
		SELF.TAXONOMY_FLAG								:=	'';

		SELF.SUPPRESS_ADDRESS							:=	'';
		
		SELF.SSN													:=	'';
		SELF.DOB													:=	0; //IF(HealthCareProvider.isValidDOB (DOB),(INTEGER)DOB,0);
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.Phone1);
		SELF.FAX													:=	HealthCareProvider.Clean_Phone(L.Fax1);
		SELF.LIC_NBR											:=	L.LIC_NUM_IN;
		LIC_NBR														:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(L.LIC_NUM_IN),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.C_LIC_NBR										:=	HealthCareProvider.Clean_License (LIC_NBR);
		SELF.LIC_STATE										:=	IF (LENGTH(TRIM(L.LIC_STATE)) = 2,L.LIC_STATE,'');
		SELF.LIC_TYPE											:=	L.LIC_TYPE;
		SELF.LIC_STATUS										:=	L.LIC_STATUS;
		
		SELF.TITLE												:=	'';
		SELF.FNAME												:=	'';
		SELF.MNAME												:=	'';
		SELF.LNAME												:=	'';
		SELF.SNAME												:=	'';
		SELF.SIC_CODE											:=	'';
		SELF.CNAME												:=	L.PRAC_COMPANY_NAME; //HealthCareFacility.clean_facility_name(L.PRAC_COMPANY_NAME); //HealthCareFacility.FacilityNameCleaner.fnCleanAsConfigured(L.PRAC_COMPANY_NAME);
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

		SELF.ADDRESS_ID										:=	0;
		SELF.ADDRESS_CLASSIFICATION				:=	''; //MAP (R.prac_addr_ind  = 'Y' and R.bill_addr_ind = 'Y' => 'A', R.prac_addr_ind  = 'Y' => 'P' , R.bill_addr_ind = 'Y' => 'B','');

		SELF.PRIM_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prim_range)); 
		SELF.PREDIR												:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.predir));		
		SELF.PRIM_NAME										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prim_name));
		SELF.ADDR_SUFFIX									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.addr_suffix));
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
		SELF.DBPC													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.dbpc));		
		SELF.CHK_DIGIT										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.chk_digit));
		SELF.REC_TYPE											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.rec_type));
		SELF.FIPS_COUNTY									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.fips_county));
		SELF.FIPS_STATE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.fips_st));
		SELF.GEO_LAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_lat));	
		SELF.GEO_LONG											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_long));
		SELF.MSA													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.msa));		
		SELF.GEO_BLK											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_blk));
		SELF.GEO_MATCH										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.geo_match));
		SELF.ERR_STAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	(INTEGER)L.TIN1;
		SELF.FEIN													:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	L.NPI_NUM;
		SELF.DEA_BUS_ACT_IND							:=	L.DEA_BUS_ACT_IND;
		SELF.DEA_NUMBER										:=	L.DEA_NUM;
		SELF.CLIA_NUMBER									:=	L.CLIA_NUM;
		SELF.TAXONOMY											:=	L.TAXONOMY;
		SELF.TAXONOMY_CODE								:=	L.TAXONOMY [1..2];
		MEDICARE_FACILITY_NUMBER					:= IF (TRIM(L.MEDICARE_FAC_NUM) IN HealthCareFacility.Constants.INVALID_MEDICARE_FAC_NO,'',TRIM(L.MEDICARE_FAC_NUM));
		SELF.MEDICARE_FACILITY_NUMBER			:=	TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(MEDICARE_FACILITY_NUMBER),''),LEFT,RIGHT);
		SELF.NCPDP_NUMBER									:=	L.NCPDP_ID;
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.Group_KEY;
		SELF															:= [];
	END;

	Enclarity_Facility_DS	 	:= PROJECT (Infile(RECORD_TYPE = 'C'),getFacilityInfo(LEFT))(TRIM(CNAME) <> '' AND TRIM(PRIM_NAME) <> '' AND TRIM(ZIP) <> '');

	D_Enclarity_Facility_DS := DISTRIBUTE (Enclarity_Facility_DS,HASH32(VENDOR_ID));
	
	S_Enclarity_Facility_DS		:=	SORT (D_Enclarity_Facility_DS,VENDOR_ID,CNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,ZIP,PHONE,FAX,LIC_NBR,C_LIC_NBR,LIC_STATE,LIC_TYPE,LIC_STATUS,TAX_ID,NPI_NUMBER,DEA_BUS_ACT_IND,DEA_NUMBER,CLIA_NUMBER,TAXONOMY,MEDICARE_FACILITY_NUMBER,NCPDP_NUMBER,LOCAL);
	De_Enclarity_Facility_DS	:=	DEDUP (S_Enclarity_Facility_DS,VENDOR_ID,CNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,ZIP,PHONE,FAX,LIC_NBR,C_LIC_NBR,LIC_STATE,LIC_TYPE,LIC_STATUS,TAX_ID,NPI_NUMBER,DEA_BUS_ACT_IND,DEA_NUMBER,CLIA_NUMBER,TAXONOMY,MEDICARE_FACILITY_NUMBER,NCPDP_NUMBER,LOCAL);	
	
	D_Enclarity_Assoc_DS	:=	DISTRIBUTE (HealthCareFacility.Files.Enclarity_Assoc_DS,HASH32(billing_group_key));
	
	Remove_Duplicate_TaxID	:=	DEDUP(SORT (D_Enclarity_Assoc_DS,billing_group_key,bill_tin,local),billing_group_key,bill_tin,local);
	
	Assign_Tax_ID	:=	JOIN (DISTRIBUTE(De_Enclarity_Facility_DS,HASH32(VENDOR_ID)),Remove_Duplicate_TaxID,LEFT.VENDOR_ID = RIGHT.Billing_Group_Key,TRANSFORM(
																				HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.Tax_ID := (INTEGER) RIGHT.bill_tin; SELF := LEFT;),LEFT OUTER, LOCAL);
	
	// Remove_Duplicates := SORT (Assign_Tax_ID,Vendor_Id,);
	// OUTPUT(count (Enclarity_Facility_DS));
	
	// OUTPUT(count (Assign_Tax_ID));
	
	RETURN Assign_Tax_ID (TRIM(CNAME) <> '' AND TRIM(PRIM_NAME) <> '' AND TRIM(ZIP) <> '');
END;