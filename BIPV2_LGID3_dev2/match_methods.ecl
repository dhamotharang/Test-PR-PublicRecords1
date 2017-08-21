IMPORT SALT30,std;
EXPORT match_methods(DATASET(layout_LGID3) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_sbfe_id(TYPEOF(h.sbfe_id) L, TYPEOF(h.sbfe_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_source_record_id(TYPEOF(h.source_record_id) L, TYPEOF(h.source_record_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_company_name(TYPEOF(h.company_name) L, TYPEOF(h.company_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchBagOfWords(L,R,2128912,1) <> 0 => SALT30.MatchCode.WordBagMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_cnp_number(TYPEOF(h.cnp_number) L, TYPEOF(h.cnp_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_active_duns_number(TYPEOF(h.active_duns_number) L, TYPEOF(h.active_duns_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_duns_number(TYPEOF(h.duns_number) L, TYPEOF(h.duns_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_duns_number_concept(TYPEOF(h.duns_number_concept) L,TYPEOF(h.duns_number_concept) R) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_company_fein(TYPEOF(h.company_fein) L, TYPEOF(h.company_fein) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_company_inc_state(TYPEOF(h.company_inc_state) L, TYPEOF(h.company_inc_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_company_charter_number(TYPEOF(h.company_charter_number) L, TYPEOF(h.company_charter_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_cnp_btype(TYPEOF(h.cnp_btype) L, TYPEOF(h.cnp_btype) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
END;
