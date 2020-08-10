IMPORT Business_Header,ut;

EXPORT BestJoined(

  DATASET(Business_Header.Layout_Business_Header_Base) bh_base	= Business_Header.Files().Base.Business_Headers.Built
  ,STRING pPersistUnique	= ''

) := FUNCTION

bh_d_bdid := DISTRIBUTE(bh_base, HASH(bdid));

lbhb := Business_Header.Layout_BH_Best;

lbhb tobestlayout(bh_d_bdid l) := TRANSFORM
SELF := l;
SELF.DPPA_State := if(L.dppa, L.vendor_id[1..2], '');
END;
bh_best := DEDUP(SORT(PROJECT(bh_d_bdid,tobestlayout(LEFT)),bdid,LOCAL),bdid,LOCAL);
//bh_best := TABLE(bh_d_bdid, lbhb, bdid, LOCAL);

bestcompanyname_local := BestCompanyName(bh_base) : persist(_dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestCompanyName' + pPersistUnique);
lbhb JoinCompanyName(bh_best l, bestcompanyname_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF := r;
	SELF := l;
END;

bh_best_cn := JOIN(	bh_best, bestcompanyname_local,
					LEFT.bdid = RIGHT.bdid,
					JoinCompanyName(LEFT, RIGHT), LEFT OUTER, HASH);


bestaddress_local := BestAddress(bh_base) : persist(_dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestAddress' + pPersistUnique);

lbhb JoinAddress(bh_best l, bestaddress_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.best_flags := IF(0 != r.bdid,
				ut.SetFlag(l.best_flags, BestFlag_Address),
				l.best_flags);
	SELF := r;
	SELF := l;
END;

bh_best_cn_a := JOIN(	
					bh_best_cn, bestaddress_local,
					LEFT.bdid = RIGHT.bdid,
					JoinAddress(LEFT, RIGHT), LEFT OUTER, HASH);


bestphone_local := BestPhone(bh_base) : persist(_dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestPhone' + pPersistUnique);
lbhb JoinPhone(bh_best l, bestphone_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.best_flags := IF(0 != r.bdid, 
				ut.SetFlag(l.best_flags, BestFlag_Phone),
				l.best_flags);
	SELF := r;
	SELF := l;
END;

bh_best_cn_a_p := JOIN(	
					bh_best_cn_a, bestphone_local,
					LEFT.bdid = RIGHT.bdid,
					JoinPhone(LEFT, RIGHT), LEFT OUTER, HASH);


bestfein_local := BestFEIN(bh_base) : persist(_dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestFein' + pPersistUnique);
lbhb JoinFEIN(bh_best l, bestfein_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.best_flags := IF(0 != r.bdid,
				ut.SetFlag(l.best_flags, BestFlag_FEIN),
				l.best_flags);
	SELF := r;
	SELF := l;
END;

// This join stalls without the seemingly unnecessary distribute.
bh_best_cn_a_p_f := JOIN(	
					DISTRIBUTE(bh_best_cn_a_p, HASH(bdid)), DISTRIBUTE(bestfein_local, HASH(bdid)),
					LEFT.bdid = RIGHT.bdid,
					JoinFEIN(LEFT, RIGHT), LEFT OUTER, HASH, LOCAL);

return bh_best_cn_a_p_f;
end;