IMPORT SALT30,std;
EXPORT match_methods(DATASET(layout_Email_Data) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_clean_email(TYPEOF(h.clean_email) L, TYPEOF(h.clean_email) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_email_username(TYPEOF(h.append_email_username) L, TYPEOF(h.append_email_username) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_domain(TYPEOF(h.append_domain) L, TYPEOF(h.append_domain) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_domain_type(TYPEOF(h.append_domain_type) L, TYPEOF(h.append_domain_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_domain_root(TYPEOF(h.append_domain_root) L, TYPEOF(h.append_domain_root) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_domain_ext(TYPEOF(h.append_domain_ext) L, TYPEOF(h.append_domain_ext) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_is_tld_state(TYPEOF(h.append_is_tld_state) L, TYPEOF(h.append_is_tld_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_is_tld_generic(TYPEOF(h.append_is_tld_generic) L, TYPEOF(h.append_is_tld_generic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_is_tld_country(TYPEOF(h.append_is_tld_country) L, TYPEOF(h.append_is_tld_country) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_is_valid_domain_ext(TYPEOF(h.append_is_valid_domain_ext) L, TYPEOF(h.append_is_valid_domain_ext) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_email_rec_key(TYPEOF(h.email_rec_key) L, TYPEOF(h.email_rec_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_email_src(TYPEOF(h.email_src) L, TYPEOF(h.email_src) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_rec_src_all(TYPEOF(h.rec_src_all) L, TYPEOF(h.rec_src_all) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_email_src_all(TYPEOF(h.email_src_all) L, TYPEOF(h.email_src_all) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_email_src_num(TYPEOF(h.email_src_num) L, TYPEOF(h.email_src_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_num_email_per_did(TYPEOF(h.num_email_per_did) L, TYPEOF(h.num_email_per_did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_num_did_per_email(TYPEOF(h.num_did_per_email) L, TYPEOF(h.num_did_per_email) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_pmghousehold_id(TYPEOF(h.orig_pmghousehold_id) L, TYPEOF(h.orig_pmghousehold_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_pmgindividual_id(TYPEOF(h.orig_pmgindividual_id) L, TYPEOF(h.orig_pmgindividual_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_first_name(TYPEOF(h.orig_first_name) L, TYPEOF(h.orig_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_last_name(TYPEOF(h.orig_last_name) L, TYPEOF(h.orig_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_address(TYPEOF(h.orig_address) L, TYPEOF(h.orig_address) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_city(TYPEOF(h.orig_city) L, TYPEOF(h.orig_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_state(TYPEOF(h.orig_state) L, TYPEOF(h.orig_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_zip(TYPEOF(h.orig_zip) L, TYPEOF(h.orig_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_zip4(TYPEOF(h.orig_zip4) L, TYPEOF(h.orig_zip4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_email(TYPEOF(h.orig_email) L, TYPEOF(h.orig_email) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_ip(TYPEOF(h.orig_ip) L, TYPEOF(h.orig_ip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_login_date(TYPEOF(h.orig_login_date) L, TYPEOF(h.orig_login_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_site(TYPEOF(h.orig_site) L, TYPEOF(h.orig_site) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_e360_id(TYPEOF(h.orig_e360_id) L, TYPEOF(h.orig_e360_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_teramedia_id(TYPEOF(h.orig_teramedia_id) L, TYPEOF(h.orig_teramedia_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_did(TYPEOF(h.did) L, TYPEOF(h.did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_did_score(TYPEOF(h.did_score) L, TYPEOF(h.did_score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_did_type(TYPEOF(h.did_type) L, TYPEOF(h.did_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_is_did_prop(TYPEOF(h.is_did_prop) L, TYPEOF(h.is_did_prop) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_hhid(TYPEOF(h.hhid) L, TYPEOF(h.hhid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_title(TYPEOF(h.title) L, TYPEOF(h.title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
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
EXPORT match_name_score(TYPEOF(h.name_score) L, TYPEOF(h.name_score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_addr_suffix(TYPEOF(h.addr_suffix) L, TYPEOF(h.addr_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_p_city_name(TYPEOF(h.p_city_name) L, TYPEOF(h.p_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_zip4(TYPEOF(h.zip4) L, TYPEOF(h.zip4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_cart(TYPEOF(h.cart) L, TYPEOF(h.cart) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_cr_sort_sz(TYPEOF(h.cr_sort_sz) L, TYPEOF(h.cr_sort_sz) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_lot(TYPEOF(h.lot) L, TYPEOF(h.lot) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_lot_order(TYPEOF(h.lot_order) L, TYPEOF(h.lot_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_dbpc(TYPEOF(h.dbpc) L, TYPEOF(h.dbpc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_chk_digit(TYPEOF(h.chk_digit) L, TYPEOF(h.chk_digit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_rec_type(TYPEOF(h.rec_type) L, TYPEOF(h.rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_county(TYPEOF(h.county) L, TYPEOF(h.county) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_geo_lat(TYPEOF(h.geo_lat) L, TYPEOF(h.geo_lat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_geo_long(TYPEOF(h.geo_long) L, TYPEOF(h.geo_long) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_msa(TYPEOF(h.msa) L, TYPEOF(h.msa) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_geo_blk(TYPEOF(h.geo_blk) L, TYPEOF(h.geo_blk) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_geo_match(TYPEOF(h.geo_match) L, TYPEOF(h.geo_match) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_err_stat(TYPEOF(h.err_stat) L, TYPEOF(h.err_stat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_append_rawaid(TYPEOF(h.append_rawaid) L, TYPEOF(h.append_rawaid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_best_ssn(TYPEOF(h.best_ssn) L, TYPEOF(h.best_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_best_dob(TYPEOF(h.best_dob) L, TYPEOF(h.best_dob) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_process_date(TYPEOF(h.process_date) L, TYPEOF(h.process_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_activecode(TYPEOF(h.activecode) L, TYPEOF(h.activecode) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_date_first_seen(TYPEOF(h.date_first_seen) L, TYPEOF(h.date_first_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_date_last_seen(TYPEOF(h.date_last_seen) L, TYPEOF(h.date_last_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_date_vendor_first_reported(TYPEOF(h.date_vendor_first_reported) L, TYPEOF(h.date_vendor_first_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_date_vendor_last_reported(TYPEOF(h.date_vendor_last_reported) L, TYPEOF(h.date_vendor_last_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_current_rec(TYPEOF(h.current_rec) L, TYPEOF(h.current_rec) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
END;

