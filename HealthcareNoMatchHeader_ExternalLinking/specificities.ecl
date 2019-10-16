IMPORT SALT311,STD,HealthcareNoMatchHeader_InternalLinking;
EXPORT specificities(DATASET(layout_HEADER) ih) := MODULE
 
EXPORT ih_init := SALT311.initNullIDs.baseLevel(ih,RID,nomatch_id);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT311.UIDType nomatch_id := h.nomatch_id; // using existing id field
  h.RID;//RIDfield 
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))Fields.Make_SRC((SALT311.StrType)h.SRC ); // Cleans before using
  TYPEOF(h.SSN) SSN := (TYPEOF(h.SSN))Fields.Make_SSN((SALT311.StrType)h.SSN ); // Cleans before using
  UNSIGNED1 SSN_len := 0;  // Place holder filled in by project
  TYPEOF(h.DOB) DOB := (TYPEOF(h.DOB))Fields.Make_DOB((SALT311.StrType)h.DOB ); // Cleans before using
  UNSIGNED2 DOB_year := ((UNSIGNED)h.DOB) DIV 10000;
  UNSIGNED1 DOB_month := (((UNSIGNED)h.DOB) DIV 100 ) % 100;
  UNSIGNED1 DOB_day := ((UNSIGNED)h.DOB) % 100;
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))Fields.Make_LEXID((SALT311.StrType)h.LEXID ); // Cleans before using
  TYPEOF(h.SUFFIX) SUFFIX := (TYPEOF(h.SUFFIX))Fields.Make_SUFFIX((SALT311.StrType)h.SUFFIX ); // Cleans before using
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))Fields.Make_FNAME((SALT311.StrType)h.FNAME ); // Cleans before using
  UNSIGNED1 FNAME_len := 0;  // Place holder filled in by project
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))Fields.Make_MNAME((SALT311.StrType)h.MNAME ); // Cleans before using
  UNSIGNED1 MNAME_len := 0;  // Place holder filled in by project
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))Fields.Make_LNAME((SALT311.StrType)h.LNAME ); // Cleans before using
  UNSIGNED1 LNAME_len := 0;  // Place holder filled in by project
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))Fields.Make_GENDER((SALT311.StrType)h.GENDER ); // Cleans before using
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT311.StrType)h.PRIM_NAME ); // Cleans before using
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT311.StrType)h.PRIM_RANGE ); // Cleans before using
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT311.StrType)h.SEC_RANGE ); // Cleans before using
  TYPEOF(h.CITY_NAME) CITY_NAME := (TYPEOF(h.CITY_NAME))Fields.Make_CITY_NAME((SALT311.StrType)h.CITY_NAME ); // Cleans before using
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))Fields.Make_ST((SALT311.StrType)h.ST ); // Cleans before using
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))Fields.Make_ZIP((SALT311.StrType)h.ZIP ); // Cleans before using
  UNSIGNED4 DT_FIRST_SEEN := (UNSIGNED4)Fields.Make_DT_FIRST_SEEN((SALT311.StrType)h.DT_FIRST_SEEN ); // Cleans before using
  UNSIGNED4 DT_LAST_SEEN := (UNSIGNED4)Fields.Make_DT_LAST_SEEN((SALT311.StrType)h.DT_LAST_SEEN ); // Cleans before using
  UNSIGNED4 MAINNAME := 0; // Place holder filled in by project
  UNSIGNED4 ADDR1 := 0; // Place holder filled in by project
  UNSIGNED4 LOCALE := 0; // Place holder filled in by project
  UNSIGNED4 ADDRESS := 0; // Place holder filled in by project
  UNSIGNED4 FULLNAME := 0; // Place holder filled in by project
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(nomatch_id<>0),r),HASH(nomatch_id)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.SSN_len := LENGTH(TRIM((SALT311.StrType)le.SSN));
  SELF.FNAME_len := LENGTH(TRIM((SALT311.StrType)le.FNAME));
  SELF.MNAME_len := LENGTH(TRIM((SALT311.StrType)le.MNAME));
  SELF.LNAME_len := LENGTH(TRIM((SALT311.StrType)le.LNAME));
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME)>0,0,HASH32((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME)>0,0,HASH32((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)>0,0,HASH32((SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)>0,0,HASH32((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.SUFFIX)>0,0,HASH32((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.SUFFIX)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::Specificities_Cache',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
//We have nomatch_id specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.nomatch_id;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,nomatch_id,LOCAL) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::Cluster_Sizes',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  SSN_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,SSN) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::SSN',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(SSN_deduped,SSN,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,SSN,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT SSN_values_persisted_temp := distance_computed : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::SSN',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  DOB_year_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,DOB_year) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::DOB_year',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_year_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::DOB_year',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  DOB_month_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,DOB_month) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::DOB_month',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_month_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::DOB_month',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  DOB_day_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,DOB_day) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::DOB_day',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_day_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::DOB_day',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  LEXID_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,LEXID) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::LEXID',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(LEXID_deduped,LEXID,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LEXID_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::LEXID',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  SUFFIX_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,SUFFIX) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::SUFFIX',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(SUFFIX_deduped,SUFFIX,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SUFFIX_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::SUFFIX',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  FNAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,FNAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::FNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.MAC_Field_Variants_Initials(FNAME_deduped,nomatch_id,FNAME,expanded) // expand out all variants of initial
  SALT311.Mac_Field_Count_UID(expanded,FNAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 FNAME_PreferredName := HealthcareNoMatchHeader_InternalLinking.fn_PreferredName(counted.FNAME); // Compute fn_PreferredName value for FNAME
  end;
  with_id := table(counted,r1);
  SALT311.MAC_Field_Accumulate_Counts(with_id,FNAME_PreferredName,PreferredName_cnt,fuzzies_counted0)
  SALT311.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,FNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT311.MAC_Field_Initial_Specificities(distance_computed,FNAME,initial_specs_added) // add initial char specificities
EXPORT FNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::FNAME_temp',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  MNAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,MNAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::MNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.MAC_Field_Variants_Initials(MNAME_deduped,nomatch_id,MNAME,expanded) // expand out all variants of initial
  SALT311.Mac_Field_Count_UID(expanded,MNAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,MNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT311.MAC_Field_Initial_Specificities(distance_computed,MNAME,initial_specs_added) // add initial char specificities
EXPORT MNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::MNAME_temp',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  LNAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,LNAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::LNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(LNAME_deduped,nomatch_id,LNAME,2); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,LNAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,LNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT311.MAC_Field_Initial_Specificities(distance_computed,LNAME,initial_specs_added) // add initial char specificities
EXPORT LNAME_values_persisted_temp := initial_specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::LNAME_temp',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  GENDER_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,GENDER) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::GENDER',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(GENDER_deduped,GENDER,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT GENDER_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::GENDER',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  PRIM_NAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,PRIM_NAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::PRIM_NAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_NAME_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::PRIM_NAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  PRIM_RANGE_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,PRIM_RANGE) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::PRIM_RANGE',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_RANGE_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::PRIM_RANGE',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  SEC_RANGE_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,SEC_RANGE) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::SEC_RANGE',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,nomatch_id,SEC_RANGE,2); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,SEC_RANGE,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEC_RANGE_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::SEC_RANGE',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  CITY_NAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,CITY_NAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::CITY_NAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(CITY_NAME_deduped,CITY_NAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CITY_NAME_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::CITY_NAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  ST_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,ST) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::ST',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ST_deduped,ST,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::ST',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  ZIP_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,ZIP) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::ZIP',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ZIP_deduped,ZIP,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::ZIP',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  DT_FIRST_SEEN_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,DT_FIRST_SEEN) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::DT_FIRST_SEEN',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_FIRST_SEEN_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::DT_FIRST_SEEN',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  DT_LAST_SEEN_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,DT_LAST_SEEN) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::DT_LAST_SEEN',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(DT_LAST_SEEN_deduped,DT_LAST_SEEN,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_LAST_SEEN_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::DT_LAST_SEEN',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  MAINNAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,MAINNAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::MAINNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MAINNAME_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::MAINNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  ADDR1_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,ADDR1) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::ADDR1',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ADDR1_deduped,ADDR1,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDR1_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::ADDR1',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  LOCALE_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,LOCALE) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::LOCALE',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LOCALE_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::LOCALE',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  ADDRESS_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,ADDRESS) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::ADDRESS',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ADDRESS_deduped,ADDRESS,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDRESS_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::ADDRESS',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT  FULLNAME_deduped := SALT311.MAC_Field_By_UID(input_file,nomatch_id,FULLNAME) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::FULLNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,nomatch_id,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FULLNAME_values_persisted_temp := specs_added : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::FULLNAME',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT SSNValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::SSN';
 
EXPORT SSN_values_index := INDEX(SSN_values_persisted_temp,{SSN},{SSN_values_persisted_temp},SSNValuesIndexKeyName);
EXPORT SSN_values_persisted := SSN_values_index;
SALT311.MAC_Field_Nulls(SSN_values_persisted_temp,Layout_Specificities.SSN_ChildRec,nv) // Use automated NULL spotting
EXPORT SSN_nulls := nv;
SALT311.MAC_Field_Bfoul(SSN_deduped,SSN,nomatch_id,SSN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SSN_switch := bf;
EXPORT SSN_max := MAX(SSN_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(SSN_values_persisted_temp,SSN,SSN_nulls,ol) // Compute column level specificity
EXPORT SSN_specificity := ol;
 
EXPORT DOB_yearValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::DOB_year';
 
EXPORT DOB_year_values_index := INDEX(DOB_year_values_persisted_temp,{DOB_year},{DOB_year_values_persisted_temp},DOB_yearValuesIndexKeyName);
EXPORT DOB_year_values_persisted := DOB_year_values_index;
SALT311.MAC_Field_Nulls(DOB_year_values_persisted_temp,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_year_nulls := nv;
SALT311.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,nomatch_id,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_year_switch := bf;
EXPORT DOB_year_max := MAX(DOB_year_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(DOB_year_values_persisted_temp,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
EXPORT DOB_year_specificity := ol;
 
EXPORT DOB_monthValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::DOB_month';
 
EXPORT DOB_month_values_index := INDEX(DOB_month_values_persisted_temp,{DOB_month},{DOB_month_values_persisted_temp},DOB_monthValuesIndexKeyName);
EXPORT DOB_month_values_persisted := DOB_month_values_index;
SALT311.MAC_Field_Nulls(DOB_month_values_persisted_temp,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_month_nulls := nv;
SALT311.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,nomatch_id,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_month_switch := bf;
EXPORT DOB_month_max := MAX(DOB_month_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(DOB_month_values_persisted_temp,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
EXPORT DOB_month_specificity := ol;
 
EXPORT DOB_dayValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::DOB_day';
 
EXPORT DOB_day_values_index := INDEX(DOB_day_values_persisted_temp,{DOB_day},{DOB_day_values_persisted_temp},DOB_dayValuesIndexKeyName);
EXPORT DOB_day_values_persisted := DOB_day_values_index;
SALT311.MAC_Field_Nulls(DOB_day_values_persisted_temp,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_day_nulls := nv;
SALT311.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,nomatch_id,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_day_switch := bf;
EXPORT DOB_day_max := MAX(DOB_day_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(DOB_day_values_persisted_temp,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
EXPORT DOB_day_specificity := ol;
 
EXPORT LEXIDValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::LEXID';
 
EXPORT LEXID_values_index := INDEX(LEXID_values_persisted_temp,{LEXID},{LEXID_values_persisted_temp},LEXIDValuesIndexKeyName);
EXPORT LEXID_values_persisted := LEXID_values_index;
SALT311.MAC_Field_Nulls(LEXID_values_persisted_temp,Layout_Specificities.LEXID_ChildRec,nv) // Use automated NULL spotting
EXPORT LEXID_nulls := nv;
SALT311.MAC_Field_Bfoul(LEXID_deduped,LEXID,nomatch_id,LEXID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LEXID_switch := bf;
EXPORT LEXID_max := MAX(LEXID_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(LEXID_values_persisted_temp,LEXID,LEXID_nulls,ol) // Compute column level specificity
EXPORT LEXID_specificity := ol;
 
EXPORT SUFFIXValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::SUFFIX';
 
EXPORT SUFFIX_values_index := INDEX(SUFFIX_values_persisted_temp,{SUFFIX},{SUFFIX_values_persisted_temp},SUFFIXValuesIndexKeyName);
EXPORT SUFFIX_values_persisted := SUFFIX_values_index;
SALT311.MAC_Field_Nulls(SUFFIX_values_persisted_temp,Layout_Specificities.SUFFIX_ChildRec,nv) // Use automated NULL spotting
EXPORT SUFFIX_nulls := nv;
SALT311.MAC_Field_Bfoul(SUFFIX_deduped,SUFFIX,nomatch_id,SUFFIX_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SUFFIX_switch := bf;
EXPORT SUFFIX_max := MAX(SUFFIX_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(SUFFIX_values_persisted_temp,SUFFIX,SUFFIX_nulls,ol) // Compute column level specificity
EXPORT SUFFIX_specificity := ol;
SALT311.MAC_Concept3_Specificities(MAINNAME_cnt,FNAME_values_persisted_temp,FNAME,cnt,8,MNAME_values_persisted_temp,MNAME,cnt,8,LNAME_values_persisted_temp,LNAME,cnt,8,ofile)
SALT311.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,FNAME,e2_cnt,8,MNAME_values_persisted_temp,MNAME,e2_cnt,8,LNAME_values_persisted_temp,LNAME,e2_cnt,8,ofile_wfuzzy)
SHARED FNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
EXPORT FNAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::FNAME';
 
EXPORT FNAME_values_index := INDEX(FNAME_values_persisted0,{FNAME},{FNAME_values_persisted0},FNAMEValuesIndexKeyName);
EXPORT FNAME_values_persisted := FNAME_values_index;
EXPORT FNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(FNAME_deduped,FNAME,nomatch_id,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FNAME_switch := bf;
EXPORT FNAME_max := MAX(FNAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(FNAME_values_persisted_temp,FNAME,FNAME_nulls,ol) // Compute column level specificity
EXPORT FNAME_specificity := ol;
SALT311.MAC_Concept3_Specificities(MAINNAME_cnt,MNAME_values_persisted_temp,MNAME,cnt,6,FNAME_values_persisted_temp,FNAME,cnt,6,LNAME_values_persisted_temp,LNAME,cnt,6,ofile)
SALT311.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,MNAME,e2_cnt,6,FNAME_values_persisted_temp,FNAME,e2_cnt,6,LNAME_values_persisted_temp,LNAME,e2_cnt,6,ofile_wfuzzy)
SHARED MNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
EXPORT MNAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::MNAME';
 
EXPORT MNAME_values_index := INDEX(MNAME_values_persisted0,{MNAME},{MNAME_values_persisted0},MNAMEValuesIndexKeyName);
EXPORT MNAME_values_persisted := MNAME_values_index;
EXPORT MNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(MNAME_deduped,MNAME,nomatch_id,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MNAME_switch := bf;
EXPORT MNAME_max := MAX(MNAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(MNAME_values_persisted_temp,MNAME,MNAME_nulls,ol) // Compute column level specificity
EXPORT MNAME_specificity := ol;
SALT311.MAC_Concept3_Specificities(MAINNAME_cnt,LNAME_values_persisted_temp,LNAME,cnt,6,FNAME_values_persisted_temp,FNAME,cnt,6,MNAME_values_persisted_temp,MNAME,cnt,6,ofile)
SALT311.MAC_Concept3_Specificities(MAINNAME_fuzzy_cnt,ofile,LNAME,e2_cnt,6,FNAME_values_persisted_temp,FNAME,e2_cnt,6,MNAME_values_persisted_temp,MNAME,e2_cnt,6,ofile_wfuzzy)
SHARED LNAME_values_persisted0 := ofile_wfuzzy; // Skip over EXPORT
 
EXPORT LNAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::LNAME';
 
EXPORT LNAME_values_index := INDEX(LNAME_values_persisted0,{LNAME},{LNAME_values_persisted0},LNAMEValuesIndexKeyName);
EXPORT LNAME_values_persisted := LNAME_values_index;
EXPORT LNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.LNAME_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(LNAME_deduped,LNAME,nomatch_id,LNAME_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LNAME_switch := bf;
EXPORT LNAME_max := MAX(LNAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(LNAME_values_persisted_temp,LNAME,LNAME_nulls,ol) // Compute column level specificity
EXPORT LNAME_specificity := ol;
 
EXPORT GENDERValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::GENDER';
 
EXPORT GENDER_values_index := INDEX(GENDER_values_persisted_temp,{GENDER},{GENDER_values_persisted_temp},GENDERValuesIndexKeyName);
EXPORT GENDER_values_persisted := GENDER_values_index;
EXPORT GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.GENDER_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(GENDER_deduped,GENDER,nomatch_id,GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT GENDER_switch := bf;
EXPORT GENDER_max := MAX(GENDER_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(GENDER_values_persisted_temp,GENDER,GENDER_nulls,ol) // Compute column level specificity
EXPORT GENDER_specificity := ol;
 
EXPORT PRIM_NAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::PRIM_NAME';
 
EXPORT PRIM_NAME_values_index := INDEX(PRIM_NAME_values_persisted_temp,{PRIM_NAME},{PRIM_NAME_values_persisted_temp},PRIM_NAMEValuesIndexKeyName);
EXPORT PRIM_NAME_values_persisted := PRIM_NAME_values_index;
SALT311.MAC_Field_Nulls(PRIM_NAME_values_persisted_temp,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_NAME_nulls := nv;
SALT311.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,nomatch_id,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(PRIM_NAME_values_persisted_temp,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;
 
EXPORT PRIM_RANGEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::PRIM_RANGE';
 
EXPORT PRIM_RANGE_values_index := INDEX(PRIM_RANGE_values_persisted_temp,{PRIM_RANGE},{PRIM_RANGE_values_persisted_temp},PRIM_RANGEValuesIndexKeyName);
EXPORT PRIM_RANGE_values_persisted := PRIM_RANGE_values_index;
SALT311.MAC_Field_Nulls(PRIM_RANGE_values_persisted_temp,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT311.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,nomatch_id,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(PRIM_RANGE_values_persisted_temp,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;
 
EXPORT SEC_RANGEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::SEC_RANGE';
 
EXPORT SEC_RANGE_values_index := INDEX(SEC_RANGE_values_persisted_temp,{SEC_RANGE},{SEC_RANGE_values_persisted_temp},SEC_RANGEValuesIndexKeyName);
EXPORT SEC_RANGE_values_persisted := SEC_RANGE_values_index;
SALT311.MAC_Field_Nulls(SEC_RANGE_values_persisted_temp,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT311.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,nomatch_id,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(SEC_RANGE_values_persisted_temp,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;
 
EXPORT CITY_NAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::CITY_NAME';
 
EXPORT CITY_NAME_values_index := INDEX(CITY_NAME_values_persisted_temp,{CITY_NAME},{CITY_NAME_values_persisted_temp},CITY_NAMEValuesIndexKeyName);
EXPORT CITY_NAME_values_persisted := CITY_NAME_values_index;
SALT311.MAC_Field_Nulls(CITY_NAME_values_persisted_temp,Layout_Specificities.CITY_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT CITY_NAME_nulls := nv;
SALT311.MAC_Field_Bfoul(CITY_NAME_deduped,CITY_NAME,nomatch_id,CITY_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CITY_NAME_switch := bf;
EXPORT CITY_NAME_max := MAX(CITY_NAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(CITY_NAME_values_persisted_temp,CITY_NAME,CITY_NAME_nulls,ol) // Compute column level specificity
EXPORT CITY_NAME_specificity := ol;
 
EXPORT STValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::ST';
 
EXPORT ST_values_index := INDEX(ST_values_persisted_temp,{ST},{ST_values_persisted_temp},STValuesIndexKeyName);
EXPORT ST_values_persisted := ST_values_index;
SALT311.MAC_Field_Nulls(ST_values_persisted_temp,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT311.MAC_Field_Bfoul(ST_deduped,ST,nomatch_id,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(ST_values_persisted_temp,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;
 
EXPORT ZIPValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::ZIP';
 
EXPORT ZIP_values_index := INDEX(ZIP_values_persisted_temp,{ZIP},{ZIP_values_persisted_temp},ZIPValuesIndexKeyName);
EXPORT ZIP_values_persisted := ZIP_values_index;
SALT311.MAC_Field_Nulls(ZIP_values_persisted_temp,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT311.MAC_Field_Bfoul(ZIP_deduped,ZIP,nomatch_id,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(ZIP_values_persisted_temp,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;
 
EXPORT DT_FIRST_SEENValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::DT_FIRST_SEEN';
 
EXPORT DT_FIRST_SEEN_values_index := INDEX(DT_FIRST_SEEN_values_persisted_temp,{DT_FIRST_SEEN},{DT_FIRST_SEEN_values_persisted_temp},DT_FIRST_SEENValuesIndexKeyName);
EXPORT DT_FIRST_SEEN_values_persisted := DT_FIRST_SEEN_values_index;
SALT311.MAC_Field_Nulls(DT_FIRST_SEEN_values_persisted_temp,Layout_Specificities.DT_FIRST_SEEN_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_FIRST_SEEN_nulls := nv;
SALT311.MAC_Field_Bfoul(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,nomatch_id,DT_FIRST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_FIRST_SEEN_switch := bf;
EXPORT DT_FIRST_SEEN_max := MAX(DT_FIRST_SEEN_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(DT_FIRST_SEEN_values_persisted_temp,DT_FIRST_SEEN,DT_FIRST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_FIRST_SEEN_specificity := ol;
 
EXPORT DT_LAST_SEENValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::DT_LAST_SEEN';
 
EXPORT DT_LAST_SEEN_values_index := INDEX(DT_LAST_SEEN_values_persisted_temp,{DT_LAST_SEEN},{DT_LAST_SEEN_values_persisted_temp},DT_LAST_SEENValuesIndexKeyName);
EXPORT DT_LAST_SEEN_values_persisted := DT_LAST_SEEN_values_index;
SALT311.MAC_Field_Nulls(DT_LAST_SEEN_values_persisted_temp,Layout_Specificities.DT_LAST_SEEN_ChildRec,nv) // Use automated NULL spotting
EXPORT DT_LAST_SEEN_nulls := nv;
SALT311.MAC_Field_Bfoul(DT_LAST_SEEN_deduped,DT_LAST_SEEN,nomatch_id,DT_LAST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_LAST_SEEN_switch := bf;
EXPORT DT_LAST_SEEN_max := MAX(DT_LAST_SEEN_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(DT_LAST_SEEN_values_persisted_temp,DT_LAST_SEEN,DT_LAST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_LAST_SEEN_specificity := ol;
 
EXPORT MAINNAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::MAINNAME';
 
EXPORT MAINNAME_values_index := INDEX(MAINNAME_values_persisted_temp,{MAINNAME},{MAINNAME_values_persisted_temp},MAINNAMEValuesIndexKeyName);
EXPORT MAINNAME_values_persisted := MAINNAME_values_index;
SALT311.MAC_Field_Nulls(MAINNAME_values_persisted_temp,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT MAINNAME_nulls := nv;
SALT311.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,nomatch_id,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MAINNAME_switch := bf;
EXPORT MAINNAME_max := MAX(MAINNAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(MAINNAME_values_persisted_temp,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
EXPORT MAINNAME_specificity := ol;
 
EXPORT ADDR1ValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::ADDR1';
 
EXPORT ADDR1_values_index := INDEX(ADDR1_values_persisted_temp,{ADDR1},{ADDR1_values_persisted_temp},ADDR1ValuesIndexKeyName);
EXPORT ADDR1_values_persisted := ADDR1_values_index;
SALT311.MAC_Field_Nulls(ADDR1_values_persisted_temp,Layout_Specificities.ADDR1_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDR1_nulls := nv;
SALT311.MAC_Field_Bfoul(ADDR1_deduped,ADDR1,nomatch_id,ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDR1_switch := bf;
EXPORT ADDR1_max := MAX(ADDR1_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(ADDR1_values_persisted_temp,ADDR1,ADDR1_nulls,ol) // Compute column level specificity
EXPORT ADDR1_specificity := ol;
 
EXPORT LOCALEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::LOCALE';
 
EXPORT LOCALE_values_index := INDEX(LOCALE_values_persisted_temp,{LOCALE},{LOCALE_values_persisted_temp},LOCALEValuesIndexKeyName);
EXPORT LOCALE_values_persisted := LOCALE_values_index;
SALT311.MAC_Field_Nulls(LOCALE_values_persisted_temp,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
EXPORT LOCALE_nulls := nv;
SALT311.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,nomatch_id,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LOCALE_switch := bf;
EXPORT LOCALE_max := MAX(LOCALE_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(LOCALE_values_persisted_temp,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
EXPORT LOCALE_specificity := ol;
 
EXPORT ADDRESSValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::ADDRESS';
 
EXPORT ADDRESS_values_index := INDEX(ADDRESS_values_persisted_temp,{ADDRESS},{ADDRESS_values_persisted_temp},ADDRESSValuesIndexKeyName);
EXPORT ADDRESS_values_persisted := ADDRESS_values_index;
SALT311.MAC_Field_Nulls(ADDRESS_values_persisted_temp,Layout_Specificities.ADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDRESS_nulls := nv;
SALT311.MAC_Field_Bfoul(ADDRESS_deduped,ADDRESS,nomatch_id,ADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDRESS_switch := bf;
EXPORT ADDRESS_max := MAX(ADDRESS_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(ADDRESS_values_persisted_temp,ADDRESS,ADDRESS_nulls,ol) // Compute column level specificity
EXPORT ADDRESS_specificity := ol;
 
EXPORT FULLNAMEValuesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::FULLNAME';
 
EXPORT FULLNAME_values_index := INDEX(FULLNAME_values_persisted_temp,{FULLNAME},{FULLNAME_values_persisted_temp},FULLNAMEValuesIndexKeyName);
EXPORT FULLNAME_values_persisted := FULLNAME_values_index;
SALT311.MAC_Field_Nulls(FULLNAME_values_persisted_temp,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FULLNAME_nulls := nv;
SALT311.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,nomatch_id,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FULLNAME_switch := bf;
EXPORT FULLNAME_max := MAX(FULLNAME_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(FULLNAME_values_persisted_temp,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
EXPORT FULLNAME_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(SSN_values_index, OVERWRITE),BUILDINDEX(DOB_year_values_index, OVERWRITE),BUILDINDEX(DOB_month_values_index, OVERWRITE),BUILDINDEX(DOB_day_values_index, OVERWRITE),BUILDINDEX(LEXID_values_index, OVERWRITE),BUILDINDEX(SUFFIX_values_index, OVERWRITE),BUILDINDEX(FNAME_values_index, OVERWRITE),BUILDINDEX(MNAME_values_index, OVERWRITE),BUILDINDEX(LNAME_values_index, OVERWRITE),BUILDINDEX(GENDER_values_index, OVERWRITE),BUILDINDEX(PRIM_NAME_values_index, OVERWRITE),BUILDINDEX(PRIM_RANGE_values_index, OVERWRITE),BUILDINDEX(SEC_RANGE_values_index, OVERWRITE),BUILDINDEX(CITY_NAME_values_index, OVERWRITE),BUILDINDEX(ST_values_index, OVERWRITE),BUILDINDEX(ZIP_values_index, OVERWRITE),BUILDINDEX(DT_FIRST_SEEN_values_index, OVERWRITE),BUILDINDEX(DT_LAST_SEEN_values_index, OVERWRITE),BUILDINDEX(MAINNAME_values_index, OVERWRITE),BUILDINDEX(ADDR1_values_index, OVERWRITE),BUILDINDEX(LOCALE_values_index, OVERWRITE),BUILDINDEX(ADDRESS_values_index, OVERWRITE),BUILDINDEX(FULLNAME_values_index, OVERWRITE));
EXPORT Layout_Uber_Plus := RECORD(SALT311.Layout_Uber_Record0)
  SALT311.Str30Type word;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(input_file le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,Fields.Make_SRC((SALT311.StrType)le.SRC),Fields.Make_SSN((SALT311.StrType)le.SSN),(SALT311.StrType)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),Fields.Make_LEXID((SALT311.StrType)le.LEXID),Fields.Make_SUFFIX((SALT311.StrType)le.SUFFIX),Fields.Make_FNAME((SALT311.StrType)le.FNAME),Fields.Make_MNAME((SALT311.StrType)le.MNAME),Fields.Make_LNAME((SALT311.StrType)le.LNAME),Fields.Make_GENDER((SALT311.StrType)le.GENDER),Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME),Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE),Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE),Fields.Make_CITY_NAME((SALT311.StrType)le.CITY_NAME),Fields.Make_ST((SALT311.StrType)le.ST),Fields.Make_ZIP((SALT311.StrType)le.ZIP),'','',SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.nomatch_id;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(input_file,22,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Normal_Field(input_file,FNAME,18,nomatch_id,layout_uber_plus,nfields4194);
SALT311.MAC_Expand_Normal_Field(input_file,MNAME,18,nomatch_id,layout_uber_plus,nfields4195);
SALT311.MAC_Expand_Normal_Field(input_file,LNAME,18,nomatch_id,layout_uber_plus,nfields4196);
nfields18 := nfields4194+nfields4195+nfields4196;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,PRIM_RANGE,19,nomatch_id,layout_uber_plus,nfields4427);
SALT311.MAC_Expand_Normal_Field(input_file,SEC_RANGE,19,nomatch_id,layout_uber_plus,nfields4428);
SALT311.MAC_Expand_Normal_Field(input_file,PRIM_NAME,19,nomatch_id,layout_uber_plus,nfields4429);
nfields19 := nfields4427+nfields4428+nfields4429;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,CITY_NAME,20,nomatch_id,layout_uber_plus,nfields4660);
SALT311.MAC_Expand_Normal_Field(input_file,ST,20,nomatch_id,layout_uber_plus,nfields4661);
SALT311.MAC_Expand_Normal_Field(input_file,ZIP,20,nomatch_id,layout_uber_plus,nfields4662);
nfields20 := nfields4660+nfields4661+nfields4662;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,PRIM_RANGE,21,nomatch_id,layout_uber_plus,nfields1140069);
SALT311.MAC_Expand_Normal_Field(input_file,SEC_RANGE,21,nomatch_id,layout_uber_plus,nfields1140070);
SALT311.MAC_Expand_Normal_Field(input_file,PRIM_NAME,21,nomatch_id,layout_uber_plus,nfields1140071);
nfields4893 := nfields1140069+nfields1140070+nfields1140071;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,CITY_NAME,21,nomatch_id,layout_uber_plus,nfields1140302);
SALT311.MAC_Expand_Normal_Field(input_file,ST,21,nomatch_id,layout_uber_plus,nfields1140303);
SALT311.MAC_Expand_Normal_Field(input_file,ZIP,21,nomatch_id,layout_uber_plus,nfields1140304);
nfields4894 := nfields1140302+nfields1140303+nfields1140304;//Collect wordbags for parts of concept field
nfields21 := nfields4893+nfields4894;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,FNAME,22,nomatch_id,layout_uber_plus,nfields1194358);
SALT311.MAC_Expand_Normal_Field(input_file,MNAME,22,nomatch_id,layout_uber_plus,nfields1194359);
SALT311.MAC_Expand_Normal_Field(input_file,LNAME,22,nomatch_id,layout_uber_plus,nfields1194360);
nfields5126 := nfields1194358+nfields1194359+nfields1194360;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,SUFFIX,22,nomatch_id,layout_uber_plus,nfields5127);
nfields22 := nfields5126+nfields5127;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r + nfields18;
uber_values_deduped0 := Fn_Reduce_UBER_Local( invert_records);
// minimize otherwise required changes to the macros used by uber and specificities!
Layout_Uber_Plus_Spec := RECORD(Layout_Uber_Plus AND NOT uid)
  SALT311.UIDType nomatch_id;
END;
SHARED uber_values_deduped := PROJECT(uber_values_deduped0,TRANSFORM(Layout_Uber_Plus_Spec,SELF.nomatch_id:=LEFT.uid,SELF:=LEFT)) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::dedups::uber',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
SALT311.MAC_Specificity_Local(uber_values_deduped,word,nomatch_id,uber_nulls,Layout_Specificities.uber_ChildRec,word_specificity,word_switch,word_values)
EXPORT uber_values_persisted_temp := word_values : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::values::uber',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire));
 
EXPORT UbervaluesIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Word::Uber';
 
EXPORT uber_values_index := INDEX(uber_values_persisted_temp,{word},{uber_values_persisted_temp},UbervaluesIndexKeyName);
EXPORT Uber_values_persisted := uber_values_index;
 
EXPORT BuildUber := BUILDINDEX(uber_values_index, OVERWRITE);
SALT311.MAC_Field_Bfoul(uber_values_deduped,word,nomatch_id,uber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT uber_switch := bf;
EXPORT uber_max := MAX(uber_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(uber_values_persisted_temp,word,uber_nulls,ol) // Compute column level specificity;
EXPORT uber_specificity := ol;
EXPORT BuildAll := PARALLEL(BuildFields, BuildUber);
 
EXPORT SpecIndexKeyName := '~'+'key::HealthcareNoMatchHeader_ExternalLinking::nomatch_id::Specificities';
iSpecificities := DATASET([{0,SSN_specificity,SSN_switch,SSN_max,SSN_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,LEXID_specificity,LEXID_switch,LEXID_max,LEXID_nulls,SUFFIX_specificity,SUFFIX_switch,SUFFIX_max,SUFFIX_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,GENDER_specificity,GENDER_switch,GENDER_max,GENDER_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,CITY_NAME_specificity,CITY_NAME_switch,CITY_NAME_max,CITY_NAME_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,DT_FIRST_SEEN_specificity,DT_FIRST_SEEN_switch,DT_FIRST_SEEN_max,DT_FIRST_SEEN_nulls,DT_LAST_SEEN_specificity,DT_LAST_SEEN_switch,DT_LAST_SEEN_max,DT_LAST_SEEN_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_max,ADDR1_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRESS_specificity,ADDRESS_switch,ADDRESS_max,ADDRESS_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls,uber_specificity,uber_switch,uber_max,uber_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT BuildSpec := BUILDINDEX(Specificities_Index, OVERWRITE, FEW);
 
EXPORT Build := SEQUENTIAL(BuildAll, BuildSpec);
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 SSN_shift0 := ROUND(Specificities[1].SSN_specificity - 0);
  integer2 SSN_switch_shift0 := ROUND(1000*Specificities[1].SSN_switch - 0);
  integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 0);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 LEXID_shift0 := ROUND(Specificities[1].LEXID_specificity - 18);
  integer2 LEXID_switch_shift0 := ROUND(1000*Specificities[1].LEXID_switch - 0);
  integer1 SUFFIX_shift0 := ROUND(Specificities[1].SUFFIX_specificity - 10);
  integer2 SUFFIX_switch_shift0 := ROUND(1000*Specificities[1].SUFFIX_switch - 0);
  integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 8);
  integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 0);
  integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 14);
  integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 0);
  integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 10);
  integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 0);
  integer1 GENDER_shift0 := ROUND(Specificities[1].GENDER_specificity - 1);
  integer2 GENDER_switch_shift0 := ROUND(1000*Specificities[1].GENDER_switch - 0);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 10);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 0);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 13);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 0);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 8);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 0);
  integer1 CITY_NAME_shift0 := ROUND(Specificities[1].CITY_NAME_specificity - 6);
  integer2 CITY_NAME_switch_shift0 := ROUND(1000*Specificities[1].CITY_NAME_switch - 0);
  integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 0);
  integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 0);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 6);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 0);
  integer1 DT_FIRST_SEEN_shift0 := ROUND(Specificities[1].DT_FIRST_SEEN_specificity - 0);
  integer2 DT_FIRST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_FIRST_SEEN_switch - 0);
  integer1 DT_LAST_SEEN_shift0 := ROUND(Specificities[1].DT_LAST_SEEN_specificity - 0);
  integer2 DT_LAST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_LAST_SEEN_switch - 0);
  integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 18);
  integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 0);
  integer1 ADDR1_shift0 := ROUND(Specificities[1].ADDR1_specificity - 16);
  integer2 ADDR1_switch_shift0 := ROUND(1000*Specificities[1].ADDR1_switch - 0);
  integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 6);
  integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 0);
  integer1 ADDRESS_shift0 := ROUND(Specificities[1].ADDRESS_specificity - 16);
  integer2 ADDRESS_switch_shift0 := ROUND(1000*Specificities[1].ADDRESS_switch - 0);
  integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 18);
  integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT311.MAC_Specificity_Values(SSN_values_persisted,SSN,'SSN',SSN_specificity,SSN_specificity_profile);
  SALT311.MAC_Specificity_Values(LEXID_values_persisted,LEXID,'LEXID',LEXID_specificity,LEXID_specificity_profile);
  SALT311.MAC_Specificity_Values(SUFFIX_values_persisted,SUFFIX,'SUFFIX',SUFFIX_specificity,SUFFIX_specificity_profile);
  SALT311.MAC_Specificity_Values(FNAME_values_persisted,FNAME,'FNAME',FNAME_specificity,FNAME_specificity_profile);
  SALT311.MAC_Specificity_Values(MNAME_values_persisted,MNAME,'MNAME',MNAME_specificity,MNAME_specificity_profile);
  SALT311.MAC_Specificity_Values(LNAME_values_persisted,LNAME,'LNAME',LNAME_specificity,LNAME_specificity_profile);
  SALT311.MAC_Specificity_Values(GENDER_values_persisted,GENDER,'GENDER',GENDER_specificity,GENDER_specificity_profile);
  SALT311.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
  SALT311.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
  SALT311.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
  SALT311.MAC_Specificity_Values(CITY_NAME_values_persisted,CITY_NAME,'CITY_NAME',CITY_NAME_specificity,CITY_NAME_specificity_profile);
  SALT311.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
  SALT311.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
EXPORT AllProfiles := SSN_specificity_profile + LEXID_specificity_profile + SUFFIX_specificity_profile + FNAME_specificity_profile + MNAME_specificity_profile + LNAME_specificity_profile + GENDER_specificity_profile + PRIM_NAME_specificity_profile + PRIM_RANGE_specificity_profile + SEC_RANGE_specificity_profile + CITY_NAME_specificity_profile + ST_specificity_profile + ZIP_specificity_profile;
END;
 
