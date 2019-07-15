IMPORT SALT311,std;
EXPORT specificities(DATASET(layout_Address_Link) ih) := MODULE
 
EXPORT ih_init := SALT311.initNullIDs.baseLevel(ih,RID,ADDRESS_GROUP_ID);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT311.UIDType ADDRESS_GROUP_ID := h.ADDRESS_GROUP_ID; // using existing id field
  h.RID;//RIDfield 
  h.DID;
  h.src;
  h.dt_first_seen;
  h.dt_last_seen;
  h.prim_range;
  h.prim_range_alpha;
  TYPEOF(h.prim_range_num) prim_range_num := (TYPEOF(h.prim_range_num))Fields.Make_prim_range_num((SALT311.StrType)h.prim_range_num ); // Cleans before using
  h.prim_range_fract;
  h.predir;
  h.prim_name;
  TYPEOF(h.prim_name_num) prim_name_num := (TYPEOF(h.prim_name_num))Fields.Make_prim_name_num((SALT311.StrType)h.prim_name_num ); // Cleans before using
  TYPEOF(h.prim_name_alpha) prim_name_alpha := (TYPEOF(h.prim_name_alpha))Fields.Make_prim_name_alpha((SALT311.StrType)h.prim_name_alpha ); // Cleans before using
  h.addr_suffix;
  h.addr_ind;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.sec_range_alpha;
  h.sec_range_num;
  TYPEOF(h.city) city := (TYPEOF(h.city))Fields.Make_city((SALT311.StrType)h.city ); // Cleans before using
  h.st;
  h.zip;
  h.rec_cnt;
  h.src_cnt;
  UNSIGNED4 addr := 0; // Place holder filled in by project
  UNSIGNED4 locale := 0; // Place holder filled in by project
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(ADDRESS_GROUP_ID<>0),r),HASH(ADDRESS_GROUP_ID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.addr := IF (Fields.InValid_addr((SALT311.StrType)le.prim_range_num,(SALT311.StrType)le.prim_range_alpha,(SALT311.StrType)le.prim_range_fract,(SALT311.StrType)le.prim_name_num,(SALT311.StrType)le.prim_name_alpha,(SALT311.StrType)le.sec_range_num,(SALT311.StrType)le.sec_range_alpha)>0,0,HASH32((SALT311.StrType)le.prim_range_num,(SALT311.StrType)le.prim_range_alpha,(SALT311.StrType)le.prim_range_fract,(SALT311.StrType)le.prim_name_num,(SALT311.StrType)le.prim_name_alpha,(SALT311.StrType)le.sec_range_num,(SALT311.StrType)le.sec_range_alpha)); // Combine child fields into 1 for specificity counting
  SELF.locale := IF (Fields.InValid_locale((SALT311.StrType)le.city,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)>0,0,HASH32((SALT311.StrType)le.city,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::Specificities_Cache',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
//We have ADDRESS_GROUP_ID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.ADDRESS_GROUP_ID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,ADDRESS_GROUP_ID,LOCAL) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::Cluster_Sizes',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  DID_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,DID) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::DID',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(DID_deduped,DID,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DID_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::DID',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  prim_range_alpha_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,prim_range_alpha) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::prim_range_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_range_alpha_deduped,prim_range_alpha,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_alpha_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::prim_range_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  prim_range_num_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,prim_range_num) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::prim_range_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_range_num_deduped,prim_range_num,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED prim_range_num_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(prim_range_num_deduped,ADDRESS_GROUP_ID,prim_range_num,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,prim_range_num,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT prim_range_num_ad_temp := wb_specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::wbspecs::prim_range_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(prim_range_num_sa,prim_range_num,prim_range_num_ad_temp,p);
EXPORT prim_range_num_values_persisted_temp := p : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::prim_range_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  prim_range_fract_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,prim_range_fract) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::prim_range_fract',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_range_fract_deduped,prim_range_fract,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_fract_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::prim_range_fract',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  prim_name_num_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,prim_name_num) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::prim_name_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(prim_name_num_deduped,prim_name_num,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED prim_name_num_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(prim_name_num_deduped,ADDRESS_GROUP_ID,prim_name_num,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,prim_name_num,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT prim_name_num_ad_temp := wb_specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::wbspecs::prim_name_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(prim_name_num_sa,prim_name_num,prim_name_num_ad_temp,p);
EXPORT prim_name_num_values_persisted_temp := p : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::prim_name_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  prim_name_alpha_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,prim_name_alpha) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::prim_name_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(prim_name_alpha_deduped,ADDRESS_GROUP_ID,prim_name_alpha,2); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,prim_name_alpha,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.MAC_Field_Initial_Specificities(specs_added,prim_name_alpha,initial_specs_added) // add initial char specificities
SHARED prim_name_alpha_sa := initial_specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(prim_name_alpha_deduped,ADDRESS_GROUP_ID,prim_name_alpha,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,prim_name_alpha,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT prim_name_alpha_ad_temp := wb_specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::wbspecs::prim_name_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(prim_name_alpha_sa,prim_name_alpha,prim_name_alpha_ad_temp,p);
EXPORT prim_name_alpha_values_persisted_temp := p : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::prim_name_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  sec_range_alpha_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,sec_range_alpha) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::sec_range_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(sec_range_alpha_deduped,sec_range_alpha,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_alpha_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::sec_range_alpha',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  sec_range_num_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,sec_range_num) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::sec_range_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.MAC_Field_Variants_Initials(sec_range_num_deduped,ADDRESS_GROUP_ID,sec_range_num,expanded) // expand out all variants of initial
  SALT311.Mac_Field_Count_UID(expanded,sec_range_num,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT311.MAC_Field_Initial_Specificities(specs_added,sec_range_num,initial_specs_added) // add initial char specificities
EXPORT sec_range_num_values_persisted_temp := initial_specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::sec_range_num',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  city_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,city) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::city',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT311.MAC_Field_Variants_Hyphen(city_deduped,ADDRESS_GROUP_ID,city,2); // expand out all variants when hyphenated
  SALT311.Mac_Field_Count_UID(expanded,city,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED city_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT311.MAC_Field_Variants_WordBag(city_deduped,ADDRESS_GROUP_ID,city,expanded)// expand out all variants of wordbag
  SALT311.Mac_Field_Count_UID(expanded,city,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT311.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
EXPORT city_ad_temp := wb_specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::wbspecs::city',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
  SALT311.mac_wordbag_addweights(city_sa,city,city_ad_temp,p);
EXPORT city_values_persisted_temp := p : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::city',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  st_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,st) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::st',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(st_deduped,st,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::st',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  zip_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,zip) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::zip',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(zip_deduped,zip,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::zip',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  addr_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,addr) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::addr',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(addr_deduped,addr,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT addr_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::addr',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT  locale_deduped := SALT311.MAC_Field_By_UID(input_file,ADDRESS_GROUP_ID,locale) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::locale',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Reduce to field values by UID
  SALT311.Mac_Field_Count_UID(locale_deduped,locale,ADDRESS_GROUP_ID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT311.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT311.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT locale_values_persisted_temp := specs_added : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::locale',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT DIDValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::DID';
 
EXPORT DID_values_index := INDEX(DID_values_persisted_temp,{DID},{DID_values_persisted_temp},DIDValuesIndexKeyName);
EXPORT DID_values_persisted := DID_values_index;
SALT311.MAC_Field_Nulls(DID_values_persisted_temp,Layout_Specificities.DID_ChildRec,nv) // Use automated NULL spotting
EXPORT DID_nulls := nv;
SALT311.MAC_Field_Bfoul(DID_deduped,DID,ADDRESS_GROUP_ID,DID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DID_switch := bf;
EXPORT DID_max := MAX(DID_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(DID_values_persisted_temp,DID,DID_nulls,ol) // Compute column level specificity
EXPORT DID_specificity := ol;
 
EXPORT prim_range_alphaValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::prim_range_alpha';
 
EXPORT prim_range_alpha_values_index := INDEX(prim_range_alpha_values_persisted_temp,{prim_range_alpha},{prim_range_alpha_values_persisted_temp},prim_range_alphaValuesIndexKeyName);
EXPORT prim_range_alpha_values_persisted := prim_range_alpha_values_index;
SALT311.MAC_Field_Nulls(prim_range_alpha_values_persisted_temp,Layout_Specificities.prim_range_alpha_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_alpha_nulls := nv;
SALT311.MAC_Field_Bfoul(prim_range_alpha_deduped,prim_range_alpha,ADDRESS_GROUP_ID,prim_range_alpha_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_alpha_switch := bf;
EXPORT prim_range_alpha_max := MAX(prim_range_alpha_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_range_alpha_values_persisted_temp,prim_range_alpha,prim_range_alpha_nulls,ol) // Compute column level specificity
EXPORT prim_range_alpha_specificity := ol;
 
EXPORT prim_range_numWBTokenSpecKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::WordBag_specs::prim_range_num';
 
EXPORT prim_range_num_wbtokenspec_index := INDEX(prim_range_num_ad_temp,{prim_range_num},{prim_range_num_ad_temp},prim_range_numWBTokenSpecKeyName);
EXPORT prim_range_num_ad := prim_range_num_wbtokenspec_index;
 
EXPORT prim_range_numValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::prim_range_num';
 
EXPORT prim_range_num_values_index := INDEX(prim_range_num_values_persisted_temp,{prim_range_num},{prim_range_num_values_persisted_temp},prim_range_numValuesIndexKeyName);
EXPORT prim_range_num_values_persisted := prim_range_num_values_index;
EXPORT prim_range_num_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_range_num_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(prim_range_num_deduped,prim_range_num,ADDRESS_GROUP_ID,prim_range_num_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_num_switch := bf;
EXPORT prim_range_num_max := MAX(prim_range_num_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_range_num_values_persisted_temp,prim_range_num,prim_range_num_nulls,ol) // Compute column level specificity
EXPORT prim_range_num_specificity := ol;
 
EXPORT prim_range_fractValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::prim_range_fract';
 
EXPORT prim_range_fract_values_index := INDEX(prim_range_fract_values_persisted_temp,{prim_range_fract},{prim_range_fract_values_persisted_temp},prim_range_fractValuesIndexKeyName);
EXPORT prim_range_fract_values_persisted := prim_range_fract_values_index;
SALT311.MAC_Field_Nulls(prim_range_fract_values_persisted_temp,Layout_Specificities.prim_range_fract_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_fract_nulls := nv;
SALT311.MAC_Field_Bfoul(prim_range_fract_deduped,prim_range_fract,ADDRESS_GROUP_ID,prim_range_fract_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_fract_switch := bf;
EXPORT prim_range_fract_max := MAX(prim_range_fract_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_range_fract_values_persisted_temp,prim_range_fract,prim_range_fract_nulls,ol) // Compute column level specificity
EXPORT prim_range_fract_specificity := ol;
 
EXPORT prim_name_numWBTokenSpecKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::WordBag_specs::prim_name_num';
 
EXPORT prim_name_num_wbtokenspec_index := INDEX(prim_name_num_ad_temp,{prim_name_num},{prim_name_num_ad_temp},prim_name_numWBTokenSpecKeyName);
EXPORT prim_name_num_ad := prim_name_num_wbtokenspec_index;
 
EXPORT prim_name_numValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::prim_name_num';
 
EXPORT prim_name_num_values_index := INDEX(prim_name_num_values_persisted_temp,{prim_name_num},{prim_name_num_values_persisted_temp},prim_name_numValuesIndexKeyName);
EXPORT prim_name_num_values_persisted := prim_name_num_values_index;
EXPORT prim_name_num_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_name_num_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(prim_name_num_deduped,prim_name_num,ADDRESS_GROUP_ID,prim_name_num_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_num_switch := bf;
EXPORT prim_name_num_max := MAX(prim_name_num_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_name_num_values_persisted_temp,prim_name_num,prim_name_num_nulls,ol) // Compute column level specificity
EXPORT prim_name_num_specificity := ol;
 
EXPORT prim_name_alphaWBTokenSpecKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::WordBag_specs::prim_name_alpha';
 
EXPORT prim_name_alpha_wbtokenspec_index := INDEX(prim_name_alpha_ad_temp,{prim_name_alpha},{prim_name_alpha_ad_temp},prim_name_alphaWBTokenSpecKeyName);
EXPORT prim_name_alpha_ad := prim_name_alpha_wbtokenspec_index;
 
EXPORT prim_name_alphaValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::prim_name_alpha';
 
EXPORT prim_name_alpha_values_index := INDEX(prim_name_alpha_values_persisted_temp,{prim_name_alpha},{prim_name_alpha_values_persisted_temp},prim_name_alphaValuesIndexKeyName);
EXPORT prim_name_alpha_values_persisted := prim_name_alpha_values_index;
EXPORT prim_name_alpha_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_name_alpha_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(prim_name_alpha_deduped,prim_name_alpha,ADDRESS_GROUP_ID,prim_name_alpha_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_alpha_switch := bf;
EXPORT prim_name_alpha_max := MAX(prim_name_alpha_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(prim_name_alpha_values_persisted_temp,prim_name_alpha,prim_name_alpha_nulls,ol) // Compute column level specificity
EXPORT prim_name_alpha_specificity := ol;
 
EXPORT sec_range_alphaValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::sec_range_alpha';
 
EXPORT sec_range_alpha_values_index := INDEX(sec_range_alpha_values_persisted_temp,{sec_range_alpha},{sec_range_alpha_values_persisted_temp},sec_range_alphaValuesIndexKeyName);
EXPORT sec_range_alpha_values_persisted := sec_range_alpha_values_index;
SALT311.MAC_Field_Nulls(sec_range_alpha_values_persisted_temp,Layout_Specificities.sec_range_alpha_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_alpha_nulls := nv;
SALT311.MAC_Field_Bfoul(sec_range_alpha_deduped,sec_range_alpha,ADDRESS_GROUP_ID,sec_range_alpha_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_alpha_switch := bf;
EXPORT sec_range_alpha_max := MAX(sec_range_alpha_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(sec_range_alpha_values_persisted_temp,sec_range_alpha,sec_range_alpha_nulls,ol) // Compute column level specificity
EXPORT sec_range_alpha_specificity := ol;
 
EXPORT sec_range_numValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::sec_range_num';
 
EXPORT sec_range_num_values_index := INDEX(sec_range_num_values_persisted_temp,{sec_range_num},{sec_range_num_values_persisted_temp},sec_range_numValuesIndexKeyName);
EXPORT sec_range_num_values_persisted := sec_range_num_values_index;
EXPORT sec_range_num_nulls := DATASET([{'',0,0}],Layout_Specificities.sec_range_num_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(sec_range_num_deduped,sec_range_num,ADDRESS_GROUP_ID,sec_range_num_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_num_switch := bf;
EXPORT sec_range_num_max := MAX(sec_range_num_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(sec_range_num_values_persisted_temp,sec_range_num,sec_range_num_nulls,ol) // Compute column level specificity
EXPORT sec_range_num_specificity := ol;
 
EXPORT cityWBTokenSpecKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::WordBag_specs::city';
 
EXPORT city_wbtokenspec_index := INDEX(city_ad_temp,{city},{city_ad_temp},cityWBTokenSpecKeyName);
EXPORT city_ad := city_wbtokenspec_index;
 
EXPORT cityValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::city';
 
EXPORT city_values_index := INDEX(city_values_persisted_temp,{city},{city_values_persisted_temp},cityValuesIndexKeyName);
EXPORT city_values_persisted := city_values_index;
EXPORT city_nulls := DATASET([{'',0,0}],Layout_Specificities.city_ChildRec); // Automated null spotting not applicable
SALT311.MAC_Field_Bfoul(city_deduped,city,ADDRESS_GROUP_ID,city_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT city_switch := bf;
EXPORT city_max := MAX(city_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(city_values_persisted_temp,city,city_nulls,ol) // Compute column level specificity
EXPORT city_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT311.MAC_Field_Nulls(st_values_persisted_temp,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT311.MAC_Field_Bfoul(st_deduped,st,ADDRESS_GROUP_ID,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(st_values_persisted_temp,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::zip';
 
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT311.MAC_Field_Nulls(zip_values_persisted_temp,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT311.MAC_Field_Bfoul(zip_deduped,zip,ADDRESS_GROUP_ID,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(zip_values_persisted_temp,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT addrValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::addr';
 
EXPORT addr_values_index := INDEX(addr_values_persisted_temp,{addr},{addr_values_persisted_temp},addrValuesIndexKeyName);
EXPORT addr_values_persisted := addr_values_index;
SALT311.MAC_Field_Nulls(addr_values_persisted_temp,Layout_Specificities.addr_ChildRec,nv) // Use automated NULL spotting
EXPORT addr_nulls := nv;
SALT311.MAC_Field_Bfoul(addr_deduped,addr,ADDRESS_GROUP_ID,addr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT addr_switch := bf;
EXPORT addr_max := MAX(addr_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(addr_values_persisted_temp,addr,addr_nulls,ol) // Compute column level specificity
EXPORT addr_specificity := ol;
 
EXPORT localeValuesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::locale';
 
EXPORT locale_values_index := INDEX(locale_values_persisted_temp,{locale},{locale_values_persisted_temp},localeValuesIndexKeyName);
EXPORT locale_values_persisted := locale_values_index;
SALT311.MAC_Field_Nulls(locale_values_persisted_temp,Layout_Specificities.locale_ChildRec,nv) // Use automated NULL spotting
EXPORT locale_nulls := nv;
SALT311.MAC_Field_Bfoul(locale_deduped,locale,ADDRESS_GROUP_ID,locale_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT locale_switch := bf;
EXPORT locale_max := MAX(locale_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(locale_values_persisted_temp,locale,locale_nulls,ol) // Compute column level specificity
EXPORT locale_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(DID_values_index, OVERWRITE),BUILDINDEX(prim_range_alpha_values_index, OVERWRITE),BUILDINDEX(prim_range_num_wbtokenspec_index, OVERWRITE),BUILDINDEX(prim_range_num_values_index, OVERWRITE),BUILDINDEX(prim_range_fract_values_index, OVERWRITE),BUILDINDEX(prim_name_num_wbtokenspec_index, OVERWRITE),BUILDINDEX(prim_name_num_values_index, OVERWRITE),BUILDINDEX(prim_name_alpha_wbtokenspec_index, OVERWRITE),BUILDINDEX(prim_name_alpha_values_index, OVERWRITE),BUILDINDEX(sec_range_alpha_values_index, OVERWRITE),BUILDINDEX(sec_range_num_values_index, OVERWRITE),BUILDINDEX(city_wbtokenspec_index, OVERWRITE),BUILDINDEX(city_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(addr_values_index, OVERWRITE),BUILDINDEX(locale_values_index, OVERWRITE));
EXPORT Layout_Uber_Plus := RECORD(SALT311.Layout_Uber_Record0)
  SALT311.Str30Type word;
END;
SHARED Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(input_file le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT311.StrType)le.DID,(SALT311.StrType)le.src,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.prim_range_alpha,'',(SALT311.StrType)le.prim_range_fract,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,'','',(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.addr_ind,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.sec_range_alpha,(SALT311.StrType)le.sec_range_num,'',(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.rec_cnt,(SALT311.StrType)le.src_cnt,SKIP,SKIP,SKIP);
  SELF.field := c;
  SELF.uid := le.ADDRESS_GROUP_ID;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(input_file,26,IntoInversion(LEFT,COUNTER))(word<>''));
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_range_num,7,ADDRESS_GROUP_ID,layout_uber_plus,nfields7);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_num,11,ADDRESS_GROUP_ID,layout_uber_plus,nfields11);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_alpha,12,ADDRESS_GROUP_ID,layout_uber_plus,nfields12);
SALT311.MAC_Expand_Wordbag_Field(input_file,city,20,ADDRESS_GROUP_ID,layout_uber_plus,nfields20);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_range_num,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5825);
SALT311.MAC_Expand_Normal_Field(input_file,prim_range_alpha,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5826);
SALT311.MAC_Expand_Normal_Field(input_file,prim_range_fract,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5827);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_num,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5828);
SALT311.MAC_Expand_Wordbag_Field(input_file,prim_name_alpha,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5829);
SALT311.MAC_Expand_Normal_Field(input_file,sec_range_num,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5830);
SALT311.MAC_Expand_Normal_Field(input_file,sec_range_alpha,25,ADDRESS_GROUP_ID,layout_uber_plus,nfields5831);
nfields25 := nfields5825+nfields5826+nfields5827+nfields5828+nfields5829+nfields5830+nfields5831;//Collect wordbags for parts of concept field
SALT311.MAC_Expand_Wordbag_Field(input_file,city,26,ADDRESS_GROUP_ID,layout_uber_plus,nfields6058);
SALT311.MAC_Expand_Normal_Field(input_file,st,26,ADDRESS_GROUP_ID,layout_uber_plus,nfields6059);
SALT311.MAC_Expand_Normal_Field(input_file,zip,26,ADDRESS_GROUP_ID,layout_uber_plus,nfields6060);
nfields26 := nfields6058+nfields6059+nfields6060;//Collect wordbags for parts of concept field
SHARED invert_records := nfields_r + nfields7 + nfields11 + nfields12 + nfields20;
uber_values_deduped0 := Fn_Reduce_UBER_Local( invert_records);
// minimize otherwise required changes to the macros used by uber and specificities!
Layout_Uber_Plus_Spec := RECORD(Layout_Uber_Plus AND NOT uid)
  SALT311.UIDType ADDRESS_GROUP_ID;
END;
SHARED uber_values_deduped := PROJECT(uber_values_deduped0,TRANSFORM(Layout_Uber_Plus_Spec,SELF.ADDRESS_GROUP_ID:=LEFT.uid,SELF:=LEFT)) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::dedups::uber',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
SALT311.MAC_Specificity_Local(uber_values_deduped,word,ADDRESS_GROUP_ID,uber_nulls,Layout_Specificities.uber_ChildRec,word_specificity,word_switch,word_values)
EXPORT uber_values_persisted_temp := word_values : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::values::uber',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
EXPORT UbervaluesIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Word::Uber';
 
EXPORT uber_values_index := INDEX(uber_values_persisted_temp,{word},{uber_values_persisted_temp},UbervaluesIndexKeyName);
EXPORT Uber_values_persisted := uber_values_index;
 
EXPORT BuildUber := BUILDINDEX(uber_values_index, OVERWRITE);
SALT311.MAC_Field_Bfoul(uber_values_deduped,word,ADDRESS_GROUP_ID,uber_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT uber_switch := bf;
EXPORT uber_max := MAX(uber_values_persisted_temp,field_specificity);
SALT311.MAC_Field_Specificity(uber_values_persisted_temp,word,uber_nulls,ol) // Compute column level specificity;
EXPORT uber_specificity := ol;
EXPORT BuildAll := PARALLEL(BuildFields, BuildUber);
 
EXPORT SpecIndexKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Specificities';
iSpecificities := DATASET([{0,DID_specificity,DID_switch,DID_max,DID_nulls,prim_range_alpha_specificity,prim_range_alpha_switch,prim_range_alpha_max,prim_range_alpha_nulls,prim_range_num_specificity,prim_range_num_switch,prim_range_num_max,prim_range_num_nulls,prim_range_fract_specificity,prim_range_fract_switch,prim_range_fract_max,prim_range_fract_nulls,prim_name_num_specificity,prim_name_num_switch,prim_name_num_max,prim_name_num_nulls,prim_name_alpha_specificity,prim_name_alpha_switch,prim_name_alpha_max,prim_name_alpha_nulls,sec_range_alpha_specificity,sec_range_alpha_switch,sec_range_alpha_max,sec_range_alpha_nulls,sec_range_num_specificity,sec_range_num_switch,sec_range_num_max,sec_range_num_nulls,city_specificity,city_switch,city_max,city_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,addr_specificity,addr_switch,addr_max,addr_nulls,locale_specificity,locale_switch,locale_max,locale_nulls,uber_specificity,uber_switch,uber_max,uber_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT BuildSpec := BUILDINDEX(Specificities_Index, OVERWRITE, FEW);
 
EXPORT Build := SEQUENTIAL(BuildAll, BuildSpec);
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 DID_shift0 := ROUND(Specificities[1].DID_specificity - 30);
  integer2 DID_switch_shift0 := ROUND(1000*Specificities[1].DID_switch - 0);
  integer1 prim_range_alpha_shift0 := ROUND(Specificities[1].prim_range_alpha_specificity - 10);
  integer2 prim_range_alpha_switch_shift0 := ROUND(1000*Specificities[1].prim_range_alpha_switch - 0);
  integer1 prim_range_num_shift0 := ROUND(Specificities[1].prim_range_num_specificity - 13);
  integer2 prim_range_num_switch_shift0 := ROUND(1000*Specificities[1].prim_range_num_switch - 0);
  integer1 prim_range_fract_shift0 := ROUND(Specificities[1].prim_range_fract_specificity - 9);
  integer2 prim_range_fract_switch_shift0 := ROUND(1000*Specificities[1].prim_range_fract_switch - 0);
  integer1 prim_name_num_shift0 := ROUND(Specificities[1].prim_name_num_specificity - 13);
  integer2 prim_name_num_switch_shift0 := ROUND(1000*Specificities[1].prim_name_num_switch - 0);
  integer1 prim_name_alpha_shift0 := ROUND(Specificities[1].prim_name_alpha_specificity - 10);
  integer2 prim_name_alpha_switch_shift0 := ROUND(1000*Specificities[1].prim_name_alpha_switch - 0);
  integer1 sec_range_alpha_shift0 := ROUND(Specificities[1].sec_range_alpha_specificity - 9);
  integer2 sec_range_alpha_switch_shift0 := ROUND(1000*Specificities[1].sec_range_alpha_switch - 0);
  integer1 sec_range_num_shift0 := ROUND(Specificities[1].sec_range_num_specificity - 9);
  integer2 sec_range_num_switch_shift0 := ROUND(1000*Specificities[1].sec_range_num_switch - 0);
  integer1 city_shift0 := ROUND(Specificities[1].city_specificity - 8);
  integer2 city_switch_shift0 := ROUND(1000*Specificities[1].city_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 6);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 addr_shift0 := ROUND(Specificities[1].addr_specificity - 26);
  integer2 addr_switch_shift0 := ROUND(1000*Specificities[1].addr_switch - 0);
  integer1 locale_shift0 := ROUND(Specificities[1].locale_specificity - 15);
  integer2 locale_switch_shift0 := ROUND(1000*Specificities[1].locale_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT311.MAC_Specificity_Values(DID_values_persisted,DID,'DID',DID_specificity,DID_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_range_alpha_values_persisted,prim_range_alpha,'prim_range_alpha',prim_range_alpha_specificity,prim_range_alpha_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_range_num_values_persisted,prim_range_num,'prim_range_num',prim_range_num_specificity,prim_range_num_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_range_fract_values_persisted,prim_range_fract,'prim_range_fract',prim_range_fract_specificity,prim_range_fract_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_name_num_values_persisted,prim_name_num,'prim_name_num',prim_name_num_specificity,prim_name_num_specificity_profile);
  SALT311.MAC_Specificity_Values(prim_name_alpha_values_persisted,prim_name_alpha,'prim_name_alpha',prim_name_alpha_specificity,prim_name_alpha_specificity_profile);
  SALT311.MAC_Specificity_Values(sec_range_alpha_values_persisted,sec_range_alpha,'sec_range_alpha',sec_range_alpha_specificity,sec_range_alpha_specificity_profile);
  SALT311.MAC_Specificity_Values(sec_range_num_values_persisted,sec_range_num,'sec_range_num',sec_range_num_specificity,sec_range_num_specificity_profile);
  SALT311.MAC_Specificity_Values(city_values_persisted,city,'city',city_specificity,city_specificity_profile);
  SALT311.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT311.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
EXPORT AllProfiles := DID_specificity_profile + prim_range_alpha_specificity_profile + prim_range_num_specificity_profile + prim_range_fract_specificity_profile + prim_name_num_specificity_profile + prim_name_alpha_specificity_profile + sec_range_alpha_specificity_profile + sec_range_num_specificity_profile + city_specificity_profile + st_specificity_profile + zip_specificity_profile;
END;
 
