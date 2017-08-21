import MDR, Address, ut;
EXPORT ConvertNPPEStoHeader (DATASET (Layouts.NPPES_DID) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (Layouts.NPPES_DID L, INTEGER C) := TRANSFORM 
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
		SELF.ULTID												:= 	L.ultid;

		SELF.SRC													:=	MDR.SourceTools.src_NPPES;
		SELF.SOURCE_RID										:=	L.SOURCE_REC_ID;

		SELF.DT_FIRST_SEEN								:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_first_seen,8,1)),(INTEGER)L.dt_first_seen,0);
		SELF.DT_LAST_SEEN									:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_last_seen,8,1)),(INTEGER)L.dt_last_seen,0);
		SELF.DT_VENDOR_FIRST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_first_reported,8,1)),(INTEGER)L.dt_vendor_first_reported,0);
		SELF.DT_VENDOR_LAST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_last_reported,8,1)),(INTEGER)L.dt_vendor_last_reported,0);
		SELF.DT_LIC_BEGIN									:=	0;
		SELF.DT_LIC_EXPIRATION						:=	0;
		SELF.DT_DEA_EXPIRATION						:=	0;
		SELF.DT_NPI_DEACT									:=	IF(HealthCareProvider.isValidDate(L.npi_deactivation_date),(INTEGER)L.npi_deactivation_date,0);
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		SELF.DT_BUS_INCORPORATED					:=	0;
		
		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';

		SELF.ENTITY_TYPE									:=	IF (L.ENTITY_TYPE_CODE IN ['1','2'],L.ENTITY_TYPE_CODE,'');
		
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
		SELF.PHONE_FLAG										:=	MAP ((INTEGER)HealthCareProvider.Clean_Phone(L.cleanmailingphone) > 0 AND (INTEGER)HealthCareProvider.Clean_Phone(L.cleanlocationphone) > 0 AND 
																							 (INTEGER)HealthCareProvider.Clean_Phone(L.cleanmailingphone) = (INTEGER)HealthCareProvider.Clean_Phone(L.cleanlocationphone) => 'B',
																								C = 1 AND (INTEGER)HealthCareProvider.Clean_Phone(L.cleanmailingphone) > 0 => 'M',
																												  (INTEGER)HealthCareProvider.Clean_Phone(L.cleanlocationphone) > 0 => 'P','');		
		SELF.FAX_FLAG											:=	MAP ((INTEGER)HealthCareProvider.Clean_Phone(L.provider_business_mailing_address_fax_number) > 0 AND (INTEGER)HealthCareProvider.Clean_Phone(L.provider_business_practice_location_address_fax_number) > 0 AND
																							 (INTEGER)HealthCareProvider.Clean_Phone(L.provider_business_mailing_address_fax_number) = (INTEGER)HealthCareProvider.Clean_Phone(L.provider_business_practice_location_address_fax_number) => 'B',
																								C = 1 AND (INTEGER)HealthCareProvider.Clean_Phone(L.provider_business_mailing_address_fax_number) > 0 => 'M',
																													(INTEGER)HealthCareProvider.Clean_Phone(L.provider_business_practice_location_address_fax_number) > 0 => 'P','');										
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
		SELF.PHONE												:=	IF (C = 1, HealthCareProvider.Clean_Phone(L.cleanmailingphone),HealthCareProvider.Clean_Phone(L.cleanlocationphone));
		SELF.FAX													:=	IF (C = 1, HealthCareProvider.Clean_Phone(L.provider_business_mailing_address_fax_number),HealthCareProvider.Clean_Phone(L.provider_business_practice_location_address_fax_number));										
		
		LIC_DS														:=	DATASET ([{L.provider_license_number_1,L.provider_license_number_state_code_1,L.healthcare_provider_primary_taxonomy_switch_1},
																										{L.provider_license_number_2,L.provider_license_number_state_code_2,L.healthcare_provider_primary_taxonomy_switch_2},
																										{L.provider_license_number_3,L.provider_license_number_state_code_3,L.healthcare_provider_primary_taxonomy_switch_3},
																										{L.provider_license_number_4,L.provider_license_number_state_code_4,L.healthcare_provider_primary_taxonomy_switch_4},
																										{L.provider_license_number_5,L.provider_license_number_state_code_5,L.healthcare_provider_primary_taxonomy_switch_5},
																										{L.provider_license_number_6,L.provider_license_number_state_code_6,L.healthcare_provider_primary_taxonomy_switch_6},
																										{L.provider_license_number_7,L.provider_license_number_state_code_7,L.healthcare_provider_primary_taxonomy_switch_7},
																										{L.provider_license_number_8,L.provider_license_number_state_code_8,L.healthcare_provider_primary_taxonomy_switch_8},
																										{L.provider_license_number_9,L.provider_license_number_state_code_9,L.healthcare_provider_primary_taxonomy_switch_9},
																										{L.provider_license_number_10,L.provider_license_number_state_code_10,L.healthcare_provider_primary_taxonomy_switch_10},
																										{L.provider_license_number_11,L.provider_license_number_state_code_11,L.healthcare_provider_primary_taxonomy_switch_11},
																										{L.provider_license_number_12,L.provider_license_number_state_code_12,L.healthcare_provider_primary_taxonomy_switch_12},
																										{L.provider_license_number_13,L.provider_license_number_state_code_13,L.healthcare_provider_primary_taxonomy_switch_13},
																										{L.provider_license_number_14,L.provider_license_number_state_code_14,L.healthcare_provider_primary_taxonomy_switch_14},
																										{L.provider_license_number_15,L.provider_license_number_state_code_15,L.healthcare_provider_primary_taxonomy_switch_15}
																										],HealthCareProvider.Layouts.NPPES_LICENSE
																									);
		STRING25 LIC_NO										:=	LIC_DS (switch = 'Y') [1].license_number;
		LIC_NBR														:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(CleanData.DL_No,stringLib.stringToUpperCase(LIC_NO),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.LIC_NBR											:=	IF (LIC_NO IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NO);
		C_LIC_NO													:=	IF (LIC_NBR IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NBR);
		SELF.C_LIC_NBR										:=	Clean_License (C_LIC_NO);
		SELF.LIC_STATE										:=	LIC_DS (switch = 'Y') [1].state_code;
		SELF.LIC_TYPE											:=	L.Provider_Credential_Text;
		SELF.LIC_STATUS										:=	'';
		
		SELF.TITLE												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.provider_name_prefix_text)),' ')),LEFT,RIGHT);
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.provider_first_name)),' ')),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.provider_middle_name)),' ')),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.provider_last_name)),' ')),LEFT,RIGHT);
		SELF.SNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(CleanData.Name,CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(L.provider_name_suffix_text)),' ')),LEFT,RIGHT);	
		SELF.SIC_CODE											:=	'';
		SELF.CNAME												:=	L.provider_organization_name;
		SELF.CNP_NAMEID										:=	0;
		SELF.CNP_NAME											:=	'';
		SELF.CNP_NUMBER										:=	'';	
		SELF.CNP_STORE_NUMBER							:=	'';
		SELF.CNP_BTYPE										:=	'';		
		SELF.CNP_LOWV											:=	'';
		SELF.CNP_TRANSLATED							 	:= false;
		SELF.CNP_CLASSID 									:= 0;
		
		GENDER														:=	stringLib.stringToUpperCase(L.provider_gender_code);
		SELF.GENDER												:=	IF(GENDER IN ['M','F'], GENDER, '');
		SELF.DERIVED_GENDER								:=	'';
		SELF.ADDRESS_ID										:=	IF (C = 1,L.aceaid_mailing,L.aceaid_location);
		SELF.ADDRESS_CLASSIFICATION				:=	MAP (L.aceaid_mailing > 0 AND L.aceaid_location > 0 AND L.aceaid_mailing = L.aceaid_location => 'B',C = 1 => 'M', 'P');

		boolean isSuite (string pInput) := REGEXFIND(('APT|STORE|SUITE|STE'),StringLib.StringToUpperCase(pInput)); 
		
		AddressLine1 := IF (isSuite(L.provider_second_line_business_practice_location_address),trim(L.provider_first_line_business_practice_location_address) + ' ' + trim (L.provider_second_line_business_practice_location_address),L.provider_first_line_business_practice_location_address);
		AddressLine2 := Address.Addr2FromComponents(L.provider_business_practice_location_address_city_name, L.provider_business_practice_location_address_state_name, L.provider_business_practice_location_address_postal_code [1..5]);

		AddressLine3 := IF (isSuite(L.provider_second_line_business_mailing_address),trim(L.provider_first_line_business_mailing_address) + ' ' + trim (L.provider_second_line_business_mailing_address),L.provider_first_line_business_mailing_address);
		AddressLine4 := Address.Addr2FromComponents(L.provider_business_mailing_address_city_name, L.provider_business_mailing_address_state_name, L.provider_business_mailing_address_postal_code [1..5]);

		AddressLine5 := IF (C = 1,AddressLine3,AddressLine1);
		AddressLine6 := IF (C = 1,AddressLine4,AddressLine2);

		CleanedAddress := Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine5, AddressLine6)).addressrecord;																					 

		PRIM_RANGE												:=	IF (C = 1, CleanedAddress.PRIM_RANGE,CleanedAddress.PRIM_RANGE);
		PREDIR														:=	IF (C = 1, CleanedAddress.PREDIR,CleanedAddress.PREDIR);
		PRIM_NAME													:=	IF (C = 1, CleanedAddress.PRIM_NAME,CleanedAddress.PRIM_NAME);
		ADDR_SUFFIX												:=	IF (C = 1, CleanedAddress.ADDR_SUFFIX,CleanedAddress.ADDR_SUFFIX);
		POSTDIR														:=	IF (C = 1, CleanedAddress.POSTDIR,CleanedAddress.POSTDIR);
		UNIT_DESIG												:=	IF (C = 1, CleanedAddress.UNIT_DESIG,CleanedAddress.UNIT_DESIG);
		rec_type													:= 	IF (C = 1, CleanedAddress.REC_TYPE,CleanedAddress.REC_TYPE);
		SEC_RANGE													:=	IF (C = 1, CleanedAddress.SEC_RANGE,CleanedAddress.SEC_RANGE);
		P_CITY														:=	IF (C = 1, CleanedAddress.P_city_name,CleanedAddress.P_city_name);
		V_CITY														:=	IF (C = 1, CleanedAddress.v_city_name,CleanedAddress.v_city_name);
		ST																:=	IF (C = 1, CleanedAddress.ST,CleanedAddress.ST);
		ZIP																:=	IF (C = 1, CleanedAddress.ZIP,CleanedAddress.ZIP);
		ZIP4															:=	IF (C = 1, CleanedAddress.ZIP4,CleanedAddress.ZIP4);

		CART															:=	IF (C = 1, CleanedAddress.CART,CleanedAddress.CART);
		CR_SORT_SZ												:=	IF (C = 1, CleanedAddress.CR_SORT_SZ,CleanedAddress.CR_SORT_SZ);
		LOT																:=	IF (C = 1, CleanedAddress.LOT,CleanedAddress.LOT);
		LOT_ORDER													:=	IF (C = 1, CleanedAddress.LOT_ORDER,CleanedAddress.LOT_ORDER);
		DBPC															:=	IF (C = 1, CleanedAddress.DBPC,CleanedAddress.DBPC);
		CHK_DIGIT													:=	IF (C = 1, CleanedAddress.CHK_DIGIT,CleanedAddress.CHK_DIGIT);
		COUNTY														:=	IF (C = 1, CleanedAddress.fips_county,CleanedAddress.fips_county);
		STATE															:=	IF (C = 1, CleanedAddress.fips_state,CleanedAddress.fips_state);		
		GEO_LAT														:=	IF (C = 1, CleanedAddress.GEO_LAT,CleanedAddress.GEO_LAT);
		GEO_LONG													:=	IF (C = 1, CleanedAddress.GEO_LONG,CleanedAddress.GEO_LONG);
		MSA																:=	IF (C = 1, CleanedAddress.MSA,CleanedAddress.MSA);
		GEO_BLK														:=	IF (C = 1, CleanedAddress.GEO_BLK,CleanedAddress.GEO_BLK);
		GEO_MATCH													:=	IF (C = 1, CleanedAddress.GEO_MATCH,CleanedAddress.GEO_MATCH);
		ERR_STAT													:=	IF (C = 1, CleanedAddress.ERR_STAT,CleanedAddress.ERR_STAT);
	
		SELF.PRIM_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(prim_range)); 
		SELF.PREDIR												:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(predir));		
		SELF.PRIM_NAME										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(prim_name));
		SELF.ADDR_SUFFIX									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(addr_suffix));
		SELF.POSTDIR											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(postdir));		
		SELF.UNIT_DESIG										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(unit_desig));
		SELF.SEC_RANGE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(sec_range));
		SELF.P_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(P_CITY));
		SELF.V_CITY_NAME									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(v_city));
		SELF.ST														:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(st));		
		SELF.ZIP													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(zip));		
		SELF.ZIP4													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(zip4));		
		SELF.CART													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(cart));		
		SELF.CR_SORT_SZ										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(cr_sort_sz));
		SELF.LOT													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(lot));		
		SELF.LOT_ORDER										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(lot_order));
		SELF.DBPC													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(dbpc));		
		SELF.CHK_DIGIT										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(chk_digit));
		SELF.REC_TYPE											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(rec_type));
		SELF.FIPS_COUNTY									:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(COUNTY));
		SELF.FIPS_STATE										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(state));
		SELF.GEO_LAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(geo_lat));	
		SELF.GEO_LONG											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(geo_long));
		SELF.MSA													:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(msa));		
		SELF.GEO_BLK											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(geo_blk));
		SELF.GEO_MATCH										:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(geo_match));
		SELF.ERR_STAT											:=	CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(err_stat));

		SELF.DEATH_IND										:=	'';
		SELF.DOD													:=	0;
		
		SELF.TAX_ID												:=	0;
		SELF.BILLING_TAX_ID								:=	0;
		SELF.FEIN													:=	0;
		SELF.DERIVED_FEIN									:=	0;
		SELF.UPIN													:=	'';
		NPI																:=	TRIM (L.NPI,LEFT,RIGHT);
		SELF.NPI_NUMBER										:=	IF (ut.isNumeric(NPI),NPI,'');
		SELF.BILLING_NPI_NUMBER						:=	'';
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	'';
		SELF.CLIA_NUMBER									:=	'';
		Taxonomy_DS												:=	DATASET ([{L.healthcare_provider_taxonomy_code_1,L.healthcare_provider_primary_taxonomy_switch_1},
																										{L.healthcare_provider_taxonomy_code_2,L.healthcare_provider_primary_taxonomy_switch_2},
																										{L.healthcare_provider_taxonomy_code_3,L.healthcare_provider_primary_taxonomy_switch_3},
																										{L.healthcare_provider_taxonomy_code_4,L.healthcare_provider_primary_taxonomy_switch_4},
																										{L.healthcare_provider_taxonomy_code_5,L.healthcare_provider_primary_taxonomy_switch_5},
																										{L.healthcare_provider_taxonomy_code_6,L.healthcare_provider_primary_taxonomy_switch_6},
																										{L.healthcare_provider_taxonomy_code_7,L.healthcare_provider_primary_taxonomy_switch_7},
																										{L.healthcare_provider_taxonomy_code_8,L.healthcare_provider_primary_taxonomy_switch_8},
																										{L.healthcare_provider_taxonomy_code_9,L.healthcare_provider_primary_taxonomy_switch_9},
																										{L.healthcare_provider_taxonomy_code_10,L.healthcare_provider_primary_taxonomy_switch_10},
																										{L.healthcare_provider_taxonomy_code_11,L.healthcare_provider_primary_taxonomy_switch_11},
																										{L.healthcare_provider_taxonomy_code_12,L.healthcare_provider_primary_taxonomy_switch_12},
																										{L.healthcare_provider_taxonomy_code_13,L.healthcare_provider_primary_taxonomy_switch_13},
																										{L.healthcare_provider_taxonomy_code_14,L.healthcare_provider_primary_taxonomy_switch_14},
																										{L.healthcare_provider_taxonomy_code_15,L.healthcare_provider_primary_taxonomy_switch_15}
																										],HealthCareProvider.Layouts.NPPES_TAXONOMY
																									);
		SELF.TAXONOMY											:=	Taxonomy_DS (switch = 'Y') [1].taxonomy_code;
		SELF.TAXONOMY_CODE								:=	Taxonomy_DS (switch = 'Y') [1].taxonomy_code [1..4];
		SELF.MEDICARE_FACILITY_NUMBER			:=	'';
		SELF.MEDICAID_NUMBER							:=	'';
		SELF.NCPDP_NUMBER									:=	'';
		SELF.SPECIALITY_CODE							:=	'';
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	IF (ut.isNumeric(NPI),NPI,'');
		SELF.CleavePenalty								:=	0;
	END;

	Provider_DS := NORMALIZE (Infile,2,getProviderInfo (LEFT,COUNTER)) (TRIM(LNAME) <> '' AND TRIM(FNAME) <> '' AND TRIM(ZIP) <> '' AND TRIM(PRIM_NAME) <> '');

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));

	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,DT_NPI_DEACT,LNAME,FNAME,MNAME,SNAME,GENDER,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,FAX,LIC_NBR,LIC_STATE,TAXONOMY,SOURCE_RID,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,DT_NPI_DEACT,LNAME,FNAME,MNAME,SNAME,GENDER,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,PHONE,FAX,LIC_NBR,LIC_STATE,TAXONOMY,LOCAL);
	
	RETURN DE_Provider_DS (TRIM(Lname) <> '' and TRIM(FNAME) <> '' and (INTEGER)TRIM(zip) > 0 and TRIM(PRIM_NAME) <> '');
	// RETURN Provider_DS;
END;