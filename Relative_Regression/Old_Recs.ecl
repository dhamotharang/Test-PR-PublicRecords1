dids := interesting_dids;
old_rels := file_relatives_old;

old1 := join(old_rels, dids,
			left.person1 = right.did,
			tra_flip(left, false), lookup);

old2 := join(old_rels, dids,
			left.person2 = right.did,
			tra_flip(left, true), lookup);


export old_recs := old1 + old2 : persist('old_recs');