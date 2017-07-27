import PropertyCharacteristics; 

// Returns in-house LN property data (clean addresses from the input are preserved)
// Note: input records are not preserved, if there's no match in inhouse data

export GetPropertyData (dataset (layouts.CleanAddressRec) indata_clean) := function

  ids := join (indata_clean, PropertyCharacteristics.Key_PropChar_Address,
               keyed (Left.prim_name = Right.prim_name) and
               keyed (Left.prim_range = Right.prim_range) and
               keyed (Left.zip = Right.zip) and
               keyed (Left.predir = Right.predir) and
               keyed (Left.postdir = Right.postdir) and
               keyed (Left.addr_suffix = Right.addr_suffix) and
               keyed (Left.sec_range = Right.sec_range),
               transform (layouts.SearchID, Self.acctno := Left.acctno, Self.property_rid := Right.property_rid),
               limit (Constants.MAX_IDS_PER_ADDRESS, skip)); // results should be unique, so dedup is not needed.

  // Get payload information from main file
  dPropPayload  :=  join (ids, PropertyCharacteristics.Key_PropChar_RID,
                          keyed (Left.property_rid  =  Right.property_rid),
                          transform (layouts.main, Self.acctno := Left.acctno, Self := Right),
                          limit (0), keep (1)); //1 : 1

  return dPropPayload;
end;
