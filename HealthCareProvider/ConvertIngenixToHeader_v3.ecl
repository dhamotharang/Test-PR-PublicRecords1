IMPORT Health_Provider_Test;
IMPORT CLUEAuto;

EXPORT ConvertIngenixToHeader_v3(DATASET(Layouts.INGENIX_DID) Infile, boolean useLocal = true, string persistPath = '~thor21::bbounds::provider_header::') := FUNCTION

	Health_Provider_Test.Layouts.HealthCareProvider_Header getProviderInfo (Layouts.INGENIX_DID L) := TRANSFORM 
		SELF.RID													:=	0;
		SELF.HCID													:=	0;
		SELF.DID													:=	(INTEGER)L.DID;
		SELF.BDID													:=	0;

		SELF.DOTID												:= 	0;//(INTEGER)L.ProviderNameTierID;
		SELF.EMPID												:= 	0;
		SELF.POWID												:= 	0;
		SELF.PROXID												:= 	0;
		SELF.ORGID												:= 	0;
		SELF.ULTID												:= 	0;

		SELF.SRC													:=	'INGX';
		SELF.SOURCE_RID										:=	0;

		SELF.DT_FIRST_SEEN								:=	(INTEGER)L.dt_first_seen;
		SELF.DT_LAST_SEEN									:=	(INTEGER)L.dt_last_seen;
		SELF.DT_VENDOR_FIRST_REPORTED			:=	(INTEGER)L.dt_vendor_first_reported;
		SELF.DT_VENDOR_LAST_REPORTED			:=	(INTEGER)L.dt_vendor_last_reported;

		SELF.AMBIGUOUS										:=	'';
		SELF.CONSUMER_DISCLOSURE					:=	'';
		SELF.SSN_IND											:=	'';		
		SELF.DOB_IND											:=	'';		
		SELF.LIC_IND											:=	'';   
		SELF.NAME_IND											:=	'';		
		SELF.ADDR_IND											:=	'';		
		SELF.TAX_IND											:=	'';		
		SELF.PHONE_IND										:=	'';		

		SELF.SSN													:=	'';
		SELF.DOB													:=	(INTEGER)L.birthdate;
		SELF.PHONE												:=	L.phonenumber;
		SELF.PHONE_TYPE										:=	MAP(L.phonetype = 'Office Phone' => 'P', L.phonetype = 'Office Fax' => 'F', L.phonetype);;

		SELF.LIC_NBR											:=	'';
		SELF.LIC_STATE										:=	'';
		SELF.LIC_TYPE											:=	'';
		
		SELF.PROVIDER_TYPE								:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.filetyp));
		SELF.TITLE												:=	'';
		SELF.FNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.firstname)),' '),LEFT,RIGHT);
		SELF.MNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.middlename)),' '),LEFT,RIGHT);
		SELF.LNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.lastname)),' '),LEFT,RIGHT);	 
		SELF.SNAME												:=	TRIM(REGEXREPLACE(CLUEAuto.Constants.Name,CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.suffix)),' '),LEFT,RIGHT);
		SELF.CNAME												:=	'';
		SELF.GENDER												:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.gender));
		SELF.DERIVED_GENDER								:=	'';

		SELF.ADDRESS_ID										:=	(INTEGER)L.addressid;

		SELF.PRIM_RANGE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_prim_range)); 
		SELF.PREDIR												:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_predir));		
		SELF.PRIM_NAME										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_prim_name));
		SELF.ADDR_SUFFIX									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_addr_suffix));
		SELF.POSTDIR											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_postdir));		
		SELF.UNIT_DESIG										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_unit_desig));
		SELF.SEC_RANGE										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_sec_range));
		SELF.P_CITY_NAME									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_p_city_name));
		SELF.V_CITY_NAME									:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_v_city_name));
		SELF.ST														:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_st));		
		SELF.ZIP													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_zip));		
		SELF.ZIP4													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_zip4));		
		SELF.CART													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_cart));		
		SELF.CR_SORT_SZ										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_cr_sort_sz));
		SELF.LOT													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_lot));		
		SELF.LOT_ORDER										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_lot_order));
		SELF.DBPC													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_dpbc));		
		SELF.CHK_DIGIT										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_chk_digit));
		SELF.REC_TYPE											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_record_type));
		SELF.COUNTY												:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_fipscounty));		
		SELF.GEO_LAT											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_geo_lat));	
		SELF.GEO_LONG											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_geo_long));
		SELF.MSA													:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_msa));		
		SELF.GEO_BLK											:=	'';
		SELF.GEO_MATCH										:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_geo_match));
		SELF.ERR_STAT											:=	CLUEAuto.CleanData.fUpperCleanSpaces(CLUEAuto.CleanData.fReplaceUnprintable(L.PROV_CLEAN_err_stat));

		SELF.DEATH_IND										:=	L.deceasedindicator;
		SELF.DOD													:=	(INTEGER)L.deceaseddate;
		
		SELF.TAX_ID												:=	(INTEGER)L.taxid;
		SELF.UPIN													:=	'';
		SELF.NPI_NUMBER										:=	'';
		SELF.DEA_NUMBER										:=	'';
		SELF.VENDOR_ID										:=	L.providerid;
	END;

  //
  // Only the current rows of the Ingenix main provider file
  //
  ingenixDidRawRs1 := DISTRIBUTE(Infile) : PERSIST(persistPath + 'ingenix_did_raw');
  ingenixDidRawRs2 := IF(useLocal,
    DATASET(persistPath + 'ingenix_did_raw', HealthCareProvider.Layouts.INGENIX_DID, THOR),
    ingenixDidRawRs1);
  ingenixDidRawRs  := ingenixDidRawRs2;
  
  //
  // Calculate the latest Process Date
  //
  currentProcessdateRs1 := ingenixDidRawRs;
  currentProcessdateRs2 := TABLE(currentProcessdateRs1,
    {
        TYPEOF(Infile.processdate) maxProcessdate := MAX(GROUP, processdate);
    });
  currentProcessdateRs  := currentProcessdateRs2;
  currentProcessdate    := currentProcessdateRs[1].maxProcessdate;
  //
  // Find all the provider ids for the current processdate
  //
  
  currentInfileRs1      := DISTRIBUTE(ingenixDidRawRs, HASH32(providerid));
  currentInfileRs2      := SORT(currentInfileRs1, providerid, LOCAL);   // rhs ... to find all rows for current provider ids
  currentInfileRs3      := currentInfileRs2(processdate = currentProcessdate);
  currentInfileRs4      := DEDUP(currentInfileRs3, providerid, LOCAL);   // lhs ... list of current provider ids
  currentInfileRs5      := JOIN(currentInfileRs4, currentInfileRs2,
    LEFT.providerid = RIGHT.providerid,
    TRANSFORM(RIGHT),
    LOCAL);
  currentInfileRs       := currentInfileRs5;   // distributed/sorted lhs ... multiple times
  
	Provider_DS           := PROJECT(currentInfileRs, getProviderInfo(LEFT));

  //
  // Provider record in Header Layout
  //
	D_Provider_DS  := DISTRIBUTE(Provider_DS, HASH32(Vendor_ID));
	S_Provider_DS1 :=	SORT(D_Provider_DS,
    VENDOR_ID,    PROVIDER_TYPE,  LNAME,       FNAME,        MNAME,
    SNAME,        GENDER,         PRIM_RANGE,  PREDIR,       PRIM_NAME,
    ADDR_SUFFIX,  POSTDIR,        SEC_RANGE,   V_CITY_NAME,  ST,
    ZIP,          TAX_ID,         DOB,
    LOCAL);
  S_Provider_DS2 := DEDUP(S_Provider_DS1,
    VENDOR_ID,    PROVIDER_TYPE,  LNAME,       FNAME,        MNAME,
    SNAME,        GENDER,         PRIM_RANGE,  PREDIR,       PRIM_NAME,
    ADDR_SUFFIX,  POSTDIR,        SEC_RANGE,   V_CITY_NAME,  ST,
    ZIP,          TAX_ID,         DOB,
    LOCAL);
  S_Provider_DS  := S_Provider_DS2;
  
  //
  // Ingenix DEA file
  //
  D_DEA_DS1 := DISTRIBUTE(HealthCareProvider.Files.DEA_DS) : PERSIST(persistPath + 'ingenix_dea_raw');
  D_DEA_DS2 := IF(useLocal,
    DATASET(persistPath + 'ingenix_dea_raw', HealthCareProvider.Layouts.INGENIX_DEA, THOR),
    D_DEA_DS1);
  D_DEA_DS3 := DISTRIBUTE(D_DEA_DS2, HASH32(providerid));
  D_DEA_DS4 := SORT(D_DEA_DS3, providerid, deanumber, LOCAL);
  D_DEA_DS5 := JOIN(currentInfileRs, D_DEA_DS4,
    LEFT.providerid = RIGHT.providerid
      AND LEFT.processdate = RIGHT.processdate,
    TRANSFORM(RIGHT),
    INNER,
    LOCAL);
	D_DEA_DS6 := SORT(D_DEA_DS5, PROVIDERID, FILETYP, DEANUMBER, LOCAL);
  D_DEA_DS7 := DEDUP(D_DEA_DS6, PROVIDERID, FILETYP, DEANUMBER, LOCAL);
  D_DEA_DS  := D_DEA_DS7;

  //
  // Ingenix NPI file
  //
  D_NPI_DS1  := DISTRIBUTE(HealthCareProvider.Files.NPI_DS) : PERSIST(persistPath + 'ingenix_npi_raw');
  D_NPI_DS1a := IF(useLocal,
    DATASET(persistPath + 'ingenix_npi_raw', HealthCareProvider.Layouts.INGENIX_NPI, THOR),
    D_NPI_DS1);
  D_NPI_DS2  := DISTRIBUTE(D_NPI_DS1a, HASH32(providerid));
  D_NPI_DS3  := SORT(D_NPI_DS2, providerid, npi, LOCAL);
  D_NPI_DS4  := JOIN(currentInfileRs, D_NPI_DS3,
    LEFT.providerid = RIGHT.providerid
      AND LEFT.processdate = RIGHT.processdate,
    TRANSFORM(RIGHT),
    INNER,
    LOCAL);
	D_NPI_DS5  := SORT(D_NPI_DS4, PROVIDERID, FILETYP, NPI, LOCAL);
  D_NPI_DS6  := DEDUP(D_NPI_DS5, PROVIDERID, FILETYP, NPI, LOCAL);
  D_NPI_DS   := D_NPI_DS6;
  
	//
  // Ingenix LIC file
  //
  D_LIC_DS1  := DISTRIBUTE(HealthCareProvider.Files.LIC_DS) : PERSIST(persistPath + 'ingenix_lic_raw');
  D_LIC_DS1a := if(useLocal,
    DATASET(persistPath + 'ingenix_lic_raw', HealthCareProvider.Layouts.INGENIX_LIC, THOR),
    D_LIC_DS1);
  D_LIC_DS1b := PROJECT(D_LIC_DS1a,
    TRANSFORM(HealthCareProvider.Layouts.INGENIX_LIC,
      SELF.licensenumber := TRIM(
        REGEXREPLACE(
          '\\s',
          stringLib.stringToUpperCase(
            TRIM(
              REGEXREPLACE(
                CLUEAuto.Constants.DL_No,
                stringLib.stringToUpperCase(Left.licensenumber),
                ''),
              LEFT,
              RIGHT)),
            ''),
        LEFT,
        RIGHT);
      SELF := LEFT;));
  D_LIC_DS2 := DISTRIBUTE(D_LIC_DS1b, HASH32(providerid));
  D_LIC_DS3 := SORT(D_LIC_DS2, providerid, licensenumber, LOCAL);
  D_LIC_DS4 := JOIN(currentInfileRs, D_LIC_DS3,
    LEFT.providerid = RIGHT.providerid
      AND LEFT.processdate = RIGHT.processdate,
    TRANSFORM(RIGHT),
    INNER,
    LOCAL);
	D_LIC_DS5 := SORT(D_LIC_DS4, PROVIDERID, FILETYP, LICENSESTATE, LICENSENUMBER, LOCAL);
  D_LIC_DS6 := DEDUP(D_LIC_DS5, PROVIDERID, FILETYP, LICENSESTATE, LICENSENUMBER, LOCAL);
  D_LIC_DS  := D_LIC_DS6;
  
  //
  // Ingenix UPIN file
  //
  D_UPIN_DS1 := DISTRIBUTE(HealthCareProvider.Files.UPIN_DS) : PERSIST(persistPath + 'ingenix_upin_raw');
  D_UPIN_DS1a := IF(useLocal,
    DATASET(persistPath + 'ingenix_upin_raw', HealthCareProvider.Layouts.INGENIX_UPIN, THOR),
    D_UPIN_DS1);
  D_UPIN_DS2 := DISTRIBUTE(D_UPIN_DS1a, HASH32(providerid));
  D_UPIN_DS3 := SORT(D_UPIN_DS2, providerid, upin, LOCAL);
  D_UPIN_DS4 := JOIN(currentInfileRs, D_UPIN_DS3,
    LEFT.providerid = RIGHT.providerid
      AND LEFT.processdate = RIGHT.processdate,
    TRANSFORM(RIGHT),
    INNER,
    LOCAL);
	D_UPIN_DS5 := SORT(D_UPIN_DS4, PROVIDERID, FILETYP, UPIN, LOCAL);
  D_UPIN_DS6 := DEDUP(D_UPIN_DS5, PROVIDERID, FILETYP, UPIN, LOCAL);
  D_UPIN_DS  := D_UPIN_DS6;
  
  finalIngenixHdrRs1 := S_Provider_DS;
  finalIngenixHdrRs2 := JOIN(finalIngenixHdrRs1, D_DEA_DS,    // Add DEA number
    LEFT.VENDOR_ID = RIGHT.PROVIDERID
      AND LEFT.PROVIDER_TYPE = RIGHT.FILETYP,
    TRANSFORM(Health_Provider_Test.Layouts.HealthCareProvider_Header,
      SELF.DEA_NUMBER := RIGHT.DEANUMBER;
      SELF := LEFT),
    LEFT OUTER,
    LOCAL);
    
  finalIngenixHdrRs3 := JOIN(finalIngenixHdrRs2, D_NPI_DS,    // Add NPI number
    LEFT.VENDOR_ID = RIGHT.PROVIDERID
      AND LEFT.PROVIDER_TYPE = RIGHT.FILETYP,
    TRANSFORM(Health_Provider_Test.Layouts.HealthCareProvider_Header,
      SELF.NPI_NUMBER := RIGHT.NPI;
      SELF := LEFT),
    LEFT OUTER,
    LOCAL);
    
  finalIngenixHdrRs4 := JOIN(finalIngenixHdrRs3, D_LIC_DS,    // Add LIC number
    LEFT.VENDOR_ID = RIGHT.PROVIDERID
      AND LEFT.PROVIDER_TYPE = RIGHT.FILETYP,
    TRANSFORM(Health_Provider_Test.Layouts.HealthCareProvider_Header,
      SELF.LIC_NBR := RIGHT.licensenumber,
      SELF.LIC_STATE  := RIGHT.licensestate,;
      SELF := LEFT),
    LEFT OUTER,
    LOCAL);
    
  finalIngenixHdrRs5 := JOIN(finalIngenixHdrRs4, D_UPIN_DS,    // Add UPIN number
    LEFT.VENDOR_ID = RIGHT.PROVIDERID
      AND LEFT.PROVIDER_TYPE = RIGHT.FILETYP,
    TRANSFORM(Health_Provider_Test.Layouts.HealthCareProvider_Header,
      SELF.UPIN := RIGHT.upin,
      SELF := LEFT),
    LEFT OUTER,
    LOCAL);

  finalIngenixHdrRs  := finalIngenixHdrRs5;
    
	// D_DEANO_DS	:=	DISTRIBUTE (ADD_DEA_NO,HASH32(VENDOR_ID));
	
	// D_NPI_DS :=	DISTRIBUTE (HealthCareProvider.Files.NPI_DS,HASH32(PROVIDERID));
	
	// S_NPI_DS := DEDUP (SORT (D_NPI_DS,PROVIDERID,FILETYP,NPI,LOCAL),PROVIDERID,FILETYP,NPI,LOCAL);
	
	// ADD_NPI_NO	:=	JOIN (D_DEANO_DS,S_NPI_DS,LEFT.VENDOR_ID = RIGHT.PROVIDERID AND LEFT.PROVIDER_TYPE = RIGHT.FILETYP,
												// TRANSFORM (Health_Provider_Test.Layouts.HealthCareProvider_Header, SELF.NPI_NUMBER := RIGHT.npi; SELF := LEFT;), LEFT OUTER, LOCAL);

	// Clean_LIC_DS	:=	PROJECT (HealthCareProvider.Files.LIC_DS ,TRANSFORM(HealthCareProvider.Layouts.INGENIX_LIC, self.licensenumber := TRIM(REGEXREPLACE('\\s',stringLib.stringToUpperCase(TRIM(REGEXREPLACE(CLUEAuto.Constants.DL_No,stringLib.stringToUpperCase(Left.licensenumber),''),LEFT,RIGHT)),''),LEFT,RIGHT); self := left;));
	
	// D_LIC_DS	:=	DISTRIBUTE (Clean_LIC_DS,HASH32(PROVIDERID));

	// S_LIC_DS := DEDUP (SORT	(D_LIC_DS,PROVIDERID,FILETYP,LICENSENUMBER,LOCAL),PROVIDERID,FILETYP,LICENSENUMBER,LOCAL);
	
	// D_ADD_NPI_DS := DISTRIBUTE (ADD_NPI_NO,HASH32(VENDOR_ID));

	// ADD_LIC_DS := JOIN (D_ADD_NPI_DS,S_LIC_DS,LEFT.VENDOR_ID = RIGHT.providerid AND LEFT.PROVIDER_TYPE = RIGHT.FILETYP,
											// TRANSFORM (Health_Provider_Test.Layouts.HealthCareProvider_Header, SELF.LIC_NBR := RIGHT.licensenumber; SELF.LIC_STATE := RIGHT.licensestate;  SELF := LEFT;), LEFT OUTER, LOCAL);

	// D_UPIN_DS	:=	DISTRIBUTE (HealthCareProvider.Files.UPIN_DS,HASH32(PROVIDERID));

	// S_UPIN_DS := DEDUP (SORT	(D_UPIN_DS,PROVIDERID,UPIN,LOCAL),PROVIDERID,UPIN,LOCAL);
	
	// D_ADD_LIC_DS := DISTRIBUTE (ADD_LIC_DS,HASH32(VENDOR_ID));

	// ADD_UPIN_DS := JOIN (D_ADD_LIC_DS,S_UPIN_DS,LEFT.VENDOR_ID = RIGHT.providerid,
											// TRANSFORM (Health_Provider_Test.Layouts.HealthCareProvider_Header, SELF.UPIN := RIGHT.UPIN; SELF := LEFT;), LEFT OUTER, LOCAL);
                      
  OUTPUT (currentProcessdate, NAMED('CurrentProcessdate'));
  OUTPUT (COUNT(Infile), NAMED('RawIngenixCount'));
  OUTPUT (COUNT(currentInfileRs), NAMED('CurrentInfileRawCount'));
	OUTPUT (COUNT(Provider_DS),NAMED('CurrentIngenixHdrCount'));
	OUTPUT (COUNT(S_Provider_DS),NAMED('DedupedProviderCount'));	
	OUTPUT (COUNT(D_DEA_DS),NAMED('DeaDatasetCount'));
	OUTPUT (COUNT(D_NPI_DS),NAMED('NpiDatasetCount'));
	OUTPUT (COUNT(D_LIC_DS),NAMED('LicDatasetCount'));
	OUTPUT (COUNT(D_UPIN_DS),NAMED('UpinDatasetCount'));
	OUTPUT (COUNT(finalIngenixHdrRs2),NAMED('WithDeaDatasetCount'));	
	OUTPUT (COUNT(finalIngenixHdrRs3),NAMED('WithNpiDatasetCount'));	
	OUTPUT (COUNT(finalIngenixHdrRs4),NAMED('WithLicDatasetCount'));	
	OUTPUT (COUNT(finalIngenixHdrRs5),NAMED('WithUpinDatasetCount'));		
	RETURN finalIngenixHdrRs;
END;

