IMPORT ut,SALT32;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_POWID) ih) := MODULE
 
EXPORT ih_init := SALT32.initNullIDs.baseLevel(ih,rcid,POWID);
 
SHARED h := ih_init;
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT32.UIDType POWID := h.POWID; // using existing id field
  SALT32.UIDType OrgID := h.OrgID; // Copy ID from hierarchy
  SALT32.UIDType UltID := h.UltID; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.num_incs;
  h.nodes_total;
  h.RID_If_Big_Biz;
  h.num_legal_names;
  TYPEOF(h.company_name) company_name := (TYPEOF(h.company_name))Fields.Make_company_name((SALT32.StrType)h.company_name ); // Cleans before using
  UNSIGNED1 company_name_len := LENGTH(TRIM((SALT32.StrType)h.company_name));
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))Fields.Make_cnp_name((SALT32.StrType)h.cnp_name ); // Cleans before using
  h.cnp_number;
  h.prim_range;
  h.prim_name;
  h.zip;
  h.zip4;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.company_inc_state;
  h.company_charter_number;
  h.active_duns_number;
  h.hist_duns_number;
  h.active_domestic_corp_key;
  h.hist_domestic_corp_key;
  h.foreign_corp_key;
  h.unk_corp_key;
  h.company_fein;
  h.cnp_btype;
  h.company_name_type_derived;
  h.company_bdid;
  h.dt_first_seen;
  h.dt_last_seen;
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(POWID<>0),r),HASH(POWID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT32.MAC_Partition_Stars(h02,SALT_Partition,POWID); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_num_incs((SALT32.StrType)h0.num_incs)>0 OR Fields.Invalid_nodes_total((SALT32.StrType)h0.nodes_total)>0 OR Fields.Invalid_num_legal_names((SALT32.StrType)h0.num_legal_names)>0 OR Fields.Invalid_zip4((SALT32.StrType)h0.zip4)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject) : PERSIST('~temp::POWID::BIPV2_POWID_Platform::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have POWID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.POWID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,POWID,LOCAL) : PERSIST('~temp::POWID::BIPV2_POWID_Platform::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  RID_If_Big_Biz_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,RID_If_Big_Biz); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(RID_If_Big_Biz_deduped,RID_If_Big_Biz,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT RID_If_Big_Biz_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::RID_If_Big_Biz',EXPIRE(Config.PersistExpire));
 
EXPORT  company_name_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,company_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(company_name_deduped,company_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED company_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT32.MAC_Field_Variants_WordBag(company_name_deduped,POWID,company_name,expanded)// expand out all variants of wordbag
  SALT32.Mac_Field_Count_UID(expanded,company_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT32.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED company_name_ad := wb_specs_added; // Hop over export
 
EXPORT company_nameValuesKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::WordBag::company_name';
 
EXPORT company_name_values_key := INDEX(company_name_ad,{company_name},{company_name_ad},company_nameValuesKeyName);
  SALT32.mac_wordbag_addweights(company_name_sa,company_name,company_name_ad,p);
EXPORT company_name_values_persisted_temp := p;
 
EXPORT  cnp_name_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,cnp_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED cnp_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT32.MAC_Field_Variants_WordBag(cnp_name_deduped,POWID,cnp_name,expanded)// expand out all variants of wordbag
  SALT32.Mac_Field_Count_UID(expanded,cnp_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT32.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED cnp_name_ad := wb_specs_added; // Hop over export
 
EXPORT cnp_nameValuesKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::WordBag::cnp_name';
 
EXPORT cnp_name_values_key := INDEX(cnp_name_ad,{cnp_name},{cnp_name_ad},cnp_nameValuesKeyName);
  SALT32.mac_wordbag_addweights(cnp_name_sa,cnp_name,cnp_name_ad,p);
EXPORT cnp_name_values_persisted_temp := p;
 
EXPORT  cnp_number_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,cnp_number); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::cnp_number',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_range_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,prim_range); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(prim_range_deduped,prim_range,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::prim_range',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_name_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,prim_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(prim_name_deduped,prim_name,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::prim_name',EXPIRE(Config.PersistExpire));
 
EXPORT  zip_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,zip); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(zip_deduped,zip,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::zip',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,dt_first_seen); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::dt_first_seen',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_deduped := SALT32.MAC_Field_By_UID(input_file,POWID,dt_last_seen); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,POWID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted_temp := specs_added : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::dt_last_seen',EXPIRE(Config.PersistExpire));
 
EXPORT BuildBOWFields := PARALLEL(BUILDINDEX(company_name_values_key, OVERWRITE),BUILDINDEX(cnp_name_values_key, OVERWRITE));
 
EXPORT RID_If_Big_BizValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::RID_If_Big_Biz';
 
EXPORT RID_If_Big_Biz_values_index := INDEX(RID_If_Big_Biz_values_persisted_temp,{RID_If_Big_Biz},{RID_If_Big_Biz_values_persisted_temp},RID_If_Big_BizValuesIndexKeyName);
EXPORT RID_If_Big_Biz_values_persisted := RID_If_Big_Biz_values_index;
SALT32.MAC_Field_Nulls(RID_If_Big_Biz_values_persisted,Layout_Specificities.RID_If_Big_Biz_ChildRec,nv) // Use automated NULL spotting
EXPORT RID_If_Big_Biz_nulls := nv;
SALT32.MAC_Field_Bfoul(RID_If_Big_Biz_deduped,RID_If_Big_Biz,POWID,RID_If_Big_Biz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT RID_If_Big_Biz_switch := bf;
EXPORT RID_If_Big_Biz_max := MAX(RID_If_Big_Biz_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(RID_If_Big_Biz_values_persisted,RID_If_Big_Biz,RID_If_Big_Biz_nulls,ol) // Compute column level specificity
EXPORT RID_If_Big_Biz_specificity := ol;
 
EXPORT company_nameValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::company_name';
 
EXPORT company_name_values_index := INDEX(company_name_values_persisted_temp,{company_name},{company_name_values_persisted_temp},company_nameValuesIndexKeyName);
EXPORT company_name_values_persisted := company_name_values_index;
EXPORT company_name_nulls := DATASET([{'',0,0}],Layout_Specificities.company_name_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(company_name_deduped,company_name,POWID,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_switch := bf;
EXPORT company_name_max := MAX(company_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(company_name_values_persisted,company_name,company_name_nulls,ol) // Compute column level specificity
EXPORT company_name_specificity := ol;
 
EXPORT cnp_nameValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::cnp_name';
 
EXPORT cnp_name_values_index := INDEX(cnp_name_values_persisted_temp,{cnp_name},{cnp_name_values_persisted_temp},cnp_nameValuesIndexKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
EXPORT cnp_name_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_name_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,POWID,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT32.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT32.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,POWID,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT32.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT32.MAC_Field_Bfoul(prim_range_deduped,prim_range,POWID,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT32.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT32.MAC_Field_Bfoul(prim_name_deduped,prim_name,POWID,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT32.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT32.MAC_Field_Bfoul(zip_deduped,zip,POWID,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT dt_first_seenValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::dt_first_seen';
 
EXPORT dt_first_seen_values_index := INDEX(dt_first_seen_values_persisted_temp,{dt_first_seen},{dt_first_seen_values_persisted_temp},dt_first_seenValuesIndexKeyName);
EXPORT dt_first_seen_values_persisted := dt_first_seen_values_index;
SALT32.MAC_Field_Nulls(dt_first_seen_values_persisted,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT32.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,POWID,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
 
EXPORT dt_last_seenValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::dt_last_seen';
 
EXPORT dt_last_seen_values_index := INDEX(dt_last_seen_values_persisted_temp,{dt_last_seen},{dt_last_seen_values_persisted_temp},dt_last_seenValuesIndexKeyName);
EXPORT dt_last_seen_values_persisted := dt_last_seen_values_index;
SALT32.MAC_Field_Nulls(dt_last_seen_values_persisted,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT32.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,POWID,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(RID_If_Big_Biz_values_index, OVERWRITE),BUILDINDEX(company_name_values_index, OVERWRITE),BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(dt_first_seen_values_index, OVERWRITE),BUILDINDEX(dt_last_seen_values_index, OVERWRITE));
 
  infile := _ds_attr_charter;
  r := RECORD
    Config.AttrValueType Basis := TRIM((SALT32.StrType)infile.company_charter_number) + '|' + TRIM((SALT32.StrType)infile.company_inc_state);
    infile.company_charter_number; // Easy way to get component values
    INTEGER2 company_charter_number_weight100 := 0; // Easy place to store weight
    infile.company_inc_state; // Easy way to get component values
    INTEGER2 company_inc_state_weight100 := 0; // Easy place to store weight
    SALT32.UIDType POWID := infile.powid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED charter_attributes := DEDUP( SORT( DISTRIBUTE( t, POWID ), POWID, Basis, LOCAL), POWID, Basis, LOCAL) : PERSIST('~temp::POWID::BIPV2_POWID_Platform::values::charter',EXPIRE(Config.PersistExpire));
  SALT32.Mac_Specificity_Local(charter_attributes,Basis,POWID,charter_nulls,Layout_Specificities.charter_ChildRec,charter_specificity,charter_switch,charter_values);
EXPORT charter_max := MAX(charter_values,field_specificity);
 
EXPORT charterValuesIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Word::charter';
  TYPEOF(charter_attributes) take(charter_attributes le,charter_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.company_charter_number_weight100 := SELF.Basis_weight100 / 2;
    SELF.company_inc_state_weight100 := SELF.Basis_weight100 / 2;
    SELF := le;
  END;
  non_null_atts := charter_attributes(Basis NOT IN SET(charter_nulls,Basis));
SALT32.MAC_Choose_JoinType(non_null_atts,charter_nulls,charter_values,Basis,Basis_weight100,take,charter_v);
 
EXPORT charter_values_index := INDEX(charter_v,{Basis},{charter_v},charterValuesIndexKeyName);
EXPORT charter_values_persisted := charter_values_index;
 
EXPORT BuildAttributes := BUILDINDEX(charter_values_index, OVERWRITE);
EXPORT BuildAll := PARALLEL(BuildFields, BuildAttributes);
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_POWID_Platform::POWID::Specificities';
iSpecificities := DATASET([{0,RID_If_Big_Biz_specificity,RID_If_Big_Biz_switch,RID_If_Big_Biz_max,RID_If_Big_Biz_nulls,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,charter_specificity,charter_switch,charter_max,charter_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( BuildAll, BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 RID_If_Big_Biz_shift0 := ROUND(Specificities[1].RID_If_Big_Biz_specificity - 26);
  integer2 RID_If_Big_Biz_switch_shift0 := ROUND(1000*Specificities[1].RID_If_Big_Biz_switch - 0);
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 25);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 277);
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 26);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 126);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 14);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 1);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  INTEGER1 charter_shift0 := ROUND(Specificities[1].charter_specificity - 26);
  INTEGER2 charter_switch_shift0 := ROUND(1000*Specificities[1].charter_switch - 1);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT32.MAC_Specificity_Values(RID_If_Big_Biz_values_persisted,RID_If_Big_Biz,'RID_If_Big_Biz',RID_If_Big_Biz_specificity,RID_If_Big_Biz_specificity_profile);
  SALT32.MAC_Specificity_Values(company_name_values_persisted,company_name,'company_name',company_name_specificity,company_name_specificity_profile);
  SALT32.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT32.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT32.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT32.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT32.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
EXPORT AllProfiles := RID_If_Big_Biz_specificity_profile + company_name_specificity_profile + cnp_name_specificity_profile + cnp_number_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + zip_specificity_profile;
END;
 
