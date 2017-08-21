IMPORT SALT32,std;
EXPORT match_methods(DATASET(layout_Prof_License) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_prolic_key(TYPEOF(h.prolic_key) L, TYPEOF(h.prolic_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_date_first_seen(TYPEOF(h.date_first_seen) L, TYPEOF(h.date_first_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_date_last_seen(TYPEOF(h.date_last_seen) L, TYPEOF(h.date_last_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_profession_or_board(TYPEOF(h.profession_or_board) L, TYPEOF(h.profession_or_board) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_license_type(TYPEOF(h.license_type) L, TYPEOF(h.license_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_status(TYPEOF(h.status) L, TYPEOF(h.status) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_license_number(TYPEOF(h.orig_license_number) L, TYPEOF(h.orig_license_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_license_number(TYPEOF(h.license_number) L, TYPEOF(h.license_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_previous_license_number(TYPEOF(h.previous_license_number) L, TYPEOF(h.previous_license_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_previous_license_type(TYPEOF(h.previous_license_type) L, TYPEOF(h.previous_license_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_company_name(TYPEOF(h.company_name) L, TYPEOF(h.company_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_name(TYPEOF(h.orig_name) L, TYPEOF(h.orig_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_name_order(TYPEOF(h.name_order) L, TYPEOF(h.name_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_former_name(TYPEOF(h.orig_former_name) L, TYPEOF(h.orig_former_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_former_name_order(TYPEOF(h.former_name_order) L, TYPEOF(h.former_name_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_addr_1(TYPEOF(h.orig_addr_1) L, TYPEOF(h.orig_addr_1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_addr_2(TYPEOF(h.orig_addr_2) L, TYPEOF(h.orig_addr_2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_addr_3(TYPEOF(h.orig_addr_3) L, TYPEOF(h.orig_addr_3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_addr_4(TYPEOF(h.orig_addr_4) L, TYPEOF(h.orig_addr_4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_city(TYPEOF(h.orig_city) L, TYPEOF(h.orig_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_st(TYPEOF(h.orig_st) L, TYPEOF(h.orig_st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orig_zip(TYPEOF(h.orig_zip) L, TYPEOF(h.orig_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_county_str(TYPEOF(h.county_str) L, TYPEOF(h.county_str) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_country_str(TYPEOF(h.country_str) L, TYPEOF(h.country_str) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_business_flag(TYPEOF(h.business_flag) L, TYPEOF(h.business_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_phone(TYPEOF(h.phone) L, TYPEOF(h.phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_sex(TYPEOF(h.sex) L, TYPEOF(h.sex) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dob(TYPEOF(h.dob) L, TYPEOF(h.dob) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_issue_date(TYPEOF(h.issue_date) L, TYPEOF(h.issue_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_expiration_date(TYPEOF(h.expiration_date) L, TYPEOF(h.expiration_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_last_renewal_date(TYPEOF(h.last_renewal_date) L, TYPEOF(h.last_renewal_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_license_obtained_by(TYPEOF(h.license_obtained_by) L, TYPEOF(h.license_obtained_by) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_board_action_indicator(TYPEOF(h.board_action_indicator) L, TYPEOF(h.board_action_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_source_st(TYPEOF(h.source_st) L, TYPEOF(h.source_st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_vendor(TYPEOF(h.vendor) L, TYPEOF(h.vendor) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_record_type(TYPEOF(h.action_record_type) L, TYPEOF(h.action_record_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_complaint_violation_cds(TYPEOF(h.action_complaint_violation_cds) L, TYPEOF(h.action_complaint_violation_cds) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_complaint_violation_desc(TYPEOF(h.action_complaint_violation_desc) L, TYPEOF(h.action_complaint_violation_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_complaint_violation_dt(TYPEOF(h.action_complaint_violation_dt) L, TYPEOF(h.action_complaint_violation_dt) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_case_number(TYPEOF(h.action_case_number) L, TYPEOF(h.action_case_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_effective_dt(TYPEOF(h.action_effective_dt) L, TYPEOF(h.action_effective_dt) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_cds(TYPEOF(h.action_cds) L, TYPEOF(h.action_cds) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_desc(TYPEOF(h.action_desc) L, TYPEOF(h.action_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_final_order_no(TYPEOF(h.action_final_order_no) L, TYPEOF(h.action_final_order_no) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_status(TYPEOF(h.action_status) L, TYPEOF(h.action_status) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_posting_status_dt(TYPEOF(h.action_posting_status_dt) L, TYPEOF(h.action_posting_status_dt) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_action_original_filename_or_url(TYPEOF(h.action_original_filename_or_url) L, TYPEOF(h.action_original_filename_or_url) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_name_addr_type(TYPEOF(h.additional_name_addr_type) L, TYPEOF(h.additional_name_addr_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_name(TYPEOF(h.additional_orig_name) L, TYPEOF(h.additional_orig_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_name_order(TYPEOF(h.additional_name_order) L, TYPEOF(h.additional_name_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_additional_1(TYPEOF(h.additional_orig_additional_1) L, TYPEOF(h.additional_orig_additional_1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_additional_2(TYPEOF(h.additional_orig_additional_2) L, TYPEOF(h.additional_orig_additional_2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_additional_3(TYPEOF(h.additional_orig_additional_3) L, TYPEOF(h.additional_orig_additional_3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_additional_4(TYPEOF(h.additional_orig_additional_4) L, TYPEOF(h.additional_orig_additional_4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_city(TYPEOF(h.additional_orig_city) L, TYPEOF(h.additional_orig_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_st(TYPEOF(h.additional_orig_st) L, TYPEOF(h.additional_orig_st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_orig_zip(TYPEOF(h.additional_orig_zip) L, TYPEOF(h.additional_orig_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_phone(TYPEOF(h.additional_phone) L, TYPEOF(h.additional_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_occupation(TYPEOF(h.misc_occupation) L, TYPEOF(h.misc_occupation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_practice_hours(TYPEOF(h.misc_practice_hours) L, TYPEOF(h.misc_practice_hours) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_practice_type(TYPEOF(h.misc_practice_type) L, TYPEOF(h.misc_practice_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_email(TYPEOF(h.misc_email) L, TYPEOF(h.misc_email) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_fax(TYPEOF(h.misc_fax) L, TYPEOF(h.misc_fax) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_web_site(TYPEOF(h.misc_web_site) L, TYPEOF(h.misc_web_site) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_other_id(TYPEOF(h.misc_other_id) L, TYPEOF(h.misc_other_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_misc_other_id_type(TYPEOF(h.misc_other_id_type) L, TYPEOF(h.misc_other_id_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_continuing_education(TYPEOF(h.education_continuing_education) L, TYPEOF(h.education_continuing_education) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_1_school_attended(TYPEOF(h.education_1_school_attended) L, TYPEOF(h.education_1_school_attended) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_1_dates_attended(TYPEOF(h.education_1_dates_attended) L, TYPEOF(h.education_1_dates_attended) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_1_curriculum(TYPEOF(h.education_1_curriculum) L, TYPEOF(h.education_1_curriculum) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_1_degree(TYPEOF(h.education_1_degree) L, TYPEOF(h.education_1_degree) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_2_school_attended(TYPEOF(h.education_2_school_attended) L, TYPEOF(h.education_2_school_attended) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_2_dates_attended(TYPEOF(h.education_2_dates_attended) L, TYPEOF(h.education_2_dates_attended) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_2_curriculum(TYPEOF(h.education_2_curriculum) L, TYPEOF(h.education_2_curriculum) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_2_degree(TYPEOF(h.education_2_degree) L, TYPEOF(h.education_2_degree) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_3_school_attended(TYPEOF(h.education_3_school_attended) L, TYPEOF(h.education_3_school_attended) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_3_dates_attended(TYPEOF(h.education_3_dates_attended) L, TYPEOF(h.education_3_dates_attended) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_3_curriculum(TYPEOF(h.education_3_curriculum) L, TYPEOF(h.education_3_curriculum) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_education_3_degree(TYPEOF(h.education_3_degree) L, TYPEOF(h.education_3_degree) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_additional_licensing_specifics(TYPEOF(h.additional_licensing_specifics) L, TYPEOF(h.additional_licensing_specifics) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_personal_pob_cd(TYPEOF(h.personal_pob_cd) L, TYPEOF(h.personal_pob_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_personal_pob_desc(TYPEOF(h.personal_pob_desc) L, TYPEOF(h.personal_pob_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_personal_race_cd(TYPEOF(h.personal_race_cd) L, TYPEOF(h.personal_race_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_personal_race_desc(TYPEOF(h.personal_race_desc) L, TYPEOF(h.personal_race_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_status_status_cds(TYPEOF(h.status_status_cds) L, TYPEOF(h.status_status_cds) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_status_effective_dt(TYPEOF(h.status_effective_dt) L, TYPEOF(h.status_effective_dt) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_status_renewal_desc(TYPEOF(h.status_renewal_desc) L, TYPEOF(h.status_renewal_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_status_other_agency(TYPEOF(h.status_other_agency) L, TYPEOF(h.status_other_agency) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
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
EXPORT match_suffix(TYPEOF(h.suffix) L, TYPEOF(h.suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
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
EXPORT match_dpbc(TYPEOF(h.dpbc) L, TYPEOF(h.dpbc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_chk_digit(TYPEOF(h.chk_digit) L, TYPEOF(h.chk_digit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_record_type(TYPEOF(h.record_type) L, TYPEOF(h.record_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_ace_fips_st(TYPEOF(h.ace_fips_st) L, TYPEOF(h.ace_fips_st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
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
EXPORT match_pl_score_in(TYPEOF(h.pl_score_in) L, TYPEOF(h.pl_score_in) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prep_addr_line1(TYPEOF(h.prep_addr_line1) L, TYPEOF(h.prep_addr_line1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prep_addr_last_line(TYPEOF(h.prep_addr_last_line) L, TYPEOF(h.prep_addr_last_line) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rawaid(TYPEOF(h.rawaid) L, TYPEOF(h.rawaid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_aceaid(TYPEOF(h.aceaid) L, TYPEOF(h.aceaid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_county_name(TYPEOF(h.county_name) L, TYPEOF(h.county_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_did(TYPEOF(h.did) L, TYPEOF(h.did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_score(TYPEOF(h.score) L, TYPEOF(h.score) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_best_ssn(TYPEOF(h.best_ssn) L, TYPEOF(h.best_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_bdid(TYPEOF(h.bdid) L, TYPEOF(h.bdid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_source_rec_id(TYPEOF(h.source_rec_id) L, TYPEOF(h.source_rec_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dotid(TYPEOF(h.dotid) L, TYPEOF(h.dotid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dotscore(TYPEOF(h.dotscore) L, TYPEOF(h.dotscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dotweight(TYPEOF(h.dotweight) L, TYPEOF(h.dotweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_empid(TYPEOF(h.empid) L, TYPEOF(h.empid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_empscore(TYPEOF(h.empscore) L, TYPEOF(h.empscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_empweight(TYPEOF(h.empweight) L, TYPEOF(h.empweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_powid(TYPEOF(h.powid) L, TYPEOF(h.powid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_powscore(TYPEOF(h.powscore) L, TYPEOF(h.powscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_powweight(TYPEOF(h.powweight) L, TYPEOF(h.powweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_proxid(TYPEOF(h.proxid) L, TYPEOF(h.proxid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_proxscore(TYPEOF(h.proxscore) L, TYPEOF(h.proxscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_proxweight(TYPEOF(h.proxweight) L, TYPEOF(h.proxweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_seleid(TYPEOF(h.seleid) L, TYPEOF(h.seleid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_selescore(TYPEOF(h.selescore) L, TYPEOF(h.selescore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_seleweight(TYPEOF(h.seleweight) L, TYPEOF(h.seleweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orgid(TYPEOF(h.orgid) L, TYPEOF(h.orgid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orgscore(TYPEOF(h.orgscore) L, TYPEOF(h.orgscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_orgweight(TYPEOF(h.orgweight) L, TYPEOF(h.orgweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_ultid(TYPEOF(h.ultid) L, TYPEOF(h.ultid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_ultscore(TYPEOF(h.ultscore) L, TYPEOF(h.ultscore) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_ultweight(TYPEOF(h.ultweight) L, TYPEOF(h.ultweight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lnpid(TYPEOF(h.lnpid) L, TYPEOF(h.lnpid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
END;

