import ut,SALT19;
export specificities(dataset(layout_FileIN) h) := MODULE
export input_layout := record // project out required fields
  SALT19.UIDType  := 0; // Fill in the value later
  h.did;
  h.src;
  h.dt_first_seen;
  h.dt_last_seen;
  h.dt_vendor_first_reported;
  h.dt_vendor_last_reported;
  h.vendor_id;
  h.phone;
  h.title;
  h.fname;
  h.mname;
  h.lname;
  h.name_suffix;
  h.prim_range;
  h.predir;
  h.prim_name;
  h.suffix;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.city_name;
  h.st;
  h.zip;
  h.zip4;
  h.county;
  h.msa;
  h.geo_blk;
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
export input_file := h0  : persist('temp::::NPPES::Specificities_Cache');
//We have  specified - so we can compute statistics on the cluster counts
  r0 := record
    input_file.;
    unsigned6 InCluster := count(group);
  end;
export ClusterSizes := table(input_file,r0,,local)  : persist('temp::::NPPES::Cluster_Sizes');
shared  did_deduped := SALT19.MAC_Field_By_UID(input_file,,did) : persist('temp::dedups::NPPES__did'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(did_deduped,did,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export did_values_persisted := specs_added : persist('temp::values::NPPES__did');
export did_nulls := dataset([{'',0,0}],Layout_Specificities.did_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(did_deduped,did,,did_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export did_switch := bf;
export did_max := MAX(did_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(did_values_persisted,did,did_nulls,ol) // Compute column level specificity
export did_specificity := ol;
shared  src_deduped := SALT19.MAC_Field_By_UID(input_file,,src) : persist('temp::dedups::NPPES__src'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(src_deduped,src,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export src_values_persisted := specs_added : persist('temp::values::NPPES__src');
export src_nulls := dataset([{'',0,0}],Layout_Specificities.src_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(src_deduped,src,,src_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export src_switch := bf;
export src_max := MAX(src_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(src_values_persisted,src,src_nulls,ol) // Compute column level specificity
export src_specificity := ol;
shared  dt_first_seen_deduped := SALT19.MAC_Field_By_UID(input_file,,dt_first_seen) : persist('temp::dedups::NPPES__dt_first_seen'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_first_seen_values_persisted := specs_added : persist('temp::values::NPPES__dt_first_seen');
export dt_first_seen_nulls := dataset([{'',0,0}],Layout_Specificities.dt_first_seen_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_first_seen_switch := bf;
export dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
export dt_first_seen_specificity := ol;
shared  dt_last_seen_deduped := SALT19.MAC_Field_By_UID(input_file,,dt_last_seen) : persist('temp::dedups::NPPES__dt_last_seen'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_last_seen_values_persisted := specs_added : persist('temp::values::NPPES__dt_last_seen');
export dt_last_seen_nulls := dataset([{'',0,0}],Layout_Specificities.dt_last_seen_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_last_seen_switch := bf;
export dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
export dt_last_seen_specificity := ol;
shared  dt_vendor_first_reported_deduped := SALT19.MAC_Field_By_UID(input_file,,dt_vendor_first_reported) : persist('temp::dedups::NPPES__dt_vendor_first_reported'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(dt_vendor_first_reported_deduped,dt_vendor_first_reported,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_vendor_first_reported_values_persisted := specs_added : persist('temp::values::NPPES__dt_vendor_first_reported');
export dt_vendor_first_reported_nulls := dataset([{'',0,0}],Layout_Specificities.dt_vendor_first_reported_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(dt_vendor_first_reported_deduped,dt_vendor_first_reported,,dt_vendor_first_reported_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_vendor_first_reported_switch := bf;
export dt_vendor_first_reported_max := MAX(dt_vendor_first_reported_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(dt_vendor_first_reported_values_persisted,dt_vendor_first_reported,dt_vendor_first_reported_nulls,ol) // Compute column level specificity
export dt_vendor_first_reported_specificity := ol;
shared  dt_vendor_last_reported_deduped := SALT19.MAC_Field_By_UID(input_file,,dt_vendor_last_reported) : persist('temp::dedups::NPPES__dt_vendor_last_reported'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(dt_vendor_last_reported_deduped,dt_vendor_last_reported,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_vendor_last_reported_values_persisted := specs_added : persist('temp::values::NPPES__dt_vendor_last_reported');
export dt_vendor_last_reported_nulls := dataset([{'',0,0}],Layout_Specificities.dt_vendor_last_reported_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(dt_vendor_last_reported_deduped,dt_vendor_last_reported,,dt_vendor_last_reported_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_vendor_last_reported_switch := bf;
export dt_vendor_last_reported_max := MAX(dt_vendor_last_reported_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(dt_vendor_last_reported_values_persisted,dt_vendor_last_reported,dt_vendor_last_reported_nulls,ol) // Compute column level specificity
export dt_vendor_last_reported_specificity := ol;
shared  vendor_id_deduped := SALT19.MAC_Field_By_UID(input_file,,vendor_id) : persist('temp::dedups::NPPES__vendor_id'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(vendor_id_deduped,vendor_id,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export vendor_id_values_persisted := specs_added : persist('temp::values::NPPES__vendor_id');
export vendor_id_nulls := dataset([{'',0,0}],Layout_Specificities.vendor_id_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(vendor_id_deduped,vendor_id,,vendor_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export vendor_id_switch := bf;
export vendor_id_max := MAX(vendor_id_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(vendor_id_values_persisted,vendor_id,vendor_id_nulls,ol) // Compute column level specificity
export vendor_id_specificity := ol;
shared  phone_deduped := SALT19.MAC_Field_By_UID(input_file,,phone) : persist('temp::dedups::NPPES__phone'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(phone_deduped,phone,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export phone_values_persisted := specs_added : persist('temp::values::NPPES__phone');
export phone_nulls := dataset([{'',0,0}],Layout_Specificities.phone_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(phone_deduped,phone,,phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export phone_switch := bf;
export phone_max := MAX(phone_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(phone_values_persisted,phone,phone_nulls,ol) // Compute column level specificity
export phone_specificity := ol;
shared  title_deduped := SALT19.MAC_Field_By_UID(input_file,,title) : persist('temp::dedups::NPPES__title'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(title_deduped,title,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export title_values_persisted := specs_added : persist('temp::values::NPPES__title');
export title_nulls := dataset([{'',0,0}],Layout_Specificities.title_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(title_deduped,title,,title_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export title_switch := bf;
export title_max := MAX(title_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(title_values_persisted,title,title_nulls,ol) // Compute column level specificity
export title_specificity := ol;
shared  fname_deduped := SALT19.MAC_Field_By_UID(input_file,,fname) : persist('temp::dedups::NPPES__fname'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(fname_deduped,fname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export fname_values_persisted := specs_added : persist('temp::values::NPPES__fname');
export fname_nulls := dataset([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(fname_deduped,fname,,fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export fname_switch := bf;
export fname_max := MAX(fname_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
export fname_specificity := ol;
shared  mname_deduped := SALT19.MAC_Field_By_UID(input_file,,mname) : persist('temp::dedups::NPPES__mname'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(mname_deduped,mname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export mname_values_persisted := specs_added : persist('temp::values::NPPES__mname');
export mname_nulls := dataset([{'',0,0}],Layout_Specificities.mname_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(mname_deduped,mname,,mname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export mname_switch := bf;
export mname_max := MAX(mname_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
export mname_specificity := ol;
shared  lname_deduped := SALT19.MAC_Field_By_UID(input_file,,lname) : persist('temp::dedups::NPPES__lname'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(lname_deduped,lname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export lname_values_persisted := specs_added : persist('temp::values::NPPES__lname');
export lname_nulls := dataset([{'',0,0}],Layout_Specificities.lname_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(lname_deduped,lname,,lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export lname_switch := bf;
export lname_max := MAX(lname_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
export lname_specificity := ol;
shared  name_suffix_deduped := SALT19.MAC_Field_By_UID(input_file,,name_suffix) : persist('temp::dedups::NPPES__name_suffix'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(name_suffix_deduped,name_suffix,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export name_suffix_values_persisted := specs_added : persist('temp::values::NPPES__name_suffix');
export name_suffix_nulls := dataset([{'',0,0}],Layout_Specificities.name_suffix_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(name_suffix_deduped,name_suffix,,name_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export name_suffix_switch := bf;
export name_suffix_max := MAX(name_suffix_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(name_suffix_values_persisted,name_suffix,name_suffix_nulls,ol) // Compute column level specificity
export name_suffix_specificity := ol;
shared  prim_range_deduped := SALT19.MAC_Field_By_UID(input_file,,prim_range) : persist('temp::dedups::NPPES__prim_range'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(prim_range_deduped,prim_range,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export prim_range_values_persisted := specs_added : persist('temp::values::NPPES__prim_range');
export prim_range_nulls := dataset([{'',0,0}],Layout_Specificities.prim_range_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(prim_range_deduped,prim_range,,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export prim_range_switch := bf;
export prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
export prim_range_specificity := ol;
shared  predir_deduped := SALT19.MAC_Field_By_UID(input_file,,predir) : persist('temp::dedups::NPPES__predir'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(predir_deduped,predir,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export predir_values_persisted := specs_added : persist('temp::values::NPPES__predir');
export predir_nulls := dataset([{'',0,0}],Layout_Specificities.predir_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(predir_deduped,predir,,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export predir_switch := bf;
export predir_max := MAX(predir_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
export predir_specificity := ol;
shared  prim_name_deduped := SALT19.MAC_Field_By_UID(input_file,,prim_name) : persist('temp::dedups::NPPES__prim_name'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(prim_name_deduped,prim_name,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export prim_name_values_persisted := specs_added : persist('temp::values::NPPES__prim_name');
export prim_name_nulls := dataset([{'',0,0}],Layout_Specificities.prim_name_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(prim_name_deduped,prim_name,,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export prim_name_switch := bf;
export prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
export prim_name_specificity := ol;
shared  suffix_deduped := SALT19.MAC_Field_By_UID(input_file,,suffix) : persist('temp::dedups::NPPES__suffix'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(suffix_deduped,suffix,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export suffix_values_persisted := specs_added : persist('temp::values::NPPES__suffix');
export suffix_nulls := dataset([{'',0,0}],Layout_Specificities.suffix_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(suffix_deduped,suffix,,suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export suffix_switch := bf;
export suffix_max := MAX(suffix_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(suffix_values_persisted,suffix,suffix_nulls,ol) // Compute column level specificity
export suffix_specificity := ol;
shared  postdir_deduped := SALT19.MAC_Field_By_UID(input_file,,postdir) : persist('temp::dedups::NPPES__postdir'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(postdir_deduped,postdir,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export postdir_values_persisted := specs_added : persist('temp::values::NPPES__postdir');
export postdir_nulls := dataset([{'',0,0}],Layout_Specificities.postdir_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(postdir_deduped,postdir,,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export postdir_switch := bf;
export postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
export postdir_specificity := ol;
shared  unit_desig_deduped := SALT19.MAC_Field_By_UID(input_file,,unit_desig) : persist('temp::dedups::NPPES__unit_desig'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(unit_desig_deduped,unit_desig,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export unit_desig_values_persisted := specs_added : persist('temp::values::NPPES__unit_desig');
export unit_desig_nulls := dataset([{'',0,0}],Layout_Specificities.unit_desig_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(unit_desig_deduped,unit_desig,,unit_desig_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export unit_desig_switch := bf;
export unit_desig_max := MAX(unit_desig_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(unit_desig_values_persisted,unit_desig,unit_desig_nulls,ol) // Compute column level specificity
export unit_desig_specificity := ol;
shared  sec_range_deduped := SALT19.MAC_Field_By_UID(input_file,,sec_range) : persist('temp::dedups::NPPES__sec_range'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(sec_range_deduped,sec_range,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export sec_range_values_persisted := specs_added : persist('temp::values::NPPES__sec_range');
export sec_range_nulls := dataset([{'',0,0}],Layout_Specificities.sec_range_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(sec_range_deduped,sec_range,,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export sec_range_switch := bf;
export sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
export sec_range_specificity := ol;
shared  city_name_deduped := SALT19.MAC_Field_By_UID(input_file,,city_name) : persist('temp::dedups::NPPES__city_name'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(city_name_deduped,city_name,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export city_name_values_persisted := specs_added : persist('temp::values::NPPES__city_name');
export city_name_nulls := dataset([{'',0,0}],Layout_Specificities.city_name_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(city_name_deduped,city_name,,city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export city_name_switch := bf;
export city_name_max := MAX(city_name_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(city_name_values_persisted,city_name,city_name_nulls,ol) // Compute column level specificity
export city_name_specificity := ol;
shared  st_deduped := SALT19.MAC_Field_By_UID(input_file,,st) : persist('temp::dedups::NPPES__st'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(st_deduped,st,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export st_values_persisted := specs_added : persist('temp::values::NPPES__st');
export st_nulls := dataset([{'',0,0}],Layout_Specificities.st_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(st_deduped,st,,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export st_switch := bf;
export st_max := MAX(st_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
export st_specificity := ol;
shared  zip_deduped := SALT19.MAC_Field_By_UID(input_file,,zip) : persist('temp::dedups::NPPES__zip'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(zip_deduped,zip,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip_values_persisted := specs_added : persist('temp::values::NPPES__zip');
export zip_nulls := dataset([{'',0,0}],Layout_Specificities.zip_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(zip_deduped,zip,,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip_switch := bf;
export zip_max := MAX(zip_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
export zip_specificity := ol;
shared  zip4_deduped := SALT19.MAC_Field_By_UID(input_file,,zip4) : persist('temp::dedups::NPPES__zip4'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(zip4_deduped,zip4,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip4_values_persisted := specs_added : persist('temp::values::NPPES__zip4');
export zip4_nulls := dataset([{'',0,0}],Layout_Specificities.zip4_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(zip4_deduped,zip4,,zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip4_switch := bf;
export zip4_max := MAX(zip4_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(zip4_values_persisted,zip4,zip4_nulls,ol) // Compute column level specificity
export zip4_specificity := ol;
shared  county_deduped := SALT19.MAC_Field_By_UID(input_file,,county) : persist('temp::dedups::NPPES__county'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(county_deduped,county,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export county_values_persisted := specs_added : persist('temp::values::NPPES__county');
export county_nulls := dataset([{'',0,0}],Layout_Specificities.county_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(county_deduped,county,,county_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export county_switch := bf;
export county_max := MAX(county_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(county_values_persisted,county,county_nulls,ol) // Compute column level specificity
export county_specificity := ol;
shared  msa_deduped := SALT19.MAC_Field_By_UID(input_file,,msa) : persist('temp::dedups::NPPES__msa'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(msa_deduped,msa,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export msa_values_persisted := specs_added : persist('temp::values::NPPES__msa');
export msa_nulls := dataset([{'',0,0}],Layout_Specificities.msa_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(msa_deduped,msa,,msa_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export msa_switch := bf;
export msa_max := MAX(msa_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(msa_values_persisted,msa,msa_nulls,ol) // Compute column level specificity
export msa_specificity := ol;
shared  geo_blk_deduped := SALT19.MAC_Field_By_UID(input_file,,geo_blk) : persist('temp::dedups::NPPES__geo_blk'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(geo_blk_deduped,geo_blk,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export geo_blk_values_persisted := specs_added : persist('temp::values::NPPES__geo_blk');
export geo_blk_nulls := dataset([{'',0,0}],Layout_Specificities.geo_blk_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(geo_blk_deduped,geo_blk,,geo_blk_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export geo_blk_switch := bf;
export geo_blk_max := MAX(geo_blk_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(geo_blk_values_persisted,geo_blk,geo_blk_nulls,ol) // Compute column level specificity
export geo_blk_specificity := ol;
shared  RawAID_deduped := SALT19.MAC_Field_By_UID(input_file,,RawAID) : persist('temp::dedups::NPPES__RawAID'); // Reduce to field values by UID
  SALT19.Mac_Field_Count_UID(RawAID_deduped,RawAID,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT19.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export RawAID_values_persisted := specs_added : persist('temp::values::NPPES__RawAID');
export RawAID_nulls := dataset([{'',0,0}],Layout_Specificities.RawAID_ChildRec); // Automated null spotting not applicable
SALT19.MAC_Field_Bfoul(RawAID_deduped,RawAID,,RawAID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export RawAID_switch := bf;
export RawAID_max := MAX(RawAID_values_persisted,field_specificity);
SALT19.MAC_Field_Specificity(RawAID_values_persisted,RawAID,RawAID_nulls,ol) // Compute column level specificity
export RawAID_specificity := ol;
iSpecificities := dataset([{0,did_specificity,did_switch,did_max,did_nulls,src_specificity,src_switch,src_max,src_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,dt_vendor_first_reported_specificity,dt_vendor_first_reported_switch,dt_vendor_first_reported_max,dt_vendor_first_reported_nulls,dt_vendor_last_reported_specificity,dt_vendor_last_reported_switch,dt_vendor_last_reported_max,dt_vendor_last_reported_nulls,vendor_id_specificity,vendor_id_switch,vendor_id_max,vendor_id_nulls,phone_specificity,phone_switch,phone_max,phone_nulls,title_specificity,title_switch,title_max,title_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,name_suffix_specificity,name_suffix_switch,name_suffix_max,name_suffix_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,suffix_specificity,suffix_switch,suffix_max,suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,unit_desig_specificity,unit_desig_switch,unit_desig_max,unit_desig_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,city_name_specificity,city_name_switch,city_name_max,city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,zip4_specificity,zip4_switch,zip4_max,zip4_nulls,county_specificity,county_switch,county_max,county_nulls,msa_specificity,msa_switch,msa_max,msa_nulls,geo_blk_specificity,geo_blk_switch,geo_blk_max,geo_blk_nulls,RawAID_specificity,RawAID_switch,RawAID_max,RawAID_nulls}],Layout_Specificities.R) : persist('NPPES::::Specificities');
export Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 did_shift0 := ROUND(Specificities[1].did_specificity - 0);
  integer2 did_switch_shift0 := ROUND(1000*Specificities[1].did_switch - 0);
  integer1 src_shift0 := ROUND(Specificities[1].src_specificity - 0);
  integer2 src_switch_shift0 := ROUND(1000*Specificities[1].src_switch - 0);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  integer1 dt_vendor_first_reported_shift0 := ROUND(Specificities[1].dt_vendor_first_reported_specificity - 0);
  integer2 dt_vendor_first_reported_switch_shift0 := ROUND(1000*Specificities[1].dt_vendor_first_reported_switch - 0);
  integer1 dt_vendor_last_reported_shift0 := ROUND(Specificities[1].dt_vendor_last_reported_specificity - 0);
  integer2 dt_vendor_last_reported_switch_shift0 := ROUND(1000*Specificities[1].dt_vendor_last_reported_switch - 0);
  integer1 vendor_id_shift0 := ROUND(Specificities[1].vendor_id_specificity - 0);
  integer2 vendor_id_switch_shift0 := ROUND(1000*Specificities[1].vendor_id_switch - 0);
  integer1 phone_shift0 := ROUND(Specificities[1].phone_specificity - 0);
  integer2 phone_switch_shift0 := ROUND(1000*Specificities[1].phone_switch - 0);
  integer1 title_shift0 := ROUND(Specificities[1].title_specificity - 0);
  integer2 title_switch_shift0 := ROUND(1000*Specificities[1].title_switch - 0);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 0);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 0);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 0);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 0);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 0);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 0);
  integer1 name_suffix_shift0 := ROUND(Specificities[1].name_suffix_specificity - 0);
  integer2 name_suffix_switch_shift0 := ROUND(1000*Specificities[1].name_suffix_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 0);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 0);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 0);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 suffix_shift0 := ROUND(Specificities[1].suffix_specificity - 0);
  integer2 suffix_switch_shift0 := ROUND(1000*Specificities[1].suffix_switch - 0);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 0);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 0);
  integer1 unit_desig_shift0 := ROUND(Specificities[1].unit_desig_specificity - 0);
  integer2 unit_desig_switch_shift0 := ROUND(1000*Specificities[1].unit_desig_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 0);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 0);
  integer1 city_name_shift0 := ROUND(Specificities[1].city_name_specificity - 0);
  integer2 city_name_switch_shift0 := ROUND(1000*Specificities[1].city_name_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 0);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 0);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 zip4_shift0 := ROUND(Specificities[1].zip4_specificity - 0);
  integer2 zip4_switch_shift0 := ROUND(1000*Specificities[1].zip4_switch - 0);
  integer1 county_shift0 := ROUND(Specificities[1].county_specificity - 0);
  integer2 county_switch_shift0 := ROUND(1000*Specificities[1].county_switch - 0);
  integer1 msa_shift0 := ROUND(Specificities[1].msa_specificity - 0);
  integer2 msa_switch_shift0 := ROUND(1000*Specificities[1].msa_switch - 0);
  integer1 geo_blk_shift0 := ROUND(Specificities[1].geo_blk_specificity - 0);
  integer2 geo_blk_switch_shift0 := ROUND(1000*Specificities[1].geo_blk_switch - 0);
  integer1 RawAID_shift0 := ROUND(Specificities[1].RawAID_specificity - 0);
  integer2 RawAID_switch_shift0 := ROUND(1000*Specificities[1].RawAID_switch - 0);
  end;
export SpcShift := table(Specificities,SpcShiftR);
end;
