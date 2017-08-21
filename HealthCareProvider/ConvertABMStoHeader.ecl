import CLUEAuto, mdr;
EXPORT ConvertABMStoHeader (DATASET (Layouts.ABMS) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header getProviderInfo (Layouts.ABMS L, INTEGER C) := TRANSFORM 
		SELF.RID													:=	0;
		SELF.LNPID												:=	0;
		SELF.DID													:=	(INTEGER)L.DID;
		SELF.BDID													:=	(INTEGER)L.bdid;

		SELF.DOTID												:= 	0;
		SELF.EMPID												:= 	0;
		SELF.POWID												:= 	0;
		SELF.PROXID												:= 	0;
		SELF.SELEID												:=	0;
		SELF.ORGID												:= 	0;
		SELF.ULTID												:= 	0;

		SELF.SRC													:=	MDR.SourceTools.src_ABMS;
		SELF.SOURCE_RID										:=	L.SOURCE_REC_ID;

		SELF.DT_FIRST_SEEN								:=	0;//(INTEGER)L.dt_first_seen;
		SELF.DT_LAST_SEEN									:=	0;//(INTEGER)L.dt_last_seen;
		SELF.DT_VENDOR_FIRST_REPORTED			:=	(INTEGER)L.dt_vendor_first_reported;
		SELF.DT_VENDOR_LAST_REPORTED			:=	(INTEGER)L.dt_vendor_last_reported;
		SELF.DT_LIC_EXPIRATION						:=	0;
		SELF.DT_DEA_EXPIRATION						:=	0;//(INTEGER)L.rawaddressfields.exp_date;
		
		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';
		SELF.DID_FLAG											:=	'';				
		SELF.SSN_FLAG											:=	'';		
		SELF.DOB_FLAG											:=	'';		
		SELF.LIC_NBR_FLAG									:=	'';   
		SELF.FNAME_FLAG										:=	'';		
		SELF.MNAME_FLAG										:=	'';		
		SELF.LNAME_FLAG										:=	'';		
		SELF.ADDR_FLAG										:=	'';		
		SELF.TAX_ID_FLAG									:=	'';	
		SELF.FEIN_FLAG										:=	'';
		SELF.UPIN_FLAG										:=	'';
		SELF.NPI_NUMBER_FLAG							:=	'';					
		SELF.DEA_NUMBER_FLAG							:=	'';							
		SELF.PHONE_FLAG										:=	'';		
		SELF.CLIA_NUMBER_FLAG							:=	'';
		
		SELF.SUPPRESS_ADDRESS							:=	'';
		
		SELF.SSN													:=	'';
		SELF.DOB													:=	IF (isValidDOB(L.DOB),(INTEGER)L.DOB,0);
		SELF.PHONE												:=	L.clean_phone.phone;

		SELF.LIC_NBR											:=	'';
		SELF.C_LIC_NBR										:=	'';
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		
		SELF.TITLE												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_name.title)),' '),LEFT,RIGHT);
		SELF.FNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_name.fname)),' '),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_name.mname)),' '),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_name.lname)),' '),LEFT,RIGHT);	 
		SELF.SNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_name.name_suffix)),' '),LEFT,RIGHT);
		SELF.CNAME												:=	'';
		SELF.SIC_CODE											:=	'';
		GENDER														:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.GENDER));
		SELF.GENDER												:=	IF (GENDER IN ['M','F'],GENDER,'');
		
		SELF.DERIVED_GENDER								:=	'';

		SELF.ADDRESS_ID										:=	L.ace_aid;
		SELF.ADDRESS_CLASSIFICATION				:=	'';

		SELF.PRIM_RANGE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.prim_range)); 
		SELF.PREDIR												:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.predir));		
		SELF.PRIM_NAME										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.prim_name));
		SELF.ADDR_SUFFIX									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.addr_suffix));
		SELF.POSTDIR											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.postdir));		
		SELF.UNIT_DESIG										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.unit_desig));
		SELF.SEC_RANGE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.sec_range));
		SELF.P_CITY_NAME									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.p_city_name));
		SELF.V_CITY_NAME									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.v_city_name));
		SELF.ST														:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.st));		
		SELF.ZIP													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.zip));		
		SELF.ZIP4													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.zip4));		
		SELF.CART													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.cart));		
		SELF.CR_SORT_SZ										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.cr_sort_sz));
		SELF.LOT													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.lot));		
		SELF.LOT_ORDER										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.lot_order));
		SELF.DBPC													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.dbpc));		
		SELF.CHK_DIGIT										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.chk_digit));
		SELF.REC_TYPE											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.rec_type));
		SELF.FIPS_STATE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.fips_state));
		SELF.FIPS_COUNTY									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.fips_county));
		SELF.GEO_LAT											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.geo_lat));	
		SELF.GEO_LONG											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.geo_long));
		SELF.MSA													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.msa));		
		SELF.GEO_BLK											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.geo_blk));
		SELF.GEO_MATCH										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.geo_match));
		SELF.ERR_STAT											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.clean_company_address.err_stat));

		SELF.DEATH_IND										:=	L.dead_ind;
		SELF.DOD													:=	(integer)L.DOD;
		
		SELF.TAX_ID												:=	0;
		SELF.FEIN													:=	0;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	L.NPI;
		SELF.DEA_NUMBER										:=	'';
		SELF.CLIA_NUMBER									:=	'';
		SELF.VENDOR_ID										:=	L.biog_number;
	END;

	Provider_DS := PROJECT (Infile,getProviderInfo (LEFT,COUNTER)) (LNAME <> '' AND FNAME <> '' AND ZIP <> '' AND PRIM_NAME <> '');

	D_Provider_DS := DISTRIBUTE (Provider_DS,HASH32(VENDOR_ID));
	
	S_Provider_DS := SORT (D_Provider_DS,VENDOR_ID,LNAME,FNAME,MNAME,SNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,NPI_NUMBER,TAX_ID,DOB,PHONE,DOD,NPI_NUMBER,SOURCE_RID,LOCAL);

	DE_Provider_DS := DEDUP	(S_Provider_DS,VENDOR_ID,LNAME,FNAME,MNAME,SNAME,PRIM_RANGE,PREDIR,PRIM_NAME,ADDR_SUFFIX,POSTDIR,SEC_RANGE,ZIP,NPI_NUMBER,TAX_ID,DOB,PHONE,DOD,NPI_NUMBER,LOCAL);
	
	RETURN DE_Provider_DS (Lname <> '' and FNAME <> '' and zip <> '' and PRIM_NAME <> '');
END;