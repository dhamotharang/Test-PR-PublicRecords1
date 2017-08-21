import header, ut;

export FN_Patch_RID(dataset(header.Layout_Header) head0) :=
FUNCTION

dist0 := distribute(head0, hash(did));
dist := Header.FN_ResetDIDwForeignRID(dist0);

rec := record
	unsigned6 did;
	unsigned6 rid;
end;

//***** Identify the need

slim := project(dist, rec);
srt  := sort(slim, did, if(did = rid, 0, 1), rid, local);
ddp  := dedup(srt, did, local);
bad  := ddp(rid <> did);



//***** Make sure the DID is not a RID elsewhere
clear := join(bad, distribute(slim, hash(rid)), left.did = right.rid, left only, local);

temp_patch := record
	unsigned6 old_rid;
	recordof(dist);
end;


//***** Raise the lowest RID to be the DID
temp_patch patch(dist l, clear r) := transform
	self.old_rid := l.rid;
	self.rid := if(r.did > 0, r.did, l.rid);
	self := l;
end;

patched_t := join(dist, clear, left.rid = right.rid, patch(left, right), left outer, local);

patched := project(patched_t, recordof(dist));

//******Output Reset rid - Before/After
find_patched := project(patched_t(rid <> old_rid), transform(Header.Layout_PairMatch and not pflag, 
																																								self.new_rid := left.rid, 
																																								self := left));
																																							
find_patched_ded := dedup(sort(distribute(find_patched, hash(old_rid)),	old_rid, new_rid,local),old_rid, new_rid,local); 					 
output(find_patched_ded,, '~thor_data400::base::RidPatches' + thorlib.wuid(), overwrite);

ut.fn_AddStat(count(clear), 'Build Stats: RID patches');
return patched;


END;