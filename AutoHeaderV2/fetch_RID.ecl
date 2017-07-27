IMPORT ut,doxie,AutoHeaderV2;

export fetch_RID (dataset (AutoHeaderV2.layouts.search) _in) := function
  kHdrRid := doxie.key_header_rid(false,false);
  kQHRid  := doxie.key_header_rid(true,false);
  
  //NB: inner join; we might want to change it for real batch implementation
  key_hdr_read := join (_in, kHdrRid,
                        keyed (Left.rid = Right.rid),
                        transform (AutoHeaderV2.layouts.search_out, Self.did := Right.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.RID),
                        LIMIT (0), keep (1));
  
  key_qh_read := join (_in, kQHRid,
                        keyed (Left.rid = Right.rid),
                        transform (AutoHeaderV2.layouts.search_out, Self.did := Right.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.RID),
                        LIMIT (0), keep (1));
  
  key_read := key_hdr_read + key_qh_read;
  
  return if(exists(key_read), key_read, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.RID, 
																												AutoHeaderV2.Constants.STATUS._NOT_FOUND)); 

end;
