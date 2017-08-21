IMPORT ut,SALT29;
EXPORT specificities(DATASET(layout_HealthProvider) h) := MODULE
EXPORT input_layout := RECORD // project out required fields
  SALT29.UIDType LNPID := h.LNPID; // using existing id field
  h.RID;//RIDfield 
  UNSIGNED1 data_permits := fn_sources(h.SRC); // Pre-compute permissions for every field
  h.SSN;
  h.DID;
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))Fields.Make_SRC((SALT29.StrType)h.SRC ); // Cleans before using
  UNSIGNED2 DOB_year := ((UNSIGNED)h.DOB) DIV 10000;
  UNSIGNED1 DOB_month := (((UNSIGNED)h.DOB) DIV 100 ) % 100;
  UNSIGNED1 DOB_day := ((UNSIGNED)h.DOB) % 100;
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))Fields.Make_SNAME((SALT29.StrType)h.SNAME ); // Cleans before using
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))Fields.Make_FNAME((SALT29.StrType)h.FNAME ); // Cleans before using
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))Fields.Make_MNAME((SALT29.StrType)h.MNAME ); // Cleans before using
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))Fields.Make_LNAME((SALT29.StrType)h.LNAME ); // Cleans before using
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))Fields.Make_GENDER((SALT29.StrType)h.GENDER ); // Cleans before using
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))Fields.Make_DERIVED_GENDER((SALT29.StrType)h.DERIVED_GENDER ); // Cleans before using
  TYPEOF(h.LIC_STATE) LIC_STATE := (TYPEOF(h.LIC_STATE))Fields.Make_LIC_STATE((SALT29.StrType)h.LIC_STATE ); // Cleans before using
  TYPEOF(h.C_LIC_NBR) C_LIC_NBR := (TYPEOF(h.C_LIC_NBR))Fields.Make_C_LIC_NBR((SALT29.StrType)h.C_LIC_NBR ); // Cleans before using
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))Fields.Make_PHONE((SALT29.StrType)h.PHONE ); // Cleans before using
  TYPEOF(h.FAX) FAX := (TYPEOF(h.FAX))Fields.Make_FAX((SALT29.StrType)h.FAX ); // Cleans before using
  h.ADDRESS_ID;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT29.StrType)h.PRIM_NAME ); // Cleans before using
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT29.StrType)h.PRIM_RANGE ); // Cleans before using
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT29.StrType)h.SEC_RANGE ); // Cleans before using
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))Fields.Make_V_CITY_NAME((SALT29.StrType)h.V_CITY_NAME ); // Cleans before using
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))Fields.Make_ST((SALT29.StrType)h.ST ); // Cleans before using
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))Fields.Make_ZIP((SALT29.StrType)h.ZIP ); // Cleans before using
  TYPEOF(h.CNAME) CNAME := (TYPEOF(h.CNAME))Fields.Make_CNAME((SALT29.StrType)h.CNAME ); // Cleans before using
  TYPEOF(h.TAX_ID) TAX_ID := (TYPEOF(h.TAX_ID))Fields.Make_TAX_ID((SALT29.StrType)h.TAX_ID ); // Cleans before using
  TYPEOF(h.BILLING_TAX_ID) BILLING_TAX_ID := (TYPEOF(h.BILLING_TAX_ID))Fields.Make_BILLING_TAX_ID((SALT29.StrType)h.BILLING_TAX_ID ); // Cleans before using
  TYPEOF(h.UPIN) UPIN := (TYPEOF(h.UPIN))Fields.Make_UPIN((SALT29.StrType)h.UPIN ); // Cleans before using
  h.NPI_NUMBER;
  h.BILLING_NPI_NUMBER;
  TYPEOF(h.DEA_NUMBER) DEA_NUMBER := (TYPEOF(h.DEA_NUMBER))Fields.Make_DEA_NUMBER((SALT29.StrType)h.DEA_NUMBER ); // Cleans before using
  TYPEOF(h.TAXONOMY) TAXONOMY := (TYPEOF(h.TAXONOMY))Fields.Make_TAXONOMY((SALT29.StrType)h.TAXONOMY ); // Cleans before using
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))Fields.Make_VENDOR_ID((SALT29.StrType)h.VENDOR_ID ); // Cleans before using
  TYPEOF(h.LIC_TYPE) LIC_TYPE := (TYPEOF(h.LIC_TYPE))Fields.Make_LIC_TYPE((SALT29.StrType)h.LIC_TYPE ); // Cleans before using
  h.CNSMR_SSN;
  UNSIGNED2 CNSMR_DOB_year := ((UNSIGNED)h.CNSMR_DOB) DIV 10000;
  UNSIGNED1 CNSMR_DOB_month := (((UNSIGNED)h.CNSMR_DOB) DIV 100 ) % 100;
  UNSIGNED1 CNSMR_DOB_day := ((UNSIGNED)h.CNSMR_DOB) % 100;
  TYPEOF(h.GEO_LAT) GEO_LAT := (TYPEOF(h.GEO_LAT))Fields.Make_GEO_LAT((SALT29.StrType)h.GEO_LAT ); // Cleans before using
  TYPEOF(h.GEO_LONG) GEO_LONG := (TYPEOF(h.GEO_LONG))Fields.Make_GEO_LONG((SALT29.StrType)h.GEO_LONG ); // Cleans before using
  SALT29.Str30Type LAT_LONG := SALT29.Fn_Create_LL((SALT29.StrType)h.GEO_LAT,(SALT29.StrType)h.GEO_LONG,5); // Create single field to proxy for lat/long pair
  UNSIGNED4 DT_FIRST_SEEN := (UNSIGNED4)Fields.Make_DT_FIRST_SEEN((SALT29.StrType)h.DT_FIRST_SEEN ); // Cleans before using
  UNSIGNED4 DT_LAST_SEEN := (UNSIGNED4)Fields.Make_DT_LAST_SEEN((SALT29.StrType)h.DT_LAST_SEEN ); // Cleans before using
  TYPEOF(h.DT_LIC_EXPIRATION) DT_LIC_EXPIRATION := (TYPEOF(h.DT_LIC_EXPIRATION))Fields.Make_DT_LIC_EXPIRATION((SALT29.StrType)h.DT_LIC_EXPIRATION ); // Cleans before using
  TYPEOF(h.DT_DEA_EXPIRATION) DT_DEA_EXPIRATION := (TYPEOF(h.DT_DEA_EXPIRATION))Fields.Make_DT_DEA_EXPIRATION((SALT29.StrType)h.DT_DEA_EXPIRATION ); // Cleans before using
  unsigned4 MAINNAME := 0; // Place holder filled in by project
  unsigned4 FULLNAME := 0; // Place holder filled in by project
  unsigned4 ADDR1 := 0; // Place holder filled in by project
  unsigned4 LOCALE := 0; // Place holder filled in by project
  unsigned4 ADDRESS := 0; // Place holder filled in by project
END;
r := input_layout;
h01 := DISTRIBUTE(TABLE(h(LNPID<>0),r),HASH(LNPID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT29.StrType)le.FNAME,(SALT29.StrType)le.MNAME,(SALT29.StrType)le.LNAME),0,HASH32((SALT29.StrType)le.FNAME,(SALT29.StrType)le.MNAME,(SALT29.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT29.StrType)SELF.MAINNAME,(SALT29.StrType)le.SNAME),0,HASH32((SALT29.StrType)SELF.MAINNAME,(SALT29.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.PRIM_NAME),0,HASH32((SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP),0,HASH32((SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT29.StrType)SELF.ADDR1,(SALT29.StrType)SELF.LOCALE),0,HASH32((SALT29.StrType)SELF.ADDR1,(SALT29.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0 : PERSIST('~temp::LNPID::HealthCareProviderHeader::Specificities_Cache',EXPIRE(30));
//We have LNPID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.LNPID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,LNPID,LOCAL) : PERSIST('~temp::LNPID::HealthCareProviderHeader::Cluster_Sizes',EXPIRE(30));
EXPORT TotalClusters := COUNT(ClusterSizes);
SHARED  SSN_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,SSN) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::SSN',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(SSN_deduped,SSN,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING4 SSN_Right4 := fn_Right4(counted.SSN); // Compute fn_Right4 value for SSN
  end;
  with_id := table(counted,r1);
  SALT29.MAC_Field_Accumulate_Counts(with_id,SSN_Right4,Right4_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT29.mac_edit_distance_pairs(specs_added,SSN,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT SSN_values_persisted := distance_computed;
SHARED  DID_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,DID) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::DID',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(DID_deduped,DID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DID_values_persisted := specs_added;
SHARED  DOB_year_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,DOB_year) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::DOB_year',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_year_values_persisted := specs_added;
SHARED  DOB_month_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,DOB_month) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::DOB_month',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_month_values_persisted := specs_added;
SHARED  DOB_day_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,DOB_day) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::DOB_day',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_day_values_persisted := specs_added;
SHARED  SNAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,SNAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::SNAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(SNAME_deduped,SNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING5 SNAME_NormSuffix := fn_NormSuffix(counted.SNAME); // Compute fn_NormSuffix value for SNAME
  end;
  with_id := table(counted,r1);
  SALT29.MAC_Field_Accumulate_Counts(with_id,SNAME_NormSuffix,NormSuffix_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SNAME_values_persisted := specs_added;
SHARED  FNAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,FNAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::FNAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.MAC_Field_Variants_Initials(FNAME_deduped,LNPID,FNAME,expanded) // expand out all variants of initial
  SALT29.Mac_Field_Count_UID(expanded,FNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 FNAME_PreferredName := fn_PreferredName(counted.FNAME); // Compute fn_PreferredName value for FNAME
  end;
  with_id := table(counted,r1);
  SALT29.MAC_Field_Accumulate_Counts(with_id,FNAME_PreferredName,PreferredName_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT29.mac_edit_distance_pairs(specs_added,FNAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT FNAME_values_persisted_temp := distance_computed : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::FNAME_temp',EXPIRE(30));
SHARED  MNAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,MNAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::MNAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.MAC_Field_Variants_Initials(MNAME_deduped,LNPID,MNAME,expanded) // expand out all variants of initial
  SALT29.Mac_Field_Count_UID(expanded,MNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT29.mac_edit_distance_pairs(specs_added,MNAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT MNAME_values_persisted_temp := distance_computed : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::MNAME_temp',EXPIRE(30));
SHARED  LNAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,LNAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::LNAME',EXPIRE(30)); // Reduce to field values by UID
  expanded := SALT29.MAC_Field_Variants_Hyphen(LNAME_deduped,LNPID,LNAME,2); // expand out all variants when hyphenated
  SALT29.Mac_Field_Count_UID(expanded,LNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT29.mac_edit_distance_pairs(specs_added,LNAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT LNAME_values_persisted_temp := distance_computed : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::LNAME_temp',EXPIRE(30));
SHARED  GENDER_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,GENDER) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::GENDER',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(GENDER_deduped,GENDER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT GENDER_values_persisted := specs_added;
SHARED  DERIVED_GENDER_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,DERIVED_GENDER) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::DERIVED_GENDER',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(DERIVED_GENDER_deduped,DERIVED_GENDER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DERIVED_GENDER_values_persisted := specs_added;
SHARED  C_LIC_NBR_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,C_LIC_NBR) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::C_LIC_NBR',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(C_LIC_NBR_deduped,C_LIC_NBR,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT29.mac_edit_distance_pairs(specs_added,C_LIC_NBR,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT C_LIC_NBR_values_persisted := distance_computed;
SHARED  PHONE_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,PHONE) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::PHONE',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(PHONE_deduped,PHONE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PHONE_values_persisted := specs_added;
SHARED  FAX_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,FAX) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::FAX',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(FAX_deduped,FAX,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FAX_values_persisted := specs_added;
SHARED  PRIM_NAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,PRIM_NAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::PRIM_NAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_NAME_values_persisted := specs_added;
SHARED  PRIM_RANGE_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,PRIM_RANGE) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::PRIM_RANGE',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_RANGE_values_persisted := specs_added;
SHARED  SEC_RANGE_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,SEC_RANGE) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::SEC_RANGE',EXPIRE(30)); // Reduce to field values by UID
  expanded := SALT29.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,LNPID,SEC_RANGE,2); // expand out all variants when hyphenated
  SALT29.Mac_Field_Count_UID(expanded,SEC_RANGE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEC_RANGE_values_persisted := specs_added;
SHARED  V_CITY_NAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,V_CITY_NAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::V_CITY_NAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(V_CITY_NAME_deduped,V_CITY_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT V_CITY_NAME_values_persisted := specs_added;
SHARED  ST_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,ST) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::ST',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(ST_deduped,ST,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted := specs_added;
SHARED  ZIP_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,ZIP) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::ZIP',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(ZIP_deduped,ZIP,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted := specs_added;
SHARED  TAX_ID_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,TAX_ID) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::TAX_ID',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(TAX_ID_deduped,TAX_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT TAX_ID_values_persisted := specs_added;
SHARED  BILLING_TAX_ID_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,BILLING_TAX_ID) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::BILLING_TAX_ID',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(BILLING_TAX_ID_deduped,BILLING_TAX_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT BILLING_TAX_ID_values_persisted := specs_added;
SHARED  UPIN_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,UPIN) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::UPIN',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(UPIN_deduped,UPIN,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT UPIN_values_persisted := specs_added;
SHARED  NPI_NUMBER_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,NPI_NUMBER) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::NPI_NUMBER',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(NPI_NUMBER_deduped,NPI_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT NPI_NUMBER_values_persisted := specs_added;
SHARED  BILLING_NPI_NUMBER_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,BILLING_NPI_NUMBER) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::BILLING_NPI_NUMBER',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(BILLING_NPI_NUMBER_deduped,BILLING_NPI_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT BILLING_NPI_NUMBER_values_persisted := specs_added;
SHARED  DEA_NUMBER_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,DEA_NUMBER) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::DEA_NUMBER',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(DEA_NUMBER_deduped,DEA_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DEA_NUMBER_values_persisted := specs_added;
SHARED  TAXONOMY_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,TAXONOMY) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::TAXONOMY',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(TAXONOMY_deduped,TAXONOMY,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT TAXONOMY_values_persisted := specs_added;
SHARED  VENDOR_ID_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,VENDOR_ID) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::VENDOR_ID',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(VENDOR_ID_deduped,VENDOR_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT VENDOR_ID_values_persisted := specs_added;
SHARED  LIC_TYPE_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,LIC_TYPE) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::LIC_TYPE',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(LIC_TYPE_deduped,LIC_TYPE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED LIC_TYPE_sa := specs_added; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT29.MAC_Field_Variants_WordBag(LIC_TYPE_deduped,LNPID,LIC_TYPE,expanded)// expand out all variants of wordbag
  SALT29.Mac_Field_Count_UID(expanded,LIC_TYPE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT29.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED LIC_TYPE_ad := wb_specs_added; // Hop over export
EXPORT LIC_TYPEValuesKeyName := '~'+'key::HealthCareProviderHeader::LNPID::Word::LIC_TYPE';
EXPORT LIC_TYPE_values_key := INDEX(LIC_TYPE_ad,{LIC_TYPE},{LIC_TYPE_ad},LIC_TYPEValuesKeyName);
  SALT29.mac_wordbag_addweights(LIC_TYPE_sa,LIC_TYPE,LIC_TYPE_ad,p);
EXPORT LIC_TYPE_values_persisted := p;
SHARED  CNSMR_SSN_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,CNSMR_SSN) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::CNSMR_SSN',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(CNSMR_SSN_deduped,CNSMR_SSN,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNSMR_SSN_values_persisted := specs_added;
SHARED  CNSMR_DOB_year_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,CNSMR_DOB_year) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::CNSMR_DOB_year',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(CNSMR_DOB_year_deduped,CNSMR_DOB_year,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNSMR_DOB_year_values_persisted := specs_added;
SHARED  CNSMR_DOB_month_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,CNSMR_DOB_month) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::CNSMR_DOB_month',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(CNSMR_DOB_month_deduped,CNSMR_DOB_month,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNSMR_DOB_month_values_persisted := specs_added;
SHARED  CNSMR_DOB_day_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,CNSMR_DOB_day) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::CNSMR_DOB_day',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(CNSMR_DOB_day_deduped,CNSMR_DOB_day,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNSMR_DOB_day_values_persisted := specs_added;
  SALT29.MAC_Specificity_Local(input_file,LAT_LONG,LNPID,LAT_LONG_nulls,Layout_Specificities.LAT_LONG_ChildRec,LAT_LONG_specificity,LAT_LONG_switch,LAT_LONG_values,false);
//Construct ranged values to allow for fuzzying (by distance) away from lat/long position
  SALT29.MAC_Specificity_LL(LAT_LONG_values,LAT_LONG,cnt,1,LAT_LONG_ll_range);
EXPORT LAT_LONG_values_persisted := LAT_LONG_ll_range : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::ll_range::LAT_LONG',EXPIRE(30));
EXPORT LAT_LONG_max := MAX(LAT_LONG_values_persisted,field_specificity);
SHARED  MAINNAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,MAINNAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::MAINNAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MAINNAME_values_persisted := specs_added;
SHARED  FULLNAME_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,FULLNAME) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::FULLNAME',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FULLNAME_values_persisted := specs_added;
SHARED  ADDR1_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,ADDR1) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::ADDR1',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(ADDR1_deduped,ADDR1,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDR1_values_persisted := specs_added;
SHARED  LOCALE_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,LOCALE) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::LOCALE',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LOCALE_values_persisted := specs_added;
SHARED  ADDRESS_deduped := SALT29.MAC_Field_By_UID(input_file,LNPID,ADDRESS) : PERSIST('~temp::LNPID::HealthCareProviderHeader::dedups::ADDRESS',EXPIRE(30)); // Reduce to field values by UID
  SALT29.Mac_Field_Count_UID(ADDRESS_deduped,ADDRESS,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT29.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDRESS_values_persisted := specs_added;
SALT29.MAC_Field_Nulls(SSN_values_persisted,Layout_Specificities.SSN_ChildRec,nv) // Use automated NULL spotting
EXPORT SSN_nulls := nv;
SALT29.MAC_Field_Bfoul(SSN_deduped,SSN,LNPID,SSN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SSN_switch := bf;
EXPORT SSN_max := MAX(SSN_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(SSN_values_persisted,SSN,SSN_nulls,ol) // Compute column level specificity
EXPORT SSN_specificity := ol;
SALT29.MAC_Field_Nulls(DID_values_persisted,Layout_Specificities.DID_ChildRec,nv) // Use automated NULL spotting
EXPORT DID_nulls := nv;
SALT29.MAC_Field_Bfoul(DID_deduped,DID,LNPID,DID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DID_switch := bf;
EXPORT DID_max := MAX(DID_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(DID_values_persisted,DID,DID_nulls,ol) // Compute column level specificity
EXPORT DID_specificity := ol;
SALT29.MAC_Field_Nulls(DOB_year_values_persisted,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_year_nulls := nv;
SALT29.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,LNPID,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_year_switch := bf;
EXPORT DOB_year_max := MAX(DOB_year_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(DOB_year_values_persisted,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
EXPORT DOB_year_specificity := ol;
SALT29.MAC_Field_Nulls(DOB_month_values_persisted,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_month_nulls := nv;
SALT29.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,LNPID,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_month_switch := bf;
EXPORT DOB_month_max := MAX(DOB_month_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(DOB_month_values_persisted,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
EXPORT DOB_month_specificity := ol;
SALT29.MAC_Field_Nulls(DOB_day_values_persisted,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_day_nulls := nv;
SALT29.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,LNPID,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_day_switch := bf;
EXPORT DOB_day_max := MAX(DOB_day_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(DOB_day_values_persisted,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
EXPORT DOB_day_specificity := ol;
SALT29.MAC_Field_Nulls(SNAME_values_persisted,Layout_Specificities.SNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT SNAME_nulls := nv;
SALT29.MAC_Field_Bfoul(SNAME_deduped,SNAME,LNPID,SNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SNAME_switch := bf;
EXPORT SNAME_max := MAX(SNAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(SNAME_values_persisted,SNAME,SNAME_nulls,ol) // Compute column level specificity
EXPORT SNAME_specificity := ol;
SALT29.MAC_Concept3_Specificities(MAINNAME_cnt,FNAME_values_persisted_temp,FNAME,e1_cnt,MNAME_values_persisted_temp,MNAME,e1_cnt,LNAME_values_persisted_temp,LNAME,e1_cnt,ofile)
EXPORT FNAME_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::FNAME',EXPIRE(30));
EXPORT FNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT29.MAC_Field_Bfoul(FNAME_deduped,FNAME,LNPID,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FNAME_switch := bf;
EXPORT FNAME_max := MAX(FNAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(FNAME_values_persisted,FNAME,FNAME_nulls,ol) // Compute column level specificity
EXPORT FNAME_specificity := ol;
SALT29.MAC_Concept3_Specificities(MAINNAME_cnt,MNAME_values_persisted_temp,MNAME,e1_cnt,FNAME_values_persisted_temp,FNAME,e1_cnt,LNAME_values_persisted_temp,LNAME,e1_cnt,ofile)
EXPORT MNAME_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::MNAME',EXPIRE(30));
EXPORT MNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT29.MAC_Field_Bfoul(MNAME_deduped,MNAME,LNPID,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MNAME_switch := bf;
EXPORT MNAME_max := MAX(MNAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(MNAME_values_persisted,MNAME,MNAME_nulls,ol) // Compute column level specificity
EXPORT MNAME_specificity := ol;
SALT29.MAC_Concept3_Specificities(MAINNAME_cnt,LNAME_values_persisted_temp,LNAME,e1_cnt,FNAME_values_persisted_temp,FNAME,e1_cnt,MNAME_values_persisted_temp,MNAME,e1_cnt,ofile)
EXPORT LNAME_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareProviderHeader::values::LNAME',EXPIRE(30));
EXPORT LNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.LNAME_ChildRec); // Automated null spotting not applicable
SALT29.MAC_Field_Bfoul(LNAME_deduped,LNAME,LNPID,LNAME_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LNAME_switch := bf;
EXPORT LNAME_max := MAX(LNAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(LNAME_values_persisted,LNAME,LNAME_nulls,ol) // Compute column level specificity
EXPORT LNAME_specificity := ol;
EXPORT GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.GENDER_ChildRec); // Automated null spotting not applicable
SALT29.MAC_Field_Bfoul(GENDER_deduped,GENDER,LNPID,GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT GENDER_switch := bf;
EXPORT GENDER_max := MAX(GENDER_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(GENDER_values_persisted,GENDER,GENDER_nulls,ol) // Compute column level specificity
EXPORT GENDER_specificity := ol;
EXPORT DERIVED_GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.DERIVED_GENDER_ChildRec); // Automated null spotting not applicable
SALT29.MAC_Field_Bfoul(DERIVED_GENDER_deduped,DERIVED_GENDER,LNPID,DERIVED_GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DERIVED_GENDER_switch := bf;
EXPORT DERIVED_GENDER_max := MAX(DERIVED_GENDER_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(DERIVED_GENDER_values_persisted,DERIVED_GENDER,DERIVED_GENDER_nulls,ol) // Compute column level specificity
EXPORT DERIVED_GENDER_specificity := ol;
SALT29.MAC_Field_Nulls(C_LIC_NBR_values_persisted,Layout_Specificities.C_LIC_NBR_ChildRec,nv) // Use automated NULL spotting
EXPORT C_LIC_NBR_nulls := nv;
SALT29.MAC_Field_Bfoul(C_LIC_NBR_deduped,C_LIC_NBR,LNPID,C_LIC_NBR_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT C_LIC_NBR_switch := bf;
EXPORT C_LIC_NBR_max := MAX(C_LIC_NBR_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(C_LIC_NBR_values_persisted,C_LIC_NBR,C_LIC_NBR_nulls,ol) // Compute column level specificity
EXPORT C_LIC_NBR_specificity := ol;
SALT29.MAC_Field_Nulls(PHONE_values_persisted,Layout_Specificities.PHONE_ChildRec,nv) // Use automated NULL spotting
EXPORT PHONE_nulls := nv;
SALT29.MAC_Field_Bfoul(PHONE_deduped,PHONE,LNPID,PHONE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PHONE_switch := bf;
EXPORT PHONE_max := MAX(PHONE_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(PHONE_values_persisted,PHONE,PHONE_nulls,ol) // Compute column level specificity
EXPORT PHONE_specificity := ol;
SALT29.MAC_Field_Nulls(FAX_values_persisted,Layout_Specificities.FAX_ChildRec,nv) // Use automated NULL spotting
EXPORT FAX_nulls := nv;
SALT29.MAC_Field_Bfoul(FAX_deduped,FAX,LNPID,FAX_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FAX_switch := bf;
EXPORT FAX_max := MAX(FAX_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(FAX_values_persisted,FAX,FAX_nulls,ol) // Compute column level specificity
EXPORT FAX_specificity := ol;
SALT29.MAC_Field_Nulls(PRIM_NAME_values_persisted,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_NAME_nulls := nv;
SALT29.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,LNPID,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;
SALT29.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT29.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,LNPID,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;
SALT29.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT29.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,LNPID,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;
SALT29.MAC_Field_Nulls(V_CITY_NAME_values_persisted,Layout_Specificities.V_CITY_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT V_CITY_NAME_nulls := nv;
SALT29.MAC_Field_Bfoul(V_CITY_NAME_deduped,V_CITY_NAME,LNPID,V_CITY_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT V_CITY_NAME_switch := bf;
EXPORT V_CITY_NAME_max := MAX(V_CITY_NAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(V_CITY_NAME_values_persisted,V_CITY_NAME,V_CITY_NAME_nulls,ol) // Compute column level specificity
EXPORT V_CITY_NAME_specificity := ol;
SALT29.MAC_Field_Nulls(ST_values_persisted,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT29.MAC_Field_Bfoul(ST_deduped,ST,LNPID,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(ST_values_persisted,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;
SALT29.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT29.MAC_Field_Bfoul(ZIP_deduped,ZIP,LNPID,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;
SALT29.MAC_Field_Nulls(TAX_ID_values_persisted,Layout_Specificities.TAX_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT TAX_ID_nulls := nv;
SALT29.MAC_Field_Bfoul(TAX_ID_deduped,TAX_ID,LNPID,TAX_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TAX_ID_switch := bf;
EXPORT TAX_ID_max := MAX(TAX_ID_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(TAX_ID_values_persisted,TAX_ID,TAX_ID_nulls,ol) // Compute column level specificity
EXPORT TAX_ID_specificity := ol;
SALT29.MAC_Field_Nulls(BILLING_TAX_ID_values_persisted,Layout_Specificities.BILLING_TAX_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT BILLING_TAX_ID_nulls := nv;
SALT29.MAC_Field_Bfoul(BILLING_TAX_ID_deduped,BILLING_TAX_ID,LNPID,BILLING_TAX_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT BILLING_TAX_ID_switch := bf;
EXPORT BILLING_TAX_ID_max := MAX(BILLING_TAX_ID_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(BILLING_TAX_ID_values_persisted,BILLING_TAX_ID,BILLING_TAX_ID_nulls,ol) // Compute column level specificity
EXPORT BILLING_TAX_ID_specificity := ol;
SALT29.MAC_Field_Nulls(UPIN_values_persisted,Layout_Specificities.UPIN_ChildRec,nv) // Use automated NULL spotting
EXPORT UPIN_nulls := nv;
SALT29.MAC_Field_Bfoul(UPIN_deduped,UPIN,LNPID,UPIN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT UPIN_switch := bf;
EXPORT UPIN_max := MAX(UPIN_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(UPIN_values_persisted,UPIN,UPIN_nulls,ol) // Compute column level specificity
EXPORT UPIN_specificity := ol;
SALT29.MAC_Field_Nulls(NPI_NUMBER_values_persisted,Layout_Specificities.NPI_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT NPI_NUMBER_nulls := nv;
SALT29.MAC_Field_Bfoul(NPI_NUMBER_deduped,NPI_NUMBER,LNPID,NPI_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NPI_NUMBER_switch := bf;
EXPORT NPI_NUMBER_max := MAX(NPI_NUMBER_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(NPI_NUMBER_values_persisted,NPI_NUMBER,NPI_NUMBER_nulls,ol) // Compute column level specificity
EXPORT NPI_NUMBER_specificity := ol;
SALT29.MAC_Field_Nulls(BILLING_NPI_NUMBER_values_persisted,Layout_Specificities.BILLING_NPI_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT BILLING_NPI_NUMBER_nulls := nv;
SALT29.MAC_Field_Bfoul(BILLING_NPI_NUMBER_deduped,BILLING_NPI_NUMBER,LNPID,BILLING_NPI_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT BILLING_NPI_NUMBER_switch := bf;
EXPORT BILLING_NPI_NUMBER_max := MAX(BILLING_NPI_NUMBER_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(BILLING_NPI_NUMBER_values_persisted,BILLING_NPI_NUMBER,BILLING_NPI_NUMBER_nulls,ol) // Compute column level specificity
EXPORT BILLING_NPI_NUMBER_specificity := ol;
SALT29.MAC_Field_Nulls(DEA_NUMBER_values_persisted,Layout_Specificities.DEA_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT DEA_NUMBER_nulls := nv;
SALT29.MAC_Field_Bfoul(DEA_NUMBER_deduped,DEA_NUMBER,LNPID,DEA_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DEA_NUMBER_switch := bf;
EXPORT DEA_NUMBER_max := MAX(DEA_NUMBER_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(DEA_NUMBER_values_persisted,DEA_NUMBER,DEA_NUMBER_nulls,ol) // Compute column level specificity
EXPORT DEA_NUMBER_specificity := ol;
SALT29.MAC_Field_Nulls(TAXONOMY_values_persisted,Layout_Specificities.TAXONOMY_ChildRec,nv) // Use automated NULL spotting
EXPORT TAXONOMY_nulls := nv;
SALT29.MAC_Field_Bfoul(TAXONOMY_deduped,TAXONOMY,LNPID,TAXONOMY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TAXONOMY_switch := bf;
EXPORT TAXONOMY_max := MAX(TAXONOMY_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(TAXONOMY_values_persisted,TAXONOMY,TAXONOMY_nulls,ol) // Compute column level specificity
EXPORT TAXONOMY_specificity := ol;
SALT29.MAC_Field_Nulls(VENDOR_ID_values_persisted,Layout_Specificities.VENDOR_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT VENDOR_ID_nulls := nv;
SALT29.MAC_Field_Bfoul(VENDOR_ID_deduped,VENDOR_ID,LNPID,VENDOR_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VENDOR_ID_switch := bf;
EXPORT VENDOR_ID_max := MAX(VENDOR_ID_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_nulls,ol) // Compute column level specificity
EXPORT VENDOR_ID_specificity := ol;
EXPORT LIC_TYPE_nulls := DATASET([{'',0,0}],Layout_Specificities.LIC_TYPE_ChildRec); // Automated null spotting not applicable
SALT29.MAC_Field_Bfoul(LIC_TYPE_deduped,LIC_TYPE,LNPID,LIC_TYPE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LIC_TYPE_switch := bf;
EXPORT LIC_TYPE_max := MAX(LIC_TYPE_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(LIC_TYPE_values_persisted,LIC_TYPE,LIC_TYPE_nulls,ol) // Compute column level specificity
EXPORT LIC_TYPE_specificity := ol;
SALT29.MAC_Field_Nulls(CNSMR_SSN_values_persisted,Layout_Specificities.CNSMR_SSN_ChildRec,nv) // Use automated NULL spotting
EXPORT CNSMR_SSN_nulls := nv;
SALT29.MAC_Field_Bfoul(CNSMR_SSN_deduped,CNSMR_SSN,LNPID,CNSMR_SSN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNSMR_SSN_switch := bf;
EXPORT CNSMR_SSN_max := MAX(CNSMR_SSN_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(CNSMR_SSN_values_persisted,CNSMR_SSN,CNSMR_SSN_nulls,ol) // Compute column level specificity
EXPORT CNSMR_SSN_specificity := ol;
SALT29.MAC_Field_Nulls(CNSMR_DOB_year_values_persisted,Layout_Specificities.CNSMR_DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT CNSMR_DOB_year_nulls := nv;
SALT29.MAC_Field_Bfoul(CNSMR_DOB_year_deduped,CNSMR_DOB_year,LNPID,CNSMR_DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNSMR_DOB_year_switch := bf;
EXPORT CNSMR_DOB_year_max := MAX(CNSMR_DOB_year_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(CNSMR_DOB_year_values_persisted,CNSMR_DOB_year,CNSMR_DOB_year_nulls,ol) // Compute column level specificity
EXPORT CNSMR_DOB_year_specificity := ol;
SALT29.MAC_Field_Nulls(CNSMR_DOB_month_values_persisted,Layout_Specificities.CNSMR_DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT CNSMR_DOB_month_nulls := nv;
SALT29.MAC_Field_Bfoul(CNSMR_DOB_month_deduped,CNSMR_DOB_month,LNPID,CNSMR_DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNSMR_DOB_month_switch := bf;
EXPORT CNSMR_DOB_month_max := MAX(CNSMR_DOB_month_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(CNSMR_DOB_month_values_persisted,CNSMR_DOB_month,CNSMR_DOB_month_nulls,ol) // Compute column level specificity
EXPORT CNSMR_DOB_month_specificity := ol;
SALT29.MAC_Field_Nulls(CNSMR_DOB_day_values_persisted,Layout_Specificities.CNSMR_DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT CNSMR_DOB_day_nulls := nv;
SALT29.MAC_Field_Bfoul(CNSMR_DOB_day_deduped,CNSMR_DOB_day,LNPID,CNSMR_DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNSMR_DOB_day_switch := bf;
EXPORT CNSMR_DOB_day_max := MAX(CNSMR_DOB_day_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(CNSMR_DOB_day_values_persisted,CNSMR_DOB_day,CNSMR_DOB_day_nulls,ol) // Compute column level specificity
EXPORT CNSMR_DOB_day_specificity := ol;
SALT29.MAC_Field_Nulls(MAINNAME_values_persisted,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT MAINNAME_nulls := nv;
SALT29.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,LNPID,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MAINNAME_switch := bf;
EXPORT MAINNAME_max := MAX(MAINNAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(MAINNAME_values_persisted,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
EXPORT MAINNAME_specificity := ol;
SALT29.MAC_Field_Nulls(FULLNAME_values_persisted,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FULLNAME_nulls := nv;
SALT29.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,LNPID,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FULLNAME_switch := bf;
EXPORT FULLNAME_max := MAX(FULLNAME_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(FULLNAME_values_persisted,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
EXPORT FULLNAME_specificity := ol;
SALT29.MAC_Field_Nulls(ADDR1_values_persisted,Layout_Specificities.ADDR1_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDR1_nulls := nv;
SALT29.MAC_Field_Bfoul(ADDR1_deduped,ADDR1,LNPID,ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDR1_switch := bf;
EXPORT ADDR1_max := MAX(ADDR1_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(ADDR1_values_persisted,ADDR1,ADDR1_nulls,ol) // Compute column level specificity
EXPORT ADDR1_specificity := ol;
SALT29.MAC_Field_Nulls(LOCALE_values_persisted,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
EXPORT LOCALE_nulls := nv;
SALT29.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,LNPID,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LOCALE_switch := bf;
EXPORT LOCALE_max := MAX(LOCALE_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(LOCALE_values_persisted,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
EXPORT LOCALE_specificity := ol;
SALT29.MAC_Field_Nulls(ADDRESS_values_persisted,Layout_Specificities.ADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDRESS_nulls := nv;
SALT29.MAC_Field_Bfoul(ADDRESS_deduped,ADDRESS,LNPID,ADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDRESS_switch := bf;
EXPORT ADDRESS_max := MAX(ADDRESS_values_persisted,field_specificity);
SALT29.MAC_Field_Specificity(ADDRESS_values_persisted,ADDRESS,ADDRESS_nulls,ol) // Compute column level specificity
EXPORT ADDRESS_specificity := ol;
iSpecificities := DATASET([{0,SSN_specificity,SSN_switch,SSN_max,SSN_nulls,DID_specificity,DID_switch,DID_max,DID_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,SNAME_specificity,SNAME_switch,SNAME_max,SNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,GENDER_specificity,GENDER_switch,GENDER_max,GENDER_nulls,DERIVED_GENDER_specificity,DERIVED_GENDER_switch,DERIVED_GENDER_max,DERIVED_GENDER_nulls,C_LIC_NBR_specificity,C_LIC_NBR_switch,C_LIC_NBR_max,C_LIC_NBR_nulls,PHONE_specificity,PHONE_switch,PHONE_max,PHONE_nulls,FAX_specificity,FAX_switch,FAX_max,FAX_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,V_CITY_NAME_specificity,V_CITY_NAME_switch,V_CITY_NAME_max,V_CITY_NAME_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,TAX_ID_specificity,TAX_ID_switch,TAX_ID_max,TAX_ID_nulls,BILLING_TAX_ID_specificity,BILLING_TAX_ID_switch,BILLING_TAX_ID_max,BILLING_TAX_ID_nulls,UPIN_specificity,UPIN_switch,UPIN_max,UPIN_nulls,NPI_NUMBER_specificity,NPI_NUMBER_switch,NPI_NUMBER_max,NPI_NUMBER_nulls,BILLING_NPI_NUMBER_specificity,BILLING_NPI_NUMBER_switch,BILLING_NPI_NUMBER_max,BILLING_NPI_NUMBER_nulls,DEA_NUMBER_specificity,DEA_NUMBER_switch,DEA_NUMBER_max,DEA_NUMBER_nulls,TAXONOMY_specificity,TAXONOMY_switch,TAXONOMY_max,TAXONOMY_nulls,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_max,VENDOR_ID_nulls,LIC_TYPE_specificity,LIC_TYPE_switch,LIC_TYPE_max,LIC_TYPE_nulls,CNSMR_SSN_specificity,CNSMR_SSN_switch,CNSMR_SSN_max,CNSMR_SSN_nulls,CNSMR_DOB_year_specificity,CNSMR_DOB_year_switch,CNSMR_DOB_year_max,CNSMR_DOB_year_nulls,CNSMR_DOB_month_specificity,CNSMR_DOB_month_switch,CNSMR_DOB_month_max,CNSMR_DOB_month_nulls,CNSMR_DOB_day_specificity,CNSMR_DOB_day_switch,CNSMR_DOB_day_max,CNSMR_DOB_day_nulls,LAT_LONG_specificity,LAT_LONG_switch,LAT_LONG_max,LAT_LONG_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_max,ADDR1_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRESS_specificity,ADDRESS_switch,ADDRESS_max,ADDRESS_nulls}],Layout_Specificities.R) : PERSIST('~temp::LNPID::HealthCareProviderHeader::Specificities',EXPIRE(30));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 SSN_shift0 := ROUND(Specificities[1].SSN_specificity - 24);
  integer2 SSN_switch_shift0 := ROUND(1000*Specificities[1].SSN_switch - 35);
  integer1 DID_shift0 := ROUND(Specificities[1].DID_specificity - 23);
  integer2 DID_switch_shift0 := ROUND(1000*Specificities[1].DID_switch - 222);
  integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 17);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 SNAME_shift0 := ROUND(Specificities[1].SNAME_specificity - 8);
  integer2 SNAME_switch_shift0 := ROUND(1000*Specificities[1].SNAME_switch - 10);
  integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 8);
  integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 39);
  integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 8);
  integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 68);
  integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 11);
  integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 126);
  integer1 GENDER_shift0 := ROUND(Specificities[1].GENDER_specificity - 2);
  integer2 GENDER_switch_shift0 := ROUND(1000*Specificities[1].GENDER_switch - 13);
  integer1 DERIVED_GENDER_shift0 := ROUND(Specificities[1].DERIVED_GENDER_specificity - 1);
  integer2 DERIVED_GENDER_switch_shift0 := ROUND(1000*Specificities[1].DERIVED_GENDER_switch - 4);
  integer1 C_LIC_NBR_shift0 := ROUND(Specificities[1].C_LIC_NBR_specificity - 20);
  integer2 C_LIC_NBR_switch_shift0 := ROUND(1000*Specificities[1].C_LIC_NBR_switch - 345);
  integer1 PHONE_shift0 := ROUND(Specificities[1].PHONE_specificity - 18);
  integer2 PHONE_switch_shift0 := ROUND(1000*Specificities[1].PHONE_switch - 565);
  integer1 FAX_shift0 := ROUND(Specificities[1].FAX_specificity - 21);
  integer2 FAX_switch_shift0 := ROUND(1000*Specificities[1].FAX_switch - 374);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 13);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 569);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 11);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 553);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 7);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 418);
  integer1 V_CITY_NAME_shift0 := ROUND(Specificities[1].V_CITY_NAME_specificity - 10);
  integer2 V_CITY_NAME_switch_shift0 := ROUND(1000*Specificities[1].V_CITY_NAME_switch - 438);
  integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 5);
  integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 177);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 12);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 505);
  integer1 TAX_ID_shift0 := ROUND(Specificities[1].TAX_ID_specificity - 0);
  integer2 TAX_ID_switch_shift0 := ROUND(1000*Specificities[1].TAX_ID_switch - 0);
  integer1 BILLING_TAX_ID_shift0 := ROUND(Specificities[1].BILLING_TAX_ID_specificity - 16);
  integer2 BILLING_TAX_ID_switch_shift0 := ROUND(1000*Specificities[1].BILLING_TAX_ID_switch - 608);
  integer1 UPIN_shift0 := ROUND(Specificities[1].UPIN_specificity - 24);
  integer2 UPIN_switch_shift0 := ROUND(1000*Specificities[1].UPIN_switch - 0);
  integer1 NPI_NUMBER_shift0 := ROUND(Specificities[1].NPI_NUMBER_specificity - 24);
  integer2 NPI_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].NPI_NUMBER_switch - 0);
  integer1 BILLING_NPI_NUMBER_shift0 := ROUND(Specificities[1].BILLING_NPI_NUMBER_specificity - 16);
  integer2 BILLING_NPI_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].BILLING_NPI_NUMBER_switch - 668);
  integer1 DEA_NUMBER_shift0 := ROUND(Specificities[1].DEA_NUMBER_specificity - 24);
  integer2 DEA_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].DEA_NUMBER_switch - 147);
  integer1 TAXONOMY_shift0 := ROUND(Specificities[1].TAXONOMY_specificity - 8);
  integer2 TAXONOMY_switch_shift0 := ROUND(1000*Specificities[1].TAXONOMY_switch - 45);
  integer1 VENDOR_ID_shift0 := ROUND(Specificities[1].VENDOR_ID_specificity - 23);
  integer2 VENDOR_ID_switch_shift0 := ROUND(1000*Specificities[1].VENDOR_ID_switch - 847);
  integer1 LIC_TYPE_shift0 := ROUND(Specificities[1].LIC_TYPE_specificity - 6);
  integer2 LIC_TYPE_switch_shift0 := ROUND(1000*Specificities[1].LIC_TYPE_switch - 709);
  integer1 CNSMR_SSN_shift0 := ROUND(Specificities[1].CNSMR_SSN_specificity - 23);
  integer2 CNSMR_SSN_switch_shift0 := ROUND(1000*Specificities[1].CNSMR_SSN_switch - 37);
  integer1 CNSMR_DOB_shift0 := ROUND(Specificities[1].CNSMR_DOB_year_specificity+Specificities[1].CNSMR_DOB_month_specificity+Specificities[1].CNSMR_DOB_day_specificity - 17);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 LAT_LONG_shift0 := ROUND(Specificities[1].LAT_LONG_specificity - 10);
  integer2 LAT_LONG_switch_shift0 := ROUND(1000*Specificities[1].LAT_LONG_switch - 321);
  integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 23);
  integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 407);
  integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 23);
  integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 410);
  integer1 ADDR1_shift0 := ROUND(Specificities[1].ADDR1_specificity - 19);
  integer2 ADDR1_switch_shift0 := ROUND(1000*Specificities[1].ADDR1_switch - 598);
  integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 12);
  integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 507);
  integer1 ADDRESS_shift0 := ROUND(Specificities[1].ADDRESS_specificity - 20);
  integer2 ADDRESS_switch_shift0 := ROUND(1000*Specificities[1].ADDRESS_switch - 600);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT29.MAC_Specificity_Values(SSN_values_persisted,SSN,'SSN',SSN_specificity,SSN_specificity_profile);
  SALT29.MAC_Specificity_Values(DID_values_persisted,DID,'DID',DID_specificity,DID_specificity_profile);
  SALT29.MAC_Specificity_Values(SNAME_values_persisted,SNAME,'SNAME',SNAME_specificity,SNAME_specificity_profile);
  SALT29.MAC_Specificity_Values(FNAME_values_persisted,FNAME,'FNAME',FNAME_specificity,FNAME_specificity_profile);
  SALT29.MAC_Specificity_Values(MNAME_values_persisted,MNAME,'MNAME',MNAME_specificity,MNAME_specificity_profile);
  SALT29.MAC_Specificity_Values(LNAME_values_persisted,LNAME,'LNAME',LNAME_specificity,LNAME_specificity_profile);
  SALT29.MAC_Specificity_Values(GENDER_values_persisted,GENDER,'GENDER',GENDER_specificity,GENDER_specificity_profile);
  SALT29.MAC_Specificity_Values(DERIVED_GENDER_values_persisted,DERIVED_GENDER,'DERIVED_GENDER',DERIVED_GENDER_specificity,DERIVED_GENDER_specificity_profile);
  SALT29.MAC_Specificity_Values(C_LIC_NBR_values_persisted,C_LIC_NBR,'C_LIC_NBR',C_LIC_NBR_specificity,C_LIC_NBR_specificity_profile);
  SALT29.MAC_Specificity_Values(PHONE_values_persisted,PHONE,'PHONE',PHONE_specificity,PHONE_specificity_profile);
  SALT29.MAC_Specificity_Values(FAX_values_persisted,FAX,'FAX',FAX_specificity,FAX_specificity_profile);
  SALT29.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
  SALT29.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
  SALT29.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
  SALT29.MAC_Specificity_Values(V_CITY_NAME_values_persisted,V_CITY_NAME,'V_CITY_NAME',V_CITY_NAME_specificity,V_CITY_NAME_specificity_profile);
  SALT29.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
  SALT29.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
  SALT29.MAC_Specificity_Values(TAX_ID_values_persisted,TAX_ID,'TAX_ID',TAX_ID_specificity,TAX_ID_specificity_profile);
  SALT29.MAC_Specificity_Values(BILLING_TAX_ID_values_persisted,BILLING_TAX_ID,'BILLING_TAX_ID',BILLING_TAX_ID_specificity,BILLING_TAX_ID_specificity_profile);
  SALT29.MAC_Specificity_Values(UPIN_values_persisted,UPIN,'UPIN',UPIN_specificity,UPIN_specificity_profile);
  SALT29.MAC_Specificity_Values(NPI_NUMBER_values_persisted,NPI_NUMBER,'NPI_NUMBER',NPI_NUMBER_specificity,NPI_NUMBER_specificity_profile);
  SALT29.MAC_Specificity_Values(BILLING_NPI_NUMBER_values_persisted,BILLING_NPI_NUMBER,'BILLING_NPI_NUMBER',BILLING_NPI_NUMBER_specificity,BILLING_NPI_NUMBER_specificity_profile);
  SALT29.MAC_Specificity_Values(DEA_NUMBER_values_persisted,DEA_NUMBER,'DEA_NUMBER',DEA_NUMBER_specificity,DEA_NUMBER_specificity_profile);
  SALT29.MAC_Specificity_Values(TAXONOMY_values_persisted,TAXONOMY,'TAXONOMY',TAXONOMY_specificity,TAXONOMY_specificity_profile);
  SALT29.MAC_Specificity_Values(VENDOR_ID_values_persisted,VENDOR_ID,'VENDOR_ID',VENDOR_ID_specificity,VENDOR_ID_specificity_profile);
  SALT29.MAC_Specificity_Values(LIC_TYPE_values_persisted,LIC_TYPE,'LIC_TYPE',LIC_TYPE_specificity,LIC_TYPE_specificity_profile);
  SALT29.MAC_Specificity_Values(CNSMR_SSN_values_persisted,CNSMR_SSN,'CNSMR_SSN',CNSMR_SSN_specificity,CNSMR_SSN_specificity_profile);
  SALT29.MAC_Specificity_Values(LAT_LONG_values_persisted,LAT_LONG,'LAT_LONG',LAT_LONG_specificity,LAT_LONG_specificity_profile);
EXPORT AllProfiles := SSN_specificity_profile + DID_specificity_profile + SNAME_specificity_profile + FNAME_specificity_profile + MNAME_specificity_profile + LNAME_specificity_profile + GENDER_specificity_profile + DERIVED_GENDER_specificity_profile + C_LIC_NBR_specificity_profile + PHONE_specificity_profile + FAX_specificity_profile + PRIM_NAME_specificity_profile + PRIM_RANGE_specificity_profile + SEC_RANGE_specificity_profile + V_CITY_NAME_specificity_profile + ST_specificity_profile + ZIP_specificity_profile + TAX_ID_specificity_profile + BILLING_TAX_ID_specificity_profile + UPIN_specificity_profile + NPI_NUMBER_specificity_profile + BILLING_NPI_NUMBER_specificity_profile + DEA_NUMBER_specificity_profile + TAXONOMY_specificity_profile + VENDOR_ID_specificity_profile + LIC_TYPE_specificity_profile + CNSMR_SSN_specificity_profile + LAT_LONG_specificity_profile;
END;
