IMPORT ut,SALT35;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_POWID_Down) ih) := MODULE
 
EXPORT ih_init := SALT35.initNullIDs.baseLevel(ih,rcid,POWID);
 
SHARED h := ih_init;
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT35.UIDType POWID := h.POWID; // using existing id field
  h.rcid;//RIDfield 
  h.company_name;
  h.orgid;
  h.prim_range;
  h.prim_name;
  h.st;
  h.v_city_name;
  h.zip;
  unsigned4 csz := 0; // Place holder filled in by project
  unsigned4 addr1 := 0; // Place holder filled in by project
  unsigned4 address := 0; // Place holder filled in by project
  h.dt_first_seen;
  h.dt_last_seen;
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(POWID<>0),r),HASH(POWID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.csz := IF (Fields.InValid_csz((SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip)>0,0,HASH32((SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.addr1 := IF (Fields.InValid_addr1((SALT35.StrType)le.prim_range,(SALT35.StrType)le.prim_name)>0,0,HASH32((SALT35.StrType)le.prim_range,(SALT35.StrType)le.prim_name)); // Combine child fields into 1 for specificity counting
  SELF.address := IF (Fields.InValid_address((SALT35.StrType)SELF.addr1,(SALT35.StrType)SELF.csz)>0,0,HASH32((SALT35.StrType)SELF.addr1,(SALT35.StrType)SELF.csz)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT35.MAC_Partition_Stars(h02,SALT_Partition,POWID); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::POWID::BIPV2_POWID_Down::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have POWID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.POWID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,POWID,LOCAL) : PERSIST('~temp::POWID::BIPV2_POWID_Down::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  orgid_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,orgid); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(orgid_deduped,orgid,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT orgid_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::orgid',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_range_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,prim_range); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(prim_range_deduped,prim_range,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::prim_range',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_name_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,prim_name); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(prim_name_deduped,prim_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::prim_name',EXPIRE(Config.PersistExpire));
 
EXPORT  st_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,st); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(st_deduped,st,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::st',EXPIRE(Config.PersistExpire));
 
EXPORT  v_city_name_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,v_city_name); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::v_city_name',EXPIRE(Config.PersistExpire));
 
EXPORT  zip_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,zip); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(zip_deduped,zip,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::zip',EXPIRE(Config.PersistExpire));
 
EXPORT  csz_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,csz); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(csz_deduped,csz,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT csz_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::csz',EXPIRE(Config.PersistExpire));
 
EXPORT  addr1_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,addr1); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(addr1_deduped,addr1,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT addr1_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::addr1',EXPIRE(Config.PersistExpire));
 
EXPORT  address_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,address); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(address_deduped,address,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT address_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::address',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,dt_first_seen); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::dt_first_seen',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_deduped := SALT35.MAC_Field_By_UID(input_file,POWID,dt_last_seen); // Reduce to field values by UID
  SALT35.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT35.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Down::values::dt_last_seen',EXPIRE(Config.PersistExpire));
 
EXPORT orgidValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::orgid';
 
EXPORT orgid_values_index := INDEX(orgid_values_persisted_temp,{orgid},{orgid_values_persisted_temp},orgidValuesIndexKeyName);
EXPORT orgid_values_persisted := orgid_values_index;
SALT35.MAC_Field_Nulls(orgid_values_persisted,Layout_Specificities.orgid_ChildRec,nv) // Use automated NULL spotting
EXPORT orgid_nulls := nv;
SALT35.MAC_Field_Bfoul(orgid_deduped,orgid,POWID,orgid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT orgid_switch := bf;
EXPORT orgid_max := MAX(orgid_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(orgid_values_persisted,orgid,orgid_nulls,ol) // Compute column level specificity
EXPORT orgid_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT35.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT35.MAC_Field_Bfoul(prim_range_deduped,prim_range,POWID,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT35.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT35.MAC_Field_Bfoul(prim_name_deduped,prim_name,POWID,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT35.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT35.MAC_Field_Bfoul(st_deduped,st,POWID,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::v_city_name';
 
EXPORT v_city_name_values_index := INDEX(v_city_name_values_persisted_temp,{v_city_name},{v_city_name_values_persisted_temp},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT35.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT35.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,POWID,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT35.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT35.MAC_Field_Bfoul(zip_deduped,zip,POWID,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT cszValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::csz';
 
EXPORT csz_values_index := INDEX(csz_values_persisted_temp,{csz},{csz_values_persisted_temp},cszValuesIndexKeyName);
EXPORT csz_values_persisted := csz_values_index;
SALT35.MAC_Field_Nulls(csz_values_persisted,Layout_Specificities.csz_ChildRec,nv) // Use automated NULL spotting
EXPORT csz_nulls := nv;
SALT35.MAC_Field_Bfoul(csz_deduped,csz,POWID,csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT csz_switch := bf;
EXPORT csz_max := MAX(csz_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(csz_values_persisted,csz,csz_nulls,ol) // Compute column level specificity
EXPORT csz_specificity := ol;
 
EXPORT addr1ValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::addr1';
 
EXPORT addr1_values_index := INDEX(addr1_values_persisted_temp,{addr1},{addr1_values_persisted_temp},addr1ValuesIndexKeyName);
EXPORT addr1_values_persisted := addr1_values_index;
SALT35.MAC_Field_Nulls(addr1_values_persisted,Layout_Specificities.addr1_ChildRec,nv) // Use automated NULL spotting
EXPORT addr1_nulls := nv;
SALT35.MAC_Field_Bfoul(addr1_deduped,addr1,POWID,addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT addr1_switch := bf;
EXPORT addr1_max := MAX(addr1_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(addr1_values_persisted,addr1,addr1_nulls,ol) // Compute column level specificity
EXPORT addr1_specificity := ol;
 
EXPORT addressValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::address';
 
EXPORT address_values_index := INDEX(address_values_persisted_temp,{address},{address_values_persisted_temp},addressValuesIndexKeyName);
EXPORT address_values_persisted := address_values_index;
SALT35.MAC_Field_Nulls(address_values_persisted,Layout_Specificities.address_ChildRec,nv) // Use automated NULL spotting
EXPORT address_nulls := nv;
SALT35.MAC_Field_Bfoul(address_deduped,address,POWID,address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT address_switch := bf;
EXPORT address_max := MAX(address_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(address_values_persisted,address,address_nulls,ol) // Compute column level specificity
EXPORT address_specificity := ol;
 
EXPORT dt_first_seenValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::dt_first_seen';
 
EXPORT dt_first_seen_values_index := INDEX(dt_first_seen_values_persisted_temp,{dt_first_seen},{dt_first_seen_values_persisted_temp},dt_first_seenValuesIndexKeyName);
EXPORT dt_first_seen_values_persisted := dt_first_seen_values_index;
SALT35.MAC_Field_Nulls(dt_first_seen_values_persisted,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT35.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,POWID,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
 
EXPORT dt_last_seenValuesIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Word::dt_last_seen';
 
EXPORT dt_last_seen_values_index := INDEX(dt_last_seen_values_persisted_temp,{dt_last_seen},{dt_last_seen_values_persisted_temp},dt_last_seenValuesIndexKeyName);
EXPORT dt_last_seen_values_persisted := dt_last_seen_values_index;
SALT35.MAC_Field_Nulls(dt_last_seen_values_persisted,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT35.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,POWID,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT35.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(orgid_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(csz_values_index, OVERWRITE),BUILDINDEX(addr1_values_index, OVERWRITE),BUILDINDEX(address_values_index, OVERWRITE),BUILDINDEX(dt_first_seen_values_index, OVERWRITE),BUILDINDEX(dt_last_seen_values_index, OVERWRITE));
EXPORT BuildAll := BuildFields;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Specificities';
iSpecificities := DATASET([{0,orgid_specificity,orgid_switch,orgid_max,orgid_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,st_specificity,st_switch,st_max,st_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,csz_specificity,csz_switch,csz_max,csz_nulls,addr1_specificity,addr1_switch,addr1_max,addr1_nulls,address_specificity,address_switch,address_max,address_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( BuildAll, BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 orgid_shift0 := ROUND(Specificities[1].orgid_specificity - 28);
  integer2 orgid_switch_shift0 := ROUND(1000*Specificities[1].orgid_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 14);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 6);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 7);
  integer1 csz_shift0 := ROUND(Specificities[1].csz_specificity - 14);
  integer2 csz_switch_shift0 := ROUND(1000*Specificities[1].csz_switch - 19);
  integer1 addr1_shift0 := ROUND(Specificities[1].addr1_specificity - 22);
  integer2 addr1_switch_shift0 := ROUND(1000*Specificities[1].addr1_switch - 0);
  integer1 address_shift0 := ROUND(Specificities[1].address_specificity - 25);
  integer2 address_switch_shift0 := ROUND(1000*Specificities[1].address_switch - 19);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT35.MAC_Specificity_Values(orgid_values_persisted,orgid,'orgid',orgid_specificity,orgid_specificity_profile);
  SALT35.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT35.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT35.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT35.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT35.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
EXPORT AllProfiles := orgid_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + st_specificity_profile + v_city_name_specificity_profile + zip_specificity_profile;
END;
 
