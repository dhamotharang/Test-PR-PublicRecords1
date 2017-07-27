import header;


dids_fat := dataset('CEMTEMP::Match_Base',header.Layout_Header,flat);

did_rec := record
	dids_fat.did;
end;

dids_dups := table(dids_fat, did_rec);
export Interesting_DIDs := dedup(dids_dups, did, all);