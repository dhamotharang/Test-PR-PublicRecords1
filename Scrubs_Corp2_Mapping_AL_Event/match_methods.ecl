IMPORT SALT32,std;
EXPORT match_methods(DATASET(layout_in_file) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_event_filing_cd(TYPEOF(h.event_filing_cd) L, TYPEOF(h.event_filing_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
END;

