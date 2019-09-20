IMPORT ut,SALT32;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_EmpID) ih) := MODULE
 
EXPORT ih_init := SALT32.initNullIDs.baseLevel(ih,rcid,EmpID);
 
SHARED h := ih_init;
 
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT32.UIDType EmpID := h.EmpID; // using existing id field
  h.rcid;//RIDfield 
  h.isContact;
  h.orgid;
  h.fname;
  UNSIGNED1 fname_len := LENGTH(TRIM((SALT32.StrType)h.fname));
  h.mname;
  UNSIGNED1 mname_len := LENGTH(TRIM((SALT32.StrType)h.mname));
  h.lname;
  UNSIGNED1 lname_len := LENGTH(TRIM((SALT32.StrType)h.lname));
  h.name_suffix;
  h.contact_did;
  TYPEOF(h.contact_ssn) contact_ssn := (TYPEOF(h.contact_ssn))Fields.Make_contact_ssn((SALT32.StrType)h.contact_ssn ); // Cleans before using
  UNSIGNED1 contact_ssn_len := LENGTH(TRIM((SALT32.StrType)h.contact_ssn));
  h.contact_phone;
  h.contact_email;
  h.company_name;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip;
  h.active_duns_number;
  h.hist_duns_number;
  h.active_domestic_corp_key;
  h.hist_domestic_corp_key;
  h.foreign_corp_key;
  h.unk_corp_key;
  h.dt_first_seen;
  h.dt_last_seen;
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(EmpID<>0),r),HASH(EmpID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT32.MAC_Partition_Stars(h02,SALT_Partition,EmpID); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_isContact((SALT32.StrType)h0.isContact)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject);//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have EmpID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.EmpID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,EmpID,LOCAL);//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  orgid_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,orgid); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(orgid_deduped,orgid,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT orgid_values_persisted := specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::orgid',EXPIRE(Config.PersistExpire));
 
EXPORT  fname_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,fname); // Reduce to field values by UID
  SALT32.MAC_Field_Variants_Initials(fname_deduped,EmpID,fname,expanded) // expand out all variants of initial
  SALT32.Mac_Field_Count_UID(expanded,fname,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 fname_PreferredName := BIPV2_Tools.fn_PreferredName(counted.fname); // Compute BIPV2_Tools.fn_PreferredName value for fname
  end;
  with_id := table(counted,r1);
  SALT32.MAC_Field_Accumulate_Counts(with_id,fname_PreferredName,PreferredName_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,fname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT32.MAC_Field_Initial_Specificities(distance_computed,fname,initial_specs_added) // add initial char specificities
EXPORT fname_values_persisted := initial_specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::fname',EXPIRE(Config.PersistExpire));
 
EXPORT  mname_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,mname); // Reduce to field values by UID
  SALT32.MAC_Field_Variants_Initials(mname_deduped,EmpID,mname,expanded) // expand out all variants of initial
  SALT32.Mac_Field_Count_UID(expanded,mname,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,mname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT32.MAC_Field_Initial_Specificities(distance_computed,mname,initial_specs_added) // add initial char specificities
EXPORT mname_values_persisted := initial_specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::mname',EXPIRE(Config.PersistExpire));
 
EXPORT  lname_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,lname); // Reduce to field values by UID
  expanded := SALT32.MAC_Field_Variants_Hyphen(lname_deduped,EmpID,lname,2); // expand out all variants when hyphenated
  SALT32.Mac_Field_Count_UID(expanded,lname,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,lname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT lname_values_persisted := distance_computed;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::lname',EXPIRE(Config.PersistExpire));
 
EXPORT  name_suffix_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,name_suffix); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(name_suffix_deduped,name_suffix,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING5 name_suffix_NormSuffix := BIPV2_Tools.fn_normSuffix(counted.name_suffix); // Compute BIPV2_Tools.fn_normSuffix value for name_suffix
  end;
  with_id := table(counted,r1);
  SALT32.MAC_Field_Accumulate_Counts(with_id,name_suffix_NormSuffix,NormSuffix_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT name_suffix_values_persisted := specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::name_suffix',EXPIRE(Config.PersistExpire));
 
EXPORT  contact_did_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,contact_did); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(contact_did_deduped,contact_did,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_did_values_persisted := specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::contact_did',EXPIRE(Config.PersistExpire));
 
EXPORT  contact_ssn_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,contact_ssn); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(contact_ssn_deduped,contact_ssn,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING4 contact_ssn_Right4 := BIPV2_Tools.fn_Right4(counted.contact_ssn); // Compute BIPV2_Tools.fn_Right4 value for contact_ssn
  end;
  with_id := table(counted,r1);
  SALT32.MAC_Field_Accumulate_Counts(with_id,contact_ssn_Right4,Right4_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,contact_ssn,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT contact_ssn_values_persisted := distance_computed;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::contact_ssn',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,dt_first_seen); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted := specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::dt_first_seen',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_deduped := SALT32.MAC_Field_By_UID(input_file,EmpID,dt_last_seen); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted := specs_added;//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::values::dt_last_seen',EXPIRE(Config.PersistExpire));
SALT32.MAC_Field_Nulls(orgid_values_persisted,Layout_Specificities.orgid_ChildRec,nv) // Use automated NULL spotting
EXPORT orgid_nulls := nv;
SALT32.MAC_Field_Bfoul(orgid_deduped,orgid,EmpID,orgid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT orgid_switch := bf;
EXPORT orgid_max := MAX(orgid_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(orgid_values_persisted,orgid,orgid_nulls,ol) // Compute column level specificity
EXPORT orgid_specificity := ol;
EXPORT fname_nulls := DATASET([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(fname_deduped,fname,EmpID,fname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
EXPORT mname_nulls := DATASET([{'',0,0}],Layout_Specificities.mname_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(mname_deduped,mname,EmpID,mname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mname_switch := bf;
EXPORT mname_max := MAX(mname_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
EXPORT mname_specificity := ol;
SALT32.MAC_Field_Nulls(lname_values_persisted,Layout_Specificities.lname_ChildRec,nv) // Use automated NULL spotting
EXPORT lname_nulls := nv;
SALT32.MAC_Field_Bfoul(lname_deduped,lname,EmpID,lname_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
SALT32.MAC_Field_Nulls(name_suffix_values_persisted,Layout_Specificities.name_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT name_suffix_nulls := nv;
SALT32.MAC_Field_Bfoul(name_suffix_deduped,name_suffix,EmpID,name_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_suffix_switch := bf;
EXPORT name_suffix_max := MAX(name_suffix_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(name_suffix_values_persisted,name_suffix,name_suffix_nulls,ol) // Compute column level specificity
EXPORT name_suffix_specificity := ol;
SALT32.MAC_Field_Nulls(contact_did_values_persisted,Layout_Specificities.contact_did_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_did_nulls := nv;
SALT32.MAC_Field_Bfoul(contact_did_deduped,contact_did,EmpID,contact_did_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_did_switch := bf;
EXPORT contact_did_max := MAX(contact_did_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(contact_did_values_persisted,contact_did,contact_did_nulls,ol) // Compute column level specificity
EXPORT contact_did_specificity := ol;
SALT32.MAC_Field_Nulls(contact_ssn_values_persisted,Layout_Specificities.contact_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_ssn_nulls := nv;
SALT32.MAC_Field_Bfoul(contact_ssn_deduped,contact_ssn,EmpID,contact_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_ssn_switch := bf;
EXPORT contact_ssn_max := MAX(contact_ssn_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(contact_ssn_values_persisted,contact_ssn,contact_ssn_nulls,ol) // Compute column level specificity
EXPORT contact_ssn_specificity := ol;
SALT32.MAC_Field_Nulls(dt_first_seen_values_persisted,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT32.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,EmpID,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
SALT32.MAC_Field_Nulls(dt_last_seen_values_persisted,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT32.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,EmpID,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
iSpecificities := DATASET([{0,orgid_specificity,orgid_switch,orgid_max,orgid_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,name_suffix_specificity,name_suffix_switch,name_suffix_max,name_suffix_nulls,contact_did_specificity,contact_did_switch,contact_did_max,contact_did_nulls,contact_ssn_specificity,contact_ssn_switch,contact_ssn_max,contact_ssn_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls}],Layout_Specificities.R);//('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::Specificities',EXPIRE(Config.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 orgid_shift0 := ROUND(Specificities[1].orgid_specificity - 26);
  integer2 orgid_switch_shift0 := ROUND(1000*Specificities[1].orgid_switch - 0);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 8);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 20);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 9);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 9);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 10);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 31);
  integer1 name_suffix_shift0 := ROUND(Specificities[1].name_suffix_specificity - 8);
  integer2 name_suffix_switch_shift0 := ROUND(1000*Specificities[1].name_suffix_switch - 16);
  integer1 contact_did_shift0 := ROUND(Specificities[1].contact_did_specificity - 26);
  integer2 contact_did_switch_shift0 := ROUND(1000*Specificities[1].contact_did_switch - 38);
  integer1 contact_ssn_shift0 := ROUND(Specificities[1].contact_ssn_specificity - 27);
  integer2 contact_ssn_switch_shift0 := ROUND(1000*Specificities[1].contact_ssn_switch - 7);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT32.MAC_Specificity_Values(orgid_values_persisted,orgid,'orgid',orgid_specificity,orgid_specificity_profile);
  SALT32.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT32.MAC_Specificity_Values(mname_values_persisted,mname,'mname',mname_specificity,mname_specificity_profile);
  SALT32.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT32.MAC_Specificity_Values(name_suffix_values_persisted,name_suffix,'name_suffix',name_suffix_specificity,name_suffix_specificity_profile);
  SALT32.MAC_Specificity_Values(contact_did_values_persisted,contact_did,'contact_did',contact_did_specificity,contact_did_specificity_profile);
  SALT32.MAC_Specificity_Values(contact_ssn_values_persisted,contact_ssn,'contact_ssn',contact_ssn_specificity,contact_ssn_specificity_profile);
EXPORT AllProfiles := orgid_specificity_profile + fname_specificity_profile + mname_specificity_profile + lname_specificity_profile + name_suffix_specificity_profile + contact_did_specificity_profile + contact_ssn_specificity_profile;
END;
 
