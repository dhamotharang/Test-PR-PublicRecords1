IMPORT ut,SALT31, /*HACK*/SALT38;
EXPORT specificities(DATASET(layout_Base) ih) := MODULE
 
EXPORT ih_init := SALT31.initNullIDs.baseLevel(ih,rcid,Seleid);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT31.UIDType Seleid := h.Seleid; // using existing id field
  h.rcid;//RIDfield 
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))Fields.Make_cnp_name((SALT31.StrType)h.cnp_name ); // Cleans before using
  h.company_inc_state;
  h.company_charter_number;
  h.company_fein;
  h.prim_range;
  h.prim_name;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.active_duns_number;
  h.active_enterprise_number;
  h.source;
  h.source_record_id;
  h.fname;
  h.mname;
  h.lname;
  h.contact_ssn;
  h.contact_phone;
  h.company_department;
  h.contact_email_username;
  h.dt_first_seen;
  h.dt_last_seen;
  h.dt_first_seen_contact;
  h.dt_last_seen_contact;
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(Seleid<>0),r),HASH(Seleid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have Seleid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Seleid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Seleid,LOCAL) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  cnp_name_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,cnp_name) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::cnp_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  /*HACK*/SALT38.mac_edit_distance_pairs(specs_added,cnp_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT cnp_name_values_persisted_temp := distance_computed : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::cnp_name',EXPIRE(Config.PersistExpire));
 
EXPORT  company_inc_state_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,company_inc_state) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::company_inc_state',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(company_inc_state_deduped,company_inc_state,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_inc_state_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::company_inc_state',EXPIRE(Config.PersistExpire));
 
EXPORT  company_charter_number_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,company_charter_number) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::company_charter_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(company_charter_number_deduped,company_charter_number,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  /*HACK*/SALT38.mac_edit_distance_pairs(specs_added,company_charter_number,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_charter_number_values_persisted_temp := distance_computed : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::company_charter_number',EXPIRE(Config.PersistExpire));
 
EXPORT  company_fein_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,company_fein) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::company_fein',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(company_fein_deduped,company_fein,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_fein_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::company_fein',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_range_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,prim_range) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::prim_range',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(prim_range_deduped,prim_range,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::prim_range',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_name_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,prim_name) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::prim_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(prim_name_deduped,prim_name,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::prim_name',EXPIRE(Config.PersistExpire));
 
EXPORT  postdir_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,postdir) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::postdir',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(postdir_deduped,postdir,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT postdir_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::postdir',EXPIRE(Config.PersistExpire));
 
EXPORT  sec_range_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,sec_range) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::sec_range',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(sec_range_deduped,sec_range,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::sec_range',EXPIRE(Config.PersistExpire));
 
EXPORT  v_city_name_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,v_city_name) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::v_city_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::v_city_name',EXPIRE(Config.PersistExpire));
 
EXPORT  st_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,st) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::st',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(st_deduped,st,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::st',EXPIRE(Config.PersistExpire));
 
EXPORT  active_duns_number_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,active_duns_number) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::active_duns_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_duns_number_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::active_duns_number',EXPIRE(Config.PersistExpire));
 
EXPORT  active_enterprise_number_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,active_enterprise_number) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::active_enterprise_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_enterprise_number_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::active_enterprise_number',EXPIRE(Config.PersistExpire));
 
EXPORT  source_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,source) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::source',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(source_deduped,source,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT source_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::source',EXPIRE(Config.PersistExpire));
 
EXPORT  source_record_id_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,source_record_id) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::source_record_id',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(source_record_id_deduped,source_record_id,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT source_record_id_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::source_record_id',EXPIRE(Config.PersistExpire));
 
EXPORT  fname_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,fname) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::fname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(fname_deduped,fname,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fname_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::fname',EXPIRE(Config.PersistExpire));
 
EXPORT  mname_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,mname) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::mname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(mname_deduped,mname,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mname_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::mname',EXPIRE(Config.PersistExpire));
 
EXPORT  lname_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,lname) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::lname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(lname_deduped,lname,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT lname_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::lname',EXPIRE(Config.PersistExpire));
 
EXPORT  contact_ssn_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,contact_ssn) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::contact_ssn',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(contact_ssn_deduped,contact_ssn,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_ssn_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::contact_ssn',EXPIRE(Config.PersistExpire));
 
EXPORT  contact_phone_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,contact_phone) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::contact_phone',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(contact_phone_deduped,contact_phone,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_phone_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::contact_phone',EXPIRE(Config.PersistExpire));
 
EXPORT  contact_email_username_deduped := SALT31.MAC_Field_By_UID(input_file,Seleid,contact_email_username) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::dedups::contact_email_username',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT31.Mac_Field_Count_UID(contact_email_username_deduped,contact_email_username,Seleid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT31.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_email_username_values_persisted_temp := specs_added : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::values::contact_email_username',EXPIRE(Config.PersistExpire));
 
EXPORT cnp_nameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::cnp_name';
 
EXPORT cnp_nameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::cnp_name';
 
EXPORT cnp_name_values_index := INDEX(cnp_name_values_persisted_temp,{cnp_name},{cnp_name_values_persisted_temp},cnp_nameValuesIndexKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
SALT31.MAC_Field_Nulls(cnp_name_values_persisted,Layout_Specificities.cnp_name_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_name_nulls := nv;
SALT31.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,Seleid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT company_inc_stateValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::company_inc_state';
 
EXPORT company_inc_stateValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::company_inc_state';
 
EXPORT company_inc_state_values_index := INDEX(company_inc_state_values_persisted_temp,{company_inc_state},{company_inc_state_values_persisted_temp},company_inc_stateValuesIndexKeyName);
EXPORT company_inc_state_values_persisted := company_inc_state_values_index;
SALT31.MAC_Field_Nulls(company_inc_state_values_persisted,Layout_Specificities.company_inc_state_ChildRec,nv) // Use automated NULL spotting
EXPORT company_inc_state_nulls := nv;
SALT31.MAC_Field_Bfoul(company_inc_state_deduped,company_inc_state,Seleid,company_inc_state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_inc_state_switch := bf;
EXPORT company_inc_state_max := MAX(company_inc_state_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(company_inc_state_values_persisted,company_inc_state,company_inc_state_nulls,ol) // Compute column level specificity
EXPORT company_inc_state_specificity := ol;
 
EXPORT company_charter_numberValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::company_charter_number';
 
EXPORT company_charter_numberValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::company_charter_number';
 
EXPORT company_charter_number_values_index := INDEX(company_charter_number_values_persisted_temp,{company_charter_number},{company_charter_number_values_persisted_temp},company_charter_numberValuesIndexKeyName);
EXPORT company_charter_number_values_persisted := company_charter_number_values_index;
SALT31.MAC_Field_Nulls(company_charter_number_values_persisted,Layout_Specificities.company_charter_number_ChildRec,nv) // Use automated NULL spotting
EXPORT company_charter_number_nulls := nv;
SALT31.MAC_Field_Bfoul(company_charter_number_deduped,company_charter_number,Seleid,company_charter_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_charter_number_switch := bf;
EXPORT company_charter_number_max := MAX(company_charter_number_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(company_charter_number_values_persisted,company_charter_number,company_charter_number_nulls,ol) // Compute column level specificity
EXPORT company_charter_number_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::company_fein';
 
EXPORT company_feinValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT31.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT31.MAC_Field_Bfoul(company_fein_deduped,company_fein,Seleid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::prim_range';
 
EXPORT prim_rangeValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT31.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT31.MAC_Field_Bfoul(prim_range_deduped,prim_range,Seleid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::prim_name';
 
EXPORT prim_nameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT31.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT31.MAC_Field_Bfoul(prim_name_deduped,prim_name,Seleid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT postdirValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::postdir';
 
EXPORT postdirValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::postdir';
 
EXPORT postdir_values_index := INDEX(postdir_values_persisted_temp,{postdir},{postdir_values_persisted_temp},postdirValuesIndexKeyName);
EXPORT postdir_values_persisted := postdir_values_index;
SALT31.MAC_Field_Nulls(postdir_values_persisted,Layout_Specificities.postdir_ChildRec,nv) // Use automated NULL spotting
EXPORT postdir_nulls := nv;
SALT31.MAC_Field_Bfoul(postdir_deduped,postdir,Seleid,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT postdir_switch := bf;
EXPORT postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
EXPORT postdir_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::sec_range';
 
EXPORT sec_rangeValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::sec_range';
 
EXPORT sec_range_values_index := INDEX(sec_range_values_persisted_temp,{sec_range},{sec_range_values_persisted_temp},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT31.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT31.MAC_Field_Bfoul(sec_range_deduped,sec_range,Seleid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::v_city_name';
 
EXPORT v_city_nameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::v_city_name';
 
EXPORT v_city_name_values_index := INDEX(v_city_name_values_persisted_temp,{v_city_name},{v_city_name_values_persisted_temp},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT31.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT31.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Seleid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::st';
 
EXPORT stValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT31.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT31.MAC_Field_Bfoul(st_deduped,st,Seleid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::active_duns_number';
 
EXPORT active_duns_numberValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::active_duns_number';
 
EXPORT active_duns_number_values_index := INDEX(active_duns_number_values_persisted_temp,{active_duns_number},{active_duns_number_values_persisted_temp},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT31.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT31.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,Seleid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT active_enterprise_numberValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::active_enterprise_number';
 
EXPORT active_enterprise_numberValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::active_enterprise_number';
 
EXPORT active_enterprise_number_values_index := INDEX(active_enterprise_number_values_persisted_temp,{active_enterprise_number},{active_enterprise_number_values_persisted_temp},active_enterprise_numberValuesIndexKeyName);
EXPORT active_enterprise_number_values_persisted := active_enterprise_number_values_index;
SALT31.MAC_Field_Nulls(active_enterprise_number_values_persisted,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_enterprise_number_nulls := nv;
SALT31.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,Seleid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_enterprise_number_switch := bf;
EXPORT active_enterprise_number_max := MAX(active_enterprise_number_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT active_enterprise_number_specificity := ol;
 
EXPORT sourceValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::source';
 
EXPORT sourceValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::source';
 
EXPORT source_values_index := INDEX(source_values_persisted_temp,{source},{source_values_persisted_temp},sourceValuesIndexKeyName);
EXPORT source_values_persisted := source_values_index;
SALT31.MAC_Field_Nulls(source_values_persisted,Layout_Specificities.source_ChildRec,nv) // Use automated NULL spotting
EXPORT source_nulls := nv;
SALT31.MAC_Field_Bfoul(source_deduped,source,Seleid,source_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT source_switch := bf;
EXPORT source_max := MAX(source_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(source_values_persisted,source,source_nulls,ol) // Compute column level specificity
EXPORT source_specificity := ol;
 
EXPORT source_record_idValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::source_record_id';
 
EXPORT source_record_idValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::source_record_id';
 
EXPORT source_record_id_values_index := INDEX(source_record_id_values_persisted_temp,{source_record_id},{source_record_id_values_persisted_temp},source_record_idValuesIndexKeyName);
EXPORT source_record_id_values_persisted := source_record_id_values_index;
SALT31.MAC_Field_Nulls(source_record_id_values_persisted,Layout_Specificities.source_record_id_ChildRec,nv) // Use automated NULL spotting
EXPORT source_record_id_nulls := nv;
SALT31.MAC_Field_Bfoul(source_record_id_deduped,source_record_id,Seleid,source_record_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT source_record_id_switch := bf;
EXPORT source_record_id_max := MAX(source_record_id_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(source_record_id_values_persisted,source_record_id,source_record_id_nulls,ol) // Compute column level specificity
EXPORT source_record_id_specificity := ol;
 
EXPORT fnameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::fname';
 
EXPORT fnameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::fname';
 
EXPORT fname_values_index := INDEX(fname_values_persisted_temp,{fname},{fname_values_persisted_temp},fnameValuesIndexKeyName);
EXPORT fname_values_persisted := fname_values_index;
SALT31.MAC_Field_Nulls(fname_values_persisted,Layout_Specificities.fname_ChildRec,nv) // Use automated NULL spotting
EXPORT fname_nulls := nv;
SALT31.MAC_Field_Bfoul(fname_deduped,fname,Seleid,fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
 
EXPORT mnameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::mname';
 
EXPORT mnameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::mname';
 
EXPORT mname_values_index := INDEX(mname_values_persisted_temp,{mname},{mname_values_persisted_temp},mnameValuesIndexKeyName);
EXPORT mname_values_persisted := mname_values_index;
SALT31.MAC_Field_Nulls(mname_values_persisted,Layout_Specificities.mname_ChildRec,nv) // Use automated NULL spotting
EXPORT mname_nulls := nv;
SALT31.MAC_Field_Bfoul(mname_deduped,mname,Seleid,mname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mname_switch := bf;
EXPORT mname_max := MAX(mname_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
EXPORT mname_specificity := ol;
 
EXPORT lnameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::lname';
 
EXPORT lnameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::lname';
 
EXPORT lname_values_index := INDEX(lname_values_persisted_temp,{lname},{lname_values_persisted_temp},lnameValuesIndexKeyName);
EXPORT lname_values_persisted := lname_values_index;
SALT31.MAC_Field_Nulls(lname_values_persisted,Layout_Specificities.lname_ChildRec,nv) // Use automated NULL spotting
EXPORT lname_nulls := nv;
SALT31.MAC_Field_Bfoul(lname_deduped,lname,Seleid,lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
 
EXPORT contact_ssnValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::contact_ssn';
 
EXPORT contact_ssnValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::contact_ssn';
 
EXPORT contact_ssn_values_index := INDEX(contact_ssn_values_persisted_temp,{contact_ssn},{contact_ssn_values_persisted_temp},contact_ssnValuesIndexKeyName);
EXPORT contact_ssn_values_persisted := contact_ssn_values_index;
SALT31.MAC_Field_Nulls(contact_ssn_values_persisted,Layout_Specificities.contact_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_ssn_nulls := nv;
SALT31.MAC_Field_Bfoul(contact_ssn_deduped,contact_ssn,Seleid,contact_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_ssn_switch := bf;
EXPORT contact_ssn_max := MAX(contact_ssn_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(contact_ssn_values_persisted,contact_ssn,contact_ssn_nulls,ol) // Compute column level specificity
EXPORT contact_ssn_specificity := ol;
 
EXPORT contact_phoneValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::contact_phone';
 
EXPORT contact_phoneValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::contact_phone';
 
EXPORT contact_phone_values_index := INDEX(contact_phone_values_persisted_temp,{contact_phone},{contact_phone_values_persisted_temp},contact_phoneValuesIndexKeyName);
EXPORT contact_phone_values_persisted := contact_phone_values_index;
SALT31.MAC_Field_Nulls(contact_phone_values_persisted,Layout_Specificities.contact_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_phone_nulls := nv;
SALT31.MAC_Field_Bfoul(contact_phone_deduped,contact_phone,Seleid,contact_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_phone_switch := bf;
EXPORT contact_phone_max := MAX(contact_phone_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(contact_phone_values_persisted,contact_phone,contact_phone_nulls,ol) // Compute column level specificity
EXPORT contact_phone_specificity := ol;
 
EXPORT contact_email_usernameValuesIndexKeyName := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+Config.KeyInfix_specificities+'::Seleid::Word::contact_email_username';
 
EXPORT contact_email_usernameValuesIndexKeyName_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Word::contact_email_username';
 
EXPORT contact_email_username_values_index := INDEX(contact_email_username_values_persisted_temp,{contact_email_username},{contact_email_username_values_persisted_temp},contact_email_usernameValuesIndexKeyName);
EXPORT contact_email_username_values_persisted := contact_email_username_values_index;
SALT31.MAC_Field_Nulls(contact_email_username_values_persisted,Layout_Specificities.contact_email_username_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_email_username_nulls := nv;
SALT31.MAC_Field_Bfoul(contact_email_username_deduped,contact_email_username,Seleid,contact_email_username_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_email_username_switch := bf;
EXPORT contact_email_username_max := MAX(contact_email_username_values_persisted,field_specificity);
SALT31.MAC_Field_Specificity(contact_email_username_values_persisted,contact_email_username,contact_email_username_nulls,ol) // Compute column level specificity
EXPORT contact_email_username_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(company_inc_state_values_index, OVERWRITE),BUILDINDEX(company_charter_number_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(postdir_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(active_enterprise_number_values_index, OVERWRITE),BUILDINDEX(source_values_index, OVERWRITE),BUILDINDEX(source_record_id_values_index, OVERWRITE),BUILDINDEX(fname_values_index, OVERWRITE),BUILDINDEX(mname_values_index, OVERWRITE),BUILDINDEX(lname_values_index, OVERWRITE),BUILDINDEX(contact_ssn_values_index, OVERWRITE),BUILDINDEX(contact_phone_values_index, OVERWRITE),BUILDINDEX(contact_email_username_values_index, OVERWRITE));
EXPORT BuildAll := BuildFields;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_Seleid_Relative::Seleid::Specificities';
iSpecificities := DATASET([{0,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,company_inc_state_specificity,company_inc_state_switch,company_inc_state_max,company_inc_state_nulls,company_charter_number_specificity,company_charter_number_switch,company_charter_number_max,company_charter_number_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,source_specificity,source_switch,source_max,source_nulls,source_record_id_specificity,source_record_id_switch,source_record_id_max,source_record_id_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,contact_ssn_specificity,contact_ssn_switch,contact_ssn_max,contact_ssn_nulls,contact_phone_specificity,contact_phone_switch,contact_phone_max,contact_phone_nulls,contact_email_username_specificity,contact_email_username_switch,contact_email_username_max,contact_email_username_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( BuildAll, BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 25);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 277);
  integer1 company_inc_state_shift0 := ROUND(Specificities[1].company_inc_state_specificity - 7);
  integer2 company_inc_state_switch_shift0 := ROUND(1000*Specificities[1].company_inc_state_switch - 28);
  integer1 company_charter_number_shift0 := ROUND(Specificities[1].company_charter_number_specificity - 27);
  integer2 company_charter_number_switch_shift0 := ROUND(1000*Specificities[1].company_charter_number_switch - 66);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 27);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 171);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 153);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 176);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 7);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 59);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 204);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 104);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 23);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 28);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 61);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 28);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 33);
  integer1 source_shift0 := ROUND(Specificities[1].source_specificity - 4);
  integer2 source_switch_shift0 := ROUND(1000*Specificities[1].source_switch - 678);
  integer1 source_record_id_shift0 := ROUND(Specificities[1].source_record_id_specificity - 27);
  integer2 source_record_id_switch_shift0 := ROUND(1000*Specificities[1].source_record_id_switch - 909);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 11);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 471);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 8);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 321);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 16);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 353);
  integer1 contact_ssn_shift0 := ROUND(Specificities[1].contact_ssn_specificity - 27);
  integer2 contact_ssn_switch_shift0 := ROUND(1000*Specificities[1].contact_ssn_switch - 149);
  integer1 contact_phone_shift0 := ROUND(Specificities[1].contact_phone_specificity - 27);
  integer2 contact_phone_switch_shift0 := ROUND(1000*Specificities[1].contact_phone_switch - 219);
  integer1 contact_email_username_shift0 := ROUND(Specificities[1].contact_email_username_specificity - 26);
  integer2 contact_email_username_switch_shift0 := ROUND(1000*Specificities[1].contact_email_username_switch - 209);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
PivotedSpcShiftR := RECORD
  STRING label;
  INTEGER1 shift0;
  INTEGER2 switch_shift0;
  END;
 
EXPORT PivotedSpcShift := SALT31.MAC_Pivot(SpcShift,PivotedSpcShiftR);
// Service functions for specificity profiling
  SALT31.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT31.MAC_Specificity_Values(company_inc_state_values_persisted,company_inc_state,'company_inc_state',company_inc_state_specificity,company_inc_state_specificity_profile);
  SALT31.MAC_Specificity_Values(company_charter_number_values_persisted,company_charter_number,'company_charter_number',company_charter_number_specificity,company_charter_number_specificity_profile);
  SALT31.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT31.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT31.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT31.MAC_Specificity_Values(postdir_values_persisted,postdir,'postdir',postdir_specificity,postdir_specificity_profile);
  SALT31.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT31.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT31.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT31.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT31.MAC_Specificity_Values(active_enterprise_number_values_persisted,active_enterprise_number,'active_enterprise_number',active_enterprise_number_specificity,active_enterprise_number_specificity_profile);
  SALT31.MAC_Specificity_Values(source_values_persisted,source,'source',source_specificity,source_specificity_profile);
  SALT31.MAC_Specificity_Values(source_record_id_values_persisted,source_record_id,'source_record_id',source_record_id_specificity,source_record_id_specificity_profile);
  SALT31.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT31.MAC_Specificity_Values(mname_values_persisted,mname,'mname',mname_specificity,mname_specificity_profile);
  SALT31.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT31.MAC_Specificity_Values(contact_ssn_values_persisted,contact_ssn,'contact_ssn',contact_ssn_specificity,contact_ssn_specificity_profile);
  SALT31.MAC_Specificity_Values(contact_phone_values_persisted,contact_phone,'contact_phone',contact_phone_specificity,contact_phone_specificity_profile);
  SALT31.MAC_Specificity_Values(contact_email_username_values_persisted,contact_email_username,'contact_email_username',contact_email_username_specificity,contact_email_username_specificity_profile);
EXPORT AllProfiles := cnp_name_specificity_profile + company_inc_state_specificity_profile + company_charter_number_specificity_profile + company_fein_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + postdir_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + active_duns_number_specificity_profile + active_enterprise_number_specificity_profile + source_specificity_profile + source_record_id_specificity_profile + fname_specificity_profile + mname_specificity_profile + lname_specificity_profile + contact_ssn_specificity_profile + contact_phone_specificity_profile + contact_email_username_specificity_profile;
END;
 
