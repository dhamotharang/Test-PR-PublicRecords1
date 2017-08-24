IMPORT SALT37;
EXPORT specificities(DATASET(layout_Classify_PS) ih) := MODULE
 
EXPORT ih_init := ih;
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT37.UIDType EID_HASH := h.EID_HASH; // using existing id field
  TYPEOF(h.NAME_SUFFIX) NAME_SUFFIX := (TYPEOF(h.NAME_SUFFIX))Fields.Make_NAME_SUFFIX((SALT37.StrType)h.NAME_SUFFIX ); // Cleans before using
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))Fields.Make_FNAME((SALT37.StrType)h.FNAME ); // Cleans before using
  UNSIGNED1 FNAME_len := LENGTH(TRIM((SALT37.StrType)h.FNAME));
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))Fields.Make_MNAME((SALT37.StrType)h.MNAME ); // Cleans before using
  UNSIGNED1 MNAME_len := LENGTH(TRIM((SALT37.StrType)h.MNAME));
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))Fields.Make_LNAME((SALT37.StrType)h.LNAME ); // Cleans before using
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT37.StrType)h.PRIM_RANGE ); // Cleans before using
  UNSIGNED1 PRIM_RANGE_len := LENGTH(TRIM((SALT37.StrType)h.PRIM_RANGE));
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT37.StrType)h.PRIM_NAME ); // Cleans before using
  UNSIGNED1 PRIM_NAME_len := LENGTH(TRIM((SALT37.StrType)h.PRIM_NAME));
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT37.StrType)h.SEC_RANGE ); // Cleans before using
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))Fields.Make_P_CITY_NAME((SALT37.StrType)h.P_CITY_NAME ); // Cleans before using
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))Fields.Make_ST((SALT37.StrType)h.ST ); // Cleans before using
  h.ZIP;
  UNSIGNED2 DOB_year := ((UNSIGNED)h.DOB) DIV 10000;
  UNSIGNED1 DOB_month := (((UNSIGNED)h.DOB) DIV 100 ) % 100;
  UNSIGNED1 DOB_day := ((UNSIGNED)h.DOB) % 100;
  h.PHONE;
  TYPEOF(h.DL_ST) DL_ST := (TYPEOF(h.DL_ST))Fields.Make_DL_ST((SALT37.StrType)h.DL_ST ); // Cleans before using
  TYPEOF(h.DL) DL := (TYPEOF(h.DL))Fields.Make_DL((SALT37.StrType)h.DL ); // Cleans before using
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))Fields.Make_LEXID((SALT37.StrType)h.LEXID ); // Cleans before using
  TYPEOF(h.POSSIBLE_SSN) POSSIBLE_SSN := (TYPEOF(h.POSSIBLE_SSN))Fields.Make_POSSIBLE_SSN((SALT37.StrType)h.POSSIBLE_SSN ); // Cleans before using
  UNSIGNED1 POSSIBLE_SSN_len := LENGTH(TRIM((SALT37.StrType)h.POSSIBLE_SSN));
  TYPEOF(h.CRIME) CRIME := (TYPEOF(h.CRIME))Fields.Make_CRIME((SALT37.StrType)h.CRIME ); // Cleans before using
  TYPEOF(h.NAME_TYPE) NAME_TYPE := (TYPEOF(h.NAME_TYPE))Fields.Make_NAME_TYPE((SALT37.StrType)h.NAME_TYPE ); // Cleans before using
  TYPEOF(h.CLEAN_GENDER) CLEAN_GENDER := (TYPEOF(h.CLEAN_GENDER))Fields.Make_CLEAN_GENDER((SALT37.StrType)h.CLEAN_GENDER ); // Cleans before using
  TYPEOF(h.CLASS_CODE) CLASS_CODE := (TYPEOF(h.CLASS_CODE))Fields.Make_CLASS_CODE((SALT37.StrType)h.CLASS_CODE ); // Cleans before using
  TYPEOF(h.DT_FIRST_SEEN) DT_FIRST_SEEN := (TYPEOF(h.DT_FIRST_SEEN))Fields.Make_DT_FIRST_SEEN((SALT37.StrType)h.DT_FIRST_SEEN ); // Cleans before using
  TYPEOF(h.DT_LAST_SEEN) DT_LAST_SEEN := (TYPEOF(h.DT_LAST_SEEN))Fields.Make_DT_LAST_SEEN((SALT37.StrType)h.DT_LAST_SEEN ); // Cleans before using
  TYPEOF(h.DATA_PROVIDER_ORI) DATA_PROVIDER_ORI := (TYPEOF(h.DATA_PROVIDER_ORI))Fields.Make_DATA_PROVIDER_ORI((SALT37.StrType)h.DATA_PROVIDER_ORI ); // Cleans before using
  TYPEOF(h.VIN) VIN := (TYPEOF(h.VIN))Fields.Make_VIN((SALT37.StrType)h.VIN ); // Cleans before using
  TYPEOF(h.PLATE) PLATE := (TYPEOF(h.PLATE))Fields.Make_PLATE((SALT37.StrType)h.PLATE ); // Cleans before using
  TYPEOF(h.LATITUDE) LATITUDE := (TYPEOF(h.LATITUDE))Fields.Make_LATITUDE((SALT37.StrType)h.LATITUDE ); // Cleans before using
  TYPEOF(h.LONGITUDE) LONGITUDE := (TYPEOF(h.LONGITUDE))Fields.Make_LONGITUDE((SALT37.StrType)h.LONGITUDE ); // Cleans before using
  TYPEOF(h.SEARCH_ADDR1) SEARCH_ADDR1 := (TYPEOF(h.SEARCH_ADDR1))Fields.Make_SEARCH_ADDR1((SALT37.StrType)h.SEARCH_ADDR1 ); // Cleans before using
  TYPEOF(h.SEARCH_ADDR2) SEARCH_ADDR2 := (TYPEOF(h.SEARCH_ADDR2))Fields.Make_SEARCH_ADDR2((SALT37.StrType)h.SEARCH_ADDR2 ); // Cleans before using
  TYPEOF(h.CLEAN_COMPANY_NAME) CLEAN_COMPANY_NAME := (TYPEOF(h.CLEAN_COMPANY_NAME))Fields.Make_CLEAN_COMPANY_NAME((SALT37.StrType)h.CLEAN_COMPANY_NAME ); // Cleans before using
  UNSIGNED4 MAINNAME := 0; // Place holder filled in by project
  UNSIGNED4 FULLNAME := 0; // Place holder filled in by project
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(EID_HASH<>0),r),HASH(EID_HASH)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)>0,0,HASH32((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.NAME_SUFFIX)>0,0,HASH32((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.NAME_SUFFIX)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::Specificities_Cache',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
//We have EID_HASH specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.EID_HASH;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,EID_HASH,LOCAL) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::Cluster_Sizes',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  NAME_SUFFIX_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,NAME_SUFFIX) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::NAME_SUFFIX',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(NAME_SUFFIX_deduped,NAME_SUFFIX,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT NAME_SUFFIX_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::NAME_SUFFIX',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  FNAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,FNAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::FNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(FNAME_deduped,EID_HASH,FNAME,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,FNAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
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
EXPORT FNAME_values_persisted := initial_specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::FNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  MNAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,MNAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::MNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(MNAME_deduped,EID_HASH,MNAME,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,MNAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,MNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,MNAME,initial_specs_added) // add initial char specificities
EXPORT MNAME_values_persisted := initial_specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::MNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  LNAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,LNAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::LNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(LNAME_deduped,LNAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED LNAME_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT37.MAC_Field_Variants_WordBag(LNAME_deduped,EID_HASH,LNAME,expanded)// expand out all variants of wordbag
  SALT37.Mac_Field_Count_UID(expanded,LNAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  SALT37.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED LNAME_ad := wb_specs_added; // Hop over export
 
EXPORT LNAMEValuesKeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::WordBag::LNAME';
 
EXPORT LNAMEValuesKeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::WordBag::LNAME';
 
EXPORT Assign_LNAMEValuesKeyNameToSuperFile := FileServices.AddSuperFile(LNAMEValuesKeyName_sf,LNAMEValuesKeyName);
 
EXPORT Clear_LNAMEValuesKeyNameSuperFile := SEQUENTIAL(FileServices.CreateSuperFile(LNAMEValuesKeyName_sf,,TRUE),FileServices.ClearSuperFile(LNAMEValuesKeyName_sf));
 
EXPORT LNAME_values_key := INDEX(LNAME_ad,{LNAME},{LNAME_ad},LNAMEValuesKeyName_sf);
  SALT37.mac_wordbag_addweights(LNAME_sa,LNAME,LNAME_ad,p);
EXPORT LNAME_values_persisted := p;
 
EXPORT  PRIM_RANGE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,PRIM_RANGE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::PRIM_RANGE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,PRIM_RANGE,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT PRIM_RANGE_values_persisted := distance_computed : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::PRIM_RANGE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  PRIM_NAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,PRIM_NAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::PRIM_NAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,PRIM_NAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT PRIM_NAME_values_persisted := distance_computed : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::PRIM_NAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  SEC_RANGE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,SEC_RANGE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::SEC_RANGE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,EID_HASH,SEC_RANGE,2); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,SEC_RANGE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEC_RANGE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::SEC_RANGE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  P_CITY_NAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,P_CITY_NAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::P_CITY_NAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(P_CITY_NAME_deduped,P_CITY_NAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT P_CITY_NAME_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::P_CITY_NAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  ST_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,ST) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::ST',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ST_deduped,ST,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::ST',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  ZIP_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,ZIP) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::ZIP',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ZIP_deduped,ZIP,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::ZIP',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DOB_year_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DOB_year) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DOB_year',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_year_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DOB_year',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DOB_month_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DOB_month) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DOB_month',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_month_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DOB_month',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DOB_day_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DOB_day) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DOB_day',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_day_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DOB_day',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  PHONE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,PHONE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::PHONE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PHONE_deduped,PHONE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PHONE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::PHONE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DL_ST_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DL_ST) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DL_ST',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DL_ST_deduped,DL_ST,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DL_ST_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DL_ST',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DL_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DL) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DL',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DL_deduped,DL,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DL_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DL',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  LEXID_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,LEXID) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::LEXID',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(LEXID_deduped,LEXID,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LEXID_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::LEXID',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  POSSIBLE_SSN_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,POSSIBLE_SSN) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::POSSIBLE_SSN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(POSSIBLE_SSN_deduped,POSSIBLE_SSN,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,POSSIBLE_SSN,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT POSSIBLE_SSN_values_persisted := distance_computed : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::POSSIBLE_SSN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  CRIME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,CRIME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::CRIME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CRIME_deduped,CRIME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CRIME_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::CRIME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  NAME_TYPE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,NAME_TYPE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::NAME_TYPE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(NAME_TYPE_deduped,NAME_TYPE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT NAME_TYPE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::NAME_TYPE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  CLEAN_GENDER_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,CLEAN_GENDER) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::CLEAN_GENDER',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CLEAN_GENDER_deduped,CLEAN_GENDER,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CLEAN_GENDER_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::CLEAN_GENDER',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  CLASS_CODE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,CLASS_CODE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::CLASS_CODE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CLASS_CODE_deduped,CLASS_CODE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CLASS_CODE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::CLASS_CODE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DT_FIRST_SEEN_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DT_FIRST_SEEN) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DT_FIRST_SEEN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_FIRST_SEEN_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DT_FIRST_SEEN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DT_LAST_SEEN_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DT_LAST_SEEN) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DT_LAST_SEEN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DT_LAST_SEEN_deduped,DT_LAST_SEEN,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DT_LAST_SEEN_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DT_LAST_SEEN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  DATA_PROVIDER_ORI_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,DATA_PROVIDER_ORI) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::DATA_PROVIDER_ORI',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(DATA_PROVIDER_ORI_deduped,DATA_PROVIDER_ORI,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DATA_PROVIDER_ORI_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::DATA_PROVIDER_ORI',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  VIN_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,VIN) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::VIN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(VIN_deduped,VIN,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT VIN_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::VIN',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  PLATE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,PLATE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::PLATE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(PLATE_deduped,PLATE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PLATE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::PLATE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  LATITUDE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,LATITUDE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::LATITUDE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(LATITUDE_deduped,LATITUDE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LATITUDE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::LATITUDE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  LONGITUDE_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,LONGITUDE) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::LONGITUDE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(LONGITUDE_deduped,LONGITUDE,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LONGITUDE_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::LONGITUDE',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  SEARCH_ADDR1_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,SEARCH_ADDR1) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::SEARCH_ADDR1',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SEARCH_ADDR1_deduped,SEARCH_ADDR1,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEARCH_ADDR1_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::SEARCH_ADDR1',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  SEARCH_ADDR2_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,SEARCH_ADDR2) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::SEARCH_ADDR2',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(SEARCH_ADDR2_deduped,SEARCH_ADDR2,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEARCH_ADDR2_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::SEARCH_ADDR2',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  CLEAN_COMPANY_NAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,CLEAN_COMPANY_NAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::CLEAN_COMPANY_NAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CLEAN_COMPANY_NAME_deduped,CLEAN_COMPANY_NAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CLEAN_COMPANY_NAME_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::CLEAN_COMPANY_NAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  MAINNAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,MAINNAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::MAINNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MAINNAME_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::MAINNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT  FULLNAME_deduped := SALT37.MAC_Field_By_UID(input_file,EID_HASH,FULLNAME) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::dedups::FULLNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,EID_HASH,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FULLNAME_values_persisted := specs_added : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::values::FULLNAME',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
 
EXPORT BuildBOWFields := BUILDINDEX(LNAME_values_key, OVERWRITE);
SALT37.MAC_Field_Nulls(NAME_SUFFIX_values_persisted,Layout_Specificities.NAME_SUFFIX_ChildRec,nv) // Use automated NULL spotting
EXPORT NAME_SUFFIX_nulls := nv;
SALT37.MAC_Field_Bfoul(NAME_SUFFIX_deduped,NAME_SUFFIX,EID_HASH,NAME_SUFFIX_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NAME_SUFFIX_switch := bf;
EXPORT NAME_SUFFIX_max := MAX(NAME_SUFFIX_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(NAME_SUFFIX_values_persisted,NAME_SUFFIX,NAME_SUFFIX_nulls,ol) // Compute column level specificity
EXPORT NAME_SUFFIX_specificity := ol;
EXPORT FNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(FNAME_deduped,FNAME,EID_HASH,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FNAME_switch := bf;
EXPORT FNAME_max := MAX(FNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(FNAME_values_persisted,FNAME,FNAME_nulls,ol) // Compute column level specificity
EXPORT FNAME_specificity := ol;
EXPORT MNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(MNAME_deduped,MNAME,EID_HASH,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MNAME_switch := bf;
EXPORT MNAME_max := MAX(MNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(MNAME_values_persisted,MNAME,MNAME_nulls,ol) // Compute column level specificity
EXPORT MNAME_specificity := ol;
EXPORT LNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.LNAME_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(LNAME_deduped,LNAME,EID_HASH,LNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LNAME_switch := bf;
EXPORT LNAME_max := MAX(LNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LNAME_values_persisted,LNAME,LNAME_nulls,ol) // Compute column level specificity
EXPORT LNAME_specificity := ol;
SALT37.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT37.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,EID_HASH,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;
SALT37.MAC_Field_Nulls(PRIM_NAME_values_persisted,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_NAME_nulls := nv;
SALT37.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,EID_HASH,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;
SALT37.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT37.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,EID_HASH,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;
SALT37.MAC_Field_Nulls(P_CITY_NAME_values_persisted,Layout_Specificities.P_CITY_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT P_CITY_NAME_nulls := nv;
SALT37.MAC_Field_Bfoul(P_CITY_NAME_deduped,P_CITY_NAME,EID_HASH,P_CITY_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT P_CITY_NAME_switch := bf;
EXPORT P_CITY_NAME_max := MAX(P_CITY_NAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(P_CITY_NAME_values_persisted,P_CITY_NAME,P_CITY_NAME_nulls,ol) // Compute column level specificity
EXPORT P_CITY_NAME_specificity := ol;
SALT37.MAC_Field_Nulls(ST_values_persisted,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT37.MAC_Field_Bfoul(ST_deduped,ST,EID_HASH,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ST_values_persisted,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;
SALT37.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT37.MAC_Field_Bfoul(ZIP_deduped,ZIP,EID_HASH,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;
SALT37.MAC_Field_Nulls(DOB_year_values_persisted,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_year_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,EID_HASH,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_year_switch := bf;
EXPORT DOB_year_max := MAX(DOB_year_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_year_values_persisted,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
EXPORT DOB_year_specificity := ol;
SALT37.MAC_Field_Nulls(DOB_month_values_persisted,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_month_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,EID_HASH,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_month_switch := bf;
EXPORT DOB_month_max := MAX(DOB_month_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_month_values_persisted,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
EXPORT DOB_month_specificity := ol;
SALT37.MAC_Field_Nulls(DOB_day_values_persisted,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_day_nulls := nv;
SALT37.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,EID_HASH,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_day_switch := bf;
EXPORT DOB_day_max := MAX(DOB_day_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DOB_day_values_persisted,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
EXPORT DOB_day_specificity := ol;
SALT37.MAC_Field_Nulls(PHONE_values_persisted,Layout_Specificities.PHONE_ChildRec,nv) // Use automated NULL spotting
EXPORT PHONE_nulls := nv;
SALT37.MAC_Field_Bfoul(PHONE_deduped,PHONE,EID_HASH,PHONE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PHONE_switch := bf;
EXPORT PHONE_max := MAX(PHONE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PHONE_values_persisted,PHONE,PHONE_nulls,ol) // Compute column level specificity
EXPORT PHONE_specificity := ol;
SALT37.MAC_Field_Nulls(DL_ST_values_persisted,Layout_Specificities.DL_ST_ChildRec,nv) // Use automated NULL spotting
EXPORT DL_ST_nulls := nv;
SALT37.MAC_Field_Bfoul(DL_ST_deduped,DL_ST,EID_HASH,DL_ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DL_ST_switch := bf;
EXPORT DL_ST_max := MAX(DL_ST_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DL_ST_values_persisted,DL_ST,DL_ST_nulls,ol) // Compute column level specificity
EXPORT DL_ST_specificity := ol;
SALT37.MAC_Field_Nulls(DL_values_persisted,Layout_Specificities.DL_ChildRec,nv) // Use automated NULL spotting
EXPORT DL_nulls := nv;
SALT37.MAC_Field_Bfoul(DL_deduped,DL,EID_HASH,DL_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DL_switch := bf;
EXPORT DL_max := MAX(DL_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DL_values_persisted,DL,DL_nulls,ol) // Compute column level specificity
EXPORT DL_specificity := ol;
SALT37.MAC_Field_Nulls(LEXID_values_persisted,Layout_Specificities.LEXID_ChildRec,nv) // Use automated NULL spotting
EXPORT LEXID_nulls := nv;
SALT37.MAC_Field_Bfoul(LEXID_deduped,LEXID,EID_HASH,LEXID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LEXID_switch := bf;
EXPORT LEXID_max := MAX(LEXID_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LEXID_values_persisted,LEXID,LEXID_nulls,ol) // Compute column level specificity
EXPORT LEXID_specificity := ol;
SALT37.MAC_Field_Nulls(POSSIBLE_SSN_values_persisted,Layout_Specificities.POSSIBLE_SSN_ChildRec,nv) // Use automated NULL spotting
EXPORT POSSIBLE_SSN_nulls := nv;
SALT37.MAC_Field_Bfoul(POSSIBLE_SSN_deduped,POSSIBLE_SSN,EID_HASH,POSSIBLE_SSN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT POSSIBLE_SSN_switch := bf;
EXPORT POSSIBLE_SSN_max := MAX(POSSIBLE_SSN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(POSSIBLE_SSN_values_persisted,POSSIBLE_SSN,POSSIBLE_SSN_nulls,ol) // Compute column level specificity
EXPORT POSSIBLE_SSN_specificity := ol;
SALT37.MAC_Field_Nulls(CRIME_values_persisted,Layout_Specificities.CRIME_ChildRec,nv) // Use automated NULL spotting
EXPORT CRIME_nulls := nv;
SALT37.MAC_Field_Bfoul(CRIME_deduped,CRIME,EID_HASH,CRIME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CRIME_switch := bf;
EXPORT CRIME_max := MAX(CRIME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CRIME_values_persisted,CRIME,CRIME_nulls,ol) // Compute column level specificity
EXPORT CRIME_specificity := ol;
SALT37.MAC_Field_Nulls(NAME_TYPE_values_persisted,Layout_Specificities.NAME_TYPE_ChildRec,nv) // Use automated NULL spotting
EXPORT NAME_TYPE_nulls := nv;
SALT37.MAC_Field_Bfoul(NAME_TYPE_deduped,NAME_TYPE,EID_HASH,NAME_TYPE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NAME_TYPE_switch := bf;
EXPORT NAME_TYPE_max := MAX(NAME_TYPE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(NAME_TYPE_values_persisted,NAME_TYPE,NAME_TYPE_nulls,ol) // Compute column level specificity
EXPORT NAME_TYPE_specificity := ol;
SALT37.MAC_Field_Nulls(CLEAN_GENDER_values_persisted,Layout_Specificities.CLEAN_GENDER_ChildRec,nv) // Use automated NULL spotting
EXPORT CLEAN_GENDER_nulls := nv;
SALT37.MAC_Field_Bfoul(CLEAN_GENDER_deduped,CLEAN_GENDER,EID_HASH,CLEAN_GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CLEAN_GENDER_switch := bf;
EXPORT CLEAN_GENDER_max := MAX(CLEAN_GENDER_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CLEAN_GENDER_values_persisted,CLEAN_GENDER,CLEAN_GENDER_nulls,ol) // Compute column level specificity
EXPORT CLEAN_GENDER_specificity := ol;
SALT37.MAC_Field_Nulls(CLASS_CODE_values_persisted,Layout_Specificities.CLASS_CODE_ChildRec,nv) // Use automated NULL spotting
EXPORT CLASS_CODE_nulls := nv;
SALT37.MAC_Field_Bfoul(CLASS_CODE_deduped,CLASS_CODE,EID_HASH,CLASS_CODE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CLASS_CODE_switch := bf;
EXPORT CLASS_CODE_max := MAX(CLASS_CODE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CLASS_CODE_values_persisted,CLASS_CODE,CLASS_CODE_nulls,ol) // Compute column level specificity
EXPORT CLASS_CODE_specificity := ol;
EXPORT DT_FIRST_SEEN_nulls := DATASET([{'',0,0}],Layout_Specificities.DT_FIRST_SEEN_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(DT_FIRST_SEEN_deduped,DT_FIRST_SEEN,EID_HASH,DT_FIRST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_FIRST_SEEN_switch := bf;
EXPORT DT_FIRST_SEEN_max := MAX(DT_FIRST_SEEN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_FIRST_SEEN_values_persisted,DT_FIRST_SEEN,DT_FIRST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_FIRST_SEEN_specificity := ol;
EXPORT DT_LAST_SEEN_nulls := DATASET([{'',0,0}],Layout_Specificities.DT_LAST_SEEN_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(DT_LAST_SEEN_deduped,DT_LAST_SEEN,EID_HASH,DT_LAST_SEEN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DT_LAST_SEEN_switch := bf;
EXPORT DT_LAST_SEEN_max := MAX(DT_LAST_SEEN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DT_LAST_SEEN_values_persisted,DT_LAST_SEEN,DT_LAST_SEEN_nulls,ol) // Compute column level specificity
EXPORT DT_LAST_SEEN_specificity := ol;
SALT37.MAC_Field_Nulls(DATA_PROVIDER_ORI_values_persisted,Layout_Specificities.DATA_PROVIDER_ORI_ChildRec,nv) // Use automated NULL spotting
EXPORT DATA_PROVIDER_ORI_nulls := nv;
SALT37.MAC_Field_Bfoul(DATA_PROVIDER_ORI_deduped,DATA_PROVIDER_ORI,EID_HASH,DATA_PROVIDER_ORI_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DATA_PROVIDER_ORI_switch := bf;
EXPORT DATA_PROVIDER_ORI_max := MAX(DATA_PROVIDER_ORI_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(DATA_PROVIDER_ORI_values_persisted,DATA_PROVIDER_ORI,DATA_PROVIDER_ORI_nulls,ol) // Compute column level specificity
EXPORT DATA_PROVIDER_ORI_specificity := ol;
SALT37.MAC_Field_Nulls(VIN_values_persisted,Layout_Specificities.VIN_ChildRec,nv) // Use automated NULL spotting
EXPORT VIN_nulls := nv;
SALT37.MAC_Field_Bfoul(VIN_deduped,VIN,EID_HASH,VIN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VIN_switch := bf;
EXPORT VIN_max := MAX(VIN_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(VIN_values_persisted,VIN,VIN_nulls,ol) // Compute column level specificity
EXPORT VIN_specificity := ol;
EXPORT PLATE_nulls := DATASET([{'',0,0}],Layout_Specificities.PLATE_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(PLATE_deduped,PLATE,EID_HASH,PLATE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PLATE_switch := bf;
EXPORT PLATE_max := MAX(PLATE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(PLATE_values_persisted,PLATE,PLATE_nulls,ol) // Compute column level specificity
EXPORT PLATE_specificity := ol;
EXPORT LATITUDE_nulls := DATASET([{'',0,0}],Layout_Specificities.LATITUDE_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(LATITUDE_deduped,LATITUDE,EID_HASH,LATITUDE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LATITUDE_switch := bf;
EXPORT LATITUDE_max := MAX(LATITUDE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LATITUDE_values_persisted,LATITUDE,LATITUDE_nulls,ol) // Compute column level specificity
EXPORT LATITUDE_specificity := ol;
EXPORT LONGITUDE_nulls := DATASET([{'',0,0}],Layout_Specificities.LONGITUDE_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(LONGITUDE_deduped,LONGITUDE,EID_HASH,LONGITUDE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LONGITUDE_switch := bf;
EXPORT LONGITUDE_max := MAX(LONGITUDE_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(LONGITUDE_values_persisted,LONGITUDE,LONGITUDE_nulls,ol) // Compute column level specificity
EXPORT LONGITUDE_specificity := ol;
SALT37.MAC_Field_Nulls(SEARCH_ADDR1_values_persisted,Layout_Specificities.SEARCH_ADDR1_ChildRec,nv) // Use automated NULL spotting
EXPORT SEARCH_ADDR1_nulls := nv;
SALT37.MAC_Field_Bfoul(SEARCH_ADDR1_deduped,SEARCH_ADDR1,EID_HASH,SEARCH_ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEARCH_ADDR1_switch := bf;
EXPORT SEARCH_ADDR1_max := MAX(SEARCH_ADDR1_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SEARCH_ADDR1_values_persisted,SEARCH_ADDR1,SEARCH_ADDR1_nulls,ol) // Compute column level specificity
EXPORT SEARCH_ADDR1_specificity := ol;
SALT37.MAC_Field_Nulls(SEARCH_ADDR2_values_persisted,Layout_Specificities.SEARCH_ADDR2_ChildRec,nv) // Use automated NULL spotting
EXPORT SEARCH_ADDR2_nulls := nv;
SALT37.MAC_Field_Bfoul(SEARCH_ADDR2_deduped,SEARCH_ADDR2,EID_HASH,SEARCH_ADDR2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEARCH_ADDR2_switch := bf;
EXPORT SEARCH_ADDR2_max := MAX(SEARCH_ADDR2_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(SEARCH_ADDR2_values_persisted,SEARCH_ADDR2,SEARCH_ADDR2_nulls,ol) // Compute column level specificity
EXPORT SEARCH_ADDR2_specificity := ol;
SALT37.MAC_Field_Nulls(CLEAN_COMPANY_NAME_values_persisted,Layout_Specificities.CLEAN_COMPANY_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT CLEAN_COMPANY_NAME_nulls := nv;
SALT37.MAC_Field_Bfoul(CLEAN_COMPANY_NAME_deduped,CLEAN_COMPANY_NAME,EID_HASH,CLEAN_COMPANY_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CLEAN_COMPANY_NAME_switch := bf;
EXPORT CLEAN_COMPANY_NAME_max := MAX(CLEAN_COMPANY_NAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CLEAN_COMPANY_NAME_values_persisted,CLEAN_COMPANY_NAME,CLEAN_COMPANY_NAME_nulls,ol) // Compute column level specificity
EXPORT CLEAN_COMPANY_NAME_specificity := ol;
SALT37.MAC_Field_Nulls(MAINNAME_values_persisted,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT MAINNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,EID_HASH,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MAINNAME_switch := bf;
EXPORT MAINNAME_max := MAX(MAINNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(MAINNAME_values_persisted,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
EXPORT MAINNAME_specificity := ol;
SALT37.MAC_Field_Nulls(FULLNAME_values_persisted,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FULLNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,EID_HASH,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FULLNAME_switch := bf;
EXPORT FULLNAME_max := MAX(FULLNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(FULLNAME_values_persisted,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
EXPORT FULLNAME_specificity := ol;
iSpecificities := DATASET([{0,NAME_SUFFIX_specificity,NAME_SUFFIX_switch,NAME_SUFFIX_max,NAME_SUFFIX_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,P_CITY_NAME_specificity,P_CITY_NAME_switch,P_CITY_NAME_max,P_CITY_NAME_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,PHONE_specificity,PHONE_switch,PHONE_max,PHONE_nulls,DL_ST_specificity,DL_ST_switch,DL_ST_max,DL_ST_nulls,DL_specificity,DL_switch,DL_max,DL_nulls,LEXID_specificity,LEXID_switch,LEXID_max,LEXID_nulls,POSSIBLE_SSN_specificity,POSSIBLE_SSN_switch,POSSIBLE_SSN_max,POSSIBLE_SSN_nulls,CRIME_specificity,CRIME_switch,CRIME_max,CRIME_nulls,NAME_TYPE_specificity,NAME_TYPE_switch,NAME_TYPE_max,NAME_TYPE_nulls,CLEAN_GENDER_specificity,CLEAN_GENDER_switch,CLEAN_GENDER_max,CLEAN_GENDER_nulls,CLASS_CODE_specificity,CLASS_CODE_switch,CLASS_CODE_max,CLASS_CODE_nulls,DT_FIRST_SEEN_specificity,DT_FIRST_SEEN_switch,DT_FIRST_SEEN_max,DT_FIRST_SEEN_nulls,DT_LAST_SEEN_specificity,DT_LAST_SEEN_switch,DT_LAST_SEEN_max,DT_LAST_SEEN_nulls,DATA_PROVIDER_ORI_specificity,DATA_PROVIDER_ORI_switch,DATA_PROVIDER_ORI_max,DATA_PROVIDER_ORI_nulls,VIN_specificity,VIN_switch,VIN_max,VIN_nulls,PLATE_specificity,PLATE_switch,PLATE_max,PLATE_nulls,LATITUDE_specificity,LATITUDE_switch,LATITUDE_max,LATITUDE_nulls,LONGITUDE_specificity,LONGITUDE_switch,LONGITUDE_max,LONGITUDE_nulls,SEARCH_ADDR1_specificity,SEARCH_ADDR1_switch,SEARCH_ADDR1_max,SEARCH_ADDR1_nulls,SEARCH_ADDR2_specificity,SEARCH_ADDR2_switch,SEARCH_ADDR2_max,SEARCH_ADDR2_nulls,CLEAN_COMPANY_NAME_specificity,CLEAN_COMPANY_NAME_switch,CLEAN_COMPANY_NAME_max,CLEAN_COMPANY_NAME_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls}],Layout_Specificities.R) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys_V2::Specificities',EXPIRE(Bair_ExternalLinkKeys_V2.Config.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 NAME_SUFFIX_shift0 := ROUND(Specificities[1].NAME_SUFFIX_specificity - 6);
  integer2 NAME_SUFFIX_switch_shift0 := ROUND(1000*Specificities[1].NAME_SUFFIX_switch - 54);
  integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 9);
  integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 263);
  integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 8);
  integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 228);
  integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 11);
  integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 383);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 11);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 463);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 11);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 469);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 8);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 371);
  integer1 P_CITY_NAME_shift0 := ROUND(Specificities[1].P_CITY_NAME_specificity - 10);
  integer2 P_CITY_NAME_switch_shift0 := ROUND(1000*Specificities[1].P_CITY_NAME_switch - 420);
  integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 5);
  integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 310);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 14);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 0);
  integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 15);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 PHONE_shift0 := ROUND(Specificities[1].PHONE_specificity - 21);
  integer2 PHONE_switch_shift0 := ROUND(1000*Specificities[1].PHONE_switch - 420);
  integer1 DL_ST_shift0 := ROUND(Specificities[1].DL_ST_specificity - 9);
  integer2 DL_ST_switch_shift0 := ROUND(1000*Specificities[1].DL_ST_switch - 25);
  integer1 DL_shift0 := ROUND(Specificities[1].DL_specificity - 23);
  integer2 DL_switch_shift0 := ROUND(1000*Specificities[1].DL_switch - 124);
  integer1 LEXID_shift0 := ROUND(Specificities[1].LEXID_specificity - 15);
  integer2 LEXID_switch_shift0 := ROUND(1000*Specificities[1].LEXID_switch - 350);
  integer1 POSSIBLE_SSN_shift0 := ROUND(Specificities[1].POSSIBLE_SSN_specificity - 24);
  integer2 POSSIBLE_SSN_switch_shift0 := ROUND(1000*Specificities[1].POSSIBLE_SSN_switch - 35);
  integer1 CRIME_shift0 := ROUND(Specificities[1].CRIME_specificity - 10);
  integer2 CRIME_switch_shift0 := ROUND(1000*Specificities[1].CRIME_switch - 45);
  integer1 NAME_TYPE_shift0 := ROUND(Specificities[1].NAME_TYPE_specificity - 10);
  integer2 NAME_TYPE_switch_shift0 := ROUND(1000*Specificities[1].NAME_TYPE_switch - 45);
  integer1 CLEAN_GENDER_shift0 := ROUND(Specificities[1].CLEAN_GENDER_specificity - 10);
  integer2 CLEAN_GENDER_switch_shift0 := ROUND(1000*Specificities[1].CLEAN_GENDER_switch - 45);
  integer1 CLASS_CODE_shift0 := ROUND(Specificities[1].CLASS_CODE_specificity - 10);
  integer2 CLASS_CODE_switch_shift0 := ROUND(1000*Specificities[1].CLASS_CODE_switch - 0);
  integer1 DT_FIRST_SEEN_shift0 := ROUND(Specificities[1].DT_FIRST_SEEN_specificity - 1);
  integer2 DT_FIRST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_FIRST_SEEN_switch - 0);
  integer1 DT_LAST_SEEN_shift0 := ROUND(Specificities[1].DT_LAST_SEEN_specificity - 1);
  integer2 DT_LAST_SEEN_switch_shift0 := ROUND(1000*Specificities[1].DT_LAST_SEEN_switch - 0);
  integer1 DATA_PROVIDER_ORI_shift0 := ROUND(Specificities[1].DATA_PROVIDER_ORI_specificity - 10);
  integer2 DATA_PROVIDER_ORI_switch_shift0 := ROUND(1000*Specificities[1].DATA_PROVIDER_ORI_switch - 120);
  integer1 VIN_shift0 := ROUND(Specificities[1].VIN_specificity - 12);
  integer2 VIN_switch_shift0 := ROUND(1000*Specificities[1].VIN_switch - 450);
  integer1 PLATE_shift0 := ROUND(Specificities[1].PLATE_specificity - 1);
  integer2 PLATE_switch_shift0 := ROUND(1000*Specificities[1].PLATE_switch - 0);
  integer1 LATITUDE_shift0 := ROUND(Specificities[1].LATITUDE_specificity - 1);
  integer2 LATITUDE_switch_shift0 := ROUND(1000*Specificities[1].LATITUDE_switch - 0);
  integer1 LONGITUDE_shift0 := ROUND(Specificities[1].LONGITUDE_specificity - 1);
  integer2 LONGITUDE_switch_shift0 := ROUND(1000*Specificities[1].LONGITUDE_switch - 0);
  integer1 SEARCH_ADDR1_shift0 := ROUND(Specificities[1].SEARCH_ADDR1_specificity - 18);
  integer2 SEARCH_ADDR1_switch_shift0 := ROUND(1000*Specificities[1].SEARCH_ADDR1_switch - 576);
  integer1 SEARCH_ADDR2_shift0 := ROUND(Specificities[1].SEARCH_ADDR2_specificity - 20);
  integer2 SEARCH_ADDR2_switch_shift0 := ROUND(1000*Specificities[1].SEARCH_ADDR2_switch - 520);
  integer1 CLEAN_COMPANY_NAME_shift0 := ROUND(Specificities[1].CLEAN_COMPANY_NAME_specificity - 22);
  integer2 CLEAN_COMPANY_NAME_switch_shift0 := ROUND(1000*Specificities[1].CLEAN_COMPANY_NAME_switch - 550);
  integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 22);
  integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 691);
  integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 22);
  integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 529);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT37.MAC_Specificity_Values(NAME_SUFFIX_values_persisted,NAME_SUFFIX,'NAME_SUFFIX',NAME_SUFFIX_specificity,NAME_SUFFIX_specificity_profile);
  SALT37.MAC_Specificity_Values(FNAME_values_persisted,FNAME,'FNAME',FNAME_specificity,FNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(MNAME_values_persisted,MNAME,'MNAME',MNAME_specificity,MNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(LNAME_values_persisted,LNAME,'LNAME',LNAME_specificity,LNAME_specificity_profile);
  SALT37.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
  SALT37.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
  SALT37.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
  SALT37.MAC_Specificity_Values(P_CITY_NAME_values_persisted,P_CITY_NAME,'P_CITY_NAME',P_CITY_NAME_specificity,P_CITY_NAME_specificity_profile);
  SALT37.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
  SALT37.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
  SALT37.MAC_Specificity_Values(PHONE_values_persisted,PHONE,'PHONE',PHONE_specificity,PHONE_specificity_profile);
  SALT37.MAC_Specificity_Values(DL_ST_values_persisted,DL_ST,'DL_ST',DL_ST_specificity,DL_ST_specificity_profile);
  SALT37.MAC_Specificity_Values(DL_values_persisted,DL,'DL',DL_specificity,DL_specificity_profile);
  SALT37.MAC_Specificity_Values(LEXID_values_persisted,LEXID,'LEXID',LEXID_specificity,LEXID_specificity_profile);
  SALT37.MAC_Specificity_Values(POSSIBLE_SSN_values_persisted,POSSIBLE_SSN,'POSSIBLE_SSN',POSSIBLE_SSN_specificity,POSSIBLE_SSN_specificity_profile);
  SALT37.MAC_Specificity_Values(CRIME_values_persisted,CRIME,'CRIME',CRIME_specificity,CRIME_specificity_profile);
  SALT37.MAC_Specificity_Values(NAME_TYPE_values_persisted,NAME_TYPE,'NAME_TYPE',NAME_TYPE_specificity,NAME_TYPE_specificity_profile);
  SALT37.MAC_Specificity_Values(CLEAN_GENDER_values_persisted,CLEAN_GENDER,'CLEAN_GENDER',CLEAN_GENDER_specificity,CLEAN_GENDER_specificity_profile);
  SALT37.MAC_Specificity_Values(CLASS_CODE_values_persisted,CLASS_CODE,'CLASS_CODE',CLASS_CODE_specificity,CLASS_CODE_specificity_profile);
  SALT37.MAC_Specificity_Values(DT_FIRST_SEEN_values_persisted,DT_FIRST_SEEN,'DT_FIRST_SEEN',DT_FIRST_SEEN_specificity,DT_FIRST_SEEN_specificity_profile);
  SALT37.MAC_Specificity_Values(DT_LAST_SEEN_values_persisted,DT_LAST_SEEN,'DT_LAST_SEEN',DT_LAST_SEEN_specificity,DT_LAST_SEEN_specificity_profile);
  SALT37.MAC_Specificity_Values(DATA_PROVIDER_ORI_values_persisted,DATA_PROVIDER_ORI,'DATA_PROVIDER_ORI',DATA_PROVIDER_ORI_specificity,DATA_PROVIDER_ORI_specificity_profile);
  SALT37.MAC_Specificity_Values(VIN_values_persisted,VIN,'VIN',VIN_specificity,VIN_specificity_profile);
  SALT37.MAC_Specificity_Values(PLATE_values_persisted,PLATE,'PLATE',PLATE_specificity,PLATE_specificity_profile);
  SALT37.MAC_Specificity_Values(LATITUDE_values_persisted,LATITUDE,'LATITUDE',LATITUDE_specificity,LATITUDE_specificity_profile);
  SALT37.MAC_Specificity_Values(LONGITUDE_values_persisted,LONGITUDE,'LONGITUDE',LONGITUDE_specificity,LONGITUDE_specificity_profile);
  SALT37.MAC_Specificity_Values(SEARCH_ADDR1_values_persisted,SEARCH_ADDR1,'SEARCH_ADDR1',SEARCH_ADDR1_specificity,SEARCH_ADDR1_specificity_profile);
  SALT37.MAC_Specificity_Values(SEARCH_ADDR2_values_persisted,SEARCH_ADDR2,'SEARCH_ADDR2',SEARCH_ADDR2_specificity,SEARCH_ADDR2_specificity_profile);
  SALT37.MAC_Specificity_Values(CLEAN_COMPANY_NAME_values_persisted,CLEAN_COMPANY_NAME,'CLEAN_COMPANY_NAME',CLEAN_COMPANY_NAME_specificity,CLEAN_COMPANY_NAME_specificity_profile);
EXPORT AllProfiles := NAME_SUFFIX_specificity_profile + FNAME_specificity_profile + MNAME_specificity_profile + LNAME_specificity_profile + PRIM_RANGE_specificity_profile + PRIM_NAME_specificity_profile + SEC_RANGE_specificity_profile + P_CITY_NAME_specificity_profile + ST_specificity_profile + ZIP_specificity_profile + PHONE_specificity_profile + DL_ST_specificity_profile + DL_specificity_profile + LEXID_specificity_profile + POSSIBLE_SSN_specificity_profile + CRIME_specificity_profile + NAME_TYPE_specificity_profile + CLEAN_GENDER_specificity_profile + CLASS_CODE_specificity_profile + DT_FIRST_SEEN_specificity_profile + DT_LAST_SEEN_specificity_profile + DATA_PROVIDER_ORI_specificity_profile + VIN_specificity_profile + PLATE_specificity_profile + LATITUDE_specificity_profile + LONGITUDE_specificity_profile + SEARCH_ADDR1_specificity_profile + SEARCH_ADDR2_specificity_profile + CLEAN_COMPANY_NAME_specificity_profile;
END;
 
