IMPORT SALT311,std;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_LGID3) ih) := MODULE
 
EXPORT ih_init := SALT311.initNullIDs.upperLevel(ih,proxid,LGID3);
 
SHARED h := ih_init;
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT311.UIDType LGID3 := h.LGID3; // using existing id field
  SALT311.UIDType seleid := h.seleid; // Copy ID from hierarchy
  SALT311.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT311.UIDType ultid := h.ultid; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.sbfe_id;
  h.nodes_below_st;
  h.Lgid3IfHrchy;
  h.OriginalSeleId;
  h.OriginalOrgId;
  TYPEOF(h.company_name) company_name := (TYPEOF(h.company_name))Fields.Make_company_name((SALT311.StrType)h.company_name ); // Cleans before using
  h.cnp_number;
  h.active_duns_number;
  h.duns_number;
  UNSIGNED4 duns_number_concept := 0; // Place holder filled in by project
  h.company_fein;
  h.company_inc_state;
  h.company_charter_number;
  h.cnp_btype;
  h.company_name_type_derived;
  h.hist_duns_number;
  h.active_domestic_corp_key;
  h.hist_domestic_corp_key;
  h.foreign_corp_key;
  h.unk_corp_key;
  h.cnp_name;
  h.cnp_hasNumber;
  h.cnp_lowv;
  h.cnp_translated;
  h.cnp_classid;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip;
  h.has_lgid;
  h.is_sele_level;
  h.is_org_level;
  h.is_ult_level;
  h.parent_proxid;
  h.sele_proxid;
  h.org_proxid;
  h.ultimate_proxid;
  h.levels_from_top;
  h.nodes_total;
  h.dt_first_seen;
  h.dt_last_seen;
  Config.PartitionFieldType SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(LGID3<>0),r),HASH(LGID3)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.duns_number_concept := IF (Fields.InValid_duns_number_concept((SALT311.StrType)le.active_duns_number,(SALT311.StrType)le.duns_number)>0,0,HASH32((SALT311.StrType)le.active_duns_number,(SALT311.StrType)le.duns_number)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT311.MAC_Partition_Stars(h02,SALT_Partition,LGID3); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_nodes_below_st((SALT311.StrType)h0.nodes_below_st)>0 OR Fields.Invalid_company_name((SALT311.StrType)h0.company_name)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject) : PERSIST('~temp::LGID3::BIPV2_LGID3::Specificities_Cache',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
//We have LGID3 specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.LGID3;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,LGID3,LOCAL) : PERSIST('~temp::LGID3::BIPV2_LGID3::Cluster_Sizes',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  sbfe_id_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,sbfe_id); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(sbfe_id_deduped,sbfe_id,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sbfe_id_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::sbfe_id',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  Lgid3IfHrchy_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,Lgid3IfHrchy); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(Lgid3IfHrchy_deduped,Lgid3IfHrchy,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT Lgid3IfHrchy_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::Lgid3IfHrchy',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  company_name_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,company_name); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_name_deduped,company_name,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED company_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(company_name_deduped,LGID3,company_name,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,company_name,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT company_name_ad_temp := wb_specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::wbspecs::company_name',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(company_name_sa,company_name,company_name_ad_temp,p);
EXPORT company_name_values_persisted_temp := p : PERSIST('~temp::LGID3::BIPV2_LGID3::values::company_name',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  cnp_number_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,cnp_number); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::cnp_number',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  active_duns_number_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,active_duns_number); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_duns_number_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::active_duns_number',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  duns_number_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,duns_number); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(duns_number_deduped,duns_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT duns_number_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::duns_number',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  duns_number_concept_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,duns_number_concept); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(duns_number_concept_deduped,duns_number_concept,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT duns_number_concept_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::duns_number_concept',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  company_fein_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,company_fein); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_fein_deduped,company_fein,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_fein_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::company_fein',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  company_inc_state_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,company_inc_state); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_inc_state_deduped,company_inc_state,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_inc_state_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::company_inc_state',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  company_charter_number_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,company_charter_number); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_charter_number_deduped,company_charter_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_charter_number_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::company_charter_number',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  cnp_btype_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,cnp_btype); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_btype_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::cnp_btype',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  dt_first_seen_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,dt_first_seen); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::dt_first_seen',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT  dt_last_seen_deduped := SALT311.MAC_Field_By_UID(input_file,LGID3,dt_last_seen); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted_temp := specs_added : PERSIST('~temp::LGID3::BIPV2_LGID3::values::dt_last_seen',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT sbfe_idValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::sbfe_id';
 
EXPORT sbfe_id_values_index := INDEX(sbfe_id_values_persisted_temp,{sbfe_id},{sbfe_id_values_persisted_temp},sbfe_idValuesIndexKeyName);
EXPORT sbfe_id_values_persisted := sbfe_id_values_index;
SALT311.MAC_Field_Nulls(sbfe_id_values_persisted_temp,Layout_Specificities.sbfe_id_ChildRec,nv) // Use automated NULL spotting
EXPORT sbfe_id_nulls := nv;
SALT311.MAC_Field_Bfoul(sbfe_id_deduped,sbfe_id,LGID3,sbfe_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sbfe_id_switch := bf;
EXPORT sbfe_id_max := MAX(sbfe_id_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(sbfe_id_values_persisted_temp,sbfe_id,sbfe_id_nulls,ol) // Compute column level specificity
EXPORT sbfe_id_specificity := ol;
 
EXPORT Lgid3IfHrchyValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::Lgid3IfHrchy';
 
EXPORT Lgid3IfHrchy_values_index := INDEX(Lgid3IfHrchy_values_persisted_temp,{Lgid3IfHrchy},{Lgid3IfHrchy_values_persisted_temp},Lgid3IfHrchyValuesIndexKeyName);
EXPORT Lgid3IfHrchy_values_persisted := Lgid3IfHrchy_values_index;
SALT311.MAC_Field_Nulls(Lgid3IfHrchy_values_persisted_temp,Layout_Specificities.Lgid3IfHrchy_ChildRec,nv) // Use automated NULL spotting
EXPORT Lgid3IfHrchy_nulls := nv;
SALT311.MAC_Field_Bfoul(Lgid3IfHrchy_deduped,Lgid3IfHrchy,LGID3,Lgid3IfHrchy_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT Lgid3IfHrchy_switch := bf;
EXPORT Lgid3IfHrchy_max := MAX(Lgid3IfHrchy_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(Lgid3IfHrchy_values_persisted_temp,Lgid3IfHrchy,Lgid3IfHrchy_nulls,ol) // Compute column level specificity
EXPORT Lgid3IfHrchy_specificity := ol;
 
EXPORT company_nameWBTokenSpecKeyName := '~'+'key::BIPV2_LGID3::LGID3::WordBag_specs::company_name';
 
EXPORT company_name_wbtokenspec_index := INDEX(company_name_ad_temp,{company_name},{company_name_ad_temp},company_nameWBTokenSpecKeyName);
EXPORT company_name_ad := company_name_wbtokenspec_index;
 
EXPORT company_nameValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_name';
 
EXPORT company_name_values_index := INDEX(company_name_values_persisted_temp,{company_name},{company_name_values_persisted_temp},company_nameValuesIndexKeyName);
EXPORT company_name_values_persisted := company_name_values_index;
EXPORT company_name_nulls := DATASET([{'',0,0}],Layout_Specificities.company_name_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(company_name_deduped,company_name,LGID3,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_switch := bf;
EXPORT company_name_max := MAX(company_name_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_name_values_persisted_temp,company_name,company_name_nulls,ol) // Compute column level specificity
EXPORT company_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT311.MAC_Field_Nulls(cnp_number_values_persisted_temp,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT311.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,LGID3,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(cnp_number_values_persisted_temp,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::active_duns_number';
 
EXPORT active_duns_number_values_index := INDEX(active_duns_number_values_persisted_temp,{active_duns_number},{active_duns_number_values_persisted_temp},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT311.MAC_Field_Nulls(active_duns_number_values_persisted_temp,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT311.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,LGID3,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(active_duns_number_values_persisted_temp,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT duns_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::duns_number';
 
EXPORT duns_number_values_index := INDEX(duns_number_values_persisted_temp,{duns_number},{duns_number_values_persisted_temp},duns_numberValuesIndexKeyName);
EXPORT duns_number_values_persisted := duns_number_values_index;
SALT311.MAC_Field_Nulls(duns_number_values_persisted_temp,Layout_Specificities.duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT duns_number_nulls := nv;
SALT311.MAC_Field_Bfoul(duns_number_deduped,duns_number,LGID3,duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT duns_number_switch := bf;
EXPORT duns_number_max := MAX(duns_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(duns_number_values_persisted_temp,duns_number,duns_number_nulls,ol) // Compute column level specificity
EXPORT duns_number_specificity := ol;
 
EXPORT duns_number_conceptValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::duns_number_concept';
 
EXPORT duns_number_concept_values_index := INDEX(duns_number_concept_values_persisted_temp,{duns_number_concept},{duns_number_concept_values_persisted_temp},duns_number_conceptValuesIndexKeyName);
EXPORT duns_number_concept_values_persisted := duns_number_concept_values_index;
SALT311.MAC_Field_Nulls(duns_number_concept_values_persisted_temp,Layout_Specificities.duns_number_concept_ChildRec,nv) // Use automated NULL spotting
EXPORT duns_number_concept_nulls := nv;
SALT311.MAC_Field_Bfoul(duns_number_concept_deduped,duns_number_concept,LGID3,duns_number_concept_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT duns_number_concept_switch := bf;
EXPORT duns_number_concept_max := MAX(duns_number_concept_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(duns_number_concept_values_persisted_temp,duns_number_concept,duns_number_concept_nulls,ol) // Compute column level specificity
EXPORT duns_number_concept_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT311.MAC_Field_Nulls(company_fein_values_persisted_temp,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT311.MAC_Field_Bfoul(company_fein_deduped,company_fein,LGID3,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_fein_values_persisted_temp,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT company_inc_stateValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_inc_state';
 
EXPORT company_inc_state_values_index := INDEX(company_inc_state_values_persisted_temp,{company_inc_state},{company_inc_state_values_persisted_temp},company_inc_stateValuesIndexKeyName);
EXPORT company_inc_state_values_persisted := company_inc_state_values_index;
SALT311.MAC_Field_Nulls(company_inc_state_values_persisted_temp,Layout_Specificities.company_inc_state_ChildRec,nv) // Use automated NULL spotting
EXPORT company_inc_state_nulls := nv;
SALT311.MAC_Field_Bfoul(company_inc_state_deduped,company_inc_state,LGID3,company_inc_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_inc_state_switch := bf;
EXPORT company_inc_state_max := MAX(company_inc_state_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_inc_state_values_persisted_temp,company_inc_state,company_inc_state_nulls,ol) // Compute column level specificity
EXPORT company_inc_state_specificity := ol;
 
EXPORT company_charter_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_charter_number';
 
EXPORT company_charter_number_values_index := INDEX(company_charter_number_values_persisted_temp,{company_charter_number},{company_charter_number_values_persisted_temp},company_charter_numberValuesIndexKeyName);
EXPORT company_charter_number_values_persisted := company_charter_number_values_index;
SALT311.MAC_Field_Nulls(company_charter_number_values_persisted_temp,Layout_Specificities.company_charter_number_ChildRec,nv) // Use automated NULL spotting
EXPORT company_charter_number_nulls := nv;
SALT311.MAC_Field_Bfoul(company_charter_number_deduped,company_charter_number,LGID3,company_charter_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_charter_number_switch := bf;
EXPORT company_charter_number_max := MAX(company_charter_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_charter_number_values_persisted_temp,company_charter_number,company_charter_number_nulls,ol) // Compute column level specificity
EXPORT company_charter_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::cnp_btype';
 
EXPORT cnp_btype_values_index := INDEX(cnp_btype_values_persisted_temp,{cnp_btype},{cnp_btype_values_persisted_temp},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,LGID3,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(cnp_btype_values_persisted_temp,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT dt_first_seenValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::dt_first_seen';
 
EXPORT dt_first_seen_values_index := INDEX(dt_first_seen_values_persisted_temp,{dt_first_seen},{dt_first_seen_values_persisted_temp},dt_first_seenValuesIndexKeyName);
EXPORT dt_first_seen_values_persisted := dt_first_seen_values_index;
SALT311.MAC_Field_Nulls(dt_first_seen_values_persisted_temp,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,LGID3,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(dt_first_seen_values_persisted_temp,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
 
EXPORT dt_last_seenValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::dt_last_seen';
 
EXPORT dt_last_seen_values_index := INDEX(dt_last_seen_values_persisted_temp,{dt_last_seen},{dt_last_seen_values_persisted_temp},dt_last_seenValuesIndexKeyName);
EXPORT dt_last_seen_values_persisted := dt_last_seen_values_index;
SALT311.MAC_Field_Nulls(dt_last_seen_values_persisted_temp,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,LGID3,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(dt_last_seen_values_persisted_temp,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(sbfe_id_values_index, OVERWRITE),BUILDINDEX(Lgid3IfHrchy_values_index, OVERWRITE),BUILDINDEX(company_name_wbtokenspec_index, OVERWRITE),BUILDINDEX(company_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(duns_number_values_index, OVERWRITE),BUILDINDEX(duns_number_concept_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(company_inc_state_values_index, OVERWRITE),BUILDINDEX(company_charter_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE),BUILDINDEX(dt_first_seen_values_index, OVERWRITE),BUILDINDEX(dt_last_seen_values_index, OVERWRITE));
 
  infile := file_underLink;
 r := RECORD
    Config.AttrValueType Basis := TRIM((SALT311.StrType)infile.UnderLinkId);
    infile.UnderLinkId; // Easy way to get component values
    INTEGER2 UnderLinkId_weight100 := 0; // Easy place to store weight
    SALT311.UIDType LGID3 := infile.LGID3;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED UnderLinks_attributes := DEDUP( SORT( DISTRIBUTE( t, LGID3 ), LGID3, Basis, LOCAL), LGID3, Basis, LOCAL) : PERSIST('~temp::LGID3::BIPV2_LGID3::values::UnderLinks',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
  SALT311.Mac_Specificity_Local(UnderLinks_attributes,Basis,LGID3,UnderLinks_nulls,Layout_Specificities.UnderLinks_ChildRec,UnderLinks_specificity,UnderLinks_switch,UnderLinks_values);
EXPORT UnderLinks_max := MAX(UnderLinks_values,field_specificity);
 
EXPORT UnderLinksValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::UnderLinks';
  TYPEOF(UnderLinks_attributes) take(UnderLinks_attributes le,UnderLinks_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.UnderLinkId_weight100 := SELF.Basis_weight100 / 1;
    SELF := le;
  END;
  non_null_atts := UnderLinks_attributes(Basis NOT IN SET(UnderLinks_nulls,Basis));
SALT311.MAC_Choose_JoinType(non_null_atts,UnderLinks_nulls,UnderLinks_values,Basis,Basis_weight100,take,UnderLinks_v);
 
EXPORT UnderLinks_values_index := INDEX(UnderLinks_v,{Basis},{UnderLinks_v},UnderLinksValuesIndexKeyName);
EXPORT UnderLinks_values_persisted := UnderLinks_values_index;
 
EXPORT BuildAttributes := BUILDINDEX(UnderLinks_values_index, OVERWRITE);
EXPORT Layout_Uber_Plus := RECORD(SALT311.Layout_Uber_Record0)
  SALT311.Str30Type word;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(input_file le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.sbfe_id,(SALT311.StrType)le.nodes_below_st,(SALT311.StrType)le.Lgid3IfHrchy,(SALT311.StrType)le.OriginalSeleId,(SALT311.StrType)le.OriginalOrgId,'',(SALT311.StrType)le.cnp_number,(SALT311.StrType)le.active_duns_number,(SALT311.StrType)le.duns_number,SKIP,(SALT311.StrType)le.company_fein,(SALT311.StrType)le.company_inc_state,(SALT311.StrType)le.company_charter_number,(SALT311.StrType)le.cnp_btype,(SALT311.StrType)le.company_name_type_derived,(SALT311.StrType)le.hist_duns_number,(SALT311.StrType)le.active_domestic_corp_key,(SALT311.StrType)le.hist_domestic_corp_key,(SALT311.StrType)le.foreign_corp_key,(SALT311.StrType)le.unk_corp_key,(SALT311.StrType)le.cnp_name,(SALT311.StrType)le.cnp_hasNumber,(SALT311.StrType)le.cnp_lowv,(SALT311.StrType)le.cnp_translated,(SALT311.StrType)le.cnp_classid,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.has_lgid,(SALT311.StrType)le.is_sele_level,(SALT311.StrType)le.is_org_level,(SALT311.StrType)le.is_ult_level,(SALT311.StrType)le.parent_proxid,(SALT311.StrType)le.sele_proxid,(SALT311.StrType)le.org_proxid,(SALT311.StrType)le.ultimate_proxid,(SALT311.StrType)le.levels_from_top,(SALT311.StrType)le.nodes_total,'','',SKIP);
  SELF.field := c;
  SELF.uid := le.LGID3;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(input_file,43,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Wordbag_Field(input_file,company_name,6,LGID3,layout_uber_plus,nfields6);
SALT311.MAC_Expand_Normal_Field(input_file,active_duns_number,10,LGID3,layout_uber_plus,nfields2330);
SALT311.MAC_Expand_Normal_Field(input_file,duns_number,10,LGID3,layout_uber_plus,nfields2331);
nfields10 := nfields2330+nfields2331;//Collect wordbags for parts of concept field
NumberBaseFields := 43;
 
infileUnderLinks := file_underLink;
Layout_Uber_Plus IntoInversion0(infileUnderLinks le,UNSIGNED2 c,UNSIGNED el=1) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.UnderLinkId,SKIP);
  SELF.field := c+0+NumberBaseFields; // Field number is attr file + Fields from attr files + BaseFields
  SELF.uid := le.LGID3;
  SELF := le;
END;
afields0 := NORMALIZE(infileUnderLinks,1,IntoInversion0(LEFT,COUNTER))(word<>'');
SHARED invert_records := nfields_r + nfields6 + afields0;
uber_values_deduped0 := Fn_Reduce_UBER_Local( DISTRIBUTE(invert_records,HASH(uid)));
// minimize otherwise required changes to the macros used by uber and specificities!
Layout_Uber_Plus_Spec := RECORD(Layout_Uber_Plus AND NOT uid)
  SALT311.UIDType LGID3;
END;
SHARED uber_values_deduped := PROJECT(uber_values_deduped0,TRANSFORM(Layout_Uber_Plus_Spec,SELF.LGID3:=LEFT.uid,SELF:=LEFT));
SALT311.MAC_Specificity_Local(uber_values_deduped,word,LGID3,uber_nulls,Layout_Specificities.uber_ChildRec,word_specificity,word_switch,word_values)
EXPORT uber_values_persisted_temp := word_values : PERSIST('~temp::LGID3::BIPV2_LGID3::values::uber',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
 
EXPORT UbervaluesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::Uber';
 
EXPORT uber_values_index := INDEX(uber_values_persisted_temp,{word},{uber_values_persisted_temp},UbervaluesIndexKeyName);
EXPORT Uber_values_persisted := uber_values_index;
 
EXPORT BuildUber := BUILDINDEX(uber_values_index, OVERWRITE);
SALT311.MAC_Field_Bfoul(uber_values_deduped,word,LGID3,uber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT uber_switch := bf;
EXPORT uber_max := MAX(uber_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(uber_values_persisted_temp,word,uber_nulls,ol) // Compute column level specificity;
EXPORT uber_specificity := ol;
EXPORT BuildAll := PARALLEL(BuildFields, BuildAttributes, BuildUber);
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Specificities';
iSpecificities := DATASET([{0,sbfe_id_specificity,sbfe_id_switch,sbfe_id_max,sbfe_id_nulls,Lgid3IfHrchy_specificity,Lgid3IfHrchy_switch,Lgid3IfHrchy_max,Lgid3IfHrchy_nulls,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,duns_number_specificity,duns_number_switch,duns_number_max,duns_number_nulls,duns_number_concept_specificity,duns_number_concept_switch,duns_number_concept_max,duns_number_concept_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_inc_state_specificity,company_inc_state_switch,company_inc_state_max,company_inc_state_nulls,company_charter_number_specificity,company_charter_number_switch,company_charter_number_max,company_charter_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,UnderLinks_specificity,UnderLinks_switch,UnderLinks_max,UnderLinks_nulls,uber_specificity,uber_switch,uber_max,uber_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT BuildSpec := BUILDINDEX(Specificities_Index, OVERWRITE, FEW);
 
EXPORT Build := SEQUENTIAL(BuildAll, BuildSpec);
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 sbfe_id_shift0 := ROUND(Specificities[1].sbfe_id_specificity - 27);
  integer2 sbfe_id_switch_shift0 := ROUND(1000*Specificities[1].sbfe_id_switch - 475);
  integer1 Lgid3IfHrchy_shift0 := ROUND(Specificities[1].Lgid3IfHrchy_specificity - 27);
  integer2 Lgid3IfHrchy_switch_shift0 := ROUND(1000*Specificities[1].Lgid3IfHrchy_switch - 0);
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 26);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 398);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 13);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 2);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 27);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 57);
  integer1 duns_number_shift0 := ROUND(Specificities[1].duns_number_specificity - 27);
  integer2 duns_number_switch_shift0 := ROUND(1000*Specificities[1].duns_number_switch - 68);
  integer1 duns_number_concept_shift0 := ROUND(Specificities[1].duns_number_concept_specificity - 27);
  integer2 duns_number_concept_switch_shift0 := ROUND(1000*Specificities[1].duns_number_concept_switch - 111);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 26);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 196);
  integer1 company_inc_state_shift0 := ROUND(Specificities[1].company_inc_state_specificity - 6);
  integer2 company_inc_state_switch_shift0 := ROUND(1000*Specificities[1].company_inc_state_switch - 34);
  integer1 company_charter_number_shift0 := ROUND(Specificities[1].company_charter_number_specificity - 26);
  integer2 company_charter_number_switch_shift0 := ROUND(1000*Specificities[1].company_charter_number_switch - 110);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 56);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  INTEGER1 UnderLinks_shift0 := ROUND(Specificities[1].UnderLinks_specificity - 41);
  INTEGER2 UnderLinks_switch_shift0 := ROUND(1000*Specificities[1].UnderLinks_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT311.MAC_Specificity_Values(sbfe_id_values_persisted,sbfe_id,'sbfe_id',sbfe_id_specificity,sbfe_id_specificity_profile);
  SALT311.MAC_Specificity_Values(Lgid3IfHrchy_values_persisted,Lgid3IfHrchy,'Lgid3IfHrchy',Lgid3IfHrchy_specificity,Lgid3IfHrchy_specificity_profile);
  SALT311.MAC_Specificity_Values(company_name_values_persisted,company_name,'company_name',company_name_specificity,company_name_specificity_profile);
  SALT311.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT311.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT311.MAC_Specificity_Values(duns_number_values_persisted,duns_number,'duns_number',duns_number_specificity,duns_number_specificity_profile);
  SALT311.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT311.MAC_Specificity_Values(company_inc_state_values_persisted,company_inc_state,'company_inc_state',company_inc_state_specificity,company_inc_state_specificity_profile);
  SALT311.MAC_Specificity_Values(company_charter_number_values_persisted,company_charter_number,'company_charter_number',company_charter_number_specificity,company_charter_number_specificity_profile);
  SALT311.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
EXPORT AllProfiles := sbfe_id_specificity_profile + Lgid3IfHrchy_specificity_profile + company_name_specificity_profile + cnp_number_specificity_profile + active_duns_number_specificity_profile + duns_number_specificity_profile + company_fein_specificity_profile + company_inc_state_specificity_profile + company_charter_number_specificity_profile + cnp_btype_specificity_profile;
END;
 
