import idl_header,InsuranceHeader_Ingest;

export fn_updateDID(dataset(InsuranceHeader_Ingest.Layout_Header_plus) head) := FUNCTION

rec := record
	unsigned8 did;
	unsigned8 rid;
end;

dist := distribute(head, hash(did)) ;
slim := project(dist, rec);
// srt  := sort(slim, did, if(did = rid, 0, 1), rid, local);
srt  := sort(slim, did, rid, local);
ddp  := dedup(srt, did, local);
bad  := ddp(rid <> did);
// bad_pub := bad(did < 140737488355328 and rid <  140737488355328);
// bad_ins := bad(did < 140737488355328 and rid >= 140737488355328);

// Append new DID
shared new_rec := record
	unsigned8 did;
	unsigned8 rid;
	unsigned8 new_did;
end;
dist_bad := distribute(bad, hash(did));
newdid := join(dist, dist_bad, left.did = right.did, transform(new_rec, self.new_did := right.rid, self := left), local);
srt_newdid := sort(newdid, did, rid, local);

// Append new DID to iHeader records.
hdr_w_newdid := join(dist, newdid, left.did = right.did and left.rid = right.rid, 
														transform(InsuranceHeader_Ingest.Layout_Header_plus, self.did := if(right.new_did > 0, right.new_did, left.did), self := left), left outer, local);
// output(count(dist));
// output(choosen(dist, 100));
// output(count(bad));
// output(srt);
// output(ddp);
// output(count(bad_ins));
// output(count(srt_newdid));
// output(choosen(srt_newdid, 100));		
// output(count(hdr_w_newdid));
// output(choosen(hdr_w_newdid, 1000));
												
return hdr_w_newdid ;
END;