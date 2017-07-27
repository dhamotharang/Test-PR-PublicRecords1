import doxie;
rec := doxie.layout_references;

export map_DID(dataset(rec) dids) := 
FUNCTION

k := Doxie.Key_Did_Rid2;

rec tra(dids l, k r) := transform	
	self.did := if(r.did > 0, r.did, l.did);
end;

j := join(dids, k, 
				 left.did = right.rid,
				 tra(left, right), left outer, ATMOST (10), KEEP (1));

return j;

END;
