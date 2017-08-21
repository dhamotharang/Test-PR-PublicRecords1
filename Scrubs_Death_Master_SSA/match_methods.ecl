IMPORT SALT30,std;
EXPORT match_methods(DATASET(layout_Death_Master_SSA) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_filedate(TYPEOF(h.filedate) L, TYPEOF(h.filedate) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_rec_type(TYPEOF(h.rec_type) L, TYPEOF(h.rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_rec_type_orig(TYPEOF(h.rec_type_orig) L, TYPEOF(h.rec_type_orig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_ssn(TYPEOF(h.ssn) L, TYPEOF(h.ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_vorp_code(TYPEOF(h.vorp_code) L, TYPEOF(h.vorp_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_dod8(TYPEOF(h.dod8) L, TYPEOF(h.dod8) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_dob8(TYPEOF(h.dob8) L, TYPEOF(h.dob8) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_st_country_code(TYPEOF(h.st_country_code) L, TYPEOF(h.st_country_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_zip_lastres(TYPEOF(h.zip_lastres) L, TYPEOF(h.zip_lastres) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_zip_lastpayment(TYPEOF(h.zip_lastpayment) L, TYPEOF(h.zip_lastpayment) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_state(TYPEOF(h.state) L, TYPEOF(h.state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_fipscounty(TYPEOF(h.fipscounty) L, TYPEOF(h.fipscounty) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_clean_title(TYPEOF(h.clean_title) L, TYPEOF(h.clean_title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_clean_fname(TYPEOF(h.clean_fname) L, TYPEOF(h.clean_fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_clean_mname(TYPEOF(h.clean_mname) L, TYPEOF(h.clean_mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_clean_lname(TYPEOF(h.clean_lname) L, TYPEOF(h.clean_lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_clean_name_suffix(TYPEOF(h.clean_name_suffix) L, TYPEOF(h.clean_name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_clean_name_score(TYPEOF(h.clean_name_score) L, TYPEOF(h.clean_name_score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_crlf(TYPEOF(h.crlf) L, TYPEOF(h.crlf) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
END;

