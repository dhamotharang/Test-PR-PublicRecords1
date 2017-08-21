import ut;

export Fn_RidDidStats(dataset(header.Layout_Header) f, string suffix = '') := 
FUNCTION

r := record
  f.did;
	f.rid;
	end;
	
ta := distribute( table(f,r), hash(did) );

lead_records := ta(rid=did);
rid_lt_did_violations := ta(rid<did);

unique_dids := dedup( sort( table(ta,{did}), did, local ), did, local );


did_norid := join(unique_dids,lead_records,left.did=right.did,transform(left),left only,local);

Foreign := join(did_norid,ta,left.did=right.rid,transform(left),hash,local);
Orphaned := join(did_norid,Foreign,left.did=right.did,left only,hash);


stats := parallel(
ut.fn_AddStat(count(rid_lt_Did_violations), 'DID Stats: RID less than DID' + suffix),
ut.fn_AddStat(count(did_norid), 'DID Stats: DID does not contain matching RID' + suffix),
ut.fn_AddStat(count(Foreign), 'DID Stats: matching RID in other DID' + suffix)
);

return stats;

END;