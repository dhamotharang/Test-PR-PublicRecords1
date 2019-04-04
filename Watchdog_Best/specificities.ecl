IMPORT SALT311,std;
EXPORT specificities(DATASET(layout_Hdr) ih) := MODULE

EXPORT ih_init := SALT311.initNullIDs.baseLevel(ih,rid,did);

SHARED h := ih_init;

IMPORT Watchdog_Best; // Import modules for  attribute definitions
EXPORT input_layout := RECORD // project out required fields
  SALT311.UIDType did := h.did; // using existing id field
  h.rid;//RIDfield 
  UNSIGNED4 data_permits := fn_sources(h.src); // Pre-compute permissions for every field
  h.pflag1;
  h.pflag2;
  h.pflag3;
  h.src;
  h.dt_first_seen;
  h.dt_last_seen;
  h.dt_vendor_last_reported;
  h.dt_vendor_first_reported;
  h.dt_nonglb_last_seen;
  h.rec_type;
  h.phone;
  UNSIGNED1 phone_len := 0;  // Place holder filled in by project
  h.ssn;
  h.dob;
  h.title;
  h.fname;
  UNSIGNED1 fname_len := 0;  // Place holder filled in by project
  h.mname;
  UNSIGNED1 mname_len := 0;  // Place holder filled in by project
  h.lname;
  h.name_suffix;
  h.prim_range;
  h.predir;
  h.prim_name;
  h.suffix;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.city_name;
  h.st;
  h.zip;
  h.zip4;
  h.tnt;
  h.valid_ssn;
  h.jflag1;
  h.jflag2;
  h.jflag3;
  h.rawaid;
  h.dodgy_tracking;
  h.address_ind;
  h.name_ind;
  h.persistent_record_id;
  UNSIGNED4 ssnum := 0; // Place holder filled in by project
  UNSIGNED4 address := 0; // Place holder filled in by project
END;
r := input_layout;

h01 := DISTRIBUTE(TABLE(h(did<>0),r),HASH(did)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.phone_len := LENGTH(TRIM((SALT311.StrType)le.phone));
  SELF.fname_len := LENGTH(TRIM((SALT311.StrType)le.fname));
  SELF.mname_len := LENGTH(TRIM((SALT311.StrType)le.mname));
  SELF.ssnum := IF (Fields.InValid_ssnum((SALT311.StrType)le.ssn,(SALT311.StrType)le.valid_ssn)>0,0,HASH32((SALT311.StrType)le.ssn,(SALT311.StrType)le.valid_ssn)); // Combine child fields into 1 for specificity counting
  SELF.address := IF (Fields.InValid_address((SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.tnt,(SALT311.StrType)le.rawaid,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported)>0,0,HASH32((SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.tnt,(SALT311.StrType)le.rawaid,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;

EXPORT input_file_np := h0; // No-persist version for remote_linking

EXPORT input_file := h0 : PERSIST('~temp::did::Watchdog_best::Specificities_Cache',EXPIRE(Watchdog_best.Config.PersistExpire));
//We have did specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.did;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,did,LOCAL) : PERSIST('~temp::did::Watchdog_best::Cluster_Sizes',EXPIRE(Watchdog_best.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);


EXPORT  pflag1_deduped := SALT311.MAC_Field_By_UID(input_file,did,pflag1) : PERSIST('~temp::did::Watchdog_best::dedups::pflag1',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(pflag1_deduped,pflag1,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT pflag1_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::pflag1',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  pflag2_deduped := SALT311.MAC_Field_By_UID(input_file,did,pflag2) : PERSIST('~temp::did::Watchdog_best::dedups::pflag2',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(pflag2_deduped,pflag2,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT pflag2_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::pflag2',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  pflag3_deduped := SALT311.MAC_Field_By_UID(input_file,did,pflag3) : PERSIST('~temp::did::Watchdog_best::dedups::pflag3',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(pflag3_deduped,pflag3,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT pflag3_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::pflag3',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  src_deduped := SALT311.MAC_Field_By_UID(input_file,did,src) : PERSIST('~temp::did::Watchdog_best::dedups::src',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(src_deduped,src,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT src_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::src',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dt_first_seen_deduped := SALT311.MAC_Field_By_UID(input_file,did,dt_first_seen) : PERSIST('~temp::did::Watchdog_best::dedups::dt_first_seen',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dt_first_seen',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dt_last_seen_deduped := SALT311.MAC_Field_By_UID(input_file,did,dt_last_seen) : PERSIST('~temp::did::Watchdog_best::dedups::dt_last_seen',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dt_last_seen',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dt_vendor_last_reported_deduped := SALT311.MAC_Field_By_UID(input_file,did,dt_vendor_last_reported) : PERSIST('~temp::did::Watchdog_best::dedups::dt_vendor_last_reported',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_vendor_last_reported_deduped,dt_vendor_last_reported,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_last_reported_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dt_vendor_last_reported',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dt_vendor_first_reported_deduped := SALT311.MAC_Field_By_UID(input_file,did,dt_vendor_first_reported) : PERSIST('~temp::did::Watchdog_best::dedups::dt_vendor_first_reported',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_vendor_first_reported_deduped,dt_vendor_first_reported,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_vendor_first_reported_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dt_vendor_first_reported',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dt_nonglb_last_seen_deduped := SALT311.MAC_Field_By_UID(input_file,did,dt_nonglb_last_seen) : PERSIST('~temp::did::Watchdog_best::dedups::dt_nonglb_last_seen',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_nonglb_last_seen_deduped,dt_nonglb_last_seen,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_nonglb_last_seen_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dt_nonglb_last_seen',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  rec_type_deduped := SALT311.MAC_Field_By_UID(input_file,did,rec_type) : PERSIST('~temp::did::Watchdog_best::dedups::rec_type',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(rec_type_deduped,rec_type,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT rec_type_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::rec_type',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  phone_deduped := SALT311.MAC_Field_By_UID(input_file,did,phone) : PERSIST('~temp::did::Watchdog_best::dedups::phone',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(phone_deduped,phone,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,phone,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT phone_values_persisted := distance_computed : PERSIST('~temp::did::Watchdog_best::values::phone',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  ssn_deduped := SALT311.MAC_Field_By_UID(input_file,did,ssn) : PERSIST('~temp::did::Watchdog_best::dedups::ssn',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ssn_deduped,ssn,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ssn_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::ssn',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dob_deduped := SALT311.MAC_Field_By_UID(input_file,did,dob) : PERSIST('~temp::did::Watchdog_best::dedups::dob',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dob_deduped,dob,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dob_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dob',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  title_deduped := SALT311.MAC_Field_By_UID(input_file,did,title) : PERSIST('~temp::did::Watchdog_best::dedups::title',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(title_deduped,title,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT title_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::title',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  fname_deduped := SALT311.MAC_Field_By_UID(input_file,did,fname) : PERSIST('~temp::did::Watchdog_best::dedups::fname',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.MAC_Field_Variants_Initials(fname_deduped,did,fname,expanded) // expand out all variants of initial
  SALT311.Mac_Field_Count_UID(expanded,fname,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,fname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT311.MAC_Field_Initial_Specificities(distance_computed,fname,initial_specs_added) // add initial char specificities
EXPORT fname_values_persisted := initial_specs_added : PERSIST('~temp::did::Watchdog_best::values::fname',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  mname_deduped := SALT311.MAC_Field_By_UID(input_file,did,mname) : PERSIST('~temp::did::Watchdog_best::dedups::mname',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.MAC_Field_Variants_Initials(mname_deduped,did,mname,expanded) // expand out all variants of initial
  SALT311.Mac_Field_Count_UID(expanded,mname,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,mname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT311.MAC_Field_Initial_Specificities(distance_computed,mname,initial_specs_added) // add initial char specificities
EXPORT mname_values_persisted := initial_specs_added : PERSIST('~temp::did::Watchdog_best::values::mname',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  lname_deduped := SALT311.MAC_Field_By_UID(input_file,did,lname) : PERSIST('~temp::did::Watchdog_best::dedups::lname',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(lname_deduped,did,lname,1); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,lname,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT lname_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::lname',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  name_suffix_deduped := SALT311.MAC_Field_By_UID(input_file,did,name_suffix) : PERSIST('~temp::did::Watchdog_best::dedups::name_suffix',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(name_suffix_deduped,name_suffix,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT name_suffix_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::name_suffix',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  prim_range_deduped := SALT311.MAC_Field_By_UID(input_file,did,prim_range) : PERSIST('~temp::did::Watchdog_best::dedups::prim_range',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_range_deduped,prim_range,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::prim_range',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  predir_deduped := SALT311.MAC_Field_By_UID(input_file,did,predir) : PERSIST('~temp::did::Watchdog_best::dedups::predir',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(predir_deduped,predir,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT predir_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::predir',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  prim_name_deduped := SALT311.MAC_Field_By_UID(input_file,did,prim_name) : PERSIST('~temp::did::Watchdog_best::dedups::prim_name',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_name_deduped,prim_name,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::prim_name',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  suffix_deduped := SALT311.MAC_Field_By_UID(input_file,did,suffix) : PERSIST('~temp::did::Watchdog_best::dedups::suffix',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(suffix_deduped,suffix,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT suffix_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::suffix',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  postdir_deduped := SALT311.MAC_Field_By_UID(input_file,did,postdir) : PERSIST('~temp::did::Watchdog_best::dedups::postdir',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(postdir_deduped,postdir,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT postdir_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::postdir',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  unit_desig_deduped := SALT311.MAC_Field_By_UID(input_file,did,unit_desig) : PERSIST('~temp::did::Watchdog_best::dedups::unit_desig',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(unit_desig_deduped,unit_desig,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT unit_desig_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::unit_desig',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  sec_range_deduped := SALT311.MAC_Field_By_UID(input_file,did,sec_range) : PERSIST('~temp::did::Watchdog_best::dedups::sec_range',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(sec_range_deduped,sec_range,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::sec_range',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  city_name_deduped := SALT311.MAC_Field_By_UID(input_file,did,city_name) : PERSIST('~temp::did::Watchdog_best::dedups::city_name',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(city_name_deduped,city_name,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT city_name_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::city_name',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  st_deduped := SALT311.MAC_Field_By_UID(input_file,did,st) : PERSIST('~temp::did::Watchdog_best::dedups::st',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(st_deduped,st,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::st',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  zip_deduped := SALT311.MAC_Field_By_UID(input_file,did,zip) : PERSIST('~temp::did::Watchdog_best::dedups::zip',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(zip_deduped,zip,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::zip',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  zip4_deduped := SALT311.MAC_Field_By_UID(input_file,did,zip4) : PERSIST('~temp::did::Watchdog_best::dedups::zip4',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(zip4_deduped,zip4,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip4_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::zip4',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  tnt_deduped := SALT311.MAC_Field_By_UID(input_file,did,tnt) : PERSIST('~temp::did::Watchdog_best::dedups::tnt',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(tnt_deduped,tnt,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tnt_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::tnt',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  valid_ssn_deduped := SALT311.MAC_Field_By_UID(input_file,did,valid_ssn) : PERSIST('~temp::did::Watchdog_best::dedups::valid_ssn',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(valid_ssn_deduped,valid_ssn,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT valid_ssn_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::valid_ssn',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  jflag1_deduped := SALT311.MAC_Field_By_UID(input_file,did,jflag1) : PERSIST('~temp::did::Watchdog_best::dedups::jflag1',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(jflag1_deduped,jflag1,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT jflag1_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::jflag1',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  jflag2_deduped := SALT311.MAC_Field_By_UID(input_file,did,jflag2) : PERSIST('~temp::did::Watchdog_best::dedups::jflag2',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(jflag2_deduped,jflag2,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT jflag2_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::jflag2',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  jflag3_deduped := SALT311.MAC_Field_By_UID(input_file,did,jflag3) : PERSIST('~temp::did::Watchdog_best::dedups::jflag3',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(jflag3_deduped,jflag3,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT jflag3_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::jflag3',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  rawaid_deduped := SALT311.MAC_Field_By_UID(input_file,did,rawaid) : PERSIST('~temp::did::Watchdog_best::dedups::rawaid',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(rawaid_deduped,rawaid,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT rawaid_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::rawaid',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  dodgy_tracking_deduped := SALT311.MAC_Field_By_UID(input_file,did,dodgy_tracking) : PERSIST('~temp::did::Watchdog_best::dedups::dodgy_tracking',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dodgy_tracking_deduped,dodgy_tracking,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dodgy_tracking_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::dodgy_tracking',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  address_ind_deduped := SALT311.MAC_Field_By_UID(input_file,did,address_ind) : PERSIST('~temp::did::Watchdog_best::dedups::address_ind',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(address_ind_deduped,address_ind,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT address_ind_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::address_ind',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  name_ind_deduped := SALT311.MAC_Field_By_UID(input_file,did,name_ind) : PERSIST('~temp::did::Watchdog_best::dedups::name_ind',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(name_ind_deduped,name_ind,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT name_ind_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::name_ind',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  persistent_record_id_deduped := SALT311.MAC_Field_By_UID(input_file,did,persistent_record_id) : PERSIST('~temp::did::Watchdog_best::dedups::persistent_record_id',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(persistent_record_id_deduped,persistent_record_id,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT persistent_record_id_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::persistent_record_id',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  ssnum_deduped := SALT311.MAC_Field_By_UID(input_file,did,ssnum) : PERSIST('~temp::did::Watchdog_best::dedups::ssnum',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ssnum_deduped,ssnum,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ssnum_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::ssnum',EXPIRE(Watchdog_best.Config.PersistExpire));


EXPORT  address_deduped := SALT311.MAC_Field_By_UID(input_file,did,address) : PERSIST('~temp::did::Watchdog_best::dedups::address',EXPIRE(Watchdog_best.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(address_deduped,address,did,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT address_values_persisted := specs_added : PERSIST('~temp::did::Watchdog_best::values::address',EXPIRE(Watchdog_best.Config.PersistExpire));
SALT311.MAC_Field_Nulls(pflag1_values_persisted,Layout_Specificities.pflag1_ChildRec,nv) // Use automated NULL spotting
EXPORT pflag1_nulls := nv;
SALT311.MAC_Field_Bfoul(pflag1_deduped,pflag1,did,pflag1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT pflag1_switch := bf;
EXPORT pflag1_max := MAX(pflag1_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(pflag1_values_persisted,pflag1,pflag1_nulls,ol) // Compute column level specificity
EXPORT pflag1_specificity := ol;
SALT311.MAC_Field_Nulls(pflag2_values_persisted,Layout_Specificities.pflag2_ChildRec,nv) // Use automated NULL spotting
EXPORT pflag2_nulls := nv;
SALT311.MAC_Field_Bfoul(pflag2_deduped,pflag2,did,pflag2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT pflag2_switch := bf;
EXPORT pflag2_max := MAX(pflag2_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(pflag2_values_persisted,pflag2,pflag2_nulls,ol) // Compute column level specificity
EXPORT pflag2_specificity := ol;
SALT311.MAC_Field_Nulls(pflag3_values_persisted,Layout_Specificities.pflag3_ChildRec,nv) // Use automated NULL spotting
EXPORT pflag3_nulls := nv;
SALT311.MAC_Field_Bfoul(pflag3_deduped,pflag3,did,pflag3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT pflag3_switch := bf;
EXPORT pflag3_max := MAX(pflag3_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(pflag3_values_persisted,pflag3,pflag3_nulls,ol) // Compute column level specificity
EXPORT pflag3_specificity := ol;
SALT311.MAC_Field_Nulls(src_values_persisted,Layout_Specificities.src_ChildRec,nv) // Use automated NULL spotting
EXPORT src_nulls := nv;
SALT311.MAC_Field_Bfoul(src_deduped,src,did,src_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT src_switch := bf;
EXPORT src_max := MAX(src_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(src_values_persisted,src,src_nulls,ol) // Compute column level specificity
EXPORT src_specificity := ol;
SALT311.MAC_Field_Nulls(dt_first_seen_values_persisted,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,did,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
SALT311.MAC_Field_Nulls(dt_last_seen_values_persisted,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,did,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
SALT311.MAC_Field_Nulls(dt_vendor_last_reported_values_persisted,Layout_Specificities.dt_vendor_last_reported_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_last_reported_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_vendor_last_reported_deduped,dt_vendor_last_reported,did,dt_vendor_last_reported_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_last_reported_switch := bf;
EXPORT dt_vendor_last_reported_max := MAX(dt_vendor_last_reported_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dt_vendor_last_reported_values_persisted,dt_vendor_last_reported,dt_vendor_last_reported_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_last_reported_specificity := ol;
SALT311.MAC_Field_Nulls(dt_vendor_first_reported_values_persisted,Layout_Specificities.dt_vendor_first_reported_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_vendor_first_reported_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_vendor_first_reported_deduped,dt_vendor_first_reported,did,dt_vendor_first_reported_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_vendor_first_reported_switch := bf;
EXPORT dt_vendor_first_reported_max := MAX(dt_vendor_first_reported_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dt_vendor_first_reported_values_persisted,dt_vendor_first_reported,dt_vendor_first_reported_nulls,ol) // Compute column level specificity
EXPORT dt_vendor_first_reported_specificity := ol;
SALT311.MAC_Field_Nulls(dt_nonglb_last_seen_values_persisted,Layout_Specificities.dt_nonglb_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_nonglb_last_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_nonglb_last_seen_deduped,dt_nonglb_last_seen,did,dt_nonglb_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_nonglb_last_seen_switch := bf;
EXPORT dt_nonglb_last_seen_max := MAX(dt_nonglb_last_seen_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dt_nonglb_last_seen_values_persisted,dt_nonglb_last_seen,dt_nonglb_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_nonglb_last_seen_specificity := ol;
SALT311.MAC_Field_Nulls(rec_type_values_persisted,Layout_Specificities.rec_type_ChildRec,nv) // Use automated NULL spotting
EXPORT rec_type_nulls := nv;
SALT311.MAC_Field_Bfoul(rec_type_deduped,rec_type,did,rec_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT rec_type_switch := bf;
EXPORT rec_type_max := MAX(rec_type_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(rec_type_values_persisted,rec_type,rec_type_nulls,ol) // Compute column level specificity
EXPORT rec_type_specificity := ol;
SALT311.MAC_Field_Nulls(phone_values_persisted,Layout_Specificities.phone_ChildRec,nv) // Use automated NULL spotting
EXPORT phone_nulls := nv;
SALT311.MAC_Field_Bfoul(phone_deduped,phone,did,phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT phone_switch := bf;
EXPORT phone_max := MAX(phone_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(phone_values_persisted,phone,phone_nulls,ol) // Compute column level specificity
EXPORT phone_specificity := ol;
SALT311.MAC_Field_Nulls(ssn_values_persisted,Layout_Specificities.ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT ssn_nulls := nv;
SALT311.MAC_Field_Bfoul(ssn_deduped,ssn,did,ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ssn_switch := bf;
EXPORT ssn_max := MAX(ssn_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(ssn_values_persisted,ssn,ssn_nulls,ol) // Compute column level specificity
EXPORT ssn_specificity := ol;
SALT311.MAC_Field_Nulls(dob_values_persisted,Layout_Specificities.dob_ChildRec,nv) // Use automated NULL spotting
EXPORT dob_nulls := nv;
SALT311.MAC_Field_Bfoul(dob_deduped,dob,did,dob_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dob_switch := bf;
EXPORT dob_max := MAX(dob_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dob_values_persisted,dob,dob_nulls,ol) // Compute column level specificity
EXPORT dob_specificity := ol;
EXPORT title_nulls := DATASET([{'',0,0}],Layout_Specificities.title_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(title_deduped,title,did,title_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT title_switch := bf;
EXPORT title_max := MAX(title_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(title_values_persisted,title,title_nulls,ol) // Compute column level specificity
EXPORT title_specificity := ol;
EXPORT fname_nulls := DATASET([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(fname_deduped,fname,did,fname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
EXPORT mname_nulls := DATASET([{'',0,0}],Layout_Specificities.mname_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(mname_deduped,mname,did,mname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mname_switch := bf;
EXPORT mname_max := MAX(mname_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
EXPORT mname_specificity := ol;
EXPORT lname_nulls := DATASET([{'',0,0}],Layout_Specificities.lname_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(lname_deduped,lname,did,lname_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
SALT311.MAC_Field_Nulls(name_suffix_values_persisted,Layout_Specificities.name_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT name_suffix_nulls := nv;
SALT311.MAC_Field_Bfoul(name_suffix_deduped,name_suffix,did,name_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_suffix_switch := bf;
EXPORT name_suffix_max := MAX(name_suffix_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(name_suffix_values_persisted,name_suffix,name_suffix_nulls,ol) // Compute column level specificity
EXPORT name_suffix_specificity := ol;
SALT311.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT311.MAC_Field_Bfoul(prim_range_deduped,prim_range,did,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
SALT311.MAC_Field_Nulls(predir_values_persisted,Layout_Specificities.predir_ChildRec,nv) // Use automated NULL spotting
EXPORT predir_nulls := nv;
SALT311.MAC_Field_Bfoul(predir_deduped,predir,did,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT predir_switch := bf;
EXPORT predir_max := MAX(predir_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
EXPORT predir_specificity := ol;
SALT311.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT311.MAC_Field_Bfoul(prim_name_deduped,prim_name,did,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
SALT311.MAC_Field_Nulls(suffix_values_persisted,Layout_Specificities.suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT suffix_nulls := nv;
SALT311.MAC_Field_Bfoul(suffix_deduped,suffix,did,suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT suffix_switch := bf;
EXPORT suffix_max := MAX(suffix_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(suffix_values_persisted,suffix,suffix_nulls,ol) // Compute column level specificity
EXPORT suffix_specificity := ol;
SALT311.MAC_Field_Nulls(postdir_values_persisted,Layout_Specificities.postdir_ChildRec,nv) // Use automated NULL spotting
EXPORT postdir_nulls := nv;
SALT311.MAC_Field_Bfoul(postdir_deduped,postdir,did,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT postdir_switch := bf;
EXPORT postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
EXPORT postdir_specificity := ol;
SALT311.MAC_Field_Nulls(unit_desig_values_persisted,Layout_Specificities.unit_desig_ChildRec,nv) // Use automated NULL spotting
EXPORT unit_desig_nulls := nv;
SALT311.MAC_Field_Bfoul(unit_desig_deduped,unit_desig,did,unit_desig_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT unit_desig_switch := bf;
EXPORT unit_desig_max := MAX(unit_desig_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(unit_desig_values_persisted,unit_desig,unit_desig_nulls,ol) // Compute column level specificity
EXPORT unit_desig_specificity := ol;
SALT311.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT311.MAC_Field_Bfoul(sec_range_deduped,sec_range,did,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
SALT311.MAC_Field_Nulls(city_name_values_persisted,Layout_Specificities.city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT city_name_nulls := nv;
SALT311.MAC_Field_Bfoul(city_name_deduped,city_name,did,city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT city_name_switch := bf;
EXPORT city_name_max := MAX(city_name_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(city_name_values_persisted,city_name,city_name_nulls,ol) // Compute column level specificity
EXPORT city_name_specificity := ol;
SALT311.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT311.MAC_Field_Bfoul(st_deduped,st,did,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
SALT311.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT311.MAC_Field_Bfoul(zip_deduped,zip,did,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
SALT311.MAC_Field_Nulls(zip4_values_persisted,Layout_Specificities.zip4_ChildRec,nv) // Use automated NULL spotting
EXPORT zip4_nulls := nv;
SALT311.MAC_Field_Bfoul(zip4_deduped,zip4,did,zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip4_switch := bf;
EXPORT zip4_max := MAX(zip4_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(zip4_values_persisted,zip4,zip4_nulls,ol) // Compute column level specificity
EXPORT zip4_specificity := ol;
SALT311.MAC_Field_Nulls(tnt_values_persisted,Layout_Specificities.tnt_ChildRec,nv) // Use automated NULL spotting
EXPORT tnt_nulls := nv;
SALT311.MAC_Field_Bfoul(tnt_deduped,tnt,did,tnt_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tnt_switch := bf;
EXPORT tnt_max := MAX(tnt_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(tnt_values_persisted,tnt,tnt_nulls,ol) // Compute column level specificity
EXPORT tnt_specificity := ol;
SALT311.MAC_Field_Nulls(valid_ssn_values_persisted,Layout_Specificities.valid_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT valid_ssn_nulls := nv;
SALT311.MAC_Field_Bfoul(valid_ssn_deduped,valid_ssn,did,valid_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT valid_ssn_switch := bf;
EXPORT valid_ssn_max := MAX(valid_ssn_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(valid_ssn_values_persisted,valid_ssn,valid_ssn_nulls,ol) // Compute column level specificity
EXPORT valid_ssn_specificity := ol;
SALT311.MAC_Field_Nulls(jflag1_values_persisted,Layout_Specificities.jflag1_ChildRec,nv) // Use automated NULL spotting
EXPORT jflag1_nulls := nv;
SALT311.MAC_Field_Bfoul(jflag1_deduped,jflag1,did,jflag1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT jflag1_switch := bf;
EXPORT jflag1_max := MAX(jflag1_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(jflag1_values_persisted,jflag1,jflag1_nulls,ol) // Compute column level specificity
EXPORT jflag1_specificity := ol;
SALT311.MAC_Field_Nulls(jflag2_values_persisted,Layout_Specificities.jflag2_ChildRec,nv) // Use automated NULL spotting
EXPORT jflag2_nulls := nv;
SALT311.MAC_Field_Bfoul(jflag2_deduped,jflag2,did,jflag2_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT jflag2_switch := bf;
EXPORT jflag2_max := MAX(jflag2_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(jflag2_values_persisted,jflag2,jflag2_nulls,ol) // Compute column level specificity
EXPORT jflag2_specificity := ol;
SALT311.MAC_Field_Nulls(jflag3_values_persisted,Layout_Specificities.jflag3_ChildRec,nv) // Use automated NULL spotting
EXPORT jflag3_nulls := nv;
SALT311.MAC_Field_Bfoul(jflag3_deduped,jflag3,did,jflag3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT jflag3_switch := bf;
EXPORT jflag3_max := MAX(jflag3_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(jflag3_values_persisted,jflag3,jflag3_nulls,ol) // Compute column level specificity
EXPORT jflag3_specificity := ol;
SALT311.MAC_Field_Nulls(rawaid_values_persisted,Layout_Specificities.rawaid_ChildRec,nv) // Use automated NULL spotting
EXPORT rawaid_nulls := nv;
SALT311.MAC_Field_Bfoul(rawaid_deduped,rawaid,did,rawaid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT rawaid_switch := bf;
EXPORT rawaid_max := MAX(rawaid_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(rawaid_values_persisted,rawaid,rawaid_nulls,ol) // Compute column level specificity
EXPORT rawaid_specificity := ol;
SALT311.MAC_Field_Nulls(dodgy_tracking_values_persisted,Layout_Specificities.dodgy_tracking_ChildRec,nv) // Use automated NULL spotting
EXPORT dodgy_tracking_nulls := nv;
SALT311.MAC_Field_Bfoul(dodgy_tracking_deduped,dodgy_tracking,did,dodgy_tracking_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dodgy_tracking_switch := bf;
EXPORT dodgy_tracking_max := MAX(dodgy_tracking_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(dodgy_tracking_values_persisted,dodgy_tracking,dodgy_tracking_nulls,ol) // Compute column level specificity
EXPORT dodgy_tracking_specificity := ol;
EXPORT address_ind_nulls := DATASET([{'',0,0}],Layout_Specificities.address_ind_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(address_ind_deduped,address_ind,did,address_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT address_ind_switch := bf;
EXPORT address_ind_max := MAX(address_ind_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(address_ind_values_persisted,address_ind,address_ind_nulls,ol) // Compute column level specificity
EXPORT address_ind_specificity := ol;
EXPORT name_ind_nulls := DATASET([{'',0,0}],Layout_Specificities.name_ind_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(name_ind_deduped,name_ind,did,name_ind_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_ind_switch := bf;
EXPORT name_ind_max := MAX(name_ind_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(name_ind_values_persisted,name_ind,name_ind_nulls,ol) // Compute column level specificity
EXPORT name_ind_specificity := ol;
EXPORT persistent_record_id_nulls := DATASET([{'',0,0}],Layout_Specificities.persistent_record_id_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(persistent_record_id_deduped,persistent_record_id,did,persistent_record_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT persistent_record_id_switch := bf;
EXPORT persistent_record_id_max := MAX(persistent_record_id_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(persistent_record_id_values_persisted,persistent_record_id,persistent_record_id_nulls,ol) // Compute column level specificity
EXPORT persistent_record_id_specificity := ol;
SALT311.MAC_Field_Nulls(ssnum_values_persisted,Layout_Specificities.ssnum_ChildRec,nv) // Use automated NULL spotting
EXPORT ssnum_nulls := nv;
SALT311.MAC_Field_Bfoul(ssnum_deduped,ssnum,did,ssnum_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ssnum_switch := bf;
EXPORT ssnum_max := MAX(ssnum_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(ssnum_values_persisted,ssnum,ssnum_nulls,ol) // Compute column level specificity
EXPORT ssnum_specificity := ol;
SALT311.MAC_Field_Nulls(address_values_persisted,Layout_Specificities.address_ChildRec,nv) // Use automated NULL spotting
EXPORT address_nulls := nv;
SALT311.MAC_Field_Bfoul(address_deduped,address,did,address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT address_switch := bf;
EXPORT address_max := MAX(address_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(address_values_persisted,address,address_nulls,ol) // Compute column level specificity
EXPORT address_specificity := ol;
EXPORT Layout_Uber_Plus := RECORD(SALT311.Layout_Uber_Record0)
  SALT311.Str30Type word;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(input_file le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.pflag1,(SALT311.StrType)le.pflag2,(SALT311.StrType)le.pflag3,(SALT311.StrType)le.src,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_nonglb_last_seen,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.phone,(SALT311.StrType)le.ssn,(SALT311.StrType)le.dob,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.tnt,(SALT311.StrType)le.valid_ssn,(SALT311.StrType)le.jflag1,(SALT311.StrType)le.jflag2,(SALT311.StrType)le.jflag3,(SALT311.StrType)le.rawaid,(SALT311.StrType)le.dodgy_tracking,(SALT311.StrType)le.address_ind,(SALT311.StrType)le.name_ind,(SALT311.StrType)le.persistent_record_id,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.did;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(input_file,41,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Normal_Field(input_file,ssn,40,did,layout_uber_plus,nfields9320);
SALT311.MAC_Expand_Normal_Field(input_file,valid_ssn,40,did,layout_uber_plus,nfields9321);
nfields40 := nfields9320+nfields9321;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,prim_range,41,did,layout_uber_plus,nfields9553);
SALT311.MAC_Expand_Normal_Field(input_file,predir,41,did,layout_uber_plus,nfields9554);
SALT311.MAC_Expand_Normal_Field(input_file,prim_name,41,did,layout_uber_plus,nfields9555);
SALT311.MAC_Expand_Normal_Field(input_file,suffix,41,did,layout_uber_plus,nfields9556);
SALT311.MAC_Expand_Normal_Field(input_file,postdir,41,did,layout_uber_plus,nfields9557);
SALT311.MAC_Expand_Normal_Field(input_file,unit_desig,41,did,layout_uber_plus,nfields9558);
SALT311.MAC_Expand_Normal_Field(input_file,sec_range,41,did,layout_uber_plus,nfields9559);
SALT311.MAC_Expand_Normal_Field(input_file,city_name,41,did,layout_uber_plus,nfields9560);
SALT311.MAC_Expand_Normal_Field(input_file,st,41,did,layout_uber_plus,nfields9561);
SALT311.MAC_Expand_Normal_Field(input_file,zip,41,did,layout_uber_plus,nfields9562);
SALT311.MAC_Expand_Normal_Field(input_file,zip4,41,did,layout_uber_plus,nfields9563);
SALT311.MAC_Expand_Normal_Field(input_file,tnt,41,did,layout_uber_plus,nfields9564);
SALT311.MAC_Expand_Normal_Field(input_file,rawaid,41,did,layout_uber_plus,nfields9565);
SALT311.MAC_Expand_Normal_Field(input_file,dt_first_seen,41,did,layout_uber_plus,nfields9566);
SALT311.MAC_Expand_Normal_Field(input_file,dt_last_seen,41,did,layout_uber_plus,nfields9567);
SALT311.MAC_Expand_Normal_Field(input_file,dt_vendor_first_reported,41,did,layout_uber_plus,nfields9568);
SALT311.MAC_Expand_Normal_Field(input_file,dt_vendor_last_reported,41,did,layout_uber_plus,nfields9569);
nfields41 := nfields9553+nfields9554+nfields9555+nfields9556+nfields9557+nfields9558+nfields9559+nfields9560+nfields9561+nfields9562+nfields9563+nfields9564+nfields9565+nfields9566+nfields9567+nfields9568+nfields9569;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r;
uber_values_deduped0 := Fn_Reduce_UBER_Local( invert_records);
// minimize otherwise required changes to the macros used by uber and specificities!
Layout_Uber_Plus_Spec := RECORD(Layout_Uber_Plus AND NOT uid)
  SALT311.UIDType did;
END;
SHARED uber_values_deduped := PROJECT(uber_values_deduped0,TRANSFORM(Layout_Uber_Plus_Spec,SELF.did:=LEFT.uid,SELF:=LEFT)) : PERSIST('~temp::did::Watchdog_best::dedups::uber',EXPIRE(Watchdog_best.Config.PersistExpire));
SALT311.MAC_Specificity_Local(uber_values_deduped,word,did,uber_nulls,Layout_Specificities.uber_ChildRec,word_specificity,word_switch,word_values)
EXPORT uber_values_persisted := word_values : PERSIST('~temp::did::Watchdog_best::values::uber',EXPIRE(Watchdog_best.Config.PersistExpire));
SALT311.MAC_Field_Bfoul(uber_values_deduped,word,did,uber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT uber_switch := bf;
EXPORT uber_max := MAX(uber_values_persisted,field_specificity);
SALT311.MAC_Field_Specificity(uber_values_persisted,word,uber_nulls,ol) // Compute column level specificity;
EXPORT uber_specificity := ol;
iSpecificities := DATASET([{0,pflag1_specificity,pflag1_switch,pflag1_max,pflag1_nulls,pflag2_specificity,pflag2_switch,pflag2_max,pflag2_nulls,pflag3_specificity,pflag3_switch,pflag3_max,pflag3_nulls,src_specificity,src_switch,src_max,src_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,dt_vendor_last_reported_specificity,dt_vendor_last_reported_switch,dt_vendor_last_reported_max,dt_vendor_last_reported_nulls,dt_vendor_first_reported_specificity,dt_vendor_first_reported_switch,dt_vendor_first_reported_max,dt_vendor_first_reported_nulls,dt_nonglb_last_seen_specificity,dt_nonglb_last_seen_switch,dt_nonglb_last_seen_max,dt_nonglb_last_seen_nulls,rec_type_specificity,rec_type_switch,rec_type_max,rec_type_nulls,phone_specificity,phone_switch,phone_max,phone_nulls,ssn_specificity,ssn_switch,ssn_max,ssn_nulls,dob_specificity,dob_switch,dob_max,dob_nulls,title_specificity,title_switch,title_max,title_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,name_suffix_specificity,name_suffix_switch,name_suffix_max,name_suffix_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,suffix_specificity,suffix_switch,suffix_max,suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,unit_desig_specificity,unit_desig_switch,unit_desig_max,unit_desig_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,city_name_specificity,city_name_switch,city_name_max,city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,zip4_specificity,zip4_switch,zip4_max,zip4_nulls,tnt_specificity,tnt_switch,tnt_max,tnt_nulls,valid_ssn_specificity,valid_ssn_switch,valid_ssn_max,valid_ssn_nulls,jflag1_specificity,jflag1_switch,jflag1_max,jflag1_nulls,jflag2_specificity,jflag2_switch,jflag2_max,jflag2_nulls,jflag3_specificity,jflag3_switch,jflag3_max,jflag3_nulls,rawaid_specificity,rawaid_switch,rawaid_max,rawaid_nulls,dodgy_tracking_specificity,dodgy_tracking_switch,dodgy_tracking_max,dodgy_tracking_nulls,address_ind_specificity,address_ind_switch,address_ind_max,address_ind_nulls,name_ind_specificity,name_ind_switch,name_ind_max,name_ind_nulls,persistent_record_id_specificity,persistent_record_id_switch,persistent_record_id_max,persistent_record_id_nulls,ssnum_specificity,ssnum_switch,ssnum_max,ssnum_nulls,address_specificity,address_switch,address_max,address_nulls,uber_specificity,uber_switch,uber_max,uber_nulls}],Layout_Specificities.R) : PERSIST('~temp::did::Watchdog_best::Specificities',EXPIRE(Watchdog_best.Config.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 pflag1_shift0 := ROUND(Specificities[1].pflag1_specificity - 44);
  integer2 pflag1_switch_shift0 := ROUND(1000*Specificities[1].pflag1_switch - 2);
  integer1 pflag2_shift0 := ROUND(Specificities[1].pflag2_specificity - 43);
  integer2 pflag2_switch_shift0 := ROUND(1000*Specificities[1].pflag2_switch - 20);
  integer1 pflag3_shift0 := ROUND(Specificities[1].pflag3_specificity - 7);
  integer2 pflag3_switch_shift0 := ROUND(1000*Specificities[1].pflag3_switch - 1);
  integer1 src_shift0 := ROUND(Specificities[1].src_specificity - 311);
  integer2 src_switch_shift0 := ROUND(1000*Specificities[1].src_switch - 93);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 61);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 8);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 56);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 9);
  integer1 dt_vendor_last_reported_shift0 := ROUND(Specificities[1].dt_vendor_last_reported_specificity - 48);
  integer2 dt_vendor_last_reported_switch_shift0 := ROUND(1000*Specificities[1].dt_vendor_last_reported_switch - 9);
  integer1 dt_vendor_first_reported_shift0 := ROUND(Specificities[1].dt_vendor_first_reported_specificity - 50);
  integer2 dt_vendor_first_reported_switch_shift0 := ROUND(1000*Specificities[1].dt_vendor_first_reported_switch - 8);
  integer1 dt_nonglb_last_seen_shift0 := ROUND(Specificities[1].dt_nonglb_last_seen_specificity - 64);
  integer2 dt_nonglb_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_nonglb_last_seen_switch - 8);
  integer1 rec_type_shift0 := ROUND(Specificities[1].rec_type_specificity - 12);
  integer2 rec_type_switch_shift0 := ROUND(1000*Specificities[1].rec_type_switch - 6);
  integer1 phone_shift0 := ROUND(Specificities[1].phone_specificity - 17);
  integer2 phone_switch_shift0 := ROUND(1000*Specificities[1].phone_switch - 0);
  integer1 ssn_shift0 := ROUND(Specificities[1].ssn_specificity - 17);
  integer2 ssn_switch_shift0 := ROUND(1000*Specificities[1].ssn_switch - 1);
  integer1 dob_shift0 := ROUND(Specificities[1].dob_specificity - 13);
  integer2 dob_switch_shift0 := ROUND(1000*Specificities[1].dob_switch - 1);
  integer1 title_shift0 := ROUND(Specificities[1].title_specificity - 1);
  integer2 title_switch_shift0 := ROUND(1000*Specificities[1].title_switch - 0);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 1);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 1);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 1);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 1);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 1);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 1);
  integer1 name_suffix_shift0 := ROUND(Specificities[1].name_suffix_specificity - 70);
  integer2 name_suffix_switch_shift0 := ROUND(1000*Specificities[1].name_suffix_switch - 1);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 115);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 3);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 38);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 3);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 131);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 4);
  integer1 suffix_shift0 := ROUND(Specificities[1].suffix_specificity - 29);
  integer2 suffix_switch_shift0 := ROUND(1000*Specificities[1].suffix_switch - 4);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 61);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 2);
  integer1 unit_desig_shift0 := ROUND(Specificities[1].unit_desig_specificity - 29);
  integer2 unit_desig_switch_shift0 := ROUND(1000*Specificities[1].unit_desig_switch - 3);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 103);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 5);
  integer1 city_name_shift0 := ROUND(Specificities[1].city_name_specificity - 109);
  integer2 city_name_switch_shift0 := ROUND(1000*Specificities[1].city_name_switch - 3);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 48);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 2);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 129);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 4);
  integer1 zip4_shift0 := ROUND(Specificities[1].zip4_specificity - 116);
  integer2 zip4_switch_shift0 := ROUND(1000*Specificities[1].zip4_switch - 5);
  integer1 tnt_shift0 := ROUND(Specificities[1].tnt_specificity - 93);
  integer2 tnt_switch_shift0 := ROUND(1000*Specificities[1].tnt_switch - 2);
  integer1 valid_ssn_shift0 := ROUND(Specificities[1].valid_ssn_specificity - 21);
  integer2 valid_ssn_switch_shift0 := ROUND(1000*Specificities[1].valid_ssn_switch - 1);
  integer1 jflag1_shift0 := ROUND(Specificities[1].jflag1_specificity - 24);
  integer2 jflag1_switch_shift0 := ROUND(1000*Specificities[1].jflag1_switch - 5);
  integer1 jflag2_shift0 := ROUND(Specificities[1].jflag2_specificity - 37);
  integer2 jflag2_switch_shift0 := ROUND(1000*Specificities[1].jflag2_switch - 0);
  integer1 jflag3_shift0 := ROUND(Specificities[1].jflag3_specificity - 25);
  integer2 jflag3_switch_shift0 := ROUND(1000*Specificities[1].jflag3_switch - 0);
  integer1 rawaid_shift0 := ROUND(Specificities[1].rawaid_specificity - 169);
  integer2 rawaid_switch_shift0 := ROUND(1000*Specificities[1].rawaid_switch - 5);
  integer1 dodgy_tracking_shift0 := ROUND(Specificities[1].dodgy_tracking_specificity - 53);
  integer2 dodgy_tracking_switch_shift0 := ROUND(1000*Specificities[1].dodgy_tracking_switch - 4);
  integer1 address_ind_shift0 := ROUND(Specificities[1].address_ind_specificity - 1);
  integer2 address_ind_switch_shift0 := ROUND(1000*Specificities[1].address_ind_switch - 0);
  integer1 name_ind_shift0 := ROUND(Specificities[1].name_ind_specificity - 1);
  integer2 name_ind_switch_shift0 := ROUND(1000*Specificities[1].name_ind_switch - 1);
  integer1 persistent_record_id_shift0 := ROUND(Specificities[1].persistent_record_id_specificity - 1);
  integer2 persistent_record_id_switch_shift0 := ROUND(1000*Specificities[1].persistent_record_id_switch - 1);
  integer1 ssnum_shift0 := ROUND(Specificities[1].ssnum_specificity - 56);
  integer2 ssnum_switch_shift0 := ROUND(1000*Specificities[1].ssnum_switch - 5);
  integer1 address_shift0 := ROUND(Specificities[1].address_specificity - 170);
  integer2 address_switch_shift0 := ROUND(1000*Specificities[1].address_switch - 5);
  END;

EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT311.MAC_Specificity_Values(pflag1_values_persisted,pflag1,'pflag1',pflag1_specificity,pflag1_specificity_profile);
  SALT311.MAC_Specificity_Values(pflag2_values_persisted,pflag2,'pflag2',pflag2_specificity,pflag2_specificity_profile);
  SALT311.MAC_Specificity_Values(pflag3_values_persisted,pflag3,'pflag3',pflag3_specificity,pflag3_specificity_profile);
  SALT311.MAC_Specificity_Values(src_values_persisted,src,'src',src_specificity,src_specificity_profile);
  SALT311.MAC_Specificity_Values(dt_first_seen_values_persisted,dt_first_seen,'dt_first_seen',dt_first_seen_specificity,dt_first_seen_specificity_profile);
  SALT311.MAC_Specificity_Values(dt_last_seen_values_persisted,dt_last_seen,'dt_last_seen',dt_last_seen_specificity,dt_last_seen_specificity_profile);
  SALT311.MAC_Specificity_Values(dt_vendor_last_reported_values_persisted,dt_vendor_last_reported,'dt_vendor_last_reported',dt_vendor_last_reported_specificity,dt_vendor_last_reported_specificity_profile);
  SALT311.MAC_Specificity_Values(dt_vendor_first_reported_values_persisted,dt_vendor_first_reported,'dt_vendor_first_reported',dt_vendor_first_reported_specificity,dt_vendor_first_reported_specificity_profile);
  SALT311.MAC_Specificity_Values(dt_nonglb_last_seen_values_persisted,dt_nonglb_last_seen,'dt_nonglb_last_seen',dt_nonglb_last_seen_specificity,dt_nonglb_last_seen_specificity_profile);
  SALT311.MAC_Specificity_Values(rec_type_values_persisted,rec_type,'rec_type',rec_type_specificity,rec_type_specificity_profile);
  SALT311.MAC_Specificity_Values(phone_values_persisted,phone,'phone',phone_specificity,phone_specificity_profile);
  SALT311.MAC_Specificity_Values(ssn_values_persisted,ssn,'ssn',ssn_specificity,ssn_specificity_profile);
  SALT311.MAC_Specificity_Values(dob_values_persisted,dob,'dob',dob_specificity,dob_specificity_profile);
  SALT311.MAC_Specificity_Values(title_values_persisted,title,'title',title_specificity,title_specificity_profile);
  SALT311.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT311.MAC_Specificity_Values(mname_values_persisted,mname,'mname',mname_specificity,mname_specificity_profile);
  SALT311.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT311.MAC_Specificity_Values(name_suffix_values_persisted,name_suffix,'name_suffix',name_suffix_specificity,name_suffix_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT311.MAC_Specificity_Values(predir_values_persisted,predir,'predir',predir_specificity,predir_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT311.MAC_Specificity_Values(suffix_values_persisted,suffix,'suffix',suffix_specificity,suffix_specificity_profile);
  SALT311.MAC_Specificity_Values(postdir_values_persisted,postdir,'postdir',postdir_specificity,postdir_specificity_profile);
  SALT311.MAC_Specificity_Values(unit_desig_values_persisted,unit_desig,'unit_desig',unit_desig_specificity,unit_desig_specificity_profile);
  SALT311.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT311.MAC_Specificity_Values(city_name_values_persisted,city_name,'city_name',city_name_specificity,city_name_specificity_profile);
  SALT311.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT311.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT311.MAC_Specificity_Values(zip4_values_persisted,zip4,'zip4',zip4_specificity,zip4_specificity_profile);
  SALT311.MAC_Specificity_Values(tnt_values_persisted,tnt,'tnt',tnt_specificity,tnt_specificity_profile);
  SALT311.MAC_Specificity_Values(valid_ssn_values_persisted,valid_ssn,'valid_ssn',valid_ssn_specificity,valid_ssn_specificity_profile);
  SALT311.MAC_Specificity_Values(jflag1_values_persisted,jflag1,'jflag1',jflag1_specificity,jflag1_specificity_profile);
  SALT311.MAC_Specificity_Values(jflag2_values_persisted,jflag2,'jflag2',jflag2_specificity,jflag2_specificity_profile);
  SALT311.MAC_Specificity_Values(jflag3_values_persisted,jflag3,'jflag3',jflag3_specificity,jflag3_specificity_profile);
  SALT311.MAC_Specificity_Values(rawaid_values_persisted,rawaid,'rawaid',rawaid_specificity,rawaid_specificity_profile);
  SALT311.MAC_Specificity_Values(dodgy_tracking_values_persisted,dodgy_tracking,'dodgy_tracking',dodgy_tracking_specificity,dodgy_tracking_specificity_profile);
  SALT311.MAC_Specificity_Values(address_ind_values_persisted,address_ind,'address_ind',address_ind_specificity,address_ind_specificity_profile);
  SALT311.MAC_Specificity_Values(name_ind_values_persisted,name_ind,'name_ind',name_ind_specificity,name_ind_specificity_profile);
  SALT311.MAC_Specificity_Values(persistent_record_id_values_persisted,persistent_record_id,'persistent_record_id',persistent_record_id_specificity,persistent_record_id_specificity_profile);
EXPORT AllProfiles := pflag1_specificity_profile + pflag2_specificity_profile + pflag3_specificity_profile + src_specificity_profile + dt_first_seen_specificity_profile + dt_last_seen_specificity_profile + dt_vendor_last_reported_specificity_profile + dt_vendor_first_reported_specificity_profile + dt_nonglb_last_seen_specificity_profile + rec_type_specificity_profile + phone_specificity_profile + ssn_specificity_profile + dob_specificity_profile + title_specificity_profile + fname_specificity_profile + mname_specificity_profile + lname_specificity_profile + name_suffix_specificity_profile + prim_range_specificity_profile + predir_specificity_profile + prim_name_specificity_profile + suffix_specificity_profile + postdir_specificity_profile + unit_desig_specificity_profile + sec_range_specificity_profile + city_name_specificity_profile + st_specificity_profile + zip_specificity_profile + zip4_specificity_profile + tnt_specificity_profile + valid_ssn_specificity_profile + jflag1_specificity_profile + jflag2_specificity_profile + jflag3_specificity_profile + rawaid_specificity_profile + dodgy_tracking_specificity_profile + address_ind_specificity_profile + name_ind_specificity_profile + persistent_record_id_specificity_profile;
END;

