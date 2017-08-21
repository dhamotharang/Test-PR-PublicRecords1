
export ProcessFinalLssiHistory(dataset(Layout_History) lssi, dataset(layout_gongMaster) neu, string8 asof) := FUNCTION

nu := DEDUP(SORT(DISTRIBUTE(neu(phone10<>'',did<>0), hash(phone10,did)), phone10, did, local), phone10, did, local);

candidates := DISTRIBUTE(lssi((integer)phone10<>0,did<>0), hash(phone10,did));

matches := JOIN(candidates, nu, left.phone10=right.phone10 and left.did=right.did,
									TRANSFORM(Layout_History,
											self.current_record_flag := '';
											self.deletion_date := '';			// marks this as a removed record
											self := left;), INNER);

// these don't match a phone/did combination											
nomatches := JOIN(candidates, nu, left.phone10=right.phone10 and left.did=right.did,
									TRANSFORM(Layout_History,
											self.current_record_flag := '';
											self.deletion_date := asof;	
											self := left;), LEFT ONLY);

// try to match on a business
nbiz := DEDUP(SORT(DISTRIBUTE(neu(phone10<>'',proxid<>0), hash(phone10,proxid)), phone10, proxid, local), phone10, proxid, local);
bizcandidates := lssi((integer)phone10<>0, did=0, proxid<>0);
bizmatch := JOIN(bizcandidates, nbiz, left.phone10=right.phone10 and left.proxid=right.proxid,
									TRANSFORM(Layout_History,
											self.current_record_flag := '';
											self.deletion_date := '';			// marks this as a removed record
											self := left;), INNER);

nobizmatch := JOIN(bizcandidates, nbiz, left.phone10=right.phone10 and left.proxid=right.proxid,
									TRANSFORM(Layout_History,
											self.current_record_flag := '';
											self.deletion_date := asof;
											self := left;), LEFT ONLY);

nophone := PROJECT(lssi((integer)phone10=0), 
									TRANSFORM(Layout_History,
											self.current_record_flag := '';
											self.deletion_date := asof;
											self := left;));
leftovers := PROJECT(lssi((integer)phone10<>0, did=0, proxid=0),
									TRANSFORM(Layout_History,
											self.current_record_flag := '';
											self.deletion_date := asof;
											self := left;));


return matches & nomatches & bizmatch & nobizmatch & leftovers & nophone;

END;