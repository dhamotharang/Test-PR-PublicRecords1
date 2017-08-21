import MDR, Address, ut, Enclarity, IDLExternalLinking, salt29;
EXPORT ConvertEnclaritytoHeader (DATASET (HealthCareProvider.Layouts.Enclarity_Individual_REC) Infile = HealthCareProvider.files.Enclarity_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (HealthCareProvider.Layouts.Enclarity_Individual_REC L) := TRANSFORM 
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

		SELF.SRC													:=	MDR.SourceTools.src_Enclarity;
		SELF.SOURCE_RID										:=	L.SOURCE_RID;
		SELF.CLEAVEPENALTY								:=	0;
		SELF.DT_FIRST_SEEN								:=	L.DT_FIRST_SEEN;
		SELF.DT_LAST_SEEN									:=	L.DT_LAST_SEEN;
		SELF.DT_VENDOR_FIRST_REPORTED			:=	L.DT_VENDOR_FIRST_REPORTED;
		SELF.DT_VENDOR_LAST_REPORTED			:=	L.DT_VENDOR_LAST_REPORTED;
		DT_LIC_BEGIN 											:= 	L.LIC_BEGIN_DATE [1..4] + L.LIC_BEGIN_DATE [6..7] + L.LIC_BEGIN_DATE [9..10];
		SELF.DT_LIC_BEGIN 								:= 	IF (HealthCareProvider.isValidDate(DT_LIC_BEGIN),(INTEGER)DT_LIC_BEGIN,0);
		DT_LIC_EXPIRATION 								:= 	L.LIC_END_DATE [1..4] + L.LIC_END_DATE [6..7] + L.LIC_END_DATE [9..10];
		SELF.DT_LIC_EXPIRATION 						:=  IF (HealthCareProvider.isValidDate(DT_LIC_EXPIRATION),(INTEGER)DT_LIC_EXPIRATION,0);											
		DT_DEA_EXPIRATION 								:=  L.DEA_NUM_EXP;
		SELF.DT_DEA_EXPIRATION 						:=  IF(HealthCareProvider.isValidDate(DT_DEA_EXPIRATION),(INTEGER)DT_DEA_EXPIRATION,0);
		SELF.DT_NPI_DEACT									:=	IF(HealthCareProvider.isValidDate(L.NPI_DEACT_DATE[1..8]),(INTEGER)L.NPI_DEACT_DATE,0);
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
		SELF.ADDR_FLAG										:=	MAP (L.Addr_Conf_Score > 84 => 'G', L.Addr_Conf_Score > 54 => 'F', 'L');
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.BILLING_TAX_ID_FLAG					:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.DERIVED_FEIN_FLAG						:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.BILLING_NPI_NUMBER_FLAG			:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	MAP (L.prac1_phone_ind  = 'Y' and L.bill1_phone_ind = 'Y' => 'A', L.prac1_phone_ind  = 'Y' => 'P' , L.bill1_phone_ind = 'Y' => 'B','');
		SELF.FAX_FLAG											:=	MAP (L.prac1_fax_ind  = 'Y' and L.bill1_fax_ind = 'Y' => 'A', L.prac1_fax_ind  = 'Y' => 'P' , L.bill1_fax_ind = 'Y' => 'B','');
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
		boolean isBestSSN									:=	SALT29.WithinEditN(L.Clean_SSN,L.Best_SSN,2);
		SELF.SSN													:=	IF(HealthCareProvider.isValidSSN(L.CLEAN_SSN) and isBestSSN,L.CLEAN_SSN,'');
		SELF.CNSMR_SSN										:=	IF(HealthCareProvider.isValidSSN(L.BEST_SSN),L.BEST_SSN,'');
		STRING8	DOB												:=	IF(L.birth_year <> '',L.birth_year + '0101','00000000');
		SELF.DOB													:=	MAP (HealthCareProvider.isValidDOB (L.Clean_DOB) => (INTEGER)L.Clean_DOB, HealthCareProvider.isValidDOB (DOB) => (INTEGER)DOB,0);
		SELF.CNSMR_DOB										:=	MAP (HealthCareProvider.isValidDOB (INTFORMAT(L.BEST_DOB,8,1)) => (INTEGER)L.BEST_DOB,0);
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.Phone1);
		SELF.FAX													:=	HealthCareProvider.Clean_Phone(L.Fax1);
		SELF.LIC_NBR											:=	L.LIC_NUM_IN;
		LIC_NBR														:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(CleanData.DL_No,stringLib.stringToUpperCase(L.LIC_NUM),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.C_LIC_NBR										:=	Clean_License(L.LIC_NUM);
		SELF.LIC_STATE										:=	L.LIC_STATE;
		SELF.LIC_TYPE											:=	L.LIC_TYPE;
		SELF.LIC_STATUS										:=	L.LIC_STATUS;
		
		SELF.TITLE												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.Prefix_Name)),' ')),LEFT,RIGHT);
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.First_Name)),' ')),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.Middle_Name)),' ')),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.Last_Name)),' ')),LEFT,RIGHT);
		SELF.SNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.Suffix_Name)),' ')),LEFT,RIGHT);	
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

		GENDER														:=	stringLib.stringToUpperCase(L.Gender);
		SELF.GENDER												:=	IF(GENDER IN ['M','F'], GENDER, '');
		SELF.DERIVED_GENDER								:=	'';

		SELF.ADDRESS_ID										:=	L.ACEAID;
		SELF.ADDRESS_CLASSIFICATION				:=	MAP (L.Primary_Location = 'Y' and L.prac_addr_ind  = 'Y' and L.bill_addr_ind = 'Y' => 'A', l.prac_addr_ind  = 'Y' and L.bill_addr_ind = 'Y' => 'B', L.Primary_Location = 'Y' => 'L', l.prac_addr_ind  = 'Y' => 'P' , L.bill_addr_ind = 'Y' => 'B','');

		SELF.PRIM_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.prim_range)); 
		SELF.PREDIR												:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.predir));		
		SELF.PRIM_NAME										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.prim_name));
		SELF.ADDR_SUFFIX									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.addr_suffix));
		SELF.POSTDIR											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.postdir));		
		SELF.UNIT_DESIG										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.unit_desig));
		SELF.SEC_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.sec_range));
		SELF.P_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.P_CITY_name));
		SELF.V_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.v_city_name));
		SELF.ST														:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.st));		
		SELF.ZIP													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.zip));		
		SELF.ZIP4													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.zip4));		
		SELF.CART													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.cart));		
		SELF.CR_SORT_SZ										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.cr_sort_sz));
		SELF.LOT													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.lot));		
		SELF.LOT_ORDER										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.lot_order));
		SELF.DBPC													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.dbpc));		
		SELF.CHK_DIGIT										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.chk_digit));
		SELF.REC_TYPE											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.rec_type));
		SELF.FIPS_COUNTY									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.fips_county));
		SELF.FIPS_STATE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.fips_st));
		SELF.GEO_LAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.geo_lat));	
		SELF.GEO_LONG											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.geo_long));
		SELF.MSA													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.msa));		
		SELF.GEO_BLK											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.geo_blk));
		SELF.GEO_MATCH										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.geo_match));
		SELF.ERR_STAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(l.err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	(INTEGER)L.date_of_death;
		
		SELF.TAX_ID												:=	0;
		SELF.BILLING_TAX_ID								:=	0;
		SELF.FEIN													:=	0;
		SELF.DERIVED_FEIN									:=	0;
		SELF.UPIN													:=	L.upin;
		SELF.NPI_NUMBER										:=	L.NPI_NUM;
		SELF.BILLING_NPI_NUMBER						:=	'';
		SELF.DEA_BUS_ACT_IND							:=	L.DEA_BUS_ACT_IND;
		SELF.DEA_NUMBER										:=	L.DEA_NUM;
		SELF.CLIA_NUMBER									:=	'';
		SELF.TAXONOMY											:=	L.TAXONOMY;
		SELF.TAXONOMY_CODE								:=	L.TAXONOMY [1..4];
		SELF.MEDICARE_FACILITY_NUMBER			:=	'';
		SELF.MEDICAID_NUMBER							:=	'';
		SELF.NCPDP_NUMBER									:=	'';
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	L.provider_status;
		SELF.VENDOR_ID										:=	L.GROUP_KEY;
	END;

	Provider_Ds := PROJECT (Infile(Record_Type = 'C'),getProviderInfo(LEFT));
	// output(count (Provider_Ds));
	// output(count (Provider_Ds (LNAME <> '' AND FNAME <> '')));
	// output(count (Provider_Ds (LNAME <> '' AND FNAME <> '' AND ((ZIP <> '' AND PRIM_NAME <> '') OR C_LIC_NBR <> '' OR DEA_NUMBER <> '' OR NPI_NUMBER <> '' OR UPIN <> ''))));
	RETURN Provider_Ds (LNAME <> '' AND FNAME <> '' AND ((ZIP <> '' AND PRIM_NAME <> '') OR C_LIC_NBR <> '' OR DEA_NUMBER <> '' OR NPI_NUMBER <> '' OR UPIN <> ''));
END;