IMPORT ut,SALT27;
IMPORT BIPV2,salt26; // HACK
EXPORT specificities(DATASET(layout_DOT_Base) h) := MODULE
 
EXPORT input_layout := RECORD // project out required fields
  SALT27.UIDType Proxid := h.Proxid; // using existing id field
  h.rcid;//RIDfield 
  h.active_duns_number;
  h.active_enterprise_number;
  h.active_domestic_corp_key;
  h.hist_enterprise_number;
  h.hist_duns_number;
  h.hist_domestic_corp_key;
  h.foreign_corp_key;
  h.unk_corp_key;
  h.ebr_file_number;
  h.company_name;
  h.cnp_name;
  h.company_name_type_raw;
  h.company_name_type_derived;
  h.cnp_hasnumber;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.cnp_translated;
  h.cnp_classid;
  h.company_fein;
  h.company_foreign_domestic;
  h.company_bdid;
  h.company_phone;
  h.iscorp;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip;
  unsigned4 company_csz := 0; // Place holder filled in by project
  unsigned4 company_addr1 := 0; // Place holder filled in by project
  unsigned4 company_address := 0; // Place holder filled in by project
  h.dt_first_seen;
  h.dt_last_seen;
// HACK - added next line
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h,r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_csz := IF (Fields.InValid_company_csz((SALT27.StrType)le.v_city_name,(SALT27.StrType)le.st,(SALT27.StrType)le.zip),0,HASH32((SALT27.StrType)le.v_city_name,(SALT27.StrType)le.st,(SALT27.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := IF (Fields.InValid_company_addr1((SALT27.StrType)le.prim_range,(SALT27.StrType)le.prim_name,(SALT27.StrType)le.sec_range),0,HASH32((SALT27.StrType)le.prim_range,(SALT27.StrType)le.prim_name,(SALT27.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.company_address := IF (Fields.InValid_company_address((SALT27.StrType)SELF.company_addr1,(SALT27.StrType)SELF.company_csz),0,HASH32((SALT27.StrType)SELF.company_addr1,(SALT27.StrType)SELF.company_csz)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
// SHARED h0 := PROJECT(h01,do_computes(LEFT));
// HACK - commented previous line, added next three lines
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT26.MAC_Partition_Stars(h02,SALT_Partition,proxid); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0  : PERSIST('~temp::Proxid::BIPV2_ProxID_dev5::Specificities_Cache');
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL)  : PERSIST('~temp::Proxid::BIPV2_ProxID_dev5::Cluster_Sizes');
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::active_duns_number';
 
SHARED  active_duns_number_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,active_duns_number) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_active_duns_number'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT active_duns_number_values_index := INDEX(specs_added,{active_duns_number},{specs_added},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT27.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT27.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,Proxid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT active_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::active_enterprise_number';
 
SHARED  active_enterprise_number_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,active_enterprise_number) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_active_enterprise_number'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT active_enterprise_number_values_index := INDEX(specs_added,{active_enterprise_number},{specs_added},active_enterprise_numberValuesIndexKeyName);
EXPORT active_enterprise_number_values_persisted := active_enterprise_number_values_index;
SALT27.MAC_Field_Nulls(active_enterprise_number_values_persisted,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_enterprise_number_nulls := nv;
SALT27.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,Proxid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_enterprise_number_switch := bf;
EXPORT active_enterprise_number_max := MAX(active_enterprise_number_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT active_enterprise_number_specificity := ol;
 
EXPORT active_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::active_domestic_corp_key';
 
SHARED  active_domestic_corp_key_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,active_domestic_corp_key) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_active_domestic_corp_key'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT active_domestic_corp_key_values_index := INDEX(specs_added,{active_domestic_corp_key},{specs_added},active_domestic_corp_keyValuesIndexKeyName);
EXPORT active_domestic_corp_key_values_persisted := active_domestic_corp_key_values_index;
SALT27.MAC_Field_Nulls(active_domestic_corp_key_values_persisted,Layout_Specificities.active_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT active_domestic_corp_key_nulls := nv;
SALT27.MAC_Field_Bfoul(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,active_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_domestic_corp_key_switch := bf;
EXPORT active_domestic_corp_key_max := MAX(active_domestic_corp_key_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT active_domestic_corp_key_specificity := ol;
 
EXPORT hist_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::hist_enterprise_number';
 
SHARED  hist_enterprise_number_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,hist_enterprise_number) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_hist_enterprise_number'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT hist_enterprise_number_values_index := INDEX(specs_added,{hist_enterprise_number},{specs_added},hist_enterprise_numberValuesIndexKeyName);
EXPORT hist_enterprise_number_values_persisted := hist_enterprise_number_values_index;
SALT27.MAC_Field_Nulls(hist_enterprise_number_values_persisted,Layout_Specificities.hist_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_enterprise_number_nulls := nv;
SALT27.MAC_Field_Bfoul(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,hist_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_enterprise_number_switch := bf;
EXPORT hist_enterprise_number_max := MAX(hist_enterprise_number_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(hist_enterprise_number_values_persisted,hist_enterprise_number,hist_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT hist_enterprise_number_specificity := ol;
 
EXPORT hist_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::hist_duns_number';
 
SHARED  hist_duns_number_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,hist_duns_number) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_hist_duns_number'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(hist_duns_number_deduped,hist_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT hist_duns_number_values_index := INDEX(specs_added,{hist_duns_number},{specs_added},hist_duns_numberValuesIndexKeyName);
EXPORT hist_duns_number_values_persisted := hist_duns_number_values_index;
SALT27.MAC_Field_Nulls(hist_duns_number_values_persisted,Layout_Specificities.hist_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_duns_number_nulls := nv;
SALT27.MAC_Field_Bfoul(hist_duns_number_deduped,hist_duns_number,Proxid,hist_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_duns_number_switch := bf;
EXPORT hist_duns_number_max := MAX(hist_duns_number_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(hist_duns_number_values_persisted,hist_duns_number,hist_duns_number_nulls,ol) // Compute column level specificity
EXPORT hist_duns_number_specificity := ol;
 
EXPORT hist_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::hist_domestic_corp_key';
 
SHARED  hist_domestic_corp_key_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,hist_domestic_corp_key) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_hist_domestic_corp_key'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(hist_domestic_corp_key_deduped,hist_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT hist_domestic_corp_key_values_index := INDEX(specs_added,{hist_domestic_corp_key},{specs_added},hist_domestic_corp_keyValuesIndexKeyName);
EXPORT hist_domestic_corp_key_values_persisted := hist_domestic_corp_key_values_index;
SALT27.MAC_Field_Nulls(hist_domestic_corp_key_values_persisted,Layout_Specificities.hist_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_domestic_corp_key_nulls := nv;
SALT27.MAC_Field_Bfoul(hist_domestic_corp_key_deduped,hist_domestic_corp_key,Proxid,hist_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_domestic_corp_key_switch := bf;
EXPORT hist_domestic_corp_key_max := MAX(hist_domestic_corp_key_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,hist_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT hist_domestic_corp_key_specificity := ol;
 
EXPORT foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::foreign_corp_key';
 
SHARED  foreign_corp_key_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,foreign_corp_key) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_foreign_corp_key'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(foreign_corp_key_deduped,foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT foreign_corp_key_values_index := INDEX(specs_added,{foreign_corp_key},{specs_added},foreign_corp_keyValuesIndexKeyName);
EXPORT foreign_corp_key_values_persisted := foreign_corp_key_values_index;
SALT27.MAC_Field_Nulls(foreign_corp_key_values_persisted,Layout_Specificities.foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT foreign_corp_key_nulls := nv;
SALT27.MAC_Field_Bfoul(foreign_corp_key_deduped,foreign_corp_key,Proxid,foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT foreign_corp_key_switch := bf;
EXPORT foreign_corp_key_max := MAX(foreign_corp_key_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(foreign_corp_key_values_persisted,foreign_corp_key,foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT foreign_corp_key_specificity := ol;
 
EXPORT unk_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::unk_corp_key';
 
SHARED  unk_corp_key_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,unk_corp_key) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_unk_corp_key'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(unk_corp_key_deduped,unk_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT unk_corp_key_values_index := INDEX(specs_added,{unk_corp_key},{specs_added},unk_corp_keyValuesIndexKeyName);
EXPORT unk_corp_key_values_persisted := unk_corp_key_values_index;
SALT27.MAC_Field_Nulls(unk_corp_key_values_persisted,Layout_Specificities.unk_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT unk_corp_key_nulls := nv;
SALT27.MAC_Field_Bfoul(unk_corp_key_deduped,unk_corp_key,Proxid,unk_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT unk_corp_key_switch := bf;
EXPORT unk_corp_key_max := MAX(unk_corp_key_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(unk_corp_key_values_persisted,unk_corp_key,unk_corp_key_nulls,ol) // Compute column level specificity
EXPORT unk_corp_key_specificity := ol;
 
EXPORT ebr_file_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::ebr_file_number';
 
SHARED  ebr_file_number_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,ebr_file_number) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_ebr_file_number'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(ebr_file_number_deduped,ebr_file_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT ebr_file_number_values_index := INDEX(specs_added,{ebr_file_number},{specs_added},ebr_file_numberValuesIndexKeyName);
EXPORT ebr_file_number_values_persisted := ebr_file_number_values_index;
SALT27.MAC_Field_Nulls(ebr_file_number_values_persisted,Layout_Specificities.ebr_file_number_ChildRec,nv) // Use automated NULL spotting
EXPORT ebr_file_number_nulls := nv;
SALT27.MAC_Field_Bfoul(ebr_file_number_deduped,ebr_file_number,Proxid,ebr_file_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ebr_file_number_switch := bf;
EXPORT ebr_file_number_max := MAX(ebr_file_number_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(ebr_file_number_values_persisted,ebr_file_number,ebr_file_number_nulls,ol) // Compute column level specificity
EXPORT ebr_file_number_specificity := ol;
 
EXPORT cnp_nameValuesKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::cnp_name';
 
SHARED  cnp_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,cnp_name) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_cnp_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED cnp_name_sa := specs_added; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT27.MAC_Field_Variants_WordBag(cnp_name_deduped,Proxid,cnp_name,expanded)// expand out all variants of wordbag
  SALT27.Mac_Field_Count_UID(expanded,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT27.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED cnp_name_ad := wb_specs_added; // Hop over export
 
EXPORT cnp_name_values_key := INDEX(cnp_name_ad,{cnp_name},{cnp_name_ad},cnp_nameValuesKeyName);
  SALT27.mac_wordbag_addweights(cnp_name_sa,cnp_name,cnp_name_ad,p);
 
EXPORT cnp_name_values_index := INDEX(p,{cnp_name},{p},cnp_nameValuesKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
EXPORT cnp_name_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_name_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,Proxid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::cnp_number';
 
SHARED  cnp_number_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,cnp_number) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_cnp_number'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT cnp_number_values_index := INDEX(specs_added,{cnp_number},{specs_added},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT27.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT27.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,Proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::cnp_btype';
 
SHARED  cnp_btype_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,cnp_btype) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_cnp_btype'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT cnp_btype_values_index := INDEX(specs_added,{cnp_btype},{specs_added},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,Proxid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::company_fein';
 
SHARED  company_fein_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_fein) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_company_fein'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT27.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
 
EXPORT company_fein_values_index := INDEX(distance_computed,{company_fein},{distance_computed},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT27.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT27.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT company_phoneValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::company_phone';
 
SHARED  company_phone_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_phone) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_company_phone'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_phone_deduped,company_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_phone_values_index := INDEX(specs_added,{company_phone},{specs_added},company_phoneValuesIndexKeyName);
EXPORT company_phone_values_persisted := company_phone_values_index;
SALT27.MAC_Field_Nulls(company_phone_values_persisted,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_nulls := nv;
SALT27.MAC_Field_Bfoul(company_phone_deduped,company_phone,Proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_switch := bf;
EXPORT company_phone_max := MAX(company_phone_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_phone_values_persisted,company_phone,company_phone_nulls,ol) // Compute column level specificity
EXPORT company_phone_specificity := ol;
 
EXPORT iscorpValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::iscorp';
 
SHARED  iscorp_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,iscorp) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_iscorp'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(iscorp_deduped,iscorp,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT iscorp_values_index := INDEX(specs_added,{iscorp},{specs_added},iscorpValuesIndexKeyName);
EXPORT iscorp_values_persisted := iscorp_values_index;
EXPORT iscorp_nulls := DATASET([{'',0,0}],Layout_Specificities.iscorp_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(iscorp_deduped,iscorp,Proxid,iscorp_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT iscorp_switch := bf;
EXPORT iscorp_max := MAX(iscorp_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(iscorp_values_persisted,iscorp,iscorp_nulls,ol) // Compute column level specificity
EXPORT iscorp_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::prim_range';
 
SHARED  prim_range_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,prim_range) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_prim_range'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(prim_range_deduped,prim_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT prim_range_values_index := INDEX(specs_added,{prim_range},{specs_added},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT27.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT27.MAC_Field_Bfoul(prim_range_deduped,prim_range,Proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::prim_name';
 
SHARED  prim_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,prim_name) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_prim_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(prim_name_deduped,prim_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT prim_name_values_index := INDEX(specs_added,{prim_name},{specs_added},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT27.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT27.MAC_Field_Bfoul(prim_name_deduped,prim_name,Proxid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::sec_range';
 
SHARED  sec_range_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,sec_range) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_sec_range'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(sec_range_deduped,sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT sec_range_values_index := INDEX(specs_added,{sec_range},{specs_added},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT27.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT27.MAC_Field_Bfoul(sec_range_deduped,sec_range,Proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::v_city_name';
 
SHARED  v_city_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,v_city_name) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_v_city_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT v_city_name_values_index := INDEX(specs_added,{v_city_name},{specs_added},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT27.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT27.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Proxid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::st';
 
SHARED  st_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,st) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_st'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(st_deduped,st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT st_values_index := INDEX(specs_added,{st},{specs_added},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT27.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT27.MAC_Field_Bfoul(st_deduped,st,Proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::zip';
 
SHARED  zip_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,zip) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_zip'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(zip_deduped,zip,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT zip_values_index := INDEX(specs_added,{zip},{specs_added},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT27.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT27.MAC_Field_Bfoul(zip_deduped,zip,Proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT company_cszValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::company_csz';
 
SHARED  company_csz_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_csz) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_company_csz'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_csz_deduped,company_csz,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_csz_values_index := INDEX(specs_added,{company_csz},{specs_added},company_cszValuesIndexKeyName);
EXPORT company_csz_values_persisted := company_csz_values_index;
SALT27.MAC_Field_Nulls(company_csz_values_persisted,Layout_Specificities.company_csz_ChildRec,nv) // Use automated NULL spotting
EXPORT company_csz_nulls := nv;
SALT27.MAC_Field_Bfoul(company_csz_deduped,company_csz,Proxid,company_csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_csz_switch := bf;
EXPORT company_csz_max := MAX(company_csz_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_csz_values_persisted,company_csz,company_csz_nulls,ol) // Compute column level specificity
EXPORT company_csz_specificity := ol;
 
EXPORT company_addr1ValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::company_addr1';
 
SHARED  company_addr1_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_addr1) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_company_addr1'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_addr1_deduped,company_addr1,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_addr1_values_index := INDEX(specs_added,{company_addr1},{specs_added},company_addr1ValuesIndexKeyName);
EXPORT company_addr1_values_persisted := company_addr1_values_index;
SALT27.MAC_Field_Nulls(company_addr1_values_persisted,Layout_Specificities.company_addr1_ChildRec,nv) // Use automated NULL spotting
EXPORT company_addr1_nulls := nv;
SALT27.MAC_Field_Bfoul(company_addr1_deduped,company_addr1,Proxid,company_addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_addr1_switch := bf;
EXPORT company_addr1_max := MAX(company_addr1_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_addr1_values_persisted,company_addr1,company_addr1_nulls,ol) // Compute column level specificity
EXPORT company_addr1_specificity := ol;
 
EXPORT company_addressValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::company_address';
 
SHARED  company_address_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_address) : PERSIST('~temp::dedups::BIPV2_ProxID_dev5_Proxid_company_address'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_address_deduped,company_address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_address_values_index := INDEX(specs_added,{company_address},{specs_added},company_addressValuesIndexKeyName);
EXPORT company_address_values_persisted := company_address_values_index;
SALT27.MAC_Field_Nulls(company_address_values_persisted,Layout_Specificities.company_address_ChildRec,nv) // Use automated NULL spotting
EXPORT company_address_nulls := nv;
SALT27.MAC_Field_Bfoul(company_address_deduped,company_address,Proxid,company_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_address_switch := bf;
EXPORT company_address_max := MAX(company_address_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_address_values_persisted,company_address,company_address_nulls,ol) // Compute column level specificity
EXPORT company_address_specificity := ol;
 
  infile := file_SrcRidVlid;
  r := RECORD
    SALT27.AttrValueType Basis := TRIM((SALT27.StrType)infile.source) + '|' + TRIM((SALT27.StrType)infile.source_record_id) + '|' + TRIM((SALT27.StrType)infile.vl_id);
    infile.source; // Easy way to get component values
    INTEGER2 source_weight100 := 0; // Easy place to store weight
    infile.source_record_id; // Easy way to get component values
    INTEGER2 source_record_id_weight100 := 0; // Easy place to store weight
    infile.vl_id; // Easy way to get component values
    INTEGER2 vl_id_weight100 := 0; // Easy place to store weight
    SALT27.UIDType Proxid := infile.Proxid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED SrcRidVlid_attributes := DEDUP( SORT( DISTRIBUTE( t, Proxid ), Proxid, Basis, LOCAL), Proxid, Basis, LOCAL) : PERSIST('~BIPV2_ProxID_dev5::SrcRidVlid::values');
  SALT27.Mac_Specificity_Local(SrcRidVlid_attributes,Basis,Proxid,SrcRidVlid_nulls,Layout_Specificities.SrcRidVlid_ChildRec,SrcRidVlid_specificity,SrcRidVlid_switch,SrcRidVlid_values);
EXPORT SrcRidVlid_max := MAX(SrcRidVlid_values,field_specificity);
 
EXPORT SrcRidVlidValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Word::SrcRidVlid';
  TYPEOF(SrcRidVlid_attributes) take(SrcRidVlid_attributes le,SrcRidVlid_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.source_weight100 := SELF.Basis_weight100 / 3;
    SELF.source_record_id_weight100 := SELF.Basis_weight100 / 3;
    SELF.vl_id_weight100 := SELF.Basis_weight100 / 3;
    SELF := le;
  END;
  non_null_atts := SrcRidVlid_attributes(Basis NOT IN SET(SrcRidVlid_nulls,Basis));
SALT27.MAC_Choose_JoinType(non_null_atts,SrcRidVlid_nulls,SrcRidVlid_values,Basis,Basis_weight100,take,SrcRidVlid_v);
 
EXPORT SrcRidVlid_values_index := INDEX(SrcRidVlid_v,{Basis},{SrcRidVlid_v},SrcRidVlidValuesIndexKeyName);
EXPORT SrcRidVlid_values_persisted := SrcRidVlid_values_index;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_ProxID_dev5::Proxid::Specificities';
iSpecificities := DATASET([{0,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,active_domestic_corp_key_specificity,active_domestic_corp_key_switch,active_domestic_corp_key_max,active_domestic_corp_key_nulls,hist_enterprise_number_specificity,hist_enterprise_number_switch,hist_enterprise_number_max,hist_enterprise_number_nulls,hist_duns_number_specificity,hist_duns_number_switch,hist_duns_number_max,hist_duns_number_nulls,hist_domestic_corp_key_specificity,hist_domestic_corp_key_switch,hist_domestic_corp_key_max,hist_domestic_corp_key_nulls,foreign_corp_key_specificity,foreign_corp_key_switch,foreign_corp_key_max,foreign_corp_key_nulls,unk_corp_key_specificity,unk_corp_key_switch,unk_corp_key_max,unk_corp_key_nulls,ebr_file_number_specificity,ebr_file_number_switch,ebr_file_number_max,ebr_file_number_nulls,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,iscorp_specificity,iscorp_switch,iscorp_max,iscorp_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,company_csz_specificity,company_csz_switch,company_csz_max,company_csz_nulls,company_addr1_specificity,company_addr1_switch,company_addr1_max,company_addr1_nulls,company_address_specificity,company_address_switch,company_address_max,company_address_nulls,SrcRidVlid_specificity,SrcRidVlid_switch,SrcRidVlid_max,SrcRidVlid_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( PARALLEL(BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(active_enterprise_number_values_index, OVERWRITE),BUILDINDEX(active_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(hist_enterprise_number_values_index, OVERWRITE),BUILDINDEX(hist_duns_number_values_index, OVERWRITE),BUILDINDEX(hist_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(unk_corp_key_values_index, OVERWRITE),BUILDINDEX(ebr_file_number_values_index, OVERWRITE),BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(company_phone_values_index, OVERWRITE),BUILDINDEX(iscorp_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(company_csz_values_index, OVERWRITE),BUILDINDEX(company_addr1_values_index, OVERWRITE),BUILDINDEX(company_address_values_index, OVERWRITE),BUILDINDEX(SrcRidVlid_values_index, OVERWRITE)), BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 27);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 1);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 28);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 1);
  integer1 active_domestic_corp_key_shift0 := ROUND(Specificities[1].active_domestic_corp_key_specificity - 27);
  integer2 active_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].active_domestic_corp_key_switch - 2);
  integer1 hist_enterprise_number_shift0 := ROUND(Specificities[1].hist_enterprise_number_specificity - 28);
  integer2 hist_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].hist_enterprise_number_switch - 10);
  integer1 hist_duns_number_shift0 := ROUND(Specificities[1].hist_duns_number_specificity - 26);
  integer2 hist_duns_number_switch_shift0 := ROUND(1000*Specificities[1].hist_duns_number_switch - 61);
  integer1 hist_domestic_corp_key_shift0 := ROUND(Specificities[1].hist_domestic_corp_key_specificity - 27);
  integer2 hist_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].hist_domestic_corp_key_switch - 6);
  integer1 foreign_corp_key_shift0 := ROUND(Specificities[1].foreign_corp_key_specificity - 26);
  integer2 foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].foreign_corp_key_switch - 120);
  integer1 unk_corp_key_shift0 := ROUND(Specificities[1].unk_corp_key_specificity - 27);
  integer2 unk_corp_key_switch_shift0 := ROUND(1000*Specificities[1].unk_corp_key_switch - 10);
  integer1 ebr_file_number_shift0 := ROUND(Specificities[1].ebr_file_number_specificity - 27);
  integer2 ebr_file_number_switch_shift0 := ROUND(1000*Specificities[1].ebr_file_number_switch - 229);
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 25);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 107);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 14);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 1);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 38);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 26);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 64);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 26);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 237);
  integer1 iscorp_shift0 := ROUND(Specificities[1].iscorp_specificity - 1);
  integer2 iscorp_switch_shift0 := ROUND(1000*Specificities[1].iscorp_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 111);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 6);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 7);
  integer1 company_csz_shift0 := ROUND(Specificities[1].company_csz_specificity - 14);
  integer2 company_csz_switch_shift0 := ROUND(1000*Specificities[1].company_csz_switch - 11);
  integer1 company_addr1_shift0 := ROUND(Specificities[1].company_addr1_specificity - 23);
  integer2 company_addr1_switch_shift0 := ROUND(1000*Specificities[1].company_addr1_switch - 106);
  integer1 company_address_shift0 := ROUND(Specificities[1].company_address_specificity - 25);
  integer2 company_address_switch_shift0 := ROUND(1000*Specificities[1].company_address_switch - 115);
  INTEGER1 SrcRidVlid_shift0 := ROUND(Specificities[1].SrcRidVlid_specificity - 27);
  INTEGER2 SrcRidVlid_switch_shift0 := ROUND(1000*Specificities[1].SrcRidVlid_switch - 432);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT27.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT27.MAC_Specificity_Values(active_enterprise_number_values_persisted,active_enterprise_number,'active_enterprise_number',active_enterprise_number_specificity,active_enterprise_number_specificity_profile);
  SALT27.MAC_Specificity_Values(active_domestic_corp_key_values_persisted,active_domestic_corp_key,'active_domestic_corp_key',active_domestic_corp_key_specificity,active_domestic_corp_key_specificity_profile);
  SALT27.MAC_Specificity_Values(hist_enterprise_number_values_persisted,hist_enterprise_number,'hist_enterprise_number',hist_enterprise_number_specificity,hist_enterprise_number_specificity_profile);
  SALT27.MAC_Specificity_Values(hist_duns_number_values_persisted,hist_duns_number,'hist_duns_number',hist_duns_number_specificity,hist_duns_number_specificity_profile);
  SALT27.MAC_Specificity_Values(hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,'hist_domestic_corp_key',hist_domestic_corp_key_specificity,hist_domestic_corp_key_specificity_profile);
  SALT27.MAC_Specificity_Values(foreign_corp_key_values_persisted,foreign_corp_key,'foreign_corp_key',foreign_corp_key_specificity,foreign_corp_key_specificity_profile);
  SALT27.MAC_Specificity_Values(unk_corp_key_values_persisted,unk_corp_key,'unk_corp_key',unk_corp_key_specificity,unk_corp_key_specificity_profile);
  SALT27.MAC_Specificity_Values(ebr_file_number_values_persisted,ebr_file_number,'ebr_file_number',ebr_file_number_specificity,ebr_file_number_specificity_profile);
  SALT27.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT27.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT27.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
  SALT27.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT27.MAC_Specificity_Values(company_phone_values_persisted,company_phone,'company_phone',company_phone_specificity,company_phone_specificity_profile);
  SALT27.MAC_Specificity_Values(iscorp_values_persisted,iscorp,'iscorp',iscorp_specificity,iscorp_specificity_profile);
  SALT27.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT27.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT27.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT27.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT27.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT27.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
EXPORT AllProfiles := active_duns_number_specificity_profile + active_enterprise_number_specificity_profile + active_domestic_corp_key_specificity_profile + hist_enterprise_number_specificity_profile + hist_duns_number_specificity_profile + hist_domestic_corp_key_specificity_profile + foreign_corp_key_specificity_profile + unk_corp_key_specificity_profile + ebr_file_number_specificity_profile + cnp_name_specificity_profile + cnp_number_specificity_profile + cnp_btype_specificity_profile + company_fein_specificity_profile + company_phone_specificity_profile + iscorp_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip_specificity_profile;
END;
 
