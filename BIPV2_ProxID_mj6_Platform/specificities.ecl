IMPORT ut,SALT30;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_DOT_Base) h) := MODULE
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT30.UIDType Proxid := h.Proxid; // using existing id field
  SALT30.UIDType lgid3 := h.lgid3; // Copy ID from hierarchy
  SALT30.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT30.UIDType ultid := h.ultid; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.cnp_name;
  h.cnp_number;
  h.active_duns_number;
  h.active_enterprise_number;
  h.active_domestic_corp_key;
  h.hist_enterprise_number;
  h.hist_duns_number;
  h.hist_domestic_corp_key;
  h.foreign_corp_key;
  h.unk_corp_key;
  h.ebr_file_number;
  h.company_fein;
  h.company_phone;
  h.prim_range;
  h.prim_name_derived;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip;
  unsigned4 company_csz := 0; // Place holder filled in by project
  unsigned4 company_addr1 := 0; // Place holder filled in by project
  unsigned4 company_address := 0; // Place holder filled in by project
  h.dt_first_seen;
  h.dt_last_seen;
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(Proxid<>0),r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_csz := IF (Fields.InValid_company_csz((SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip),0,HASH32((SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := IF (Fields.InValid_company_addr1((SALT30.StrType)le.prim_range,(SALT30.StrType)le.prim_name_derived,(SALT30.StrType)le.sec_range),0,HASH32((SALT30.StrType)le.prim_range,(SALT30.StrType)le.prim_name_derived,(SALT30.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.company_address := IF (Fields.InValid_company_address((SALT30.StrType)SELF.company_addr1,(SALT30.StrType)SELF.company_csz),0,HASH32((SALT30.StrType)SELF.company_addr1,(SALT30.StrType)SELF.company_csz)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT30.MAC_Partition_Stars(h02,SALT_Partition,Proxid); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  cnp_name_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,cnp_name) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::cnp_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_name_values_persisted_temp := specs_added;
 
EXPORT  cnp_number_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,cnp_number) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::cnp_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added;
 
EXPORT  active_duns_number_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,active_duns_number) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::active_duns_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_duns_number_values_persisted_temp := specs_added;
 
EXPORT  active_enterprise_number_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,active_enterprise_number) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::active_enterprise_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_enterprise_number_values_persisted_temp := specs_added;
 
EXPORT  active_domestic_corp_key_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,active_domestic_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::active_domestic_corp_key',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_domestic_corp_key_values_persisted_temp := specs_added;
 
EXPORT  hist_enterprise_number_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,hist_enterprise_number) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::hist_enterprise_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT hist_enterprise_number_values_persisted_temp := specs_added;
 
EXPORT  hist_duns_number_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,hist_duns_number) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::hist_duns_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(hist_duns_number_deduped,hist_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT hist_duns_number_values_persisted_temp := specs_added;
 
EXPORT  hist_domestic_corp_key_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,hist_domestic_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::hist_domestic_corp_key',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(hist_domestic_corp_key_deduped,hist_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT hist_domestic_corp_key_values_persisted_temp := specs_added;
 
EXPORT  foreign_corp_key_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,foreign_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::foreign_corp_key',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(foreign_corp_key_deduped,foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT foreign_corp_key_values_persisted_temp := specs_added;
 
EXPORT  unk_corp_key_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,unk_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::unk_corp_key',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(unk_corp_key_deduped,unk_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT unk_corp_key_values_persisted_temp := specs_added;
 
EXPORT  ebr_file_number_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,ebr_file_number) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::ebr_file_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ebr_file_number_deduped,ebr_file_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ebr_file_number_values_persisted_temp := specs_added;
 
EXPORT  company_fein_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,company_fein) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::company_fein',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_fein_values_persisted_temp := specs_added;
 
EXPORT  company_phone_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,company_phone) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::company_phone',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_phone_deduped,company_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_phone_values_persisted_temp := specs_added;
 
EXPORT  prim_range_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,prim_range) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::prim_range',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prim_range_deduped,prim_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added;
 
EXPORT  prim_name_derived_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,prim_name_derived) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::prim_name_derived',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prim_name_derived_deduped,prim_name_derived,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_derived_values_persisted_temp := specs_added;
 
EXPORT  sec_range_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,sec_range) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::sec_range',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(sec_range_deduped,sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted_temp := specs_added;
 
EXPORT  v_city_name_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,v_city_name) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::v_city_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted_temp := specs_added;
 
EXPORT  st_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,st) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::st',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(st_deduped,st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added;
 
EXPORT  zip_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,zip) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::zip',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(zip_deduped,zip,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added;
 
EXPORT  company_csz_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,company_csz) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::company_csz',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_csz_deduped,company_csz,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_csz_values_persisted_temp := specs_added;
 
EXPORT  company_addr1_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,company_addr1) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::company_addr1',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_addr1_deduped,company_addr1,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_addr1_values_persisted_temp := specs_added;
 
EXPORT  company_address_deduped := SALT30.MAC_Field_By_UID(input_file,Proxid,company_address) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::dedups::company_address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(company_address_deduped,company_address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_address_values_persisted_temp := specs_added;
 
EXPORT cnp_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::cnp_name';
 
EXPORT cnp_name_values_index := INDEX(cnp_name_values_persisted_temp,{cnp_name},{cnp_name_values_persisted_temp},cnp_nameValuesIndexKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
SALT30.MAC_Field_Nulls(cnp_name_values_persisted,Layout_Specificities.cnp_name_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_name_nulls := nv;
SALT30.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,Proxid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT30.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT30.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,Proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::active_duns_number';
 
EXPORT active_duns_number_values_index := INDEX(active_duns_number_values_persisted_temp,{active_duns_number},{active_duns_number_values_persisted_temp},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT30.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT30.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,Proxid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT active_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::active_enterprise_number';
 
EXPORT active_enterprise_number_values_index := INDEX(active_enterprise_number_values_persisted_temp,{active_enterprise_number},{active_enterprise_number_values_persisted_temp},active_enterprise_numberValuesIndexKeyName);
EXPORT active_enterprise_number_values_persisted := active_enterprise_number_values_index;
SALT30.MAC_Field_Nulls(active_enterprise_number_values_persisted,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_enterprise_number_nulls := nv;
SALT30.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,Proxid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_enterprise_number_switch := bf;
EXPORT active_enterprise_number_max := MAX(active_enterprise_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT active_enterprise_number_specificity := ol;
 
EXPORT active_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::active_domestic_corp_key';
 
EXPORT active_domestic_corp_key_values_index := INDEX(active_domestic_corp_key_values_persisted_temp,{active_domestic_corp_key},{active_domestic_corp_key_values_persisted_temp},active_domestic_corp_keyValuesIndexKeyName);
EXPORT active_domestic_corp_key_values_persisted := active_domestic_corp_key_values_index;
SALT30.MAC_Field_Nulls(active_domestic_corp_key_values_persisted,Layout_Specificities.active_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT active_domestic_corp_key_nulls := nv;
SALT30.MAC_Field_Bfoul(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,active_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_domestic_corp_key_switch := bf;
EXPORT active_domestic_corp_key_max := MAX(active_domestic_corp_key_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT active_domestic_corp_key_specificity := ol;
 
EXPORT hist_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::hist_enterprise_number';
 
EXPORT hist_enterprise_number_values_index := INDEX(hist_enterprise_number_values_persisted_temp,{hist_enterprise_number},{hist_enterprise_number_values_persisted_temp},hist_enterprise_numberValuesIndexKeyName);
EXPORT hist_enterprise_number_values_persisted := hist_enterprise_number_values_index;
SALT30.MAC_Field_Nulls(hist_enterprise_number_values_persisted,Layout_Specificities.hist_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_enterprise_number_nulls := nv;
SALT30.MAC_Field_Bfoul(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,hist_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_enterprise_number_switch := bf;
EXPORT hist_enterprise_number_max := MAX(hist_enterprise_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(hist_enterprise_number_values_persisted,hist_enterprise_number,hist_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT hist_enterprise_number_specificity := ol;
 
EXPORT hist_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::hist_duns_number';
 
EXPORT hist_duns_number_values_index := INDEX(hist_duns_number_values_persisted_temp,{hist_duns_number},{hist_duns_number_values_persisted_temp},hist_duns_numberValuesIndexKeyName);
EXPORT hist_duns_number_values_persisted := hist_duns_number_values_index;
SALT30.MAC_Field_Nulls(hist_duns_number_values_persisted,Layout_Specificities.hist_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_duns_number_nulls := nv;
SALT30.MAC_Field_Bfoul(hist_duns_number_deduped,hist_duns_number,Proxid,hist_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_duns_number_switch := bf;
EXPORT hist_duns_number_max := MAX(hist_duns_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(hist_duns_number_values_persisted,hist_duns_number,hist_duns_number_nulls,ol) // Compute column level specificity
EXPORT hist_duns_number_specificity := ol;
 
EXPORT hist_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::hist_domestic_corp_key';
 
EXPORT hist_domestic_corp_key_values_index := INDEX(hist_domestic_corp_key_values_persisted_temp,{hist_domestic_corp_key},{hist_domestic_corp_key_values_persisted_temp},hist_domestic_corp_keyValuesIndexKeyName);
EXPORT hist_domestic_corp_key_values_persisted := hist_domestic_corp_key_values_index;
SALT30.MAC_Field_Nulls(hist_domestic_corp_key_values_persisted,Layout_Specificities.hist_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_domestic_corp_key_nulls := nv;
SALT30.MAC_Field_Bfoul(hist_domestic_corp_key_deduped,hist_domestic_corp_key,Proxid,hist_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_domestic_corp_key_switch := bf;
EXPORT hist_domestic_corp_key_max := MAX(hist_domestic_corp_key_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,hist_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT hist_domestic_corp_key_specificity := ol;
 
EXPORT foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::foreign_corp_key';
 
EXPORT foreign_corp_key_values_index := INDEX(foreign_corp_key_values_persisted_temp,{foreign_corp_key},{foreign_corp_key_values_persisted_temp},foreign_corp_keyValuesIndexKeyName);
EXPORT foreign_corp_key_values_persisted := foreign_corp_key_values_index;
SALT30.MAC_Field_Nulls(foreign_corp_key_values_persisted,Layout_Specificities.foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT foreign_corp_key_nulls := nv;
SALT30.MAC_Field_Bfoul(foreign_corp_key_deduped,foreign_corp_key,Proxid,foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT foreign_corp_key_switch := bf;
EXPORT foreign_corp_key_max := MAX(foreign_corp_key_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(foreign_corp_key_values_persisted,foreign_corp_key,foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT foreign_corp_key_specificity := ol;
 
EXPORT unk_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::unk_corp_key';
 
EXPORT unk_corp_key_values_index := INDEX(unk_corp_key_values_persisted_temp,{unk_corp_key},{unk_corp_key_values_persisted_temp},unk_corp_keyValuesIndexKeyName);
EXPORT unk_corp_key_values_persisted := unk_corp_key_values_index;
SALT30.MAC_Field_Nulls(unk_corp_key_values_persisted,Layout_Specificities.unk_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT unk_corp_key_nulls := nv;
SALT30.MAC_Field_Bfoul(unk_corp_key_deduped,unk_corp_key,Proxid,unk_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT unk_corp_key_switch := bf;
EXPORT unk_corp_key_max := MAX(unk_corp_key_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(unk_corp_key_values_persisted,unk_corp_key,unk_corp_key_nulls,ol) // Compute column level specificity
EXPORT unk_corp_key_specificity := ol;
 
EXPORT ebr_file_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::ebr_file_number';
 
EXPORT ebr_file_number_values_index := INDEX(ebr_file_number_values_persisted_temp,{ebr_file_number},{ebr_file_number_values_persisted_temp},ebr_file_numberValuesIndexKeyName);
EXPORT ebr_file_number_values_persisted := ebr_file_number_values_index;
SALT30.MAC_Field_Nulls(ebr_file_number_values_persisted,Layout_Specificities.ebr_file_number_ChildRec,nv) // Use automated NULL spotting
EXPORT ebr_file_number_nulls := nv;
SALT30.MAC_Field_Bfoul(ebr_file_number_deduped,ebr_file_number,Proxid,ebr_file_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ebr_file_number_switch := bf;
EXPORT ebr_file_number_max := MAX(ebr_file_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ebr_file_number_values_persisted,ebr_file_number,ebr_file_number_nulls,ol) // Compute column level specificity
EXPORT ebr_file_number_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT30.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT30.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT company_phoneValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::company_phone';
 
EXPORT company_phone_values_index := INDEX(company_phone_values_persisted_temp,{company_phone},{company_phone_values_persisted_temp},company_phoneValuesIndexKeyName);
EXPORT company_phone_values_persisted := company_phone_values_index;
SALT30.MAC_Field_Nulls(company_phone_values_persisted,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_nulls := nv;
SALT30.MAC_Field_Bfoul(company_phone_deduped,company_phone,Proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_switch := bf;
EXPORT company_phone_max := MAX(company_phone_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_phone_values_persisted,company_phone,company_phone_nulls,ol) // Compute column level specificity
EXPORT company_phone_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT30.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT30.MAC_Field_Bfoul(prim_range_deduped,prim_range,Proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_name_derivedValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::prim_name_derived';
 
EXPORT prim_name_derived_values_index := INDEX(prim_name_derived_values_persisted_temp,{prim_name_derived},{prim_name_derived_values_persisted_temp},prim_name_derivedValuesIndexKeyName);
EXPORT prim_name_derived_values_persisted := prim_name_derived_values_index;
SALT30.MAC_Field_Nulls(prim_name_derived_values_persisted,Layout_Specificities.prim_name_derived_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_derived_nulls := nv;
SALT30.MAC_Field_Bfoul(prim_name_derived_deduped,prim_name_derived,Proxid,prim_name_derived_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_derived_switch := bf;
EXPORT prim_name_derived_max := MAX(prim_name_derived_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_nulls,ol) // Compute column level specificity
EXPORT prim_name_derived_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::sec_range';
 
EXPORT sec_range_values_index := INDEX(sec_range_values_persisted_temp,{sec_range},{sec_range_values_persisted_temp},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT30.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT30.MAC_Field_Bfoul(sec_range_deduped,sec_range,Proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::v_city_name';
 
EXPORT v_city_name_values_index := INDEX(v_city_name_values_persisted_temp,{v_city_name},{v_city_name_values_persisted_temp},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT30.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT30.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Proxid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT30.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT30.MAC_Field_Bfoul(st_deduped,st,Proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT30.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT30.MAC_Field_Bfoul(zip_deduped,zip,Proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT company_cszValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::company_csz';
 
EXPORT company_csz_values_index := INDEX(company_csz_values_persisted_temp,{company_csz},{company_csz_values_persisted_temp},company_cszValuesIndexKeyName);
EXPORT company_csz_values_persisted := company_csz_values_index;
SALT30.MAC_Field_Nulls(company_csz_values_persisted,Layout_Specificities.company_csz_ChildRec,nv) // Use automated NULL spotting
EXPORT company_csz_nulls := nv;
SALT30.MAC_Field_Bfoul(company_csz_deduped,company_csz,Proxid,company_csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_csz_switch := bf;
EXPORT company_csz_max := MAX(company_csz_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_csz_values_persisted,company_csz,company_csz_nulls,ol) // Compute column level specificity
EXPORT company_csz_specificity := ol;
 
EXPORT company_addr1ValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::company_addr1';
 
EXPORT company_addr1_values_index := INDEX(company_addr1_values_persisted_temp,{company_addr1},{company_addr1_values_persisted_temp},company_addr1ValuesIndexKeyName);
EXPORT company_addr1_values_persisted := company_addr1_values_index;
SALT30.MAC_Field_Nulls(company_addr1_values_persisted,Layout_Specificities.company_addr1_ChildRec,nv) // Use automated NULL spotting
EXPORT company_addr1_nulls := nv;
SALT30.MAC_Field_Bfoul(company_addr1_deduped,company_addr1,Proxid,company_addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_addr1_switch := bf;
EXPORT company_addr1_max := MAX(company_addr1_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_addr1_values_persisted,company_addr1,company_addr1_nulls,ol) // Compute column level specificity
EXPORT company_addr1_specificity := ol;
 
EXPORT company_addressValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::company_address';
 
EXPORT company_address_values_index := INDEX(company_address_values_persisted_temp,{company_address},{company_address_values_persisted_temp},company_addressValuesIndexKeyName);
EXPORT company_address_values_persisted := company_address_values_index;
SALT30.MAC_Field_Nulls(company_address_values_persisted,Layout_Specificities.company_address_ChildRec,nv) // Use automated NULL spotting
EXPORT company_address_nulls := nv;
SALT30.MAC_Field_Bfoul(company_address_deduped,company_address,Proxid,company_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_address_switch := bf;
EXPORT company_address_max := MAX(company_address_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(company_address_values_persisted,company_address,company_address_nulls,ol) // Compute column level specificity
EXPORT company_address_specificity := ol;
 
  infile := _file_Foreign_Corpkey;
  r := RECORD
    SALT30.AttrValueType Basis := TRIM((SALT30.StrType)infile.company_charter_number) + '|' + TRIM((SALT30.StrType)infile.company_inc_state);
    infile.company_charter_number; // Easy way to get component values
    INTEGER2 company_charter_number_weight100 := 0; // Easy place to store weight
    infile.company_inc_state; // Easy way to get component values
    INTEGER2 company_inc_state_weight100 := 0; // Easy place to store weight
    SALT30.UIDType Proxid := infile.Proxid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED ForeignCorpkey_attributes := DEDUP( SORT( DISTRIBUTE( t, Proxid ), Proxid, Basis, LOCAL), Proxid, Basis, LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID_mj6_PlatForm::values::ForeignCorpkey',EXPIRE(Config.PersistExpire));
  SALT30.Mac_Specificity_Local(ForeignCorpkey_attributes,Basis,Proxid,ForeignCorpkey_nulls,Layout_Specificities.ForeignCorpkey_ChildRec,ForeignCorpkey_specificity,ForeignCorpkey_switch,ForeignCorpkey_values);
EXPORT ForeignCorpkey_max := MAX(ForeignCorpkey_values,field_specificity);
 
EXPORT ForeignCorpkeyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Word::ForeignCorpkey';
  TYPEOF(ForeignCorpkey_attributes) take(ForeignCorpkey_attributes le,ForeignCorpkey_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.company_charter_number_weight100 := SELF.Basis_weight100 / 2;
    SELF.company_inc_state_weight100 := SELF.Basis_weight100 / 2;
    SELF := le;
  END;
  non_null_atts := ForeignCorpkey_attributes(Basis NOT IN SET(ForeignCorpkey_nulls,Basis));
SALT30.MAC_Choose_JoinType(non_null_atts,ForeignCorpkey_nulls,ForeignCorpkey_values,Basis,Basis_weight100,take,ForeignCorpkey_v);
 
EXPORT ForeignCorpkey_values_index := INDEX(ForeignCorpkey_v,{Basis},{ForeignCorpkey_v},ForeignCorpkeyValuesIndexKeyName);
EXPORT ForeignCorpkey_values_persisted := ForeignCorpkey_values_index;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::Specificities';
iSpecificities := DATASET([{0,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,active_domestic_corp_key_specificity,active_domestic_corp_key_switch,active_domestic_corp_key_max,active_domestic_corp_key_nulls,hist_enterprise_number_specificity,hist_enterprise_number_switch,hist_enterprise_number_max,hist_enterprise_number_nulls,hist_duns_number_specificity,hist_duns_number_switch,hist_duns_number_max,hist_duns_number_nulls,hist_domestic_corp_key_specificity,hist_domestic_corp_key_switch,hist_domestic_corp_key_max,hist_domestic_corp_key_nulls,foreign_corp_key_specificity,foreign_corp_key_switch,foreign_corp_key_max,foreign_corp_key_nulls,unk_corp_key_specificity,unk_corp_key_switch,unk_corp_key_max,unk_corp_key_nulls,ebr_file_number_specificity,ebr_file_number_switch,ebr_file_number_max,ebr_file_number_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_derived_specificity,prim_name_derived_switch,prim_name_derived_max,prim_name_derived_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,company_csz_specificity,company_csz_switch,company_csz_max,company_csz_nulls,company_addr1_specificity,company_addr1_switch,company_addr1_max,company_addr1_nulls,company_address_specificity,company_address_switch,company_address_max,company_address_nulls,ForeignCorpkey_specificity,ForeignCorpkey_switch,ForeignCorpkey_max,ForeignCorpkey_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( PARALLEL(BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(active_enterprise_number_values_index, OVERWRITE),BUILDINDEX(active_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(hist_enterprise_number_values_index, OVERWRITE),BUILDINDEX(hist_duns_number_values_index, OVERWRITE),BUILDINDEX(hist_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(unk_corp_key_values_index, OVERWRITE),BUILDINDEX(ebr_file_number_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(company_phone_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_derived_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(company_csz_values_index, OVERWRITE),BUILDINDEX(company_addr1_values_index, OVERWRITE),BUILDINDEX(company_address_values_index, OVERWRITE),BUILDINDEX(ForeignCorpkey_values_index, OVERWRITE)), BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 25);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 213);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 14);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 0);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 27);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 19);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 26);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 3);
  integer1 active_domestic_corp_key_shift0 := ROUND(Specificities[1].active_domestic_corp_key_specificity - 27);
  integer2 active_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].active_domestic_corp_key_switch - 0);
  integer1 hist_enterprise_number_shift0 := ROUND(Specificities[1].hist_enterprise_number_specificity - 28);
  integer2 hist_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].hist_enterprise_number_switch - 7);
  integer1 hist_duns_number_shift0 := ROUND(Specificities[1].hist_duns_number_specificity - 27);
  integer2 hist_duns_number_switch_shift0 := ROUND(1000*Specificities[1].hist_duns_number_switch - 171);
  integer1 hist_domestic_corp_key_shift0 := ROUND(Specificities[1].hist_domestic_corp_key_specificity - 27);
  integer2 hist_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].hist_domestic_corp_key_switch - 10);
  integer1 foreign_corp_key_shift0 := ROUND(Specificities[1].foreign_corp_key_specificity - 27);
  integer2 foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].foreign_corp_key_switch - 122);
  integer1 unk_corp_key_shift0 := ROUND(Specificities[1].unk_corp_key_specificity - 27);
  integer2 unk_corp_key_switch_shift0 := ROUND(1000*Specificities[1].unk_corp_key_switch - 17);
  integer1 ebr_file_number_shift0 := ROUND(Specificities[1].ebr_file_number_specificity - 28);
  integer2 ebr_file_number_switch_shift0 := ROUND(1000*Specificities[1].ebr_file_number_switch - 229);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 26);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 110);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 27);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 275);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_derived_shift0 := ROUND(Specificities[1].prim_name_derived_specificity - 15);
  integer2 prim_name_derived_switch_shift0 := ROUND(1000*Specificities[1].prim_name_derived_switch - 11);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 112);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 11);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 5);
  integer1 company_csz_shift0 := ROUND(Specificities[1].company_csz_specificity - 14);
  integer2 company_csz_switch_shift0 := ROUND(1000*Specificities[1].company_csz_switch - 23);
  integer1 company_addr1_shift0 := ROUND(Specificities[1].company_addr1_specificity - 23);
  integer2 company_addr1_switch_shift0 := ROUND(1000*Specificities[1].company_addr1_switch - 99);
  integer1 company_address_shift0 := ROUND(Specificities[1].company_address_specificity - 25);
  integer2 company_address_switch_shift0 := ROUND(1000*Specificities[1].company_address_switch - 115);
  INTEGER1 ForeignCorpkey_shift0 := ROUND(Specificities[1].ForeignCorpkey_specificity - 27);
  INTEGER2 ForeignCorpkey_switch_shift0 := ROUND(1000*Specificities[1].ForeignCorpkey_switch - 31);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT30.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT30.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT30.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT30.MAC_Specificity_Values(active_enterprise_number_values_persisted,active_enterprise_number,'active_enterprise_number',active_enterprise_number_specificity,active_enterprise_number_specificity_profile);
  SALT30.MAC_Specificity_Values(active_domestic_corp_key_values_persisted,active_domestic_corp_key,'active_domestic_corp_key',active_domestic_corp_key_specificity,active_domestic_corp_key_specificity_profile);
  SALT30.MAC_Specificity_Values(hist_enterprise_number_values_persisted,hist_enterprise_number,'hist_enterprise_number',hist_enterprise_number_specificity,hist_enterprise_number_specificity_profile);
  SALT30.MAC_Specificity_Values(hist_duns_number_values_persisted,hist_duns_number,'hist_duns_number',hist_duns_number_specificity,hist_duns_number_specificity_profile);
  SALT30.MAC_Specificity_Values(hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,'hist_domestic_corp_key',hist_domestic_corp_key_specificity,hist_domestic_corp_key_specificity_profile);
  SALT30.MAC_Specificity_Values(foreign_corp_key_values_persisted,foreign_corp_key,'foreign_corp_key',foreign_corp_key_specificity,foreign_corp_key_specificity_profile);
  SALT30.MAC_Specificity_Values(unk_corp_key_values_persisted,unk_corp_key,'unk_corp_key',unk_corp_key_specificity,unk_corp_key_specificity_profile);
  SALT30.MAC_Specificity_Values(ebr_file_number_values_persisted,ebr_file_number,'ebr_file_number',ebr_file_number_specificity,ebr_file_number_specificity_profile);
  SALT30.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT30.MAC_Specificity_Values(company_phone_values_persisted,company_phone,'company_phone',company_phone_specificity,company_phone_specificity_profile);
  SALT30.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT30.MAC_Specificity_Values(prim_name_derived_values_persisted,prim_name_derived,'prim_name_derived',prim_name_derived_specificity,prim_name_derived_specificity_profile);
  SALT30.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT30.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT30.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT30.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
EXPORT AllProfiles := cnp_name_specificity_profile + cnp_number_specificity_profile + active_duns_number_specificity_profile + active_enterprise_number_specificity_profile + active_domestic_corp_key_specificity_profile + hist_enterprise_number_specificity_profile + hist_duns_number_specificity_profile + hist_domestic_corp_key_specificity_profile + foreign_corp_key_specificity_profile + unk_corp_key_specificity_profile + ebr_file_number_specificity_profile + company_fein_specificity_profile + company_phone_specificity_profile + prim_range_specificity_profile + prim_name_derived_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip_specificity_profile;
END;
 
