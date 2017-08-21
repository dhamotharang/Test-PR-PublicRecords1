IMPORT ut,SALT34;
EXPORT specificities(DATASET(layout_PROPERTY_TRANSACTION) ih) := MODULE
EXPORT ih_init := SALT34.initNullIDs.baseLevel(ih,rid,DPROPTXID);
SHARED h := ih_init;
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages; // Import modules for  attribute definitions

EXPORT input_layout := RECORD // project out required fields
  SALT34.UIDType DPROPTXID := h.DPROPTXID; // using existing id field
  h.rid;//RIDfield 
  h.fips_code;
  h.apnt_or_pin_number;
  UNSIGNED1 apnt_or_pin_number_len := LENGTH(TRIM((SALT34.StrType)h.apnt_or_pin_number));
  h.ln_fares_id;
  h.did;
  h.name;
  h.prim_range;
  h.prim_range_alpha;
  h.prim_range_num;
  h.prim_name;
  h.prim_name_num;
  h.prim_name_alpha;
  h.sec_range;
  h.sec_range_alpha;
  h.sec_range_num;
  h.city;
  h.st;
  h.zip;
  UNSIGNED1 zip_len := LENGTH(TRIM((SALT34.StrType)h.zip));
  h.recording_date;
  h.SourceType;
  h.contract_date;
  h.document_number;
  h.document_type_code;
  h.recorder_book_number;
  h.recorder_page_number;
  h.sales_price;
  h.first_td_loan_amount;
  h.lender_name;
  h.county_name;
  unsigned4 primrange := 0; // Place holder filled in by project
  unsigned4 primname := 0; // Place holder filled in by project
  unsigned4 secrange := 0; // Place holder filled in by project
  unsigned4 locale := 0; // Place holder filled in by project
  unsigned4 address := 0; // Place holder filled in by project
END;
r := input_layout;
h01 := DISTRIBUTE(TABLE(h(DPROPTXID<>0),r),HASH(DPROPTXID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.primrange := IF (Fields.InValid_primrange((SALT34.StrType)le.prim_range_alpha,(SALT34.StrType)le.prim_range_num),0,HASH32((SALT34.StrType)le.prim_range_alpha,(SALT34.StrType)le.prim_range_num)); // Combine child fields into 1 for specificity counting
  SELF.primname := IF (Fields.InValid_primname((SALT34.StrType)le.prim_name_alpha,(SALT34.StrType)le.prim_name_num),0,HASH32((SALT34.StrType)le.prim_name_alpha,(SALT34.StrType)le.prim_name_num)); // Combine child fields into 1 for specificity counting
  SELF.secrange := IF (Fields.InValid_secrange((SALT34.StrType)le.sec_range_alpha,(SALT34.StrType)le.sec_range_num),0,HASH32((SALT34.StrType)le.sec_range_alpha,(SALT34.StrType)le.sec_range_num)); // Combine child fields into 1 for specificity counting
  SELF.locale := IF (Fields.InValid_locale((SALT34.StrType)le.city,(SALT34.StrType)le.st,(SALT34.StrType)le.zip),0,HASH32((SALT34.StrType)le.city,(SALT34.StrType)le.st,(SALT34.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.address := IF (Fields.InValid_address((SALT34.StrType)SELF.primrange,(SALT34.StrType)SELF.primname,(SALT34.StrType)SELF.secrange,(SALT34.StrType)SELF.locale),0,HASH32((SALT34.StrType)SELF.primrange,(SALT34.StrType)SELF.primname,(SALT34.StrType)SELF.secrange,(SALT34.StrType)SELF.locale)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::Specificities_Cache',EXPIRE(Config.PersistExpire));
//We have DPROPTXID specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.DPROPTXID;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,DPROPTXID,LOCAL) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::Cluster_Sizes',EXPIRE(Config.PersistExpire));
EXPORT TotalClusters := COUNT(ClusterSizes);
EXPORT  fips_code_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,fips_code) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::fips_code',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(fips_code_deduped,fips_code,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fips_code_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::fips_code',EXPIRE(Config.PersistExpire));
EXPORT  apnt_or_pin_number_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,apnt_or_pin_number) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::apnt_or_pin_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(apnt_or_pin_number_deduped,apnt_or_pin_number,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT34.mac_edit_distance_pairs(specs_added,apnt_or_pin_number,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT apnt_or_pin_number_values_persisted_temp := distance_computed : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::apnt_or_pin_number',EXPIRE(Config.PersistExpire));
EXPORT  did_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,did) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::did',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(did_deduped,did,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT did_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::did',EXPIRE(Config.PersistExpire));
EXPORT  name_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,name) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT34.MAC_Field_Variants_Hyphen(name_deduped,DPROPTXID,name,2); // expand out all variants when hyphenated
  SALT34.Mac_Field_Count_UID(expanded,name,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT34.MAC_Field_Variants_WordBag(name_deduped,DPROPTXID,name,expanded)// expand out all variants of wordbag
  SALT34.Mac_Field_Count_UID(expanded,name,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT34.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED name_ad := wb_specs_added; // Hop over export
EXPORT nameValuesKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::WordBag::name';
EXPORT name_values_key := INDEX(name_ad,{name},{name_ad},nameValuesKeyName);
  SALT34.mac_wordbag_addweights(name_sa,name,name_ad,p);
EXPORT name_values_persisted_temp := p;
EXPORT  prim_range_alpha_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,prim_range_alpha) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::prim_range_alpha',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(prim_range_alpha_deduped,prim_range_alpha,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_alpha_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::prim_range_alpha',EXPIRE(Config.PersistExpire));
EXPORT  prim_range_num_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,prim_range_num) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::prim_range_num',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT34.MAC_Field_Variants_Hyphen(prim_range_num_deduped,DPROPTXID,prim_range_num,2); // expand out all variants when hyphenated
  SALT34.Mac_Field_Count_UID(expanded,prim_range_num,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT34.MAC_Field_Initial_Specificities(specs_added,prim_range_num,initial_specs_added) // add initial char specificities
EXPORT prim_range_num_values_persisted_temp := initial_specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::prim_range_num',EXPIRE(Config.PersistExpire));
EXPORT  prim_name_num_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,prim_name_num) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::prim_name_num',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.MAC_Field_Variants_Initials(prim_name_num_deduped,DPROPTXID,prim_name_num,expanded) // expand out all variants of initial
  SALT34.Mac_Field_Count_UID(expanded,prim_name_num,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT34.MAC_Field_Initial_Specificities(specs_added,prim_name_num,initial_specs_added) // add initial char specificities
EXPORT prim_name_num_values_persisted_temp := initial_specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::prim_name_num',EXPIRE(Config.PersistExpire));
EXPORT  prim_name_alpha_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,prim_name_alpha) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::prim_name_alpha',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT34.MAC_Field_Variants_Hyphen(prim_name_alpha_deduped,DPROPTXID,prim_name_alpha,2); // expand out all variants when hyphenated
  SALT34.Mac_Field_Count_UID(expanded,prim_name_alpha,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED prim_name_alpha_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT34.MAC_Field_Variants_WordBag(prim_name_alpha_deduped,DPROPTXID,prim_name_alpha,expanded)// expand out all variants of wordbag
  SALT34.Mac_Field_Count_UID(expanded,prim_name_alpha,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT34.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED prim_name_alpha_ad := wb_specs_added; // Hop over export
EXPORT prim_name_alphaValuesKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::WordBag::prim_name_alpha';
EXPORT prim_name_alpha_values_key := INDEX(prim_name_alpha_ad,{prim_name_alpha},{prim_name_alpha_ad},prim_name_alphaValuesKeyName);
  SALT34.mac_wordbag_addweights(prim_name_alpha_sa,prim_name_alpha,prim_name_alpha_ad,p);
EXPORT prim_name_alpha_values_persisted_temp := p;
EXPORT  sec_range_alpha_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,sec_range_alpha) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::sec_range_alpha',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(sec_range_alpha_deduped,sec_range_alpha,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_alpha_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::sec_range_alpha',EXPIRE(Config.PersistExpire));
EXPORT  sec_range_num_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,sec_range_num) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::sec_range_num',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT34.MAC_Field_Variants_Hyphen(sec_range_num_deduped,DPROPTXID,sec_range_num,2); // expand out all variants when hyphenated
  SALT34.Mac_Field_Count_UID(expanded,sec_range_num,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT34.MAC_Field_Initial_Specificities(specs_added,sec_range_num,initial_specs_added) // add initial char specificities
EXPORT sec_range_num_values_persisted_temp := initial_specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::sec_range_num',EXPIRE(Config.PersistExpire));
EXPORT  city_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,city) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::city',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT34.MAC_Field_Variants_Hyphen(city_deduped,DPROPTXID,city,2); // expand out all variants when hyphenated
  SALT34.Mac_Field_Count_UID(expanded,city,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED city_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT34.MAC_Field_Variants_WordBag(city_deduped,DPROPTXID,city,expanded)// expand out all variants of wordbag
  SALT34.Mac_Field_Count_UID(expanded,city,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT34.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED city_ad := wb_specs_added; // Hop over export
EXPORT cityValuesKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::WordBag::city';
EXPORT city_values_key := INDEX(city_ad,{city},{city_ad},cityValuesKeyName);
  SALT34.mac_wordbag_addweights(city_sa,city,city_ad,p);
EXPORT city_values_persisted_temp := p;
EXPORT  st_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,st) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::st',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(st_deduped,st,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::st',EXPIRE(Config.PersistExpire));
EXPORT  zip_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,zip) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::zip',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(zip_deduped,zip,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT34.mac_edit_distance_pairs(specs_added,zip,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT zip_values_persisted_temp := distance_computed : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::zip',EXPIRE(Config.PersistExpire));
EXPORT  recording_date_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,recording_date) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::recording_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(recording_date_deduped,recording_date,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recording_date_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::recording_date',EXPIRE(Config.PersistExpire));
EXPORT  SourceType_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,SourceType) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::SourceType',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(SourceType_deduped,SourceType,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SourceType_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::SourceType',EXPIRE(Config.PersistExpire));
EXPORT  contract_date_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,contract_date) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::contract_date',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(contract_date_deduped,contract_date,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contract_date_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::contract_date',EXPIRE(Config.PersistExpire));
EXPORT  document_number_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,document_number) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::document_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(document_number_deduped,document_number,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  fuzzies_counted0 := with_id; // Place holder for fuzzy counting logic
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT document_number_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::document_number',EXPIRE(Config.PersistExpire));
EXPORT  recorder_book_number_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,recorder_book_number) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::recorder_book_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(recorder_book_number_deduped,recorder_book_number,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recorder_book_number_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::recorder_book_number',EXPIRE(Config.PersistExpire));
EXPORT  recorder_page_number_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,recorder_page_number) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::recorder_page_number',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(recorder_page_number_deduped,recorder_page_number,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recorder_page_number_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::recorder_page_number',EXPIRE(Config.PersistExpire));
EXPORT  sales_price_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,sales_price) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::sales_price',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(sales_price_deduped,sales_price,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sales_price_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::sales_price',EXPIRE(Config.PersistExpire));
EXPORT  first_td_loan_amount_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,first_td_loan_amount) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::first_td_loan_amount',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(first_td_loan_amount_deduped,first_td_loan_amount,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT first_td_loan_amount_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::first_td_loan_amount',EXPIRE(Config.PersistExpire));
EXPORT  lender_name_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,lender_name) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::lender_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  expanded := SALT34.MAC_Field_Variants_Hyphen(lender_name_deduped,DPROPTXID,lender_name,2); // expand out all variants when hyphenated
  SALT34.Mac_Field_Count_UID(expanded,lender_name,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SHARED lender_name_sa := specs_added; // Hop over shared/export below
// This field is a word bag; so create specificities for the words too
  SALT34.MAC_Field_Variants_WordBag(lender_name_deduped,DPROPTXID,lender_name,expanded)// expand out all variants of wordbag
  SALT34.Mac_Field_Count_UID(expanded,lender_name,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  SALT34.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED lender_name_ad := wb_specs_added; // Hop over export
EXPORT lender_nameValuesKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::WordBag::lender_name';
EXPORT lender_name_values_key := INDEX(lender_name_ad,{lender_name},{lender_name_ad},lender_nameValuesKeyName);
  SALT34.mac_wordbag_addweights(lender_name_sa,lender_name,lender_name_ad,p);
EXPORT lender_name_values_persisted_temp := p;
EXPORT  county_name_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,county_name) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::county_name',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(county_name_deduped,county_name,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT county_name_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::county_name',EXPIRE(Config.PersistExpire));
EXPORT  primrange_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,primrange) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::primrange',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(primrange_deduped,primrange,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT primrange_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::primrange',EXPIRE(Config.PersistExpire));
EXPORT  primname_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,primname) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::primname',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(primname_deduped,primname,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT primname_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::primname',EXPIRE(Config.PersistExpire));
EXPORT  secrange_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,secrange) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::secrange',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(secrange_deduped,secrange,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT secrange_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::secrange',EXPIRE(Config.PersistExpire));
EXPORT  locale_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,locale) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::locale',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(locale_deduped,locale,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT locale_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::locale',EXPIRE(Config.PersistExpire));
EXPORT  address_deduped := SALT34.MAC_Field_By_UID(input_file,DPROPTXID,address) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::dedups::address',EXPIRE(Config.PersistExpire)); // Reduce to field values by UID
  SALT34.Mac_Field_Count_UID(address_deduped,address,DPROPTXID,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT34.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT address_values_persisted_temp := specs_added : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::values::address',EXPIRE(Config.PersistExpire));
EXPORT BuildBOWFields := PARALLEL(BUILDINDEX(name_values_key, OVERWRITE),BUILDINDEX(prim_name_alpha_values_key, OVERWRITE),BUILDINDEX(city_values_key, OVERWRITE),BUILDINDEX(lender_name_values_key, OVERWRITE));
EXPORT fips_codeValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::fips_code';
EXPORT fips_code_values_index := INDEX(fips_code_values_persisted_temp,{fips_code},{fips_code_values_persisted_temp},fips_codeValuesIndexKeyName);
EXPORT fips_code_values_persisted := fips_code_values_index;
SALT34.MAC_Field_Nulls(fips_code_values_persisted,Layout_Specificities.fips_code_ChildRec,nv) // Use automated NULL spotting
EXPORT fips_code_nulls := nv;
SALT34.MAC_Field_Bfoul(fips_code_deduped,fips_code,DPROPTXID,fips_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fips_code_switch := bf;
EXPORT fips_code_max := MAX(fips_code_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(fips_code_values_persisted,fips_code,fips_code_nulls,ol) // Compute column level specificity
EXPORT fips_code_specificity := ol;
EXPORT apnt_or_pin_numberValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::apnt_or_pin_number';
EXPORT apnt_or_pin_number_values_index := INDEX(apnt_or_pin_number_values_persisted_temp,{apnt_or_pin_number},{apnt_or_pin_number_values_persisted_temp},apnt_or_pin_numberValuesIndexKeyName);
EXPORT apnt_or_pin_number_values_persisted := apnt_or_pin_number_values_index;
SALT34.MAC_Field_Nulls(apnt_or_pin_number_values_persisted,Layout_Specificities.apnt_or_pin_number_ChildRec,nv) // Use automated NULL spotting
EXPORT apnt_or_pin_number_nulls := nv;
SALT34.MAC_Field_Bfoul(apnt_or_pin_number_deduped,apnt_or_pin_number,DPROPTXID,apnt_or_pin_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT apnt_or_pin_number_switch := bf;
EXPORT apnt_or_pin_number_max := MAX(apnt_or_pin_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(apnt_or_pin_number_values_persisted,apnt_or_pin_number,apnt_or_pin_number_nulls,ol) // Compute column level specificity
EXPORT apnt_or_pin_number_specificity := ol;
EXPORT didValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::did';
EXPORT did_values_index := INDEX(did_values_persisted_temp,{did},{did_values_persisted_temp},didValuesIndexKeyName);
EXPORT did_values_persisted := did_values_index;
SALT34.MAC_Field_Nulls(did_values_persisted,Layout_Specificities.did_ChildRec,nv) // Use automated NULL spotting
EXPORT did_nulls := nv;
SALT34.MAC_Field_Bfoul(did_deduped,did,DPROPTXID,did_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT did_switch := bf;
EXPORT did_max := MAX(did_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(did_values_persisted,did,did_nulls,ol) // Compute column level specificity
EXPORT did_specificity := ol;
EXPORT nameValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::name';
EXPORT name_values_index := INDEX(name_values_persisted_temp,{name},{name_values_persisted_temp},nameValuesIndexKeyName);
EXPORT name_values_persisted := name_values_index;
EXPORT name_nulls := DATASET([{'',0,0}],Layout_Specificities.name_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(name_deduped,name,DPROPTXID,name_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT name_switch := bf;
EXPORT name_max := MAX(name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(name_values_persisted,name,name_nulls,ol) // Compute column level specificity
EXPORT name_specificity := ol;
EXPORT prim_range_alphaValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::prim_range_alpha';
EXPORT prim_range_alpha_values_index := INDEX(prim_range_alpha_values_persisted_temp,{prim_range_alpha},{prim_range_alpha_values_persisted_temp},prim_range_alphaValuesIndexKeyName);
EXPORT prim_range_alpha_values_persisted := prim_range_alpha_values_index;
SALT34.MAC_Field_Nulls(prim_range_alpha_values_persisted,Layout_Specificities.prim_range_alpha_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_alpha_nulls := nv;
SALT34.MAC_Field_Bfoul(prim_range_alpha_deduped,prim_range_alpha,DPROPTXID,prim_range_alpha_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_alpha_switch := bf;
EXPORT prim_range_alpha_max := MAX(prim_range_alpha_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(prim_range_alpha_values_persisted,prim_range_alpha,prim_range_alpha_nulls,ol) // Compute column level specificity
EXPORT prim_range_alpha_specificity := ol;
EXPORT prim_range_numValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::prim_range_num';
EXPORT prim_range_num_values_index := INDEX(prim_range_num_values_persisted_temp,{prim_range_num},{prim_range_num_values_persisted_temp},prim_range_numValuesIndexKeyName);
EXPORT prim_range_num_values_persisted := prim_range_num_values_index;
EXPORT prim_range_num_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_range_num_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(prim_range_num_deduped,prim_range_num,DPROPTXID,prim_range_num_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_num_switch := bf;
EXPORT prim_range_num_max := MAX(prim_range_num_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(prim_range_num_values_persisted,prim_range_num,prim_range_num_nulls,ol) // Compute column level specificity
EXPORT prim_range_num_specificity := ol;
EXPORT prim_name_numValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::prim_name_num';
EXPORT prim_name_num_values_index := INDEX(prim_name_num_values_persisted_temp,{prim_name_num},{prim_name_num_values_persisted_temp},prim_name_numValuesIndexKeyName);
EXPORT prim_name_num_values_persisted := prim_name_num_values_index;
EXPORT prim_name_num_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_name_num_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(prim_name_num_deduped,prim_name_num,DPROPTXID,prim_name_num_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_num_switch := bf;
EXPORT prim_name_num_max := MAX(prim_name_num_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(prim_name_num_values_persisted,prim_name_num,prim_name_num_nulls,ol) // Compute column level specificity
EXPORT prim_name_num_specificity := ol;
EXPORT prim_name_alphaValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::prim_name_alpha';
EXPORT prim_name_alpha_values_index := INDEX(prim_name_alpha_values_persisted_temp,{prim_name_alpha},{prim_name_alpha_values_persisted_temp},prim_name_alphaValuesIndexKeyName);
EXPORT prim_name_alpha_values_persisted := prim_name_alpha_values_index;
EXPORT prim_name_alpha_nulls := DATASET([{'',0,0}],Layout_Specificities.prim_name_alpha_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(prim_name_alpha_deduped,prim_name_alpha,DPROPTXID,prim_name_alpha_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_alpha_switch := bf;
EXPORT prim_name_alpha_max := MAX(prim_name_alpha_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(prim_name_alpha_values_persisted,prim_name_alpha,prim_name_alpha_nulls,ol) // Compute column level specificity
EXPORT prim_name_alpha_specificity := ol;
EXPORT sec_range_alphaValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::sec_range_alpha';
EXPORT sec_range_alpha_values_index := INDEX(sec_range_alpha_values_persisted_temp,{sec_range_alpha},{sec_range_alpha_values_persisted_temp},sec_range_alphaValuesIndexKeyName);
EXPORT sec_range_alpha_values_persisted := sec_range_alpha_values_index;
SALT34.MAC_Field_Nulls(sec_range_alpha_values_persisted,Layout_Specificities.sec_range_alpha_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_alpha_nulls := nv;
SALT34.MAC_Field_Bfoul(sec_range_alpha_deduped,sec_range_alpha,DPROPTXID,sec_range_alpha_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_alpha_switch := bf;
EXPORT sec_range_alpha_max := MAX(sec_range_alpha_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(sec_range_alpha_values_persisted,sec_range_alpha,sec_range_alpha_nulls,ol) // Compute column level specificity
EXPORT sec_range_alpha_specificity := ol;
EXPORT sec_range_numValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::sec_range_num';
EXPORT sec_range_num_values_index := INDEX(sec_range_num_values_persisted_temp,{sec_range_num},{sec_range_num_values_persisted_temp},sec_range_numValuesIndexKeyName);
EXPORT sec_range_num_values_persisted := sec_range_num_values_index;
EXPORT sec_range_num_nulls := DATASET([{'',0,0}],Layout_Specificities.sec_range_num_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(sec_range_num_deduped,sec_range_num,DPROPTXID,sec_range_num_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_num_switch := bf;
EXPORT sec_range_num_max := MAX(sec_range_num_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(sec_range_num_values_persisted,sec_range_num,sec_range_num_nulls,ol) // Compute column level specificity
EXPORT sec_range_num_specificity := ol;
EXPORT cityValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::city';
EXPORT city_values_index := INDEX(city_values_persisted_temp,{city},{city_values_persisted_temp},cityValuesIndexKeyName);
EXPORT city_values_persisted := city_values_index;
EXPORT city_nulls := DATASET([{'',0,0}],Layout_Specificities.city_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(city_deduped,city,DPROPTXID,city_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT city_switch := bf;
EXPORT city_max := MAX(city_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(city_values_persisted,city,city_nulls,ol) // Compute column level specificity
EXPORT city_specificity := ol;
EXPORT stValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::st';
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT34.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT34.MAC_Field_Bfoul(st_deduped,st,DPROPTXID,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
EXPORT zipValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::zip';
EXPORT zip_values_index := INDEX(zip_values_persisted_temp,{zip},{zip_values_persisted_temp},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT34.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT34.MAC_Field_Bfoul(zip_deduped,zip,DPROPTXID,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
EXPORT recording_dateValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::recording_date';
EXPORT recording_date_values_index := INDEX(recording_date_values_persisted_temp,{recording_date},{recording_date_values_persisted_temp},recording_dateValuesIndexKeyName);
EXPORT recording_date_values_persisted := recording_date_values_index;
SALT34.MAC_Field_Nulls(recording_date_values_persisted,Layout_Specificities.recording_date_ChildRec,nv) // Use automated NULL spotting
EXPORT recording_date_nulls := nv;
SALT34.MAC_Field_Bfoul(recording_date_deduped,recording_date,DPROPTXID,recording_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recording_date_switch := bf;
EXPORT recording_date_max := MAX(recording_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(recording_date_values_persisted,recording_date,recording_date_nulls,ol) // Compute column level specificity
EXPORT recording_date_specificity := ol;
EXPORT SourceTypeValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::SourceType';
EXPORT SourceType_values_index := INDEX(SourceType_values_persisted_temp,{SourceType},{SourceType_values_persisted_temp},SourceTypeValuesIndexKeyName);
EXPORT SourceType_values_persisted := SourceType_values_index;
EXPORT SourceType_nulls := DATASET([{'',0,0}],Layout_Specificities.SourceType_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(SourceType_deduped,SourceType,DPROPTXID,SourceType_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SourceType_switch := bf;
EXPORT SourceType_max := MAX(SourceType_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(SourceType_values_persisted,SourceType,SourceType_nulls,ol) // Compute column level specificity
EXPORT SourceType_specificity := ol;
EXPORT contract_dateValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::contract_date';
EXPORT contract_date_values_index := INDEX(contract_date_values_persisted_temp,{contract_date},{contract_date_values_persisted_temp},contract_dateValuesIndexKeyName);
EXPORT contract_date_values_persisted := contract_date_values_index;
SALT34.MAC_Field_Nulls(contract_date_values_persisted,Layout_Specificities.contract_date_ChildRec,nv) // Use automated NULL spotting
EXPORT contract_date_nulls := nv;
SALT34.MAC_Field_Bfoul(contract_date_deduped,contract_date,DPROPTXID,contract_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contract_date_switch := bf;
EXPORT contract_date_max := MAX(contract_date_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(contract_date_values_persisted,contract_date,contract_date_nulls,ol) // Compute column level specificity
EXPORT contract_date_specificity := ol;
EXPORT document_numberValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::document_number';
EXPORT document_number_values_index := INDEX(document_number_values_persisted_temp,{document_number},{document_number_values_persisted_temp},document_numberValuesIndexKeyName);
EXPORT document_number_values_persisted := document_number_values_index;
SALT34.MAC_Field_Nulls(document_number_values_persisted,Layout_Specificities.document_number_ChildRec,nv) // Use automated NULL spotting
EXPORT document_number_nulls := nv;
SALT34.MAC_Field_Bfoul(document_number_deduped,document_number,DPROPTXID,document_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT document_number_switch := bf;
EXPORT document_number_max := MAX(document_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(document_number_values_persisted,document_number,document_number_nulls,ol) // Compute column level specificity
EXPORT document_number_specificity := ol;
EXPORT recorder_book_numberValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::recorder_book_number';
EXPORT recorder_book_number_values_index := INDEX(recorder_book_number_values_persisted_temp,{recorder_book_number},{recorder_book_number_values_persisted_temp},recorder_book_numberValuesIndexKeyName);
EXPORT recorder_book_number_values_persisted := recorder_book_number_values_index;
SALT34.MAC_Field_Nulls(recorder_book_number_values_persisted,Layout_Specificities.recorder_book_number_ChildRec,nv) // Use automated NULL spotting
EXPORT recorder_book_number_nulls := nv;
SALT34.MAC_Field_Bfoul(recorder_book_number_deduped,recorder_book_number,DPROPTXID,recorder_book_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recorder_book_number_switch := bf;
EXPORT recorder_book_number_max := MAX(recorder_book_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(recorder_book_number_values_persisted,recorder_book_number,recorder_book_number_nulls,ol) // Compute column level specificity
EXPORT recorder_book_number_specificity := ol;
EXPORT recorder_page_numberValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::recorder_page_number';
EXPORT recorder_page_number_values_index := INDEX(recorder_page_number_values_persisted_temp,{recorder_page_number},{recorder_page_number_values_persisted_temp},recorder_page_numberValuesIndexKeyName);
EXPORT recorder_page_number_values_persisted := recorder_page_number_values_index;
SALT34.MAC_Field_Nulls(recorder_page_number_values_persisted,Layout_Specificities.recorder_page_number_ChildRec,nv) // Use automated NULL spotting
EXPORT recorder_page_number_nulls := nv;
SALT34.MAC_Field_Bfoul(recorder_page_number_deduped,recorder_page_number,DPROPTXID,recorder_page_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recorder_page_number_switch := bf;
EXPORT recorder_page_number_max := MAX(recorder_page_number_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(recorder_page_number_values_persisted,recorder_page_number,recorder_page_number_nulls,ol) // Compute column level specificity
EXPORT recorder_page_number_specificity := ol;
EXPORT sales_priceValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::sales_price';
EXPORT sales_price_values_index := INDEX(sales_price_values_persisted_temp,{sales_price},{sales_price_values_persisted_temp},sales_priceValuesIndexKeyName);
EXPORT sales_price_values_persisted := sales_price_values_index;
SALT34.MAC_Field_Nulls(sales_price_values_persisted,Layout_Specificities.sales_price_ChildRec,nv) // Use automated NULL spotting
EXPORT sales_price_nulls := nv;
SALT34.MAC_Field_Bfoul(sales_price_deduped,sales_price,DPROPTXID,sales_price_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sales_price_switch := bf;
EXPORT sales_price_max := MAX(sales_price_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(sales_price_values_persisted,sales_price,sales_price_nulls,ol) // Compute column level specificity
EXPORT sales_price_specificity := ol;
EXPORT first_td_loan_amountValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::first_td_loan_amount';
EXPORT first_td_loan_amount_values_index := INDEX(first_td_loan_amount_values_persisted_temp,{first_td_loan_amount},{first_td_loan_amount_values_persisted_temp},first_td_loan_amountValuesIndexKeyName);
EXPORT first_td_loan_amount_values_persisted := first_td_loan_amount_values_index;
SALT34.MAC_Field_Nulls(first_td_loan_amount_values_persisted,Layout_Specificities.first_td_loan_amount_ChildRec,nv) // Use automated NULL spotting
EXPORT first_td_loan_amount_nulls := nv;
SALT34.MAC_Field_Bfoul(first_td_loan_amount_deduped,first_td_loan_amount,DPROPTXID,first_td_loan_amount_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT first_td_loan_amount_switch := bf;
EXPORT first_td_loan_amount_max := MAX(first_td_loan_amount_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(first_td_loan_amount_values_persisted,first_td_loan_amount,first_td_loan_amount_nulls,ol) // Compute column level specificity
EXPORT first_td_loan_amount_specificity := ol;
EXPORT lender_nameValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::lender_name';
EXPORT lender_name_values_index := INDEX(lender_name_values_persisted_temp,{lender_name},{lender_name_values_persisted_temp},lender_nameValuesIndexKeyName);
EXPORT lender_name_values_persisted := lender_name_values_index;
EXPORT lender_name_nulls := DATASET([{'',0,0}],Layout_Specificities.lender_name_ChildRec); // Automated null spotting not applicable
SALT34.MAC_Field_Bfoul(lender_name_deduped,lender_name,DPROPTXID,lender_name_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT lender_name_switch := bf;
EXPORT lender_name_max := MAX(lender_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(lender_name_values_persisted,lender_name,lender_name_nulls,ol) // Compute column level specificity
EXPORT lender_name_specificity := ol;
EXPORT county_nameValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::county_name';
EXPORT county_name_values_index := INDEX(county_name_values_persisted_temp,{county_name},{county_name_values_persisted_temp},county_nameValuesIndexKeyName);
EXPORT county_name_values_persisted := county_name_values_index;
SALT34.MAC_Field_Nulls(county_name_values_persisted,Layout_Specificities.county_name_ChildRec,nv) // Use automated NULL spotting
EXPORT county_name_nulls := nv;
SALT34.MAC_Field_Bfoul(county_name_deduped,county_name,DPROPTXID,county_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT county_name_switch := bf;
EXPORT county_name_max := MAX(county_name_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(county_name_values_persisted,county_name,county_name_nulls,ol) // Compute column level specificity
EXPORT county_name_specificity := ol;
EXPORT primrangeValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::primrange';
EXPORT primrange_values_index := INDEX(primrange_values_persisted_temp,{primrange},{primrange_values_persisted_temp},primrangeValuesIndexKeyName);
EXPORT primrange_values_persisted := primrange_values_index;
SALT34.MAC_Field_Nulls(primrange_values_persisted,Layout_Specificities.primrange_ChildRec,nv) // Use automated NULL spotting
EXPORT primrange_nulls := nv;
SALT34.MAC_Field_Bfoul(primrange_deduped,primrange,DPROPTXID,primrange_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT primrange_switch := bf;
EXPORT primrange_max := MAX(primrange_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(primrange_values_persisted,primrange,primrange_nulls,ol) // Compute column level specificity
EXPORT primrange_specificity := ol;
EXPORT primnameValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::primname';
EXPORT primname_values_index := INDEX(primname_values_persisted_temp,{primname},{primname_values_persisted_temp},primnameValuesIndexKeyName);
EXPORT primname_values_persisted := primname_values_index;
SALT34.MAC_Field_Nulls(primname_values_persisted,Layout_Specificities.primname_ChildRec,nv) // Use automated NULL spotting
EXPORT primname_nulls := nv;
SALT34.MAC_Field_Bfoul(primname_deduped,primname,DPROPTXID,primname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT primname_switch := bf;
EXPORT primname_max := MAX(primname_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(primname_values_persisted,primname,primname_nulls,ol) // Compute column level specificity
EXPORT primname_specificity := ol;
EXPORT secrangeValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::secrange';
EXPORT secrange_values_index := INDEX(secrange_values_persisted_temp,{secrange},{secrange_values_persisted_temp},secrangeValuesIndexKeyName);
EXPORT secrange_values_persisted := secrange_values_index;
SALT34.MAC_Field_Nulls(secrange_values_persisted,Layout_Specificities.secrange_ChildRec,nv) // Use automated NULL spotting
EXPORT secrange_nulls := nv;
SALT34.MAC_Field_Bfoul(secrange_deduped,secrange,DPROPTXID,secrange_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT secrange_switch := bf;
EXPORT secrange_max := MAX(secrange_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(secrange_values_persisted,secrange,secrange_nulls,ol) // Compute column level specificity
EXPORT secrange_specificity := ol;
EXPORT localeValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::locale';
EXPORT locale_values_index := INDEX(locale_values_persisted_temp,{locale},{locale_values_persisted_temp},localeValuesIndexKeyName);
EXPORT locale_values_persisted := locale_values_index;
SALT34.MAC_Field_Nulls(locale_values_persisted,Layout_Specificities.locale_ChildRec,nv) // Use automated NULL spotting
EXPORT locale_nulls := nv;
SALT34.MAC_Field_Bfoul(locale_deduped,locale,DPROPTXID,locale_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT locale_switch := bf;
EXPORT locale_max := MAX(locale_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(locale_values_persisted,locale,locale_nulls,ol) // Compute column level specificity
EXPORT locale_specificity := ol;
EXPORT addressValuesIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Word::address';
EXPORT address_values_index := INDEX(address_values_persisted_temp,{address},{address_values_persisted_temp},addressValuesIndexKeyName);
EXPORT address_values_persisted := address_values_index;
SALT34.MAC_Field_Nulls(address_values_persisted,Layout_Specificities.address_ChildRec,nv) // Use automated NULL spotting
EXPORT address_nulls := nv;
SALT34.MAC_Field_Bfoul(address_deduped,address,DPROPTXID,address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT address_switch := bf;
EXPORT address_max := MAX(address_values_persisted,field_specificity);
SALT34.MAC_Field_Specificity(address_values_persisted,address,address_nulls,ol) // Compute column level specificity
EXPORT address_specificity := ol;
EXPORT BuildFields := PARALLEL(BUILDINDEX(fips_code_values_index, OVERWRITE),BUILDINDEX(apnt_or_pin_number_values_index, OVERWRITE),BUILDINDEX(did_values_index, OVERWRITE),BUILDINDEX(name_values_index, OVERWRITE),BUILDINDEX(prim_range_alpha_values_index, OVERWRITE),BUILDINDEX(prim_range_num_values_index, OVERWRITE),BUILDINDEX(prim_name_num_values_index, OVERWRITE),BUILDINDEX(prim_name_alpha_values_index, OVERWRITE),BUILDINDEX(sec_range_alpha_values_index, OVERWRITE),BUILDINDEX(sec_range_num_values_index, OVERWRITE),BUILDINDEX(city_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(recording_date_values_index, OVERWRITE),BUILDINDEX(SourceType_values_index, OVERWRITE),BUILDINDEX(contract_date_values_index, OVERWRITE),BUILDINDEX(document_number_values_index, OVERWRITE),BUILDINDEX(recorder_book_number_values_index, OVERWRITE),BUILDINDEX(recorder_page_number_values_index, OVERWRITE),BUILDINDEX(sales_price_values_index, OVERWRITE),BUILDINDEX(first_td_loan_amount_values_index, OVERWRITE),BUILDINDEX(lender_name_values_index, OVERWRITE),BUILDINDEX(county_name_values_index, OVERWRITE),BUILDINDEX(primrange_values_index, OVERWRITE),BUILDINDEX(primname_values_index, OVERWRITE),BUILDINDEX(secrange_values_index, OVERWRITE),BUILDINDEX(locale_values_index, OVERWRITE),BUILDINDEX(address_values_index, OVERWRITE));
EXPORT BuildAll := BuildFields;
EXPORT SpecIndexKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Specificities';
iSpecificities := DATASET([{0,fips_code_specificity,fips_code_switch,fips_code_max,fips_code_nulls,apnt_or_pin_number_specificity,apnt_or_pin_number_switch,apnt_or_pin_number_max,apnt_or_pin_number_nulls,did_specificity,did_switch,did_max,did_nulls,name_specificity,name_switch,name_max,name_nulls,prim_range_alpha_specificity,prim_range_alpha_switch,prim_range_alpha_max,prim_range_alpha_nulls,prim_range_num_specificity,prim_range_num_switch,prim_range_num_max,prim_range_num_nulls,prim_name_num_specificity,prim_name_num_switch,prim_name_num_max,prim_name_num_nulls,prim_name_alpha_specificity,prim_name_alpha_switch,prim_name_alpha_max,prim_name_alpha_nulls,sec_range_alpha_specificity,sec_range_alpha_switch,sec_range_alpha_max,sec_range_alpha_nulls,sec_range_num_specificity,sec_range_num_switch,sec_range_num_max,sec_range_num_nulls,city_specificity,city_switch,city_max,city_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,recording_date_specificity,recording_date_switch,recording_date_max,recording_date_nulls,SourceType_specificity,SourceType_switch,SourceType_max,SourceType_nulls,contract_date_specificity,contract_date_switch,contract_date_max,contract_date_nulls,document_number_specificity,document_number_switch,document_number_max,document_number_nulls,recorder_book_number_specificity,recorder_book_number_switch,recorder_book_number_max,recorder_book_number_nulls,recorder_page_number_specificity,recorder_page_number_switch,recorder_page_number_max,recorder_page_number_nulls,sales_price_specificity,sales_price_switch,sales_price_max,sales_price_nulls,first_td_loan_amount_specificity,first_td_loan_amount_switch,first_td_loan_amount_max,first_td_loan_amount_nulls,lender_name_specificity,lender_name_switch,lender_name_max,lender_name_nulls,county_name_specificity,county_name_switch,county_name_max,county_name_nulls,primrange_specificity,primrange_switch,primrange_max,primrange_nulls,primname_specificity,primname_switch,primname_max,primname_nulls,secrange_specificity,secrange_switch,secrange_max,secrange_nulls,locale_specificity,locale_switch,locale_max,locale_nulls,address_specificity,address_switch,address_max,address_nulls}],Layout_Specificities.R);
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( BuildAll, BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 fips_code_shift0 := ROUND(Specificities[1].fips_code_specificity - 8);
  integer2 fips_code_switch_shift0 := ROUND(1000*Specificities[1].fips_code_switch - 0);
  integer1 apnt_or_pin_number_shift0 := ROUND(Specificities[1].apnt_or_pin_number_specificity - 25);
  integer2 apnt_or_pin_number_switch_shift0 := ROUND(1000*Specificities[1].apnt_or_pin_number_switch - 0);
  integer1 did_shift0 := ROUND(Specificities[1].did_specificity - 26);
  integer2 did_switch_shift0 := ROUND(1000*Specificities[1].did_switch - 0);
  integer1 name_shift0 := ROUND(Specificities[1].name_specificity - 9);
  integer2 name_switch_shift0 := ROUND(1000*Specificities[1].name_switch - 0);
  integer1 prim_range_alpha_shift0 := ROUND(Specificities[1].prim_range_alpha_specificity - 10);
  integer2 prim_range_alpha_switch_shift0 := ROUND(1000*Specificities[1].prim_range_alpha_switch - 0);
  integer1 prim_range_num_shift0 := ROUND(Specificities[1].prim_range_num_specificity - 6);
  integer2 prim_range_num_switch_shift0 := ROUND(1000*Specificities[1].prim_range_num_switch - 0);
  integer1 prim_name_num_shift0 := ROUND(Specificities[1].prim_name_num_specificity - 8);
  integer2 prim_name_num_switch_shift0 := ROUND(1000*Specificities[1].prim_name_num_switch - 0);
  integer1 prim_name_alpha_shift0 := ROUND(Specificities[1].prim_name_alpha_specificity - 8);
  integer2 prim_name_alpha_switch_shift0 := ROUND(1000*Specificities[1].prim_name_alpha_switch - 0);
  integer1 sec_range_alpha_shift0 := ROUND(Specificities[1].sec_range_alpha_specificity - 10);
  integer2 sec_range_alpha_switch_shift0 := ROUND(1000*Specificities[1].sec_range_alpha_switch - 0);
  integer1 sec_range_num_shift0 := ROUND(Specificities[1].sec_range_num_specificity - 8);
  integer2 sec_range_num_switch_shift0 := ROUND(1000*Specificities[1].sec_range_num_switch - 0);
  integer1 city_shift0 := ROUND(Specificities[1].city_specificity - 6);
  integer2 city_switch_shift0 := ROUND(1000*Specificities[1].city_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 6);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 13);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 recording_date_shift0 := ROUND(Specificities[1].recording_date_specificity - 12);
  integer2 recording_date_switch_shift0 := ROUND(1000*Specificities[1].recording_date_switch - 0);
  integer1 SourceType_shift0 := ROUND(Specificities[1].SourceType_specificity - 1);
  integer2 SourceType_switch_shift0 := ROUND(1000*Specificities[1].SourceType_switch - 0);
  integer1 contract_date_shift0 := ROUND(Specificities[1].contract_date_specificity - 12);
  integer2 contract_date_switch_shift0 := ROUND(1000*Specificities[1].contract_date_switch - 0);
  integer1 document_number_shift0 := ROUND(Specificities[1].document_number_specificity - 12);
  integer2 document_number_switch_shift0 := ROUND(1000*Specificities[1].document_number_switch - 0);
  integer1 recorder_book_number_shift0 := ROUND(Specificities[1].recorder_book_number_specificity - 16);
  integer2 recorder_book_number_switch_shift0 := ROUND(1000*Specificities[1].recorder_book_number_switch - 0);
  integer1 recorder_page_number_shift0 := ROUND(Specificities[1].recorder_page_number_specificity - 12);
  integer2 recorder_page_number_switch_shift0 := ROUND(1000*Specificities[1].recorder_page_number_switch - 0);
  integer1 sales_price_shift0 := ROUND(Specificities[1].sales_price_specificity - 13);
  integer2 sales_price_switch_shift0 := ROUND(1000*Specificities[1].sales_price_switch - 0);
  integer1 first_td_loan_amount_shift0 := ROUND(Specificities[1].first_td_loan_amount_specificity - 13);
  integer2 first_td_loan_amount_switch_shift0 := ROUND(1000*Specificities[1].first_td_loan_amount_switch - 0);
  integer1 lender_name_shift0 := ROUND(Specificities[1].lender_name_specificity - 7);
  integer2 lender_name_switch_shift0 := ROUND(1000*Specificities[1].lender_name_switch - 0);
  integer1 county_name_shift0 := ROUND(Specificities[1].county_name_specificity - 8);
  integer2 county_name_switch_shift0 := ROUND(1000*Specificities[1].county_name_switch - 0);
  integer1 primrange_shift0 := ROUND(Specificities[1].primrange_specificity - 13);
  integer2 primrange_switch_shift0 := ROUND(1000*Specificities[1].primrange_switch - 0);
  integer1 primname_shift0 := ROUND(Specificities[1].primname_specificity - 14);
  integer2 primname_switch_shift0 := ROUND(1000*Specificities[1].primname_switch - 0);
  integer1 secrange_shift0 := ROUND(Specificities[1].secrange_specificity - 13);
  integer2 secrange_switch_shift0 := ROUND(1000*Specificities[1].secrange_switch - 0);
  integer1 locale_shift0 := ROUND(Specificities[1].locale_specificity - 13);
  integer2 locale_switch_shift0 := ROUND(1000*Specificities[1].locale_switch - 0);
  integer1 address_shift0 := ROUND(Specificities[1].address_specificity - 25);
  integer2 address_switch_shift0 := ROUND(1000*Specificities[1].address_switch - 0);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT34.MAC_Specificity_Values(fips_code_values_persisted,fips_code,'fips_code',fips_code_specificity,fips_code_specificity_profile);
  SALT34.MAC_Specificity_Values(apnt_or_pin_number_values_persisted,apnt_or_pin_number,'apnt_or_pin_number',apnt_or_pin_number_specificity,apnt_or_pin_number_specificity_profile);
  SALT34.MAC_Specificity_Values(did_values_persisted,did,'did',did_specificity,did_specificity_profile);
  SALT34.MAC_Specificity_Values(name_values_persisted,name,'name',name_specificity,name_specificity_profile);
  SALT34.MAC_Specificity_Values(prim_range_alpha_values_persisted,prim_range_alpha,'prim_range_alpha',prim_range_alpha_specificity,prim_range_alpha_specificity_profile);
  SALT34.MAC_Specificity_Values(prim_range_num_values_persisted,prim_range_num,'prim_range_num',prim_range_num_specificity,prim_range_num_specificity_profile);
  SALT34.MAC_Specificity_Values(prim_name_num_values_persisted,prim_name_num,'prim_name_num',prim_name_num_specificity,prim_name_num_specificity_profile);
  SALT34.MAC_Specificity_Values(prim_name_alpha_values_persisted,prim_name_alpha,'prim_name_alpha',prim_name_alpha_specificity,prim_name_alpha_specificity_profile);
  SALT34.MAC_Specificity_Values(sec_range_alpha_values_persisted,sec_range_alpha,'sec_range_alpha',sec_range_alpha_specificity,sec_range_alpha_specificity_profile);
  SALT34.MAC_Specificity_Values(sec_range_num_values_persisted,sec_range_num,'sec_range_num',sec_range_num_specificity,sec_range_num_specificity_profile);
  SALT34.MAC_Specificity_Values(city_values_persisted,city,'city',city_specificity,city_specificity_profile);
  SALT34.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT34.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT34.MAC_Specificity_Values(recording_date_values_persisted,recording_date,'recording_date',recording_date_specificity,recording_date_specificity_profile);
  SALT34.MAC_Specificity_Values(SourceType_values_persisted,SourceType,'SourceType',SourceType_specificity,SourceType_specificity_profile);
  SALT34.MAC_Specificity_Values(contract_date_values_persisted,contract_date,'contract_date',contract_date_specificity,contract_date_specificity_profile);
  SALT34.MAC_Specificity_Values(document_number_values_persisted,document_number,'document_number',document_number_specificity,document_number_specificity_profile);
  SALT34.MAC_Specificity_Values(recorder_book_number_values_persisted,recorder_book_number,'recorder_book_number',recorder_book_number_specificity,recorder_book_number_specificity_profile);
  SALT34.MAC_Specificity_Values(recorder_page_number_values_persisted,recorder_page_number,'recorder_page_number',recorder_page_number_specificity,recorder_page_number_specificity_profile);
  SALT34.MAC_Specificity_Values(sales_price_values_persisted,sales_price,'sales_price',sales_price_specificity,sales_price_specificity_profile);
  SALT34.MAC_Specificity_Values(first_td_loan_amount_values_persisted,first_td_loan_amount,'first_td_loan_amount',first_td_loan_amount_specificity,first_td_loan_amount_specificity_profile);
  SALT34.MAC_Specificity_Values(lender_name_values_persisted,lender_name,'lender_name',lender_name_specificity,lender_name_specificity_profile);
  SALT34.MAC_Specificity_Values(county_name_values_persisted,county_name,'county_name',county_name_specificity,county_name_specificity_profile);
EXPORT AllProfiles := fips_code_specificity_profile + apnt_or_pin_number_specificity_profile + did_specificity_profile + name_specificity_profile + prim_range_alpha_specificity_profile + prim_range_num_specificity_profile + prim_name_num_specificity_profile + prim_name_alpha_specificity_profile + sec_range_alpha_specificity_profile + sec_range_num_specificity_profile + city_specificity_profile + st_specificity_profile + zip_specificity_profile + recording_date_specificity_profile + SourceType_specificity_profile + contract_date_specificity_profile + document_number_specificity_profile + recorder_book_number_specificity_profile + recorder_page_number_specificity_profile + sales_price_specificity_profile + first_td_loan_amount_specificity_profile + lender_name_specificity_profile + county_name_specificity_profile;
END;
