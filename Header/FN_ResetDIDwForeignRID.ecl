import ut, doxie;

export FN_ResetDIDwForeignRID(dataset(header.Layout_Header) head) :=
FUNCTION

rec := record
	unsigned6 did;
	unsigned6 rid;
end;

//***** Identify the need
dist := distributed(head, hash(did));
slim := project(dist, rec);
srt  := sort(slim, did, if(did = rid, 0, 1), rid, local);
ddp  := dedup(srt, did, local);
bad  := ddp(rid <> did);



//***** Find the DID that is a RID elsewhere
dids1 := join(bad, distribute(slim, hash(rid)), left.did = right.rid, transform(doxie.layout_references, self := left), local);

//***** Find the DID that has a lower RID
dids2 := project(slim(rid < did), doxie.layout_references);

dids := dedup(dids1 + dids2, all);

//***** Reset the DID
dist patch(dist l, dids r) := transform
	self.did := if(r.did > 0, l.rid, l.did);  //reset to RID
	self := l;
end;

patched := join(dist, dids, left.did = right.did, patch(left, right), left outer, local);

ut.fn_AddStat(count(dids1), 'Build Stats: DIDs reset to RID 1');
ut.fn_AddStat(count(dids2), 'Build Stats: DIDs reset to RID 2');
output(dids,, '~thor_data400::base::DIDsResetToRID' + thorlib.wuid(), overwrite);
return patched;


END;