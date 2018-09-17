IMPORT IDLExternalLinking;

EXPORT fetch_SaltID(dataset (AutoHeaderV2.layouts.search) _in) := function
	
	// for payload interface it does not matter if you are searching for rid or did, they are both treated as id.
	unsigned8 id := IF(_in[1].did >0, _in[1].did, _in[1].rid);
	results := project(DEDUP(SORT(IDLExternalLinking.did_getAllRecs(id), DID), DID), transform (AutoHeaderV2.layouts.search_out, 
					self.did := left.did, 
					self.seq := _in[1].seq,
					Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.SALT, 	// maybe we should have a new fetch hit called SALT				
					self.index_hit := 1, 
					self.score := 100,
					self.status := 0, 
					self.err_code := 0));																	
	return if(exists(results), results, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.RID, 
																												AutoHeaderV2.Constants.STATUS._NOT_FOUND));

end;