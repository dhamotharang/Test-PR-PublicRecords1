import ut,SALT20;
export specificities(dataset(layout_as_bh) h) := MODULE
export input_layout := record // project out required fields
  SALT20.UIDType  := 0; // Fill in the value later
  h.rcid;
  h.bdid;
  h.source;
  h.source_group;
  h.pflag;
  h.group1_id;
  h.vendor_id;
  h.dt_first_seen;
  h.dt_last_seen;
  h.dt_vendor_first_reported;
  h.dt_vendor_last_reported;
  h.company_name;
  h.prim_range;
  h.predir;
  h.prim_name;
  h.addr_suffix;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.city;
  h.state;
  h.zip;
  h.zip4;
  h.county;
  h.msa;
  h.geo_lat;
  h.geo_long;
  h.phone;
  h.phone_score;
  h.fein;
  h.current;
  h.dppa;
  h.vl_id;
  h.RawAID;
END;
r := input_layout;
tab := table(h,r);
ut.mac_sequence_records(tab,,h00);
h01 := distribute(h00,); // group for the specificity_local function
input_layout do_computes(h01 le) := transform
  self := le;
end;
shared h0 := project(h01,do_computes(left));
export input_file_np := h0; // No-persist version for remote_linking
export input_file := h0  : persist('temp::::Business_Research::Specificities_Cache');
//We have  specified - so we can compute statistics on the cluster counts
  r0 := record
    input_file.;
    unsigned6 InCluster := count(group);
  end;
export ClusterSizes := table(input_file,r0,,local)  : persist('temp::::Business_Research::Cluster_Sizes');
shared  rcid_deduped := SALT20.MAC_Field_By_UID(input_file,,rcid) : persist('temp::dedups::Business_Research__rcid'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(rcid_deduped,rcid,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export rcid_values_persisted := specs_added : persist('temp::values::Business_Research__rcid');
export rcid_nulls := dataset([{'',0,0}],Layout_Specificities.rcid_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(rcid_deduped,rcid,,rcid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export rcid_switch := bf;
export rcid_max := MAX(rcid_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(rcid_values_persisted,rcid,rcid_nulls,ol) // Compute column level specificity
export rcid_specificity := ol;
shared  bdid_deduped := SALT20.MAC_Field_By_UID(input_file,,bdid) : persist('temp::dedups::Business_Research__bdid'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(bdid_deduped,bdid,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export bdid_values_persisted := specs_added : persist('temp::values::Business_Research__bdid');
export bdid_nulls := dataset([{'',0,0}],Layout_Specificities.bdid_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(bdid_deduped,bdid,,bdid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export bdid_switch := bf;
export bdid_max := MAX(bdid_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(bdid_values_persisted,bdid,bdid_nulls,ol) // Compute column level specificity
export bdid_specificity := ol;
shared  source_deduped := SALT20.MAC_Field_By_UID(input_file,,source) : persist('temp::dedups::Business_Research__source'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(source_deduped,source,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export source_values_persisted := specs_added : persist('temp::values::Business_Research__source');
export source_nulls := dataset([{'',0,0}],Layout_Specificities.source_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(source_deduped,source,,source_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export source_switch := bf;
export source_max := MAX(source_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(source_values_persisted,source,source_nulls,ol) // Compute column level specificity
export source_specificity := ol;
shared  source_group_deduped := SALT20.MAC_Field_By_UID(input_file,,source_group) : persist('temp::dedups::Business_Research__source_group'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(source_group_deduped,source_group,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export source_group_values_persisted := specs_added : persist('temp::values::Business_Research__source_group');
export source_group_nulls := dataset([{'',0,0}],Layout_Specificities.source_group_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(source_group_deduped,source_group,,source_group_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export source_group_switch := bf;
export source_group_max := MAX(source_group_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(source_group_values_persisted,source_group,source_group_nulls,ol) // Compute column level specificity
export source_group_specificity := ol;
shared  pflag_deduped := SALT20.MAC_Field_By_UID(input_file,,pflag) : persist('temp::dedups::Business_Research__pflag'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(pflag_deduped,pflag,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export pflag_values_persisted := specs_added : persist('temp::values::Business_Research__pflag');
export pflag_nulls := dataset([{'',0,0}],Layout_Specificities.pflag_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(pflag_deduped,pflag,,pflag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export pflag_switch := bf;
export pflag_max := MAX(pflag_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(pflag_values_persisted,pflag,pflag_nulls,ol) // Compute column level specificity
export pflag_specificity := ol;
shared  group1_id_deduped := SALT20.MAC_Field_By_UID(input_file,,group1_id) : persist('temp::dedups::Business_Research__group1_id'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(group1_id_deduped,group1_id,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export group1_id_values_persisted := specs_added : persist('temp::values::Business_Research__group1_id');
export group1_id_nulls := dataset([{'',0,0}],Layout_Specificities.group1_id_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(group1_id_deduped,group1_id,,group1_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export group1_id_switch := bf;
export group1_id_max := MAX(group1_id_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(group1_id_values_persisted,group1_id,group1_id_nulls,ol) // Compute column level specificity
export group1_id_specificity := ol;
shared  vendor_id_deduped := SALT20.MAC_Field_By_UID(input_file,,vendor_id) : persist('temp::dedups::Business_Research__vendor_id'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(vendor_id_deduped,vendor_id,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export vendor_id_values_persisted := specs_added : persist('temp::values::Business_Research__vendor_id');
export vendor_id_nulls := dataset([{'',0,0}],Layout_Specificities.vendor_id_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(vendor_id_deduped,vendor_id,,vendor_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export vendor_id_switch := bf;
export vendor_id_max := MAX(vendor_id_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(vendor_id_values_persisted,vendor_id,vendor_id_nulls,ol) // Compute column level specificity
export vendor_id_specificity := ol;
shared  dt_first_seen_deduped := SALT20.MAC_Field_By_UID(input_file,,dt_first_seen) : persist('temp::dedups::Business_Research__dt_first_seen'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_first_seen_values_persisted := specs_added : persist('temp::values::Business_Research__dt_first_seen');
export dt_first_seen_nulls := dataset([{'',0,0}],Layout_Specificities.dt_first_seen_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_first_seen_switch := bf;
export dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
export dt_first_seen_specificity := ol;
shared  dt_last_seen_deduped := SALT20.MAC_Field_By_UID(input_file,,dt_last_seen) : persist('temp::dedups::Business_Research__dt_last_seen'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_last_seen_values_persisted := specs_added : persist('temp::values::Business_Research__dt_last_seen');
export dt_last_seen_nulls := dataset([{'',0,0}],Layout_Specificities.dt_last_seen_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_last_seen_switch := bf;
export dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
export dt_last_seen_specificity := ol;
shared  dt_vendor_first_reported_deduped := SALT20.MAC_Field_By_UID(input_file,,dt_vendor_first_reported) : persist('temp::dedups::Business_Research__dt_vendor_first_reported'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dt_vendor_first_reported_deduped,dt_vendor_first_reported,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_vendor_first_reported_values_persisted := specs_added : persist('temp::values::Business_Research__dt_vendor_first_reported');
export dt_vendor_first_reported_nulls := dataset([{'',0,0}],Layout_Specificities.dt_vendor_first_reported_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dt_vendor_first_reported_deduped,dt_vendor_first_reported,,dt_vendor_first_reported_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_vendor_first_reported_switch := bf;
export dt_vendor_first_reported_max := MAX(dt_vendor_first_reported_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dt_vendor_first_reported_values_persisted,dt_vendor_first_reported,dt_vendor_first_reported_nulls,ol) // Compute column level specificity
export dt_vendor_first_reported_specificity := ol;
shared  dt_vendor_last_reported_deduped := SALT20.MAC_Field_By_UID(input_file,,dt_vendor_last_reported) : persist('temp::dedups::Business_Research__dt_vendor_last_reported'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dt_vendor_last_reported_deduped,dt_vendor_last_reported,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_vendor_last_reported_values_persisted := specs_added : persist('temp::values::Business_Research__dt_vendor_last_reported');
export dt_vendor_last_reported_nulls := dataset([{'',0,0}],Layout_Specificities.dt_vendor_last_reported_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dt_vendor_last_reported_deduped,dt_vendor_last_reported,,dt_vendor_last_reported_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_vendor_last_reported_switch := bf;
export dt_vendor_last_reported_max := MAX(dt_vendor_last_reported_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dt_vendor_last_reported_values_persisted,dt_vendor_last_reported,dt_vendor_last_reported_nulls,ol) // Compute column level specificity
export dt_vendor_last_reported_specificity := ol;
shared  company_name_deduped := SALT20.MAC_Field_By_UID(input_file,,company_name) : persist('temp::dedups::Business_Research__company_name'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(company_name_deduped,company_name,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export company_name_values_persisted := specs_added : persist('temp::values::Business_Research__company_name');
export company_name_nulls := dataset([{'',0,0}],Layout_Specificities.company_name_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(company_name_deduped,company_name,,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export company_name_switch := bf;
export company_name_max := MAX(company_name_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(company_name_values_persisted,company_name,company_name_nulls,ol) // Compute column level specificity
export company_name_specificity := ol;
shared  prim_range_deduped := SALT20.MAC_Field_By_UID(input_file,,prim_range) : persist('temp::dedups::Business_Research__prim_range'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(prim_range_deduped,prim_range,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export prim_range_values_persisted := specs_added : persist('temp::values::Business_Research__prim_range');
export prim_range_nulls := dataset([{'',0,0}],Layout_Specificities.prim_range_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(prim_range_deduped,prim_range,,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export prim_range_switch := bf;
export prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
export prim_range_specificity := ol;
shared  predir_deduped := SALT20.MAC_Field_By_UID(input_file,,predir) : persist('temp::dedups::Business_Research__predir'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(predir_deduped,predir,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export predir_values_persisted := specs_added : persist('temp::values::Business_Research__predir');
export predir_nulls := dataset([{'',0,0}],Layout_Specificities.predir_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(predir_deduped,predir,,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export predir_switch := bf;
export predir_max := MAX(predir_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
export predir_specificity := ol;
shared  prim_name_deduped := SALT20.MAC_Field_By_UID(input_file,,prim_name) : persist('temp::dedups::Business_Research__prim_name'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(prim_name_deduped,prim_name,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export prim_name_values_persisted := specs_added : persist('temp::values::Business_Research__prim_name');
export prim_name_nulls := dataset([{'',0,0}],Layout_Specificities.prim_name_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(prim_name_deduped,prim_name,,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export prim_name_switch := bf;
export prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
export prim_name_specificity := ol;
shared  addr_suffix_deduped := SALT20.MAC_Field_By_UID(input_file,,addr_suffix) : persist('temp::dedups::Business_Research__addr_suffix'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(addr_suffix_deduped,addr_suffix,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export addr_suffix_values_persisted := specs_added : persist('temp::values::Business_Research__addr_suffix');
export addr_suffix_nulls := dataset([{'',0,0}],Layout_Specificities.addr_suffix_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(addr_suffix_deduped,addr_suffix,,addr_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export addr_suffix_switch := bf;
export addr_suffix_max := MAX(addr_suffix_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(addr_suffix_values_persisted,addr_suffix,addr_suffix_nulls,ol) // Compute column level specificity
export addr_suffix_specificity := ol;
shared  postdir_deduped := SALT20.MAC_Field_By_UID(input_file,,postdir) : persist('temp::dedups::Business_Research__postdir'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(postdir_deduped,postdir,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export postdir_values_persisted := specs_added : persist('temp::values::Business_Research__postdir');
export postdir_nulls := dataset([{'',0,0}],Layout_Specificities.postdir_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(postdir_deduped,postdir,,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export postdir_switch := bf;
export postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
export postdir_specificity := ol;
shared  unit_desig_deduped := SALT20.MAC_Field_By_UID(input_file,,unit_desig) : persist('temp::dedups::Business_Research__unit_desig'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(unit_desig_deduped,unit_desig,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export unit_desig_values_persisted := specs_added : persist('temp::values::Business_Research__unit_desig');
export unit_desig_nulls := dataset([{'',0,0}],Layout_Specificities.unit_desig_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(unit_desig_deduped,unit_desig,,unit_desig_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export unit_desig_switch := bf;
export unit_desig_max := MAX(unit_desig_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(unit_desig_values_persisted,unit_desig,unit_desig_nulls,ol) // Compute column level specificity
export unit_desig_specificity := ol;
shared  sec_range_deduped := SALT20.MAC_Field_By_UID(input_file,,sec_range) : persist('temp::dedups::Business_Research__sec_range'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(sec_range_deduped,sec_range,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export sec_range_values_persisted := specs_added : persist('temp::values::Business_Research__sec_range');
export sec_range_nulls := dataset([{'',0,0}],Layout_Specificities.sec_range_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(sec_range_deduped,sec_range,,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export sec_range_switch := bf;
export sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
export sec_range_specificity := ol;
shared  city_deduped := SALT20.MAC_Field_By_UID(input_file,,city) : persist('temp::dedups::Business_Research__city'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(city_deduped,city,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export city_values_persisted := specs_added : persist('temp::values::Business_Research__city');
export city_nulls := dataset([{'',0,0}],Layout_Specificities.city_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(city_deduped,city,,city_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export city_switch := bf;
export city_max := MAX(city_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(city_values_persisted,city,city_nulls,ol) // Compute column level specificity
export city_specificity := ol;
shared  state_deduped := SALT20.MAC_Field_By_UID(input_file,,state) : persist('temp::dedups::Business_Research__state'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(state_deduped,state,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export state_values_persisted := specs_added : persist('temp::values::Business_Research__state');
export state_nulls := dataset([{'',0,0}],Layout_Specificities.state_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(state_deduped,state,,state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export state_switch := bf;
export state_max := MAX(state_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(state_values_persisted,state,state_nulls,ol) // Compute column level specificity
export state_specificity := ol;
shared  zip_deduped := SALT20.MAC_Field_By_UID(input_file,,zip) : persist('temp::dedups::Business_Research__zip'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(zip_deduped,zip,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip_values_persisted := specs_added : persist('temp::values::Business_Research__zip');
export zip_nulls := dataset([{'',0,0}],Layout_Specificities.zip_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(zip_deduped,zip,,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip_switch := bf;
export zip_max := MAX(zip_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
export zip_specificity := ol;
shared  zip4_deduped := SALT20.MAC_Field_By_UID(input_file,,zip4) : persist('temp::dedups::Business_Research__zip4'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(zip4_deduped,zip4,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip4_values_persisted := specs_added : persist('temp::values::Business_Research__zip4');
export zip4_nulls := dataset([{'',0,0}],Layout_Specificities.zip4_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(zip4_deduped,zip4,,zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip4_switch := bf;
export zip4_max := MAX(zip4_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(zip4_values_persisted,zip4,zip4_nulls,ol) // Compute column level specificity
export zip4_specificity := ol;
shared  county_deduped := SALT20.MAC_Field_By_UID(input_file,,county) : persist('temp::dedups::Business_Research__county'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(county_deduped,county,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export county_values_persisted := specs_added : persist('temp::values::Business_Research__county');
export county_nulls := dataset([{'',0,0}],Layout_Specificities.county_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(county_deduped,county,,county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export county_switch := bf;
export county_max := MAX(county_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(county_values_persisted,county,county_nulls,ol) // Compute column level specificity
export county_specificity := ol;
shared  msa_deduped := SALT20.MAC_Field_By_UID(input_file,,msa) : persist('temp::dedups::Business_Research__msa'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(msa_deduped,msa,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export msa_values_persisted := specs_added : persist('temp::values::Business_Research__msa');
export msa_nulls := dataset([{'',0,0}],Layout_Specificities.msa_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(msa_deduped,msa,,msa_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export msa_switch := bf;
export msa_max := MAX(msa_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(msa_values_persisted,msa,msa_nulls,ol) // Compute column level specificity
export msa_specificity := ol;
shared  geo_lat_deduped := SALT20.MAC_Field_By_UID(input_file,,geo_lat) : persist('temp::dedups::Business_Research__geo_lat'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(geo_lat_deduped,geo_lat,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export geo_lat_values_persisted := specs_added : persist('temp::values::Business_Research__geo_lat');
export geo_lat_nulls := dataset([{'',0,0}],Layout_Specificities.geo_lat_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(geo_lat_deduped,geo_lat,,geo_lat_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export geo_lat_switch := bf;
export geo_lat_max := MAX(geo_lat_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(geo_lat_values_persisted,geo_lat,geo_lat_nulls,ol) // Compute column level specificity
export geo_lat_specificity := ol;
shared  geo_long_deduped := SALT20.MAC_Field_By_UID(input_file,,geo_long) : persist('temp::dedups::Business_Research__geo_long'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(geo_long_deduped,geo_long,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export geo_long_values_persisted := specs_added : persist('temp::values::Business_Research__geo_long');
export geo_long_nulls := dataset([{'',0,0}],Layout_Specificities.geo_long_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(geo_long_deduped,geo_long,,geo_long_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export geo_long_switch := bf;
export geo_long_max := MAX(geo_long_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(geo_long_values_persisted,geo_long,geo_long_nulls,ol) // Compute column level specificity
export geo_long_specificity := ol;
shared  phone_deduped := SALT20.MAC_Field_By_UID(input_file,,phone) : persist('temp::dedups::Business_Research__phone'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(phone_deduped,phone,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export phone_values_persisted := specs_added : persist('temp::values::Business_Research__phone');
export phone_nulls := dataset([{'',0,0}],Layout_Specificities.phone_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(phone_deduped,phone,,phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export phone_switch := bf;
export phone_max := MAX(phone_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(phone_values_persisted,phone,phone_nulls,ol) // Compute column level specificity
export phone_specificity := ol;
shared  phone_score_deduped := SALT20.MAC_Field_By_UID(input_file,,phone_score) : persist('temp::dedups::Business_Research__phone_score'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(phone_score_deduped,phone_score,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export phone_score_values_persisted := specs_added : persist('temp::values::Business_Research__phone_score');
export phone_score_nulls := dataset([{'',0,0}],Layout_Specificities.phone_score_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(phone_score_deduped,phone_score,,phone_score_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export phone_score_switch := bf;
export phone_score_max := MAX(phone_score_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(phone_score_values_persisted,phone_score,phone_score_nulls,ol) // Compute column level specificity
export phone_score_specificity := ol;
shared  fein_deduped := SALT20.MAC_Field_By_UID(input_file,,fein) : persist('temp::dedups::Business_Research__fein'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(fein_deduped,fein,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export fein_values_persisted := specs_added : persist('temp::values::Business_Research__fein');
export fein_nulls := dataset([{'',0,0}],Layout_Specificities.fein_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(fein_deduped,fein,,fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export fein_switch := bf;
export fein_max := MAX(fein_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(fein_values_persisted,fein,fein_nulls,ol) // Compute column level specificity
export fein_specificity := ol;
shared  current_deduped := SALT20.MAC_Field_By_UID(input_file,,current) : persist('temp::dedups::Business_Research__current'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(current_deduped,current,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export current_values_persisted := specs_added : persist('temp::values::Business_Research__current');
export current_nulls := dataset([{'',0,0}],Layout_Specificities.current_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(current_deduped,current,,current_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export current_switch := bf;
export current_max := MAX(current_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(current_values_persisted,current,current_nulls,ol) // Compute column level specificity
export current_specificity := ol;
shared  dppa_deduped := SALT20.MAC_Field_By_UID(input_file,,dppa) : persist('temp::dedups::Business_Research__dppa'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dppa_deduped,dppa,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dppa_values_persisted := specs_added : persist('temp::values::Business_Research__dppa');
export dppa_nulls := dataset([{'',0,0}],Layout_Specificities.dppa_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dppa_deduped,dppa,,dppa_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dppa_switch := bf;
export dppa_max := MAX(dppa_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dppa_values_persisted,dppa,dppa_nulls,ol) // Compute column level specificity
export dppa_specificity := ol;
shared  vl_id_deduped := SALT20.MAC_Field_By_UID(input_file,,vl_id) : persist('temp::dedups::Business_Research__vl_id'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(vl_id_deduped,vl_id,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export vl_id_values_persisted := specs_added : persist('temp::values::Business_Research__vl_id');
export vl_id_nulls := dataset([{'',0,0}],Layout_Specificities.vl_id_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(vl_id_deduped,vl_id,,vl_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export vl_id_switch := bf;
export vl_id_max := MAX(vl_id_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(vl_id_values_persisted,vl_id,vl_id_nulls,ol) // Compute column level specificity
export vl_id_specificity := ol;
shared  RawAID_deduped := SALT20.MAC_Field_By_UID(input_file,,RawAID) : persist('temp::dedups::Business_Research__RawAID'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(RawAID_deduped,RawAID,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export RawAID_values_persisted := specs_added : persist('temp::values::Business_Research__RawAID');
export RawAID_nulls := dataset([{'',0,0}],Layout_Specificities.RawAID_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(RawAID_deduped,RawAID,,RawAID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export RawAID_switch := bf;
export RawAID_max := MAX(RawAID_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(RawAID_values_persisted,RawAID,RawAID_nulls,ol) // Compute column level specificity
export RawAID_specificity := ol;
iSpecificities := dataset([{0,rcid_specificity,rcid_switch,rcid_max,rcid_nulls,bdid_specificity,bdid_switch,bdid_max,bdid_nulls,source_specificity,source_switch,source_max,source_nulls,source_group_specificity,source_group_switch,source_group_max,source_group_nulls,pflag_specificity,pflag_switch,pflag_max,pflag_nulls,group1_id_specificity,group1_id_switch,group1_id_max,group1_id_nulls,vendor_id_specificity,vendor_id_switch,vendor_id_max,vendor_id_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,dt_vendor_first_reported_specificity,dt_vendor_first_reported_switch,dt_vendor_first_reported_max,dt_vendor_first_reported_nulls,dt_vendor_last_reported_specificity,dt_vendor_last_reported_switch,dt_vendor_last_reported_max,dt_vendor_last_reported_nulls,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,addr_suffix_specificity,addr_suffix_switch,addr_suffix_max,addr_suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,unit_desig_specificity,unit_desig_switch,unit_desig_max,unit_desig_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,city_specificity,city_switch,city_max,city_nulls,state_specificity,state_switch,state_max,state_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,zip4_specificity,zip4_switch,zip4_max,zip4_nulls,county_specificity,county_switch,county_max,county_nulls,msa_specificity,msa_switch,msa_max,msa_nulls,geo_lat_specificity,geo_lat_switch,geo_lat_max,geo_lat_nulls,geo_long_specificity,geo_long_switch,geo_long_max,geo_long_nulls,phone_specificity,phone_switch,phone_max,phone_nulls,phone_score_specificity,phone_score_switch,phone_score_max,phone_score_nulls,fein_specificity,fein_switch,fein_max,fein_nulls,current_specificity,current_switch,current_max,current_nulls,dppa_specificity,dppa_switch,dppa_max,dppa_nulls,vl_id_specificity,vl_id_switch,vl_id_max,vl_id_nulls,RawAID_specificity,RawAID_switch,RawAID_max,RawAID_nulls}],Layout_Specificities.R) : persist('Business_Research::::Specificities');
export Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 rcid_shift0 := ROUND(Specificities[1].rcid_specificity - 0);
  integer2 rcid_switch_shift0 := ROUND(1000*Specificities[1].rcid_switch - 0);
  integer1 bdid_shift0 := ROUND(Specificities[1].bdid_specificity - 0);
  integer2 bdid_switch_shift0 := ROUND(1000*Specificities[1].bdid_switch - 0);
  integer1 source_shift0 := ROUND(Specificities[1].source_specificity - 0);
  integer2 source_switch_shift0 := ROUND(1000*Specificities[1].source_switch - 0);
  integer1 source_group_shift0 := ROUND(Specificities[1].source_group_specificity - 0);
  integer2 source_group_switch_shift0 := ROUND(1000*Specificities[1].source_group_switch - 0);
  integer1 pflag_shift0 := ROUND(Specificities[1].pflag_specificity - 0);
  integer2 pflag_switch_shift0 := ROUND(1000*Specificities[1].pflag_switch - 0);
  integer1 group1_id_shift0 := ROUND(Specificities[1].group1_id_specificity - 0);
  integer2 group1_id_switch_shift0 := ROUND(1000*Specificities[1].group1_id_switch - 0);
  integer1 vendor_id_shift0 := ROUND(Specificities[1].vendor_id_specificity - 0);
  integer2 vendor_id_switch_shift0 := ROUND(1000*Specificities[1].vendor_id_switch - 0);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  integer1 dt_vendor_first_reported_shift0 := ROUND(Specificities[1].dt_vendor_first_reported_specificity - 0);
  integer2 dt_vendor_first_reported_switch_shift0 := ROUND(1000*Specificities[1].dt_vendor_first_reported_switch - 0);
  integer1 dt_vendor_last_reported_shift0 := ROUND(Specificities[1].dt_vendor_last_reported_specificity - 0);
  integer2 dt_vendor_last_reported_switch_shift0 := ROUND(1000*Specificities[1].dt_vendor_last_reported_switch - 0);
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 0);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 0);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 0);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 0);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 addr_suffix_shift0 := ROUND(Specificities[1].addr_suffix_specificity - 0);
  integer2 addr_suffix_switch_shift0 := ROUND(1000*Specificities[1].addr_suffix_switch - 0);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 0);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 0);
  integer1 unit_desig_shift0 := ROUND(Specificities[1].unit_desig_specificity - 0);
  integer2 unit_desig_switch_shift0 := ROUND(1000*Specificities[1].unit_desig_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 0);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 0);
  integer1 city_shift0 := ROUND(Specificities[1].city_specificity - 0);
  integer2 city_switch_shift0 := ROUND(1000*Specificities[1].city_switch - 0);
  integer1 state_shift0 := ROUND(Specificities[1].state_specificity - 0);
  integer2 state_switch_shift0 := ROUND(1000*Specificities[1].state_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 0);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 zip4_shift0 := ROUND(Specificities[1].zip4_specificity - 0);
  integer2 zip4_switch_shift0 := ROUND(1000*Specificities[1].zip4_switch - 0);
  integer1 county_shift0 := ROUND(Specificities[1].county_specificity - 0);
  integer2 county_switch_shift0 := ROUND(1000*Specificities[1].county_switch - 0);
  integer1 msa_shift0 := ROUND(Specificities[1].msa_specificity - 0);
  integer2 msa_switch_shift0 := ROUND(1000*Specificities[1].msa_switch - 0);
  integer1 geo_lat_shift0 := ROUND(Specificities[1].geo_lat_specificity - 0);
  integer2 geo_lat_switch_shift0 := ROUND(1000*Specificities[1].geo_lat_switch - 0);
  integer1 geo_long_shift0 := ROUND(Specificities[1].geo_long_specificity - 0);
  integer2 geo_long_switch_shift0 := ROUND(1000*Specificities[1].geo_long_switch - 0);
  integer1 phone_shift0 := ROUND(Specificities[1].phone_specificity - 0);
  integer2 phone_switch_shift0 := ROUND(1000*Specificities[1].phone_switch - 0);
  integer1 phone_score_shift0 := ROUND(Specificities[1].phone_score_specificity - 0);
  integer2 phone_score_switch_shift0 := ROUND(1000*Specificities[1].phone_score_switch - 0);
  integer1 fein_shift0 := ROUND(Specificities[1].fein_specificity - 0);
  integer2 fein_switch_shift0 := ROUND(1000*Specificities[1].fein_switch - 0);
  integer1 current_shift0 := ROUND(Specificities[1].current_specificity - 0);
  integer2 current_switch_shift0 := ROUND(1000*Specificities[1].current_switch - 0);
  integer1 dppa_shift0 := ROUND(Specificities[1].dppa_specificity - 0);
  integer2 dppa_switch_shift0 := ROUND(1000*Specificities[1].dppa_switch - 0);
  integer1 vl_id_shift0 := ROUND(Specificities[1].vl_id_specificity - 0);
  integer2 vl_id_switch_shift0 := ROUND(1000*Specificities[1].vl_id_switch - 0);
  integer1 RawAID_shift0 := ROUND(Specificities[1].RawAID_specificity - 0);
  integer2 RawAID_switch_shift0 := ROUND(1000*Specificities[1].RawAID_switch - 0);
  end;
export SpcShift := table(Specificities,SpcShiftR);
end;
