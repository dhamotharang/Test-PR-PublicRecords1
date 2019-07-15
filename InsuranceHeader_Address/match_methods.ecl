IMPORT SALT311,std;
EXPORT match_methods(DATASET(layout_Address_Link) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_DID(TYPEOF(h.DID) L, TYPEOF(h.DID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_range_alpha(TYPEOF(h.prim_range_alpha) L, TYPEOF(h.prim_range_alpha) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_range_num(TYPEOF(h.prim_range_num) L, TYPEOF(h.prim_range_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch,
	    SALT311.MatchBagOfWords(L,R,31744,1) <> 0 => SALT311.MatchCode.WordBagMatch,
    SALT311.MatchCode.NoMatch),
     MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_range_fract(TYPEOF(h.prim_range_fract) L, TYPEOF(h.prim_range_fract) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_name_num(TYPEOF(h.prim_name_num) L, TYPEOF(h.prim_name_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch,
	    SALT311.MatchBagOfWords(L,R,31744,1) <> 0 => SALT311.MatchCode.WordBagMatch,
    SALT311.MatchCode.NoMatch),
     MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_name_alpha(TYPEOF(h.prim_name_alpha) L, TYPEOF(h.prim_name_alpha) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch,
	    SALT311.MatchBagOfWords(L,R,31755,1) <> 0 => SALT311.MatchCode.WordBagMatch,
    SALT311.MatchCode.NoMatch),
     MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_sec_range_alpha(TYPEOF(h.sec_range_alpha) L, TYPEOF(h.sec_range_alpha) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_sec_range_num(TYPEOF(h.sec_range_num) L, TYPEOF(h.sec_range_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT311.MatchCode.InitialLMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT311.MatchCode.InitialRMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_city(TYPEOF(h.city) L, TYPEOF(h.city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch,
	    SALT311.MatchBagOfWords(L,R,31768,1) <> 0 => SALT311.MatchCode.WordBagMatch,
    SALT311.MatchCode.NoMatch),
     MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_addr(TYPEOF(h.addr) L,TYPEOF(h.addr) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_locale(TYPEOF(h.locale) L,TYPEOF(h.locale) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
END;
