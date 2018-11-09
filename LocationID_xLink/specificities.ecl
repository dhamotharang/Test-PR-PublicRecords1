IMPORT SALT37;
EXPORT specificities(DATASET(layout_LocationId) ih) := MODULE
 
EXPORT ih_init := SALT37.initNullIDs.baseLevel(ih,rid,LocId);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT37.UIDType LocId := h.LocId; // using existing id field
  h.rid;//RIDfield 
  h.prim_range;
  h.predir;
  UNSIGNED1 predir_len := LENGTH(TRIM((SALT37.StrType)h.predir));
  h.prim_name;
  UNSIGNED1 prim_name_len := LENGTH(TRIM((SALT37.StrType)h.prim_name));
  h.addr_suffix;
  UNSIGNED1 addr_suffix_len := LENGTH(TRIM((SALT37.StrType)h.addr_suffix));
  h.postdir;
  UNSIGNED1 postdir_len := LENGTH(TRIM((SALT37.StrType)h.postdir));
  h.unit_desig;
  UNSIGNED1 unit_desig_len := LENGTH(TRIM((SALT37.StrType)h.unit_desig));
  h.sec_range;
  h.v_city_name;
  UNSIGNED1 v_city_name_len := LENGTH(TRIM((SALT37.StrType)h.v_city_name));
  h.st;
  h.zip5;
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(LocId<>0),r),HASH(LocId)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::LocId::LocationId_xLink::Specificities_Cache',EXPIRE(LocationId_xLink._CFG.PersistExpire));
//We have LocId specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.LocId;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,LocId,LOCAL) : PERSIST('~temp::LocId::LocationId_xLink::Cluster_Sizes',EXPIRE(LocationId_xLink._CFG.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  prim_range_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,prim_range) : PERSIST('~temp::LocId::LocationId_xLink::dedups::prim_range',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(prim_range_deduped,prim_range,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted := specs_added : PERSIST('~temp::LocId::LocationId_xLink::values::prim_range',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  predir_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,predir) : PERSIST('~temp::LocId::LocationId_xLink::dedups::predir',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(predir_deduped,predir,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,predir,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT predir_values_persisted := distance_computed : PERSIST('~temp::LocId::LocationId_xLink::values::predir',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  prim_name_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,prim_name) : PERSIST('~temp::LocId::LocationId_xLink::dedups::prim_name',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(prim_name_deduped,LocId,prim_name,1); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,prim_name,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,prim_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT prim_name_values_persisted := distance_computed : PERSIST('~temp::LocId::LocationId_xLink::values::prim_name',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  addr_suffix_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,addr_suffix) : PERSIST('~temp::LocId::LocationId_xLink::dedups::addr_suffix',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(addr_suffix_deduped,addr_suffix,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,addr_suffix,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT addr_suffix_values_persisted := distance_computed : PERSIST('~temp::LocId::LocationId_xLink::values::addr_suffix',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  postdir_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,postdir) : PERSIST('~temp::LocId::LocationId_xLink::dedups::postdir',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(postdir_deduped,postdir,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,postdir,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT postdir_values_persisted := distance_computed : PERSIST('~temp::LocId::LocationId_xLink::values::postdir',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  unit_desig_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,unit_desig) : PERSIST('~temp::LocId::LocationId_xLink::dedups::unit_desig',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(unit_desig_deduped,unit_desig,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,unit_desig,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT unit_desig_values_persisted := distance_computed : PERSIST('~temp::LocId::LocationId_xLink::values::unit_desig',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  sec_range_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,sec_range) : PERSIST('~temp::LocId::LocationId_xLink::dedups::sec_range',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(sec_range_deduped,LocId,sec_range,1); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,sec_range,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted := specs_added : PERSIST('~temp::LocId::LocationId_xLink::values::sec_range',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  v_city_name_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,v_city_name) : PERSIST('~temp::LocId::LocationId_xLink::dedups::v_city_name',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,v_city_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT v_city_name_values_persisted := distance_computed : PERSIST('~temp::LocId::LocationId_xLink::values::v_city_name',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  st_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,st) : PERSIST('~temp::LocId::LocationId_xLink::dedups::st',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(st_deduped,st,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted := specs_added : PERSIST('~temp::LocId::LocationId_xLink::values::st',EXPIRE(LocationId_xLink._CFG.PersistExpire));
 
EXPORT  zip5_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,zip5) : PERSIST('~temp::LocId::LocationId_xLink::dedups::zip5',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(zip5_deduped,zip5,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip5_values_persisted := specs_added : PERSIST('~temp::LocId::LocationId_xLink::values::zip5',EXPIRE(LocationId_xLink._CFG.PersistExpire));
SALT37.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT37.MAC_Field_Bfoul(prim_range_deduped,prim_range,LocId,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
SALT37.MAC_Field_Nulls(predir_values_persisted,Layout_Specificities.predir_ChildRec,nv) // Use automated NULL spotting
EXPORT predir_nulls := nv;
SALT37.MAC_Field_Bfoul(predir_deduped,predir,LocId,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT predir_switch := bf;
EXPORT predir_max := MAX(predir_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
EXPORT predir_specificity := ol;
SALT37.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT37.MAC_Field_Bfoul(prim_name_deduped,prim_name,LocId,prim_name_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
SALT37.MAC_Field_Nulls(addr_suffix_values_persisted,Layout_Specificities.addr_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT addr_suffix_nulls := nv;
SALT37.MAC_Field_Bfoul(addr_suffix_deduped,addr_suffix,LocId,addr_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT addr_suffix_switch := bf;
EXPORT addr_suffix_max := MAX(addr_suffix_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(addr_suffix_values_persisted,addr_suffix,addr_suffix_nulls,ol) // Compute column level specificity
EXPORT addr_suffix_specificity := ol;
SALT37.MAC_Field_Nulls(postdir_values_persisted,Layout_Specificities.postdir_ChildRec,nv) // Use automated NULL spotting
EXPORT postdir_nulls := nv;
SALT37.MAC_Field_Bfoul(postdir_deduped,postdir,LocId,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT postdir_switch := bf;
EXPORT postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
EXPORT postdir_specificity := ol;
SALT37.MAC_Field_Nulls(unit_desig_values_persisted,Layout_Specificities.unit_desig_ChildRec,nv) // Use automated NULL spotting
EXPORT unit_desig_nulls := nv;
SALT37.MAC_Field_Bfoul(unit_desig_deduped,unit_desig,LocId,unit_desig_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT unit_desig_switch := bf;
EXPORT unit_desig_max := MAX(unit_desig_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(unit_desig_values_persisted,unit_desig,unit_desig_nulls,ol) // Compute column level specificity
EXPORT unit_desig_specificity := ol;
SALT37.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT37.MAC_Field_Bfoul(sec_range_deduped,sec_range,LocId,sec_range_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
SALT37.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT37.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,LocId,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
SALT37.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT37.MAC_Field_Bfoul(st_deduped,st,LocId,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
SALT37.MAC_Field_Nulls(zip5_values_persisted,Layout_Specificities.zip5_ChildRec,nv) // Use automated NULL spotting
EXPORT zip5_nulls := nv;
SALT37.MAC_Field_Bfoul(zip5_deduped,zip5,LocId,zip5_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip5_switch := bf;
EXPORT zip5_max := MAX(zip5_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(zip5_values_persisted,zip5,zip5_nulls,ol) // Compute column level specificity
EXPORT zip5_specificity := ol;
iSpecificities := DATASET([{0,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,addr_suffix_specificity,addr_suffix_switch,addr_suffix_max,addr_suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,unit_desig_specificity,unit_desig_switch,unit_desig_max,unit_desig_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip5_specificity,zip5_switch,zip5_max,zip5_nulls}],Layout_Specificities.R) : PERSIST('~temp::LocId::LocationId_xLink::Specificities',EXPIRE(LocationId_xLink._CFG.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 5);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 16);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 addr_suffix_shift0 := ROUND(Specificities[1].addr_suffix_specificity - 4);
  integer2 addr_suffix_switch_shift0 := ROUND(1000*Specificities[1].addr_suffix_switch - 0);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 7);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 0);
  integer1 unit_desig_shift0 := ROUND(Specificities[1].unit_desig_specificity - 7);
  integer2 unit_desig_switch_shift0 := ROUND(1000*Specificities[1].unit_desig_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 13);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 0);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 12);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip5_shift0 := ROUND(Specificities[1].zip5_specificity - 14);
  integer2 zip5_switch_shift0 := ROUND(1000*Specificities[1].zip5_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT37.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT37.MAC_Specificity_Values(predir_values_persisted,predir,'predir',predir_specificity,predir_specificity_profile);
  SALT37.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT37.MAC_Specificity_Values(addr_suffix_values_persisted,addr_suffix,'addr_suffix',addr_suffix_specificity,addr_suffix_specificity_profile);
  SALT37.MAC_Specificity_Values(postdir_values_persisted,postdir,'postdir',postdir_specificity,postdir_specificity_profile);
  SALT37.MAC_Specificity_Values(unit_desig_values_persisted,unit_desig,'unit_desig',unit_desig_specificity,unit_desig_specificity_profile);
  SALT37.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT37.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT37.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT37.MAC_Specificity_Values(zip5_values_persisted,zip5,'zip5',zip5_specificity,zip5_specificity_profile);
EXPORT AllProfiles := prim_range_specificity_profile + predir_specificity_profile + prim_name_specificity_profile + addr_suffix_specificity_profile + postdir_specificity_profile + unit_desig_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip5_specificity_profile;
END;
 
