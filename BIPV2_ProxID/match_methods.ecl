IMPORT SALT311,std;
EXPORT match_methods(DATASET(layout_DOT_Base) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_active_duns_number(TYPEOF(h.active_duns_number) L, TYPEOF(h.active_duns_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_active_enterprise_number(TYPEOF(h.active_enterprise_number) L, TYPEOF(h.active_enterprise_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_active_domestic_corp_key(TYPEOF(h.active_domestic_corp_key) L, TYPEOF(h.active_domestic_corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_hist_enterprise_number(TYPEOF(h.hist_enterprise_number) L, TYPEOF(h.hist_enterprise_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_hist_duns_number(TYPEOF(h.hist_duns_number) L, TYPEOF(h.hist_duns_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_hist_domestic_corp_key(TYPEOF(h.hist_domestic_corp_key) L, TYPEOF(h.hist_domestic_corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_foreign_corp_key(TYPEOF(h.foreign_corp_key) L, TYPEOF(h.foreign_corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_unk_corp_key(TYPEOF(h.unk_corp_key) L, TYPEOF(h.unk_corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_ebr_file_number(TYPEOF(h.ebr_file_number) L, TYPEOF(h.ebr_file_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_company_fein(TYPEOF(h.company_fein) L, TYPEOF(h.company_fein) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_cnp_name(TYPEOF(h.cnp_name) L, TYPEOF(h.cnp_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch,
	    SALT311.MatchBagOfWords(L,R,46614,1) <> 0 => SALT311.MatchCode.WordBagMatch,
    SALT311.MatchCode.NoMatch),
     MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_company_name_type_derived(TYPEOF(h.company_name_type_derived) L, TYPEOF(h.company_name_type_derived) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_cnp_number(TYPEOF(h.cnp_number) L, TYPEOF(h.cnp_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_cnp_btype(TYPEOF(h.cnp_btype) L, TYPEOF(h.cnp_btype) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_company_phone(TYPEOF(h.company_phone) L, TYPEOF(h.company_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_name_derived(TYPEOF(h.prim_name_derived) L, TYPEOF(h.prim_name_derived) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch,
	    SALT311.MatchBagOfWords(L,R,32022,1) <> 0 => SALT311.MatchCode.WordBagMatch,
    SALT311.MatchCode.NoMatch),
     MAP(SALT311.WordBagsEqual(L,R) => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.HyphenMatch(L,R,1)<=1 => SALT311.MatchCode.HyphenMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
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
EXPORT match_prim_range_derived(TYPEOF(h.prim_range_derived) L, TYPEOF(h.prim_range_derived) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_company_csz(TYPEOF(h.company_csz) L,TYPEOF(h.company_csz) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_company_addr1(TYPEOF(h.company_addr1) L,TYPEOF(h.company_addr1) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_company_address(TYPEOF(h.company_address) L,TYPEOF(h.company_address) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
END;
