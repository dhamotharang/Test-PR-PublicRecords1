IMPORT ut,doxie,AutoHeaderV2;

export fetch_did (dataset (AutoHeaderV2.layouts.search) ds_search) :=  function

  search_dids := project (ds_search, transform (doxie.layout_references, Self.did := Left.did));

  dids := doxie.map_DID (search_dids);
                   
  //? I'm very hesitant declaring input dataset as GROUPED by seq-number (for batch purposes),
  // although this might(?) be more efficient in deduping; something for later considerations
  res := project (dedup (dids, did, all), 
                  transform (AutoHeaderV2.layouts.search_out, Self.did := Left.did, self.fetch_hit := AutoHeaderV2.Constants.FetchHit.DID));

  return if(exists(res), res, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.DID, AutoHeaderV2.Constants.STATUS._NOT_FOUND));
end;
