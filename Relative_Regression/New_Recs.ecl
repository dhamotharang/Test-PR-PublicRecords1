import header;
dids := interesting_dids;
new_rels := dataset('relatives_temp',header.Layout_Relatives,flat,__GROUPED__);

new1 := join(new_rels, dids,
			left.person1 = right.did,
			tra_flip(left, false), lookup);

new2 := join(new_rels, dids,
			left.person2 = right.did,
			tra_flip(left, true), lookup);

old := old_recs;
export new_recs := new1 + new2 : persist('new_recs');