IMPORT MDR;

EXPORT ConvertIngenixToHeader(
    DATASET(Layouts.INGENIX_DID) Infile = Files.INGENIX_DID_DS,
    boolean useLocal = false,
    string persistPath = '~temp::lnpid::') := FUNCTION

    string cleanName(string nameval) := 
      TRIM(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(
        REGEXREPLACE(
          CleanData.Name,
          CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(nameval)),
          ' ')),
        LEFT, RIGHT);

    string cleanFld(string fldval) :=
      CleanData.fUpperCleanSpaces(CleanData.fReplaceUnprintable(fldval));
  
    Layout_HealthProvider.HealthCareProvider_Header_V1 getProviderInfo (Layouts.INGENIX_DID L) := TRANSFORM 
        SELF.RID                          := 0;
        SELF.LNPID                        := 0;
        SELF.DID                          := (INTEGER)L.DID;
        SELF.BDID                         := 0;

        SELF.DOTID                        := 0;
        SELF.EMPID                        := 0;
        SELF.POWID                        := 0;
        SELF.PROXID                       := 0;
        SELF.SELEID                       := 0;
        SELF.ORGID                        := 0;
        SELF.ULTID                        := 0;

        SELF.SRC                          := MDR.SourceTools.src_Ingenix_Sanctions;
        SELF.SOURCE_RID                   := L.SOURCE_REC_ID;

        SELF.DT_FIRST_SEEN                := IF(HealthCareProvider.isValidDate(L.dt_first_seen),(INTEGER)L.dt_first_seen,0);
        SELF.DT_LAST_SEEN                 := IF(HealthCareProvider.isValidDate(L.dt_last_seen),(INTEGER)L.dt_last_seen,0);
        SELF.DT_VENDOR_FIRST_REPORTED     := IF(HealthCareProvider.isValidDate(L.dt_vendor_first_reported),(INTEGER)L.dt_vendor_first_reported,0);
        SELF.DT_VENDOR_LAST_REPORTED      := IF(HealthCareProvider.isValidDate(L.dt_vendor_last_reported),(INTEGER)L.dt_vendor_last_reported,0);
				SELF.DT_LIC_BEGIN									:= 0;        
				SELF.DT_LIC_EXPIRATION            := 0;
        SELF.DT_DEA_EXPIRATION            := 0;
				SELF.DT_NPI_DEACT									:= 0;
				SELF.DT_ADDRESS_VERIFIED					:= IF(HealthCareProvider.isValidDate(L.provideraddressverificationdate),(INTEGER)L.provideraddressverificationdate,0);
				
        SELF.AMBIGUOUS                    := '';
        SELF.CONSUMER_DISCLOSURE          := '';
				SELF.DID_FLAG											:= '';				        
				SELF.SSN_FLAG                     := '';    
        SELF.DOB_FLAG                     := '';    
        SELF.LIC_NBR_FLAG                 := '';   
        SELF.FNAME_FLAG                   := '';    
        SELF.MNAME_FLAG                   := '';    
        SELF.LNAME_FLAG                   := '';    
        SELF.ADDR_FLAG                    := '';    
        SELF.TAX_ID_FLAG                  := '';  
        SELF.FEIN_FLAG                    := '';
        SELF.UPIN_FLAG                    := '';
        SELF.NPI_NUMBER_FLAG              := '';          
        SELF.DEA_NUMBER_FLAG              := '';              
        SELF.PHONE_FLAG                   := '';    
				SELF.FAX_FLAG      		            := '';    
        SELF.CLIA_NUMBER_FLAG             := '';
    		SELF.TAXONOMY_FLAG								:= '';
				
        SELF.SUPPRESS_ADDRESS             := '';
    
        SELF.SSN                          := '';
        SELF.DOB                          := IF (isValidDOB(L.birthdate),(INTEGER)L.birthdate,0);
        SELF.PHONE                        := IF (L.phonetype = 'Office Phone' ,HealthCareProvider.Clean_Phone(L.phonenumber),'');
				SELF.FAX													:= IF (L.phonetype = 'Office Fax'		,HealthCareProvider.Clean_Phone(L.phonenumber),'');
				
        SELF.LIC_NBR                      := '';
				SELF.C_LIC_NBR										:= '';
        SELF.LIC_STATE                    := '';
        SELF.LIC_TYPE                     := '';
				SELF.LIC_STATUS										:= '';
				
        SELF.TITLE                        := '';
        SELF.FNAME                        := cleanName(L.firstname);
        SELF.MNAME                        := cleanName(L.middlename);
        SELF.LNAME                        := cleanName(L.lastname); 
        SELF.SNAME                        := cleanName(L.suffix);
        SELF.CNAME                        := '';
        SELF.SIC_CODE                     := '';
        GENDER                            := cleanFld(L.gender);
        SELF.GENDER                       := IF(GENDER IN ['M','F'], GENDER, '');
        SELF.DERIVED_GENDER               := '';

        SELF.ADDRESS_ID                   := (INTEGER)L.addressid;
        SELF.ADDRESS_CLASSIFICATION       := '';
    
        SELF.PRIM_RANGE                   := cleanFld(L.PROV_CLEAN_prim_range); 
        SELF.PREDIR                       := cleanFld(L.PROV_CLEAN_predir);    
        SELF.PRIM_NAME                    := cleanFld(L.PROV_CLEAN_prim_name);
        SELF.ADDR_SUFFIX                  := cleanFld(L.PROV_CLEAN_addr_suffix);
        SELF.POSTDIR                      := cleanFld(L.PROV_CLEAN_postdir);    
        SELF.UNIT_DESIG                   := cleanFld(L.PROV_CLEAN_unit_desig);
        SELF.SEC_RANGE                    := cleanFld(L.PROV_CLEAN_sec_range);
        SELF.P_CITY_NAME                  := cleanFld(L.PROV_CLEAN_p_city_name);
        SELF.V_CITY_NAME                  := cleanFld(L.PROV_CLEAN_v_city_name);
        SELF.ST                           := cleanFld(L.PROV_CLEAN_st);    
        SELF.ZIP                          := cleanFld(L.PROV_CLEAN_zip);    
        SELF.ZIP4                         := cleanFld(L.PROV_CLEAN_zip4);    
        SELF.CART                         := cleanFld(L.PROV_CLEAN_cart);    
        SELF.CR_SORT_SZ                   := cleanFld(L.PROV_CLEAN_cr_sort_sz);
        SELF.LOT                          := cleanFld(L.PROV_CLEAN_lot);    
        SELF.LOT_ORDER                    := cleanFld(L.PROV_CLEAN_lot_order);
        SELF.DBPC                         := cleanFld(L.PROV_CLEAN_dpbc);    
        SELF.CHK_DIGIT                    := cleanFld(L.PROV_CLEAN_chk_digit);
        SELF.REC_TYPE                     := cleanFld(L.PROV_CLEAN_record_type);
        SELF.FIPS_STATE                   := cleanFld(L.prov_clean_ace_fips_st);
        SELF.FIPS_COUNTY                  := cleanFld(L.prov_clean_fipscounty);
        SELF.GEO_LAT                      := cleanFld(L.PROV_CLEAN_geo_lat);  
        SELF.GEO_LONG                     := cleanFld(L.PROV_CLEAN_geo_long);
        SELF.MSA                          := cleanFld(L.PROV_CLEAN_msa);    
        SELF.GEO_BLK                      := '';
        SELF.GEO_MATCH                    := cleanFld(L.PROV_CLEAN_geo_match);
        SELF.ERR_STAT                     := cleanFld(L.PROV_CLEAN_err_stat);

        SELF.DEATH_IND                    := IF(L.deceasedindicator <> '','Y','');
        SELF.DOD                          := (INTEGER)L.deceaseddate;
    
        SELF.TAX_ID                       := (INTEGER)L.taxid;
        SELF.FEIN                         := 0;
        SELF.UPIN                         := '';
        SELF.NPI_NUMBER                   := '';
				SELF.DEA_BUS_ACT_IND							:= '';
        SELF.DEA_NUMBER                   := '';
        SELF.CLIA_NUMBER                  := '';
				SELF.TAXONOMY											:= '';
				SELF.MEDICARE_FACILITY_NUMBER			:= '';
				SELF.PROVIDER_STATUS							:= '';
        SELF.VENDOR_ID                    := L.providerid;
    END;

    //
    // Create a list of provider ids present in the most recent file. We will only create data
    // for those provider ids.
    //
    ingenixDidRawRs1 := DISTRIBUTE(Infile); // : PERSIST(persistPath + 'ingenix_did_raw');
    ingenixDidRawRs2 := IF(useLocal,
      DATASET(persistPath + 'ingenix_did_raw', Layouts.INGENIX_DID, THOR),
      ingenixDidRawRs1);
    ingenixDidRawRs3 := DISTRIBUTE(ingenixDidRawRs2, HASH32(providerid));
    ingenixDidRawRs  := ingenixDidRawRs3;   // all Ingenix records
  
    currentProcessdateRs1 := ingenixDidRawRs;
    currentProcessdateRs2 := TABLE(currentProcessdateRs1,
      {
          TYPEOF(Infile.processdate) maxProcessdate := MAX(GROUP, processdate);
      });
    currentProcessdateRs  := currentProcessdateRs2;
    currentProcessdate    := currentProcessdateRs[1].maxProcessdate;   // the latest processdate
  
    currentProviderIdRs1  := ingenixDidRawRs;   // previously distributed by providerid
    currentProviderIdRs2  := SORT(currentProviderIdRs1, providerid, LOCAL);   // rhs ... for currentInfileRs
    currentProviderIdRs3  := currentProviderIdRs2(processdate = currentProcessdate);
    currentProviderIdRs4  := DEDUP(currentProviderIdRs3, providerid, LOCAL);
    currentProviderIdRs5  := PROJECT(currentProviderIdRs4, {LEFT.providerid}, LOCAL);
    currentProviderIdRs   := currentProviderIdRs5;    // distributed and sorted
  
  
    currentInfileRs1 := JOIN(currentProviderIdRs, currentProviderIdRs2,
      LEFT.providerid = RIGHT.providerid,
      TRANSFORM(RIGHT),
      INNER,
      LOCAL);
    currentInfileRs := currentInfileRs1;
  
    //
    // Initial Header Records
    //
    Provider_DS    := PROJECT(currentInfileRs, getProviderInfo(LEFT));
    D_Provider_DS  := DISTRIBUTE(Provider_DS, HASH32(Vendor_ID));
    S_Provider_DS1 :=  SORT(D_Provider_DS,
      VENDOR_ID,    LNAME,          FNAME,       MNAME,
      SNAME,        GENDER,         PRIM_RANGE,  PREDIR,       PRIM_NAME,
      ADDR_SUFFIX,  POSTDIR,        SEC_RANGE,   V_CITY_NAME,  ST,
      ZIP,          TAX_ID,         DOB,
      LOCAL);
    S_Provider_DS2 := DEDUP(S_Provider_DS1,
      VENDOR_ID,    LNAME,          FNAME,       MNAME,
      SNAME,        GENDER,         PRIM_RANGE,  PREDIR,       PRIM_NAME,
      ADDR_SUFFIX,  POSTDIR,        SEC_RANGE,   V_CITY_NAME,  ST,
      ZIP,          TAX_ID,         DOB,
      LOCAL);
    S_Provider_DS  := S_Provider_DS2;
  
    //
    // Ingenix DEA file
    //
    D_DEA_DS1 := DISTRIBUTE(Files.INGENIX_DEA_DS); // : PERSIST(persistPath + 'ingenix_dea_raw');
    D_DEA_DS2 := IF(useLocal,
      DATASET(persistPath + 'ingenix_dea_raw', Layouts.INGENIX_DEA, THOR),
      D_DEA_DS1);
    D_DEA_DS3 := DISTRIBUTE(D_DEA_DS2, HASH32(providerid));
    // D_DEA_DS4 := DEDUP (SORT(D_DEA_DS3, providerid, deanumber, -dt_vendor_last_reported, LOCAL), providerid, deanumber, LOCAL);
    D_DEA_DS4 := SORT(D_DEA_DS3, providerid, deanumber, -dt_vendor_last_reported, LOCAL);
    D_DEA_DS5 := JOIN(currentProviderIdRs, D_DEA_DS4,
      LEFT.providerid = RIGHT.providerid,
      TRANSFORM(RIGHT),
      INNER,
      LOCAL);
    D_DEA_DS6 := SORT(D_DEA_DS5, providerid, deanumber, -dt_vendor_last_reported, LOCAL);
    D_DEA_DS7 := DEDUP(D_DEA_DS6, providerid, deanumber, LOCAL);
    D_DEA_DS  := D_DEA_DS7;

    //
    // Ingenix NPI file
    //
    D_NPI_DS1  := DISTRIBUTE(Files.INGENIX_NPI_DS); // : PERSIST(persistPath + 'ingenix_npi_raw');
    D_NPI_DS1a := IF(useLocal,
      DATASET(persistPath + 'ingenix_npi_raw', Layouts.INGENIX_NPI, THOR),
      D_NPI_DS1);
    D_NPI_DS2  := DISTRIBUTE(D_NPI_DS1a, HASH32(providerid));
    D_NPI_DS3  := SORT(D_NPI_DS2, providerid, npi, LOCAL);
    D_NPI_DS4  := JOIN(currentProviderIdRs, D_NPI_DS3,
      LEFT.providerid = RIGHT.providerid,
      TRANSFORM(RIGHT),
      INNER,
      LOCAL);
    D_NPI_DS5  := SORT(D_NPI_DS4, PROVIDERID, NPI, LOCAL);
    D_NPI_DS6  := DEDUP(D_NPI_DS5, PROVIDERID, NPI, LOCAL);
    D_NPI_DS   := D_NPI_DS6;
  
    //
    // Ingenix LIC file
    //
    // To minimize the number of output rows, plan to only join such that only FL provider address get
    // joined to FL licenses. To avoid ever dropping a license ... if a license doesn't join to at least
    // one address we will join it to all addresses.
    //
    providerStateRs1 := SORT(currentInfileRs, providerid, state, LOCAL);
    providerStateRs2 := DEDUP(providerStateRs1, providerid, state, LOCAL);
    providerStateRs3 := PROJECT(providerStateRs2, {LEFT.providerid, LEFT.state}, LOCAL);
    providerStateRs  := providerStateRs3;
  
    ingxLicRs1  := DISTRIBUTE(Files.INGENIX_LIC_DS); // : PERSIST(persistPath + 'ingenix_lic_raw');
    ingxLicRs2  := if(useLocal,
      DATASET(persistPath + 'ingenix_lic_raw', Layouts.INGENIX_LIC, THOR),
      ingxLicRs1);
    ingxLicRs3  := DISTRIBUTE(ingxLicRs2, HASH32(providerid));
    ingxLicRs4  := PROJECT(ingxLicRs3,
      TRANSFORM(Layouts.INGENIX_LIC,
        SELF.licensenumber := TRIM(
          REGEXREPLACE(
            '\\s',
            stringLib.stringToUpperCase(
              TRIM(
                REGEXREPLACE(
                  CleanData.DL_No,
                  stringLib.stringToUpperCase(Left.licensenumber),
                  ''),
                LEFT,
                RIGHT)),
              ''),
          LEFT,
          RIGHT);
        SELF := LEFT),
      LOCAL);
    ingxLicRs5  := DISTRIBUTE(ingxLicRs4, HASH32(providerid));
    ingxLicRs6  := SORT(ingxLicRs5, providerid, licensenumber, licensestate, LOCAL);
    ingxLicRs7  := JOIN(providerStateRs, ingxLicRs6,   // Join once to find all rhs records that will join
      LEFT.providerid  = RIGHT.providerid
        AND LEFT.state = RIGHT.licensestate,
      TRANSFORM(
        {
            RECORDOF(RIGHT),
            TYPEOF(LEFT.state) eff_state
        },
        SELF.eff_state := LEFT.state,
        SELF := RIGHT),
      INNER,
      LOCAL);
    ingxLicRs8  := JOIN(providerStateRs, ingxLicRs6,   // Join agian to find rhs records that don't join
      LEFT.providerid  = RIGHT.providerid
        AND LEFT.state = RIGHT.licensestate,
      TRANSFORM(
        {
            RECORDOF(RIGHT),
            TYPEOF(LEFT.state) eff_state
        },
        SELF.eff_state := '',
      SELF := RIGHT),
      RIGHT ONLY,
      LOCAL);
    ingxLicRs9  := ingxLicRs7 + ingxLicRs8;
    ingxLicRs10 := SORT(ingxLicRs9, providerid, licensestate, licensenumber, eff_state, -termination_date, LOCAL);
    ingxLicRs11 := DEDUP(ingxLicRs10, providerid, licensestate, licensenumber, eff_state, LOCAL);
    ingxLicRs   := ingxLicRs11;
  
    //
    // Ingenix UPIN file
    //
    D_UPIN_DS1 := DISTRIBUTE(Files.INGENIX_UPIN_DS); // : PERSIST(persistPath + 'ingenix_upin_raw');
    D_UPIN_DS1a := IF(useLocal,
      DATASET(persistPath + 'ingenix_upin_raw', Layouts.INGENIX_UPIN, THOR),
      D_UPIN_DS1);
    D_UPIN_DS2 := DISTRIBUTE(D_UPIN_DS1a, HASH32(providerid));
    D_UPIN_DS3 := SORT(D_UPIN_DS2, providerid, upin, LOCAL);
    D_UPIN_DS4 := JOIN(currentProviderIdRs, D_UPIN_DS3,
      LEFT.providerid = RIGHT.providerid,
      TRANSFORM(RIGHT),
      INNER,
      LOCAL);
    D_UPIN_DS5 := SORT(D_UPIN_DS4, providerid, upin, LOCAL);
    D_UPIN_DS6 := DEDUP(D_UPIN_DS5, providerid, upin, LOCAL);
    D_UPIN_DS  := D_UPIN_DS6;
  
    finalIngenixHdrRs1 := S_Provider_DS;
    finalIngenixHdrRs2 := JOIN(finalIngenixHdrRs1, D_DEA_DS,    // Add DEA number
      LEFT.VENDOR_ID = RIGHT.PROVIDERID,
      TRANSFORM(Layout_HealthProvider.HealthCareProvider_Header_V1,
        SELF.DEA_NUMBER := RIGHT.DEANUMBER;
        SELF.DT_DEA_EXPIRATION := (integer) RIGHT.dt_vendor_last_reported;
        SELF := LEFT),
      LEFT OUTER,
      LOCAL);
    
    finalIngenixHdrRs3 := JOIN(finalIngenixHdrRs2, D_NPI_DS,    // Add NPI number
      LEFT.VENDOR_ID = RIGHT.PROVIDERID,

      TRANSFORM(Layout_HealthProvider.HealthCareProvider_Header_V1,
        SELF.NPI_NUMBER := RIGHT.NPI;
				SELF.TAXONOMY		:= RIGHT.TAXONOMYCODE;
        SELF := LEFT),
      LEFT OUTER,
      LOCAL);
    
    finalIngenixHdrRs4 := JOIN(finalIngenixHdrRs3, ingxLicRs,    // Add LIC number
      LEFT.VENDOR_ID = RIGHT.PROVIDERID
        AND (LEFT.st = RIGHT.licensestate OR RIGHT.eff_state = ''),
     TRANSFORM(Layout_HealthProvider.HealthCareProvider_Header_V1,
        LIC_NBR   := IF (RIGHT.licensenumber IN HealthCareProvider.Constants.Bogus_LIC,'',RIGHT.licensenumber);
				SELF.LIC_NBR   := LIC_NBR,
				SELF.C_LIC_NBR := Clean_License(LIC_NBR), 
        SELF.LIC_STATE := RIGHT.licensestate,
				SELF.DT_LIC_BEGIN			 := (integer)RIGHT.effective_date,
        SELF.DT_LIC_EXPIRATION := (integer)RIGHT.termination_date,
        SELF := LEFT),
      LEFT OUTER,
      LOCAL);
    
    finalIngenixHdrRs5 := JOIN(finalIngenixHdrRs4, D_UPIN_DS,    // Add UPIN number
      LEFT.VENDOR_ID = RIGHT.PROVIDERID,
      TRANSFORM(Layout_HealthProvider.HealthCareProvider_Header_V1,
        SELF.UPIN := RIGHT.upin,
        SELF := LEFT),
      LEFT OUTER,
      LOCAL);

    finalIngenixHdrRs  := PROJECT (finalIngenixHdrRs5(TRIM(Lname) <> '' and TRIM(FNAME) <> '' and (INTEGER)TRIM(zip) > 0 and TRIM(PRIM_NAME) <> ''),TRANSFORM(Layout_HealthProvider.HealthCareProvider_Header_V1, 
			SELF.LNPID := HASH64(LEFT.DID + LEFT.DT_LIC_EXPIRATION + LEFT.DT_DEA_EXPIRATION + 
													LEFT.DT_ADDRESS_VERIFIED + LEFT.DOB + LEFT.PHONE + LEFT.FAX + LEFT.LIC_NBR + LEFT.C_LIC_NBR + LEFT.LIC_STATE + LEFT.LIC_TYPE + LEFT.LIC_STATUS + 
													LEFT.FNAME + LEFT.MNAME + LEFT.LNAME + LEFT.SNAME + LEFT.GENDER + LEFT.DOD + LEFT.PRIM_RANGE + LEFT.PRIM_NAME + LEFT.SEC_RANGE + LEFT.V_CITY_NAME + LEFT.ST + LEFT.ZIP +
													LEFT.DEATH_IND + LEFT.DOD + LEFT.TAX_ID + LEFT.UPIN + LEFT.NPI_NUMBER + LEFT.DEA_NUMBER + LEFT.TAXONOMY + LEFT.VENDOR_ID); 
			SELF := LEFT;));

		final_Ds := PROJECT (DEDUP(SORT (DISTRIBUTE(finalIngenixHdrRs,HASH32(LNPID)),LNPID,-DT_LAST_SEEN,-DT_VENDOR_LAST_REPORTED,LOCAL),LNPID,LOCAL),TRANSFORM(Layout_HealthProvider.HealthCareProvider_Header_V1,
													SELF.LNPID := 0; SELF := LEFT;));
		
		output (COUNT (finalIngenixHdrRs),named('beforededup'));
		output (COUNT (final_ds),named('afterdedup'));
    RETURN final_Ds ;
END;
