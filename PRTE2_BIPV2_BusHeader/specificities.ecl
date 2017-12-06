IMPORT BizLinkFull,SALT37;
EXPORT specificities(DATASET(BizLinkFull.layout_BizHead) ih) := MODULE
 
EXPORT ih_init := SALT37.initNullIDs.baseLevel(ih,rcid,proxid);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT37.UIDType proxid := h.proxid; // using existing id field
  SALT37.UIDType seleid := h.seleid; // Copy ID from hierarchy
  SALT37.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT37.UIDType ultid := h.ultid; // Copy ID from hierarchy
  SALT37.UIDType powid := h.powid; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  h.parent_proxid;
  h.sele_proxid;
  h.org_proxid;
  h.ultimate_proxid;
  h.has_lgid;
  h.empid;
  h.source;
  h.source_record_id;
  h.source_docid;
  TYPEOF(h.company_name) company_name := (TYPEOF(h.company_name))BizLinkFull.Fields.Make_company_name((SALT37.StrType)h.company_name ); // Cleans before using
  TYPEOF(h.company_name_prefix) company_name_prefix := (TYPEOF(h.company_name_prefix))BizLinkFull.Fields.Make_company_name_prefix((SALT37.StrType)h.company_name_prefix ); // Cleans before using
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT37.StrType)h.cnp_name ); // Cleans before using
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.company_phone;
  h.company_phone_3;
  h.company_phone_3_ex;
  h.company_phone_7;
  TYPEOF(h.company_fein) company_fein := if ( BizLinkFull.Fields.Invalid_company_fein(h.company_fein)=0,h.company_fein,(TYPEOF(h.company_fein))'' ); // Blanks if invalid
  UNSIGNED1 company_fein_len := LENGTH(TRIM((SALT37.StrType)h.company_fein));
  h.company_sic_code1;
  h.active_duns_number;
  h.prim_range;
  UNSIGNED1 prim_range_len := LENGTH(TRIM((SALT37.StrType)h.prim_range));
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))BizLinkFull.Fields.Make_prim_name((SALT37.StrType)h.prim_name ); // Cleans before using
  UNSIGNED1 prim_name_len := LENGTH(TRIM((SALT37.StrType)h.prim_name));
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))BizLinkFull.Fields.Make_sec_range((SALT37.StrType)h.sec_range ); // Cleans before using
  UNSIGNED1 sec_range_len := LENGTH(TRIM((SALT37.StrType)h.sec_range));
  TYPEOF(h.city) city := (TYPEOF(h.city))BizLinkFull.Fields.Make_city((SALT37.StrType)h.city ); // Cleans before using
  UNSIGNED1 city_len := LENGTH(TRIM((SALT37.StrType)h.city));
  TYPEOF(h.city_clean) city_clean := (TYPEOF(h.city_clean))BizLinkFull.Fields.Make_city_clean((SALT37.StrType)h.city_clean ); // Cleans before using
  TYPEOF(h.st) st := (TYPEOF(h.st))BizLinkFull.Fields.Make_st((SALT37.StrType)h.st ); // Cleans before using
  TYPEOF(h.zip) zip := (TYPEOF(h.zip))BizLinkFull.Fields.Make_zip((SALT37.StrType)h.zip ); // Cleans before using
  TYPEOF(h.company_url) company_url := (TYPEOF(h.company_url))BizLinkFull.Fields.Make_company_url((SALT37.StrType)h.company_url ); // Cleans before using
  h.isContact;
  h.contact_did;
  h.title;
  TYPEOF(h.fname) fname := (TYPEOF(h.fname))BizLinkFull.Fields.Make_fname((SALT37.StrType)h.fname ); // Cleans before using
  UNSIGNED1 fname_len := LENGTH(TRIM((SALT37.StrType)h.fname));
  TYPEOF(h.fname_preferred) fname_preferred := (TYPEOF(h.fname_preferred))BizLinkFull.Fields.Make_fname_preferred((SALT37.StrType)h.fname_preferred ); // Cleans before using
  TYPEOF(h.mname) mname := (TYPEOF(h.mname))BizLinkFull.Fields.Make_mname((SALT37.StrType)h.mname ); // Cleans before using
  UNSIGNED1 mname_len := LENGTH(TRIM((SALT37.StrType)h.mname));
  TYPEOF(h.lname) lname := (TYPEOF(h.lname))BizLinkFull.Fields.Make_lname((SALT37.StrType)h.lname ); // Cleans before using
  UNSIGNED1 lname_len := LENGTH(TRIM((SALT37.StrType)h.lname));
  TYPEOF(h.name_suffix) name_suffix := (TYPEOF(h.name_suffix))BizLinkFull.Fields.Make_name_suffix((SALT37.StrType)h.name_suffix ); // Cleans before using
  h.contact_ssn;
  TYPEOF(h.contact_email) contact_email := (TYPEOF(h.contact_email))BizLinkFull.Fields.Make_contact_email((SALT37.StrType)h.contact_email ); // Cleans before using
  h.sele_flag;
  h.org_flag;
  h.ult_flag;
  h.fallback_value;
  UNSIGNED4 CONTACTNAME := 0; // Place holder filled in by project
  UNSIGNED4 STREETADDRESS := 0; // Place holder filled in by project
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(proxid<>0),r),HASH(proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.CONTACTNAME := IF (BizLinkFull.Fields.InValid_CONTACTNAME((SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname)>0,0,HASH32((SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname)); // Combine child fields into 1 for specificity counting
  SELF.STREETADDRESS := IF (BizLinkFull.Fields.InValid_STREETADDRESS((SALT37.StrType)le.prim_range,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.sec_range)>0,0,HASH32((SALT37.StrType)le.prim_range,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~prte::temp::proxid::BizLinkFull::Specificities_Cache',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
//We have proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,proxid,LOCAL) : PERSIST('~prte::temp::proxid::BizLinkFull::Cluster_Sizes',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  parent_proxid_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,parent_proxid) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::parent_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(parent_proxid_deduped,parent_proxid,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT parent_proxid_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::parent_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  sele_proxid_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,sele_proxid) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::sele_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(sele_proxid_deduped,sele_proxid,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sele_proxid_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::sele_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  org_proxid_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,org_proxid) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::org_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(org_proxid_deduped,org_proxid,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT org_proxid_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::org_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  ultimate_proxid_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,ultimate_proxid) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::ultimate_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ultimate_proxid_deduped,ultimate_proxid,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ultimate_proxid_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::ultimate_proxid',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  source_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,source) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::source',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(source_deduped,source,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT source_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::source',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  source_record_id_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,source_record_id) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::source_record_id',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(source_record_id_deduped,source_record_id,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT source_record_id_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::source_record_id',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_name_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_name) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_name',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_name_deduped,company_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_name_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_name',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_name_prefix_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_name_prefix) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_name_prefix',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_name_prefix_deduped,company_name_prefix,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_name_prefix_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_name_prefix',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  cnp_name_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,cnp_name) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::cnp_name',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.MAC_Field_Initial_Specificities(specs_added,cnp_name,initial_specs_added) // add initial char specificities
SHARED cnp_name_sa := initial_specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT37.MAC_Field_Variants_WordBag(cnp_name_deduped,proxid,cnp_name,expanded)// expand out all variants of wordbag
  SALT37.Mac_Field_Count_UID(expanded,cnp_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT37.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED cnp_name_ad := wb_specs_added; // Hop over export
 
EXPORT cnp_nameValuesKeyName := BizLinkFull.Filename_keys.cnp_name; /*HACK07cnp_name*/
 
EXPORT cnp_name_values_key := INDEX(cnp_name_ad,{cnp_name},{cnp_name_ad},cnp_nameValuesKeyName);
  SALT37.mac_wordbag_addweights(cnp_name_sa,cnp_name,cnp_name_ad,p);
EXPORT cnp_name_values_persisted := p;
 
EXPORT  cnp_number_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,cnp_number) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::cnp_number',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::cnp_number',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  cnp_btype_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,cnp_btype) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::cnp_btype',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_btype_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::cnp_btype',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  cnp_lowv_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,cnp_lowv) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::cnp_lowv',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(cnp_lowv_deduped,cnp_lowv,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_lowv_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::cnp_lowv',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_phone_3_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_phone_3) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_phone_3',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_phone_3_deduped,company_phone_3,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_phone_3_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_phone_3',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_phone_3_ex_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_phone_3_ex) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_phone_3_ex',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_phone_3_ex_deduped,company_phone_3_ex,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_phone_3_ex_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_phone_3_ex',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_phone_7_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_phone_7) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_phone_7',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_phone_7_deduped,company_phone_7,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_phone_7_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_phone_7',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_fein_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_fein) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_fein',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_fein_deduped,company_fein,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_fein_values_persisted := distance_computed : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_fein',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_sic_code1_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_sic_code1) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_sic_code1',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_sic_code1_deduped,company_sic_code1,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_sic_code1_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::company_sic_code1',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  prim_range_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,prim_range) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::prim_range',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(prim_range_deduped,prim_range,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,prim_range,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT prim_range_values_persisted := distance_computed : PERSIST('~prte::temp::proxid::BizLinkFull::values::prim_range',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  prim_name_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,prim_name) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::prim_name',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(prim_name_deduped,prim_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,prim_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT prim_name_values_persisted := distance_computed : PERSIST('~prte::temp::proxid::BizLinkFull::values::prim_name',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  sec_range_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,sec_range) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::sec_range',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(sec_range_deduped,sec_range,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,sec_range,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT sec_range_values_persisted := distance_computed : PERSIST('~prte::temp::proxid::BizLinkFull::values::sec_range',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  city_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,city) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::city',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(city_deduped,city,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,city,cnt,2,true,distance_computed);//Computes specificities of fuzzy matches
EXPORT city_values_persisted := distance_computed : PERSIST('~prte::temp::proxid::BizLinkFull::values::city',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  city_clean_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,city_clean) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::city_clean',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(city_clean_deduped,city_clean,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT city_clean_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::city_clean',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  st_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,st) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::st',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(st_deduped,st,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::st',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  zip_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,zip) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::zip',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(zip_deduped,zip,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::zip',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  company_url_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,company_url) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::company_url',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(company_url_deduped,company_url,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED company_url_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT37.MAC_Field_Variants_WordBag(company_url_deduped,proxid,company_url,expanded)// expand out all variants of wordbag
  SALT37.Mac_Field_Count_UID(expanded,company_url,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT37.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED company_url_ad := wb_specs_added; // Hop over export
 
EXPORT company_urlValuesKeyName := BizLinkFull.Filename_keys.company_url; /*HACK07company_url*/
 
EXPORT company_url_values_key := INDEX(company_url_ad,{company_url},{company_url_ad},company_urlValuesKeyName);
  SALT37.mac_wordbag_addweights(company_url_sa,company_url,company_url_ad,p);
EXPORT company_url_values_persisted := p;
 
EXPORT  isContact_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,isContact) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::isContact',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(isContact_deduped,isContact,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT isContact_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::isContact',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  contact_did_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,contact_did) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::contact_did',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(contact_did_deduped,contact_did,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_did_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::contact_did',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  title_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,title) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::title',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(title_deduped,title,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT title_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::title',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  fname_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,fname) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::fname',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(fname_deduped,proxid,fname,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,fname,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,fname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,fname,initial_specs_added) // add initial char specificities
EXPORT fname_values_persisted := initial_specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::fname',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  fname_preferred_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,fname_preferred) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::fname_preferred',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(fname_preferred_deduped,fname_preferred,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fname_preferred_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::fname_preferred',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  mname_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,mname) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::mname',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.MAC_Field_Variants_Initials(mname_deduped,proxid,mname,expanded) // expand out all variants of initial
  SALT37.Mac_Field_Count_UID(expanded,mname,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,mname,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,mname,initial_specs_added) // add initial char specificities
EXPORT mname_values_persisted := initial_specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::mname',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  lname_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,lname) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::lname',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(lname_deduped,proxid,lname,2); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,lname,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,lname,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT37.MAC_Field_Initial_Specificities(distance_computed,lname,initial_specs_added) // add initial char specificities
EXPORT lname_values_persisted := initial_specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::lname',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  name_suffix_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,name_suffix) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::name_suffix',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(name_suffix_deduped,name_suffix,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING5 name_suffix_NormSuffix := BizLinkFull.fn_normSuffix(counted.name_suffix); // Compute fn_normSuffix value for name_suffix
  end;
  with_id := table(counted,r1);
  SALT37.MAC_Field_Accumulate_Counts(with_id,name_suffix_NormSuffix,NormSuffix_cnt,fuzzies_counted0)
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT name_suffix_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::name_suffix',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  contact_ssn_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,contact_ssn) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::contact_ssn',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(contact_ssn_deduped,contact_ssn,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_ssn_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::contact_ssn',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  contact_email_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,contact_email) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::contact_email',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(contact_email_deduped,contact_email,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_email_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::contact_email',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  sele_flag_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,sele_flag) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::sele_flag',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(sele_flag_deduped,sele_flag,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sele_flag_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::sele_flag',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  org_flag_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,org_flag) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::org_flag',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(org_flag_deduped,org_flag,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT org_flag_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::org_flag',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  ult_flag_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,ult_flag) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::ult_flag',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(ult_flag_deduped,ult_flag,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ult_flag_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::ult_flag',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  fallback_value_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,fallback_value) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::fallback_value',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(fallback_value_deduped,fallback_value,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fallback_value_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::fallback_value',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  CONTACTNAME_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,CONTACTNAME) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::CONTACTNAME',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(CONTACTNAME_deduped,CONTACTNAME,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CONTACTNAME_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::CONTACTNAME',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT  STREETADDRESS_deduped := SALT37.MAC_Field_By_UID(input_file,proxid,STREETADDRESS) : PERSIST('~prte::temp::proxid::BizLinkFull::dedups::STREETADDRESS',EXPIRE(BizLinkFull.Config_BIP.PersistExpire)); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(STREETADDRESS_deduped,STREETADDRESS,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT STREETADDRESS_values_persisted := specs_added : PERSIST('~prte::temp::proxid::BizLinkFull::values::STREETADDRESS',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
 
EXPORT BuildBOWFields := PARALLEL(BUILDINDEX(cnp_name_values_key, OVERWRITE),BUILDINDEX(company_url_values_key, OVERWRITE));
SALT37.MAC_Field_Nulls(parent_proxid_values_persisted,BizLinkFull.Layout_Specificities.parent_proxid_ChildRec,nv) // Use automated NULL spotting
EXPORT parent_proxid_nulls := nv;
SALT37.MAC_Field_Bfoul(parent_proxid_deduped,parent_proxid,proxid,parent_proxid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT parent_proxid_switch := bf;
EXPORT parent_proxid_max := MAX(parent_proxid_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(parent_proxid_values_persisted,parent_proxid,parent_proxid_nulls,ol) // Compute column level specificity
EXPORT parent_proxid_specificity := ol;
SALT37.MAC_Field_Nulls(sele_proxid_values_persisted,BizLinkFull.Layout_Specificities.sele_proxid_ChildRec,nv) // Use automated NULL spotting
EXPORT sele_proxid_nulls := nv;
SALT37.MAC_Field_Bfoul(sele_proxid_deduped,sele_proxid,proxid,sele_proxid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sele_proxid_switch := bf;
EXPORT sele_proxid_max := MAX(sele_proxid_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(sele_proxid_values_persisted,sele_proxid,sele_proxid_nulls,ol) // Compute column level specificity
EXPORT sele_proxid_specificity := ol;
SALT37.MAC_Field_Nulls(org_proxid_values_persisted,BizLinkFull.Layout_Specificities.org_proxid_ChildRec,nv) // Use automated NULL spotting
EXPORT org_proxid_nulls := nv;
SALT37.MAC_Field_Bfoul(org_proxid_deduped,org_proxid,proxid,org_proxid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT org_proxid_switch := bf;
EXPORT org_proxid_max := MAX(org_proxid_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(org_proxid_values_persisted,org_proxid,org_proxid_nulls,ol) // Compute column level specificity
EXPORT org_proxid_specificity := ol;
SALT37.MAC_Field_Nulls(ultimate_proxid_values_persisted,BizLinkFull.Layout_Specificities.ultimate_proxid_ChildRec,nv) // Use automated NULL spotting
EXPORT ultimate_proxid_nulls := nv;
SALT37.MAC_Field_Bfoul(ultimate_proxid_deduped,ultimate_proxid,proxid,ultimate_proxid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ultimate_proxid_switch := bf;
EXPORT ultimate_proxid_max := MAX(ultimate_proxid_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ultimate_proxid_values_persisted,ultimate_proxid,ultimate_proxid_nulls,ol) // Compute column level specificity
EXPORT ultimate_proxid_specificity := ol;
SALT37.MAC_Field_Nulls(source_values_persisted,BizLinkFull.Layout_Specificities.source_ChildRec,nv) // Use automated NULL spotting
EXPORT source_nulls := nv;
SALT37.MAC_Field_Bfoul(source_deduped,source,proxid,source_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT source_switch := bf;
EXPORT source_max := MAX(source_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(source_values_persisted,source,source_nulls,ol) // Compute column level specificity
EXPORT source_specificity := ol;
SALT37.MAC_Field_Nulls(source_record_id_values_persisted,BizLinkFull.Layout_Specificities.source_record_id_ChildRec,nv) // Use automated NULL spotting
EXPORT source_record_id_nulls := nv;
SALT37.MAC_Field_Bfoul(source_record_id_deduped,source_record_id,proxid,source_record_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT source_record_id_switch := bf;
EXPORT source_record_id_max := MAX(source_record_id_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(source_record_id_values_persisted,source_record_id,source_record_id_nulls,ol) // Compute column level specificity
EXPORT source_record_id_specificity := ol;
SALT37.MAC_Field_Nulls(company_name_values_persisted,BizLinkFull.Layout_Specificities.company_name_ChildRec,nv) // Use automated NULL spotting
EXPORT company_name_nulls := nv;
SALT37.MAC_Field_Bfoul(company_name_deduped,company_name,proxid,company_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_switch := bf;
EXPORT company_name_max := MAX(company_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_name_values_persisted,company_name,company_name_nulls,ol) // Compute column level specificity
EXPORT company_name_specificity := ol;
SALT37.MAC_Field_Nulls(company_name_prefix_values_persisted,BizLinkFull.Layout_Specificities.company_name_prefix_ChildRec,nv) // Use automated NULL spotting
EXPORT company_name_prefix_nulls := nv;
SALT37.MAC_Field_Bfoul(company_name_prefix_deduped,company_name_prefix,proxid,company_name_prefix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_name_prefix_switch := bf;
EXPORT company_name_prefix_max := MAX(company_name_prefix_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_name_prefix_values_persisted,company_name_prefix,company_name_prefix_nulls,ol) // Compute column level specificity
EXPORT company_name_prefix_specificity := ol;
EXPORT cnp_name_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.cnp_name_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,proxid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
SALT37.MAC_Field_Nulls(cnp_number_values_persisted,BizLinkFull.Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT37.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,proxid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
SALT37.MAC_Field_Nulls(cnp_lowv_values_persisted,BizLinkFull.Layout_Specificities.cnp_lowv_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_lowv_nulls := nv;
SALT37.MAC_Field_Bfoul(cnp_lowv_deduped,cnp_lowv,proxid,cnp_lowv_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_lowv_switch := bf;
EXPORT cnp_lowv_max := MAX(cnp_lowv_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(cnp_lowv_values_persisted,cnp_lowv,cnp_lowv_nulls,ol) // Compute column level specificity
EXPORT cnp_lowv_specificity := ol;
SALT37.MAC_Field_Nulls(company_phone_3_values_persisted,BizLinkFull.Layout_Specificities.company_phone_3_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_3_nulls := nv;
SALT37.MAC_Field_Bfoul(company_phone_3_deduped,company_phone_3,proxid,company_phone_3_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_3_switch := bf;
EXPORT company_phone_3_max := MAX(company_phone_3_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_phone_3_values_persisted,company_phone_3,company_phone_3_nulls,ol) // Compute column level specificity
EXPORT company_phone_3_specificity := ol;
SALT37.MAC_Field_Nulls(company_phone_3_ex_values_persisted,BizLinkFull.Layout_Specificities.company_phone_3_ex_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_3_ex_nulls := nv;
SALT37.MAC_Field_Bfoul(company_phone_3_ex_deduped,company_phone_3_ex,proxid,company_phone_3_ex_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_3_ex_switch := bf;
EXPORT company_phone_3_ex_max := MAX(company_phone_3_ex_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_phone_3_ex_values_persisted,company_phone_3_ex,company_phone_3_ex_nulls,ol) // Compute column level specificity
EXPORT company_phone_3_ex_specificity := ol;
SALT37.MAC_Field_Nulls(company_phone_7_values_persisted,BizLinkFull.Layout_Specificities.company_phone_7_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_7_nulls := nv;
SALT37.MAC_Field_Bfoul(company_phone_7_deduped,company_phone_7,proxid,company_phone_7_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_7_switch := bf;
EXPORT company_phone_7_max := MAX(company_phone_7_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_phone_7_values_persisted,company_phone_7,company_phone_7_nulls,ol) // Compute column level specificity
EXPORT company_phone_7_specificity := ol;
SALT37.MAC_Field_Nulls(company_fein_values_persisted,BizLinkFull.Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT37.MAC_Field_Bfoul(company_fein_deduped,company_fein,proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
SALT37.MAC_Field_Nulls(company_sic_code1_values_persisted,BizLinkFull.Layout_Specificities.company_sic_code1_ChildRec,nv) // Use automated NULL spotting
EXPORT company_sic_code1_nulls := nv;
SALT37.MAC_Field_Bfoul(company_sic_code1_deduped,company_sic_code1,proxid,company_sic_code1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_sic_code1_switch := bf;
EXPORT company_sic_code1_max := MAX(company_sic_code1_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_sic_code1_values_persisted,company_sic_code1,company_sic_code1_nulls,ol) // Compute column level specificity
EXPORT company_sic_code1_specificity := ol;
SALT37.MAC_Field_Nulls(prim_range_values_persisted,BizLinkFull.Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT37.MAC_Field_Bfoul(prim_range_deduped,prim_range,proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
SALT37.MAC_Field_Nulls(prim_name_values_persisted,BizLinkFull.Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT37.MAC_Field_Bfoul(prim_name_deduped,prim_name,proxid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
SALT37.MAC_Field_Nulls(sec_range_values_persisted,BizLinkFull.Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT37.MAC_Field_Bfoul(sec_range_deduped,sec_range,proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
SALT37.MAC_Field_Nulls(city_values_persisted,BizLinkFull.Layout_Specificities.city_ChildRec,nv) // Use automated NULL spotting
EXPORT city_nulls := nv;
SALT37.MAC_Field_Bfoul(city_deduped,city,proxid,city_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT city_switch := bf;
EXPORT city_max := MAX(city_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(city_values_persisted,city,city_nulls,ol) // Compute column level specificity
EXPORT city_specificity := ol;
SALT37.MAC_Field_Nulls(city_clean_values_persisted,BizLinkFull.Layout_Specificities.city_clean_ChildRec,nv) // Use automated NULL spotting
EXPORT city_clean_nulls := nv;
SALT37.MAC_Field_Bfoul(city_clean_deduped,city_clean,proxid,city_clean_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT city_clean_switch := bf;
EXPORT city_clean_max := MAX(city_clean_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(city_clean_values_persisted,city_clean,city_clean_nulls,ol) // Compute column level specificity
EXPORT city_clean_specificity := ol;
SALT37.MAC_Field_Nulls(st_values_persisted,BizLinkFull.Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT37.MAC_Field_Bfoul(st_deduped,st,proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
SALT37.MAC_Field_Nulls(zip_values_persisted,BizLinkFull.Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT37.MAC_Field_Bfoul(zip_deduped,zip,proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
EXPORT company_url_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.company_url_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(company_url_deduped,company_url,proxid,company_url_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_url_switch := bf;
EXPORT company_url_max := MAX(company_url_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(company_url_values_persisted,company_url,company_url_nulls,ol) // Compute column level specificity
EXPORT company_url_specificity := ol;
EXPORT isContact_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.isContact_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(isContact_deduped,isContact,proxid,isContact_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT isContact_switch := bf;
EXPORT isContact_max := MAX(isContact_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(isContact_values_persisted,isContact,isContact_nulls,ol) // Compute column level specificity
EXPORT isContact_specificity := ol;
SALT37.MAC_Field_Nulls(contact_did_values_persisted,BizLinkFull.Layout_Specificities.contact_did_ChildRec,nv) // Use automated NULL spotting
//EXPORT contact_did_nulls := nv;
EXPORT contact_did_nulls := dataset([],recordof(nv));
SALT37.MAC_Field_Bfoul(contact_did_deduped,contact_did,proxid,contact_did_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_did_switch := bf;
EXPORT contact_did_max := MAX(contact_did_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(contact_did_values_persisted,contact_did,contact_did_nulls,ol) // Compute column level specificity
EXPORT contact_did_specificity := ol;
EXPORT title_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.title_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(title_deduped,title,proxid,title_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT title_switch := bf;
EXPORT title_max := MAX(title_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(title_values_persisted,title,title_nulls,ol) // Compute column level specificity
EXPORT title_specificity := ol;
EXPORT fname_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(fname_deduped,fname,proxid,fname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
SALT37.MAC_Field_Nulls(fname_preferred_values_persisted,BizLinkFull.Layout_Specificities.fname_preferred_ChildRec,nv) // Use automated NULL spotting
EXPORT fname_preferred_nulls := nv;
SALT37.MAC_Field_Bfoul(fname_preferred_deduped,fname_preferred,proxid,fname_preferred_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_preferred_switch := bf;
EXPORT fname_preferred_max := MAX(fname_preferred_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(fname_preferred_values_persisted,fname_preferred,fname_preferred_nulls,ol) // Compute column level specificity
EXPORT fname_preferred_specificity := ol;
EXPORT mname_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.mname_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(mname_deduped,mname,proxid,mname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mname_switch := bf;
EXPORT mname_max := MAX(mname_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
EXPORT mname_specificity := ol;
EXPORT lname_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.lname_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(lname_deduped,lname,proxid,lname_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
SALT37.MAC_Field_Nulls(name_suffix_values_persisted,BizLinkFull.Layout_Specificities.name_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT name_suffix_nulls := nv;
SALT37.MAC_Field_Bfoul(name_suffix_deduped,name_suffix,proxid,name_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_suffix_switch := bf;
EXPORT name_suffix_max := MAX(name_suffix_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(name_suffix_values_persisted,name_suffix,name_suffix_nulls,ol) // Compute column level specificity
EXPORT name_suffix_specificity := ol;
SALT37.MAC_Field_Nulls(contact_ssn_values_persisted,BizLinkFull.Layout_Specificities.contact_ssn_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_ssn_nulls := nv;
SALT37.MAC_Field_Bfoul(contact_ssn_deduped,contact_ssn,proxid,contact_ssn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_ssn_switch := bf;
EXPORT contact_ssn_max := MAX(contact_ssn_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(contact_ssn_values_persisted,contact_ssn,contact_ssn_nulls,ol) // Compute column level specificity
EXPORT contact_ssn_specificity := ol;
SALT37.MAC_Field_Nulls(contact_email_values_persisted,BizLinkFull.Layout_Specificities.contact_email_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_email_nulls := nv;
SALT37.MAC_Field_Bfoul(contact_email_deduped,contact_email,proxid,contact_email_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_email_switch := bf;
EXPORT contact_email_max := MAX(contact_email_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(contact_email_values_persisted,contact_email,contact_email_nulls,ol) // Compute column level specificity
EXPORT contact_email_specificity := ol;
SALT37.MAC_Field_Nulls(sele_flag_values_persisted,BizLinkFull.Layout_Specificities.sele_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT sele_flag_nulls := nv;
SALT37.MAC_Field_Bfoul(sele_flag_deduped,sele_flag,proxid,sele_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sele_flag_switch := bf;
EXPORT sele_flag_max := MAX(sele_flag_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(sele_flag_values_persisted,sele_flag,sele_flag_nulls,ol) // Compute column level specificity
EXPORT sele_flag_specificity := ol;
SALT37.MAC_Field_Nulls(org_flag_values_persisted,BizLinkFull.Layout_Specificities.org_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT org_flag_nulls := nv;
SALT37.MAC_Field_Bfoul(org_flag_deduped,org_flag,proxid,org_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT org_flag_switch := bf;
EXPORT org_flag_max := MAX(org_flag_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(org_flag_values_persisted,org_flag,org_flag_nulls,ol) // Compute column level specificity
EXPORT org_flag_specificity := ol;
SALT37.MAC_Field_Nulls(ult_flag_values_persisted,BizLinkFull.Layout_Specificities.ult_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT ult_flag_nulls := nv;
SALT37.MAC_Field_Bfoul(ult_flag_deduped,ult_flag,proxid,ult_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ult_flag_switch := bf;
EXPORT ult_flag_max := MAX(ult_flag_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(ult_flag_values_persisted,ult_flag,ult_flag_nulls,ol) // Compute column level specificity
EXPORT ult_flag_specificity := ol;
EXPORT fallback_value_nulls := DATASET([{'',0,0}],BizLinkFull.Layout_Specificities.fallback_value_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(fallback_value_deduped,fallback_value,proxid,fallback_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fallback_value_switch := bf;
EXPORT fallback_value_max := MAX(fallback_value_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(fallback_value_values_persisted,fallback_value,fallback_value_nulls,ol) // Compute column level specificity
EXPORT fallback_value_specificity := ol;
SALT37.MAC_Field_Nulls(CONTACTNAME_values_persisted,BizLinkFull.Layout_Specificities.CONTACTNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT CONTACTNAME_nulls := nv;
SALT37.MAC_Field_Bfoul(CONTACTNAME_deduped,CONTACTNAME,proxid,CONTACTNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CONTACTNAME_switch := bf;
EXPORT CONTACTNAME_max := MAX(CONTACTNAME_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(CONTACTNAME_values_persisted,CONTACTNAME,CONTACTNAME_nulls,ol) // Compute column level specificity
EXPORT CONTACTNAME_specificity := ol;
SALT37.MAC_Field_Nulls(STREETADDRESS_values_persisted,BizLinkFull.Layout_Specificities.STREETADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT STREETADDRESS_nulls := nv;
SALT37.MAC_Field_Bfoul(STREETADDRESS_deduped,STREETADDRESS,proxid,STREETADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT STREETADDRESS_switch := bf;
EXPORT STREETADDRESS_max := MAX(STREETADDRESS_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(STREETADDRESS_values_persisted,STREETADDRESS,STREETADDRESS_nulls,ol) // Compute column level specificity
EXPORT STREETADDRESS_specificity := ol;
iSpecificities := DATASET([{0,parent_proxid_specificity,parent_proxid_switch,parent_proxid_max,parent_proxid_nulls,sele_proxid_specificity,sele_proxid_switch,sele_proxid_max,sele_proxid_nulls,org_proxid_specificity,org_proxid_switch,org_proxid_max,org_proxid_nulls,ultimate_proxid_specificity,ultimate_proxid_switch,ultimate_proxid_max,ultimate_proxid_nulls,source_specificity,source_switch,source_max,source_nulls,source_record_id_specificity,source_record_id_switch,source_record_id_max,source_record_id_nulls,company_name_specificity,company_name_switch,company_name_max,company_name_nulls,company_name_prefix_specificity,company_name_prefix_switch,company_name_prefix_max,company_name_prefix_nulls,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,cnp_lowv_specificity,cnp_lowv_switch,cnp_lowv_max,cnp_lowv_nulls,company_phone_3_specificity,company_phone_3_switch,company_phone_3_max,company_phone_3_nulls,company_phone_3_ex_specificity,company_phone_3_ex_switch,company_phone_3_ex_max,company_phone_3_ex_nulls,company_phone_7_specificity,company_phone_7_switch,company_phone_7_max,company_phone_7_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_sic_code1_specificity,company_sic_code1_switch,company_sic_code1_max,company_sic_code1_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,city_specificity,city_switch,city_max,city_nulls,city_clean_specificity,city_clean_switch,city_clean_max,city_clean_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,company_url_specificity,company_url_switch,company_url_max,company_url_nulls,isContact_specificity,isContact_switch,isContact_max,isContact_nulls,contact_did_specificity,contact_did_switch,contact_did_max,contact_did_nulls,title_specificity,title_switch,title_max,title_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,fname_preferred_specificity,fname_preferred_switch,fname_preferred_max,fname_preferred_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,name_suffix_specificity,name_suffix_switch,name_suffix_max,name_suffix_nulls,contact_ssn_specificity,contact_ssn_switch,contact_ssn_max,contact_ssn_nulls,contact_email_specificity,contact_email_switch,contact_email_max,contact_email_nulls,sele_flag_specificity,sele_flag_switch,sele_flag_max,sele_flag_nulls,org_flag_specificity,org_flag_switch,org_flag_max,org_flag_nulls,ult_flag_specificity,ult_flag_switch,ult_flag_max,ult_flag_nulls,fallback_value_specificity,fallback_value_switch,fallback_value_max,fallback_value_nulls,CONTACTNAME_specificity,CONTACTNAME_switch,CONTACTNAME_max,CONTACTNAME_nulls,STREETADDRESS_specificity,STREETADDRESS_switch,STREETADDRESS_max,STREETADDRESS_nulls}],BizLinkFull.Layout_Specificities.R) : PERSIST('~prte::temp::proxid::BizLinkFull::Specificities',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 parent_proxid_shift0 := ROUND(Specificities[1].parent_proxid_specificity - 28);
  integer2 parent_proxid_switch_shift0 := ROUND(1000*Specificities[1].parent_proxid_switch - 0);
  integer1 sele_proxid_shift0 := ROUND(Specificities[1].sele_proxid_specificity - 28);
  integer2 sele_proxid_switch_shift0 := ROUND(1000*Specificities[1].sele_proxid_switch - 0);
  integer1 org_proxid_shift0 := ROUND(Specificities[1].org_proxid_specificity - 28);
  integer2 org_proxid_switch_shift0 := ROUND(1000*Specificities[1].org_proxid_switch - 0);
  integer1 ultimate_proxid_shift0 := ROUND(Specificities[1].ultimate_proxid_specificity - 28);
  integer2 ultimate_proxid_switch_shift0 := ROUND(1000*Specificities[1].ultimate_proxid_switch - 0);
  integer1 source_shift0 := ROUND(Specificities[1].source_specificity - 4);
  integer2 source_switch_shift0 := ROUND(1000*Specificities[1].source_switch - 514);
  integer1 source_record_id_shift0 := ROUND(Specificities[1].source_record_id_specificity - 27);
  integer2 source_record_id_switch_shift0 := ROUND(1000*Specificities[1].source_record_id_switch - 756);
  integer1 company_name_shift0 := ROUND(Specificities[1].company_name_specificity - 25);
  integer2 company_name_switch_shift0 := ROUND(1000*Specificities[1].company_name_switch - 249);
  integer1 company_name_prefix_shift0 := ROUND(Specificities[1].company_name_prefix_specificity - 14);
  integer2 company_name_prefix_switch_shift0 := ROUND(1000*Specificities[1].company_name_prefix_switch - 85);
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 25);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 167);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 13);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 4);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 42);
  integer1 cnp_lowv_shift0 := ROUND(Specificities[1].cnp_lowv_specificity - 5);
  integer2 cnp_lowv_switch_shift0 := ROUND(1000*Specificities[1].cnp_lowv_switch - 38);
  integer1 company_phone_3_shift0 := ROUND(Specificities[1].company_phone_3_specificity - 9);
  integer2 company_phone_3_switch_shift0 := ROUND(1000*Specificities[1].company_phone_3_switch - 48);
  integer1 company_phone_3_ex_shift0 := ROUND(Specificities[1].company_phone_3_ex_specificity - 9);
  integer2 company_phone_3_ex_switch_shift0 := ROUND(1000*Specificities[1].company_phone_3_ex_switch - 48);
  integer1 company_phone_7_shift0 := ROUND(Specificities[1].company_phone_7_specificity - 23);
  integer2 company_phone_7_switch_shift0 := ROUND(1000*Specificities[1].company_phone_7_switch - 202);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 25);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 59);
  integer1 company_sic_code1_shift0 := ROUND(Specificities[1].company_sic_code1_specificity - 10);
  integer2 company_sic_code1_switch_shift0 := ROUND(1000*Specificities[1].company_sic_code1_switch - 273);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 14);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 112);
  integer1 city_shift0 := ROUND(Specificities[1].city_specificity - 11);
  integer2 city_switch_shift0 := ROUND(1000*Specificities[1].city_switch - 53);
  integer1 city_clean_shift0 := ROUND(Specificities[1].city_clean_specificity - 11);
  integer2 city_clean_switch_shift0 := ROUND(1000*Specificities[1].city_clean_switch - 29);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 5);
  integer1 company_url_shift0 := ROUND(Specificities[1].company_url_specificity - 27);
  integer2 company_url_switch_shift0 := ROUND(1000*Specificities[1].company_url_switch - 25);
  integer1 isContact_shift0 := ROUND(Specificities[1].isContact_specificity - 1);
  integer2 isContact_switch_shift0 := ROUND(1000*Specificities[1].isContact_switch - 282);
  integer1 contact_did_shift0 := ROUND(Specificities[1].contact_did_specificity - 25);
  integer2 contact_did_switch_shift0 := ROUND(1000*Specificities[1].contact_did_switch - 337);
  integer1 title_shift0 := ROUND(Specificities[1].title_specificity - 1);
  integer2 title_switch_shift0 := ROUND(1000*Specificities[1].title_switch - 260);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 8);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 422);
  integer1 fname_preferred_shift0 := ROUND(Specificities[1].fname_preferred_specificity - 9);
  integer2 fname_preferred_switch_shift0 := ROUND(1000*Specificities[1].fname_preferred_switch - 438);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 9);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 277);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 10);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 349);
  integer1 name_suffix_shift0 := ROUND(Specificities[1].name_suffix_specificity - 8);
  integer2 name_suffix_switch_shift0 := ROUND(1000*Specificities[1].name_suffix_switch - 68);
  integer1 contact_ssn_shift0 := ROUND(Specificities[1].contact_ssn_specificity - 27);
  integer2 contact_ssn_switch_shift0 := ROUND(1000*Specificities[1].contact_ssn_switch - 134);
  integer1 contact_email_shift0 := ROUND(Specificities[1].contact_email_specificity - 27);
  integer2 contact_email_switch_shift0 := ROUND(1000*Specificities[1].contact_email_switch - 87);
  integer1 sele_flag_shift0 := ROUND(Specificities[1].sele_flag_specificity - 0);
  integer2 sele_flag_switch_shift0 := ROUND(1000*Specificities[1].sele_flag_switch - 0);
  integer1 org_flag_shift0 := ROUND(Specificities[1].org_flag_specificity - 0);
  integer2 org_flag_switch_shift0 := ROUND(1000*Specificities[1].org_flag_switch - 0);
  integer1 ult_flag_shift0 := ROUND(Specificities[1].ult_flag_specificity - 0);
  integer2 ult_flag_switch_shift0 := ROUND(1000*Specificities[1].ult_flag_switch - 0);
  integer1 fallback_value_shift0 := ROUND(Specificities[1].fallback_value_specificity - 1);
  integer2 fallback_value_switch_shift0 := ROUND(1000*Specificities[1].fallback_value_switch - 0);
  integer1 CONTACTNAME_shift0 := ROUND(Specificities[1].CONTACTNAME_specificity - 23);
  integer2 CONTACTNAME_switch_shift0 := ROUND(1000*Specificities[1].CONTACTNAME_switch - 492);
  integer1 STREETADDRESS_shift0 := ROUND(Specificities[1].STREETADDRESS_specificity - 23);
  integer2 STREETADDRESS_switch_shift0 := ROUND(1000*Specificities[1].STREETADDRESS_switch - 96);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT37.MAC_Specificity_Values(parent_proxid_values_persisted,parent_proxid,'parent_proxid',parent_proxid_specificity,parent_proxid_specificity_profile);
  SALT37.MAC_Specificity_Values(sele_proxid_values_persisted,sele_proxid,'sele_proxid',sele_proxid_specificity,sele_proxid_specificity_profile);
  SALT37.MAC_Specificity_Values(org_proxid_values_persisted,org_proxid,'org_proxid',org_proxid_specificity,org_proxid_specificity_profile);
  SALT37.MAC_Specificity_Values(ultimate_proxid_values_persisted,ultimate_proxid,'ultimate_proxid',ultimate_proxid_specificity,ultimate_proxid_specificity_profile);
  SALT37.MAC_Specificity_Values(source_values_persisted,source,'source',source_specificity,source_specificity_profile);
  SALT37.MAC_Specificity_Values(source_record_id_values_persisted,source_record_id,'source_record_id',source_record_id_specificity,source_record_id_specificity_profile);
  SALT37.MAC_Specificity_Values(company_name_values_persisted,company_name,'company_name',company_name_specificity,company_name_specificity_profile);
  SALT37.MAC_Specificity_Values(company_name_prefix_values_persisted,company_name_prefix,'company_name_prefix',company_name_prefix_specificity,company_name_prefix_specificity_profile);
  SALT37.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT37.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT37.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
  SALT37.MAC_Specificity_Values(cnp_lowv_values_persisted,cnp_lowv,'cnp_lowv',cnp_lowv_specificity,cnp_lowv_specificity_profile);
  SALT37.MAC_Specificity_Values(company_phone_3_values_persisted,company_phone_3,'company_phone_3',company_phone_3_specificity,company_phone_3_specificity_profile);
  SALT37.MAC_Specificity_Values(company_phone_3_ex_values_persisted,company_phone_3_ex,'company_phone_3_ex',company_phone_3_ex_specificity,company_phone_3_ex_specificity_profile);
  SALT37.MAC_Specificity_Values(company_phone_7_values_persisted,company_phone_7,'company_phone_7',company_phone_7_specificity,company_phone_7_specificity_profile);
  SALT37.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT37.MAC_Specificity_Values(company_sic_code1_values_persisted,company_sic_code1,'company_sic_code1',company_sic_code1_specificity,company_sic_code1_specificity_profile);
  SALT37.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT37.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT37.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT37.MAC_Specificity_Values(city_values_persisted,city,'city',city_specificity,city_specificity_profile);
  SALT37.MAC_Specificity_Values(city_clean_values_persisted,city_clean,'city_clean',city_clean_specificity,city_clean_specificity_profile);
  SALT37.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT37.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT37.MAC_Specificity_Values(company_url_values_persisted,company_url,'company_url',company_url_specificity,company_url_specificity_profile);
  SALT37.MAC_Specificity_Values(isContact_values_persisted,isContact,'isContact',isContact_specificity,isContact_specificity_profile);
  SALT37.MAC_Specificity_Values(contact_did_values_persisted,contact_did,'contact_did',contact_did_specificity,contact_did_specificity_profile);
  SALT37.MAC_Specificity_Values(title_values_persisted,title,'title',title_specificity,title_specificity_profile);
  SALT37.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT37.MAC_Specificity_Values(fname_preferred_values_persisted,fname_preferred,'fname_preferred',fname_preferred_specificity,fname_preferred_specificity_profile);
  SALT37.MAC_Specificity_Values(mname_values_persisted,mname,'mname',mname_specificity,mname_specificity_profile);
  SALT37.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT37.MAC_Specificity_Values(name_suffix_values_persisted,name_suffix,'name_suffix',name_suffix_specificity,name_suffix_specificity_profile);
  SALT37.MAC_Specificity_Values(contact_ssn_values_persisted,contact_ssn,'contact_ssn',contact_ssn_specificity,contact_ssn_specificity_profile);
  SALT37.MAC_Specificity_Values(contact_email_values_persisted,contact_email,'contact_email',contact_email_specificity,contact_email_specificity_profile);
  SALT37.MAC_Specificity_Values(sele_flag_values_persisted,sele_flag,'sele_flag',sele_flag_specificity,sele_flag_specificity_profile);
  SALT37.MAC_Specificity_Values(org_flag_values_persisted,org_flag,'org_flag',org_flag_specificity,org_flag_specificity_profile);
  SALT37.MAC_Specificity_Values(ult_flag_values_persisted,ult_flag,'ult_flag',ult_flag_specificity,ult_flag_specificity_profile);
  SALT37.MAC_Specificity_Values(fallback_value_values_persisted,fallback_value,'fallback_value',fallback_value_specificity,fallback_value_specificity_profile);
EXPORT AllProfiles := parent_proxid_specificity_profile + sele_proxid_specificity_profile + org_proxid_specificity_profile + ultimate_proxid_specificity_profile + source_specificity_profile + source_record_id_specificity_profile + company_name_specificity_profile + company_name_prefix_specificity_profile + cnp_name_specificity_profile + cnp_number_specificity_profile + cnp_btype_specificity_profile + cnp_lowv_specificity_profile + company_phone_3_specificity_profile + company_phone_3_ex_specificity_profile + company_phone_7_specificity_profile + company_fein_specificity_profile + company_sic_code1_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + sec_range_specificity_profile + city_specificity_profile + city_clean_specificity_profile + st_specificity_profile + zip_specificity_profile + company_url_specificity_profile + isContact_specificity_profile + contact_did_specificity_profile + title_specificity_profile + fname_specificity_profile + fname_preferred_specificity_profile + mname_specificity_profile + lname_specificity_profile + name_suffix_specificity_profile + contact_ssn_specificity_profile + contact_email_specificity_profile + sele_flag_specificity_profile + org_flag_specificity_profile + ult_flag_specificity_profile + fallback_value_specificity_profile;
END;
 
