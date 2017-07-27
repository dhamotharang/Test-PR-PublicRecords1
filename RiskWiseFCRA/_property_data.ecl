IMPORT doxie, fcra, ln_propertyv2, suppress, riskwise;

// NOTE: function is not "batch-safe": if multiple DIDs ever going to be passed as an input,
// then correction records from the FlagFile should be checked for each DID individually.
// Right now there's no need to account for that.

boolean IsFCRA := true;
MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

// output tables' layouts
layout_fares_search := ln_propertyv2.layout_search_building;
layout_assessments := ln_propertyv2.layout_property_common_model_base;
layout_deeds := ln_propertyv2.layout_deed_mortgage_common_model_base;


unsigned2 MAX_PROP_KEEP  := 100;
unsigned4 MAX_PROP_MATCH := 5000;
nss_const := Suppress.Constants.NonSubjectSuppression; // for the future needs

EXPORT _property_data (dataset (layouts.didslim) bshell_dids, 
                       dataset (layouts.didslim) currAddr, 
                       dataset (layouts.didslim) prevAddr, 
                       boolean ssn_inquiry_match,
                       dataset (fcra.Layout_override_flag) flag_file,
                       integer nss = nss_const.doNothing
                       ) := MODULE


// First, property search records are found, filtered by fares which contained in correction file,
// then filtered by fares, belonging to "this" person only.
// Thus we will have "pure" fare search dataset, which later used for fetching assessments and deeds.
// Note that assess/deeds don't require filtering by "corrections" and "did", as only records with
// fare_id from clean search file are used.

  // correction records: fares, PUIDs, pointers to flag file
  shared assessment_fares := SET (flag_file (file_id = FCRA.FILE_ID.ASSESSMENT),record_id);
  shared assessment_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.ASSESSMENT), flag_file_id);

  shared deed_fares := SET (flag_file (file_id = FCRA.FILE_ID.DEED),record_id);
  shared deed_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.DEED), flag_file_id);

  shared search_puids := SET (flag_file (file_id = FCRA.FILE_ID.SEARCH),record_id);
  shared search_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.SEARCH), flag_file_id);

  // we need a combined list of fares from D & A:
  shared search_fares := assessment_fares + deed_fares;

  fares_layout := RECORD
    unsigned6 did;
    string12 own_fares_id;
  
    string10 prim_range;
    string2  predir;
    string28 prim_name;
    string4  suffix;
    string2  postdir;
    string10 unit_desig;
    string8  sec_range;
    string25 city_name;
    string2  st;
    string5  zip;
  END;

  key_prop_addr_fid := ln_propertyv2.key_addr_fid (IsFCRA);
  fares_layout GetPropertyByAddr (layouts.didslim L, key_prop_addr_fid R) := TRANSFORM
    SELF.own_fares_id := R.ln_fares_id;
    SELF := L;
  END;

  // Get property by address (filter out those for which corrections exist)
  by_address := JOIN (bshell_dids, key_prop_addr_fid,          
                      (left.did<>0 OR ssn_inquiry_match) and
                      Left.prim_name<>'' AND
                      keyed (Left.prim_name=Right.prim_name) AND
                      keyed (Left.prim_range=Right.prim_range) AND
                      keyed (Left.zip=Right.zip) AND
                      keyed (Left.predir=Right.predir) AND
                      keyed (Left.postdir=Right.postdir) AND
                      keyed (Left.suffix=Right.suffix) AND
                      keyed (Left.sec_range=Right.sec_range) and
                      keyed (right.source_code_2 = 'P') AND
                      (right.source_code_1 <> 'C') and // filter out "Care-Of" records
                      (Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
                      GetPropertyByAddr (Left, Right),
                      LEFT OUTER, atmost(riskwise.max_atmost), KEEP(MAX_PROP_KEEP));
  // Search with the current address
  by_address_curr := JOIN (currAddr, key_prop_addr_fid,          
                           Left.prim_name<>'' AND
                           keyed (Left.prim_name=Right.prim_name) AND
                           keyed (Left.prim_range=Right.prim_range) AND
                           keyed (Left.zip=Right.zip) AND
                           keyed (Left.predir=Right.predir) AND
                           keyed (Left.postdir=Right.postdir) AND
                           keyed (Left.suffix=Right.suffix) AND
                           keyed (Left.sec_range=Right.sec_range) and
                           keyed (right.source_code_2 = 'P') AND
                           (right.source_code_1 <> 'C') and // filter out "Care-Of" records
                           (Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
                           GetPropertyByAddr (Left, Right),
                           atmost(riskwise.max_atmost), KEEP(MAX_PROP_KEEP));
  // Search with the previous address
  by_address_prev := JOIN (prevAddr, key_prop_addr_fid,          
                           Left.prim_name<>'' AND
                           keyed (Left.prim_name=Right.prim_name) AND
                           keyed (Left.prim_range=Right.prim_range) AND
                           keyed (Left.zip=Right.zip) AND
                           keyed (Left.predir=Right.predir) AND
                           keyed (Left.postdir=Right.postdir) AND
                           keyed (Left.suffix=Right.suffix) AND
                           keyed (Left.sec_range=Right.sec_range) and
                           keyed (right.source_code_2 = 'P') AND
                           (right.source_code_1 <> 'C') and // filter out "Care-Of" records
                           (Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
                           GetPropertyByAddr (Left, Right),
                           atmost(riskwise.max_atmost), KEEP(MAX_PROP_KEEP));

  key_prop_did := ln_propertyv2.key_property_did (IsFCRA);
  fares_layout GetPropertyByDid (layouts.didslim L, key_prop_did R) := TRANSFORM
    SELF.own_fares_id := R.ln_fares_id;
    SELF := L; 
  END;

  // Get property by did (filter out those for which corrections exists)
  pre_property_by_did := JOIN (bshell_dids, key_prop_did,
                               Left.did<>0 AND 
                               keyed (Left.did = Right.s_did) and
                               keyed (Right.source_code_2 = 'P') AND
                               right.source_code[1] <> 'C' and // filter out "Care-Of" records
                               (Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
                               GetPropertyByDid (Left, Right), 
                               atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP));

  // adds in addresses on by_did records that don't have them
  key_prop_search_fid := ln_propertyv2.key_search_fid (IsFCRA);

  fares_layout GetAddress (fares_layout L, key_prop_search_fid R) := TRANSFORM
    SELF.prim_range  :=  IF (L.prim_range='',R.prim_range,L.prim_range);
    SELF.prim_name   :=  IF (L.prim_name='',R.prim_name,L.prim_name);
    SELF.st          :=  IF (L.st='',R.st,L.st);
    SELF.city_name   :=  IF (L.city_name='', R.v_city_name, L.city_name);
    SELF.zip         :=  IF (L.zip='',R.zip,L.zip);
    SELF.predir      :=  IF (L.predir='', R.predir, L.predir);
    SELF.postdir     :=  IF (L.postdir='',R.postdir,L.postdir);
    SELF.suffix      :=  IF (L.suffix='', R.suffix, L.suffix);
    SELF.sec_range   :=  IF (L.sec_range='',R.sec_range,L.sec_range);
    SELF := L;
  END;

  // add address and filter out those fares records that don't have no address
  by_did := JOIN (pre_property_by_did, key_prop_search_fid,
                  keyed(Left.own_fares_id=Right.ln_fares_id) AND
                  wild (Right.which_orig) AND
                  keyed(Right.source_code_2='P') AND
                  (Left.prim_name='' OR Left.prim_name=Right.prim_name) AND
                  (Left.prim_range='' OR Left.prim_range=Right.prim_range) AND
                  (Left.zip='' OR Left.zip=Right.zip),
                  GetAddress (Left, Right),
                  LEFT OUTER, atmost(riskwise.max_atmost)) (prim_name<>'' AND zip<>'');

  property_fid := DEDUP (SORT (by_address + by_did, RECORD), ALL);


  fares_search_full := JOIN (property_fid, key_prop_search_fid,
                        keyed (Left.own_fares_id = Right.ln_fares_id) and
                        ((string)Right.persistent_record_id NOT IN search_puids), // weed out corrected prop. records
                        TRANSFORM (layout_fares_search, SELF := Right),
                        ATMOST (MAX_PROP_MATCH));
  good_fares1 := JOIN (fares_search_full, bshell_dids,
                      left.did=right.did,
                      transform (layout_fares_search, self:=left),
                      LOOKUP);
  // good_fares is used for fetching assessments and deeds
  good_fares := DEDUP (SORT (good_fares1, RECORD), ALL);

  // do seperate searching for current and previous address so that we know to only keep the most recent
  // current

  curr_fares_search_full := JOIN (by_address_curr, key_prop_search_fid,
                                  keyed (Left.own_fares_id = Right.ln_fares_id) and
                                  ((string)Right.persistent_record_id NOT IN search_puids), // weed out corrected prop. records
                                  TRANSFORM (layout_fares_search, SELF := Right),
                                  ATMOST (MAX_PROP_MATCH));
                        
  curr_good_fares := DEDUP (SORT (curr_fares_search_full, RECORD), ALL);

  curr_fare_a := choosen(sort (curr_good_fares(source_code[1]='O' and ln_fares_id[2]='A'), -dt_last_seen),1);  // keep the most recent fares id for current address
  curr_fare_d := choosen(sort (curr_good_fares(source_code[1]='O' and ln_fares_id[2]='D'), -dt_last_seen),1);  // keep the most recent fares id for current address


  // previous
  prev_fares_search_full := JOIN (by_address_prev, key_prop_search_fid,
                                  keyed (Left.own_fares_id = Right.ln_fares_id) and
                                  ((string)Right.persistent_record_id NOT IN search_puids), // weed out corrected prop. records
                                  TRANSFORM (layout_fares_search, SELF := Right),
                                  ATMOST (MAX_PROP_MATCH));
                        
  prev_good_fares := DEDUP (SORT (prev_fares_search_full, RECORD), ALL);

  prev_fare_a := choosen(sort (prev_good_fares(source_code[1]='O' and ln_fares_id[2]='A'), -dt_last_seen),1);  // keep the most recent fares id for previous address
  prev_fare_d := choosen(sort (prev_good_fares(source_code[1]='O' and ln_fares_id[2]='D'), -dt_last_seen),1);  // keep the most recent fares id for previous address



  // add in the current and previous address fares for both assessor and deed
  curr_prev_fares_ad := DEDUP (SORT (curr_fare_a + prev_fare_a + curr_fare_d + prev_fare_d, RECORD), ALL);

  // still need to test corrections, since it is not by fares, but by persistent id.
  fplus_all := JOIN (curr_prev_fares_ad, key_prop_search_fid,
                     keyed (Left.ln_fares_id = Right.ln_fares_id) and
                     ((string)Right.persistent_record_id NOT IN search_puids),
                     TRANSFORM (layout_fares_search, SELF := Right),
                     ATMOST (MAX_PROP_MATCH));
                        
  shared dedup_good_fares := DEDUP (SORT (good_fares + if (nss = nss_const.doNothing, fplus_all), RECORD), ALL);

  fares_search1 := PROJECT (
    CHOOSEN (FCRA.key_override_property.search (keyed (flag_file_id IN search_ffid)), MAX_OVERRIDE_LIMIT),
    // temporarily, until override index will have persistent_id in the layout
    transform (layout_fares_search, Self := Left))
  + dedup_good_fares; 
    
  EXPORT search := SORT (fares_search1, -dt_last_seen, -dt_first_seen);

  // Now have did, own_fares_id, addresses -- all "good" records, which are not subject to corrections;
  // Next we take all search, assessments, deeds records: they will be filtered lately by did


  // format ASSESMENTS    
  layout_assessments ToAssessmentLayout (FCRA.key_override_property.assessment L) := TRANSFORM
    //the same way it is done in doxie_ln.key_assessor_fid_FCRA
    // SELF.proc_date := (unsigned) (IF (L.recording_date [1..6] !='', L.recording_date [1..6], L.sale_date[1..6]));
    SELF := L; // NB: input has a field "process_date"
  END;
  pre_assessments := JOIN (dedup_good_fares, ln_propertyv2.key_assessor_fid (true),
                       keyed (Left.ln_fares_id = Right.ln_fares_id),
                       TRANSFORM (layout_assessments, SELF := Right),
                       atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP))
  + PROJECT (CHOOSEN (FCRA.key_override_property.assessment (keyed (flag_file_id IN assessment_ffid)), MAX_OVERRIDE_LIMIT),
             ToAssessmentLayout (Left));
       
  deduped_assessments := DEDUP (SORT (pre_assessments, RECORD), ALL);
  EXPORT assessments := sort(deduped_assessments, -assessed_value_year, ln_fares_id);


  // format DEEDS    
  layout_deeds ToDeedLayout (FCRA.key_override_property.deed L) := TRANSFORM
    //the same way it is done in FCRA key_deed_fid
    // SELF.proc_date := (unsigned) (L.recording_date[1..6]);
    SELF := L; // NB: input has a field "process_date"
  END;
  pre_deeds := JOIN (dedup_good_fares, ln_propertyv2.key_deed_fid (true),
                     keyed (Left.ln_fares_id = Right.ln_fares_id) and
                     (Right.ln_fares_id NOT IN deed_fares),
                     TRANSFORM (layout_deeds, SELF := Right),
                     atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP))
  + PROJECT (CHOOSEN (FCRA.key_override_property.deed (keyed (flag_file_id IN deed_ffid)), MAX_OVERRIDE_LIMIT),
             ToDeedLayout (Left));

  deduped_deeds := DEDUP (SORT (pre_deeds, RECORD), ALL);
  EXPORT deeds := sort(deduped_deeds, -contract_date, ln_fares_id);

END;