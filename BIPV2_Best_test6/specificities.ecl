IMPORT ut,SALT27;
EXPORT specificities(DATASET(layout_Base) h) := MODULE
EXPORT input_layout := RECORD // project out required fields
  SALT27.UIDType Proxid := h.Proxid; // using existing id field
  h.rcid;//RIDfield 
  UNSIGNED1 data_permits := fn_sources(h.source_for_votes); // Pre-compute permissions for every field
  h.dt_first_seen;
  h.dt_last_seen;
  h.source_for_votes;
  typeof(h.company_name) company_name := (typeof(h.company_name))Fields.Make_company_name((SALT27.StrType)h.company_name ); // Cleans before using
  h.company_name_flag; // Flag to be filled in as part of Best processing
  h.company_fein;
  h.company_fein_flag; // Flag to be filled in as part of Best processing
  h.company_phone;
  h.company_phone_flag; // Flag to be filled in as part of Best processing
  h.company_url;
  h.company_url_flag; // Flag to be filled in as part of Best processing
  h.prim_range;
  h.predir;
  h.prim_name;
  h.addr_suffix;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.p_city_name;
  h.v_city_name;
  h.st;
  h.zip;
  h.zip4;
  h.fips_state;
  h.fips_county;
  unsigned4 address := 0; // Place holder filled in by project
  h.address_flag; // Flag to be filled in as part of Best processing
END;
r := input_layout;
h01 := DISTRIBUTE(TABLE(h,r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.address := IF (Fields.InValid_address((SALT27.StrType)le.prim_range,(SALT27.StrType)le.predir,(SALT27.StrType)le.prim_name,(SALT27.StrType)le.addr_suffix,(SALT27.StrType)le.postdir,(SALT27.StrType)le.unit_desig,(SALT27.StrType)le.sec_range,(SALT27.StrType)le.st,(SALT27.StrType)le.zip),0,HASH32((SALT27.StrType)le.prim_range,(SALT27.StrType)le.predir,(SALT27.StrType)le.prim_name,(SALT27.StrType)le.addr_suffix,(SALT27.StrType)le.postdir,(SALT27.StrType)le.unit_desig,(SALT27.StrType)le.sec_range,(SALT27.StrType)le.st,(SALT27.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0  : PERSIST('~temp::Proxid::BIPV2_Best_test6::Specificities_Cache');
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL)  : PERSIST('~temp::Proxid::BIPV2_Best_test6::Cluster_Sizes');
EXPORT TotalClusters := COUNT(ClusterSizes);
SHARED  company_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_name) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_company_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_name_deduped,company_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT27.mac_edit_distance_pairs(specs_added,company_name,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_name_values_persisted := distance_computed : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_company_name');
SALT27.MAC_Field_Nulls(company_name_values_persisted,Layout_Specificities.company_name_ChildRec,nv) // Use automated NULL spotting
EXPORT company_name_nulls := nv;
SALT27.MAC_Field_Bfoul(company_name_deduped,company_name,Proxid,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_switch := bf;
EXPORT company_name_max := MAX(company_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_name_values_persisted,company_name,company_name_nulls,ol) // Compute column level specificity
EXPORT company_name_specificity := ol;
SHARED  company_fein_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_fein) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_company_fein'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING4 company_fein_Right4 := fn_Right4(counted.company_fein); // Compute fn_Right4 value for company_fein
  end;
  with_id := table(counted,r1);
  SALT27.MAC_Field_Accumulate_Counts(with_id,company_fein_Right4,Right4_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT27.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_fein_values_persisted := distance_computed : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_company_fein');
SALT27.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT27.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
SHARED  company_phone_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_phone) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_company_phone'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_phone_deduped,company_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT27.mac_edit_distance_pairs(specs_added,company_phone,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_phone_values_persisted := distance_computed : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_company_phone');
SALT27.MAC_Field_Nulls(company_phone_values_persisted,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_nulls := nv;
SALT27.MAC_Field_Bfoul(company_phone_deduped,company_phone,Proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_switch := bf;
EXPORT company_phone_max := MAX(company_phone_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_phone_values_persisted,company_phone,company_phone_nulls,ol) // Compute column level specificity
EXPORT company_phone_specificity := ol;
SHARED  company_url_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,company_url) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_company_url'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(company_url_deduped,company_url,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT27.mac_edit_distance_pairs(specs_added,company_url,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_url_values_persisted := distance_computed : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_company_url');
SALT27.MAC_Field_Nulls(company_url_values_persisted,Layout_Specificities.company_url_ChildRec,nv) // Use automated NULL spotting
EXPORT company_url_nulls := nv;
SALT27.MAC_Field_Bfoul(company_url_deduped,company_url,Proxid,company_url_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_url_switch := bf;
EXPORT company_url_max := MAX(company_url_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(company_url_values_persisted,company_url,company_url_nulls,ol) // Compute column level specificity
EXPORT company_url_specificity := ol;
SHARED  prim_range_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,prim_range) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_prim_range'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(prim_range_deduped,prim_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_prim_range');
SALT27.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT27.MAC_Field_Bfoul(prim_range_deduped,prim_range,Proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
SHARED  predir_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,predir) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_predir'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(predir_deduped,predir,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT predir_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_predir');
SALT27.MAC_Field_Nulls(predir_values_persisted,Layout_Specificities.predir_ChildRec,nv) // Use automated NULL spotting
EXPORT predir_nulls := nv;
SALT27.MAC_Field_Bfoul(predir_deduped,predir,Proxid,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT predir_switch := bf;
EXPORT predir_max := MAX(predir_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
EXPORT predir_specificity := ol;
SHARED  prim_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,prim_name) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_prim_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(prim_name_deduped,prim_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_prim_name');
SALT27.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT27.MAC_Field_Bfoul(prim_name_deduped,prim_name,Proxid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
SHARED  addr_suffix_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,addr_suffix) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_addr_suffix'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(addr_suffix_deduped,addr_suffix,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT addr_suffix_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_addr_suffix');
SALT27.MAC_Field_Nulls(addr_suffix_values_persisted,Layout_Specificities.addr_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT addr_suffix_nulls := nv;
SALT27.MAC_Field_Bfoul(addr_suffix_deduped,addr_suffix,Proxid,addr_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT addr_suffix_switch := bf;
EXPORT addr_suffix_max := MAX(addr_suffix_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(addr_suffix_values_persisted,addr_suffix,addr_suffix_nulls,ol) // Compute column level specificity
EXPORT addr_suffix_specificity := ol;
SHARED  postdir_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,postdir) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_postdir'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(postdir_deduped,postdir,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT postdir_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_postdir');
SALT27.MAC_Field_Nulls(postdir_values_persisted,Layout_Specificities.postdir_ChildRec,nv) // Use automated NULL spotting
EXPORT postdir_nulls := nv;
SALT27.MAC_Field_Bfoul(postdir_deduped,postdir,Proxid,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT postdir_switch := bf;
EXPORT postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
EXPORT postdir_specificity := ol;
SHARED  unit_desig_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,unit_desig) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_unit_desig'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(unit_desig_deduped,unit_desig,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT unit_desig_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_unit_desig');
SALT27.MAC_Field_Nulls(unit_desig_values_persisted,Layout_Specificities.unit_desig_ChildRec,nv) // Use automated NULL spotting
EXPORT unit_desig_nulls := nv;
SALT27.MAC_Field_Bfoul(unit_desig_deduped,unit_desig,Proxid,unit_desig_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT unit_desig_switch := bf;
EXPORT unit_desig_max := MAX(unit_desig_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(unit_desig_values_persisted,unit_desig,unit_desig_nulls,ol) // Compute column level specificity
EXPORT unit_desig_specificity := ol;
SHARED  sec_range_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,sec_range) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_sec_range'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(sec_range_deduped,sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_sec_range');
SALT27.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT27.MAC_Field_Bfoul(sec_range_deduped,sec_range,Proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
SHARED  p_city_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,p_city_name) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_p_city_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(p_city_name_deduped,p_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT p_city_name_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_p_city_name');
SALT27.MAC_Field_Nulls(p_city_name_values_persisted,Layout_Specificities.p_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT p_city_name_nulls := nv;
SALT27.MAC_Field_Bfoul(p_city_name_deduped,p_city_name,Proxid,p_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT p_city_name_switch := bf;
EXPORT p_city_name_max := MAX(p_city_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(p_city_name_values_persisted,p_city_name,p_city_name_nulls,ol) // Compute column level specificity
EXPORT p_city_name_specificity := ol;
SHARED  v_city_name_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,v_city_name) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_v_city_name'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_v_city_name');
SALT27.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT27.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Proxid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
SHARED  st_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,st) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_st'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(st_deduped,st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_st');
SALT27.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT27.MAC_Field_Bfoul(st_deduped,st,Proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
SHARED  zip_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,zip) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_zip'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(zip_deduped,zip,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_zip');
SALT27.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT27.MAC_Field_Bfoul(zip_deduped,zip,Proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
SHARED  zip4_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,zip4) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_zip4'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(zip4_deduped,zip4,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip4_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_zip4');
SALT27.MAC_Field_Nulls(zip4_values_persisted,Layout_Specificities.zip4_ChildRec,nv) // Use automated NULL spotting
EXPORT zip4_nulls := nv;
SALT27.MAC_Field_Bfoul(zip4_deduped,zip4,Proxid,zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip4_switch := bf;
EXPORT zip4_max := MAX(zip4_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(zip4_values_persisted,zip4,zip4_nulls,ol) // Compute column level specificity
EXPORT zip4_specificity := ol;
SHARED  fips_state_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,fips_state) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_fips_state'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(fips_state_deduped,fips_state,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fips_state_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_fips_state');
SALT27.MAC_Field_Nulls(fips_state_values_persisted,Layout_Specificities.fips_state_ChildRec,nv) // Use automated NULL spotting
EXPORT fips_state_nulls := nv;
SALT27.MAC_Field_Bfoul(fips_state_deduped,fips_state,Proxid,fips_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fips_state_switch := bf;
EXPORT fips_state_max := MAX(fips_state_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(fips_state_values_persisted,fips_state,fips_state_nulls,ol) // Compute column level specificity
EXPORT fips_state_specificity := ol;
SHARED  fips_county_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,fips_county) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_fips_county'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(fips_county_deduped,fips_county,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fips_county_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_fips_county');
SALT27.MAC_Field_Nulls(fips_county_values_persisted,Layout_Specificities.fips_county_ChildRec,nv) // Use automated NULL spotting
EXPORT fips_county_nulls := nv;
SALT27.MAC_Field_Bfoul(fips_county_deduped,fips_county,Proxid,fips_county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fips_county_switch := bf;
EXPORT fips_county_max := MAX(fips_county_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(fips_county_values_persisted,fips_county,fips_county_nulls,ol) // Compute column level specificity
EXPORT fips_county_specificity := ol;
SHARED  address_deduped := SALT27.MAC_Field_By_UID(input_file,Proxid,address) : PERSIST('~temp::dedups::BIPV2_Best_test6_Proxid_address'); // Reduce to field values by UID
  SALT27.Mac_Field_Count_UID(address_deduped,address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT address_values_persisted := specs_added : PERSIST('~temp::values::BIPV2_Best_test6_Proxid_address');
SALT27.MAC_Field_Nulls(address_values_persisted,Layout_Specificities.address_ChildRec,nv) // Use automated NULL spotting
EXPORT address_nulls := nv;
SALT27.MAC_Field_Bfoul(address_deduped,address,Proxid,address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT address_switch := bf;
EXPORT address_max := MAX(address_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(address_values_persisted,address,address_nulls,ol) // Compute column level specificity
EXPORT address_specificity := ol;
iSpecificities := DATASET([{0,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,company_url_specificity,company_url_switch,company_url_max,company_url_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,addr_suffix_specificity,addr_suffix_switch,addr_suffix_max,addr_suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,unit_desig_specificity,unit_desig_switch,unit_desig_max,unit_desig_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,p_city_name_specificity,p_city_name_switch,p_city_name_max,p_city_name_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,zip4_specificity,zip4_switch,zip4_max,zip4_nulls,fips_state_specificity,fips_state_switch,fips_state_max,fips_state_nulls,fips_county_specificity,fips_county_switch,fips_county_max,fips_county_nulls,address_specificity,address_switch,address_max,address_nulls}],Layout_Specificities.R) : PERSIST('~BIPV2_Best_test6::Proxid::Specificities');
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 26);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 341);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 26);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 64);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 26);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 237);
  integer1 company_url_shift0 := ROUND(Specificities[1].company_url_specificity - 27);
  integer2 company_url_switch_shift0 := ROUND(1000*Specificities[1].company_url_switch - 10);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 5);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 8);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 addr_suffix_shift0 := ROUND(Specificities[1].addr_suffix_specificity - 4);
  integer2 addr_suffix_switch_shift0 := ROUND(1000*Specificities[1].addr_suffix_switch - 2);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 7);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 11);
  integer1 unit_desig_shift0 := ROUND(Specificities[1].unit_desig_specificity - 5);
  integer2 unit_desig_switch_shift0 := ROUND(1000*Specificities[1].unit_desig_switch - 36);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 111);
  integer1 p_city_name_shift0 := ROUND(Specificities[1].p_city_name_specificity - 12);
  integer2 p_city_name_switch_shift0 := ROUND(1000*Specificities[1].p_city_name_switch - 30);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 6);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 7);
  integer1 zip4_shift0 := ROUND(Specificities[1].zip4_specificity - 13);
  integer2 zip4_switch_shift0 := ROUND(1000*Specificities[1].zip4_switch - 66);
  integer1 fips_state_shift0 := ROUND(Specificities[1].fips_state_specificity - 5);
  integer2 fips_state_switch_shift0 := ROUND(1000*Specificities[1].fips_state_switch - 0);
  integer1 fips_county_shift0 := ROUND(Specificities[1].fips_county_specificity - 7);
  integer2 fips_county_switch_shift0 := ROUND(1000*Specificities[1].fips_county_switch - 3);
  integer1 address_shift0 := ROUND(Specificities[1].address_specificity - 25);
  integer2 address_switch_shift0 := ROUND(1000*Specificities[1].address_switch - 313);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT27.MAC_Specificity_Values(company_name_values_persisted,company_name,'company_name',company_name_specificity,company_name_specificity_profile);
  SALT27.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT27.MAC_Specificity_Values(company_phone_values_persisted,company_phone,'company_phone',company_phone_specificity,company_phone_specificity_profile);
  SALT27.MAC_Specificity_Values(company_url_values_persisted,company_url,'company_url',company_url_specificity,company_url_specificity_profile);
  SALT27.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT27.MAC_Specificity_Values(predir_values_persisted,predir,'predir',predir_specificity,predir_specificity_profile);
  SALT27.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT27.MAC_Specificity_Values(addr_suffix_values_persisted,addr_suffix,'addr_suffix',addr_suffix_specificity,addr_suffix_specificity_profile);
  SALT27.MAC_Specificity_Values(postdir_values_persisted,postdir,'postdir',postdir_specificity,postdir_specificity_profile);
  SALT27.MAC_Specificity_Values(unit_desig_values_persisted,unit_desig,'unit_desig',unit_desig_specificity,unit_desig_specificity_profile);
  SALT27.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT27.MAC_Specificity_Values(p_city_name_values_persisted,p_city_name,'p_city_name',p_city_name_specificity,p_city_name_specificity_profile);
  SALT27.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT27.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT27.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT27.MAC_Specificity_Values(zip4_values_persisted,zip4,'zip4',zip4_specificity,zip4_specificity_profile);
  SALT27.MAC_Specificity_Values(fips_state_values_persisted,fips_state,'fips_state',fips_state_specificity,fips_state_specificity_profile);
  SALT27.MAC_Specificity_Values(fips_county_values_persisted,fips_county,'fips_county',fips_county_specificity,fips_county_specificity_profile);
EXPORT AllProfiles := company_name_specificity_profile + company_fein_specificity_profile + company_phone_specificity_profile + company_url_specificity_profile + prim_range_specificity_profile + predir_specificity_profile + prim_name_specificity_profile + addr_suffix_specificity_profile + postdir_specificity_profile + unit_desig_specificity_profile + sec_range_specificity_profile + p_city_name_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip_specificity_profile + zip4_specificity_profile + fips_state_specificity_profile + fips_county_specificity_profile;
END;
