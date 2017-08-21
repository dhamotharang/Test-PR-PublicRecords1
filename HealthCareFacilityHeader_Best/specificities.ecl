IMPORT ut,SALT30;
EXPORT specificities(DATASET(layout_HealthFacility) h) := MODULE
EXPORT input_layout := RECORD // project out required fields
  SALT30.UIDType LNPID := h.LNPID; // using existing id field
  h.RID;//RIDfield 
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))Fields.Make_PHONE((SALT30.StrType)h.PHONE ); // Cleans before using
  TYPEOF(h.FAX) FAX := (TYPEOF(h.FAX))Fields.Make_FAX((SALT30.StrType)h.FAX ); // Cleans before using
  TYPEOF(h.UPIN) UPIN := (TYPEOF(h.UPIN))Fields.Make_UPIN((SALT30.StrType)h.UPIN ); // Cleans before using
  h.NPI_NUMBER;
  h.NPI_NUMBER_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.DEA_NUMBER) DEA_NUMBER := (TYPEOF(h.DEA_NUMBER))Fields.Make_DEA_NUMBER((SALT30.StrType)h.DEA_NUMBER ); // Cleans before using
  h.DEA_NUMBER_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.CLIA_NUMBER) CLIA_NUMBER := (TYPEOF(h.CLIA_NUMBER))Fields.Make_CLIA_NUMBER((SALT30.StrType)h.CLIA_NUMBER ); // Cleans before using
  h.CLIA_NUMBER_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.MEDICARE_FACILITY_NUMBER) MEDICARE_FACILITY_NUMBER := (TYPEOF(h.MEDICARE_FACILITY_NUMBER))Fields.Make_MEDICARE_FACILITY_NUMBER((SALT30.StrType)h.MEDICARE_FACILITY_NUMBER ); // Cleans before using
  h.MEDICARE_FACILITY_NUMBER_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.NCPDP_NUMBER) NCPDP_NUMBER := (TYPEOF(h.NCPDP_NUMBER))Fields.Make_NCPDP_NUMBER((SALT30.StrType)h.NCPDP_NUMBER ); // Cleans before using
  h.NCPDP_NUMBER_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.TAX_ID) TAX_ID := (TYPEOF(h.TAX_ID))Fields.Make_TAX_ID((SALT30.StrType)h.TAX_ID ); // Cleans before using
  h.TAX_ID_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.FEIN) FEIN := (TYPEOF(h.FEIN))Fields.Make_FEIN((SALT30.StrType)h.FEIN ); // Cleans before using
  h.FEIN_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.C_LIC_NBR) C_LIC_NBR := (TYPEOF(h.C_LIC_NBR))Fields.Make_C_LIC_NBR((SALT30.StrType)h.C_LIC_NBR ); // Cleans before using
  h.C_LIC_NBR_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))Fields.Make_SRC((SALT30.StrType)h.SRC ); // Cleans before using
  TYPEOF(h.CNAME) CNAME := (TYPEOF(h.CNAME))Fields.Make_CNAME((SALT30.StrType)h.CNAME ); // Cleans before using
  TYPEOF(h.CNP_NAME) CNP_NAME := (TYPEOF(h.CNP_NAME))Fields.Make_CNP_NAME((SALT30.StrType)h.CNP_NAME ); // Cleans before using
  TYPEOF(h.CNP_NUMBER) CNP_NUMBER := (TYPEOF(h.CNP_NUMBER))Fields.Make_CNP_NUMBER((SALT30.StrType)h.CNP_NUMBER ); // Cleans before using
  TYPEOF(h.CNP_STORE_NUMBER) CNP_STORE_NUMBER := (TYPEOF(h.CNP_STORE_NUMBER))Fields.Make_CNP_STORE_NUMBER((SALT30.StrType)h.CNP_STORE_NUMBER ); // Cleans before using
  TYPEOF(h.CNP_BTYPE) CNP_BTYPE := (TYPEOF(h.CNP_BTYPE))Fields.Make_CNP_BTYPE((SALT30.StrType)h.CNP_BTYPE ); // Cleans before using
  TYPEOF(h.CNP_LOWV) CNP_LOWV := (TYPEOF(h.CNP_LOWV))Fields.Make_CNP_LOWV((SALT30.StrType)h.CNP_LOWV ); // Cleans before using
  TYPEOF(h.CNP_TRANSLATED) CNP_TRANSLATED := (TYPEOF(h.CNP_TRANSLATED))Fields.Make_CNP_TRANSLATED((SALT30.StrType)h.CNP_TRANSLATED ); // Cleans before using
  TYPEOF(h.CNP_CLASSID) CNP_CLASSID := (TYPEOF(h.CNP_CLASSID))Fields.Make_CNP_CLASSID((SALT30.StrType)h.CNP_CLASSID ); // Cleans before using
  h.ADDRESS_ID;
  TYPEOF(h.ADDRESS_CLASSIFICATION) ADDRESS_CLASSIFICATION := (TYPEOF(h.ADDRESS_CLASSIFICATION))Fields.Make_ADDRESS_CLASSIFICATION((SALT30.StrType)h.ADDRESS_CLASSIFICATION ); // Cleans before using
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT30.StrType)h.PRIM_RANGE ); // Cleans before using
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT30.StrType)h.PRIM_NAME ); // Cleans before using
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT30.StrType)h.SEC_RANGE ); // Cleans before using
  h.ST;
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))Fields.Make_V_CITY_NAME((SALT30.StrType)h.V_CITY_NAME ); // Cleans before using
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))Fields.Make_ZIP((SALT30.StrType)h.ZIP ); // Cleans before using
  TYPEOF(h.TAXONOMY) TAXONOMY := (TYPEOF(h.TAXONOMY))Fields.Make_TAXONOMY((SALT30.StrType)h.TAXONOMY ); // Cleans before using
  TYPEOF(h.TAXONOMY_CODE) TAXONOMY_CODE := (TYPEOF(h.TAXONOMY_CODE))Fields.Make_TAXONOMY_CODE((SALT30.StrType)h.TAXONOMY_CODE ); // Cleans before using
  TYPEOF(h.MEDICAID_NUMBER) MEDICAID_NUMBER := (TYPEOF(h.MEDICAID_NUMBER))Fields.Make_MEDICAID_NUMBER((SALT30.StrType)h.MEDICAID_NUMBER ); // Cleans before using
  h.MEDICAID_NUMBER_flag; // Flag to be filled in as part of Best processing
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))Fields.Make_VENDOR_ID((SALT30.StrType)h.VENDOR_ID ); // Cleans before using
  UNSIGNED4 DT_FIRST_SEEN := (UNSIGNED4)Fields.Make_DT_FIRST_SEEN((SALT30.StrType)h.DT_FIRST_SEEN ); // Cleans before using
  UNSIGNED4 DT_LAST_SEEN := (UNSIGNED4)Fields.Make_DT_LAST_SEEN((SALT30.StrType)h.DT_LAST_SEEN ); // Cleans before using
  TYPEOF(h.DT_LIC_EXPIRATION) DT_LIC_EXPIRATION := (TYPEOF(h.DT_LIC_EXPIRATION))Fields.Make_DT_LIC_EXPIRATION((SALT30.StrType)h.DT_LIC_EXPIRATION ); // Cleans before using
  TYPEOF(h.DT_DEA_EXPIRATION) DT_DEA_EXPIRATION := (TYPEOF(h.DT_DEA_EXPIRATION))Fields.Make_DT_DEA_EXPIRATION((SALT30.StrType)h.DT_DEA_EXPIRATION ); // Cleans before using
  unsigned4 FAC_NAME := 0; // Place holder filled in by project
  unsigned4 ADDR1 := 0; // Place holder filled in by project
  unsigned4 LOCALE := 0; // Place holder filled in by project
  unsigned4 ADDRESS := 0; // Place holder filled in by project
  h.LIC_STATE;
END;
r := input_layout;
h01 := DISTRIBUTE(TABLE(h(LNPID<>0),r),HASH(LNPID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.FAC_NAME := IF (Fields.InValid_FAC_NAME((SALT30.StrType)le.CNP_NAME,(SALT30.StrType)le.CNP_NUMBER,(SALT30.StrType)le.CNP_STORE_NUMBER,(SALT30.StrType)le.CNP_BTYPE),0,HASH32((SALT30.StrType)le.CNP_NAME,(SALT30.StrType)le.CNP_NUMBER,(SALT30.StrType)le.CNP_STORE_NUMBER,(SALT30.StrType)le.CNP_BTYPE)); // Combine child fields into 1 for specificity counting
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT30.StrType)le.PRIM_RANGE,(SALT30.StrType)le.PRIM_NAME,(SALT30.StrType)le.SEC_RANGE),0,HASH32((SALT30.StrType)le.PRIM_RANGE,(SALT30.StrType)le.PRIM_NAME,(SALT30.StrType)le.SEC_RANGE)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT30.StrType)le.V_CITY_NAME,(SALT30.StrType)le.ST,(SALT30.StrType)le.ZIP),0,HASH32((SALT30.StrType)le.V_CITY_NAME,(SALT30.StrType)le.ST,(SALT30.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT30.StrType)SELF.ADDR1,(SALT30.StrType)SELF.LOCALE),0,HASH32((SALT30.StrType)SELF.ADDR1,(SALT30.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0 : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have LNPID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.LNPID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,LNPID,LOCAL) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
EXPORT  PHONE_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,PHONE) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::PHONE',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(PHONE_deduped,PHONE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PHONE_values_persisted := specs_added;
EXPORT  FAX_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,FAX) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::FAX',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(FAX_deduped,FAX,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FAX_values_persisted := specs_added;
EXPORT  NPI_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,NPI_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::NPI_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(NPI_NUMBER_deduped,NPI_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT NPI_NUMBER_values_persisted := specs_added;
EXPORT  DEA_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,DEA_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::DEA_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(DEA_NUMBER_deduped,DEA_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DEA_NUMBER_values_persisted := specs_added;
EXPORT  CLIA_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,CLIA_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::CLIA_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(CLIA_NUMBER_deduped,CLIA_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CLIA_NUMBER_values_persisted := specs_added;
EXPORT  MEDICARE_FACILITY_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,MEDICARE_FACILITY_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::MEDICARE_FACILITY_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(MEDICARE_FACILITY_NUMBER_deduped,MEDICARE_FACILITY_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MEDICARE_FACILITY_NUMBER_values_persisted := specs_added;
EXPORT  NCPDP_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,NCPDP_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::NCPDP_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(NCPDP_NUMBER_deduped,NCPDP_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT NCPDP_NUMBER_values_persisted := specs_added;
EXPORT  TAX_ID_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,TAX_ID) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::TAX_ID',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(TAX_ID_deduped,TAX_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT TAX_ID_values_persisted := specs_added;
EXPORT  FEIN_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,FEIN) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::FEIN',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(FEIN_deduped,FEIN,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FEIN_values_persisted := specs_added;
EXPORT  C_LIC_NBR_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,C_LIC_NBR) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::C_LIC_NBR',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(C_LIC_NBR_deduped,C_LIC_NBR,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT30.mac_edit_distance_pairs(specs_added,C_LIC_NBR,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT C_LIC_NBR_values_persisted := distance_computed;
EXPORT  CNP_NAME_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,CNP_NAME) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::CNP_NAME',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT30.MAC_Field_Variants_Hyphen(CNP_NAME_deduped,LNPID,CNP_NAME,1); // expand out all variants when hyphenated
  SALT30.Mac_Field_Count_UID(expanded,CNP_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED CNP_NAME_sa := specs_added; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT30.MAC_Field_Variants_WordBag(CNP_NAME_deduped,LNPID,CNP_NAME,expanded)// expand out all variants of wordbag
  SALT30.Mac_Field_Count_UID(expanded,CNP_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT30.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED CNP_NAME_ad := wb_specs_added; // Hop over export
EXPORT CNP_NAMEValuesKeyName := '~'+'key::HealthCareFacilityHeader_Best::LNPID::Word::CNP_NAME';
EXPORT CNP_NAME_values_key := INDEX(CNP_NAME_ad,{CNP_NAME},{CNP_NAME_ad},CNP_NAMEValuesKeyName);
  SALT30.mac_wordbag_addweights(CNP_NAME_sa,CNP_NAME,CNP_NAME_ad,p);
EXPORT CNP_NAME_values_persisted_temp := p;
EXPORT  CNP_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,CNP_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::CNP_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(CNP_NUMBER_deduped,CNP_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNP_NUMBER_values_persisted_temp := specs_added : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_NUMBER_temp',EXPIRE(Config.PersistExpire));
EXPORT  CNP_STORE_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,CNP_STORE_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::CNP_STORE_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(CNP_STORE_NUMBER_deduped,CNP_STORE_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNP_STORE_NUMBER_values_persisted_temp := specs_added : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_STORE_NUMBER_temp',EXPIRE(Config.PersistExpire));
EXPORT  CNP_BTYPE_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,CNP_BTYPE) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::CNP_BTYPE',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(CNP_BTYPE_deduped,CNP_BTYPE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CNP_BTYPE_values_persisted_temp := specs_added : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_BTYPE_temp',EXPIRE(Config.PersistExpire));
EXPORT  PRIM_RANGE_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,PRIM_RANGE) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::PRIM_RANGE',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT30.mac_edit_distance_pairs(specs_added,PRIM_RANGE,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT PRIM_RANGE_values_persisted_temp := distance_computed : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::PRIM_RANGE_temp',EXPIRE(Config.PersistExpire));
EXPORT  PRIM_NAME_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,PRIM_NAME) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::PRIM_NAME',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED PRIM_NAME_sa := specs_added; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT30.MAC_Field_Variants_WordBag(PRIM_NAME_deduped,LNPID,PRIM_NAME,expanded)// expand out all variants of wordbag
  SALT30.Mac_Field_Count_UID(expanded,PRIM_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT30.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED PRIM_NAME_ad := wb_specs_added; // Hop over export
EXPORT PRIM_NAMEValuesKeyName := '~'+'key::HealthCareFacilityHeader_Best::LNPID::Word::PRIM_NAME';
EXPORT PRIM_NAME_values_key := INDEX(PRIM_NAME_ad,{PRIM_NAME},{PRIM_NAME_ad},PRIM_NAMEValuesKeyName);
  SALT30.mac_wordbag_addweights(PRIM_NAME_sa,PRIM_NAME,PRIM_NAME_ad,p);
EXPORT PRIM_NAME_values_persisted_temp := p;
EXPORT  SEC_RANGE_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,SEC_RANGE) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::SEC_RANGE',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT30.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,LNPID,SEC_RANGE,2); // expand out all variants when hyphenated
  SALT30.Mac_Field_Count_UID(expanded,SEC_RANGE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT30.mac_edit_distance_pairs(specs_added,SEC_RANGE,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT SEC_RANGE_values_persisted_temp := distance_computed : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::SEC_RANGE_temp',EXPIRE(Config.PersistExpire));
EXPORT  ST_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,ST) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::ST',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ST_deduped,ST,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted := specs_added;
EXPORT  V_CITY_NAME_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,V_CITY_NAME) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::V_CITY_NAME',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(V_CITY_NAME_deduped,V_CITY_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT V_CITY_NAME_values_persisted := specs_added;
EXPORT  ZIP_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,ZIP) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::ZIP',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ZIP_deduped,ZIP,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted := specs_added;
EXPORT  TAXONOMY_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,TAXONOMY) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::TAXONOMY',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(TAXONOMY_deduped,TAXONOMY,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT TAXONOMY_values_persisted := specs_added;
EXPORT  TAXONOMY_CODE_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,TAXONOMY_CODE) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::TAXONOMY_CODE',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(TAXONOMY_CODE_deduped,TAXONOMY_CODE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT TAXONOMY_CODE_values_persisted := specs_added;
EXPORT  MEDICAID_NUMBER_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,MEDICAID_NUMBER) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::MEDICAID_NUMBER',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(MEDICAID_NUMBER_deduped,MEDICAID_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MEDICAID_NUMBER_values_persisted := specs_added;
EXPORT  VENDOR_ID_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,VENDOR_ID) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::VENDOR_ID',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(VENDOR_ID_deduped,VENDOR_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT VENDOR_ID_values_persisted := specs_added;
EXPORT  FAC_NAME_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,FAC_NAME) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::FAC_NAME',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(FAC_NAME_deduped,FAC_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FAC_NAME_values_persisted := specs_added;
EXPORT  ADDR1_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,ADDR1) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::ADDR1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ADDR1_deduped,ADDR1,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDR1_values_persisted := specs_added;
EXPORT  LOCALE_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,LOCALE) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::LOCALE',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LOCALE_values_persisted := specs_added;
EXPORT  ADDRESS_deduped := SALT30.MAC_Field_By_UID(input_file,LNPID,ADDRESS) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::dedups::ADDRESS',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ADDRESS_deduped,ADDRESS,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDRESS_values_persisted := specs_added;
SALT30.MAC_Field_Nulls(PHONE_values_persisted,Layout_Specificities.PHONE_ChildRec,nv) // Use automated NULL spotting
EXPORT PHONE_nulls := nv;
SALT30.MAC_Field_Bfoul(PHONE_deduped,PHONE,LNPID,PHONE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PHONE_switch := bf;
EXPORT PHONE_max := MAX(PHONE_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(PHONE_values_persisted,PHONE,PHONE_nulls,ol) // Compute column level specificity
EXPORT PHONE_specificity := ol;
SALT30.MAC_Field_Nulls(FAX_values_persisted,Layout_Specificities.FAX_ChildRec,nv) // Use automated NULL spotting
EXPORT FAX_nulls := nv;
SALT30.MAC_Field_Bfoul(FAX_deduped,FAX,LNPID,FAX_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FAX_switch := bf;
EXPORT FAX_max := MAX(FAX_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(FAX_values_persisted,FAX,FAX_nulls,ol) // Compute column level specificity
EXPORT FAX_specificity := ol;
SALT30.MAC_Field_Nulls(NPI_NUMBER_values_persisted,Layout_Specificities.NPI_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT NPI_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(NPI_NUMBER_deduped,NPI_NUMBER,LNPID,NPI_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NPI_NUMBER_switch := bf;
EXPORT NPI_NUMBER_max := MAX(NPI_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(NPI_NUMBER_values_persisted,NPI_NUMBER,NPI_NUMBER_nulls,ol) // Compute column level specificity
EXPORT NPI_NUMBER_specificity := ol;
SALT30.MAC_Field_Nulls(DEA_NUMBER_values_persisted,Layout_Specificities.DEA_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT DEA_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(DEA_NUMBER_deduped,DEA_NUMBER,LNPID,DEA_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DEA_NUMBER_switch := bf;
EXPORT DEA_NUMBER_max := MAX(DEA_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(DEA_NUMBER_values_persisted,DEA_NUMBER,DEA_NUMBER_nulls,ol) // Compute column level specificity
EXPORT DEA_NUMBER_specificity := ol;
SALT30.MAC_Field_Nulls(CLIA_NUMBER_values_persisted,Layout_Specificities.CLIA_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT CLIA_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(CLIA_NUMBER_deduped,CLIA_NUMBER,LNPID,CLIA_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CLIA_NUMBER_switch := bf;
EXPORT CLIA_NUMBER_max := MAX(CLIA_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(CLIA_NUMBER_values_persisted,CLIA_NUMBER,CLIA_NUMBER_nulls,ol) // Compute column level specificity
EXPORT CLIA_NUMBER_specificity := ol;
SALT30.MAC_Field_Nulls(MEDICARE_FACILITY_NUMBER_values_persisted,Layout_Specificities.MEDICARE_FACILITY_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT MEDICARE_FACILITY_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(MEDICARE_FACILITY_NUMBER_deduped,MEDICARE_FACILITY_NUMBER,LNPID,MEDICARE_FACILITY_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MEDICARE_FACILITY_NUMBER_switch := bf;
EXPORT MEDICARE_FACILITY_NUMBER_max := MAX(MEDICARE_FACILITY_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(MEDICARE_FACILITY_NUMBER_values_persisted,MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER_nulls,ol) // Compute column level specificity
EXPORT MEDICARE_FACILITY_NUMBER_specificity := ol;
SALT30.MAC_Field_Nulls(NCPDP_NUMBER_values_persisted,Layout_Specificities.NCPDP_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT NCPDP_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(NCPDP_NUMBER_deduped,NCPDP_NUMBER,LNPID,NCPDP_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NCPDP_NUMBER_switch := bf;
EXPORT NCPDP_NUMBER_max := MAX(NCPDP_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(NCPDP_NUMBER_values_persisted,NCPDP_NUMBER,NCPDP_NUMBER_nulls,ol) // Compute column level specificity
EXPORT NCPDP_NUMBER_specificity := ol;
SALT30.MAC_Field_Nulls(TAX_ID_values_persisted,Layout_Specificities.TAX_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT TAX_ID_nulls := nv;
SALT30.MAC_Field_Bfoul(TAX_ID_deduped,TAX_ID,LNPID,TAX_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TAX_ID_switch := bf;
EXPORT TAX_ID_max := MAX(TAX_ID_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(TAX_ID_values_persisted,TAX_ID,TAX_ID_nulls,ol) // Compute column level specificity
EXPORT TAX_ID_specificity := ol;
SALT30.MAC_Field_Nulls(FEIN_values_persisted,Layout_Specificities.FEIN_ChildRec,nv) // Use automated NULL spotting
EXPORT FEIN_nulls := nv;
SALT30.MAC_Field_Bfoul(FEIN_deduped,FEIN,LNPID,FEIN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FEIN_switch := bf;
EXPORT FEIN_max := MAX(FEIN_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(FEIN_values_persisted,FEIN,FEIN_nulls,ol) // Compute column level specificity
EXPORT FEIN_specificity := ol;
SALT30.MAC_Field_Nulls(C_LIC_NBR_values_persisted,Layout_Specificities.C_LIC_NBR_ChildRec,nv) // Use automated NULL spotting
EXPORT C_LIC_NBR_nulls := nv;
SALT30.MAC_Field_Bfoul(C_LIC_NBR_deduped,C_LIC_NBR,LNPID,C_LIC_NBR_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT C_LIC_NBR_switch := bf;
EXPORT C_LIC_NBR_max := MAX(C_LIC_NBR_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(C_LIC_NBR_values_persisted,C_LIC_NBR,C_LIC_NBR_nulls,ol) // Compute column level specificity
EXPORT C_LIC_NBR_specificity := ol;
SALT30.MAC_Concept4_Specificities(FAC_NAME_cnt,CNP_NAME_values_persisted_temp,CNP_NAME,cnt,CNP_NUMBER_values_persisted_temp,CNP_NUMBER,cnt,CNP_STORE_NUMBER_values_persisted_temp,CNP_STORE_NUMBER,cnt,CNP_BTYPE_values_persisted_temp,CNP_BTYPE,cnt,ofile)
EXPORT CNP_NAME_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_NAME',EXPIRE(Config.PersistExpire));
EXPORT CNP_NAME_nulls := DATASET([{'',0,0}],Layout_Specificities.CNP_NAME_ChildRec); // Automated null spotting not applicable
SALT30.MAC_Field_Bfoul(CNP_NAME_deduped,CNP_NAME,LNPID,CNP_NAME_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNP_NAME_switch := bf;
EXPORT CNP_NAME_max := MAX(CNP_NAME_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(CNP_NAME_values_persisted,CNP_NAME,CNP_NAME_nulls,ol) // Compute column level specificity
EXPORT CNP_NAME_specificity := ol;
SALT30.MAC_Concept4_Specificities(FAC_NAME_cnt,CNP_NUMBER_values_persisted_temp,CNP_NUMBER,cnt,CNP_NAME_values_persisted_temp,CNP_NAME,cnt,CNP_STORE_NUMBER_values_persisted_temp,CNP_STORE_NUMBER,cnt,CNP_BTYPE_values_persisted_temp,CNP_BTYPE,cnt,ofile)
EXPORT CNP_NUMBER_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_NUMBER',EXPIRE(Config.PersistExpire));
SALT30.MAC_Field_Nulls(CNP_NUMBER_values_persisted,Layout_Specificities.CNP_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT CNP_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(CNP_NUMBER_deduped,CNP_NUMBER,LNPID,CNP_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNP_NUMBER_switch := bf;
EXPORT CNP_NUMBER_max := MAX(CNP_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(CNP_NUMBER_values_persisted,CNP_NUMBER,CNP_NUMBER_nulls,ol) // Compute column level specificity
EXPORT CNP_NUMBER_specificity := ol;
SALT30.MAC_Concept4_Specificities(FAC_NAME_cnt,CNP_STORE_NUMBER_values_persisted_temp,CNP_STORE_NUMBER,cnt,CNP_NAME_values_persisted_temp,CNP_NAME,cnt,CNP_NUMBER_values_persisted_temp,CNP_NUMBER,cnt,CNP_BTYPE_values_persisted_temp,CNP_BTYPE,cnt,ofile)
EXPORT CNP_STORE_NUMBER_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_STORE_NUMBER',EXPIRE(Config.PersistExpire));
SALT30.MAC_Field_Nulls(CNP_STORE_NUMBER_values_persisted,Layout_Specificities.CNP_STORE_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT CNP_STORE_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(CNP_STORE_NUMBER_deduped,CNP_STORE_NUMBER,LNPID,CNP_STORE_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNP_STORE_NUMBER_switch := bf;
EXPORT CNP_STORE_NUMBER_max := MAX(CNP_STORE_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(CNP_STORE_NUMBER_values_persisted,CNP_STORE_NUMBER,CNP_STORE_NUMBER_nulls,ol) // Compute column level specificity
EXPORT CNP_STORE_NUMBER_specificity := ol;
SALT30.MAC_Concept4_Specificities(FAC_NAME_cnt,CNP_BTYPE_values_persisted_temp,CNP_BTYPE,cnt,CNP_NAME_values_persisted_temp,CNP_NAME,cnt,CNP_NUMBER_values_persisted_temp,CNP_NUMBER,cnt,CNP_STORE_NUMBER_values_persisted_temp,CNP_STORE_NUMBER,cnt,ofile)
EXPORT CNP_BTYPE_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::CNP_BTYPE',EXPIRE(Config.PersistExpire));
SALT30.MAC_Field_Nulls(CNP_BTYPE_values_persisted,Layout_Specificities.CNP_BTYPE_ChildRec,nv) // Use automated NULL spotting
EXPORT CNP_BTYPE_nulls := nv;
SALT30.MAC_Field_Bfoul(CNP_BTYPE_deduped,CNP_BTYPE,LNPID,CNP_BTYPE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CNP_BTYPE_switch := bf;
EXPORT CNP_BTYPE_max := MAX(CNP_BTYPE_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(CNP_BTYPE_values_persisted,CNP_BTYPE,CNP_BTYPE_nulls,ol) // Compute column level specificity
EXPORT CNP_BTYPE_specificity := ol;
SALT30.MAC_Concept3_Specificities(ADDR1_cnt,PRIM_RANGE_values_persisted_temp,PRIM_RANGE,e1_cnt,PRIM_NAME_values_persisted_temp,PRIM_NAME,cnt,SEC_RANGE_values_persisted_temp,SEC_RANGE,e1_cnt,ofile)
EXPORT PRIM_RANGE_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::PRIM_RANGE',EXPIRE(Config.PersistExpire));
SALT30.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT30.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,LNPID,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;
SALT30.MAC_Concept3_Specificities(ADDR1_cnt,PRIM_NAME_values_persisted_temp,PRIM_NAME,cnt,PRIM_RANGE_values_persisted_temp,PRIM_RANGE,e1_cnt,SEC_RANGE_values_persisted_temp,SEC_RANGE,e1_cnt,ofile)
EXPORT PRIM_NAME_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::PRIM_NAME',EXPIRE(Config.PersistExpire));
EXPORT PRIM_NAME_nulls := DATASET([{'',0,0}],Layout_Specificities.PRIM_NAME_ChildRec); // Automated null spotting not applicable
SALT30.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,LNPID,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;
SALT30.MAC_Concept3_Specificities(ADDR1_cnt,SEC_RANGE_values_persisted_temp,SEC_RANGE,e1_cnt,PRIM_RANGE_values_persisted_temp,PRIM_RANGE,e1_cnt,PRIM_NAME_values_persisted_temp,PRIM_NAME,cnt,ofile)
EXPORT SEC_RANGE_values_persisted := ofile : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::values::SEC_RANGE',EXPIRE(Config.PersistExpire));
SALT30.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT30.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,LNPID,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;
SALT30.MAC_Field_Nulls(ST_values_persisted,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT30.MAC_Field_Bfoul(ST_deduped,ST,LNPID,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ST_values_persisted,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;
SALT30.MAC_Field_Nulls(V_CITY_NAME_values_persisted,Layout_Specificities.V_CITY_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT V_CITY_NAME_nulls := nv;
SALT30.MAC_Field_Bfoul(V_CITY_NAME_deduped,V_CITY_NAME,LNPID,V_CITY_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT V_CITY_NAME_switch := bf;
EXPORT V_CITY_NAME_max := MAX(V_CITY_NAME_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(V_CITY_NAME_values_persisted,V_CITY_NAME,V_CITY_NAME_nulls,ol) // Compute column level specificity
EXPORT V_CITY_NAME_specificity := ol;
SALT30.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT30.MAC_Field_Bfoul(ZIP_deduped,ZIP,LNPID,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;
SALT30.MAC_Field_Nulls(TAXONOMY_values_persisted,Layout_Specificities.TAXONOMY_ChildRec,nv) // Use automated NULL spotting
EXPORT TAXONOMY_nulls := nv;
SALT30.MAC_Field_Bfoul(TAXONOMY_deduped,TAXONOMY,LNPID,TAXONOMY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TAXONOMY_switch := bf;
EXPORT TAXONOMY_max := MAX(TAXONOMY_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(TAXONOMY_values_persisted,TAXONOMY,TAXONOMY_nulls,ol) // Compute column level specificity
EXPORT TAXONOMY_specificity := ol;
SALT30.MAC_Field_Nulls(TAXONOMY_CODE_values_persisted,Layout_Specificities.TAXONOMY_CODE_ChildRec,nv) // Use automated NULL spotting
EXPORT TAXONOMY_CODE_nulls := nv;
SALT30.MAC_Field_Bfoul(TAXONOMY_CODE_deduped,TAXONOMY_CODE,LNPID,TAXONOMY_CODE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TAXONOMY_CODE_switch := bf;
EXPORT TAXONOMY_CODE_max := MAX(TAXONOMY_CODE_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(TAXONOMY_CODE_values_persisted,TAXONOMY_CODE,TAXONOMY_CODE_nulls,ol) // Compute column level specificity
EXPORT TAXONOMY_CODE_specificity := ol;
SALT30.MAC_Field_Nulls(MEDICAID_NUMBER_values_persisted,Layout_Specificities.MEDICAID_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT MEDICAID_NUMBER_nulls := nv;
SALT30.MAC_Field_Bfoul(MEDICAID_NUMBER_deduped,MEDICAID_NUMBER,LNPID,MEDICAID_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MEDICAID_NUMBER_switch := bf;
EXPORT MEDICAID_NUMBER_max := MAX(MEDICAID_NUMBER_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(MEDICAID_NUMBER_values_persisted,MEDICAID_NUMBER,MEDICAID_NUMBER_nulls,ol) // Compute column level specificity
EXPORT MEDICAID_NUMBER_specificity := ol;
SALT30.MAC_Field_Nulls(VENDOR_ID_values_persisted,Layout_Specificities.VENDOR_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT VENDOR_ID_nulls := nv;
SALT30.MAC_Field_Bfoul(VENDOR_ID_deduped,VENDOR_ID,LNPID,VENDOR_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VENDOR_ID_switch := bf;
EXPORT VENDOR_ID_max := MAX(VENDOR_ID_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_nulls,ol) // Compute column level specificity
EXPORT VENDOR_ID_specificity := ol;
SALT30.MAC_Field_Nulls(FAC_NAME_values_persisted,Layout_Specificities.FAC_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FAC_NAME_nulls := nv;
SALT30.MAC_Field_Bfoul(FAC_NAME_deduped,FAC_NAME,LNPID,FAC_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FAC_NAME_switch := bf;
EXPORT FAC_NAME_max := MAX(FAC_NAME_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(FAC_NAME_values_persisted,FAC_NAME,FAC_NAME_nulls,ol) // Compute column level specificity
EXPORT FAC_NAME_specificity := ol;
SALT30.MAC_Field_Nulls(ADDR1_values_persisted,Layout_Specificities.ADDR1_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDR1_nulls := nv;
SALT30.MAC_Field_Bfoul(ADDR1_deduped,ADDR1,LNPID,ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDR1_switch := bf;
EXPORT ADDR1_max := MAX(ADDR1_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ADDR1_values_persisted,ADDR1,ADDR1_nulls,ol) // Compute column level specificity
EXPORT ADDR1_specificity := ol;
SALT30.MAC_Field_Nulls(LOCALE_values_persisted,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
EXPORT LOCALE_nulls := nv;
SALT30.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,LNPID,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LOCALE_switch := bf;
EXPORT LOCALE_max := MAX(LOCALE_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(LOCALE_values_persisted,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
EXPORT LOCALE_specificity := ol;
SALT30.MAC_Field_Nulls(ADDRESS_values_persisted,Layout_Specificities.ADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDRESS_nulls := nv;
SALT30.MAC_Field_Bfoul(ADDRESS_deduped,ADDRESS,LNPID,ADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDRESS_switch := bf;
EXPORT ADDRESS_max := MAX(ADDRESS_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ADDRESS_values_persisted,ADDRESS,ADDRESS_nulls,ol) // Compute column level specificity
EXPORT ADDRESS_specificity := ol;
iSpecificities := DATASET([{0,PHONE_specificity,PHONE_switch,PHONE_max,PHONE_nulls,FAX_specificity,FAX_switch,FAX_max,FAX_nulls,NPI_NUMBER_specificity,NPI_NUMBER_switch,NPI_NUMBER_max,NPI_NUMBER_nulls,DEA_NUMBER_specificity,DEA_NUMBER_switch,DEA_NUMBER_max,DEA_NUMBER_nulls,CLIA_NUMBER_specificity,CLIA_NUMBER_switch,CLIA_NUMBER_max,CLIA_NUMBER_nulls,MEDICARE_FACILITY_NUMBER_specificity,MEDICARE_FACILITY_NUMBER_switch,MEDICARE_FACILITY_NUMBER_max,MEDICARE_FACILITY_NUMBER_nulls,NCPDP_NUMBER_specificity,NCPDP_NUMBER_switch,NCPDP_NUMBER_max,NCPDP_NUMBER_nulls,TAX_ID_specificity,TAX_ID_switch,TAX_ID_max,TAX_ID_nulls,FEIN_specificity,FEIN_switch,FEIN_max,FEIN_nulls,C_LIC_NBR_specificity,C_LIC_NBR_switch,C_LIC_NBR_max,C_LIC_NBR_nulls,CNP_NAME_specificity,CNP_NAME_switch,CNP_NAME_max,CNP_NAME_nulls,CNP_NUMBER_specificity,CNP_NUMBER_switch,CNP_NUMBER_max,CNP_NUMBER_nulls,CNP_STORE_NUMBER_specificity,CNP_STORE_NUMBER_switch,CNP_STORE_NUMBER_max,CNP_STORE_NUMBER_nulls,CNP_BTYPE_specificity,CNP_BTYPE_switch,CNP_BTYPE_max,CNP_BTYPE_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,V_CITY_NAME_specificity,V_CITY_NAME_switch,V_CITY_NAME_max,V_CITY_NAME_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,TAXONOMY_specificity,TAXONOMY_switch,TAXONOMY_max,TAXONOMY_nulls,TAXONOMY_CODE_specificity,TAXONOMY_CODE_switch,TAXONOMY_CODE_max,TAXONOMY_CODE_nulls,MEDICAID_NUMBER_specificity,MEDICAID_NUMBER_switch,MEDICAID_NUMBER_max,MEDICAID_NUMBER_nulls,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_max,VENDOR_ID_nulls,FAC_NAME_specificity,FAC_NAME_switch,FAC_NAME_max,FAC_NAME_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_max,ADDR1_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRESS_specificity,ADDRESS_switch,ADDRESS_max,ADDRESS_nulls}],Layout_Specificities.R) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Specificities',EXPIRE(Config.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 PHONE_shift0 := ROUND(Specificities[1].PHONE_specificity - 20);
  integer2 PHONE_switch_shift0 := ROUND(1000*Specificities[1].PHONE_switch - 226);
  integer1 FAX_shift0 := ROUND(Specificities[1].FAX_specificity - 20);
  integer2 FAX_switch_shift0 := ROUND(1000*Specificities[1].FAX_switch - 193);
  integer1 NPI_NUMBER_shift0 := ROUND(Specificities[1].NPI_NUMBER_specificity - 22);
  integer2 NPI_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].NPI_NUMBER_switch - 0);
  integer1 DEA_NUMBER_shift0 := ROUND(Specificities[1].DEA_NUMBER_specificity - 21);
  integer2 DEA_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].DEA_NUMBER_switch - 38);
  integer1 CLIA_NUMBER_shift0 := ROUND(Specificities[1].CLIA_NUMBER_specificity - 22);
  integer2 CLIA_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].CLIA_NUMBER_switch - 0);
  integer1 MEDICARE_FACILITY_NUMBER_shift0 := ROUND(Specificities[1].MEDICARE_FACILITY_NUMBER_specificity - 21);
  integer2 MEDICARE_FACILITY_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].MEDICARE_FACILITY_NUMBER_switch - 147);
  integer1 NCPDP_NUMBER_shift0 := ROUND(Specificities[1].NCPDP_NUMBER_specificity - 22);
  integer2 NCPDP_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].NCPDP_NUMBER_switch - 2);
  integer1 TAX_ID_shift0 := ROUND(Specificities[1].TAX_ID_specificity - 21);
  integer2 TAX_ID_switch_shift0 := ROUND(1000*Specificities[1].TAX_ID_switch - 34);
  integer1 FEIN_shift0 := ROUND(Specificities[1].FEIN_specificity - 17);
  integer2 FEIN_switch_shift0 := ROUND(1000*Specificities[1].FEIN_switch - 23);
  integer1 C_LIC_NBR_shift0 := ROUND(Specificities[1].C_LIC_NBR_specificity - 19);
  integer2 C_LIC_NBR_switch_shift0 := ROUND(1000*Specificities[1].C_LIC_NBR_switch - 147);
  integer1 CNP_NAME_shift0 := ROUND(Specificities[1].CNP_NAME_specificity - 13);
  integer2 CNP_NAME_switch_shift0 := ROUND(1000*Specificities[1].CNP_NAME_switch - 292);
  integer1 CNP_NUMBER_shift0 := ROUND(Specificities[1].CNP_NUMBER_specificity - 13);
  integer2 CNP_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].CNP_NUMBER_switch - 44);
  integer1 CNP_STORE_NUMBER_shift0 := ROUND(Specificities[1].CNP_STORE_NUMBER_specificity - 20);
  integer2 CNP_STORE_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].CNP_STORE_NUMBER_switch - 44);
  integer1 CNP_BTYPE_shift0 := ROUND(Specificities[1].CNP_BTYPE_specificity - 4);
  integer2 CNP_BTYPE_switch_shift0 := ROUND(1000*Specificities[1].CNP_BTYPE_switch - 22);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 12);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 210);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 13);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 290);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 7);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 70);
  integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 5);
  integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 73);
  integer1 V_CITY_NAME_shift0 := ROUND(Specificities[1].V_CITY_NAME_specificity - 11);
  integer2 V_CITY_NAME_switch_shift0 := ROUND(1000*Specificities[1].V_CITY_NAME_switch - 191);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 13);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 240);
  integer1 TAXONOMY_shift0 := ROUND(Specificities[1].TAXONOMY_specificity - 7);
  integer2 TAXONOMY_switch_shift0 := ROUND(1000*Specificities[1].TAXONOMY_switch - 85);
  integer1 TAXONOMY_CODE_shift0 := ROUND(Specificities[1].TAXONOMY_CODE_specificity - 4);
  integer2 TAXONOMY_CODE_switch_shift0 := ROUND(1000*Specificities[1].TAXONOMY_CODE_switch - 10);
  integer1 MEDICAID_NUMBER_shift0 := ROUND(Specificities[1].MEDICAID_NUMBER_specificity - 22);
  integer2 MEDICAID_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].MEDICAID_NUMBER_switch - 14);
  integer1 VENDOR_ID_shift0 := ROUND(Specificities[1].VENDOR_ID_specificity - 21);
  integer2 VENDOR_ID_switch_shift0 := ROUND(1000*Specificities[1].VENDOR_ID_switch - 934);
  integer1 FAC_NAME_shift0 := ROUND(Specificities[1].FAC_NAME_specificity - 20);
  integer2 FAC_NAME_switch_shift0 := ROUND(1000*Specificities[1].FAC_NAME_switch - 401);
  integer1 ADDR1_shift0 := ROUND(Specificities[1].ADDR1_specificity - 20);
  integer2 ADDR1_switch_shift0 := ROUND(1000*Specificities[1].ADDR1_switch - 447);
  integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 13);
  integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 242);
  integer1 ADDRESS_shift0 := ROUND(Specificities[1].ADDRESS_specificity - 20);
  integer2 ADDRESS_switch_shift0 := ROUND(1000*Specificities[1].ADDRESS_switch - 449);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT30.MAC_Specificity_Values(PHONE_values_persisted,PHONE,'PHONE',PHONE_specificity,PHONE_specificity_profile);
  SALT30.MAC_Specificity_Values(FAX_values_persisted,FAX,'FAX',FAX_specificity,FAX_specificity_profile);
  SALT30.MAC_Specificity_Values(NPI_NUMBER_values_persisted,NPI_NUMBER,'NPI_NUMBER',NPI_NUMBER_specificity,NPI_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(DEA_NUMBER_values_persisted,DEA_NUMBER,'DEA_NUMBER',DEA_NUMBER_specificity,DEA_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(CLIA_NUMBER_values_persisted,CLIA_NUMBER,'CLIA_NUMBER',CLIA_NUMBER_specificity,CLIA_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(MEDICARE_FACILITY_NUMBER_values_persisted,MEDICARE_FACILITY_NUMBER,'MEDICARE_FACILITY_NUMBER',MEDICARE_FACILITY_NUMBER_specificity,MEDICARE_FACILITY_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(NCPDP_NUMBER_values_persisted,NCPDP_NUMBER,'NCPDP_NUMBER',NCPDP_NUMBER_specificity,NCPDP_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(TAX_ID_values_persisted,TAX_ID,'TAX_ID',TAX_ID_specificity,TAX_ID_specificity_profile);
  SALT30.MAC_Specificity_Values(FEIN_values_persisted,FEIN,'FEIN',FEIN_specificity,FEIN_specificity_profile);
  SALT30.MAC_Specificity_Values(C_LIC_NBR_values_persisted,C_LIC_NBR,'C_LIC_NBR',C_LIC_NBR_specificity,C_LIC_NBR_specificity_profile);
  SALT30.MAC_Specificity_Values(CNP_NAME_values_persisted,CNP_NAME,'CNP_NAME',CNP_NAME_specificity,CNP_NAME_specificity_profile);
  SALT30.MAC_Specificity_Values(CNP_NUMBER_values_persisted,CNP_NUMBER,'CNP_NUMBER',CNP_NUMBER_specificity,CNP_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(CNP_STORE_NUMBER_values_persisted,CNP_STORE_NUMBER,'CNP_STORE_NUMBER',CNP_STORE_NUMBER_specificity,CNP_STORE_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(CNP_BTYPE_values_persisted,CNP_BTYPE,'CNP_BTYPE',CNP_BTYPE_specificity,CNP_BTYPE_specificity_profile);
  SALT30.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
  SALT30.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
  SALT30.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
  SALT30.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
  SALT30.MAC_Specificity_Values(V_CITY_NAME_values_persisted,V_CITY_NAME,'V_CITY_NAME',V_CITY_NAME_specificity,V_CITY_NAME_specificity_profile);
  SALT30.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
  SALT30.MAC_Specificity_Values(TAXONOMY_values_persisted,TAXONOMY,'TAXONOMY',TAXONOMY_specificity,TAXONOMY_specificity_profile);
  SALT30.MAC_Specificity_Values(TAXONOMY_CODE_values_persisted,TAXONOMY_CODE,'TAXONOMY_CODE',TAXONOMY_CODE_specificity,TAXONOMY_CODE_specificity_profile);
  SALT30.MAC_Specificity_Values(MEDICAID_NUMBER_values_persisted,MEDICAID_NUMBER,'MEDICAID_NUMBER',MEDICAID_NUMBER_specificity,MEDICAID_NUMBER_specificity_profile);
  SALT30.MAC_Specificity_Values(VENDOR_ID_values_persisted,VENDOR_ID,'VENDOR_ID',VENDOR_ID_specificity,VENDOR_ID_specificity_profile);
EXPORT AllProfiles := PHONE_specificity_profile + FAX_specificity_profile + NPI_NUMBER_specificity_profile + DEA_NUMBER_specificity_profile + CLIA_NUMBER_specificity_profile + MEDICARE_FACILITY_NUMBER_specificity_profile + NCPDP_NUMBER_specificity_profile + TAX_ID_specificity_profile + FEIN_specificity_profile + C_LIC_NBR_specificity_profile + CNP_NAME_specificity_profile + CNP_NUMBER_specificity_profile + CNP_STORE_NUMBER_specificity_profile + CNP_BTYPE_specificity_profile + PRIM_RANGE_specificity_profile + PRIM_NAME_specificity_profile + SEC_RANGE_specificity_profile + ST_specificity_profile + V_CITY_NAME_specificity_profile + ZIP_specificity_profile + TAXONOMY_specificity_profile + TAXONOMY_CODE_specificity_profile + MEDICAID_NUMBER_specificity_profile + VENDOR_ID_specificity_profile;
END;
