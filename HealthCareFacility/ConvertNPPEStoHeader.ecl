import MDR, Address, ut, Enclarity, HealthCareProvider, CCLUE_Contribution;
EXPORT ConvertNPPEStoHeader (DATASET (HealthCareProvider.Layouts.NPPES_DID) Infile = HealthCareFacility.Files.NPPES_DID_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getFacilityInfo (HealthCareProvider.Layouts.NPPES_DID L, INTEGER C) := TRANSFORM, SKIP (C = 1 AND TRIM(L.Provider_Organization_Name) = '' OR
																																																																																C = 2 AND TRIM(L.Provider_Organization_Name) = '' OR
																																																																																C = 3 AND TRIM(L.Provider_Other_Organization_Name) = '' OR
																																																																																C = 4 AND TRIM(L.Provider_Other_Organization_Name) = '')
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

		SELF.SRC													:=	MDR.SourceTools.src_NPPES;
		SELF.SOURCE_RID										:=	L.SOURCE_REC_ID;
		SELF.CLEAVEPENALTY								:=	0;

		SELF.DT_FIRST_SEEN								:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_first_seen,8,1)),(INTEGER)L.dt_first_seen,0);
		SELF.DT_LAST_SEEN									:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_last_seen,8,1)),(INTEGER)L.dt_last_seen,0);
		SELF.DT_VENDOR_FIRST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_first_reported,8,1)),(INTEGER)L.dt_vendor_first_reported,0);
		SELF.DT_VENDOR_LAST_REPORTED			:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_vendor_last_reported,8,1)),(INTEGER)L.dt_vendor_last_reported,0);
		SELF.DT_LIC_BEGIN									:=	0;
		SELF.DT_LIC_EXPIRATION						:=	0;
		SELF.DT_DEA_EXPIRATION						:=	0;
		SELF.DT_NPI_DEACT									:=	IF(HealthCareProvider.isValidDate(L.npi_deactivation_date),(INTEGER)L.npi_deactivation_date,0);
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		
		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';
		
		SELF.ENTITY_TYPE									:=  L.ENTITY_TYPE_CODE;
																						
		SELF.DID_FLAG											:=	'';						
		SELF.SSN_FLAG											:=	'';		
		SELF.DOB_FLAG											:=	'';		
		SELF.C_LIC_NBR_FLAG								:=	'';   
		SELF.FNAME_FLAG										:=	'';		
		SELF.MNAME_FLAG										:=	'';		
		SELF.LNAME_FLAG										:=	'';		
		SELF.CNAME_FLAG										:=	MAP (C IN [1,2] => 'L', C IN [3,4] AND L.provider_other_organization_name_type_code = '3' => 'D', C IN [3,4] AND L.provider_other_organization_name_type_code = '4' => 'L','');		
		SELF.ADDR_FLAG										:=	'';		
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
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

		SELF.IS_STATE_SANCTION						:=	FALSE;
		SELF.IS_OIG_SANCTION							:=	FALSE;
		SELF.IS_OPM_SANCTION							:=	FALSE;				
		
		SELF.SUPPRESS_ADDRESS							:=	'';
		
		SELF.SSN													:=	'';
		SELF.CNSMR_SSN										:=  '';
		SELF.DOB													:=	0;
		SELF.CNSMR_DOB										:=	0;		
		SELF.PHONE												:=	IF (C IN [1,3], HealthCareProvider.Clean_Phone(L.cleanmailingphone),HealthCareProvider.Clean_Phone(L.cleanlocationphone));
		SELF.FAX													:=	IF (C IN [1,3], HealthCareProvider.Clean_Phone(L.provider_business_mailing_address_fax_number),HealthCareProvider.Clean_Phone(L.provider_business_practice_location_address_fax_number));										
		
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
		LIC_NBR														:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(LIC_NO),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.LIC_NBR											:=	IF (LIC_NO IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NO);
		C_LIC_NO													:=	IF (LIC_NBR IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NBR);
		SELF.C_LIC_NBR										:=	HealthCareProvider.Clean_License (C_LIC_NO);
		LIC_STATE													:=	LIC_DS (switch = 'Y') [1].state_code;
		SELF.LIC_STATE										:=	IF (LENGTH(TRIM(LIC_STATE)) = 2,LIC_STATE,'');
		SELF.LIC_TYPE											:=	L.Provider_Credential_Text;
		SELF.LIC_STATUS										:=	'';
		
		SELF.TITLE												:=	''; 
		SELF.FNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.authorized_official_first_name)),' ')),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.authorized_official_middle_name)),' ')),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.authorized_official_last_name)),' ')),LEFT,RIGHT);
		SELF.SNAME												:=	'';
		SELF.SIC_CODE											:=	'';
		// SELF.CNAME												:=	IF (C IN [1,2],HealthCareFacility.FacilityNameCleaner.fnCleanAsConfigured(L.provider_organization_name),
																												 // HealthCareFacility.FacilityNameCleaner.fnCleanAsConfigured(L.provider_other_organization_name));
		SELF.CNAME												:=	IF (C IN [1,2],L.provider_organization_name,L.provider_other_organization_name);
		SELF.CNP_NAMEID										:=	0;
		SELF.CNP_NAME											:=	'';
		SELF.CNP_NUMBER										:=	'';	
		SELF.CNP_STORE_NUMBER							:=	'';
		SELF.CNP_BTYPE										:=	'';		
		SELF.CNP_LOWV											:=	'';
		SELF.CNP_TRANSLATED							 	:= 	false;
		SELF.CNP_CLASSID 									:=	0;
		
		SELF.GENDER												:=	'';
		SELF.DERIVED_GENDER								:=	'';
		SELF.ADDRESS_ID										:=	IF (C IN [1,3],L.aceaid_mailing,L.aceaid_location);
		SELF.ADDRESS_CLASSIFICATION				:=	MAP (L.aceaid_mailing > 0 AND L.aceaid_location > 0 AND L.aceaid_mailing = L.aceaid_location => 'B',C IN [1,3] => 'M', 'P');

		// AddressLine1 := IF (C IN [1,3],L.provider_first_line_business_mailing_address + ' ' + L.provider_second_line_business_mailing_address,L.provider_first_line_business_practice_location_address + ' ' + L.provider_second_line_business_practice_location_address);
		// AddressLine2 := IF (C IN [1,3],Address.Addr2FromComponents(L.provider_business_mailing_address_city_name, L.provider_business_mailing_address_state_name, L.provider_business_mailing_address_postal_code [1..5]),Address.Addr2FromComponents(L.provider_business_practice_location_address_city_name, L.provider_business_practice_location_address_state_name, L.provider_business_practice_location_address_postal_code [1..5]));

		// CleanedAddress := Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;																					 

		boolean isSuite (string pInput) := REGEXFIND(('APT|STORE|SUITE|STE'),StringLib.StringToUpperCase(pInput)); 
		
		AddressLine1 := IF (isSuite(L.provider_second_line_business_practice_location_address),trim(L.provider_first_line_business_practice_location_address) + ' ' + trim (L.provider_second_line_business_practice_location_address),L.provider_first_line_business_practice_location_address);
		AddressLine2 := Address.Addr2FromComponents(L.provider_business_practice_location_address_city_name, L.provider_business_practice_location_address_state_name, L.provider_business_practice_location_address_postal_code [1..5]);

		AddressLine3 := IF (isSuite(L.provider_second_line_business_mailing_address),trim(L.provider_first_line_business_mailing_address) + ' ' + trim (L.provider_second_line_business_mailing_address),L.provider_first_line_business_mailing_address);
		AddressLine4 := Address.Addr2FromComponents(L.provider_business_mailing_address_city_name, L.provider_business_mailing_address_state_name, L.provider_business_mailing_address_postal_code [1..5]);

		AddressLine5 := IF (C IN [1,3],AddressLine3,AddressLine1);
		AddressLine6 := IF (C IN [1,3],AddressLine4,AddressLine2);

		CleanedAddress := Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine5, AddressLine6)).addressrecord;																					 

		PRIM_RANGE												:=	IF (C IN [1,3], CleanedAddress.PRIM_RANGE,CleanedAddress.PRIM_RANGE);
		PREDIR														:=	IF (C IN [1,3], CleanedAddress.PREDIR,CleanedAddress.PREDIR);
		PRIM_NAME													:=	IF (C IN [1,3], CleanedAddress.PRIM_NAME,CleanedAddress.PRIM_NAME);
		ADDR_SUFFIX												:=	IF (C IN [1,3], CleanedAddress.ADDR_SUFFIX,CleanedAddress.ADDR_SUFFIX);
		POSTDIR														:=	IF (C IN [1,3], CleanedAddress.POSTDIR,CleanedAddress.POSTDIR);
		UNIT_DESIG												:=	IF (C IN [1,3], CleanedAddress.UNIT_DESIG,CleanedAddress.UNIT_DESIG);
		rec_type													:= 	IF (C IN [1,3], CleanedAddress.REC_TYPE,CleanedAddress.REC_TYPE);
		SEC_RANGE													:=	IF (C IN [1,3], CleanedAddress.SEC_RANGE,CleanedAddress.SEC_RANGE);
		P_CITY														:=	IF (C IN [1,3], CleanedAddress.P_city_name,CleanedAddress.P_city_name);
		V_CITY														:=	IF (C IN [1,3], CleanedAddress.v_city_name,CleanedAddress.v_city_name);
		ST																:=	IF (C IN [1,3], CleanedAddress.ST,CleanedAddress.ST);
		ZIP																:=	IF (C IN [1,3], CleanedAddress.ZIP,CleanedAddress.ZIP);
		ZIP4															:=	IF (C IN [1,3], CleanedAddress.ZIP4,CleanedAddress.ZIP4);

		CART															:=	IF (C IN [1,3], CleanedAddress.CART,CleanedAddress.CART);
		CR_SORT_SZ												:=	IF (C IN [1,3], CleanedAddress.CR_SORT_SZ,CleanedAddress.CR_SORT_SZ);
		LOT																:=	IF (C IN [1,3], CleanedAddress.LOT,CleanedAddress.LOT);
		LOT_ORDER													:=	IF (C IN [1,3], CleanedAddress.LOT_ORDER,CleanedAddress.LOT_ORDER);
		DBPC															:=	IF (C IN [1,3], CleanedAddress.DBPC,CleanedAddress.DBPC);
		CHK_DIGIT													:=	IF (C IN [1,3], CleanedAddress.CHK_DIGIT,CleanedAddress.CHK_DIGIT);
		COUNTY														:=	IF (C IN [1,3], CleanedAddress.fips_county,CleanedAddress.fips_county);
		STATE															:=	IF (C IN [1,3], CleanedAddress.fips_state,CleanedAddress.fips_state);		
		GEO_LAT														:=	IF (C IN [1,3], CleanedAddress.GEO_LAT,CleanedAddress.GEO_LAT);
		GEO_LONG													:=	IF (C IN [1,3], CleanedAddress.GEO_LONG,CleanedAddress.GEO_LONG);
		MSA																:=	IF (C IN [1,3], CleanedAddress.MSA,CleanedAddress.MSA);
		GEO_BLK														:=	IF (C IN [1,3], CleanedAddress.GEO_BLK,CleanedAddress.GEO_BLK);
		GEO_MATCH													:=	IF (C IN [1,3], CleanedAddress.GEO_MATCH,CleanedAddress.GEO_MATCH);
		ERR_STAT													:=	IF (C IN [1,3], CleanedAddress.ERR_STAT,CleanedAddress.ERR_STAT);
	
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
		
		SELF.TAX_ID												:=	0;
		SELF.FEIN													:=	(INTEGER)IF (L.Employer_Identification_Number <> '<UNAVAIL>','',L.Employer_Identification_Number);
		SELF.UPIN													:=	'';
		NPI																:=	TRIM (L.NPI,LEFT,RIGHT);
		SELF.NPI_NUMBER										:=	IF (ut.isNumeric(NPI),NPI,'');
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
		SELF.TAXONOMY_CODE								:=	Taxonomy_DS (switch = 'Y') [1].taxonomy_code [1..2];
		MEDICARE_FACILITY_NUMBER					:=	IF (L.OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_1 = '06',L.OTHER_PROVIDER_IDENTIFIER_1,'');		
		MEDICARE_FACILITY_NUM							:= 	IF (TRIM(MEDICARE_FACILITY_NUMBER) IN HealthCareFacility.Constants.INVALID_MEDICARE_FAC_NO,'',TRIM(MEDICARE_FACILITY_NUMBER));
		SELF.MEDICARE_FACILITY_NUMBER			:=	TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(MEDICARE_FACILITY_NUM),''),LEFT,RIGHT);
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	IF (ut.isNumeric(NPI),NPI,'');
		SELF															:=	[];
	END;

	Provider_DS := NORMALIZE (Infile(Provider_Organization_Name <> '' OR Provider_Other_Organization_name <> ''),4,getFacilityInfo (LEFT,COUNTER));

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));

	AssignHashValue := PROJECT (D_Provider_DS(TRIM(CName) <> ''and (INTEGER)TRIM(zip) > 0 and TRIM(PRIM_NAME) <> ''),TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
			SELF.LNPID := HASH64(LEFT.BDID + LEFT.DT_NPI_DEACT + LEFT.PHONE_FLAG + LEFT.FAX_FLAG + LEFT.PHONE + LEFT.FAX + LEFT.LIC_NBR + LEFT.C_LIC_NBR + LEFT.LIC_STATE + LEFT.LIC_TYPE + LEFT.LIC_STATUS +  
													 LEFT.FNAME + LEFT.MNAME + LEFT.LNAME + LEFT.CNAME + LEFT.PRIM_RANGE + LEFT.PRIM_NAME + LEFT.SEC_RANGE + LEFT.V_CITY_NAME + LEFT.ST + LEFT.ZIP +
													 LEFT.FEIN + LEFT.NPI_NUMBER + LEFT.TAXONOMY + LEFT.VENDOR_ID); 
			SELF := LEFT;));

	Remove_Duplicates := PROJECT (DEDUP(SORT (DISTRIBUTE(AssignHashValue,HASH32(LNPID)),LNPID,-DT_LAST_SEEN,-DT_VENDOR_LAST_REPORTED,LOCAL),LNPID,LOCAL),TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,
													 SELF.LNPID := 0; SELF := LEFT;));

	RETURN Remove_Duplicates (TRIM(CNAME) <> '' AND (INTEGER)TRIM(zip) > 0 AND TRIM(PRIM_NAME) <> '');
END;