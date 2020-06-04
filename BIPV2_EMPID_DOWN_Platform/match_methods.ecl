IMPORT SALT32,std;
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
EXPORT match_methods(DATASET(layout_EmpID) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_orgid(TYPEOF(h.orgid) L, TYPEOF(h.orgid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_contact_ssn(TYPEOF(h.contact_ssn) L, TYPEOF(h.contact_ssn) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    BIPV2_Tools.fn_Right4(L) =  BIPV2_Tools.fn_Right4(R) => SALT32.MatchCode.CustomFuzzyMatch, // Compare BIPV2_Tools.fn_Right4 values
    SALT32.WithinEditNew(L,LL,R,RL,1, 0) => SALT32.MatchCode.EditDistanceMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_contact_did(TYPEOF(h.contact_did) L, TYPEOF(h.contact_did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.HyphenMatch(L,R,3)<=2 => SALT32.MatchCode.HyphenMatch,
    SALT32.WithinEditNew(L,LL,R,RL,1, 0) => SALT32.MatchCode.EditDistanceMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.WithinEditNew(L,LL,R,RL,1, 0) => SALT32.MatchCode.EditDistanceMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT32.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT32.MatchCode.InitialMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    BIPV2_Tools.fn_PreferredName(L) =  BIPV2_Tools.fn_PreferredName(R) => SALT32.MatchCode.CustomFuzzyMatch, // Compare BIPV2_Tools.fn_PreferredName values
    SALT32.WithinEditNew(L,LL,R,RL,1, 0) => SALT32.MatchCode.EditDistanceMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT32.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT32.MatchCode.InitialMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    BIPV2_Tools.fn_normSuffix(L) =  BIPV2_Tools.fn_normSuffix(R) => SALT32.MatchCode.CustomFuzzyMatch, // Compare BIPV2_Tools.fn_normSuffix values
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
END;
