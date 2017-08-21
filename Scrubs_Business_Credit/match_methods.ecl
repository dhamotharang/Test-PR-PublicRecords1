IMPORT SALT31,std;
EXPORT match_methods(DATASET(layout_Business_Credit) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_timestamp(TYPEOF(h.timestamp) L, TYPEOF(h.timestamp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_process_date(TYPEOF(h.process_date) L, TYPEOF(h.process_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_record_type(TYPEOF(h.record_type) L, TYPEOF(h.record_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_did(TYPEOF(h.did) L, TYPEOF(h.did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_did_score(TYPEOF(h.did_score) L, TYPEOF(h.did_score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dt_first_seen(TYPEOF(h.dt_first_seen) L, TYPEOF(h.dt_first_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dt_last_seen(TYPEOF(h.dt_last_seen) L, TYPEOF(h.dt_last_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dt_vendor_first_reported(TYPEOF(h.dt_vendor_first_reported) L, TYPEOF(h.dt_vendor_first_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dt_vendor_last_reported(TYPEOF(h.dt_vendor_last_reported) L, TYPEOF(h.dt_vendor_last_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dt_datawarehouse_first_reported(TYPEOF(h.dt_datawarehouse_first_reported) L, TYPEOF(h.dt_datawarehouse_first_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dt_datawarehouse_last_reported(TYPEOF(h.dt_datawarehouse_last_reported) L, TYPEOF(h.dt_datawarehouse_last_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_sbfe_contributor_number(TYPEOF(h.sbfe_contributor_number) L, TYPEOF(h.sbfe_contributor_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_contract_account_number(TYPEOF(h.contract_account_number) L, TYPEOF(h.contract_account_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_type_reported(TYPEOF(h.account_type_reported) L, TYPEOF(h.account_type_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extracted_date(TYPEOF(h.extracted_date) L, TYPEOF(h.extracted_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cycle_end_date(TYPEOF(h.cycle_end_date) L, TYPEOF(h.cycle_end_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_holder_business_name(TYPEOF(h.account_holder_business_name) L, TYPEOF(h.account_holder_business_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_account_holder_business_name(TYPEOF(h.clean_account_holder_business_name) L, TYPEOF(h.clean_account_holder_business_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dba(TYPEOF(h.dba) L, TYPEOF(h.dba) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_dba(TYPEOF(h.clean_dba) L, TYPEOF(h.clean_dba) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_business_name(TYPEOF(h.business_name) L, TYPEOF(h.business_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_business_name(TYPEOF(h.clean_business_name) L, TYPEOF(h.clean_business_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_company_website(TYPEOF(h.company_website) L, TYPEOF(h.company_website) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_fname(TYPEOF(h.original_fname) L, TYPEOF(h.original_fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_mname(TYPEOF(h.original_mname) L, TYPEOF(h.original_mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_lname(TYPEOF(h.original_lname) L, TYPEOF(h.original_lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_suffix(TYPEOF(h.original_suffix) L, TYPEOF(h.original_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_e_mail_address(TYPEOF(h.e_mail_address) L, TYPEOF(h.e_mail_address) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_guarantor_owner_indicator(TYPEOF(h.guarantor_owner_indicator) L, TYPEOF(h.guarantor_owner_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_relationship_to_business_indicator(TYPEOF(h.relationship_to_business_indicator) L, TYPEOF(h.relationship_to_business_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_business_title(TYPEOF(h.business_title) L, TYPEOF(h.business_title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_title(TYPEOF(h.clean_title) L, TYPEOF(h.clean_title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_fname(TYPEOF(h.clean_fname) L, TYPEOF(h.clean_fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_mname(TYPEOF(h.clean_mname) L, TYPEOF(h.clean_mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_lname(TYPEOF(h.clean_lname) L, TYPEOF(h.clean_lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_clean_suffix(TYPEOF(h.clean_suffix) L, TYPEOF(h.clean_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_address_line_1(TYPEOF(h.original_address_line_1) L, TYPEOF(h.original_address_line_1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_address_line_2(TYPEOF(h.original_address_line_2) L, TYPEOF(h.original_address_line_2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_city(TYPEOF(h.original_city) L, TYPEOF(h.original_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_state(TYPEOF(h.original_state) L, TYPEOF(h.original_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_zip_code_or_ca_postal_code(TYPEOF(h.original_zip_code_or_ca_postal_code) L, TYPEOF(h.original_zip_code_or_ca_postal_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_postal_code(TYPEOF(h.original_postal_code) L, TYPEOF(h.original_postal_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_country_code(TYPEOF(h.original_country_code) L, TYPEOF(h.original_country_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_addr_suffix(TYPEOF(h.addr_suffix) L, TYPEOF(h.addr_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_p_city_name(TYPEOF(h.p_city_name) L, TYPEOF(h.p_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_zip4(TYPEOF(h.zip4) L, TYPEOF(h.zip4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cart(TYPEOF(h.cart) L, TYPEOF(h.cart) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cr_sort_sz(TYPEOF(h.cr_sort_sz) L, TYPEOF(h.cr_sort_sz) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lot(TYPEOF(h.lot) L, TYPEOF(h.lot) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lot_order(TYPEOF(h.lot_order) L, TYPEOF(h.lot_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dbpc(TYPEOF(h.dbpc) L, TYPEOF(h.dbpc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_chk_digit(TYPEOF(h.chk_digit) L, TYPEOF(h.chk_digit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_rec_type(TYPEOF(h.rec_type) L, TYPEOF(h.rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fips_state(TYPEOF(h.fips_state) L, TYPEOF(h.fips_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fips_county(TYPEOF(h.fips_county) L, TYPEOF(h.fips_county) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_geo_lat(TYPEOF(h.geo_lat) L, TYPEOF(h.geo_lat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_geo_long(TYPEOF(h.geo_long) L, TYPEOF(h.geo_long) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_msa(TYPEOF(h.msa) L, TYPEOF(h.msa) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_geo_blk(TYPEOF(h.geo_blk) L, TYPEOF(h.geo_blk) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_geo_match(TYPEOF(h.geo_match) L, TYPEOF(h.geo_match) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_err_stat(TYPEOF(h.err_stat) L, TYPEOF(h.err_stat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_rawaid(TYPEOF(h.rawaid) L, TYPEOF(h.rawaid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_area_code(TYPEOF(h.original_area_code) L, TYPEOF(h.original_area_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_phone_number(TYPEOF(h.original_phone_number) L, TYPEOF(h.original_phone_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_phone_extension(TYPEOF(h.phone_extension) L, TYPEOF(h.phone_extension) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_primary_phone_indicator(TYPEOF(h.primary_phone_indicator) L, TYPEOF(h.primary_phone_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_published_unlisted_indicator(TYPEOF(h.published_unlisted_indicator) L, TYPEOF(h.published_unlisted_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_phone_type(TYPEOF(h.phone_type) L, TYPEOF(h.phone_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_phone_number(TYPEOF(h.phone_number) L, TYPEOF(h.phone_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_federal_taxid_ssn(TYPEOF(h.federal_taxid_ssn) L, TYPEOF(h.federal_taxid_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_federal_taxid_ssn_identifier(TYPEOF(h.federal_taxid_ssn_identifier) L, TYPEOF(h.federal_taxid_ssn_identifier) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dotid(TYPEOF(h.dotid) L, TYPEOF(h.dotid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dotscore(TYPEOF(h.dotscore) L, TYPEOF(h.dotscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dotweight(TYPEOF(h.dotweight) L, TYPEOF(h.dotweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_empid(TYPEOF(h.empid) L, TYPEOF(h.empid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_empscore(TYPEOF(h.empscore) L, TYPEOF(h.empscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_empweight(TYPEOF(h.empweight) L, TYPEOF(h.empweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_powid(TYPEOF(h.powid) L, TYPEOF(h.powid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_powscore(TYPEOF(h.powscore) L, TYPEOF(h.powscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_powweight(TYPEOF(h.powweight) L, TYPEOF(h.powweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_proxid(TYPEOF(h.proxid) L, TYPEOF(h.proxid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_proxscore(TYPEOF(h.proxscore) L, TYPEOF(h.proxscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_proxweight(TYPEOF(h.proxweight) L, TYPEOF(h.proxweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_seleid(TYPEOF(h.seleid) L, TYPEOF(h.seleid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_selescore(TYPEOF(h.selescore) L, TYPEOF(h.selescore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_seleweight(TYPEOF(h.seleweight) L, TYPEOF(h.seleweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_orgid(TYPEOF(h.orgid) L, TYPEOF(h.orgid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_orgscore(TYPEOF(h.orgscore) L, TYPEOF(h.orgscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_orgweight(TYPEOF(h.orgweight) L, TYPEOF(h.orgweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ultid(TYPEOF(h.ultid) L, TYPEOF(h.ultid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ultscore(TYPEOF(h.ultscore) L, TYPEOF(h.ultscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ultweight(TYPEOF(h.ultweight) L, TYPEOF(h.ultweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_persistent_record_id(TYPEOF(h.persistent_record_id) L, TYPEOF(h.persistent_record_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_sbfe_id(TYPEOF(h.sbfe_id) L, TYPEOF(h.sbfe_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_source(TYPEOF(h.source) L, TYPEOF(h.source) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_active(TYPEOF(h.active) L, TYPEOF(h.active) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_business_structure(TYPEOF(h.legal_business_structure) L, TYPEOF(h.legal_business_structure) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_business_established_date(TYPEOF(h.business_established_date) L, TYPEOF(h.business_established_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_status_1(TYPEOF(h.account_status_1) L, TYPEOF(h.account_status_1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_status_2(TYPEOF(h.account_status_2) L, TYPEOF(h.account_status_2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_date_account_opened(TYPEOF(h.date_account_opened) L, TYPEOF(h.date_account_opened) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_date_account_closed(TYPEOF(h.date_account_closed) L, TYPEOF(h.date_account_closed) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_closure_basis(TYPEOF(h.account_closure_basis) L, TYPEOF(h.account_closure_basis) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_expiration_date(TYPEOF(h.account_expiration_date) L, TYPEOF(h.account_expiration_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_last_activity_date(TYPEOF(h.last_activity_date) L, TYPEOF(h.last_activity_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_last_activity_type(TYPEOF(h.last_activity_type) L, TYPEOF(h.last_activity_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_recent_activity_indicator(TYPEOF(h.recent_activity_indicator) L, TYPEOF(h.recent_activity_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_credit_limit(TYPEOF(h.original_credit_limit) L, TYPEOF(h.original_credit_limit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_highest_credit_used(TYPEOF(h.highest_credit_used) L, TYPEOF(h.highest_credit_used) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_current_credit_limit(TYPEOF(h.current_credit_limit) L, TYPEOF(h.current_credit_limit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_reporting_indicator_length(TYPEOF(h.reporting_indicator_length) L, TYPEOF(h.reporting_indicator_length) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_interval(TYPEOF(h.payment_interval) L, TYPEOF(h.payment_interval) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_status_category(TYPEOF(h.payment_status_category) L, TYPEOF(h.payment_status_category) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_term_of_account_in_months(TYPEOF(h.term_of_account_in_months) L, TYPEOF(h.term_of_account_in_months) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_first_payment_due_date(TYPEOF(h.first_payment_due_date) L, TYPEOF(h.first_payment_due_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_final_payment_due_date(TYPEOF(h.final_payment_due_date) L, TYPEOF(h.final_payment_due_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_original_rate(TYPEOF(h.original_rate) L, TYPEOF(h.original_rate) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_floating_rate(TYPEOF(h.floating_rate) L, TYPEOF(h.floating_rate) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_grace_period(TYPEOF(h.grace_period) L, TYPEOF(h.grace_period) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_category(TYPEOF(h.payment_category) L, TYPEOF(h.payment_category) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_history_profile_12_months(TYPEOF(h.payment_history_profile_12_months) L, TYPEOF(h.payment_history_profile_12_months) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_history_profile_13_24_months(TYPEOF(h.payment_history_profile_13_24_months) L, TYPEOF(h.payment_history_profile_13_24_months) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_history_profile_25_36_months(TYPEOF(h.payment_history_profile_25_36_months) L, TYPEOF(h.payment_history_profile_25_36_months) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_history_profile_37_48_months(TYPEOF(h.payment_history_profile_37_48_months) L, TYPEOF(h.payment_history_profile_37_48_months) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_history_length(TYPEOF(h.payment_history_length) L, TYPEOF(h.payment_history_length) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_year_to_date_purchases_count(TYPEOF(h.year_to_date_purchases_count) L, TYPEOF(h.year_to_date_purchases_count) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lifetime_to_date_purchases_count(TYPEOF(h.lifetime_to_date_purchases_count) L, TYPEOF(h.lifetime_to_date_purchases_count) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_year_to_date_purchases_sum_amount(TYPEOF(h.year_to_date_purchases_sum_amount) L, TYPEOF(h.year_to_date_purchases_sum_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lifetime_to_date_purchases_sum_amount(TYPEOF(h.lifetime_to_date_purchases_sum_amount) L, TYPEOF(h.lifetime_to_date_purchases_sum_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_amount_scheduled(TYPEOF(h.payment_amount_scheduled) L, TYPEOF(h.payment_amount_scheduled) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_recent_payment_amount(TYPEOF(h.recent_payment_amount) L, TYPEOF(h.recent_payment_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_recent_payment_date(TYPEOF(h.recent_payment_date) L, TYPEOF(h.recent_payment_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_remaining_balance(TYPEOF(h.remaining_balance) L, TYPEOF(h.remaining_balance) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_carried_over_amount(TYPEOF(h.carried_over_amount) L, TYPEOF(h.carried_over_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_new_applied_charges(TYPEOF(h.new_applied_charges) L, TYPEOF(h.new_applied_charges) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_balloon_payment_due(TYPEOF(h.balloon_payment_due) L, TYPEOF(h.balloon_payment_due) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_balloon_payment_due_date(TYPEOF(h.balloon_payment_due_date) L, TYPEOF(h.balloon_payment_due_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_delinquency_date(TYPEOF(h.delinquency_date) L, TYPEOF(h.delinquency_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_days_delinquent(TYPEOF(h.days_delinquent) L, TYPEOF(h.days_delinquent) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_amount(TYPEOF(h.past_due_amount) L, TYPEOF(h.past_due_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_maximum_number_of_past_due_aging_amounts_buckets_provided(TYPEOF(h.maximum_number_of_past_due_aging_amounts_buckets_provided) L, TYPEOF(h.maximum_number_of_past_due_aging_amounts_buckets_provided) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_bucket_type(TYPEOF(h.past_due_aging_bucket_type) L, TYPEOF(h.past_due_aging_bucket_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_1(TYPEOF(h.past_due_aging_amount_bucket_1) L, TYPEOF(h.past_due_aging_amount_bucket_1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_2(TYPEOF(h.past_due_aging_amount_bucket_2) L, TYPEOF(h.past_due_aging_amount_bucket_2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_3(TYPEOF(h.past_due_aging_amount_bucket_3) L, TYPEOF(h.past_due_aging_amount_bucket_3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_4(TYPEOF(h.past_due_aging_amount_bucket_4) L, TYPEOF(h.past_due_aging_amount_bucket_4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_5(TYPEOF(h.past_due_aging_amount_bucket_5) L, TYPEOF(h.past_due_aging_amount_bucket_5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_6(TYPEOF(h.past_due_aging_amount_bucket_6) L, TYPEOF(h.past_due_aging_amount_bucket_6) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_past_due_aging_amount_bucket_7(TYPEOF(h.past_due_aging_amount_bucket_7) L, TYPEOF(h.past_due_aging_amount_bucket_7) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_maximum_number_of_payment_tracking_cycle_periods_provided(TYPEOF(h.maximum_number_of_payment_tracking_cycle_periods_provided) L, TYPEOF(h.maximum_number_of_payment_tracking_cycle_periods_provided) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_type(TYPEOF(h.payment_tracking_cycle_type) L, TYPEOF(h.payment_tracking_cycle_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_0_current(TYPEOF(h.payment_tracking_cycle_0_current) L, TYPEOF(h.payment_tracking_cycle_0_current) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_1_1_to_30_days(TYPEOF(h.payment_tracking_cycle_1_1_to_30_days) L, TYPEOF(h.payment_tracking_cycle_1_1_to_30_days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_2_31_to_60_days(TYPEOF(h.payment_tracking_cycle_2_31_to_60_days) L, TYPEOF(h.payment_tracking_cycle_2_31_to_60_days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_3_61_to_90_days(TYPEOF(h.payment_tracking_cycle_3_61_to_90_days) L, TYPEOF(h.payment_tracking_cycle_3_61_to_90_days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_4_91_to_120_days(TYPEOF(h.payment_tracking_cycle_4_91_to_120_days) L, TYPEOF(h.payment_tracking_cycle_4_91_to_120_days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_cycle_5_121_to_150days(TYPEOF(h.payment_tracking_cycle_5_121_to_150days) L, TYPEOF(h.payment_tracking_cycle_5_121_to_150days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_number_of_times_cycle_6_151_to_180_days(TYPEOF(h.payment_tracking_number_of_times_cycle_6_151_to_180_days) L, TYPEOF(h.payment_tracking_number_of_times_cycle_6_151_to_180_days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_payment_tracking_number_of_times_cycle_7_181_or_greater_days(TYPEOF(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days) L, TYPEOF(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_date_account_was_charged_off(TYPEOF(h.date_account_was_charged_off) L, TYPEOF(h.date_account_was_charged_off) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amount_charged_off_by_creditor(TYPEOF(h.amount_charged_off_by_creditor) L, TYPEOF(h.amount_charged_off_by_creditor) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_charge_off_type_indicator(TYPEOF(h.charge_off_type_indicator) L, TYPEOF(h.charge_off_type_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_total_charge_off_recoveries_to_date(TYPEOF(h.total_charge_off_recoveries_to_date) L, TYPEOF(h.total_charge_off_recoveries_to_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_government_guarantee_flag(TYPEOF(h.government_guarantee_flag) L, TYPEOF(h.government_guarantee_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_government_guarantee_category(TYPEOF(h.government_guarantee_category) L, TYPEOF(h.government_guarantee_category) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_portion_of_account_guaranteed_by_government(TYPEOF(h.portion_of_account_guaranteed_by_government) L, TYPEOF(h.portion_of_account_guaranteed_by_government) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_guarantors_indicator(TYPEOF(h.guarantors_indicator) L, TYPEOF(h.guarantors_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_number_of_guarantors(TYPEOF(h.number_of_guarantors) L, TYPEOF(h.number_of_guarantors) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_owners_indicator(TYPEOF(h.owners_indicator) L, TYPEOF(h.owners_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_number_of_principals(TYPEOF(h.number_of_principals) L, TYPEOF(h.number_of_principals) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_account_update_deletion_indicator(TYPEOF(h.account_update_deletion_indicator) L, TYPEOF(h.account_update_deletion_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_percent_of_liability(TYPEOF(h.percent_of_liability) L, TYPEOF(h.percent_of_liability) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_percent_of_ownership(TYPEOF(h.percent_of_ownership) L, TYPEOF(h.percent_of_ownership) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
END;

