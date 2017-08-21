IMPORT ut,SALT30;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_LGID3) h) := MODULE
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT30.UIDType LGID3 := h.LGID3; // using existing id field
  SALT30.UIDType seleid := h.seleid; // Copy ID from hierarchy
  SALT30.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT30.UIDType ultid := h.ultid; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.sbfe_id;
  h.nodes_below_st;
  h.Lgid3IfHrchy;
  h.OriginalSeleId;
  h.OriginalOrgId;
  h.company_name;
  h.cnp_number;
  h.active_duns_number;
  h.duns_number;
  unsigned4 duns_number_concept := 0; // Place holder filled in by project
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
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(LGID3<>0),r),HASH(LGID3)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.duns_number_concept := IF (Fields.InValid_duns_number_concept((SALT30.StrType)le.active_duns_number,(SALT30.StrType)le.duns_number),0,HASH32((SALT30.StrType)le.active_duns_number,(SALT30.StrType)le.duns_number)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT30.MAC_Partition_Stars(h02,SALT_Partition,LGID3); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_nodes_below_st((SALT30.StrType)h0.nodes_below_st)>0 OR Fields.Invalid_company_name((SALT30.StrType)h0.company_name)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject) : PERSIST('~temp::LGID3::BIPV2_LGID3::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have LGID3 specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.LGID3;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,LGID3,LOCAL) : PERSIST('~temp::LGID3::BIPV2_LGID3::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  sbfe_id_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,sbfe_id); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(sbfe_id_deduped,sbfe_id,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sbfe_id_values_persisted_temp := specs_added;
 
EXPORT  Lgid3IfHrchy_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,Lgid3IfHrchy); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(Lgid3IfHrchy_deduped,Lgid3IfHrchy,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT Lgid3IfHrchy_values_persisted_temp := specs_added;
 
EXPORT  company_name_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,company_name); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_name_deduped,company_name,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED company_name_sa := specs_added; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT30.MAC_Field_Variants_WordBag(company_name_deduped,LGID3,company_name,expanded)// expand out all variants of wordbag
  SALT30.Mac_Field_Count_UID(expanded,company_name,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  SALT30.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED company_name_ad := wb_specs_added; // Hop over export
 
EXPORT company_nameValuesKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_name';
 
EXPORT company_name_values_key := INDEX(company_name_ad,{company_name},{company_name_ad},company_nameValuesKeyName);
  SALT30.mac_wordbag_addweights(company_name_sa,company_name,company_name_ad,p);
EXPORT company_name_values_persisted_temp := p;
 
EXPORT  cnp_number_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,cnp_number); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added;
 
EXPORT  active_duns_number_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,active_duns_number); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_duns_number_values_persisted_temp := specs_added;
 
EXPORT  duns_number_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,duns_number); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(duns_number_deduped,duns_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT duns_number_values_persisted_temp := specs_added;
 
EXPORT  duns_number_concept_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,duns_number_concept); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(duns_number_concept_deduped,duns_number_concept,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT duns_number_concept_values_persisted_temp := specs_added;
 
EXPORT  company_fein_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,company_fein); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_fein_deduped,company_fein,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_fein_values_persisted_temp := specs_added;
 
EXPORT  company_inc_state_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,company_inc_state); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_inc_state_deduped,company_inc_state,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_inc_state_values_persisted_temp := specs_added;
 
EXPORT  company_charter_number_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,company_charter_number); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_charter_number_deduped,company_charter_number,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_charter_number_values_persisted_temp := specs_added;
 
EXPORT  cnp_btype_deduped := SALT30.MAC_Field_By_UID(input_file,LGID3,cnp_btype); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,LGID3,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_btype_values_persisted_temp := specs_added;
 
EXPORT sbfe_idValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::sbfe_id';
 
EXPORT sbfe_id_values_index := INDEX(sbfe_id_values_persisted_temp,{sbfe_id},{sbfe_id_values_persisted_temp},sbfe_idValuesIndexKeyName);
EXPORT sbfe_id_values_persisted := sbfe_id_values_index;
SALT30.MAC_Field_Nulls(sbfe_id_values_persisted,Layout_Specificities.sbfe_id_ChildRec,nv) // Use automated NULL spotting
EXPORT sbfe_id_nulls := nv;
SALT30.MAC_Field_Bfoul(sbfe_id_deduped,sbfe_id,LGID3,sbfe_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sbfe_id_switch := bf;
EXPORT sbfe_id_max := MAX(sbfe_id_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(sbfe_id_values_persisted,sbfe_id,sbfe_id_nulls,ol) // Compute column level specificity
EXPORT sbfe_id_specificity := ol;
 
EXPORT Lgid3IfHrchyValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::Lgid3IfHrchy';
 
EXPORT Lgid3IfHrchy_values_index := INDEX(Lgid3IfHrchy_values_persisted_temp,{Lgid3IfHrchy},{Lgid3IfHrchy_values_persisted_temp},Lgid3IfHrchyValuesIndexKeyName);
EXPORT Lgid3IfHrchy_values_persisted := Lgid3IfHrchy_values_index;
SALT30.MAC_Field_Nulls(Lgid3IfHrchy_values_persisted,Layout_Specificities.Lgid3IfHrchy_ChildRec,nv) // Use automated NULL spotting
EXPORT Lgid3IfHrchy_nulls := nv;
SALT30.MAC_Field_Bfoul(Lgid3IfHrchy_deduped,Lgid3IfHrchy,LGID3,Lgid3IfHrchy_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT Lgid3IfHrchy_switch := bf;
EXPORT Lgid3IfHrchy_max := MAX(Lgid3IfHrchy_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(Lgid3IfHrchy_values_persisted,Lgid3IfHrchy,Lgid3IfHrchy_nulls,ol) // Compute column level specificity
EXPORT Lgid3IfHrchy_specificity := ol;
 
EXPORT company_nameValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_name';
 
EXPORT company_name_values_index := INDEX(company_name_values_persisted_temp,{company_name},{company_name_values_persisted_temp},company_nameValuesIndexKeyName);
EXPORT company_name_values_persisted := company_name_values_index;
EXPORT company_name_nulls := DATASET([{'',0,0}],Layout_Specificities.company_name_ChildRec); // Automated null spotting not applicable
SALT30.MAC_Field_Bfoul(company_name_deduped,company_name,LGID3,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_switch := bf;
EXPORT company_name_max := MAX(company_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_name_values_persisted,company_name,company_name_nulls,ol) // Compute column level specificity
EXPORT company_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT30.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT30.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,LGID3,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::active_duns_number';
 
EXPORT active_duns_number_values_index := INDEX(active_duns_number_values_persisted_temp,{active_duns_number},{active_duns_number_values_persisted_temp},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT30.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT30.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,LGID3,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT duns_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::duns_number';
 
EXPORT duns_number_values_index := INDEX(duns_number_values_persisted_temp,{duns_number},{duns_number_values_persisted_temp},duns_numberValuesIndexKeyName);
EXPORT duns_number_values_persisted := duns_number_values_index;
SALT30.MAC_Field_Nulls(duns_number_values_persisted,Layout_Specificities.duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT duns_number_nulls := nv;
SALT30.MAC_Field_Bfoul(duns_number_deduped,duns_number,LGID3,duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT duns_number_switch := bf;
EXPORT duns_number_max := MAX(duns_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(duns_number_values_persisted,duns_number,duns_number_nulls,ol) // Compute column level specificity
EXPORT duns_number_specificity := ol;
 
EXPORT duns_number_conceptValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::duns_number_concept';
 
EXPORT duns_number_concept_values_index := INDEX(duns_number_concept_values_persisted_temp,{duns_number_concept},{duns_number_concept_values_persisted_temp},duns_number_conceptValuesIndexKeyName);
EXPORT duns_number_concept_values_persisted := duns_number_concept_values_index;
SALT30.MAC_Field_Nulls(duns_number_concept_values_persisted,Layout_Specificities.duns_number_concept_ChildRec,nv) // Use automated NULL spotting
EXPORT duns_number_concept_nulls := nv;
SALT30.MAC_Field_Bfoul(duns_number_concept_deduped,duns_number_concept,LGID3,duns_number_concept_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT duns_number_concept_switch := bf;
EXPORT duns_number_concept_max := MAX(duns_number_concept_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(duns_number_concept_values_persisted,duns_number_concept,duns_number_concept_nulls,ol) // Compute column level specificity
EXPORT duns_number_concept_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT30.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT30.MAC_Field_Bfoul(company_fein_deduped,company_fein,LGID3,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT company_inc_stateValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_inc_state';
 
EXPORT company_inc_state_values_index := INDEX(company_inc_state_values_persisted_temp,{company_inc_state},{company_inc_state_values_persisted_temp},company_inc_stateValuesIndexKeyName);
EXPORT company_inc_state_values_persisted := company_inc_state_values_index;
SALT30.MAC_Field_Nulls(company_inc_state_values_persisted,Layout_Specificities.company_inc_state_ChildRec,nv) // Use automated NULL spotting
EXPORT company_inc_state_nulls := nv;
SALT30.MAC_Field_Bfoul(company_inc_state_deduped,company_inc_state,LGID3,company_inc_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_inc_state_switch := bf;
EXPORT company_inc_state_max := MAX(company_inc_state_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_inc_state_values_persisted,company_inc_state,company_inc_state_nulls,ol) // Compute column level specificity
EXPORT company_inc_state_specificity := ol;
 
EXPORT company_charter_numberValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::company_charter_number';
 
EXPORT company_charter_number_values_index := INDEX(company_charter_number_values_persisted_temp,{company_charter_number},{company_charter_number_values_persisted_temp},company_charter_numberValuesIndexKeyName);
EXPORT company_charter_number_values_persisted := company_charter_number_values_index;
SALT30.MAC_Field_Nulls(company_charter_number_values_persisted,Layout_Specificities.company_charter_number_ChildRec,nv) // Use automated NULL spotting
EXPORT company_charter_number_nulls := nv;
SALT30.MAC_Field_Bfoul(company_charter_number_deduped,company_charter_number,LGID3,company_charter_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_charter_number_switch := bf;
EXPORT company_charter_number_max := MAX(company_charter_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_charter_number_values_persisted,company_charter_number,company_charter_number_nulls,ol) // Compute column level specificity
EXPORT company_charter_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Word::cnp_btype';
 
EXPORT cnp_btype_values_index := INDEX(cnp_btype_values_persisted_temp,{cnp_btype},{cnp_btype_values_persisted_temp},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT30.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,LGID3,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_LGID3::LGID3::Specificities';
iSpecificities := DATASET([{0,sbfe_id_specificity,sbfe_id_switch,sbfe_id_max,sbfe_id_nulls,Lgid3IfHrchy_specificity,Lgid3IfHrchy_switch,Lgid3IfHrchy_max,Lgid3IfHrchy_nulls,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,duns_number_specificity,duns_number_switch,duns_number_max,duns_number_nulls,duns_number_concept_specificity,duns_number_concept_switch,duns_number_concept_max,duns_number_concept_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_inc_state_specificity,company_inc_state_switch,company_inc_state_max,company_inc_state_nulls,company_charter_number_specificity,company_charter_number_switch,company_charter_number_max,company_charter_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( PARALLEL(BUILDINDEX(sbfe_id_values_index, OVERWRITE),BUILDINDEX(Lgid3IfHrchy_values_index, OVERWRITE),BUILDINDEX(company_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(duns_number_values_index, OVERWRITE),BUILDINDEX(duns_number_concept_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(company_inc_state_values_index, OVERWRITE),BUILDINDEX(company_charter_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE)), BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 sbfe_id_shift0 := ROUND(Specificities[1].sbfe_id_specificity - 27);
  integer2 sbfe_id_switch_shift0 := ROUND(1000*Specificities[1].sbfe_id_switch - 471);
  integer1 Lgid3IfHrchy_shift0 := ROUND(Specificities[1].Lgid3IfHrchy_specificity - 27);
  integer2 Lgid3IfHrchy_switch_shift0 := ROUND(1000*Specificities[1].Lgid3IfHrchy_switch - 0);
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 26);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 328);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 13);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 1);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 27);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 55);
  integer1 duns_number_shift0 := ROUND(Specificities[1].duns_number_specificity - 27);
  integer2 duns_number_switch_shift0 := ROUND(1000*Specificities[1].duns_number_switch - 66);
  integer1 duns_number_concept_shift0 := ROUND(Specificities[1].duns_number_concept_specificity - 27);
  integer2 duns_number_concept_switch_shift0 := ROUND(1000*Specificities[1].duns_number_concept_switch - 110);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 26);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 184);
  integer1 company_inc_state_shift0 := ROUND(Specificities[1].company_inc_state_specificity - 6);
  integer2 company_inc_state_switch_shift0 := ROUND(1000*Specificities[1].company_inc_state_switch - 32);
  integer1 company_charter_number_shift0 := ROUND(Specificities[1].company_charter_number_specificity - 26);
  integer2 company_charter_number_switch_shift0 := ROUND(1000*Specificities[1].company_charter_number_switch - 106);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 54);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT30.MAC_Specificity_Values(sbfe_id_values_persisted,sbfe_id,'sbfe_id',sbfe_id_specificity,sbfe_id_specificity_profile);
  SALT30.MAC_Specificity_Values(Lgid3IfHrchy_values_persisted,Lgid3IfHrchy,'Lgid3IfHrchy',Lgid3IfHrchy_specificity,Lgid3IfHrchy_specificity_profile);
  SALT30.MAC_Specificity_Values(company_name_values_persisted,company_name,'company_name',company_name_specificity,company_name_specificity_profile);
  SALT30.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT30.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT30.MAC_Specificity_Values(duns_number_values_persisted,duns_number,'duns_number',duns_number_specificity,duns_number_specificity_profile);
  SALT30.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT30.MAC_Specificity_Values(company_inc_state_values_persisted,company_inc_state,'company_inc_state',company_inc_state_specificity,company_inc_state_specificity_profile);
  SALT30.MAC_Specificity_Values(company_charter_number_values_persisted,company_charter_number,'company_charter_number',company_charter_number_specificity,company_charter_number_specificity_profile);
  SALT30.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
EXPORT AllProfiles := sbfe_id_specificity_profile + Lgid3IfHrchy_specificity_profile + company_name_specificity_profile + cnp_number_specificity_profile + active_duns_number_specificity_profile + duns_number_specificity_profile + company_fein_specificity_profile + company_inc_state_specificity_profile + company_charter_number_specificity_profile + cnp_btype_specificity_profile;
END;
 
