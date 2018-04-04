IMPORT SALT38,std;
EXPORT match_methods(DATASET(layout_BizHead) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_empid(TYPEOF(h.empid) L, TYPEOF(h.empid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_powid(TYPEOF(h.powid) L, TYPEOF(h.powid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_source(TYPEOF(h.source) L, TYPEOF(h.source) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_source_record_id(TYPEOF(h.source_record_id) L, TYPEOF(h.source_record_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_cnp_number(TYPEOF(h.cnp_number) L, TYPEOF(h.cnp_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_cnp_btype(TYPEOF(h.cnp_btype) L, TYPEOF(h.cnp_btype) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_cnp_lowv(TYPEOF(h.cnp_lowv) L, TYPEOF(h.cnp_lowv) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_cnp_name(TYPEOF(h.cnp_name) L, TYPEOF(h.cnp_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT38.WordBagsEqual(L,R) => SALT38.MatchCode.ExactMatch,
    SALT38.MatchBagOfWords(L,R,31744,0) <> 0 => SALT38.MatchCode.WordBagMatch,
    SALT38.MatchCode.NoMatch),
        MAP(SALT38.WordBagsEqual(L,R) => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_company_phone(TYPEOF(h.company_phone) L, TYPEOF(h.company_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_company_fein(TYPEOF(h.company_fein) L, TYPEOF(h.company_fein) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_company_sic_code1(TYPEOF(h.company_sic_code1) L, TYPEOF(h.company_sic_code1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_p_city_name(TYPEOF(h.p_city_name) L, TYPEOF(h.p_city_name) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_zip_el(TYPEOF(h.zip) L, SET OF TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L IN R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L IN R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_company_url(TYPEOF(h.company_url) L, TYPEOF(h.company_url) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT38.WordBagsEqual(L,R) => SALT38.MatchCode.ExactMatch,
    SALT38.MatchBagOfWords(L,R,31744,0) <> 0 => SALT38.MatchCode.WordBagMatch,
    SALT38.MatchCode.NoMatch),
        MAP(SALT38.WordBagsEqual(L,R) => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_isContact(TYPEOF(h.isContact) L, TYPEOF(h.isContact) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_title(TYPEOF(h.title) L, TYPEOF(h.title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT38.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT38.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT38.MatchCode.EditDistanceMatch,
    fn_PreferredName(L) =  fn_PreferredName(R) => SALT38.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT38.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT38.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,2, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.HyphenMatch(L,R,1)<=2 => SALT38.MatchCode.HyphenMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT38.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT38.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,2, 0) => SALT38.MatchCode.EditDistanceMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    fn_normSuffix(L) =  fn_normSuffix(R) => SALT38.MatchCode.CustomFuzzyMatch, // Compare fn_normSuffix values
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_contact_email(TYPEOF(h.contact_email) L, TYPEOF(h.contact_email) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT38.MatchCode.ExactMatch,
    SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch, SALT38.MatchCode.NoMatch)
);
EXPORT match_CONTACTNAME(TYPEOF(h.CONTACTNAME) L,TYPEOF(h.CONTACTNAME) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT38.MatchCode.ExactMatch,
      SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch,SALT38.MatchCode.NoMatch)
);
EXPORT match_STREETADDRESS(TYPEOF(h.STREETADDRESS) L,TYPEOF(h.STREETADDRESS) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT38.MatchCode.ExactMatch,
      SALT38.MatchCode.NoMatch),
        MAP(L = R => SALT38.MatchCode.ExactMatch,SALT38.MatchCode.NoMatch)
);
END;
