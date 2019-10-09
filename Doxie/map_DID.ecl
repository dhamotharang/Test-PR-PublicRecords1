import doxie, dx_header;

rec := doxie.layout_references;

export map_DID(dataset(rec) dids) := 
FUNCTION

k := dx_header.key_did_rid2();

rec tra(dids l, k r) := transform	
	self.did := if(r.did > 0, r.did, l.did);
end;

j := join(dids, k, 
				 left.did = right.rid,
				 tra(left, right), left outer, ATMOST (10), KEEP (1));

return j;

END;
