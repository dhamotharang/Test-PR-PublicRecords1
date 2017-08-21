IMPORT SALT32,std;
EXPORT match_methods(DATASET(layout_File) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_record_type(TYPEOF(h.record_type) L, TYPEOF(h.record_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_first_name(TYPEOF(h.first_name) L, TYPEOF(h.first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_middle_name(TYPEOF(h.middle_name) L, TYPEOF(h.middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_last_name(TYPEOF(h.last_name) L, TYPEOF(h.last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_prefix(TYPEOF(h.name_prefix) L, TYPEOF(h.name_prefix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_suffix_(TYPEOF(h.name_suffix_) L, TYPEOF(h.name_suffix_) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_perm_id(TYPEOF(h.perm_id) L, TYPEOF(h.perm_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_ssn(TYPEOF(h.ssn) L, TYPEOF(h.ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_aka1(TYPEOF(h.aka1) L, TYPEOF(h.aka1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_aka2(TYPEOF(h.aka2) L, TYPEOF(h.aka2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_aka3(TYPEOF(h.aka3) L, TYPEOF(h.aka3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_new_subject_flag(TYPEOF(h.new_subject_flag) L, TYPEOF(h.new_subject_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_change_flag(TYPEOF(h.name_change_flag) L, TYPEOF(h.name_change_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_address_change_flag(TYPEOF(h.address_change_flag) L, TYPEOF(h.address_change_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_ssn_change_flag(TYPEOF(h.ssn_change_flag) L, TYPEOF(h.ssn_change_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_file_since_date_change_flag(TYPEOF(h.file_since_date_change_flag) L, TYPEOF(h.file_since_date_change_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_deceased_indicator_flag(TYPEOF(h.deceased_indicator_flag) L, TYPEOF(h.deceased_indicator_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dob_change_flag(TYPEOF(h.dob_change_flag) L, TYPEOF(h.dob_change_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_phone_change_flag(TYPEOF(h.phone_change_flag) L, TYPEOF(h.phone_change_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_filler2(TYPEOF(h.filler2) L, TYPEOF(h.filler2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_gender(TYPEOF(h.gender) L, TYPEOF(h.gender) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_mfdu_indicator(TYPEOF(h.mfdu_indicator) L, TYPEOF(h.mfdu_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_file_since_date(TYPEOF(h.file_since_date) L, TYPEOF(h.file_since_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_house_number(TYPEOF(h.house_number) L, TYPEOF(h.house_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_street_direction(TYPEOF(h.street_direction) L, TYPEOF(h.street_direction) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_street_name(TYPEOF(h.street_name) L, TYPEOF(h.street_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_street_type(TYPEOF(h.street_type) L, TYPEOF(h.street_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_street_post_direction(TYPEOF(h.street_post_direction) L, TYPEOF(h.street_post_direction) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_unit_type(TYPEOF(h.unit_type) L, TYPEOF(h.unit_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_unit_number(TYPEOF(h.unit_number) L, TYPEOF(h.unit_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_cty(TYPEOF(h.cty) L, TYPEOF(h.cty) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_state(TYPEOF(h.state) L, TYPEOF(h.state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_zip_code(TYPEOF(h.zip_code) L, TYPEOF(h.zip_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_zp4(TYPEOF(h.zp4) L, TYPEOF(h.zp4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_address_standardization_indicator(TYPEOF(h.address_standardization_indicator) L, TYPEOF(h.address_standardization_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_date_address_reported(TYPEOF(h.date_address_reported) L, TYPEOF(h.date_address_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_party_id(TYPEOF(h.party_id) L, TYPEOF(h.party_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_deceased_indicator(TYPEOF(h.deceased_indicator) L, TYPEOF(h.deceased_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_date_of_birth(TYPEOF(h.date_of_birth) L, TYPEOF(h.date_of_birth) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_date_of_birth_estimated_ind(TYPEOF(h.date_of_birth_estimated_ind) L, TYPEOF(h.date_of_birth_estimated_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_phone(TYPEOF(h.phone) L, TYPEOF(h.phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_filler3(TYPEOF(h.filler3) L, TYPEOF(h.filler3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prepped_name(TYPEOF(h.prepped_name) L, TYPEOF(h.prepped_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prepped_addr1(TYPEOF(h.prepped_addr1) L, TYPEOF(h.prepped_addr1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prepped_addr2(TYPEOF(h.prepped_addr2) L, TYPEOF(h.prepped_addr2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prepped_rec_type(TYPEOF(h.prepped_rec_type) L, TYPEOF(h.prepped_rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_isupdating(TYPEOF(h.isupdating) L, TYPEOF(h.isupdating) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_iscurrent(TYPEOF(h.iscurrent) L, TYPEOF(h.iscurrent) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_did(TYPEOF(h.did) L, TYPEOF(h.did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_did_score(TYPEOF(h.did_score) L, TYPEOF(h.did_score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dt_first_seen(TYPEOF(h.dt_first_seen) L, TYPEOF(h.dt_first_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dt_last_seen(TYPEOF(h.dt_last_seen) L, TYPEOF(h.dt_last_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dt_vendor_last_reported(TYPEOF(h.dt_vendor_last_reported) L, TYPEOF(h.dt_vendor_last_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dt_vendor_first_reported(TYPEOF(h.dt_vendor_first_reported) L, TYPEOF(h.dt_vendor_first_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_clean_phone(TYPEOF(h.clean_phone) L, TYPEOF(h.clean_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_clean_ssn(TYPEOF(h.clean_ssn) L, TYPEOF(h.clean_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_clean_dob(TYPEOF(h.clean_dob) L, TYPEOF(h.clean_dob) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_title(TYPEOF(h.title) L, TYPEOF(h.title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_score(TYPEOF(h.name_score) L, TYPEOF(h.name_score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_addr_suffix(TYPEOF(h.addr_suffix) L, TYPEOF(h.addr_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_p_city_name(TYPEOF(h.p_city_name) L, TYPEOF(h.p_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_zip4(TYPEOF(h.zip4) L, TYPEOF(h.zip4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_cart(TYPEOF(h.cart) L, TYPEOF(h.cart) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_cr_sort_sz(TYPEOF(h.cr_sort_sz) L, TYPEOF(h.cr_sort_sz) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lot(TYPEOF(h.lot) L, TYPEOF(h.lot) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lot_order(TYPEOF(h.lot_order) L, TYPEOF(h.lot_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dbpc(TYPEOF(h.dbpc) L, TYPEOF(h.dbpc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_chk_digit(TYPEOF(h.chk_digit) L, TYPEOF(h.chk_digit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_type(TYPEOF(h.rec_type) L, TYPEOF(h.rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_fips_county(TYPEOF(h.fips_county) L, TYPEOF(h.fips_county) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_county(TYPEOF(h.county) L, TYPEOF(h.county) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_lat(TYPEOF(h.geo_lat) L, TYPEOF(h.geo_lat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_long(TYPEOF(h.geo_long) L, TYPEOF(h.geo_long) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_msa(TYPEOF(h.msa) L, TYPEOF(h.msa) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_blk(TYPEOF(h.geo_blk) L, TYPEOF(h.geo_blk) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_match(TYPEOF(h.geo_match) L, TYPEOF(h.geo_match) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_err_stat(TYPEOF(h.err_stat) L, TYPEOF(h.err_stat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rawaid(TYPEOF(h.rawaid) L, TYPEOF(h.rawaid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_isdelete(TYPEOF(h.isdelete) L, TYPEOF(h.isdelete) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
END;

