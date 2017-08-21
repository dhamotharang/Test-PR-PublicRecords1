import header, ut;

export FN_Patch_RID(dataset({unsigned8 old_rid,header.Layout_New_Records}) head0) :=
FUNCTION

dist0 := distribute(head0, hash(did));
dist := jbello_stuff.FN_ResetDIDwForeignRID(dist0);

rec := record
	unsigned6 did;
	unsigned6 rid;
end;

//***** Identify the need

slim := project(dist, rec);
srt  := sort(slim, did, if(did = rid, 0, 1), rid, local);
ddp  := dedup(srt, did, local);
bad  := ddp(rid <> did);

// output(bad,named('FN_Patch_RID_bad'));

//***** Make sure the DID is not a RID elsewhere
clear := join(bad, distribute(slim, hash(rid)), left.did = right.rid, left only, local);



//***** Raise the lowest RID to be the DID
dist patch(dist l, clear r) := transform
	self.rid := if(r.did > 0, r.did, l.rid);
	self.old_rid := if(r.did > 0, l.rid, l.old_rid);
	self.pflag1 := if(r.did > 0, '2', l.pflag1);
	self := l;
end;

patched := join(dist, clear, left.rid = right.rid, patch(left, right), left outer, local);

ut.fn_AddStat(count(clear), 'Build Stats: RID patches');
return patched;


END;