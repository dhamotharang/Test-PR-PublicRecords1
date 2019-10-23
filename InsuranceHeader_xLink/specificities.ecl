IMPORT SALT37;
EXPORT specificities(DATASET(layout_InsuranceHeader) ih) := MODULE
 
EXPORT ih_init := SALT37.initNullIDs.baseLevel(ih,RID,DID);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT37.UIDType DID := h.DID; // using existing id field
  h.RID;//RIDfield 
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))Fields.Make_SNAME((SALT37.StrType)h.SNAME ); // Cleans before using
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))Fields.Make_FNAME((SALT37.StrType)h.FNAME ); // Cleans before using
  UNSIGNED1 FNAME_len := LENGTH(TRIM((SALT37.StrType)h.FNAME));
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))Fields.Make_MNAME((SALT37.StrType)h.MNAME ); // Cleans before using
  UNSIGNED1 MNAME_len := LENGTH(TRIM((SALT37.StrType)h.MNAME));
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))Fields.Make_LNAME((SALT37.StrType)h.LNAME ); // Cleans before using
  UNSIGNED1 LNAME_len := LENGTH(TRIM((SALT37.StrType)h.LNAME));
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))Fields.Make_DERIVED_GENDER((SALT37.StrType)h.DERIVED_GENDER ); // Cleans before using
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT37.StrType)h.PRIM_RANGE ); // Cleans before using
  UNSIGNED1 PRIM_RANGE_len := LENGTH(TRIM((SALT37.StrType)h.PRIM_RANGE));
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT37.StrType)h.PRIM_NAME ); // Cleans before using
  UNSIGNED1 PRIM_NAME_len := LENGTH(TRIM((SALT37.StrType)h.PRIM_NAME));
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT37.StrType)h.SEC_RANGE ); // Cleans before using
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))Fields.Make_CITY((SALT37.StrType)h.CITY ); // Cleans before using
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))Fields.Make_ST((SALT37.StrType)h.ST ); // Cleans before using
  h.ZIP;
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))Fields.Make_SSN5((SALT37.StrType)h.SSN5 ); // Cleans before using
  UNSIGNED1 SSN5_len := LENGTH(TRIM((SALT37.StrType)h.SSN5));
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))Fields.Make_SSN4((SALT37.StrType)h.SSN4 ); // Cleans before using
  UNSIGNED1 SSN4_len := LENGTH(TRIM((SALT37.StrType)h.SSN4));
  UNSIGNED2 DOB_year := ((UNSIGNED)h.DOB) DIV 10000;
  UNSIGNED1 DOB_month := (((UNSIGNED)h.DOB) DIV 100 ) % 100;
  UNSIGNED1 DOB_day := ((UNSIGNED)h.DOB) % 100;
  h.PHONE;
  TYPEOF(h.DL_STATE) DL_STATE := (TYPEOF(h.DL_STATE))Fields.Make_DL_STATE((SALT37.StrType)h.DL_STATE ); // Cleans before using
  TYPEOF(h.DL_NBR) DL_NBR := (TYPEOF(h.DL_NBR))Fields.Make_DL_NBR((SALT37.StrType)h.DL_NBR ); // Cleans before using
  UNSIGNED1 DL_NBR_len := LENGTH(TRIM((SALT37.StrType)h.DL_NBR));
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))Fields.Make_SRC((SALT37.StrType)h.SRC ); // Cleans before using
  TYPEOF(h.SOURCE_RID) SOURCE_RID := (TYPEOF(h.SOURCE_RID))Fields.Make_SOURCE_RID((SALT37.StrType)h.SOURCE_RID ); // Cleans before using
  UNSIGNED4 DT_FIRST_SEEN := (UNSIGNED4)Fields.Make_DT_FIRST_SEEN((SALT37.StrType)h.DT_FIRST_SEEN ); // Cleans before using
  UNSIGNED4 DT_LAST_SEEN := (UNSIGNED4)Fields.Make_DT_LAST_SEEN((SALT37.StrType)h.DT_LAST_SEEN ); // Cleans before using
  UNSIGNED4 DT_EFFECTIVE_FIRST := (UNSIGNED4)Fields.Make_DT_EFFECTIVE_FIRST((SALT37.StrType)h.DT_EFFECTIVE_FIRST ); // Cleans before using
  UNSIGNED4 DT_EFFECTIVE_LAST := (UNSIGNED4)Fields.Make_DT_EFFECTIVE_LAST((SALT37.StrType)h.DT_EFFECTIVE_LAST ); // Cleans before using
  UNSIGNED4 MAINNAME := 0; // Place holder filled in by project
  UNSIGNED4 FULLNAME := 0; // Place holder filled in by project
  UNSIGNED4 ADDR1 := 0; // Place holder filled in by project
  UNSIGNED4 LOCALE := 0; // Place holder filled in by project
  UNSIGNED4 ADDRESS := 0; // Place holder filled in by project
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(DID<>0),r),HASH(DID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)>0,0,HASH32((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.SNAME)>0,0,HASH32((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.PRIM_NAME)>0,0,HASH32((SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT37.StrType)le.CITY,(SALT37.StrType)le.ST,(SALT37.StrType)le.ZIP)>0,0,HASH32((SALT37.StrType)le.CITY,(SALT37.StrType)le.ST,(SALT37.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT37.StrType)SELF.ADDR1,(SALT37.StrType)SELF.LOCALE)>0,0,HASH32((SALT37.StrType)SELF.ADDR1,(SALT37.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::DID::InsuranceHeader_xLink::Specificities_Cache',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
//We have DID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.DID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,DID,LOCAL) : PERSIST('~temp::DID::InsuranceHeader_xLink::Cluster_Sizes',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  SNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SNAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::SNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SNAME_deduped,SNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SNAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::SNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  FNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,FNAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::FNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
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
  SALT37.mac_edit_distance_pairs(specs_added,FNAME,cnt,1,true,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,FNAME,initial_specs_added) // add initial char specificities
EXPORT FNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::FNAME_temp',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  MNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,MNAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::MNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
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
EXPORT MNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::MNAME_temp',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  LNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,LNAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::LNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(LNAME_deduped,DID,LNAME,2); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,LNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,LNAME,cnt,1,true,distance_computed);//Computes specificities of fuzzy matches
EXPORT LNAME_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_xLink::values::LNAME_temp',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DERIVED_GENDER_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DERIVED_GENDER) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DERIVED_GENDER',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(DERIVED_GENDER_deduped,DID,DERIVED_GENDER,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,DERIVED_GENDER,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.MAC_Field_Initial_Specificities(specs_added,DERIVED_GENDER,initial_specs_added) // add initial char specificities
EXPORT DERIVED_GENDER_values_persisted_temp := initial_specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DERIVED_GENDER',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  PRIM_RANGE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,PRIM_RANGE) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::PRIM_RANGE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,PRIM_RANGE,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT PRIM_RANGE_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_xLink::values::PRIM_RANGE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  PRIM_NAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,PRIM_NAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::PRIM_NAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,PRIM_NAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT PRIM_NAME_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_xLink::values::PRIM_NAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  SEC_RANGE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SEC_RANGE) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::SEC_RANGE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,DID,SEC_RANGE,2); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,SEC_RANGE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEC_RANGE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::SEC_RANGE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  CITY_deduped := SALT37.MAC_Field_By_UID(input_file,DID,CITY) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::CITY',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CITY_deduped,CITY,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CITY_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::CITY',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  ST_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ST) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::ST',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ST_deduped,ST,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::ST',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  ZIP_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ZIP) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::ZIP',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ZIP_deduped,ZIP,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::ZIP',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  SSN5_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SSN5) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::SSN5',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SSN5_deduped,SSN5,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,SSN5,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT SSN5_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_xLink::values::SSN5',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  SSN4_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SSN4) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::SSN4',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SSN4_deduped,SSN4,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,SSN4,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT SSN4_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_xLink::values::SSN4',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DOB_year_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DOB_year) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DOB_year',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_year_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DOB_year',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DOB_month_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DOB_month) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DOB_month',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_month_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DOB_month',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DOB_day_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DOB_day) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DOB_day',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_day_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DOB_day',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  PHONE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,PHONE) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::PHONE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PHONE_deduped,PHONE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PHONE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::PHONE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DL_STATE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DL_STATE) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DL_STATE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DL_STATE_deduped,DL_STATE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DL_STATE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DL_STATE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DL_NBR_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DL_NBR) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DL_NBR',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DL_NBR_deduped,DL_NBR,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,DL_NBR,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT DL_NBR_values_persisted_temp := distance_computed : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DL_NBR',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  SRC_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SRC) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::SRC',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SRC_deduped,SRC,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SRC_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::SRC',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  SOURCE_RID_deduped := SALT37.MAC_Field_By_UID(input_file,DID,SOURCE_RID) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::SOURCE_RID',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SOURCE_RID_deduped,SOURCE_RID,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SOURCE_RID_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::SOURCE_RID',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DT_FIRST_SEEN_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DT_FIRST_SEEN) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DT_FIRST_SEEN',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_FIRST_SEEN_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DT_FIRST_SEEN',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DT_LAST_SEEN_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DT_LAST_SEEN) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DT_LAST_SEEN',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_LAST_SEEN_deduped,DT_LAST_SEEN,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_LAST_SEEN_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DT_LAST_SEEN',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DT_EFFECTIVE_FIRST_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DT_EFFECTIVE_FIRST) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DT_EFFECTIVE_FIRST',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_EFFECTIVE_FIRST_deduped,DT_EFFECTIVE_FIRST,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_EFFECTIVE_FIRST_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DT_EFFECTIVE_FIRST',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  DT_EFFECTIVE_LAST_deduped := SALT37.MAC_Field_By_UID(input_file,DID,DT_EFFECTIVE_LAST) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::DT_EFFECTIVE_LAST',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_EFFECTIVE_LAST_deduped,DT_EFFECTIVE_LAST,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_EFFECTIVE_LAST_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::DT_EFFECTIVE_LAST',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  MAINNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,MAINNAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::MAINNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MAINNAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::MAINNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  FULLNAME_deduped := SALT37.MAC_Field_By_UID(input_file,DID,FULLNAME) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::FULLNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FULLNAME_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::FULLNAME',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  ADDR1_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ADDR1) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::ADDR1',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ADDR1_deduped,ADDR1,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDR1_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::ADDR1',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  LOCALE_deduped := SALT37.MAC_Field_By_UID(input_file,DID,LOCALE) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::LOCALE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LOCALE_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::LOCALE',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT  ADDRESS_deduped := SALT37.MAC_Field_By_UID(input_file,DID,ADDRESS) : PERSIST('~temp::DID::InsuranceHeader_xLink::dedups::ADDRESS',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ADDRESS_deduped,ADDRESS,DID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDRESS_values_persisted_temp := specs_added : PERSIST('~temp::DID::InsuranceHeader_xLink::values::ADDRESS',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
 
EXPORT SNAMEValuesIndexKeyName := KeyNames().SNAME_spc_logical;/*SPECHACK01*/
 
EXPORT SNAMEValuesIndexKeyName_sf := KeyNames().SNAME_spc_super;/*SPECHACK02*/
 
EXPORT SNAME_values_index := INDEX(SNAME_values_persisted_temp,{SNAME},{SNAME_values_persisted_temp},SNAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT SNAME_values_persisted := SNAME_values_index;
SALT37.MAC_Field_Nulls(SNAME_values_persisted,Layout_Specificities.SNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT SNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(SNAME_deduped,SNAME,DID,SNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SNAME_switch := bf;
EXPORT SNAME_max := MAX(SNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SNAME_values_persisted,SNAME,SNAME_nulls,ol) // Compute column level specificity
EXPORT SNAME_specificity := ol;
SALT37.MAC_Concept3_Specificities(MAINNAME_cnt,FNAME_values_persisted_temp,FNAME,cnt,0,MNAME_values_persisted_temp,MNAME,cnt,0,LNAME_values_persisted_temp,LNAME,cnt,0,ofile)
SALT37.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,FNAME,e1p_cnt,0,MNAME_values_persisted_temp,MNAME,e2_cnt,0,LNAME_values_persisted_temp,LNAME,e1p_cnt,0,ofile_wfuzzy)
SHARED FNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
EXPORT FNAMEValuesIndexKeyName := KeyNames().FNAME_spc_logical;/*SPECHACK01*/
 
EXPORT FNAMEValuesIndexKeyName_sf := KeyNames().FNAME_spc_super;/*SPECHACK02*/
 
EXPORT FNAME_values_index := INDEX(FNAME_values_persisted0,{FNAME},{FNAME_values_persisted0},FNAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT FNAME_values_persisted := FNAME_values_index;
EXPORT FNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(FNAME_deduped,FNAME,DID,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FNAME_switch := bf;
EXPORT FNAME_max := MAX(FNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(FNAME_values_persisted,FNAME,FNAME_nulls,ol) // Compute column level specificity
EXPORT FNAME_specificity := ol;
SALT37.MAC_Concept3_Specificities(MAINNAME_cnt,MNAME_values_persisted_temp,MNAME,cnt,0,FNAME_values_persisted_temp,FNAME,cnt,0,LNAME_values_persisted_temp,LNAME,cnt,0,ofile)
SALT37.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,MNAME,e2_cnt,0,FNAME_values_persisted_temp,FNAME,e1p_cnt,0,LNAME_values_persisted_temp,LNAME,e1p_cnt,0,ofile_wfuzzy)
SHARED MNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
EXPORT MNAMEValuesIndexKeyName := KeyNames().MNAME_spc_logical;/*SPECHACK01*/
 
EXPORT MNAMEValuesIndexKeyName_sf := KeyNames().MNAME_spc_super;/*SPECHACK02*/
 
EXPORT MNAME_values_index := INDEX(MNAME_values_persisted0,{MNAME},{MNAME_values_persisted0},MNAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT MNAME_values_persisted := MNAME_values_index;
EXPORT MNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(MNAME_deduped,MNAME,DID,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MNAME_switch := bf;
EXPORT MNAME_max := MAX(MNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(MNAME_values_persisted,MNAME,MNAME_nulls,ol) // Compute column level specificity
EXPORT MNAME_specificity := ol;
SALT37.MAC_Concept3_Specificities(MAINNAME_cnt,LNAME_values_persisted_temp,LNAME,cnt,0,FNAME_values_persisted_temp,FNAME,cnt,0,MNAME_values_persisted_temp,MNAME,cnt,0,ofile)
SALT37.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,LNAME,e1p_cnt,0,FNAME_values_persisted_temp,FNAME,e1p_cnt,0,MNAME_values_persisted_temp,MNAME,e2_cnt,0,ofile_wfuzzy)
SHARED LNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
EXPORT LNAMEValuesIndexKeyName := KeyNames().LNAME_spc_logical;/*SPECHACK01*/
 
EXPORT LNAMEValuesIndexKeyName_sf := KeyNames().LNAME_spc_super;/*SPECHACK02*/
 
EXPORT LNAME_values_index := INDEX(LNAME_values_persisted0,{LNAME},{LNAME_values_persisted0},LNAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT LNAME_values_persisted := LNAME_values_index;
SALT37.MAC_Field_Nulls(LNAME_values_persisted,Layout_Specificities.LNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT LNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(LNAME_deduped,LNAME,DID,LNAME_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LNAME_switch := bf;
EXPORT LNAME_max := MAX(LNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LNAME_values_persisted,LNAME,LNAME_nulls,ol) // Compute column level specificity
EXPORT LNAME_specificity := ol;
 
EXPORT DERIVED_GENDERValuesIndexKeyName := KeyNames().DERIVED_GENDER_spc_logical;/*SPECHACK01*/
 
EXPORT DERIVED_GENDERValuesIndexKeyName_sf := KeyNames().DERIVED_GENDER_spc_super;/*SPECHACK02*/
 
EXPORT DERIVED_GENDER_values_index := INDEX(DERIVED_GENDER_values_persisted_temp,{DERIVED_GENDER},{DERIVED_GENDER_values_persisted_temp},DERIVED_GENDERValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DERIVED_GENDER_values_persisted := DERIVED_GENDER_values_index;
EXPORT DERIVED_GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.DERIVED_GENDER_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(DERIVED_GENDER_deduped,DERIVED_GENDER,DID,DERIVED_GENDER_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DERIVED_GENDER_switch := bf;
EXPORT DERIVED_GENDER_max := MAX(DERIVED_GENDER_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DERIVED_GENDER_values_persisted,DERIVED_GENDER,DERIVED_GENDER_nulls,ol) // Compute column level specificity
EXPORT DERIVED_GENDER_specificity := ol;
 
EXPORT PRIM_RANGEValuesIndexKeyName := KeyNames().PRIM_RANGE_spc_logical;/*SPECHACK01*/
 
EXPORT PRIM_RANGEValuesIndexKeyName_sf := KeyNames().PRIM_RANGE_spc_super;/*SPECHACK02*/
 
EXPORT PRIM_RANGE_values_index := INDEX(PRIM_RANGE_values_persisted_temp,{PRIM_RANGE},{PRIM_RANGE_values_persisted_temp},PRIM_RANGEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT PRIM_RANGE_values_persisted := PRIM_RANGE_values_index;
SALT37.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT37.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,DID,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;
 
EXPORT PRIM_NAMEValuesIndexKeyName := KeyNames().PRIM_NAME_spc_logical;/*SPECHACK01*/
 
EXPORT PRIM_NAMEValuesIndexKeyName_sf := KeyNames().PRIM_NAME_spc_super;/*SPECHACK02*/
 
EXPORT PRIM_NAME_values_index := INDEX(PRIM_NAME_values_persisted_temp,{PRIM_NAME},{PRIM_NAME_values_persisted_temp},PRIM_NAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT PRIM_NAME_values_persisted := PRIM_NAME_values_index;
SALT37.MAC_Field_Nulls(PRIM_NAME_values_persisted,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_NAME_nulls := nv;
SALT37.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,DID,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;
 
EXPORT SEC_RANGEValuesIndexKeyName := KeyNames().SEC_RANGE_spc_logical;/*SPECHACK01*/
 
EXPORT SEC_RANGEValuesIndexKeyName_sf := KeyNames().SEC_RANGE_spc_super;/*SPECHACK02*/
 
EXPORT SEC_RANGE_values_index := INDEX(SEC_RANGE_values_persisted_temp,{SEC_RANGE},{SEC_RANGE_values_persisted_temp},SEC_RANGEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT SEC_RANGE_values_persisted := SEC_RANGE_values_index;
SALT37.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT37.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,DID,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;
 
EXPORT CITYValuesIndexKeyName := KeyNames().CITY_spc_logical;/*SPECHACK01*/
 
EXPORT CITYValuesIndexKeyName_sf := KeyNames().CITY_spc_super;/*SPECHACK02*/
 
EXPORT CITY_values_index := INDEX(CITY_values_persisted_temp,{CITY},{CITY_values_persisted_temp},CITYValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT CITY_values_persisted := CITY_values_index;
SALT37.MAC_Field_Nulls(CITY_values_persisted,Layout_Specificities.CITY_ChildRec,nv) // Use automated NULL spotting
EXPORT CITY_nulls := nv;
SALT37.MAC_Field_Bfoul(CITY_deduped,CITY,DID,CITY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CITY_switch := bf;
EXPORT CITY_max := MAX(CITY_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CITY_values_persisted,CITY,CITY_nulls,ol) // Compute column level specificity
EXPORT CITY_specificity := ol;
 
EXPORT STValuesIndexKeyName := KeyNames().ST_spc_logical;/*SPECHACK01*/
 
EXPORT STValuesIndexKeyName_sf := KeyNames().ST_spc_super;/*SPECHACK02*/
 
EXPORT ST_values_index := INDEX(ST_values_persisted_temp,{ST},{ST_values_persisted_temp},STValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT ST_values_persisted := ST_values_index;
SALT37.MAC_Field_Nulls(ST_values_persisted,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT37.MAC_Field_Bfoul(ST_deduped,ST,DID,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ST_values_persisted,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;
 
EXPORT ZIPValuesIndexKeyName := KeyNames().ZIP_spc_logical;/*SPECHACK01*/
 
EXPORT ZIPValuesIndexKeyName_sf := KeyNames().ZIP_spc_super;/*SPECHACK02*/
 
EXPORT ZIP_values_index := INDEX(ZIP_values_persisted_temp,{ZIP},{ZIP_values_persisted_temp},ZIPValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT ZIP_values_persisted := ZIP_values_index;
SALT37.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT37.MAC_Field_Bfoul(ZIP_deduped,ZIP,DID,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;
 
EXPORT SSN5ValuesIndexKeyName := KeyNames().SSN5_spc_logical;/*SPECHACK01*/
 
EXPORT SSN5ValuesIndexKeyName_sf := KeyNames().SSN5_spc_super;/*SPECHACK02*/
 
EXPORT SSN5_values_index := INDEX(SSN5_values_persisted_temp,{SSN5},{SSN5_values_persisted_temp},SSN5ValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT SSN5_values_persisted := SSN5_values_index;
SALT37.MAC_Field_Nulls(SSN5_values_persisted,Layout_Specificities.SSN5_ChildRec,nv) // Use automated NULL spotting
EXPORT SSN5_nulls := nv;
SALT37.MAC_Field_Bfoul(SSN5_deduped,SSN5,DID,SSN5_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SSN5_switch := bf;
EXPORT SSN5_max := MAX(SSN5_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SSN5_values_persisted,SSN5,SSN5_nulls,ol) // Compute column level specificity
EXPORT SSN5_specificity := ol;
 
EXPORT SSN4ValuesIndexKeyName := KeyNames().SSN4_spc_logical;/*SPECHACK01*/
 
EXPORT SSN4ValuesIndexKeyName_sf := KeyNames().SSN4_spc_super;/*SPECHACK02*/
 
EXPORT SSN4_values_index := INDEX(SSN4_values_persisted_temp,{SSN4},{SSN4_values_persisted_temp},SSN4ValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT SSN4_values_persisted := SSN4_values_index;
SALT37.MAC_Field_Nulls(SSN4_values_persisted,Layout_Specificities.SSN4_ChildRec,nv) // Use automated NULL spotting
EXPORT SSN4_nulls := nv;
SALT37.MAC_Field_Bfoul(SSN4_deduped,SSN4,DID,SSN4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SSN4_switch := bf;
EXPORT SSN4_max := MAX(SSN4_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SSN4_values_persisted,SSN4,SSN4_nulls,ol) // Compute column level specificity
EXPORT SSN4_specificity := ol;
 
EXPORT DOB_yearValuesIndexKeyName := KeyNames().DOB_year_spc_logical;/*SPECHACK01*/
 
EXPORT DOB_yearValuesIndexKeyName_sf := KeyNames().DOB_year_spc_super;/*SPECHACK02*/
 
EXPORT DOB_year_values_index := INDEX(DOB_year_values_persisted_temp,{DOB_year},{DOB_year_values_persisted_temp},DOB_yearValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DOB_year_values_persisted := DOB_year_values_index;
SALT37.MAC_Field_Nulls(DOB_year_values_persisted,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_year_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,DID,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_year_switch := bf;
EXPORT DOB_year_max := MAX(DOB_year_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_year_values_persisted,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
EXPORT DOB_year_specificity := ol;
 
EXPORT DOB_monthValuesIndexKeyName := KeyNames().DOB_month_spc_logical;/*SPECHACK01*/
 
EXPORT DOB_monthValuesIndexKeyName_sf := KeyNames().DOB_month_spc_super;/*SPECHACK02*/
 
EXPORT DOB_month_values_index := INDEX(DOB_month_values_persisted_temp,{DOB_month},{DOB_month_values_persisted_temp},DOB_monthValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DOB_month_values_persisted := DOB_month_values_index;
SALT37.MAC_Field_Nulls(DOB_month_values_persisted,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_month_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,DID,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_month_switch := bf;
EXPORT DOB_month_max := MAX(DOB_month_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_month_values_persisted,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
EXPORT DOB_month_specificity := ol;
 
EXPORT DOB_dayValuesIndexKeyName := KeyNames().DOB_day_spc_logical;/*SPECHACK01*/
 
EXPORT DOB_dayValuesIndexKeyName_sf := KeyNames().DOB_day_spc_super;/*SPECHACK02*/
 
EXPORT DOB_day_values_index := INDEX(DOB_day_values_persisted_temp,{DOB_day},{DOB_day_values_persisted_temp},DOB_dayValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DOB_day_values_persisted := DOB_day_values_index;
SALT37.MAC_Field_Nulls(DOB_day_values_persisted,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_day_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,DID,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_day_switch := bf;
EXPORT DOB_day_max := MAX(DOB_day_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_day_values_persisted,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
EXPORT DOB_day_specificity := ol;
 
EXPORT PHONEValuesIndexKeyName := KeyNames().PHONE_spc_logical;/*SPECHACK01*/
 
EXPORT PHONEValuesIndexKeyName_sf := KeyNames().PHONE_spc_super;/*SPECHACK02*/
 
EXPORT PHONE_values_index := INDEX(PHONE_values_persisted_temp,{PHONE},{PHONE_values_persisted_temp},PHONEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT PHONE_values_persisted := PHONE_values_index;
SALT37.MAC_Field_Nulls(PHONE_values_persisted,Layout_Specificities.PHONE_ChildRec,nv) // Use automated NULL spotting
EXPORT PHONE_nulls := nv;
SALT37.MAC_Field_Bfoul(PHONE_deduped,PHONE,DID,PHONE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PHONE_switch := bf;
EXPORT PHONE_max := MAX(PHONE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PHONE_values_persisted,PHONE,PHONE_nulls,ol) // Compute column level specificity
EXPORT PHONE_specificity := ol;
 
EXPORT DL_STATEValuesIndexKeyName := KeyNames().DL_STATE_spc_logical;/*SPECHACK01*/
 
EXPORT DL_STATEValuesIndexKeyName_sf := KeyNames().DL_STATE_spc_super;/*SPECHACK02*/
 
EXPORT DL_STATE_values_index := INDEX(DL_STATE_values_persisted_temp,{DL_STATE},{DL_STATE_values_persisted_temp},DL_STATEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DL_STATE_values_persisted := DL_STATE_values_index;
SALT37.MAC_Field_Nulls(DL_STATE_values_persisted,Layout_Specificities.DL_STATE_ChildRec,nv) // Use automated NULL spotting
EXPORT DL_STATE_nulls := nv;
SALT37.MAC_Field_Bfoul(DL_STATE_deduped,DL_STATE,DID,DL_STATE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DL_STATE_switch := bf;
EXPORT DL_STATE_max := MAX(DL_STATE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DL_STATE_values_persisted,DL_STATE,DL_STATE_nulls,ol) // Compute column level specificity
EXPORT DL_STATE_specificity := ol;
 
EXPORT DL_NBRValuesIndexKeyName := KeyNames().DL_NBR_spc_logical;/*SPECHACK01*/
 
EXPORT DL_NBRValuesIndexKeyName_sf := KeyNames().DL_NBR_spc_super;/*SPECHACK02*/
 
EXPORT DL_NBR_values_index := INDEX(DL_NBR_values_persisted_temp,{DL_NBR},{DL_NBR_values_persisted_temp},DL_NBRValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DL_NBR_values_persisted := DL_NBR_values_index;
SALT37.MAC_Field_Nulls(DL_NBR_values_persisted,Layout_Specificities.DL_NBR_ChildRec,nv) // Use automated NULL spotting
EXPORT DL_NBR_nulls := nv;
SALT37.MAC_Field_Bfoul(DL_NBR_deduped,DL_NBR,DID,DL_NBR_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DL_NBR_switch := bf;
EXPORT DL_NBR_max := MAX(DL_NBR_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DL_NBR_values_persisted,DL_NBR,DL_NBR_nulls,ol) // Compute column level specificity
EXPORT DL_NBR_specificity := ol;
 
EXPORT SRCValuesIndexKeyName := KeyNames().SRC_spc_logical;/*SPECHACK01*/
 
EXPORT SRCValuesIndexKeyName_sf := KeyNames().SRC_spc_super;/*SPECHACK02*/
 
EXPORT SRC_values_index := INDEX(SRC_values_persisted_temp,{SRC},{SRC_values_persisted_temp},SRCValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT SRC_values_persisted := SRC_values_index;
EXPORT SRC_nulls := DATASET([{'',0,0}],Layout_Specificities.SRC_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(SRC_deduped,SRC,DID,SRC_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SRC_switch := bf;
EXPORT SRC_max := MAX(SRC_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SRC_values_persisted,SRC,SRC_nulls,ol) // Compute column level specificity
EXPORT SRC_specificity := ol;
 
EXPORT SOURCE_RIDValuesIndexKeyName := KeyNames().SOURCE_RID_spc_logical;/*SPECHACK01*/
 
EXPORT SOURCE_RIDValuesIndexKeyName_sf := KeyNames().SOURCE_RID_spc_super;/*SPECHACK02*/
 
EXPORT SOURCE_RID_values_index := INDEX(SOURCE_RID_values_persisted_temp,{SOURCE_RID},{SOURCE_RID_values_persisted_temp},SOURCE_RIDValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT SOURCE_RID_values_persisted := SOURCE_RID_values_index;
SALT37.MAC_Field_Nulls(SOURCE_RID_values_persisted,Layout_Specificities.SOURCE_RID_ChildRec,nv) // Use automated NULL spotting
EXPORT SOURCE_RID_nulls := nv;
SALT37.MAC_Field_Bfoul(SOURCE_RID_deduped,SOURCE_RID,DID,SOURCE_RID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SOURCE_RID_switch := bf;
EXPORT SOURCE_RID_max := MAX(SOURCE_RID_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SOURCE_RID_values_persisted,SOURCE_RID,SOURCE_RID_nulls,ol) // Compute column level specificity
EXPORT SOURCE_RID_specificity := ol;
 
EXPORT DT_FIRST_SEENValuesIndexKeyName := KeyNames().DT_FIRST_SEEN_spc_logical;/*SPECHACK01*/
 
EXPORT DT_FIRST_SEENValuesIndexKeyName_sf := KeyNames().DT_FIRST_SEEN_spc_super;/*SPECHACK02*/
 
EXPORT DT_FIRST_SEEN_values_index := INDEX(DT_FIRST_SEEN_values_persisted_temp,{DT_FIRST_SEEN},{DT_FIRST_SEEN_values_persisted_temp},DT_FIRST_SEENValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DT_FIRST_SEEN_values_persisted := DT_FIRST_SEEN_values_index;
SALT37.MAC_Field_Nulls(DT_FIRST_SEEN_values_persisted,Layout_Specificities.DT_FIRST_SEEN_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_FIRST_SEEN_nulls := nv;
SALT37.MAC_Field_Bfoul(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,DID,DT_FIRST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_FIRST_SEEN_switch := bf;
EXPORT DT_FIRST_SEEN_max := MAX(DT_FIRST_SEEN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_FIRST_SEEN_values_persisted,DT_FIRST_SEEN,DT_FIRST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_FIRST_SEEN_specificity := ol;
 
EXPORT DT_LAST_SEENValuesIndexKeyName := KeyNames().DT_LAST_SEEN_spc_logical;/*SPECHACK01*/
 
EXPORT DT_LAST_SEENValuesIndexKeyName_sf := KeyNames().DT_LAST_SEEN_spc_super;/*SPECHACK02*/
 
EXPORT DT_LAST_SEEN_values_index := INDEX(DT_LAST_SEEN_values_persisted_temp,{DT_LAST_SEEN},{DT_LAST_SEEN_values_persisted_temp},DT_LAST_SEENValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DT_LAST_SEEN_values_persisted := DT_LAST_SEEN_values_index;
SALT37.MAC_Field_Nulls(DT_LAST_SEEN_values_persisted,Layout_Specificities.DT_LAST_SEEN_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_LAST_SEEN_nulls := nv;
SALT37.MAC_Field_Bfoul(DT_LAST_SEEN_deduped,DT_LAST_SEEN,DID,DT_LAST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_LAST_SEEN_switch := bf;
EXPORT DT_LAST_SEEN_max := MAX(DT_LAST_SEEN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_LAST_SEEN_values_persisted,DT_LAST_SEEN,DT_LAST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_LAST_SEEN_specificity := ol;
 
EXPORT DT_EFFECTIVE_FIRSTValuesIndexKeyName := KeyNames().DT_EFFECTIVE_FIRST_spc_logical;/*SPECHACK01*/
 
EXPORT DT_EFFECTIVE_FIRSTValuesIndexKeyName_sf := KeyNames().DT_EFFECTIVE_FIRST_spc_super;/*SPECHACK02*/
 
EXPORT DT_EFFECTIVE_FIRST_values_index := INDEX(DT_EFFECTIVE_FIRST_values_persisted_temp,{DT_EFFECTIVE_FIRST},{DT_EFFECTIVE_FIRST_values_persisted_temp},DT_EFFECTIVE_FIRSTValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DT_EFFECTIVE_FIRST_values_persisted := DT_EFFECTIVE_FIRST_values_index;
SALT37.MAC_Field_Nulls(DT_EFFECTIVE_FIRST_values_persisted,Layout_Specificities.DT_EFFECTIVE_FIRST_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_EFFECTIVE_FIRST_nulls := nv;
SALT37.MAC_Field_Bfoul(DT_EFFECTIVE_FIRST_deduped,DT_EFFECTIVE_FIRST,DID,DT_EFFECTIVE_FIRST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_EFFECTIVE_FIRST_switch := bf;
EXPORT DT_EFFECTIVE_FIRST_max := MAX(DT_EFFECTIVE_FIRST_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_EFFECTIVE_FIRST_values_persisted,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_FIRST_nulls,ol) // Compute column level specificity
EXPORT DT_EFFECTIVE_FIRST_specificity := ol;
 
EXPORT DT_EFFECTIVE_LASTValuesIndexKeyName := KeyNames().DT_EFFECTIVE_LAST_spc_logical;/*SPECHACK01*/
 
EXPORT DT_EFFECTIVE_LASTValuesIndexKeyName_sf := KeyNames().DT_EFFECTIVE_LAST_spc_super;/*SPECHACK02*/
 
EXPORT DT_EFFECTIVE_LAST_values_index := INDEX(DT_EFFECTIVE_LAST_values_persisted_temp,{DT_EFFECTIVE_LAST},{DT_EFFECTIVE_LAST_values_persisted_temp},DT_EFFECTIVE_LASTValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT DT_EFFECTIVE_LAST_values_persisted := DT_EFFECTIVE_LAST_values_index;
SALT37.MAC_Field_Nulls(DT_EFFECTIVE_LAST_values_persisted,Layout_Specificities.DT_EFFECTIVE_LAST_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_EFFECTIVE_LAST_nulls := nv;
SALT37.MAC_Field_Bfoul(DT_EFFECTIVE_LAST_deduped,DT_EFFECTIVE_LAST,DID,DT_EFFECTIVE_LAST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_EFFECTIVE_LAST_switch := bf;
EXPORT DT_EFFECTIVE_LAST_max := MAX(DT_EFFECTIVE_LAST_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_EFFECTIVE_LAST_values_persisted,DT_EFFECTIVE_LAST,DT_EFFECTIVE_LAST_nulls,ol) // Compute column level specificity
EXPORT DT_EFFECTIVE_LAST_specificity := ol;
 
EXPORT MAINNAMEValuesIndexKeyName := KeyNames().MAINNAME_spc_logical;/*SPECHACK01*/
 
EXPORT MAINNAMEValuesIndexKeyName_sf := KeyNames().MAINNAME_spc_super;/*SPECHACK02*/
 
EXPORT MAINNAME_values_index := INDEX(MAINNAME_values_persisted_temp,{MAINNAME},{MAINNAME_values_persisted_temp},MAINNAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT MAINNAME_values_persisted := MAINNAME_values_index;
SALT37.MAC_Field_Nulls(MAINNAME_values_persisted,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT MAINNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,DID,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MAINNAME_switch := bf;
EXPORT MAINNAME_max := MAX(MAINNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(MAINNAME_values_persisted,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
EXPORT MAINNAME_specificity := ol;
 
EXPORT FULLNAMEValuesIndexKeyName := KeyNames().FULLNAME_spc_logical;/*SPECHACK01*/
 
EXPORT FULLNAMEValuesIndexKeyName_sf := KeyNames().FULLNAME_spc_super;/*SPECHACK02*/
 
EXPORT FULLNAME_values_index := INDEX(FULLNAME_values_persisted_temp,{FULLNAME},{FULLNAME_values_persisted_temp},FULLNAMEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT FULLNAME_values_persisted := FULLNAME_values_index;
SALT37.MAC_Field_Nulls(FULLNAME_values_persisted,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FULLNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,DID,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FULLNAME_switch := bf;
EXPORT FULLNAME_max := MAX(FULLNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(FULLNAME_values_persisted,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
EXPORT FULLNAME_specificity := ol;
 
EXPORT ADDR1ValuesIndexKeyName := KeyNames().ADDR1_spc_logical;/*SPECHACK01*/
 
EXPORT ADDR1ValuesIndexKeyName_sf := KeyNames().ADDR1_spc_super;/*SPECHACK02*/
 
EXPORT ADDR1_values_index := INDEX(ADDR1_values_persisted_temp,{ADDR1},{ADDR1_values_persisted_temp},ADDR1ValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT ADDR1_values_persisted := ADDR1_values_index;
SALT37.MAC_Field_Nulls(ADDR1_values_persisted,Layout_Specificities.ADDR1_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDR1_nulls := nv;
SALT37.MAC_Field_Bfoul(ADDR1_deduped,ADDR1,DID,ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDR1_switch := bf;
EXPORT ADDR1_max := MAX(ADDR1_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ADDR1_values_persisted,ADDR1,ADDR1_nulls,ol) // Compute column level specificity
EXPORT ADDR1_specificity := ol;
 
EXPORT LOCALEValuesIndexKeyName := KeyNames().LOCALE_spc_logical;/*SPECHACK01*/
 
EXPORT LOCALEValuesIndexKeyName_sf := KeyNames().LOCALE_spc_super;/*SPECHACK02*/
 
EXPORT LOCALE_values_index := INDEX(LOCALE_values_persisted_temp,{LOCALE},{LOCALE_values_persisted_temp},LOCALEValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT LOCALE_values_persisted := LOCALE_values_index;
SALT37.MAC_Field_Nulls(LOCALE_values_persisted,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
EXPORT LOCALE_nulls := nv;
SALT37.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,DID,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LOCALE_switch := bf;
EXPORT LOCALE_max := MAX(LOCALE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LOCALE_values_persisted,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
EXPORT LOCALE_specificity := ol;
 
EXPORT ADDRESSValuesIndexKeyName := KeyNames().ADDRESS_spc_logical;/*SPECHACK01*/
 
EXPORT ADDRESSValuesIndexKeyName_sf := KeyNames().ADDRESS_spc_super;/*SPECHACK02*/
 
EXPORT ADDRESS_values_index := INDEX(ADDRESS_values_persisted_temp,{ADDRESS},{ADDRESS_values_persisted_temp},ADDRESSValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT ADDRESS_values_persisted := ADDRESS_values_index;
SALT37.MAC_Field_Nulls(ADDRESS_values_persisted,Layout_Specificities.ADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDRESS_nulls := nv;
SALT37.MAC_Field_Bfoul(ADDRESS_deduped,ADDRESS,DID,ADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDRESS_switch := bf;
EXPORT ADDRESS_max := MAX(ADDRESS_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ADDRESS_values_persisted,ADDRESS,ADDRESS_nulls,ol) // Compute column level specificity
EXPORT ADDRESS_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(SNAME_values_index, SNAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(FNAME_values_index, FNAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(MNAME_values_index, MNAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(LNAME_values_index, LNAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DERIVED_GENDER_values_index, DERIVED_GENDERValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(PRIM_RANGE_values_index, PRIM_RANGEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(PRIM_NAME_values_index, PRIM_NAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(SEC_RANGE_values_index, SEC_RANGEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(CITY_values_index, CITYValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(ST_values_index, STValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(ZIP_values_index, ZIPValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(SSN5_values_index, SSN5ValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(SSN4_values_index, SSN4ValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DOB_year_values_index, DOB_yearValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DOB_month_values_index, DOB_monthValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DOB_day_values_index, DOB_dayValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(PHONE_values_index, PHONEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DL_STATE_values_index, DL_STATEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DL_NBR_values_index, DL_NBRValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(SRC_values_index, SRCValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(SOURCE_RID_values_index, SOURCE_RIDValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DT_FIRST_SEEN_values_index, DT_FIRST_SEENValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DT_LAST_SEEN_values_index, DT_LAST_SEENValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DT_EFFECTIVE_FIRST_values_index, DT_EFFECTIVE_FIRSTValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(DT_EFFECTIVE_LAST_values_index, DT_EFFECTIVE_LASTValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(MAINNAME_values_index, MAINNAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(FULLNAME_values_index, FULLNAMEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(ADDR1_values_index, ADDR1ValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(LOCALE_values_index, LOCALEValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/,BUILDINDEX(ADDRESS_values_index, ADDRESSValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/);
 
  infile := Relatives;
  r := RECORD
    Config.AttrValueType Basis := TRIM((SALT37.StrType)infile.fname2) + '|' + TRIM((SALT37.StrType)infile.lname2);
    infile.fname2; // Easy way to get component values
    INTEGER2 fname2_weight100 := 0; // Easy place to store weight
    infile.lname2; // Easy way to get component values
    INTEGER2 lname2_weight100 := 0; // Easy place to store weight
    SALT37.UIDType DID := infile.DID;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED RES_attributes := DEDUP( SORT( DISTRIBUTE( t, DID ), DID, Basis, LOCAL), DID, Basis, LOCAL) : PERSIST('~temp::DID::InsuranceHeader_xLink::values::RES',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
  SALT37.Mac_Specificity_Local(RES_attributes,Basis,DID,RES_nulls,Layout_Specificities.RES_ChildRec,RES_specificity,RES_switch,RES_values);
EXPORT RES_max := MAX(RES_values,field_specificity);
 
EXPORT RESValuesIndexKeyName := KeyNames().RES_spc_logical;/*SPECHACK01*/
 
EXPORT RESValuesIndexKeyName_sf := KeyNames().RES_spc_super;/*SPECHACK02*/
  TYPEOF(RES_attributes) take(RES_attributes le,RES_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.fname2_weight100 := SELF.Basis_weight100 / 2;
    SELF.lname2_weight100 := SELF.Basis_weight100 / 2;
    SELF := le;
  END;
  non_null_atts := RES_attributes(Basis NOT IN SET(RES_nulls,Basis));
SALT37.MAC_Choose_JoinType(non_null_atts,RES_nulls,RES_values,Basis,Basis_weight100,take,RES_v);
 
EXPORT RES_values_index := INDEX(RES_v,{Basis},{RES_v},RESValuesIndexKeyName_sf/*SPECHACK03*/);
EXPORT RES_values_persisted := RES_values_index;
 
EXPORT BuildAttributes := BUILDINDEX(RES_values_index, RESValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/;
EXPORT BuildAll := PARALLEL(BuildFields, BuildAttributes);
 
EXPORT SpecIndexKeyName := KeyNames().main_spc_logical;/*SPECHACK05*/
 
EXPORT SpecIndexKeyName_sf := KeyNames().main_spc_super;/*SPECHACK06*/
iSpecificities := DATASET([{0,SNAME_specificity,SNAME_switch,SNAME_max,SNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,DERIVED_GENDER_specificity,DERIVED_GENDER_switch,DERIVED_GENDER_max,DERIVED_GENDER_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,CITY_specificity,CITY_switch,CITY_max,CITY_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,SSN5_specificity,SSN5_switch,SSN5_max,SSN5_nulls,SSN4_specificity,SSN4_switch,SSN4_max,SSN4_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,PHONE_specificity,PHONE_switch,PHONE_max,PHONE_nulls,DL_STATE_specificity,DL_STATE_switch,DL_STATE_max,DL_STATE_nulls,DL_NBR_specificity,DL_NBR_switch,DL_NBR_max,DL_NBR_nulls,SRC_specificity,SRC_switch,SRC_max,SRC_nulls,SOURCE_RID_specificity,SOURCE_RID_switch,SOURCE_RID_max,SOURCE_RID_nulls,DT_FIRST_SEEN_specificity,DT_FIRST_SEEN_switch,DT_FIRST_SEEN_max,DT_FIRST_SEEN_nulls,DT_LAST_SEEN_specificity,DT_LAST_SEEN_switch,DT_LAST_SEEN_max,DT_LAST_SEEN_nulls,DT_EFFECTIVE_FIRST_specificity,DT_EFFECTIVE_FIRST_switch,DT_EFFECTIVE_FIRST_max,DT_EFFECTIVE_FIRST_nulls,DT_EFFECTIVE_LAST_specificity,DT_EFFECTIVE_LAST_switch,DT_EFFECTIVE_LAST_max,DT_EFFECTIVE_LAST_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_max,ADDR1_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRESS_specificity,ADDRESS_switch,ADDRESS_max,ADDRESS_nulls,RES_specificity,RES_switch,RES_max,RES_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName_sf/*SPECHACK07*/);
EXPORT Build := SEQUENTIAL(BuildAll,

createUpdateSuperFile().updateFieldSpecificitiesSuperFiles,

createUpdateSuperFile().updateAttrSpecificitiesSuperFiles,

BUILDINDEX(Specificities_Index, SpecIndexKeyName, OVERWRITE, FEW),

createUpdateSuperFile().updateMainSpecificitiesSuperFiles);/*SPECHACK08*/
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 SNAME_shift0 := ROUND(Specificities[1].SNAME_specificity - 6);
  integer2 SNAME_switch_shift0 := ROUND(1000*Specificities[1].SNAME_switch - 54);
  integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 9);
  integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 263);
  integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 8);
  integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 228);
  integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 11);
  integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 383);
  integer1 DERIVED_GENDER_shift0 := ROUND(Specificities[1].DERIVED_GENDER_specificity - 1);
  integer2 DERIVED_GENDER_switch_shift0 := ROUND(1000*Specificities[1].DERIVED_GENDER_switch - 17);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 11);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 463);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 11);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 469);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 8);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 371);
  integer1 CITY_shift0 := ROUND(Specificities[1].CITY_specificity - 10);
  integer2 CITY_switch_shift0 := ROUND(1000*Specificities[1].CITY_switch - 420);
  integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 5);
  integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 310);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 14);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 0);
  integer1 SSN5_shift0 := ROUND(Specificities[1].SSN5_specificity - 15);
  integer2 SSN5_switch_shift0 := ROUND(1000*Specificities[1].SSN5_switch - 127);
  integer1 SSN4_shift0 := ROUND(Specificities[1].SSN4_specificity - 13);
  integer2 SSN4_switch_shift0 := ROUND(1000*Specificities[1].SSN4_switch - 134);
  integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 15);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 PHONE_shift0 := ROUND(Specificities[1].PHONE_specificity - 21);
  integer2 PHONE_switch_shift0 := ROUND(1000*Specificities[1].PHONE_switch - 420);
  integer1 DL_STATE_shift0 := ROUND(Specificities[1].DL_STATE_specificity - 9);
  integer2 DL_STATE_switch_shift0 := ROUND(1000*Specificities[1].DL_STATE_switch - 25);
  integer1 DL_NBR_shift0 := ROUND(Specificities[1].DL_NBR_specificity - 23);
  integer2 DL_NBR_switch_shift0 := ROUND(1000*Specificities[1].DL_NBR_switch - 124);
  integer1 SRC_shift0 := ROUND(Specificities[1].SRC_specificity - 3);
  integer2 SRC_switch_shift0 := ROUND(1000*Specificities[1].SRC_switch - 717);
  integer1 SOURCE_RID_shift0 := ROUND(Specificities[1].SOURCE_RID_specificity - 23);
  integer2 SOURCE_RID_switch_shift0 := ROUND(1000*Specificities[1].SOURCE_RID_switch - 1000);
  integer1 DT_FIRST_SEEN_shift0 := ROUND(Specificities[1].DT_FIRST_SEEN_specificity - 0);
  integer2 DT_FIRST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_FIRST_SEEN_switch - 0);
  integer1 DT_LAST_SEEN_shift0 := ROUND(Specificities[1].DT_LAST_SEEN_specificity - 0);
  integer2 DT_LAST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_LAST_SEEN_switch - 0);
  integer1 DT_EFFECTIVE_FIRST_shift0 := ROUND(Specificities[1].DT_EFFECTIVE_FIRST_specificity - 0);
  integer2 DT_EFFECTIVE_FIRST_switch_shift0 := ROUND(1000*Specificities[1].DT_EFFECTIVE_FIRST_switch - 0);
  integer1 DT_EFFECTIVE_LAST_shift0 := ROUND(Specificities[1].DT_EFFECTIVE_LAST_specificity - 0);
  integer2 DT_EFFECTIVE_LAST_switch_shift0 := ROUND(1000*Specificities[1].DT_EFFECTIVE_LAST_switch - 0);
  integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 22);
  integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 691);
  integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 22);
  integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 529);
  integer1 ADDR1_shift0 := ROUND(Specificities[1].ADDR1_specificity - 18);
  integer2 ADDR1_switch_shift0 := ROUND(1000*Specificities[1].ADDR1_switch - 576);
  integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 14);
  integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 481);
  integer1 ADDRESS_shift0 := ROUND(Specificities[1].ADDRESS_specificity - 30);
  integer2 ADDRESS_switch_shift0 := ROUND(1000*Specificities[1].ADDRESS_switch - 601);
  INTEGER1 RES_shift0 := ROUND(Specificities[1].RES_specificity - 19);
  INTEGER2 RES_switch_shift0 := ROUND(1000*Specificities[1].RES_switch - 900);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT37.MAC_Specificity_Values(SNAME_values_persisted,SNAME,'SNAME',SNAME_specificity,SNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(FNAME_values_persisted,FNAME,'FNAME',FNAME_specificity,FNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(MNAME_values_persisted,MNAME,'MNAME',MNAME_specificity,MNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(LNAME_values_persisted,LNAME,'LNAME',LNAME_specificity,LNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(DERIVED_GENDER_values_persisted,DERIVED_GENDER,'DERIVED_GENDER',DERIVED_GENDER_specificity,DERIVED_GENDER_specificity_profile);
  SALT37.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
  SALT37.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
  SALT37.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
  SALT37.MAC_Specificity_Values(CITY_values_persisted,CITY,'CITY',CITY_specificity,CITY_specificity_profile);
  SALT37.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
  SALT37.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
  SALT37.MAC_Specificity_Values(SSN5_values_persisted,SSN5,'SSN5',SSN5_specificity,SSN5_specificity_profile);
  SALT37.MAC_Specificity_Values(SSN4_values_persisted,SSN4,'SSN4',SSN4_specificity,SSN4_specificity_profile);
  SALT37.MAC_Specificity_Values(PHONE_values_persisted,PHONE,'PHONE',PHONE_specificity,PHONE_specificity_profile);
  SALT37.MAC_Specificity_Values(DL_STATE_values_persisted,DL_STATE,'DL_STATE',DL_STATE_specificity,DL_STATE_specificity_profile);
  SALT37.MAC_Specificity_Values(DL_NBR_values_persisted,DL_NBR,'DL_NBR',DL_NBR_specificity,DL_NBR_specificity_profile);
  SALT37.MAC_Specificity_Values(SRC_values_persisted,SRC,'SRC',SRC_specificity,SRC_specificity_profile);
  SALT37.MAC_Specificity_Values(SOURCE_RID_values_persisted,SOURCE_RID,'SOURCE_RID',SOURCE_RID_specificity,SOURCE_RID_specificity_profile);
EXPORT AllProfiles := SNAME_specificity_profile + FNAME_specificity_profile + MNAME_specificity_profile + LNAME_specificity_profile + DERIVED_GENDER_specificity_profile + PRIM_RANGE_specificity_profile + PRIM_NAME_specificity_profile + SEC_RANGE_specificity_profile + CITY_specificity_profile + ST_specificity_profile + ZIP_specificity_profile + SSN5_specificity_profile + SSN4_specificity_profile + PHONE_specificity_profile + DL_STATE_specificity_profile + DL_NBR_specificity_profile + SRC_specificity_profile + SOURCE_RID_specificity_profile;
END;
 
