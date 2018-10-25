IMPORT SALT311,std;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_DOT_Base) ih) := MODULE
 
EXPORT ih_init := SALT311.initNullIDs.upperLevel(ih,dotid,Proxid);
 
SHARED h := ih_init;
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT311.UIDType Proxid := h.Proxid; // using existing id field
  SALT311.UIDType lgid3 := h.lgid3; // Copy ID from hierarchy
  SALT311.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT311.UIDType ultid := h.ultid; // Copy ID from hierarchy
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
  h.company_fein;
  UNSIGNED1 company_fein_len := 0;  // Place holder filled in by project
  h.company_name;
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))Fields.Make_cnp_name((SALT311.StrType)h.cnp_name ); // Cleans before using
  h.company_name_type_raw;
  h.company_name_type_derived;
  h.cnp_hasnumber;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.cnp_translated;
  h.cnp_classid;
  h.company_foreign_domestic;
  h.company_bdid;
  h.company_phone;
  h.prim_name;
  TYPEOF(h.prim_name_derived) prim_name_derived := (TYPEOF(h.prim_name_derived))Fields.Make_prim_name_derived((SALT311.StrType)h.prim_name_derived ); // Cleans before using
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip;
  h.prim_range;
  h.prim_range_derived;
  UNSIGNED4 company_csz := 0; // Place holder filled in by project
  UNSIGNED4 company_addr1 := 0; // Place holder filled in by project
  UNSIGNED4 company_address := 0; // Place holder filled in by project
  h.dt_first_seen;
  h.dt_last_seen;
  Config.PartitionFieldType SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(Proxid<>0),r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_fein_len := LENGTH(TRIM((SALT311.StrType)le.company_fein));
  SELF.company_csz := IF (Fields.InValid_company_csz((SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)>0,0,HASH32((SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := IF (Fields.InValid_company_addr1((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range)>0,0,HASH32((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.company_address := IF (Fields.InValid_company_address((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)>0,0,HASH32((SALT311.StrType)le.prim_range_derived,(SALT311.StrType)le.prim_name_derived,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT311.MAC_Partition_Stars(h02,SALT_Partition,Proxid); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_cnp_name((SALT311.StrType)h0.cnp_name)>0 OR Fields.Invalid_prim_name_derived((SALT311.StrType)h0.prim_name_derived)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject) : PERSIST('~temp::Proxid::BIPV2_ProxID::Specificities_Cache',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::Cluster_Sizes',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  active_duns_number_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,active_duns_number) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::active_duns_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_duns_number_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::active_duns_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  active_enterprise_number_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,active_enterprise_number) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::active_enterprise_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_enterprise_number_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::active_enterprise_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  active_domestic_corp_key_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,active_domestic_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::active_domestic_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_domestic_corp_key_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::active_domestic_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  hist_enterprise_number_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,hist_enterprise_number) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::hist_enterprise_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT hist_enterprise_number_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::hist_enterprise_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  hist_duns_number_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,hist_duns_number) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::hist_duns_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(hist_duns_number_deduped,hist_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT hist_duns_number_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::hist_duns_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  hist_domestic_corp_key_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,hist_domestic_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::hist_domestic_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(hist_domestic_corp_key_deduped,hist_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT hist_domestic_corp_key_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::hist_domestic_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  foreign_corp_key_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,foreign_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::foreign_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(foreign_corp_key_deduped,foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT foreign_corp_key_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::foreign_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  unk_corp_key_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,unk_corp_key) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::unk_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(unk_corp_key_deduped,unk_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT unk_corp_key_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::unk_corp_key',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  ebr_file_number_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,ebr_file_number) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::ebr_file_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(ebr_file_number_deduped,ebr_file_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ebr_file_number_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::ebr_file_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  company_fein_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,company_fein) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::company_fein',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_fein_values_persisted_temp := distance_computed : PERSIST('~temp::Proxid::BIPV2_ProxID::values::company_fein',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  cnp_name_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,cnp_name) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::cnp_name',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(cnp_name_deduped,Proxid,cnp_name,1); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED cnp_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(cnp_name_deduped,Proxid,cnp_name,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT cnp_name_ad_temp := wb_specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::wbspecs::cnp_name',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(cnp_name_sa,cnp_name,cnp_name_ad_temp,p);
EXPORT cnp_name_values_persisted_temp := p : PERSIST('~temp::Proxid::BIPV2_ProxID::values::cnp_name',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  company_name_type_derived_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,company_name_type_derived) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::company_name_type_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_name_type_derived_deduped,company_name_type_derived,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_name_type_derived_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::company_name_type_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  cnp_number_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,cnp_number) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::cnp_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::cnp_number',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  cnp_btype_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,cnp_btype) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::cnp_btype',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_btype_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::cnp_btype',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  company_phone_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,company_phone) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::company_phone',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_phone_deduped,company_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_phone_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::company_phone',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  prim_name_derived_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,prim_name_derived) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::prim_name_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(prim_name_derived_deduped,Proxid,prim_name_derived,1); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,prim_name_derived,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED prim_name_derived_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(prim_name_derived_deduped,Proxid,prim_name_derived,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,prim_name_derived,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT prim_name_derived_ad_temp := wb_specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::wbspecs::prim_name_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(prim_name_derived_sa,prim_name_derived,prim_name_derived_ad_temp,p);
EXPORT prim_name_derived_values_persisted_temp := p : PERSIST('~temp::Proxid::BIPV2_ProxID::values::prim_name_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  sec_range_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,sec_range) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::sec_range',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(sec_range_deduped,Proxid,sec_range,1); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::sec_range',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  v_city_name_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,v_city_name) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::v_city_name',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::v_city_name',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  st_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,st) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::st',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(st_deduped,st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::st',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  zip_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,zip) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::zip',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(zip_deduped,zip,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::zip',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  prim_range_derived_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,prim_range_derived) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::prim_range_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_range_derived_deduped,prim_range_derived,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_derived_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::prim_range_derived',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  company_csz_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,company_csz) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::company_csz',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_csz_deduped,company_csz,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_csz_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::company_csz',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  company_addr1_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,company_addr1) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::company_addr1',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_addr1_deduped,company_addr1,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_addr1_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::company_addr1',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  company_address_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,company_address) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::company_address',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(company_address_deduped,company_address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_address_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::company_address',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  dt_first_seen_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,dt_first_seen) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::dt_first_seen',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::dt_first_seen',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT  dt_last_seen_deduped := SALT311.MAC_Field_By_UID(input_file,Proxid,dt_last_seen) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::dt_last_seen',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted_temp := specs_added : PERSIST('~temp::Proxid::BIPV2_ProxID::values::dt_last_seen',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::active_duns_number';
 
EXPORT active_duns_number_values_index := INDEX(active_duns_number_values_persisted_temp,{active_duns_number},{active_duns_number_values_persisted_temp},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT311.MAC_Field_Nulls(active_duns_number_values_persisted_temp,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT311.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,Proxid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(active_duns_number_values_persisted_temp,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT active_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::active_enterprise_number';
 
EXPORT active_enterprise_number_values_index := INDEX(active_enterprise_number_values_persisted_temp,{active_enterprise_number},{active_enterprise_number_values_persisted_temp},active_enterprise_numberValuesIndexKeyName);
EXPORT active_enterprise_number_values_persisted := active_enterprise_number_values_index;
SALT311.MAC_Field_Nulls(active_enterprise_number_values_persisted_temp,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_enterprise_number_nulls := nv;
SALT311.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,Proxid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_enterprise_number_switch := bf;
EXPORT active_enterprise_number_max := MAX(active_enterprise_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(active_enterprise_number_values_persisted_temp,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT active_enterprise_number_specificity := ol;
 
EXPORT active_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::active_domestic_corp_key';
 
EXPORT active_domestic_corp_key_values_index := INDEX(active_domestic_corp_key_values_persisted_temp,{active_domestic_corp_key},{active_domestic_corp_key_values_persisted_temp},active_domestic_corp_keyValuesIndexKeyName);
EXPORT active_domestic_corp_key_values_persisted := active_domestic_corp_key_values_index;
SALT311.MAC_Field_Nulls(active_domestic_corp_key_values_persisted_temp,Layout_Specificities.active_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT active_domestic_corp_key_nulls := nv;
SALT311.MAC_Field_Bfoul(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,active_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_domestic_corp_key_switch := bf;
EXPORT active_domestic_corp_key_max := MAX(active_domestic_corp_key_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(active_domestic_corp_key_values_persisted_temp,active_domestic_corp_key,active_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT active_domestic_corp_key_specificity := ol;
 
EXPORT hist_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::hist_enterprise_number';
 
EXPORT hist_enterprise_number_values_index := INDEX(hist_enterprise_number_values_persisted_temp,{hist_enterprise_number},{hist_enterprise_number_values_persisted_temp},hist_enterprise_numberValuesIndexKeyName);
EXPORT hist_enterprise_number_values_persisted := hist_enterprise_number_values_index;
SALT311.MAC_Field_Nulls(hist_enterprise_number_values_persisted_temp,Layout_Specificities.hist_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_enterprise_number_nulls := nv;
SALT311.MAC_Field_Bfoul(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,hist_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_enterprise_number_switch := bf;
EXPORT hist_enterprise_number_max := MAX(hist_enterprise_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(hist_enterprise_number_values_persisted_temp,hist_enterprise_number,hist_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT hist_enterprise_number_specificity := ol;
 
EXPORT hist_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::hist_duns_number';
 
EXPORT hist_duns_number_values_index := INDEX(hist_duns_number_values_persisted_temp,{hist_duns_number},{hist_duns_number_values_persisted_temp},hist_duns_numberValuesIndexKeyName);
EXPORT hist_duns_number_values_persisted := hist_duns_number_values_index;
SALT311.MAC_Field_Nulls(hist_duns_number_values_persisted_temp,Layout_Specificities.hist_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_duns_number_nulls := nv;
SALT311.MAC_Field_Bfoul(hist_duns_number_deduped,hist_duns_number,Proxid,hist_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_duns_number_switch := bf;
EXPORT hist_duns_number_max := MAX(hist_duns_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(hist_duns_number_values_persisted_temp,hist_duns_number,hist_duns_number_nulls,ol) // Compute column level specificity
EXPORT hist_duns_number_specificity := ol;
 
EXPORT hist_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::hist_domestic_corp_key';
 
EXPORT hist_domestic_corp_key_values_index := INDEX(hist_domestic_corp_key_values_persisted_temp,{hist_domestic_corp_key},{hist_domestic_corp_key_values_persisted_temp},hist_domestic_corp_keyValuesIndexKeyName);
EXPORT hist_domestic_corp_key_values_persisted := hist_domestic_corp_key_values_index;
SALT311.MAC_Field_Nulls(hist_domestic_corp_key_values_persisted_temp,Layout_Specificities.hist_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_domestic_corp_key_nulls := nv;
SALT311.MAC_Field_Bfoul(hist_domestic_corp_key_deduped,hist_domestic_corp_key,Proxid,hist_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_domestic_corp_key_switch := bf;
EXPORT hist_domestic_corp_key_max := MAX(hist_domestic_corp_key_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(hist_domestic_corp_key_values_persisted_temp,hist_domestic_corp_key,hist_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT hist_domestic_corp_key_specificity := ol;
 
EXPORT foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::foreign_corp_key';
 
EXPORT foreign_corp_key_values_index := INDEX(foreign_corp_key_values_persisted_temp,{foreign_corp_key},{foreign_corp_key_values_persisted_temp},foreign_corp_keyValuesIndexKeyName);
EXPORT foreign_corp_key_values_persisted := foreign_corp_key_values_index;
SALT311.MAC_Field_Nulls(foreign_corp_key_values_persisted_temp,Layout_Specificities.foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT foreign_corp_key_nulls := nv;
SALT311.MAC_Field_Bfoul(foreign_corp_key_deduped,foreign_corp_key,Proxid,foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT foreign_corp_key_switch := bf;
EXPORT foreign_corp_key_max := MAX(foreign_corp_key_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(foreign_corp_key_values_persisted_temp,foreign_corp_key,foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT foreign_corp_key_specificity := ol;
 
EXPORT unk_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::unk_corp_key';
 
EXPORT unk_corp_key_values_index := INDEX(unk_corp_key_values_persisted_temp,{unk_corp_key},{unk_corp_key_values_persisted_temp},unk_corp_keyValuesIndexKeyName);
EXPORT unk_corp_key_values_persisted := unk_corp_key_values_index;
SALT311.MAC_Field_Nulls(unk_corp_key_values_persisted_temp,Layout_Specificities.unk_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT unk_corp_key_nulls := nv;
SALT311.MAC_Field_Bfoul(unk_corp_key_deduped,unk_corp_key,Proxid,unk_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT unk_corp_key_switch := bf;
EXPORT unk_corp_key_max := MAX(unk_corp_key_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(unk_corp_key_values_persisted_temp,unk_corp_key,unk_corp_key_nulls,ol) // Compute column level specificity
EXPORT unk_corp_key_specificity := ol;
 
EXPORT ebr_file_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::ebr_file_number';
 
EXPORT ebr_file_number_values_index := INDEX(ebr_file_number_values_persisted_temp,{ebr_file_number},{ebr_file_number_values_persisted_temp},ebr_file_numberValuesIndexKeyName);
EXPORT ebr_file_number_values_persisted := ebr_file_number_values_index;
SALT311.MAC_Field_Nulls(ebr_file_number_values_persisted_temp,Layout_Specificities.ebr_file_number_ChildRec,nv) // Use automated NULL spotting
EXPORT ebr_file_number_nulls := nv;
SALT311.MAC_Field_Bfoul(ebr_file_number_deduped,ebr_file_number,Proxid,ebr_file_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ebr_file_number_switch := bf;
EXPORT ebr_file_number_max := MAX(ebr_file_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(ebr_file_number_values_persisted_temp,ebr_file_number,ebr_file_number_nulls,ol) // Compute column level specificity
EXPORT ebr_file_number_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT311.MAC_Field_Nulls(company_fein_values_persisted_temp,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT311.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_fein_values_persisted_temp,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT cnp_nameWBTokenSpecKeyName := '~'+'key::BIPV2_ProxID::Proxid::WordBag_specs::cnp_name';
 
EXPORT cnp_name_wbtokenspec_index := INDEX(cnp_name_ad_temp,{cnp_name},{cnp_name_ad_temp},cnp_nameWBTokenSpecKeyName);
EXPORT cnp_name_ad := cnp_name_wbtokenspec_index;
 
EXPORT cnp_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::cnp_name';
 
EXPORT cnp_name_values_index := INDEX(cnp_name_values_persisted_temp,{cnp_name},{cnp_name_values_persisted_temp},cnp_nameValuesIndexKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
EXPORT cnp_name_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_name_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,Proxid,cnp_name_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(cnp_name_values_persisted_temp,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT company_name_type_derivedValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::company_name_type_derived';
 
EXPORT company_name_type_derived_values_index := INDEX(company_name_type_derived_values_persisted_temp,{company_name_type_derived},{company_name_type_derived_values_persisted_temp},company_name_type_derivedValuesIndexKeyName);
EXPORT company_name_type_derived_values_persisted := company_name_type_derived_values_index;
EXPORT company_name_type_derived_nulls := DATASET([{'',0,0}],Layout_Specificities.company_name_type_derived_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(company_name_type_derived_deduped,company_name_type_derived,Proxid,company_name_type_derived_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_type_derived_switch := bf;
EXPORT company_name_type_derived_max := MAX(company_name_type_derived_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_name_type_derived_values_persisted_temp,company_name_type_derived,company_name_type_derived_nulls,ol) // Compute column level specificity
EXPORT company_name_type_derived_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT311.MAC_Field_Nulls(cnp_number_values_persisted_temp,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT311.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,Proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(cnp_number_values_persisted_temp,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::cnp_btype';
 
EXPORT cnp_btype_values_index := INDEX(cnp_btype_values_persisted_temp,{cnp_btype},{cnp_btype_values_persisted_temp},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,Proxid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(cnp_btype_values_persisted_temp,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT company_phoneValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::company_phone';
 
EXPORT company_phone_values_index := INDEX(company_phone_values_persisted_temp,{company_phone},{company_phone_values_persisted_temp},company_phoneValuesIndexKeyName);
EXPORT company_phone_values_persisted := company_phone_values_index;
SALT311.MAC_Field_Nulls(company_phone_values_persisted_temp,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_nulls := nv;
SALT311.MAC_Field_Bfoul(company_phone_deduped,company_phone,Proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_switch := bf;
EXPORT company_phone_max := MAX(company_phone_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_phone_values_persisted_temp,company_phone,company_phone_nulls,ol) // Compute column level specificity
EXPORT company_phone_specificity := ol;
 
EXPORT prim_name_derivedWBTokenSpecKeyName := '~'+'key::BIPV2_ProxID::Proxid::WordBag_specs::prim_name_derived';
 
EXPORT prim_name_derived_wbtokenspec_index := INDEX(prim_name_derived_ad_temp,{prim_name_derived},{prim_name_derived_ad_temp},prim_name_derivedWBTokenSpecKeyName);
EXPORT prim_name_derived_ad := prim_name_derived_wbtokenspec_index;
 
EXPORT prim_name_derivedValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::prim_name_derived';
 
EXPORT prim_name_derived_values_index := INDEX(prim_name_derived_values_persisted_temp,{prim_name_derived},{prim_name_derived_values_persisted_temp},prim_name_derivedValuesIndexKeyName);
EXPORT prim_name_derived_values_persisted := prim_name_derived_values_index;
EXPORT prim_name_derived_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_name_derived_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(prim_name_derived_deduped,prim_name_derived,Proxid,prim_name_derived_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_derived_switch := bf;
EXPORT prim_name_derived_max := MAX(prim_name_derived_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_name_derived_values_persisted_temp,prim_name_derived,prim_name_derived_nulls,ol) // Compute column level specificity
EXPORT prim_name_derived_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::sec_range';
 
EXPORT sec_range_values_index := INDEX(sec_range_values_persisted_temp,{sec_range},{sec_range_values_persisted_temp},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT311.MAC_Field_Nulls(sec_range_values_persisted_temp,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT311.MAC_Field_Bfoul(sec_range_deduped,sec_range,Proxid,sec_range_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(sec_range_values_persisted_temp,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::v_city_name';
 
EXPORT v_city_name_values_index := INDEX(v_city_name_values_persisted_temp,{v_city_name},{v_city_name_values_persisted_temp},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT311.MAC_Field_Nulls(v_city_name_values_persisted_temp,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT311.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Proxid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(v_city_name_values_persisted_temp,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT311.MAC_Field_Nulls(st_values_persisted_temp,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT311.MAC_Field_Bfoul(st_deduped,st,Proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(st_values_persisted_temp,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT311.MAC_Field_Nulls(zip_values_persisted_temp,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT311.MAC_Field_Bfoul(zip_deduped,zip,Proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(zip_values_persisted_temp,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT prim_range_derivedValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::prim_range_derived';
 
EXPORT prim_range_derived_values_index := INDEX(prim_range_derived_values_persisted_temp,{prim_range_derived},{prim_range_derived_values_persisted_temp},prim_range_derivedValuesIndexKeyName);
EXPORT prim_range_derived_values_persisted := prim_range_derived_values_index;
SALT311.MAC_Field_Nulls(prim_range_derived_values_persisted_temp,Layout_Specificities.prim_range_derived_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_derived_nulls := nv;
SALT311.MAC_Field_Bfoul(prim_range_derived_deduped,prim_range_derived,Proxid,prim_range_derived_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_derived_switch := bf;
EXPORT prim_range_derived_max := MAX(prim_range_derived_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_range_derived_values_persisted_temp,prim_range_derived,prim_range_derived_nulls,ol) // Compute column level specificity
EXPORT prim_range_derived_specificity := ol;
 
EXPORT company_cszValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::company_csz';
 
EXPORT company_csz_values_index := INDEX(company_csz_values_persisted_temp,{company_csz},{company_csz_values_persisted_temp},company_cszValuesIndexKeyName);
EXPORT company_csz_values_persisted := company_csz_values_index;
SALT311.MAC_Field_Nulls(company_csz_values_persisted_temp,Layout_Specificities.company_csz_ChildRec,nv) // Use automated NULL spotting
EXPORT company_csz_nulls := nv;
SALT311.MAC_Field_Bfoul(company_csz_deduped,company_csz,Proxid,company_csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_csz_switch := bf;
EXPORT company_csz_max := MAX(company_csz_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_csz_values_persisted_temp,company_csz,company_csz_nulls,ol) // Compute column level specificity
EXPORT company_csz_specificity := ol;
 
EXPORT company_addr1ValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::company_addr1';
 
EXPORT company_addr1_values_index := INDEX(company_addr1_values_persisted_temp,{company_addr1},{company_addr1_values_persisted_temp},company_addr1ValuesIndexKeyName);
EXPORT company_addr1_values_persisted := company_addr1_values_index;
SALT311.MAC_Field_Nulls(company_addr1_values_persisted_temp,Layout_Specificities.company_addr1_ChildRec,nv) // Use automated NULL spotting
EXPORT company_addr1_nulls := nv;
SALT311.MAC_Field_Bfoul(company_addr1_deduped,company_addr1,Proxid,company_addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_addr1_switch := bf;
EXPORT company_addr1_max := MAX(company_addr1_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_addr1_values_persisted_temp,company_addr1,company_addr1_nulls,ol) // Compute column level specificity
EXPORT company_addr1_specificity := ol;
 
EXPORT company_addressValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::company_address';
 
EXPORT company_address_values_index := INDEX(company_address_values_persisted_temp,{company_address},{company_address_values_persisted_temp},company_addressValuesIndexKeyName);
EXPORT company_address_values_persisted := company_address_values_index;
SALT311.MAC_Field_Nulls(company_address_values_persisted_temp,Layout_Specificities.company_address_ChildRec,nv) // Use automated NULL spotting
EXPORT company_address_nulls := nv;
SALT311.MAC_Field_Bfoul(company_address_deduped,company_address,Proxid,company_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_address_switch := bf;
EXPORT company_address_max := MAX(company_address_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(company_address_values_persisted_temp,company_address,company_address_nulls,ol) // Compute column level specificity
EXPORT company_address_specificity := ol;
 
EXPORT dt_first_seenValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::dt_first_seen';
 
EXPORT dt_first_seen_values_index := INDEX(dt_first_seen_values_persisted_temp,{dt_first_seen},{dt_first_seen_values_persisted_temp},dt_first_seenValuesIndexKeyName);
EXPORT dt_first_seen_values_persisted := dt_first_seen_values_index;
SALT311.MAC_Field_Nulls(dt_first_seen_values_persisted_temp,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,Proxid,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(dt_first_seen_values_persisted_temp,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
 
EXPORT dt_last_seenValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::dt_last_seen';
 
EXPORT dt_last_seen_values_index := INDEX(dt_last_seen_values_persisted_temp,{dt_last_seen},{dt_last_seen_values_persisted_temp},dt_last_seenValuesIndexKeyName);
EXPORT dt_last_seen_values_persisted := dt_last_seen_values_index;
SALT311.MAC_Field_Nulls(dt_last_seen_values_persisted_temp,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT311.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,Proxid,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(dt_last_seen_values_persisted_temp,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(active_enterprise_number_values_index, OVERWRITE),BUILDINDEX(active_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(hist_enterprise_number_values_index, OVERWRITE),BUILDINDEX(hist_duns_number_values_index, OVERWRITE),BUILDINDEX(hist_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(unk_corp_key_values_index, OVERWRITE),BUILDINDEX(ebr_file_number_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(cnp_name_wbtokenspec_index, OVERWRITE),BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(company_name_type_derived_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE),BUILDINDEX(company_phone_values_index, OVERWRITE),BUILDINDEX(prim_name_derived_wbtokenspec_index, OVERWRITE),BUILDINDEX(prim_name_derived_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(prim_range_derived_values_index, OVERWRITE),BUILDINDEX(company_csz_values_index, OVERWRITE),BUILDINDEX(company_addr1_values_index, OVERWRITE),BUILDINDEX(company_address_values_index, OVERWRITE),BUILDINDEX(dt_first_seen_values_index, OVERWRITE),BUILDINDEX(dt_last_seen_values_index, OVERWRITE));
 
  infile := file_SrcRidVlid;
 r := RECORD
    Config.AttrValueType Basis := TRIM((SALT311.StrType)infile.source) + '|' + TRIM((SALT311.StrType)infile.source_record_id) + '|' + TRIM((SALT311.StrType)infile.vl_id);
    infile.source; // Easy way to get component values
    INTEGER2 source_weight100 := 0; // Easy place to store weight
    infile.source_record_id; // Easy way to get component values
    INTEGER2 source_record_id_weight100 := 0; // Easy place to store weight
    infile.vl_id; // Easy way to get component values
    INTEGER2 vl_id_weight100 := 0; // Easy place to store weight
    SALT311.UIDType Proxid := infile.Proxid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED SrcRidVlid_attributes := DEDUP( SORT( DISTRIBUTE( t, Proxid ), Proxid, Basis, LOCAL), Proxid, Basis, LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::values::SrcRidVlid',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
  SALT311.Mac_Specificity_Local(SrcRidVlid_attributes,Basis,Proxid,SrcRidVlid_nulls,Layout_Specificities.SrcRidVlid_ChildRec,SrcRidVlid_specificity,SrcRidVlid_switch,SrcRidVlid_values);
EXPORT SrcRidVlid_max := MAX(SrcRidVlid_values,field_specificity);
 
EXPORT SrcRidVlidValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::SrcRidVlid';
  TYPEOF(SrcRidVlid_attributes) take(SrcRidVlid_attributes le,SrcRidVlid_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.source_weight100 := SELF.Basis_weight100 / 3;
    SELF.source_record_id_weight100 := SELF.Basis_weight100 / 3;
    SELF.vl_id_weight100 := SELF.Basis_weight100 / 3;
    SELF := le;
  END;
  non_null_atts := SrcRidVlid_attributes(Basis NOT IN SET(SrcRidVlid_nulls,Basis));
SALT311.MAC_Choose_JoinType(non_null_atts,SrcRidVlid_nulls,SrcRidVlid_values,Basis,Basis_weight100,take,SrcRidVlid_v);
 
EXPORT SrcRidVlid_values_index := INDEX(SrcRidVlid_v,{Basis},{SrcRidVlid_v},SrcRidVlidValuesIndexKeyName);
EXPORT SrcRidVlid_values_persisted := SrcRidVlid_values_index;
 
  infile := file_Foreign_Corpkey;
 r := RECORD
    Config.AttrValueType Basis := TRIM((SALT311.StrType)infile.company_charter_number) + '|' + TRIM((SALT311.StrType)infile.company_inc_state);
    infile.company_charter_number; // Easy way to get component values
    INTEGER2 company_charter_number_weight100 := 0; // Easy place to store weight
    infile.company_inc_state; // Easy way to get component values
    INTEGER2 company_inc_state_weight100 := 0; // Easy place to store weight
    SALT311.UIDType Proxid := infile.Proxid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED ForeignCorpkey_attributes := DEDUP( SORT( DISTRIBUTE( t, Proxid ), Proxid, Basis, LOCAL), Proxid, Basis, LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::values::ForeignCorpkey',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
  SALT311.Mac_Specificity_Local(ForeignCorpkey_attributes,Basis,Proxid,ForeignCorpkey_nulls,Layout_Specificities.ForeignCorpkey_ChildRec,ForeignCorpkey_specificity,ForeignCorpkey_switch,ForeignCorpkey_values);
EXPORT ForeignCorpkey_max := MAX(ForeignCorpkey_values,field_specificity);
 
EXPORT ForeignCorpkeyValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::ForeignCorpkey';
  TYPEOF(ForeignCorpkey_attributes) take(ForeignCorpkey_attributes le,ForeignCorpkey_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.company_charter_number_weight100 := SELF.Basis_weight100 / 2;
    SELF.company_inc_state_weight100 := SELF.Basis_weight100 / 2;
    SELF := le;
  END;
  non_null_atts := ForeignCorpkey_attributes(Basis NOT IN SET(ForeignCorpkey_nulls,Basis));
SALT311.MAC_Choose_JoinType(non_null_atts,ForeignCorpkey_nulls,ForeignCorpkey_values,Basis,Basis_weight100,take,ForeignCorpkey_v);
 
EXPORT ForeignCorpkey_values_index := INDEX(ForeignCorpkey_v,{Basis},{ForeignCorpkey_v},ForeignCorpkeyValuesIndexKeyName);
EXPORT ForeignCorpkey_values_persisted := ForeignCorpkey_values_index;
 
  infile := file_RA_Addresses;
 r := RECORD
    Config.AttrValueType Basis := TRIM((SALT311.StrType)infile.cname);
    infile.cname; // Easy way to get component values
    INTEGER2 cname_weight100 := 0; // Easy place to store weight
    SALT311.UIDType Proxid := infile.Proxid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED RAAddresses_attributes := DEDUP( SORT( DISTRIBUTE( t, Proxid ), Proxid, Basis, LOCAL), Proxid, Basis, LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::values::RAAddresses',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
  SALT311.Mac_Specificity_Local(RAAddresses_attributes,Basis,Proxid,RAAddresses_nulls,Layout_Specificities.RAAddresses_ChildRec,RAAddresses_specificity,RAAddresses_switch,RAAddresses_values);
EXPORT RAAddresses_max := MAX(RAAddresses_values,field_specificity);
 
EXPORT RAAddressesValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::RAAddresses';
  TYPEOF(RAAddresses_attributes) take(RAAddresses_attributes le,RAAddresses_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.cname_weight100 := SELF.Basis_weight100 / 1;
    SELF := le;
  END;
  non_null_atts := RAAddresses_attributes(Basis NOT IN SET(RAAddresses_nulls,Basis));
SALT311.MAC_Choose_JoinType(non_null_atts,RAAddresses_nulls,RAAddresses_values,Basis,Basis_weight100,take,RAAddresses_v);
 
EXPORT RAAddresses_values_index := INDEX(RAAddresses_v,{Basis},{RAAddresses_v},RAAddressesValuesIndexKeyName);
EXPORT RAAddresses_values_persisted := RAAddresses_values_index;
 
  infile := file_filter_Prim_names;
 r := RECORD
    Config.AttrValueType Basis := TRIM((SALT311.StrType)infile.pname_digits);
    infile.pname_digits; // Easy way to get component values
    INTEGER2 pname_digits_weight100 := 0; // Easy place to store weight
    SALT311.UIDType Proxid := infile.Proxid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED FilterPrimNames_attributes := DEDUP( SORT( DISTRIBUTE( t, Proxid ), Proxid, Basis, LOCAL), Proxid, Basis, LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::values::FilterPrimNames',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
  SALT311.Mac_Specificity_Local(FilterPrimNames_attributes,Basis,Proxid,FilterPrimNames_nulls,Layout_Specificities.FilterPrimNames_ChildRec,FilterPrimNames_specificity,FilterPrimNames_switch,FilterPrimNames_values);
EXPORT FilterPrimNames_max := MAX(FilterPrimNames_values,field_specificity);
 
EXPORT FilterPrimNamesValuesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::FilterPrimNames';
  TYPEOF(FilterPrimNames_attributes) take(FilterPrimNames_attributes le,FilterPrimNames_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.pname_digits_weight100 := SELF.Basis_weight100 / 1;
    SELF := le;
  END;
  non_null_atts := FilterPrimNames_attributes(Basis NOT IN SET(FilterPrimNames_nulls,Basis));
SALT311.MAC_Choose_JoinType(non_null_atts,FilterPrimNames_nulls,FilterPrimNames_values,Basis,Basis_weight100,take,FilterPrimNames_v);
 
EXPORT FilterPrimNames_values_index := INDEX(FilterPrimNames_v,{Basis},{FilterPrimNames_v},FilterPrimNamesValuesIndexKeyName);
EXPORT FilterPrimNames_values_persisted := FilterPrimNames_values_index;
 
EXPORT BuildAttributes := PARALLEL(BUILDINDEX(SrcRidVlid_values_index, OVERWRITE),BUILDINDEX(ForeignCorpkey_values_index, OVERWRITE),BUILDINDEX(RAAddresses_values_index, OVERWRITE),BUILDINDEX(FilterPrimNames_values_index, OVERWRITE));
EXPORT Layout_Uber_Plus := RECORD(SALT311.Layout_Uber_Record0)
  SALT311.Str30Type word;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(input_file le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.active_duns_number,(SALT311.StrType)le.active_enterprise_number,(SALT311.StrType)le.active_domestic_corp_key,(SALT311.StrType)le.hist_enterprise_number,(SALT311.StrType)le.hist_duns_number,(SALT311.StrType)le.hist_domestic_corp_key,(SALT311.StrType)le.foreign_corp_key,(SALT311.StrType)le.unk_corp_key,(SALT311.StrType)le.ebr_file_number,(SALT311.StrType)le.company_fein,(SALT311.StrType)le.company_name,'',(SALT311.StrType)le.company_name_type_raw,(SALT311.StrType)le.company_name_type_derived,(SALT311.StrType)le.cnp_hasnumber,(SALT311.StrType)le.cnp_number,(SALT311.StrType)le.cnp_btype,(SALT311.StrType)le.cnp_lowv,(SALT311.StrType)le.cnp_translated,(SALT311.StrType)le.cnp_classid,(SALT311.StrType)le.company_foreign_domestic,(SALT311.StrType)le.company_bdid,(SALT311.StrType)le.company_phone,(SALT311.StrType)le.prim_name,'',(SALT311.StrType)le.sec_range,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.prim_range_derived,SKIP,SKIP,SKIP,'','',SKIP);
  SELF.field := c;
  SELF.uid := le.Proxid;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(input_file,36,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Wordbag_Field(input_file,cnp_name,12,Proxid,layout_uber_plus,nfields12);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_derived,25,Proxid,layout_uber_plus,nfields25);
SALT311.MAC_Expand_Normal_Field(input_file,v_city_name,32,Proxid,layout_uber_plus,nfields7456);
SALT311.MAC_Expand_Normal_Field(input_file,st,32,Proxid,layout_uber_plus,nfields7457);
SALT311.MAC_Expand_Normal_Field(input_file,zip,32,Proxid,layout_uber_plus,nfields7458);
nfields32 := nfields7456+nfields7457+nfields7458;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,prim_range_derived,33,Proxid,layout_uber_plus,nfields7689);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_derived,33,Proxid,layout_uber_plus,nfields7690);
SALT311.MAC_Expand_Normal_Field(input_file,sec_range,33,Proxid,layout_uber_plus,nfields7691);
nfields33 := nfields7689+nfields7690+nfields7691;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,prim_range_derived,34,Proxid,layout_uber_plus,nfields1845826);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_derived,34,Proxid,layout_uber_plus,nfields1845827);
SALT311.MAC_Expand_Normal_Field(input_file,sec_range,34,Proxid,layout_uber_plus,nfields1845828);
nfields7922 := nfields1845826+nfields1845827+nfields1845828;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Normal_Field(input_file,v_city_name,34,Proxid,layout_uber_plus,nfields1846059);
SALT311.MAC_Expand_Normal_Field(input_file,st,34,Proxid,layout_uber_plus,nfields1846060);
SALT311.MAC_Expand_Normal_Field(input_file,zip,34,Proxid,layout_uber_plus,nfields1846061);
nfields7923 := nfields1846059+nfields1846060+nfields1846061;//Collect wordbags for parts of concept field
nfields34 := nfields7922+nfields7923;//Collect wordbags for parts of concept field
NumberBaseFields := 36;
 
infileSrcRidVlid := file_SrcRidVlid;
Layout_Uber_Plus IntoInversion0(infileSrcRidVlid le,UNSIGNED2 c,UNSIGNED el=1) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.source,(SALT311.StrType)le.source_record_id,(SALT311.StrType)le.vl_id,SKIP);
  SELF.field := c+0+NumberBaseFields; // Field number is attr file + Fields from attr files + BaseFields
  SELF.uid := le.Proxid;
  SELF := le;
END;
afields0 := NORMALIZE(infileSrcRidVlid,3,IntoInversion0(LEFT,COUNTER))(word<>'');
 
infileForeignCorpkey := file_Foreign_Corpkey;
Layout_Uber_Plus IntoInversion3(infileForeignCorpkey le,UNSIGNED2 c,UNSIGNED el=1) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.company_charter_number,(SALT311.StrType)le.company_inc_state,SKIP);
  SELF.field := c+3+NumberBaseFields; // Field number is attr file + Fields from attr files + BaseFields
  SELF.uid := le.Proxid;
  SELF := le;
END;
afields3 := NORMALIZE(infileForeignCorpkey,2,IntoInversion3(LEFT,COUNTER))(word<>'');
 
infileRAAddresses := file_RA_Addresses;
Layout_Uber_Plus IntoInversion5(infileRAAddresses le,UNSIGNED2 c,UNSIGNED el=1) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.cname,SKIP);
  SELF.field := c+5+NumberBaseFields; // Field number is attr file + Fields from attr files + BaseFields
  SELF.uid := le.Proxid;
  SELF := le;
END;
afields5 := NORMALIZE(infileRAAddresses,1,IntoInversion5(LEFT,COUNTER))(word<>'');
 
infileFilterPrimNames := file_filter_Prim_names;
Layout_Uber_Plus IntoInversion6(infileFilterPrimNames le,UNSIGNED2 c,UNSIGNED el=1) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.pname_digits,SKIP);
  SELF.field := c+6+NumberBaseFields; // Field number is attr file + Fields from attr files + BaseFields
  SELF.uid := le.Proxid;
  SELF := le;
END;
afields6 := NORMALIZE(infileFilterPrimNames,1,IntoInversion6(LEFT,COUNTER))(word<>'');
SHARED invert_records := nfields_r + nfields12 + nfields25 + afields0 + afields3 + afields5 + afields6;
uber_values_deduped0 := Fn_Reduce_UBER_Local( DISTRIBUTE(invert_records,HASH(uid)));
// minimize otherwise required changes to the macros used by uber and specificities!
Layout_Uber_Plus_Spec := RECORD(Layout_Uber_Plus AND NOT uid)
  SALT311.UIDType Proxid;
END;
SHARED uber_values_deduped := PROJECT(uber_values_deduped0,TRANSFORM(Layout_Uber_Plus_Spec,SELF.Proxid:=LEFT.uid,SELF:=LEFT)) : PERSIST('~temp::Proxid::BIPV2_ProxID::dedups::uber',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
SALT311.MAC_Specificity_Local(uber_values_deduped,word,Proxid,uber_nulls,Layout_Specificities.uber_ChildRec,word_specificity,word_switch,word_values)
EXPORT uber_values_persisted_temp := word_values : PERSIST('~temp::Proxid::BIPV2_ProxID::values::uber',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
EXPORT UbervaluesIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Word::Uber';
 
EXPORT uber_values_index := INDEX(uber_values_persisted_temp,{word},{uber_values_persisted_temp},UbervaluesIndexKeyName);
EXPORT Uber_values_persisted := uber_values_index;
 
EXPORT BuildUber := BUILDINDEX(uber_values_index, OVERWRITE);
SALT311.MAC_Field_Bfoul(uber_values_deduped,word,Proxid,uber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT uber_switch := bf;
EXPORT uber_max := MAX(uber_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(uber_values_persisted_temp,word,uber_nulls,ol) // Compute column level specificity;
EXPORT uber_specificity := ol;
EXPORT BuildAll := PARALLEL(BuildFields, BuildAttributes, BuildUber);
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_ProxID::Proxid::Specificities';
iSpecificities := DATASET([{0,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,active_domestic_corp_key_specificity,active_domestic_corp_key_switch,active_domestic_corp_key_max,active_domestic_corp_key_nulls,hist_enterprise_number_specificity,hist_enterprise_number_switch,hist_enterprise_number_max,hist_enterprise_number_nulls,hist_duns_number_specificity,hist_duns_number_switch,hist_duns_number_max,hist_duns_number_nulls,hist_domestic_corp_key_specificity,hist_domestic_corp_key_switch,hist_domestic_corp_key_max,hist_domestic_corp_key_nulls,foreign_corp_key_specificity,foreign_corp_key_switch,foreign_corp_key_max,foreign_corp_key_nulls,unk_corp_key_specificity,unk_corp_key_switch,unk_corp_key_max,unk_corp_key_nulls,ebr_file_number_specificity,ebr_file_number_switch,ebr_file_number_max,ebr_file_number_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,company_name_type_derived_specificity,company_name_type_derived_switch,company_name_type_derived_max,company_name_type_derived_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,prim_name_derived_specificity,prim_name_derived_switch,prim_name_derived_max,prim_name_derived_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,prim_range_derived_specificity,prim_range_derived_switch,prim_range_derived_max,prim_range_derived_nulls,company_csz_specificity,company_csz_switch,company_csz_max,company_csz_nulls,company_addr1_specificity,company_addr1_switch,company_addr1_max,company_addr1_nulls,company_address_specificity,company_address_switch,company_address_max,company_address_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,SrcRidVlid_specificity,SrcRidVlid_switch,SrcRidVlid_max,SrcRidVlid_nulls,ForeignCorpkey_specificity,ForeignCorpkey_switch,ForeignCorpkey_max,ForeignCorpkey_nulls,RAAddresses_specificity,RAAddresses_switch,RAAddresses_max,RAAddresses_nulls,FilterPrimNames_specificity,FilterPrimNames_switch,FilterPrimNames_max,FilterPrimNames_nulls,uber_specificity,uber_switch,uber_max,uber_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT BuildSpec := BUILDINDEX(Specificities_Index, OVERWRITE, FEW);
 
EXPORT Build := SEQUENTIAL(BuildAll, BuildSpec);
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 18);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 78);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 20);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 15);
  integer1 active_domestic_corp_key_shift0 := ROUND(Specificities[1].active_domestic_corp_key_specificity - 19);
  integer2 active_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].active_domestic_corp_key_switch - 1);
  integer1 hist_enterprise_number_shift0 := ROUND(Specificities[1].hist_enterprise_number_specificity - 20);
  integer2 hist_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].hist_enterprise_number_switch - 22);
  integer1 hist_duns_number_shift0 := ROUND(Specificities[1].hist_duns_number_specificity - 18);
  integer2 hist_duns_number_switch_shift0 := ROUND(1000*Specificities[1].hist_duns_number_switch - 72);
  integer1 hist_domestic_corp_key_shift0 := ROUND(Specificities[1].hist_domestic_corp_key_specificity - 19);
  integer2 hist_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].hist_domestic_corp_key_switch - 151);
  integer1 foreign_corp_key_shift0 := ROUND(Specificities[1].foreign_corp_key_specificity - 19);
  integer2 foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].foreign_corp_key_switch - 418);
  integer1 unk_corp_key_shift0 := ROUND(Specificities[1].unk_corp_key_specificity - 19);
  integer2 unk_corp_key_switch_shift0 := ROUND(1000*Specificities[1].unk_corp_key_switch - 133);
  integer1 ebr_file_number_shift0 := ROUND(Specificities[1].ebr_file_number_specificity - 20);
  integer2 ebr_file_number_switch_shift0 := ROUND(1000*Specificities[1].ebr_file_number_switch - 427);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 17);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 227);
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 12);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 334);
  integer1 company_name_type_derived_shift0 := ROUND(Specificities[1].company_name_type_derived_specificity - 1);
  integer2 company_name_type_derived_switch_shift0 := ROUND(1000*Specificities[1].company_name_type_derived_switch - 402);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 13);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 0);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 166);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 18);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 426);
  integer1 prim_name_derived_shift0 := ROUND(Specificities[1].prim_name_derived_specificity - 11);
  integer2 prim_name_derived_switch_shift0 := ROUND(1000*Specificities[1].prim_name_derived_switch - 14);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 11);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 142);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 10);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 18);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 13);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 18);
  integer1 prim_range_derived_shift0 := ROUND(Specificities[1].prim_range_derived_specificity - 12);
  integer2 prim_range_derived_switch_shift0 := ROUND(1000*Specificities[1].prim_range_derived_switch - 7);
  integer1 company_csz_shift0 := ROUND(Specificities[1].company_csz_specificity - 13);
  integer2 company_csz_switch_shift0 := ROUND(1000*Specificities[1].company_csz_switch - 52);
  integer1 company_addr1_shift0 := ROUND(Specificities[1].company_addr1_specificity - 17);
  integer2 company_addr1_switch_shift0 := ROUND(1000*Specificities[1].company_addr1_switch - 177);
  integer1 company_address_shift0 := ROUND(Specificities[1].company_address_specificity - 18);
  integer2 company_address_switch_shift0 := ROUND(1000*Specificities[1].company_address_switch - 205);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  INTEGER1 SrcRidVlid_shift0 := ROUND(Specificities[1].SrcRidVlid_specificity - 19);
  INTEGER2 SrcRidVlid_switch_shift0 := ROUND(1000*Specificities[1].SrcRidVlid_switch - 753);
  INTEGER1 ForeignCorpkey_shift0 := ROUND(Specificities[1].ForeignCorpkey_specificity - 19);
  INTEGER2 ForeignCorpkey_switch_shift0 := ROUND(1000*Specificities[1].ForeignCorpkey_switch - 321);
  INTEGER1 RAAddresses_shift0 := ROUND(Specificities[1].RAAddresses_specificity - 18);
  INTEGER2 RAAddresses_switch_shift0 := ROUND(1000*Specificities[1].RAAddresses_switch - 196);
  INTEGER1 FilterPrimNames_shift0 := ROUND(Specificities[1].FilterPrimNames_specificity - 12);
  INTEGER2 FilterPrimNames_switch_shift0 := ROUND(1000*Specificities[1].FilterPrimNames_switch - 5);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT311.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT311.MAC_Specificity_Values(active_enterprise_number_values_persisted,active_enterprise_number,'active_enterprise_number',active_enterprise_number_specificity,active_enterprise_number_specificity_profile);
  SALT311.MAC_Specificity_Values(active_domestic_corp_key_values_persisted,active_domestic_corp_key,'active_domestic_corp_key',active_domestic_corp_key_specificity,active_domestic_corp_key_specificity_profile);
  SALT311.MAC_Specificity_Values(hist_enterprise_number_values_persisted,hist_enterprise_number,'hist_enterprise_number',hist_enterprise_number_specificity,hist_enterprise_number_specificity_profile);
  SALT311.MAC_Specificity_Values(hist_duns_number_values_persisted,hist_duns_number,'hist_duns_number',hist_duns_number_specificity,hist_duns_number_specificity_profile);
  SALT311.MAC_Specificity_Values(hist_domestic_corp_key_values_persisted,hist_domestic_corp_key,'hist_domestic_corp_key',hist_domestic_corp_key_specificity,hist_domestic_corp_key_specificity_profile);
  SALT311.MAC_Specificity_Values(foreign_corp_key_values_persisted,foreign_corp_key,'foreign_corp_key',foreign_corp_key_specificity,foreign_corp_key_specificity_profile);
  SALT311.MAC_Specificity_Values(unk_corp_key_values_persisted,unk_corp_key,'unk_corp_key',unk_corp_key_specificity,unk_corp_key_specificity_profile);
  SALT311.MAC_Specificity_Values(ebr_file_number_values_persisted,ebr_file_number,'ebr_file_number',ebr_file_number_specificity,ebr_file_number_specificity_profile);
  SALT311.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT311.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT311.MAC_Specificity_Values(company_name_type_derived_values_persisted,company_name_type_derived,'company_name_type_derived',company_name_type_derived_specificity,company_name_type_derived_specificity_profile);
  SALT311.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT311.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
  SALT311.MAC_Specificity_Values(company_phone_values_persisted,company_phone,'company_phone',company_phone_specificity,company_phone_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_name_derived_values_persisted,prim_name_derived,'prim_name_derived',prim_name_derived_specificity,prim_name_derived_specificity_profile);
  SALT311.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT311.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT311.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT311.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_range_derived_values_persisted,prim_range_derived,'prim_range_derived',prim_range_derived_specificity,prim_range_derived_specificity_profile);
EXPORT AllProfiles := active_duns_number_specificity_profile + active_enterprise_number_specificity_profile + active_domestic_corp_key_specificity_profile + hist_enterprise_number_specificity_profile + hist_duns_number_specificity_profile + hist_domestic_corp_key_specificity_profile + foreign_corp_key_specificity_profile + unk_corp_key_specificity_profile + ebr_file_number_specificity_profile + company_fein_specificity_profile + cnp_name_specificity_profile + company_name_type_derived_specificity_profile + cnp_number_specificity_profile + cnp_btype_specificity_profile + company_phone_specificity_profile + prim_name_derived_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip_specificity_profile + prim_range_derived_specificity_profile;
END;
 
