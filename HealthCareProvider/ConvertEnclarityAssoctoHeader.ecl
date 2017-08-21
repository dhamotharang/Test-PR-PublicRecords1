import MDR, Address, ut, Enclarity, IDLExternalLinking, salt29, HealthCareFacility;
EXPORT ConvertEnclarityAssoctoHeader (DATASET (HealthCareFacility.Layouts.Enclarity_Assoc_REC) Infile = HealthCareProvider.files.Enclarity_ASSOC_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (HealthCareFacility.Layouts.Enclarity_ASSOC_REC L, INTEGER C) := TRANSFORM , SKIP (( C = 2 AND L.CLEAN_PHONE <> '' AND L.CLEAN_PHONE = L.CLEAN_SLOC_PHONE) OR 
	                                                                                                                                                                     ( C = 2 AND L.CLEAN_SLOC_PHONE = ''))
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
		SELF.DT_LIC_BEGIN 								:= 	0;
		SELF.DT_LIC_EXPIRATION 						:=  0;
		SELF.DT_DEA_EXPIRATION 						:=  0;
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
		SELF.ADDR_FLAG										:=	MAP ((INTEGER)L.PRAC_ADDR_CONFIDENCE_SCORE > 84 OR (INTEGER)L.BILL_ADDR_CONFIDENCE_SCORE > 84 => 'G', 
																							 (INTEGER)L.PRAC_ADDR_CONFIDENCE_SCORE > 54 OR (INTEGER)L.BILL_ADDR_CONFIDENCE_SCORE > 54 => 'F', 
																							  'L');
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.BILLING_TAX_ID_FLAG					:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.DERIVED_FEIN_FLAG						:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.BILLING_NPI_NUMBER_FLAG			:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	MAP (L.ADDR_PHONE <> '' AND L.ADDR_PHONE = L.SLOC_PHONE => 'A', L.ADDR_PHONE <> '' => 'B' , L.SLOC_PHONE <> '' => 'P','');
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
		boolean isBestSSN									:=	IF (L.Best_SSN <> '',SALT29.WithinEditN(L.Clean_SSN,L.Best_SSN,2),true);
		SELF.SSN													:=	IF(HealthCareProvider.isValidSSN(L.CLEAN_SSN) and isBestSSN,L.CLEAN_SSN,'');
		SELF.CNSMR_SSN										:=	IF(HealthCareProvider.isValidSSN(L.BEST_SSN),L.BEST_SSN,'');
		SELF.DOB													:=	MAP (HealthCareProvider.isValidDOB (L.Clean_DOB) => (INTEGER)L.Clean_DOB,0);
		SELF.CNSMR_DOB										:=	MAP (HealthCareProvider.isValidDOB (INTFORMAT(L.BEST_DOB,8,1)) => (INTEGER)L.BEST_DOB,0);
		SELF.PHONE												:=	MAP (C = 1 => L.CLEAN_PHONE, L.CLEAN_SLOC_PHONE);
		SELF.FAX													:=	'';
		SELF.LIC_NBR											:=	''; 
		SELF.C_LIC_NBR										:=	'';
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		SELF.LIC_STATUS										:=	''; 
		
		SELF.TITLE												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.TITLE)),' ')),LEFT,RIGHT);
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.FName)),' ')),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.MName)),' ')),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.LName)),' ')),LEFT,RIGHT);
		SELF.SNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.NAME_SUFFIX)),' ')),LEFT,RIGHT);	
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

		SELF.GENDER												:=	'';
		SELF.DERIVED_GENDER								:=	'';

		SELF.ADDRESS_ID										:=	L.ACEAID;
		SELF.ADDRESS_CLASSIFICATION				:=	MAP (L.SLOC_GROUP_KEY <> '' AND L.BILLING_GROUP_KEY <> '' => 'A', L.BILLING_GROUP_KEY <> '' => 'B', L.SLOC_GROUP_KEY <> '' => 'L','');

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
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	0;
		SELF.BILLING_TAX_ID								:=	(INTEGER)L.BILL_TIN;
		SELF.FEIN													:=	0;
		SELF.DERIVED_FEIN									:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.BILLING_NPI_NUMBER						:=	L.BILL_NPI;
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
		SELF.VENDOR_ID										:=	L.GROUP_KEY;
	END;

	// Provider_Ds := NORMALIZE (Infile (NORMED_NAME_REC_TYPE = '1' AND FNAME <> '' AND LNAME <> '' AND ZIP <> '' AND PRIM_NAME <> ''),2,getProviderInfo(LEFT,COUNTER));
	Provider_Ds := NORMALIZE (Infile (NORMED_NAME_REC_TYPE = '1' AND FNAME <> '' AND LNAME <> '' and RECORD_TYPE = 'C'),2,getProviderInfo(LEFT,COUNTER));

	D_Provider_DS := DISTRIBUTE (PROVIDER_DS,HASH32(VENDOR_ID)); 

	S_Provider_DS := SORT (D_Provider_DS,Vendor_ID,did,ssn,cnsmr_ssn,dob,cnsmr_dob,phone,fname,lname,mname,sname,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,v_city_name,st,zip,billing_tax_id,billing_npi_number,vendor_id,local);
	
	De_Provider_DS := DEDUP (S_Provider_DS,Vendor_ID,did,ssn,cnsmr_ssn,dob,cnsmr_dob,phone,fname,lname,mname,sname,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,v_city_name,st,zip,billing_tax_id,billing_npi_number,vendor_id,local);	

	Enclarity_NPI := DEDUP(SORT (DISTRIBUTE (HealthCareProvider.Files.Enclarity_NPI,HASH32(GROUP_KEY)),GROUP_KEY,NPI_NUM,LOCAL),GROUP_KEY,NPI_NUM,LOCAL);	
	
	Append_NPI := JOIN (De_Provider_DS,Enclarity_NPI,LEFT.VENDOR_ID = RIGHT.GROUP_KEY,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
														SELF.ENTITY_TYPE := RIGHT.NPI_TYPE; 
														SELF.DT_NPI_DEACT := (INTEGER) RIGHT.clean_npi_deact_date; 
														SELF.TAXONOMY	:= RIGHT.TAXONOMY;
														SELF.TAXONOMY_CODE := RIGHT.TAXONOMY [1..4];
														SELF.NPI_NUMBER := RIGHT.NPI_NUM; SELF := LEFT;), LEFT OUTER, LOCAL);
	
	RETURN Append_NPI (LNAME <> '' AND FNAME <> '' AND ((ZIP <> '' AND PRIM_NAME <> '') OR C_LIC_NBR <> '' OR DEA_NUMBER <> '' OR NPI_NUMBER <> '' OR UPIN <> ''));

END;