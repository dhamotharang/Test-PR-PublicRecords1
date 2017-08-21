IMPORT SALT35,std;
EXPORT match_methods(DATASET(layout_POWID_Down) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_orgid(TYPEOF(h.orgid) L, TYPEOF(h.orgid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT35.MatchCode.ExactMatch,
    SALT35.MatchCode.NoMatch),
        MAP(L = R => SALT35.MatchCode.ExactMatch, SALT35.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT35.MatchCode.ExactMatch,
    SALT35.MatchCode.NoMatch),
        MAP(L = R => SALT35.MatchCode.ExactMatch, SALT35.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT35.MatchCode.ExactMatch,
    SALT35.MatchCode.NoMatch),
        MAP(L = R => SALT35.MatchCode.ExactMatch, SALT35.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT35.MatchCode.ExactMatch,
    SALT35.MatchCode.NoMatch),
        MAP(L = R => SALT35.MatchCode.ExactMatch, SALT35.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT35.MatchCode.ExactMatch,
    SALT35.MatchCode.NoMatch),
        MAP(L = R => SALT35.MatchCode.ExactMatch, SALT35.MatchCode.NoMatch)
);
EXPORT match_csz(TYPEOF(h.csz) L,TYPEOF(h.csz) R) := 
   MAP(L = R => SALT35.MatchCode.ExactMatch,
	SALT35.MatchCode.NoMatch);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT35.MatchCode.ExactMatch,
    SALT35.MatchCode.NoMatch),
        MAP(L = R => SALT35.MatchCode.ExactMatch, SALT35.MatchCode.NoMatch)
);
EXPORT match_addr1(TYPEOF(h.addr1) L,TYPEOF(h.addr1) R) := 
   MAP(L = R => SALT35.MatchCode.ExactMatch,
	SALT35.MatchCode.NoMatch);
EXPORT match_address(TYPEOF(h.address) L,TYPEOF(h.address) R) := 
   MAP(L = R => SALT35.MatchCode.ExactMatch,
	SALT35.MatchCode.NoMatch);
END;
