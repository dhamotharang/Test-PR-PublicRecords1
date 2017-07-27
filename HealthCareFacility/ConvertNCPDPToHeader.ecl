import MDR, Address, ut, Enclarity, HealthCareProvider, STD, CCLUE_Contribution;
EXPORT ConvertNCPDPToHeader (DATASET (HealthCareFacility.Layouts.NCPDP_REC) Infile = HealthCareFacility.Files.NCPDP_DS) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getFacilityInfo (HealthCareFacility.Layouts.NCPDP_REC L, INTEGER C) := TRANSFORM, SKIP (C IN [1,2] AND TRIM(L.LEGAL_BUSINESS_NAME) = '' OR 
										 																																																																				 C IN [3,4] AND TRIM(L.DBA) = '')
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
		SELF.SOURCE_RID										:=	0;
		SELF.CLEAVEPENALTY								:=	0;

		SELF.DT_FIRST_SEEN								:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_first_seen,8,1)),(INTEGER)L.dt_first_seen,0);
		SELF.DT_LAST_SEEN									:=	IF(HealthCareProvider.isValidDate(INTFORMAT(L.dt_last_seen,8,1)),(INTEGER)L.dt_last_seen,0);
		SELF.DT_VENDOR_FIRST_REPORTED			:=	0;
		SELF.DT_VENDOR_LAST_REPORTED			:=	0;
		SELF.DT_LIC_BEGIN									:=	0;
		SELF.DT_LIC_EXPIRATION						:=	0;
		SELF.DT_DEA_EXPIRATION						:=	0;
		SELF.DT_NPI_DEACT									:=	0;
		SELF.DT_ADDRESS_VERIFIED					:=	0;
		
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
		SELF.ADDR_FLAG										:=	'';		
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	'';
		SELF.FAX_FLAG											:=	'';
		SELF.CLIA_NUMBER_FLAG							:=	'';
		SELF.TAXONOMY_FLAG								:=	'';

		SELF.SUPPRESS_ADDRESS							:=	'';
		
		SELF.SSN													:=	'';
		SELF.DOB													:=	0;
		SELF.PHONE												:=	HealthCareProvider.Clean_Phone(L.Phys_loc_Phone);
		SELF.FAX													:=	HealthCareProvider.Clean_Phone(L.Phys_loc_Fax_Number);
		
		LIC_NBR														:=	TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(HealthCareProvider.CleanData.DL_No,stringLib.stringToUpperCase(L.State_License_Number),''),LEFT,RIGHT)),''),LEFT,RIGHT);
		SELF.LIC_NBR											:=	IF (LIC_NBR IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NBR);
		C_LIC_NO													:=	IF (LIC_NBR IN HealthCareProvider.Constants.Bogus_LIC,'',LIC_NBR);
		SELF.C_LIC_NBR										:=	HealthCareProvider.Clean_License (C_LIC_NO);
		
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		SELF.LIC_STATUS										:=	'';
		
		SELF.TITLE												:=	'';
		SELF.FNAME												:=	'';
		SELF.MNAME												:=	'';
		SELF.LNAME												:=	'';
		SELF.SNAME												:=	'';
		SELF.SIC_CODE											:=	'';
		DBA																:=	IF(std.str.contains(L.DBA,L.Store_Number,true),L.DBA,L.DBA + ' ' + L.Store_Number);
		SELF.CNAME												:=	IF (C  IN [1,2],HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Legal_Business_Name)), 
																												  HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(DBA))); 																											
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
		SELF.ADDRESS_ID										:=	IF (C IN [1,3],L.append_phyaceaid,L.append_mailaceaid);
		SELF.ADDRESS_CLASSIFICATION				:=	MAP (L.append_phyaceaid > 0 AND L.append_mailaceaid > 0 AND L.append_mailaceaid = L.append_phyaceaid => 'B',C IN [1,3] => 'P', 'M');

		AddressLine1 := IF (C IN [1,3],L.phys_loc_address1 + ' ' + L.phys_loc_address2,L.append_mailaddr1);
		AddressLine2 := IF (C IN [1,3],Address.Addr2FromComponents(L.phys_loc_city, L.phys_loc_state, L.phys_loc_full_zip [1..5]),L.append_mailaddrlast);

		CleanedAddress := Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;																					 

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
		
		SELF.TAX_ID												:=	(INTEGER)L.State_Income_Tax_ID;
		SELF.FEIN													:=	(INTEGER)L.Federal_Tax_ID;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	L.National_Provider_ID;
		SELF.DEA_BUS_ACT_IND							:=	'';
		SELF.DEA_NUMBER										:=	L.Dea_Registration_ID;
		SELF.CLIA_NUMBER									:=	'';
		SELF.TAXONOMY											:=	'';
		SELF.TAXONOMY_CODE								:=	'';
		SELF.MEDICARE_FACILITY_NUMBER			:=	L.MEDICARE_PROVIDER_ID;
		SELF.PROVIDER_STATUS							:=	'';
		SELF.VENDOR_ID										:=	L.NCPDP_Provider_ID;
	END;

	Provider_DS := NORMALIZE (Infile,4,getFacilityInfo (LEFT,COUNTER));

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));

	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,LIC_NBR,PHONE,TAX_ID,FEIN,NPI_NUMBER,DEA_NUMBER,MEDICARE_FACILITY_NUMBER,SOURCE_RID,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,CNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,LIC_NBR,PHONE,TAX_ID,FEIN,NPI_NUMBER,DEA_NUMBER,MEDICARE_FACILITY_NUMBER,LOCAL);
	
	RETURN DE_Provider_DS (TRIM(CNAME) <> '' AND (INTEGER)TRIM(zip) > 0 AND TRIM(PRIM_NAME) <> '');
END;