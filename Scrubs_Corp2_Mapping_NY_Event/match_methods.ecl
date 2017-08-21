IMPORT SALT32,std;
EXPORT match_methods(DATASET(layout_in_file) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_corp_key(TYPEOF(h.corp_key) L, TYPEOF(h.corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_sos_charter_nbr(TYPEOF(h.corp_sos_charter_nbr) L, TYPEOF(h.corp_sos_charter_nbr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_event_filing_cd(TYPEOF(h.event_filing_cd) L, TYPEOF(h.event_filing_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
END;

