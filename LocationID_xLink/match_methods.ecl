IMPORT SALT37,std;
EXPORT match_methods(DATASET(layout_LocationId) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_prim_name_derived(TYPEOF(h.prim_name_derived) L, TYPEOF(h.prim_name_derived) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_addr_suffix_derived(TYPEOF(h.addr_suffix_derived) L, TYPEOF(h.addr_suffix_derived) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_err_stat(TYPEOF(h.err_stat) L, TYPEOF(h.err_stat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
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
    fn_ZipMatch((STRING5)L,(STRING5)R) => SALT37.MatchCode.CustomFuzzyMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
END;
