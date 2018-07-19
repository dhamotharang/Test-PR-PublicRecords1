IMPORT SALT37;
EXPORT specificities(DATASET(layout_HEADER) ih) := MODULE
 
EXPORT ih_init := SALT37.initNullIDs.baseLevel(ih,RID,DID);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT37.UIDType DID := h.DID; // using existing id field
  h.RID;//RIDfield 
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))Fields.Make_VENDOR_ID((SALT37.StrType)h.VENDOR_ID ); // Cleans before using
  TYPEOF(h.BOCA_DID) BOCA_DID := (TYPEOF(h.BOCA_DID))Fields.Make_BOCA_DID((SALT37.StrType)h.BOCA_DID ); // Cleans before using
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))Fields.Make_SRC((SALT37.StrType)h.SRC ); // Cleans before using
  TYPEOF(h.SSN) SSN := (TYPEOF(h.SSN))Fields.Make_SSN((SALT37.StrType)h.SSN ); // Cleans before using
  UNSIGNED1 SSN_len := LENGTH(TRIM((SALT37.StrType)h.SSN));
  UNSIGNED2 DOB_year := ((UNSIGNED)h.DOB) DIV 10000;
  UNSIGNED1 DOB_month := (((UNSIGNED)h.DOB) DIV 100 ) % 100;
  UNSIGNED1 DOB_day := ((UNSIGNED)h.DOB) % 100;
  TYPEOF(h.DL_NBR) DL_NBR := (TYPEOF(h.DL_NBR))Fields.Make_DL_NBR((SALT37.StrType)h.DL_NBR ); // Cleans before using
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))Fields.Make_SNAME((SALT37.StrType)h.SNAME ); // Cleans before using
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))Fields.Make_FNAME((SALT37.StrType)h.FNAME ); // Cleans before using
  UNSIGNED1 FNAME_len := LENGTH(TRIM((SALT37.StrType)h.FNAME));
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))Fields.Make_MNAME((SALT37.StrType)h.MNAME ); // Cleans before using
  UNSIGNED1 MNAME_len := LENGTH(TRIM((SALT37.StrType)h.MNAME));
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))Fields.Make_LNAME((SALT37.StrType)h.LNAME ); // Cleans before using
  UNSIGNED1 LNAME_len := LENGTH(TRIM((SALT37.StrType)h.LNAME));
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))Fields.Make_GENDER((SALT37.StrType)h.GENDER ); // Cleans before using
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))Fields.Make_DERIVED_GENDER((SALT37.StrType)h.DERIVED_GENDER ); // Cleans before using
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT37.StrType)h.PRIM_NAME ); // Cleans before using
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT37.StrType)h.PRIM_RANGE ); // Cleans before using
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT37.StrType)h.SEC_RANGE ); // Cleans before using
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))Fields.Make_CITY((SALT37.StrType)h.CITY ); // Cleans before using
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))Fields.Make_ST((SALT37.StrType)h.ST ); // Cleans before using
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))Fields.Make_ZIP((SALT37.StrType)h.ZIP ); // Cleans before using
  TYPEOF(h.POLICY_NUMBER) POLICY_NUMBER := (TYPEOF(h.POLICY_NUMBER))Fields.Make_POLICY_NUMBER((SALT37.StrType)h.POLICY_NUMBER ); // Cleans before using
  TYPEOF(h.CLAIM_NUMBER) CLAIM_NUMBER := (TYPEOF(h.CLAIM_NUMBER))Fields.Make_CLAIM_NUMBER((SALT37.StrType)h.CLAIM_NUMBER ); // Cleans before using
  UNSIGNED4 DT_FIRST_SEEN := (UNSIGNED4)Fields.Make_DT_FIRST_SEEN((SALT37.StrType)h.DT_FIRST_SEEN ); // Cleans before using
  UNSIGNED4 DT_LAST_SEEN := (UNSIGNED4)Fields.Make_DT_LAST_SEEN((SALT37.StrType)h.DT_LAST_SEEN ); // Cleans before using
  UNSIGNED4 MAINNAME := 0; // Place holder filled in by project
  UNSIGNED4 ADDR1 := 0; // Place holder filled in by project
  UNSIGNED4 LOCALE := 0; // Place holder filled in by project
  UNSIGNED4 ADDRESS := 0; // Place holder filled in by project
  UNSIGNED4 FULLNAME := 0; // Place holder filled in by project
  h.DL_STATE;
  h.AMBEST;
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(DID<>0),r),HASH(DID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)>0,0,HASH32((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.PRIM_NAME)>0,0,HASH32((SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT37.StrType)le.CITY,(SALT37.StrType)le.ST,(SALT37.StrType)le.ZIP)>0,0,HASH32((SALT37.StrType)le.CITY,(SALT37.StrType)le.ST,(SALT37.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT37.StrType)SELF.ADDR1,(SALT37.StrType)SELF.LOCALE)>0,0,HASH32((SALT37.StrType)SELF.ADDR1,(SALT37.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.SNAME)>0,0,HASH32((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::Specificities_Cache',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
//We have DID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.DID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,DID,LOCAL) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::Cluster_Sizes',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  SSN_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SSN) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::SSN',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SSN_deduped,SSN,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING4 SSN_Right4 := fn_Right4(counted.SSN); // Compute fn_Right4 value for SSN
  end;
  with_id := table(counted,r1);
  SALT37.MAC_Field_Accumulate_Counts(with_id,SSN_Right4,Right4_cnt,fuzzies_counted0)
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,SSN,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT SSN_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::SSN',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DOB_year_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DOB_year) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DOB_year',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_year_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DOB_year',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DOB_month_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DOB_month) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DOB_month',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_month_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DOB_month',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DOB_day_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DOB_day) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DOB_day',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_day_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DOB_day',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DL_NBR_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DL_NBR) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DL_NBR',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DL_NBR_deduped,DL_NBR,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 DL_NBR_TrimLeadingZero := fn_TrimLeadingZero(counted.DL_NBR); // Compute fn_TrimLeadingZero value for DL_NBR
  end;
  with_id := table(counted,r1);
  SALT37.MAC_Field_Accumulate_Counts(with_id,DL_NBR_TrimLeadingZero,TrimLeadingZero_cnt,fuzzies_counted0)
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DL_NBR_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DL_NBR',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  SNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SNAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::SNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SNAME_deduped,SNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SNAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::SNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  FNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,FNAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::FNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(FNAME_deduped,DID,FNAME,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,FNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 FNAME_PreferredName := fn_PreferredName(counted.FNAME); // Compute fn_PreferredName value for FNAME
  end;
  with_id := table(counted,r1);
  SALT37.MAC_Field_Accumulate_Counts(with_id,FNAME_PreferredName,PreferredName_cnt,fuzzies_counted0)
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,FNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,FNAME,initial_specs_added) // add initial char specificities
EXPORT FNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::FNAME_temp',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  MNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,MNAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::MNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(MNAME_deduped,DID,MNAME,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,MNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,MNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,MNAME,initial_specs_added) // add initial char specificities
EXPORT MNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::MNAME_temp',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  LNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,LNAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::LNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(LNAME_deduped,DID,LNAME,2); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,LNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,LNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,LNAME,initial_specs_added) // add initial char specificities
EXPORT LNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::LNAME_temp',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  GENDER_deduped := SALT37.MAC_Field_By_UID(input_file,DID,GENDER) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::GENDER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(GENDER_deduped,GENDER,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT GENDER_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::GENDER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DERIVED_GENDER_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DERIVED_GENDER) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DERIVED_GENDER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DERIVED_GENDER_deduped,DERIVED_GENDER,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DERIVED_GENDER_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DERIVED_GENDER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  PRIM_NAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,PRIM_NAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::PRIM_NAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_NAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::PRIM_NAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  PRIM_RANGE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,PRIM_RANGE) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::PRIM_RANGE',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_RANGE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::PRIM_RANGE',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  SEC_RANGE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SEC_RANGE) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::SEC_RANGE',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,DID,SEC_RANGE,2); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,SEC_RANGE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEC_RANGE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::SEC_RANGE',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  CITY_deduped := SALT37.MAC_Field_By_UID(input_file,DID,CITY) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::CITY',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CITY_deduped,CITY,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CITY_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::CITY',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  ST_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ST) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::ST',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ST_deduped,ST,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::ST',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  ZIP_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ZIP) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::ZIP',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ZIP_deduped,ZIP,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::ZIP',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  POLICY_NUMBER_deduped := SALT37.MAC_Field_By_UID(input_file,DID,POLICY_NUMBER) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::POLICY_NUMBER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(POLICY_NUMBER_deduped,POLICY_NUMBER,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 POLICY_NUMBER_TrimLeadingZero := fn_TrimLeadingZero(counted.POLICY_NUMBER); // Compute fn_TrimLeadingZero value for POLICY_NUMBER
  end;
  with_id := table(counted,r1);
  SALT37.MAC_Field_Accumulate_Counts(with_id,POLICY_NUMBER_TrimLeadingZero,TrimLeadingZero_cnt,fuzzies_counted0)
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT POLICY_NUMBER_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::POLICY_NUMBER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  CLAIM_NUMBER_deduped := SALT37.MAC_Field_By_UID(input_file,DID,CLAIM_NUMBER) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::CLAIM_NUMBER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CLAIM_NUMBER_deduped,CLAIM_NUMBER,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CLAIM_NUMBER_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::CLAIM_NUMBER',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DT_FIRST_SEEN_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DT_FIRST_SEEN) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DT_FIRST_SEEN',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_FIRST_SEEN_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DT_FIRST_SEEN',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  DT_LAST_SEEN_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DT_LAST_SEEN) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::DT_LAST_SEEN',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_LAST_SEEN_deduped,DT_LAST_SEEN,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_LAST_SEEN_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::DT_LAST_SEEN',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  MAINNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,MAINNAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::MAINNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MAINNAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::MAINNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  ADDR1_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ADDR1) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::ADDR1',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ADDR1_deduped,ADDR1,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDR1_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::ADDR1',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  LOCALE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,LOCALE) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::LOCALE',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LOCALE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::LOCALE',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  ADDRESS_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ADDRESS) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::ADDRESS',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ADDRESS_deduped,ADDRESS,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDRESS_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::ADDRESS',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
EXPORT  FULLNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,FULLNAME) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::dedups::FULLNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FULLNAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::values::FULLNAME',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
/*HACK-O-MATIC*/ EXPORT SSNValuesIndexKeyName(STRING Version) := Filenames.spec_SSN_LF(version);
EXPORT SSNValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_SSN_Full_SF.current,'qa' => Filenames.spec_SSN_QA_SF.current, Filenames.spec_SSN_SF.current);

 
/*HACK-O-MATIC*/ EXPORT SSN_values_index := INDEX(SSN_values_persisted_temp,{SSN},{SSN_values_persisted_temp},SSNValuesIndexKeyNameSuper);
EXPORT SSN_values_index_Logical(STRING version) := INDEX(SSN_values_persisted_temp,{SSN},{SSN_values_persisted_temp},SSNValuesIndexKeyName(version));

EXPORT SSN_values_persisted := SSN_values_index;
SALT37.MAC_Field_Nulls(SSN_values_persisted,Layout_Specificities.SSN_ChildRec,nv) // Use automated NULL spotting
EXPORT SSN_nulls := nv;
SALT37.MAC_Field_Bfoul(SSN_deduped,SSN,DID,SSN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SSN_switch := bf;
EXPORT SSN_max := MAX(SSN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SSN_values_persisted,SSN,SSN_nulls,ol) // Compute column level specificity
EXPORT SSN_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DOB_yearValuesIndexKeyName(STRING Version) := Filenames.spec_DOB_year_LF(version);
EXPORT DOB_yearValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DOB_year_Full_SF.current,'qa' => Filenames.spec_DOB_year_QA_SF.current, Filenames.spec_DOB_year_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DOB_year_values_index := INDEX(DOB_year_values_persisted_temp,{DOB_year},{DOB_year_values_persisted_temp},DOB_yearValuesIndexKeyNameSuper);
EXPORT DOB_year_values_index_Logical(STRING version) := INDEX(DOB_year_values_persisted_temp,{DOB_year},{DOB_year_values_persisted_temp},DOB_yearValuesIndexKeyName(version));

EXPORT DOB_year_values_persisted := DOB_year_values_index;
SALT37.MAC_Field_Nulls(DOB_year_values_persisted,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_year_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,DID,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_year_switch := bf;
EXPORT DOB_year_max := MAX(DOB_year_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_year_values_persisted,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
EXPORT DOB_year_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DOB_monthValuesIndexKeyName(STRING Version) := Filenames.spec_DOB_month_LF(version);
EXPORT DOB_monthValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DOB_month_Full_SF.current,'qa' => Filenames.spec_DOB_month_QA_SF.current, Filenames.spec_DOB_month_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DOB_month_values_index := INDEX(DOB_month_values_persisted_temp,{DOB_month},{DOB_month_values_persisted_temp},DOB_monthValuesIndexKeyNameSuper);
EXPORT DOB_month_values_index_Logical(STRING version) := INDEX(DOB_month_values_persisted_temp,{DOB_month},{DOB_month_values_persisted_temp},DOB_monthValuesIndexKeyName(version));

EXPORT DOB_month_values_persisted := DOB_month_values_index;
SALT37.MAC_Field_Nulls(DOB_month_values_persisted,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_month_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,DID,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_month_switch := bf;
EXPORT DOB_month_max := MAX(DOB_month_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_month_values_persisted,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
EXPORT DOB_month_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DOB_dayValuesIndexKeyName(STRING Version) := Filenames.spec_DOB_day_LF(version);
EXPORT DOB_dayValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DOB_day_Full_SF.current,'qa' => Filenames.spec_DOB_day_QA_SF.current, Filenames.spec_DOB_day_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DOB_day_values_index := INDEX(DOB_day_values_persisted_temp,{DOB_day},{DOB_day_values_persisted_temp},DOB_dayValuesIndexKeyNameSuper);
EXPORT DOB_day_values_index_Logical(STRING version) := INDEX(DOB_day_values_persisted_temp,{DOB_day},{DOB_day_values_persisted_temp},DOB_dayValuesIndexKeyName(version));

EXPORT DOB_day_values_persisted := DOB_day_values_index;
SALT37.MAC_Field_Nulls(DOB_day_values_persisted,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_day_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,DID,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_day_switch := bf;
EXPORT DOB_day_max := MAX(DOB_day_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_day_values_persisted,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
EXPORT DOB_day_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DL_NBRValuesIndexKeyName(STRING Version) := Filenames.spec_DL_NBR_LF(version);
EXPORT DL_NBRValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DL_NBR_Full_SF.current,'qa' => Filenames.spec_DL_NBR_QA_SF.current, Filenames.spec_DL_NBR_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DL_NBR_values_index := INDEX(DL_NBR_values_persisted_temp,{DL_NBR},{DL_NBR_values_persisted_temp},DL_NBRValuesIndexKeyNameSuper);
EXPORT DL_NBR_values_index_Logical(STRING version) := INDEX(DL_NBR_values_persisted_temp,{DL_NBR},{DL_NBR_values_persisted_temp},DL_NBRValuesIndexKeyName(version));

EXPORT DL_NBR_values_persisted := DL_NBR_values_index;
SALT37.MAC_Field_Nulls(DL_NBR_values_persisted,Layout_Specificities.DL_NBR_ChildRec,nv) // Use automated NULL spotting
EXPORT DL_NBR_nulls := nv;
SALT37.MAC_Field_Bfoul(DL_NBR_deduped,DL_NBR,DID,DL_NBR_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DL_NBR_switch := bf;
EXPORT DL_NBR_max := MAX(DL_NBR_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DL_NBR_values_persisted,DL_NBR,DL_NBR_nulls,ol) // Compute column level specificity
EXPORT DL_NBR_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT SNAMEValuesIndexKeyName(STRING Version) := Filenames.spec_SNAME_LF(version);
EXPORT SNAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_SNAME_Full_SF.current,'qa' => Filenames.spec_SNAME_QA_SF.current, Filenames.spec_SNAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT SNAME_values_index := INDEX(SNAME_values_persisted_temp,{SNAME},{SNAME_values_persisted_temp},SNAMEValuesIndexKeyNameSuper);
EXPORT SNAME_values_index_Logical(STRING version) := INDEX(SNAME_values_persisted_temp,{SNAME},{SNAME_values_persisted_temp},SNAMEValuesIndexKeyName(version));

EXPORT SNAME_values_persisted := SNAME_values_index;
EXPORT SNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.SNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(SNAME_deduped,SNAME,DID,SNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SNAME_switch := bf;
EXPORT SNAME_max := MAX(SNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SNAME_values_persisted,SNAME,SNAME_nulls,ol) // Compute column level specificity
EXPORT SNAME_specificity := ol;
SALT37.MAC_Concept3_Specificities(MAINNAME_cnt,FNAME_values_persisted_temp,FNAME,cnt,6,MNAME_values_persisted_temp,MNAME,cnt,6,LNAME_values_persisted_temp,LNAME,cnt,6,ofile)
SALT37.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,FNAME,e2_cnt,6,MNAME_values_persisted_temp,MNAME,e2_cnt,6,LNAME_values_persisted_temp,LNAME,e2_cnt,6,ofile_wfuzzy)
SHARED FNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
/*HACK-O-MATIC*/ EXPORT FNAMEValuesIndexKeyName(STRING Version) := Filenames.spec_FNAME_LF(version);
EXPORT FNAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_FNAME_Full_SF.current,'qa' => Filenames.spec_FNAME_QA_SF.current, Filenames.spec_FNAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT FNAME_values_index := INDEX(FNAME_values_persisted0,{FNAME},{FNAME_values_persisted0},FNAMEValuesIndexKeyNameSuper);
EXPORT FNAME_values_index_Logical(STRING version) := INDEX(FNAME_values_persisted0,{FNAME},{FNAME_values_persisted0},FNAMEValuesIndexKeyName(version));

EXPORT FNAME_values_persisted := FNAME_values_index;
EXPORT FNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(FNAME_deduped,FNAME,DID,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FNAME_switch := bf;
EXPORT FNAME_max := MAX(FNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(FNAME_values_persisted,FNAME,FNAME_nulls,ol) // Compute column level specificity
EXPORT FNAME_specificity := ol;
SALT37.MAC_Concept3_Specificities(MAINNAME_cnt,MNAME_values_persisted_temp,MNAME,cnt,6,FNAME_values_persisted_temp,FNAME,cnt,6,LNAME_values_persisted_temp,LNAME,cnt,6,ofile)
SALT37.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,MNAME,e2_cnt,6,FNAME_values_persisted_temp,FNAME,e2_cnt,6,LNAME_values_persisted_temp,LNAME,e2_cnt,6,ofile_wfuzzy)
SHARED MNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
/*HACK-O-MATIC*/ EXPORT MNAMEValuesIndexKeyName(STRING Version) := Filenames.spec_MNAME_LF(version);
EXPORT MNAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_MNAME_Full_SF.current,'qa' => Filenames.spec_MNAME_QA_SF.current, Filenames.spec_MNAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT MNAME_values_index := INDEX(MNAME_values_persisted0,{MNAME},{MNAME_values_persisted0},MNAMEValuesIndexKeyNameSuper);
EXPORT MNAME_values_index_Logical(STRING version) := INDEX(MNAME_values_persisted0,{MNAME},{MNAME_values_persisted0},MNAMEValuesIndexKeyName(version));

EXPORT MNAME_values_persisted := MNAME_values_index;
EXPORT MNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(MNAME_deduped,MNAME,DID,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MNAME_switch := bf;
EXPORT MNAME_max := MAX(MNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(MNAME_values_persisted,MNAME,MNAME_nulls,ol) // Compute column level specificity
EXPORT MNAME_specificity := ol;
SALT37.MAC_Concept3_Specificities(MAINNAME_cnt,LNAME_values_persisted_temp,LNAME,cnt,6,FNAME_values_persisted_temp,FNAME,cnt,6,MNAME_values_persisted_temp,MNAME,cnt,6,ofile)
SALT37.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,LNAME,e2_cnt,6,FNAME_values_persisted_temp,FNAME,e2_cnt,6,MNAME_values_persisted_temp,MNAME,e2_cnt,6,ofile_wfuzzy)
SHARED LNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
/*HACK-O-MATIC*/ EXPORT LNAMEValuesIndexKeyName(STRING Version) := Filenames.spec_LNAME_LF(version);
EXPORT LNAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_LNAME_Full_SF.current,'qa' => Filenames.spec_LNAME_QA_SF.current, Filenames.spec_LNAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT LNAME_values_index := INDEX(LNAME_values_persisted0,{LNAME},{LNAME_values_persisted0},LNAMEValuesIndexKeyNameSuper);
EXPORT LNAME_values_index_Logical(STRING version) := INDEX(LNAME_values_persisted0,{LNAME},{LNAME_values_persisted0},LNAMEValuesIndexKeyName(version));

EXPORT LNAME_values_persisted := LNAME_values_index;
EXPORT LNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.LNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(LNAME_deduped,LNAME,DID,LNAME_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LNAME_switch := bf;
EXPORT LNAME_max := MAX(LNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LNAME_values_persisted,LNAME,LNAME_nulls,ol) // Compute column level specificity
EXPORT LNAME_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT GENDERValuesIndexKeyName(STRING Version) := Filenames.spec_GENDER_LF(version);
EXPORT GENDERValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_GENDER_Full_SF.current,'qa' => Filenames.spec_GENDER_QA_SF.current, Filenames.spec_GENDER_SF.current);

 
/*HACK-O-MATIC*/ EXPORT GENDER_values_index := INDEX(GENDER_values_persisted_temp,{GENDER},{GENDER_values_persisted_temp},GENDERValuesIndexKeyNameSuper);
EXPORT GENDER_values_index_Logical(STRING version) := INDEX(GENDER_values_persisted_temp,{GENDER},{GENDER_values_persisted_temp},GENDERValuesIndexKeyName(version));

EXPORT GENDER_values_persisted := GENDER_values_index;
EXPORT GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.GENDER_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(GENDER_deduped,GENDER,DID,GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT GENDER_switch := bf;
EXPORT GENDER_max := MAX(GENDER_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(GENDER_values_persisted,GENDER,GENDER_nulls,ol) // Compute column level specificity
EXPORT GENDER_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DERIVED_GENDERValuesIndexKeyName(STRING Version) := Filenames.spec_DERIVED_GENDER_LF(version);
EXPORT DERIVED_GENDERValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DERIVED_GENDER_Full_SF.current,'qa' => Filenames.spec_DERIVED_GENDER_QA_SF.current, Filenames.spec_DERIVED_GENDER_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DERIVED_GENDER_values_index := INDEX(DERIVED_GENDER_values_persisted_temp,{DERIVED_GENDER},{DERIVED_GENDER_values_persisted_temp},DERIVED_GENDERValuesIndexKeyNameSuper);
EXPORT DERIVED_GENDER_values_index_Logical(STRING version) := INDEX(DERIVED_GENDER_values_persisted_temp,{DERIVED_GENDER},{DERIVED_GENDER_values_persisted_temp},DERIVED_GENDERValuesIndexKeyName(version));

EXPORT DERIVED_GENDER_values_persisted := DERIVED_GENDER_values_index;
EXPORT DERIVED_GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.DERIVED_GENDER_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(DERIVED_GENDER_deduped,DERIVED_GENDER,DID,DERIVED_GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DERIVED_GENDER_switch := bf;
EXPORT DERIVED_GENDER_max := MAX(DERIVED_GENDER_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DERIVED_GENDER_values_persisted,DERIVED_GENDER,DERIVED_GENDER_nulls,ol) // Compute column level specificity
EXPORT DERIVED_GENDER_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT PRIM_NAMEValuesIndexKeyName(STRING Version) := Filenames.spec_PRIM_NAME_LF(version);
EXPORT PRIM_NAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_PRIM_NAME_Full_SF.current,'qa' => Filenames.spec_PRIM_NAME_QA_SF.current, Filenames.spec_PRIM_NAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT PRIM_NAME_values_index := INDEX(PRIM_NAME_values_persisted_temp,{PRIM_NAME},{PRIM_NAME_values_persisted_temp},PRIM_NAMEValuesIndexKeyNameSuper);
EXPORT PRIM_NAME_values_index_Logical(STRING version) := INDEX(PRIM_NAME_values_persisted_temp,{PRIM_NAME},{PRIM_NAME_values_persisted_temp},PRIM_NAMEValuesIndexKeyName(version));

EXPORT PRIM_NAME_values_persisted := PRIM_NAME_values_index;
SALT37.MAC_Field_Nulls(PRIM_NAME_values_persisted,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_NAME_nulls := nv;
SALT37.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,DID,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT PRIM_RANGEValuesIndexKeyName(STRING Version) := Filenames.spec_PRIM_RANGE_LF(version);
EXPORT PRIM_RANGEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_PRIM_RANGE_Full_SF.current,'qa' => Filenames.spec_PRIM_RANGE_QA_SF.current, Filenames.spec_PRIM_RANGE_SF.current);

 
/*HACK-O-MATIC*/ EXPORT PRIM_RANGE_values_index := INDEX(PRIM_RANGE_values_persisted_temp,{PRIM_RANGE},{PRIM_RANGE_values_persisted_temp},PRIM_RANGEValuesIndexKeyNameSuper);
EXPORT PRIM_RANGE_values_index_Logical(STRING version) := INDEX(PRIM_RANGE_values_persisted_temp,{PRIM_RANGE},{PRIM_RANGE_values_persisted_temp},PRIM_RANGEValuesIndexKeyName(version));

EXPORT PRIM_RANGE_values_persisted := PRIM_RANGE_values_index;
SALT37.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT37.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,DID,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT SEC_RANGEValuesIndexKeyName(STRING Version) := Filenames.spec_SEC_RANGE_LF(version);
EXPORT SEC_RANGEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_SEC_RANGE_Full_SF.current,'qa' => Filenames.spec_SEC_RANGE_QA_SF.current, Filenames.spec_SEC_RANGE_SF.current);

 
/*HACK-O-MATIC*/ EXPORT SEC_RANGE_values_index := INDEX(SEC_RANGE_values_persisted_temp,{SEC_RANGE},{SEC_RANGE_values_persisted_temp},SEC_RANGEValuesIndexKeyNameSuper);
EXPORT SEC_RANGE_values_index_Logical(STRING version) := INDEX(SEC_RANGE_values_persisted_temp,{SEC_RANGE},{SEC_RANGE_values_persisted_temp},SEC_RANGEValuesIndexKeyName(version));

EXPORT SEC_RANGE_values_persisted := SEC_RANGE_values_index;
SALT37.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT37.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,DID,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT CITYValuesIndexKeyName(STRING Version) := Filenames.spec_CITY_LF(version);
EXPORT CITYValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_CITY_Full_SF.current,'qa' => Filenames.spec_CITY_QA_SF.current, Filenames.spec_CITY_SF.current);

 
/*HACK-O-MATIC*/ EXPORT CITY_values_index := INDEX(CITY_values_persisted_temp,{CITY},{CITY_values_persisted_temp},CITYValuesIndexKeyNameSuper);
EXPORT CITY_values_index_Logical(STRING version) := INDEX(CITY_values_persisted_temp,{CITY},{CITY_values_persisted_temp},CITYValuesIndexKeyName(version));

EXPORT CITY_values_persisted := CITY_values_index;
SALT37.MAC_Field_Nulls(CITY_values_persisted,Layout_Specificities.CITY_ChildRec,nv) // Use automated NULL spotting
EXPORT CITY_nulls := nv;
SALT37.MAC_Field_Bfoul(CITY_deduped,CITY,DID,CITY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CITY_switch := bf;
EXPORT CITY_max := MAX(CITY_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CITY_values_persisted,CITY,CITY_nulls,ol) // Compute column level specificity
EXPORT CITY_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT STValuesIndexKeyName(STRING Version) := Filenames.spec_ST_LF(version);
EXPORT STValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_ST_Full_SF.current,'qa' => Filenames.spec_ST_QA_SF.current, Filenames.spec_ST_SF.current);

 
/*HACK-O-MATIC*/ EXPORT ST_values_index := INDEX(ST_values_persisted_temp,{ST},{ST_values_persisted_temp},STValuesIndexKeyNameSuper);
EXPORT ST_values_index_Logical(STRING version) := INDEX(ST_values_persisted_temp,{ST},{ST_values_persisted_temp},STValuesIndexKeyName(version));

EXPORT ST_values_persisted := ST_values_index;
SALT37.MAC_Field_Nulls(ST_values_persisted,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT37.MAC_Field_Bfoul(ST_deduped,ST,DID,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ST_values_persisted,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT ZIPValuesIndexKeyName(STRING Version) := Filenames.spec_ZIP_LF(version);
EXPORT ZIPValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_ZIP_Full_SF.current,'qa' => Filenames.spec_ZIP_QA_SF.current, Filenames.spec_ZIP_SF.current);

 
/*HACK-O-MATIC*/ EXPORT ZIP_values_index := INDEX(ZIP_values_persisted_temp,{ZIP},{ZIP_values_persisted_temp},ZIPValuesIndexKeyNameSuper);
EXPORT ZIP_values_index_Logical(STRING version) := INDEX(ZIP_values_persisted_temp,{ZIP},{ZIP_values_persisted_temp},ZIPValuesIndexKeyName(version));

EXPORT ZIP_values_persisted := ZIP_values_index;
SALT37.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT37.MAC_Field_Bfoul(ZIP_deduped,ZIP,DID,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT POLICY_NUMBERValuesIndexKeyName(STRING Version) := Filenames.spec_POLICY_NUMBER_LF(version);
EXPORT POLICY_NUMBERValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_POLICY_NUMBER_Full_SF.current,'qa' => Filenames.spec_POLICY_NUMBER_QA_SF.current, Filenames.spec_POLICY_NUMBER_SF.current);

 
/*HACK-O-MATIC*/ EXPORT POLICY_NUMBER_values_index := INDEX(POLICY_NUMBER_values_persisted_temp,{POLICY_NUMBER},{POLICY_NUMBER_values_persisted_temp},POLICY_NUMBERValuesIndexKeyNameSuper);
EXPORT POLICY_NUMBER_values_index_Logical(STRING version) := INDEX(POLICY_NUMBER_values_persisted_temp,{POLICY_NUMBER},{POLICY_NUMBER_values_persisted_temp},POLICY_NUMBERValuesIndexKeyName(version));

EXPORT POLICY_NUMBER_values_persisted := POLICY_NUMBER_values_index;
SALT37.MAC_Field_Nulls(POLICY_NUMBER_values_persisted,Layout_Specificities.POLICY_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT POLICY_NUMBER_nulls := nv;
SALT37.MAC_Field_Bfoul(POLICY_NUMBER_deduped,POLICY_NUMBER,DID,POLICY_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT POLICY_NUMBER_switch := bf;
EXPORT POLICY_NUMBER_max := MAX(POLICY_NUMBER_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(POLICY_NUMBER_values_persisted,POLICY_NUMBER,POLICY_NUMBER_nulls,ol) // Compute column level specificity
EXPORT POLICY_NUMBER_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT CLAIM_NUMBERValuesIndexKeyName(STRING Version) := Filenames.spec_CLAIM_NUMBER_LF(version);
EXPORT CLAIM_NUMBERValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_CLAIM_NUMBER_Full_SF.current,'qa' => Filenames.spec_CLAIM_NUMBER_QA_SF.current, Filenames.spec_CLAIM_NUMBER_SF.current);

 
/*HACK-O-MATIC*/ EXPORT CLAIM_NUMBER_values_index := INDEX(CLAIM_NUMBER_values_persisted_temp,{CLAIM_NUMBER},{CLAIM_NUMBER_values_persisted_temp},CLAIM_NUMBERValuesIndexKeyNameSuper);
EXPORT CLAIM_NUMBER_values_index_Logical(STRING version) := INDEX(CLAIM_NUMBER_values_persisted_temp,{CLAIM_NUMBER},{CLAIM_NUMBER_values_persisted_temp},CLAIM_NUMBERValuesIndexKeyName(version));

EXPORT CLAIM_NUMBER_values_persisted := CLAIM_NUMBER_values_index;
SALT37.MAC_Field_Nulls(CLAIM_NUMBER_values_persisted,Layout_Specificities.CLAIM_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT CLAIM_NUMBER_nulls := nv;
SALT37.MAC_Field_Bfoul(CLAIM_NUMBER_deduped,CLAIM_NUMBER,DID,CLAIM_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CLAIM_NUMBER_switch := bf;
EXPORT CLAIM_NUMBER_max := MAX(CLAIM_NUMBER_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CLAIM_NUMBER_values_persisted,CLAIM_NUMBER,CLAIM_NUMBER_nulls,ol) // Compute column level specificity
EXPORT CLAIM_NUMBER_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DT_FIRST_SEENValuesIndexKeyName(STRING Version) := Filenames.spec_DT_FIRST_SEEN_LF(version);
EXPORT DT_FIRST_SEENValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DT_FIRST_SEEN_Full_SF.current,'qa' => Filenames.spec_DT_FIRST_SEEN_QA_SF.current, Filenames.spec_DT_FIRST_SEEN_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DT_FIRST_SEEN_values_index := INDEX(DT_FIRST_SEEN_values_persisted_temp,{DT_FIRST_SEEN},{DT_FIRST_SEEN_values_persisted_temp},DT_FIRST_SEENValuesIndexKeyNameSuper);
EXPORT DT_FIRST_SEEN_values_index_Logical(STRING version) := INDEX(DT_FIRST_SEEN_values_persisted_temp,{DT_FIRST_SEEN},{DT_FIRST_SEEN_values_persisted_temp},DT_FIRST_SEENValuesIndexKeyName(version));

EXPORT DT_FIRST_SEEN_values_persisted := DT_FIRST_SEEN_values_index;
SALT37.MAC_Field_Nulls(DT_FIRST_SEEN_values_persisted,Layout_Specificities.DT_FIRST_SEEN_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_FIRST_SEEN_nulls := nv;
SALT37.MAC_Field_Bfoul(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,DID,DT_FIRST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_FIRST_SEEN_switch := bf;
EXPORT DT_FIRST_SEEN_max := MAX(DT_FIRST_SEEN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_FIRST_SEEN_values_persisted,DT_FIRST_SEEN,DT_FIRST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_FIRST_SEEN_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT DT_LAST_SEENValuesIndexKeyName(STRING Version) := Filenames.spec_DT_LAST_SEEN_LF(version);
EXPORT DT_LAST_SEENValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_DT_LAST_SEEN_Full_SF.current,'qa' => Filenames.spec_DT_LAST_SEEN_QA_SF.current, Filenames.spec_DT_LAST_SEEN_SF.current);

 
/*HACK-O-MATIC*/ EXPORT DT_LAST_SEEN_values_index := INDEX(DT_LAST_SEEN_values_persisted_temp,{DT_LAST_SEEN},{DT_LAST_SEEN_values_persisted_temp},DT_LAST_SEENValuesIndexKeyNameSuper);
EXPORT DT_LAST_SEEN_values_index_Logical(STRING version) := INDEX(DT_LAST_SEEN_values_persisted_temp,{DT_LAST_SEEN},{DT_LAST_SEEN_values_persisted_temp},DT_LAST_SEENValuesIndexKeyName(version));

EXPORT DT_LAST_SEEN_values_persisted := DT_LAST_SEEN_values_index;
SALT37.MAC_Field_Nulls(DT_LAST_SEEN_values_persisted,Layout_Specificities.DT_LAST_SEEN_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_LAST_SEEN_nulls := nv;
SALT37.MAC_Field_Bfoul(DT_LAST_SEEN_deduped,DT_LAST_SEEN,DID,DT_LAST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_LAST_SEEN_switch := bf;
EXPORT DT_LAST_SEEN_max := MAX(DT_LAST_SEEN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_LAST_SEEN_values_persisted,DT_LAST_SEEN,DT_LAST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_LAST_SEEN_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT MAINNAMEValuesIndexKeyName(STRING Version) := Filenames.spec_MAINNAME_LF(version);
EXPORT MAINNAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_MAINNAME_Full_SF.current,'qa' => Filenames.spec_MAINNAME_QA_SF.current, Filenames.spec_MAINNAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT MAINNAME_values_index := INDEX(MAINNAME_values_persisted_temp,{MAINNAME},{MAINNAME_values_persisted_temp},MAINNAMEValuesIndexKeyNameSuper);
EXPORT MAINNAME_values_index_Logical(STRING version) := INDEX(MAINNAME_values_persisted_temp,{MAINNAME},{MAINNAME_values_persisted_temp},MAINNAMEValuesIndexKeyName(version));

EXPORT MAINNAME_values_persisted := MAINNAME_values_index;
SALT37.MAC_Field_Nulls(MAINNAME_values_persisted,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT MAINNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,DID,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MAINNAME_switch := bf;
EXPORT MAINNAME_max := MAX(MAINNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(MAINNAME_values_persisted,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
EXPORT MAINNAME_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT ADDR1ValuesIndexKeyName(STRING Version) := Filenames.spec_ADDR1_LF(version);
EXPORT ADDR1ValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_ADDR1_Full_SF.current,'qa' => Filenames.spec_ADDR1_QA_SF.current, Filenames.spec_ADDR1_SF.current);

 
/*HACK-O-MATIC*/ EXPORT ADDR1_values_index := INDEX(ADDR1_values_persisted_temp,{ADDR1},{ADDR1_values_persisted_temp},ADDR1ValuesIndexKeyNameSuper);
EXPORT ADDR1_values_index_Logical(STRING version) := INDEX(ADDR1_values_persisted_temp,{ADDR1},{ADDR1_values_persisted_temp},ADDR1ValuesIndexKeyName(version));

EXPORT ADDR1_values_persisted := ADDR1_values_index;
SALT37.MAC_Field_Nulls(ADDR1_values_persisted,Layout_Specificities.ADDR1_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDR1_nulls := nv;
SALT37.MAC_Field_Bfoul(ADDR1_deduped,ADDR1,DID,ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDR1_switch := bf;
EXPORT ADDR1_max := MAX(ADDR1_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ADDR1_values_persisted,ADDR1,ADDR1_nulls,ol) // Compute column level specificity
EXPORT ADDR1_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT LOCALEValuesIndexKeyName(STRING Version) := Filenames.spec_LOCALE_LF(version);
EXPORT LOCALEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_LOCALE_Full_SF.current,'qa' => Filenames.spec_LOCALE_QA_SF.current, Filenames.spec_LOCALE_SF.current);

 
/*HACK-O-MATIC*/ EXPORT LOCALE_values_index := INDEX(LOCALE_values_persisted_temp,{LOCALE},{LOCALE_values_persisted_temp},LOCALEValuesIndexKeyNameSuper);
EXPORT LOCALE_values_index_Logical(STRING version) := INDEX(LOCALE_values_persisted_temp,{LOCALE},{LOCALE_values_persisted_temp},LOCALEValuesIndexKeyName(version));

EXPORT LOCALE_values_persisted := LOCALE_values_index;
SALT37.MAC_Field_Nulls(LOCALE_values_persisted,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
EXPORT LOCALE_nulls := nv;
SALT37.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,DID,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LOCALE_switch := bf;
EXPORT LOCALE_max := MAX(LOCALE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LOCALE_values_persisted,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
EXPORT LOCALE_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT ADDRESSValuesIndexKeyName(STRING Version) := Filenames.spec_ADDRESS_LF(version);
EXPORT ADDRESSValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_ADDRESS_Full_SF.current,'qa' => Filenames.spec_ADDRESS_QA_SF.current, Filenames.spec_ADDRESS_SF.current);

 
/*HACK-O-MATIC*/ EXPORT ADDRESS_values_index := INDEX(ADDRESS_values_persisted_temp,{ADDRESS},{ADDRESS_values_persisted_temp},ADDRESSValuesIndexKeyNameSuper);
EXPORT ADDRESS_values_index_Logical(STRING version) := INDEX(ADDRESS_values_persisted_temp,{ADDRESS},{ADDRESS_values_persisted_temp},ADDRESSValuesIndexKeyName(version));

EXPORT ADDRESS_values_persisted := ADDRESS_values_index;
SALT37.MAC_Field_Nulls(ADDRESS_values_persisted,Layout_Specificities.ADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDRESS_nulls := nv;
SALT37.MAC_Field_Bfoul(ADDRESS_deduped,ADDRESS,DID,ADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDRESS_switch := bf;
EXPORT ADDRESS_max := MAX(ADDRESS_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ADDRESS_values_persisted,ADDRESS,ADDRESS_nulls,ol) // Compute column level specificity
EXPORT ADDRESS_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT FULLNAMEValuesIndexKeyName(STRING Version) := Filenames.spec_FULLNAME_LF(version);
EXPORT FULLNAMEValuesIndexKeyNameSuper := CASE(Config.Superfile_Name, 'full' => Filenames.spec_FULLNAME_Full_SF.current,'qa' => Filenames.spec_FULLNAME_QA_SF.current, Filenames.spec_FULLNAME_SF.current);

 
/*HACK-O-MATIC*/ EXPORT FULLNAME_values_index := INDEX(FULLNAME_values_persisted_temp,{FULLNAME},{FULLNAME_values_persisted_temp},FULLNAMEValuesIndexKeyNameSuper);
EXPORT FULLNAME_values_index_Logical(STRING version) := INDEX(FULLNAME_values_persisted_temp,{FULLNAME},{FULLNAME_values_persisted_temp},FULLNAMEValuesIndexKeyName(version));

EXPORT FULLNAME_values_persisted := FULLNAME_values_index;
SALT37.MAC_Field_Nulls(FULLNAME_values_persisted,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FULLNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,DID,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FULLNAME_switch := bf;
EXPORT FULLNAME_max := MAX(FULLNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(FULLNAME_values_persisted,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
EXPORT FULLNAME_specificity := ol;
 
/*HACK-O-MATIC*/ EXPORT BuildFields(STRING version) := PARALLEL(BUILDINDEX(SSN_values_index_logical(version), OVERWRITE),BUILDINDEX(DOB_year_values_index_logical(version), OVERWRITE),BUILDINDEX(DOB_month_values_index_logical(version), OVERWRITE),BUILDINDEX(DOB_day_values_index_logical(version), OVERWRITE),BUILDINDEX(DL_NBR_values_index_logical(version), OVERWRITE),BUILDINDEX(SNAME_values_index_logical(version), OVERWRITE),BUILDINDEX(FNAME_values_index_logical(version), OVERWRITE),BUILDINDEX(MNAME_values_index_logical(version), OVERWRITE),BUILDINDEX(LNAME_values_index_logical(version), OVERWRITE),BUILDINDEX(GENDER_values_index_logical(version), OVERWRITE),BUILDINDEX(DERIVED_GENDER_values_index_logical(version), OVERWRITE),BUILDINDEX(PRIM_NAME_values_index_logical(version), OVERWRITE),BUILDINDEX(PRIM_RANGE_values_index_logical(version), OVERWRITE),BUILDINDEX(SEC_RANGE_values_index_logical(version), OVERWRITE),BUILDINDEX(CITY_values_index_logical(version), OVERWRITE),BUILDINDEX(ST_values_index_logical(version), OVERWRITE),BUILDINDEX(ZIP_values_index_logical(version), OVERWRITE),BUILDINDEX(POLICY_NUMBER_values_index_logical(version), OVERWRITE),BUILDINDEX(CLAIM_NUMBER_values_index_logical(version), OVERWRITE),BUILDINDEX(DT_FIRST_SEEN_values_index_logical(version), OVERWRITE),BUILDINDEX(DT_LAST_SEEN_values_index_logical(version), OVERWRITE),BUILDINDEX(MAINNAME_values_index_logical(version), OVERWRITE),BUILDINDEX(ADDR1_values_index_logical(version), OVERWRITE),BUILDINDEX(LOCALE_values_index_logical(version), OVERWRITE),BUILDINDEX(ADDRESS_values_index_logical(version), OVERWRITE),BUILDINDEX(FULLNAME_values_index_logical(version), OVERWRITE));
/*HACK-O-MATIC*/ EXPORT BuildAll(STRING version) := BuildFields(version);
 
/*HACK-O-MATIC*/ EXPORT SpecIndexKeyName(STRING version) := Filenames.spec_SPECIFICITIES_LF(version);
EXPORT SpecIndexKeyNameSuper := Filenames.spec_SPECIFICITIES_SF.current;
SHARED iSpecificities := DATASET([{0,SSN_specificity,SSN_switch,SSN_max,SSN_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,DL_NBR_specificity,DL_NBR_switch,DL_NBR_max,DL_NBR_nulls,SNAME_specificity,SNAME_switch,SNAME_max,SNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,GENDER_specificity,GENDER_switch,GENDER_max,GENDER_nulls,DERIVED_GENDER_specificity,DERIVED_GENDER_switch,DERIVED_GENDER_max,DERIVED_GENDER_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,CITY_specificity,CITY_switch,CITY_max,CITY_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,POLICY_NUMBER_specificity,POLICY_NUMBER_switch,POLICY_NUMBER_max,POLICY_NUMBER_nulls,CLAIM_NUMBER_specificity,CLAIM_NUMBER_switch,CLAIM_NUMBER_max,CLAIM_NUMBER_nulls,DT_FIRST_SEEN_specificity,DT_FIRST_SEEN_switch,DT_FIRST_SEEN_max,DT_FIRST_SEEN_nulls,DT_LAST_SEEN_specificity,DT_LAST_SEEN_switch,DT_LAST_SEEN_max,DT_LAST_SEEN_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_max,ADDR1_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRESS_specificity,ADDRESS_switch,ADDRESS_max,ADDRESS_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls}],Layout_Specificities.R);
 
/*HACK-O-MATIC*/ EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyNameSuper);
EXPORT Specificities_Index_Logical(STRING version) := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName(version));
/*HACK-O-MATIC*/ EXPORT BuildSpec(STRING version) := BUILDINDEX(Specificities_Index_Logical(version), OVERWRITE, FEW);
/*HACK-O-MATIC*/ EXPORT Build(STRING version) := SEQUENTIAL ( BuildAll(version), BUILDINDEX(Specificities_Index_Logical(version), OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 SSN_shift0 := ROUND(Specificities[1].SSN_specificity - 28);
  integer2 SSN_switch_shift0 := ROUND(1000*Specificities[1].SSN_switch - 100);
  integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 15);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 DL_NBR_shift0 := ROUND(Specificities[1].DL_NBR_specificity - 26);
  integer2 DL_NBR_switch_shift0 := ROUND(1000*Specificities[1].DL_NBR_switch - 201);
  integer1 SNAME_shift0 := ROUND(Specificities[1].SNAME_specificity - 2);
  integer2 SNAME_switch_shift0 := ROUND(1000*Specificities[1].SNAME_switch - 7);
  integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 9);
  integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 130);
  integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 6);
  integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 137);
  integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 11);
  integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 221);
  integer1 GENDER_shift0 := ROUND(Specificities[1].GENDER_specificity - 1);
  integer2 GENDER_switch_shift0 := ROUND(1000*Specificities[1].GENDER_switch - 5);
  integer1 DERIVED_GENDER_shift0 := ROUND(Specificities[1].DERIVED_GENDER_specificity - 1);
  integer2 DERIVED_GENDER_switch_shift0 := ROUND(1000*Specificities[1].DERIVED_GENDER_switch - 0);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 12);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 534);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 11);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 523);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 8);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 481);
  integer1 CITY_shift0 := ROUND(Specificities[1].CITY_specificity - 10);
  integer2 CITY_switch_shift0 := ROUND(1000*Specificities[1].CITY_switch - 406);
  integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 5);
  integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 177);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 14);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 463);
  integer1 POLICY_NUMBER_shift0 := ROUND(Specificities[1].POLICY_NUMBER_specificity - 28);
  integer2 POLICY_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].POLICY_NUMBER_switch - 704);
  integer1 CLAIM_NUMBER_shift0 := ROUND(Specificities[1].CLAIM_NUMBER_specificity - 28);
  integer2 CLAIM_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].CLAIM_NUMBER_switch - 556);
  /*integer1 DT_FIRST_SEEN_shift0 := ROUND(Specificities[1].DT_FIRST_SEEN_specificity - 0);
  integer2 DT_FIRST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_FIRST_SEEN_switch - 0);
  integer1 DT_LAST_SEEN_shift0 := ROUND(Specificities[1].DT_LAST_SEEN_specificity - 0);
  integer2 DT_LAST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_LAST_SEEN_switch - 0);*/
  integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 18);
  integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 366);
  integer1 ADDR1_shift0 := ROUND(Specificities[1].ADDR1_specificity - 18);
  integer2 ADDR1_switch_shift0 := ROUND(1000*Specificities[1].ADDR1_switch - 576);
  integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 14);
  integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 481);
  integer1 ADDRESS_shift0 := ROUND(Specificities[1].ADDRESS_specificity - 30);
  integer2 ADDRESS_switch_shift0 := ROUND(1000*Specificities[1].ADDRESS_switch - 601);
  integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 22);
  integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 529);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT37.MAC_Specificity_Values(SSN_values_persisted,SSN,'SSN',SSN_specificity,SSN_specificity_profile);
  SALT37.MAC_Specificity_Values(DL_NBR_values_persisted,DL_NBR,'DL_NBR',DL_NBR_specificity,DL_NBR_specificity_profile);
  SALT37.MAC_Specificity_Values(SNAME_values_persisted,SNAME,'SNAME',SNAME_specificity,SNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(FNAME_values_persisted,FNAME,'FNAME',FNAME_specificity,FNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(MNAME_values_persisted,MNAME,'MNAME',MNAME_specificity,MNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(LNAME_values_persisted,LNAME,'LNAME',LNAME_specificity,LNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(GENDER_values_persisted,GENDER,'GENDER',GENDER_specificity,GENDER_specificity_profile);
  SALT37.MAC_Specificity_Values(DERIVED_GENDER_values_persisted,DERIVED_GENDER,'DERIVED_GENDER',DERIVED_GENDER_specificity,DERIVED_GENDER_specificity_profile);
  SALT37.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
  SALT37.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
  SALT37.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
  SALT37.MAC_Specificity_Values(CITY_values_persisted,CITY,'CITY',CITY_specificity,CITY_specificity_profile);
  SALT37.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
  SALT37.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
  SALT37.MAC_Specificity_Values(POLICY_NUMBER_values_persisted,POLICY_NUMBER,'POLICY_NUMBER',POLICY_NUMBER_specificity,POLICY_NUMBER_specificity_profile);
  SALT37.MAC_Specificity_Values(CLAIM_NUMBER_values_persisted,CLAIM_NUMBER,'CLAIM_NUMBER',CLAIM_NUMBER_specificity,CLAIM_NUMBER_specificity_profile);
EXPORT AllProfiles := SSN_specificity_profile + DL_NBR_specificity_profile + SNAME_specificity_profile + FNAME_specificity_profile + MNAME_specificity_profile + LNAME_specificity_profile + GENDER_specificity_profile + DERIVED_GENDER_specificity_profile + PRIM_NAME_specificity_profile + PRIM_RANGE_specificity_profile + SEC_RANGE_specificity_profile + CITY_specificity_profile + ST_specificity_profile + ZIP_specificity_profile + POLICY_NUMBER_specificity_profile + CLAIM_NUMBER_specificity_profile;
END;
 
