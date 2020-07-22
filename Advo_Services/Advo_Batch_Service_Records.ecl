import Address, Advo, doxie;

export Advo_Batch_Service_Records(
   dataset(Advo_Batch_Service_Layouts.Batch_In) in_data = dataset([],Advo_Batch_Service_Layouts.Batch_In),
   boolean doBadSecRange = false,
   boolean include_all_sec_ranges = false) := function

  // Clean the input data, provide a seq number for uniqueness
  cleaned_data := project(in_data,transform(Advo_Batch_Service_Layouts.Batch_Post_In,
    self.__seq := counter,
    addressParts := address.CleanAddressFieldsFips(doxie.CleanAddress182(left.addr, trim(left.city,left,right) + ' ' + trim(left.state,left,right) + ' ' + trim(left.zip,left,right)));
    self.clean_address := addressParts.addressrecord,
    self := left));
  
  // Define keyfiles
  key_zip := Advo.Key_Addr1;
  key_city_state := Advo.Key_Addr2;

  // 1. Strict matches: must be exact match on all parts -- including sec range being blank.
  
  // 1.a. Look up data by address (using ZIP)
  records_from_key_zip := join(cleaned_data,key_zip,
    keyed(left.Clean_Address.zip != '' and left.Clean_Address.zip = right.zip) and
    keyed(left.Clean_Address.prim_range = right.prim_range) and
    keyed(left.Clean_Address.prim_name = right.prim_name) and
    keyed(left.Clean_Address.addr_suffix = right.addr_suffix) and
    keyed(left.Clean_Address.predir = right.predir) and
    keyed(left.Clean_Address.postdir = right.postdir) and
    keyed(left.Clean_Address.sec_range = right.sec_range),
    transform(Advo_Batch_Service_Layouts.Batch_Pre_Out,
      // Take all the Advo fields
      self := right,
      // And the acctno field
      self := left),
    keep(1));
  
  // 1.b. Look up data by address (using City/State)
  records_from_key_city_state := join(cleaned_data,key_city_state,
    keyed(left.Clean_Address.zip = '' and left.Clean_Address.st != '' and left.Clean_Address.v_city_name != '' and left.Clean_Address.st = right.st) and
    keyed(left.Clean_Address.v_city_name = right.v_city_name) and
    keyed(left.Clean_Address.prim_range = right.prim_range) and
    keyed(left.Clean_Address.prim_name = right.prim_name) and
    keyed(left.Clean_Address.sec_range = right.sec_range),
    transform(Advo_Batch_Service_Layouts.Batch_Pre_Out,
      // Take all the Advo fields
      self := right,
      // And the acctno field
      self := left),
    keep(1));
  
  // 1.c. Concatenate the two results. Define a meta-pass.
  pass1_recs := records_from_key_zip + records_from_key_city_state;
  addrMetaPass1 := pass1_recs(sec_range = '' or address_type <> ''); // found Advo or not apt

  // 2. Exception case (non-strict) matches: must be exact match on all parts -- except sec_range.
  // Keep at most 1 matching record.
  //
  // Sometimes the user will provide a house address and include a sec_range by mistake. We overcome
  // this problem by running the key joins again and ignoring the sec_range altogether. The ATMOST(1)
  // ensures that we retain the matching record if one and only one matching record exists. If more
  // than one matching record exists, then what we have is an apartment or office building. We don't
  // want those here. If parameter is true for doBadSecRange then perform second pass of both keys
  // without sec_range. ATMOST on JOIN causes only those with 1 row found will get the metadata.
    
  // Make second pass for those that didn't find MetaData row and had sec_range (apt#).
  cleaned_data2 := join(cleaned_data, addrMetaPass1, left.__seq=right.__seq,
                      transform(Advo_Batch_Service_Layouts.Batch_Post_In, self := left),LEFT ONLY); // only want those NOT found on right.
  
  // 2.a. Look up data by address (using ZIP)--note: no match on sec_range
  records_from_key_zip2 := join(cleaned_data2,key_zip,
    keyed(left.Clean_Address.zip != '' and left.Clean_Address.zip = right.zip) and
    keyed(left.Clean_Address.prim_range = right.prim_range) and
    keyed(left.Clean_Address.prim_name = right.prim_name) and
    keyed(left.Clean_Address.addr_suffix = right.addr_suffix) and
    keyed(left.Clean_Address.predir = right.predir) and
    keyed(left.Clean_Address.postdir = right.postdir),
    transform(Advo_Services.Advo_Batch_Service_Layouts.Batch_Pre_Out,
      // Take all the Advo fields
      self := right,
      // And the acctno field
      self := left),
    atmost(1));
  
  // 2.b. Look up data by address (using City/State)--note: no match on sec_range
  records_from_key_city_state2 := join(cleaned_data2,key_city_state,
    keyed(left.Clean_Address.zip = '' and left.Clean_Address.st != '' and left.Clean_Address.v_city_name != '' and left.Clean_Address.st = right.st) and
    keyed(left.Clean_Address.v_city_name = right.v_city_name) and
    keyed(left.Clean_Address.prim_range = right.prim_range) and
    keyed(left.Clean_Address.prim_name = right.prim_name),
    transform(Advo_Services.Advo_Batch_Service_Layouts.Batch_Pre_Out,
      // Take all the Advo fields
      self := right,
      // And the acctno field
      self := left),
    atmost(1));
  
  // 2.c. Concatenate the two results. Define a second meta-pass.
  pass2_recs := records_from_key_zip2 + records_from_key_city_state2 ;
  
  // 3. Exception case (non-strict) matches: must be exact match on all parts -- except sec_range.
  // Keeping up to 1000 matching records.
  //
  // Sometimes the input record will be that of a building address (i.e. has no sec_range). The
  // intent here is to find all units (and their metadata) within the building, even if the first
  // two joins found metadata for the building itself.
    
  cleaned_data3 := cleaned_data( TRIM(clean_address.sec_range) = '' );
  
  // 3.a. Look up data by address (using ZIP)--note: no match on sec_range
  records_from_key_zip3 := join(cleaned_data3,key_zip,
    keyed(left.Clean_Address.zip != '' and left.Clean_Address.zip = right.zip) and
    keyed(left.Clean_Address.prim_range = right.prim_range) and
    keyed(left.Clean_Address.prim_name = right.prim_name) and
    keyed(left.Clean_Address.addr_suffix = right.addr_suffix) and
    keyed(left.Clean_Address.predir = right.predir) and
    keyed(left.Clean_Address.postdir = right.postdir),
    transform(Advo_Services.Advo_Batch_Service_Layouts.Batch_Pre_Out,
      // Take all the Advo fields
      self := right,
      // And the acctno field
      self := left),
    keep(1000));
  
  // 3.b. Look up data by address (using City/State)--note: no match on sec_range
  records_from_key_city_state3 := join(cleaned_data3,key_city_state,
    keyed(left.Clean_Address.zip = '' and left.Clean_Address.st != '' and left.Clean_Address.v_city_name != '' and left.Clean_Address.st = right.st) and
    keyed(left.Clean_Address.v_city_name = right.v_city_name) and
    keyed(left.Clean_Address.prim_range = right.prim_range) and
    keyed(left.Clean_Address.prim_name = right.prim_name),
    transform(Advo_Services.Advo_Batch_Service_Layouts.Batch_Pre_Out,
      // Take all the Advo fields
      self := right,
      // And the acctno field
      self := left),
    keep(1000));
  
  // 3.c. Concatenate the two results
  pass3_recs := records_from_key_zip3 + records_from_key_city_state3 ;
  
  // 4. Choose which datasets are returnable based on formal parameter values.
  returnable_records :=
    MAP(
      include_all_sec_ranges AND doBadSecRange => pass1_recs + pass2_recs + pass3_recs,
      include_all_sec_ranges => pass1_recs + pass3_recs,
      doBadSecRange => pass1_recs + pass2_recs,
      /* default............................ */ pass1_recs
    );
  
  // Sort records by seq number
  deduped_records := sort( dedup(returnable_records, whole record, all), __seq );
  
  // Project into final layout, using cleaned data.
  final_records := project(deduped_records,transform(Advo_Batch_Service_Layouts.Batch_Out,
    self := left));
  
  // OUTPUT( pass1_recs, NAMED('pass1_recs') );
  // OUTPUT( pass2_recs, NAMED('pass2_recs') );
  // OUTPUT( pass3_recs, NAMED('pass3_recs') );
  // OUTPUT( returnable_records, NAMED('returnable_records') );
  // OUTPUT( deduped_records, NAMED('deduped_records') );
  
  return final_records;

end;
