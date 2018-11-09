IMPORT SALT37,std;
EXPORT match_methods(DATASET(layout_LocationId) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	_CFG.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.HyphenMatch(L,R,1)<=1 => SALT37.MatchCode.HyphenMatch,
	_CFG.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_addr_suffix(TYPEOF(h.addr_suffix) L, TYPEOF(h.addr_suffix) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	_CFG.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	_CFG.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	_CFG.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.HyphenMatch(L,R,1)<=1 => SALT37.MatchCode.HyphenMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	_CFG.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_zip5(TYPEOF(h.zip5) L, TYPEOF(h.zip5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
END;
