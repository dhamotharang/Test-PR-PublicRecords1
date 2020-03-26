IMPORT ut,SALT30;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_EmpID) h) := MODULE
 
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT30.UIDType EmpID := h.EmpID; // using existing id field
  SALT30.UIDType SeleID := h.SeleID; // Copy ID from hierarchy
  SALT30.UIDType OrgID := h.OrgID; // Copy ID from hierarchy
  SALT30.UIDType UltID := h.UltID; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.isCorpEnhanced;
  h.contact_job_title_derived;
  TYPEOF(h.cname_devanitize) cname_devanitize := (TYPEOF(h.cname_devanitize))Fields.Make_cname_devanitize((SALT30.StrType)h.cname_devanitize ); // Cleans before using
  h.prim_range;
  h.prim_name;
  h.zip;
  h.zip4;
  h.fname;
  h.lname;
  h.contact_phone;
  h.contact_did;
  h.contact_ssn;
  h.company_name;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.company_inc_state;
  h.company_charter_number;
  h.active_duns_number;
  h.hist_duns_number;
  h.active_domestic_corp_key;
  h.hist_domestic_corp_key;
  h.foreign_corp_key;
  h.unk_corp_key;
  h.company_fein;
  h.cnp_btype;
  h.cnp_name;
  h.company_name_type_derived;
  h.company_bdid;
  h.nodes_total;
  h.dt_first_seen;
  h.dt_last_seen;
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(EmpID<>0),r),HASH(EmpID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT30.MAC_Partition_Stars(h02,SALT_Partition,EmpID); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_isCorpEnhanced((SALT30.StrType)h0.isCorpEnhanced)>0 OR Fields.Invalid_contact_job_title_derived((SALT30.StrType)h0.contact_job_title_derived)>0 OR Fields.Invalid_zip4((SALT30.StrType)h0.zip4)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject) : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have EmpID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.EmpID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,EmpID,LOCAL) : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  cname_devanitize_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,cname_devanitize); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(cname_devanitize_deduped,cname_devanitize,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED cname_devanitize_sa := specs_added; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT30.MAC_Field_Variants_WordBag(cname_devanitize_deduped,EmpID,cname_devanitize,expanded)// expand out all variants of wordbag
  SALT30.Mac_Field_Count_UID(expanded,cname_devanitize,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT30.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED cname_devanitize_ad := wb_specs_added; // Hop over export
 
EXPORT cname_devanitizeValuesKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::cname_devanitize';
 
EXPORT cname_devanitize_values_key := INDEX(cname_devanitize_ad,{cname_devanitize},{cname_devanitize_ad},cname_devanitizeValuesKeyName);
  SALT30.mac_wordbag_addweights(cname_devanitize_sa,cname_devanitize,cname_devanitize_ad,p);
EXPORT cname_devanitize_values_persisted_temp := p;
 
EXPORT  prim_range_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,prim_range); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prim_range_deduped,prim_range,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added;
 
EXPORT  prim_name_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,prim_name); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prim_name_deduped,prim_name,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted_temp := specs_added;
 
EXPORT  zip_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,zip); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(zip_deduped,zip,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added;
 
EXPORT  fname_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,fname); // Reduce to field values by UID
  SALT30.MAC_Field_Variants_Initials(fname_deduped,EmpID,fname,expanded) // expand out all variants of initial
  SALT30.Mac_Field_Count_UID(expanded,fname,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 fname_PreferredName := BIPV2_Tools.fn_PreferredName(counted.fname); // Compute BIPV2_Tools.fn_PreferredName value for fname
  end;
  with_id := table(counted,r1);
  SALT30.MAC_Field_Accumulate_Counts(with_id,fname_PreferredName,PreferredName_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fname_values_persisted_temp := specs_added;
 
EXPORT  lname_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,lname); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(lname_deduped,lname,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT lname_values_persisted_temp := specs_added;
 
EXPORT  contact_phone_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,contact_phone); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(contact_phone_deduped,contact_phone,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_phone_values_persisted_temp := specs_added;
 
EXPORT  contact_did_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,contact_did); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(contact_did_deduped,contact_did,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_did_values_persisted_temp := specs_added;
 
EXPORT  contact_ssn_deduped := SALT30.MAC_Field_By_UID(input_file,EmpID,contact_ssn); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(contact_ssn_deduped,contact_ssn,EmpID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_ssn_values_persisted_temp := specs_added;
 
EXPORT cname_devanitizeValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::cname_devanitize';
 
EXPORT cname_devanitize_values_index := INDEX(cname_devanitize_values_persisted_temp,{cname_devanitize},{cname_devanitize_values_persisted_temp},cname_devanitizeValuesIndexKeyName);
EXPORT cname_devanitize_values_persisted := cname_devanitize_values_index;
EXPORT cname_devanitize_nulls := DATASET([{'',0,0}],Layout_Specificities.cname_devanitize_ChildRec); // Automated null spotting not applicable
SALT30.MAC_Field_Bfoul(cname_devanitize_deduped,cname_devanitize,EmpID,cname_devanitize_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cname_devanitize_switch := bf;
EXPORT cname_devanitize_max := MAX(cname_devanitize_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(cname_devanitize_values_persisted,cname_devanitize,cname_devanitize_nulls,ol) // Compute column level specificity
EXPORT cname_devanitize_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT30.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT30.MAC_Field_Bfoul(prim_range_deduped,prim_range,EmpID,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT30.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT30.MAC_Field_Bfoul(prim_name_deduped,prim_name,EmpID,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT30.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT30.MAC_Field_Bfoul(zip_deduped,zip,EmpID,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT fnameValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::fname';
 
EXPORT fname_values_index := INDEX(fname_values_persisted_temp,{fname},{fname_values_persisted_temp},fnameValuesIndexKeyName);
EXPORT fname_values_persisted := fname_values_index;
EXPORT fname_nulls := DATASET([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT30.MAC_Field_Bfoul(fname_deduped,fname,EmpID,fname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
 
EXPORT lnameValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::lname';
 
EXPORT lname_values_index := INDEX(lname_values_persisted_temp,{lname},{lname_values_persisted_temp},lnameValuesIndexKeyName);
EXPORT lname_values_persisted := lname_values_index;
SALT30.MAC_Field_Nulls(lname_values_persisted,Layout_Specificities.lname_ChildRec,nv) // Use automated NULL spotting
EXPORT lname_nulls := nv;
SALT30.MAC_Field_Bfoul(lname_deduped,lname,EmpID,lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
 
EXPORT contact_phoneValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::contact_phone';
 
EXPORT contact_phone_values_index := INDEX(contact_phone_values_persisted_temp,{contact_phone},{contact_phone_values_persisted_temp},contact_phoneValuesIndexKeyName);
EXPORT contact_phone_values_persisted := contact_phone_values_index;
SALT30.MAC_Field_Nulls(contact_phone_values_persisted,Layout_Specificities.contact_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_phone_nulls := nv;
SALT30.MAC_Field_Bfoul(contact_phone_deduped,contact_phone,EmpID,contact_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_phone_switch := bf;
EXPORT contact_phone_max := MAX(contact_phone_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(contact_phone_values_persisted,contact_phone,contact_phone_nulls,ol) // Compute column level specificity
EXPORT contact_phone_specificity := ol;
 
EXPORT contact_didValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::contact_did';
 
EXPORT contact_did_values_index := INDEX(contact_did_values_persisted_temp,{contact_did},{contact_did_values_persisted_temp},contact_didValuesIndexKeyName);
EXPORT contact_did_values_persisted := contact_did_values_index;
SALT30.MAC_Field_Nulls(contact_did_values_persisted,Layout_Specificities.contact_did_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_did_nulls := nv;
SALT30.MAC_Field_Bfoul(contact_did_deduped,contact_did,EmpID,contact_did_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_did_switch := bf;
EXPORT contact_did_max := MAX(contact_did_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(contact_did_values_persisted,contact_did,contact_did_nulls,ol) // Compute column level specificity
EXPORT contact_did_specificity := ol;
 
EXPORT contact_ssnValuesIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Word::contact_ssn';
 
EXPORT contact_ssn_values_index := INDEX(contact_ssn_values_persisted_temp,{contact_ssn},{contact_ssn_values_persisted_temp},contact_ssnValuesIndexKeyName);
EXPORT contact_ssn_values_persisted := contact_ssn_values_index;
SALT30.MAC_Field_Nulls(contact_ssn_values_persisted,Layout_Specificities.contact_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_ssn_nulls := nv;
SALT30.MAC_Field_Bfoul(contact_ssn_deduped,contact_ssn,EmpID,contact_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_ssn_switch := bf;
EXPORT contact_ssn_max := MAX(contact_ssn_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(contact_ssn_values_persisted,contact_ssn,contact_ssn_nulls,ol) // Compute column level specificity
EXPORT contact_ssn_specificity := ol;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_EMPID_Platform::EmpID::Specificities';
iSpecificities := DATASET([{0,cname_devanitize_specificity,cname_devanitize_switch,cname_devanitize_max,cname_devanitize_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,contact_phone_specificity,contact_phone_switch,contact_phone_max,contact_phone_nulls,contact_did_specificity,contact_did_switch,contact_did_max,contact_did_nulls,contact_ssn_specificity,contact_ssn_switch,contact_ssn_max,contact_ssn_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( PARALLEL(BUILDINDEX(cname_devanitize_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(fname_values_index, OVERWRITE),BUILDINDEX(lname_values_index, OVERWRITE),BUILDINDEX(contact_phone_values_index, OVERWRITE),BUILDINDEX(contact_did_values_index, OVERWRITE),BUILDINDEX(contact_ssn_values_index, OVERWRITE)), BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 cname_devanitize_shift0 := ROUND(Specificities[1].cname_devanitize_specificity - 20);
  integer2 cname_devanitize_switch_shift0 := ROUND(1000*Specificities[1].cname_devanitize_switch - 90);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 37);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 53);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 31);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 8);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 15);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 15);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 20);
  integer1 contact_phone_shift0 := ROUND(Specificities[1].contact_phone_specificity - 24);
  integer2 contact_phone_switch_shift0 := ROUND(1000*Specificities[1].contact_phone_switch - 101);
  integer1 contact_did_shift0 := ROUND(Specificities[1].contact_did_specificity - 24);
  integer2 contact_did_switch_shift0 := ROUND(1000*Specificities[1].contact_did_switch - 23);
  integer1 contact_ssn_shift0 := ROUND(Specificities[1].contact_ssn_specificity - 4);
  integer2 contact_ssn_switch_shift0 := ROUND(1000*Specificities[1].contact_ssn_switch - 48);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT30.MAC_Specificity_Values(cname_devanitize_values_persisted,cname_devanitize,'cname_devanitize',cname_devanitize_specificity,cname_devanitize_specificity_profile);
  SALT30.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT30.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT30.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT30.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT30.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT30.MAC_Specificity_Values(contact_phone_values_persisted,contact_phone,'contact_phone',contact_phone_specificity,contact_phone_specificity_profile);
  SALT30.MAC_Specificity_Values(contact_did_values_persisted,contact_did,'contact_did',contact_did_specificity,contact_did_specificity_profile);
  SALT30.MAC_Specificity_Values(contact_ssn_values_persisted,contact_ssn,'contact_ssn',contact_ssn_specificity,contact_ssn_specificity_profile);
EXPORT AllProfiles := cname_devanitize_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + zip_specificity_profile + fname_specificity_profile + lname_specificity_profile + contact_phone_specificity_profile + contact_did_specificity_profile + contact_ssn_specificity_profile;
END;
 
