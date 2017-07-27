IMPORT ut,SALT24;
EXPORT specificities(DATASET(layout_Base) h) := MODULE
EXPORT input_layout := RECORD // project out required fields
  SALT24.UIDType Proxid := h.Proxid; // using existing id field
  h.rcid;//RIDfield 
  UNSIGNED4 data_permits := fn_sources(h.source); // Pre-compute permissions for every field
  h.dt_first_seen;
  h.dt_last_seen;
  h.source;
  typeof(h.company_name) company_name := (typeof(h.company_name))Fields.Make_company_name((SALT24.StrType)h.company_name ); // Cleans before using
  h.company_name_flag; // Flag to be filled in as part of Best processing
  h.company_fein;
  h.company_fein_flag; // Flag to be filled in as part of Best processing
  h.company_phone;
  h.company_phone_flag; // Flag to be filled in as part of Best processing
  typeof(h.company_url) company_url := (typeof(h.company_url))Fields.Make_company_url((SALT24.StrType)h.company_url ); // Cleans before using
  h.company_url_flag; // Flag to be filled in as part of Best processing
  h.company_prim_range;
  h.company_predir;
  h.company_prim_name;
  h.company_addr_suffix;
  h.company_postdir;
  h.company_unit_desig;
  h.company_sec_range;
  h.company_p_city_name;
  h.company_v_city_name;
  h.company_st;
  h.company_zip5;
  h.company_zip4;
  unsigned4 company_csz := 0; // Place holder filled in by project
  unsigned4 company_addr1 := 0; // Place holder filled in by project
  unsigned4 company_address := 0; // Place holder filled in by project
  h.company_address_flag; // Flag to be filled in as part of Best processing
END;
r := input_layout;
h01 := DISTRIBUTE(TABLE(h,r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_csz := HASH32((SALT24.StrType)le.company_v_city_name,(SALT24.StrType)le.company_st,(SALT24.StrType)le.company_zip5,(SALT24.StrType)le.company_zip4); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := HASH32((SALT24.StrType)le.company_prim_range,(SALT24.StrType)le.company_predir,(SALT24.StrType)le.company_prim_name,(SALT24.StrType)le.company_addr_suffix,(SALT24.StrType)le.company_postdir,(SALT24.StrType)le.company_unit_desig,(SALT24.StrType)le.company_sec_range); // Combine child fields into 1 for specificity counting
  SELF.company_address := HASH32((SALT24.StrType)SELF.company_addr1,(SALT24.StrType)SELF.company_csz); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED h0 := PROJECT(h01,do_computes(LEFT));
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0  : PERSIST('temp::Proxid::BIPV2_Best::Specificities_Cache');
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL)  : PERSIST('temp::Proxid::BIPV2_Best::Cluster_Sizes');
EXPORT TotalClusters := COUNT(ClusterSizes);
SHARED  company_name_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_name) : persist('temp::dedups::BIPV2_Best_Proxid_company_name'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_name_deduped,company_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT24.mac_edit_distance_pairs(specs_added,company_name,cnt,1,true,distance_computed);//Computes specificities of fuzzy matches
export company_name_values_persisted := distance_computed : persist('temp::values::BIPV2_Best_Proxid_company_name');
SALT24.MAC_Field_Nulls(company_name_values_persisted,Layout_Specificities.company_name_ChildRec,nv) // Use automated NULL spotting
export company_name_nulls := nv;
SALT24.MAC_Field_Bfoul(company_name_deduped,company_name,Proxid,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_name_switch := bf;
export company_name_max := MAX(company_name_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_name_values_persisted,company_name,company_name_nulls,ol) // Compute column level specificity
export company_name_specificity := ol;
SHARED  company_fein_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_fein) : persist('temp::dedups::BIPV2_Best_Proxid_company_fein'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
    STRING4 company_fein_Right4 := fn_Right4(counted.company_fein); // Compute fn_Right4 value for company_fein
  end;
  with_id := table(counted,r1);
  SALT24.MAC_Field_Accumulate_Counts(with_id,company_fein_Right4,Right4_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT24.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export company_fein_values_persisted := distance_computed : persist('temp::values::BIPV2_Best_Proxid_company_fein');
SALT24.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
export company_fein_nulls := nv;
SALT24.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_fein_switch := bf;
export company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
export company_fein_specificity := ol;
SHARED  company_phone_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_phone) : persist('temp::dedups::BIPV2_Best_Proxid_company_phone'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_phone_deduped,company_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT24.mac_edit_distance_pairs(specs_added,company_phone,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export company_phone_values_persisted := distance_computed : persist('temp::values::BIPV2_Best_Proxid_company_phone');
SALT24.MAC_Field_Nulls(company_phone_values_persisted,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
export company_phone_nulls := nv;
SALT24.MAC_Field_Bfoul(company_phone_deduped,company_phone,Proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_phone_switch := bf;
export company_phone_max := MAX(company_phone_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_phone_values_persisted,company_phone,company_phone_nulls,ol) // Compute column level specificity
export company_phone_specificity := ol;
SHARED  company_url_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_url) : persist('temp::dedups::BIPV2_Best_Proxid_company_url'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_url_deduped,company_url,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT24.mac_edit_distance_pairs(specs_added,company_url,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export company_url_values_persisted := distance_computed : persist('temp::values::BIPV2_Best_Proxid_company_url');
SALT24.MAC_Field_Nulls(company_url_values_persisted,Layout_Specificities.company_url_ChildRec,nv) // Use automated NULL spotting
export company_url_nulls := nv;
SALT24.MAC_Field_Bfoul(company_url_deduped,company_url,Proxid,company_url_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_url_switch := bf;
export company_url_max := MAX(company_url_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_url_values_persisted,company_url,company_url_nulls,ol) // Compute column level specificity
export company_url_specificity := ol;
SHARED  company_prim_range_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_prim_range) : persist('temp::dedups::BIPV2_Best_Proxid_company_prim_range'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_prim_range_deduped,company_prim_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_prim_range_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_prim_range');
SALT24.MAC_Field_Nulls(company_prim_range_values_persisted,Layout_Specificities.company_prim_range_ChildRec,nv) // Use automated NULL spotting
export company_prim_range_nulls := nv;
SALT24.MAC_Field_Bfoul(company_prim_range_deduped,company_prim_range,Proxid,company_prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_prim_range_switch := bf;
export company_prim_range_max := MAX(company_prim_range_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_prim_range_values_persisted,company_prim_range,company_prim_range_nulls,ol) // Compute column level specificity
export company_prim_range_specificity := ol;
SHARED  company_predir_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_predir) : persist('temp::dedups::BIPV2_Best_Proxid_company_predir'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_predir_deduped,company_predir,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_predir_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_predir');
SALT24.MAC_Field_Nulls(company_predir_values_persisted,Layout_Specificities.company_predir_ChildRec,nv) // Use automated NULL spotting
export company_predir_nulls := nv;
SALT24.MAC_Field_Bfoul(company_predir_deduped,company_predir,Proxid,company_predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_predir_switch := bf;
export company_predir_max := MAX(company_predir_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_predir_values_persisted,company_predir,company_predir_nulls,ol) // Compute column level specificity
export company_predir_specificity := ol;
SHARED  company_prim_name_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_prim_name) : persist('temp::dedups::BIPV2_Best_Proxid_company_prim_name'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_prim_name_deduped,company_prim_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_prim_name_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_prim_name');
SALT24.MAC_Field_Nulls(company_prim_name_values_persisted,Layout_Specificities.company_prim_name_ChildRec,nv) // Use automated NULL spotting
export company_prim_name_nulls := nv;
SALT24.MAC_Field_Bfoul(company_prim_name_deduped,company_prim_name,Proxid,company_prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_prim_name_switch := bf;
export company_prim_name_max := MAX(company_prim_name_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_prim_name_values_persisted,company_prim_name,company_prim_name_nulls,ol) // Compute column level specificity
export company_prim_name_specificity := ol;
SHARED  company_addr_suffix_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_addr_suffix) : persist('temp::dedups::BIPV2_Best_Proxid_company_addr_suffix'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_addr_suffix_deduped,company_addr_suffix,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_addr_suffix_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_addr_suffix');
export company_addr_suffix_nulls := dataset([{'',0,0}],Layout_Specificities.company_addr_suffix_ChildRec); // Automated null spotting not applicable
SALT24.MAC_Field_Bfoul(company_addr_suffix_deduped,company_addr_suffix,Proxid,company_addr_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_addr_suffix_switch := bf;
export company_addr_suffix_max := MAX(company_addr_suffix_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_addr_suffix_values_persisted,company_addr_suffix,company_addr_suffix_nulls,ol) // Compute column level specificity
export company_addr_suffix_specificity := ol;
SHARED  company_postdir_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_postdir) : persist('temp::dedups::BIPV2_Best_Proxid_company_postdir'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_postdir_deduped,company_postdir,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_postdir_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_postdir');
SALT24.MAC_Field_Nulls(company_postdir_values_persisted,Layout_Specificities.company_postdir_ChildRec,nv) // Use automated NULL spotting
export company_postdir_nulls := nv;
SALT24.MAC_Field_Bfoul(company_postdir_deduped,company_postdir,Proxid,company_postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_postdir_switch := bf;
export company_postdir_max := MAX(company_postdir_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_postdir_values_persisted,company_postdir,company_postdir_nulls,ol) // Compute column level specificity
export company_postdir_specificity := ol;
SHARED  company_unit_desig_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_unit_desig) : persist('temp::dedups::BIPV2_Best_Proxid_company_unit_desig'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_unit_desig_deduped,company_unit_desig,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_unit_desig_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_unit_desig');
SALT24.MAC_Field_Nulls(company_unit_desig_values_persisted,Layout_Specificities.company_unit_desig_ChildRec,nv) // Use automated NULL spotting
export company_unit_desig_nulls := nv;
SALT24.MAC_Field_Bfoul(company_unit_desig_deduped,company_unit_desig,Proxid,company_unit_desig_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_unit_desig_switch := bf;
export company_unit_desig_max := MAX(company_unit_desig_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_unit_desig_values_persisted,company_unit_desig,company_unit_desig_nulls,ol) // Compute column level specificity
export company_unit_desig_specificity := ol;
SHARED  company_sec_range_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_sec_range) : persist('temp::dedups::BIPV2_Best_Proxid_company_sec_range'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_sec_range_deduped,company_sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_sec_range_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_sec_range');
SALT24.MAC_Field_Nulls(company_sec_range_values_persisted,Layout_Specificities.company_sec_range_ChildRec,nv) // Use automated NULL spotting
export company_sec_range_nulls := nv;
SALT24.MAC_Field_Bfoul(company_sec_range_deduped,company_sec_range,Proxid,company_sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_sec_range_switch := bf;
export company_sec_range_max := MAX(company_sec_range_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_sec_range_values_persisted,company_sec_range,company_sec_range_nulls,ol) // Compute column level specificity
export company_sec_range_specificity := ol;
SHARED  company_p_city_name_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_p_city_name) : persist('temp::dedups::BIPV2_Best_Proxid_company_p_city_name'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_p_city_name_deduped,company_p_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_p_city_name_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_p_city_name');
SALT24.MAC_Field_Nulls(company_p_city_name_values_persisted,Layout_Specificities.company_p_city_name_ChildRec,nv) // Use automated NULL spotting
export company_p_city_name_nulls := nv;
SALT24.MAC_Field_Bfoul(company_p_city_name_deduped,company_p_city_name,Proxid,company_p_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_p_city_name_switch := bf;
export company_p_city_name_max := MAX(company_p_city_name_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_p_city_name_values_persisted,company_p_city_name,company_p_city_name_nulls,ol) // Compute column level specificity
export company_p_city_name_specificity := ol;
SHARED  company_v_city_name_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_v_city_name) : persist('temp::dedups::BIPV2_Best_Proxid_company_v_city_name'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_v_city_name_deduped,company_v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_v_city_name_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_v_city_name');
export company_v_city_name_nulls := dataset([{'',0,0}],Layout_Specificities.company_v_city_name_ChildRec); // Automated null spotting not applicable
SALT24.MAC_Field_Bfoul(company_v_city_name_deduped,company_v_city_name,Proxid,company_v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_v_city_name_switch := bf;
export company_v_city_name_max := MAX(company_v_city_name_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_v_city_name_values_persisted,company_v_city_name,company_v_city_name_nulls,ol) // Compute column level specificity
export company_v_city_name_specificity := ol;
SHARED  company_st_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_st) : persist('temp::dedups::BIPV2_Best_Proxid_company_st'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_st_deduped,company_st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_st_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_st');
SALT24.MAC_Field_Nulls(company_st_values_persisted,Layout_Specificities.company_st_ChildRec,nv) // Use automated NULL spotting
export company_st_nulls := nv;
SALT24.MAC_Field_Bfoul(company_st_deduped,company_st,Proxid,company_st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_st_switch := bf;
export company_st_max := MAX(company_st_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_st_values_persisted,company_st,company_st_nulls,ol) // Compute column level specificity
export company_st_specificity := ol;
SHARED  company_zip5_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_zip5) : persist('temp::dedups::BIPV2_Best_Proxid_company_zip5'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_zip5_deduped,company_zip5,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_zip5_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_zip5');
SALT24.MAC_Field_Nulls(company_zip5_values_persisted,Layout_Specificities.company_zip5_ChildRec,nv) // Use automated NULL spotting
export company_zip5_nulls := nv;
SALT24.MAC_Field_Bfoul(company_zip5_deduped,company_zip5,Proxid,company_zip5_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_zip5_switch := bf;
export company_zip5_max := MAX(company_zip5_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_zip5_values_persisted,company_zip5,company_zip5_nulls,ol) // Compute column level specificity
export company_zip5_specificity := ol;
SHARED  company_zip4_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_zip4) : persist('temp::dedups::BIPV2_Best_Proxid_company_zip4'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_zip4_deduped,company_zip4,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_zip4_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_zip4');
SALT24.MAC_Field_Nulls(company_zip4_values_persisted,Layout_Specificities.company_zip4_ChildRec,nv) // Use automated NULL spotting
export company_zip4_nulls := nv;
SALT24.MAC_Field_Bfoul(company_zip4_deduped,company_zip4,Proxid,company_zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_zip4_switch := bf;
export company_zip4_max := MAX(company_zip4_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_zip4_values_persisted,company_zip4,company_zip4_nulls,ol) // Compute column level specificity
export company_zip4_specificity := ol;
SHARED  company_csz_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_csz) : persist('temp::dedups::BIPV2_Best_Proxid_company_csz'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_csz_deduped,company_csz,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_csz_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_csz');
SALT24.MAC_Field_Nulls(company_csz_values_persisted,Layout_Specificities.company_csz_ChildRec,nv) // Use automated NULL spotting
export company_csz_nulls := nv;
SALT24.MAC_Field_Bfoul(company_csz_deduped,company_csz,Proxid,company_csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_csz_switch := bf;
export company_csz_max := MAX(company_csz_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_csz_values_persisted,company_csz,company_csz_nulls,ol) // Compute column level specificity
export company_csz_specificity := ol;
SHARED  company_addr1_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_addr1) : persist('temp::dedups::BIPV2_Best_Proxid_company_addr1'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_addr1_deduped,company_addr1,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_addr1_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_addr1');
SALT24.MAC_Field_Nulls(company_addr1_values_persisted,Layout_Specificities.company_addr1_ChildRec,nv) // Use automated NULL spotting
export company_addr1_nulls := nv;
SALT24.MAC_Field_Bfoul(company_addr1_deduped,company_addr1,Proxid,company_addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_addr1_switch := bf;
export company_addr1_max := MAX(company_addr1_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_addr1_values_persisted,company_addr1,company_addr1_nulls,ol) // Compute column level specificity
export company_addr1_specificity := ol;
SHARED  company_address_deduped := SALT24.MAC_Field_By_UID(input_file,Proxid,company_address) : persist('temp::dedups::BIPV2_Best_Proxid_company_address'); // Reduce to field values by UID
  SALT24.Mac_Field_Count_UID(company_address_deduped,company_address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT24.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_address_values_persisted := specs_added : persist('temp::values::BIPV2_Best_Proxid_company_address');
SALT24.MAC_Field_Nulls(company_address_values_persisted,Layout_Specificities.company_address_ChildRec,nv) // Use automated NULL spotting
export company_address_nulls := nv;
SALT24.MAC_Field_Bfoul(company_address_deduped,company_address,Proxid,company_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_address_switch := bf;
export company_address_max := MAX(company_address_values_persisted,field_specificity);
SALT24.MAC_Field_Specificity(company_address_values_persisted,company_address,company_address_nulls,ol) // Compute column level specificity
export company_address_specificity := ol;
iSpecificities := DATASET([{0,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,company_url_specificity,company_url_switch,company_url_max,company_url_nulls,company_prim_range_specificity,company_prim_range_switch,company_prim_range_max,company_prim_range_nulls,company_predir_specificity,company_predir_switch,company_predir_max,company_predir_nulls,company_prim_name_specificity,company_prim_name_switch,company_prim_name_max,company_prim_name_nulls,company_addr_suffix_specificity,company_addr_suffix_switch,company_addr_suffix_max,company_addr_suffix_nulls,company_postdir_specificity,company_postdir_switch,company_postdir_max,company_postdir_nulls,company_unit_desig_specificity,company_unit_desig_switch,company_unit_desig_max,company_unit_desig_nulls,company_sec_range_specificity,company_sec_range_switch,company_sec_range_max,company_sec_range_nulls,company_p_city_name_specificity,company_p_city_name_switch,company_p_city_name_max,company_p_city_name_nulls,company_v_city_name_specificity,company_v_city_name_switch,company_v_city_name_max,company_v_city_name_nulls,company_st_specificity,company_st_switch,company_st_max,company_st_nulls,company_zip5_specificity,company_zip5_switch,company_zip5_max,company_zip5_nulls,company_zip4_specificity,company_zip4_switch,company_zip4_max,company_zip4_nulls,company_csz_specificity,company_csz_switch,company_csz_max,company_csz_nulls,company_addr1_specificity,company_addr1_switch,company_addr1_max,company_addr1_nulls,company_address_specificity,company_address_switch,company_address_max,company_address_nulls}],Layout_Specificities.R) : PERSIST('BIPV2_Best::Proxid::Specificities');
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 19);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 137);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 27);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 20);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 19);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 207);
  integer1 company_url_shift0 := ROUND(Specificities[1].company_url_specificity - 27);
  integer2 company_url_switch_shift0 := ROUND(1000*Specificities[1].company_url_switch - 2);
  integer1 company_prim_range_shift0 := ROUND(Specificities[1].company_prim_range_specificity - 11);
  integer2 company_prim_range_switch_shift0 := ROUND(1000*Specificities[1].company_prim_range_switch - 13);
  integer1 company_predir_shift0 := ROUND(Specificities[1].company_predir_specificity - 4);
  integer2 company_predir_switch_shift0 := ROUND(1000*Specificities[1].company_predir_switch - 3);
  integer1 company_prim_name_shift0 := ROUND(Specificities[1].company_prim_name_specificity - 12);
  integer2 company_prim_name_switch_shift0 := ROUND(1000*Specificities[1].company_prim_name_switch - 12);
  integer1 company_addr_suffix_shift0 := ROUND(Specificities[1].company_addr_suffix_specificity - 3);
  integer2 company_addr_suffix_switch_shift0 := ROUND(1000*Specificities[1].company_addr_suffix_switch - 2);
  integer1 company_postdir_shift0 := ROUND(Specificities[1].company_postdir_specificity - 6);
  integer2 company_postdir_switch_shift0 := ROUND(1000*Specificities[1].company_postdir_switch - 4);
  integer1 company_unit_desig_shift0 := ROUND(Specificities[1].company_unit_desig_specificity - 4);
  integer2 company_unit_desig_switch_shift0 := ROUND(1000*Specificities[1].company_unit_desig_switch - 4);
  integer1 company_sec_range_shift0 := ROUND(Specificities[1].company_sec_range_specificity - 11);
  integer2 company_sec_range_switch_shift0 := ROUND(1000*Specificities[1].company_sec_range_switch - 7435);
  integer1 company_p_city_name_shift0 := ROUND(Specificities[1].company_p_city_name_specificity - 10);
  integer2 company_p_city_name_switch_shift0 := ROUND(1000*Specificities[1].company_p_city_name_switch - 411);
  integer1 company_v_city_name_shift0 := ROUND(Specificities[1].company_v_city_name_specificity - 1);
  integer2 company_v_city_name_switch_shift0 := ROUND(1000*Specificities[1].company_v_city_name_switch - 1);
  integer1 company_st_shift0 := ROUND(Specificities[1].company_st_specificity - 4);
  integer2 company_st_switch_shift0 := ROUND(1000*Specificities[1].company_st_switch - 0);
  integer1 company_zip5_shift0 := ROUND(Specificities[1].company_zip5_specificity - 5);
  integer2 company_zip5_switch_shift0 := ROUND(1000*Specificities[1].company_zip5_switch - 0);
  integer1 company_zip4_shift0 := ROUND(Specificities[1].company_zip4_specificity - 12);
  integer2 company_zip4_switch_shift0 := ROUND(1000*Specificities[1].company_zip4_switch - 15);
  integer1 company_csz_shift0 := ROUND(Specificities[1].company_csz_specificity - 18);
  integer2 company_csz_switch_shift0 := ROUND(1000*Specificities[1].company_csz_switch - 50);
  integer1 company_addr1_shift0 := ROUND(Specificities[1].company_addr1_specificity - 18);
  integer2 company_addr1_switch_shift0 := ROUND(1000*Specificities[1].company_addr1_switch - 59);
  integer1 company_address_shift0 := ROUND(Specificities[1].company_address_specificity - 18);
  integer2 company_address_switch_shift0 := ROUND(1000*Specificities[1].company_address_switch - 59);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
END;
