IMPORT SALT38,std,BIPV2_WAF;
EXPORT specificities(DATASET(layout_BizHead) ih) := MODULE
 
EXPORT ih_init := SALT38.initNullIDs.baseLevel(ih,rcid,proxid);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT38.UIDType proxid := h.proxid; // using existing id field
  SALT38.UIDType seleid := h.seleid; // Copy ID from hierarchy
  SALT38.UIDType orgid := h.orgid; // Copy ID from hierarchy
  SALT38.UIDType ultid := h.ultid; // Copy ID from hierarchy
  h.rcid;//RIDfield 
  UNSIGNED2 data_permits := fn_sources(h.SOURCE); // Pre-compute permissions for every field
  h.parent_proxid;
  h.ultimate_proxid;
  h.has_lgid;
  h.empid;
  h.powid;
  h.source;
  h.source_record_id;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))Fields.Make_cnp_name((SALT38.StrType)h.cnp_name ); // Cleans before using
  h.company_phone;
  TYPEOF(h.company_fein) company_fein := (TYPEOF(h.company_fein))Fields.Make_company_fein((SALT38.StrType)h.company_fein ); // Cleans before using
  UNSIGNED1 company_fein_len := 0;  // Place holder filled in by project
  h.company_sic_code1;
  h.prim_range;
  UNSIGNED1 prim_range_len := 0;  // Place holder filled in by project
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))Fields.Make_prim_name((SALT38.StrType)h.prim_name ); // Cleans before using
  UNSIGNED1 prim_name_len := 0;  // Place holder filled in by project
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))Fields.Make_sec_range((SALT38.StrType)h.sec_range ); // Cleans before using
  UNSIGNED1 sec_range_len := 0;  // Place holder filled in by project
  TYPEOF(h.p_city_name) p_city_name := (TYPEOF(h.p_city_name))Fields.Make_p_city_name((SALT38.StrType)h.p_city_name ); // Cleans before using
  UNSIGNED1 p_city_name_len := 0;  // Place holder filled in by project
  TYPEOF(h.st) st := (TYPEOF(h.st))Fields.Make_st((SALT38.StrType)h.st ); // Cleans before using
  TYPEOF(h.zip) zip := (TYPEOF(h.zip))Fields.Make_zip((SALT38.StrType)h.zip ); // Cleans before using
  TYPEOF(h.company_url) company_url := (TYPEOF(h.company_url))Fields.Make_company_url((SALT38.StrType)h.company_url ); // Cleans before using
  h.isContact;
  h.title;
  TYPEOF(h.fname) fname := (TYPEOF(h.fname))Fields.Make_fname((SALT38.StrType)h.fname ); // Cleans before using
  UNSIGNED1 fname_len := 0;  // Place holder filled in by project
  TYPEOF(h.mname) mname := (TYPEOF(h.mname))Fields.Make_mname((SALT38.StrType)h.mname ); // Cleans before using
  UNSIGNED1 mname_len := 0;  // Place holder filled in by project
  TYPEOF(h.lname) lname := (TYPEOF(h.lname))Fields.Make_lname((SALT38.StrType)h.lname ); // Cleans before using
  UNSIGNED1 lname_len := 0;  // Place holder filled in by project
  TYPEOF(h.name_suffix) name_suffix := (TYPEOF(h.name_suffix))Fields.Make_name_suffix((SALT38.StrType)h.name_suffix ); // Cleans before using
  h.contact_email;
  UNSIGNED4 CONTACTNAME := 0; // Place holder filled in by project
  UNSIGNED4 STREETADDRESS := 0; // Place holder filled in by project
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(proxid<>0),r),HASH(proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_fein_len := LENGTH(TRIM((SALT38.StrType)le.company_fein));
  SELF.prim_range_len := LENGTH(TRIM((SALT38.StrType)le.prim_range));
  SELF.prim_name_len := LENGTH(TRIM((SALT38.StrType)le.prim_name));
  SELF.sec_range_len := LENGTH(TRIM((SALT38.StrType)le.sec_range));
  SELF.p_city_name_len := LENGTH(TRIM((SALT38.StrType)le.p_city_name));
  SELF.fname_len := LENGTH(TRIM((SALT38.StrType)le.fname));
  SELF.mname_len := LENGTH(TRIM((SALT38.StrType)le.mname));
  SELF.lname_len := LENGTH(TRIM((SALT38.StrType)le.lname));
  SELF.CONTACTNAME := IF (Fields.InValid_CONTACTNAME((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname)>0,0,HASH32((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname)); // Combine child fields into 1 for specificity counting
  SELF.STREETADDRESS := IF (Fields.InValid_STREETADDRESS((SALT38.StrType)le.prim_range,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.sec_range)>0,0,HASH32((SALT38.StrType)le.prim_range,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::Specificities_Cache',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
//We have proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,proxid,LOCAL) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::Cluster_Sizes',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  empid_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,empid) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::empid',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(empid_deduped,empid,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT empid_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::empid',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  powid_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,powid) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::powid',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(powid_deduped,powid,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT powid_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::powid',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  source_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,source) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::source',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(source_deduped,source,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT source_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::source',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  source_record_id_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,source_record_id) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::source_record_id',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(source_record_id_deduped,source_record_id,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT source_record_id_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::source_record_id',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  cnp_number_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,cnp_number) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::cnp_number',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_number_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::cnp_number',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  cnp_btype_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,cnp_btype) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::cnp_btype',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_btype_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::cnp_btype',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  cnp_lowv_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,cnp_lowv) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::cnp_lowv',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(cnp_lowv_deduped,cnp_lowv,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cnp_lowv_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::cnp_lowv',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  cnp_name_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,cnp_name) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::cnp_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED cnp_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT38.MAC_Field_Variants_WordBag(cnp_name_deduped,proxid,cnp_name,expanded)// expand out all variants of wordbag
  SALT38.Mac_Field_Count_UID(expanded,cnp_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT38.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT cnp_name_ad_temp := wb_specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::wbspecs::cnp_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
  SALT38.mac_wordbag_addweights(cnp_name_sa,cnp_name,cnp_name_ad_temp,p);
EXPORT cnp_name_values_persisted_temp := p : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::cnp_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  company_phone_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,company_phone) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::company_phone',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(company_phone_deduped,company_phone,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_phone_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::company_phone',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  company_fein_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,company_fein) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::company_fein',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(company_fein_deduped,company_fein,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT company_fein_values_persisted_temp := distance_computed : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::company_fein',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  company_sic_code1_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,company_sic_code1) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::company_sic_code1',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(company_sic_code1_deduped,company_sic_code1,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT company_sic_code1_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::company_sic_code1',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  prim_range_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,prim_range) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::prim_range',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(prim_range_deduped,prim_range,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,prim_range,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT prim_range_values_persisted_temp := distance_computed : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::prim_range',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  prim_name_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,prim_name) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::prim_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(prim_name_deduped,prim_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,prim_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT prim_name_values_persisted_temp := distance_computed : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::prim_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  sec_range_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,sec_range) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::sec_range',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(sec_range_deduped,sec_range,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,sec_range,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT sec_range_values_persisted_temp := distance_computed : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::sec_range',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  p_city_name_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,p_city_name) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::p_city_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(p_city_name_deduped,p_city_name,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,p_city_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT p_city_name_values_persisted_temp := distance_computed : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::p_city_name',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  st_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,st) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::st',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(st_deduped,st,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::st',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  zip_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,zip) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::zip',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(zip_deduped,zip,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::zip',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  company_url_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,company_url) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::company_url',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(company_url_deduped,company_url,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED company_url_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT38.MAC_Field_Variants_WordBag(company_url_deduped,proxid,company_url,expanded)// expand out all variants of wordbag
  SALT38.Mac_Field_Count_UID(expanded,company_url,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT38.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT company_url_ad_temp := wb_specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::wbspecs::company_url',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
  SALT38.mac_wordbag_addweights(company_url_sa,company_url,company_url_ad_temp,p);
EXPORT company_url_values_persisted_temp := p : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::company_url',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  isContact_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,isContact) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::isContact',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(isContact_deduped,isContact,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT isContact_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::isContact',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  title_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,title) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::title',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(title_deduped,title,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT title_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::title',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  fname_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,fname) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::fname',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.MAC_Field_Variants_Initials(fname_deduped,proxid,fname,expanded) // expand out all variants of initial
  SALT38.Mac_Field_Count_UID(expanded,fname,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING20 fname_PreferredName := fn_PreferredName(counted.fname); // Compute fn_PreferredName value for fname
  end;
  with_id := table(counted,r1);
  SALT38.MAC_Field_Accumulate_Counts(with_id,fname_PreferredName,PreferredName_cnt,fuzzies_counted0)
  SALT38.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,fname,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
  SALT38.MAC_Field_Initial_Specificities(distance_computed,fname,initial_specs_added) // add initial char specificities
EXPORT fname_values_persisted_temp := initial_specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::fname',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  mname_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,mname) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::mname',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.MAC_Field_Variants_Initials(mname_deduped,proxid,mname,expanded) // expand out all variants of initial
  SALT38.Mac_Field_Count_UID(expanded,mname,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,mname,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT38.MAC_Field_Initial_Specificities(distance_computed,mname,initial_specs_added) // add initial char specificities
EXPORT mname_values_persisted_temp := initial_specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::mname',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  lname_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,lname) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::lname',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT38.MAC_Field_Variants_Hyphen(lname_deduped,proxid,lname,2); // expand out all variants when hyphenated
  SALT38.Mac_Field_Count_UID(expanded,lname,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT38.mac_edit_distance_pairs(specs_added,lname,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
  SALT38.MAC_Field_Initial_Specificities(distance_computed,lname,initial_specs_added) // add initial char specificities
EXPORT lname_values_persisted_temp := initial_specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::lname',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  name_suffix_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,name_suffix) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::name_suffix',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(name_suffix_deduped,name_suffix,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
    STRING5 name_suffix_NormSuffix := BIPV2_WAF.fn_normSuffix(counted.name_suffix); // Compute fn_normSuffix value for name_suffix
  end;
  with_id := table(counted,r1);
  SALT38.MAC_Field_Accumulate_Counts(with_id,name_suffix_NormSuffix,NormSuffix_cnt,fuzzies_counted0)
  SALT38.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT name_suffix_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::name_suffix',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  contact_email_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,contact_email) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::contact_email',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(contact_email_deduped,contact_email,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contact_email_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::contact_email',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  CONTACTNAME_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,CONTACTNAME) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::CONTACTNAME',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(CONTACTNAME_deduped,CONTACTNAME,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT CONTACTNAME_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::CONTACTNAME',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT  STREETADDRESS_deduped := SALT38.MAC_Field_By_UID(input_file,proxid,STREETADDRESS) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::STREETADDRESS',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire)); // Reduce to field values by UID
  SALT38.Mac_Field_Count_UID(STREETADDRESS_deduped,STREETADDRESS,proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT38.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT38.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT STREETADDRESS_values_persisted_temp := specs_added : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::STREETADDRESS',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT empidValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::empid';
 
EXPORT empid_values_index := INDEX(empid_values_persisted_temp,{empid},{empid_values_persisted_temp},empidValuesIndexKeyName);
EXPORT empid_values_persisted := empid_values_index;
SALT38.MAC_Field_Nulls(empid_values_persisted,Layout_Specificities.empid_ChildRec,nv) // Use automated NULL spotting
EXPORT empid_nulls := nv;
SALT38.MAC_Field_Bfoul(empid_deduped,empid,proxid,empid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT empid_switch := bf;
EXPORT empid_max := MAX(empid_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(empid_values_persisted,empid,empid_nulls,ol) // Compute column level specificity
EXPORT empid_specificity := ol;
 
EXPORT powidValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::powid';
 
EXPORT powid_values_index := INDEX(powid_values_persisted_temp,{powid},{powid_values_persisted_temp},powidValuesIndexKeyName);
EXPORT powid_values_persisted := powid_values_index;
SALT38.MAC_Field_Nulls(powid_values_persisted,Layout_Specificities.powid_ChildRec,nv) // Use automated NULL spotting
EXPORT powid_nulls := nv;
SALT38.MAC_Field_Bfoul(powid_deduped,powid,proxid,powid_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT powid_switch := bf;
EXPORT powid_max := MAX(powid_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(powid_values_persisted,powid,powid_nulls,ol) // Compute column level specificity
EXPORT powid_specificity := ol;
 
EXPORT sourceValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::source';
 
EXPORT source_values_index := INDEX(source_values_persisted_temp,{source},{source_values_persisted_temp},sourceValuesIndexKeyName);
EXPORT source_values_persisted := source_values_index;
EXPORT source_nulls := DATASET([{'',0,0}],Layout_Specificities.source_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(source_deduped,source,proxid,source_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT source_switch := bf;
EXPORT source_max := MAX(source_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(source_values_persisted,source,source_nulls,ol) // Compute column level specificity
EXPORT source_specificity := ol;
 
EXPORT source_record_idValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::source_record_id';
 
EXPORT source_record_id_values_index := INDEX(source_record_id_values_persisted_temp,{source_record_id},{source_record_id_values_persisted_temp},source_record_idValuesIndexKeyName);
EXPORT source_record_id_values_persisted := source_record_id_values_index;
SALT38.MAC_Field_Nulls(source_record_id_values_persisted,Layout_Specificities.source_record_id_ChildRec,nv) // Use automated NULL spotting
EXPORT source_record_id_nulls := nv;
SALT38.MAC_Field_Bfoul(source_record_id_deduped,source_record_id,proxid,source_record_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT source_record_id_switch := bf;
EXPORT source_record_id_max := MAX(source_record_id_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(source_record_id_values_persisted,source_record_id,source_record_id_nulls,ol) // Compute column level specificity
EXPORT source_record_id_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::cnp_number';
 
EXPORT cnp_number_values_index := INDEX(cnp_number_values_persisted_temp,{cnp_number},{cnp_number_values_persisted_temp},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT38.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT38.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::cnp_btype';
 
EXPORT cnp_btype_values_index := INDEX(cnp_btype_values_persisted_temp,{cnp_btype},{cnp_btype_values_persisted_temp},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
SALT38.MAC_Field_Nulls(cnp_btype_values_persisted,Layout_Specificities.cnp_btype_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_btype_nulls := nv;
SALT38.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,proxid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT cnp_lowvValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::cnp_lowv';
 
EXPORT cnp_lowv_values_index := INDEX(cnp_lowv_values_persisted_temp,{cnp_lowv},{cnp_lowv_values_persisted_temp},cnp_lowvValuesIndexKeyName);
EXPORT cnp_lowv_values_persisted := cnp_lowv_values_index;
SALT38.MAC_Field_Nulls(cnp_lowv_values_persisted,Layout_Specificities.cnp_lowv_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_lowv_nulls := nv;
SALT38.MAC_Field_Bfoul(cnp_lowv_deduped,cnp_lowv,proxid,cnp_lowv_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_lowv_switch := bf;
EXPORT cnp_lowv_max := MAX(cnp_lowv_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(cnp_lowv_values_persisted,cnp_lowv,cnp_lowv_nulls,ol) // Compute column level specificity
EXPORT cnp_lowv_specificity := ol;
 
EXPORT cnp_nameWBTokenSpecKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::WordBag_specs::cnp_name';
 
EXPORT cnp_name_wbtokenspec_index := INDEX(cnp_name_ad_temp,{cnp_name},{cnp_name_ad_temp},cnp_nameWBTokenSpecKeyName);
EXPORT cnp_name_ad := cnp_name_wbtokenspec_index;
 
EXPORT cnp_nameValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::cnp_name';
 
EXPORT cnp_name_values_index := INDEX(cnp_name_values_persisted_temp,{cnp_name},{cnp_name_values_persisted_temp},cnp_nameValuesIndexKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
EXPORT cnp_name_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_name_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,proxid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT company_phoneValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::company_phone';
 
EXPORT company_phone_values_index := INDEX(company_phone_values_persisted_temp,{company_phone},{company_phone_values_persisted_temp},company_phoneValuesIndexKeyName);
EXPORT company_phone_values_persisted := company_phone_values_index;
SALT38.MAC_Field_Nulls(company_phone_values_persisted,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_nulls := nv;
SALT38.MAC_Field_Bfoul(company_phone_deduped,company_phone,proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_switch := bf;
EXPORT company_phone_max := MAX(company_phone_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(company_phone_values_persisted,company_phone,company_phone_nulls,ol) // Compute column level specificity
EXPORT company_phone_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::company_fein';
 
EXPORT company_fein_values_index := INDEX(company_fein_values_persisted_temp,{company_fein},{company_fein_values_persisted_temp},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT38.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT38.MAC_Field_Bfoul(company_fein_deduped,company_fein,proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT company_sic_code1ValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::company_sic_code1';
 
EXPORT company_sic_code1_values_index := INDEX(company_sic_code1_values_persisted_temp,{company_sic_code1},{company_sic_code1_values_persisted_temp},company_sic_code1ValuesIndexKeyName);
EXPORT company_sic_code1_values_persisted := company_sic_code1_values_index;
SALT38.MAC_Field_Nulls(company_sic_code1_values_persisted,Layout_Specificities.company_sic_code1_ChildRec,nv) // Use automated NULL spotting
EXPORT company_sic_code1_nulls := nv;
SALT38.MAC_Field_Bfoul(company_sic_code1_deduped,company_sic_code1,proxid,company_sic_code1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_sic_code1_switch := bf;
EXPORT company_sic_code1_max := MAX(company_sic_code1_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(company_sic_code1_values_persisted,company_sic_code1,company_sic_code1_nulls,ol) // Compute column level specificity
EXPORT company_sic_code1_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT38.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT38.MAC_Field_Bfoul(prim_range_deduped,prim_range,proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT38.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT38.MAC_Field_Bfoul(prim_name_deduped,prim_name,proxid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::sec_range';
 
EXPORT sec_range_values_index := INDEX(sec_range_values_persisted_temp,{sec_range},{sec_range_values_persisted_temp},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT38.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT38.MAC_Field_Bfoul(sec_range_deduped,sec_range,proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT p_city_nameValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::p_city_name';
 
EXPORT p_city_name_values_index := INDEX(p_city_name_values_persisted_temp,{p_city_name},{p_city_name_values_persisted_temp},p_city_nameValuesIndexKeyName);
EXPORT p_city_name_values_persisted := p_city_name_values_index;
SALT38.MAC_Field_Nulls(p_city_name_values_persisted,Layout_Specificities.p_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT p_city_name_nulls := nv;
SALT38.MAC_Field_Bfoul(p_city_name_deduped,p_city_name,proxid,p_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT p_city_name_switch := bf;
EXPORT p_city_name_max := MAX(p_city_name_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(p_city_name_values_persisted,p_city_name,p_city_name_nulls,ol) // Compute column level specificity
EXPORT p_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT38.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT38.MAC_Field_Bfoul(st_deduped,st,proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT38.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT38.MAC_Field_Bfoul(zip_deduped,zip,proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT company_urlWBTokenSpecKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::WordBag_specs::company_url';
 
EXPORT company_url_wbtokenspec_index := INDEX(company_url_ad_temp,{company_url},{company_url_ad_temp},company_urlWBTokenSpecKeyName);
EXPORT company_url_ad := company_url_wbtokenspec_index;
 
EXPORT company_urlValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::company_url';
 
EXPORT company_url_values_index := INDEX(company_url_values_persisted_temp,{company_url},{company_url_values_persisted_temp},company_urlValuesIndexKeyName);
EXPORT company_url_values_persisted := company_url_values_index;
EXPORT company_url_nulls := DATASET([{'',0,0}],Layout_Specificities.company_url_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(company_url_deduped,company_url,proxid,company_url_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_url_switch := bf;
EXPORT company_url_max := MAX(company_url_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(company_url_values_persisted,company_url,company_url_nulls,ol) // Compute column level specificity
EXPORT company_url_specificity := ol;
 
EXPORT isContactValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::isContact';
 
EXPORT isContact_values_index := INDEX(isContact_values_persisted_temp,{isContact},{isContact_values_persisted_temp},isContactValuesIndexKeyName);
EXPORT isContact_values_persisted := isContact_values_index;
EXPORT isContact_nulls := DATASET([{'',0,0}],Layout_Specificities.isContact_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(isContact_deduped,isContact,proxid,isContact_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT isContact_switch := bf;
EXPORT isContact_max := MAX(isContact_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(isContact_values_persisted,isContact,isContact_nulls,ol) // Compute column level specificity
EXPORT isContact_specificity := ol;
 
EXPORT titleValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::title';
 
EXPORT title_values_index := INDEX(title_values_persisted_temp,{title},{title_values_persisted_temp},titleValuesIndexKeyName);
EXPORT title_values_persisted := title_values_index;
EXPORT title_nulls := DATASET([{'',0,0}],Layout_Specificities.title_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(title_deduped,title,proxid,title_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT title_switch := bf;
EXPORT title_max := MAX(title_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(title_values_persisted,title,title_nulls,ol) // Compute column level specificity
EXPORT title_specificity := ol;
 
EXPORT fnameValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::fname';
 
EXPORT fname_values_index := INDEX(fname_values_persisted_temp,{fname},{fname_values_persisted_temp},fnameValuesIndexKeyName);
EXPORT fname_values_persisted := fname_values_index;
EXPORT fname_nulls := DATASET([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(fname_deduped,fname,proxid,fname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fname_switch := bf;
EXPORT fname_max := MAX(fname_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
EXPORT fname_specificity := ol;
 
EXPORT mnameValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::mname';
 
EXPORT mname_values_index := INDEX(mname_values_persisted_temp,{mname},{mname_values_persisted_temp},mnameValuesIndexKeyName);
EXPORT mname_values_persisted := mname_values_index;
EXPORT mname_nulls := DATASET([{'',0,0}],Layout_Specificities.mname_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(mname_deduped,mname,proxid,mname_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mname_switch := bf;
EXPORT mname_max := MAX(mname_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(mname_values_persisted,mname,mname_nulls,ol) // Compute column level specificity
EXPORT mname_specificity := ol;
 
EXPORT lnameValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::lname';
 
EXPORT lname_values_index := INDEX(lname_values_persisted_temp,{lname},{lname_values_persisted_temp},lnameValuesIndexKeyName);
EXPORT lname_values_persisted := lname_values_index;
EXPORT lname_nulls := DATASET([{'',0,0}],Layout_Specificities.lname_ChildRec); // Automated null spotting not applicable
SALT38.MAC_Field_Bfoul(lname_deduped,lname,proxid,lname_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lname_switch := bf;
EXPORT lname_max := MAX(lname_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
EXPORT lname_specificity := ol;
 
EXPORT name_suffixValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::name_suffix';
 
EXPORT name_suffix_values_index := INDEX(name_suffix_values_persisted_temp,{name_suffix},{name_suffix_values_persisted_temp},name_suffixValuesIndexKeyName);
EXPORT name_suffix_values_persisted := name_suffix_values_index;
SALT38.MAC_Field_Nulls(name_suffix_values_persisted,Layout_Specificities.name_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT name_suffix_nulls := nv;
SALT38.MAC_Field_Bfoul(name_suffix_deduped,name_suffix,proxid,name_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_suffix_switch := bf;
EXPORT name_suffix_max := MAX(name_suffix_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(name_suffix_values_persisted,name_suffix,name_suffix_nulls,ol) // Compute column level specificity
EXPORT name_suffix_specificity := ol;
 
EXPORT contact_emailValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::contact_email';
 
EXPORT contact_email_values_index := INDEX(contact_email_values_persisted_temp,{contact_email},{contact_email_values_persisted_temp},contact_emailValuesIndexKeyName);
EXPORT contact_email_values_persisted := contact_email_values_index;
SALT38.MAC_Field_Nulls(contact_email_values_persisted,Layout_Specificities.contact_email_ChildRec,nv) // Use automated NULL spotting
EXPORT contact_email_nulls := nv;
SALT38.MAC_Field_Bfoul(contact_email_deduped,contact_email,proxid,contact_email_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contact_email_switch := bf;
EXPORT contact_email_max := MAX(contact_email_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(contact_email_values_persisted,contact_email,contact_email_nulls,ol) // Compute column level specificity
EXPORT contact_email_specificity := ol;
 
EXPORT CONTACTNAMEValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::CONTACTNAME';
 
EXPORT CONTACTNAME_values_index := INDEX(CONTACTNAME_values_persisted_temp,{CONTACTNAME},{CONTACTNAME_values_persisted_temp},CONTACTNAMEValuesIndexKeyName);
EXPORT CONTACTNAME_values_persisted := CONTACTNAME_values_index;
SALT38.MAC_Field_Nulls(CONTACTNAME_values_persisted,Layout_Specificities.CONTACTNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT CONTACTNAME_nulls := nv;
SALT38.MAC_Field_Bfoul(CONTACTNAME_deduped,CONTACTNAME,proxid,CONTACTNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CONTACTNAME_switch := bf;
EXPORT CONTACTNAME_max := MAX(CONTACTNAME_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(CONTACTNAME_values_persisted,CONTACTNAME,CONTACTNAME_nulls,ol) // Compute column level specificity
EXPORT CONTACTNAME_specificity := ol;
 
EXPORT STREETADDRESSValuesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::STREETADDRESS';
 
EXPORT STREETADDRESS_values_index := INDEX(STREETADDRESS_values_persisted_temp,{STREETADDRESS},{STREETADDRESS_values_persisted_temp},STREETADDRESSValuesIndexKeyName);
EXPORT STREETADDRESS_values_persisted := STREETADDRESS_values_index;
SALT38.MAC_Field_Nulls(STREETADDRESS_values_persisted,Layout_Specificities.STREETADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT STREETADDRESS_nulls := nv;
SALT38.MAC_Field_Bfoul(STREETADDRESS_deduped,STREETADDRESS,proxid,STREETADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT STREETADDRESS_switch := bf;
EXPORT STREETADDRESS_max := MAX(STREETADDRESS_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(STREETADDRESS_values_persisted,STREETADDRESS,STREETADDRESS_nulls,ol) // Compute column level specificity
EXPORT STREETADDRESS_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(empid_values_index, OVERWRITE),BUILDINDEX(powid_values_index, OVERWRITE),BUILDINDEX(source_values_index, OVERWRITE),BUILDINDEX(source_record_id_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE),BUILDINDEX(cnp_lowv_values_index, OVERWRITE),BUILDINDEX(cnp_name_wbtokenspec_index, OVERWRITE),BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(company_phone_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(company_sic_code1_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(p_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(company_url_wbtokenspec_index, OVERWRITE),BUILDINDEX(company_url_values_index, OVERWRITE),BUILDINDEX(isContact_values_index, OVERWRITE),BUILDINDEX(title_values_index, OVERWRITE),BUILDINDEX(fname_values_index, OVERWRITE),BUILDINDEX(mname_values_index, OVERWRITE),BUILDINDEX(lname_values_index, OVERWRITE),BUILDINDEX(name_suffix_values_index, OVERWRITE),BUILDINDEX(contact_email_values_index, OVERWRITE),BUILDINDEX(CONTACTNAME_values_index, OVERWRITE),BUILDINDEX(STREETADDRESS_values_index, OVERWRITE));
EXPORT Layout_Uber_Plus := RECORD(SALT38.Layout_Uber_Record0)
  SALT38.Str30Type word;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(input_file le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT38.StrType)le.parent_proxid,(SALT38.StrType)le.ultimate_proxid,(SALT38.StrType)le.has_lgid,(SALT38.StrType)le.empid,(SALT38.StrType)le.powid,(SALT38.StrType)le.source,(SALT38.StrType)le.source_record_id,(SALT38.StrType)le.cnp_number,(SALT38.StrType)le.cnp_btype,(SALT38.StrType)le.cnp_lowv,'',(SALT38.StrType)le.company_phone,Fields.Make_company_fein((SALT38.StrType)le.company_fein),(SALT38.StrType)le.company_sic_code1,(SALT38.StrType)le.prim_range,Fields.Make_prim_name((SALT38.StrType)le.prim_name),Fields.Make_sec_range((SALT38.StrType)le.sec_range),Fields.Make_p_city_name((SALT38.StrType)le.p_city_name),Fields.Make_st((SALT38.StrType)le.st),Fields.Make_zip((SALT38.StrType)le.zip),'',(SALT38.StrType)le.isContact,(SALT38.StrType)le.title,Fields.Make_fname((SALT38.StrType)le.fname),Fields.Make_mname((SALT38.StrType)le.mname),Fields.Make_lname((SALT38.StrType)le.lname),Fields.Make_name_suffix((SALT38.StrType)le.name_suffix),(SALT38.StrType)le.contact_email,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.proxid;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(input_file,30,IntoInversion(LEFT,COUNTER))(word<>''));
SALT38.MAC_Expand_Wordbag_Field(input_file,cnp_name,11,proxid,layout_uber_plus,nfields11);
SALT38.MAC_Expand_Wordbag_Field(input_file,company_url,21,proxid,layout_uber_plus,nfields21);
SALT38.MAC_Expand_Normal_Field(input_file,fname,29,proxid,layout_uber_plus,nfields6757);
SALT38.MAC_Expand_Normal_Field(input_file,mname,29,proxid,layout_uber_plus,nfields6758);
SALT38.MAC_Expand_Normal_Field(input_file,lname,29,proxid,layout_uber_plus,nfields6759);
nfields29 := nfields6757+nfields6758+nfields6759;//Collect wordbags for parts of concept field
SALT38.MAC_Expand_Normal_Field(input_file,prim_range,30,proxid,layout_uber_plus,nfields6990);
SALT38.MAC_Expand_Normal_Field(input_file,prim_name,30,proxid,layout_uber_plus,nfields6991);
SALT38.MAC_Expand_Normal_Field(input_file,sec_range,30,proxid,layout_uber_plus,nfields6992);
nfields30 := nfields6990+nfields6991+nfields6992;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r + nfields11 + nfields21;
uber_values_deduped0 := Fn_Reduce_UBER_Local( invert_records);
// minimize otherwise required changes to the macros used by uber and specificities!
Layout_Uber_Plus_Spec := RECORD(Layout_Uber_Plus AND NOT uid)
  SALT38.UIDType proxid;
END;
SHARED uber_values_deduped := PROJECT(uber_values_deduped0,TRANSFORM(Layout_Uber_Plus_Spec,SELF.proxid:=LEFT.uid,SELF:=LEFT)) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::dedups::uber',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
SALT38.MAC_Specificity_Local(uber_values_deduped,word,proxid,uber_nulls,Layout_Specificities.uber_ChildRec,word_specificity,word_switch,word_values)
EXPORT uber_values_persisted_temp := word_values : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::values::uber',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
 
EXPORT UbervaluesIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Word::Uber';
 
EXPORT uber_values_index := INDEX(uber_values_persisted_temp,{word},{uber_values_persisted_temp},UbervaluesIndexKeyName);
EXPORT Uber_values_persisted := uber_values_index;
 
EXPORT BuildUber := BUILDINDEX(uber_values_index, OVERWRITE);
SALT38.MAC_Field_Bfoul(uber_values_deduped,word,proxid,uber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT uber_switch := bf;
EXPORT uber_max := MAX(uber_values_persisted,field_specificity);
SALT38.MAC_Field_Specificity(uber_values_persisted,word,uber_nulls,ol) // Compute column level specificity;
EXPORT uber_specificity := ol;
EXPORT BuildAll := PARALLEL(BuildFields, BuildUber);
 
EXPORT SpecIndexKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::Specificities';
iSpecificities := DATASET([{0,empid_specificity,empid_switch,empid_max,empid_nulls,powid_specificity,powid_switch,powid_max,powid_nulls,source_specificity,source_switch,source_max,source_nulls,source_record_id_specificity,source_record_id_switch,source_record_id_max,source_record_id_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,cnp_lowv_specificity,cnp_lowv_switch,cnp_lowv_max,cnp_lowv_nulls,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_sic_code1_specificity,company_sic_code1_switch,company_sic_code1_max,company_sic_code1_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,p_city_name_specificity,p_city_name_switch,p_city_name_max,p_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,company_url_specificity,company_url_switch,company_url_max,company_url_nulls,isContact_specificity,isContact_switch,isContact_max,isContact_nulls,title_specificity,title_switch,title_max,title_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,mname_specificity,mname_switch,mname_max,mname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,name_suffix_specificity,name_suffix_switch,name_suffix_max,name_suffix_nulls,contact_email_specificity,contact_email_switch,contact_email_max,contact_email_nulls,CONTACTNAME_specificity,CONTACTNAME_switch,CONTACTNAME_max,CONTACTNAME_nulls,STREETADDRESS_specificity,STREETADDRESS_switch,STREETADDRESS_max,STREETADDRESS_nulls,uber_specificity,uber_switch,uber_max,uber_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT BuildSpec := BUILDINDEX(Specificities_Index, OVERWRITE, FEW);
 
EXPORT Build := SEQUENTIAL ( BuildAll, BuildSpec );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 empid_shift0 := ROUND(Specificities[1].empid_specificity - 0);
  integer2 empid_switch_shift0 := ROUND(1000*Specificities[1].empid_switch - 0);
  integer1 powid_shift0 := ROUND(Specificities[1].powid_specificity - 0);
  integer2 powid_switch_shift0 := ROUND(1000*Specificities[1].powid_switch - 0);
  integer1 source_shift0 := ROUND(Specificities[1].source_specificity - 2);
  integer2 source_switch_shift0 := ROUND(1000*Specificities[1].source_switch - 0);
  integer1 source_record_id_shift0 := ROUND(Specificities[1].source_record_id_specificity - 26);
  integer2 source_record_id_switch_shift0 := ROUND(1000*Specificities[1].source_record_id_switch - 0);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 0);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 0);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 0);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 0);
  integer1 cnp_lowv_shift0 := ROUND(Specificities[1].cnp_lowv_specificity - 0);
  integer2 cnp_lowv_switch_shift0 := ROUND(1000*Specificities[1].cnp_lowv_switch - 0);
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 24);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 0);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 26);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 0);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 26);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 0);
  integer1 company_sic_code1_shift0 := ROUND(Specificities[1].company_sic_code1_specificity - 10);
  integer2 company_sic_code1_switch_shift0 := ROUND(1000*Specificities[1].company_sic_code1_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 0);
  integer1 p_city_name_shift0 := ROUND(Specificities[1].p_city_name_specificity - 12);
  integer2 p_city_name_switch_shift0 := ROUND(1000*Specificities[1].p_city_name_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 company_url_shift0 := ROUND(Specificities[1].company_url_specificity - 26);
  integer2 company_url_switch_shift0 := ROUND(1000*Specificities[1].company_url_switch - 0);
  integer1 isContact_shift0 := ROUND(Specificities[1].isContact_specificity - 1);
  integer2 isContact_switch_shift0 := ROUND(1000*Specificities[1].isContact_switch - 0);
  integer1 title_shift0 := ROUND(Specificities[1].title_specificity - 1);
  integer2 title_switch_shift0 := ROUND(1000*Specificities[1].title_switch - 0);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 8);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 0);
  integer1 mname_shift0 := ROUND(Specificities[1].mname_specificity - 9);
  integer2 mname_switch_shift0 := ROUND(1000*Specificities[1].mname_switch - 0);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 10);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 0);
  integer1 name_suffix_shift0 := ROUND(Specificities[1].name_suffix_specificity - 8);
  integer2 name_suffix_switch_shift0 := ROUND(1000*Specificities[1].name_suffix_switch - 0);
  integer1 contact_email_shift0 := ROUND(Specificities[1].contact_email_specificity - 0);
  integer2 contact_email_switch_shift0 := ROUND(1000*Specificities[1].contact_email_switch - 0);
  integer1 CONTACTNAME_shift0 := ROUND(Specificities[1].CONTACTNAME_specificity - 17);
  integer2 CONTACTNAME_switch_shift0 := ROUND(1000*Specificities[1].CONTACTNAME_switch - 0);
  integer1 STREETADDRESS_shift0 := ROUND(Specificities[1].STREETADDRESS_specificity - 16);
  integer2 STREETADDRESS_switch_shift0 := ROUND(1000*Specificities[1].STREETADDRESS_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT38.MAC_Specificity_Values(empid_values_persisted,empid,'empid',empid_specificity,empid_specificity_profile);
  SALT38.MAC_Specificity_Values(powid_values_persisted,powid,'powid',powid_specificity,powid_specificity_profile);
  SALT38.MAC_Specificity_Values(source_values_persisted,source,'source',source_specificity,source_specificity_profile);
  SALT38.MAC_Specificity_Values(source_record_id_values_persisted,source_record_id,'source_record_id',source_record_id_specificity,source_record_id_specificity_profile);
  SALT38.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT38.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
  SALT38.MAC_Specificity_Values(cnp_lowv_values_persisted,cnp_lowv,'cnp_lowv',cnp_lowv_specificity,cnp_lowv_specificity_profile);
  SALT38.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT38.MAC_Specificity_Values(company_phone_values_persisted,company_phone,'company_phone',company_phone_specificity,company_phone_specificity_profile);
  SALT38.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT38.MAC_Specificity_Values(company_sic_code1_values_persisted,company_sic_code1,'company_sic_code1',company_sic_code1_specificity,company_sic_code1_specificity_profile);
  SALT38.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT38.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT38.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT38.MAC_Specificity_Values(p_city_name_values_persisted,p_city_name,'p_city_name',p_city_name_specificity,p_city_name_specificity_profile);
  SALT38.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT38.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT38.MAC_Specificity_Values(company_url_values_persisted,company_url,'company_url',company_url_specificity,company_url_specificity_profile);
  SALT38.MAC_Specificity_Values(isContact_values_persisted,isContact,'isContact',isContact_specificity,isContact_specificity_profile);
  SALT38.MAC_Specificity_Values(title_values_persisted,title,'title',title_specificity,title_specificity_profile);
  SALT38.MAC_Specificity_Values(fname_values_persisted,fname,'fname',fname_specificity,fname_specificity_profile);
  SALT38.MAC_Specificity_Values(mname_values_persisted,mname,'mname',mname_specificity,mname_specificity_profile);
  SALT38.MAC_Specificity_Values(lname_values_persisted,lname,'lname',lname_specificity,lname_specificity_profile);
  SALT38.MAC_Specificity_Values(name_suffix_values_persisted,name_suffix,'name_suffix',name_suffix_specificity,name_suffix_specificity_profile);
  SALT38.MAC_Specificity_Values(contact_email_values_persisted,contact_email,'contact_email',contact_email_specificity,contact_email_specificity_profile);
EXPORT AllProfiles := empid_specificity_profile + powid_specificity_profile + source_specificity_profile + source_record_id_specificity_profile + cnp_number_specificity_profile + cnp_btype_specificity_profile + cnp_lowv_specificity_profile + cnp_name_specificity_profile + company_phone_specificity_profile + company_fein_specificity_profile + company_sic_code1_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + sec_range_specificity_profile + p_city_name_specificity_profile + st_specificity_profile + zip_specificity_profile + company_url_specificity_profile + isContact_specificity_profile + title_specificity_profile + fname_specificity_profile + mname_specificity_profile + lname_specificity_profile + name_suffix_specificity_profile + contact_email_specificity_profile;
// Specificities keys needed as part of MEOW key build
 
EXPORT cnp_nameValuesKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::WordBag::cnp_name';
 
EXPORT cnp_name_values_key := INDEX(cnp_name_ad,{cnp_name},{cnp_name_ad},cnp_nameValuesKeyName);
 
EXPORT company_urlValuesKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::WordBag::company_url';
 
EXPORT company_url_values_key := INDEX(company_url_ad,{company_url},{company_url_ad},company_urlValuesKeyName);
 
EXPORT BuildBOWFields := PARALLEL(BUILDINDEX(cnp_name_values_key, OVERWRITE),BUILDINDEX(company_url_values_key, OVERWRITE));
END;
 
