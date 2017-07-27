IMPORT ut,SALT25;
EXPORT specificities(DATASET(layout_DOT_Base) h) := MODULE
EXPORT input_layout := RECORD // project out required fields
  SALT25.UIDType Proxid := h.Proxid; // using existing id field
  h.rcid;//RIDfield 
  h.company_name;
  typeof(h.cnp_name) cnp_name := (typeof(h.cnp_name))Fields.Make_cnp_name((SALT25.StrType)h.cnp_name ); // Cleans before using
  typeof(h.corp_legal_name) corp_legal_name := (typeof(h.corp_legal_name))Fields.Make_corp_legal_name((SALT25.StrType)h.corp_legal_name ); // Cleans before using
  h.cnp_hasnumber;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.cnp_translated;
  h.cnp_classid;
  h.company_fein;
  h.company_inc_state;
  h.company_charter_number;
  h.company_bdid;
  h.company_phone;
  h.iscorp;
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
  h.Company_RAWAID;
  unsigned4 company_csz := 0; // Place holder filled in by project
  unsigned4 company_addr1 := 0; // Place holder filled in by project
  unsigned4 company_address := 0; // Place holder filled in by project
  h.active_duns_number;
  h.active_enterprise_number;
  h.active_domestic_corp_key;
  h.source;
  h.source_record_id;
  h.isContact;
  h.title;
  h.fname;
  h.mname;
  h.lname;
  h.name_suffix;
  h.contact_ssn;
  h.contact_phone;
  typeof(h.contact_email) contact_email := (typeof(h.contact_email))Fields.Make_contact_email((SALT25.StrType)h.contact_email ); // Cleans before using
  h.contact_job_title_raw;
  h.company_department;
  h.contact_email_username;
  h.dt_first_seen;
  h.dt_last_seen;
END;
r := input_layout;
h01 := DISTRIBUTE(TABLE(h,r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_csz := HASH32((SALT25.StrType)le.v_city_name,(SALT25.StrType)le.st,(SALT25.StrType)le.zip); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := HASH32((SALT25.StrType)le.prim_range,(SALT25.StrType)le.prim_name,(SALT25.StrType)le.sec_range); // Combine child fields into 1 for specificity counting
  SELF.company_address := HASH32((SALT25.StrType)SELF.company_addr1,(SALT25.StrType)SELF.company_csz); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED h0 := PROJECT(h01,do_computes(LEFT));
SHARED reject := Fields.Invalid_company_name((SALT25.StrType)h0.company_name)>0;
EXPORT rejected_file := h0(reject);
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0(~Reject)  : PERSIST('temp::Proxid::BIPV2_Relative::Specificities_Cache');
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL)  : PERSIST('temp::Proxid::BIPV2_Relative::Cluster_Sizes');
EXPORT TotalClusters := COUNT(ClusterSizes);
SHARED  cnp_name_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,cnp_name) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_cnp_name'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT25.mac_edit_distance_pairs(specs_added,cnp_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export cnp_name_values_persisted := distance_computed : persist('temp::values::BIPV2_Relative_Proxid_cnp_name');
SALT25.MAC_Field_Nulls(cnp_name_values_persisted,Layout_Specificities.cnp_name_ChildRec,nv) // Use automated NULL spotting
export cnp_name_nulls := nv;
SALT25.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,Proxid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export cnp_name_switch := bf;
export cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
export cnp_name_specificity := ol;
SHARED  corp_legal_name_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,corp_legal_name) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_corp_legal_name'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(corp_legal_name_deduped,corp_legal_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT25.mac_edit_distance_pairs(specs_added,corp_legal_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export corp_legal_name_values_persisted := distance_computed : persist('temp::values::BIPV2_Relative_Proxid_corp_legal_name');
SALT25.MAC_Field_Nulls(corp_legal_name_values_persisted,Layout_Specificities.corp_legal_name_ChildRec,nv) // Use automated NULL spotting
export corp_legal_name_nulls := nv;
SALT25.MAC_Field_Bfoul(corp_legal_name_deduped,corp_legal_name,Proxid,corp_legal_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export corp_legal_name_switch := bf;
export corp_legal_name_max := MAX(corp_legal_name_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(corp_legal_name_values_persisted,corp_legal_name,corp_legal_name_nulls,ol) // Compute column level specificity
export corp_legal_name_specificity := ol;
SHARED  cnp_hasnumber_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,cnp_hasnumber) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_cnp_hasnumber'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(cnp_hasnumber_deduped,cnp_hasnumber,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export cnp_hasnumber_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_cnp_hasnumber');
SALT25.MAC_Field_Nulls(cnp_hasnumber_values_persisted,Layout_Specificities.cnp_hasnumber_ChildRec,nv) // Use automated NULL spotting
export cnp_hasnumber_nulls := nv;
SALT25.MAC_Field_Bfoul(cnp_hasnumber_deduped,cnp_hasnumber,Proxid,cnp_hasnumber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export cnp_hasnumber_switch := bf;
export cnp_hasnumber_max := MAX(cnp_hasnumber_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(cnp_hasnumber_values_persisted,cnp_hasnumber,cnp_hasnumber_nulls,ol) // Compute column level specificity
export cnp_hasnumber_specificity := ol;
SHARED  cnp_number_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,cnp_number) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_cnp_number'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export cnp_number_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_cnp_number');
SALT25.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
export cnp_number_nulls := nv;
SALT25.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,Proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export cnp_number_switch := bf;
export cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
export cnp_number_specificity := ol;
SHARED  cnp_btype_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,cnp_btype) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_cnp_btype'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export cnp_btype_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_cnp_btype');
export cnp_btype_nulls := dataset([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT25.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,Proxid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export cnp_btype_switch := bf;
export cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
export cnp_btype_specificity := ol;
SHARED  company_fein_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,company_fein) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_company_fein'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_fein_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_company_fein');
SALT25.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
export company_fein_nulls := nv;
SALT25.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_fein_switch := bf;
export company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
export company_fein_specificity := ol;
SHARED  company_inc_state_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,company_inc_state) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_company_inc_state'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(company_inc_state_deduped,company_inc_state,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_inc_state_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_company_inc_state');
SALT25.MAC_Field_Nulls(company_inc_state_values_persisted,Layout_Specificities.company_inc_state_ChildRec,nv) // Use automated NULL spotting
export company_inc_state_nulls := nv;
SALT25.MAC_Field_Bfoul(company_inc_state_deduped,company_inc_state,Proxid,company_inc_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_inc_state_switch := bf;
export company_inc_state_max := MAX(company_inc_state_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(company_inc_state_values_persisted,company_inc_state,company_inc_state_nulls,ol) // Compute column level specificity
export company_inc_state_specificity := ol;
SHARED  company_charter_number_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,company_charter_number) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_company_charter_number'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(company_charter_number_deduped,company_charter_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT25.mac_edit_distance_pairs(specs_added,company_charter_number,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export company_charter_number_values_persisted := distance_computed : persist('temp::values::BIPV2_Relative_Proxid_company_charter_number');
SALT25.MAC_Field_Nulls(company_charter_number_values_persisted,Layout_Specificities.company_charter_number_ChildRec,nv) // Use automated NULL spotting
export company_charter_number_nulls := nv;
SALT25.MAC_Field_Bfoul(company_charter_number_deduped,company_charter_number,Proxid,company_charter_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_charter_number_switch := bf;
export company_charter_number_max := MAX(company_charter_number_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(company_charter_number_values_persisted,company_charter_number,company_charter_number_nulls,ol) // Compute column level specificity
export company_charter_number_specificity := ol;
SHARED  iscorp_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,iscorp) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_iscorp'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(iscorp_deduped,iscorp,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export iscorp_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_iscorp');
export iscorp_nulls := dataset([{'',0,0}],Layout_Specificities.iscorp_ChildRec); // Automated null spotting not applicable
SALT25.MAC_Field_Bfoul(iscorp_deduped,iscorp,Proxid,iscorp_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export iscorp_switch := bf;
export iscorp_max := MAX(iscorp_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(iscorp_values_persisted,iscorp,iscorp_nulls,ol) // Compute column level specificity
export iscorp_specificity := ol;
SHARED  prim_range_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,prim_range) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_prim_range'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(prim_range_deduped,prim_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export prim_range_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_prim_range');
SALT25.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
export prim_range_nulls := nv;
SALT25.MAC_Field_Bfoul(prim_range_deduped,prim_range,Proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export prim_range_switch := bf;
export prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
export prim_range_specificity := ol;
SHARED  predir_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,predir) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_predir'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(predir_deduped,predir,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export predir_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_predir');
SALT25.MAC_Field_Nulls(predir_values_persisted,Layout_Specificities.predir_ChildRec,nv) // Use automated NULL spotting
export predir_nulls := nv;
SALT25.MAC_Field_Bfoul(predir_deduped,predir,Proxid,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export predir_switch := bf;
export predir_max := MAX(predir_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
export predir_specificity := ol;
SHARED  prim_name_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,prim_name) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_prim_name'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(prim_name_deduped,prim_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export prim_name_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_prim_name');
SALT25.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
export prim_name_nulls := nv;
SALT25.MAC_Field_Bfoul(prim_name_deduped,prim_name,Proxid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export prim_name_switch := bf;
export prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
export prim_name_specificity := ol;
SHARED  addr_suffix_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,addr_suffix) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_addr_suffix'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(addr_suffix_deduped,addr_suffix,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export addr_suffix_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_addr_suffix');
SALT25.MAC_Field_Nulls(addr_suffix_values_persisted,Layout_Specificities.addr_suffix_ChildRec,nv) // Use automated NULL spotting
export addr_suffix_nulls := nv;
SALT25.MAC_Field_Bfoul(addr_suffix_deduped,addr_suffix,Proxid,addr_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export addr_suffix_switch := bf;
export addr_suffix_max := MAX(addr_suffix_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(addr_suffix_values_persisted,addr_suffix,addr_suffix_nulls,ol) // Compute column level specificity
export addr_suffix_specificity := ol;
SHARED  postdir_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,postdir) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_postdir'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(postdir_deduped,postdir,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export postdir_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_postdir');
SALT25.MAC_Field_Nulls(postdir_values_persisted,Layout_Specificities.postdir_ChildRec,nv) // Use automated NULL spotting
export postdir_nulls := nv;
SALT25.MAC_Field_Bfoul(postdir_deduped,postdir,Proxid,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export postdir_switch := bf;
export postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
export postdir_specificity := ol;
SHARED  sec_range_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,sec_range) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_sec_range'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(sec_range_deduped,sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export sec_range_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_sec_range');
SALT25.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
export sec_range_nulls := nv;
SALT25.MAC_Field_Bfoul(sec_range_deduped,sec_range,Proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export sec_range_switch := bf;
export sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
export sec_range_specificity := ol;
SHARED  p_city_name_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,p_city_name) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_p_city_name'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(p_city_name_deduped,p_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export p_city_name_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_p_city_name');
SALT25.MAC_Field_Nulls(p_city_name_values_persisted,Layout_Specificities.p_city_name_ChildRec,nv) // Use automated NULL spotting
export p_city_name_nulls := nv;
SALT25.MAC_Field_Bfoul(p_city_name_deduped,p_city_name,Proxid,p_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export p_city_name_switch := bf;
export p_city_name_max := MAX(p_city_name_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(p_city_name_values_persisted,p_city_name,p_city_name_nulls,ol) // Compute column level specificity
export p_city_name_specificity := ol;
SHARED  v_city_name_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,v_city_name) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_v_city_name'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export v_city_name_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_v_city_name');
SALT25.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
export v_city_name_nulls := nv;
SALT25.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Proxid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export v_city_name_switch := bf;
export v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
export v_city_name_specificity := ol;
SHARED  st_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,st) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_st'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(st_deduped,st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export st_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_st');
SALT25.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
export st_nulls := nv;
SALT25.MAC_Field_Bfoul(st_deduped,st,Proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export st_switch := bf;
export st_max := MAX(st_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
export st_specificity := ol;
SHARED  zip_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,zip) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_zip'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(zip_deduped,zip,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_zip');
SALT25.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
export zip_nulls := nv;
SALT25.MAC_Field_Bfoul(zip_deduped,zip,Proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip_switch := bf;
export zip_max := MAX(zip_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
export zip_specificity := ol;
SHARED  zip4_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,zip4) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_zip4'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(zip4_deduped,zip4,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip4_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_zip4');
SALT25.MAC_Field_Nulls(zip4_values_persisted,Layout_Specificities.zip4_ChildRec,nv) // Use automated NULL spotting
export zip4_nulls := nv;
SALT25.MAC_Field_Bfoul(zip4_deduped,zip4,Proxid,zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip4_switch := bf;
export zip4_max := MAX(zip4_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(zip4_values_persisted,zip4,zip4_nulls,ol) // Compute column level specificity
export zip4_specificity := ol;
SHARED  company_csz_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,company_csz) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_company_csz'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(company_csz_deduped,company_csz,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_csz_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_company_csz');
SALT25.MAC_Field_Nulls(company_csz_values_persisted,Layout_Specificities.company_csz_ChildRec,nv) // Use automated NULL spotting
export company_csz_nulls := nv;
SALT25.MAC_Field_Bfoul(company_csz_deduped,company_csz,Proxid,company_csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_csz_switch := bf;
export company_csz_max := MAX(company_csz_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(company_csz_values_persisted,company_csz,company_csz_nulls,ol) // Compute column level specificity
export company_csz_specificity := ol;
SHARED  company_addr1_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,company_addr1) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_company_addr1'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(company_addr1_deduped,company_addr1,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_addr1_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_company_addr1');
SALT25.MAC_Field_Nulls(company_addr1_values_persisted,Layout_Specificities.company_addr1_ChildRec,nv) // Use automated NULL spotting
export company_addr1_nulls := nv;
SALT25.MAC_Field_Bfoul(company_addr1_deduped,company_addr1,Proxid,company_addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_addr1_switch := bf;
export company_addr1_max := MAX(company_addr1_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(company_addr1_values_persisted,company_addr1,company_addr1_nulls,ol) // Compute column level specificity
export company_addr1_specificity := ol;
SHARED  company_address_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,company_address) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_company_address'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(company_address_deduped,company_address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_address_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_company_address');
SALT25.MAC_Field_Nulls(company_address_values_persisted,Layout_Specificities.company_address_ChildRec,nv) // Use automated NULL spotting
export company_address_nulls := nv;
SALT25.MAC_Field_Bfoul(company_address_deduped,company_address,Proxid,company_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_address_switch := bf;
export company_address_max := MAX(company_address_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(company_address_values_persisted,company_address,company_address_nulls,ol) // Compute column level specificity
export company_address_specificity := ol;
SHARED  active_duns_number_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,active_duns_number) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_active_duns_number'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export active_duns_number_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_active_duns_number');
SALT25.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
export active_duns_number_nulls := nv;
SALT25.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,Proxid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export active_duns_number_switch := bf;
export active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
export active_duns_number_specificity := ol;
SHARED  active_enterprise_number_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,active_enterprise_number) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_active_enterprise_number'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export active_enterprise_number_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_active_enterprise_number');
SALT25.MAC_Field_Nulls(active_enterprise_number_values_persisted,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
export active_enterprise_number_nulls := nv;
SALT25.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,Proxid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export active_enterprise_number_switch := bf;
export active_enterprise_number_max := MAX(active_enterprise_number_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
export active_enterprise_number_specificity := ol;
SHARED  active_domestic_corp_key_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,active_domestic_corp_key) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_active_domestic_corp_key'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT25.mac_edit_distance_pairs(specs_added,active_domestic_corp_key,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export active_domestic_corp_key_values_persisted := distance_computed : persist('temp::values::BIPV2_Relative_Proxid_active_domestic_corp_key');
SALT25.MAC_Field_Nulls(active_domestic_corp_key_values_persisted,Layout_Specificities.active_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
export active_domestic_corp_key_nulls := nv;
SALT25.MAC_Field_Bfoul(active_domestic_corp_key_deduped,active_domestic_corp_key,Proxid,active_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export active_domestic_corp_key_switch := bf;
export active_domestic_corp_key_max := MAX(active_domestic_corp_key_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_nulls,ol) // Compute column level specificity
export active_domestic_corp_key_specificity := ol;
SHARED  source_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,source) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_source'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(source_deduped,source,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export source_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_source');
export source_nulls := dataset([{'',0,0}],Layout_Specificities.source_ChildRec); // Automated null spotting not applicable
SALT25.MAC_Field_Bfoul(source_deduped,source,Proxid,source_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export source_switch := bf;
export source_max := MAX(source_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(source_values_persisted,source,source_nulls,ol) // Compute column level specificity
export source_specificity := ol;
SHARED  source_record_id_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,source_record_id) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_source_record_id'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(source_record_id_deduped,source_record_id,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export source_record_id_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_source_record_id');
SALT25.MAC_Field_Nulls(source_record_id_values_persisted,Layout_Specificities.source_record_id_ChildRec,nv) // Use automated NULL spotting
export source_record_id_nulls := nv;
SALT25.MAC_Field_Bfoul(source_record_id_deduped,source_record_id,Proxid,source_record_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export source_record_id_switch := bf;
export source_record_id_max := MAX(source_record_id_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(source_record_id_values_persisted,source_record_id,source_record_id_nulls,ol) // Compute column level specificity
export source_record_id_specificity := ol;
SHARED  fname_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,fname) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_fname'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(fname_deduped,fname,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export fname_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_fname');
SALT25.MAC_Field_Nulls(fname_values_persisted,Layout_Specificities.fname_ChildRec,nv) // Use automated NULL spotting
export fname_nulls := nv;
SALT25.MAC_Field_Bfoul(fname_deduped,fname,Proxid,fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export fname_switch := bf;
export fname_max := MAX(fname_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
export fname_specificity := ol;
SHARED  mname_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,mname) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_mname'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(mname_deduped,mname,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export mname_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_mname');
SALT25.MAC_Field_Nulls(mname_values_persisted,Layout_Specificities.mname_ChildRec,nv) // Use automated NULL spotting
export mname_nulls := nv;
SALT25.MAC_Field_Bfoul(mname_deduped,mname,Proxid,mname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export mname_switch := bf;
export mname_max := MAX(mname_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
export mname_specificity := ol;
SHARED  lname_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,lname) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_lname'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(lname_deduped,lname,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export lname_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_lname');
SALT25.MAC_Field_Nulls(lname_values_persisted,Layout_Specificities.lname_ChildRec,nv) // Use automated NULL spotting
export lname_nulls := nv;
SALT25.MAC_Field_Bfoul(lname_deduped,lname,Proxid,lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export lname_switch := bf;
export lname_max := MAX(lname_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
export lname_specificity := ol;
SHARED  contact_ssn_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,contact_ssn) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_contact_ssn'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(contact_ssn_deduped,contact_ssn,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export contact_ssn_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_contact_ssn');
SALT25.MAC_Field_Nulls(contact_ssn_values_persisted,Layout_Specificities.contact_ssn_ChildRec,nv) // Use automated NULL spotting
export contact_ssn_nulls := nv;
SALT25.MAC_Field_Bfoul(contact_ssn_deduped,contact_ssn,Proxid,contact_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export contact_ssn_switch := bf;
export contact_ssn_max := MAX(contact_ssn_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(contact_ssn_values_persisted,contact_ssn,contact_ssn_nulls,ol) // Compute column level specificity
export contact_ssn_specificity := ol;
SHARED  contact_phone_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,contact_phone) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_contact_phone'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(contact_phone_deduped,contact_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export contact_phone_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_contact_phone');
SALT25.MAC_Field_Nulls(contact_phone_values_persisted,Layout_Specificities.contact_phone_ChildRec,nv) // Use automated NULL spotting
export contact_phone_nulls := nv;
SALT25.MAC_Field_Bfoul(contact_phone_deduped,contact_phone,Proxid,contact_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export contact_phone_switch := bf;
export contact_phone_max := MAX(contact_phone_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(contact_phone_values_persisted,contact_phone,contact_phone_nulls,ol) // Compute column level specificity
export contact_phone_specificity := ol;
SHARED  contact_email_username_deduped := SALT25.MAC_Field_By_UID(input_file,Proxid,contact_email_username) : PERSIST('temp::dedups::BIPV2_Relative_Proxid_contact_email_username'); // Reduce to field values by UID
  SALT25.Mac_Field_Count_UID(contact_email_username_deduped,contact_email_username,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT25.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export contact_email_username_values_persisted := specs_added : persist('temp::values::BIPV2_Relative_Proxid_contact_email_username');
SALT25.MAC_Field_Nulls(contact_email_username_values_persisted,Layout_Specificities.contact_email_username_ChildRec,nv) // Use automated NULL spotting
export contact_email_username_nulls := nv;
SALT25.MAC_Field_Bfoul(contact_email_username_deduped,contact_email_username,Proxid,contact_email_username_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export contact_email_username_switch := bf;
export contact_email_username_max := MAX(contact_email_username_values_persisted,field_specificity);
SALT25.MAC_Field_Specificity(contact_email_username_values_persisted,contact_email_username,contact_email_username_nulls,ol) // Compute column level specificity
export contact_email_username_specificity := ol;
iSpecificities := DATASET([{0,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,corp_legal_name_specificity,corp_legal_name_switch,corp_legal_name_max,corp_legal_name_nulls,cnp_hasnumber_specificity,cnp_hasnumber_switch,cnp_hasnumber_max,cnp_hasnumber_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_inc_state_specificity,company_inc_state_switch,company_inc_state_max,company_inc_state_nulls,company_charter_number_specificity,company_charter_number_switch,company_charter_number_max,company_charter_number_nulls,iscorp_specificity,iscorp_switch,iscorp_max,iscorp_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,addr_suffix_specificity,addr_suffix_switch,addr_suffix_max,addr_suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,p_city_name_specificity,p_city_name_switch,p_city_name_max,p_city_name_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,zip4_specificity,zip4_switch,zip4_max,zip4_nulls,company_csz_specificity,company_csz_switch,company_csz_max,company_csz_nulls,company_addr1_specificity,company_addr1_switch,company_addr1_max,company_addr1_nulls,company_address_specificity,company_address_switch,company_address_max,company_address_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,active_domestic_corp_key_specificity,active_domestic_corp_key_switch,active_domestic_corp_key_max,active_domestic_corp_key_nulls,source_specificity,source_switch,source_max,source_nulls,source_record_id_specificity,source_record_id_switch,source_record_id_max,source_record_id_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,contact_ssn_specificity,contact_ssn_switch,contact_ssn_max,contact_ssn_nulls,contact_phone_specificity,contact_phone_switch,contact_phone_max,contact_phone_nulls,contact_email_username_specificity,contact_email_username_switch,contact_email_username_max,contact_email_username_nulls}],Layout_Specificities.R) : PERSIST('BIPV2_Relative::Proxid::Specificities');
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 24);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 7);
  integer1 corp_legal_name_shift0 := ROUND(Specificities[1].corp_legal_name_specificity - 24);
  integer2 corp_legal_name_switch_shift0 := ROUND(1000*Specificities[1].corp_legal_name_switch - 7);
  integer1 cnp_hasnumber_shift0 := ROUND(Specificities[1].cnp_hasnumber_specificity - 0);
  integer2 cnp_hasnumber_switch_shift0 := ROUND(1000*Specificities[1].cnp_hasnumber_switch - 0);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 11);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 1);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 1);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 25);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 8);
  integer1 company_inc_state_shift0 := ROUND(Specificities[1].company_inc_state_specificity - 8);
  integer2 company_inc_state_switch_shift0 := ROUND(1000*Specificities[1].company_inc_state_switch - 1);
  integer1 company_charter_number_shift0 := ROUND(Specificities[1].company_charter_number_specificity - 25);
  integer2 company_charter_number_switch_shift0 := ROUND(1000*Specificities[1].company_charter_number_switch - 7);
  integer1 iscorp_shift0 := ROUND(Specificities[1].iscorp_specificity - 1);
  integer2 iscorp_switch_shift0 := ROUND(1000*Specificities[1].iscorp_switch - 1);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 1);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 4);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 1);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 5);
  integer1 addr_suffix_shift0 := ROUND(Specificities[1].addr_suffix_specificity - 4);
  integer2 addr_suffix_switch_shift0 := ROUND(1000*Specificities[1].addr_suffix_switch - 0);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 7);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 1);
  integer1 p_city_name_shift0 := ROUND(Specificities[1].p_city_name_specificity - 11);
  integer2 p_city_name_switch_shift0 := ROUND(1000*Specificities[1].p_city_name_switch - 8);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 9);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 4);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 9);
  integer1 zip4_shift0 := ROUND(Specificities[1].zip4_specificity - 13);
  integer2 zip4_switch_shift0 := ROUND(1000*Specificities[1].zip4_switch - 1);
  integer1 company_csz_shift0 := ROUND(Specificities[1].company_csz_specificity - 22);
  integer2 company_csz_switch_shift0 := ROUND(1000*Specificities[1].company_csz_switch - 24);
  integer1 company_addr1_shift0 := ROUND(Specificities[1].company_addr1_specificity - 23);
  integer2 company_addr1_switch_shift0 := ROUND(1000*Specificities[1].company_addr1_switch - 42);
  integer1 company_address_shift0 := ROUND(Specificities[1].company_address_specificity - 24);
  integer2 company_address_switch_shift0 := ROUND(1000*Specificities[1].company_address_switch - 45);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 25);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 9);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 26);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 8);
  integer1 active_domestic_corp_key_shift0 := ROUND(Specificities[1].active_domestic_corp_key_specificity - 25);
  integer2 active_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].active_domestic_corp_key_switch - 6);
  integer1 source_shift0 := ROUND(Specificities[1].source_specificity - 2);
  integer2 source_switch_shift0 := ROUND(1000*Specificities[1].source_switch - 2);
  integer1 source_record_id_shift0 := ROUND(Specificities[1].source_record_id_specificity - 26);
  integer2 source_record_id_switch_shift0 := ROUND(1000*Specificities[1].source_record_id_switch - 26);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 10);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 4);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 8);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 0);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 15);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 5);
  integer1 contact_ssn_shift0 := ROUND(Specificities[1].contact_ssn_specificity - 26);
  integer2 contact_ssn_switch_shift0 := ROUND(1000*Specificities[1].contact_ssn_switch - 5);
  integer1 contact_phone_shift0 := ROUND(Specificities[1].contact_phone_specificity - 25);
  integer2 contact_phone_switch_shift0 := ROUND(1000*Specificities[1].contact_phone_switch - 25);
  integer1 contact_email_username_shift0 := ROUND(Specificities[1].contact_email_username_specificity - 0);
  integer2 contact_email_username_switch_shift0 := ROUND(1000*Specificities[1].contact_email_username_switch - 0);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
END;
