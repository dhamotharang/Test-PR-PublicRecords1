IMPORT ut,SALT32;
IMPORT BIPV2;
EXPORT specificities(DATASET(layout_DOT) ih) := MODULE
 
EXPORT ih_init := SALT32.initNullIDs.baseLevel(ih,rcid,DOTid);
 
SHARED h := ih_init;
 
IMPORT BIPV2;
EXPORT input_layout := RECORD // project out required fields
  SALT32.UIDType DOTid := h.DOTid; // using existing id field
  SALT32.UIDType proxid := h.proxid; // Copy ID from hierarchy
  SALT32.UIDType lgid3 := h.lgid3; // Copy ID from hierarchy
  SALT32.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT32.UIDType ultid := h.ultid; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.company_name;
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))Fields.Make_cnp_name((SALT32.StrType)h.cnp_name ); // Cleans before using
  UNSIGNED1 cnp_name_len := LENGTH(TRIM((SALT32.StrType)h.cnp_name));
  h.corp_legal_name;
  UNSIGNED1 corp_legal_name_len := LENGTH(TRIM((SALT32.StrType)h.corp_legal_name));
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.cnp_translated;
  h.cnp_classid;
  h.company_fein;
  h.active_duns_number;
  h.active_enterprise_number;
  h.active_domestic_corp_key;
  h.company_bdid;
  h.company_phone;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.st;
  h.v_city_name;
  h.zip;
  unsigned4 csz := 0; // Place holder filled in by project
  unsigned4 addr1 := 0; // Place holder filled in by project
  unsigned4 address := 0; // Place holder filled in by project
  h.isContact;
  h.title;
  h.fname;
  UNSIGNED1 fname_len := LENGTH(TRIM((SALT32.StrType)h.fname));
  h.mname;
  UNSIGNED1 mname_len := LENGTH(TRIM((SALT32.StrType)h.mname));
  h.lname;
  UNSIGNED1 lname_len := LENGTH(TRIM((SALT32.StrType)h.lname));
  h.name_suffix;
  h.contact_ssn;
  UNSIGNED1 contact_ssn_len := LENGTH(TRIM((SALT32.StrType)h.contact_ssn));
  h.contact_phone;
  TYPEOF(h.contact_email) contact_email := (TYPEOF(h.contact_email))Fields.Make_contact_email((SALT32.StrType)h.contact_email ); // Cleans before using
  h.contact_job_title_raw;
  h.company_department;
  h.dt_first_seen;
  h.dt_last_seen;
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(DOTid<>0),r),HASH(DOTid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.csz := IF (Fields.InValid_csz((SALT32.StrType)le.v_city_name,(SALT32.StrType)le.st,(SALT32.StrType)le.zip),0,HASH32((SALT32.StrType)le.v_city_name,(SALT32.StrType)le.st,(SALT32.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.addr1 := IF (Fields.InValid_addr1((SALT32.StrType)le.prim_range,(SALT32.StrType)le.prim_name,(SALT32.StrType)le.sec_range),0,HASH32((SALT32.StrType)le.prim_range,(SALT32.StrType)le.prim_name,(SALT32.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF.address := IF (Fields.InValid_address((SALT32.StrType)SELF.addr1,(SALT32.StrType)SELF.csz),0,HASH32((SALT32.StrType)SELF.addr1,(SALT32.StrType)SELF.csz)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT32.MAC_Partition_Stars(h02,SALT_Partition,DOTid); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
SHARED reject := Fields.Invalid_company_name((SALT32.StrType)h0.company_name)>0;
EXPORT rejected_file := h0(reject);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0(~Reject) : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have DOTid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.DOTid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,DOTid,LOCAL) : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  cnp_name_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,cnp_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,cnp_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT cnp_name_values_persisted_temp := distance_computed : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::cnp_name',EXPIRE(Config.PersistExpire));
 
EXPORT  corp_legal_name_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,corp_legal_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(corp_legal_name_deduped,corp_legal_name,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED corp_legal_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT32.MAC_Field_Variants_WordBag(corp_legal_name_deduped,DOTid,corp_legal_name,expanded)// expand out all variants of wordbag
  SALT32.Mac_Field_Count_UID(expanded,corp_legal_name,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT32.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED corp_legal_name_ad := wb_specs_added; // Hop over export
 
EXPORT corp_legal_nameValuesKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::WordBag::corp_legal_name';
 
EXPORT corp_legal_name_values_key := INDEX(corp_legal_name_ad,{corp_legal_name},{corp_legal_name_ad},corp_legal_nameValuesKeyName);
  SALT32.mac_wordbag_addweights(corp_legal_name_sa,corp_legal_name,corp_legal_name_ad,p);
EXPORT corp_legal_name_values_persisted_temp := p;
 
EXPORT  cnp_number_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,cnp_number); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::cnp_number',EXPIRE(Config.PersistExpire));
 
EXPORT  cnp_btype_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,cnp_btype); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_btype_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::cnp_btype',EXPIRE(Config.PersistExpire));
 
EXPORT  company_fein_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,company_fein); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(company_fein_deduped,company_fein,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_fein_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::company_fein',EXPIRE(Config.PersistExpire));
 
EXPORT  active_duns_number_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,active_duns_number); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_duns_number_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::active_duns_number',EXPIRE(Config.PersistExpire));
 
EXPORT  active_enterprise_number_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,active_enterprise_number); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_enterprise_number_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::active_enterprise_number',EXPIRE(Config.PersistExpire));
 
EXPORT  active_domestic_corp_key_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,active_domestic_corp_key); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(active_domestic_corp_key_deduped,active_domestic_corp_key,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT active_domestic_corp_key_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::active_domestic_corp_key',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_range_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,prim_range); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(prim_range_deduped,prim_range,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::prim_range',EXPIRE(Config.PersistExpire));
 
EXPORT  prim_name_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,prim_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(prim_name_deduped,prim_name,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_name_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::prim_name',EXPIRE(Config.PersistExpire));
 
EXPORT  sec_range_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,sec_range); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(sec_range_deduped,sec_range,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::sec_range',EXPIRE(Config.PersistExpire));
 
EXPORT  st_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,st); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(st_deduped,st,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::st',EXPIRE(Config.PersistExpire));
 
EXPORT  v_city_name_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,v_city_name); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::v_city_name',EXPIRE(Config.PersistExpire));
 
EXPORT  zip_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,zip); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(zip_deduped,zip,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::zip',EXPIRE(Config.PersistExpire));
 
EXPORT  csz_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,csz); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(csz_deduped,csz,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT csz_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::csz',EXPIRE(Config.PersistExpire));
 
EXPORT  addr1_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,addr1); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(addr1_deduped,addr1,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT addr1_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::addr1',EXPIRE(Config.PersistExpire));
 
EXPORT  address_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,address); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(address_deduped,address,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT address_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::address',EXPIRE(Config.PersistExpire));
 
EXPORT  isContact_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,isContact); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(isContact_deduped,isContact,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT isContact_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::isContact',EXPIRE(Config.PersistExpire));
 
EXPORT  fname_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,fname); // Reduce to field values by UID
  SALT32.MAC_Field_Variants_Initials(fname_deduped,DOTid,fname,expanded) // expand out all variants of initial
  SALT32.Mac_Field_Count_UID(expanded,fname,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 fname_PreferredName := fn_PreferredName(counted.fname); // Compute fn_PreferredName value for fname
  end;
  with_id := table(counted,r1);
  SALT32.MAC_Field_Accumulate_Counts(with_id,fname_PreferredName,PreferredName_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,fname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT32.MAC_Field_Initial_Specificities(distance_computed,fname,initial_specs_added) // add initial char specificities
EXPORT fname_values_persisted_temp := initial_specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::fname',EXPIRE(Config.PersistExpire));
 
EXPORT  mname_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,mname); // Reduce to field values by UID
  SALT32.MAC_Field_Variants_Initials(mname_deduped,DOTid,mname,expanded) // expand out all variants of initial
  SALT32.Mac_Field_Count_UID(expanded,mname,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,mname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT32.MAC_Field_Initial_Specificities(distance_computed,mname,initial_specs_added) // add initial char specificities
EXPORT mname_values_persisted_temp := initial_specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::mname',EXPIRE(Config.PersistExpire));
 
EXPORT  lname_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,lname); // Reduce to field values by UID
  expanded := SALT32.MAC_Field_Variants_Hyphen(lname_deduped,DOTid,lname,2); // expand out all variants when hyphenated
  SALT32.Mac_Field_Count_UID(expanded,lname,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,lname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT lname_values_persisted_temp := distance_computed : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::lname',EXPIRE(Config.PersistExpire));
 
EXPORT  name_suffix_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,name_suffix); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(name_suffix_deduped,name_suffix,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING5 name_suffix_NormSuffix := fn_normSuffix(counted.name_suffix); // Compute fn_normSuffix value for name_suffix
  end;
  with_id := table(counted,r1);
  SALT32.MAC_Field_Accumulate_Counts(with_id,name_suffix_NormSuffix,NormSuffix_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT name_suffix_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::name_suffix',EXPIRE(Config.PersistExpire));
 
EXPORT  contact_ssn_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,contact_ssn); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(contact_ssn_deduped,contact_ssn,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING4 contact_ssn_Right4 := fn_Right4(counted.contact_ssn); // Compute fn_Right4 value for contact_ssn
  end;
  with_id := table(counted,r1);
  SALT32.MAC_Field_Accumulate_Counts(with_id,contact_ssn_Right4,Right4_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT32.mac_edit_distance_pairs(specs_added,contact_ssn,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT contact_ssn_values_persisted_temp := distance_computed : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::contact_ssn',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_first_seen_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,dt_first_seen); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(dt_first_seen_deduped,dt_first_seen,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_first_seen_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::dt_first_seen',EXPIRE(Config.PersistExpire));
 
EXPORT  dt_last_seen_deduped := SALT32.MAC_Field_By_UID(input_file,DOTid,dt_last_seen); // Reduce to field values by UID
  SALT32.Mac_Field_Count_UID(dt_last_seen_deduped,dt_last_seen,DOTid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT32.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT dt_last_seen_values_persisted_temp := specs_added : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::dt_last_seen',EXPIRE(Config.PersistExpire));
 
EXPORT BuildBOWFields := BUILDINDEX(corp_legal_name_values_key, OVERWRITE);
 
EXPORT cnp_nameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::cnp_name';
 
EXPORT cnp_name_values_index := INDEX(cnp_name_values_persisted_temp,{cnp_name},{cnp_name_values_persisted_temp},cnp_nameValuesIndexKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
SALT32.MAC_Field_Nulls(cnp_name_values_persisted,Layout_Specificities.cnp_name_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_name_nulls := nv;
SALT32.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,DOTid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT corp_legal_nameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::corp_legal_name';
 
EXPORT corp_legal_name_values_index := INDEX(corp_legal_name_values_persisted_temp,{corp_legal_name},{corp_legal_name_values_persisted_temp},corp_legal_nameValuesIndexKeyName);
EXPORT corp_legal_name_values_persisted := corp_legal_name_values_index;
EXPORT corp_legal_name_nulls := DATASET([{'',0,0}],Layout_Specificities.corp_legal_name_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(corp_legal_name_deduped,corp_legal_name,DOTid,corp_legal_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT corp_legal_name_switch := bf;
EXPORT corp_legal_name_max := MAX(corp_legal_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(corp_legal_name_values_persisted,corp_legal_name,corp_legal_name_nulls,ol) // Compute column level specificity
EXPORT corp_legal_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT32.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT32.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,DOTid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::cnp_btype';
 
EXPORT cnp_btype_values_index := INDEX(cnp_btype_values_persisted_temp,{cnp_btype},{cnp_btype_values_persisted_temp},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,DOTid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT32.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT32.MAC_Field_Bfoul(company_fein_deduped,company_fein,DOTid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::active_duns_number';
 
EXPORT active_duns_number_values_index := INDEX(active_duns_number_values_persisted_temp,{active_duns_number},{active_duns_number_values_persisted_temp},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT32.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT32.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,DOTid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT active_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::active_enterprise_number';
 
EXPORT active_enterprise_number_values_index := INDEX(active_enterprise_number_values_persisted_temp,{active_enterprise_number},{active_enterprise_number_values_persisted_temp},active_enterprise_numberValuesIndexKeyName);
EXPORT active_enterprise_number_values_persisted := active_enterprise_number_values_index;
SALT32.MAC_Field_Nulls(active_enterprise_number_values_persisted,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_enterprise_number_nulls := nv;
SALT32.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,DOTid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_enterprise_number_switch := bf;
EXPORT active_enterprise_number_max := MAX(active_enterprise_number_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT active_enterprise_number_specificity := ol;
 
EXPORT active_domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::active_domestic_corp_key';
 
EXPORT active_domestic_corp_key_values_index := INDEX(active_domestic_corp_key_values_persisted_temp,{active_domestic_corp_key},{active_domestic_corp_key_values_persisted_temp},active_domestic_corp_keyValuesIndexKeyName);
EXPORT active_domestic_corp_key_values_persisted := active_domestic_corp_key_values_index;
SALT32.MAC_Field_Nulls(active_domestic_corp_key_values_persisted,Layout_Specificities.active_domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT active_domestic_corp_key_nulls := nv;
SALT32.MAC_Field_Bfoul(active_domestic_corp_key_deduped,active_domestic_corp_key,DOTid,active_domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_domestic_corp_key_switch := bf;
EXPORT active_domestic_corp_key_max := MAX(active_domestic_corp_key_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT active_domestic_corp_key_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT32.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT32.MAC_Field_Bfoul(prim_range_deduped,prim_range,DOTid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT32.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT32.MAC_Field_Bfoul(prim_name_deduped,prim_name,DOTid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::sec_range';
 
EXPORT sec_range_values_index := INDEX(sec_range_values_persisted_temp,{sec_range},{sec_range_values_persisted_temp},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT32.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT32.MAC_Field_Bfoul(sec_range_deduped,sec_range,DOTid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT32.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT32.MAC_Field_Bfoul(st_deduped,st,DOTid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::v_city_name';
 
EXPORT v_city_name_values_index := INDEX(v_city_name_values_persisted_temp,{v_city_name},{v_city_name_values_persisted_temp},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT32.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT32.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,DOTid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT32.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT32.MAC_Field_Bfoul(zip_deduped,zip,DOTid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT cszValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::csz';
 
EXPORT csz_values_index := INDEX(csz_values_persisted_temp,{csz},{csz_values_persisted_temp},cszValuesIndexKeyName);
EXPORT csz_values_persisted := csz_values_index;
SALT32.MAC_Field_Nulls(csz_values_persisted,Layout_Specificities.csz_ChildRec,nv) // Use automated NULL spotting
EXPORT csz_nulls := nv;
SALT32.MAC_Field_Bfoul(csz_deduped,csz,DOTid,csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT csz_switch := bf;
EXPORT csz_max := MAX(csz_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(csz_values_persisted,csz,csz_nulls,ol) // Compute column level specificity
EXPORT csz_specificity := ol;
 
EXPORT addr1ValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::addr1';
 
EXPORT addr1_values_index := INDEX(addr1_values_persisted_temp,{addr1},{addr1_values_persisted_temp},addr1ValuesIndexKeyName);
EXPORT addr1_values_persisted := addr1_values_index;
SALT32.MAC_Field_Nulls(addr1_values_persisted,Layout_Specificities.addr1_ChildRec,nv) // Use automated NULL spotting
EXPORT addr1_nulls := nv;
SALT32.MAC_Field_Bfoul(addr1_deduped,addr1,DOTid,addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT addr1_switch := bf;
EXPORT addr1_max := MAX(addr1_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(addr1_values_persisted,addr1,addr1_nulls,ol) // Compute column level specificity
EXPORT addr1_specificity := ol;
 
EXPORT addressValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::address';
 
EXPORT address_values_index := INDEX(address_values_persisted_temp,{address},{address_values_persisted_temp},addressValuesIndexKeyName);
EXPORT address_values_persisted := address_values_index;
SALT32.MAC_Field_Nulls(address_values_persisted,Layout_Specificities.address_ChildRec,nv) // Use automated NULL spotting
EXPORT address_nulls := nv;
SALT32.MAC_Field_Bfoul(address_deduped,address,DOTid,address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT address_switch := bf;
EXPORT address_max := MAX(address_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(address_values_persisted,address,address_nulls,ol) // Compute column level specificity
EXPORT address_specificity := ol;
 
EXPORT isContactValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::isContact';
 
EXPORT isContact_values_index := INDEX(isContact_values_persisted_temp,{isContact},{isContact_values_persisted_temp},isContactValuesIndexKeyName);
EXPORT isContact_values_persisted := isContact_values_index;
EXPORT isContact_nulls := DATASET([{'',0,0}],Layout_Specificities.isContact_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(isContact_deduped,isContact,DOTid,isContact_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT isContact_switch := bf;
EXPORT isContact_max := MAX(isContact_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(isContact_values_persisted,isContact,isContact_nulls,ol) // Compute column level specificity
EXPORT isContact_specificity := ol;
 
EXPORT fnameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::fname';
 
EXPORT fname_values_index := INDEX(fname_values_persisted_temp,{fname},{fname_values_persisted_temp},fnameValuesIndexKeyName);
EXPORT fname_values_persisted := fname_values_index;
EXPORT fname_nulls := DATASET([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(fname_deduped,fname,DOTid,fname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
 
EXPORT mnameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::mname';
 
EXPORT mname_values_index := INDEX(mname_values_persisted_temp,{mname},{mname_values_persisted_temp},mnameValuesIndexKeyName);
EXPORT mname_values_persisted := mname_values_index;
EXPORT mname_nulls := DATASET([{'',0,0}],Layout_Specificities.mname_ChildRec); // Automated null spotting not applicable
SALT32.MAC_Field_Bfoul(mname_deduped,mname,DOTid,mname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mname_switch := bf;
EXPORT mname_max := MAX(mname_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
EXPORT mname_specificity := ol;
 
EXPORT lnameValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::lname';
 
EXPORT lname_values_index := INDEX(lname_values_persisted_temp,{lname},{lname_values_persisted_temp},lnameValuesIndexKeyName);
EXPORT lname_values_persisted := lname_values_index;
SALT32.MAC_Field_Nulls(lname_values_persisted,Layout_Specificities.lname_ChildRec,nv) // Use automated NULL spotting
EXPORT lname_nulls := nv;
SALT32.MAC_Field_Bfoul(lname_deduped,lname,DOTid,lname_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
 
EXPORT name_suffixValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::name_suffix';
 
EXPORT name_suffix_values_index := INDEX(name_suffix_values_persisted_temp,{name_suffix},{name_suffix_values_persisted_temp},name_suffixValuesIndexKeyName);
EXPORT name_suffix_values_persisted := name_suffix_values_index;
SALT32.MAC_Field_Nulls(name_suffix_values_persisted,Layout_Specificities.name_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT name_suffix_nulls := nv;
SALT32.MAC_Field_Bfoul(name_suffix_deduped,name_suffix,DOTid,name_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_suffix_switch := bf;
EXPORT name_suffix_max := MAX(name_suffix_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(name_suffix_values_persisted,name_suffix,name_suffix_nulls,ol) // Compute column level specificity
EXPORT name_suffix_specificity := ol;
 
EXPORT contact_ssnValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::contact_ssn';
 
EXPORT contact_ssn_values_index := INDEX(contact_ssn_values_persisted_temp,{contact_ssn},{contact_ssn_values_persisted_temp},contact_ssnValuesIndexKeyName);
EXPORT contact_ssn_values_persisted := contact_ssn_values_index;
SALT32.MAC_Field_Nulls(contact_ssn_values_persisted,Layout_Specificities.contact_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_ssn_nulls := nv;
SALT32.MAC_Field_Bfoul(contact_ssn_deduped,contact_ssn,DOTid,contact_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_ssn_switch := bf;
EXPORT contact_ssn_max := MAX(contact_ssn_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(contact_ssn_values_persisted,contact_ssn,contact_ssn_nulls,ol) // Compute column level specificity
EXPORT contact_ssn_specificity := ol;
 
EXPORT dt_first_seenValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::dt_first_seen';
 
EXPORT dt_first_seen_values_index := INDEX(dt_first_seen_values_persisted_temp,{dt_first_seen},{dt_first_seen_values_persisted_temp},dt_first_seenValuesIndexKeyName);
EXPORT dt_first_seen_values_persisted := dt_first_seen_values_index;
SALT32.MAC_Field_Nulls(dt_first_seen_values_persisted,Layout_Specificities.dt_first_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_first_seen_nulls := nv;
SALT32.MAC_Field_Bfoul(dt_first_seen_deduped,dt_first_seen,DOTid,dt_first_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_first_seen_switch := bf;
EXPORT dt_first_seen_max := MAX(dt_first_seen_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_nulls,ol) // Compute column level specificity
EXPORT dt_first_seen_specificity := ol;
 
EXPORT dt_last_seenValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::dt_last_seen';
 
EXPORT dt_last_seen_values_index := INDEX(dt_last_seen_values_persisted_temp,{dt_last_seen},{dt_last_seen_values_persisted_temp},dt_last_seenValuesIndexKeyName);
EXPORT dt_last_seen_values_persisted := dt_last_seen_values_index;
SALT32.MAC_Field_Nulls(dt_last_seen_values_persisted,Layout_Specificities.dt_last_seen_ChildRec,nv) // Use automated NULL spotting
EXPORT dt_last_seen_nulls := nv;
SALT32.MAC_Field_Bfoul(dt_last_seen_deduped,dt_last_seen,DOTid,dt_last_seen_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT dt_last_seen_switch := bf;
EXPORT dt_last_seen_max := MAX(dt_last_seen_values_persisted,field_specificity);
SALT32.MAC_Field_Specificity(dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_nulls,ol) // Compute column level specificity
EXPORT dt_last_seen_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(corp_legal_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(active_enterprise_number_values_index, OVERWRITE),BUILDINDEX(active_domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(csz_values_index, OVERWRITE),BUILDINDEX(addr1_values_index, OVERWRITE),BUILDINDEX(address_values_index, OVERWRITE),BUILDINDEX(isContact_values_index, OVERWRITE),BUILDINDEX(fname_values_index, OVERWRITE),BUILDINDEX(mname_values_index, OVERWRITE),BUILDINDEX(lname_values_index, OVERWRITE),BUILDINDEX(name_suffix_values_index, OVERWRITE),BUILDINDEX(contact_ssn_values_index, OVERWRITE),BUILDINDEX(dt_first_seen_values_index, OVERWRITE),BUILDINDEX(dt_last_seen_values_index, OVERWRITE));
 
  infile := _attr_ck_charters;
  r := RECORD
    Config.AttrValueType Basis := TRIM((SALT32.StrType)infile.company_charter_number) + '|' + TRIM((SALT32.StrType)infile.company_inc_state);
    infile.company_charter_number; // Easy way to get component values
    INTEGER2 company_charter_number_weight100 := 0; // Easy place to store weight
    infile.company_inc_state; // Easy way to get component values
    INTEGER2 company_inc_state_weight100 := 0; // Easy place to store weight
    SALT32.UIDType DOTid := infile.dotid;
    UNSIGNED Basis_cnt := 0;
    INTEGER2 Basis_weight100 := 0;
  END;
  t := TABLE(infile,r);
SHARED ForeignCorpkey_attributes := DEDUP( SORT( DISTRIBUTE( t, DOTid ), DOTid, Basis, LOCAL), DOTid, Basis, LOCAL) : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::values::ForeignCorpkey',EXPIRE(Config.PersistExpire));
  SALT32.Mac_Specificity_Local(ForeignCorpkey_attributes,Basis,DOTid,ForeignCorpkey_nulls,Layout_Specificities.ForeignCorpkey_ChildRec,ForeignCorpkey_specificity,ForeignCorpkey_switch,ForeignCorpkey_values);
EXPORT ForeignCorpkey_max := MAX(ForeignCorpkey_values,field_specificity);
 
EXPORT ForeignCorpkeyValuesIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Word::ForeignCorpkey';
  TYPEOF(ForeignCorpkey_attributes) take(ForeignCorpkey_attributes le,ForeignCorpkey_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.Basis_cnt := ri.cnt;
    SELF.Basis_weight100 := ri.field_specificity*100;
    SELF.company_charter_number_weight100 := SELF.Basis_weight100 / 2;
    SELF.company_inc_state_weight100 := SELF.Basis_weight100 / 2;
    SELF := le;
  END;
  non_null_atts := ForeignCorpkey_attributes(Basis NOT IN SET(ForeignCorpkey_nulls,Basis));
SALT32.MAC_Choose_JoinType(non_null_atts,ForeignCorpkey_nulls,ForeignCorpkey_values,Basis,Basis_weight100,take,ForeignCorpkey_v);
 
EXPORT ForeignCorpkey_values_index := INDEX(ForeignCorpkey_v,{Basis},{ForeignCorpkey_v},ForeignCorpkeyValuesIndexKeyName);
EXPORT ForeignCorpkey_values_persisted := ForeignCorpkey_values_index;
 
EXPORT BuildAttributes := BUILDINDEX(ForeignCorpkey_values_index, OVERWRITE);
EXPORT BuildAll := PARALLEL(BuildFields, BuildAttributes);
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Specificities';
iSpecificities := DATASET([{0,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,corp_legal_name_specificity,corp_legal_name_switch,corp_legal_name_max,corp_legal_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,active_domestic_corp_key_specificity,active_domestic_corp_key_switch,active_domestic_corp_key_max,active_domestic_corp_key_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,st_specificity,st_switch,st_max,st_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,csz_specificity,csz_switch,csz_max,csz_nulls,addr1_specificity,addr1_switch,addr1_max,addr1_nulls,address_specificity,address_switch,address_max,address_nulls,isContact_specificity,isContact_switch,isContact_max,isContact_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,name_suffix_specificity,name_suffix_switch,name_suffix_max,name_suffix_nulls,contact_ssn_specificity,contact_ssn_switch,contact_ssn_max,contact_ssn_nulls,dt_first_seen_specificity,dt_first_seen_switch,dt_first_seen_max,dt_first_seen_nulls,dt_last_seen_specificity,dt_last_seen_switch,dt_last_seen_max,dt_last_seen_nulls,ForeignCorpkey_specificity,ForeignCorpkey_switch,ForeignCorpkey_max,ForeignCorpkey_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( BuildAll, BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 25);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 64);
  integer1 corp_legal_name_shift0 := ROUND(Specificities[1].corp_legal_name_specificity - 25);
  integer2 corp_legal_name_switch_shift0 := ROUND(1000*Specificities[1].corp_legal_name_switch - 69);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 14);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 0);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 25);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 27);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 18);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 24);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 12);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 27);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 0);
  integer1 active_domestic_corp_key_shift0 := ROUND(Specificities[1].active_domestic_corp_key_specificity - 27);
  integer2 active_domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].active_domestic_corp_key_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 3);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 8);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 4);
  integer1 csz_shift0 := ROUND(Specificities[1].csz_specificity - 14);
  integer2 csz_switch_shift0 := ROUND(1000*Specificities[1].csz_switch - 17);
  integer1 addr1_shift0 := ROUND(Specificities[1].addr1_specificity - 23);
  integer2 addr1_switch_shift0 := ROUND(1000*Specificities[1].addr1_switch - 64);
  integer1 address_shift0 := ROUND(Specificities[1].address_specificity - 25);
  integer2 address_switch_shift0 := ROUND(1000*Specificities[1].address_switch - 78);
  integer1 isContact_shift0 := ROUND(Specificities[1].isContact_specificity - 1);
  integer2 isContact_switch_shift0 := ROUND(1000*Specificities[1].isContact_switch - 0);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 9);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 20);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 10);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 6);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 11);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 28);
  integer1 name_suffix_shift0 := ROUND(Specificities[1].name_suffix_specificity - 9);
  integer2 name_suffix_switch_shift0 := ROUND(1000*Specificities[1].name_suffix_switch - 12);
  integer1 contact_ssn_shift0 := ROUND(Specificities[1].contact_ssn_specificity - 28);
  integer2 contact_ssn_switch_shift0 := ROUND(1000*Specificities[1].contact_ssn_switch - 34);
  integer1 dt_first_seen_shift0 := ROUND(Specificities[1].dt_first_seen_specificity - 0);
  integer2 dt_first_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_first_seen_switch - 0);
  integer1 dt_last_seen_shift0 := ROUND(Specificities[1].dt_last_seen_specificity - 0);
  integer2 dt_last_seen_switch_shift0 := ROUND(1000*Specificities[1].dt_last_seen_switch - 0);
  INTEGER1 ForeignCorpkey_shift0 := ROUND(Specificities[1].ForeignCorpkey_specificity - 26);
  INTEGER2 ForeignCorpkey_switch_shift0 := ROUND(1000*Specificities[1].ForeignCorpkey_switch - 42);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT32.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT32.MAC_Specificity_Values(corp_legal_name_values_persisted,corp_legal_name,'corp_legal_name',corp_legal_name_specificity,corp_legal_name_specificity_profile);
  SALT32.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT32.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
  SALT32.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT32.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT32.MAC_Specificity_Values(active_enterprise_number_values_persisted,active_enterprise_number,'active_enterprise_number',active_enterprise_number_specificity,active_enterprise_number_specificity_profile);
  SALT32.MAC_Specificity_Values(active_domestic_corp_key_values_persisted,active_domestic_corp_key,'active_domestic_corp_key',active_domestic_corp_key_specificity,active_domestic_corp_key_specificity_profile);
  SALT32.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT32.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT32.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT32.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT32.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT32.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT32.MAC_Specificity_Values(isContact_values_persisted,isContact,'isContact',isContact_specificity,isContact_specificity_profile);
  SALT32.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT32.MAC_Specificity_Values(mname_values_persisted,mname,'mname',mname_specificity,mname_specificity_profile);
  SALT32.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT32.MAC_Specificity_Values(name_suffix_values_persisted,name_suffix,'name_suffix',name_suffix_specificity,name_suffix_specificity_profile);
  SALT32.MAC_Specificity_Values(contact_ssn_values_persisted,contact_ssn,'contact_ssn',contact_ssn_specificity,contact_ssn_specificity_profile);
EXPORT AllProfiles := cnp_name_specificity_profile + corp_legal_name_specificity_profile + cnp_number_specificity_profile + cnp_btype_specificity_profile + company_fein_specificity_profile + active_duns_number_specificity_profile + active_enterprise_number_specificity_profile + active_domestic_corp_key_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + sec_range_specificity_profile + st_specificity_profile + v_city_name_specificity_profile + zip_specificity_profile + isContact_specificity_profile + fname_specificity_profile + mname_specificity_profile + lname_specificity_profile + name_suffix_specificity_profile + contact_ssn_specificity_profile;
END;
 
