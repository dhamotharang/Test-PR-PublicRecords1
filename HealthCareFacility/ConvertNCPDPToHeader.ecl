import MDR, Address, ut, Enclarity, HealthCareProvider, STD, CCLUE_Contribution;
EXPORT ConvertNCPDPToHeader (DATASET (HealthCareFacility.Layouts.NCPDP_REC) Infile = HealthCareFacility.Files.NCPDP_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getFacilityInfo (HealthCareFacility.Layouts.NCPDP_REC L, INTEGER C) := TRANSFORM, SKIP (C IN [1,2] AND TRIM(L.prov_info_legal_business_name) = '' OR 
										 																																																																				 C IN [3,4] AND TRIM(L.prov_info_dba) = '')
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

		SELF.SRC													:=	MDR.SourceTools.src_NCPDP;
		SELF.SOURCE_RID										:=	L.SOURCE_RID;
		SELF.CLEAVEPENALTY								:=	0;

		SELF.DT_FIRST_SEEN								:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_first_seen,8,1)),(INTEGER)L.dt_first_seen,0);
		SELF.DT_LAST_SEEN									:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_last_seen,8,1)),(INTEGER)L.dt_last_seen,0);
		SELF.DT_VENDOR_FIRST_REPORTED			:=	0;
		SELF.DT_VENDOR_LAST_REPORTED			:=	0;
		SELF.DT_LIC_BEGIN									:=	0;
		SELF.DT_LIC_EXPIRATION						:=	IF (HealthCareProvider.isValidDate (INTFORMAT(l.state_license_clean_expiration_date,8,1)),l.state_license_clean_expiration_date,0);
		SELF.DT_DEA_EXPIRATION						:=	IF (HealthCareProvider.isValidDate (INTFORMAT(l.prov_info_clean_dea_expiration_date,8,1)),l.prov_info_clean_dea_expiration_date,0);
		SELF.DT_NPI_DEACT									:=	0;
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		SELF.DT_BUS_INCORPORATED					:= 	IF (HealthCareProvider.isValidDate (INTFORMAT(l.prov_info_clean_phys_loc_store_open_date,8,1)),L.prov_info_clean_phys_loc_store_open_date,0);
		
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
		SELF.CNAME_FLAG										:=	IF (C  IN [1,2],'L','D');		
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
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.prov_info_phys_loc_phone);
		SELF.FAX													:=	HealthCareProvider.Clean_Phone(L.prov_info_phys_loc_fax_number);
		
		LIC_NBR														:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(L.State_License_Number),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.LIC_NBR											:=	IF (LIC_NBR IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NBR);
		C_LIC_NO													:=	IF (LIC_NBR IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NBR);
		SELF.C_LIC_NBR										:=	HealthCareProvider.Clean_License (C_LIC_NO);
		
		SELF.LIC_STATE										:=	L.STATE_CODE;
		SELF.LIC_TYPE											:=	'';
		SELF.LIC_STATUS										:=	'';
		
		SELF.TITLE												:=	'';
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prov_info_clean_fname)),' ')),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prov_info_clean_mname)),' ')),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prov_info_clean_lname)),' ')),LEFT,RIGHT);
		SELF.SNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.prov_info_clean_suffix)),' ')),LEFT,RIGHT);
		
		SELF.SIC_CODE											:=	'';
		DBA																:=	IF(std.str.contains(L.prov_info_dba,L.prov_info_store_number,true),L.prov_info_dba,trim(L.prov_info_dba) + ' ' + L.prov_info_store_number);
		SELF.CNAME												:=	IF (C  IN [1,2],L.prov_info_legal_business_name,DBA); 																											
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
		SELF.ADDRESS_ID										:=	IF (C IN [1,3],L.prov_info_append_phyaceaid,L.prov_info_append_mailaceaid);
		SELF.ADDRESS_CLASSIFICATION				:=	MAP (L.prov_info_append_phyaceaid > 0 AND L.prov_info_append_mailaceaid > 0 AND L.prov_info_append_mailaceaid = L.prov_info_append_phyaceaid => 'B',C IN [1,3] => 'P', 'M');

		PRIM_RANGE												:=	IF (C IN [1,3], l.prov_info_phys_PRIM_RANGE,l.prov_info_mail_PRIM_RANGE);
		PREDIR														:=	IF (C IN [1,3], l.prov_info_phys_PREDIR,l.prov_info_mail_PREDIR);
		PRIM_NAME													:=	IF (C IN [1,3], l.prov_info_phys_PRIM_NAME,l.prov_info_mail_PRIM_NAME);
		ADDR_SUFFIX												:=	IF (C IN [1,3], l.prov_info_phys_ADDR_SUFFIX,l.prov_info_mail_ADDR_SUFFIX);
		POSTDIR														:=	IF (C IN [1,3], l.prov_info_phys_POSTDIR,l.prov_info_mail_POSTDIR);
		UNIT_DESIG												:=	IF (C IN [1,3], l.prov_info_phys_UNIT_DESIG,l.prov_info_mail_UNIT_DESIG);
		rec_type													:= 	IF (C IN [1,3], l.prov_info_phys_REC_TYPE,l.prov_info_mail_REC_TYPE);
		SEC_RANGE													:=	IF (C IN [1,3], l.prov_info_phys_SEC_RANGE,l.prov_info_mail_SEC_RANGE);
		P_CITY														:=	IF (C IN [1,3], l.prov_info_phys_P_city_name,l.prov_info_mail_P_city_name);
		V_CITY														:=	IF (C IN [1,3], l.prov_info_phys_v_city_name,l.prov_info_mail_v_city_name);
		ST																:=	IF (C IN [1,3], l.prov_info_phys_state,l.prov_info_mail_state);
		ZIP																:=	IF (C IN [1,3], l.prov_info_phys_zip5,l.prov_info_mail_ZIP5);
		ZIP4															:=	IF (C IN [1,3], l.prov_info_phys_ZIP4,l.prov_info_mail_ZIP4);

		CART															:=	IF (C IN [1,3], l.prov_info_phys_CART,l.prov_info_mail_CART);
		CR_SORT_SZ												:=	IF (C IN [1,3], l.prov_info_phys_CR_SORT_SZ,l.prov_info_mail_CR_SORT_SZ);
		LOT																:=	IF (C IN [1,3], l.prov_info_phys_LOT,l.prov_info_mail_LOT);
		LOT_ORDER													:=	IF (C IN [1,3], l.prov_info_phys_LOT_ORDER,l.prov_info_mail_LOT_ORDER);
		DBPC															:=	IF (C IN [1,3], l.prov_info_phys_dpbc,l.prov_info_mail_dpbc);
		CHK_DIGIT													:=	IF (C IN [1,3], l.prov_info_phys_CHK_DIGIT,l.prov_info_mail_CHK_DIGIT);
		COUNTY														:=	IF (C IN [1,3], l.prov_info_phys_county,l.prov_info_mail_county);
		STATE															:=	IF (C IN [1,3], l.prov_info_phys_ace_fips_st,l.prov_info_mail_ace_fips_st);		
		GEO_LAT														:=	IF (C IN [1,3], l.prov_info_phys_GEO_LAT,l.prov_info_mail_GEO_LAT);
		GEO_LONG													:=	IF (C IN [1,3], l.prov_info_phys_GEO_LONG,l.prov_info_mail_GEO_LONG);
		MSA																:=	IF (C IN [1,3], l.prov_info_phys_MSA,l.prov_info_mail_MSA);
		GEO_BLK														:=	IF (C IN [1,3], l.prov_info_phys_GEO_BLK,l.prov_info_mail_GEO_BLK);
		GEO_MATCH													:=	IF (C IN [1,3], l.prov_info_phys_GEO_MATCH,l.prov_info_mail_GEO_MATCH);
		ERR_STAT													:=	IF (C IN [1,3], l.prov_info_phys_ERR_STAT,l.prov_info_mail_ERR_STAT);
	
		SELF.PRIM_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(prim_range)); 
		SELF.PREDIR												:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(predir));		
		SELF.PRIM_NAME										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(prim_name));
		SELF.ADDR_SUFFIX									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(addr_suffix));
		SELF.POSTDIR											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(postdir));		
		SELF.UNIT_DESIG										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(unit_desig));
		SELF.SEC_RANGE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(sec_range));
		SELF.P_CITY_NAME									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(P_CITY));
		SELF.V_CITY_NAME									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(v_city));
		SELF.ST														:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(st));		
		SELF.ZIP													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(zip));		
		SELF.ZIP4													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(zip4));		
		SELF.CART													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(cart));		
		SELF.CR_SORT_SZ										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(cr_sort_sz));
		SELF.LOT													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(lot));		
		SELF.LOT_ORDER										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(lot_order));
		SELF.DBPC													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(dbpc));		
		SELF.CHK_DIGIT										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(chk_digit));
		SELF.REC_TYPE											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(rec_type));
		SELF.FIPS_COUNTY									:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(COUNTY));
		SELF.FIPS_STATE										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(state));
		SELF.GEO_LAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(geo_lat));	
		SELF.GEO_LONG											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(geo_long));
		SELF.MSA													:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(msa));		
		SELF.GEO_BLK											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(geo_blk));
		SELF.GEO_MATCH										:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(geo_match));
		SELF.ERR_STAT											:=	HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	(INTEGER)L.prov_info_state_income_tax_id;
		SELF.FEIN													:=	(INTEGER)L.prov_info_federal_tax_id;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	L.prov_info_national_provider_id;
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	L.prov_info_dea_registration_id;
		SELF.CLIA_NUMBER									:=	'';
		SELF.TAXONOMY											:=	L.taxonomy_code;
		SELF.TAXONOMY_CODE								:=	L.taxonomy_code [1..2];
		MEDICARE_FACILITY_NUMBER					:= 	IF (TRIM(L.prov_info_medicare_provider_id) IN HealthCareFacility.Constants.INVALID_MEDICARE_FAC_NO,'',TRIM(L.prov_info_medicare_provider_id));
		SELF.MEDICARE_FACILITY_NUMBER			:=	TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(MEDICARE_FACILITY_NUMBER),''),LEFT,RIGHT);
		MEDICAID_NO												:=	IF (TRIM(L.medicaid_id) IN HealthCareFacility.Constants.INVALID_MEDICAID_NO,'',TRIM(L.medicaid_id));
		SELF.MEDICAID_NUMBER							:=	TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(MEDICAID_NO),''),LEFT,RIGHT);
		SELF.NCPDP_NUMBER									:=	L.NCPDP_PROVIDER_ID;
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.NCPDP_Provider_ID;
		SELF															:=	[];
	END;

	Provider_DS := NORMALIZE (Infile(Record_Type = 'C'),4,getFacilityInfo (LEFT,COUNTER));

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));

	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,LIC_NBR,PHONE,TAX_ID,FEIN,NPI_NUMBER,DEA_NUMBER,MEDICARE_FACILITY_NUMBER,SOURCE_RID,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,LIC_NBR,PHONE,TAX_ID,FEIN,NPI_NUMBER,DEA_NUMBER,MEDICARE_FACILITY_NUMBER,LOCAL);
	
	RETURN DE_Provider_DS (TRIM(CNAME) <> '' AND (INTEGER)TRIM(zip) > 0 AND TRIM(PRIM_NAME) <> '');
END;