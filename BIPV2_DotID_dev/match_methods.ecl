IMPORT SALT30,std;
EXPORT match_methods(DATASET(layout_DOT) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_cnp_name(TYPEOF(h.cnp_name) L, TYPEOF(h.cnp_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_corp_legal_name(TYPEOF(h.corp_legal_name) L, TYPEOF(h.corp_legal_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchBagOfWords(L,R,31762,1) <> 0 => SALT30.MatchCode.WordBagMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_cnp_number(TYPEOF(h.cnp_number) L, TYPEOF(h.cnp_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_cnp_btype(TYPEOF(h.cnp_btype) L, TYPEOF(h.cnp_btype) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_company_fein(TYPEOF(h.company_fein) L, TYPEOF(h.company_fein) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_active_duns_number(TYPEOF(h.active_duns_number) L, TYPEOF(h.active_duns_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_active_enterprise_number(TYPEOF(h.active_enterprise_number) L, TYPEOF(h.active_enterprise_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_active_domestic_corp_key(TYPEOF(h.active_domestic_corp_key) L, TYPEOF(h.active_domestic_corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_csz(TYPEOF(h.csz) L,TYPEOF(h.csz) R) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_addr1(TYPEOF(h.addr1) L,TYPEOF(h.addr1) R) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_address(TYPEOF(h.address) L,TYPEOF(h.address) R) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_isContact(TYPEOF(h.isContact) L, TYPEOF(h.isContact) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		fn_PreferredName(L) =  fn_PreferredName(R) => SALT30.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT30.MatchCode.InitialMatch,
		LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT30.MatchCode.InitialMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT30.MatchCode.InitialMatch,
		LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT30.MatchCode.InitialMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.HyphenMatch(L,R,3)<=2 => SALT30.MatchCode.HyphenMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		fn_normSuffix(L) =  fn_normSuffix(R) => SALT30.MatchCode.CustomFuzzyMatch, // Compare fn_normSuffix values
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_contact_ssn(TYPEOF(h.contact_ssn) L, TYPEOF(h.contact_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		fn_Right4(L) =  fn_Right4(R) => SALT30.MatchCode.CustomFuzzyMatch, // Compare fn_Right4 values
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
END;
