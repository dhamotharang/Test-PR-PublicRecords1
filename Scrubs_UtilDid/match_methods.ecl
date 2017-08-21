IMPORT SALT30,std;
EXPORT match_methods(DATASET(layout_UtilDid) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_id(TYPEOF(h.id) L, TYPEOF(h.id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_exchange_serial_number(TYPEOF(h.exchange_serial_number) L, TYPEOF(h.exchange_serial_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_date_added_to_exchange(TYPEOF(h.date_added_to_exchange) L, TYPEOF(h.date_added_to_exchange) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_connect_date(TYPEOF(h.connect_date) L, TYPEOF(h.connect_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_date_first_seen(TYPEOF(h.date_first_seen) L, TYPEOF(h.date_first_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_record_date(TYPEOF(h.record_date) L, TYPEOF(h.record_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_util_type(TYPEOF(h.util_type) L, TYPEOF(h.util_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_lname(TYPEOF(h.orig_lname) L, TYPEOF(h.orig_lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_fname(TYPEOF(h.orig_fname) L, TYPEOF(h.orig_fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_mname(TYPEOF(h.orig_mname) L, TYPEOF(h.orig_mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_orig_name_suffix(TYPEOF(h.orig_name_suffix) L, TYPEOF(h.orig_name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_addr_type(TYPEOF(h.addr_type) L, TYPEOF(h.addr_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_addr_dual(TYPEOF(h.addr_dual) L, TYPEOF(h.addr_dual) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_street(TYPEOF(h.address_street) L, TYPEOF(h.address_street) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_street_Name(TYPEOF(h.address_street_Name) L, TYPEOF(h.address_street_Name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_street_type(TYPEOF(h.address_street_type) L, TYPEOF(h.address_street_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_street_direction(TYPEOF(h.address_street_direction) L, TYPEOF(h.address_street_direction) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_apartment(TYPEOF(h.address_apartment) L, TYPEOF(h.address_apartment) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_city(TYPEOF(h.address_city) L, TYPEOF(h.address_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_state(TYPEOF(h.address_state) L, TYPEOF(h.address_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_address_zip(TYPEOF(h.address_zip) L, TYPEOF(h.address_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_ssn(TYPEOF(h.ssn) L, TYPEOF(h.ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_work_phone(TYPEOF(h.work_phone) L, TYPEOF(h.work_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_phone(TYPEOF(h.phone) L, TYPEOF(h.phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_dob(TYPEOF(h.dob) L, TYPEOF(h.dob) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_drivers_license_state_code(TYPEOF(h.drivers_license_state_code) L, TYPEOF(h.drivers_license_state_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_drivers_license(TYPEOF(h.drivers_license) L, TYPEOF(h.drivers_license) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
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
EXPORT match_did(TYPEOF(h.did) L, TYPEOF(h.did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
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
EXPORT match_fdid(TYPEOF(h.fdid) L, TYPEOF(h.fdid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_hhid(TYPEOF(h.hhid) L, TYPEOF(h.hhid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
END;

