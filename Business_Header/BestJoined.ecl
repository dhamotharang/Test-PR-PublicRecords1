IMPORT Business_Header;

EXPORT BestJoined(

	 DATASET(business_header.Layout_Business_Header_Base) bh_base					= Business_Header.Files().Base.Business_Headers.Built
	,STRING																								pPersistUnique	= ''
	,BOOLEAN best_poss_non_DandB = FALSE

) := FUNCTION

bh_d_bdid := DISTRIBUTE(bh_base, HASH(bdid));

lbhb := 
RECORD
	Business_Header.Layout_BH_Best;
	QSTRING34 vendor_id;
END;

lbhb_only := Business_Header.Layout_BH_Best;

lbhb tobestlayout(bh_d_bdid l) := TRANSFORM
SELF := l;
SELF.DPPA_State := if(L.dppa, L.vendor_id[1..2], '');
SELF := [];
END;
bh_best := DEDUP(SORT(PROJECT(bh_d_bdid,tobestlayout(left)),bdid, -dt_last_seen,LOCAL),bdid,LOCAL);
//bh_best := TABLE(bh_d_bdid, lbhb, bdid, LOCAL);

bestcompanyname_local := Business_Header.BestCompanyName(bh_base) : PERSIST(Business_Header._dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestCompanyName' + pPersistUnique);
lbhb JoinCompanyName(bh_best l, bestcompanyname_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF := r;
	SELF := l;
END;

bh_best_cn := JOIN(	bh_best, bestcompanyname_local,
					LEFT.bdid = RIGHT.bdid,
					JoinCompanyName(LEFT, RIGHT), LEFT OUTER, HASH);


bestaddress_local := Business_Header.BestAddress(bh_base,best_poss_non_DandB) : PERSIST(Business_Header._dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestAddress' + pPersistUnique);

lbhb JoinAddress(bh_best l, bestaddress_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.best_flags := IF(0 != r.bdid,
				Business_Header.SetFlag(l.best_flags, BestFlag_Address),
				l.best_flags);
	SELF := r;
	SELF := l;
END;

bh_best_cn_a := JOIN(	
					bh_best_cn, bestaddress_local,
					LEFT.bdid = RIGHT.bdid,
					JoinAddress(LEFT, RIGHT), LEFT OUTER, HASH);


bestphone_local := Business_Header.BestPhone(bh_base,best_poss_non_DandB) : PERSIST(Business_Header._dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestPhone' + pPersistUnique);
lbhb JoinPhone(bh_best l, bestphone_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.best_flags := IF(0 != r.bdid, 
				Business_Header.SetFlag(l.best_flags, BestFlag_Phone),
				l.best_flags);
	SELF := r;
	SELF := l;
END;

bh_best_cn_a_p := JOIN(	
					bh_best_cn_a, bestphone_local,
					LEFT.bdid = RIGHT.bdid,
					JoinPhone(LEFT, RIGHT), LEFT OUTER, HASH);


bestfein_local := Business_Header.BestFEIN(bh_base) : PERSIST(Business_Header._dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestFein' + pPersistUnique);
lbhb JoinFEIN(bh_best l, bestfein_local r) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.best_flags := IF(0 != r.bdid,
				Business_Header.SetFlag(l.best_flags, BestFlag_FEIN),
				l.best_flags);
	SELF := r;
	SELF := l;
END;

// This join stalls without the seemingly unnecessary distribute.
bh_best_cn_a_p_f := JOIN(	
					DISTRIBUTE(bh_best_cn_a_p, HASH(bdid)), DISTRIBUTE(bestfein_local, HASH(bdid)),
					LEFT.bdid = RIGHT.bdid,
					JoinFEIN(LEFT, RIGHT), LEFT OUTER, HASH, LOCAL);

//* Get best Dt_last_seen dates for best file.	
bestDtLastSeen_local := Business_Header.BestDtLastSeen(bh_base) : PERSIST(Business_Header._dataset().thor_cluster_Persists + 'persist::Business_Header::BestJoined::BestDtLastSeen' + pPersistUnique);
lbhb JoinDtLastSeen(bh_best l, bestDtLastSeen_local r) := TRANSFORM
	SELF.bdid 				:= l.bdid;
	SELF.dt_last_seen	:= r.dt_last_seen;
	SELF 							:= l;
END;

bh_best_cn_a_p_f_d := JOIN(	
					DISTRIBUTE(bh_best_cn_a_p_f, HASH(bdid)), DISTRIBUTE(bestDtLastSeen_local, HASH(bdid)),
					LEFT.bdid = RIGHT.bdid,
					JoinDtLastSeen(LEFT, RIGHT), LEFT OUTER, HASH, LOCAL);
	
dout 					:= bh_best_cn_a_p_f_d;

doutdecision := dout;

dout_proj := PROJECT(doutdecision	,TRANSFORM(lbhb_only, SELF := LEFT));

RETURN dout_proj;
	
END;